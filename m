Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4177BBDC4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 19:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbjJFRbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 13:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjJFRbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 13:31:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD3C2;
        Fri,  6 Oct 2023 10:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696613471; x=1728149471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5PKJcHQuGAJasXvUQcWL2vxKmsvzbQLbVutteBr3/jA=;
  b=Gicp4+CnPPBUApl6gAvC5Gm71MbpjKRDgvwKVs1aKAud3J24UtbMliKK
   HkpXp5XiijWVqTVlzAlvB580aRC+7wrhOIfecncRJRnnQGSw92Dg34ANr
   DJG0zN4T8TCtziN1yQfP+cFTw9JRPcHgf95jw82ulWP2181rDNyXjHZU7
   ByJ8fSW8XNAUKNkJDTKtAZeP9LYLwKVd12E83UmjNjjRm5lDMpOXgcg2O
   K1b+qclsnqK2c8eMrZzOHKP6g0dpK4B6pcMNcxFxVR5agNt1Aqld4weLO
   D9L0VOI3GBEyj1f1VfrRrj8bGJ47befzJCeBV5XwAKIIdaHNDnsyaiZUY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="387676757"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="387676757"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="745937353"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="745937353"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 10:31:07 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        nvdimm@lists.linux.dev
Cc:     rafael.j.wysocki@intel.com, andriy.shevchenko@intel.com,
        lenb@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        Michal Wilczynski <michal.wilczynski@intel.com>
Subject: [PATCH v2 1/6] ACPI: AC: Remove unnecessary checks
Date:   Fri,  6 Oct 2023 20:30:50 +0300
Message-ID: <20231006173055.2938160-2-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006173055.2938160-1-michal.wilczynski@intel.com>
References: <20231006173055.2938160-1-michal.wilczynski@intel.com>
MIME-Version: 1.0
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

Remove unnecessary checks for NULL for variables that can't be NULL at
the point they're checked for it. Defensive programming is discouraged
in the kernel.

Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/ac.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
index aac3e561790c..83d45c681121 100644
--- a/drivers/acpi/ac.c
+++ b/drivers/acpi/ac.c
@@ -131,9 +131,6 @@ static void acpi_ac_notify(acpi_handle handle, u32 event, void *data)
 	struct acpi_device *device = data;
 	struct acpi_ac *ac = acpi_driver_data(device);
 
-	if (!ac)
-		return;
-
 	switch (event) {
 	default:
 		acpi_handle_debug(device->handle, "Unsupported event [0x%x]\n",
@@ -216,12 +213,8 @@ static const struct dmi_system_id ac_dmi_table[]  __initconst = {
 static int acpi_ac_add(struct acpi_device *device)
 {
 	struct power_supply_config psy_cfg = {};
-	int result = 0;
-	struct acpi_ac *ac = NULL;
-
-
-	if (!device)
-		return -EINVAL;
+	struct acpi_ac *ac;
+	int result;
 
 	ac = kzalloc(sizeof(struct acpi_ac), GFP_KERNEL);
 	if (!ac)
@@ -275,16 +268,9 @@ static int acpi_ac_add(struct acpi_device *device)
 #ifdef CONFIG_PM_SLEEP
 static int acpi_ac_resume(struct device *dev)
 {
-	struct acpi_ac *ac;
+	struct acpi_ac *ac = acpi_driver_data(to_acpi_device(dev));
 	unsigned int old_state;
 
-	if (!dev)
-		return -EINVAL;
-
-	ac = acpi_driver_data(to_acpi_device(dev));
-	if (!ac)
-		return -EINVAL;
-
 	old_state = ac->state;
 	if (acpi_ac_get_state(ac))
 		return 0;
@@ -299,12 +285,7 @@ static int acpi_ac_resume(struct device *dev)
 
 static void acpi_ac_remove(struct acpi_device *device)
 {
-	struct acpi_ac *ac = NULL;
-
-	if (!device || !acpi_driver_data(device))
-		return;
-
-	ac = acpi_driver_data(device);
+	struct acpi_ac *ac = acpi_driver_data(device);
 
 	acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
 				       acpi_ac_notify);
-- 
2.41.0

