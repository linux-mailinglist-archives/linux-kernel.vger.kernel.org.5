Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5C7FEA1D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344786AbjK3ICI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:02:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbjK3ICG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:02:06 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 818DF10DB;
        Thu, 30 Nov 2023 00:02:09 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-a00b056ca38so80542166b.2;
        Thu, 30 Nov 2023 00:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701331328; x=1701936128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zx/KGYJAnFp6NJZfcIVVscvdqh4rbto2bCeX1+xINQU=;
        b=Kn5GD2g1/Ee21XGW8gznWgIeFj5R210Y9Bb3+xr36c+MchCdL/V1oaJzZKA9vrZymA
         KGmKDRcV/s1dpL4cxVlKpfzZ6plznyn6GLRx8yTI5yuMARE1NhaslplMpnFRKH+0AmZ4
         yZ377TswNduJTF3pQRlCeeeDXt67ZaGQU8gJuTk1x7rIQCJ9ZZdT1BwqmElNiD/ok5MH
         2/QPUplToGE6Q7H2UGiZagHLV+yGQo5mTFULHgM2XPEa8cI0Spxvk73sdJ8C1MhKB4sh
         yEY64Kjtr7286mPjkFglTt+jx7WTBPgEeKAF5m/WVAps5UzctUsi4bEvcE0mgJkczWke
         e/cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701331328; x=1701936128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zx/KGYJAnFp6NJZfcIVVscvdqh4rbto2bCeX1+xINQU=;
        b=jDxQVKfA7+DSPYJpzQ3zENi25EdJGi1LEsKL7MInSF8sjmC0e1d0qSa5wCeF0t3EZA
         3/krBgRnpwdIN2h56TOCBYane3ih4i3AbC/6VlzLiiV8fiaLy06HTyh0faDCKhoGaaOc
         2SC8+h+FWOqlUmvWdYParOfwkQaH4StwYQdRK8936QtHiANKhSX5aG1Yj6ESSy9zAiI/
         7xngfAEIVBdh6mxfa2Ahhg0YYwqysYuox3PmNTuFOG1OO8vrhpYfMUDdGL73Fs2r+VjT
         V+3qVzH6YmxY3+u9KQEwxIVbUXLvw1k5n7+Ur+LDFMd+rA+DC0DZeMSkK9x6gwn8/Xdw
         FjzQ==
X-Gm-Message-State: AOJu0YxMin2fGPqXGzY8MWKb9TmgBM4mCianj5f0DF+S+ctooN7ueufE
        vdL+FXPztaeF4qYhjxfQs0v0UZugyvw4Og0Mrxs=
X-Google-Smtp-Source: AGHT+IEqPB8oiCcKreUnnhhCSBlvWbty5ZDJW39VjrZ/MDDaOnvt5BfM1B72XZH35qogSCiNUdJPjE2+ddTJ3y8Wzhg=
X-Received: by 2002:a17:906:3f18:b0:a18:ef56:8876 with SMTP id
 c24-20020a1709063f1800b00a18ef568876mr184395ejj.47.1701331327725; Thu, 30 Nov
 2023 00:02:07 -0800 (PST)
MIME-Version: 1.0
References: <20231129-idmap-fscap-refactor-v1-0-da5a26058a5b@kernel.org> <20231129-idmap-fscap-refactor-v1-9-da5a26058a5b@kernel.org>
In-Reply-To: <20231129-idmap-fscap-refactor-v1-9-da5a26058a5b@kernel.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 30 Nov 2023 10:01:55 +0200
Message-ID: <CAOQ4uxjhFKmHSUKiFOraDZojD0qGC=ChJJwtfrncuvTYi9NTKw@mail.gmail.com>
Subject: Re: [PATCH 09/16] fs: add vfs_set_fscaps()
To:     "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Serge Hallyn <serge@hallyn.com>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org, audit@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 11:50=E2=80=AFPM Seth Forshee (DigitalOcean)
<sforshee@kernel.org> wrote:
>
> Provide a type-safe interface for setting filesystem capabilities and a
> generic implementation suitable for most filesystems.
>
> Signed-off-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
> ---
>  fs/xattr.c         | 87 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/fs.h |  2 ++
>  2 files changed, 89 insertions(+)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index 3abaf9bef0a5..03cc824e4f87 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -247,6 +247,93 @@ int vfs_get_fscaps(struct mnt_idmap *idmap, struct d=
entry *dentry,
>  }
>  EXPORT_SYMBOL(vfs_get_fscaps);
>
> +static int generic_set_fscaps(struct mnt_idmap *idmap, struct dentry *de=
ntry,
> +                             const struct vfs_caps *caps, int flags)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct vfs_ns_cap_data nscaps;
> +       int size;
> +
> +       size =3D vfs_caps_to_xattr(idmap, i_user_ns(inode), caps,
> +                                &nscaps, sizeof(nscaps));
> +       if (size < 0)
> +               return size;
> +
> +       return __vfs_setxattr_noperm(idmap, dentry, XATTR_NAME_CAPS,
> +                                    &nscaps, size, flags);
> +}
> +
> +/**
> + * vfs_set_fscaps - set filesystem capabilities
> + * @idmap: idmap of the mount the inode was found from
> + * @dentry: the dentry on which to set filesystem capabilities
> + * @caps: the filesystem capabilities to be written
> + * @flags: setxattr flags to use when writing the capabilities xattr
> + *
> + * This function writes the supplied filesystem capabilities to the dent=
ry.
> + *
> + * Return: 0 on success, a negative errno on error.
> + */
> +int vfs_set_fscaps(struct mnt_idmap *idmap, struct dentry *dentry,
> +                  const struct vfs_caps *caps, int flags)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct inode *delegated_inode =3D NULL;
> +       struct vfs_ns_cap_data nscaps;
> +       int size, error;
> +
> +       /*
> +        * Unfortunately EVM wants to have the raw xattr value to compare=
 to
> +        * the on-disk version, so we need to pass the raw xattr to the
> +        * security hooks. But we also want to do security checks before
> +        * breaking leases, so that means a conversion to the raw xattr h=
ere
> +        * which will usually be reduntant with the conversion we do for
> +        * writing the xattr to disk.
> +        */
> +       size =3D vfs_caps_to_xattr(idmap, i_user_ns(inode), caps, &nscaps=
,
> +                                sizeof(nscaps));
> +       if (size < 0)
> +               return size;
> +
> +retry_deleg:
> +       inode_lock(inode);
> +
> +       error =3D xattr_permission(idmap, inode, XATTR_NAME_CAPS, MAY_WRI=
TE);
> +       if (error)
> +               goto out_inode_unlock;
> +       error =3D security_inode_setxattr(idmap, dentry, XATTR_NAME_CAPS,=
 &nscaps,
> +                                       size, flags);
> +       if (error)
> +               goto out_inode_unlock;
> +
> +       error =3D try_break_deleg(inode, &delegated_inode);
> +       if (error)
> +               goto out_inode_unlock;
> +
> +       if (inode->i_opflags & IOP_XATTR) {
> +               if (inode->i_op->set_fscaps)
> +                       error =3D inode->i_op->set_fscaps(idmap, dentry, =
caps, flags);
> +               else
> +                       error =3D generic_set_fscaps(idmap, dentry, caps,=
 flags);

I think the non-generic case is missing fsnotify_xattr().

See vfs_set_acl() for comparison.

Thanks,
Amir.
