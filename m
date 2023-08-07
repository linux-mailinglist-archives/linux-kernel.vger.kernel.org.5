Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC255773056
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 22:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjHGUdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 16:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGUdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 16:33:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B0910D8
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691440379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ef2qFHsqfq9w04kkUFwpr5VGp6ZXP1q9+YtKoiAHED8=;
        b=anh3X1KXDChmrXDskB5b+O4TKCj/wt3Q0l6wC4kUsM+6I/q/q4QH/5KpIHcukRZs7c4rXB
        zRbyl3P8SNp/Q+XJuhVXph6B0f4ED0bR/rUlP5qPHUpab9pmLPU40Y2a7l4dDUJ17Y093i
        7Xv5peG7y6qh0jpoibP+jh13xRUd3+E=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-SVUP9cvKPJO68kX_eC-L6Q-1; Mon, 07 Aug 2023 16:32:56 -0400
X-MC-Unique: SVUP9cvKPJO68kX_eC-L6Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-40feb0c08c0so37243741cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 13:32:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440376; x=1692045176;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef2qFHsqfq9w04kkUFwpr5VGp6ZXP1q9+YtKoiAHED8=;
        b=iAhx4+ocPXcbI82fRnsLhYa9ODrJkWsVCAqa7Dp2FlqWmV1lEgxE9714llb6tRSwgv
         JCkRJbS/PlfVJGXUgYIy24drvlqIJlUMkxLtJ/nkXuTh1djO9L6KJC2cccftEnGKrz04
         beTFaqh3s1dD9jtG2olSKxqM8qsDDsr6lmT6NuCpTbo0L8a1qWazngynIovLGZCkPt7r
         7DKMnXdI97cttEop1FycomsrcFqylmpK7Utsd4mwqH6gSxFezaBcioeBSFz5+BdxK56C
         Yaqr3c2OnTiVxQGrsmX8DP2f3UkbrFABaVY7/kX7BgQ8ZT312xPpLaS1nD1QeikpM+ys
         eTQQ==
X-Gm-Message-State: AOJu0YzYWfRZTUxvvVmdayqJFCf4XVxGWvvszKQ6CMWIL7SFt3XTK7Wd
        9pEhwyz3jv6eUrF3GgMA1s01cGAm9W0hycWcXHLl0J4N0fToJrMwPFUKzUyIr7dGNWNTGDqVqr9
        ax9Fs+ADWX0lI4pYvjgEyrEWg
X-Received: by 2002:a05:622a:1301:b0:410:682:972c with SMTP id v1-20020a05622a130100b004100682972cmr6058591qtk.62.1691440375833;
        Mon, 07 Aug 2023 13:32:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPqPsJ9+KhVuwjTgj9i7DT2wVC/+erfl77JxIrDG0C82kOepjLE2//seLYHR3tPeHf0bg4Kg==
X-Received: by 2002:a05:622a:1301:b0:410:682:972c with SMTP id v1-20020a05622a130100b004100682972cmr6058576qtk.62.1691440375600;
        Mon, 07 Aug 2023 13:32:55 -0700 (PDT)
Received: from ?IPv6:2600:4040:5c7d:5f00:6966:42dc:c4a4:dad3? ([2600:4040:5c7d:5f00:6966:42dc:c4a4:dad3])
        by smtp.gmail.com with ESMTPSA id r17-20020ac87951000000b00401217aa51dsm2894075qtt.76.2023.08.07.13.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 13:32:54 -0700 (PDT)
Message-ID: <b350fd1e60cc0fa24a81be512e35f9b6a2358f94.camel@redhat.com>
Subject: Re: [PATCH] drm/nouveau/disp: Revert a NULL check inside
 nouveau_connector_get_modes
From:   Lyude Paul <lyude@redhat.com>
To:     Karol Herbst <kherbst@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org, Olaf Skibbe <news@kravcenko.com>
Date:   Mon, 07 Aug 2023 16:32:53 -0400
In-Reply-To: <20230805101813.2603989-1-kherbst@redhat.com>
References: <20230805101813.2603989-1-kherbst@redhat.com>
Organization: Red Hat Inc.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ugh, thanks for catching this!

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sat, 2023-08-05 at 12:18 +0200, Karol Herbst wrote:
> The original commit adding that check tried to protect the kenrel against
> a potential invalid NULL pointer access.
>=20
> However we call nouveau_connector_detect_depth once without a native_mode
> set on purpose for non LVDS connectors and this broke DP support in a few
> cases.
>=20
> Cc: Olaf Skibbe <news@kravcenko.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/238
> Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/245
> Fixes: 20a2ce87fbaf8 ("drm/nouveau/dp: check for NULL nv_connector->nativ=
e_mode")
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nouveau_connector.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/dr=
m/nouveau/nouveau_connector.c
> index f75c6f09dd2af..a2e0033e8a260 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_connector.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
> @@ -967,7 +967,7 @@ nouveau_connector_get_modes(struct drm_connector *con=
nector)
>  	/* Determine display colour depth for everything except LVDS now,
>  	 * DP requires this before mode_valid() is called.
>  	 */
> -	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS && nv_connec=
tor->native_mode)
> +	if (connector->connector_type !=3D DRM_MODE_CONNECTOR_LVDS)
>  		nouveau_connector_detect_depth(connector);
> =20
>  	/* Find the native mode if this is a digital panel, if we didn't

--=20
Cheers,
 Lyude Paul (she/her)
 Software Engineer at Red Hat

