Return-Path: <linux-kernel+bounces-158126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A4888B1BE5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1E9E1F25105
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A1E6D1A0;
	Thu, 25 Apr 2024 07:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eao7xs7e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E776CDB9
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714030145; cv=none; b=B/oiyL0gNEZ8pyJZ0R6eTLIFMwriKVE27Qmi3p+kysduaB8/Bup3UKbfTXhTbCztRwlU0ZAEm2enuAbGPiruNjRY/YvIUq71JsP2SYqAR3DNwJchNT0b6QYU1qufMHZn/4Rf4gMLNMG1nLvq/uC4mZHdbvgTzZu2B24PZysUi1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714030145; c=relaxed/simple;
	bh=TMu1jwfsQ/Oo8+E5Wa0QXw/UAq3TJMY5lLS+uU0OvlU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=setJqVibSPW/4CHdvJz5OFs9FnmXkeuVvXoR8d7Z+RuY2hv5A1qpTczDzVL+o8SFJJHPDq71UYYkztiWquG2ceNuInF1/KCt6gmAK8RkmtUtnRB1T1V86vNc0+Cq3T7CeC+5WsgMfpo2P183+VcQ1aAub1e6Qpi4Rh1A/V5i/Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eao7xs7e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D5BC113CC;
	Thu, 25 Apr 2024 07:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714030144;
	bh=TMu1jwfsQ/Oo8+E5Wa0QXw/UAq3TJMY5lLS+uU0OvlU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=eao7xs7eNO2j399czeIB2LCNOIZelmdeBPAPqbI/lRYrpPgvFZ0ItANB/zruhYRPb
	 CcF/KlcJ7KrXW4I+wA5XbEv2ldnuqTFQpMdrlVzNqTg1xnUSsnyHGgWnuTp65BM9i+
	 iv/bl5Kd99oLtq7Lbr2M8y/RXKjq5cMZlegMnYhrM4FTuppHb2YDf/1AQE7HyoTMaO
	 TehQPpKLVZaSCMQntuIei7apafd6It+A1VpKBhqR8AOjy6l7dmaYxfv6MUjtpHBwaJ
	 m7kycPHcc5RyQiPMQh8bUsusjmSBQd9EPKVSeeg56OLOX9ns98ai4p+uvMOCkDGSuK
	 w+MTBD8xE9o2w==
Message-ID: <49a4cc15-299f-432c-85c7-ab1b1daaaad1@kernel.org>
Date: Thu, 25 Apr 2024 15:29:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix false alarm on invalid block
 address
To: Juhyung Park <qkrwngud825@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
References: <20240409203411.1885121-1-jaegeuk@kernel.org>
 <20240409203411.1885121-3-jaegeuk@kernel.org>
 <050a93dc-d9a8-44bd-9a83-83718e95f04d@kernel.org>
 <Zhmf4klcOr4eplin@google.com>
 <CAD14+f0Scnc1GTjqR1izHqPerCqgHsLMR9mfKocUxw_4hyZ+Zg@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAD14+f0Scnc1GTjqR1izHqPerCqgHsLMR9mfKocUxw_4hyZ+Zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/4/19 18:27, Juhyung Park wrote:
> On Sat, Apr 13, 2024 at 5:57 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>
>> On 04/11, Chao Yu wrote:
>>> On 2024/4/10 4:34, Jaegeuk Kim wrote:
>>>> f2fs_ra_meta_pages can try to read ahead on invalid block address which is
>>>> not the corruption case.
>>>
>>> In which case we will read ahead invalid meta pages? recovery w/ META_POR?
> 
> In my case, it seems like it's META_SIT, and it's triggered right after mount.

Ah, I see, actually it hits at this case, thanks for the information.

Thanks,

> fsck detects invalid_blkaddr, and when the kernel mounts it, it
> immediately flags invalid_blkaddr again:
> 
> [    6.333498] init: [libfs_mgr] Running /system/bin/fsck.f2fs -a -c
> 10000 --debug-cache /dev/block/sda13
> [    6.337671] fsck.f2fs: Info: Fix the reported corruption.
> [    6.337947] fsck.f2fs: Info: not exist /proc/version!
> [    6.338010] fsck.f2fs: Info: can't find /sys, assuming normal block device
> [    6.338294] fsck.f2fs: Info: MKFS version
> [    6.338319] fsck.f2fs:   "5.10.160-android12-9-ge5cfec41c8e2"
> [    6.338366] fsck.f2fs: Info: FSCK version
> [    6.338380] fsck.f2fs:   from "5.10-arter97"
> [    6.338393] fsck.f2fs:     to "5.10-arter97"
> [    6.338414] fsck.f2fs: Info: superblock features = 1499 :  encrypt
> verity extra_attr project_quota quota_ino casefold
> [    6.338429] fsck.f2fs: Info: superblock encrypt level = 0, salt =
> 00000000000000000000000000000000
> [    6.338442] fsck.f2fs: Info: checkpoint stop reason: shutdown(180)
> [    6.338455] fsck.f2fs: Info: fs errors: invalid_blkaddr
> [    6.338468] fsck.f2fs: Info: Segments per section = 1
> [    6.338480] fsck.f2fs: Info: Sections per zone = 1
> [    6.338492] fsck.f2fs: Info: total FS sectors = 58971571 (230357 MB)
> [    6.340599] fsck.f2fs: Info: CKPT version = 2b7e3b29
> [    6.340620] fsck.f2fs: Info: version timestamp cur: 19789296, prev: 18407008
> [    6.677041] fsck.f2fs: Info: checkpoint state = 46 :  crc
> compacted_summary orphan_inodes sudden-power-off
> [    6.677052] fsck.f2fs: [FSCK] Check node 1 / 712937 (0.00%)
> [    8.997922] fsck.f2fs: [FSCK] Check node 71294 / 712937 (10.00%)
> [   10.629205] fsck.f2fs: [FSCK] Check node 142587 / 712937 (20.00%)
> [   12.278186] fsck.f2fs: [FSCK] Check node 213880 / 712937 (30.00%)
> [   13.768177] fsck.f2fs: [FSCK] Check node 285173 / 712937 (40.00%)
> [   17.446971] fsck.f2fs: [FSCK] Check node 356466 / 712937 (50.00%)
> [   19.891623] fsck.f2fs: [FSCK] Check node 427759 / 712937 (60.00%)
> [   23.251327] fsck.f2fs: [FSCK] Check node 499052 / 712937 (70.00%)
> [   28.493457] fsck.f2fs: [FSCK] Check node 570345 / 712937 (80.00%)
> [   29.640800] fsck.f2fs: [FSCK] Check node 641638 / 712937 (90.00%)
> [   30.718347] fsck.f2fs: [FSCK] Check node 712931 / 712937 (100.00%)
> [   30.724176] fsck.f2fs:
> [   30.737160] fsck.f2fs: [FSCK] Max image size: 167506 MB, Free space: 62850 MB
> [   30.737164] fsck.f2fs: [FSCK] Unreachable nat entries
>           [Ok..] [0x0]
> [   30.737638] fsck.f2fs: [FSCK] SIT valid block bitmap checking
>           [Ok..]
> [   30.737640] fsck.f2fs: [FSCK] Hard link checking for regular file
>           [Ok..] [0xd]
> [   30.737641] fsck.f2fs: [FSCK] valid_block_count matching with CP
>           [Ok..] [0x28b98e6]
> [   30.737644] fsck.f2fs: [FSCK] valid_node_count matching with CP (de
> lookup)  [Ok..] [0xae0e9]
> [   30.737646] fsck.f2fs: [FSCK] valid_node_count matching with CP
> (nat lookup) [Ok..] [0xae0e9]
> [   30.737647] fsck.f2fs: [FSCK] valid_inode_count matched with CP
>           [Ok..] [0xa74a3]
> [   30.737649] fsck.f2fs: [FSCK] free segment_count matched with CP
>           [Ok..] [0x7aa3]
> [   30.737662] fsck.f2fs: [FSCK] next block offset is free
>           [Ok..]
> [   30.737663] fsck.f2fs: [FSCK] fixing SIT types
> [   30.737867] fsck.f2fs: [FSCK] other corrupted bugs
>           [Ok..]
> [   30.737893] fsck.f2fs: [update_superblock: 765] Info: Done to
> update superblock
> [   30.960610] fsck.f2fs:
> [   30.960618] fsck.f2fs: Done: 24.622956 secs
> [   30.960620] fsck.f2fs:
> [   30.960622] fsck.f2fs: c, u, RA, CH, CM, Repl=
> [   30.960627] fsck.f2fs: 10000 10000 43600517 42605434 995083 985083
> [   30.963274] F2FS-fs (sda13): Using encoding defined by superblock:
> utf8-12.1.0 with flags 0x0
> [   30.995360] __f2fs_is_valid_blkaddr: type=2
> 
> (Manually added that print ^)
> 
> [   30.995369] ------------[ cut here ]------------
> [   30.995375] WARNING: CPU: 7 PID: 1 at f2fs_handle_error+0x18/0x3c
> [   30.995378] CPU: 7 PID: 1 Comm: init Tainted: G S      W
> 5.10.209-arter97-r15-kernelsu-g0867d0e4f1d2 #6
> [   30.995379] Hardware name: Qualcomm Technologies, Inc. Cape QRD
> with PM8010 (DT)
> [   30.995380] pstate: 22400005 (nzCv daif +PAN -UAO +TCO BTYPE=--)
> [   30.995382] pc : f2fs_handle_error+0x18/0x3c
> [   30.995384] lr : __f2fs_is_valid_blkaddr+0x2a4/0x2b0
> [   30.995385] sp : ffffff80209e79b0
> [   30.995386] x29: ffffff80209e79b0 x28: 0000000000000037
> [   30.995388] x27: 00000000000001c7 x26: 0000000020120121
> [   30.995389] x25: 00000000000000d9 x24: 0000000000000000
> [   30.995390] x23: ffffffff00f1a700 x22: 0000000000000828
> [   30.995391] x21: ffffff80462aa000 x20: ffffff80462aa000
> [   30.995392] x19: 0000000000000002 x18: ffffffffffffffff
> [   30.995393] x17: 0000000000000000 x16: 00000000ffff0000
> [   30.995394] x15: 0000000000000004 x14: ffffffd1675ac6d0
> [   30.995395] x13: 0000000000000003 x12: 0000000000000003
> [   30.995396] x11: 00000000ffffffff x10: 0000000000000000
> [   30.995397] x9 : 0000000100000001 x8 : 0000000100000000
> [   30.995398] x7 : 64696c61765f7369 x6 : ffffffd1681279e8
> [   30.995399] x5 : 000000000000001f x4 : 0000000000000001
> [   30.995400] x3 : 0000000000000000 x2 : ffffff89f03dedc8
> [   30.995401] x1 : 0000000000000002 x0 : ffffff80462aa000
> [   30.995403] Call trace:
> [   30.995404] f2fs_handle_error+0x18/0x3c
> [   30.995405] __f2fs_is_valid_blkaddr+0x2a4/0x2b0
> [   30.995406] f2fs_is_valid_blkaddr+0x10/0x20
> [   30.995407] f2fs_ra_meta_pages+0xe0/0x230
> [   30.995409] build_sit_entries+0xa8/0x580
> [   30.995411] f2fs_build_segment_manager+0x124/0x170
> [   30.995412] f2fs_fill_super+0x78c/0xd1c
> [   30.995415] mount_bdev+0x168/0x1ac
> [   30.995416] f2fs_mount+0x18/0x24
> [   30.995418] legacy_get_tree.llvm.9147845779559715083+0x30/0x5c
> [   30.995419] vfs_get_tree+0x30/0xe0
> [   30.995421] do_new_mount+0x140/0x358
> [   30.995422] path_mount+0x1fc/0x4e8
> [   30.995423] __arm64_sys_mount+0x150/0x294
> [   30.995425] el0_svc_common.llvm.15698454952154965787+0xa8/0x138
> [   30.995426] do_el0_svc+0x24/0x90
> [   30.995429] el0_svc+0x10/0x1c
> [   30.995430] el0_sync_handler+0xcc/0xe4
> [   30.995432] el0_sync+0x1a0/0x1c0
> [   30.995433] ---[ end trace 3b83295e0cdac94e ]---
> [   31.005011] F2FS-fs (sda13): Mounted with checkpoint version = 2b7e3b29
> [   31.005176] init: [libfs_mgr]
> __mount(source=/dev/block/bootdevice/by-name/userdata,target=/data,type=f2fs)=0:
> Success
> [   31.007749] init: Userdata mounted using /vendor/etc/fstab.qcom result : 0
> 
> 
> I was bisecting a long boot time (24 additional seconds) issue, which
> is always reproducible, and found commit 31f85ccc84b8 ("f2fs: unify
> the error handling of f2fs_is_valid_blkaddr") to be causing it.
> 
> I'll just revert that patch locally. Seems like Jaegeuk's dev branch
> doesn't have the fix for this specifically yet.
> 
> Thanks.
> 
>>
>> I was trying to debug another issue, but found the root cause. Let me drop this
>> patch.
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
>>>> ---
>>>>    fs/f2fs/checkpoint.c | 9 +++++----
>>>>    1 file changed, 5 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
>>>> index eac698b8dd38..b01320502624 100644
>>>> --- a/fs/f2fs/checkpoint.c
>>>> +++ b/fs/f2fs/checkpoint.c
>>>> @@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>>              break;
>>>>      case META_SIT:
>>>>              if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
>>>> -                   goto err;
>>>> +                   goto check_only;
>>>>              break;
>>>>      case META_SSA:
>>>>              if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
>>>>                      blkaddr < SM_I(sbi)->ssa_blkaddr))
>>>> -                   goto err;
>>>> +                   goto check_only;
>>>>              break;
>>>>      case META_CP:
>>>>              if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
>>>>                      blkaddr < __start_cp_addr(sbi)))
>>>> -                   goto err;
>>>> +                   goto check_only;
>>>>              break;
>>>>      case META_POR:
>>>>              if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
>>>>                      blkaddr < MAIN_BLKADDR(sbi)))
>>>> -                   goto err;
>>>> +                   goto check_only;
>>>>              break;
>>>>      case DATA_GENERIC:
>>>>      case DATA_GENERIC_ENHANCE:
>>>> @@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
>>>>      return true;
>>>>    err:
>>>>      f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
>>>> +check_only:
>>>>      return false;
>>>>    }
>>
>>
>> _______________________________________________
>> Linux-f2fs-devel mailing list
>> Linux-f2fs-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

