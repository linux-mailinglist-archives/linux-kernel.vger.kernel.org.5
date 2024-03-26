Return-Path: <linux-kernel+bounces-118289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2456C88B750
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:19:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92D7D1F3F7B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C89129A83;
	Tue, 26 Mar 2024 02:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fDo5v7yr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D980D127B75
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419445; cv=none; b=ucYo9L6u/uyV/BZzFCzHctmgK4qfCqJtAq0VxfZHSrjDg1eyC4vIPPdcUoTc/C+3J0SMCvBeItyvpmig9ytirly/TegW/S1xjPH7gjmHLSomkkmTIDa/bthOvUFlkpdx5hEOwhF0P5VN1lDYWWHprS3vXwXyYJ9lnmnC5R7ZjgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419445; c=relaxed/simple;
	bh=BjoIXKt5bAU2p5uENJE46EVXE51w6Jj985k5TB+SvjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2bYsez6Xae0m8sv9NJr9d2QXZDBEXCTwmsodQo3QLBIUoi7r1dcwsaNRy+/kYBn1JLsZ8laB9LM0fZ5qgkvqLms7cxo74S+ZrBa8za7JNG8P9gK3hWHyDphQGaIYL2qW1g0jGcujehi22glRwYSp0OqCBT9EYQh8wNAFepozvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fDo5v7yr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419443; x=1742955443;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BjoIXKt5bAU2p5uENJE46EVXE51w6Jj985k5TB+SvjQ=;
  b=fDo5v7yrPWxGzUR4dNsGTgKg4umlk/mlCBEF8KQQlR6Fj2hKhXqFUPf3
   64HBX5rsydtFfaNSgNA+25vBKDKt3cM0BVhp1kVpypRElm2D+dj8auhVN
   /+sGnW5DvTz1biR6Jg7HhVkzWKCyl5n3FAziq/swRsQ5N+HRPSvZMCjB5
   pdOI3so9teb+/7TtujYz+ISBGiQdOjfsRTw9lsng2f7wMLAoqCtnOKtjP
   ZRNUtnQOeNHqDnOr6AwUbAhaXlTxRv+LktCzC85DdX9snTnNDUqektNQs
   26jZVA3ltaH76RsPKaI/O+vPhWFWqHrJDELBaGP5s2Fsr+AEKddfyXgo9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564322"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564322"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489901"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:16 -0700
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
	linux-mm@kvack.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 09/14] powerpc: Use initializer for struct vm_unmapped_area_info
Date: Mon, 25 Mar 2024 19:16:51 -0700
Message-Id: <20240326021656.202649-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
References: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
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
v4:
 - Remove designated zero initialization (Christophe Leroy)

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
 arch/powerpc/mm/book3s64/slice.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/mm/book3s64/slice.c b/arch/powerpc/mm/book3s64/slice.c
index c0b58afb9a47..ef3ce37f1bb3 100644
--- a/arch/powerpc/mm/book3s64/slice.c
+++ b/arch/powerpc/mm/book3s64/slice.c
@@ -282,12 +282,10 @@ static unsigned long slice_find_area_bottomup(struct mm_struct *mm,
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
+		.length = len,
+		.align_mask = PAGE_MASK & ((1ul << pshift) - 1),
+	};
 	/*
 	 * Check till the allow max value for this mmap request
 	 */
@@ -326,13 +324,13 @@ static unsigned long slice_find_area_topdown(struct mm_struct *mm,
 {
 	int pshift = max_t(int, mmu_psize_defs[psize].shift, PAGE_SHIFT);
 	unsigned long found, prev;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.flags = VM_UNMAPPED_AREA_TOPDOWN,
+		.length = len,
+		.align_mask = PAGE_MASK & ((1ul << pshift) - 1),
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


