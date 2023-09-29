Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53B07B3B7A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbjI2Up1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 16:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233592AbjI2UpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 16:45:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6F1CC3;
        Fri, 29 Sep 2023 13:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696020323; x=1727556323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W0bEWWgNT9CiXugP8M24uRKr5rb4of+/WbVzOiaRxgM=;
  b=Pttkv4IPdHUOMfq2VW6pMSqG0Xfb/FTNfnRu3hVpxuz3PxzhxGfADaVL
   BIldTMQr2lYgtOZOY+GiBjG+q5e9gr1Qlpq02jJyGoP/GKk7bLGQiUFpl
   Y1jfC+y2qkXr4hhadAyWIOjKM+3hSPvFWs+/7t+jWmQQkVj0LCyX+JqWS
   s6HjBCQSYHzrHpvdGyQsvq/PzgZY+n03nDDX23qRzCKmeAj9o3IgFSbNd
   GX0hn78If226jfiRghMM5Sp4V4zPTj920VRcKUAHuY4CK73sjZwmMKsun
   mgb05xVU98TzaCdcYpbqEhXK881uvyJTZnJSoFKBvtuxShmwQWDenrLGR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="468654422"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="468654422"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:28:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="893539191"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="893539191"
Received: from jithujos.sc.intel.com ([172.25.103.66])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 13:27:28 -0700
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, jithu.joseph@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v3 1/9] platform/x86/intel/ifs: Store IFS generation number
Date:   Fri, 29 Sep 2023 13:24:28 -0700
Message-Id: <20230929202436.2850388-2-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230929202436.2850388-1-jithu.joseph@intel.com>
References: <20230922232606.1928026-1-jithu.joseph@intel.com>
 <20230929202436.2850388-1-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IFS generation number is reported via MSR_INTEGRITY_CAPS.  As IFS
support gets added to newer CPUs, some differences are expected during
IFS image loading and test flows.

Define MSR bitmasks to extract and store the generation in driver data,
so that driver can modify its MSR interaction appropriately.

Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
---
 arch/x86/include/asm/msr-index.h      | 1 +
 drivers/platform/x86/intel/ifs/ifs.h  | 2 ++
 drivers/platform/x86/intel/ifs/core.c | 3 +++
 3 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d111350197f..838e5a013a07 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -222,6 +222,7 @@
 #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
 #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
+#define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
 
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
index 306f886b52d2..4ff2aa4b484b 100644
--- a/drivers/platform/x86/intel/ifs/core.c
+++ b/drivers/platform/x86/intel/ifs/core.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/kdev_t.h>
 #include <linux/semaphore.h>
@@ -94,6 +95,8 @@ static int __init ifs_init(void)
 	for (i = 0; i < IFS_NUMTESTS; i++) {
 		if (!(msrval & BIT(ifs_devices[i].test_caps->integrity_cap_bit)))
 			continue;
+		ifs_devices[i].rw_data.generation = FIELD_GET(MSR_INTEGRITY_CAPS_SAF_GEN_MASK,
+							      msrval);
 		ret = misc_register(&ifs_devices[i].misc);
 		if (ret)
 			goto err_exit;
-- 
2.25.1

