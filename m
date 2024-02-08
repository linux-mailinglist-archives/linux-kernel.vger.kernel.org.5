Return-Path: <linux-kernel+bounces-58359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD2C784E528
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 423AB1F21A8D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA057C0AA;
	Thu,  8 Feb 2024 16:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQCPngQ9"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3FF73164;
	Thu,  8 Feb 2024 16:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707410475; cv=none; b=mb51eyhAMZz00AstxhLRD3aPTbbnzTg/zRecV7fZJGC2sIN1PIpAM53BpjI8ZCyQhC1cWmwj9AY4ZRrhmGHlrwCT4RjD98tHocknClkBhXqIETe+wv7urG5XRyydDN2dh/WXGMaIZWScNcG+thldt4X14du0NPYgePA/dVLLgJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707410475; c=relaxed/simple;
	bh=99upx2OvKz08x4ODDCpSfglp0MX3/+wADi/+EIRLQkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWXWB2nE4qALE6la5x6yXYFQnTsX9kAgiZPNVXbdKsw+olsCvcgIYX2iw0+GydUQTrmo0WRZIbr0aRjWJ6rd1FPbBNAYnd4Oo0D0ZspLOXeU63tQMZfQGQoMivOCE1sHJibWdGqIyYIF4ysDocSz5vV7O1o3+t1n/yoYFXyrFn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gQCPngQ9; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0d100336cso713031fa.2;
        Thu, 08 Feb 2024 08:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707410471; x=1708015271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXgQyc4QqV21RGZWHkg0afbuVd4wVESNNL3AHhWR3mg=;
        b=gQCPngQ96Fd0MGVhpbEkm5Cn0cUT6xKMnxzGqs0K5ASAfDVFXmNH3m6+TJjdcOFhtp
         5CGn+9/hUGm05OQIaSJOn3Yy2meuxh+MXr4/P3Dhq5nRDSHIwWXdZ13o9TW2Ku+N2Ws3
         5KKHH4i2e80y95qg0+uzp1M2CXoAx9geJ1DBd/OtgO4V5v5w8tGl2HgFHLRIrjZuuCV1
         jlJF+1jWhinMe/G3U/wOPX4wxgzcx2ShmmD1hP4L59DGBww/AvL4p1VJ6hkN8KswFeLC
         xcOzIIQjM+tVxkwAd1d8cPOtKar/3yOfp9vWZyNDblvmqLgaD0RVhKb0IVtdnp4fxEiJ
         nRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707410471; x=1708015271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cXgQyc4QqV21RGZWHkg0afbuVd4wVESNNL3AHhWR3mg=;
        b=p1JO1zg/PG1QAra+7SXU262C09szCxET+qnMaeJEJBgcKolc/50C1BGnCO6PCvR/ad
         9y1pq1QVhZXmTCaNguriTF9nXYS+dfVSXGtnxR3bQRHlQdseESiuLfz/bs1w8zx9Dx7N
         vp0bHUwiCKt1RBqeACvscskDlny0tPS/H7kb+d0Ka7EFpUYEf3nUiFMXkPQQOaA6VSHs
         Vx32ADkbmxtwbaMC9OiBK2mVSi7vY7Oh7o4Wm+XiKH/ICjQ6JPYkQyibMkSixkYIebTq
         VLE8HCWuWwkWHXOhNVEy0DOUuXqE5M5UyM40GQXM4ycZf0qqSQZ1FdrMok2BgQNiIKEO
         /9Vw==
X-Forwarded-Encrypted: i=1; AJvYcCWK+DETarrsA9AsrQ570jg2m6ZcgzRo24G+c92xGksP8veAumWI46rjwo4fPGxJc9KTkZ6YKtfOHWLaA2JnYl5ZBe5MYhBQR3qnJoTuXUODeczQnPnH6XQHOVJ/M3YsuM+5DJmT4wFbag==
X-Gm-Message-State: AOJu0YwU0xl6nxiVsZjjQa7HOShyDkrTonYSx8sjzAM0oxhKQwTydyyM
	FXhdUXLA2P2HGhqFgJgHGWsLQV++2tp2yfYDIZpINk3VUvzp/qDHqtxFG3GDrGPx1hlQsmi7X8e
	qhK0YK9OB4WgPZVh7wIju9NTqMqwsoUjJaRM=
X-Google-Smtp-Source: AGHT+IEG6/2Uae+FIWY8AXFLdzEo77r9eAOikawO8s4/Yp57o1zDl12a9H2lKvmAjH4yyEnF6ywgjMs3jfO7TCbFkQs=
X-Received: by 2002:a2e:b1c2:0:b0:2d0:a154:f38a with SMTP id
 e2-20020a2eb1c2000000b002d0a154f38amr6575566lja.47.1707410471146; Thu, 08 Feb
 2024 08:41:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202170537.409508-1-meetakshisetiyaoss@gmail.com> <CAH2r5msEtpJGTvK2F2TY0jR9hU0e7LYJekiyV1zD7MM+i9Oxgg@mail.gmail.com>
In-Reply-To: <CAH2r5msEtpJGTvK2F2TY0jR9hU0e7LYJekiyV1zD7MM+i9Oxgg@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Thu, 8 Feb 2024 22:10:59 +0530
Message-ID: <CANT5p=p8BxhPANdU=YsJiXg_s=j8COG3-VgPK0MopFeMzDUfhA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: do not defer close open handles to deleted files
To: Steve French <smfrench@gmail.com>
Cc: meetakshisetiyaoss@gmail.com, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samba-technical@lists.samba.org, 
	bharathsm.hsk@gmail.com, msetiya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 3:27=E2=80=AFAM Steve French <smfrench@gmail.com> wr=
ote:
>
> This was puzzling because I tried some experiments with deleting files
> that were deferred close and noticed that we already making sure that
> they weren't deferred close in cifs_unlink by calling
> cifs_close_deferred_file_under_dentry(tcon, full_path) even in
> Rohith's original code from a few years ago - so I didn't see cases
> where we had a file marked for delete that was deferred close.  How
> did you reproduce that problem?
>
The issue here is that other bugs are hiding this bug.
When Meetakshi fixed the missing lease key bug for deletes/renames/set
size, the tests started breaking.
But the bug definitely exists.

> On Fri, Feb 2, 2024 at 11:39=E2=80=AFAM <meetakshisetiyaoss@gmail.com> wr=
ote:
> >
> > From: Meetakshi Setiya <msetiya@microsoft.com>
> >
> > When a file/dentry has been deleted before closing all its open
> > handles, currently, closing them can add them to the deferred close
> > list. This can lead to problems in creating file with the same name
> > when the file is re-created before the deferred close completes. This
> > issue was seen while reusing a client's already existing lease on a
> > file for compound operations and xfstest 591 failed because of the
> > deferred close handle that remained valid even after the file was
> > deleted and was being reused to create a file with the same name. The
> > server in this case returns an error on open with
> > STATUS_DELETE_PENDING. Recreating the file would fail till the
> > deferred handles are closed (duration specified in closetimeo).
> >
> > This patch fixes the issue by flagging all open handles for the
> > deleted file (file path to be precise) with FILE_DELETED at the end
> > of the unlink operation. When doing close in cifs_close for each of
> > these handles, check the flag and do not defer close these handles if
> > the corresponding filepath has been deleted.
> >
> > Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> > ---
> >  fs/smb/client/cifsglob.h  |  1 +
> >  fs/smb/client/cifsproto.h |  4 ++++
> >  fs/smb/client/file.c      |  2 +-
> >  fs/smb/client/inode.c     |  2 ++
> >  fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
> >  5 files changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> > index decf80131bbe..826da216a9e1 100644
> > --- a/fs/smb/client/cifsglob.h
> > +++ b/fs/smb/client/cifsglob.h
> > @@ -1399,6 +1399,7 @@ struct cifs_fid_locks {
> >         struct list_head locks;         /* locks held by fid above */
> >  };
> >
> > +#define FILE_DELETED   0x550
> >  struct cifsFileInfo {
> >         /* following two lists are protected by tcon->open_file_lock */
> >         struct list_head tlist; /* pointer to next fid owned by tcon */
> > diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> > index 770db9026850..67f75497db02 100644
> > --- a/fs/smb/client/cifsproto.h
> > +++ b/fs/smb/client/cifsproto.h
> > @@ -292,6 +292,10 @@ extern void cifs_close_all_deferred_files(struct c=
ifs_tcon *cifs_tcon);
> >
> >  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *ci=
fs_tcon,
> >                                 const char *path);
> > +
> > +extern void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon
> > +                               *cifs_tcon, const char *path);
> > +
> >  extern struct TCP_Server_Info *
> >  cifs_get_tcp_session(struct smb3_fs_context *ctx,
> >                      struct TCP_Server_Info *primary_server);
> > diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> > index b75282c204da..4c87ddbe8a5a 100644
> > --- a/fs/smb/client/file.c
> > +++ b/fs/smb/client/file.c
> > @@ -1085,7 +1085,7 @@ int cifs_close(struct inode *inode, struct file *=
file)
> >                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=3D =
CIFS_CACHE_RHW_FLG)
> >                     && cinode->lease_granted &&
> >                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &=
&
> > -                   dclose) {
> > +                   dclose && !(cfile->f_flags & FILE_DELETED)) {
> >                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, =
&cinode->flags)) {
> >                                 inode_set_mtime_to_ts(inode,
> >                                                       inode_set_ctime_c=
urrent(inode));
> > diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> > index 24489e1e238a..be5bc01319d8 100644
> > --- a/fs/smb/client/inode.c
> > +++ b/fs/smb/client/inode.c
> > @@ -1822,6 +1822,8 @@ int cifs_unlink(struct inode *dir, struct dentry =
*dentry)
> >         cifs_inode =3D CIFS_I(dir);
> >         CIFS_I(dir)->time =3D 0;  /* force revalidate of dir as well */
> >  unlink_out:
> > +       if (rc =3D=3D 0)
> > +               cifs_mark_open_handles_for_deleted_file(tcon, full_path=
);
> >         free_dentry_path(page);
> >         kfree(attrs);
> >         free_xid(xid);
> > diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> > index 0748d7b757b9..ebc867bfc034 100644
> > --- a/fs/smb/client/misc.c
> > +++ b/fs/smb/client/misc.c
> > @@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct cifs_=
tcon *tcon, const char *path)
> >         free_dentry_path(page);
> >  }
> >
> > +/*
> > + * If a dentry has been deleted, all corresponding open handles should=
 know the
> > + * same, so that we do not defer close them.
> > + */
> > +void
> > +cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tcon, const =
char
> > +*path)
> > +{
> > +       struct cifsFileInfo *cfile;
> > +       void *page;
> > +       const char *full_path;
> > +
> > +       page =3D alloc_dentry_path();
> > +       spin_lock(&tcon->open_file_lock);
> > +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {
> > +               full_path =3D build_path_from_dentry(cfile->dentry, pag=
e);
> > +               if (strcmp(full_path, path) =3D=3D 0)
> > +                       cfile->f_flags |=3D FILE_DELETED;
> > +       }
> > +       spin_unlock(&tcon->open_file_lock);
> > +}
> > +
> >  /* parses DFS referral V3 structure
> >   * caller is responsible for freeing target_nodes
> >   * returns:
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

Hi Meetakshi,

Please fix the issue that Steve indicated in our call.
i.e. use new "flags" field for cfile, rather than f_flags. And use a
power of 2 value for FILE_DELETED.
Other than that, it looks good to me.

--=20
Regards,
Shyam

