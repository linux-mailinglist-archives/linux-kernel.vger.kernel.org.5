Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8427E833C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346635AbjKJTvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346681AbjKJTuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:50:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB153515EF;
        Fri, 10 Nov 2023 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699641041; x=1731177041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=X/xNhyHvFMkgPNj7any9KS/bIKEyL+Njqu+OGpvTT3E=;
  b=fwXUbv4wLzxoJFpzAPraDOiPXR90UFazMcpvzrb4AD+6j5o+AoGsMPp1
   REeKImJGkAEhzow43veh7yhova+BK/XUM1AtoMJqQmjPKBAb1uggdtfup
   BP8IQ1WvUxWHHZdVzm5xQ3VabPljG1XsJSVGcEqZgBq48Zzsps2xExAn5
   IBuwTNrXrVDqzg4JnIxNi67qPoGg0DrA/O/X4O/BIf1h4Xl4p8KIqnc5P
   NQiz4hXYGUH+xC+NVeanb5t9tY34iNgy1OrblVZn4IvKkw5jqXn9FeoMs
   +/LG4cetKDXx0G0FkBnCsuleTT+dqeZ3DphTEXy5AIYZl5KOM8tTHv2AX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="380606851"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="380606851"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 10:29:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10890"; a="792912167"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="792912167"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 10 Nov 2023 10:29:40 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3F97F8D7; Fri, 10 Nov 2023 20:23:08 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jan Dabros <jsd@semihalf.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 20/25] i2c: designware: Uninline i2c_dw_probe()
Date:   Fri, 10 Nov 2023 20:11:40 +0200
Message-ID: <20231110182304.3894319-21-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
References: <20231110182304.3894319-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since i2c_dw_probe() is going to be extended, uninline it to reduce
the noise in the common header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/i2c/busses/i2c-designware-common.c | 14 ++++++++++++++
 drivers/i2c/busses/i2c-designware-core.h   | 17 ++---------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/i2c/busses/i2c-designware-common.c b/drivers/i2c/busses/i2c-designware-common.c
index b7e653e939bd..68d6a1c642a0 100644
--- a/drivers/i2c/busses/i2c-designware-common.c
+++ b/drivers/i2c/busses/i2c-designware-common.c
@@ -713,6 +713,20 @@ void i2c_dw_disable(struct dw_i2c_dev *dev)
 	i2c_dw_release_lock(dev);
 }
 
+int i2c_dw_probe(struct dw_i2c_dev *dev)
+{
+	switch (dev->mode) {
+	case DW_IC_SLAVE:
+		return i2c_dw_probe_slave(dev);
+	case DW_IC_MASTER:
+		return i2c_dw_probe_master(dev);
+	default:
+		dev_err(dev->dev, "Wrong operation mode: %d\n", dev->mode);
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_GPL(i2c_dw_probe);
+
 static int i2c_dw_prepare(struct device *device)
 {
 	/*
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index f6ebf86dcc6f..7479cb3a450d 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -10,9 +10,7 @@
  */
 
 #include <linux/bits.h>
-#include <linux/compiler_types.h>
 #include <linux/completion.h>
-#include <linux/dev_printk.h>
 #include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/pm.h>
@@ -367,19 +365,6 @@ static inline void i2c_dw_configure_slave(struct dw_i2c_dev *dev) { }
 static inline int i2c_dw_probe_slave(struct dw_i2c_dev *dev) { return -EINVAL; }
 #endif
 
-static inline int i2c_dw_probe(struct dw_i2c_dev *dev)
-{
-	switch (dev->mode) {
-	case DW_IC_SLAVE:
-		return i2c_dw_probe_slave(dev);
-	case DW_IC_MASTER:
-		return i2c_dw_probe_master(dev);
-	default:
-		dev_err(dev->dev, "Wrong operation mode: %d\n", dev->mode);
-		return -EINVAL;
-	}
-}
-
 static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 {
 	if (i2c_detect_slave_mode(dev->dev))
@@ -388,6 +373,8 @@ static inline void i2c_dw_configure(struct dw_i2c_dev *dev)
 		i2c_dw_configure_master(dev);
 }
 
+int i2c_dw_probe(struct dw_i2c_dev *dev);
+
 #if IS_ENABLED(CONFIG_I2C_DESIGNWARE_BAYTRAIL)
 int i2c_dw_baytrail_probe_lock_support(struct dw_i2c_dev *dev);
 #endif
-- 
2.43.0.rc1.1.gbec44491f096

