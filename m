Return-Path: <linux-kernel+bounces-118280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 332CC88B73D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AE3B21D45
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB695A119;
	Tue, 26 Mar 2024 02:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FDI3UiVr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255AF1804F
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419437; cv=none; b=FmrxvgsmkmFqmh1X2N74rIAaTzlP+o5F72WHrE4cfE0TtKgM1VJj5mwttxPqjjX5/tfFrKJp5qsZCizil8fRpCM2Q4BsmBc38X0Sf+WCTgdlVemnIt5RUJAvyqtKwv8ogUUO1siygmiH/0aFxc919Hu9olRtJxYFbOq39g12WYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419437; c=relaxed/simple;
	bh=9GrifE+eAYRpRenFQJ6XnRK39adqukOR1ANPiFlRvJA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=tgFtNpN6UIe3kJGA2zn8KPC3SJjKhz8OdzxiW2YkR06WU2EwOxADjyDxkY0HA3fbfk35y12ASCLbhXMvbxhR76/0iIHlPXqAivMMGvauq0YuE73swvHohSAcLg/FO3Z5WrAxGQG5aBFAARZb/4aYGtwZpOdmQCy9BxLZ8Nz/Yuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FDI3UiVr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419435; x=1742955435;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9GrifE+eAYRpRenFQJ6XnRK39adqukOR1ANPiFlRvJA=;
  b=FDI3UiVrcpkP8Dh/vUNImH1DPEqzU5ljOiLKsCh86AVt11IR4exd7dKG
   hmAOCiA/sXBPYTRHzSLSSVzk0iIyRK85wwhiPYve5dWgp/tejsi5uEwqR
   h8Fw/73+QRskZqorFxnSpP4YEM/LPXruIUhhAQXOr/9s/JKkG9lEJVPu8
   nptMzKEOkK4hR9jO81aIulKKrRLkCEr5cIh+aUTcM9RQEAQ0yRX21dzU4
   hKBrrAXphuCwS0Mcc+L1J19hy1p1pOTIUqDxy+17eqBqoYGLjxESTDFQn
   ITccoix7f2VW24GFwk/Cact+Wa4HRPNX9ippSI88kuDCrT8XPKDEhqaeu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564196"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564196"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489861"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:13 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 00/14] Cover a guard gap corner case
Date: Mon, 25 Mar 2024 19:16:42 -0700
Message-Id: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
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

For v4, is just some small non-functional changes from Christophe Leroy,
including splitting two patches.

Also, rebase to v6.9-rc1. This included converting two new
mm->get_unmapped_area() callsites that popped up.

v3:
https://lore.kernel.org/lkml/20240312222843.2505560-1-rick.p.edgecombe@intel.com/

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


Rick Edgecombe (14):
  proc: Refactor pde_get_unmapped_area as prep
  mm: Switch mm->get_unmapped_area() to a flag
  mm: Introduce arch_get_unmapped_area_vmflags()
  mm: Remove export for get_unmapped_area()
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
 arch/powerpc/mm/book3s64/slice.c              |  20 ++--
 arch/s390/mm/hugetlbpage.c                    |   9 +-
 arch/s390/mm/mmap.c                           |   9 +-
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
 fs/proc/inode.c                               |  10 +-
 fs/ramfs/file-mmu.c                           |   2 +-
 include/linux/huge_mm.h                       |  11 ++
 include/linux/mm.h                            |  12 +-
 include/linux/mm_types.h                      |   6 +-
 include/linux/sched/coredump.h                |   5 +-
 include/linux/sched/mm.h                      |  22 ++++
 io_uring/io_uring.c                           |   2 +-
 kernel/bpf/arena.c                            |   2 +-
 kernel/bpf/syscall.c                          |   2 +-
 mm/debug.c                                    |   6 -
 mm/huge_memory.c                              |  26 +++--
 mm/mmap.c                                     | 106 +++++++++++++-----
 mm/shmem.c                                    |  11 +-
 mm/util.c                                     |   6 +-
 .../testing/selftests/x86/test_shadow_stack.c |  67 ++++++++++-
 38 files changed, 312 insertions(+), 174 deletions(-)

-- 
2.34.1


