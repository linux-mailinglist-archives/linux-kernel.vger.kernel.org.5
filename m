Return-Path: <linux-kernel+bounces-93325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F749872E04
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8951F21748
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF4A1805A;
	Wed,  6 Mar 2024 04:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4O0q2ZR"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3F156C2;
	Wed,  6 Mar 2024 04:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698802; cv=none; b=abngduwDnDD3DeS7h9ZDj3bCcethR8LxA4kfhLyR1q5RNVbfUKMoOPpad4/yCkT14Jf3AgWh/l6JSOKbF78wKn4la91nhNZE1OUD6OXruwyV6lYue4MOVMFA1O35O8yxTgaTooZB1eJYaWSiFz5WkGhVgT+7vKQSdDyk35GFYAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698802; c=relaxed/simple;
	bh=2dfHSc6VAPcDWCQt/cCbwQloxCdMhdHYVlV59fu3gco=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6MrA4r1DoPRsjxYSJuTyVZ2SzaV2S319e/wCoPsbXQtEZbnTEec1LxmarmU7S4W2HZdD6YHJDrcZRew6ZvpHyJBq8do2Hdh9/GRFjJDb5ntZ3EK41RmJUosLpALiybQWVWBtnloeb6AFZcmwW7Ue9K3AuvQhOBhektvU1PqqNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D4O0q2ZR; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-566adfeced4so6812473a12.1;
        Tue, 05 Mar 2024 20:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709698799; x=1710303599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WaH+OCLP7mlTp2cQYeBoaU4GpsCEpVFbSMUWSfBpzj4=;
        b=D4O0q2ZR6u5FWDJter/0OMCZgp64c6ghXhAQErDZqrYRXN+NfdhYFQuzerOzSpzfUI
         zctrJbJ3koVQztShuEmmvFg4q312no+v7UQnloiiIfj4M5MfgXxSwo1Xu4TWdPWsxwyX
         JGCkZwdaGrC3VG6tIscrREwkt95m0Ep3Ty56pPBsA+PlwtuIP0aeLKlMsCLO4852xP3b
         ugtudB3ieQCxrEf/B7TuUICSWGhguA/Wg/Noy3JDBH/IhJk6vZ2OUke58ZhjK7uSmDI9
         3CWUshuSiP2lrkpVPUEbd1qOZsibpohomBYUIK23I3UuNOKJWdN8pkUa9QIrN3dhb+Ed
         E06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698799; x=1710303599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WaH+OCLP7mlTp2cQYeBoaU4GpsCEpVFbSMUWSfBpzj4=;
        b=bup4+vi/vC7L4TRzFe/SUTMoJ5CFbHrbgoMRxzxleFsKf4Q0ZcTsTuhXH6Erj5wSfG
         FCbe7p1f6cbFxBeiAgWkMkrjW0VDodQpu0IpidBBjgGwzRiU6QgZ4XeGZq7osxjRagrP
         co+TEr/MBTBd7jD1A2piqH7SbP9yZ+W39+AEuTxDX+F0cU/6tS51CQSzA/jXKFe/TEzf
         nko2aCysDUutJpwOLSdqFkwQHaijPCeX/urnGkvz52KFkCf/tDy6/zIvS4tMtAFuRZbI
         IIi5LaGlxnk/nG3Bwq21xpIwAaU574NgKLaZG9w70j3YPJBUPuQsXM2t1tfDBjHCjmu+
         0mtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVYjioRWa9R3aVpbZ5hmOIX91Up3exZ73v43RUU1aIJMEycvsNwPePzbzp5vaZcMP1WPL83icOgbyTigphHRx7aqaN01NUPCPa05gww4XWGwDUJG4oxocleZ89nhFhnRMhFYSffz2A1Kg==
X-Gm-Message-State: AOJu0Yz2yzJ4QiTIhAx4BrqIKg6mFA7SieXkMYrjYrQprb24E7/v0Xrq
	5do6eU/isaWDmRMmcxD9lUN2tn0sg89H072Rxk4zAThA6s2jNNVrT99hVLMqLYZK6ZP31dkY9ST
	/MiC5ZMo7xEMRDpmkGy4DUUVI0hU=
X-Google-Smtp-Source: AGHT+IH6WeM5K5ozItkPrXyQnS7z4bZGXlodgcMTNodDbP+NOiy5zKGGL8SKFF2nN/YMM+5a3ATuQENiA20NBuzQR+0=
X-Received: by 2002:a05:6402:2152:b0:565:7c8d:5790 with SMTP id
 bq18-20020a056402215200b005657c8d5790mr9575483edb.4.1709698798675; Tue, 05
 Mar 2024 20:19:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306034353.190039-1-meetakshisetiyaoss@gmail.com> <20240306034353.190039-3-meetakshisetiyaoss@gmail.com>
In-Reply-To: <20240306034353.190039-3-meetakshisetiyaoss@gmail.com>
From: Meetakshi Setiya <meetakshisetiyaoss@gmail.com>
Date: Wed, 6 Mar 2024 09:49:46 +0530
Message-ID: <CAFTVevUYbPCTQs7V5EcqaRy1B3kpFwj+NKCemUamDa0P10QVUg@mail.gmail.com>
Subject: Re: [PATCH 3/3] smb: client: retry compound request without reusing lease
To: sfrench@samba.org, pc@manguebit.com, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, nspmangalore@gmail.com, tom@talpey.com, 
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	samba-technical@lists.samba.org, bharathsm.hsk@gmail.com
Cc: Meetakshi Setiya <msetiya@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch 1 of this patch series
https://lore.kernel.org/all/20240306034353.190039-1-meetakshisetiyaoss@gmai=
l.com/
aims to fix a customer reported bug by reusing lease key in unlink,
rename and set_path_size compound operations on the smb client. The
bug, its implications and reproduction has been described in the
commit message of the patch. In short, unlink, rename and
set_path_size operations can cause the server to send lease breaks to
the same client, on the same connection which hurts performance.

The aim is to have a fix in place for this problem without regressing
existing behaviour. Also, the proposed changes should go in smaller
batches so that they can be backported with relative ease. Patch 1
regressed a few operations on hardlinks (eg., xfstests generic 002,
013).  As per MS-SMB2, lease keys are associated with the file name.
Linux cifs client maintains lease keys with the inode. If the file
has hardlinks, it is possible that the lease for a file be wrongly
reused for an operation on the hardlink or vice versa. In these
cases, the mentioned compound operations fail with
STATUS_INVALID_PARAMETER.

A simple fix for the regressions would be to have a two-phased
approach and resend the compound op request again without the lease
key if STATUS_INVALID_PARAMETER is received. This would help patch 1
fix the original issue. Fix(es) for the hardlink-leasekey problem can
come in the next batch.

On Wed, Mar 6, 2024 at 9:14=E2=80=AFAM <meetakshisetiyaoss@gmail.com> wrote=
:
>
> From: Meetakshi Setiya <msetiya@microsoft.com>
>
> There is a shortcoming in the current implementation of the file
> lease mechanism exposed when the lease keys were attempted to be
> reused for unlink, rename and set_path_size operations for a client. As
> per MS-SMB2, lease keys are associated with the file name. Linux smb
> client maintains lease keys with the inode. If the file has any hardlinks=
,
> it is possible that the lease for a file be wrongly reused for an
> operation on the hardlink or vice versa. In these cases, the mentioned
> compound operations fail with STATUS_INVALID_PARAMETER.
> This patch adds a fallback to the old mechanism of not sending any
> lease with these compound operations if the request with lease key fails
> with STATUS_INVALID_PARAMETER.
> Resending the same request without lease key should not hurt any
> functionality, but might impact performance especially in cases where
> the error is not because of the usage of wrong lease key and we might
> end up doing an extra roundtrip.
>
> Signed-off-by: Meetakshi Setiya <msetiya@microsoft.com>
> ---
>  fs/smb/client/smb2inode.c | 41 ++++++++++++++++++++++++++++++++++++---
>  1 file changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 429d83d31280..f697c14cd8c6 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -154,6 +154,17 @@ static int smb2_compound_op(const unsigned int xid, =
struct cifs_tcon *tcon,
>         }
>
>         /* if there is an existing lease, reuse it */
> +
> +       /*
> +        * note: files with hardlinks cause unexpected behaviour. As per =
MS-SMB2,
> +        * lease keys are associated with the filepath. We are maintainin=
g lease keys
> +        * with the inode on the client. If the file has hardlinks, it is=
 possible
> +        * that the lease for a file be reused for an operation on its ha=
rdlink or
> +        * vice versa.
> +        * As a workaround, send request using an existing lease key and =
if the server
> +        * returns STATUS_INVALID_PARAMETER, which maps to EINVAL, send t=
he request
> +        * again without the lease.
> +        */
>         if (dentry) {
>                 inode =3D d_inode(dentry);
>                 if (CIFS_I(inode)->lease_granted && server->ops->get_leas=
e_key) {
> @@ -874,11 +885,20 @@ int
>  smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *=
name,
>             struct cifs_sb_info *cifs_sb, struct dentry *dentry)
>  {
> -       return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OP=
EN,
> +       int rc =3D smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FIL=
E_OPEN,
>                                 CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POI=
NT,
>                                 ACL_NO_MODE, NULL,
>                                 &(int){SMB2_OP_DELETE}, 1,
>                                 NULL, NULL, NULL, dentry);
> +       if (rc =3D=3D -EINVAL) {
> +               cifs_dbg(FYI, "invalid lease key, resending request witho=
ut lease");
> +               rc =3D smb2_compound_op(xid, tcon, cifs_sb, name, DELETE,=
 FILE_OPEN,
> +                               CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POI=
NT,
> +                               ACL_NO_MODE, NULL,
> +                               &(int){SMB2_OP_DELETE}, 1,
> +                               NULL, NULL, NULL, NULL);
> +       }
> +       return rc;
>  }
>
>  static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *=
tcon,
> @@ -919,8 +939,14 @@ int smb2_rename_path(const unsigned int xid,
>         drop_cached_dir_by_name(xid, tcon, from_name, cifs_sb);
>         cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfi=
le);
>
> -       return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
> +       int rc =3D smb2_set_path_attr(xid, tcon, from_name, to_name, cifs=
_sb,
>                                   co, DELETE, SMB2_OP_RENAME, cfile, sour=
ce_dentry);
> +       if (rc =3D=3D -EINVAL) {
> +               cifs_dbg(FYI, "invalid lease key, resending request witho=
ut lease");
> +               rc =3D smb2_set_path_attr(xid, tcon, from_name, to_name, =
cifs_sb,
> +                                 co, DELETE, SMB2_OP_RENAME, cfile, NULL=
);
> +       }
> +       return rc;
>  }
>
>  int smb2_create_hardlink(const unsigned int xid,
> @@ -949,11 +975,20 @@ smb2_set_path_size(const unsigned int xid, struct c=
ifs_tcon *tcon,
>         in_iov.iov_base =3D &eof;
>         in_iov.iov_len =3D sizeof(eof);
>         cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
> -       return smb2_compound_op(xid, tcon, cifs_sb, full_path,
> +       int rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
>                                 FILE_WRITE_DATA, FILE_OPEN,
>                                 0, ACL_NO_MODE, &in_iov,
>                                 &(int){SMB2_OP_SET_EOF}, 1,
>                                 cfile, NULL, NULL, dentry);
> +       if (rc =3D=3D -EINVAL) {
> +               cifs_dbg(FYI, "invalid lease key, resending request witho=
ut lease");
> +               rc =3D smb2_compound_op(xid, tcon, cifs_sb, full_path,
> +                               FILE_WRITE_DATA, FILE_OPEN,
> +                               0, ACL_NO_MODE, &in_iov,
> +                               &(int){SMB2_OP_SET_EOF}, 1,
> +                               cfile, NULL, NULL, NULL);
> +       }
> +       return rc;
>  }
>
>  int
> --
> 2.39.2
>

