Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9B57DFF15
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 07:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjKCGP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 02:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbjKCGPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 02:15:48 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45B41B4
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 23:15:41 -0700 (PDT)
Received: from localhost.localdomain (ppp14-2-79-67.adl-apt-pir-bras31.tpg.internode.on.net [14.2.79.67])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A4F7D201C3;
        Fri,  3 Nov 2023 14:15:39 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1698992140;
        bh=hYHyullC4OIb5ueKBUtHARoDjsv8sC0z5UpD23psbTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=lKLQuGemKmw5voq2rUsfzBHn00UX+Y/HnEtbLYNqvN9CseaRxwuOjIHs7hHv9nU17
         1E7Egh94J5i3ygDC9uJZktBIr99HafQqZVBDpCnlta1lT6Pvp8sFgZSnkr2aFDP8za
         zc7oTfZAGpYs9YOf6/q+NZPBnGwPPKhrBVPn+5ULR+8x0FHqFxWxAgD24g5SaHzGW3
         zRjkqz+W+5VxcdrECFjyv/Ds8UsXttu2lfr3OKqezPbOCEV/rWM/I/3QPG9SE3b7Ku
         tW3yISYZM6PmsEguqM8j2YhbfC2qvWaZAumTj9iY2XLk1MaPNvyZeMq2Ydf3+A7WuR
         yyZQ9zdtGTn+Q==
From:   Andrew Jeffery <andrew@codeconstruct.com.au>
To:     minyard@acm.org, openipmi-developer@lists.sourceforge.net
Cc:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        linux-kernel@vger.kernel.org, Jonathan.Cameron@Huawei.com,
        aladyshev22@gmail.com, jk@codeconstruct.com.au
Subject: [PATCH 03/10] ipmi: kcs_bmc: Make kcs_bmc_update_event_mask() static
Date:   Fri,  3 Nov 2023 16:45:15 +1030
Message-Id: <20231103061522.1268637-4-andrew@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
References: <20231103061522.1268637-1-andrew@codeconstruct.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There were no users outside the subsystem core, so let's not expose it.

Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
---
 drivers/char/ipmi/kcs_bmc.c        | 11 +++++------
 drivers/char/ipmi/kcs_bmc_client.h |  2 --
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/char/ipmi/kcs_bmc.c b/drivers/char/ipmi/kcs_bmc.c
index a429d9f8a7bf..1a827db8a465 100644
--- a/drivers/char/ipmi/kcs_bmc.c
+++ b/drivers/char/ipmi/kcs_bmc.c
@@ -68,6 +68,11 @@ irqreturn_t kcs_bmc_handle_event(struct kcs_bmc_device *kcs_bmc)
 }
 EXPORT_SYMBOL(kcs_bmc_handle_event);
 
+static void kcs_bmc_update_event_mask(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 events)
+{
+	kcs_bmc->ops->irq_mask_update(kcs_bmc, mask, events);
+}
+
 int kcs_bmc_enable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client)
 {
 	int rc;
@@ -178,12 +183,6 @@ void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv)
 }
 EXPORT_SYMBOL(kcs_bmc_unregister_driver);
 
-void kcs_bmc_update_event_mask(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 events)
-{
-	kcs_bmc->ops->irq_mask_update(kcs_bmc, mask, events);
-}
-EXPORT_SYMBOL(kcs_bmc_update_event_mask);
-
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Haiyue Wang <haiyue.wang@linux.intel.com>");
 MODULE_AUTHOR("Andrew Jeffery <andrew@aj.id.au>");
diff --git a/drivers/char/ipmi/kcs_bmc_client.h b/drivers/char/ipmi/kcs_bmc_client.h
index 6fdcde0a7169..814ad8e052ef 100644
--- a/drivers/char/ipmi/kcs_bmc_client.h
+++ b/drivers/char/ipmi/kcs_bmc_client.h
@@ -35,8 +35,6 @@ void kcs_bmc_unregister_driver(struct kcs_bmc_driver *drv);
 int kcs_bmc_enable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client);
 void kcs_bmc_disable_device(struct kcs_bmc_device *kcs_bmc, struct kcs_bmc_client *client);
 
-void kcs_bmc_update_event_mask(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 events);
-
 u8 kcs_bmc_read_data(struct kcs_bmc_device *kcs_bmc);
 void kcs_bmc_write_data(struct kcs_bmc_device *kcs_bmc, u8 data);
 u8 kcs_bmc_read_status(struct kcs_bmc_device *kcs_bmc);
-- 
2.39.2

