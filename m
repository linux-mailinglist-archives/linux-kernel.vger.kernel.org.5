Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B1C7BC5F3
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234135AbjJGIJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJGIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:09:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD85EB9;
        Sat,  7 Oct 2023 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696666173; x=1728202173;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ucCWAV9tBh035gehFcwDIaV0+OTgzp7lmmLZmyJxONk=;
  b=cAOk1j6i/89WZ10TgFW98MP+8zbK5oy078WWJPTyplDMEiGfvei2JlO9
   Gu3hQOeUd4KbiHHmWbdTVPD7TGtHfsjNpd2RhYVc6a+p4F6m+tEPjpQHU
   YYLJWarvrApF0YDeyrhcqE1YBBJQOraDdLel7yPj6Zh8St3VByuauIrxI
   3xgfMHToQ64GHNcbpvyjwEPSAPawzT0JZ3+G2xTEpEH9U5wbdczCGklc/
   hOXWxOibgYAzGq846OSETBEwqw8dY+Y/ZAZBmVLmlKzgVNJwyN1E3padK
   JdcGuI8gLC2c/VI/LPuXWSipnlxjFJBF1DShJqEeVk7hrPvY73bTRgZw1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="381177637"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="381177637"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 01:09:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="818287316"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="818287316"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2023 01:09:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 06B5D456; Sat,  7 Oct 2023 11:09:29 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v3 1/1] platform/x86: xo15-ebook: Replace open coded acpi_match_device()
Date:   Sat,  7 Oct 2023 11:09:28 +0300
Message-Id: <20231007080928.3555494-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded acpi_match_device() in ebook_switch_add().

Note, while it is a bit longer it is more robust in case
more IDs will be added.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v3: used proper API, added tag (Hans)
v2: fixed compilation error

 drivers/platform/x86/xo15-ebook.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 391f7ea4431e..df2bf1c58523 100644
--- a/drivers/platform/x86/xo15-ebook.c
+++ b/drivers/platform/x86/xo15-ebook.c
@@ -81,9 +81,9 @@ static SIMPLE_DEV_PM_OPS(ebook_switch_pm, NULL, ebook_switch_resume);
 
 static int ebook_switch_add(struct acpi_device *device)
 {
+	const struct acpi_device_id *id;
 	struct ebook_switch *button;
 	struct input_dev *input;
-	const char *hid = acpi_device_hid(device);
 	char *name, *class;
 	int error;
 
@@ -102,8 +102,9 @@ static int ebook_switch_add(struct acpi_device *device)
 	name = acpi_device_name(device);
 	class = acpi_device_class(device);
 
-	if (strcmp(hid, XO15_EBOOK_HID)) {
-		pr_err("Unsupported hid [%s]\n", hid);
+	id = acpi_match_acpi_device(ebook_device_ids, device);
+	if (!id) {
+		dev_err(&device->dev, "Unsupported hid\n");
 		error = -ENODEV;
 		goto err_free_input;
 	}
@@ -111,7 +112,7 @@ static int ebook_switch_add(struct acpi_device *device)
 	strcpy(name, XO15_EBOOK_DEVICE_NAME);
 	sprintf(class, "%s/%s", XO15_EBOOK_CLASS, XO15_EBOOK_SUBCLASS);
 
-	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", hid);
+	snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
 
 	input->name = name;
 	input->phys = button->phys;
-- 
2.40.0.1.gaa8946217a0b

