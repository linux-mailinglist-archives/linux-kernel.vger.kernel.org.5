Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9837BC5F8
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 10:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbjJGIMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 04:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjJGIMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 04:12:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C3EA6;
        Sat,  7 Oct 2023 01:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696666356; x=1728202356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MthAMNSAvqVlqmjaZAPKyZLE+PvlZ9m2aggOFYe4Cq4=;
  b=aHp8ehL+BZhmfEF/iJc3rmxK9zwWCu3UGTAiLXlvOs1gbI8lCnZOM5zU
   vqfcZb4SJZ7nMYI2OZQhdCN629MakGM89lLhYY5T1BriBxe5Z25NgQzf9
   QPDGzw4/75ST5Tt+k6nZBZqrVOtAxT6SvUThtFhEMACWbuCR/kfssF7H+
   akWVD7t4/tVn5evyoKSp1G723JqUAXEoy3XNkG7rMwtOiVQUAc4Cjw9iU
   NRGIIudcmMKxC6YplYF9m4e5agxv8r28fOJKdOpA2AM0WTsCrxH8ZvFkk
   KKQPjfimB3zFfNtp3y8/u5FHYs7OAV5K6HhM6oZo2mrFF6iLFq2zr98wS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="381177737"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="381177737"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 01:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="729123789"
X-IronPort-AV: E=Sophos;i="6.03,205,1694761200"; 
   d="scan'208";a="729123789"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2023 01:12:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3D5CD456; Sat,  7 Oct 2023 11:12:32 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>
Subject: [PATCH v4 1/1] platform/x86: asus-wireless: Replace open coded acpi_match_device()
Date:   Sat,  7 Oct 2023 11:12:30 +0300
Message-Id: <20231007081230.3555681-1-andriy.shevchenko@linux.intel.com>
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

Replace open coded acpi_match_device() in asus_wireless_add().

Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

v4: used proper API, added tag (Hans)
v3: rewrote error path logic (Hans)
v2: fixed compilation error

 drivers/platform/x86/asus-wireless.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/asus-wireless.c b/drivers/platform/x86/asus-wireless.c
index abf01e00b799..41227bf95878 100644
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
+	id = acpi_match_acpi_device(device_ids, adev);
+	if (!id)
 		return 0;
 
+	data->hswc_params = (const struct hswc_params *)id->driver_data;
+
 	data->wq = create_singlethread_workqueue("asus_wireless_workqueue");
 	if (!data->wq)
 		return -ENOMEM;
-- 
2.40.0.1.gaa8946217a0b

