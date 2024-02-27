Return-Path: <linux-kernel+bounces-82612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D950C868740
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 03:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9952B22540
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 02:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549F311CBA;
	Tue, 27 Feb 2024 02:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="di71mfYX"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41F4746E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001313; cv=none; b=HTosNq6LzcyyNPe/vSjrwJpjUoTd3a6NFWxerO6vE+AvTm2F4BqoSOiv9Jk3ukhqWlpYypItjsR/UOsuwMj6fLzfTfnkzTG2pFTZ+T+ZZrmTr6gUZLsiE0fr/s3WHEXfPhBf7+khk/7oT1KZOmMoVt+Rwlndv0QYsCRL4cTZqcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001313; c=relaxed/simple;
	bh=vzU2YaorHwvaPNHI/TTfps8jJxR3eDtvTDV4A/+6TmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CFBtMOl7bevw7nHduHqBlWsuvj+QLNOhkDvtJ8r+13HtVvK+6Q6XQcKYBzfCo8gPjhAE7fLJnlbdeaGJVgC11Cd21+HPw5a9K2xy/9Dz5HUzI426bfegt1hjiB0v+UTYGLAOpLNFY4R/hDy1/QO7vv0YQKyUq2mYkp79LteMvOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=di71mfYX; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-565a3910f86so3816812a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 18:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709001310; x=1709606110; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKnTk+J+FX3ola1FbmaFj80zZDlGsKyOPaOv8pvNq9Y=;
        b=di71mfYXSxzaYddQXIKT2sQZD9rwqQ82ebdk+bOzsSf24+FRPLxXSzC5xv0T+Mi3fG
         ub4OXz97CKZe2ShhhDgzYjCVzIbuQDDNGrpnKywGUOH1jP6ZXoWmtvN7cSSCxQ2YmwE6
         7c7LJ628+RPE1U3oXTfneHHtEGext6/FEza7lyqWiKtclCiMoxtFQZ3VEq9YwND4xp7c
         0tUiikpvsZPbCR83nxzIfB3iTxNKiuBblTFgDepBDZqCwThqodP3iyVNxKRTi0PZmV9v
         KXV+elM9jti/DrQpfpJArN4kSLbMLjftjHZVxGJ735Bzwn4c2Hy+4M9G78AjIWvrDtwr
         j0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709001310; x=1709606110;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKnTk+J+FX3ola1FbmaFj80zZDlGsKyOPaOv8pvNq9Y=;
        b=H8lbXmZZyrjc4/3xkeprPbUd3wOzViTklgo/VfmQGvnX3K0+3TYkhe1u+SngMDap4e
         FF9IazbfzAp9byLsOfuCOvgHvVToaA3m9nem+lmO4EvdWHOnGhNbrZPVzjo6o+RVOe7t
         pwQ6gS0UDKLCIhuCrLM3Ipk6DiJhy4uJJW5qj/ZS68MzUyvJLHKj4GldX7z+0n12Q4Zc
         Gpqy223dqBL+IxOwsFO6P6I90zTirP4MP+ghxIOR6cRVf+FtI8ucG9iuSt67ImTRD/B1
         sWxtkpr1bxlAfALjb5JtgbAWqF/QnHn1Kq3ldF1Habf/L42GxrGbOPqCT/0r2GDcM6uN
         lDbw==
X-Forwarded-Encrypted: i=1; AJvYcCW/vO0eRbBGxliCnpnOb8P7O2N9XXxoC3so7HalQE810rcpx2LZtyBHCnmce3IgsIHDrqmfCNhN79W1lVH/BrB1Tkx5Wimd8jdZWSpO
X-Gm-Message-State: AOJu0YzjViARs6h9aUQsfwX37S6PZA+PYQ/mZ89UxQCML6UcBtTauzUb
	F5sEe8rkfuBl2LrjJJKqlh7srBzIUxVOK0OeBPDak8OQqbYpHDBZhzR6lsDb8Xq5usz4AU9KfNd
	C1Si5JXt/N9BEuud7w9wwj4H5Dg5FMwQ+BBY=
X-Google-Smtp-Source: AGHT+IEXXbKpXmjl9N8hMVutjJqfZLOxImX2rF+nFapa9vIsJj1qUBXl6dHVVXRP2UAScLC8ElOF8tquWZvBP2Qa+dY=
X-Received: by 2002:aa7:d5d5:0:b0:564:3392:e9db with SMTP id
 d21-20020aa7d5d5000000b005643392e9dbmr5247469eds.33.1709001309894; Mon, 26
 Feb 2024 18:35:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
 <88459a22-a21c-4c3d-8371-31d7d713b536@kernel.org> <CAHJ8P3KYY27M3v=9Lu-yD2ufxU1fdG-bg=G92AbpnLUx0zLz3g@mail.gmail.com>
 <f36ef5d0-8922-449e-b19c-de009c89e712@kernel.org> <CAHJ8P3KS2YAXm=GND8DknZqvGqTvm38Nv_9z1nEq4cTJjir-sA@mail.gmail.com>
 <Zd03RHMKBqv1f6GF@google.com>
In-Reply-To: <Zd03RHMKBqv1f6GF@google.com>
From: Zhiguo Niu <niuzhiguo84@gmail.com>
Date: Tue, 27 Feb 2024 10:34:58 +0800
Message-ID: <CAHJ8P3Lj_1pa=npkAsMfeStEY3nWgf591tFndKTT_skFYLv+GQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Zhiguo Niu <zhiguo.niu@unisoc.com>, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	ke.wang@unisoc.com, hongyu.jin@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 9:13=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 02/26, Zhiguo Niu wrote:
> > Dear Chao,
> >
> > On Fri, Feb 23, 2024 at 10:38=E2=80=AFAM Chao Yu <chao@kernel.org> wrot=
e:
> > >
> > > On 2024/2/23 10:01, Zhiguo Niu wrote:
> > > >
> > > >
> > > > On Thu, Feb 22, 2024 at 8:30=E2=80=AFPM Chao Yu <chao@kernel.org <m=
ailto:chao@kernel.org>> wrote:
> > > >
> > > >     On 2024/2/7 10:01, Zhiguo Niu wrote:
> > > >      > A panic issue happened in a reboot test in small capacity de=
vice
> > > >      > as following:
> > > >      > 1.The device size is 64MB, and main area has 24 segments, an=
d
> > > >      > CONFIG_F2FS_CHECK_FS is not enabled.
> > > >      > 2.There is no any free segments left shown in free_segmap_in=
fo,
> > > >      > then another write request cause get_new_segment get a out-o=
f-bound
> > > >      > segment with segno 24.
> > > >      > 3.panic happen in update_sit_entry because access invalid bi=
tmap
> > > >      > pointer.
> > > >
> > > >     Zhiguo,
> > > >
> > > >     Can you please try below patch to see whether it can fix your p=
roblem?
> > > >
> > > >     https://lore.kernel.org/linux-f2fs-devel/20240222121851.883141-=
3-chao@kernel.org <https://lore.kernel.org/linux-f2fs-devel/20240222121851.=
883141-3-chao@kernel.org>
> > > >
> > > >     Thanks,
> > > >
> > > >
> > > > Dear Chao,
> > > > I need to coordinate the testing resources. The previous testing ha=
s been stopped because it was fixed with the current patch. In addition, th=
is requires stability testing to reproduce, so it will take a certain amoun=
t of time. If there is any situation, I will tell you in time.
> > >
> > > Zhiguo, thank you!
> >
> > We tested this patch  this weekend on the previous version with
> > problem, and it can not reproduce panic issues,
> > so this patch should fix the original issue.
> > thanks=EF=BC=81
>
Dear Jaegeuk,
> Hey, do you guys please point out which patches were tested without what?
This problem occurred during our platform stability testing.
it can be fixed by my  this patch set, mainly be fixed by:
f2fs: fix panic issue in update_sit_entry & f2fs: enhance judgment
conditions of GET_SEGNO
and Chao's patch can also fix this problems testing without my patch
> IOWs, which patches should I remove and keep Chao's patch?
I think chao's patch is more reasonable, it does error handling more comple=
te.
but my patch just do some sanity check for return value of GET_SEGNO
Same as other codes(update_segment_mtime)
and i think it also needed except this part:

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 3bf2ce46fa0907..bb22feeae1cfcb 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -96,7 +96,8 @@ static inline void sanity_check_seg_type(struct
f2fs_sb_info *sbi,
(GET_SEGOFF_FROM_SEG0(sbi, blk_addr) & (BLKS_PER_SEG(sbi) - 1))
#define GET_SEGNO(sbi, blk_addr) \
- ((!__is_valid_data_blkaddr(blk_addr)) ? \
+ ((!__is_valid_data_blkaddr(blk_addr) || \
+ !f2fs_is_valid_blkaddr(sbi, blk_addr, DATA_GENERIC)) ? \
NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi), \
GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
#define CAP_BLKS_PER_SEC(sbi)
because Chao's patch let new_addr=3Dnull_addr when  get_new_segment
returns NOSPACE,
so I think this can be reverted and it also saves code running time.
How about Chao's opinions?
thanks!
>
> >
> > >
> > > BTW, I've tested this patch for a while, and it looks there is no iss=
ue w/
> > > FAULT_NO_SEGMENT fault injection is on.
> > >
> > > > btw, Why can=E2=80=99t I see this patch on your branch^^?
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/log/=
?h=3Ddev-test <https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.g=
it/log/?h=3Ddev-test>
> > >
> > > Too lazy to push patches in time, will do it in this weekend. :P
> > >
> > > > thanks=EF=BC=81
> > > >
> > > >
> > > >      >
> > > >      > More detail shown in following patch sets.
> > > >      > The three patches are splited here because the modifications=
 are
> > > >      > relatively independent and more readable.
> > > >      >
> > > >      > ---
> > > >      > Changes of v2: stop checkpoint when get a out-of-bound segme=
nt
> > > >      > ---
> > > >      >
> > > >      > Zhiguo Niu (4):
> > > >      >    f2fs: correct counting methods of free_segments in __set_=
inuse
> > > >      >    f2fs: fix panic issue in update_sit_entry
> > > >      >    f2fs: enhance judgment conditions of GET_SEGNO
> > > >      >    f2fs: stop checkpoint when get a out-of-bounds segment
> > > >      >
> > > >      >   fs/f2fs/file.c          |  7 ++++++-
> > > >      >   fs/f2fs/segment.c       | 21 ++++++++++++++++-----
> > > >      >   fs/f2fs/segment.h       |  7 ++++---
> > > >      >   include/linux/f2fs_fs.h |  1 +
> > > >      >   4 files changed, 27 insertions(+), 9 deletions(-)
> > > >      >
> > > >

