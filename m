Return-Path: <linux-kernel+bounces-100886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4523879EA6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:29:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3A028706A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A191B143C71;
	Tue, 12 Mar 2024 22:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWSPq3HG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2574CDE0
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282544; cv=none; b=DMeGtlgs1KtwQZwwHermm9eEJxLkRDrnaWOPeUq5sNYbYpLmAqYtnogzN4RgD12VKNafmiWCPgSN56e/cTj7k9tdxde3rZxwuRHEP/Rewa/4jhajl2MhBcq4POcfVEN7+XeBTk7BUXMdr5qjHl9/exZr/iz3nrAlZdU8KxXoqW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282544; c=relaxed/simple;
	bh=tTQ5x31bZfDMPtCq1BPOxcN0a7C3MnUNoyPhThEtsVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=rnGjVoOXC1+kfCE/cthTPX1crHTRetH+ro9jBOsZLCYWQJyYqaYhK3cUHHxAxTJZ0tn746cIo4rUqFMPJHjFAM2qTGVGIm5lKY7DNPGfJGkkJ68xOoRDH9RtP0w6N2GDgk+PB+LNXzZ+H7UnvDl4XHHk5d6Vs6EAX5B3fg/RSYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWSPq3HG; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282543; x=1741818543;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tTQ5x31bZfDMPtCq1BPOxcN0a7C3MnUNoyPhThEtsVE=;
  b=lWSPq3HGfjIGXZeJkMMkpkr2GzVklJ87SpA2aXT9jBsmUK3mbIdwolZe
   doKVDLL67gI+E5nUWAriZ4DW49Qx+Uwi+iWTftGNA+CbLvh630VBV7LbE
   3o0ll2KM+10/z50L86qeS9Jr7w9tPRTA05gu756PVU4CvpKJJuAajPfQO
   HSADQY9wHiKRoLGNkqeKgEcd6Xsq2+DhS0WzJhQakkk/j+8MwAEpjGkzZ
   zgUESzxtMins6QXVYsIgJoBhkZHzwHyyhk+rZ6eT/C5ZYeYjmTS44/GhO
   +7ANvnMGuwDXnBv9S5AbY7TVuQJOqUYtgYaMQCyVrXJJz50AQVXsNL52C
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5191902"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5191902"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356823"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:01 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org,
	christophe.leroy@csgroup.eu
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	rick.p.edgecombe@intel.com
Subject: [PATCH v3 00/12] Cover a guard gap corner case
Date: Tue, 12 Mar 2024 15:28:31 -0700
Message-Id: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

For v3, the change is in the struct vm_unmapped_area_info zeroing patches. 
Per discussion[0], they are switched to a method of intializing the struct 
at the callers that also doesn't leave useless statements as cleanup, but 
is a bit easier to manually inspect for bugs. The arch's that acked the 
old versions are left separate. What's left after that happens in a 
treewide change. 

It seems like a more straightforward change now, but I would still 
appreciate if anyone can double check the treewide change.

Also, rebase to v6.8.

[0] https://lore.kernel.org/lkml/e617dea592ec336e991c4362e48cd8c648ba7b49.camel@intel.com/

v2:
https://lore.kernel.org/lkml/20240226190951.3240433-1-rick.p.edgecombe@intel.com/

v1:
https://lore.kernel.org/lkml/20240215231332.1556787-1-rick.p.edgecombe@intel.com/

=======

In working on x86’s shadow stack feature, I came across some limitations 
around the kernel’s handling of guard gaps. AFAICT these limitations are 
not too important for the traditional stack usage of guard gaps, but have 
bigger impact on shadow stack’s usage. And now in addition to x86, we have 
two other architectures implementing shadow stack like features that plan 
to use guard gaps. I wanted to see about addressing them, but I have not 
worked on mmap() placement related code before, so would greatly 
appreciate if people could take a look and point me in the right 
direction.

The nature of the limitations of concern is as follows. In order to ensure 
guard gaps between mappings, mmap() would need to consider two things:
 1. That the new mapping isn’t placed in an any existing mapping’s guard
    gap.
 2. That the new mapping isn’t placed such that any existing mappings are
    not in *its* guard gaps
Currently mmap never considers (2), and (1) is not considered in some 
situations.

When not passing an address hint, or passing one without 
MAP_FIXED_NOREPLACE, (1) is enforced. With MAP_FIXED_NOREPLACE, (1) is not 
enforced. With MAP_FIXED, (1) is not considered, but this seems to be 
expected since MAP_FIXED can already clobber existing mappings. For 
MAP_FIXED_NOREPLACE I would have guessed it should respect the guard gaps 
of existing mappings, but it is probably a little ambiguous.

In this series I just tried to add enforcement of (2) for the normal (no 
address hint) case and only for the newer shadow stack memory (not 
stacks). The reason is that with the no-address-hint situation, landing 
next to a guard gap could come up naturally and so be more influencable by 
attackers such that two shadow stacks could be adjacent without a guard 
gap. Where as the address-hint scenarios would require more control - 
being able to call mmap() with specific arguments. As for why not just fix 
the other corner cases anyway, I thought it might have some greater 
possibility of affecting existing apps.

Thanks,

Rick

Rick Edgecombe (12):
  mm: Switch mm->get_unmapped_area() to a flag
  mm: Introduce arch_get_unmapped_area_vmflags()
  mm: Use get_unmapped_area_vmflags()
  thp: Add thp_get_unmapped_area_vmflags()
  csky: Use initializer for struct vm_unmapped_area_info
  parisc: Use initializer for struct vm_unmapped_area_info
  powerpc: Use initializer for struct vm_unmapped_area_info
  treewide: Use initializer for struct vm_unmapped_area_info
  mm: Take placement mappings gap into account
  x86/mm: Implement HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
  x86/mm: Care about shadow stack guard gap during placement
  selftests/x86: Add placement guard gap test for shstk

 arch/alpha/kernel/osf_sys.c                   |   5 +-
 arch/arc/mm/mmap.c                            |   4 +-
 arch/arm/mm/mmap.c                            |   5 +-
 arch/csky/abiv1/mmap.c                        |  12 +-
 arch/loongarch/mm/mmap.c                      |   3 +-
 arch/mips/mm/mmap.c                           |   3 +-
 arch/parisc/kernel/sys_parisc.c               |   6 +-
 arch/powerpc/mm/book3s64/slice.c              |  23 ++--
 arch/s390/mm/hugetlbpage.c                    |   9 +-
 arch/s390/mm/mmap.c                           |  15 +--
 arch/sh/mm/mmap.c                             |   5 +-
 arch/sparc/kernel/sys_sparc_32.c              |   3 +-
 arch/sparc/kernel/sys_sparc_64.c              |  20 ++--
 arch/sparc/mm/hugetlbpage.c                   |   9 +-
 arch/x86/include/asm/pgtable_64.h             |   1 +
 arch/x86/kernel/cpu/sgx/driver.c              |   2 +-
 arch/x86/kernel/sys_x86_64.c                  |  42 +++++--
 arch/x86/mm/hugetlbpage.c                     |   9 +-
 arch/x86/mm/mmap.c                            |   4 +-
 drivers/char/mem.c                            |   2 +-
 drivers/dax/device.c                          |   6 +-
 fs/hugetlbfs/inode.c                          |  11 +-
 fs/proc/inode.c                               |  15 +--
 fs/ramfs/file-mmu.c                           |   2 +-
 include/linux/huge_mm.h                       |  11 ++
 include/linux/mm.h                            |  12 +-
 include/linux/mm_types.h                      |   6 +-
 include/linux/sched/coredump.h                |   5 +-
 include/linux/sched/mm.h                      |  22 ++++
 io_uring/io_uring.c                           |   2 +-
 mm/debug.c                                    |   6 -
 mm/huge_memory.c                              |  26 +++--
 mm/mmap.c                                     | 106 +++++++++++++-----
 mm/shmem.c                                    |  11 +-
 mm/util.c                                     |   6 +-
 .../testing/selftests/x86/test_shadow_stack.c |  67 ++++++++++-
 36 files changed, 319 insertions(+), 177 deletions(-)

-- 
2.34.1


