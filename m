Return-Path: <linux-kernel+bounces-111647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A2D886F00
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BE21C2094F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037B5482F6;
	Fri, 22 Mar 2024 14:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZHoA7y2"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD5482C1;
	Fri, 22 Mar 2024 14:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711118860; cv=none; b=en/L1tudRpL+dk2tJgqfKxS+qCNDtOFd3RSNSWKSLJgUMlMhg79Dy+6CV1KN6ZB4O/oc4J4u6s0I5QZBINmIucCzyF8Ejpiz4LUahJkPeyu4ebVSohF6gdSq48DbXhMM7l5VCbqLBvphFlazYBahLt5bCm4KNq0he69o3Cul/sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711118860; c=relaxed/simple;
	bh=JJzavrnAmK0BpI+tzYrxsVu+js63yWmPtYgY2ryHQ68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LaMz582zWEg5NUWr0Hc8Rc+Qbl6LhTb++maUFAuVQZg9RKdtqz09IPuIfNIMLKTB0IRv2lp11OyPxYBvT4kq9hRk+bYvKqDX+kcbMgiq76amxw4ODYyNQsv1f8cv3mxNFfcwYpZOwmKiEZ4JfMbpGadcd1lxSdx4f8Z04xZgw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZHoA7y2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4541bf57eso29935991fa.2;
        Fri, 22 Mar 2024 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711118857; x=1711723657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2dzRd2+RISoYKGE/ucShUTjhAS+0hbTNEpYIAQNB4E4=;
        b=gZHoA7y23f7jagVDI9ZG9jELOEEfEBive2UoSYw4HHkas3yK2Q3T3FBAEDu2UaqSYl
         n0EjRi2XZWHQ9Q0IJdt2nZN4PxXDeRCmTA1bBS70I+/zSk95ytke5sPlDJmXFi2jA2d3
         4WKHd6lLDLaQAfnjX4vfii6SkO1N7qXkAUPhPXp7nXLo5Z1t7+yYQtdNz68lfRuNddo1
         rAzZ7vMLUXVkUosdNRdb3m72yq9mpdA0b+hVvUhDzbImyk0U3VhGJO2MbDBQdtvDsbFW
         YPNOrdM9vnha1WfYm/4Uv/FxQ1c/D+QZnGftZ8iB2LLgLn51YFXAOP16Vu/dt8wwGsNC
         eCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711118857; x=1711723657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2dzRd2+RISoYKGE/ucShUTjhAS+0hbTNEpYIAQNB4E4=;
        b=P8mcZgBPJzHpCfs6pmIsX1+13k2h7U1HUN1XbLiX1+zyrdffgPMeMXi1gKTUYtIE0s
         afNK8w293KDhf1dvCH53x3lUN5Wy/uCVqtdrozu8f0HiVGSGLTejIHDhovj+e6jHIo11
         rDPhlOJm893xH+xYzoNS6q2C4vafj15h8E518pkyAMqRsLDAtuffBA2DEXe7h0/WOA5q
         2kcmOWBsY2cqmy+mYyF4hYDlEJEfyBwc3p95vnfkDY8G3qnCXOGjAOqE0V9Qaq77/2/R
         mIvEeuZIkmhw9OuFovC0XUcFqh8Kp7lBZ1klb4h8SXL1EHoYNwkNlIOm7L3d6SkLPMIb
         vVYA==
X-Forwarded-Encrypted: i=1; AJvYcCUw6RxGtxdv7lqBRliMT1cTO5a6VJXcSIxFjKdFMDYdZq9NvYa4N4XCAfWQSsV+EYjbOQMJ3flliflSxkyLuSCeaH8KQOhNeiscLVQgNpKtbwy3ggYnf8pB2B9zomHd7PzFJcx+HwUjTQ==
X-Gm-Message-State: AOJu0Yw2wUpixUIsoIdB1KomHzAjaWEc7dMBG3Y/aT4liZBbqixEZiF0
	c/Pdvfn/160EG7Xd4Iu30XkqK7fTOZpc74v3v+O8BfXXIUTrMmnRv2LOQ+1oMRtDJ4DH3zTscpz
	z9ZRC+UtQPrON5Jr8fPYc06KDTsM=
X-Google-Smtp-Source: AGHT+IE6kfa9YMuN0JLgk2024WMR8YCUyZkuq3KGPuHXRbYND0bWpu4iaMpWZht1hbVvWpIk8jbapPctesc+ZqoG5NI=
X-Received: by 2002:ac2:4d82:0:b0:513:d8b4:90be with SMTP id
 g2-20020ac24d82000000b00513d8b490bemr1756823lfe.24.1711118856514; Fri, 22 Mar
 2024 07:47:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfQC6Xk+E6HtCtsI@rbudubuntu.daqjip3ntomehmqy3wvpaa3zyf.bx.internal.cloudapp.net>
 <CA+EPQ67TC27FTmN30QRHji61ymrD=0y-NZ_CHOi7tAq2qcFWQw@mail.gmail.com>
In-Reply-To: <CA+EPQ67TC27FTmN30QRHji61ymrD=0y-NZ_CHOi7tAq2qcFWQw@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 22 Mar 2024 09:47:24 -0500
Message-ID: <CAH2r5mt1X3wp89FLUN_VEzA1kCQmu8x8bVAyi0cdG7-b2V=Bmw@mail.gmail.com>
Subject: Re: [PATCH] Retrying on failed server close
To: Ritvik Budhiraja <budhirajaritviksmb@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	bharathsm.hsk@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Do you know a repro scenario where you can get the server to return
EAGAIN or EBUSY?

SInce close is also issued from other paths than the one you issued
retries from (_cifsFileInfo_put) - are there other cases we should be
retrying?  e.g. error paths in do_create and atomic_open, cifs_open,
cifs_close_dir, find_cifs_entry

Also do you know a scenario where we can repro the negative total open
files count?

On Fri, Mar 22, 2024 at 2:33=E2=80=AFAM Ritvik Budhiraja
<budhirajaritviksmb@gmail.com> wrote:
>
> Attaching the updated patch
>
>
> On Fri, 15 Mar 2024 at 01:12, Ritvik Budhiraja <budhirajaritviksmb@gmail.=
com> wrote:
>>
>> In the current implementation, CIFS close sends a close to the server
>> and does not check for the success of the server close. This patch adds
>> functionality to check for server close return status and retries
>> in case of an EBUSY or EAGAIN error
>>
>> Signed-off-by: Ritvik Budhiraja <rbudhiraja@microsoft.com>
>> ---
>>  fs/smb/client/cifsfs.c   | 11 +++++++
>>  fs/smb/client/cifsglob.h |  7 +++--
>>  fs/smb/client/file.c     | 63 ++++++++++++++++++++++++++++++++++++----
>>  fs/smb/client/smb1ops.c  |  4 +--
>>  fs/smb/client/smb2ops.c  |  9 +++---
>>  5 files changed, 80 insertions(+), 14 deletions(-)
>>
>> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
>> index fb368b191eef..e4b2ded86fce 100644
>> --- a/fs/smb/client/cifsfs.c
>> +++ b/fs/smb/client/cifsfs.c
>> @@ -160,6 +160,7 @@ struct workqueue_struct     *decrypt_wq;
>>  struct workqueue_struct        *fileinfo_put_wq;
>>  struct workqueue_struct        *cifsoplockd_wq;
>>  struct workqueue_struct        *deferredclose_wq;
>> +struct workqueue_struct        *serverclose_wq;
>>  __u32 cifs_lock_secret;
>>
>>  /*
>> @@ -1890,6 +1891,13 @@ init_cifs(void)
>>                 goto out_destroy_cifsoplockd_wq;
>>         }
>>
>> +       serverclose_wq =3D alloc_workqueue("serverclose",
>> +                                          WQ_FREEZABLE|WQ_MEM_RECLAIM, =
0);
>> +       if (!serverclose_wq) {
>> +               rc =3D -ENOMEM;
>> +               goto out_destroy_serverclose_wq;
>> +       }
>> +
>>         rc =3D cifs_init_inodecache();
>>         if (rc)
>>                 goto out_destroy_deferredclose_wq;
>> @@ -1964,6 +1972,8 @@ init_cifs(void)
>>         destroy_workqueue(decrypt_wq);
>>  out_destroy_cifsiod_wq:
>>         destroy_workqueue(cifsiod_wq);
>> +out_destroy_serverclose_wq:
>> +       destroy_workqueue(serverclose_wq);
>>  out_clean_proc:
>>         cifs_proc_clean();
>>         return rc;
>> @@ -1993,6 +2003,7 @@ exit_cifs(void)
>>         destroy_workqueue(cifsoplockd_wq);
>>         destroy_workqueue(decrypt_wq);
>>         destroy_workqueue(fileinfo_put_wq);
>> +       destroy_workqueue(serverclose_wq);
>>         destroy_workqueue(cifsiod_wq);
>>         cifs_proc_clean();
>>  }
>> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
>> index 53c75cfb33ab..c99bc3b3ff56 100644
>> --- a/fs/smb/client/cifsglob.h
>> +++ b/fs/smb/client/cifsglob.h
>> @@ -429,10 +429,10 @@ struct smb_version_operations {
>>         /* set fid protocol-specific info */
>>         void (*set_fid)(struct cifsFileInfo *, struct cifs_fid *, __u32)=
;
>>         /* close a file */
>> -       void (*close)(const unsigned int, struct cifs_tcon *,
>> +       int (*close)(const unsigned int, struct cifs_tcon *,
>>                       struct cifs_fid *);
>>         /* close a file, returning file attributes and timestamps */
>> -       void (*close_getattr)(const unsigned int xid, struct cifs_tcon *=
tcon,
>> +       int (*close_getattr)(const unsigned int xid, struct cifs_tcon *t=
con,
>>                       struct cifsFileInfo *pfile_info);
>>         /* send a flush request to the server */
>>         int (*flush)(const unsigned int, struct cifs_tcon *, struct cifs=
_fid *);
>> @@ -1420,6 +1420,7 @@ struct cifsFileInfo {
>>         bool invalidHandle:1;   /* file closed via session abend */
>>         bool swapfile:1;
>>         bool oplock_break_cancelled:1;
>> +       bool offload:1; /* offload final part of _put to a wq */
>>         unsigned int oplock_epoch; /* epoch from the lease break */
>>         __u32 oplock_level; /* oplock/lease level from the lease break *=
/
>>         int count;
>> @@ -1428,6 +1429,7 @@ struct cifsFileInfo {
>>         struct cifs_search_info srch_inf;
>>         struct work_struct oplock_break; /* work for oplock breaks */
>>         struct work_struct put; /* work for the final part of _put */
>> +       struct work_struct serverclose; /* work for serverclose */
>>         struct delayed_work deferred;
>>         bool deferred_close_scheduled; /* Flag to indicate close is sche=
duled */
>>         char *symlink_target;
>> @@ -2085,6 +2087,7 @@ extern struct workqueue_struct *decrypt_wq;
>>  extern struct workqueue_struct *fileinfo_put_wq;
>>  extern struct workqueue_struct *cifsoplockd_wq;
>>  extern struct workqueue_struct *deferredclose_wq;
>> +extern struct workqueue_struct *serverclose_wq;
>>  extern __u32 cifs_lock_secret;
>>
>>  extern mempool_t *cifs_mid_poolp;
>> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
>> index c3b8e7091a4d..c1379ec27dcd 100644
>> --- a/fs/smb/client/file.c
>> +++ b/fs/smb/client/file.c
>> @@ -445,6 +445,7 @@ cifs_down_write(struct rw_semaphore *sem)
>>  }
>>
>>  static void cifsFileInfo_put_work(struct work_struct *work);
>> +void serverclose_work(struct work_struct *work);
>>
>>  struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct fil=
e *file,
>>                                        struct tcon_link *tlink, __u32 op=
lock,
>> @@ -491,6 +492,7 @@ struct cifsFileInfo *cifs_new_fileinfo(struct cifs_f=
id *fid, struct file *file,
>>         cfile->tlink =3D cifs_get_tlink(tlink);
>>         INIT_WORK(&cfile->oplock_break, cifs_oplock_break);
>>         INIT_WORK(&cfile->put, cifsFileInfo_put_work);
>> +       INIT_WORK(&cfile->serverclose, serverclose_work);
>>         INIT_DELAYED_WORK(&cfile->deferred, smb2_deferred_work_close);
>>         mutex_init(&cfile->fh_mutex);
>>         spin_lock_init(&cfile->file_info_lock);
>> @@ -582,6 +584,40 @@ static void cifsFileInfo_put_work(struct work_struc=
t *work)
>>         cifsFileInfo_put_final(cifs_file);
>>  }
>>
>> +void serverclose_work(struct work_struct *work)
>> +{
>> +       struct cifsFileInfo *cifs_file =3D container_of(work,
>> +                       struct cifsFileInfo, serverclose);
>> +
>> +       struct cifs_tcon *tcon =3D tlink_tcon(cifs_file->tlink);
>> +
>> +       struct TCP_Server_Info *server =3D tcon->ses->server;
>> +       int rc;
>> +       int retries =3D 0;
>> +       int MAX_RETRIES =3D 4;
>> +
>> +       do {
>> +               if (server->ops->close_getattr)
>> +                       rc =3D server->ops->close_getattr(0, tcon, cifs_=
file);
>> +               else if (server->ops->close)
>> +                       rc =3D server->ops->close(0, tcon, &cifs_file->f=
id);
>> +
>> +               if (rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) {
>> +                       retries++;
>> +                       msleep(250);
>> +               }
>> +       } while ((rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) && (retries < M=
AX_RETRIES)
>> +       );
>> +
>> +       if (retries =3D=3D MAX_RETRIES)
>> +               printk(KERN_WARNING "[CIFS_CLOSE] Serverclose failed %d =
times, giving up\n", MAX_RETRIES);
>> +
>> +       if (cifs_file->offload)
>> +               queue_work(fileinfo_put_wq, &cifs_file->put);
>> +       else
>> +               cifsFileInfo_put_final(cifs_file);
>> +}
>> +
>>  /**
>>   * cifsFileInfo_put - release a reference of file priv data
>>   *
>> @@ -622,10 +658,13 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_f=
ile,
>>         struct cifs_fid fid =3D {};
>>         struct cifs_pending_open open;
>>         bool oplock_break_cancelled;
>> +       bool serverclose_offloaded =3D false;
>>
>>         spin_lock(&tcon->open_file_lock);
>>         spin_lock(&cifsi->open_file_lock);
>>         spin_lock(&cifs_file->file_info_lock);
>> +
>> +       cifs_file->offload =3D offload;
>>         if (--cifs_file->count > 0) {
>>                 spin_unlock(&cifs_file->file_info_lock);
>>                 spin_unlock(&cifsi->open_file_lock);
>> @@ -667,13 +706,20 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_f=
ile,
>>         if (!tcon->need_reconnect && !cifs_file->invalidHandle) {
>>                 struct TCP_Server_Info *server =3D tcon->ses->server;
>>                 unsigned int xid;
>> +               int rc;
>>
>>                 xid =3D get_xid();
>>                 if (server->ops->close_getattr)
>> -                       server->ops->close_getattr(xid, tcon, cifs_file)=
;
>> +                       rc =3D server->ops->close_getattr(xid, tcon, cif=
s_file);
>>                 else if (server->ops->close)
>> -                       server->ops->close(xid, tcon, &cifs_file->fid);
>> +                       rc =3D server->ops->close(xid, tcon, &cifs_file-=
>fid);
>>                 _free_xid(xid);
>> +
>> +               if (rc =3D=3D -EBUSY || rc =3D=3D -EAGAIN) {
>> +                       // Server close failed, hence offloading it as a=
n async op
>> +                       queue_work(serverclose_wq, &cifs_file->serverclo=
se);
>> +                       serverclose_offloaded =3D true;
>> +               }
>>         }
>>
>>         if (oplock_break_cancelled)
>> @@ -681,10 +727,15 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_f=
ile,
>>
>>         cifs_del_pending_open(&open);
>>
>> -       if (offload)
>> -               queue_work(fileinfo_put_wq, &cifs_file->put);
>> -       else
>> -               cifsFileInfo_put_final(cifs_file);
>> +       // if serverclose has been offloaded to wq (on failure), it will
>> +       // handle offloading put as well. If serverclose not offloaded,
>> +       // we need to handle offloading put here.
>> +       if (!serverclose_offloaded) {
>> +               if (offload)
>> +                       queue_work(fileinfo_put_wq, &cifs_file->put);
>> +               else
>> +                       cifsFileInfo_put_final(cifs_file);
>> +       }
>>  }
>>
>>  int cifs_open(struct inode *inode, struct file *file)
>> diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
>> index a9eaba8083b0..212ec6f66ec6 100644
>> --- a/fs/smb/client/smb1ops.c
>> +++ b/fs/smb/client/smb1ops.c
>> @@ -753,11 +753,11 @@ cifs_set_fid(struct cifsFileInfo *cfile, struct ci=
fs_fid *fid, __u32 oplock)
>>         cinode->can_cache_brlcks =3D CIFS_CACHE_WRITE(cinode);
>>  }
>>
>> -static void
>> +static int
>>  cifs_close_file(const unsigned int xid, struct cifs_tcon *tcon,
>>                 struct cifs_fid *fid)
>>  {
>> -       CIFSSMBClose(xid, tcon, fid->netfid);
>> +       return CIFSSMBClose(xid, tcon, fid->netfid);
>>  }
>>
>>  static int
>> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
>> index 4695433fcf39..1dcd4944958f 100644
>> --- a/fs/smb/client/smb2ops.c
>> +++ b/fs/smb/client/smb2ops.c
>> @@ -1411,14 +1411,14 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct =
cifs_fid *fid, __u32 oplock)
>>         memcpy(cfile->fid.create_guid, fid->create_guid, 16);
>>  }
>>
>> -static void
>> +static int
>>  smb2_close_file(const unsigned int xid, struct cifs_tcon *tcon,
>>                 struct cifs_fid *fid)
>>  {
>> -       SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_fid);
>> +       return SMB2_close(xid, tcon, fid->persistent_fid, fid->volatile_=
fid);
>>  }
>>
>> -static void
>> +static int
>>  smb2_close_getattr(const unsigned int xid, struct cifs_tcon *tcon,
>>                    struct cifsFileInfo *cfile)
>>  {
>> @@ -1429,7 +1429,7 @@ smb2_close_getattr(const unsigned int xid, struct =
cifs_tcon *tcon,
>>         rc =3D __SMB2_close(xid, tcon, cfile->fid.persistent_fid,
>>                    cfile->fid.volatile_fid, &file_inf);
>>         if (rc)
>> -               return;
>> +               return rc;
>>
>>         inode =3D d_inode(cfile->dentry);
>>
>> @@ -1458,6 +1458,7 @@ smb2_close_getattr(const unsigned int xid, struct =
cifs_tcon *tcon,
>>
>>         /* End of file and Attributes should not have to be updated on c=
lose */
>>         spin_unlock(&inode->i_lock);
>> +       return rc;
>>  }
>>
>>  static int
>> --
>> 2.34.1
>>


--=20
Thanks,

Steve

