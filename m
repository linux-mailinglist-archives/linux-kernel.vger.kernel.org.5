Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B930774337
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjHHR7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjHHR6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:58:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B32BC8A;
        Tue,  8 Aug 2023 09:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691511991; x=1723047991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=f91CxPAnd8jYoABhN6Y0bEUrupNGUDodI0gM1y7O31Y=;
  b=ZCk+nwI71K0P+TdytxIjoUExeLBvf1bcfN4ut8zs73mt1JNZPO6eRUMe
   bLldGwiSgnAHyJxzUPNe3Mfza4IeJnbVzvtzPDRSnoSFx1XIPbR0HZgi1
   zW5YZibVjJL/AuTy5vSfoglkpc3rVWviSwYZ2iQqt4sgOigGC6Axgz6Hy
   ERU0cpFI6nmXEgII45OLJ0TjH6r6RCfC7JmOIoS5OtA3smvSKKC4cQax8
   OwuKwv4YTQdHPKXYLkcFUizZgp+D2I6KBTmyu8JJeAPyc9pLxBurUJX2H
   nXaZBSs0pkl6FU6uHxQouVh3fnT5M8/eupOpf+1X66l4apzU670mlRVbY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457260946"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457260946"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821449146"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821449146"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 09:24:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4E5BDF4D; Tue,  8 Aug 2023 19:28:03 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v1 3/6] iio: frequency: adf4377: Switch to device_property_match_property_string()
Date:   Tue,  8 Aug 2023 19:27:57 +0300
Message-Id: <20230808162800.61651-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
References: <20230808162800.61651-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace open coded device_property_match_property_string().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/iio/frequency/adf4377.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
index 26abecbd51e0..9284c13f1abb 100644
--- a/drivers/iio/frequency/adf4377.c
+++ b/drivers/iio/frequency/adf4377.c
@@ -870,7 +870,6 @@ static const struct iio_chan_spec adf4377_channels[] = {
 static int adf4377_properties_parse(struct adf4377_state *st)
 {
 	struct spi_device *spi = st->spi;
-	const char *str;
 	int ret;
 
 	st->clkin = devm_clk_get_enabled(&spi->dev, "ref_in");
@@ -896,16 +895,13 @@ static int adf4377_properties_parse(struct adf4377_state *st)
 		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
 				     "failed to get the CE GPIO\n");
 
-	ret = device_property_read_string(&spi->dev, "adi,muxout-select", &str);
-	if (ret) {
-		st->muxout_select = ADF4377_MUXOUT_HIGH_Z;
-	} else {
-		ret = match_string(adf4377_muxout_modes, ARRAY_SIZE(adf4377_muxout_modes), str);
-		if (ret < 0)
-			return ret;
-
+	ret = device_property_match_property_string(&spi->dev, "adi,muxout-select",
+						    adf4377_muxout_modes,
+						    ARRAY_SIZE(adf4377_muxout_modes));
+	if (ret >= 0)
 		st->muxout_select = ret;
-	}
+	else
+		st->muxout_select = ADF4377_MUXOUT_HIGH_Z;
 
 	return 0;
 }
-- 
2.40.0.1.gaa8946217a0b

