Return-Path: <linux-kernel+bounces-96103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4187571C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D77F6B222A6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D752213666A;
	Thu,  7 Mar 2024 19:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZ0SfAgN"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EC8136980;
	Thu,  7 Mar 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839636; cv=none; b=LKuUtuXaMJitxPh2IO0zgC5rvoxHs/cUcQhcc9UEEqhcBGzhM/DXR0yxPN0GuROB3kycFp1vyq2woWIWYIHM1aZ8oTbWfNJR8btPzpD19JF7HUt734X9FHTV02pzudo0eSi6hzSywZ5hbxKLFnQ2bbMIBt/eM1rFb9QQIj0qZGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839636; c=relaxed/simple;
	bh=O9HYUfGhBrMg/vLIPn1khVFtzwO/60/tyJqtjWCD8sg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fSkrFTPn/DN1gKpxu/2JXG3sSu/kc3KkqpC1EAtXQRw2YrljtJ2eBWjvKSUQGxJZrWJajUWALLpHCsGZo1tMNFJgLK9AEQvOsNbt8JOyFsW+aiZKUuKzi7f5T/ba8r/YeYy8Y1tYgk8Z3fP+HzATUKUaOelA+YoG8z/MTSba3GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PZ0SfAgN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709839634; x=1741375634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O9HYUfGhBrMg/vLIPn1khVFtzwO/60/tyJqtjWCD8sg=;
  b=PZ0SfAgNUdvdcdshRph9WdfPLnvbX9ty+SYaMrHEvr0lsfJfjTJxtDHJ
   QLX/vKiHotwfibQlB2jTM57WhkXYizpF6P1SxWPvk3BJL+muDTydG+C2F
   37nBFTnI5+nGQPMcaEYFfScOmbCP1MLEc4unwqw0Kjge8FUTQDztIK89K
   gxEGVCEjTo9oR5vkOHUGd3dQyMB5S4FyM4uBofmfhvGf8IWCW3pIebJN1
   R4luJtpQ/R8V9D/EJMAwC0Rz0LN+COm8Aj8cBjkLslIWHagbxJiP/iBh2
   Cy0zoPw0Fvb66PcUKqdn521Zzijvsd6ieOLewfNE7DWqD0FS5wHPVSLhz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4654556"
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="4654556"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,107,1708416000"; 
   d="scan'208";a="10287693"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 11:27:13 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Yazen Ghannam" <yazen.ghannam@amd.com>,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v3] x86/mce: Dynamically size space for machine check records
Date: Thu,  7 Mar 2024 11:27:04 -0800
Message-ID: <20240307192704.37213-1-tony.luck@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Systems with a large number of CPUs may generate a large
number of machine check records when things go seriously
wrong. But Linux has a fixed buffer that can only capture
a few dozen errors.

Allocate space based on the number of CPUs (with a minimum
value based on the historical fixed buffer that could store
80 records).

Signed-off-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---

Changes since V2; Link: https://lore.kernel.org/all/20240307000256.34352-1-tony.luck@intel.com/

Boris: Eliminate "out:" label in mce_gen_pool_create()

Sohil: Added Reviewed-by tag

 arch/x86/kernel/cpu/mce/genpool.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index fbe8b61c3413..cadf28662a70 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -16,14 +16,14 @@
  * used to save error information organized in a lock-less list.
  *
  * This memory pool is only to be used to save MCE records in MCE context.
- * MCE events are rare, so a fixed size memory pool should be enough. Use
- * 2 pages to save MCE events for now (~80 MCE records at most).
+ * MCE events are rare, so a fixed size memory pool should be enough.
+ * Allocate on a sliding scale based on number of CPUs.
  */
-#define MCE_POOLSZ	(2 * PAGE_SIZE)
+#define MCE_MIN_ENTRIES	80
+#define MCE_PER_CPU	2
 
 static struct gen_pool *mce_evt_pool;
 static LLIST_HEAD(mce_event_llist);
-static char gen_pool_buf[MCE_POOLSZ];
 
 /*
  * Compare the record "t" with each of the records on list "l" to see if
@@ -118,22 +118,32 @@ int mce_gen_pool_add(struct mce *mce)
 
 static int mce_gen_pool_create(void)
 {
+	int mce_numrecords, mce_poolsz, order;
 	struct gen_pool *tmpp;
 	int ret = -ENOMEM;
+	void *mce_pool;
 
-	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
+	order = order_base_2(sizeof(struct mce_evt_llist));
+	tmpp = gen_pool_create(order, -1);
 	if (!tmpp)
-		goto out;
+		return ret;
 
-	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
+	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
+	mce_poolsz = mce_numrecords * (1 << order);
+	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
+	if (!mce_pool) {
+		gen_pool_destroy(tmpp);
+		return ret;
+	}
+	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
 	if (ret) {
 		gen_pool_destroy(tmpp);
-		goto out;
+		kfree(mce_pool);
+		return ret;
 	}
 
 	mce_evt_pool = tmpp;
 
-out:
 	return ret;
 }
 

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.43.0


