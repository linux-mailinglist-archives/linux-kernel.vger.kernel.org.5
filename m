Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1907766767
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbjG1Iit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233433AbjG1IiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:38:18 -0400
X-Greylist: delayed 71 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Jul 2023 01:38:17 PDT
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C6E1BF2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:38:16 -0700 (PDT)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 202307280837021885275da137ba6ea8
        for <linux-kernel@vger.kernel.org>;
        Fri, 28 Jul 2023 10:37:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=henning.schild@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=sjzuJAI+/GFX3c9vpkjcL9A3iRP3yQcGvaQ7KvEyUXo=;
 b=h4UFXRpf5EjEjkx495yzZe8UFf3uVYK8AD4QTWbQZzcs9aauEkp6r84Pd09AJAqhCVVbF0
 jZrOegRt38fdhJq92leSbInefxwIdkp+0YerDYVHKybctNna4MMOO32YqRZUJuhrIoVc7u9c
 i4is/O1Nmw0BJWKj2Ou6BkoMjADS8=;
From:   henning.schild@siemens.com
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        "xingtong.wu" <xingtong.wu@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH] platform/x86: simatic-ipc-batt: fix reading in BX_21A
Date:   Fri, 28 Jul 2023 10:36:51 +0200
Message-ID: <20230728083651.19747-1-henning.schild@siemens.com>
In-Reply-To: <20230725093113.9739-1-henning.schild@siemens.com>
References: <20230725093113.9739-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-52304:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "xingtong.wu" <xingtong.wu@siemens.com>

There was a case missing in a switch statement which lead to that model
not actually reading the GPIOs. That switch statement got simplified
now. Additionally on that model we need to initialize one pin
differently. As a drive-by finding also add a missing newline.

Fixes: 917f54340794 ("platform/x86: simatic-ipc: add CMOS battery monitoring")
Reported-by: Henning Schild <henning.schild@siemens.com>
Signed-off-by: xingtong.wu <xingtong.wu@siemens.com>
Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 .../platform/x86/siemens/simatic-ipc-batt.c   | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/siemens/simatic-ipc-batt.c b/drivers/platform/x86/siemens/simatic-ipc-batt.c
index d2791ff84f23..e34417ca9e13 100644
--- a/drivers/platform/x86/siemens/simatic-ipc-batt.c
+++ b/drivers/platform/x86/siemens/simatic-ipc-batt.c
@@ -92,19 +92,14 @@ static long simatic_ipc_batt_read_value(struct device *dev)
 
 	next_update = priv.last_updated_jiffies + msecs_to_jiffies(BATT_DELAY_MS);
 	if (time_after(jiffies, next_update) || !priv.last_updated_jiffies) {
-		switch (priv.devmode) {
-		case SIMATIC_IPC_DEVICE_127E:
-		case SIMATIC_IPC_DEVICE_227G:
-		case SIMATIC_IPC_DEVICE_BX_39A:
-			priv.current_state = simatic_ipc_batt_read_gpio();
-			break;
-		case SIMATIC_IPC_DEVICE_227E:
+		if (priv.devmode == SIMATIC_IPC_DEVICE_227E)
 			priv.current_state = simatic_ipc_batt_read_io(dev);
-			break;
-		}
+		else
+			priv.current_state = simatic_ipc_batt_read_gpio();
+
 		priv.last_updated_jiffies = jiffies;
 		if (priv.current_state < SIMATIC_IPC_BATT_LEVEL_FULL)
-			dev_warn(dev, "CMOS battery needs to be replaced.");
+			dev_warn(dev, "CMOS battery needs to be replaced.\n");
 	}
 
 	return priv.current_state;
@@ -163,6 +158,7 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
 	struct simatic_ipc_platform *plat;
 	struct device *dev = &pdev->dev;
 	struct device *hwmon_dev;
+	unsigned long flags;
 	int err;
 
 	plat = pdev->dev.platform_data;
@@ -196,7 +192,10 @@ int simatic_ipc_batt_probe(struct platform_device *pdev, struct gpiod_lookup_tab
 	}
 
 	if (table->table[2].key) {
-		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, GPIOD_OUT_HIGH);
+		flags = GPIOD_OUT_HIGH;
+		if (priv.devmode == SIMATIC_IPC_DEVICE_BX_21A)
+			flags = GPIOD_OUT_LOW;
+		priv.gpios[2] = devm_gpiod_get_index(dev, "CMOSBattery meter", 2, flags);
 		if (IS_ERR(priv.gpios[2])) {
 			err = PTR_ERR(priv.gpios[1]);
 			priv.gpios[2] = NULL;
-- 
2.41.0

