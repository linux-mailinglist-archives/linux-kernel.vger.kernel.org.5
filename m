Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4453A78F355
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345903AbjHaT2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238027AbjHaT2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:28:46 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F811BF;
        Thu, 31 Aug 2023 12:28:43 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-d7b9de8139fso916669276.1;
        Thu, 31 Aug 2023 12:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693510123; x=1694114923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8qDQJExdf2/MyftTvEkhS4s/WAMk52xVgwr8SGMiDE=;
        b=fFk4gy/qXBXmOhI8uy5rjhSNuJRBwo7uBtXPnhRnfmIV2CX70b5IWcjHszSmVJ/Dxw
         VydufYKTAP2PWvfvDsUglKuu6WojaTVsxDJs+JCMsVHBVVJzYeVIG6ETuTb2wbX3/DLH
         fysmlvBv1hx1cy+8MboYTL1CItpa8l1K2EMRVqrDn1+2qSit6Gor1LV9uGMQW5tt4a2V
         QvRBTL5FJY6wqDakhvDynjgbX7L9GWaXqqk3s9jzYiDh3Z4uR3yz7put5f8JrFhioF1T
         ckz350pBObCo1Y9D/CFaxhzIzMgzB4Bb+A0gt+UcAbic9JsSX/8PweAlK1YPrXcR4EGV
         HMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693510123; x=1694114923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8qDQJExdf2/MyftTvEkhS4s/WAMk52xVgwr8SGMiDE=;
        b=QPaaVLlAoja4hF2UJQzzXbd9x3HHzRHdj3WcBrYtmhC+7uOgZCjsfIalYZeyB0Ipzw
         Fdtf2wLsTEkf5ndtlMVum5K8bidf9LVEU3MkxSii3UuogQLU94j15qFuTGrbx2YvWnfz
         1OU/86/8qqf1Xe+rKn20paVinRogbBB6yY+voAmIqKqnEXP2/vYB07HKpmtIwpdvFv3h
         0VdVPMt/tTR2UeODVOXZ2s02Od2bsES8RIDHvsqPssO0ySS4J0ih0mRq/ll5yUDIiVfB
         6P7pJ4CBngXK0lGhHjQ2TOjXdmuQVJ7xnu6n6QYgkeYBeIe97UTtAdhLkh6h63emPR6n
         6X+Q==
X-Gm-Message-State: AOJu0YxR5Z940POUJ66+6QM4eKhocB1AeEqY1GKgxnK/0rvSB8wixYOq
        HVjurZ1bLb8UqKCYjOIfy6HJ9NwXeyETiV8DNgA=
X-Google-Smtp-Source: AGHT+IHUk+T46JxLGqYp6rQq8hKNL4/Cn40334y926ibfAf3nZ4zAVGPqIKHXAMfPwddXw3jVUWSXX+nNgI0+RVu+F4=
X-Received: by 2002:a25:6642:0:b0:d78:2383:4427 with SMTP id
 z2-20020a256642000000b00d7823834427mr671226ybm.9.1693510123188; Thu, 31 Aug
 2023 12:28:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230830215426.4181755-1-azeemshaikh38@gmail.com>
 <20230830215426.4181755-3-azeemshaikh38@gmail.com> <202308301601.8A8EE6B653@keescook>
In-Reply-To: <202308301601.8A8EE6B653@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Thu, 31 Aug 2023 15:28:32 -0400
Message-ID: <CADmuW3Wc7fzoCcif7WmY4X4FWErFc4poMOqzMXu=3mf0ycju1Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ocfs2: Replace strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        linux-hardening@vger.kernel.org, ocfs2-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 7:06=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Wed, Aug 30, 2023 at 09:54:26PM +0000, Azeem Shaikh wrote:
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> >
> > Direct replacement is assumed to be safe here since
> > it's ok for `kernel_param_ops.get()` to return -errno [3].
> > This changes the behavior such that instead of silently ignoring the
> > case when sizeof(@buffer) < DLMFS_CAPABILITIES, we now return error.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strl=
cpy
> > [2] https://github.com/KSPP/linux/issues/89
> > [3] https://elixir.bootlin.com/linux/v6.5/source/include/linux/modulepa=
ram.h#L52
> >
> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> >  fs/ocfs2/dlmfs/dlmfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
> > index 33e529de93b2..b001eccdd2f3 100644
> > --- a/fs/ocfs2/dlmfs/dlmfs.c
> > +++ b/fs/ocfs2/dlmfs/dlmfs.c
> > @@ -80,7 +80,7 @@ static int param_set_dlmfs_capabilities(const char *v=
al,
> >  static int param_get_dlmfs_capabilities(char *buffer,
> >                                       const struct kernel_param *kp)
> >  {
> > -     return strlcpy(buffer, DLMFS_CAPABILITIES,
> > +     return strscpy(buffer, DLMFS_CAPABILITIES,
> >                      strlen(DLMFS_CAPABILITIES) + 1);
> >  }
>
> This is another case of "accidentally correct".
>
>
> param->get() is hooked here, in the sysfs "show" callback:
>
> static ssize_t param_attr_show(struct module_attribute *mattr,
>                                struct module_kobject *mk, char *buf)
> {
>         int count;
>         struct param_attribute *attribute =3D to_param_attr(mattr);
>
>         if (!attribute->param->ops->get)
>                 return -EPERM;
>
>         kernel_param_lock(mk->mod);
>         count =3D attribute->param->ops->get(buf, attribute->param);
>         kernel_param_unlock(mk->mod);
>         return count;
> }
>
> Meaning ultimately this will show up here, if I'm reading names right:
> /sys/module/ocfs/parameters/dlmfs_capabilities
>
> Anyway, the "count" being returned would be quite bad if
> DLMFS_CAPABILITIES were dynamic and larger than PAGE_SIZE (the size of
> the sysfs buffer).
>
> For this case, I would say replace strlcpy with sysfs_emit:
>
>         return sysfs_emit(buffer, DLMFS_CAPABILITIES);
>

Thanks, sending out a v2 for this. Out of curiosity - why sysfs_emit?
Is it because DLMFS_CAPABILITIES is a hard-coded string?
