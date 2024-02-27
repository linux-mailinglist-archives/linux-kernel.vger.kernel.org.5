Return-Path: <linux-kernel+bounces-83230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9AC86908A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C02A81C230C4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44D313A879;
	Tue, 27 Feb 2024 12:28:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522613A24A
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 12:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709036904; cv=none; b=NqmutDmyVHni3e2kCoXTGRB5qbFDF3ivEjVIF2RbiU1IBSJZWQT7Rh2R/8M7Prhs0Ph/K0ynddkon70xvTuOfcZnNCLJbL68xbRLuYPS9nZc/2uQrt38LgMokcEpU+to38nqIILLdZpmUOmCO301C8RPhAemu2ExVFb/YBzz02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709036904; c=relaxed/simple;
	bh=RRXFy/boXCwxSxlgJSeOaphTJjc72DSJtT1PMzF0QDs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oVO5Oz5DZGJSndp+GEhzFXHdOage91rgERN+CfKnRizZ829iY4QxARqmgut/YmOKr0210qZ1HA0YPUeenaYoNxVVBNIaIsGw8AfKM9haoogcmtMpNuDDdBkcX+IbZ+oJpU+c5186PvVXcdBscnyp06k/DRhxIaNao7komSLuirQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TkcDT2FLjzNljx;
	Tue, 27 Feb 2024 20:26:49 +0800 (CST)
Received: from dggpemd200001.china.huawei.com (unknown [7.185.36.224])
	by mail.maildlp.com (Postfix) with ESMTPS id DFFB91404FC;
	Tue, 27 Feb 2024 20:28:18 +0800 (CST)
Received: from localhost.localdomain (10.175.112.125) by
 dggpemd200001.china.huawei.com (7.185.36.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 27 Feb 2024 20:28:18 +0800
From: Wupeng Ma <mawupeng1@huawei.com>
To: <akpm@linux-foundation.org>, <khlebnikov@openvz.org>, <jaredeh@gmail.com>,
	<david@redhat.com>, <linmiaohe@huawei.com>, <hpa@zytor.com>
CC: <dave.hansen@linux.intel.com>, <luto@kernel.org>, <tglx@linutronix.de>,
	<peterz@infradead.org>, <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<mawupeng1@huawei.com>, <mingo@redhat.com>, <rdunlap@infradead.org>,
	<bhelgaas@google.com>, <linux-mm@kvack.org>
Subject: [Question] CoW on VM_PFNMAP vma during write fault
Date: Tue, 27 Feb 2024 20:28:14 +0800
Message-ID: <20240227122814.3781907-1-mawupeng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemd200001.china.huawei.com (7.185.36.224)

We find that a warn will be produced during our test, the detail log is
shown in the end.

The core problem of this warn is that the first pfn of this pfnmap vma is
cleared during memory-failure. Digging into the source we find that this
problem can be triggered as following:

// mmap with MAP_PRIVATE and specific fd which hook mmap
mmap(MAP_PRIVATE, fd)
  __mmap_region
    remap_pfn_range
    // set vma with pfnmap and the prot of pte is read only
	  
// memset this memory with trigger fault
handle_mm_fault
  __handle_mm_fault
    handle_pte_fault
      // write fault and !pte_write(entry)
      do_wp_page
        wp_page_copy // this will alloc a new page with valid page struct
                     // for this pfnmap vma

// inject a hwpoison to the first page of this vma
madvise_inject_error
  memory_failure
    hwpoison_user_mappings
      try_to_unmap_one
        // mark this pte as invalid (hwpoison)
        mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
                address, range.end);

// during unmap vma, the first pfn of this pfnmap vma is invalid
vm_mmap_pgoff
  do_mmap
    __do_mmap_mm
      __mmap_region
        __do_munmap 
          unmap_region
            unmap_vmas
              unmap_single_vma
                untrack_pfn
                  follow_phys // pte is already invalidate, WARN_ON here

CoW with a valid page for pfnmap vma is weird to us. Can we use
remap_pfn_range for private vma(read only)? Once CoW happens on a pfnmap
vma during write fault, this page is normal(page flag is valid) for most mm
subsystems, such as memory failure in thais case and extra should be done to
handle this special page.

During unmap, if this vma is pfnmap, unmap shouldn't be done since page
should not be touched for pfnmap vma.

But the root problem is that can we insert a valid page for pfnmap vma?

Any thoughts to solve this warn?

------------[ cut here ]------------
WARNING: CPU: 0 PID: 503 at arch/x86/mm/pat/memtype.c:1060 untrack_pfn+0xed/0x100
Modules linked in: remap_pfn(OE)
CPU: 0 PID: 503 Comm: remap_pfn Tainted: G           OE      6.8.0-rc6-dirty #436
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 0.0.0 02/06/2015
RIP: 0010:untrack_pfn+0xed/0x100
Code: cc cc cc cc 48 8b 43 10 8b a8 e8 00 00 00 3b 6b 28 74 ca 48 8b 7b 30 e8 81 de cf 00 89 6b 28 48 8b 7b 30 e8 05 cc b7 e8 ba c3 ce 00 66 2e 0f 1f 84 00 00 00 00 00 90 90 90
RSP: 0018:ffffb5f683eafc78 EFLAGS: 00010282
RAX: 00000000ffffffea RBX: ffff960b18537658 RCX: 0000000000000043
RDX: bfffffffdcb13e00 RSI: 0000000000000043 RDI: ffff960e45b7a140
RBP: 0000000000000000 R08: 00007f7df7a00000 R09: ffff960a00000fb8
R10: ffff960a00000000 R11: 000fffffffffffff R12: 00007f7df7a08000
R13: 0000000000000000 R14: ffffb5f683eafdc8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff960e2fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7df7aeb110 CR3: 0000000118b66003 CR4: 0000000000770ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 ? __warn+0x84/0x140
 ? untrack_pfn+0xed/0x100
 ? report_bug+0x1bd/0x1d0
 ? handle_bug+0x3c/0x70
 ? exc_invalid_op+0x18/0x70
 ? asm_exc_invalid_op+0x1a/0x20
 ? untrack_pfn+0xed/0x100
 ? untrack_pfn+0x5c/0x100
 unmap_single_vma+0xa6/0xe0
 unmap_vmas+0xb2/0x190
 exit_mmap+0xee/0x3c0
 mmput+0x68/0x120
 do_exit+0x2ec/0xb80
 do_group_exit+0x31/0x80
 __x64_sys_exit_group+0x18/0x20
 do_syscall_64+0x66/0x180
 entry_SYSCALL_64_after_hwframe+0x6e/0x76
RIP: 0033:0x7f7df7aeb146
Code: Unable to access opcode bytes at 0x7f7df7aeb11c.
RSP: 002b:00007ffe571100a8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 00007f7df7bf08a0 RCX: 00007f7df7aeb146
RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000000000e7 R09: ffffffffffffff80
R10: 0000000000000002 R11: 0000000000000246 R12: 00007f7df7bf08a0
R13: 0000000000000001 R14: 00007f7df7bf92e8 R15: 0000000000000000
 </TASK>
---[ end trace 0000000000000000 ]---


