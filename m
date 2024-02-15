Return-Path: <linux-kernel+bounces-67822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE44685716D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75EF7281058
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 23:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C73C14D45B;
	Thu, 15 Feb 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H6vzGf+G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B066414AD33
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 23:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038887; cv=none; b=AslqiY01oZZZiGFUlinZpzgtDAPiFtoj6JrycAVWJLBSbIFeVarZOA+4reuALaJQ90SuM+FuJdmEHykNK0VO61t+iTHHNdcpBpfa4uNT3T5lPfS8a7P58vXdbIzT/DmiTBLugZRfms0AKk0Y44netZwy3WFPro/ySkKuKBO5O3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038887; c=relaxed/simple;
	bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msJYnINfhEOeZrhRClKwDQIrm/m4FvFX9r18C1KodfJq/FDQvx+GB9u4zHX/v8HSargdVcQlzpzICWZ0Yc1zYQ4OJYdmYlqWfCSjp3OEsUxkbPCSRpwJ1+aPRVkMcaw4Rp2NYLgLSfT0ExKH8E7o7vIC/M+MWKyhN5BDKq6RtHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H6vzGf+G; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708038886; x=1739574886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
  b=H6vzGf+Gbtr4uatpgey901EkkN8dPcjUaVdbO6ZsJGj5Ur+Xc5qO9Opw
   OnFSvkA7WtptVm/9vxwk0aCVCUukpqtxR7o4j2pWxbxkHaclbjelHyHmg
   cc4d1WB7+3S5ED2JmKYuPwG9ETKkiTvzl+cryHxPJGyeI8AmDJ7t59k3Z
   Mj9zaPtrbP1c2fnap0C5jU9tGEG4pxm3A0/tzT7RqneVuJwKF5VAB6qHh
   d+87yCZHSOP6kfPSRDxDkSab9Hm79hlZAk3GVizaJZHPtnLzwXI74Le/b
   Uir8ooXOQat0wlL5JvslqDgKk9/E4Y+caJCrsbtxLS1jfDnmZi+OO6wZb
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2066410"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="2066410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912250210"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912250210"
Received: from yshin-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.95.133])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 15:14:42 -0800
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
Subject: [RFC PATCH 8/8] selftests/x86: Add placement guard gap test for shstk
Date: Thu, 15 Feb 2024 15:13:32 -0800
Message-Id: <20240215231332.1556787-9-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
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


