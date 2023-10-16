Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79A37CAD8B
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 17:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjJPPbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 11:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjJPPa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 11:30:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D24B4;
        Mon, 16 Oct 2023 08:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697470256; x=1729006256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RQU8/Zny7LUH+xDdoP1sBFUskYkB9NhPlwDT24YZKrQ=;
  b=New87fooCZGCPjDieI26pgbQ/3fMznUEs42SeLBDcvEMLov/Wwlrlshr
   DlszLacHjiaeOFDzHdsgqNiAM7SWumW4Fzvj0UyS3AyDbmb73BfQdVIM1
   oN2dv3Gx8PpkCRVB3Ym8JPIFEaaoykVej38B+c0iz1lvHx873gIadL7JI
   i4tKIXfVaUklhXLwMAqjZkfXDb1i0a164KSyTLZmAZhXrgPAP2NeCYRJc
   7OHByQpxC0Cy+BJwefY/717v2ns5MYDjXOllSTZwK27jCI2YRw7Ja5R0b
   cs4Gl1Nppr1Pvbeog3eYdcU6HJ4Vp82aXfdeC/OCmh24oH+g2JNTqZNhT
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="7121603"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="7121603"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 08:30:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="1002987990"
X-IronPort-AV: E=Sophos;i="6.03,229,1694761200"; 
   d="scan'208";a="1002987990"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 16 Oct 2023 08:30:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CF423385; Mon, 16 Oct 2023 18:30:52 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Denis Osterland-Heim <denis.osterland@diehl.com>
Subject: [PATCH v2 1/1] leds: core: Refactor led_update_brightness() to use standard pattern
Date:   Mon, 16 Oct 2023 18:30:51 +0300
Message-Id: <20231016153051.1409074-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The standard conditional pattern is to check for errors first and
bail out if any. Refactor led_update_brightness() accordingly.

While at it, drop unneeded assignment and return 0 unconditionally
on success.

Acked-by: Denis Osterland-Heim <denis.osterland@diehl.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: added tag (Denis), Cc'ed to the updated list of LED maintainers
 drivers/leds/led-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/leds/led-core.c b/drivers/leds/led-core.c
index 2230239283d0..89c9806cc97f 100644
--- a/drivers/leds/led-core.c
+++ b/drivers/leds/led-core.c
@@ -364,17 +364,17 @@ EXPORT_SYMBOL_GPL(led_set_brightness_sync);
 
 int led_update_brightness(struct led_classdev *led_cdev)
 {
-	int ret = 0;
+	int ret;
 
 	if (led_cdev->brightness_get) {
 		ret = led_cdev->brightness_get(led_cdev);
-		if (ret >= 0) {
-			led_cdev->brightness = ret;
-			return 0;
-		}
+		if (ret < 0)
+			return ret;
+
+		led_cdev->brightness = ret;
 	}
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(led_update_brightness);
 
-- 
2.40.0.1.gaa8946217a0b

