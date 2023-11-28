Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD427FC26D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345517AbjK1SIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 13:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345452AbjK1SH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 13:07:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA887D1;
        Tue, 28 Nov 2023 10:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701194884; x=1732730884;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5F0bjNxEgtP7x33STn/p+8Uw7VTHKy9xSYAWXxBhJGM=;
  b=VrFhqLCFUzVatPfxj/OenNNQ+XRtRCAkD9sj5Ljavl9zz8LrtUkul6dI
   Ovto1+AoX5YuWp95PCQ2uSSf3gVlG4b0HgWbAwTRC74WLaGprCZwGo6r8
   1OEeIJk0oIM2r53VlR/Afk4T4UwToZKk+NmxbgisS8l+/GI5urML2Tz3w
   QQShuOnNOGnYAhkoBc+fwoob8skmWVLxg8Rl0EuCYgybVPA5bh8zbMoQE
   Oq+uxw2q0svV8H3QNXzRIenw5LN/xlzuvkIL4F5Z39sN+/8OYGQxrF7Hd
   uiLTG2JEf6Bs02cxXP0eP4PGJV0wCzahZg43d8mMJ1uCd/fyQVehJF0oK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="373166001"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="373166001"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 10:07:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859523451"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="859523451"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Nov 2023 10:06:59 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 12AF74D4; Tue, 28 Nov 2023 20:06:58 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/3] hwmon: tmp513: Simplify with dev_err_probe()
Date:   Tue, 28 Nov 2023 20:06:03 +0200
Message-ID: <20231128180654.395692-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20231128180654.395692-1-andriy.shevchenko@linux.intel.com>
References: <20231128180654.395692-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hwmon/tmp513.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/hwmon/tmp513.c b/drivers/hwmon/tmp513.c
index 849a8c3e1020..6e01800404fc 100644
--- a/drivers/hwmon/tmp513.c
+++ b/drivers/hwmon/tmp513.c
@@ -630,9 +630,9 @@ static int tmp51x_vbus_range_to_reg(struct device *dev,
 	} else if (data->vbus_range_uvolt == TMP51X_VBUS_RANGE_16V) {
 		data->shunt_config &= ~TMP51X_BUS_VOLTAGE_MASK;
 	} else {
-		dev_err(dev, "ti,bus-range-microvolt is invalid: %u\n",
-			data->vbus_range_uvolt);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "ti,bus-range-microvolt is invalid: %u\n",
+				     data->vbus_range_uvolt);
 	}
 	return 0;
 }
@@ -648,8 +648,8 @@ static int tmp51x_pga_gain_to_reg(struct device *dev, struct tmp51x_data *data)
 	} else if (data->pga_gain == 1) {
 		data->shunt_config |= CURRENT_SENSE_VOLTAGE_40_MASK;
 	} else {
-		dev_err(dev, "ti,pga-gain is invalid: %u\n", data->pga_gain);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "ti,pga-gain is invalid: %u\n", data->pga_gain);
 	}
 	return 0;
 }
@@ -679,9 +679,9 @@ static int tmp51x_read_properties(struct device *dev, struct tmp51x_data *data)
 
 	// Check if shunt value is compatible with pga-gain
 	if (data->shunt_uohms > data->pga_gain * 40 * 1000 * 1000) {
-		dev_err(dev, "shunt-resistor: %u too big for pga_gain: %u\n",
-			data->shunt_uohms, data->pga_gain);
-		return -EINVAL;
+		return dev_err_probe(dev, -EINVAL,
+				     "shunt-resistor: %u too big for pga_gain: %u\n",
+				     data->shunt_uohms, data->pga_gain);
 	}
 
 	return 0;
@@ -721,22 +721,16 @@ static int tmp51x_probe(struct i2c_client *client)
 	data->max_channels = (uintptr_t)i2c_get_match_data(client);
 
 	ret = tmp51x_configure(dev, data);
-	if (ret < 0) {
-		dev_err(dev, "error configuring the device: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "error configuring the device\n");
 
 	data->regmap = devm_regmap_init_i2c(client, &tmp51x_regmap_config);
-	if (IS_ERR(data->regmap)) {
-		dev_err(dev, "failed to allocate register map\n");
-		return PTR_ERR(data->regmap);
-	}
+	if (IS_ERR(data->regmap))
+		return dev_err_probe(dev, PTR_ERR(data->regmap), "failed to allocate register map\n");
 
 	ret = tmp51x_init(data);
-	if (ret < 0) {
-		dev_err(dev, "error configuring the device: %d\n", ret);
-		return -ENODEV;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "error configuring the device\n");
 
 	hwmon_dev = devm_hwmon_device_register_with_info(dev, client->name,
 							 data,
-- 
2.43.0.rc1.1.gbec44491f096

