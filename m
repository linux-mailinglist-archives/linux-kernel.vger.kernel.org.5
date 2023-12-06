Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5073D806A5D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346717AbjLFJJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjLFJJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:09:32 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F97D71
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 01:09:37 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-db539f21712so594677276.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 01:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701853777; x=1702458577; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wP++sDZ0D6RnqxEDsIfOfMZaHshu8C2nXxTEhtKdeFg=;
        b=XGaGB5S0ho5Kv2fj6FKTKgltohzZKE5geOFxJbJyuOp53bjxzUXqHJJJYUSz9rT9ef
         iDVeWbUY+VzG1H9NKEY5ikT+wVqqWvooxRElK2rdfniJsceqN8MgATPDFE25rQzCudlY
         getlh8t+nNOQG6rAfu+xMWkqN+KDBF0rVT60v25JXwDtCNTfnIKJ1vtNuEauPcMT9H16
         iN6zuCQoGZ0gQD42UDOKZyMhr3/nLQ/mZGKYOPWnzW//YSDidSK44Eq8cQZ/8rtqH3mL
         IsZwePz4woPgYUGOKxWfdmeS9bGKDcadfOKBo6jvhr70C4NtNAaxRu/zT5QTQNkK8FuK
         RGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853777; x=1702458577;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wP++sDZ0D6RnqxEDsIfOfMZaHshu8C2nXxTEhtKdeFg=;
        b=qNstQH40Bh1/N0DX7kEPDeCwypemmjlIjxAVqhRe8o2uniVGa7cA/TmYB3K8DcyK6G
         Lr2yb7bZLhUjE1APJoQ+QJzON/cY3MoDWAT2S2IuSO+zUpYJu25Wwx5Xnt+b10Wn60Ac
         gfsBRB23PX8ytFN2h0EjkNOskTVfIxUWlrOk+AQCYMgR7Q00STeo6dGSts7MTGMhKSLc
         AowLd6ZNAXQ5c1BjFPWJr1Uvd/kqg4kSbOk5CNAtH+WcoBRDqb/ODePtnQgPuyKz/ml9
         yguVr984uEWZ6cyGJiIeSkKwbPwmBY6EWns6whSBqPis0waKvBVj35rzw6cE17B43XMg
         Ubhg==
X-Gm-Message-State: AOJu0YxeeFfJ6gNyc/IvZo/8py7M/NXg94/cGJlQBlo79j4SmrZgESRs
        qiQzcshlydNjCZhiuU3yAK1pQ1qUwzzzj6zy2GSOdQ==
X-Google-Smtp-Source: AGHT+IHg0pHACl+xt9RzmXvwGIPui6Yb8M/F4NDq2ZCAoTAskYtXkHT/owjn5oxY8N77ibLrBkj9aG20YDg0hFxnl2M=
X-Received: by 2002:a05:6902:4e1:b0:db9:85c7:b052 with SMTP id
 w1-20020a05690204e100b00db985c7b052mr1761994ybs.9.1701853776943; Wed, 06 Dec
 2023 01:09:36 -0800 (PST)
MIME-Version: 1.0
References: <20231206072701.13276-1-dinghao.liu@zju.edu.cn> <77925c2e-8cb2-473b-9dd0-3ce60a909066@suse.de>
In-Reply-To: <77925c2e-8cb2-473b-9dd0-3ce60a909066@suse.de>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Wed, 6 Dec 2023 11:09:25 +0200
Message-ID: <CAA8EJprUDgraGgiGKsh0PSVd6Zxe9L2Q+HTPrALHWFVP3hiq1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/plane: fix error handling in __drm_universal_plane_init
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2023 at 10:22, Thomas Zimmermann <tzimmermann@suse.de> wrote:
>
> Hi
>
> Am 06.12.23 um 08:27 schrieb Dinghao Liu:
> > __drm_universal_plane_init() frees plane->format_types and
> > plane->modifiers on failure. However, sometimes its callers
> > will free these two pointers again, which may lead to a
> > double-free. One possible call chain is:
> >
> > mdp5_plane_init
> >    |-> drm_universal_plane_init
> >    |     |-> __drm_universal_plane_init (first free)
> >    |
> >    |-> mdp5_plane_destroy
> >          |-> drm_plane_cleanup (second free)
> >
> > Fix this by setting the two pointers to NULL after kfree.
> >
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
>
> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
>
> to get the immediate bug fixed.
>
> However, I don't think it's the correct way of doing things in general.
> Planes should probably not attempt to even make a copy, but use the
> supplied pointers. Lifetime of the arrays is the same as of the plane.
> That's for a different patch set, of course.  (I did not review the DRM
> code whether the internal copy is required.)

But there is no internal copy. The issue is in the mdp5 code calling
drm_plane_cleanup (indirectly) even though the plane init has failed.

>
> For now, maybe drm_plane_cleanup() could warn if format_types equals
> NULL. [1] It indicates that the plane has not been initialized correctly
> and the driver's memory lifetime handling is somehow broken.
>
> Best regards
> Thomas
>
> [1]
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/drm_plane.c#L542
>
> > ---
> >   drivers/gpu/drm/drm_plane.c | 3 +++
> >   1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_plane.c b/drivers/gpu/drm/drm_plane.c
> > index 24e7998d1731..1331b8224920 100644
> > --- a/drivers/gpu/drm/drm_plane.c
> > +++ b/drivers/gpu/drm/drm_plane.c
> > @@ -304,6 +304,7 @@ static int __drm_universal_plane_init(struct drm_device *dev,
> >       if (format_modifier_count && !plane->modifiers) {
> >               DRM_DEBUG_KMS("out of memory when allocating plane\n");
> >               kfree(plane->format_types);
> > +             plane->format_types = NULL;
> >               drm_mode_object_unregister(dev, &plane->base);
> >               return -ENOMEM;
> >       }
> > @@ -317,6 +318,8 @@ static int __drm_universal_plane_init(struct drm_device *dev,
> >       if (!plane->name) {
> >               kfree(plane->format_types);
> >               kfree(plane->modifiers);
> > +             plane->format_types = NULL;
> > +             plane->modifiers = NULL;
> >               drm_mode_object_unregister(dev, &plane->base);
> >               return -ENOMEM;
> >       }
>
> --
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Frankenstrasse 146, 90461 Nuernberg, Germany
> GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
> HRB 36809 (AG Nuernberg)



-- 
With best wishes
Dmitry
