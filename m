Return-Path: <linux-kernel+bounces-118876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A8488C08B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D410B24551
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53229548E5;
	Tue, 26 Mar 2024 11:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KVyg9r92"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F3803;
	Tue, 26 Mar 2024 11:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452201; cv=none; b=DD/fts3EkSVY6rsGHaaX/H4Gr0aREU+bR2nToVoMHqI781tmjrhupqbaq/gGrQIdTKOc1OXBwBdAHzIEm7WkX6tIurFsWRjLHqbdTB4uLvvH9O15jcgOSnc9dAokWMKgky5EAx4WRMs/WEAyfFHznPKcEJplBFpSrEgVEVEhB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452201; c=relaxed/simple;
	bh=P+JshgJbBuo+dRHr2CLKg7uxLKV640cwkW4vt5Y+9Qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RLKVT5rWqWUGQyoEcQT0dxyaV/MJfnefl+FsYbFjoTO6oj9OYwoauOTqEONL3g0OfbMZGE8ZHTMTViTlasMk9MhRqHlireNs/JVE0+Lq2dXgBkQ4lRBnV0kOhJ7McQZXMmMI+TU+E6VYo5HqH68MiunI28vr7PAdrGdQfbkBlUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KVyg9r92; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so89032141fa.1;
        Tue, 26 Mar 2024 04:23:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711452197; x=1712056997; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I4e7mgTsL7+2ckfWIbJIWKSN45SmLaOe4sFFVNaDO6M=;
        b=KVyg9r92/Zr5pcONQlNx1lwcsog1+kQYZTL1lyDawRlG8CyLy3xsaam6SqZt7w3iwN
         D76qJZBAaOmzFAIsDjPNQmmW2VrPpNAHP1JjoaqMmWyvitf8GPoKR4nslJ0AU4ljmLNX
         XjRGRl/T4pGLDw5MB/2CVZ9DI2Og8l4vnjKU2mWG6GrnmQzD3kAwtWrS3gW3pZ83DCWj
         dikQsLD5mJNtROiPyqHjt/Ao0yEqlfwicfi8JhnlrQmoGAHRM/b1R40rJxCDTgkygH7U
         UHlJGTlqq4qK0/rm7gMQB8MROaJ3us7Wa0+l76TgwSJMnPE3j3bDu6DkNWhVhnj5rIlD
         kGJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711452197; x=1712056997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I4e7mgTsL7+2ckfWIbJIWKSN45SmLaOe4sFFVNaDO6M=;
        b=MZZfvgxg2KVTXyRQwtXdD6WG/LJOKzvQNyTVp2YKIF9JCj+sz0GTcn3/SALhX9Z/H8
         E5KBmgrJr0Y/d/IOVPd9is2fXFjyly2RCIjq8BEC6demjil/EZPSyiDgERACFv681K7e
         iuozTFxsK2OTKTLv4fwuAQUmx459USUb4+kQBsdyir5BfzXIww8+/FCIzhpOpkVwH2Ud
         FOuTNhlBdPb7WxMAlWaytIxtHDWtLtlZ8hTx0uGwrmoxkrV+Vtqs7yUYWffUiB0xnzd9
         /phNSjOecL+y8EsvkLUsR7cthEGGF+IqBBmv9Ybkjvtoi2O8VutPVk4Kp190O5lAp4Hm
         5XoA==
X-Forwarded-Encrypted: i=1; AJvYcCW0cyQl45bu0hORvSbztE8JtJaot1H3H73Nr+DDOZQed7d8cgYDwNxZsu5umLyxmTzOIIJFE4aURGFDYo+mJo2J5u8AzJZTdb53Y+FKttHmnApAwKCDZH8ePHfunulSoiV+7TK1zatnzQ==
X-Gm-Message-State: AOJu0Yx6sI8SvQjd8oH/OnisFQT2XiRt+4yXwZ4xithJH5PaJyuJxVY4
	1eJOUYVEm6bYFcBgvOq9oJSarcDjhmQoTCXx1hfbb7J/lg+XIm5e2+rIob7SBw0EdiFhV5M+NaH
	D5MlrdvzYLES5Zf4UFEu+vRAbt7Mc/NB3
X-Google-Smtp-Source: AGHT+IFUSRsM4MLdefKGwwWIzQlDG5G8x0JZ2q8dpjo+CixQLAXFujI2bvaXRzMfsj6ULgyyvLKNQe7BBU5LOAiKp60=
X-Received: by 2002:a05:651c:10cc:b0:2d6:f05f:cb39 with SMTP id
 l12-20020a05651c10cc00b002d6f05fcb39mr453978ljn.49.1711452196655; Tue, 26 Mar
 2024 04:23:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfQC6Xk+E6HtCtsI@rbudubuntu.daqjip3ntomehmqy3wvpaa3zyf.bx.internal.cloudapp.net>
 <CA+EPQ67TC27FTmN30QRHji61ymrD=0y-NZ_CHOi7tAq2qcFWQw@mail.gmail.com>
 <CAH2r5mt1X3wp89FLUN_VEzA1kCQmu8x8bVAyi0cdG7-b2V=Bmw@mail.gmail.com> <0a4cf834-c102-4497-a5dc-2bb44d6083f1@talpey.com>
In-Reply-To: <0a4cf834-c102-4497-a5dc-2bb44d6083f1@talpey.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 26 Mar 2024 16:53:04 +0530
Message-ID: <CANT5p=pKUoiBi6Fq=erqXNS2HW30qNRPt=WJnDG=tQOz8H2qtA@mail.gmail.com>
Subject: Re: [PATCH] Retrying on failed server close
To: Tom Talpey <tom@talpey.com>
Cc: Steve French <smfrench@gmail.com>, Ritvik Budhiraja <budhirajaritviksmb@gmail.com>, sfrench@samba.org, 
	pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, bharathsm.hsk@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 11:47=E2=80=AFPM Tom Talpey <tom@talpey.com> wrote:
>
> [resending as plain text stupid phone]
>
> Aren't these local errors, triggered by failure to send the close? Server=
s can fail the close too of course, which should also be retried, if approp=
riate to the error.
>
> Tom.
>

I agree. I think we should retry all errors a finite number of times,
unless we know that it is a known non-retryable error.

> Mar 22, 2024 10:50:10 AM Steve French <smfrench@gmail.com>:
>
> > Do you know a repro scenario where you can get the server to return
> > EAGAIN or EBUSY?
> >
> > SInce close is also issued from other paths than the one you issued
> > retries from (_cifsFileInfo_put) - are there other cases we should be
> > retrying?  e.g. error paths in do_create and atomic_open, cifs_open,
> > cifs_close_dir, find_cifs_entry
> >
> > Also do you know a scenario where we can repro the negative total open
> > files count?
> >
> > On Fri, Mar 22, 2024 at 2:33=E2=80=AFAM Ritvik Budhiraja
> > <budhirajaritviksmb@gmail.com> wrote:
> >>
> >> Attaching the updated patch
> >>
> >>
> >> On Fri, 15 Mar 2024 at 01:12, Ritvik Budhiraja <budhirajaritviksmb@gma=
il.com> wrote:
> >>>
> >>> In the current implementation, CIFS close sends a close to the server
> >>> and does not check for the success of the server close. This patch ad=
ds
> >>> functionality to check for server close return status and retries
> >>> in case of an EBUSY or EAGAIN error
> >>>
> >>> Signed-off-by: Ritvik Budhiraja <rbudhiraja@microsoft.com>
> >>> ---
> >>> fs/smb/client/cifsfs.c   | 11 +++++++
> >>> fs/smb/client/cifsglob.h |  7 +++--
> >>> fs/smb/client/file.c     | 63 ++++++++++++++++++++++++++++++++++++---=
-
> >>> fs/smb/client/smb1ops.c  |  4 +--
> >>> fs/smb/client/smb2ops.c  |  9 +++---
> >>> 5 files changed, 80 insertions(+), 14 deletions(-)
> >>>
> >>> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> >>> index fb368b191eef..e4b2ded86fce 100644
> >>> --- a/fs/smb/client/cifsfs.c
> >>> +++ b/fs/smb/client/cifsfs.c
> >>> @@ -160,6 +160,7 @@ struct workqueue_struct     *decrypt_wq;
> >>> struct workqueue_struct        *fileinfo_put_wq;
> >>> struct workqueue_struct        *cifsoplockd_wq;
> >>> struct workqueue_struct        *deferredclose_wq;
> >>> +struct workqueue_struct        *serverclose_wq;
> >>> __u32 cifs_lock_secret;
> >>>
> >>> /*
> >>> @@ -1890,6 +1891,13 @@ init_cifs(void)
> >>>                 goto out_destroy_cifsoplockd_wq;
> >>>         }
> >>>
> >>> +       serverclose_wq =3D alloc_workqueue("serverclose",
> >>> +                                          WQ_FREEZABLE|WQ_MEM_RECLAI=
M, 0);
> >>> +       if (!serverclose_wq) {
> >>> +               rc =3D -ENOMEM;
> >>> +               goto out_destroy_serverclose_wq;
> >>> +       }
> >>> +
> >>>         rc =3D cifs_init_inodecache();
> >>>         if (rc)
> >>>                 goto out_destroy_deferredclose_wq;
> >>> @@ -1964,6 +1972,8 @@ init_cifs(void)
> >>>         destroy_workqueue(decrypt_wq);
> >>> out_destroy_cifsiod_wq:
> >>>         destroy_workqueue(cifsiod_wq);
> >>> +out_destroy_serverclose_wq:
> >>> +       destroy_workqueue(serverclose_wq);
> >>> out_clean_proc:
> >>>         cifs_proc_clean();
> >>>         return rc;
> >>> @@ -1993,6 +2003,7 @@ exit_cifs(void)
> >>>         destroy_workqueue(cifsoplockd_wq);
> >>>         destroy_workqueue(decrypt_wq);
> >>>         destroy_workqueue(fileinfo_put_wq);
> >>> +       destroy_workqueue(serverclose_wq);
> >>>         destroy_workqueue(cifsiod_wq);
> >>>         cifs_proc_clean();
> >>> }
> >>> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> >>> index 53c75cfb33ab..c99bc3b3ff56 100644
> >>> --- a/fs/smb/client/cifsglob.h
> >>> +++ b/fs/smb/client/cifsglob.h
> >>> @@ -429,10 +429,10 @@ struct smb_version_operations {
> >>>         /* set fid protocol-specific info */
> >>>         void (*set_fid)(struct cifsFileInfo *, struct cifs_fid *, __u=
32);
> >>>         /* close a file */
> >>> -       void (*close)(const unsigned int, struct cifs_tcon *,
> >>> +       int (*close)(const unsigned int, struct cifs_tcon *,
> >>>                       struct cifs_fid *);
> >>>         /* close a file, returning file attributes and timestamps */
> >>> -       void (*close_getattr)(const unsigned int xid, struct cifs_tco=
n *tcon,
> >>> +       int (*close_getattr)(const unsigned int xid, struct cifs_tcon=
 *tcon,
> >>>                       struct cifsFileInfo *pfile_info);
> >>>         /* send a flush request to the server */
> >>>         int (*flush)(const unsigned int, struct cifs_tcon *, struct c=
ifs_fid *);
> >>> @@ -1420,6 +1420,7 @@ struct cifsFileInfo {
> >>>         bool invalidHandle:1;   /* file closed via session abend */
> >>>         bool swapfile:1;
> >>>         bool oplock_break_cancelled:1;
> >>> +       bool offload:1; /* offload final part of _put to a wq */
> >>>         unsigned int oplock_epoch; /* epoch from the lease break */
> >>>         __u32 oplock_level; /* oplock/lease level from the lease brea=
k */
> >>>         int count;
> >>> @@ -1428,6 +1429,7 @@ struct cifsFileInfo {
> >>>         struct cifs_search_info srch_inf;
> >>>         struct work_struct oplock_break; /* work for oplock breaks */
> >>>         struct work_struct put; /* work for the final part of _put */
> >>> +       struct work_struct serverclose; /* work for serverclose */
> >>>         struct delayed_work deferred;
> >>>         bool deferred_close_scheduled; /* Flag to indicate close is s=
cheduled */
> >>>         char *symlink_target;
> >>> @@ -2085,6 +2087,7 @@ extern struct workqueue_struct *decrypt_wq;
> >>> extern struct workqueue_struct *fileinfo_put_wq;
> >>> extern struct workqueue_struct *cifsoplockd_wq;
> >>> extern struct workqueue_struct *deferredclose_wq;
> >>> +extern struct workqueue_struct *serverclose_wq;
> >>> extern __u32 cifs_lock_secret;
> >>>
> >>> extern mempool_t *cifs_mid_poolp;
> >>> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> >>> index c3b8e7091a4d..c1379ec27dcd 100644
> >>> --- a/fs/smb/client/file.c
> >>> +++ b/fs/smb/client/file.c
> >>> @@ -445,6 +445,7 @@ cifs_down_write(struct rw_semaphore *sem)
> >>> }
> >>>
> >>> static void cifsFileInfo_put_work(struct work_struct *work);
> >>> +void serverclose_work(struct work_struct *work);
> >>>
> >>> struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct f=
ile *file,
> >>>                                        struct tcon_link *tlink, __u32=
 oplock,
> >>> @@ -491,6 +492,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cif=
s_fid *fid, struct file *file,
> >>>         cfile->tlink =3D cifs_get_tlink(tlink);
> >>>         INIT_WORK(&cfile->oplock_break, cifs_oplock_break);
> >>>         INIT_WORK(&cfile->put, cifsFileInfo_put_work);
> >>> +       INIT_WORK(&cfile->serverclose, serverclose_work);
> >>>         INIT_DELAYED_WORK(&cfile->deferred, smb2_deferred_work_close)=
;
> >>>         mutex_init(&cfile->fh_mutex);
> >>>         spin_lock_init(&cfile->file_info_lock);
> >>> @@ -582,6 +584,40 @@ static void cifsFileInfo_put_work(struct work_st=
ruct *work)
> >>>         cifsFileInfo_put_final(cifs_file);
> >>> }
> >>>
> >>> +void serverclose_work(struct work_struct *work)
> >>> +{
> >>> +       struct cifsFileInfo *cifs_file =3D container_of(work,
> >>> +                       struct cifsFileInfo, serverclose);
> >>> +
> >>> +       struct cifs_tcon *tcon =3D tlink_tcon(cifs_file->tlink);
> >>> +
> >>> +       struct TCP_Server_Info *server =3D tcon->ses->server;
> >>> +       int rc;
> >>> +       int retries =3D 0;
> >>> +       int MAX_RETRIES =3D 4;
> >>> +
> >>> +       do {
> >>> +               if (server->ops->close_getattr)
> >>> +                       rc =3D server->ops->close_getattr(0, tcon, ci=
fs_file);
> >>> +               else if (server->ops->close)
> >>> +                       rc =3D server->ops->close(0, tcon, &cifs_file=
->fid);
> >>> +
> >>> +               if (rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) {
> >>> +                       retries++;
> >>> +                       msleep(250);
> >>> +               }
> >>> +       } while ((rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) && (retries =
< MAX_RETRIES)
> >>> +       );
> >>> +
> >>> +       if (retries =3D=3D MAX_RETRIES)
> >>> +               printk(KERN_WARNING "[CIFS_CLOSE] Serverclose failed =
%d times, giving up\n", MAX_RETRIES);
> >>> +
> >>> +       if (cifs_file->offload)
> >>> +               queue_work(fileinfo_put_wq, &cifs_file->put);
> >>> +       else
> >>> +               cifsFileInfo_put_final(cifs_file);
> >>> +}
> >>> +
> >>> /**
> >>>   * cifsFileInfo_put - release a reference of file priv data
> >>>   *
> >>> @@ -622,10 +658,13 @@ void _cifsFileInfo_put(struct cifsFileInfo *cif=
s_file,
> >>>         struct cifs_fid fid =3D {};
> >>>         struct cifs_pending_open open;
> >>>         bool oplock_break_cancelled;
> >>> +       bool serverclose_offloaded =3D false;
> >>>
> >>>         spin_lock(&tcon->open_file_lock);
> >>>         spin_lock(&cifsi->open_file_lock);
> >>>         spin_lock(&cifs_file->file_info_lock);
> >>> +
> >>> +       cifs_file->offload =3D offload;
> >>>         if (--cifs_file->count > 0) {
> >>>                 spin_unlock(&cifs_file->file_info_lock);
> >>>                 spin_unlock(&cifsi->open_file_lock);
> >>> @@ -667,13 +706,20 @@ void _cifsFileInfo_put(struct cifsFileInfo *cif=
s_file,
> >>>         if (!tcon->need_reconnect && !cifs_file->invalidHandle) {
> >>>                 struct TCP_Server_Info *server =3D tcon->ses->server;
> >>>                 unsigned int xid;
> >>> +               int rc;
> >>>
> >>>                 xid =3D get_xid();
> >>>                 if (server->ops->close_getattr)
> >>> -                       server->ops->close_getattr(xid, tcon, cifs_fi=
le);
> >>> +                       rc =3D server->ops->close_getattr(xid, tcon, =
cifs_file);
> >>>                 else if (server->ops->close)
> >>> -                       server->ops->close(xid, tcon, &cifs_file->fid=
);
> >>> +                       rc =3D server->ops->close(xid, tcon, &cifs_fi=
le->fid);
> >>>                 _free_xid(xid);
> >>> +
> >>> +               if (rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) {
> >>> +                       // Server close failed, hence offloading it a=
s an async op
> >>> +                       queue_work(serverclose_wq, &cifs_file->server=
close);
> >>> +                       serverclose_offloaded =3D true;
> >>> +               }
> >>>         }
> >>>
> >>>         if (oplock_break_cancelled)
> >>> @@ -681,10 +727,15 @@ void _cifsFileInfo_put(struct cifsFileInfo *cif=
s_file,
> >>>
> >>>         cifs_del_pending_open(&open);
> >>>
> >>> -       if (offload)
> >>> -               queue_work(fileinfo_put_wq, &cifs_file->put);
> >>> -       else
> >>> -               cifsFileInfo_put_final(cifs_file);
> >>> +       // if serverclose has been offloaded to wq (on failure), it w=
ill
> >>> +       // handle offloading put as well. If serverclose not offloade=
d,
> >>> +       // we need to handle offloading put here.
> >>> +       if (!serverclose_offloaded) {
> >>> +               if (offload)
> >>> +                       queue_work(fileinfo_put_wq, &cifs_file->put);
> >>> +               else
> >>> +                       cifsFileInfo_put_final(cifs_file);
> >>> +       }
> >>> }
> >>>
> >>> int cifs_open(struct inode *inode, struct file *file)
> >>> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
> >>> index a9eaba8083b0..212ec6f66ec6 100644
> >>> --- a/fs/smb/client/smb1ops.c
> >>> +++ b/fs/smb/client/smb1ops.c
> >>> @@ -753,11 +753,11 @@ cifs_set_fid(struct cifsFileInfo *cfile, struct=
 cifs_fid *fid, __u32 oplock)
> >>>         cinode->can_cache_brlcks =3D CIFS_CACHE_WRITE(cinode);
> >>> }
> >>>
> >>> -static void
> >>> +static int
> >>> cifs_close_file(const unsigned int xid, struct cifs_tcon *tcon,
> >>>                 struct cifs_fid *fid)
> >>> {
> >>> -       CIFSSMBClose(xid, tcon, fid->netfid);
> >>> +       return CIFSSMBClose(xid, tcon, fid->netfid);
> >>> }
> >>>
> >>> static int
> >>> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> >>> index 4695433fcf39..1dcd4944958f 100644
> >>> --- a/fs/smb/client/smb2ops.c
> >>> +++ b/fs/smb/client/smb2ops.c
> >>> @@ -1411,14 +1411,14 @@ smb2_set_fid(struct cifsFileInfo *cfile, stru=
ct cifs_fid *fid, __u32 oplock)
> >>>         memcpy(cfile->fid.create_guid, fid->create_guid, 16);
> >>> }
> >>>
> >>> -static void
> >>> +static int
> >>> smb2_close_file(const unsigned int xid, struct cifs_tcon *tcon,
> >>>                 struct cifs_fid *fid)
> >>> {
> >>> -       SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_fid)=
;
> >>> +       return SMB2_close(xid, tcon, fid->persistent_fid, fid->volati=
le_fid);
> >>> }
> >>>
> >>> -static void
> >>> +static int
> >>> smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
> >>>                    struct cifsFileInfo *cfile)
> >>> {
> >>> @@ -1429,7 +1429,7 @@ smb2_close_getattr(const unsigned int xid, stru=
ct cifs_tcon *tcon,
> >>>         rc =3D __SMB2_close(xid, tcon, cfile->fid.persistent_fid,
> >>>                    cfile->fid.volatile_fid, &file_inf);
> >>>         if (rc)
> >>> -               return;
> >>> +               return rc;
> >>>
> >>>         inode =3D d_inode(cfile->dentry);
> >>>
> >>> @@ -1458,6 +1458,7 @@ smb2_close_getattr(const unsigned int xid, stru=
ct cifs_tcon *tcon,
> >>>
> >>>         /* End of file and Attributes should not have to be updated o=
n close */
> >>>         spin_unlock(&inode->i_lock);
> >>> +       return rc;
> >>> }
> >>>
> >>> static int
> >>> --
> >>> 2.34.1
> >>>
> >
> >
> > --
> > Thanks,
> >
> > Steve
>


--=20
Regards,
Shyam

