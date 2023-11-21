Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920387F2AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjKUKjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjKUKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:39:09 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D04D137;
        Tue, 21 Nov 2023 02:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700563145; x=1732099145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Y6ds1jUN7LPSrZRrgey6FYqJOhCq9ZfRNZPabZ6KtHA=;
  b=M9+gDsOTpNJWH9op6O7/K3HXkqTffL7PmQy8oWaRVMCfgFeievRgX2n3
   0qC7VJzXIjT+m9nRCKmlcJ30ImDqg7hIGItp8rpO9bq5xlEpj8xwVLFD5
   6Cl3drPOVyrp8+fmQtxIb842/y1n/lHshxa4JxBJ0H//CNoXDZSDiKaRc
   tWPdl3JugLyv/St3Q5pw0pR8Oqn+SYcMSgjmPHIPJSPo8ZMpZF3/Cz7Qx
   c3fP8k5WqsqGW8k/O0kOuCyDucc4sPg4gNezAIviXzH/WtyIvXbrVLtVS
   oXe+3gXt3ycpTo/L4ssrTptosvQvf/1bvOcYwMrow4mzTA+yMEZ6Umvck
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371987049"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="371987049"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 02:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="14871962"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 21 Nov 2023 02:39:00 -0800
From:   Raag Jadav <raag.jadav@intel.com>
To:     mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        rafael@kernel.org, lenb@kernel.org, robert.moore@intel.com,
        ardb@kernel.org, will@kernel.org, mark.rutland@arm.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v2 6/6] perf: arm_cspmu: drop redundant acpi_dev_uid_to_integer()
Date:   Tue, 21 Nov 2023 16:08:29 +0530
Message-Id: <20231121103829.10027-7-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231121103829.10027-1-raag.jadav@intel.com>
References: <20231121103829.10027-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have _UID matching support for integer types, we can use
acpi_dev_hid_uid_match() for it.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
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

