Return-Path: <linux-kernel+bounces-67812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C1B85715F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B41F1F21354
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D814A087;
	Thu, 15 Feb 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gBwIIfka"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A611482EF
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038881; cv=none; b=ecgtM2GaLRc+FZrmbJNU7lD7etRCrmyakVvnAIwB8otwfqOofM4vM3lHm209OMpSnWgwXLlTfSwiJw/oxztCosW9MN4QS8eznTRJGVoJ/mJ0DYH9nHYj1fWk56CLFN41NLEHmuCpsmix9MVonif9HdVW/K+PTKAilSXbwcIjrKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038881; c=relaxed/simple;
	bh=Jt1Mpx1uMY7XnHlh/3E2LCtQ+SRD+/n8kJk/hjL1Z1k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=HWRyM1VwNnVdKwqL4pckbJF6PX50AEcvHMiRDv0hEAnW4kdqMMp4hP0utZACQIyQ46Ai7EOx2O/P/8orpA2ZrLoudREh05uFR+SQjxXy4sKza7yk011kv1GFD4ggMybKK/JKt5egX4V/U9CCNyOTW/COHbJSxxIN6Q6terLrwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gBwIIfka; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038879; x=1739574879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jt1Mpx1uMY7XnHlh/3E2LCtQ+SRD+/n8kJk/hjL1Z1k=;
  b=gBwIIfkaonPZTy5benTGbNenhLKKsFflLtO2UBCaVU2nI9M5xvx+avQ/
   O5hqdUMkw+I+RU7ZB1CLheRyWtAXayno2vkFnTZ9HB6C/jRj+bLPwPLgb
   MbZCZvcu+b1lGuI7PIhqCPTEiWt/klR1WFD3Rd+8uimQDwb29PS6Uq4lG
   oEf/HByjl4v3Lum/RXG7m97JvrP1Roc7f+xBgrbH2fTKO1qsCJSAutv2h
   aAnkhwHRVhlYCyKmH46pqsBW50X/cAJUAXsiFNwMhG0IsjuCIxlhoVu/M
   pkUaGkTVRrcmi5Qko8SUwkvICU39PTyd7pb4K1gPco4Dbic9QnIgUutiQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066304"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066304"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250184"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250184"
Received: from yshin-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.95.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:36 -0800
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
Subject: [RFC PATCH 0/8] Cover a guard gap corner case
Date: Thu, 15 Feb 2024 15:13:24 -0800
Message-Id: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
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

In this RFC I just tried to add enforcement of (2) for the normal (no 
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

Rick Edgecombe (8):
  mm: Switch mm->get_unmapped_area() to a flag
  mm: Introduce arch_get_unmapped_area_vmflags()
  mm: Use get_unmapped_area_vmflags()
  thp: Add thp_get_unmapped_area_vmflags()
  mm: Take placement mappings gap into account
  x86/mm: Implement HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
  x86/mm: Care about shadow stack guard gap during placement
  selftests/x86: Add placement guard gap test for shstk

 arch/s390/mm/hugetlbpage.c                    |   2 +-
 arch/s390/mm/mmap.c                           |   4 +-
 arch/sparc/kernel/sys_sparc_64.c              |  15 +--
 arch/sparc/mm/hugetlbpage.c                   |   2 +-
 arch/x86/include/asm/pgtable_64.h             |   1 +
 arch/x86/kernel/cpu/sgx/driver.c              |   2 +-
 arch/x86/kernel/sys_x86_64.c                  |  43 +++++--
 arch/x86/mm/hugetlbpage.c                     |   2 +-
 arch/x86/mm/mmap.c                            |   4 +-
 drivers/char/mem.c                            |   2 +-
 drivers/dax/device.c                          |   6 +-
 fs/hugetlbfs/inode.c                          |   2 +-
 fs/proc/inode.c                               |  15 +--
 fs/ramfs/file-mmu.c                           |   2 +-
 include/linux/huge_mm.h                       |  11 ++
 include/linux/mm.h                            |   4 +
 include/linux/mm_types.h                      |   6 +-
 include/linux/sched/coredump.h                |   1 +
 include/linux/sched/mm.h                      |  22 ++++
 io_uring/io_uring.c                           |   2 +-
 mm/debug.c                                    |   6 -
 mm/huge_memory.c                              |  23 ++--
 mm/mmap.c                                     | 108 ++++++++++++++----
 mm/shmem.c                                    |  11 +-
 mm/util.c                                     |   6 +-
 .../testing/selftests/x86/test_shadow_stack.c |  67 ++++++++++-
 26 files changed, 273 insertions(+), 96 deletions(-)

-- 
2.34.1


