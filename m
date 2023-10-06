Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C227BBBC5
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjJFPcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjJFPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:31:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EE49E;
        Fri,  6 Oct 2023 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696606318; x=1728142318;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6+Wehx1uF41hZpIjafvQpHKPc68H7L87dFNCBaLztcE=;
  b=I1Wp94G1x69nIf+d4Fd2+rKPBSDnDJXQP3TQRcNg1L5CePhq4krsBGPx
   xhmuVsWcKjWhcrUJA0QE+eKSf6xyZ9j7Agwftfrez11ghJ4d5bGR429M4
   fcMDTN0s3Ubg8XplpjzU0si0TtFxAgpXDfBGODjjajS4UbSScylqraOd7
   r+ah0ZGldOW0dw9UaY/2WRVMHgHGdSR3soJ60LYPYXHQzA8bxE4P+gxAg
   atU8eBI+25RLPZLt/XuOmKPd0kN4hUjWlIeVkh03s54czkzhXhbo3t5pm
   V4oEJ+7iR0oObS3bVFAQwYJtHSRC9/8THRFGyeRFVbGsYMzYNNrA7tJFZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="470038700"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="470038700"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:31:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="702087014"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="702087014"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 06 Oct 2023 08:31:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C891F430; Fri,  6 Oct 2023 18:31:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v2 1/1] platform/x86: xo15-ebook: Replace open coded acpi_match_device()
Date:   Fri,  6 Oct 2023 18:31:52 +0300
Message-Id: <20231006153152.3502912-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded acpi_match_device() in ebook_switch_add().

Note, while it is a bit longer it is more robust in case
more IDs will be added.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: fixed compilation error
 drivers/platform/x86/xo15-ebook.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/xo15-ebook.c b/drivers/platform/x86/xo15-ebook.c
index 391f7ea4431e..2ae8a58adcd0 100644
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
+	id = acpi_match_device(ebook_device_ids, device);
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

