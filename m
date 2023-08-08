Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26327774346
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjHHSAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjHHR7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:59:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB77890C;
        Tue,  8 Aug 2023 09:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691512033; x=1723048033;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2+l/cxo6AVrTQ5h7fePgIjT5ulStNYcn0rdQ6zjsI/Q=;
  b=B0MUE1wwxVQFPdY227NubGwER82koUIKSCX14p7R1ascwHPWAjzsAKWG
   Xdep4Np8VdpAAn+AEgEqtKNM4FvQMcMYsn+GV1NZ6dfTq9JkxfyEWqku9
   ym6Mhsl8kFuvf/OotJfk8GghBjtdLeEZEUL85LgVuACHbrth5JZQgmN9T
   OsPB6S/EnNcg97ez15USVP0QHoVpJghG5DXcv28itUnutGO+wW3py9NIu
   jGwXsgB5+UIFphiR/opG0YrHtfjVH6wBQH2ClPT1++8lDOt5Q5JG7Eqod
   i+St1iXmKPp69EbyXHmf+/97GyXpiXLiWKb2DV27tnQ+lrE/la4gLLwfC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="457261002"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="457261002"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 09:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="821449261"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="821449261"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Aug 2023 09:24:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6A2811358; Tue,  8 Aug 2023 19:28:03 +0300 (EEST)
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
Subject: [PATCH v1 5/6] iio: magnetometer: tmag5273: Switch to device_property_match_property_string()
Date:   Tue,  8 Aug 2023 19:27:59 +0300
Message-Id: <20230808162800.61651-6-andriy.shevchenko@linux.intel.com>
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
 drivers/iio/magnetometer/tmag5273.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/magnetometer/tmag5273.c b/drivers/iio/magnetometer/tmag5273.c
index c5e5c4ad681e..bcd989d65059 100644
--- a/drivers/iio/magnetometer/tmag5273.c
+++ b/drivers/iio/magnetometer/tmag5273.c
@@ -497,17 +497,13 @@ static int tmag5273_set_operating_mode(struct tmag5273_data *data,
 static void tmag5273_read_device_property(struct tmag5273_data *data)
 {
 	struct device *dev = data->dev;
-	const char *str;
 	int ret;
 
 	data->angle_measurement = TMAG5273_ANGLE_EN_X_Y;
 
-	ret = device_property_read_string(dev, "ti,angle-measurement", &str);
-	if (ret)
-		return;
-
-	ret = match_string(tmag5273_angle_names,
-			   ARRAY_SIZE(tmag5273_angle_names), str);
+	ret = device_property_match_property_string(dev, "ti,angle-measurement",
+						    tmag5273_angle_names,
+						    ARRAY_SIZE(tmag5273_angle_names));
 	if (ret >= 0)
 		data->angle_measurement = ret;
 }
-- 
2.40.0.1.gaa8946217a0b

