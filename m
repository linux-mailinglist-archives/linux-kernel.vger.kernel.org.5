Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2887F5BF6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 11:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344389AbjKWKIB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 05:08:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjKWKHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 05:07:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0956D10EB;
        Thu, 23 Nov 2023 02:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700734051; x=1732270051;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=eGrPJB71BQqPQgzBxdkMDsK/ebN3t2PqlY8XYy9ELos=;
  b=fySHu95rX65pKTF/wNvbOZ170G5WL0GKZQKbQWukKyWG2dbMqd8TxFPR
   gPQ2FtFwLy1Qmn0OkciwDjwcCQXBdpdZ7zofhQFLJSad9WvS+YdeG7IPp
   KCXTH7b32BSbiejOu2MQREjp9eLz+Q4yO7Gh0r7PtJdJT+LIhoPyYVWEQ
   8GVAb9Oiuuikd9Xcdye/JbXotxWItfhbhXPW9eVsQDmoDtxC6E632AiKg
   gnezJnIRBTrjhv58ASiAis4Gl95xGSOV71xgOdDaFmO772acVp1lGiVhN
   UttWsbHr3ls06V8NKSaIYrjCQtrid5/s9Qwuw1dzU5t/VvGuPieGSJG86
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="456576447"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="456576447"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 02:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767160544"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="767160544"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga002.jf.intel.com with ESMTP; 23 Nov 2023 02:07:26 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 5/5] perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()
Date:   Thu, 23 Nov 2023 15:36:17 +0530
Message-Id: <20231123100617.28020-6-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123100617.28020-1-raag.jadav@intel.com>
References: <20231123100617.28020-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have _UID matching support for integer types, we can use
acpi_dev_hid_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Will Deacon <will@kernel.org>
---
 drivers/perf/arm_cspmu/arm_cspmu.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/perf/arm_cspmu/arm_cspmu.c b/drivers/perf/arm_cspmu/arm_cspmu.c
index 2cc35dded007..50b89b989ce7 100644
--- a/drivers/perf/arm_cspmu/arm_cspmu.c
+++ b/drivers/perf/arm_cspmu/arm_cspmu.c
@@ -1108,7 +1108,6 @@ static int arm_cspmu_request_irq(struct arm_cspmu *cspmu)
 
 static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 {
-	u64 acpi_uid;
 	struct device *cpu_dev;
 	struct acpi_device *acpi_dev;
 
@@ -1118,8 +1117,7 @@ static inline int arm_cspmu_find_cpu_container(int cpu, u32 container_uid)
 
 	acpi_dev = ACPI_COMPANION(cpu_dev);
 	while (acpi_dev) {
-		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, NULL) &&
-		    !acpi_dev_uid_to_integer(acpi_dev, &acpi_uid) && acpi_uid == container_uid)
+		if (acpi_dev_hid_uid_match(acpi_dev, ACPI_PROCESSOR_CONTAINER_HID, container_uid))
 			return 0;
 
 		acpi_dev = acpi_dev_parent(acpi_dev);
-- 
2.17.1

