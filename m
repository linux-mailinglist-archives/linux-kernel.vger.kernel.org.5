Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51B8783AED
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 09:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjHVHbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 03:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbjHVHba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 03:31:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B956D130;
        Tue, 22 Aug 2023 00:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692689488; x=1724225488;
  h=from:to:cc:subject:date:message-id;
  bh=3BYZu9n4dVZV2dz0cvespv/7zchBpnF7YiYEuX3chcA=;
  b=mim1Eo/FOLiJRb3qfDq/8Ggz6pVpJyOEpw3OaIduwBhOt1n64Fou+pLo
   n253HeZk7WlXFzNH4OKgjf2e43ocHqops7BMdZq4uJPD1AFzWtKDdVTDB
   Sl994fE1/yIJw/xtJSPd+FklZan9jQ20IH83aiPh3+Qjr/rrby5jKbQKU
   DOsZ6EVYu8ydaraOOdrYNihC8VXxGfWEogbzbyV5pVMzApc7faLFYmgq2
   xFS8Fp4qU8fnel+B4B5r9jd2lfjkJ2MkWt3ZHn3Yp/u+mSclVaaxc8zs+
   1v9p+IGccSyNq2ZOtySBqR4pMavV3+l+UJXDpDvHrmgW9fXUHw+jfRsgt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="437722371"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="437722371"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 00:31:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="850506464"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="850506464"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmsmga002.fm.intel.com with ESMTP; 22 Aug 2023 00:31:25 -0700
From:   Raag Jadav <raag.jadav@intel.com>
To:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        andriy.shevchenko@linux.intel.com
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com,
        Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v1] pinctrl: intel: consolidate ACPI dependency
Date:   Tue, 22 Aug 2023 13:00:56 +0530
Message-Id: <20230822073056.10208-1-raag.jadav@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since all the Intel specific platform drivers depend on ACPI, we can
consolidate their config dependency.

Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pinctrl/intel/Kconfig | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/pinctrl/intel/Kconfig b/drivers/pinctrl/intel/Kconfig
index f42a83e29b8b..d66f4f6932d8 100644
--- a/drivers/pinctrl/intel/Kconfig
+++ b/drivers/pinctrl/intel/Kconfig
@@ -1,11 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 # Intel pin control drivers
 menu "Intel pinctrl drivers"
-	depends on X86 || COMPILE_TEST
+	depends on ACPI && (X86 || COMPILE_TEST)
 
 config PINCTRL_BAYTRAIL
 	bool "Intel Baytrail GPIO pin control"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  driver for memory mapped GPIO functionality on Intel Baytrail
@@ -17,7 +16,6 @@ config PINCTRL_BAYTRAIL
 
 config PINCTRL_CHERRYVIEW
 	tristate "Intel Cherryview/Braswell pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  Cherryview/Braswell pinctrl driver provides an interface that
@@ -25,7 +23,6 @@ config PINCTRL_CHERRYVIEW
 
 config PINCTRL_LYNXPOINT
 	tristate "Intel Lynxpoint pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  Lynxpoint is the PCH of Intel Haswell. This pinctrl driver
@@ -42,7 +39,6 @@ config PINCTRL_INTEL
 
 config PINCTRL_ALDERLAKE
 	tristate "Intel Alder Lake pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -50,7 +46,6 @@ config PINCTRL_ALDERLAKE
 
 config PINCTRL_BROXTON
 	tristate "Intel Broxton pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  Broxton pinctrl driver provides an interface that allows
@@ -58,7 +53,6 @@ config PINCTRL_BROXTON
 
 config PINCTRL_CANNONLAKE
 	tristate "Intel Cannon Lake PCH pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -66,7 +60,6 @@ config PINCTRL_CANNONLAKE
 
 config PINCTRL_CEDARFORK
 	tristate "Intel Cedar Fork pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -74,7 +67,6 @@ config PINCTRL_CEDARFORK
 
 config PINCTRL_DENVERTON
 	tristate "Intel Denverton pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -82,7 +74,6 @@ config PINCTRL_DENVERTON
 
 config PINCTRL_ELKHARTLAKE
 	tristate "Intel Elkhart Lake SoC pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -90,7 +81,6 @@ config PINCTRL_ELKHARTLAKE
 
 config PINCTRL_EMMITSBURG
 	tristate "Intel Emmitsburg pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -98,7 +88,6 @@ config PINCTRL_EMMITSBURG
 
 config PINCTRL_GEMINILAKE
 	tristate "Intel Gemini Lake SoC pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -106,7 +95,6 @@ config PINCTRL_GEMINILAKE
 
 config PINCTRL_ICELAKE
 	tristate "Intel Ice Lake PCH pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -114,7 +102,6 @@ config PINCTRL_ICELAKE
 
 config PINCTRL_JASPERLAKE
 	tristate "Intel Jasper Lake PCH pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -122,7 +109,6 @@ config PINCTRL_JASPERLAKE
 
 config PINCTRL_LAKEFIELD
 	tristate "Intel Lakefield SoC pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -130,7 +116,6 @@ config PINCTRL_LAKEFIELD
 
 config PINCTRL_LEWISBURG
 	tristate "Intel Lewisburg pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -138,7 +123,6 @@ config PINCTRL_LEWISBURG
 
 config PINCTRL_METEORLAKE
 	tristate "Intel Meteor Lake pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring
@@ -146,7 +130,6 @@ config PINCTRL_METEORLAKE
 
 config PINCTRL_SUNRISEPOINT
 	tristate "Intel Sunrisepoint pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  Sunrisepoint is the PCH of Intel Skylake. This pinctrl driver
@@ -155,7 +138,6 @@ config PINCTRL_SUNRISEPOINT
 
 config PINCTRL_TIGERLAKE
 	tristate "Intel Tiger Lake pinctrl and GPIO driver"
-	depends on ACPI
 	select PINCTRL_INTEL
 	help
 	  This pinctrl driver provides an interface that allows configuring

base-commit: 83f7586f3b365330765a24eb40f99a1c1a43d38e
-- 
2.17.1

