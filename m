Return-Path: <linux-kernel+bounces-92907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B44538727E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5E7A1C27059
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DF018639;
	Tue,  5 Mar 2024 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JMGanj5g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2CB5C619;
	Tue,  5 Mar 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668031; cv=none; b=Cifon236hi62QyiLlkf3tvBB/my859wl0g8GhzD6yj/NIZonIcy5A/ZHRxA8/ithseU/BELbGEvDhMV/VxGT0GRr6yQEUc3LHjgcHarxJp/w4rLdtjXRSLwF233OE7Y+6RP8lHfoOzm97uiIsxFmCZeDTLYf9yTnj9qdzfPgco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668031; c=relaxed/simple;
	bh=kuoYnsDLmW/wxuxNi4a6n7MjG9q5R/wZqtXOSAbz7p0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y5YK3fNfmBBdYbx9RPKscKOzA6TEE6oyyfSIbeasTfQtvaQ8F9Vh/GET6bNQ0uHJhetXK95Cc8zgwROLRiexoMGJLS3A2Xe6ezmRjkSCaQasg5UZKVs3jEFqHD3gqf3yphDH/pfa/jxmydi0EVB1Y+5hxgUa1At9qraWgGzMhCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JMGanj5g; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709668031; x=1741204031;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kuoYnsDLmW/wxuxNi4a6n7MjG9q5R/wZqtXOSAbz7p0=;
  b=JMGanj5gWiyvzj3vPF6/9x8TeO7b071tslUzcawtqjtajzyFMYgySkGn
   FvzaZseScrrpaAz/ltBp+DjxCdNIyruwH+fGQvAjWCHoh9ufsKEs9LL1F
   7LhERh5t3KtiJZJaiV6Q59Hfil7f7UHyG+kGWcGOb3CV+qW52zMTH4CPl
   2FRvAnnONkGbXJFZ+Eg10bA4WkYx+6DE5G4Qgbdwd764c3kIqKDE96S2H
   tXsOXX6q6gJxgFxgRCGekPp5vcLO15nOjo2HZAPu1hqHYRMQeISIBMrxY
   +5LrTOnkea7g6U3E046XyrmHg9sbG5btZFOfsCIvO8LHiiNQWlADn0bqN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4121795"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4121795"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 11:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14057021"
Received: from spandruv-desk.jf.intel.com ([10.54.75.14])
  by fmviesa004.fm.intel.com with ESMTP; 05 Mar 2024 11:47:09 -0800
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: hdegoede@redhat.com,
	markgross@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/intel/tpmi: Change vsec offset to u64
Date: Tue,  5 Mar 2024 11:46:44 -0800
Message-Id: <20240305194644.2077867-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The vsec offset can be 64 bit long depending on the PFS start. So change
type to u64. Also use 64 bit formatting for seq_printf.

Fixes: 47731fd2865f ("platform/x86/intel: Intel TPMI enumeration driver")
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.3+
---
This is a forward looking change. There is no platform with this issue.
This can go through regular cycle.

 drivers/platform/x86/intel/tpmi.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/intel/tpmi.c b/drivers/platform/x86/intel/tpmi.c
index e73cdea67fff..910df7c654f4 100644
--- a/drivers/platform/x86/intel/tpmi.c
+++ b/drivers/platform/x86/intel/tpmi.c
@@ -96,7 +96,7 @@ struct intel_tpmi_pfs_entry {
  */
 struct intel_tpmi_pm_feature {
 	struct intel_tpmi_pfs_entry pfs_header;
-	unsigned int vsec_offset;
+	u64 vsec_offset;
 	struct intel_vsec_device *vsec_dev;
 };
 
@@ -376,7 +376,7 @@ static int tpmi_pfs_dbg_show(struct seq_file *s, void *unused)
 			read_blocked = feature_state.read_blocked ? 'Y' : 'N';
 			write_blocked = feature_state.write_blocked ? 'Y' : 'N';
 		}
-		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%08x\t%c\t%c\t\t%c\t\t%c\n",
+		seq_printf(s, "0x%02x\t\t0x%02x\t\t0x%04x\t\t0x%04x\t\t0x%02x\t\t0x%016llx\t%c\t%c\t\t%c\t\t%c\n",
 			   pfs->pfs_header.tpmi_id, pfs->pfs_header.num_entries,
 			   pfs->pfs_header.entry_size, pfs->pfs_header.cap_offset,
 			   pfs->pfs_header.attribute, pfs->vsec_offset, locked, disabled,
@@ -395,7 +395,8 @@ static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
 	struct intel_tpmi_pm_feature *pfs = s->private;
 	int count, ret = 0;
 	void __iomem *mem;
-	u32 off, size;
+	u32 size;
+	u64 off;
 	u8 *buffer;
 
 	size = TPMI_GET_SINGLE_ENTRY_SIZE(pfs);
@@ -411,7 +412,7 @@ static int tpmi_mem_dump_show(struct seq_file *s, void *unused)
 	mutex_lock(&tpmi_dev_lock);
 
 	for (count = 0; count < pfs->pfs_header.num_entries; ++count) {
-		seq_printf(s, "TPMI Instance:%d offset:0x%x\n", count, off);
+		seq_printf(s, "TPMI Instance:%d offset:0x%llx\n", count, off);
 
 		mem = ioremap(off, size);
 		if (!mem) {
-- 
2.43.0


