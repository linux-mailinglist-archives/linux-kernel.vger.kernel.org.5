Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 798DB7DB983
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjJ3MHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F92D6;
        Mon, 30 Oct 2023 05:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667660; x=1730203660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Av6uPxTI7FRENYuCogXP/ie05oTJeYGJQFWmKLyvqx0=;
  b=iIp6wiI5+04aSmD+UDuo+uZrFWWDBfeWURK/cFUsVqoA2BCbzN9eF3jN
   pO4FuPPYR1cGrZhL6R0dQBXhy0699eh3ZcZgVbZXkxVjTTFOf2RkB5tNQ
   qGKlSfY7F7oqPNOudRru8B4FSZsOBFFvys4RdUPiX+zUSqUEacuzeKYzE
   WmMa3CkGuE0rBXAz6GLqjyw7I8PZwiWEBQkYVzUZjjP22A9hWHaVVU61w
   Z5wlS6e9GJW7DIkXhVWoE3anUE7CsYujYlcYr0Fj9Njp2mzT7oU1tiCsW
   q6kkcGcyCBdTAlpjSuq/kJW07FuXi9F50DW99FJPq8dHVNyviL5xYEbVl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107317"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107317"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771397"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771397"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01B52331; Mon, 30 Oct 2023 14:07:35 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 03/17] pinctrl: broxton: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:20 +0200
Message-Id: <20231030120734.2831419-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
References: <20231030120734.2831419-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main driver conditionally exports the PM ops structure.
Switch this driver to use it instead of customly wrapped one.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pinctrl/intel/pinctrl-broxton.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-broxton.c b/drivers/pinctrl/intel/pinctrl-broxton.c
index 3118c7c8842f..d99541676630 100644
--- a/drivers/pinctrl/intel/pinctrl-broxton.c
+++ b/drivers/pinctrl/intel/pinctrl-broxton.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -1000,14 +1001,12 @@ static const struct platform_device_id bxt_pinctrl_platform_ids[] = {
 };
 MODULE_DEVICE_TABLE(platform, bxt_pinctrl_platform_ids);
 
-static INTEL_PINCTRL_PM_OPS(bxt_pinctrl_pm_ops);
-
 static struct platform_driver bxt_pinctrl_driver = {
 	.probe = intel_pinctrl_probe_by_uid,
 	.driver = {
 		.name = "broxton-pinctrl",
 		.acpi_match_table = bxt_pinctrl_acpi_match,
-		.pm = &bxt_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 	.id_table = bxt_pinctrl_platform_ids,
 };
-- 
2.40.0.1.gaa8946217a0b

