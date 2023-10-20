Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096B67D0ADA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376556AbjJTIsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376564AbjJTIsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:48:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E48D64;
        Fri, 20 Oct 2023 01:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697791701; x=1729327701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=VTxu+ilZT0ByPxEPyTKRaS8c0W/p+nQekrV/1V+4jQc=;
  b=OJJrz6hApE3sw6lDZqb8SB4GEC11s7v/9R+obMP2aEzczlg9uNzAIPSH
   H3pMB+a0CrRfIQL1lA4DqROiojZnyGBB4bZ33HYgdW/JKK3/scW0GJthy
   6KJ/qeyPyziR8NZ4pULcMwT9E0ila2iHvm1NHEEH9wsEXJ6HgP3B6vjMv
   5Tu7T20Z+XagQo7xp4D7PtmfPpvry9lCVmkWNKjkr5y1PRkyj2iFinB5W
   YKzs4HEV961WbhAI2nq2fMFsjNDMDQHI82ZQ9drhNAtWtUObSWzjEPSO/
   xnCiUi7LWmkJXe+EjeEHfK6QgjaOW0ryJ4xByqY+9SYtuk7+uCMmtJf12
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="450683647"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="450683647"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 01:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="873832198"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="873832198"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 20 Oct 2023 01:48:16 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     rafael@kernel.org, len.brown@intel.com, robert.moore@intel.com,
        mika.westerberg@linux.intel.com, andriy.shevchenko@linux.intel.com,
        mark.rutland@arm.com, will@kernel.org, linux@roeck-us.net
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hwmon@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1 7/8] hwmon: nct6775: use acpi_dev_hid_uid_match() for matching _HID and _UID
Date:   Fri, 20 Oct 2023 14:17:31 +0530
Message-Id: <20231020084732.17130-8-raag.jadav@intel.com>
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

Convert manual _UID references to use standard ACPI helpers.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
---
 drivers/hwmon/nct6775-platform.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 81bf03dad6bb..0adeeab7ee03 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1465,10 +1465,8 @@ static const char * const asus_msi_boards[] = {
 static int nct6775_asuswmi_device_match(struct device *dev, void *data)
 {
 	struct acpi_device *adev = to_acpi_device(dev);
-	const char *uid = acpi_device_uid(adev);
-	const char *hid = acpi_device_hid(adev);
 
-	if (hid && !strcmp(hid, ASUSWMI_DEVICE_HID) && uid && !strcmp(uid, data)) {
+	if (acpi_dev_hid_uid_match(adev, ASUSWMI_DEVICE_HID, data)) {
 		asus_acpi_dev = adev;
 		return 1;
 	}
-- 
2.17.1

