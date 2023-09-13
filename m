Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6491879F138
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjIMSiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjIMSh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:37:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9DA3;
        Wed, 13 Sep 2023 11:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694630275; x=1726166275;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7jiyu/bEO46k0jXXC149ozOKb3OC/lXOxys31r8AOQ4=;
  b=UcDrEkDT3xdrOQNdO1It/PixlfB7HUjyEMkl5vulR7pmWhKlIMXEbHLF
   U24H+EmN/N2/lZSg4nUtSoH632fQQzRzVANxf+F6dGGaqjgiwvhAK2Lib
   FzLQTieB5a+l+RytnYTW1c2nRQMwKKhocVK4JGK9rvMoEulh5epcis5Ix
   hLYYat8Umfo4S2lWUlhuLMkLnZhCSWNzN2sCyQFrXRDkrx3vImNmfzpHH
   Bfg+PNjdNcpPc8x6aYty3akLGDVQlJfxvp3Dx4BF6KaS/T83F+VntNXvF
   bS7WjljqiRZC9lETcDFvXn9wPKhStLTJa3xIwY/BiZnSFdhGX6TdUJw/s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="369019143"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="369019143"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744238584"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744238584"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 11:37:55 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: [PATCH 04/10] platform/x86/intel/ifs: Scan test for new generations
Date:   Wed, 13 Sep 2023 11:33:42 -0700
Message-Id: <20230913183348.1349409-5-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230913183348.1349409-1-jithu.joseph@intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make changes to scan test flow such that MSRs are populated
appropriately based on the generation supported by hardware.

Width of chunk related bitfields is ACTIVATE_SCAN and SCAN_STATUS MSRs
are different in newer IFS generation compared to gen0.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h     | 14 ++++++++++++++
 drivers/platform/x86/intel/ifs/runtest.c | 23 ++++++++++++++++++-----
 2 files changed, 32 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 886dc74de57d..3265a6d8a6f3 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -205,6 +205,12 @@ union ifs_scan {
 		u32	delay	:31;
 		u32	sigmce	:1;
 	};
+	struct {
+		u16	start;
+		u16	stop;
+		u32	delay	:31;
+		u32	sigmce	:1;
+	} gen2;
 };
 
 /* MSR_SCAN_STATUS bit fields */
@@ -219,6 +225,14 @@ union ifs_status {
 		u32	control_error		:1;
 		u32	signature_error		:1;
 	};
+	struct {
+		u16	chunk_num;
+		u16	chunk_stop_index;
+		u8	error_code;
+		u32	rsvd1			:22;
+		u32	control_error		:1;
+		u32	signature_error		:1;
+	} gen2;
 };
 
 /* MSR_ARRAY_BIST bit fields */
diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
index 1061eb7ec399..4bbab6be2fa2 100644
--- a/drivers/platform/x86/intel/ifs/runtest.c
+++ b/drivers/platform/x86/intel/ifs/runtest.c
@@ -171,6 +171,8 @@ static void ifs_test_core(int cpu, struct device *dev)
 	union ifs_status status;
 	unsigned long timeout;
 	struct ifs_data *ifsd;
+	int to_start, to_stop;
+	int status_chunk;
 	u64 msrvals[2];
 	int retries;
 
@@ -179,13 +181,21 @@ static void ifs_test_core(int cpu, struct device *dev)
 	activate.rsvd = 0;
 	activate.delay = IFS_THREAD_WAIT;
 	activate.sigmce = 0;
-	activate.start = 0;
-	activate.stop = ifsd->valid_chunks - 1;
+	to_start = 0;
+	to_stop = ifsd->valid_chunks - 1;
+
+	if (ifsd->generation) {
+		activate.gen2.start = to_start;
+		activate.gen2.stop = to_stop;
+	} else {
+		activate.start = to_start;
+		activate.stop = to_stop;
+	}
 
 	timeout = jiffies + HZ / 2;
 	retries = MAX_IFS_RETRIES;
 
-	while (activate.start <= activate.stop) {
+	while (to_start <= to_stop) {
 		if (time_after(jiffies, timeout)) {
 			status.error_code = IFS_SW_TIMEOUT;
 			break;
@@ -202,7 +212,8 @@ static void ifs_test_core(int cpu, struct device *dev)
 		if (!can_restart(status))
 			break;
 
-		if (status.chunk_num == activate.start) {
+		status_chunk = ifsd->generation ? status.gen2.chunk_num : status.chunk_num;
+		if (status_chunk == to_start) {
 			/* Check for forward progress */
 			if (--retries == 0) {
 				if (status.error_code == IFS_NO_ERROR)
@@ -211,7 +222,9 @@ static void ifs_test_core(int cpu, struct device *dev)
 			}
 		} else {
 			retries = MAX_IFS_RETRIES;
-			activate.start = status.chunk_num;
+			ifsd->generation ? (activate.gen2.start = status_chunk) :
+			 (activate.start = status_chunk);
+			to_start = status_chunk;
 		}
 	}
 
-- 
2.25.1

