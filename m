Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E937BFE25
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjJJNmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbjJJNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:40:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696AC10D1;
        Tue, 10 Oct 2023 06:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945184; x=1728481184;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bweTMAw7Mh9T1bx7i565yAzoKLSObi9KIivLe8urTtA=;
  b=P+lyTVQgJ6n4xBnqupgrCp7tbHoHt9I31I6kL2v+7OufKh4gqcTWXAnm
   wXxetYz7iiA4ujkH58bF/KQi7vTDd4AXZXHk6a8Rgyh2rhIiShswHgOOR
   whU9mEDD2jgWO9HAXQd18zHr6pCGljcX9QRVlmijWCTLOtSyG6w0MfH52
   lwiCfT4yxXpLG5g1HOrxjYPezNq9nJMvtCPxnLO5PgIluvuqWwjwf3sTe
   dWmOeMNiqtv5ucfIbJCwc2FIPeZBWaj0OR4ycO5qn1tY0H5/p0vBheHyc
   I//SA+phSIWswcGmDAbLhcPEKMRGHkLR9RneaPNHpAmyW9uRkLoBzxm7Z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="415410035"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="415410035"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:39:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="1000701667"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1000701667"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2023 06:39:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B3ED735A; Tue, 10 Oct 2023 16:39:40 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v4 1/1] platform/x86: xo15-ebook: Replace open coded acpi_match_acpi_device()
Date:   Tue, 10 Oct 2023 16:39:36 +0300
Message-Id: <20231010133936.3891996-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded acpi_match_acpi_device() in ebook_switch_add().

Note, while it is a bit longer it is more robust in case
more IDs will be added.

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v4: updated subject (Ilpo)
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

