Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2EC7B0601
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 16:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbjI0OCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 10:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbjI0OCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 10:02:39 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C54610A;
        Wed, 27 Sep 2023 07:02:38 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6c4c594c0eeso5491405a34.0;
        Wed, 27 Sep 2023 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695823357; x=1696428157; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBgo/SWIO02Pm/xzDvMlyzJPp7I0czV8f3hR93KFgsk=;
        b=R2ULERYdMlfhBMmUAbH1iL3UJpsD6DYE3a157LM7ogB3chQ3KEJXolTPGf/PUdx3Yw
         oY38XQmN+FoaUjkr9PAdOXxr3aKzjRXW1YfIWaBkSNrT0kk/4QFzAUYWNjSBEecjWxzR
         f5ZIRVPbHab22Z4+1Krc0sNM6mupDKkp+dMUmG44zEX7HnpqQOup5qT3pEzOozkhiHFt
         XDFtnWOc0LrkdH3QPmbA7FLsX219gNsYooe+y6tXI6JPpIZ5usPIc45/kX/rSBGPwujX
         MFBGJjOmN0oSsJQ2F9GL6HNNmTjjtBTLFTW46w8AU1uRnquc4CxOAiJD9vtl8C/qSIqI
         I7GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695823357; x=1696428157;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZBgo/SWIO02Pm/xzDvMlyzJPp7I0czV8f3hR93KFgsk=;
        b=oIQLTmKlp7uGnrUsikcGCiGOscIc06pXOcTBof0WR0DwvEJKRhsNJqv1oh1qKcrI6g
         k65H3xxEhW79APbg9c8ZkfpmsWZKg2XgKYt/tRAnm0W+dvsyvZRAL53Cl5DA8rctXCuf
         R7vV9KtaTauaFLC9Ep0/ejFuzymeoLnq2gDQlZYewFD32H1q9WIBb1qhVyZ5AR86bw1v
         wOkMUjCgTgKbj4QykoaXbkqUxaz7KQviB81CMxhTQ9KOCSKo6+ALMdAVTz52sgUG0o6N
         NQaDkdRFBqrJyzbb6SHSktiDQG3iQHmqwH65HjNje15s3zjPqkYMAsLNEcLB284pC40e
         Ol+Q==
X-Gm-Message-State: AOJu0YyhzzuSU8qH4T6Vpa2FeKB/DZ9w/wZ1ul6LFBWSjLavAIMZ1zhl
        4pq6eL0S2hkSTv8J+XLvDZrlrbU8V9z33oXIhQo=
X-Google-Smtp-Source: AGHT+IGX+Eyi3U6z/rblwtsWWP/9TBKMDyZgdX5YoXYjjU8FFILz4zJPI4wp/Tj307ujnIycKSLX6ReyZlLQaUb169I=
X-Received: by 2002:a05:6358:6f08:b0:142:d097:3725 with SMTP id
 r8-20020a0563586f0800b00142d0973725mr1931059rwn.9.1695823357416; Wed, 27 Sep
 2023 07:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230925045059.92883-1-suhui@nfschina.com>
In-Reply-To: <20230925045059.92883-1-suhui@nfschina.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 27 Sep 2023 17:02:26 +0300
Message-ID: <CAOQ4uxhv=Theeq0tEiDXEjUcKLNfaZnsVjnweX84mzWYSmFiZQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: avoid possible NULL dereference
To:     Su Hui <suhui@nfschina.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Dan Carpenter <dan.carpenter@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 7:52=E2=80=AFAM Su Hui <suhui@nfschina.com> wrote:
>
> smatch warn:
> fs/overlayfs/copy_up.c:450 ovl_set_origin() warn:
> variable dereferenced before check 'fh' (see line 449)
>
> If 'fh' is NULL, passing NULL instead of 'fh->buf'.
>
> Signed-off-by: Su Hui <suhui@nfschina.com>
> ---
>  fs/overlayfs/copy_up.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index d1761ec5866a..086f9176b4d4 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -446,7 +446,7 @@ int ovl_set_origin(struct ovl_fs *ofs, struct dentry =
*lower,
>         /*
>          * Do not fail when upper doesn't support xattrs.
>          */
> -       err =3D ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh->buf,
> +       err =3D ovl_check_setxattr(ofs, upper, OVL_XATTR_ORIGIN, fh ? fh-=
>buf : NULL,
>                                  fh ? fh->fb.len : 0, 0);
>         kfree(fh);
>
> --
> 2.30.2

After discussing this with Dan Carpenter, this is not a kernel bug,
it is a smatch bug.

The value being passed to setxattr is (void *)OVL_FH_FID_OFFSET,
which is just as arbitrary as NULL when size is 0.

Thanks,
Amir.
