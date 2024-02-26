Return-Path: <linux-kernel+bounces-82203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C46868090
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C6BA1F24FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B3012FF76;
	Mon, 26 Feb 2024 19:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhYueh+P"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A455112FB03
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974599; cv=none; b=XQ10paw5suVh78jJRTjlFN3HHPjfn9tRHhGNrdBQ6rTj/fAPdFOTHPi/mmYAJsKoM4kWjkPB+EDjEIibEFvK9rvq7sCHOc8SfPTT9+gN82Dw+Z9tkmm135anuidLxanlgJEyx0HM1EREpP+gFzjyJY884Ggs2sTsqFmbdionNiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974599; c=relaxed/simple;
	bh=WLPsNTUS0rffo4BsiNOi5ZgQL+HawDXmRJXW4mh1RDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sJ2sBf8iL9r7pSYdBpgh70qkfXeVQarkEjphD2dke5XfTeu9ID/VZRdwX2H8yQOYhxq4tQzjQZu5S5/zZuGRv0AlnCz6/zXtiuoHCGvE8tOl1UWiSHIi6YPSYY1YPcIF7/QG5oD0xZtkI+VyL45rM1IO2WClBXV2erZWQcIfoa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhYueh+P; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974598; x=1740510598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WLPsNTUS0rffo4BsiNOi5ZgQL+HawDXmRJXW4mh1RDM=;
  b=VhYueh+PrhBGhw3KMN/ByEhawK70DjF6OfghFYZqLP9WdpyKG2U4xv86
   BRjcL5AdawOB/piXixzVZ1iBq2IMYydQr481IPUaQphXT1wc1tLdQpbYt
   UPPMRP9O80+lowVSpcWqCwQtGburFP41PXagV1zcYm+gUH40FoxYuhGGk
   PIN9by6SHnvXThkkLqQwjgCcse8fidpMq7wFrAXsd7K8MFp+519jMKdOR
   dIHSqGf5irOCKZ5cR6Kfn2qDpyG8qmhFcARm5rYVjrLWle0ZgPUGa0kJg
   cjwcD61iL2BcsnUkohkElNgaKNFEsafuVFvWAQt5JM8Qtqyw0r5d3tDrc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721311"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721311"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:09:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911439"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:09:56 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	debug@rivosinc.com,
	broonie@kernel.org,
	kirill.shutemov@linux.intel.com,
	keescook@chromium.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	peterz@infradead.org,
	hpa@zytor.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: rick.p.edgecombe@intel.com
Subject: [PATCH v2 0/9] Cover a guard gap corner case
Date: Mon, 26 Feb 2024 11:09:42 -0800
Message-Id: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
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

For v2, the notable change is a bug fix to not clobber the MMF_TOPDOWN 
during fork. In the RFC this resulted in fork() children that didn't exec 
getting the map up behavior, which included the stress-ng bigheap test. It 
turns out much of the 4% improvement seen was due to the bottomup mapping 
direction. With the fix, the performance benefit was a less surprising 
~1%. Other than that, Kirill's style feedback was addressed. There were no 
functional changes (other than the bug).

Link to v1:
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

Rick Edgecombe (9):
  mm: Switch mm->get_unmapped_area() to a flag
  mm: Introduce arch_get_unmapped_area_vmflags()
  mm: Use get_unmapped_area_vmflags()
  thp: Add thp_get_unmapped_area_vmflags()
  mm: Initialize struct vm_unmapped_area_info
  mm: Take placement mappings gap into account
  x86/mm: Implement HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
  x86/mm: Care about shadow stack guard gap during placement
  selftests/x86: Add placement guard gap test for shstk

 arch/alpha/kernel/osf_sys.c                   |   2 +-
 arch/arc/mm/mmap.c                            |   2 +-
 arch/arm/mm/mmap.c                            |   4 +-
 arch/csky/abiv1/mmap.c                        |   2 +-
 arch/loongarch/mm/mmap.c                      |   2 +-
 arch/mips/mm/mmap.c                           |   2 +-
 arch/parisc/kernel/sys_parisc.c               |   2 +-
 arch/powerpc/mm/book3s64/slice.c              |   4 +-
 arch/s390/mm/hugetlbpage.c                    |   6 +-
 arch/s390/mm/mmap.c                           |   8 +-
 arch/sh/mm/mmap.c                             |   4 +-
 arch/sparc/kernel/sys_sparc_32.c              |   2 +-
 arch/sparc/kernel/sys_sparc_64.c              |  19 ++--
 arch/sparc/mm/hugetlbpage.c                   |   6 +-
 arch/x86/include/asm/pgtable_64.h             |   1 +
 arch/x86/kernel/cpu/sgx/driver.c              |   2 +-
 arch/x86/kernel/sys_x86_64.c                  |  39 +++++--
 arch/x86/mm/hugetlbpage.c                     |   6 +-
 arch/x86/mm/mmap.c                            |   4 +-
 drivers/char/mem.c                            |   2 +-
 drivers/dax/device.c                          |   6 +-
 fs/hugetlbfs/inode.c                          |   6 +-
 fs/proc/inode.c                               |  15 +--
 fs/ramfs/file-mmu.c                           |   2 +-
 include/linux/huge_mm.h                       |  11 ++
 include/linux/mm.h                            |  12 ++-
 include/linux/mm_types.h                      |   6 +-
 include/linux/sched/coredump.h                |   5 +-
 include/linux/sched/mm.h                      |  22 ++++
 io_uring/io_uring.c                           |   2 +-
 mm/debug.c                                    |   6 --
 mm/huge_memory.c                              |  23 ++--
 mm/mmap.c                                     | 101 +++++++++++++-----
 mm/shmem.c                                    |  11 +-
 mm/util.c                                     |   6 +-
 .../testing/selftests/x86/test_shadow_stack.c |  67 +++++++++++-
 36 files changed, 298 insertions(+), 122 deletions(-)

-- 
2.34.1


