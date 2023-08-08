Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C491774343
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235204AbjHHR76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjHHR7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:59:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D60F8908;
        Tue,  8 Aug 2023 09:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512027; x=1723048027;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=15sgPUJ2wXhm4hgjV02VyUPoKXBOHJknS1CjWkpfOyM=;
  b=fjGxyUfcCvQ7Em1m8Y3hw6J3xNlxSlBWWxFv5s1H+8QzFxH6Za39u/Mw
   YeZqsOFHDA+Rr60vRP2NwcbQIfZoF0skTZk7DOvNvpZwNRjINlxvXqggD
   TNMKXEzTgT0GYzJmLiqOdberUn6+oMhdcb+fZCNAs2faMqjnQw6m8/b5D
   7kecFwMxdMrI3reVKfGvcgAilidCkxxo+EwJDj9UQtO1S3VWqkqw7nOd+
   ZXrSro7UVImlgD69ffU8kAxxnJB23oUqH30ExL1qm6m4y83zKZ3i6bKw0
   lUHIJZxrne+VffaHJboCOP1+UW8bc1Z2Q+Fjgu062mWxwGCKtpp+X4Hu9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457260970"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457260970"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:25:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821449147"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821449147"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 09:24:55 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5AC1F1341; Tue,  8 Aug 2023 19:28:03 +0300 (EEST)
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
Subject: [PATCH v1 4/6] iio: frequency: admv1014: Switch to device_property_match_property_string()
Date:   Tue,  8 Aug 2023 19:27:58 +0300
Message-Id: <20230808162800.61651-5-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/frequency/admv1014.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/iio/frequency/admv1014.c b/drivers/iio/frequency/admv1014.c
index bb5e1feef42b..b46b73b89eb7 100644
--- a/drivers/iio/frequency/admv1014.c
+++ b/drivers/iio/frequency/admv1014.c
@@ -710,7 +710,6 @@ static int admv1014_init(struct admv1014_state *st)
 
 static int admv1014_properties_parse(struct admv1014_state *st)
 {
-	const char *str;
 	unsigned int i;
 	struct spi_device *spi = st->spi;
 	int ret;
@@ -719,27 +718,21 @@ static int admv1014_properties_parse(struct admv1014_state *st)
 
 	st->p1db_comp = device_property_read_bool(&spi->dev, "adi,p1db-compensation-enable");
 
-	ret = device_property_read_string(&spi->dev, "adi,input-mode", &str);
-	if (ret) {
-		st->input_mode = ADMV1014_IQ_MODE;
-	} else {
-		ret = match_string(input_mode_names, ARRAY_SIZE(input_mode_names), str);
-		if (ret < 0)
-			return ret;
-
+	ret = device_property_match_property_string(&spi->dev, "adi,input-mode",
+						    input_mode_names,
+						    ARRAY_SIZE(input_mode_names));
+	if (ret >= 0)
 		st->input_mode = ret;
-	}
-
-	ret = device_property_read_string(&spi->dev, "adi,quad-se-mode", &str);
-	if (ret) {
-		st->quad_se_mode = ADMV1014_SE_MODE_POS;
-	} else {
-		ret = match_string(quad_se_mode_names, ARRAY_SIZE(quad_se_mode_names), str);
-		if (ret < 0)
-			return ret;
+	else
+		st->input_mode = ADMV1014_IQ_MODE;
 
+	ret = device_property_match_property_string(&spi->dev, "adi,quad-se-mode",
+						    quad_se_mode_names,
+						    ARRAY_SIZE(quad_se_mode_names));
+	if (ret >= 0)
 		st->quad_se_mode = ADMV1014_SE_MODE_POS + (ret * 3);
-	}
+	else
+		st->quad_se_mode = ADMV1014_SE_MODE_POS;
 
 	for (i = 0; i < ADMV1014_NUM_REGULATORS; ++i)
 		st->regulators[i].supply = admv1014_reg_name[i];
-- 
2.40.0.1.gaa8946217a0b

