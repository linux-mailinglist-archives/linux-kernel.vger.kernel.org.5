Return-Path: <linux-kernel+bounces-93439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C009872FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775461F217CF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9A15C8FB;
	Wed,  6 Mar 2024 07:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3ztfrWh"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969B17745;
	Wed,  6 Mar 2024 07:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710567; cv=none; b=o7Fz6NmDlkwKzuwJ4iBZls+ir5LeJXjcIjUjnf/qVm5O5UyiS54e4c0m23JqervSvMyaR1Rwc9X/zjnQnee0b4hh+bP4NXOPXmx1hOnjbK6G9XOlD95z8Q6U9dumaWtxAWtzZckHhhiyR0oLmK1swp3rqGfS3bOxMgLdVIot8zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710567; c=relaxed/simple;
	bh=Yeq6VsHc8D2NxqOB+eG+WeB0tV6FgrW/utPw+mlV8r4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S8lPEjxPEThhymHT2eP94q2XHb8FrGcUu0GaC5veu8I7bFrfKY/WQSl7byA6deOg7L1G58I8vkCNKU35M6noJ/0zZzkRoc0Xb7OPXt7zJHcEXCSmMvJsrPG31q35q8smPd66nM2WHFuBBaIYTWRN4yxEkNvSzVbaX50L4lelT0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3ztfrWh; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so561777766b.2;
        Tue, 05 Mar 2024 23:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709710564; x=1710315364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m08tRuJtmAoj0uqc6vM3T3Q6LV8ZZsSEJZUCv1RNGAQ=;
        b=M3ztfrWhS/wLo6zarRUTDu1k/g1GUtf3XF1qDpNVunQTvxHkCCZOxt/r/wBWsk7Oz2
         gXvBp0g8ltFOPqWD6Spe9D1uQyXIqQKUDTm2ekwAEskOMDZz4Vh0ANSjLkQwNByhKVb9
         qxQZhBMreA8bZLD5P0up/0ChNxrs5jO6iaFHxC+Or1W7KdHsp+7M9YSCH5aLpaFsp+ET
         QjmdBuNWr2DbiNwjNjenRRqpxVPa72r/rb69ise+Q9/M/iQaRig9L2RzQYYKRO/sNNpa
         H51gvs9CPZLf9Hy03s53IceGBcEy2p/KkSLzoFsdVYoo62UoK9chITiUuWy4LqasbX/O
         OH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710564; x=1710315364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m08tRuJtmAoj0uqc6vM3T3Q6LV8ZZsSEJZUCv1RNGAQ=;
        b=O0za2D7tMVxW/SX43S6Cy0D3ksJRTLrmbZBwKc4rvFL2umPwW1D6UpTi376HkIQJt3
         xvtzGltnE0PBBc9AcgGkVzdz+RFN0mYhgrDDlr9ibHARDGGXDKtd4C+PdEAFLr6nqdkW
         UmCiX9tkvTKv19dRYr4M/H5voMCpdUbOEdz8VV3IxYgiW9th5i1LdBOD57EHKYTHQLam
         yCT5KnYIwmHg92zvNZBCwWSnZeIC2H2gAY1AITwW4DWUV+3XFqUJIZimXPkY8ojcYzFU
         xOE7NEJJT3jqLo8+/zOYw060eJqy7NqmgLGZkExa0N0bb2nwjSWuVGfOrV0nRLtpb1kn
         e2bg==
X-Forwarded-Encrypted: i=1; AJvYcCXzOpatB3CU98Ps8GrQ4JVxzHN5sv7y/quCJ6xPMkfNcmhuZcIJewj1lCgTmmYcVPQvvHM42eI30SLHcyFO1UNfi3lGlw8gIXubAmeE8tZSLYdqOoxbbsjf1Z3Niq9dAsdStTXEF5Ahmg==
X-Gm-Message-State: AOJu0Yx5XYyC+Du0jSfvo+FVe+Tskt6E9ZpYyuBTywVl/pK4Q7lCyAF+
	VyLaRzmH95KzvMzmduOCEhp5xFO40FMeT7CgGXDre7yFNSj5gTcwok3SJKBXYDvmEduuWkKrNeT
	I7uYH1OalqPUkWao2e6LS7pA7ECY=
X-Google-Smtp-Source: AGHT+IGkBitiEpmIf/eCBLxP3W9a0oYPDPAm1+Pf8w6aphDRXF0JohBcAmnC1dqKb6qZpH4u49G1oW2pPCnYBooYjQU=
X-Received: by 2002:a17:906:a197:b0:a43:af0b:c1c0 with SMTP id
 s23-20020a170906a19700b00a43af0bc1c0mr11113008ejy.16.1709710564098; Tue, 05
 Mar 2024 23:36:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com>
 <20240306034353.190039-2-meetakshisetiyaoss@gmail.com> <CAH2r5mtt0aBrWCK3QgkHv7HHv0wpRHeOVM=5aXr=E5MFsmfFfg@mail.gmail.com>
In-Reply-To: <CAH2r5mtt0aBrWCK3QgkHv7HHv0wpRHeOVM=5aXr=E5MFsmfFfg@mail.gmail.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 6 Mar 2024 13:05:51 +0530
Message-ID: <CAFTVevVMQY=yQWBQK8mbkhkFqNHd_a=QYPGW4F3oynSNwvX+Eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] smb: client: do not defer close open handles to
 deleted files
To: Steve French <smfrench@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com, 
	Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Just checked, looks fine to me.
(apologies for the previous mail)

On Wed, Mar 6, 2024 at 12:39=E2=80=AFPM Steve French <smfrench@gmail.com> w=
rote:
>
> Merged the three patches into cifs-2.6.git pending testing but I had
> to rebase this one.  I also had to rebase one of Paulo's patches "smb:
> client: move most of reparse point handling code to common file"
>
> If you see anything wrong with the minor rebase let me know.
>
> On Tue, Mar 5, 2024 at 9:44=E2=80=AFPM <meetakshisetiyaoss@gmail.com> wro=
te:
> >
> > From: Meetakshi Setiya <msetiya@microsoft.com>
> >
> > When a file/dentry has been deleted before closing all its open
> > handles, currently, closing them can add them to the deferred
> > close list. This can lead to problems in creating file with the
> > same name when the file is re-created before the deferred close
> > completes. This issue was seen while reusing a client's already
> > existing lease on a file for compound operations and xfstest 591
> > failed because of the deferred close handle that remained valid
> > even after the file was deleted and was being reused to create a
> > file with the same name. The server in this case returns an error
> > on open with STATUS_DELETE_PENDING. Recreating the file would
> > fail till the deferred handles are closed (duration specified in
> > closetimeo).
> >
> > This patch fixes the issue by flagging all open handles for the
> > deleted file (file path to be precise) by setting
> > status_file_deleted to true in the cifsFileInfo structure. As per
> > the information classes specified in MS-FSCC, SMB2 query info
> > response from the server has a DeletePending field, set to true
> > to indicate that deletion has been requested on that file. If
> > this is the case, flag the open handles for this file too.
> >
> > When doing close in cifs_close for each of these handles, check the
> > value of this boolean field and do not defer close these handles
> > if the corresponding filepath has been deleted.
> >
> > Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> > ---
> >  fs/smb/client/cifsglob.h  |  1 +
> >  fs/smb/client/cifsproto.h |  4 ++++
> >  fs/smb/client/file.c      |  3 ++-
> >  fs/smb/client/inode.c     | 28 +++++++++++++++++++++++++---
> >  fs/smb/client/misc.c      | 34 ++++++++++++++++++++++++++++++++++
> >  fs/smb/client/smb2inode.c |  9 ++++++++-
> >  6 files changed, 74 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> > index 50f7e47c2229..a88c8328b29c 100644
> > --- a/fs/smb/client/cifsglob.h
> > +++ b/fs/smb/client/cifsglob.h
> > @@ -1417,6 +1417,7 @@ struct cifsFileInfo {
> >         bool invalidHandle:1;   /* file closed via session abend */
> >         bool swapfile:1;
> >         bool oplock_break_cancelled:1;
> > +       bool status_file_deleted:1; /* file has been deleted */
> >         unsigned int oplock_epoch; /* epoch from the lease break */
> >         __u32 oplock_level; /* oplock/lease level from the lease break =
*/
> >         int count;
> > diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> > index ef98c840791f..1f46e0db6e92 100644
> > --- a/fs/smb/client/cifsproto.h
> > +++ b/fs/smb/client/cifsproto.h
> > @@ -296,6 +296,10 @@ extern void cifs_close_all_deferred_files(struct c=
ifs_tcon *cifs_tcon);
> >
> >  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *ci=
fs_tcon,
> >                                 const char *path);
> > +
> > +extern void cifs_mark_open_handles_for_deleted_file(struct inode *inod=
e,
> > +                               const char *path);
> > +
> >  extern struct TCP_Server_Info *
> >  cifs_get_tcp_session(struct smb3_fs_context *ctx,
> >                      struct TCP_Server_Info *primary_server);
> > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> > index b75282c204da..46951f403d31 100644
> > --- a/fs/smb/client/file.c
> > +++ b/fs/smb/client/file.c
> > @@ -483,6 +483,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_=
fid *fid, struct file *file,
> >         cfile->uid =3D current_fsuid();
> >         cfile->dentry =3D dget(dentry);
> >         cfile->f_flags =3D file->f_flags;
> > +       cfile->status_file_deleted =3D false;
> >         cfile->invalidHandle =3D false;
> >         cfile->deferred_close_scheduled =3D false;
> >         cfile->tlink =3D cifs_get_tlink(tlink);
> > @@ -1085,7 +1086,7 @@ int cifs_close(struct inode *inode, struct file *=
file)
> >                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=3D =
CIFS_CACHE_RHW_FLG)
> >                     && cinode->lease_granted &&
> >                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &=
&
> > -                   dclose) {
> > +                   dclose && !(cfile->status_file_deleted)) {
> >                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, =
&cinode->flags)) {
> >                                 inode_set_mtime_to_ts(inode,
> >                                                       inode_set_ctime_c=
urrent(inode));
> > diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> > index 3073eac989ea..3242e3b74386 100644
> > --- a/fs/smb/client/inode.c
> > +++ b/fs/smb/client/inode.c
> > @@ -893,6 +893,9 @@ cifs_get_file_info(struct file *filp)
> >         struct cifsFileInfo *cfile =3D filp->private_data;
> >         struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
> >         struct TCP_Server_Info *server =3D tcon->ses->server;
> > +       struct dentry *dentry =3D filp->f_path.dentry;
> > +       void *page =3D alloc_dentry_path();
> > +       const unsigned char *path;
> >
> >         if (!server->ops->query_file_info)
> >                 return -ENOSYS;
> > @@ -907,7 +910,14 @@ cifs_get_file_info(struct file *filp)
> >                         data.symlink =3D true;
> >                         data.reparse.tag =3D IO_REPARSE_TAG_SYMLINK;
> >                 }
> > +               path =3D build_path_from_dentry(dentry, page);
> > +               if (IS_ERR(path)) {
> > +                       free_dentry_path(page);
> > +                       return PTR_ERR(path);
> > +               }
> >                 cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
> > +               if (fattr.cf_flags & CIFS_FATTR_DELETE_PENDING)
> > +                       cifs_mark_open_handles_for_deleted_file(inode, =
path);
> >                 break;
> >         case -EREMOTE:
> >                 cifs_create_junction_fattr(&fattr, inode->i_sb);
> > @@ -937,6 +947,7 @@ cifs_get_file_info(struct file *filp)
> >         rc =3D cifs_fattr_to_inode(inode, &fattr);
> >  cgfi_exit:
> >         cifs_free_open_info(&data);
> > +       free_dentry_path(page);
> >         free_xid(xid);
> >         return rc;
> >  }
> > @@ -1075,6 +1086,7 @@ static int reparse_info_to_fattr(struct cifs_open=
_info_data *data,
> >         struct kvec rsp_iov, *iov =3D NULL;
> >         int rsp_buftype =3D CIFS_NO_BUFFER;
> >         u32 tag =3D data->reparse.tag;
> > +       struct inode *inode =3D NULL;
> >         int rc =3D 0;
> >
> >         if (!tag && server->ops->query_reparse_point) {
> > @@ -1114,8 +1126,12 @@ static int reparse_info_to_fattr(struct cifs_ope=
n_info_data *data,
> >
> >         if (tcon->posix_extensions)
> >                 smb311_posix_info_to_fattr(fattr, data, sb);
> > -       else
> > +       else {
> >                 cifs_open_info_to_fattr(fattr, data, sb);
> > +               inode =3D cifs_iget(sb, fattr);
> > +               if (inode && fattr->cf_flags & CIFS_FATTR_DELETE_PENDIN=
G)
> > +                       cifs_mark_open_handles_for_deleted_file(inode, =
full_path);
> > +       }
> >  out:
> >         fattr->cf_cifstag =3D data->reparse.tag;
> >         free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
> > @@ -1170,6 +1186,8 @@ static int cifs_get_fattr(struct cifs_open_info_d=
ata *data,
> >                                                    full_path, fattr);
> >                 } else {
> >                         cifs_open_info_to_fattr(fattr, data, sb);
> > +                       if (fattr->cf_flags & CIFS_FATTR_DELETE_PENDING=
)
> > +                               cifs_mark_open_handles_for_deleted_file=
(*inode, full_path);
> >                 }
> >                 break;
> >         case -EREMOTE:
> > @@ -1850,16 +1868,20 @@ int cifs_unlink(struct inode *dir, struct dentr=
y *dentry)
> >
> >  psx_del_no_retry:
> >         if (!rc) {
> > -               if (inode)
> > +               if (inode) {
> > +                       cifs_mark_open_handles_for_deleted_file(inode, =
full_path);
> >                         cifs_drop_nlink(inode);
> > +               }
> >         } else if (rc =3D=3D -ENOENT) {
> >                 d_drop(dentry);
> >         } else if (rc =3D=3D -EBUSY) {
> >                 if (server->ops->rename_pending_delete) {
> >                         rc =3D server->ops->rename_pending_delete(full_=
path,
> >                                                                 dentry,=
 xid);
> > -                       if (rc =3D=3D 0)
> > +                       if (rc =3D=3D 0) {
> > +                               cifs_mark_open_handles_for_deleted_file=
(inode, full_path);
> >                                 cifs_drop_nlink(inode);
> > +                       }
> >                 }
> >         } else if ((rc =3D=3D -EACCES) && (dosattr =3D=3D 0) && inode) =
{
> >                 attrs =3D kzalloc(sizeof(*attrs), GFP_KERNEL);
> > diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> > index 0748d7b757b9..9428a0db7718 100644
> > --- a/fs/smb/client/misc.c
> > +++ b/fs/smb/client/misc.c
> > @@ -853,6 +853,40 @@ cifs_close_deferred_file_under_dentry(struct cifs_=
tcon *tcon, const char *path)
> >         free_dentry_path(page);
> >  }
> >
> > +/*
> > + * If a dentry has been deleted, all corresponding open handles should=
 know that
> > + * so that we do not defer close them.
> > + */
> > +void cifs_mark_open_handles_for_deleted_file(struct inode *inode,
> > +                                            const char *path)
> > +{
> > +       struct cifsFileInfo *cfile;
> > +       void *page;
> > +       const char *full_path;
> > +       struct cifsInodeInfo *cinode =3D CIFS_I(inode);
> > +
> > +       page =3D alloc_dentry_path();
> > +       spin_lock(&cinode->open_file_lock);
> > +
> > +       /*
> > +        * note: we need to construct path from dentry and compare only=
 if the
> > +        * inode has any hardlinks. When number of hardlinks is 1, we c=
an just
> > +        * mark all open handles since they are going to be from the sa=
me file.
> > +        */
> > +       if (inode->i_nlink > 1) {
> > +               list_for_each_entry(cfile, &cinode->openFileList, flist=
) {
> > +                       full_path =3D build_path_from_dentry(cfile->den=
try, page);
> > +                       if (!IS_ERR(full_path) && strcmp(full_path, pat=
h) =3D=3D 0)
> > +                               cfile->status_file_deleted =3D true;
> > +               }
> > +       } else {
> > +               list_for_each_entry(cfile, &cinode->openFileList, flist=
)
> > +                       cfile->status_file_deleted =3D true;
> > +       }
> > +       spin_unlock(&cinode->open_file_lock);
> > +       free_dentry_path(page);
> > +}
> > +
> >  /* parses DFS referral V3 structure
> >   * caller is responsible for freeing target_nodes
> >   * returns:
> > diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> > index 69f3442c5b96..429d83d31280 100644
> > --- a/fs/smb/client/smb2inode.c
> > +++ b/fs/smb/client/smb2inode.c
> > @@ -561,8 +561,15 @@ static int smb2_compound_op(const unsigned int xid=
, struct cifs_tcon *tcon,
> >                 case SMB2_OP_DELETE:
> >                         if (rc)
> >                                 trace_smb3_delete_err(xid,  ses->Suid, =
tcon->tid, rc);
> > -                       else
> > +                       else {
> > +                               /*
> > +                                * If dentry (hence, inode) is NULL, le=
ase break is going to
> > +                                * take care of degrading leases on han=
dles for deleted files.
> > +                                */
> > +                               if (inode)
> > +                                       cifs_mark_open_handles_for_dele=
ted_file(inode, full_path);
> >                                 trace_smb3_delete_done(xid, ses->Suid, =
tcon->tid);
> > +                       }
> >                         break;
> >                 case SMB2_OP_MKDIR:
> >                         if (rc)
> > --
> > 2.39.2
> >
> >
>
>
> --
> Thanks,
>
> Steve

