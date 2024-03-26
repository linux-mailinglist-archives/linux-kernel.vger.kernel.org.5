Return-Path: <linux-kernel+bounces-118293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9B88B756
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336C0B22CC8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9912B165;
	Tue, 26 Mar 2024 02:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYYZyUFr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6DB12AAEA
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419450; cv=none; b=pgVp4duOHYAZgv+r+v7kDS7rxXReSUT3/lNfDrXCumgQ4V/rS0ZXEVn1zL7t7lYuZfCw7oBSGnNWAlpLNyZjnI/5T3lqgSkJUS7eFIvlO3Py1DVmo5aVlgPVPJtR5W4PMo6F6tVBcMy40BJIlnNOHuZK6h3djkFD5KS8tBH7B0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419450; c=relaxed/simple;
	bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j08hyYHb7aK3NxWz/o+qGEu3FgcQcWowi4482K5dRoL5ApHnEg8z6nce4TmNpWSNXNIV8Y0AzGUkIMBxiYuS6weeEP7JhBGicKcFDCkFjRGZIVY2E8RWq98tKscOaDajTlf2zphHfuiT0jVlWckTIkRZk1L+j9aos4a9i2lONwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYYZyUFr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419448; x=1742955448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Kz1B1g9YBWVQVBA7u5n8sBfRhBddgPHEWEy/INdrdY=;
  b=LYYZyUFrtDZkQhAOhqtCiGspppwQiSNYt0J9ZxHDi60absIqwAZ2EZR5
   pCBEajXfa3H9NHI68e+NyPUj8PnASFZxA7ZJOwBETuF7CFwpMR/90+46y
   A6IbGfBr23dXDkyOGz2AqMcy2MQ2Fk8PV4bqx3sVW+AZZLaCWCk+gNB3Z
   I5LHhzdXjHFuCcQgfUOshc21whlZ31lCYNvcN+Xdq5l/ehIokD/MXOseh
   NqBdTP1YCJcqqkoTj5+p8WnFCDnRuCU2GGuvewkDPhToZNgPK45DM6tCF
   FBS7wbeJxDJpwDGHzrua9+HoUysX5gl/gvAKWVAGeuNr3SoOduI90ztvv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564393"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564393"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489921"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:18 -0700
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
Subject: [PATCH v4 14/14] selftests/x86: Add placement guard gap test for shstk
Date: Mon, 25 Mar 2024 19:16:56 -0700
Message-Id: <20240326021656.202649-15-rick.p.edgecombe@intel.com>
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


