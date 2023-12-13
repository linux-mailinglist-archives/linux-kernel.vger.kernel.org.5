Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6AAC8119DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 17:43:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379456AbjLMQnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 11:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjLMQnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 11:43:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB85198
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 08:43:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B93C433CA;
        Wed, 13 Dec 2023 16:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702485799;
        bh=rdciy/0/Z93nKkXxUuM7UguPu20ZVfuX9LAn386poEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dqtg2pM9xbljP02JIqTH46nYNlnAMc7Q0E0OQra/fNqCKcgEKD1nnQ5YsUa14ouEy
         dznp2ey28JKoFwQWuHBrgt6FVXBO6zOqssz14lC9Q8kNx4XJ9tMYscdQbAIPfA76Bq
         T9xxaf0x1MycykiWCpwo9huxkrQsKX+chqZAz1xI98HJ3A3JfmXM3THD/QqVp9nGiP
         N6DzwPtdtNjTT7Xwx+rUyTC3epNyMTShrjkj0SLWt8udrbZd++IrE7EE2PhRggtR+R
         q29LTgz93GTzFyA5dkn2L54biIrmynq+pYy9AwbLkPbFmMk8AyktcVpevdhthplqVi
         jlisSRxWHe04Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        usb-storage@lists.one-eyed-alien.net
Subject: [PATCH 12/12] usb: storage: Remove snprintf() from sysfs call-backs and replace with sysfs_emit()
Date:   Wed, 13 Dec 2023 16:42:41 +0000
Message-ID: <20231213164246.1021885-13-lee@kernel.org>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231213164246.1021885-1-lee@kernel.org>
References: <20231213164246.1021885-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() has the documented, but still rather strange trait of
returning the length of the data that *would have been* written to the
array if space were available, rather than the arguably more useful
length of data *actually* written, it is usually considered wise to use
something else instead in order to avoid confusion.

In the case of sysfs call-backs, new wrappers exist that do just that.

Link: https://lwn.net/Articles/69419/
Link: https://github.com/KSPP/linux/issues/105
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: usb-storage@lists.one-eyed-alien.net
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/usb/storage/sierra_ms.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index 0774ba22fb66e..177fa6cd143ab 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -98,26 +98,26 @@ static ssize_t truinst_show(struct device *dev, struct device_attribute *attr,
 	struct usb_device *udev = interface_to_usbdev(intf);
 	int result;
 	if (swi_tru_install == TRU_FORCE_MS) {
-		result = snprintf(buf, PAGE_SIZE, "Forced Mass Storage\n");
+		result = sysfs_emit(buf, "Forced Mass Storage\n");
 	} else {
 		swocInfo = kmalloc(sizeof(struct swoc_info), GFP_KERNEL);
 		if (!swocInfo) {
-			snprintf(buf, PAGE_SIZE, "Error\n");
+			sysfs_emit(buf, "Error\n");
 			return -ENOMEM;
 		}
 		result = sierra_get_swoc_info(udev, swocInfo);
 		if (result < 0) {
 			dev_dbg(dev, "SWIMS: failed SWoC query\n");
 			kfree(swocInfo);
-			snprintf(buf, PAGE_SIZE, "Error\n");
+			sysfs_emit(buf, "Error\n");
 			return -EIO;
 		}
 		debug_swoc(dev, swocInfo);
-		result = snprintf(buf, PAGE_SIZE,
-			"REV=%02d SKU=%04X VER=%04X\n",
-			swocInfo->rev,
-			swocInfo->LinuxSKU,
-			swocInfo->LinuxVer);
+		result = sysfs_emit(buf,
+				    "REV=%02d SKU=%04X VER=%04X\n",
+				    swocInfo->rev,
+				    swocInfo->LinuxSKU,
+				    swocInfo->LinuxVer);
 		kfree(swocInfo);
 	}
 	return result;
-- 
2.43.0.472.g3155946c3a-goog

