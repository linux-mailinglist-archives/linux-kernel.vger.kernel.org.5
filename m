Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF45C7B4D5D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235859AbjJBIlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 04:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjJBIk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 04:40:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214459F;
        Mon,  2 Oct 2023 01:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696236057; x=1727772057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/P37FcaXZjMMutq9n67JQiVyfnH8gDi/nEODIuFKqk=;
  b=A6a2fkp1viAm+TrKoOsC91ucyOHs/Sid7l/+ZNXkpOZ+1wUxMGlF/lyb
   Xp8ofuMPRlqaNEYEQV1Blnm0NODIZa/RdKlhEUy2pgZ7X1UM5yvYpIhqI
   p/FiHzCY1NIvQ4s44BnCdo+0p7GuE/4CvUr7GjUpNCVEMFID0J2tHm0tH
   YFhia5r59xDZe22tpckaVAwxPV75I0mU6dQHHmXWUh30KEqZibz8KZ2RG
   9LyHapS/gTSNl1qqhU3LHfcZm0LQYCOU12GFADEIahMtCUkjZN4NwF6bm
   jxgMHLSOrRGQ8gszqrwd8KvNF1rfzP2E5ywJaDcOEjq6bZXTp8x93CVwD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="379880220"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="379880220"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 01:40:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="997565754"
X-IronPort-AV: E=Sophos;i="6.03,193,1694761200"; 
   d="scan'208";a="997565754"
Received: from powerlab.fi.intel.com ([10.237.71.25])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 01:40:54 -0700
From:   Michal Wilczynski <michal.wilczynski@intel.com>
To:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v1] ACPI: scan: Add support for GPE block devices
Date:   Mon,  2 Oct 2023 11:40:45 +0300
Message-ID: <20231002084045.475843-1-michal.wilczynski@intel.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently there is no support for GPE block devices described in the
ACPI specification. However there is a need to implement it as new
platforms are coming that will make use of that feature.

Add new acpi_scan_handler, that will attach itself to devices with
"ACPI0006" _HID. Implement .attach() callback. Check for _CRS and _PRS
objects, as their presence is required in non-FADT GPE block device, per
ACPI specification. Extract address ranges/irq from _CRS/_PRS object. Call
acpi_install_gpe_block() from ACPICA to install the GPE block. Then call
acpi_update_all_gpes() to initialize newly installed GPE block.

Link: https://uefi.org/specs/ACPI/6.5/09_ACPI_Defined_Devices_and_Device_Specific_Objects.html#gpe-block-device
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
---
 drivers/acpi/scan.c | 111 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 7cae369ca33b..f00bfe63fbcf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2174,6 +2174,116 @@ static int acpi_scan_attach_handler(struct acpi_device *device)
 	return ret;
 }
 
+static const struct acpi_device_id gpe_block_ids[] = {
+	{"ACPI0006"},
+	{}
+};
+
+static int acpi_gpe_fill_address(struct acpi_generic_address *gpe_block_address,
+				 u8 type,
+				 int *register_count,
+				 struct resource_entry *rentry)
+{
+	if (gpe_block_address->address)
+		return -EINVAL;
+
+	gpe_block_address->address = rentry->res->start;
+	gpe_block_address->space_id = type;
+	*register_count = (rentry->res->end - rentry->res->start);
+	*register_count /= ACPI_GPE_REGISTER_WIDTH;
+
+	return 0;
+}
+
+static int acpi_gpe_block_attach(struct acpi_device *adev,
+				 const struct acpi_device_id *not_used)
+{
+	struct acpi_generic_address gpe_block_address = {};
+	struct list_head resource_list;
+	struct resource_entry *rentry;
+	int register_count;
+	acpi_status status;
+	u32 irq = 0;
+	int ret;
+
+	if (!acpi_has_method(adev->handle, METHOD_NAME__CRS) &&
+	    !acpi_has_method(adev->handle, METHOD_NAME__PRS))
+		/* It's not a block GPE if it doesn't contain _CRS or _PRS.
+		 * Specification says that ACPI0006 _HID can also refer to
+		 * FADT described GPE's. It's not an error, so it's reasonable
+		 * to return 0.
+		 */
+		return 0;
+
+	INIT_LIST_HEAD(&resource_list);
+	ret = acpi_dev_get_resources(adev, &resource_list, NULL, NULL);
+	if (ret)
+		return ret;
+
+	list_for_each_entry(rentry, &resource_list, node) {
+		switch (resource_type(rentry->res)) {
+		case IORESOURCE_IO:
+			ret = acpi_gpe_fill_address(&gpe_block_address,
+						    ACPI_ADR_SPACE_SYSTEM_IO,
+						    &register_count,
+						    rentry);
+			if (ret) {
+				acpi_handle_err(adev->handle,
+						"Multiple IO blocks in GPE block\n");
+				return ret;
+			}
+			break;
+		case IORESOURCE_MEM:
+			ret = acpi_gpe_fill_address(&gpe_block_address,
+						    ACPI_ADR_SPACE_SYSTEM_MEMORY,
+						    &register_count,
+						    rentry);
+			if (ret) {
+				acpi_handle_err(adev->handle,
+						"Multiple MEM blocks in GPE block\n");
+				return ret;
+			}
+			break;
+		case IORESOURCE_IRQ:
+			if (irq) {
+				acpi_handle_err(adev->handle,
+						"Multiple IRQ blocks in GPE block\n");
+				return -EINVAL;
+			}
+			irq = rentry->res->start;
+			break;
+		default:
+			break;
+		}
+	}
+
+	acpi_dev_free_resource_list(&resource_list);
+
+	/* GPE block needs to define one address range and one irq line */
+	if (!gpe_block_address.address || !irq)
+		return -ENODEV;
+
+	status = acpi_install_gpe_block(adev->handle,
+					&gpe_block_address,
+					register_count,
+					irq);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	status = acpi_update_all_gpes();
+	if (ACPI_FAILURE(status)) {
+		acpi_remove_gpe_block(adev->handle);
+		return -ENODEV;
+	}
+
+	return 1;
+}
+
+static struct acpi_scan_handler gpe_block_device_handler = {
+	.ids = gpe_block_ids,
+	.attach = acpi_gpe_block_attach,
+};
+
 static int acpi_bus_attach(struct acpi_device *device, void *first_pass)
 {
 	bool skip = !first_pass && device->flags.visited;
@@ -2623,6 +2733,7 @@ void __init acpi_scan_init(void)
 	acpi_init_lpit();
 
 	acpi_scan_add_handler(&generic_device_handler);
+	acpi_scan_add_handler(&gpe_block_device_handler);
 
 	/*
 	 * If there is STAO table, check whether it needs to ignore the UART
-- 
2.41.0

