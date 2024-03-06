Return-Path: <linux-kernel+bounces-93305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D835872DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87CA01C21837
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A42615ACB;
	Wed,  6 Mar 2024 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2DdmEqC"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6891A14280;
	Wed,  6 Mar 2024 04:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698009; cv=none; b=bhYxGZSh1m54fZln1JonPxCqFuq+cqaSLCUCmCLsLI+oVNYImBEIlvnwGZ211D+M6SMS6FNRZkzhLw4kU/tDWvsT7DKEEOZHmfMpYlX8KtScPHXE784htEHOcMWBeNAjpjKb96vC/Sw1EbfGETqU/sNqkXq85kegh/DMr63mBWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698009; c=relaxed/simple;
	bh=m1FBM12FiouE7oTupXHy8yDMpoy9xGvFMJmmmvirJAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GPIJnfJWgVrCTeamIAcnNTfFd09jS/FD4ALQEaZcdCz9WQpQAzZ/1UYDYriGIppjDozaAWbtAjXzwq7zN/QU9vOoBpdNz8YlQ80rEiMXUOdGuWdlNLggegpN4eoUS1P2pJ55L43OgCFgfx15/UTQ5hyPv00oRaEC5y0mYiYx9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2DdmEqC; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a44628725e3so815374766b.0;
        Tue, 05 Mar 2024 20:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709698006; x=1710302806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yo8kdFWfcbPRCney8aVXOU6QIDnqUXcX0fbHa52cDOM=;
        b=h2DdmEqCWLiez1GghyAxVgtz8CCWcQBqI+G/tv4qkw4MxhJWAYD0M0XObqzKBwaul3
         81Yq65XFhNgL4AcZIvjTDB2O+QZO9BxqIz9cwo6BuZsz6WM+Kj3vAFHRiYYg6RFdhRSV
         2RuQCjQ7TkrAGOI34M6SnZKZwr6NZbVvEJnCUG3l0xVVxMIjLUA7aieRoPovJGymh/Re
         jyVLY6/85BCW8zWJfOxooOUaQunwCgL/ruyhsGFoLTdEzWXzlY0nBcDGPdK1TIhTpGxO
         gVa3BwYKIJwZ3Ud6M60+q9KxEgs9JI2GCf6fuAhWzgyDnFkcY6B+tkzjnwQ2BumFKD+G
         /HSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698006; x=1710302806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yo8kdFWfcbPRCney8aVXOU6QIDnqUXcX0fbHa52cDOM=;
        b=EaeAF2TK5eJfOPs9QT9z+iZlFFdQPEvkRgkzEST/QYdEA4V64dwCj1/H7FfNmjTNAm
         RghLDq3KjTbuPssTaM/cBqLcZxn2aLCFrF0+VwFj5d06QHgQYdILTzUxsE/V8128By/G
         rfiURBXZ/K6sG3N87blXGAYO9sTZdsakqSNpJrAZE1GpYdwbKCERcNg8uQzGluEB05i7
         lK2EkN8Fkv8T6SAv2dkovOX/Tl/NXXYisSOINjXKspX32Qr4/TZOm1bzbIQ8P34bDuIk
         TKwmjae4QZNETji6BDsGdjQ3Ada5DyPOf+XLvInBSYy4st+WkA49H/RaGVRv5HCSTmXq
         Oe1g==
X-Forwarded-Encrypted: i=1; AJvYcCW9nwIwIz1X6VnwRFJurSPWny4q+WF5Ml1xvFrZE85SVnY4pMP/F94uxoyo4KqdeQAiOwSKARkaXOXcuuMt+NJhYz3CUqBRAXvNWPRhlpcXTDCGSGpWNI/tiyIyQtd+4VQ0iZ/VFkc+DQ==
X-Gm-Message-State: AOJu0Yy2mfbnAg6Yb9GkLwGjQhb5PFj8kmv/IjLAdR12eamYv5erZa4X
	0iUYc7z9S2I+zKoIGXeqUyFDKBUpR2cplYnw3bXEnvB2C9xFZkFWauht09z1oorNg6QVPYDSnzB
	qgdstl5m9Ox7YIGTn7NVZwn9acHVniv2+LcwQeQ==
X-Google-Smtp-Source: AGHT+IEOHmmWZASLHqAU2H4GlFekUdxW9F3GcE0RukINeB2qASnJLDd6CMwCQsjJkbTqiHjWyLaPemp7pov9LjhnTV0=
X-Received: by 2002:a17:906:d148:b0:a45:67ce:5264 with SMTP id
 br8-20020a170906d14800b00a4567ce5264mr4352538ejb.56.1709698005432; Tue, 05
 Mar 2024 20:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com> <20240306034353.190039-2-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240306034353.190039-2-meetakshisetiyaoss@gmail.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 6 Mar 2024 09:36:33 +0530
Message-ID: <CAFTVevUF0Vc56p=V2p1Nn8OYg7rQ-Rei4ADC=ycJ0-sHLgKj+Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] smb: client: do not defer close open handles to
 deleted files
To: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated version of the patch
https://lore.kernel.org/all/20240209131552.471765-1-meetakshisetiyaoss@gmai=
l.com/
Includes perf improvement by iterating over cinode's openFileList instead
of tcon openFileList. Also, compare the deleted path with the path of each
open file in the cinode only when the file has hardlinks. Else, all open
handles are from the same file only.

Thanks
Meetakshi

On Wed, Mar 6, 2024 at 9:14=E2=80=AFAM <meetakshisetiyaoss@gmail.com> wrote=
:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> When a file/dentry has been deleted before closing all its open
> handles, currently, closing them can add them to the deferred
> close list. This can lead to problems in creating file with the
> same name when the file is re-created before the deferred close
> completes. This issue was seen while reusing a client's already
> existing lease on a file for compound operations and xfstest 591
> failed because of the deferred close handle that remained valid
> even after the file was deleted and was being reused to create a
> file with the same name. The server in this case returns an error
> on open with STATUS_DELETE_PENDING. Recreating the file would
> fail till the deferred handles are closed (duration specified in
> closetimeo).
>
> This patch fixes the issue by flagging all open handles for the
> deleted file (file path to be precise) by setting
> status_file_deleted to true in the cifsFileInfo structure. As per
> the information classes specified in MS-FSCC, SMB2 query info
> response from the server has a DeletePending field, set to true
> to indicate that deletion has been requested on that file. If
> this is the case, flag the open handles for this file too.
>
> When doing close in cifs_close for each of these handles, check the
> value of this boolean field and do not defer close these handles
> if the corresponding filepath has been deleted.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/cifsglob.h  |  1 +
>  fs/smb/client/cifsproto.h |  4 ++++
>  fs/smb/client/file.c      |  3 ++-
>  fs/smb/client/inode.c     | 28 +++++++++++++++++++++++++---
>  fs/smb/client/misc.c      | 34 ++++++++++++++++++++++++++++++++++
>  fs/smb/client/smb2inode.c |  9 ++++++++-
>  6 files changed, 74 insertions(+), 5 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index 50f7e47c2229..a88c8328b29c 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -1417,6 +1417,7 @@ struct cifsFileInfo {
>         bool invalidHandle:1;   /* file closed via session abend */
>         bool swapfile:1;
>         bool oplock_break_cancelled:1;
> +       bool status_file_deleted:1; /* file has been deleted */
>         unsigned int oplock_epoch; /* epoch from the lease break */
>         __u32 oplock_level; /* oplock/lease level from the lease break */
>         int count;
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index ef98c840791f..1f46e0db6e92 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struct cif=
s_tcon *cifs_tcon);
>
>  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs=
_tcon,
>                                 const char *path);
> +
> +extern void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
> +                               const char *path);
> +
>  extern struct TCP_Server_Info *
>  cifs_get_tcp_session(struct smb3_fs_context *ctx,
>                      struct TCP_Server_Info *primary_server);
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index b75282c204da..46951f403d31 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fi=
d *fid, struct file *file,
>         cfile->uid =3D current_fsuid();
>         cfile->dentry =3D dget(dentry);
>         cfile->f_flags =3D file->f_flags;
> +       cfile->status_file_deleted =3D false;
>         cfile->invalidHandle =3D false;
>         cfile->deferred_close_scheduled =3D false;
>         cfile->tlink =3D cifs_get_tlink(tlink);
> @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *fi=
le)
>                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=3D CI=
FS_CACHE_RHW_FLG)
>                     && cinode->lease_granted &&
>                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
> -                   dclose) {
> +                   dclose && !(cfile->status_file_deleted)) {
>                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &c=
inode->flags)) {
>                                 inode_set_mtime_to_ts(inode,
>                                                       inode_set_ctime_cur=
rent(inode));
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 3073eac989ea..3242e3b74386 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -893,6 +893,9 @@ cifs_get_file_info(struct file *filp)
>         struct cifsFileInfo *cfile =3D filp->private_data;
>         struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
>         struct TCP_Server_Info *server =3D tcon->ses->server;
> +       struct dentry *dentry =3D filp->f_path.dentry;
> +       void *page =3D alloc_dentry_path();
> +       const unsigned char *path;
>
>         if (!server->ops->query_file_info)
>                 return -ENOSYS;
> @@ -907,7 +910,14 @@ cifs_get_file_info(struct file *filp)
>                         data.symlink =3D true;
>                         data.reparse.tag =3D IO_REPARSE_TAG_SYMLINK;
>                 }
> +               path =3D build_path_from_dentry(dentry, page);
> +               if (IS_ERR(path)) {
> +                       free_dentry_path(page);
> +                       return PTR_ERR(path);
> +               }
>                 cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
> +               if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
> +                       cifs_mark_open_handles_for_deleted_file(inode, pa=
th);
>                 break;
>         case -EREMOTE:
>                 cifs_create_junction_fattr(&fattr, inode->i_sb);
> @@ -937,6 +947,7 @@ cifs_get_file_info(struct file *filp)
>         rc =3D cifs_fattr_to_inode(inode, &fattr);
>  cgfi_exit:
>         cifs_free_open_info(&data);
> +       free_dentry_path(page);
>         free_xid(xid);
>         return rc;
>  }
> @@ -1075,6 +1086,7 @@ static int reparse_info_to_fattr(struct cifs_open_i=
nfo_data *data,
>         struct kvec rsp_iov, *iov =3D NULL;
>         int rsp_buftype =3D CIFS_NO_BUFFER;
>         u32 tag =3D data->reparse.tag;
> +       struct inode *inode =3D NULL;
>         int rc =3D 0;
>
>         if (!tag && server->ops->query_reparse_point) {
> @@ -1114,8 +1126,12 @@ static int reparse_info_to_fattr(struct cifs_open_=
info_data *data,
>
>         if (tcon->posix_extensions)
>                 smb311_posix_info_to_fattr(fattr, data, sb);
> -       else
> +       else {
>                 cifs_open_info_to_fattr(fattr, data, sb);
> +               inode =3D cifs_iget(sb, fattr);
> +               if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
> +                       cifs_mark_open_handles_for_deleted_file(inode, fu=
ll_path);
> +       }
>  out:
>         fattr->cf_cifstag =3D data->reparse.tag;
>         free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
> @@ -1170,6 +1186,8 @@ static int cifs_get_fattr(struct cifs_open_info_dat=
a *data,
>                                                    full_path, fattr);
>                 } else {
>                         cifs_open_info_to_fattr(fattr, data, sb);
> +                       if (fattr->cf_flags & CIFS_FATTR_DELETE_PENDING)
> +                               cifs_mark_open_handles_for_deleted_file(*=
inode, full_path);
>                 }
>                 break;
>         case -EREMOTE:
> @@ -1850,16 +1868,20 @@ int cifs_unlink(struct inode *dir, struct dentry =
*dentry)
>
>  psx_del_no_retry:
>         if (!rc) {
> -               if (inode)
> +               if (inode) {
> +                       cifs_mark_open_handles_for_deleted_file(inode, fu=
ll_path);
>                         cifs_drop_nlink(inode);
> +               }
>         } else if (rc =3D=3D -ENOENT) {
>                 d_drop(dentry);
>         } else if (rc =3D=3D -EBUSY) {
>                 if (server->ops->rename_pending_delete) {
>                         rc =3D server->ops->rename_pending_delete(full_pa=
th,
>                                                                 dentry, x=
id);
> -                       if (rc =3D=3D 0)
> +                       if (rc =3D=3D 0) {
> +                               cifs_mark_open_handles_for_deleted_file(i=
node, full_path);
>                                 cifs_drop_nlink(inode);
> +                       }
>                 }
>         } else if ((rc =3D=3D -EACCES) && (dosattr =3D=3D 0) && inode) {
>                 attrs =3D kzalloc(sizeof(*attrs), GFP_KERNEL);
> diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> index 0748d7b757b9..9428a0db7718 100644
> --- a/fs/smb/client/misc.c
> +++ b/fs/smb/client/misc.c
> @@ -853,6 +853,40 @@ cifs_close_deferred_file_under_dentry(struct cifs_tc=
on *tcon, const char *path)
>         free_dentry_path(page);
>  }
>
> +/*
> + * If a dentry has been deleted, all corresponding open handles should k=
now that
> + * so that we do not defer close them.
> + */
> +void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
> +                                            const char *path)
> +{
> +       struct cifsFileInfo *cfile;
> +       void *page;
> +       const char *full_path;
> +       struct cifsInodeInfo *cinode =3D CIFS_I(inode);
> +
> +       page =3D alloc_dentry_path();
> +       spin_lock(&cinode->open_file_lock);
> +
> +       /*
> +        * note: we need to construct path from dentry and compare only i=
f the
> +        * inode has any hardlinks. When number of hardlinks is 1, we can=
 just
> +        * mark all open handles since they are going to be from the same=
 file.
> +        */
> +       if (inode->i_nlink > 1) {
> +               list_for_each_entry(cfile, &cinode->openFileList, flist) =
{
> +                       full_path =3D build_path_from_dentry(cfile->dentr=
y, page);
> +                       if (!IS_ERR(full_path) && strcmp(full_path, path)=
 =3D=3D 0)
> +                               cfile->status_file_deleted =3D true;
> +               }
> +       } else {
> +               list_for_each_entry(cfile, &cinode->openFileList, flist)
> +                       cfile->status_file_deleted =3D true;
> +       }
> +       spin_unlock(&cinode->open_file_lock);
> +       free_dentry_path(page);
> +}
> +
>  /* parses DFS referral V3 structure
>   * caller is responsible for freeing target_nodes
>   * returns:
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 69f3442c5b96..429d83d31280 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -561,8 +561,15 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>                 case SMB2_OP_DELETE:
>                         if (rc)
>                                 trace_smb3_delete_err(xid,  ses->Suid, tc=
on->tid, rc);
> -                       else
> +                       else {
> +                               /*
> +                                * If dentry (hence, inode) is NULL, leas=
e break is going to
> +                                * take care of degrading leases on handl=
es for deleted files.
> +                                */
> +                               if (inode)
> +                                       cifs_mark_open_handles_for_delete=
d_file(inode, full_path);
>                                 trace_smb3_delete_done(xid, ses->Suid, tc=
on->tid);
> +                       }
>                         break;
>                 case SMB2_OP_MKDIR:
>                         if (rc)
> --
> 2.39.2
>

