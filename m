Return-Path: <linux-kernel+bounces-40426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D09C83DFE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31AD81C21D26
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709111EB4F;
	Fri, 26 Jan 2024 17:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nLA67ZYn"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E04A1EB41;
	Fri, 26 Jan 2024 17:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706289751; cv=none; b=OmI+yyukRIZ/RjKktGCfpEL5G4qcPxe6VArgaRgBtQ5p33rfybpVTDvZ2HUeuXUaiSW+rj3TvLW3uh7c6xqGqKJ1SlrFsIYKWbjoRIu0Is3BPbsraTQYGlKPlXsm6pPLIoyqAxPdfLmIWlhIDPF7h9cx3gViKbsrMf/2KRHCH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706289751; c=relaxed/simple;
	bh=faMjkaHk7os/E2kEVOp/ZNX+EUZRZ1j9yZusNn3y15I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KdlzdNPSek1Yvvof/P1RFBZCC92kV/weIzRB2PT1Cxs6fHuJ9p6z0gaXqYgYnROWjM5gYZDbtx7AeWP+KNtER6Kr+B7ytyoS7GbSBQPlUdCnpiTa1kIbtkVx/vAdTCfGP0JhapeXqh8zcIhAqSbtXnQcC7LHiBbNQYtpIpUt+h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nLA67ZYn; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a27733ae1dfso38730666b.3;
        Fri, 26 Jan 2024 09:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706289747; x=1706894547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=frHohxChucR+396ZZyvCVKe3rd87cMANH2LHlTV9uT0=;
        b=nLA67ZYnjSHHKr+QIFNsvOqKwNFbP9hamzg/k617hWKUUwvK8FpETCYc0yYgP4LeOr
         MA1OMxHgifcxaE1bLQTwZT9benspt8sMfAREaSWyeEbiOaKNR3PxPEjP4QTh+cynlkkh
         ZvGNRI7kybaA71ld98tOsTKYEM8r6riQK2y5dLerKustUyCWD3xoZOuqURZkp8A8bzm0
         4226Nk33HIazX8JleqrSW35guL3/Y+zhhizei8M3iwqV6YGDegp7KWxePeNpWDxF+xSx
         PACjdHKlianwqcmuiodkM0myNxMAh+tMYcvy4nE+XEurQ+xvrXWyJheP9CbgaxQPte4b
         Uo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706289747; x=1706894547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=frHohxChucR+396ZZyvCVKe3rd87cMANH2LHlTV9uT0=;
        b=fhGxjPdFphRCW24sCTiilzpx8yb/EoXDR07ld4doUda2QxtTaBv8qNvWaw20wFHQal
         MKsXcg0lynsni1dgdN69oZap+Pc6jtuA3rjDAUN/bPneFCHhtiyDfokVf1//hWsfzvAY
         S4P8ZLXuM7cbPZA5bGi1KW5IFX8MAEYqt+MS36oCuyjYMa/Cw1p33Wwt3ZChH0Yw4UrD
         IZliQaob8i8rPkheO9hbDeCOW1of3YH23RbZaOXrZOH9j6LF4vvIV0S82Dw7OhbDYqmh
         kYtlSoPZQsed/V4nTgdT0O8G2K2I+EZw/CpY3ARv3GnQfCDKa41IIA1tN/wrDoe4a2XL
         MN+Q==
X-Gm-Message-State: AOJu0Yw9YEG1wKNa1uG7GzpYaCB0emtXBbgYzQN2rnIomoqXrx5O3lv9
	31yU1uFwKffHNYAaJpoNbe5Krdnm6W+Lp/hVJsgkBPnbRbgZDzjb5Wfyq6hrCHw8MOHZjxP5QM0
	5FvFCVCbD5VbSsQIyRA8H2f4tL/U=
X-Google-Smtp-Source: AGHT+IEv+VzPTgkhlM0Iyu9mf/bHiSiJ5tBWQ5F4heJdFo1RrwTSJwMPOP7fFmT7DWgwCzAtgYHxTGLHWB376hQqNSk=
X-Received: by 2002:a17:906:bc5b:b0:a31:6811:bf99 with SMTP id
 s27-20020a170906bc5b00b00a316811bf99mr570470ejv.56.1706289747305; Fri, 26 Jan
 2024 09:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125235723.39507-1-vinicius.gomes@intel.com> <20240125235723.39507-4-vinicius.gomes@intel.com>
In-Reply-To: <20240125235723.39507-4-vinicius.gomes@intel.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 26 Jan 2024 19:22:14 +0200
Message-ID: <CAOQ4uxh15X9pMY7Ck=iigaaKX11_77x5sZE9jxakTG9VpkuG6g@mail.gmail.com>
Subject: Re: [RFC v2 3/4] overlayfs: Optimize credentials usage
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: brauner@kernel.org, hu1.chen@intel.com, miklos@szeredi.hu, 
	malini.bhandaru@intel.com, tim.c.chen@intel.com, mikko.ylinen@intel.com, 
	lizhen.you@intel.com, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:57=E2=80=AFAM Vinicius Costa Gomes
<vinicius.gomes@intel.com> wrote:
>
> File operations in overlayfs also check against the credentials of the
> mounter task, stored in the superblock, this credentials will outlive
> most of the operations. For these cases, use the recently introduced
> guard statements to guarantee that override/revert_creds() are paired.
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> ---
>  fs/overlayfs/copy_up.c |  4 +--
>  fs/overlayfs/dir.c     | 22 +++++++------
>  fs/overlayfs/file.c    | 70 ++++++++++++++++++++++--------------------
>  fs/overlayfs/inode.c   | 60 +++++++++++++++++++-----------------
>  fs/overlayfs/namei.c   | 21 ++++++-------
>  fs/overlayfs/readdir.c | 18 +++++------
>  fs/overlayfs/util.c    | 23 +++++++-------
>  fs/overlayfs/xattrs.c  | 34 ++++++++++----------
>  8 files changed, 130 insertions(+), 122 deletions(-)
>
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index b8e25ca51016..55d1f2b60775 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -1202,7 +1202,8 @@ static int ovl_copy_up_flags(struct dentry *dentry,=
 int flags)
>         if (err)
>                 return err;
>
> -       old_cred =3D ovl_override_creds(dentry->d_sb);
> +       old_cred =3D ovl_creds(dentry->d_sb);
> +       guard(cred)(old_cred);
>         while (!err) {
>                 struct dentry *next;
>                 struct dentry *parent =3D NULL;
> @@ -1227,7 +1228,6 @@ static int ovl_copy_up_flags(struct dentry *dentry,=
 int flags)
>                 dput(parent);
>                 dput(next);
>         }
> -       revert_creds(old_cred);
>
>         return err;
>  }
> diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
> index 0f8b4a719237..5aa43a3a7b3e 100644
> --- a/fs/overlayfs/dir.c
> +++ b/fs/overlayfs/dir.c
> @@ -687,9 +687,9 @@ static int ovl_set_link_redirect(struct dentry *dentr=
y)
>         const struct cred *old_cred;
>         int err;
>
> -       old_cred =3D ovl_override_creds(dentry->d_sb);
> +       old_cred =3D ovl_creds(dentry->d_sb);
> +       guard(cred)(old_cred);
>         err =3D ovl_set_redirect(dentry, false);
> -       revert_creds(old_cred);
>
>         return err;
>  }
> @@ -894,12 +894,13 @@ static int ovl_do_remove(struct dentry *dentry, boo=
l is_dir)
>         if (err)
>                 goto out;
>
> -       old_cred =3D ovl_override_creds(dentry->d_sb);
> -       if (!lower_positive)
> -               err =3D ovl_remove_upper(dentry, is_dir, &list);
> -       else
> -               err =3D ovl_remove_and_whiteout(dentry, &list);
> -       revert_creds(old_cred);
> +       old_cred =3D ovl_creds(dentry->d_sb);
> +       scoped_guard(cred, old_cred) {
> +               if (!lower_positive)
> +                       err =3D ovl_remove_upper(dentry, is_dir, &list);
> +               else
> +                       err =3D ovl_remove_and_whiteout(dentry, &list);
> +       }
>         if (!err) {
>                 if (is_dir)
>                         clear_nlink(dentry->d_inode);
> @@ -1146,7 +1147,8 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>                         goto out;
>         }
>
> -       old_cred =3D ovl_override_creds(old->d_sb);
> +       old_cred =3D ovl_creds(old->d_sb);
> +       old_cred =3D override_creds_light(old_cred);
>
>         if (!list_empty(&list)) {
>                 opaquedir =3D ovl_clear_empty(new, &list);
> @@ -1279,7 +1281,7 @@ static int ovl_rename(struct mnt_idmap *idmap, stru=
ct inode *olddir,
>  out_unlock:
>         unlock_rename(new_upperdir, old_upperdir);
>  out_revert_creds:
> -       revert_creds(old_cred);
> +       revert_creds_light(old_cred);
>         if (update_nlink)
>                 ovl_nlink_end(new);
>         else

Most of my comments on this patch are identical to the ones I have made on
backing file, so rather complete that review before moving on to this bigge=
r
patch.

I even wonder if we need a specialized macro for overlayfs
guard(ovl_creds, ofs); or if
guard(cred, ovl_override_creds(dentry->d_sb));
is good enough.

One thing that stands out in functions like ovl_rename() is that,
understandably, you tried to preserve logic, but in fact, the scope of
override_creds/revert_creds() in some of the overlayfs functions ir rather
arbitrary.

The simplest solution for functions like the above is to use guard(cred, ..
and extend the scope till the end of the function.
This needs more careful review, but the end result will be much cleaner.

> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> index 05536964d37f..482bf78555e2 100644
> --- a/fs/overlayfs/file.c
> +++ b/fs/overlayfs/file.c
> @@ -42,7 +42,8 @@ static struct file *ovl_open_realfile(const struct file=
 *file,
>         if (flags & O_APPEND)
>                 acc_mode |=3D MAY_APPEND;
>
> -       old_cred =3D ovl_override_creds(inode->i_sb);
> +       old_cred =3D ovl_creds(inode->i_sb);
> +       guard(cred)(old_cred);
>         real_idmap =3D mnt_idmap(realpath->mnt);
>         err =3D inode_permission(real_idmap, realinode, MAY_OPEN | acc_mo=
de);
>         if (err) {
> @@ -54,7 +55,6 @@ static struct file *ovl_open_realfile(const struct file=
 *file,
>                 realfile =3D backing_file_open(&file->f_path, flags, real=
path,
>                                              current_cred());
>         }
> -       revert_creds(old_cred);
>
>         pr_debug("open(%p[%pD2/%c], 0%o) -> (%p, 0%o)\n",
>                  file, file, ovl_whatisit(inode, realinode), file->f_flag=
s,
> @@ -214,9 +214,9 @@ static loff_t ovl_llseek(struct file *file, loff_t of=
fset, int whence)
>         ovl_inode_lock(inode);
>         real.file->f_pos =3D file->f_pos;
>
> -       old_cred =3D ovl_override_creds(inode->i_sb);
> -       ret =3D vfs_llseek(real.file, offset, whence);
> -       revert_creds(old_cred);
> +       old_cred =3D ovl_creds(inode->i_sb);
> +       scoped_guard(cred, old_cred)
> +               ret =3D vfs_llseek(real.file, offset, whence);
>
>         file->f_pos =3D real.file->f_pos;
>         ovl_inode_unlock(inode);
> @@ -388,7 +388,6 @@ static ssize_t ovl_splice_write(struct pipe_inode_inf=
o *pipe, struct file *out,
>  static int ovl_fsync(struct file *file, loff_t start, loff_t end, int da=
tasync)
>  {
>         struct fd real;
> -       const struct cred *old_cred;
>         int ret;
>
>         ret =3D ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
> @@ -401,9 +400,11 @@ static int ovl_fsync(struct file *file, loff_t start=
, loff_t end, int datasync)
>
>         /* Don't sync lower file for fear of receiving EROFS error */
>         if (file_inode(real.file) =3D=3D ovl_inode_upper(file_inode(file)=
)) {
> -               old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
> +               const struct cred *old_cred;
> +
> +               old_cred =3D ovl_creds(file_inode(file)->i_sb);
> +               guard(cred)(old_cred);
>                 ret =3D vfs_fsync_range(real.file, start, end, datasync);
> -               revert_creds(old_cred);
>         }
>
>         fdput(real);
> @@ -441,9 +442,9 @@ static long ovl_fallocate(struct file *file, int mode=
, loff_t offset, loff_t len
>         if (ret)
>                 goto out_unlock;
>
> -       old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
> -       ret =3D vfs_fallocate(real.file, mode, offset, len);
> -       revert_creds(old_cred);
> +       old_cred =3D ovl_creds(file_inode(file)->i_sb);
> +       scoped_guard(cred, old_cred)
> +               ret =3D vfs_fallocate(real.file, mode, offset, len);
>
>         /* Update size */
>         ovl_file_modified(file);
> @@ -466,9 +467,9 @@ static int ovl_fadvise(struct file *file, loff_t offs=
et, loff_t len, int advice)
>         if (ret)
>                 return ret;
>
> -       old_cred =3D ovl_override_creds(file_inode(file)->i_sb);
> -       ret =3D vfs_fadvise(real.file, offset, len, advice);
> -       revert_creds(old_cred);
> +       old_cred =3D ovl_creds(file_inode(file)->i_sb);
> +       scoped_guard(cred, old_cred)
> +               ret =3D vfs_fadvise(real.file, offset, len, advice);
>
>         fdput(real);
>
> @@ -509,25 +510,25 @@ static loff_t ovl_copyfile(struct file *file_in, lo=
ff_t pos_in,
>                 goto out_unlock;
>         }
>
> -       old_cred =3D ovl_override_creds(file_inode(file_out)->i_sb);
> -       switch (op) {
> -       case OVL_COPY:
> -               ret =3D vfs_copy_file_range(real_in.file, pos_in,
> -                                         real_out.file, pos_out, len, fl=
ags);
> -               break;
> +       old_cred =3D ovl_creds(file_inode(file_out)->i_sb);
> +       scoped_guard(cred, old_cred)
> +               switch (op) {
> +               case OVL_COPY:
> +                       ret =3D vfs_copy_file_range(real_in.file, pos_in,
> +                                                 real_out.file, pos_out,=
 len, flags);
> +                       break;
>
> -       case OVL_CLONE:
> -               ret =3D vfs_clone_file_range(real_in.file, pos_in,
> -                                          real_out.file, pos_out, len, f=
lags);
> -               break;
> +               case OVL_CLONE:
> +                       ret =3D vfs_clone_file_range(real_in.file, pos_in=
,
> +                                                  real_out.file, pos_out=
, len, flags);
> +                       break;
>
> -       case OVL_DEDUPE:
> -               ret =3D vfs_dedupe_file_range_one(real_in.file, pos_in,
> -                                               real_out.file, pos_out, l=
en,
> -                                               flags);
> -               break;
> -       }
> -       revert_creds(old_cred);
> +               case OVL_DEDUPE:
> +                       ret =3D vfs_dedupe_file_range_one(real_in.file, p=
os_in,
> +                                                       real_out.file, po=
s_out, len,
> +                                                       flags);
> +                       break;
> +               }
>
>         /* Update size */
>         ovl_file_modified(file_out);

This is another case where extending the scope to the end of the function
is the simpler/cleaner solution.

Thanks,
Amir.

