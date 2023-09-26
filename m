Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20B47AF3D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 21:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235682AbjIZTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 15:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjIZTIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 15:08:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01594126;
        Tue, 26 Sep 2023 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695755305; x=1727291305;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+4CIGQkiHpdKp7raUQTHIHbkLXKoETSn/0+bWyXrAyU=;
  b=mjcM7UlKJV027aOUyzh0lz0PE1kXLKemuJGS3kgTrGhxDQ4BudCEIP1x
   24j2/7g2idonF/v0v5lJSqKOAZVRTVKYBjWB5ZqlX6PuYsR9dUGhIKou3
   eGqHGv/Mbta88X2HIRaNP86RMuikWPJKqGzN9GRicY04f4/xzMvFMrCJa
   58Hfr0SY+hcVQQ67zxGLe0gYhGLBzde1T4j7yyHAjEnqK1hZcIJZF5kzC
   Sws+IFaFYArzzx3hnwy4zWLzmf0ArvB+sNTMnd4QCpAe3uxU49mxVot2C
   ASpPZai5CovFHNYrjgMegFVUaBPKuBA3zkFhtlDPdIAK9wPVJ3MxjN7Ic
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="448142580"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="448142580"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 12:08:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819142506"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="819142506"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 26 Sep 2023 12:08:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D97F211D; Tue, 26 Sep 2023 22:08:21 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v1 1/1] pinctrl: denverton: Enable platform device in the absence of ACPI enumeration
Date:   Tue, 26 Sep 2023 22:08:18 +0300
Message-Id: <20230926190818.931951-1-andriy.shevchenko@linux.intel.com>
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

This is to cater the need for non-ACPI system whereby
a platform device has to be created in order to bind
with the Denverton pinctrl platform driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-denverton.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pinctrl/intel/pinctrl-denverton.c b/drivers/pinctrl/intel/pinctrl-denverton.c
index 0c4694cfa594..a1a7242e0451 100644
--- a/drivers/pinctrl/intel/pinctrl-denverton.c
+++ b/drivers/pinctrl/intel/pinctrl-denverton.c
@@ -257,6 +257,11 @@ static const struct acpi_device_id dnv_pinctrl_acpi_match[] = {
 };
 MODULE_DEVICE_TABLE(acpi, dnv_pinctrl_acpi_match);
 
+static const struct platform_device_id dnv_pinctrl_platform_ids[] = {
+	{ "denverton-pinctrl", (kernel_ulong_t)&dnv_soc_data },
+	{ }
+};
+
 static struct platform_driver dnv_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_hid,
 	.driver = {
@@ -264,6 +269,7 @@ static struct platform_driver dnv_pinctrl_driver = {
 		.acpi_match_table = dnv_pinctrl_acpi_match,
 		.pm = &dnv_pinctrl_pm_ops,
 	},
+	.id_table = dnv_pinctrl_platform_ids,
 };
 
 static int __init dnv_pinctrl_init(void)
@@ -281,4 +287,5 @@ module_exit(dnv_pinctrl_exit);
 MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
 MODULE_DESCRIPTION("Intel Denverton SoC pinctrl/GPIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_ALIAS("platform:denverton-pinctrl");
 MODULE_IMPORT_NS(PINCTRL_INTEL);
-- 
2.40.0.1.gaa8946217a0b

