Return-Path: <linux-kernel+bounces-82212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 835BD86809A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E411F27599
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFEF1332A0;
	Mon, 26 Feb 2024 19:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jOT4lAGg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E05F132496
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708974607; cv=none; b=Bv9GsQsXNQOJWG6Y7mtcxJ4Q6juubHsE4xaX/TWiLDWIgUWG9jcGdAv/oyYgyfsu457LF74ENZJxbBZZvTpSyHsLC9UNLlP4qR3hmAC3btcM0RS29sdBZJYvfDSvOOi1++4Aq2Bax8KkTrMSrEd5hNOqpKHxGLw4TBX/Mqg81xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708974607; c=relaxed/simple;
	bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dikgc8YGooM1yMflyIaCpxnHE22e4TczU+1MHhu0GWoGr6afsQOj730HXxP37nYg3T9o65q2YasiNmU7qORD0fBtatmk2bSD1GrtRXDHoaHVjXFiFM1PKoI8Npv9TKVUXcfnXJpn6iaVJljgRI5GuEI4USpM5YxXti8A3+tvQbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jOT4lAGg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708974606; x=1740510606;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
  b=jOT4lAGgGPJSBIobtFG6DfkeDJDgCH9S1EcXTIpJpCTFNDri0NJf14+l
   oPC5sVR5E5RLLYfdmLBOiYsmoyATTvnh96egcmJn1rs4CtG+HqLkL9LoI
   Ew0vQAn5R+LW7AZiyn3e+uS9d4p7Bodw01OY/SLZuZpC8ri/rTx2b/UQw
   CFhhdD6iMng2Q3j8kVxc3owxbgRLoZAv0834YLBEKOyz6Jbb74JZd5e4X
   uZRyrmcC/iC5QP/JwpQwR6pArw9vHT0u5acncF0VipYu1mBU4qGSLnMmr
   YNfkH2UkDydNgcScAwHoZLJRs2P5DKVzMu115buy2CjIZWaBV75v5NJJ7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14721432"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="14721432"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6911475"
Received: from bdmirand-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.3.213])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:10:04 -0800
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
Subject: [PATCH v2 9/9] selftests/x86: Add placement guard gap test for shstk
Date: Mon, 26 Feb 2024 11:09:51 -0800
Message-Id: <20240226190951.3240433-10-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing shadow stack test for guard gaps just checks that new
mappings are not placed in an existing mapping's guard gap. Add one that
checks that new mappings are not placed such that preexisting mappings are
in the new mappings guard gap.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 .../testing/selftests/x86/test_shadow_stack.c | 67 +++++++++++++++++--
 1 file changed, 63 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 757e6527f67e..ee909a7927f9 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -556,7 +556,7 @@ struct node {
  *      looked at the shadow stack gaps.
  *   5. See if it landed in the gap.
  */
-int test_guard_gap(void)
+int test_guard_gap_other_gaps(void)
 {
 	void *free_area, *shstk, *test_map = (void *)0xFFFFFFFFFFFFFFFF;
 	struct node *head = NULL, *cur;
@@ -593,11 +593,64 @@ int test_guard_gap(void)
 	if (shstk - test_map - PAGE_SIZE != PAGE_SIZE)
 		return 1;
 
-	printf("[OK]\tGuard gap test\n");
+	printf("[OK]\tGuard gap test, other mapping's gaps\n");
 
 	return 0;
 }
 
+/* Tests respecting the guard gap of the mapping getting placed */
+int test_guard_gap_new_mappings_gaps(void)
+{
+	void *free_area, *shstk_start, *test_map = (void *)0xFFFFFFFFFFFFFFFF;
+	struct node *head = NULL, *cur;
+	int ret = 0;
+
+	free_area = mmap(0, PAGE_SIZE * 4, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	munmap(free_area, PAGE_SIZE * 4);
+
+	/* Test letting map_shadow_stack find a free space */
+	shstk_start = mmap(free_area, PAGE_SIZE, PROT_READ | PROT_WRITE,
+			   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (shstk_start == MAP_FAILED || shstk_start != free_area)
+		return 1;
+
+	while (test_map > shstk_start) {
+		test_map = (void *)syscall(__NR_map_shadow_stack, 0, PAGE_SIZE, 0);
+		if (test_map == MAP_FAILED) {
+			printf("[INFO]\tmap_shadow_stack MAP_FAILED\n");
+			ret = 1;
+			break;
+		}
+
+		cur = malloc(sizeof(*cur));
+		cur->mapping = test_map;
+
+		cur->next = head;
+		head = cur;
+
+		if (test_map == free_area + PAGE_SIZE) {
+			printf("[INFO]\tNew mapping has other mapping in guard gap!\n");
+			ret = 1;
+			break;
+		}
+	}
+
+	while (head) {
+		cur = head;
+		head = cur->next;
+		munmap(cur->mapping, PAGE_SIZE);
+		free(cur);
+	}
+
+	munmap(shstk_start, PAGE_SIZE);
+
+	if (!ret)
+		printf("[OK]\tGuard gap test, placement mapping's gaps\n");
+
+	return ret;
+}
+
 /*
  * Too complicated to pull it out of the 32 bit header, but also get the
  * 64 bit one needed above. Just define a copy here.
@@ -850,9 +903,15 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
-	if (test_guard_gap()) {
+	if (test_guard_gap_other_gaps()) {
 		ret = 1;
-		printf("[FAIL]\tGuard gap test\n");
+		printf("[FAIL]\tGuard gap test, other mappings' gaps\n");
+		goto out;
+	}
+
+	if (test_guard_gap_new_mappings_gaps()) {
+		ret = 1;
+		printf("[FAIL]\tGuard gap test, placement mapping's gaps\n");
 		goto out;
 	}
 
-- 
2.34.1


