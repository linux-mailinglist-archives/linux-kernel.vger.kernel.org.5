Return-Path: <linux-kernel+bounces-117351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AFB88AA54
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39C5D1F3E3BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00EE13AD10;
	Mon, 25 Mar 2024 15:20:07 +0000 (UTC)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA9137C21
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.17.236.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380007; cv=none; b=Jdhz2gTCcxkSUHtlPHcDtu00JKHh05RmUmTCrrWpnXUgt44+gRUeRWYu5l1B1auVeuizE3qimTSYJ14OUQCJ0n7V+HeV3I/XhhnOfQfFiGdsQPWc+iGFNR3NClxnSOsJiBm3cb6zcOn5/Y77+AT0A/gjSXId0l5wUXncewpAJxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380007; c=relaxed/simple;
	bh=1QUfp3pSHGOWHPlUD77voOXNtRwi/Hp1Mh0eHpyYI3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WXCEYKuc2FKpVw4kqBvy2Ai2dQYN4NvFJ8Z1waJFPAIIIHYVFpLaNDju55fw45E/HcGllqfEhp0uO+MTX8V9D5tzdaneIP2sw4WQn1e26k4uSSxpbC8S6NP4BIt5Y2GHO2sd+P/vIDxrzVJdIu1RmZOT3Kxp5Au+h6Zjee/Pon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; arc=none smtp.client-ip=93.17.236.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
	by localhost (Postfix) with ESMTP id 4V3GGL3yshz9sq1;
	Mon, 25 Mar 2024 15:56:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
	by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D0GLhUgBDpEJ; Mon, 25 Mar 2024 15:56:10 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
	by pegase1.c-s.fr (Postfix) with ESMTP id 4V3GGK1NtXz9sTD;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 2BF598B770;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
	by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
	with ESMTP id ILrl3yQG2tup; Mon, 25 Mar 2024 15:56:09 +0100 (CET)
Received: from PO20335.idsi0.si.c-s.fr (unknown [172.25.230.108])
	by messagerie.si.c-s.fr (Postfix) with ESMTP id 0882E8B765;
	Mon, 25 Mar 2024 15:56:09 +0100 (CET)
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Peter Xu <peterx@redhat.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 0/8] Reimplement huge pages without hugepd on powerpc 8xx
Date: Mon, 25 Mar 2024 15:55:53 +0100
Message-ID: <cover.1711377230.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711378567; l=4005; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=1QUfp3pSHGOWHPlUD77voOXNtRwi/Hp1Mh0eHpyYI3M=; b=C2sC3KyJ+kZ+6wF7ahqvDmuEGRLy5haI+SS54JsNZwoPEOE39owJkJ0ambGrjV6GLYJixynOt hLZawct1NZMDswMbTvR/oOyV7gzS1FnN6AeaEeEOZQL1j80Ng/rUHOW
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit

This series reimplements hugepages with hugepd on powerpc 8xx.

Unlike most architectures, powerpc 8xx HW requires a two-level
pagetable topology for all page sizes. So a leaf PMD-contig approach
is not feasible as such.

Possible sizes are 4k, 16k, 512k and 8M.

First level (PGD/PMD) covers 4M per entry. For 8M pages, two PMD entries
must point to a single entry level-2 page table. Until now that was
done using hugepd. This series changes it to use standard page tables
where the entry is replicated 1024 times on each of the two pagetables
refered by the two associated PMD entries for that 8M page.

At the moment it has to look into each helper to know if the
hugepage ptep is a PTE or a PMD in order to know it is a 8M page or
a lower size. I hope this can me handled by core-mm in the future.

There are probably several ways to implement stuff, so feedback is
very welcome.

Christophe Leroy (8):
  mm: Provide pagesize to pmd_populate()
  mm: Provide page size to pte_alloc_huge()
  mm: Provide pmd to pte_leaf_size()
  mm: Provide mm_struct and address to huge_ptep_get()
  powerpc/mm: Allow hugepages without hugepd
  powerpc/8xx: Fix size given to set_huge_pte_at()
  powerpc/8xx: Remove support for 8M pages
  powerpc/8xx: Add back support for 8M pages using contiguous PTE
    entries

 arch/arm64/include/asm/hugetlb.h              |  2 +-
 arch/arm64/include/asm/pgtable.h              |  2 +-
 arch/arm64/mm/hugetlbpage.c                   |  2 +-
 arch/parisc/mm/hugetlbpage.c                  |  2 +-
 arch/powerpc/Kconfig                          |  1 -
 arch/powerpc/include/asm/hugetlb.h            | 13 +++-
 .../include/asm/nohash/32/hugetlb-8xx.h       | 54 ++++++++---------
 arch/powerpc/include/asm/nohash/32/pgalloc.h  |  2 +
 arch/powerpc/include/asm/nohash/32/pte-8xx.h  | 59 +++++++++++++------
 arch/powerpc/include/asm/nohash/pgtable.h     | 12 ++--
 arch/powerpc/include/asm/page.h               |  5 --
 arch/powerpc/include/asm/pgtable.h            |  1 +
 arch/powerpc/kernel/head_8xx.S                | 10 +---
 arch/powerpc/mm/hugetlbpage.c                 | 23 +++++++-
 arch/powerpc/mm/nohash/8xx.c                  | 46 +++++++--------
 arch/powerpc/mm/pgtable.c                     | 26 +++++---
 arch/powerpc/mm/pgtable_32.c                  |  2 +-
 arch/powerpc/platforms/Kconfig.cputype        |  2 +
 arch/riscv/include/asm/pgtable.h              |  2 +-
 arch/riscv/mm/hugetlbpage.c                   |  2 +-
 arch/sh/mm/hugetlbpage.c                      |  2 +-
 arch/sparc/include/asm/pgtable_64.h           |  2 +-
 arch/sparc/mm/hugetlbpage.c                   |  4 +-
 fs/hugetlbfs/inode.c                          |  2 +-
 fs/proc/task_mmu.c                            |  8 +--
 fs/userfaultfd.c                              |  2 +-
 include/asm-generic/hugetlb.h                 |  2 +-
 include/linux/hugetlb.h                       |  4 +-
 include/linux/mm.h                            | 12 ++--
 include/linux/pgtable.h                       |  2 +-
 include/linux/swapops.h                       |  2 +-
 kernel/events/core.c                          |  2 +-
 mm/damon/vaddr.c                              |  6 +-
 mm/filemap.c                                  |  2 +-
 mm/gup.c                                      |  2 +-
 mm/hmm.c                                      |  2 +-
 mm/hugetlb.c                                  | 46 +++++++--------
 mm/internal.h                                 |  2 +-
 mm/memory-failure.c                           |  2 +-
 mm/memory.c                                   | 19 +++---
 mm/mempolicy.c                                |  2 +-
 mm/migrate.c                                  |  4 +-
 mm/mincore.c                                  |  2 +-
 mm/pgalloc-track.h                            |  2 +-
 mm/userfaultfd.c                              |  6 +-
 45 files changed, 229 insertions(+), 180 deletions(-)

-- 
2.43.0


