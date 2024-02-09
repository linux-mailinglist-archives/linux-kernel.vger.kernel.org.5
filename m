Return-Path: <linux-kernel+bounces-59372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7773A84F603
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01F781F2415C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD733C47B;
	Fri,  9 Feb 2024 13:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVsbrfJ2"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044103C471;
	Fri,  9 Feb 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707485365; cv=none; b=D8kcodeG7bxS8Z41vI9oqf/1A6MDZlzwH4ZI0I4f2STQPH8ExKmCQqkf/vJtpvFGfqbeQeWuZ7iCfD4+d9ShUPNnCa5P48XzRaN3KFjG7z/KYTGcszGNKJVZAVOzK5s26e3kd83cdsKeshXwYw2EYFHOaKncVaQgfpKNmwAfquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707485365; c=relaxed/simple;
	bh=YRN9vb7FMub9zXapg4jZtxH/yMeSSnoIUHj3Es03/+w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OnzzQk4PEiSEbgN+c0WHYqNG8sK7rkMT5vmjHVKRrBHlkHwfnjA6dqNUZQFSnsA26lhcwB3WztEgw8p2Xx78o0A29DMOTOvTSDwSY99bBlGz9oEE4VkZehb+spcuqnPO4kSlcDrcyUVc3HK5QzgcxVcj3QdQRD2lWuvAxmd8VG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVsbrfJ2; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3810e975aaso111206866b.3;
        Fri, 09 Feb 2024 05:29:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707485361; x=1708090161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFRg3zTwq/2/qPn4UoHBkBXLaAiL/xiiGrMUW2JfwW8=;
        b=WVsbrfJ2yl3/KOeMHFgHfcsn/OvMBd9oG6cUpID++M7xkZs/RFbE+JdqO10026IGsY
         uhML+lsVKAlNPN54hItnXnNmZFJYeAgNIVtRZsiGb70UP1zqas2YZ/hg1oPCg68v8Hgu
         +4U6pFdJggOEPEWOakLg/Ru12Uk+J19c+v1nbs9bOXLuzqYZE5PRvZ6sRnYFnjvzsDMv
         mTe3uH2Boi1PB64mJsQs4P89O2KbSCv6xxAkPSU/6l+YntWh3TFGcqB7wr7o1JvSD/yq
         TlFvv7QyHRaSvRpR6o/GkDM4F66T5E6HIcJV2GOG3W2/t/CfNT4xdEZAlieamW0adqus
         KKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707485361; x=1708090161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFRg3zTwq/2/qPn4UoHBkBXLaAiL/xiiGrMUW2JfwW8=;
        b=Svsy73hViqywNF/zWnJlMxXn8eI80awcGtt63BZ2gVqNoPrWgG5lQ3dy8qwOwhmP+8
         uegYHX/m2A1yDe0fsW+mc2qdSAcy47K69BQ007eSW3midwFGM634J42jPILWtiQuw+pF
         unDDB4meWvlUkiM09Jc8YLneI0euQiPWqfuez4Nb4c9Fl+13fqHiyCSJ12GssRUMsQI8
         R55zEFwl8uQQZ65N1gkL5YfcQhYAIUKXcnb7H0wp9UxN2urwQyXBCgLur7m8sXzigcDH
         XH4GNIm8fTsjU7pRSfv0ep8jBiEwCSM2v7cK4Pas9jIM7KI8Dm5dj2QUKnN/iE+HkJlT
         +JsA==
X-Gm-Message-State: AOJu0YxiuTgR6dj+scznRylIW+fQEsqtX4bPNZTWJH81+KQZVJ5U+aWe
	Vk8o3KA+pgPgnlHjCboRvnVjrSlAOdSRxaG93NxNEF8wI3QQMhh/dsDWdm+nWMWTrCDPXe3bukE
	xu7vheauglM4vDqVn3D8YgzYTtXo=
X-Google-Smtp-Source: AGHT+IGUOjiL7nX6AgGRh0Cv+vYXIpG37bAjf8/CbLASHOWsYE1+xLMqRbq/lvsL6+2rKfgKT64diwj7qyNYbCbfjlc=
X-Received: by 2002:a17:906:2610:b0:a3b:e8b8:1640 with SMTP id
 h16-20020a170906261000b00a3be8b81640mr1308075ejc.66.1707485360929; Fri, 09
 Feb 2024 05:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209131552.471765-1-meetakshisetiyaoss@gmail.com> <20240209131552.471765-2-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240209131552.471765-2-meetakshisetiyaoss@gmail.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Fri, 9 Feb 2024 18:59:08 +0530
Message-ID: <CAFTVevXHstK=Vh4kGu-m1FnLL9FmVy4wJFjU6mdx2zMDAnBfMw@mail.gmail.com>
Subject: Re: [PATCH 2/3] smb: client: reuse file lease key in compound operations
To: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On its own, the patch is expected to regress xfstests generic 013,
002 and 591.

The fix for 591 is in part 1 of this patch series
https://lore.kernel.org/linux-cifs/20240209131552.471765-1-meetakshisetiyao=
ss@gmail.com/

The fix for 002 and 013 is in part 3 of this patch series
https://lore.kernel.org/linux-cifs/20240209131552.471765-3-meetakshisetiyao=
ss@gmail.com/

Thanks
Meetakshi

On Fri, Feb 9, 2024 at 6:46=E2=80=AFPM <meetakshisetiyaoss@gmail.com> wrote=
:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> Currently, when a rename, unlink or set path size compound operation
> is requested on a file that has a lot of dirty pages to be written
> to the server, we do not send the lease key for these requests. As a
> result, the server can assume that this request is from a new client, and
> send a lease break notification to the same client, on the same
> connection. As a response to the lease break, the client can consume
> several credits to write the dirty pages to the server. Depending on the
> server's credit grant implementation, the server can stop granting more
> credits to this connection, and this can cause a deadlock (which can only
> be resolved when the lease timer on the server expires).
> One of the problems here is that the client is sending no lease key,
> even if it has a lease for the file. This patch fixes the problem by
> reusing the existing lease key on the file for rename, unlink and set pat=
h
> size compound operations so that the client does not break its own lease.
>
> A very trivial example could be a set of commands by a client that
> maintains open handle (for write) to a file and then tries to copy the
> contents of that file to another one, eg.,
>
> tail -f /dev/null > myfile &
> mv myfile myfile2
>
> Presently, the network capture on the client shows that the move (or
> rename) would trigger a lease break on the same client, for the same file=
.
> With the lease key reused, the lease break request-response overhead is
> eliminated, thereby reducing the roundtrips performed for this set of
> operations.
>
> The patch fixes the bug described above and also provides perf benefit.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/cifsglob.h  |  5 ++--
>  fs/smb/client/cifsproto.h |  6 +++--
>  fs/smb/client/cifssmb.c   |  4 ++--
>  fs/smb/client/inode.c     | 10 ++++----
>  fs/smb/client/smb2inode.c | 48 ++++++++++++++++++++++++---------------
>  fs/smb/client/smb2proto.h |  6 +++--
>  6 files changed, 48 insertions(+), 31 deletions(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index f6b4acdcdeb3..baeed01d356b 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -371,7 +371,8 @@ struct smb_version_operations {
>                             struct cifs_open_info_data *data);
>         /* set size by path */
>         int (*set_path_size)(const unsigned int, struct cifs_tcon *,
> -                            const char *, __u64, struct cifs_sb_info *, =
bool);
> +                            const char *, __u64, struct cifs_sb_info *, =
bool,
> +                                struct dentry *);
>         /* set size by file handle */
>         int (*set_file_size)(const unsigned int, struct cifs_tcon *,
>                              struct cifsFileInfo *, __u64, bool);
> @@ -401,7 +402,7 @@ struct smb_version_operations {
>                      struct cifs_sb_info *);
>         /* unlink file */
>         int (*unlink)(const unsigned int, struct cifs_tcon *, const char =
*,
> -                     struct cifs_sb_info *);
> +                     struct cifs_sb_info *, struct dentry *);
>         /* open, rename and delete file */
>         int (*rename_pending_delete)(const char *, struct dentry *,
>                                      const unsigned int);
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index f995b766b177..e108964950b5 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -406,7 +406,8 @@ extern int CIFSSMBSetFileDisposition(const unsigned i=
nt xid,
>                                      __u32 pid_of_opener);
>  extern int CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
>                          const char *file_name, __u64 size,
> -                        struct cifs_sb_info *cifs_sb, bool set_allocatio=
n);
> +                        struct cifs_sb_info *cifs_sb, bool set_allocatio=
n,
> +                        struct dentry *dentry);
>  extern int CIFSSMBSetFileSize(const unsigned int xid, struct cifs_tcon *=
tcon,
>                               struct cifsFileInfo *cfile, __u64 size,
>                               bool set_allocation);
> @@ -442,7 +443,8 @@ extern int CIFSPOSIXDelFile(const unsigned int xid, s=
truct cifs_tcon *tcon,
>                         const struct nls_table *nls_codepage,
>                         int remap_special_chars);
>  extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon=
,
> -                         const char *name, struct cifs_sb_info *cifs_sb)=
;
> +                         const char *name, struct cifs_sb_info *cifs_sb,
> +                         struct dentry *dentry);
>  int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
>                   struct dentry *source_dentry,
>                   const char *from_name, const char *to_name,
> diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
> index 01e89070df5a..301189ee1335 100644
> --- a/fs/smb/client/cifssmb.c
> +++ b/fs/smb/client/cifssmb.c
> @@ -738,7 +738,7 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_=
tcon *tcon,
>
>  int
>  CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const cha=
r *name,
> -              struct cifs_sb_info *cifs_sb)
> +              struct cifs_sb_info *cifs_sb, struct dentry *dentry)
>  {
>         DELETE_FILE_REQ *pSMB =3D NULL;
>         DELETE_FILE_RSP *pSMBr =3D NULL;
> @@ -4993,7 +4993,7 @@ CIFSSMBQFSPosixInfo(const unsigned int xid, struct =
cifs_tcon *tcon,
>  int
>  CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
>               const char *file_name, __u64 size, struct cifs_sb_info *cif=
s_sb,
> -             bool set_allocation)
> +             bool set_allocation, struct dentry *dentry)
>  {
>         struct smb_com_transaction2_spi_req *pSMB =3D NULL;
>         struct smb_com_transaction2_spi_rsp *pSMBr =3D NULL;
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 8121b5b1aa22..c3e86876a2a8 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -1846,7 +1846,7 @@ int cifs_unlink(struct inode *dir, struct dentry *d=
entry)
>                 goto psx_del_no_retry;
>         }
>
> -       rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb);
> +       rc =3D server->ops->unlink(xid, tcon, full_path, cifs_sb, dentry)=
;
>
>  psx_del_no_retry:
>         if (!rc) {
> @@ -2799,7 +2799,7 @@ void cifs_setsize(struct inode *inode, loff_t offse=
t)
>
>  static int
>  cifs_set_file_size(struct inode *inode, struct iattr *attrs,
> -                  unsigned int xid, const char *full_path)
> +                  unsigned int xid, const char *full_path, struct dentry=
 *dentry)
>  {
>         int rc;
>         struct cifsFileInfo *open_file;
> @@ -2850,7 +2850,7 @@ cifs_set_file_size(struct inode *inode, struct iatt=
r *attrs,
>          */
>         if (server->ops->set_path_size)
>                 rc =3D server->ops->set_path_size(xid, tcon, full_path,
> -                                               attrs->ia_size, cifs_sb, =
false);
> +                                               attrs->ia_size, cifs_sb, =
false, dentry);
>         else
>                 rc =3D -ENOSYS;
>         cifs_dbg(FYI, "SetEOF by path (setattrs) rc =3D %d\n", rc);
> @@ -2940,7 +2940,7 @@ cifs_setattr_unix(struct dentry *direntry, struct i=
attr *attrs)
>         rc =3D 0;
>
>         if (attrs->ia_valid & ATTR_SIZE) {
> -               rc =3D cifs_set_file_size(inode, attrs, xid, full_path);
> +               rc =3D cifs_set_file_size(inode, attrs, xid, full_path, d=
irentry);
>                 if (rc !=3D 0)
>                         goto out;
>         }
> @@ -3107,7 +3107,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct=
 iattr *attrs)
>         }
>
>         if (attrs->ia_valid & ATTR_SIZE) {
> -               rc =3D cifs_set_file_size(inode, attrs, xid, full_path);
> +               rc =3D cifs_set_file_size(inode, attrs, xid, full_path, d=
irentry);
>                 if (rc !=3D 0)
>                         goto cifs_setattr_exit;
>         }
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 05818cd6d932..69f3442c5b96 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -98,7 +98,7 @@ static int smb2_compound_op(const unsigned int xid, str=
uct cifs_tcon *tcon,
>                             __u32 desired_access, __u32 create_dispositio=
n,
>                             __u32 create_options, umode_t mode, struct kv=
ec *in_iov,
>                             int *cmds, int num_cmds, struct cifsFileInfo =
*cfile,
> -                           struct kvec *out_iov, int *out_buftype)
> +                           struct kvec *out_iov, int *out_buftype, struc=
t dentry *dentry)
>  {
>
>         struct reparse_data_buffer *rbuf;
> @@ -115,6 +115,7 @@ static int smb2_compound_op(const unsigned int xid, s=
truct cifs_tcon *tcon,
>         int resp_buftype[MAX_COMPOUND];
>         struct smb2_query_info_rsp *qi_rsp =3D NULL;
>         struct cifs_open_info_data *idata;
> +       struct inode *inode =3D NULL;
>         int flags =3D 0;
>         __u8 delete_pending[8] =3D {1, 0, 0, 0, 0, 0, 0, 0};
>         unsigned int size[2];
> @@ -152,6 +153,15 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>                 goto finished;
>         }
>
> +       /* if there is an existing lease, reuse it */
> +       if (dentry) {
> +               inode =3D d_inode(dentry);
> +               if (CIFS_I(inode)->lease_granted && server->ops->get_leas=
e_key) {
> +                       oplock =3D SMB2_OPLOCK_LEVEL_LEASE;
> +                       server->ops->get_lease_key(inode, &fid);
> +               }
> +       }
> +
>         vars->oparms =3D (struct cifs_open_parms) {
>                 .tcon =3D tcon,
>                 .path =3D full_path,
> @@ -747,7 +757,7 @@ int smb2_query_path_info(const unsigned int xid,
>         rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                               FILE_READ_ATTRIBUTES, FILE_OPEN,
>                               create_options, ACL_NO_MODE, in_iov,
> -                             cmds, 1, cfile, out_iov, out_buftype);
> +                             cmds, 1, cfile, out_iov, out_buftype, NULL)=
;
>         hdr =3D out_iov[0].iov_base;
>         /*
>          * If first iov is unset, then SMB session was dropped or we've g=
ot a
> @@ -779,7 +789,7 @@ int smb2_query_path_info(const unsigned int xid,
>                 rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                       FILE_READ_ATTRIBUTES, FILE_OPEN,
>                                       create_options, ACL_NO_MODE, in_iov=
,
> -                                     cmds, num_cmds, cfile, NULL, NULL);
> +                                     cmds, num_cmds, cfile, NULL, NULL, =
NULL);
>                 break;
>         case -EREMOTE:
>                 break;
> @@ -811,7 +821,7 @@ smb2_mkdir(const unsigned int xid, struct inode *pare=
nt_inode, umode_t mode,
>                                 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
>                                 CREATE_NOT_FILE, mode,
>                                 NULL, &(int){SMB2_OP_MKDIR}, 1,
> -                               NULL, NULL, NULL);
> +                               NULL, NULL, NULL, NULL);
>  }
>
>  void
> @@ -836,7 +846,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *n=
ame,
>                                  FILE_WRITE_ATTRIBUTES, FILE_CREATE,
>                                  CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
>                                  &(int){SMB2_OP_SET_INFO}, 1,
> -                                cfile, NULL, NULL);
> +                                cfile, NULL, NULL, NULL);
>         if (tmprc =3D=3D 0)
>                 cifs_i->cifsAttrs =3D dosattrs;
>  }
> @@ -850,25 +860,26 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon=
 *tcon, const char *name,
>                                 DELETE, FILE_OPEN, CREATE_NOT_FILE,
>                                 ACL_NO_MODE, NULL,
>                                 &(int){SMB2_OP_RMDIR}, 1,
> -                               NULL, NULL, NULL);
> +                               NULL, NULL, NULL, NULL);
>  }
>
>  int
>  smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *=
name,
> -           struct cifs_sb_info *cifs_sb)
> +           struct cifs_sb_info *cifs_sb, struct dentry *dentry)
>  {
>         return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OP=
EN,
>                                 CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POI=
NT,
>                                 ACL_NO_MODE, NULL,
>                                 &(int){SMB2_OP_DELETE}, 1,
> -                               NULL, NULL, NULL);
> +                               NULL, NULL, NULL, dentry);
>  }
>
>  static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *=
tcon,
>                               const char *from_name, const char *to_name,
>                               struct cifs_sb_info *cifs_sb,
>                               __u32 create_options, __u32 access,
> -                             int command, struct cifsFileInfo *cfile)
> +                             int command, struct cifsFileInfo *cfile,
> +                                 struct dentry *dentry)
>  {
>         struct kvec in_iov;
>         __le16 *smb2_to_name =3D NULL;
> @@ -883,7 +894,7 @@ static int smb2_set_path_attr(const unsigned int xid,=
 struct cifs_tcon *tcon,
>         in_iov.iov_len =3D 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_M=
AX);
>         rc =3D smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
>                               FILE_OPEN, create_options, ACL_NO_MODE,
> -                             &in_iov, &command, 1, cfile, NULL, NULL);
> +                             &in_iov, &command, 1, cfile, NULL, NULL, de=
ntry);
>  smb2_rename_path:
>         kfree(smb2_to_name);
>         return rc;
> @@ -902,7 +913,7 @@ int smb2_rename_path(const unsigned int xid,
>         cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfi=
le);
>
>         return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
> -                                 co, DELETE, SMB2_OP_RENAME, cfile);
> +                                 co, DELETE, SMB2_OP_RENAME, cfile, sour=
ce_dentry);
>  }
>
>  int smb2_create_hardlink(const unsigned int xid,
> @@ -915,13 +926,14 @@ int smb2_create_hardlink(const unsigned int xid,
>
>         return smb2_set_path_attr(xid, tcon, from_name, to_name,
>                                   cifs_sb, co, FILE_READ_ATTRIBUTES,
> -                                 SMB2_OP_HARDLINK, NULL);
> +                                 SMB2_OP_HARDLINK, NULL, NULL);
>  }
>
>  int
>  smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
>                    const char *full_path, __u64 size,
> -                  struct cifs_sb_info *cifs_sb, bool set_alloc)
> +                  struct cifs_sb_info *cifs_sb, bool set_alloc,
> +                  struct dentry *dentry)
>  {
>         struct cifsFileInfo *cfile;
>         struct kvec in_iov;
> @@ -934,7 +946,7 @@ smb2_set_path_size(const unsigned int xid, struct cif=
s_tcon *tcon,
>                                 FILE_WRITE_DATA, FILE_OPEN,
>                                 0, ACL_NO_MODE, &in_iov,
>                                 &(int){SMB2_OP_SET_EOF}, 1,
> -                               cfile, NULL, NULL);
> +                               cfile, NULL, NULL, dentry);
>  }
>
>  int
> @@ -963,7 +975,7 @@ smb2_set_file_info(struct inode *inode, const char *f=
ull_path,
>                               FILE_WRITE_ATTRIBUTES, FILE_OPEN,
>                               0, ACL_NO_MODE, &in_iov,
>                               &(int){SMB2_OP_SET_INFO}, 1,
> -                             cfile, NULL, NULL);
> +                             cfile, NULL, NULL, NULL);
>         cifs_put_tlink(tlink);
>         return rc;
>  }
> @@ -998,7 +1010,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_ope=
n_info_data *data,
>                 cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfi=
le);
>                 rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                       da, cd, co, ACL_NO_MODE, in_iov,
> -                                     cmds, 2, cfile, NULL, NULL);
> +                                     cmds, 2, cfile, NULL, NULL, NULL);
>                 if (!rc) {
>                         rc =3D smb311_posix_get_inode_info(&new, full_pat=
h,
>                                                          data, sb, xid);
> @@ -1008,7 +1020,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_op=
en_info_data *data,
>                 cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfi=
le);
>                 rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                       da, cd, co, ACL_NO_MODE, in_iov,
> -                                     cmds, 2, cfile, NULL, NULL);
> +                                     cmds, 2, cfile, NULL, NULL, NULL);
>                 if (!rc) {
>                         rc =3D cifs_get_inode_info(&new, full_path,
>                                                  data, sb, xid, NULL);
> @@ -1036,7 +1048,7 @@ int smb2_query_reparse_point(const unsigned int xid=
,
>                               FILE_READ_ATTRIBUTES, FILE_OPEN,
>                               OPEN_REPARSE_POINT, ACL_NO_MODE, &in_iov,
>                               &(int){SMB2_OP_GET_REPARSE}, 1,
> -                             cfile, NULL, NULL);
> +                             cfile, NULL, NULL, NULL);
>         if (rc)
>                 goto out;
>
> diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
> index b3069911e9dd..221143788a1c 100644
> --- a/fs/smb/client/smb2proto.h
> +++ b/fs/smb/client/smb2proto.h
> @@ -75,7 +75,8 @@ int smb2_query_path_info(const unsigned int xid,
>                          struct cifs_open_info_data *data);
>  extern int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *=
tcon,
>                               const char *full_path, __u64 size,
> -                             struct cifs_sb_info *cifs_sb, bool set_allo=
c);
> +                             struct cifs_sb_info *cifs_sb, bool set_allo=
c,
> +                                 struct dentry *dentry);
>  extern int smb2_set_file_info(struct inode *inode, const char *full_path=
,
>                               FILE_BASIC_INFO *buf, const unsigned int xi=
d);
>  extern int smb311_posix_mkdir(const unsigned int xid, struct inode *inod=
e,
> @@ -91,7 +92,8 @@ extern void smb2_mkdir_setinfo(struct inode *inode, con=
st char *full_path,
>  extern int smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon,
>                       const char *name, struct cifs_sb_info *cifs_sb);
>  extern int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon,
> -                      const char *name, struct cifs_sb_info *cifs_sb);
> +                      const char *name, struct cifs_sb_info *cifs_sb,
> +                          struct dentry *dentry);
>  int smb2_rename_path(const unsigned int xid,
>                      struct cifs_tcon *tcon,
>                      struct dentry *source_dentry,
> --
> 2.39.2
>

