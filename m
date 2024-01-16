Return-Path: <linux-kernel+bounces-27694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5834082F43F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA520B21690
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B51B1CD39;
	Tue, 16 Jan 2024 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rDt6lp7T"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756021CD21
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705429761; cv=none; b=SUkqZ3I92sig0Yarn1C/CCIVem9dAis1HH3b9rSdKvYWCj2ib5zCEL+oj8ShRIt+jlzTtX+834kLQoP/fHyFB6BMs7Tx/YFpHm13BP7g4u4gAxQ0SBDaiWpWxRvnJWUrr9tKnSyPQ+w9YGNPrx6UbE6plf01R2G/VyPG7FcFTu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705429761; c=relaxed/simple;
	bh=wEOXEHxlPFfQySz0/lYwk3N4GjHtmvnUZtcMTz27B4E=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 From:To:References:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=rG/a6AnLlTvFdS/Gi1JCVxyt2Wyyd1VmnBJtknqrO2M0FCxnBVB9yC9zMt3LkpQU1rgtSUuLq6+4AfCS7yb9zdaOX1SslhbaXl/i3XBwDdxwdfuXhDGaU1Od9qc4Y81zxTfaRTvStTOk1Ufbvlzbj+XNpT/Xe4iz7MmLfRXlXks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rDt6lp7T; arc=none smtp.client-ip=209.85.166.180
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-35d374bebe3so7501465ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 10:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1705429758; x=1706034558; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=veNPUkKF1HjNVPxzlUqZ4yFozAAQyN3eYiE18FDsQpA=;
        b=rDt6lp7Tkph6DUhPuK733ouH0Jz1buz/8AilHqOOCSxf6Q6KSgw4yGS4fU9lf6kFRy
         sJiUTBzltnFGsZ/RGs7tF/1nSdKbLYPtwWEpJRQmp3oCqnROeENJZmMrP1+h0lklmUfg
         QcUej0FKFhvW3D4l9BWBZdyIT7j+D6sL+IODA5jgunaNqUS5Fh4AKhO8/v8LVtNw/9pr
         1ucAjvThPKHYg2Diciz4s2DnmrrJG+biR9J0FEo+HQzAo8Gbhg00pCAFdsP2BvRhFHn0
         X0pqUr+uKc305lXx3keFHjGlZkNAeU1qFwwfsv9WbBF9dWgrta29PZO0VrpOvpjQh+4t
         yOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705429758; x=1706034558;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=veNPUkKF1HjNVPxzlUqZ4yFozAAQyN3eYiE18FDsQpA=;
        b=QqXQQL/YRfqgN3QbvvsFsX7/p+4PVR4Nr2HboDDiip0IUI8+PCdrfv9cdsa80pPu+h
         5a4nKLwhofv+Z3jS1s9qFRFyD0gUg8Pd3vRDMu+Z867I3pUSWbbnigx8P4h8YsjwNAJO
         aeUxseqS52bDuxiU4ggxh74a86jJvGws6Xi8SZABA5ZXjLOlekX3TtAaydrrWl+csq14
         VDCLUL3scP/hi/ZPPe+fKQOC7za0xKRvUufbgl0Lzl8jqrqdxmF0Sj9R9McpXY864cAg
         3YWWcwDLmpZfIZWUOQ1oYMFeVaGgLoEuMycWPsn84bMTB/QQWNHJ35Pu6tVAxlGKMXpY
         QXOQ==
X-Gm-Message-State: AOJu0Yzqo6aAB4cV7wAlbjagWq3G2JzC5Riq5r1HwISr0JV2Z8ZW9pHc
	udjQExnzWnpBPbCC+xXcqAzPc5Uf+PMJmw==
X-Google-Smtp-Source: AGHT+IFgk0Ydn2bjVl6ukcjpg15ulvFXA48ksc2GozqT3iJl1bCchjFJH8EJX+yxDaLBD2lgANLT/Q==
X-Received: by 2002:a92:c561:0:b0:35f:fa79:644 with SMTP id b1-20020a92c561000000b0035ffa790644mr14016283ilj.3.1705429758607;
        Tue, 16 Jan 2024 10:29:18 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ck12-20020a056e02370c00b003608a649906sm3670625ilb.43.2024.01.16.10.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 10:29:17 -0800 (PST)
Message-ID: <487a298c-710d-4c04-8901-da584e1b3038@kernel.dk>
Date: Tue, 16 Jan 2024 11:29:17 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [block?] BUG: unable to handle kernel NULL pointer
 dereference in __bio_release_pages
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
To: syzbot <syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzkaller-bugs@googlegroups.com, Matthew Wilcox <willy@infradead.org>
References: <000000000000dbe2f2060f0d2781@google.com>
 <4bd438c0-75b8-4e28-939c-954716df7563@kernel.dk>
In-Reply-To: <4bd438c0-75b8-4e28-939c-954716df7563@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/16/24 11:00 AM, Jens Axboe wrote:
> On 1/16/24 2:57 AM, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    052d534373b7 Merge tag 'exfat-for-6.8-rc1' of git://git.ke..
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=17957913e80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=9603f9823d535d97
>> dashboard link: https://syzkaller.appspot.com/bug?extid=004c1e0fced2b4bc3dcc
>> compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
>> userspace arch: arm64
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13529733e80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=166850dde80000
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-052d5343.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/74cc52d4cc15/vmlinux-052d5343.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/a2da7e6a234c/Image-052d5343.gz.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+004c1e0fced2b4bc3dcc@syzkaller.appspotmail.com
>>
>> Unable to handle kernel paging request at virtual address dfff800000000001
>> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>> Mem abort info:
>>   ESR = 0x0000000096000005
>>   EC = 0x25: DABT (current EL), IL = 32 bits
>>   SET = 0, FnV = 0
>>   EA = 0, S1PTW = 0
>>   FSC = 0x05: level 1 translation fault
>> Data abort info:
>>   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>>   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>>   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>> [dfff800000000001] address between user and kernel address ranges
>> Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>> Modules linked in:
>> CPU: 1 PID: 3139 Comm: syz-executor303 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
>> Hardware name: linux,dummy-virt (DT)
>> pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> pc : _compound_head include/linux/page-flags.h:247 [inline]
>> pc : bio_first_folio include/linux/bio.h:289 [inline]
>> pc : __bio_release_pages+0x100/0x73c block/bio.c:1153
>> lr : bio_release_pages include/linux/bio.h:508 [inline]
>> lr : blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
>> sp : ffff800089a375e0
>> x29: ffff800089a375e0 x28: 1fffe0000162e879 x27: ffff00000b1743c0
>> x26: ffff00000b1743c8 x25: 000000000000000a x24: 1fffe000015a9e12
>> x23: ffff00000ad4f094 x22: ffff00000f496600 x21: 1fffe0000162e87a
>> x20: 0000000000000004 x19: 0000000000000000 x18: ffff00000b174432
>> x17: ffff00000b174438 x16: ffff00000f948008 x15: 1fffe0000162e886
>> x14: ffff00000b1743d4 x13: 00000000f1f1f1f1 x12: ffff6000015a9e13
>> x11: 1fffe000015a9e12 x10: ffff6000015a9e12 x9 : dfff800000000000
>> x8 : ffff00000b1743d4 x7 : 0000000041b58ab3 x6 : 1ffff00011346ed0
>> x5 : ffff700011346ed0 x4 : 00000000f1f1f1f1 x3 : 000000000000f1f1
>> x2 : 0000000000000001 x1 : dfff800000000000 x0 : 0000000000000008
>> Call trace:
>>  _compound_head include/linux/page-flags.h:247 [inline]
>>  bio_first_folio include/linux/bio.h:289 [inline]
>>  __bio_release_pages+0x100/0x73c block/bio.c:1153
>>  bio_release_pages include/linux/bio.h:508 [inline]
>>  blkdev_bio_end_io+0x2a0/0x3f0 block/fops.c:157
>>  bio_endio+0x4a4/0x618 block/bio.c:1608
>>  __blkdev_direct_IO block/fops.c:213 [inline]
>>  blkdev_direct_IO.part.0+0xf08/0x13c0 block/fops.c:379
>>  blkdev_direct_IO block/fops.c:370 [inline]
>>  blkdev_direct_write block/fops.c:648 [inline]
>>  blkdev_write_iter+0x430/0x91c block/fops.c:706
>>  call_write_iter include/linux/fs.h:2085 [inline]
>>  do_iter_readv_writev+0x194/0x298 fs/read_write.c:741
>>  vfs_writev+0x244/0x684 fs/read_write.c:971
>>  do_pwritev+0x15c/0x1e0 fs/read_write.c:1072
>>  __do_sys_pwritev2 fs/read_write.c:1131 [inline]
>>  __se_sys_pwritev2 fs/read_write.c:1122 [inline]
>>  __arm64_sys_pwritev2+0xac/0x120 fs/read_write.c:1122
>>  __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
>>  invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:51
>>  el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:136
>>  do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:155
>>  el0_svc+0x58/0x140 arch/arm64/kernel/entry-common.c:678
>>  el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:696
>>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:595
>> Code: d2d00001 f2fbffe1 91002260 d343fc02 (38e16841) 
>> ---[ end trace 0000000000000000 ]---
>> ----------------
>> Code disassembly (best guess):
>>    0:	d2d00001 	mov	x1, #0x800000000000        	// #140737488355328
>>    4:	f2fbffe1 	movk	x1, #0xdfff, lsl #48
>>    8:	91002260 	add	x0, x19, #0x8
>>    c:	d343fc02 	lsr	x2, x0, #3
>> * 10:	38e16841 	ldrsb	w1, [x2, x1] <-- trapping instruction
> 
> This looks to be caused by:
> 
> commit 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Mon Aug 14 15:41:00 2023 +0100
> 
>     block: Remove special-casing of compound pages

I suspect this should fix it.

diff --git a/block/bio.c b/block/bio.c
index b9642a41f286..d271f093abb9 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1150,6 +1150,12 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct folio_iter fi;
 
+	/*
+	 * No pages, nothing to do
+	 */
+	if (!bio->bi_vcnt)
+		return;
+
 	bio_for_each_folio_all(fi, bio) {
 		struct page *page;
 		size_t done = 0;

-- 
Jens Axboe


