Return-Path: <linux-kernel+bounces-100893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9BDB879EB1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 867F42883DF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B62814564F;
	Tue, 12 Mar 2024 22:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RITabw2D"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7801448D5
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282550; cv=none; b=s6C3Roe3TE4MWsM2fF90m7hCl0azbpYjhvWfLNdOhNEHV8WgBR8kNDXmKnQzefDMyi2Lvqhp/IeT+35hP6g2d+v9BzeDV6c7tpYp8daHXwgroiinTDjtyV0O9pcuLzOOuuWq7AQSvO97Me7tZbC/zc+ecMSb6rMF+Ygd+9R0AXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282550; c=relaxed/simple;
	bh=SOxmdONZG+ooJ46ryKwSr/UQJN1BRbIVpZR9p2Kx8ZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vf5YJ06agcMTvPzS/KtWG9xiXOotpvIWwV6hGeyCs0bbdgopT63aeXnASOkPCn6WsmxjXZep161ObErVHtv5x2CQCjOCfLpIWzVOyTc9RsGPI/RvjglkH2FIeEGpQgzA0XdyHoDnMw68HlN/1c466Dx4ztNeOCa44IW/80Tp4S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RITabw2D; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282549; x=1741818549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SOxmdONZG+ooJ46ryKwSr/UQJN1BRbIVpZR9p2Kx8ZQ=;
  b=RITabw2DjNdHts4LOOzYBA7YTt5/3f8/fMVgayp5PF17FEOURjdpRMc2
   dP4D+/JMMlyShm3x3XrpOpEuvKU+7Wc7f2T3EmUHnWfEJFSejBCXf5Xrb
   n7mXGE7kg59XQE7R7HejawVdbj0yeu/GRYAeHhcb/owp+ypAqjHQPB0aF
   M3nC3/QUfoItaHx9rKQbOab21HFn0Jzmvpkb0tUSAsf0ENsUtBnMuRaxg
   KNZQyLiHGQL6sSfJPkXEPnMYeqvxcna4GF9T78gln5tTjG6+q4PkIplrV
   fOZUAgxnMS2US23YPdMnM1D0R9NQAFLHzxAkU4w+qosKWeoNX5hXzYIQd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5192005"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5192005"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356860"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:03 -0700
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
	rick.p.edgecombe@intel.com,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 07/12] powerpc: Use initializer for struct vm_unmapped_area_info
Date: Tue, 12 Mar 2024 15:28:38 -0700
Message-Id: <20240312222843.2505560-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will need to add a new member to struct
vm_unmapped_area_info. This would cause trouble for any call site that
doesn't initialize the struct. Currently every caller sets each member
manually, so if new members are added they will be uninitialized and the
core code parsing the struct will see garbage in the new member.

It could be possible to initialize the new member manually to 0 at each
call site. This and a couple other options were discussed, and a working
consensus (see links) was that in general the best way to accomplish this
would be via static initialization with designated member initiators.
Having some struct vm_unmapped_area_info instances not zero initialized
will put those sites at risk of feeding garbage into vm_unmapped_area() if
the convention is to zero initialize the struct and any new member addition
misses a call site that initializes each member manually.

It could be possible to leave the code mostly untouched, and just change
the line:
struct vm_unmapped_area_info info
to:
struct vm_unmapped_area_info info = {};

However, that would leave cleanup for the members that are manually set
to zero, as it would no longer be required.

So to be reduce the chance of bugs via uninitialized members, instead
simply continue the process to initialize the struct this way tree wide.
This will zero any unspecified members. Move the member initializers to the
struct declaration when they are known at that time. Leave the members out
that were manually initialized to zero, as this would be redundant for
designated initializers.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/
---
v3:
 - Fixed spelling errors in log
 - Be consistent about field vs member in log

Hi,

This patch was split and refactored out of a tree-wide change [0] to just
zero-init each struct vm_unmapped_area_info. The overall goal of the
series is to help shadow stack guard gaps. Currently, there is only one
arch with shadow stacks, but two more are in progress. It is compile tested
only.

There was further discussion that this method of initializing the structs
while nice in some ways has a greater risk of introducing bugs in some of
the more complicated callers. Since this version was reviewed my arch
maintainers already, leave it as was already acknowledged.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20240226190951.3240433-6-rick.p.edgecombe@intel.com/
---
 arch/powerpc/mm/book3s64/slice.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index c0b58afb9a47..6c7ac8c73a6c 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -282,12 +282,12 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long found, next_end;
-	struct vm_unmapped_area_info info;
-
-	info.flags = 0;
-	info.length = len;
-	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
-	info.align_offset = 0;
+	struct vm_unmapped_area_info info = {
+		.flags = 0,
+		.length = len,
+		.align_mask = PAGE_MASK & ((1ul << pshift) - 1),
+		.align_offset = 0
+	};
 	/*
 	 * Check till the allow max value for this mmap request
 	 */
@@ -326,13 +326,14 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long found, prev;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.flags = VM_UNMAPPED_AREA_TOPDOWN,
+		.length = len,
+		.align_mask = PAGE_MASK & ((1ul << pshift) - 1),
+		.align_offset = 0
+	};
 	unsigned long min_addr = max(PAGE_SIZE, mmap_min_addr);
 
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.align_mask = PAGE_MASK & ((1ul << pshift) - 1);
-	info.align_offset = 0;
 	/*
 	 * If we are trying to allocate above DEFAULT_MAP_WINDOW
 	 * Add the different to the mmap_base.
-- 
2.34.1


