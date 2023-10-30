Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBC17DB99E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjJ3MIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjJ3MHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCD8E9;
        Mon, 30 Oct 2023 05:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667666; x=1730203666;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+S7wel8AALKq2+6uysyF1Wgw77L8D37D7NPLQyJaAcc=;
  b=aCSMskHaqkvN+rJyUWJPxWboIAKh2LtTmfNxshWLZsZB8Tce7wKzEKll
   L8pJ38mCFPkU/rluxAwPXNI86+dO52zGNsSpBVRvwWTNDRy3uAN9rXnx4
   PqIK9D7u/TmGeKiB1EcoZmA3anash4Uch8MCYKM/wEu5P+y95Tf+l1Zmp
   ccn7uh2HbTgsYJaYS/bdVUSnDnZmlhqEy0jHotqhjKZU5JnUHLrOY0t6T
   U6ON/xnMb8sSZZNpsH98+OsrM3G6P11mllnXoH7CDKn+r6xGiTSYjuA/O
   UHC9qF4MrgDpZvyN3+ohvagqqhauNOFd8Ob6IVE79L+9u1Kx8n1piLMUk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="6691313"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="6691313"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="826036534"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="826036534"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 30 Oct 2023 05:07:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6E61249C; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 13/17] pinctrl: lewisburg: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:30 +0200
Message-Id: <20231030120734.2831419-14-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-lewisburg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-lewisburg.c b/drivers/pinctrl/intel/pinctrl-lewisburg.c
index aa725a5d62b9..a304d30ea9ed 100644
--- a/drivers/pinctrl/intel/pinctrl-lewisburg.c
+++ b/drivers/pinctrl/intel/pinctrl-lewisburg.c
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -301,8 +302,6 @@ static const struct intel_pinctrl_soc_data lbg_soc_data = {
 	.ncommunities = ARRAY_SIZE(lbg_communities),
 };
 
-static INTEL_PINCTRL_PM_OPS(lbg_pinctrl_pm_ops);
-
 static const struct acpi_device_id lbg_pinctrl_acpi_match[] = {
 	{ "INT3536", (kernel_ulong_t)&lbg_soc_data },
 	{ }
@@ -314,7 +313,7 @@ static struct platform_driver lbg_pinctrl_driver = {
 	.driver = {
 		.name = "lewisburg-pinctrl",
 		.acpi_match_table = lbg_pinctrl_acpi_match,
-		.pm = &lbg_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(lbg_pinctrl_driver);
-- 
2.40.0.1.gaa8946217a0b

