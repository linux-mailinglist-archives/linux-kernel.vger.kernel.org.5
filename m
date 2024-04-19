Return-Path: <linux-kernel+bounces-151318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 584498AACCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43B81F2194A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036BD7D408;
	Fri, 19 Apr 2024 10:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rp+SNQ87"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D85B78276
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522456; cv=none; b=ZL+tku6fD4tSfFCUbBw1/vgBQQ9VphQ609Cb/acmSR3RrjH5245HQDv5i23tKbF3ykj96IYFNaeHIHLy2XhWtckbvqbuDlLxAJRYWGAEph175R5tiqi00CN09Z3ELF3SiXITBEjS5IGVRR7gmAr6f8g16xF63rEWkBGkdMfFkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522456; c=relaxed/simple;
	bh=akJ3UOzwy9Ko4wMDhjh3beJfY0oqhz0kPPt9UTqx36I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rS/kdo7+28vXw152/HI6gVM0hUeLgz57ZHE1CNKGgw8xLFQjKQVkLMpZzZp0OvTF5HAaB2YyAimYF+LRwGwwpmPhmn5eGQpyBiipCjzMNQqijirbWE7RwdXRY9ZHh9wA2uKFUjF9tK97jwg5bFaz8IYV2Jh4w+HID3CoSOzocoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rp+SNQ87; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a557044f2ddso190323966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 03:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713522452; x=1714127252; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ymktnwao7az+LFVgnqD7jFOZn9xsvS/2Wg2WVoxC6nM=;
        b=Rp+SNQ87rHLPStJkfQIvheS6cwpd23sCcS86Ej33DrYIaEVT9cur75s7aOfgKS3PKm
         a1EtfGjn5ncoSlwJbllO6iSaA7EQQ/viLQsR5PZXwDZOa7rL3LK6w7WGVGb7L4ID1qgl
         letlfV4hfZvDW80bg53/urDnz0B4+Bm8yIVGa7W6zBGH66PuqATSzSXt9D3uD2QFD0GD
         8Vn0Jjj/J4gTP88jeGQ0L0mO8YGy9mM/s7tf8Ua5N9qauJXIbGKt4Lu4Sogmqvx1syZ9
         42xX4Ox5Jky/SVb+d4Rb+GZ9xSsQVXiJrySAulS3fMZIdKREmD8sH5AQB99lgATiSbY+
         UPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713522452; x=1714127252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ymktnwao7az+LFVgnqD7jFOZn9xsvS/2Wg2WVoxC6nM=;
        b=QchT2BgDqoUOQELepZlYALX7N6Quz1Uf64f0q9hci9asEa5BgJJNwtSaQGXmV7mZez
         ePjGb2j8gbXbc6Zhu//CxvnphBXhweK7j0YePteCDMhlPlbzBrG0W3hkrfgJDGi0QNes
         IS9n1X89sGU8X2i7c24o367qle+JjXDIPFjiBsLniteWO6fGY6kfyaXj2XJFojcIz3fb
         oNOz9bcWlKzqPkKcUFl/ypt3fbYYbV9rHWH0wMZx9abnPMtb+OGtUE0eWawA2/8aMLAD
         0h5dLU5ZtNPlLG437Tx0wOxgS0L9LrHw0W31K7Z01Z5LmK44n/r/TiAbRteZZB/KLWBJ
         raTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKURPjqT+po8rv7eVSk3wB4jNz/7x3s66BAILE41HYVd1OQMbh3TrdvHz+hbat6m8fI8bN7lRgN4Y+G/PxT90ARVR0A6imwHeaM9Ru
X-Gm-Message-State: AOJu0YwB41T1ZExKOyXiNgE1qc6aHgyvzrSUNk7FymXGjWC8fyeE/iqg
	lDtSThJjkPFkBvUoklGoA00U8iOrm/ZkkDAZbkJfbYompY+AjzsyMi0as7/Mrd7wy+y7EawxWS9
	Joic7jZO4GTLNAjYWEZec5FdLpok=
X-Google-Smtp-Source: AGHT+IGNgyYc3Ns8gPxZxDY0qvdByFCwb6qp9WjshdssbYI1zEO97pv9KF5rehMhOHBnSyL86mcxAo8wECu8xQfQNKQ=
X-Received: by 2002:a17:906:7fc6:b0:a52:3f01:e11d with SMTP id
 r6-20020a1709067fc600b00a523f01e11dmr1268730ejs.34.1713522452118; Fri, 19 Apr
 2024 03:27:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409203411.1885121-1-jaegeuk@kernel.org> <20240409203411.1885121-3-jaegeuk@kernel.org>
 <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org> <Zhmf4klcOr4eplin@google.com>
In-Reply-To: <Zhmf4klcOr4eplin@google.com>
From: Juhyung Park <qkrwngud825@gmail.com>
Date: Fri, 19 Apr 2024 19:27:20 +0900
Message-ID: <CAD14+f0Scnc1GTjqR1izHqPerCqgHsLMR9mfKocUxw_4hyZ+Zg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix false alarm on invalid block address
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 5:57=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 04/11, Chao Yu wrote:
> > On 2024/4/10 4:34, Jaegeuk Kim wrote:
> > > f2fs_ra_meta_pages can try to read ahead on invalid block address whi=
ch is
> > > not the corruption case.
> >
> > In which case we will read ahead invalid meta pages? recovery w/ META_P=
OR?

In my case, it seems like it's META_SIT, and it's triggered right after mou=
nt.
fsck detects invalid_blkaddr, and when the kernel mounts it, it
immediately flags invalid_blkaddr again:

[    6.333498] init: [libfs_mgr] Running /system/bin/fsck.f2fs -a -c
10000 --debug-cache /dev/block/sda13
[    6.337671] fsck.f2fs: Info: Fix the reported corruption.
[    6.337947] fsck.f2fs: Info: not exist /proc/version!
[    6.338010] fsck.f2fs: Info: can't find /sys, assuming normal block devi=
ce
[    6.338294] fsck.f2fs: Info: MKFS version
[    6.338319] fsck.f2fs:   "5.10.160-android12-9-ge5cfec41c8e2"
[    6.338366] fsck.f2fs: Info: FSCK version
[    6.338380] fsck.f2fs:   from "5.10-arter97"
[    6.338393] fsck.f2fs:     to "5.10-arter97"
[    6.338414] fsck.f2fs: Info: superblock features =3D 1499 :  encrypt
verity extra_attr project_quota quota_ino casefold
[    6.338429] fsck.f2fs: Info: superblock encrypt level =3D 0, salt =3D
00000000000000000000000000000000
[    6.338442] fsck.f2fs: Info: checkpoint stop reason: shutdown(180)
[    6.338455] fsck.f2fs: Info: fs errors: invalid_blkaddr
[    6.338468] fsck.f2fs: Info: Segments per section =3D 1
[    6.338480] fsck.f2fs: Info: Sections per zone =3D 1
[    6.338492] fsck.f2fs: Info: total FS sectors =3D 58971571 (230357 MB)
[    6.340599] fsck.f2fs: Info: CKPT version =3D 2b7e3b29
[    6.340620] fsck.f2fs: Info: version timestamp cur: 19789296, prev: 1840=
7008
[    6.677041] fsck.f2fs: Info: checkpoint state =3D 46 :  crc
compacted_summary orphan_inodes sudden-power-off
[    6.677052] fsck.f2fs: [FSCK] Check node 1 / 712937 (0.00%)
[    8.997922] fsck.f2fs: [FSCK] Check node 71294 / 712937 (10.00%)
[   10.629205] fsck.f2fs: [FSCK] Check node 142587 / 712937 (20.00%)
[   12.278186] fsck.f2fs: [FSCK] Check node 213880 / 712937 (30.00%)
[   13.768177] fsck.f2fs: [FSCK] Check node 285173 / 712937 (40.00%)
[   17.446971] fsck.f2fs: [FSCK] Check node 356466 / 712937 (50.00%)
[   19.891623] fsck.f2fs: [FSCK] Check node 427759 / 712937 (60.00%)
[   23.251327] fsck.f2fs: [FSCK] Check node 499052 / 712937 (70.00%)
[   28.493457] fsck.f2fs: [FSCK] Check node 570345 / 712937 (80.00%)
[   29.640800] fsck.f2fs: [FSCK] Check node 641638 / 712937 (90.00%)
[   30.718347] fsck.f2fs: [FSCK] Check node 712931 / 712937 (100.00%)
[   30.724176] fsck.f2fs:
[   30.737160] fsck.f2fs: [FSCK] Max image size: 167506 MB, Free space: 628=
50 MB
[   30.737164] fsck.f2fs: [FSCK] Unreachable nat entries
         [Ok..] [0x0]
[   30.737638] fsck.f2fs: [FSCK] SIT valid block bitmap checking
         [Ok..]
[   30.737640] fsck.f2fs: [FSCK] Hard link checking for regular file
         [Ok..] [0xd]
[   30.737641] fsck.f2fs: [FSCK] valid_block_count matching with CP
         [Ok..] [0x28b98e6]
[   30.737644] fsck.f2fs: [FSCK] valid_node_count matching with CP (de
lookup)  [Ok..] [0xae0e9]
[   30.737646] fsck.f2fs: [FSCK] valid_node_count matching with CP
(nat lookup) [Ok..] [0xae0e9]
[   30.737647] fsck.f2fs: [FSCK] valid_inode_count matched with CP
         [Ok..] [0xa74a3]
[   30.737649] fsck.f2fs: [FSCK] free segment_count matched with CP
         [Ok..] [0x7aa3]
[   30.737662] fsck.f2fs: [FSCK] next block offset is free
         [Ok..]
[   30.737663] fsck.f2fs: [FSCK] fixing SIT types
[   30.737867] fsck.f2fs: [FSCK] other corrupted bugs
         [Ok..]
[   30.737893] fsck.f2fs: [update_superblock: 765] Info: Done to
update superblock
[   30.960610] fsck.f2fs:
[   30.960618] fsck.f2fs: Done: 24.622956 secs
[   30.960620] fsck.f2fs:
[   30.960622] fsck.f2fs: c, u, RA, CH, CM, Repl=3D
[   30.960627] fsck.f2fs: 10000 10000 43600517 42605434 995083 985083
[   30.963274] F2FS-fs (sda13): Using encoding defined by superblock:
utf8-12.1.0 with flags 0x0
[   30.995360] __f2fs_is_valid_blkaddr: type=3D2

(Manually added that print ^)

[   30.995369] ------------[ cut here ]------------
[   30.995375] WARNING: CPU: 7 PID: 1 at f2fs_handle_error+0x18/0x3c
[   30.995378] CPU: 7 PID: 1 Comm: init Tainted: G S      W
5.10.209-arter97-r15-kernelsu-g0867d0e4f1d2 #6
[   30.995379] Hardware name: Qualcomm Technologies, Inc. Cape QRD
with PM8010 (DT)
[   30.995380] pstate: 22400005 (nzCv daif +PAN -UAO +TCO BTYPE=3D--)
[   30.995382] pc : f2fs_handle_error+0x18/0x3c
[   30.995384] lr : __f2fs_is_valid_blkaddr+0x2a4/0x2b0
[   30.995385] sp : ffffff80209e79b0
[   30.995386] x29: ffffff80209e79b0 x28: 0000000000000037
[   30.995388] x27: 00000000000001c7 x26: 0000000020120121
[   30.995389] x25: 00000000000000d9 x24: 0000000000000000
[   30.995390] x23: ffffffff00f1a700 x22: 0000000000000828
[   30.995391] x21: ffffff80462aa000 x20: ffffff80462aa000
[   30.995392] x19: 0000000000000002 x18: ffffffffffffffff
[   30.995393] x17: 0000000000000000 x16: 00000000ffff0000
[   30.995394] x15: 0000000000000004 x14: ffffffd1675ac6d0
[   30.995395] x13: 0000000000000003 x12: 0000000000000003
[   30.995396] x11: 00000000ffffffff x10: 0000000000000000
[   30.995397] x9 : 0000000100000001 x8 : 0000000100000000
[   30.995398] x7 : 64696c61765f7369 x6 : ffffffd1681279e8
[   30.995399] x5 : 000000000000001f x4 : 0000000000000001
[   30.995400] x3 : 0000000000000000 x2 : ffffff89f03dedc8
[   30.995401] x1 : 0000000000000002 x0 : ffffff80462aa000
[   30.995403] Call trace:
[   30.995404] f2fs_handle_error+0x18/0x3c
[   30.995405] __f2fs_is_valid_blkaddr+0x2a4/0x2b0
[   30.995406] f2fs_is_valid_blkaddr+0x10/0x20
[   30.995407] f2fs_ra_meta_pages+0xe0/0x230
[   30.995409] build_sit_entries+0xa8/0x580
[   30.995411] f2fs_build_segment_manager+0x124/0x170
[   30.995412] f2fs_fill_super+0x78c/0xd1c
[   30.995415] mount_bdev+0x168/0x1ac
[   30.995416] f2fs_mount+0x18/0x24
[   30.995418] legacy_get_tree.llvm.9147845779559715083+0x30/0x5c
[   30.995419] vfs_get_tree+0x30/0xe0
[   30.995421] do_new_mount+0x140/0x358
[   30.995422] path_mount+0x1fc/0x4e8
[   30.995423] __arm64_sys_mount+0x150/0x294
[   30.995425] el0_svc_common.llvm.15698454952154965787+0xa8/0x138
[   30.995426] do_el0_svc+0x24/0x90
[   30.995429] el0_svc+0x10/0x1c
[   30.995430] el0_sync_handler+0xcc/0xe4
[   30.995432] el0_sync+0x1a0/0x1c0
[   30.995433] ---[ end trace 3b83295e0cdac94e ]---
[   31.005011] F2FS-fs (sda13): Mounted with checkpoint version =3D 2b7e3b2=
9
[   31.005176] init: [libfs_mgr]
__mount(source=3D/dev/block/bootdevice/by-name/userdata,target=3D/data,type=
=3Df2fs)=3D0:
Success
[   31.007749] init: Userdata mounted using /vendor/etc/fstab.qcom result :=
 0


I was bisecting a long boot time (24 additional seconds) issue, which
is always reproducible, and found commit 31f85ccc84b8 ("f2fs: unify
the error handling of f2fs_is_valid_blkaddr") to be causing it.

I'll just revert that patch locally. Seems like Jaegeuk's dev branch
doesn't have the fix for this specifically yet.

Thanks.

>
> I was trying to debug another issue, but found the root cause. Let me dro=
p this
> patch.
>
> >
> > Thanks,
> >
> > >
> > > Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid=
_blkaddr")
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > > ---
> > >   fs/f2fs/checkpoint.c | 9 +++++----
> > >   1 file changed, 5 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > index eac698b8dd38..b01320502624 100644
> > > --- a/fs/f2fs/checkpoint.c
> > > +++ b/fs/f2fs/checkpoint.c
> > > @@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs=
_sb_info *sbi,
> > >             break;
> > >     case META_SIT:
> > >             if (unlikely(blkaddr >=3D SIT_BLK_CNT(sbi)))
> > > -                   goto err;
> > > +                   goto check_only;
> > >             break;
> > >     case META_SSA:
> > >             if (unlikely(blkaddr >=3D MAIN_BLKADDR(sbi) ||
> > >                     blkaddr < SM_I(sbi)->ssa_blkaddr))
> > > -                   goto err;
> > > +                   goto check_only;
> > >             break;
> > >     case META_CP:
> > >             if (unlikely(blkaddr >=3D SIT_I(sbi)->sit_base_addr ||
> > >                     blkaddr < __start_cp_addr(sbi)))
> > > -                   goto err;
> > > +                   goto check_only;
> > >             break;
> > >     case META_POR:
> > >             if (unlikely(blkaddr >=3D MAX_BLKADDR(sbi) ||
> > >                     blkaddr < MAIN_BLKADDR(sbi)))
> > > -                   goto err;
> > > +                   goto check_only;
> > >             break;
> > >     case DATA_GENERIC:
> > >     case DATA_GENERIC_ENHANCE:
> > > @@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_s=
b_info *sbi,
> > >     return true;
> > >   err:
> > >     f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
> > > +check_only:
> > >     return false;
> > >   }
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

