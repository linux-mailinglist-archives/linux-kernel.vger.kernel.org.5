Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411197BBC2D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjJFPyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232502AbjJFPyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:54:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08511A6;
        Fri,  6 Oct 2023 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696607639; x=1728143639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=T5padUABpr+rZPmgSty+LxTkQr1WULnszt8+VvtZGdQ=;
  b=ZhMxeCjgRkw33Vpnt3ZhoSafHIGidsOy8mZuqimVPN5StDdZ3gbdTVRN
   pQsbajBvQAiCpfw7THLGko33sq2kQ7p7r8+HOmsWTHXAr8znCLSg3S5GT
   irn2q+qcU740GUuMucoCBZ5nRHRFYDzYaWw9bsypmNSateyclYLBrikoc
   5Mqettckw70WPbSN3hsdBoXIrKaArlcosq9wIy8TsC5JVUqjLZlxOce1r
   jtDpjzpE+EfVT9N9giN2zBDB+ZzZrva6nZQ5aXYrwXx1ErUzRr5nq4Uxx
   thT3krsj3yRTqoanZFfeWqi2FY3dYks4tv0v1Y0BzjewtWOcoynh1yVi9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386602078"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386602078"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="875980608"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="875980608"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 06 Oct 2023 08:53:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D1946430; Fri,  6 Oct 2023 18:53:53 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v3 1/1] platform/x86: asus-wireless: Replace open coded acpi_match_device()
Date:   Fri,  6 Oct 2023 18:53:51 +0300
Message-Id: <20231006155351.3503665-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
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

Replace open coded acpi_match_device() in asus_wireless_add().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v3: rewrote error path logic (Hans)
v2: fixed compilation error
 drivers/platform/x86/asus-wireless.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index abf01e00b799..1a571efa02eb 100644
--- a/drivers/platform/x86/asus-wireless.c
+++ b/drivers/platform/x86/asus-wireless.c
@@ -148,16 +148,12 @@ static int asus_wireless_add(struct acpi_device *adev)
 	if (err)
 		return err;
 
-	for (id = device_ids; id->id[0]; id++) {
-		if (!strcmp((char *) id->id, acpi_device_hid(adev))) {
-			data->hswc_params =
-				(const struct hswc_params *)id->driver_data;
-			break;
-		}
-	}
-	if (!data->hswc_params)
+	id = acpi_match_device(device_ids, adev);
+	if (!id)
 		return 0;
 
+	data->hswc_params = (const struct hswc_params *)id->driver_data;
+
 	data->wq = create_singlethread_workqueue("asus_wireless_workqueue");
 	if (!data->wq)
 		return -ENOMEM;
-- 
2.40.0.1.gaa8946217a0b

