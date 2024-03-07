Return-Path: <linux-kernel+bounces-94761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71EF8744ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CDE92857E8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B217F0;
	Thu,  7 Mar 2024 00:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gYWptQIE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA221A21;
	Thu,  7 Mar 2024 00:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769785; cv=none; b=gWWV/8JJXC6KyhH+AphrfcPppjgGd4z/Hjm+ZbPaFLy0UVJABkqGtFcdEPsXZ2c1PVKmeKT4WpLZxCJ0o3I8V7d+6eWAmftR1VYTy94J9jeB+UTYGVAADClQU8LHF6XexvdCc+vxM+tCFEB2oFQP7OMT3qyltpuY8OJSuY8S+MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769785; c=relaxed/simple;
	bh=UOKNzMhwVFkCQi+cFJQD6VB8TNDKSv/w2l7quwCmF0M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZSP/p+ok/SPuBcfYJ+yEsn3H1jpuk+eP7de+MkSBjeb2H66whageBQnIyQ8Ww9f/3ztPmu73rkNth3XOF/PL3FZhZ/jFFrGsaPhLaqkM/ZsaMCGYOnc8itvEApQH8pP0dv8DNRvagB8DBpcDXOp9xaURgpkXFF6klONmp5mkObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gYWptQIE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709769784; x=1741305784;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UOKNzMhwVFkCQi+cFJQD6VB8TNDKSv/w2l7quwCmF0M=;
  b=gYWptQIESomAq7sAnni17OATP7RUock1ACLjSVgFzT8/hrmtkxUxb6nW
   bbR8NPuwet4tBUOWG5+yH/S79sCxmOIpvyqyBYB0kd+9ToJUiE5p90ZnU
   9W3phV5Uz4s9qIKFjAzZarWhZ8Uwxnr5l0kvmcFTaak95cnxKtL4lzVMJ
   AglI9w4NMQ6mcpdHPB7nAHEiKzoRWLna7TTeCA3HirzLnYDa3rXQK5Lwy
   ZHLdPorD2hUud2rp7Fc1VroJIvQNPRGDmiGmUVD77yzdEZEzIM5noZC3H
   qrEqs9DVKKSRbvIJ1a8d45Su5zGlNJAsCrzjbe1xvP2CX9cf8CffcCBjk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="14990564"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14990564"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 16:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14506394"
Received: from agluck-desk3.sc.intel.com ([172.25.222.105])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 16:03:02 -0800
From: Tony Luck <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Naik, Avadhut" <avadnaik@amd.com>,
	"Mehta, Sohil" <sohil.mehta@intel.com>,
	"Yazen Ghannam" <yazen.ghannam@amd.com>,
	x86@kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tony Luck <tony.luck@intel.com>
Subject: [PATCH v2] x86/mce: Dynamically size space for machine check records
Date: Wed,  6 Mar 2024 16:02:56 -0800
Message-ID: <20240307000256.34352-1-tony.luck@intel.com>
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
---

Changes since v1: Link: https://lore.kernel.org/all/Zd--PJp-NbXGrb39@agluck-desk3/

Sohil:
	Group declaration of "order" with other int's in mce_gen_pool_create()
	Use #define MCE_MIN_ENTRIES instead of hard-coded inline "80"
	Missed kfree(mce_pool) in error path.

Yazen:
	Use order_base_2() instead of ilog2() as rounded up size of
	structure is needed.

Avadhut:
	Allocate 2 records per CPU

Me:
	Add a #define MCE_PER_CPU for number of records per CPU

 arch/x86/kernel/cpu/mce/genpool.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index fbe8b61c3413..42ce3dc97ca8 100644
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
@@ -118,16 +118,27 @@ int mce_gen_pool_add(struct mce *mce)
 
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
 		goto out;
 
-	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
+	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
+	mce_poolsz = mce_numrecords * (1 << order);
+	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
+	if (!mce_pool) {
+		gen_pool_destroy(tmpp);
+		goto out;
+	}
+	ret = gen_pool_add(tmpp, (unsigned long)mce_pool, mce_poolsz, -1);
 	if (ret) {
 		gen_pool_destroy(tmpp);
+		kfree(mce_pool);
 		goto out;
 	}
 

base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
-- 
2.43.0


