Return-Path: <linux-kernel+bounces-161719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BB38B5020
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 552461C21685
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 04:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106E7DDB1;
	Mon, 29 Apr 2024 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zk592Gam"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F033D518;
	Mon, 29 Apr 2024 04:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714363496; cv=none; b=SqzJp8zr3jRKf7X/EaWrw9XRmu5A417UvQA18dHiloWwFn+9KB7oITVhjAI0Qu8QHmeTOLJyOUXJXAw1yg0DJw9XrD7IkVWYOdoD/OHX90CqBCqPDmsQR4v0zwnOL+zV/4v6ZdClBUZDDU/wEabod19W8urtdT9NVS7rlK1wIkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714363496; c=relaxed/simple;
	bh=2gLv6YbZkLGGN1mEZJfClM75NzImg+F8/NdAIDj2BvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6wkUR7oWoWMgrGtVQ2M5RgHrMLV9rE8UcZS+Zt8LCnk9xVBfO0FpsRvcs7zqWUXwRt8m1gzDzT68Vf1mefN6SDAV/vCV1md1pyfIhXrbn1damnCWFTPR1bjCqbrXzb9a8GSyNhLH70jjkiUYJDRToPZr2O1N7cKSrPe4QzRlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zk592Gam; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gKnote634Xk8Cne5W0bRUjKD7Uijz9Us6S+5AaUh5yQ=; b=zk592GamY45x/W3dBcgS0ml73v
	sTZ9fk3Ta8KdVE0aloATUbnjMUolrwlb93Zu/3h3HjB82ltTiV2N1k88t5DyT8qbuOlxAinloKGOw
	guFzNCJX7UNGF7A6rdJyHBWlOCKwp6YF6ML15HHbvEEn64298FNYyQcwAqEJacSuvJWWGCxbvVv9m
	/fk6AYkGvr4YVYwH42WzpDEurWSCejIt5mXaVIBoltMWIflUol1qqmpkZ5LFb22iCRzW8CpZQ+mAi
	Kb9lwUyHpA+pVai6+q/uCAKGxbEnpFJRfcrrSk3c7HGUqBLK/bvLGpph094tRjCiuMbaVb7eGO/aF
	2VhEurHQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1IG2-00000001Nnp-3gz2;
	Mon, 29 Apr 2024 04:04:50 +0000
Date: Sun, 28 Apr 2024 21:04:50 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: ziy@nvidia.com, linux-mm@kvack.org, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	willy@infradead.org, hare@suse.de, john.g.garry@oracle.com,
	p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 1/2] mm/huge_memory: skip invalid debugfs file entry for
 folio split
Message-ID: <Zi8cYrtxyO7Uw-Mc@bombadil.infradead.org>
References: <20240424225449.1498244-1-mcgrof@kernel.org>
 <20240424225449.1498244-2-mcgrof@kernel.org>
 <20240425140126.2a62a5ec686813ee7deea658@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425140126.2a62a5ec686813ee7deea658@linux-foundation.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Thu, Apr 25, 2024 at 02:01:26PM -0700, Andrew Morton wrote:
> On Wed, 24 Apr 2024 15:54:48 -0700 Luis Chamberlain <mcgrof@kernel.org> wrote:
> 
> > If the file entry is too long we may easily end up going out of bounds
> > and crash after strsep() on sscanf(). 
> > 
> 
> Can you explain why?  I'm not seeing it.

I couldn't see it either but I just looked at the crash below and
its the only thing I could think of. So I think its when userspace
somehow abuses MAX_INPUT_BUF_SZ a lot somehow.

The test I am using:

https://lore.kernel.org/all/20240424224649.1494092-1-mcgrof@kernel.org/

The crash:

Apr 28 20:09:21 debian12-xfs-reflink-16k-4ks unknown: run fstests generic/745 at 2024-04-28 20:09:21
Apr 28 20:09:22 debian12-xfs-reflink-16k-4ks kernel: XFS (loop5): EXPERIMENTAL: Filesystem with Large Block Size (16384 bytes) enabled.
Apr 28 20:09:22 debian12-xfs-reflink-16k-4ks kernel: XFS (loop5): Mounting V5 Filesystem 6633551d-bd66-4a7c-a4ce-7e312e611742
Apr 28 20:09:22 debian12-xfs-reflink-16k-4ks kernel: XFS (loop5): Ending clean mount
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: split file-backed THPs in file: /media/scratch/test/fss896, page offset: [0x0 - 0x0] with order: 2
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: 0 of 0 file-backed THP split
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: split file-backed THPs in file: /media/scratch/test/p0/f0, page offset: [0x0 - 0x6a4000] with order: 2
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: 0 of 2 file-backed THP split
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: split file-backed THPs in file: /media/scratch/test/p0/f1, page offset: [0x0 - 0x0] with order: 2
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: 0 of 0 file-backed THP split
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: split file-backed THPs in file: /media/scratch/test/p2/d0/d1/d4/f5, page offset: [0x0 - 0xc83d64] with order: 2
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: 1 of 6 file-backed THP split
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: split file-backed THPs in file: /media/scratch/test/p2/d0/d1/d4/f9, page offset: [0x0 - 0xcad301] with order: 2
Apr 28 20:09:25 debian12-xfs-reflink-16k-4ks kernel: huge_memory: 9 of 79 file-backed THP split


<--- after ~2 minutes -->

Apr 28 20:11:24 debian12-xfs-reflink-16k-4ks kernel: huge_memory: split file-backed THPs in file: /media/scratch/test/p0/dc/dd/d274/d2ca/de12/d139/d4b1/d3cf/d4bb/d1240/d96c/d902/d7a5/d8b0/dbfb/dd18/d795/d8a1/dcc5/d1950/d19ed/d1204/d1452/db5f/dbb7/d10e8/d316/d707/f8f3, page offset: [0x0 - 0x17c0000] with order: 2
Apr 28 20:11:24 debian12-xfs-reflink-16k-4ks kernel: huge_memory: 0 of 6 file-backed THP split
Apr 28 20:11:24 debian12-xfs-reflink-16k-4ks kernel: huge_memory: split file-backed THPs in file: /media/scratch/test/p0/dc/dd/d274/d2ca/de12/d139/d4b1/d3cf/d4bb/d1240/d96c/d902/d7a5/d8b0/dbfb/dd18/d795/d8a1/dcc5/d1950/d19ed/d1204/d1452/db5f/dbb7/d10e8/d316/d707/fbb8, page offset: [0x0 - 0x32b533] with order: 2
Apr 28 20:11:24 debian12-xfs-reflink-16k-4ks kernel: huge_memory: 0 of 5 file-backed THP split
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: #PF: supervisor read access in kernel mode
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: #PF: error_code(0x0000) - not-present page
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: PGD 0 P4D 0
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: Oops: 0000 [#1] PREEMPT SMP NOPTI
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: CPU: 7 PID: 2177 Comm: 745 Not tainted 6.9.0-rc5+ #5
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RIP: 0010:vsscanf (lib/vsprintf.c:3465) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: Code: 0f 85 1d 02 00 00 48 8b 54 24 08 0f b6 02 3c 25 40 0f 95 c7 84 c0 0f 95 c1 40 20 cf 41 89 fe 74 40 48 8d 4a 01 48 89 4c 24 08 <41> 0f b6 45 00 38 02 0f 84 87 02 00 00 48 8b 44 24 38 65 48 2b 04
All code
========
   0:	0f 85 1d 02 00 00    	jne    0x223
   6:	48 8b 54 24 08       	mov    0x8(%rsp),%rdx
   b:	0f b6 02             	movzbl (%rdx),%eax
   e:	3c 25                	cmp    $0x25,%al
  10:	40 0f 95 c7          	setne  %dil
  14:	84 c0                	test   %al,%al
  16:	0f 95 c1             	setne  %cl
  19:	40 20 cf             	and    %cl,%dil
  1c:	41 89 fe             	mov    %edi,%r14d
  1f:	74 40                	je     0x61
  21:	48 8d 4a 01          	lea    0x1(%rdx),%rcx
  25:	48 89 4c 24 08       	mov    %rcx,0x8(%rsp)
  2a:*	41 0f b6 45 00       	movzbl 0x0(%r13),%eax		<-- trapping instruction
  2f:	38 02                	cmp    %al,(%rdx)
  31:	0f 84 87 02 00 00    	je     0x2be
  37:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
  3c:	65                   	gs
  3d:	48                   	rex.W
  3e:	2b                   	.byte 0x2b
  3f:	04                   	.byte 0x4

Code starting with the faulting instruction
===========================================
   0:	41 0f b6 45 00       	movzbl 0x0(%r13),%eax
   5:	38 02                	cmp    %al,(%rdx)
   7:	0f 84 87 02 00 00    	je     0x294
   d:	48 8b 44 24 38       	mov    0x38(%rsp),%rax
  12:	65                   	gs
  13:	48                   	rex.W
  14:	2b                   	.byte 0x2b
  15:	04                   	.byte 0x4
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RSP: 0018:ffffb24ec358bad8 EFLAGS: 00010202
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RAX: 0000000000000030 RBX: ffffb24ec358bb50 RCX: ffffffffa03fbc18
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RDX: ffffffffa03fbc17 RSI: ffffffffa03fbc17 RDI: 0000000000000001
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RBP: 0000000000000000 R08: ffffb24ec358bbdc R09: 000000000000002c
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: R10: ffffb24ec358bbfa R11: 0000000000000000 R12: 0000000000000000
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: R13: 0000000000000000 R14: 0000000000000001 R15: ffffb24ec358bf08
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: FS:  00007f8b39189740(0000) GS:ffff88837bdc0000(0000) knlGS:0000000000000000
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: CR2: 0000000000000000 CR3: 000000010c9f2003 CR4: 0000000000770ef0
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: PKRU: 55555554
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: Call Trace:
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel:  <TASK>
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? page_fault_oops (arch/x86/mm/fault.c:713) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? do_user_addr_fault (./include/linux/kprobes.h:591 (discriminator 1) arch/x86/mm/fault.c:1265 (discriminator 1)) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? exc_page_fault (./arch/x86/include/asm/paravirt.h:693 arch/x86/mm/fault.c:1513 arch/x86/mm/fault.c:1563) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? asm_exc_page_fault (./arch/x86/include/asm/idtentry.h:623) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? vsscanf (lib/vsprintf.c:3465) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? stack_depot_save_flags (lib/stackdepot.c:609) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: sscanf (lib/vsprintf.c:3725) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? __check_object_size (mm/usercopy.c:226 (discriminator 1) mm/usercopy.c:213 (discriminator 1)) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: split_huge_pages_write (mm/huge_memory.c:3664) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: full_proxy_write (fs/debugfs/file.c:328 (discriminator 1)) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: vfs_write (fs/read_write.c:588) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? __count_memcg_events (mm/memcontrol.c:723 (discriminator 1) mm/memcontrol.c:962 (discriminator 1)) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? count_memcg_events.constprop.0 (./arch/x86/include/asm/irqflags.h:134 (discriminator 1) ./include/linux/memcontrol.h:1097 (discriminator 1)) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? handle_mm_fault (mm/memory.c:5483 mm/memory.c:5622) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ? preempt_count_add (./include/linux/ftrace.h:974 (discriminator 1) kernel/sched/core.c:5852 (discriminator 1) kernel/sched/core.c:5849 (discriminator 1) kernel/sched/core.c:5877 (discriminator 1)) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: ksys_write (fs/read_write.c:643) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1)) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130) 
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RIP: 0033:0x7f8b39284240
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: Code: 40 00 48 8b 15 c1 9b 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 80 3d a1 23 0e 00 00 74 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 48 83 ec 28 48 89
All code
========
   0:	40 00 48 8b          	rex add %cl,-0x75(%rax)
   4:	15 c1 9b 0d 00       	adc    $0xd9bc1,%eax
   9:	f7 d8                	neg    %eax
   b:	64 89 02             	mov    %eax,%fs:(%rdx)
   e:	48 c7 c0 ff ff ff ff 	mov    $0xffffffffffffffff,%rax
  15:	eb b7                	jmp    0xffffffffffffffce
  17:	0f 1f 00             	nopl   (%rax)
  1a:	80 3d a1 23 0e 00 00 	cmpb   $0x0,0xe23a1(%rip)        # 0xe23c2
  21:	74 17                	je     0x3a
  23:	b8 01 00 00 00       	mov    $0x1,%eax
  28:	0f 05                	syscall
  2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
  30:	77 58                	ja     0x8a
  32:	c3                   	ret
  33:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  3a:	48 83 ec 28          	sub    $0x28,%rsp
  3e:	48                   	rex.W
  3f:	89                   	.byte 0x89

Code starting with the faulting instruction
===========================================
   0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
   6:	77 58                	ja     0x60
   8:	c3                   	ret
   9:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  10:	48 83 ec 28          	sub    $0x28,%rsp
  14:	48                   	rex.W
  15:	89                   	.byte 0x89
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RSP: 002b:00007fff2a14b5f8 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RAX: ffffffffffffffda RBX: 0000000000000109 RCX: 00007f8b39284240
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RDX: 0000000000000109 RSI: 00005589ea673400 RDI: 0000000000000001
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: RBP: 00005589ea673400 R08: 0000000000000007 R09: 0000000000000073
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000109
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel: R13: 00007f8b3935f760 R14: 0000000000000109 R15: 00007f8b3935a9e0
Apr 28 20:11:25 debian12-xfs-reflink-16k-4ks kernel:  </TASK>

