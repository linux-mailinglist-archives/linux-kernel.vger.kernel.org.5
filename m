Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65C27C50BE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 13:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346706AbjJKLCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 07:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346572AbjJKLCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 07:02:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98ADC98
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 04:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697022135; x=1728558135;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uD4MYHG5qvyyAF6HKIr6E+xlIfaGIPkL5F9+Pwgm4B4=;
  b=nCoUNbiQM9684QLAYT9MP1QNhP6+xfsxUoqLAdeb/up/GlGXb7HN0hLN
   pDp2qNG5vDDnvrWkYLDuvNby2JEZeZxCyLbnsOsCzgaRXlJnXc0HJCh8u
   4qmTj3Ep0VPF8fvy9Cq+URPnJPy4mcQxEpuCEEZfXWBw2v2VhoKOT9v8Q
   x10gMnwMJZXtKcOMGkaP4pXCBMKCL1+6zbHnD8XG7Eu9F0uc7UkCVn657
   sQNXCUntMHdqRfYDEdypI1f4IW2I1PL23KfbFK0pOiF/rZbFNTbr7pdIl
   C3XLj80nNAbvLnib39UZeUTS2368jlJqw3KiTz0I6qWms/PMqupceq+Qm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="369696912"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="369696912"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="788960297"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="788960297"
Received: from twinkler-lnx.jer.intel.com ([10.12.231.216])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 04:02:13 -0700
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 3/4] mei: pxp: re-enable client on errors
Date:   Wed, 11 Oct 2023 14:01:56 +0300
Message-ID: <20231011110157.247552-4-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231011110157.247552-1-tomas.winkler@intel.com>
References: <20231011110157.247552-1-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

Disable and enable mei-pxp client on errors to clean the internal state.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/pxp/mei_pxp.c | 70 +++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 22 deletions(-)

diff --git a/drivers/misc/mei/pxp/mei_pxp.c b/drivers/misc/mei/pxp/mei_pxp.c
index c6cdd6a47308ebcc72f34c38..9875d16445bb03efcfb31cd9 100644
--- a/drivers/misc/mei/pxp/mei_pxp.c
+++ b/drivers/misc/mei/pxp/mei_pxp.c
@@ -23,6 +23,24 @@
 
 #include "mei_pxp.h"
 
+static inline int mei_pxp_reenable(const struct device *dev, struct mei_cl_device *cldev)
+{
+	int ret;
+
+	dev_warn(dev, "Trying to reset the channel...\n");
+	ret = mei_cldev_disable(cldev);
+	if (ret < 0)
+		dev_warn(dev, "mei_cldev_disable failed. %d\n", ret);
+	/*
+	 * Explicitly ignoring disable failure,
+	 * enable may fix the states and succeed
+	 */
+	ret = mei_cldev_enable(cldev);
+	if (ret < 0)
+		dev_err(dev, "mei_cldev_enable failed. %d\n", ret);
+	return ret;
+}
+
 /**
  * mei_pxp_send_message() - Sends a PXP message to ME FW.
  * @dev: device corresponding to the mei_cl_device
@@ -35,6 +53,7 @@ mei_pxp_send_message(struct device *dev, const void *message, size_t size)
 {
 	struct mei_cl_device *cldev;
 	ssize_t byte;
+	int ret;
 
 	if (!dev || !message)
 		return -EINVAL;
@@ -44,10 +63,20 @@ mei_pxp_send_message(struct device *dev, const void *message, size_t size)
 	byte = mei_cldev_send(cldev, message, size);
 	if (byte < 0) {
 		dev_dbg(dev, "mei_cldev_send failed. %zd\n", byte);
-		return byte;
+		switch (byte) {
+		case -ENOMEM:
+			fallthrough;
+		case -ENODEV:
+			fallthrough;
+		case -ETIME:
+			ret = mei_pxp_reenable(dev, cldev);
+			if (ret)
+				byte = ret;
+			break;
+		}
 	}
 
-	return 0;
+	return byte;
 }
 
 /**
@@ -63,6 +92,7 @@ mei_pxp_receive_message(struct device *dev, void *buffer, size_t size)
 	struct mei_cl_device *cldev;
 	ssize_t byte;
 	bool retry = false;
+	int ret;
 
 	if (!dev || !buffer)
 		return -EINVAL;
@@ -73,26 +103,22 @@ mei_pxp_receive_message(struct device *dev, void *buffer, size_t size)
 	byte = mei_cldev_recv(cldev, buffer, size);
 	if (byte < 0) {
 		dev_dbg(dev, "mei_cldev_recv failed. %zd\n", byte);
-		if (byte != -ENOMEM)
-			return byte;
-
-		/* Retry the read when pages are reclaimed */
-		msleep(20);
-		if (!retry) {
-			retry = true;
-			goto retry;
-		} else {
-			dev_warn(dev, "No memory on data receive after retry, trying to reset the channel...\n");
-			byte = mei_cldev_disable(cldev);
-			if (byte < 0)
-				dev_warn(dev, "mei_cldev_disable failed. %zd\n", byte);
-			/*
-			 * Explicitly ignoring disable failure,
-			 * enable may fix the states and succeed
-			 */
-			byte = mei_cldev_enable(cldev);
-			if (byte < 0)
-				dev_err(dev, "mei_cldev_enable failed. %zd\n", byte);
+		switch (byte) {
+		case -ENOMEM:
+			/* Retry the read when pages are reclaimed */
+			msleep(20);
+			if (!retry) {
+				retry = true;
+				goto retry;
+			}
+			fallthrough;
+		case -ENODEV:
+			fallthrough;
+		case -ETIME:
+			ret = mei_pxp_reenable(dev, cldev);
+			if (ret)
+				byte = ret;
+			break;
 		}
 	}
 
-- 
2.41.0

