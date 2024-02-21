Return-Path: <linux-kernel+bounces-74293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5785D256
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0681C23D14
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1B33BB34;
	Wed, 21 Feb 2024 08:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5qlCJFA"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128F03BB47
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503278; cv=none; b=I/vMGfFA/mT4khkmDmt7QRiTFdOZRkZ33LeBrxZmjdQMH8z/3XV16sP9leGH95zUcm8vnTmMkMuC5AEmAUA0ugvbN8TOoU97bJNwtgV8vQRd/RDEubilcfsL1jSJeR7tcJY9aTnhdjfBF16o88XMPT+wQZtQZW3yZlRJNOUVKV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503278; c=relaxed/simple;
	bh=jF6XMnOiFdZX5iqucfymnRtHXrEd59ceRu4vHcr5vjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QcjyQqFAjPpsP7UmeHVtdoe/qzcar9EA7N80zxao4Tc3W5FDhQL+Fq9EgZ18JK97ILt0/Vd9BKUbJ2rI6Nc/Sn3M4NsaMomemowSTrl4ol8IAKV8dV4+pJqBw+R6G5TRoqxqtxaWnXxJm4oxrbDTEUEc13g8L02CdCZU4KOPL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5qlCJFA; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so902603366b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708503274; x=1709108074; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=affQeENqLDxOxxM/PL2vqLhlvABsuaTJ2eMVOC6ybDQ=;
        b=D5qlCJFAFl+yz9QqmKqM1UM+LCf6EENgo6vlxl7//Xo85QEpc+OYS/orEXarYZp11l
         k6nDaqOmAljlRg2qkkDCszxg7J+DYkm8VyTDHKtQMeHapOp1b03EitqM09vksUnJ1DPg
         3Z9UfCGOVSqby1mzgl63ba75bZFY9NTHyAHaSPBUzImXXUUfH76clah7e99YBhEh19bx
         A+WBxExiek6INDTv4aKmQj68E+oWwCQsBBqWusfpvmj0cvCLLJTUBN+qkvz6ipYjXR3O
         EQUQ9mf4ME+rG7s/wIUz8S+0RAxt4pYySi8qbrASTmXruMuUX2ua+Q5ypiW7Lnnr9gsb
         nYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708503274; x=1709108074;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=affQeENqLDxOxxM/PL2vqLhlvABsuaTJ2eMVOC6ybDQ=;
        b=M6a5ra3ow+F5L7vBNdPbDkjdrTYw19kFUT6lWkXJb924lql9Jz/EFaeDJkfs3l85hd
         e9sMy/+Tl+v0xNUMhvc/A/DQzK3O9K58tGe4ug/XuozxZxZG1S4P5xgw2BBPSpxD148z
         iLBQAoGWlOnqrD6r3kP0/jVcsHT68Q40wVBetMAiK/fiOO1ATZdwoD9WAZysVux0xix0
         DMQU+3zjj11JNay2I/ie7FsCH+RoU3DHxzfuqFKI+AR3RKAdWUZNSkV4/f2hha6wwUVN
         otqI1j5lqW0gAv9Qr258Qd0dPSbqAaVv5y20hgqZSKs35BCikE9CITlroRKv+nEEq34R
         iTNg==
X-Forwarded-Encrypted: i=1; AJvYcCWqCjTjR2C1vhCS8vA9sdGltFI66u1mf8S33p0Z5zq5Fcb3MQgVNeWN1CLZ1bM78nMcxEDK8w6lUygb+6oIt8TsDHJ9MbjNqX5GmqHS
X-Gm-Message-State: AOJu0Ywxqg0i3FekRxXcVhEbDq0TGokLkpLr//0gorIg9P9VYN1SmX87
	RiIraV96fcDTBt+8OSGGFJKkzC5XzV8bjDZhFsb4oieh86i/W5tbncM6w07QScT4GTtOnvDmL68
	DyW6V66kFLX798Y1sr59Vd9TWA9U=
X-Google-Smtp-Source: AGHT+IHAdg3lyNciQKSI0vrxkHtpuCkB9UqGq17GvA7ik8+E7iWqTBxL892i/JE9HFU+dOeRrhTpaCBss/TZ+T3XjLE=
X-Received: by 2002:a17:906:3957:b0:a3f:4315:5960 with SMTP id
 g23-20020a170906395700b00a3f43155960mr825953eje.32.1708503273806; Wed, 21 Feb
 2024 00:14:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207005105.3744811-1-jaegeuk@kernel.org> <20240207005105.3744811-3-jaegeuk@kernel.org>
 <ZcQSV0HyTwoiW8os@google.com> <f174092a-192a-47f9-a1d4-14d86bba266c@kernel.org>
 <ZdT3EqOB-wXM1NLm@google.com>
In-Reply-To: <ZdT3EqOB-wXM1NLm@google.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Wed, 21 Feb 2024 17:14:22 +0900
Message-ID: <CAD14+f106hmLXMOfLu_cd55rAKmv-KLq-HqCSrKULt27OPhk=w@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 3/3 v2] f2fs: kill zone-capacity support
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, Niklas Cassel <niklas.cassel@wdc.com>, 
	Damien Le Moal <damien.lemoal@wdc.com>, =?UTF-8?Q?Matias_Bj=C3=B8rling?= <matias.bjorling@wdc.com>, 
	daehojeong@google.com, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:03=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 02/20, Chao Yu wrote:
> > Jaegeuk, Daeho,
> >
> > Do we need Cc WD guys? Not sure whether they need this feature...
>
> CC'ed WDC folks.
>
> >
> > For ZUFS: 1) will it only exports 2MB-aligned zone size, and 2) its zon=
e
> > capacity equals zone size?
>
> Yeah, I think f2fs just needs to check 2MB alignment only.
>

Doesn't this break practically all ZNS NVMe devices?

dm-po2zoned isn't merged yet, and PO2 is still enforced on NVMe's
side, and afaik vendors are doing capacity !=3D size to comply with PO2
requirements on the ZNS-side.

> >
> > Thanks,
> >
> > On 2024/2/8 7:29, Jaegeuk Kim wrote:
> > > Since we don't see any user, let's kill.
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >
> > >   from v1:
> > >    - keep setting the seq bit
> > >
> > >   Documentation/ABI/testing/sysfs-fs-f2fs |  6 --
> > >   fs/f2fs/debug.c                         |  7 +-
> > >   fs/f2fs/f2fs.h                          |  5 --
> > >   fs/f2fs/file.c                          |  6 +-
> > >   fs/f2fs/gc.c                            | 33 +++------
> > >   fs/f2fs/gc.h                            | 26 -------
> > >   fs/f2fs/segment.c                       | 93 +++-------------------=
---
> > >   fs/f2fs/segment.h                       | 41 ++++-------
> > >   fs/f2fs/super.c                         | 16 ++---
> > >   fs/f2fs/sysfs.c                         |  6 --
> > >   10 files changed, 44 insertions(+), 195 deletions(-)
> > >
> > > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/=
ABI/testing/sysfs-fs-f2fs
> > > index 48c135e24eb5..dff8c87d87dd 100644
> > > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > > @@ -628,12 +628,6 @@ Contact:       "Jaegeuk Kim" <jaegeuk@kernel.org=
>
> > >   Description:      Controls max # of node block writes to be used fo=
r roll forward
> > >             recovery. This can limit the roll forward recovery time.
> > > -What:              /sys/fs/f2fs/<disk>/unusable_blocks_per_sec
> > > -Date:              June 2022
> > > -Contact:   "Jaegeuk Kim" <jaegeuk@kernel.org>
> > > -Description:       Shows the number of unusable blocks in a section =
which was defined by
> > > -           the zone capacity reported by underlying zoned device.
> > > -
> > >   What:             /sys/fs/f2fs/<disk>/current_atomic_write
> > >   Date:             July 2022
> > >   Contact:  "Daeho Jeong" <daehojeong@google.com>
> > > diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> > > index 0d02224b99b7..6617195bd27e 100644
> > > --- a/fs/f2fs/debug.c
> > > +++ b/fs/f2fs/debug.c
> > > @@ -32,21 +32,20 @@ static struct dentry *f2fs_debugfs_root;
> > >   void f2fs_update_sit_info(struct f2fs_sb_info *sbi)
> > >   {
> > >     struct f2fs_stat_info *si =3D F2FS_STAT(sbi);
> > > -   unsigned long long blks_per_sec, hblks_per_sec, total_vblocks;
> > > +   unsigned long long hblks_per_sec, total_vblocks;
> > >     unsigned long long bimodal, dist;
> > >     unsigned int segno, vblocks;
> > >     int ndirty =3D 0;
> > >     bimodal =3D 0;
> > >     total_vblocks =3D 0;
> > > -   blks_per_sec =3D CAP_BLKS_PER_SEC(sbi);
> > > -   hblks_per_sec =3D blks_per_sec / 2;
> > > +   hblks_per_sec =3D BLKS_PER_SEC(sbi) / 2;
> > >     for (segno =3D 0; segno < MAIN_SEGS(sbi); segno +=3D SEGS_PER_SEC=
(sbi)) {
> > >             vblocks =3D get_valid_blocks(sbi, segno, true);
> > >             dist =3D abs(vblocks - hblks_per_sec);
> > >             bimodal +=3D dist * dist;
> > > -           if (vblocks > 0 && vblocks < blks_per_sec) {
> > > +           if (vblocks > 0 && vblocks < BLKS_PER_SEC(sbi)) {
> > >                     total_vblocks +=3D vblocks;
> > >                     ndirty++;
> > >             }
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 9a9e858083af..34d718301392 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -1618,7 +1618,6 @@ struct f2fs_sb_info {
> > >     unsigned int meta_ino_num;              /* meta inode number*/
> > >     unsigned int log_blocks_per_seg;        /* log2 blocks per segmen=
t */
> > >     unsigned int blocks_per_seg;            /* blocks per segment */
> > > -   unsigned int unusable_blocks_per_sec;   /* unusable blocks per se=
ction */
> > >     unsigned int segs_per_sec;              /* segments per section *=
/
> > >     unsigned int secs_per_zone;             /* sections per zone */
> > >     unsigned int total_sections;            /* total section count */
> > > @@ -3743,10 +3742,6 @@ void f2fs_destroy_segment_manager(struct f2fs_=
sb_info *sbi);
> > >   int __init f2fs_create_segment_manager_caches(void);
> > >   void f2fs_destroy_segment_manager_caches(void);
> > >   int f2fs_rw_hint_to_seg_type(enum rw_hint hint);
> > > -unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > > -                   unsigned int segno);
> > > -unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > > -                   unsigned int segno);
> > >   #define DEF_FRAGMENT_SIZE 4
> > >   #define MIN_FRAGMENT_SIZE 1
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index b0be576b2090..2c13b340c8a0 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -1717,7 +1717,7 @@ static int f2fs_expand_inode_data(struct inode =
*inode, loff_t offset,
> > >             return 0;
> > >     if (f2fs_is_pinned_file(inode)) {
> > > -           block_t sec_blks =3D CAP_BLKS_PER_SEC(sbi);
> > > +           block_t sec_blks =3D BLKS_PER_SEC(sbi);
> > >             block_t sec_len =3D roundup(map.m_len, sec_blks);
> > >             map.m_len =3D sec_blks;
> > > @@ -2525,7 +2525,7 @@ static int __f2fs_ioc_gc_range(struct file *fil=
p, struct f2fs_gc_range *range)
> > >                     ret =3D -EAGAIN;
> > >             goto out;
> > >     }
> > > -   range->start +=3D CAP_BLKS_PER_SEC(sbi);
> > > +   range->start +=3D BLKS_PER_SEC(sbi);
> > >     if (range->start <=3D end)
> > >             goto do_more;
> > >   out:
> > > @@ -2654,7 +2654,7 @@ static int f2fs_defragment_range(struct f2fs_sb=
_info *sbi,
> > >             goto out;
> > >     }
> > > -   sec_num =3D DIV_ROUND_UP(total, CAP_BLKS_PER_SEC(sbi));
> > > +   sec_num =3D DIV_ROUND_UP(total, BLKS_PER_SEC(sbi));
> > >     /*
> > >      * make sure there are enough free section for LFS allocation, th=
is can
> > > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > > index d61a60c1c844..0a1a50b68df8 100644
> > > --- a/fs/f2fs/gc.c
> > > +++ b/fs/f2fs/gc.c
> > > @@ -340,14 +340,13 @@ static unsigned int get_cb_cost(struct f2fs_sb_=
info *sbi, unsigned int segno)
> > >     unsigned char age =3D 0;
> > >     unsigned char u;
> > >     unsigned int i;
> > > -   unsigned int usable_segs_per_sec =3D f2fs_usable_segs_in_sec(sbi,=
 segno);
> > > -   for (i =3D 0; i < usable_segs_per_sec; i++)
> > > +   for (i =3D 0; i < SEGS_PER_SEC(sbi); i++)
> > >             mtime +=3D get_seg_entry(sbi, start + i)->mtime;
> > >     vblocks =3D get_valid_blocks(sbi, segno, true);
> > > -   mtime =3D div_u64(mtime, usable_segs_per_sec);
> > > -   vblocks =3D div_u64(vblocks, usable_segs_per_sec);
> > > +   mtime =3D div_u64(mtime, SEGS_PER_SEC(sbi));
> > > +   vblocks =3D div_u64(vblocks, SEGS_PER_SEC(sbi));
> > >     u =3D (vblocks * 100) >> sbi->log_blocks_per_seg;
> > > @@ -530,7 +529,6 @@ static void atgc_lookup_victim(struct f2fs_sb_inf=
o *sbi,
> > >     unsigned long long age, u, accu;
> > >     unsigned long long max_mtime =3D sit_i->dirty_max_mtime;
> > >     unsigned long long min_mtime =3D sit_i->dirty_min_mtime;
> > > -   unsigned int sec_blocks =3D CAP_BLKS_PER_SEC(sbi);
> > >     unsigned int vblocks;
> > >     unsigned int dirty_threshold =3D max(am->max_candidate_count,
> > >                                     am->candidate_ratio *
> > > @@ -560,13 +558,13 @@ static void atgc_lookup_victim(struct f2fs_sb_i=
nfo *sbi,
> > >     /* age =3D 10000 * x% * 60 */
> > >     age =3D div64_u64(accu * (max_mtime - ve->mtime), total_time) *
> > > -                                                           age_weigh=
t;
> > > +                                                   age_weight;
> > >     vblocks =3D get_valid_blocks(sbi, ve->segno, true);
> > > -   f2fs_bug_on(sbi, !vblocks || vblocks =3D=3D sec_blocks);
> > > +   f2fs_bug_on(sbi, !vblocks || vblocks =3D=3D BLKS_PER_SEC(sbi));
> > >     /* u =3D 10000 * x% * 40 */
> > > -   u =3D div64_u64(accu * (sec_blocks - vblocks), sec_blocks) *
> > > +   u =3D div64_u64(accu * (BLKS_PER_SEC(sbi) - vblocks), BLKS_PER_SE=
C(sbi)) *
> > >                                                     (100 - age_weight=
);
> > >     f2fs_bug_on(sbi, age + u >=3D UINT_MAX);
> > > @@ -1003,7 +1001,6 @@ static int gc_node_segment(struct f2fs_sb_info =
*sbi,
> > >     int phase =3D 0;
> > >     bool fggc =3D (gc_type =3D=3D FG_GC);
> > >     int submitted =3D 0;
> > > -   unsigned int usable_blks_in_seg =3D f2fs_usable_blks_in_seg(sbi, =
segno);
> > >     start_addr =3D START_BLOCK(sbi, segno);
> > > @@ -1013,7 +1010,7 @@ static int gc_node_segment(struct f2fs_sb_info =
*sbi,
> > >     if (fggc && phase =3D=3D 2)
> > >             atomic_inc(&sbi->wb_sync_req[NODE]);
> > > -   for (off =3D 0; off < usable_blks_in_seg; off++, entry++) {
> > > +   for (off =3D 0; off < BLKS_PER_SEG(sbi); off++, entry++) {
> > >             nid_t nid =3D le32_to_cpu(entry->nid);
> > >             struct page *node_page;
> > >             struct node_info ni;
> > > @@ -1498,14 +1495,13 @@ static int gc_data_segment(struct f2fs_sb_inf=
o *sbi, struct f2fs_summary *sum,
> > >     int off;
> > >     int phase =3D 0;
> > >     int submitted =3D 0;
> > > -   unsigned int usable_blks_in_seg =3D f2fs_usable_blks_in_seg(sbi, =
segno);
> > >     start_addr =3D START_BLOCK(sbi, segno);
> > >   next_step:
> > >     entry =3D sum;
> > > -   for (off =3D 0; off < usable_blks_in_seg; off++, entry++) {
> > > +   for (off =3D 0; off < BLKS_PER_SEG(sbi); off++, entry++) {
> > >             struct page *data_page;
> > >             struct inode *inode;
> > >             struct node_info dni; /* dnode info for the data */
> > > @@ -1520,7 +1516,7 @@ static int gc_data_segment(struct f2fs_sb_info =
*sbi, struct f2fs_summary *sum,
> > >              */
> > >             if ((gc_type =3D=3D BG_GC && has_not_enough_free_secs(sbi=
, 0, 0)) ||
> > >                     (!force_migrate && get_valid_blocks(sbi, segno, t=
rue) =3D=3D
> > > -                                                   CAP_BLKS_PER_SEC(=
sbi)))
> > > +                                                   BLKS_PER_SEC(sbi)=
))
> > >                     return submitted;
> > >             if (check_valid_map(sbi, segno, off) =3D=3D 0)
> > > @@ -1680,15 +1676,6 @@ static int do_garbage_collect(struct f2fs_sb_i=
nfo *sbi,
> > >     if (__is_large_section(sbi))
> > >             end_segno =3D rounddown(end_segno, SEGS_PER_SEC(sbi));
> > > -   /*
> > > -    * zone-capacity can be less than zone-size in zoned devices,
> > > -    * resulting in less than expected usable segments in the zone,
> > > -    * calculate the end segno in the zone which can be garbage colle=
cted
> > > -    */
> > > -   if (f2fs_sb_has_blkzoned(sbi))
> > > -           end_segno -=3D SEGS_PER_SEC(sbi) -
> > > -                                   f2fs_usable_segs_in_sec(sbi, segn=
o);
> > > -
> > >     sanity_check_seg_type(sbi, get_seg_entry(sbi, segno)->type);
> > >     /* readahead multi ssa blocks those have contiguous address */
> > > @@ -1862,7 +1849,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2=
fs_gc_control *gc_control)
> > >     total_freed +=3D seg_freed;
> > > -   if (seg_freed =3D=3D f2fs_usable_segs_in_sec(sbi, segno)) {
> > > +   if (seg_freed =3D=3D SEGS_PER_SEC(sbi)) {
> > >             sec_freed++;
> > >             total_sec_freed++;
> > >     }
> > > diff --git a/fs/f2fs/gc.h b/fs/f2fs/gc.h
> > > index 28a00942802c..e4a75aa4160f 100644
> > > --- a/fs/f2fs/gc.h
> > > +++ b/fs/f2fs/gc.h
> > > @@ -68,34 +68,8 @@ struct victim_entry {
> > >    * inline functions
> > >    */
> > > -/*
> > > - * On a Zoned device zone-capacity can be less than zone-size and if
> > > - * zone-capacity is not aligned to f2fs segment size(2MB), then the =
segment
> > > - * starting just before zone-capacity has some blocks spanning acros=
s the
> > > - * zone-capacity, these blocks are not usable.
> > > - * Such spanning segments can be in free list so calculate the sum o=
f usable
> > > - * blocks in currently free segments including normal and spanning s=
egments.
> > > - */
> > > -static inline block_t free_segs_blk_count_zoned(struct f2fs_sb_info =
*sbi)
> > > -{
> > > -   block_t free_seg_blks =3D 0;
> > > -   struct free_segmap_info *free_i =3D FREE_I(sbi);
> > > -   int j;
> > > -
> > > -   spin_lock(&free_i->segmap_lock);
> > > -   for (j =3D 0; j < MAIN_SEGS(sbi); j++)
> > > -           if (!test_bit(j, free_i->free_segmap))
> > > -                   free_seg_blks +=3D f2fs_usable_blks_in_seg(sbi, j=
);
> > > -   spin_unlock(&free_i->segmap_lock);
> > > -
> > > -   return free_seg_blks;
> > > -}
> > > -
> > >   static inline block_t free_segs_blk_count(struct f2fs_sb_info *sbi)
> > >   {
> > > -   if (f2fs_sb_has_blkzoned(sbi))
> > > -           return free_segs_blk_count_zoned(sbi);
> > > -
> > >     return free_segments(sbi) << sbi->log_blocks_per_seg;
> > >   }
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 8d330664b925..1013276ad12a 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -769,7 +769,7 @@ static void __locate_dirty_segment(struct f2fs_sb=
_info *sbi, unsigned int segno,
> > >                             get_valid_blocks(sbi, segno, true);
> > >                     f2fs_bug_on(sbi, unlikely(!valid_blocks ||
> > > -                                   valid_blocks =3D=3D CAP_BLKS_PER_=
SEC(sbi)));
> > > +                                   valid_blocks =3D=3D BLKS_PER_SEC(=
sbi)));
> > >                     if (!IS_CURSEC(sbi, secno))
> > >                             set_bit(secno, dirty_i->dirty_secmap);
> > > @@ -805,7 +805,7 @@ static void __remove_dirty_segment(struct f2fs_sb=
_info *sbi, unsigned int segno,
> > >                     unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segn=
o);
> > >                     if (!valid_blocks ||
> > > -                                   valid_blocks =3D=3D CAP_BLKS_PER_=
SEC(sbi)) {
> > > +                                   valid_blocks =3D=3D BLKS_PER_SEC(=
sbi)) {
> > >                             clear_bit(secno, dirty_i->dirty_secmap);
> > >                             return;
> > >                     }
> > > @@ -825,22 +825,20 @@ static void locate_dirty_segment(struct f2fs_sb=
_info *sbi, unsigned int segno)
> > >   {
> > >     struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> > >     unsigned short valid_blocks, ckpt_valid_blocks;
> > > -   unsigned int usable_blocks;
> > >     if (segno =3D=3D NULL_SEGNO || IS_CURSEG(sbi, segno))
> > >             return;
> > > -   usable_blocks =3D f2fs_usable_blks_in_seg(sbi, segno);
> > >     mutex_lock(&dirty_i->seglist_lock);
> > >     valid_blocks =3D get_valid_blocks(sbi, segno, false);
> > >     ckpt_valid_blocks =3D get_ckpt_valid_blocks(sbi, segno, false);
> > >     if (valid_blocks =3D=3D 0 && (!is_sbi_flag_set(sbi, SBI_CP_DISABL=
ED) ||
> > > -           ckpt_valid_blocks =3D=3D usable_blocks)) {
> > > +           ckpt_valid_blocks =3D=3D BLKS_PER_SEG(sbi))) {
> > >             __locate_dirty_segment(sbi, segno, PRE);
> > >             __remove_dirty_segment(sbi, segno, DIRTY);
> > > -   } else if (valid_blocks < usable_blocks) {
> > > +   } else if (valid_blocks < BLKS_PER_SEG(sbi)) {
> > >             __locate_dirty_segment(sbi, segno, DIRTY);
> > >     } else {
> > >             /* Recovery routine with SSR needs this */
> > > @@ -882,12 +880,7 @@ block_t f2fs_get_unusable_blocks(struct f2fs_sb_=
info *sbi)
> > >     mutex_lock(&dirty_i->seglist_lock);
> > >     for_each_set_bit(segno, dirty_i->dirty_segmap[DIRTY], MAIN_SEGS(s=
bi)) {
> > >             se =3D get_seg_entry(sbi, segno);
> > > -           if (IS_NODESEG(se->type))
> > > -                   holes[NODE] +=3D f2fs_usable_blks_in_seg(sbi, seg=
no) -
> > > -                                                   se->valid_blocks;
> > > -           else
> > > -                   holes[DATA] +=3D f2fs_usable_blks_in_seg(sbi, seg=
no) -
> > > -                                                   se->valid_blocks;
> > > +           holes[SE_PAGETYPE(se)] +=3D BLKS_PER_SEG(sbi) - se->valid=
_blocks;
> > >     }
> > >     mutex_unlock(&dirty_i->seglist_lock);
> > > @@ -2406,8 +2399,7 @@ static void update_sit_entry(struct f2fs_sb_inf=
o *sbi, block_t blkaddr, int del)
> > >     new_vblocks =3D se->valid_blocks + del;
> > >     offset =3D GET_BLKOFF_FROM_SEG0(sbi, blkaddr);
> > > -   f2fs_bug_on(sbi, (new_vblocks < 0 ||
> > > -                   (new_vblocks > f2fs_usable_blks_in_seg(sbi, segno=
))));
> > > +   f2fs_bug_on(sbi, new_vblocks < 0 || new_vblocks > BLKS_PER_SEG(sb=
i));
> > >     se->valid_blocks =3D new_vblocks;
> > > @@ -3449,7 +3441,7 @@ void f2fs_allocate_data_block(struct f2fs_sb_in=
fo *sbi, struct page *page,
> > >             if (F2FS_OPTION(sbi).fs_mode =3D=3D FS_MODE_FRAGMENT_BLK)
> > >                     f2fs_randomize_chunk(sbi, curseg);
> > >     }
> > > -   if (curseg->next_blkoff >=3D f2fs_usable_blks_in_seg(sbi, curseg-=
>segno))
> > > +   if (curseg->next_blkoff >=3D BLKS_PER_SEG(sbi))
> > >             segment_full =3D true;
> > >     stat_inc_block_count(sbi, curseg);
> > > @@ -4687,8 +4679,6 @@ static void init_free_segmap(struct f2fs_sb_inf=
o *sbi)
> > >     struct seg_entry *sentry;
> > >     for (start =3D 0; start < MAIN_SEGS(sbi); start++) {
> > > -           if (f2fs_usable_blks_in_seg(sbi, start) =3D=3D 0)
> > > -                   continue;
> > >             sentry =3D get_seg_entry(sbi, start);
> > >             if (!sentry->valid_blocks)
> > >                     __set_free(sbi, start);
> > > @@ -4710,7 +4700,7 @@ static void init_dirty_segmap(struct f2fs_sb_in=
fo *sbi)
> > >     struct dirty_seglist_info *dirty_i =3D DIRTY_I(sbi);
> > >     struct free_segmap_info *free_i =3D FREE_I(sbi);
> > >     unsigned int segno =3D 0, offset =3D 0, secno;
> > > -   block_t valid_blocks, usable_blks_in_seg;
> > > +   block_t valid_blocks;
> > >     while (1) {
> > >             /* find dirty segment based on free segmap */
> > > @@ -4719,10 +4709,9 @@ static void init_dirty_segmap(struct f2fs_sb_i=
nfo *sbi)
> > >                     break;
> > >             offset =3D segno + 1;
> > >             valid_blocks =3D get_valid_blocks(sbi, segno, false);
> > > -           usable_blks_in_seg =3D f2fs_usable_blks_in_seg(sbi, segno=
);
> > > -           if (valid_blocks =3D=3D usable_blks_in_seg || !valid_bloc=
ks)
> > > +           if (valid_blocks =3D=3D BLKS_PER_SEG(sbi) || !valid_block=
s)
> > >                     continue;
> > > -           if (valid_blocks > usable_blks_in_seg) {
> > > +           if (valid_blocks > BLKS_PER_SEG(sbi)) {
> > >                     f2fs_bug_on(sbi, 1);
> > >                     continue;
> > >             }
> > > @@ -4739,7 +4728,7 @@ static void init_dirty_segmap(struct f2fs_sb_in=
fo *sbi)
> > >             valid_blocks =3D get_valid_blocks(sbi, segno, true);
> > >             secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > > -           if (!valid_blocks || valid_blocks =3D=3D CAP_BLKS_PER_SEC=
(sbi))
> > > +           if (!valid_blocks || valid_blocks =3D=3D BLKS_PER_SEC(sbi=
))
> > >                     continue;
> > >             if (IS_CURSEC(sbi, secno))
> > >                     continue;
> > > @@ -5097,42 +5086,6 @@ int f2fs_check_write_pointer(struct f2fs_sb_in=
fo *sbi)
> > >     return 0;
> > >   }
> > > -
> > > -/*
> > > - * Return the number of usable blocks in a segment. The number of bl=
ocks
> > > - * returned is always equal to the number of blocks in a segment for
> > > - * segments fully contained within a sequential zone capacity or a
> > > - * conventional zone. For segments partially contained in a sequenti=
al
> > > - * zone capacity, the number of usable blocks up to the zone capacit=
y
> > > - * is returned. 0 is returned in all other cases.
> > > - */
> > > -static inline unsigned int f2fs_usable_zone_blks_in_seg(
> > > -                   struct f2fs_sb_info *sbi, unsigned int segno)
> > > -{
> > > -   block_t seg_start, sec_start_blkaddr, sec_cap_blkaddr;
> > > -   unsigned int secno;
> > > -
> > > -   if (!sbi->unusable_blocks_per_sec)
> > > -           return BLKS_PER_SEG(sbi);
> > > -
> > > -   secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > > -   seg_start =3D START_BLOCK(sbi, segno);
> > > -   sec_start_blkaddr =3D START_BLOCK(sbi, GET_SEG_FROM_SEC(sbi, secn=
o));
> > > -   sec_cap_blkaddr =3D sec_start_blkaddr + CAP_BLKS_PER_SEC(sbi);
> > > -
> > > -   /*
> > > -    * If segment starts before zone capacity and spans beyond
> > > -    * zone capacity, then usable blocks are from seg start to
> > > -    * zone capacity. If the segment starts after the zone capacity,
> > > -    * then there are no usable blocks.
> > > -    */
> > > -   if (seg_start >=3D sec_cap_blkaddr)
> > > -           return 0;
> > > -   if (seg_start + BLKS_PER_SEG(sbi) > sec_cap_blkaddr)
> > > -           return sec_cap_blkaddr - seg_start;
> > > -
> > > -   return BLKS_PER_SEG(sbi);
> > > -}
> > >   #else
> > >   int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi)
> > >   {
> > > @@ -5143,31 +5096,7 @@ int f2fs_check_write_pointer(struct f2fs_sb_in=
fo *sbi)
> > >   {
> > >     return 0;
> > >   }
> > > -
> > > -static inline unsigned int f2fs_usable_zone_blks_in_seg(struct f2fs_=
sb_info *sbi,
> > > -                                                   unsigned int segn=
o)
> > > -{
> > > -   return 0;
> > > -}
> > > -
> > >   #endif
> > > -unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
> > > -                                   unsigned int segno)
> > > -{
> > > -   if (f2fs_sb_has_blkzoned(sbi))
> > > -           return f2fs_usable_zone_blks_in_seg(sbi, segno);
> > > -
> > > -   return BLKS_PER_SEG(sbi);
> > > -}
> > > -
> > > -unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi,
> > > -                                   unsigned int segno)
> > > -{
> > > -   if (f2fs_sb_has_blkzoned(sbi))
> > > -           return CAP_SEGS_PER_SEC(sbi);
> > > -
> > > -   return SEGS_PER_SEC(sbi);
> > > -}
> > >   /*
> > >    * Update min, max modified time for cost-benefit GC algorithm
> > > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > > index 96cec83012f1..b725ae1a7043 100644
> > > --- a/fs/f2fs/segment.h
> > > +++ b/fs/f2fs/segment.h
> > > @@ -99,12 +99,6 @@ static inline void sanity_check_seg_type(struct f2=
fs_sb_info *sbi,
> > >     ((!__is_valid_data_blkaddr(blk_addr)) ?                 \
> > >     NULL_SEGNO : GET_L2R_SEGNO(FREE_I(sbi),                 \
> > >             GET_SEGNO_FROM_SEG0(sbi, blk_addr)))
> > > -#define CAP_BLKS_PER_SEC(sbi)                                      \
> > > -   ((sbi)->segs_per_sec * (sbi)->blocks_per_seg -          \
> > > -    (sbi)->unusable_blocks_per_sec)
> > > -#define CAP_SEGS_PER_SEC(sbi)                                      \
> > > -   ((sbi)->segs_per_sec - ((sbi)->unusable_blocks_per_sec >>\
> > > -   (sbi)->log_blocks_per_seg))
> > >   #define GET_SEC_FROM_SEG(sbi, segno)                              \
> > >     (((segno) =3D=3D -1) ? -1 : (segno) / (sbi)->segs_per_sec)
> > >   #define GET_SEG_FROM_SEC(sbi, secno)                              \
> > > @@ -440,7 +434,6 @@ static inline void __set_free(struct f2fs_sb_info=
 *sbi, unsigned int segno)
> > >     unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > >     unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> > >     unsigned int next;
> > > -   unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> > >     spin_lock(&free_i->segmap_lock);
> > >     clear_bit(segno, free_i->free_segmap);
> > > @@ -448,7 +441,7 @@ static inline void __set_free(struct f2fs_sb_info=
 *sbi, unsigned int segno)
> > >     next =3D find_next_bit(free_i->free_segmap,
> > >                     start_segno + SEGS_PER_SEC(sbi), start_segno);
> > > -   if (next >=3D start_segno + usable_segs) {
> > > +   if (next >=3D start_segno + SEGS_PER_SEC(sbi)) {
> > >             clear_bit(secno, free_i->free_secmap);
> > >             free_i->free_sections++;
> > >     }
> > > @@ -474,7 +467,6 @@ static inline void __set_test_and_free(struct f2f=
s_sb_info *sbi,
> > >     unsigned int secno =3D GET_SEC_FROM_SEG(sbi, segno);
> > >     unsigned int start_segno =3D GET_SEG_FROM_SEC(sbi, secno);
> > >     unsigned int next;
> > > -   unsigned int usable_segs =3D f2fs_usable_segs_in_sec(sbi, segno);
> > >     spin_lock(&free_i->segmap_lock);
> > >     if (test_and_clear_bit(segno, free_i->free_segmap)) {
> > > @@ -484,7 +476,7 @@ static inline void __set_test_and_free(struct f2f=
s_sb_info *sbi,
> > >                     goto skip_free;
> > >             next =3D find_next_bit(free_i->free_segmap,
> > >                             start_segno + SEGS_PER_SEC(sbi), start_se=
gno);
> > > -           if (next >=3D start_segno + usable_segs) {
> > > +           if (next >=3D start_segno + SEGS_PER_SEC(sbi)) {
> > >                     if (test_and_clear_bit(secno, free_i->free_secmap=
))
> > >                             free_i->free_sections++;
> > >             }
> > > @@ -577,16 +569,15 @@ static inline bool has_curseg_enough_space(stru=
ct f2fs_sb_info *sbi,
> > >     /* check current node segment */
> > >     for (i =3D CURSEG_HOT_NODE; i <=3D CURSEG_COLD_NODE; i++) {
> > >             segno =3D CURSEG_I(sbi, i)->segno;
> > > -           left_blocks =3D f2fs_usable_blks_in_seg(sbi, segno) -
> > > +           left_blocks =3D BLKS_PER_SEG(sbi) -
> > >                             get_seg_entry(sbi, segno)->ckpt_valid_blo=
cks;
> > > -
> > >             if (node_blocks > left_blocks)
> > >                     return false;
> > >     }
> > >     /* check current data segment */
> > >     segno =3D CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
> > > -   left_blocks =3D f2fs_usable_blks_in_seg(sbi, segno) -
> > > +   left_blocks =3D BLKS_PER_SEG(sbi) -
> > >                     get_seg_entry(sbi, segno)->ckpt_valid_blocks;
> > >     if (dent_blocks > left_blocks)
> > >             return false;
> > > @@ -604,10 +595,10 @@ static inline void __get_secs_required(struct f=
2fs_sb_info *sbi,
> > >                                     get_pages(sbi, F2FS_DIRTY_DENTS) =
+
> > >                                     get_pages(sbi, F2FS_DIRTY_IMETA);
> > >     unsigned int total_dent_blocks =3D get_pages(sbi, F2FS_DIRTY_DENT=
S);
> > > -   unsigned int node_secs =3D total_node_blocks / CAP_BLKS_PER_SEC(s=
bi);
> > > -   unsigned int dent_secs =3D total_dent_blocks / CAP_BLKS_PER_SEC(s=
bi);
> > > -   unsigned int node_blocks =3D total_node_blocks % CAP_BLKS_PER_SEC=
(sbi);
> > > -   unsigned int dent_blocks =3D total_dent_blocks % CAP_BLKS_PER_SEC=
(sbi);
> > > +   unsigned int node_secs =3D total_node_blocks / BLKS_PER_SEC(sbi);
> > > +   unsigned int dent_secs =3D total_dent_blocks / BLKS_PER_SEC(sbi);
> > > +   unsigned int node_blocks =3D total_node_blocks % BLKS_PER_SEC(sbi=
);
> > > +   unsigned int dent_blocks =3D total_dent_blocks % BLKS_PER_SEC(sbi=
);
> > >     if (lower_p)
> > >             *lower_p =3D node_secs + dent_secs;
> > > @@ -766,22 +757,21 @@ static inline int check_block_count(struct f2fs=
_sb_info *sbi,
> > >     bool is_valid  =3D test_bit_le(0, raw_sit->valid_map) ? true : fa=
lse;
> > >     int valid_blocks =3D 0;
> > >     int cur_pos =3D 0, next_pos;
> > > -   unsigned int usable_blks_per_seg =3D f2fs_usable_blks_in_seg(sbi,=
 segno);
> > >     /* check bitmap with valid block count */
> > >     do {
> > >             if (is_valid) {
> > >                     next_pos =3D find_next_zero_bit_le(&raw_sit->vali=
d_map,
> > > -                                   usable_blks_per_seg,
> > > +                                   BLKS_PER_SEG(sbi),
> > >                                     cur_pos);
> > >                     valid_blocks +=3D next_pos - cur_pos;
> > >             } else
> > >                     next_pos =3D find_next_bit_le(&raw_sit->valid_map=
,
> > > -                                   usable_blks_per_seg,
> > > +                                   BLKS_PER_SEG(sbi),
> > >                                     cur_pos);
> > >             cur_pos =3D next_pos;
> > >             is_valid =3D !is_valid;
> > > -   } while (cur_pos < usable_blks_per_seg);
> > > +   } while (cur_pos < BLKS_PER_SEG(sbi));
> > >     if (unlikely(GET_SIT_VBLOCKS(raw_sit) !=3D valid_blocks)) {
> > >             f2fs_err(sbi, "Mismatch valid blocks %d vs. %d",
> > > @@ -791,14 +781,9 @@ static inline int check_block_count(struct f2fs_=
sb_info *sbi,
> > >             return -EFSCORRUPTED;
> > >     }
> > > -   if (usable_blks_per_seg < BLKS_PER_SEG(sbi))
> > > -           f2fs_bug_on(sbi, find_next_bit_le(&raw_sit->valid_map,
> > > -                           BLKS_PER_SEG(sbi),
> > > -                           usable_blks_per_seg) !=3D BLKS_PER_SEG(sb=
i));
> > > -
> > >     /* check segment usage, and check boundary of a given segment num=
ber */
> > > -   if (unlikely(GET_SIT_VBLOCKS(raw_sit) > usable_blks_per_seg
> > > -                                   || !valid_main_segno(sbi, segno))=
) {
> > > +   if (unlikely(GET_SIT_VBLOCKS(raw_sit) > BLKS_PER_SEG(sbi) ||
> > > +                           !valid_main_segno(sbi, segno))) {
> > >             f2fs_err(sbi, "Wrong valid blocks %d or segno %u",
> > >                      GET_SIT_VBLOCKS(raw_sit), segno);
> > >             set_sbi_flag(sbi, SBI_NEED_FSCK);
> > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > > index c0688c124aa7..cd6a56020a5d 100644
> > > --- a/fs/f2fs/super.c
> > > +++ b/fs/f2fs/super.c
> > > @@ -3837,21 +3837,13 @@ static int f2fs_report_zone_cb(struct blk_zon=
e *zone, unsigned int idx,
> > >                           void *data)
> > >   {
> > >     struct f2fs_report_zones_args *rz_args =3D data;
> > > -   block_t unusable_blocks =3D (zone->len - zone->capacity) >>
> > > -                                   F2FS_LOG_SECTORS_PER_BLOCK;
> > > -   if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > > -           return 0;
> > > -
> > > -   set_bit(idx, rz_args->dev->blkz_seq);
> > > -   if (!rz_args->sbi->unusable_blocks_per_sec) {
> > > -           rz_args->sbi->unusable_blocks_per_sec =3D unusable_blocks=
;
> > > -           return 0;
> > > -   }
> > > -   if (rz_args->sbi->unusable_blocks_per_sec !=3D unusable_blocks) {
> > > -           f2fs_err(rz_args->sbi, "F2FS supports single zone capacit=
y\n");
> > > +   if (zone->len !=3D zone->capacity) {
> > > +           f2fs_err(rz_args->sbi, "F2FS does not support zone capaci=
ty.\n");
> > >             return -EINVAL;
> > >     }
> > > +   if (zone->type !=3D BLK_ZONE_TYPE_CONVENTIONAL)
> > > +           set_bit(idx, rz_args->dev->blkz_seq);
> > >     return 0;
> > >   }
> > > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > > index 906d2af2d849..2689cc9c3bf8 100644
> > > --- a/fs/f2fs/sysfs.c
> > > +++ b/fs/f2fs/sysfs.c
> > > @@ -1018,9 +1018,6 @@ F2FS_SBI_GENERAL_RW_ATTR(revoked_atomic_block);
> > >   F2FS_SBI_GENERAL_RW_ATTR(hot_data_age_threshold);
> > >   F2FS_SBI_GENERAL_RW_ATTR(warm_data_age_threshold);
> > >   F2FS_SBI_GENERAL_RW_ATTR(last_age_weight);
> > > -#ifdef CONFIG_BLK_DEV_ZONED
> > > -F2FS_SBI_GENERAL_RO_ATTR(unusable_blocks_per_sec);
> > > -#endif
> > >   /* STAT_INFO ATTR */
> > >   #ifdef CONFIG_F2FS_STAT_FS
> > > @@ -1172,9 +1169,6 @@ static struct attribute *f2fs_attrs[] =3D {
> > >     ATTR_LIST(moved_blocks_background),
> > >     ATTR_LIST(avg_vblocks),
> > >   #endif
> > > -#ifdef CONFIG_BLK_DEV_ZONED
> > > -   ATTR_LIST(unusable_blocks_per_sec),
> > > -#endif
> > >   #ifdef CONFIG_F2FS_FS_COMPRESSION
> > >     ATTR_LIST(compr_written_block),
> > >     ATTR_LIST(compr_saved_block),
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

