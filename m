Return-Path: <linux-kernel+bounces-88213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C33986DEB8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC4031F21A19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082D6A8CE;
	Fri,  1 Mar 2024 10:01:17 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A45A1E4BD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287276; cv=none; b=QiMk07dYiJEd0icfPiJ65OqJASoILyKs+FXx36FS6YBV1+Dygd7PesnOBKLGRAry6CVwpuWKlrIDFg6O7/1nkQFl3pKoZZxGEaJLDgreBMA6K3yEJKbTalbZT5NRr8mJG9t73/FE/CvS/RHTZv6bHDmzl6AGltH7rQkbVw2CGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287276; c=relaxed/simple;
	bh=6mAd+E7jEFzGhcEWC7no6EMaTPorIbMs6sgr/QAqZXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JLDDwh/PXPXZPu9Ulm2cMW1O1jFT6mBuQW7nBEP0G5FMqAfGXyn0B+iPD9p9SlnXgLHrQOniV8GYyLklr433MfszMpHZWH1EYg3NdaInPxxdN5V7/GN3N9AEK4nrV/L1If4K+Ra/bLJKRm576Z3YViKoMrvxH+6cONnrTeN0CCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TmNrK3VJ1z1vvmn;
	Fri,  1 Mar 2024 18:00:33 +0800 (CST)
Received: from dggpemm100001.china.huawei.com (unknown [7.185.36.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 86637140158;
	Fri,  1 Mar 2024 18:01:11 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm100001.china.huawei.com (7.185.36.93) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 18:01:11 +0800
Message-ID: <a262ed14-b2a4-4a15-91b5-9c88979a8338@huawei.com>
Date: Fri, 1 Mar 2024 18:01:10 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux Kernel Bug] UBSAN: shift-out-of-bounds in
 fault_around_bytes_set
Content-Language: en-US
To: Sam Sun <samsun1006219@gmail.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <akpm@linux-foundation.org>
CC: <syzkaller@googlegroups.com>
References: <CAEkJfYOvjjoTWMs6ozxF0P4_U050i8_YmvmhWO7YmhLmOBQWWw@mail.gmail.com>
From: Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <CAEkJfYOvjjoTWMs6ozxF0P4_U050i8_YmvmhWO7YmhLmOBQWWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100001.china.huawei.com (7.185.36.93)



On 2024/3/1 15:42, Sam Sun wrote:
> Dear developers and maintainers,
> 
> We found a shift-out-of-bounds bug in mm/memory.c. Kernel commit is b401b621758.
> Kernel config and C repro are attached to this email.
> UBSAN report is listed below.
> ```
> UBSAN: shift-out-of-bounds in /home/sy/linux-original/include/linux/log2.h:67:13
> shift exponent 4294967295 is too large for 64-bit type 'long unsigned int'
> CPU: 0 PID: 8091 Comm: syz-executor371 Not tainted 6.7.0-rc7 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x136/0x150 lib/dump_stack.c:106
>   ubsan_epilogue lib/ubsan.c:217 [inline]
>   __ubsan_handle_shift_out_of_bounds+0x24b/0x430 lib/ubsan.c:387
>   __rounddown_pow_of_two include/linux/log2.h:67 [inline]
>   fault_around_bytes_set.cold+0x19/0x1e mm/memory.c:4527
>   simple_attr_write_xsigned.constprop.0.isra.0+0x1ed/0x2d0 fs/libfs.c:1301
>   debugfs_attr_write_xsigned fs/debugfs/file.c:485 [inline]
>   debugfs_attr_write+0x74/0xa0 fs/debugfs/file.c:493
>   vfs_write+0x2a9/0xd80 fs/read_write.c:582
>   ksys_write+0x122/0x250 fs/read_write.c:637
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
>   entry_SYSCALL_64_after_hwframe+0x63/0x6b
> RIP: 0033:0x7fa30d5d7fcd
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48
> 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc8b7ee1b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007ffc8b7ee3b8 RCX: 00007fa30d5d7fcd
> RDX: 0000000000000002 RSI: 0000000020000040 RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffc8b7ee3b8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc8b7ee3a8 R14: 00007fa30d655530 R15: 0000000000000001
>   </TASK>
> ================================================================================
> ```
> In function simple_attr_write_xsigned, a user controlled string "buf"
> is copied and
> turned to long type by function "kstrtoll". If buf is "0", val passed
> to function
> fault_around_bytes_set is 0, which would trigger shift-out-of-bound bug.

Look like commit 53d36a56d8c4 ("mm: prefer fault_around_pages to 
fault_around_bytes") introduces the issue, please try the following change,

diff --git a/mm/memory.c b/mm/memory.c
index abd4f33d62c9..e17669d4f72f 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4776,7 +4776,8 @@ static int fault_around_bytes_set(void *data, u64 val)
          * The minimum value is 1 page, however this results in no 
fault-around
          * at all. See should_fault_around().
          */
-       fault_around_pages = max(rounddown_pow_of_two(val) >> 
PAGE_SHIFT, 1UL);
+       val = max(val, PAGE_SIZE);
+       fault_around_pages = rounddown_pow_of_two(val) >> PAGE_SHIFT;

         return 0;
  }



> 
> If you have any questions, please contact us.
> Reported by Yue Sun <samsun1006219@gmail.com>
> 
> Best Regards,
> Yue

