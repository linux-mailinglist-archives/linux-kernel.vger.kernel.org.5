Return-Path: <linux-kernel+bounces-46743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF3D844377
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35461C2457F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7144212A154;
	Wed, 31 Jan 2024 15:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br+vz2sV"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CC3129A8D;
	Wed, 31 Jan 2024 15:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706716490; cv=none; b=EgPkYDtFnVM8ZOTgVcYswp57VH5MtTu0+5IccnVHaey1z9g7byeNCxgISJjTfZFdW6LmeAE8I/cwg1Z89AOblM/TK9T6f+fxWpMTjf9gCV2uwa/4NqxYWsD9dXpjX7L2aM20e+0QT95musLposTvRq5sSGygc0pbQCcrWkxwgbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706716490; c=relaxed/simple;
	bh=962G4SeZS6ybqHxFrU26+VODCD2iTSXY5jIdT5VAmx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SGZyG04ipwDyqYCb2EKcka/R67b1yB2J5Um2HVMike/g0DB6/STUGJtjhauyN88UBicWRu9/E8TpDiBeYPWD+4zThEynd1WQdNGwYeZJ9WjpvRL6uqKOxOnbBxEVyhsXuH5roYfQYJEx0dPiGBnUY3Ra+PbE4V04hZ85yHp3FQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br+vz2sV; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc6b5d0e015so1155436276.1;
        Wed, 31 Jan 2024 07:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706716488; x=1707321288; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sp+45kIh37HWYYNwuHvpyq1RNM06jOtAV4lYBAKJAiQ=;
        b=br+vz2sV3+EOmEV7kP4zfuON4sDb2xMWnP9TglLvKNbtKZYXG7lOpQiUv9Hmzm8MGr
         wau6v6SUt5jfTCzbzUQkrWERvSnWWsn8G2uZorc1uC4a+mpKDHufKuuW94ff+3LLOyAh
         DSedETYwVxuGfZlXWBH9lXGyg9cE574oqrh5b2bIozuzgJjp5dHbgNHlqGVAxd5yHHb0
         os2SYyVBYbz1ED3sR5QSwqACG0GSilPJTHCgPQBmmL2lYIdso4pvEEVylhL9vv13r0bv
         4UvBRs7KHO9G6k9hM3xHxdbTrBUXIl7Xh6XfhFeF0mvttMiuy1rt72I1BVjLJBqYxBv5
         NKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706716488; x=1707321288;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sp+45kIh37HWYYNwuHvpyq1RNM06jOtAV4lYBAKJAiQ=;
        b=RnqAlLpy9rjqyZrg2o4eqv9tYhuUqMR1YU7ipCK0ClEwv7fb/7UK306J5LpnMdQ4nk
         PHQHMYhRbitxR+6aW1iirC9BRjAL1S9xP2fDjZiw/B1lTkpjvViRRUXCIqmEicgDbeRC
         gV+0ZWIPnGg76Kb3agryiiiN98KaLG0e3G3BOawdMy6asVQ1zyDpAe6yCpHQDbRhX1uM
         DR0SfmPgRpQqnkBKLtI7qfXg609wuAyMMwOUt7CsuKRlisO21LfRtAQMJyXgD7gcJMGB
         2uRtmYxZl3gt1gLl/4Go5fY12qu1xTfzx7hdZrtTpgmpngSn7mRerBRA4rVFpMsaMqyu
         t7wA==
X-Gm-Message-State: AOJu0YxDRfyAP/J0ZasteZp0k/aVUXk8lyqDPelvUmxwargdFHgp/HK9
	8YJEioGglySmfwAYXHAdTqrxqv6MwW7Zs7Cro/aTv/lsQghgc88bD+KxfB2Qdvxcx9Ah6gy7dB7
	Wj0x0BZ00MJzwTvnvIwOq7cPe+wg=
X-Google-Smtp-Source: AGHT+IFdGdK0zvmMkDmOQrQbRw5dX+IZi8Nc46PV6odF8loYa7iZfaTmImmWVuhsxnN4JyycwD/NBnrVZDen5oDkTog=
X-Received: by 2002:a25:c546:0:b0:dc2:3562:d234 with SMTP id
 v67-20020a25c546000000b00dc23562d234mr2003329ybe.12.1706716488054; Wed, 31
 Jan 2024 07:54:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130214620.3155380-1-stefanb@linux.ibm.com>
 <20240130214620.3155380-5-stefanb@linux.ibm.com> <38230b4c-54ae-45ed-a6fb-34e63501e5b1@linux.ibm.com>
 <CAOQ4uxiYARZBSgzb4_W-RKvB1XLSF3GUBqeLw2kH+eVeZ_8ARQ@mail.gmail.com> <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com>
In-Reply-To: <c018b014-9ba8-4395-86dc-b61346ab20a8@linux.ibm.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 31 Jan 2024 17:54:37 +0200
Message-ID: <CAOQ4uxi6Te8izWpXROthknRaXrVA9jho5nbc+mkuQDrcTLY44Q@mail.gmail.com>
Subject: Re: [PATCH 4/5] evm: Use the real inode's metadata to calculate
 metadata hash
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 4:40=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.co=
m> wrote:
>
>
>
> On 1/31/24 08:16, Amir Goldstein wrote:
> > On Wed, Jan 31, 2024 at 4:11=E2=80=AFAM Stefan Berger <stefanb@linux.ib=
m.com> wrote:
> >>
> >>
> >>
> >> On 1/30/24 16:46, Stefan Berger wrote:
> >>> Changes to the file attribute (mode bits, uid, gid) on the lower laye=
r
> >>> are not take into account when d_backing_inode() is used when a file =
is
> >>> accessed on the overlay layer and this file has not yet been copied u=
p.
> >>> This is because d_backing_inode() does not return the real inode of t=
he
> >>> lower layer but instead returns the backing inode which holds old fil=
e
> >>> attributes. When the old file attributes are used for calculating the
> >>> metadata hash then the expected hash is calculated and the file then
> >>> mistakenly passes signature verification. Therefore, use d_real_inode=
()
> >>> which returns the inode of the lower layer for as long as the file ha=
s
> >>> not been copied up and returns the upper layer's inode otherwise.
> >>>
> >>> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> >>> ---
> >>>    security/integrity/evm/evm_crypto.c | 2 +-
> >>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity=
/evm/evm_crypto.c
> >>> index b1ffd4cc0b44..2e48fe54e899 100644
> >>> --- a/security/integrity/evm/evm_crypto.c
> >>> +++ b/security/integrity/evm/evm_crypto.c
> >>> @@ -223,7 +223,7 @@ static int evm_calc_hmac_or_hash(struct dentry *d=
entry,
> >>>                                 size_t req_xattr_value_len,
> >>>                                 uint8_t type, struct evm_digest *data=
)
> >>>    {
> >>> -     struct inode *inode =3D d_backing_inode(dentry);
> >>> +     struct inode *inode =3D d_real_inode(dentry);
> >>>        struct xattr_list *xattr;
> >>>        struct shash_desc *desc;
> >>>        size_t xattr_size =3D 0;
> >>
> >> We need this patch when NOT activating CONFIG_OVERLAY_FS_METACOPY but
> >> when setting CONFIG_OVERLAY_FS_METACOPY=3Dy it has to be reverted...  =
I am
> >> not sure what the solution is.
> >
> > I think d_real_inode() does not work correctly for all its current user=
s for
> > a metacopy file.
> >
> > I think the solution is to change d_real_inode() to return the data ino=
de
> > and add another helper to get the metadata inode if needed.
> > I will post some patches for it.
>
> I thought that we may have to go through vfs_getattr() but even better
> if we don't because we don't have the file *file anywhere 'near'.
>
> >
> > However, I must say that I do not know if evm_calc_hmac_or_hash()
> > needs the lower data inode, the upper metadata inode or both.
>
> What it needs are data structures with mode bits, uid, and gid that stat
> in userspace would show.
>
>

With or without metacopy enabled, an overlay inode st_uid st_gid st_mode
are always taken from the upper most inode which is what d_real_inode()
currently returns, so I do not understand what the problem is.

> >
> > The last time you tried to fix ovl+IMA, I asked for documentation
> > of what data/metadata is protected with EVM and how are those
> > protections supposed to work across overlayfs copy up, when the
> > data and metadata are often split between 2 and myabe event 3
> > differnt inode.
>
> I always compare against what userspace sees with stat and that's what
> the EVM should also work with so it ends up in reasonable matching
> result in terms of hash calculation and then access permission/rejection.
>

I will need a lot more analysis information to be able to help you.
Exactly which setup, exactly which test, exactly which inode/dentry/file
objects are used and how they are accessed when things go wrong.

Thanks,
Amir.

