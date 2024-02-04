Return-Path: <linux-kernel+bounces-51922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2888490EF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 22:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 502821F22BF1
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DE32C692;
	Sun,  4 Feb 2024 21:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3nX0aEU"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6E13398B;
	Sun,  4 Feb 2024 21:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707083880; cv=none; b=ebtAJkCXKk5VIZVhw2neIJgzalLfroijW9PsK5DHiFCfiaV8HZu2TujWMXoXXRvzvW0pBHoey1YHosPjBLmWFG2djoXbC/V9L5aFGTmuWN5PuP412+JULk6PAni6DQskEKe05triucls8/9xXNBSlSdM7n0LMcHfKze36qkx3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707083880; c=relaxed/simple;
	bh=Ip5cVz+Ph13G1He0TDR8o/2b64vT3lObRAuWHJcE/80=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VayQrUzImS462bDruLmFA7DwtbU9YfjC/5GWyFFGEbQH6HHAjioNBbd2vu0+xO6KSyJ34274j4twRJYoziZLNv/Y3SW9NU0YWXK/7rXwOL+KRyesrt20A/F/SxXKkIOJ/zg5/vhsoOs87J4PDXRJfbPL9WyikoH6fUqVWHKor88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3nX0aEU; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-511344235c6so4104153e87.0;
        Sun, 04 Feb 2024 13:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707083875; x=1707688675; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CjCxiSJkm9OfsI1W1Cwfy9duny+rRipupV8xlV0TRM=;
        b=G3nX0aEU5o1owxq4Q3+/ZmtDI5tBckoftuz/iU+oCmodzRtefJNpyRfAsHLo5I06ap
         zW+//mjVh2feafn+kOuBOmLnkM6xyMQ7cobvZ9BsSM6Zlrjt5GYFb1/f6Ar/la8iyo5Y
         CeIFqa2fEey/jiE46r4LY44KB829G5YSCs02YG4ub9pmTLjpFTOr8XcCuwGenEvf1NPm
         O/qnIoR/ESZic4UHDrXjzTBc8yOm6ihW+ISBHXgCCebxPucnjIYQhCEt2jPxKPpPSUvt
         yfTccOd1QunXXextUHY8HyX26DwteMWhC2MAM4eUQwy1qI1Nr/gEanmiYinm9L+HNjV/
         CzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707083875; x=1707688675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7CjCxiSJkm9OfsI1W1Cwfy9duny+rRipupV8xlV0TRM=;
        b=DBTCW5H0YwKlzCn6fQbboom8eS11+TWeWpqCxcG35H/EBCH6qd2EkeaRxUNGjlxNYy
         KWWRbAg+UAUs8aKc3g8BMJuxlVbE6236BP5sd2tIxnp8nKTScbx7LnfLEG355wuvZU7a
         Q/SMpFtkfMUsvqQlcucaKmEdvRqSyircT3WALMtgJhxIdulF9VmnzO/06HYjmX7m89Po
         q0qLv42py2tO2VIKGbQ3ADKqCZ+imLq+8MW0hNEl3Wp3kva/Ygnsk1jlXO2RgrkmeAIB
         d5lztq73Xpbp/fqvoZLAxyzcNjKtl1en0eNppR26S4fqtIs1F1f189UE2Wt1J2HreJ3p
         dTnA==
X-Gm-Message-State: AOJu0YxpGxPad+AK2SFOt4OM+dEQRZgPWgQ+LgvPHUB6Ce9D+hhGTESj
	cz4d2y2zBwPKs/G8YFRtTkoIArQMeeXzYqRM0LhFKEuqLH3FV9MoV1O1uVCZS9U2+eWr3RosjAY
	aiZZRfXhp+24KVQTWnDm4gAY2MCk=
X-Google-Smtp-Source: AGHT+IH/0SSshHS/A5IFRd1z8dYjtlDX3mJJumoqB3JoKjAjnGtDkdVVFH4lUEH+D3YdCt9yxk35D9cBEd5f6oXMbvU=
X-Received: by 2002:ac2:4e0a:0:b0:511:48ab:2f9c with SMTP id
 e10-20020ac24e0a000000b0051148ab2f9cmr2892478lfr.42.1707083875131; Sun, 04
 Feb 2024 13:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202170537.409508-1-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240202170537.409508-1-meetakshisetiyaoss@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Sun, 4 Feb 2024 15:57:43 -0600
Message-ID: <CAH2r5msEtpJGTvK2F2TY0jR9hU0e7LYJekiyV1zD7MM+i9Oxgg@mail.gmail.com>
Subject: Re: [PATCH] smb: client: do not defer close open handles to deleted files
To: meetakshisetiyaoss@gmail.com
Cc: pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	nspmangalore@gmail.com, tom@talpey.com, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samba-technical@lists.samba.org, 
	bharathsm.hsk@gmail.com, msetiya@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This was puzzling because I tried some experiments with deleting files
that were deferred close and noticed that we already making sure that
they weren't deferred close in cifs_unlink by calling
cifs_close_deferred_file_under_dentry(tcon, full_path) even in
Rohith's original code from a few years ago - so I didn't see cases
where we had a file marked for delete that was deferred close.  How
did you reproduce that problem?

On Fri, Feb 2, 2024 at 11:39=E2=80=AFAM <meetakshisetiyaoss@gmail.com> wrot=
e:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> When a file/dentry has been deleted before closing all its open
> handles, currently, closing them can add them to the deferred close
> list. This can lead to problems in creating file with the same name
> when the file is re-created before the deferred close completes. This
> issue was seen while reusing a client's already existing lease on a
> file for compound operations and xfstest 591 failed because of the
> deferred close handle that remained valid even after the file was
> deleted and was being reused to create a file with the same name. The
> server in this case returns an error on open with
> STATUS_DELETE_PENDING. Recreating the file would fail till the
> deferred handles are closed (duration specified in closetimeo).
>
> This patch fixes the issue by flagging all open handles for the
> deleted file (file path to be precise) with FILE_DELETED at the end
> of the unlink operation. When doing close in cifs_close for each of
> these handles, check the flag and do not defer close these handles if
> the corresponding filepath has been deleted.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/cifsglob.h  |  1 +
>  fs/smb/client/cifsproto.h |  4 ++++
>  fs/smb/client/file.c      |  2 +-
>  fs/smb/client/inode.c     |  2 ++
>  fs/smb/client/misc.c      | 22 ++++++++++++++++++++++
>  5 files changed, 30 insertions(+), 1 deletion(-)
>
> diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
> index decf80131bbe..826da216a9e1 100644
> --- a/fs/smb/client/cifsglob.h
> +++ b/fs/smb/client/cifsglob.h
> @@ -1399,6 +1399,7 @@ struct cifs_fid_locks {
>         struct list_head locks;         /* locks held by fid above */
>  };
>
> +#define FILE_DELETED   0x550
>  struct cifsFileInfo {
>         /* following two lists are protected by tcon->open_file_lock */
>         struct list_head tlist; /* pointer to next fid owned by tcon */
> diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
> index 770db9026850..67f75497db02 100644
> --- a/fs/smb/client/cifsproto.h
> +++ b/fs/smb/client/cifsproto.h
> @@ -292,6 +292,10 @@ extern void cifs_close_all_deferred_files(struct cif=
s_tcon *cifs_tcon);
>
>  extern void cifs_close_deferred_file_under_dentry(struct cifs_tcon *cifs=
_tcon,
>                                 const char *path);
> +
> +extern void cifs_mark_open_handles_for_deleted_file(struct cifs_tcon
> +                               *cifs_tcon, const char *path);
> +
>  extern struct TCP_Server_Info *
>  cifs_get_tcp_session(struct smb3_fs_context *ctx,
>                      struct TCP_Server_Info *primary_server);
> diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
> index b75282c204da..4c87ddbe8a5a 100644
> --- a/fs/smb/client/file.c
> +++ b/fs/smb/client/file.c
> @@ -1085,7 +1085,7 @@ int cifs_close(struct inode *inode, struct file *fi=
le)
>                 if ((cifs_sb->ctx->closetimeo && cinode->oplock =3D=3D CI=
FS_CACHE_RHW_FLG)
>                     && cinode->lease_granted &&
>                     !test_bit(CIFS_INO_CLOSE_ON_LOCK, &cinode->flags) &&
> -                   dclose) {
> +                   dclose && !(cfile->f_flags & FILE_DELETED)) {
>                         if (test_and_clear_bit(CIFS_INO_MODIFIED_ATTR, &c=
inode->flags)) {
>                                 inode_set_mtime_to_ts(inode,
>                                                       inode_set_ctime_cur=
rent(inode));
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 24489e1e238a..be5bc01319d8 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -1822,6 +1822,8 @@ int cifs_unlink(struct inode *dir, struct dentry *d=
entry)
>         cifs_inode =3D CIFS_I(dir);
>         CIFS_I(dir)->time =3D 0;  /* force revalidate of dir as well */
>  unlink_out:
> +       if (rc =3D=3D 0)
> +               cifs_mark_open_handles_for_deleted_file(tcon, full_path);
>         free_dentry_path(page);
>         kfree(attrs);
>         free_xid(xid);
> diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
> index 0748d7b757b9..ebc867bfc034 100644
> --- a/fs/smb/client/misc.c
> +++ b/fs/smb/client/misc.c
> @@ -853,6 +853,28 @@ cifs_close_deferred_file_under_dentry(struct cifs_tc=
on *tcon, const char *path)
>         free_dentry_path(page);
>  }
>
> +/*
> + * If a dentry has been deleted, all corresponding open handles should k=
now the
> + * same, so that we do not defer close them.
> + */
> +void
> +cifs_mark_open_handles_for_deleted_file(struct cifs_tcon *tcon, const ch=
ar
> +*path)
> +{
> +       struct cifsFileInfo *cfile;
> +       void *page;
> +       const char *full_path;
> +
> +       page =3D alloc_dentry_path();
> +       spin_lock(&tcon->open_file_lock);
> +       list_for_each_entry(cfile, &tcon->openFileList, tlist) {
> +               full_path =3D build_path_from_dentry(cfile->dentry, page)=
;
> +               if (strcmp(full_path, path) =3D=3D 0)
> +                       cfile->f_flags |=3D FILE_DELETED;
> +       }
> +       spin_unlock(&tcon->open_file_lock);
> +}
> +
>  /* parses DFS referral V3 structure
>   * caller is responsible for freeing target_nodes
>   * returns:
> --
> 2.39.2
>
>


--=20
Thanks,

Steve

