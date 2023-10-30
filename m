Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC77F7DB98C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 13:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjJ3MHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 08:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233167AbjJ3MHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 08:07:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A396D6;
        Mon, 30 Oct 2023 05:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698667663; x=1730203663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+BEoNOVpWEZhamBaNCb3lmH2sOnOe89VQ+7qyzH87zo=;
  b=NHtc9UoaJ3bW2c0rNVx4OGXO2jBhSPYj42l1qbZI83rQavpE68UCzGma
   gKjbJB3VWmcqRMYyInq2AJ3GQVnQexYMSmuWXPmXrWBf9m+y6C2V/okf6
   ksvW2uZvpQVskpnYNU6+UFtcm5EMHIM/C5KF8YZrqH8/IjGKWNa/3OBVT
   m8kipe3s1TMc5IJP3oYYOvposYaWNZTbzxXhAm9hOAOeddOxXjcBWzGac
   Jx8Th48KnEhyiu9EU6Mof0g1VleTeBsz+bn0ha3EYAmoyyVPmrTqL0ZIC
   tQv6eXH8EhSUvQfpJ4F/qtnG0tYy7B6Yx2Shwos6hgQcbBGdp29wqOtcB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="373107359"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="373107359"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2023 05:07:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10878"; a="753771406"
X-IronPort-AV: E=Sophos;i="6.03,263,1694761200"; 
   d="scan'208";a="753771406"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 Oct 2023 05:07:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5254545B; Mon, 30 Oct 2023 14:07:36 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Subject: [PATCH v3 10/17] pinctrl: icelake: Switch to use Intel pin control PM ops
Date:   Mon, 30 Oct 2023 14:07:27 +0200
Message-Id: <20231030120734.2831419-11-andriy.shevchenko@linux.intel.com>
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
 drivers/pinctrl/intel/pinctrl-icelake.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/intel/pinctrl-icelake.c b/drivers/pinctrl/intel/pinctrl-icelake.c
index 300e1538c8d0..fe3042de891a 100644
--- a/drivers/pinctrl/intel/pinctrl-icelake.c
+++ b/drivers/pinctrl/intel/pinctrl-icelake.c
@@ -10,6 +10,7 @@
 #include <linux/acpi.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <linux/pinctrl/pinctrl.h>
 
@@ -668,8 +669,6 @@ static const struct intel_pinctrl_soc_data icln_soc_data = {
 	.ncommunities = ARRAY_SIZE(icln_communities),
 };
 
-static INTEL_PINCTRL_PM_OPS(icl_pinctrl_pm_ops);
-
 static const struct acpi_device_id icl_pinctrl_acpi_match[] = {
 	{ "INT3455", (kernel_ulong_t)&icllp_soc_data },
 	{ "INT34C3", (kernel_ulong_t)&icln_soc_data },
@@ -682,7 +681,7 @@ static struct platform_driver icl_pinctrl_driver = {
 	.driver = {
 		.name = "icelake-pinctrl",
 		.acpi_match_table = icl_pinctrl_acpi_match,
-		.pm = &icl_pinctrl_pm_ops,
+		.pm = pm_sleep_ptr(&intel_pinctrl_pm_ops),
 	},
 };
 module_platform_driver(icl_pinctrl_driver);
-- 
2.40.0.1.gaa8946217a0b

