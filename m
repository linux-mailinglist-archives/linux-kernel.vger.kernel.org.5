Return-Path: <linux-kernel+bounces-100898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D8A879EBB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:31:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5143BB24657
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CB5145FF8;
	Tue, 12 Mar 2024 22:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e8ZO6C39"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F63D145674
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710282554; cv=none; b=b9iev4w30z8ied/BilL/erGzWaulC7OfuUqQYQJX5E6nk4ob5jsw7ysE7GfLm+0dV1pCevReL4RUw2lI+7sW1ClP8G5FumvPvai0/aaMjlCce8kSmZSscc1v9fxHJ/bDQgFMNapmWCKppjTFbNzqassIVMJJoFtfHq0Zh6BjbZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710282554; c=relaxed/simple;
	bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HIDaueI3VY54MGTDaicJCnFobKIMg0HKnwGJaPDoNiXldwlFZaOCv9sku8ekOnHJ0JL0v1yuGUVmb10bGcwgbO0JQLfAgpRBYNj0wxz9f24hghu6Q/mL3kNIZ+DiN4iUWRfk5ffTie1m/BJcxwzoUX5yUcgbAPx24GWFh5VMmqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e8ZO6C39; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710282553; x=1741818553;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
  b=e8ZO6C39lQATqSmUewTLf/q93OfAJeT8nyWFJx5ZM0q4yK4BtupB2wYu
   /q4HH50m397PQn1hreOnAYB04BTXrxAY2wTj6E0h9FYC1ggBfzjiGWBQD
   OFP7nISyj/OyMmMjo0kCAZrmKtnhri8ib5xlRlGdVYpf7+6RxqS5jDtq3
   a0JzGcRfC/9gKAqC4gWGOlHkL/2FyREzjyEjRMGqAcYHf9A03cT7mfAhP
   16indzBY7i3NC9H1144dQJ0orsk1KQK4/6eK9avIZSZnXKxG+x5WRCVG1
   d5Qx4p/X2Czo3XFoDIHPLVXcFW82P4iTH5KPqTIMHmk/Cn3ykZssl14R8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5192091"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5192091"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="16356888"
Received: from gargayus-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.255.231.196])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 15:29:05 -0700
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
Subject: [PATCH v3 12/12] selftests/x86: Add placement guard gap test for shstk
Date: Tue, 12 Mar 2024 15:28:43 -0700
Message-Id: <20240312222843.2505560-13-rick.p.edgecombe@intel.com>
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


