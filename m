Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9FD7D0AD1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376539AbjJTIsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376515AbjJTIsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:48:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86ECD45;
        Fri, 20 Oct 2023 01:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791692; x=1729327692;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=0WNKWxhqnOM7fF435JX3yfg+v0y6tyX67g7zORiWNpU=;
  b=K1Rxu3No8QvnVNhWqN7dlrJGhSPWm4RGDd4KfZNlCk9v4+OGw4Tz92Lt
   G2ISJXJvrR7ZbaKZiSqdTZMp1c5meQ8He1py66vP3OxBW70VcE0KM5byR
   8ge7xQTWQGr6T9fPyBTa8IqoBNnZMBBJ4fM3X4XbCCBT3XcTAkIr/j5W0
   WM9j39xLdcqZvC8eJKHKKujJVbd3AXK2B5Jl2BhxAVop3FeyE9UxSdxUi
   DzLOcn15954Y4qcgPQfi5YPLKMIZeGBV8mBtv2tl83TRD8Bp50uvAWHQB
   fiWuKdAtwoa49gmByXHjXl4m+4Oo41naVAHEOzxeI9UzZEGeuqd1xd4rq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683501"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683501"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832161"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832161"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:47:47 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 1/8] ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
Date:   Fri, 20 Oct 2023 14:17:25 +0530
Message-Id: <20231020084732.17130-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231020084732.17130-1-raag.jadav@intel.com>
References: <20231020084732.17130-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce acpi_dev_uid_match() helper that matches the device with
supplied _UID string.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/utils.c    | 40 +++++++++++++++++++++++++++++++++-------
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 2ea14648a661..664b9890b625 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -768,28 +768,54 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
+/**
+ * acpi_dev_uid_match - Match device by supplied UID
+ * @adev: ACPI device to match.
+ * @uid2: Unique ID of the device, pass NULL to not check _UID.
+ *
+ * Matches UID in @adev with given @uid2. Absence of @uid2 will be treated as
+ * a match. If user wants to validate @uid2, it should be done before calling
+ * this function. This behaviour is as needed by most of its current users.
+ *
+ * Returns:
+ *  - %true if matches or @uid2 is NULL.
+ *  - %false otherwise.
+ */
+bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	const char *uid1 = acpi_device_uid(adev);
+
+	if (!uid2)
+		return true;
+
+	return uid1 && !strcmp(uid1, uid2);
+}
+EXPORT_SYMBOL_GPL(acpi_dev_uid_match);
+
 /**
  * acpi_dev_hid_uid_match - Match device by supplied HID and UID
  * @adev: ACPI device to match.
  * @hid2: Hardware ID of the device.
  * @uid2: Unique ID of the device, pass NULL to not check _UID.
  *
- * Matches HID and UID in @adev with given @hid2 and @uid2.
- * Returns true if matches.
+ * Matches HID and UID in @adev with given @hid2 and @uid2. Absence of @uid2
+ * will be treated as a match. If user wants to validate @uid2, it should be
+ * done before calling this function. This behaviour is as needed by most of
+ * its current users.
+ *
+ * Returns:
+ *  - %true if matches or @uid2 is NULL.
+ *  - %false otherwise.
  */
 bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 			    const char *hid2, const char *uid2)
 {
 	const char *hid1 = acpi_device_hid(adev);
-	const char *uid1 = acpi_device_uid(adev);
 
 	if (strcmp(hid1, hid2))
 		return false;
 
-	if (!uid2)
-		return true;
-
-	return uid1 && !strcmp(uid1, uid2);
+	return acpi_dev_uid_match(adev, uid2);
 }
 EXPORT_SYMBOL(acpi_dev_hid_uid_match);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 254685085c82..d1fe6446ffe0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -760,6 +760,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
 		adev->power.states[ACPI_STATE_D3_HOT].flags.explicit_set);
 }
 
+bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2);
 bool acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2);
 int acpi_dev_uid_to_integer(struct acpi_device *adev, u64 *integer);
 
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index afd94c9b8b8a..db3a33e19c97 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -787,6 +787,11 @@ static inline bool acpi_dev_present(const char *hid, const char *uid, s64 hrv)
 
 struct acpi_device;
 
+static inline bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	return false;
+}
+
 static inline bool
 acpi_dev_hid_uid_match(struct acpi_device *adev, const char *hid2, const char *uid2)
 {
-- 
2.17.1

