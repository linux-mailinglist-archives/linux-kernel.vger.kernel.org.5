Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB98774349
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235214AbjHHSAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjHHR7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:59:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53082CEDE;
        Tue,  8 Aug 2023 09:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512040; x=1723048040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gWwAWGglUm0bX7zbgnm6zeMnQk/P1kwlr24RlDxfY40=;
  b=im2U57xWrm1MTPgzQZJe1GyXcXPY10iqx8PoVOYdAK8in4RWxWx2ulnP
   hOdRZBULwZSSI1CMdyS6/sn/ET2LQmnU0pjaAChTaKAs8Em2Gy4t0oQ/+
   wezzKH//aTVfygEVxFx2rEhMvr2yEkO2M35PmgX7Y1axwPQZFN097UsQJ
   MJFOF9YgRwpRI7iyo/zFOHzbb3NCzQBLPjG6WjU8Ds9J2CM+UmPV6I4yN
   9OzQSOtsLsZEOckKb4aP8nAaJg3CuopcbklUFoRO1Cz+vzhEGz2QuJg33
   8ecdWGfPnZUC167rw4EbLYFxHYof34Ma1ySO4ijlxXQSEKrhouH4HOOhr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457260988"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457260988"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821449262"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821449262"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 09:24:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 79FAC1476; Tue,  8 Aug 2023 19:28:03 +0300 (EEST)
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
Subject: [PATCH v1 6/6] iio: proximity: sx9324: Switch to device_property_match_property_string()
Date:   Tue,  8 Aug 2023 19:28:00 +0300
Message-Id: <20230808162800.61651-7-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/proximity/sx9324.c | 24 ++++++++++--------------
 1 file changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 438f9c9aba6e..ac2ed2da21cc 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -888,7 +888,6 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	char prop[] = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
 	int ret, count, ph, pin;
-	const char *res;
 
 	memcpy(reg_def, &sx9324_default_regs[idx], sizeof(*reg_def));
 
@@ -915,24 +914,21 @@ sx9324_get_default_reg(struct device *dev, int idx,
 		reg_def->def = raw;
 		break;
 	case SX9324_REG_AFE_CTRL0:
-		ret = device_property_read_string(dev,
-				"semtech,cs-idle-sleep", &res);
-		if (!ret)
-			ret = match_string(sx9324_csidle, ARRAY_SIZE(sx9324_csidle), res);
+		ret = device_property_match_property_string(dev, "semtech,cs-idle-sleep",
+							    sx9324_csidle,
+							    ARRAY_SIZE(sx9324_csidle));
 		if (ret >= 0) {
 			reg_def->def &= ~SX9324_REG_AFE_CTRL0_CSIDLE_MASK;
 			reg_def->def |= ret << SX9324_REG_AFE_CTRL0_CSIDLE_SHIFT;
 		}
 
-		ret = device_property_read_string(dev,
-				"semtech,int-comp-resistor", &res);
-		if (ret)
-			break;
-		ret = match_string(sx9324_rints, ARRAY_SIZE(sx9324_rints), res);
-		if (ret < 0)
-			break;
-		reg_def->def &= ~SX9324_REG_AFE_CTRL0_RINT_MASK;
-		reg_def->def |= ret << SX9324_REG_AFE_CTRL0_RINT_SHIFT;
+		ret = device_property_match_property_string(dev, "semtech,int-comp-resistor",
+							    sx9324_rints,
+							    ARRAY_SIZE(sx9324_rints));
+		if (ret >= 0) {
+			reg_def->def &= ~SX9324_REG_AFE_CTRL0_RINT_MASK;
+			reg_def->def |= ret << SX9324_REG_AFE_CTRL0_RINT_SHIFT;
+		}
 		break;
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
-- 
2.40.0.1.gaa8946217a0b

