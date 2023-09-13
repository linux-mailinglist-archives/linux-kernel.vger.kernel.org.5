Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7DB79F136
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjIMSiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:37:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EBC1BC6;
        Wed, 13 Sep 2023 11:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630274; x=1726166274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zYniCTlI2hRtCCmtPBhkZpW2hr3gRwPR25GRONFDmyM=;
  b=c22BAhIA5kRI5fagxc0Bfmd7/LS3xBFH51O2r5dj88HqIYaDgLjmj5va
   SCrgxnuHVc76+w+egJBIzThWDQ4LxvXl+fc3HxhTUwH2ppxvkp3VkCxD2
   iaUb5WVvg60SRm5+rVUaxeYuLVm0ED4MGcPvhEk1AOI37UeXAGo8OsSeu
   i8kVCYejyO6E4F1cLcJ3fQrC4v2v9t870DnvkVTrygDrq9FrlOwZO3Gij
   MgujrYqlp0nQXflxVsY2DRx2+eVmcuzdygoS4OoTvpHEgza9ETmztV9cp
   VzyFPtZkbf8jhaH/DofGw/hqnGSTgi3DoVw1UYRWpO3/0dE3xkQdrJlE8
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369019114"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="369019114"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744238575"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744238575"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:53 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH 01/10] platform/x86/intel/ifs: Store IFS generation number
Date:   Wed, 13 Sep 2023 11:33:39 -0700
Message-Id: <20230913183348.1349409-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913183348.1349409-1-jithu.joseph@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS generation number is reported via MSR_INTEGRITY_CAPS.
As IFS support gets added to newer CPUs, some differences
are expected during IFS image loading and test flows.

Define MSR bitmasks to extract and store the generation in
driver data, so that driver can modify its MSR interaction
appropriately.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 arch/x86/include/asm/msr-index.h      | 2 ++
 drivers/platform/x86/intel/ifs/ifs.h  | 2 ++
 drivers/platform/x86/intel/ifs/core.c | 2 ++
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d111350197f..a71a86a01488 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -222,6 +222,8 @@
 #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT	9
+#define MSR_INTEGRITY_CAPS_SAF_GEN_REV_MASK	(0x3ull << MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT)
 
 #define MSR_LBR_NHM_FROM		0x00000680
 #define MSR_LBR_NHM_TO			0x000006c0
diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 93191855890f..d666aeed20fc 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -229,6 +229,7 @@ struct ifs_test_caps {
  * @status: it holds simple status pass/fail/untested
  * @scan_details: opaque scan status code from h/w
  * @cur_batch: number indicating the currently loaded test file
+ * @generation: IFS test generation enumerated by hardware
  */
 struct ifs_data {
 	int	loaded_version;
@@ -238,6 +239,7 @@ struct ifs_data {
 	int	status;
 	u64	scan_details;
 	u32	cur_batch;
+	u32	generation;
 };
 
 struct ifs_work {
diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
index 306f886b52d2..88d84aad9334 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -94,6 +94,8 @@ static int __init ifs_init(void)
 	for (i = 0; i < IFS_NUMTESTS; i++) {
 		if (!(msrval & BIT(ifs_devices[i].test_caps->integrity_cap_bit)))
 			continue;
+		ifs_devices[i].rw_data.generation = (msrval & MSR_INTEGRITY_CAPS_SAF_GEN_REV_MASK)
+							>> MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT;
 		ret = misc_register(&ifs_devices[i].misc);
 		if (ret)
 			goto err_exit;
-- 
2.25.1

