Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8B5777CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbjHJP5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236278AbjHJP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:57:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBF526B9;
        Thu, 10 Aug 2023 08:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691683060; x=1723219060;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9/T4v2V+yA3mEh+9HZo2xrCffsz0nfS/ly/siL4hZ4U=;
  b=HhgIMkQ6/764HAzU4zzo852IHQZHjTEAb9A38xIAFfuJtqkn/w+N/dQK
   p73jj4TGbUV/pZoWLuXyoyd/ss0Iyc57M1JHSAeR5jMDronx4evZhmawU
   w0EWqrlNcCJsMH0r4Q8/Zvze84sGX1+Wd+RFMcSA5pZtYr6UK1ppKexQ7
   gZF/EIDnzew/ymYETG3IbtPyBWEB/4QMZElA+y1pH/EmjBiOj7SWrO14Y
   BNxUsqriAvMd2Hq8k4dmlReUyZTvlFNEuKSDsaW1pcuMd7gajcqKf1sVz
   TqP9HaFPzi8sv+PjVkp3BbpZ4BHU04FWS3KDee6B0lVGM6uvJaReJNkLg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374209326"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="374209326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:57:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="709212689"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="709212689"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 10 Aug 2023 08:57:16 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1621C1D9; Thu, 10 Aug 2023 19:01:50 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] ACPI: x86: s2idle: Add for_each_lpi_constraint() helper
Date:   Thu, 10 Aug 2023 19:01:39 +0300
Message-Id: <20230810160139.59201-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <ZNUGoONuUZAp0TM9@smile.fi.intel.com>
References: <ZNUGoONuUZAp0TM9@smile.fi.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have one existing and one coming user of this macro.
Introduce a helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/x86/s2idle.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
index ce62e61a9605..a8aa7299039e 100644
--- a/drivers/acpi/x86/s2idle.c
+++ b/drivers/acpi/x86/s2idle.c
@@ -94,6 +94,11 @@ static struct lpi_constraints *lpi_constraints_table;
 static int lpi_constraints_table_size;
 static int rev_id;
 
+#define for_each_lpi_constraint(entry)						\
+	for (int i = 0;								\
+	     entry = &lpi_constraints_table[i], i < lpi_constraints_table_size;	\
+	     i++)
+
 static void lpi_device_get_constraints_amd(void)
 {
 	union acpi_object *out_obj;
@@ -293,30 +298,29 @@ static void lpi_device_get_constraints(void)
 
 static void lpi_check_constraints(void)
 {
-	int i;
+	struct lpi_constraints *entry;
 
-	for (i = 0; i < lpi_constraints_table_size; ++i) {
-		acpi_handle handle = lpi_constraints_table[i].handle;
-		struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
+	for_each_lpi_constraint(entry) {
+		struct acpi_device *adev = acpi_fetch_acpi_dev(entry->handle);
 
 		if (!adev)
 			continue;
 
-		acpi_handle_debug(handle,
+		acpi_handle_debug(entry->handle,
 			"LPI: required min power state:%s current power state:%s\n",
-			acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+			acpi_power_state_string(entry->min_dstate),
 			acpi_power_state_string(adev->power.state));
 
 		if (!adev->flags.power_manageable) {
-			acpi_handle_info(handle, "LPI: Device not power manageable\n");
-			lpi_constraints_table[i].handle = NULL;
+			acpi_handle_info(entry->handle, "LPI: Device not power manageable\n");
+			entry->handle = NULL;
 			continue;
 		}
 
-		if (adev->power.state < lpi_constraints_table[i].min_dstate)
-			acpi_handle_info(handle,
+		if (adev->power.state < entry->min_dstate)
+			acpi_handle_info(entry->handle,
 				"LPI: Constraint not met; min power state:%s current power state:%s\n",
-				acpi_power_state_string(lpi_constraints_table[i].min_dstate),
+				acpi_power_state_string(entry->min_dstate),
 				acpi_power_state_string(adev->power.state));
 	}
 }
-- 
2.40.0.1.gaa8946217a0b

