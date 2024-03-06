Return-Path: <linux-kernel+bounces-93785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5362087348E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1F33B2A83D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 118A3605B3;
	Wed,  6 Mar 2024 10:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gr832pYl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92DF605A5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709721723; cv=none; b=UOcIbHC7YNH2iFqhDkQuoga5ppfzniM5HVmXl7lB9peUY+0oe79JXNOuzPGxAaRBTrOhkcpxCs4kk8kc1iAJ7v1EN18l7ry/Z/d/ISAbHWnQ7KJpw32XyZ7ko+cpo603S8jVsTOqRDkSSVY9qdcDh+B0dQmqNmhJ77WWNAoC1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709721723; c=relaxed/simple;
	bh=sndXh1K9u7hqol9ljgqbvLP+cDVWvZMzw+q1BPr+LSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b3MZeu2va/RyYVawD4fkfHznhVRStQuApDiuGNW+hPRu04Ga+jfqBHOwbdI9M0cDXHWZD7Kvpakgwh6O4nirzHhPOAC6aVZ0HMQ9r2bKPImAZTlZzy80D0vtFs/GR5w+ZiUkjYn9oJTPMiizdjj9blfm4eHA7rd/CRID99C1YYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gr832pYl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709721720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nsf6jReUnDDAR6+gdGYukarc12MvosBlw43zRUpKkD0=;
	b=Gr832pYlmYmJo4FMHrxRrLYiIpG/6blkDlTdADyWx9q7lDS2YFmQ3/DDJhxVCd/jPdQOpm
	4+zY4XhTJEhYrUQGd+Lzkup31GJX83vvvIaw92+JnOGIR9WaM69RtPaDktk/CF6ObNRF09
	q8V+Yi2KKiv7gYPTmFxvMtJVpZ3mcsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-h1aSarPyMoSclrJ9xw8rvg-1; Wed, 06 Mar 2024 05:41:57 -0500
X-MC-Unique: h1aSarPyMoSclrJ9xw8rvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70D85101A56C;
	Wed,  6 Mar 2024 10:41:56 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.8])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2CD3F112131D;
	Wed,  6 Mar 2024 10:41:49 +0000 (UTC)
From: peterx@redhat.com
To: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	peterx@redhat.com,
	Matthew Wilcox <willy@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	x86@kernel.org,
	sparclinux@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH RFC 00/13] mm/treewide: Remove pXd_huge() API
Date: Wed,  6 Mar 2024 18:41:34 +0800
Message-ID: <20240306104147.193052-1-peterx@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

From: Peter Xu <peterx@redhat.com>

[based on akpm/mm-unstable latest commit a7f399ae964e]

In previous work [1], we removed the pXd_large() API, which is arch
specific.  This patchset further removes the hugetlb pXd_huge() API.

Hugetlb was never special on creating huge mappings when compared with
other huge mappings.  Having a standalone API just to detect such pgtable
entries is more or less redundant, especially after the pXd_leaf() API set
is introduced with/without CONFIG_HUGETLB_PAGE.

When looking at this problem, a few issues are also exposed that we don't
have a clear definition of the *_huge() variance API.  This patchset
started by cleaning these issues first, then replace all *_huge() users to
use *_leaf(), then drop all *_huge() code.

On x86/sparc, swap entries will be reported "true" in pXd_huge(), while for
all the rest archs they're reported "false" instead.  This part is done in
patch 1-5, in which I suspect patch 1 can be seen as a bug fix, but I'll
leave that to hmm experts to decide.

Besides, there are three archs (arm, arm64, powerpc) that have slightly
different definitions between the *_huge() v.s. *_leaf() variances.  I
tackled them separately so that it'll be easier for arch experts to chim in
when necessary.  This part is done in patch 6-9.

The final patches 10-13 do the rest on the final removal, since *_leaf()
will be the ultimate API in the future, and we seem to have quite some
confusions on how *_huge() APIs can be defined, provide a rich comment for
*_leaf() API set to define them properly to avoid future misuse, and
hopefully that'll also help new archs to start support huge mappings and
avoid traps (like either swap entries, or PROT_NONE entry checks).

The whole series is only lightly tested on x86, while as usual I don't have
the capability to test all archs that it touches.

Marking this series RFC as of now.

[1] https://lore.kernel.org/r/20240305043750.93762-1-peterx@redhat.com

Peter Xu (13):
  mm/hmm: Process pud swap entry without pud_huge()
  mm/gup: Cache p4d in follow_p4d_mask()
  mm/gup: Check p4d presence before going on
  mm/x86: Change pXd_huge() behavior to exclude swap entries
  mm/sparc: Change pXd_huge() behavior to exclude swap entries
  mm/arm: Use macros to define pmd/pud helpers
  mm/arm: Redefine pmd_huge() with pmd_leaf()
  mm/arm64: Merge pXd_huge() and pXd_leaf() definitions
  mm/powerpc: Redefine pXd_huge() with pXd_leaf()
  mm/gup: Merge pXd huge mapping checks
  mm/treewide: Replace pXd_huge() with pXd_leaf()
  mm/treewide: Remove pXd_huge()
  mm: Document pXd_leaf() API

 arch/arm/include/asm/pgtable-2level.h         |  4 +--
 arch/arm/include/asm/pgtable-3level-hwdef.h   |  1 +
 arch/arm/include/asm/pgtable-3level.h         |  6 ++--
 arch/arm/mm/Makefile                          |  1 -
 arch/arm/mm/hugetlbpage.c                     | 34 -------------------
 arch/arm64/include/asm/pgtable.h              |  6 +++-
 arch/arm64/mm/hugetlbpage.c                   | 18 ++--------
 arch/loongarch/mm/hugetlbpage.c               | 12 +------
 arch/mips/include/asm/pgtable-32.h            |  2 +-
 arch/mips/include/asm/pgtable-64.h            |  2 +-
 arch/mips/mm/hugetlbpage.c                    | 10 ------
 arch/mips/mm/tlb-r4k.c                        |  2 +-
 arch/parisc/mm/hugetlbpage.c                  | 11 ------
 .../include/asm/book3s/64/pgtable-4k.h        | 20 -----------
 .../include/asm/book3s/64/pgtable-64k.h       | 25 --------------
 arch/powerpc/include/asm/book3s/64/pgtable.h  |  3 --
 arch/powerpc/include/asm/nohash/pgtable.h     | 10 ------
 arch/powerpc/mm/pgtable_64.c                  |  6 ++--
 arch/riscv/mm/hugetlbpage.c                   | 10 ------
 arch/s390/mm/hugetlbpage.c                    | 10 ------
 arch/sh/mm/hugetlbpage.c                      | 10 ------
 arch/sparc/mm/hugetlbpage.c                   | 12 -------
 arch/x86/mm/hugetlbpage.c                     | 26 --------------
 arch/x86/mm/pgtable.c                         |  4 +--
 include/linux/hugetlb.h                       | 24 -------------
 include/linux/pgtable.h                       | 24 ++++++++++---
 mm/gup.c                                      | 24 ++++++-------
 mm/hmm.c                                      |  9 ++---
 mm/memory.c                                   |  2 +-
 29 files changed, 56 insertions(+), 272 deletions(-)
 delete mode 100644 arch/arm/mm/hugetlbpage.c

-- 
2.44.0


