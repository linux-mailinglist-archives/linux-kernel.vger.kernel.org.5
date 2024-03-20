Return-Path: <linux-kernel+bounces-109246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B3D8816B6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383B1B2158B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E35D6A33C;
	Wed, 20 Mar 2024 17:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlxGXUjt"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9965628
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956535; cv=none; b=iY2maeivyxMapfPSrEqjQE15V92w95OQtswZZInH8ykj+e7BzyEVTlS5l/QecVRbkZ7a2prmU4rvzw/2EBkv2E7+L8Q7Yl4NAs5c6SmXUt4mRXJ1hl30BWQXIGMC4I5UY4B4SgWzEK8FSwAgLFfuNYIj6HA2bh65BtIV7nvmYSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956535; c=relaxed/simple;
	bh=VhGg694ao/0WXM3Z9YmE2+/9/baWtANWAVHD4wIPwk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9exQgPTTXpxMZvHyGa5Mwhgpahwt1huo6wxzCst4wOsFuDFEUgzA7jO5M0G3hAnAQCj2ElNDYcoCVH3yL5/aFYHl/v7cKbbjUBvY6sZ0T2dBtXIw5g4MFeYAICtRkqHH8fgw6OmCPRgG0aTNCvGoNcTZv6iSYXSsSSY5stIGxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlxGXUjt; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7dec16fc4b2so34759241.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710956533; x=1711561333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NW19ZZi2sVI9kzIhS7t3Wxp6wjDVebKp4FeXycGbrmk=;
        b=RlxGXUjtzNYbZjyJhyDQ7o7Y0e6L8PPERcPw3qkmX8rDZP50GKXh9w17OAVkPcptC9
         A6RJJ2nT9YEKLSyiXdBMtqAJewzq75lse/TRfYEQ1OQS0KLA/DM63WX/6Hva4HDgDhD+
         xEtH6cf5hav5uOeAvp0O3nnvGC2kMs8ttUEMfwdSgL+FtpjhdTFCKtXbrqsHaPM0cpa4
         xMuBX6Jk1kr8Ht2VF3sS77+xCmmILAnEURfLnrdgmNZKdIM1dPlELzxrdrmnr+YmF9/i
         bSureDhwqPQmaaYcxjF16F3L7YsbbiS/DEJ1fqXACZMmzrQCbH4CLEWCp+ZIB5BnhmrB
         BKFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710956533; x=1711561333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NW19ZZi2sVI9kzIhS7t3Wxp6wjDVebKp4FeXycGbrmk=;
        b=WpDEzd+PJbUQvFF9stMVfbuTQ9jwdbrlbxPFcv5KtcSm9WjRcnadw5p22n9QeC4SMq
         qM9kKff9+zzx6EkSVTScttPoQWeL8SIbtn5PfQhb+LRz7aYxqQ/QWPuzKmoKAc8AxDMQ
         mipJF9qqGcgJQ0yC8PHeZihRjYhcgo/YnUbWZRadQdHhA2uUi//A9IstL6l0J2J/Tz4X
         JQVqMJaN6Nc7rHZTFAv098cJ99lp2WanXmlMALE/KUgwxRsTmn+zkcHcFH484bY7bFk9
         zpCpPw/52Zn9fgsj/Al1VgXVR29GpAkCK/vCjG5GiV2j9yEMSMKJyHkRZARsNi1ZIOjs
         WseA==
X-Gm-Message-State: AOJu0YxPhpUPOZH3pe4bO1zyv3eCE50XWGeP+I2H3sriDR7Ei8Fzr5GE
	YQshS//zLi03kS5fPr7LFV8emYDlcbiiUUMSy/ruchPesLbdbajt4JLGaD3RDrpJlbOw5aSLKuh
	u79DL2rObjV7cIse3hzjzP8U0+fM=
X-Google-Smtp-Source: AGHT+IF+OiH30Ak1ZIPDrfPiWCrr77p7WnNH2Gz47qu2eWme2cStI+UdwFIiEtA2ErBVpGZw05MEhC3fqogHCKhTqQ8=
X-Received: by 2002:a67:b64b:0:b0:476:5404:5f11 with SMTP id
 e11-20020a67b64b000000b0047654045f11mr15013127vsm.25.1710956532744; Wed, 20
 Mar 2024 10:42:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319212316.4193790-1-daeho43@gmail.com> <712f380c-68ef-4743-bd9b-7342e838ced7@kernel.org>
In-Reply-To: <712f380c-68ef-4743-bd9b-7342e838ced7@kernel.org>
From: Daeho Jeong <daeho43@gmail.com>
Date: Wed, 20 Mar 2024 10:42:01 -0700
Message-ID: <CACOAw_yAWGbx2Bx2or1OyVUUw6HSgTd=fo3e151d1JHU+Op5qQ@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: prevent writing without fallocate()
 for pinned files
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	kernel-team@android.com, Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 2:38=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 2024/3/20 5:23, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > In a case writing without fallocate(), we can't guarantee it's allocate=
d
> > in the conventional area for zoned stroage.
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
> > ---
> > v2: covered the direct io case
> > v3: covered the mkwrite case
> > ---
> >   fs/f2fs/data.c | 14 ++++++++++++--
> >   fs/f2fs/file.c | 16 ++++++++--------
> >   2 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index c21b92f18463..d3e5ab2736a6 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -1584,8 +1584,11 @@ int f2fs_map_blocks(struct inode *inode, struct =
f2fs_map_blocks *map, int flag)
> >
> >       /* use out-place-update for direct IO under LFS mode */
> >       if (map->m_may_create &&
> > -         (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_BLOCK=
_DIO))) {
> > -             if (unlikely(f2fs_cp_error(sbi))) {
> > +         (is_hole || (f2fs_lfs_mode(sbi) && flag =3D=3D F2FS_GET_BLOCK=
_DIO &&
> > +                      !f2fs_is_pinned_file(inode)))) {
> > +             if (unlikely(f2fs_cp_error(sbi)) ||
> > +                 (f2fs_is_pinned_file(inode) && is_hole &&
> > +                  flag !=3D F2FS_GET_BLOCK_PRE_DIO)) {
> >                       err =3D -EIO;
> >                       goto sync_out;
> >               }
> > @@ -3378,6 +3381,8 @@ static int prepare_write_begin(struct f2fs_sb_inf=
o *sbi,
> >               f2fs_map_lock(sbi, flag);
> >               locked =3D true;
> >       } else if ((pos & PAGE_MASK) >=3D i_size_read(inode)) {
> > +             if (f2fs_is_pinned_file(inode))
> > +                     return -EIO;
> >               f2fs_map_lock(sbi, flag);
> >               locked =3D true;
> >       }
> > @@ -3407,6 +3412,11 @@ static int prepare_write_begin(struct f2fs_sb_in=
fo *sbi,
> >
> >       if (!f2fs_lookup_read_extent_cache_block(inode, index,
> >                                                &dn.data_blkaddr)) {
> > +             if (f2fs_is_pinned_file(inode)) {
> > +                     err =3D -EIO;
> > +                     goto out;
> > +             }
> > +
> >               if (locked) {
> >                       err =3D f2fs_reserve_block(&dn, index);
> >                       goto out;
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 82277e95c88f..4db3b21c804b 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -57,7 +57,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_faul=
t *vmf)
> >       struct inode *inode =3D file_inode(vmf->vma->vm_file);
> >       struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
> >       struct dnode_of_data dn;
> > -     bool need_alloc =3D true;
> > +     bool need_alloc =3D !f2fs_is_pinned_file(inode);
>
> Will this check races w/ pinfile get|set?

Do you mean "set/clear" case? I believe "set" case is okay, since we
can't set if the inode already has a data block. For "clear" case, I
believe mkwrite failure is okay in racy conditions caused by clearing
the pin flag. What do you think?

>
> Thanks,
>
> >       int err =3D 0;
> >       vm_fault_t ret;
> >
> > @@ -114,19 +114,15 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_=
fault *vmf)
> >               goto out_sem;
> >       }
> >
> > +     set_new_dnode(&dn, inode, NULL, NULL, 0);
> >       if (need_alloc) {
> >               /* block allocation */
> > -             set_new_dnode(&dn, inode, NULL, NULL, 0);
> >               err =3D f2fs_get_block_locked(&dn, page->index);
> > -     }
> > -
> > -#ifdef CONFIG_F2FS_FS_COMPRESSION
> > -     if (!need_alloc) {
> > -             set_new_dnode(&dn, inode, NULL, NULL, 0);
> > +     } else {
> >               err =3D f2fs_get_dnode_of_data(&dn, page->index, LOOKUP_N=
ODE);
> >               f2fs_put_dnode(&dn);
> >       }
> > -#endif
> > +
> >       if (err) {
> >               unlock_page(page);
> >               goto out_sem;
> > @@ -4611,6 +4607,10 @@ static int f2fs_preallocate_blocks(struct kiocb =
*iocb, struct iov_iter *iter,
> >                       return ret;
> >       }
> >
> > +     /* For pinned files, it should be fallocate()-ed in advance. */
> > +     if (f2fs_is_pinned_file(inode))
> > +             return 0;
> > +
> >       /* Do not preallocate blocks that will be written partially in 4K=
B. */
> >       map.m_lblk =3D F2FS_BLK_ALIGN(pos);
> >       map.m_len =3D F2FS_BYTES_TO_BLK(pos + count);

