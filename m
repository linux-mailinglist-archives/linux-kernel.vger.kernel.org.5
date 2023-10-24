Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5FB7D5055
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 14:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234428AbjJXMxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 08:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234343AbjJXMxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 08:53:38 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A05CC;
        Tue, 24 Oct 2023 05:53:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2e22f1937so2640499b6e.1;
        Tue, 24 Oct 2023 05:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698152015; x=1698756815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EM4Fv3c8UGojmnjnYetmNItfOCNpkkeFenXKakvLeSo=;
        b=Y+TrhITclIRcUFmPoKsJ17xphlS7bSUNMUwsF117LM+ijrB/S4+WZizp5Cj8tpNC/D
         Vgdd/vGqRJH+ZLu+MST9XCvpbNWekgcyNaYJ1Z57ZnIvTdQCISk83XiLyGN0BEis25sU
         EeTPxSSzjlycYiaWMDzkYBEjwvsDLLRKrSLSXBWDtxrXLinnPlGDF6e8F1U+ufsYxafH
         P9qJLLAwuZBIkw184Vb/9nhCoHoj5mRq14xUxReLyOlKiom0LzMSQVAlPvNp2yEnsbU5
         YAMQ6pWjBueH1giluQhkT0quMcYX7Z4EQxwDlQh3KKhLrQVM7dO7SzcFtQxJzxxgVB/e
         Kv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698152015; x=1698756815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EM4Fv3c8UGojmnjnYetmNItfOCNpkkeFenXKakvLeSo=;
        b=KJn/L2KtMjibf2Xw4AMfmuqeV/ygblm8GH7ybDt6J23sH+U5WrLdWtAp2gXXkgSZ5P
         /sPPPE6nwgjpkV/38hQrRXrCFGOEQmmUX/ijuXzXMgdlHbp1lMhlIRiJIwIuC9aU+MEf
         nsmd7gVsjEAuOlTtVZkL4Srur69nhxc5/a15fS1/TdU6e1LvnjeJstFyuBHExAy2/KjF
         lnlr4AS6+S0dJMrBbcmgYFNYBPu0QVcepZ6REUieL2XRiVFMeFS7zRlydkzM3OWE4/fy
         G+Yk2o1ytnAIwSdJJ8JBwkrzQ7i30TgW1OkheGzDHnZCwp2Yb/dbKZvjYjttyGFjGAA1
         wpPA==
X-Gm-Message-State: AOJu0Yw2B2//R/HY0qGUUjb/HYBS/fDacwgCtWI9NItpS7tEGlYAF1b1
        nkLL0YokpRCeCxL2sENc9xXijimcoEZbEpYm9T/OR0MOtDqszA==
X-Google-Smtp-Source: AGHT+IFROi++TBTG5fQCokZI6lvT1I1p/ESAbrAV4OkrXB6oEmWv7QskQP+v15eyN2/jVo7Hgah70FotEqZbJneSTgw=
X-Received: by 2002:a05:6808:1a8e:b0:3a7:57a6:e077 with SMTP id
 bm14-20020a0568081a8e00b003a757a6e077mr12319707oib.37.1698152015597; Tue, 24
 Oct 2023 05:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231024120845.942815-1-zohar@linux.ibm.com>
In-Reply-To: <20231024120845.942815-1-zohar@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 24 Oct 2023 15:53:24 +0300
Message-ID: <CAOQ4uxiWCm5o+iezCOKVcunZaec=3AxY+z6BWuX7thaZ3+6p6Q@mail.gmail.com>
Subject: Re: [PATCH] ima: detect changes to the backing overlay file
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raul Rangel <rrangel@chromium.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
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

On Tue, Oct 24, 2023 at 3:09=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
> IMA") forced signature re-evaulation on every file access.
>
> IMA does not detect changes made to the backing overlay file.  Instead
> of always re-evaluating the file's integrity, detect a change to the
> backing overlay file, by comparing the i_version, as stored in the iint,
> with the backing file's i_version.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  fs/overlayfs/super.c              |  2 +-
>  security/integrity/ima/ima_api.c  |  1 +
>  security/integrity/ima/ima_main.c | 21 ++++++++++++++++++++-
>  3 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index def266b5e2a3..4d9137ba2293 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1482,7 +1482,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
s_context *fc)
>                 ovl_trusted_xattr_handlers;
>         sb->s_fs_info =3D ofs;
>         sb->s_flags |=3D SB_POSIXACL;
> -       sb->s_iflags |=3D SB_I_SKIP_SYNC | SB_I_IMA_UNVERIFIABLE_SIGNATUR=
E;
> +       sb->s_iflags |=3D SB_I_SKIP_SYNC;
>
>         err =3D -ENOMEM;
>         root_dentry =3D ovl_get_root(sb, ctx->upper.dentry, oe);
> diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/im=
a_api.c
> index 452e80b541e5..d1c718ef9295 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -272,6 +272,7 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>                                    AT_STATX_SYNC_AS_STAT);
>         if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
>                 i_version =3D stat.change_cookie;
> +
>         hash.hdr.algo =3D algo;
>         hash.hdr.length =3D hash_digest_size[algo];
>
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 365db0e43d7c..7c8aac81d16e 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -25,6 +25,7 @@
>  #include <linux/xattr.h>
>  #include <linux/ima.h>
>  #include <linux/fs.h>
> +#include <linux/iversion.h>
>
>  #include "ima.h"
>
> @@ -207,7 +208,7 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>                                u32 secid, char *buf, loff_t size, int mas=
k,
>                                enum ima_hooks func)
>  {
> -       struct inode *inode =3D file_inode(file);
> +       struct inode *backing_inode, *inode =3D file_inode(file);
>         struct integrity_iint_cache *iint =3D NULL;
>         struct ima_template_desc *template_desc =3D NULL;
>         char *pathbuf =3D NULL;
> @@ -284,6 +285,24 @@ static int process_measurement(struct file *file, co=
nst struct cred *cred,
>                 iint->measured_pcrs =3D 0;
>         }
>
> +       /*
> +        * IMA does not detect changes made to the backing overlay file.
> +        * If the backing file's i_version is greater than the overlay
> +        * file's i_version or the backing file doesn't support iversion,
> +        * clear the cache to force the file's integrity to be re-evaluat=
ed.
> +        */
> +       if (inode->i_sb->s_magic =3D=3D 0x794c7630 &&

Please don't use magic to detect overlayfs.
Overlayfs is not the only fs that can have a backing file
and this test is not needed.

> +           (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> +               backing_inode =3D d_real_inode(file_dentry(file));
> +               if (backing_inode !=3D inode) {

This test is sufficient, because for regular files of filesystems
without ->d_real(),
backing_inode will always be =3D=3D inode.

> +                       if (!IS_I_VERSION(backing_inode) ||
> +                           inode_peek_iversion(backing_inode) > iint->ve=
rsion) {


IIUC, this checking > iint->version is not enough.
The reason is that you could have recorded iint->version from i_version
of a lower file, after open for write, lower file gets copied up to upper f=
ile,
which is a completely different backing_inode, so there is no guarantee
that the copy up will not result in a smaller or even equal i_version.

For a complete solution, you will need to store the backing_inode
pointer or backing dev/ino in iint to make sure that backing_inode did not
change.

Thanks,
Amir.
