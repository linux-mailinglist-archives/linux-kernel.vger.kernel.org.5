Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CF47D4750
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 08:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232625AbjJXGUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 02:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjJXGUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 02:20:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC24DD;
        Mon, 23 Oct 2023 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698128442; x=1729664442;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Kqxv9LhJ7k/94shFEad9R6LAGCDnjlnqdVEYRK8V/Ro=;
  b=DyHv4prx10Gih+J7BT8iuKyU6E2AOVdfNksaMjFwy98m+IBN3ZoCbF61
   T95kLaV6RFoBhhF6ZRx+qISDald57B7Ubl9BkP/asUh8OZRLYD7SMClVY
   LIHHFmLAWiJDbmkwj8/b6Mdj5RKAW4JFuvw/mnvxkKXtHpdK5tg8WHXkL
   MKGVuRG+/wQjMeDzZxWUj/y4oQnr+Eh5ie4Rsgjbtpy/3D9mJXuQ6b3oj
   ip+9DQdLm1FeC7z4nQXZXN7Igp5fpcJM97yGNKdlmZwnOeToOdz694+u8
   jRIQ9TpAaEW5hn8IDQ73cVlrbdxeJDunewDjpiSEbdekqeL4TXCv4MbtV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386806560"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="386806560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 23:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="751891316"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="751891316"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by orsmga007.jf.intel.com with ESMTP; 23 Oct 2023 23:20:37 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net,
        Jonathan.Cameron@Huawei.com
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 1/6] ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
Date:   Tue, 24 Oct 2023 11:50:13 +0530
Message-Id: <20231024062018.23839-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231024062018.23839-1-raag.jadav@intel.com>
References: <20231024062018.23839-1-raag.jadav@intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce acpi_dev_uid_match() helper that matches the device with
supplied _UID string.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/acpi/utils.c    | 31 +++++++++++++++++++++++++++----
 include/acpi/acpi_bus.h |  1 +
 include/linux/acpi.h    |  5 +++++
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/utils.c b/drivers/acpi/utils.c
index 79915d4a0031..be21b77059af 100644
--- a/drivers/acpi/utils.c
+++ b/drivers/acpi/utils.c
@@ -824,20 +824,43 @@ bool acpi_check_dsm(acpi_handle handle, const guid_t *guid, u64 rev, u64 funcs)
 }
 EXPORT_SYMBOL(acpi_check_dsm);
 
+/**
+ * acpi_dev_uid_match - Match device by supplied UID
+ * @adev: ACPI device to match.
+ * @uid2: Unique ID of the device.
+ *
+ * Matches UID in @adev with given @uid2.
+ *
+ * Returns:
+ *  - %true if matches.
+ *  - %false otherwise.
+ */
+bool acpi_dev_uid_match(struct acpi_device *adev, const char *uid2)
+{
+	const char *uid1 = acpi_device_uid(adev);
+
+	return uid1 && uid2 && !strcmp(uid1, uid2);
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
+ * done before calling this function.
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
@@ -845,7 +868,7 @@ bool acpi_dev_hid_uid_match(struct acpi_device *adev,
 	if (!uid2)
 		return true;
 
-	return uid1 && !strcmp(uid1, uid2);
+	return acpi_dev_uid_match(adev, uid2);
 }
 EXPORT_SYMBOL(acpi_dev_hid_uid_match);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 756b3f3c2c45..afeed6e72049 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -763,6 +763,7 @@ static inline bool acpi_device_can_poweroff(struct acpi_device *adev)
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

