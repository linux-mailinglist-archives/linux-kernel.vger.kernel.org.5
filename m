Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A248E7D6CD3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344513AbjJYNNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234959AbjJYNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:13:11 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D01111;
        Wed, 25 Oct 2023 06:13:09 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7789cb322deso386381985a.3;
        Wed, 25 Oct 2023 06:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698239588; x=1698844388; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFeJTuWj+8fliI7ZKMp8fCArGM+QdzaiPtmM5GUkmWs=;
        b=SNF7niw1Zq+KJnYAgueR96YtvqRZSCYk2H+2bHeVQF7JuPhataQFwbo+tYL8FLXBlP
         4G8iYfKFyPeAO3B3aywtd09Bw138siNMEDkYOuPHwFRD0VrLuRAhZ9G/kVqSlIV1ayjO
         tNdGeFxNU4oRaC159WT61yzmJvyNxOwcaHl/fJfNR1cIuoV1kASrMcqbRlI+7YFQImKv
         zsN+F+h0Jp1wHzs8+9aNEGfJgJ7bKDNOYyX+VA5Yrfnwye0SfLpJrus8GXuRpYD74DAQ
         Y+O3poJtQqPkIVs8A9M0PEBGnTLAEI2DUtqfcto67/xXmvW7VXmm8Av256IVa8Nzl1jn
         QAAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698239588; x=1698844388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFeJTuWj+8fliI7ZKMp8fCArGM+QdzaiPtmM5GUkmWs=;
        b=Yy2Cdgme7xcpoUiLWNdvnntnhJmslGeA0f0smYc7OvAQP9cLoAK551MLS1yqXXJSso
         mDTG+kk70Ddbd0i9xj7PmGo4jLmyrD5vp4Z2QkdkbBhvPuGauoGh27eldUzbr9vJPm3c
         CZkm5lA8YsD2yUkmnWthphqYeHWzLffXRe7LAaNNtwl6uHo5nm8UiPKZy7X8Yu07CspL
         OaVuIRB5Y1aUUTtxHNGEc23C5nzWBZVZ0Fhc9rYqbyc+9OES95zhjmoz5bXUsGlk4H3q
         8I8d4zlVp3kSaTC3oHxuln0E6hOrxWui+lYOBsmngPSOSNFPbJMxypwCxuuDqpbeAfu7
         P10g==
X-Gm-Message-State: AOJu0YwwJKZ2Zp2xpVeJ7pQr+dSCj/AivJer0sC9nPAml7yZ3w0rtIKR
        d3uQ6gFzukgWz9Nycx1tr3tdrsGL6aTmDTsmIyw=
X-Google-Smtp-Source: AGHT+IHtBOrHCchdxTvkzOtqs00oPy95CN565EVEhi3PvnF3Mkw20XMvsMc54VKjw7pknPZg6eTnJTtXs/qFgyFyNaw=
X-Received: by 2002:a05:6214:1c4a:b0:66d:ba99:ba1e with SMTP id
 if10-20020a0562141c4a00b0066dba99ba1emr9984191qvb.52.1698239588401; Wed, 25
 Oct 2023 06:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20231025112932.84336-1-zohar@linux.ibm.com>
In-Reply-To: <20231025112932.84336-1-zohar@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 25 Oct 2023 16:12:57 +0300
Message-ID: <CAOQ4uxhtasz_mapEiUBb5ecoVaKy+H9=rNeLRTTAN8Tyf4jyVw@mail.gmail.com>
Subject: Re: [PATCH v2] ima: detect changes to the backing overlay file
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Raul Rangel <rrangel@chromium.org>,
        Eric Snowberg <eric.snowberg@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 2:29=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
> IMA") forced signature re-evaulation on every file access.
>
> Instead of always re-evaluating the file's integrity, detect a change
> to the backing file, by comparing the cached file metadata with the
> backing file's metadata.  Verifying just the i_version has not changed
> is insufficient.  In addition save and compare the i_ino and i_rdev
> as well.
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Changelog:
> - Changes made based on Amir's review: removal of unnecessary overlay
> magic test, verify i_version, i_ino and i_rdev haven't changed.
>
>  fs/overlayfs/super.c              |  2 +-
>  security/integrity/ima/ima_api.c  |  4 ++++
>  security/integrity/ima/ima_main.c | 16 +++++++++++++++-
>  security/integrity/integrity.h    |  2 ++
>  4 files changed, 22 insertions(+), 2 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 3fa2416264a4..c71d185980c0 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1489,7 +1489,7 @@ int ovl_fill_super(struct super_block *sb, struct f=
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
> index 452e80b541e5..f191bdcceef8 100644
> --- a/security/integrity/ima/ima_api.c
> +++ b/security/integrity/ima/ima_api.c
> @@ -243,6 +243,7 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>  {
>         const char *audit_cause =3D "failed";
>         struct inode *inode =3D file_inode(file);
> +       struct inode *real_inode =3D d_real_inode(file_dentry(file));
>         const char *filename =3D file->f_path.dentry->d_name.name;
>         struct ima_max_digest_data hash;
>         struct kstat stat;
> @@ -272,6 +273,7 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>                                    AT_STATX_SYNC_AS_STAT);
>         if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
>                 i_version =3D stat.change_cookie;
> +
>         hash.hdr.algo =3D algo;
>         hash.hdr.length =3D hash_digest_size[algo];
>
> @@ -302,6 +304,8 @@ int ima_collect_measurement(struct integrity_iint_cac=
he *iint,
>         iint->ima_hash =3D tmpbuf;
>         memcpy(iint->ima_hash, &hash, length);
>         iint->version =3D i_version;

You don't have to store them if real_inode =3D=3D inode.

> +       iint->real_ino =3D real_inode->i_ino;
> +       iint->real_rdev =3D real_inode->i_rdev;

iint->real_dev =3D real_inode->i_sb->s_dev;

i_rdev is something else.
it's the device pointed to by a blockdev/chardev inode.

Thanks,
Amir.


>
>         /* Possibly temporary failure due to type of read (eg. O_DIRECT) =
*/
>         if (!result)
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 365db0e43d7c..4a6a22f8805b 100644
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
> @@ -284,6 +285,19 @@ static int process_measurement(struct file *file, co=
nst struct cred *cred,
>                 iint->measured_pcrs =3D 0;
>         }
>
> +       /* Detect and re-evaluate changes made to the backing file. */
> +       backing_inode =3D d_real_inode(file_dentry(file));
> +       if (backing_inode !=3D inode &&
> +           (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
> +               if (!IS_I_VERSION(backing_inode) ||
> +                   backing_inode->i_rdev !=3D iint->real_rdev ||
> +                   backing_inode->i_ino !=3D iint->real_ino ||
> +                   !inode_eq_iversion(backing_inode, iint->version)) {
> +                       iint->flags &=3D ~IMA_DONE_MASK;
> +                       iint->measured_pcrs =3D 0;
> +               }
> +       }
> +
>         /* Determine if already appraised/measured based on bitmask
>          * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAI=
SED,
>          *  IMA_AUDIT, IMA_AUDITED)
> diff --git a/security/integrity/integrity.h b/security/integrity/integrit=
y.h
> index d7553c93f5c0..dd2bb2d150f6 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -164,6 +164,8 @@ struct integrity_iint_cache {
>         unsigned long flags;
>         unsigned long measured_pcrs;
>         unsigned long atomic_flags;
> +       unsigned long real_ino;
> +       dev_t real_rdev;
>         enum integrity_status ima_file_status:4;
>         enum integrity_status ima_mmap_status:4;
>         enum integrity_status ima_bprm_status:4;
> --
> 2.39.3
>
