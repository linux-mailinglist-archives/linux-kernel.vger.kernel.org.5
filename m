Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4C07F2AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjKUKhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233992AbjKUKhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:37:08 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2BCD78;
        Tue, 21 Nov 2023 02:36:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1700563010; x=1732099010;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/BuOSICs5te6V9ljUk+eVtExi5LOcGJYUpjHjgNW5Hk=;
  b=P5YNhls8Xyip+vIaTNvc+NyTtzaN6Kk9jptDDv79bgNaYvxE44aP+vNq
   Ji34xcxI6aYx99SfUrgGUnrTdoeTjysZkImo4HAIFAYtYdvRiuJIOxBf2
   L/ikUu1KL/xXXgtWXf0QaI5FZVmuV74iWAMe7iGGSHhnn2yy2HOs/2w92
   HfNJUuDbmW7Yl8zAJq0y+TMH/dlpgLADLmPlHF9gG4QaWjsYHYWKvsxKM
   N1k0PQU9iavk3f3dcoVkew5fDrvvJOI41KSmTCYYwRTlmO/TcScC/NIsH
   vPHLyd8AvDm62jjk7e0H7NMLh+frzmXX3ibiRT06TXYJh2e+HFxB5hhcy
   w==;
X-IronPort-AV: E=Sophos;i="6.04,215,1695679200"; 
   d="scan'208";a="34092750"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Nov 2023 11:36:47 +0100
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.20])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 2F03A280075;
        Tue, 21 Nov 2023 11:36:47 +0100 (CET)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@ew.tq-group.com,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH] Input: synaptics-rmi4 - remove no-op reset handler
Date:   Tue, 21 Nov 2023 11:36:33 +0100
Message-ID: <20231121103633.42978-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the individual function drivers have ever implemented a reset()
operation, meaning that reset_one_function() and in turn
rmi_driver_process_reset_requests() have always been no-ops. Get rid of
them.

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---
 drivers/input/rmi4/rmi_bus.h    |  1 -
 drivers/input/rmi4/rmi_driver.c | 38 ---------------------------------
 2 files changed, 39 deletions(-)

diff --git a/drivers/input/rmi4/rmi_bus.h b/drivers/input/rmi4/rmi_bus.h
index 25df6320f9f1d..9b0860a8b06f9 100644
--- a/drivers/input/rmi4/rmi_bus.h
+++ b/drivers/input/rmi4/rmi_bus.h
@@ -80,7 +80,6 @@ struct rmi_function_handler {
 	int (*probe)(struct rmi_function *fn);
 	void (*remove)(struct rmi_function *fn);
 	int (*config)(struct rmi_function *fn);
-	int (*reset)(struct rmi_function *fn);
 	irqreturn_t (*attention)(int irq, void *ctx);
 	int (*suspend)(struct rmi_function *fn);
 	int (*resume)(struct rmi_function *fn);
diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
index 258d5fe3d395c..131add4b9affd 100644
--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -57,25 +57,6 @@ void rmi_free_function_list(struct rmi_device *rmi_dev)
 	data->f34_container = NULL;
 }
 
-static int reset_one_function(struct rmi_function *fn)
-{
-	struct rmi_function_handler *fh;
-	int retval = 0;
-
-	if (!fn || !fn->dev.driver)
-		return 0;
-
-	fh = to_rmi_function_handler(fn->dev.driver);
-	if (fh->reset) {
-		retval = fh->reset(fn);
-		if (retval < 0)
-			dev_err(&fn->dev, "Reset failed with code %d.\n",
-				retval);
-	}
-
-	return retval;
-}
-
 static int configure_one_function(struct rmi_function *fn)
 {
 	struct rmi_function_handler *fh;
@@ -95,21 +76,6 @@ static int configure_one_function(struct rmi_function *fn)
 	return retval;
 }
 
-static int rmi_driver_process_reset_requests(struct rmi_device *rmi_dev)
-{
-	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
-	struct rmi_function *entry;
-	int retval;
-
-	list_for_each_entry(entry, &data->function_list, node) {
-		retval = reset_one_function(entry);
-		if (retval < 0)
-			return retval;
-	}
-
-	return 0;
-}
-
 static int rmi_driver_process_config_requests(struct rmi_device *rmi_dev)
 {
 	struct rmi_driver_data *data = dev_get_drvdata(&rmi_dev->dev);
@@ -445,10 +411,6 @@ static int rmi_driver_reset_handler(struct rmi_device *rmi_dev)
 		return error;
 	}
 
-	error = rmi_driver_process_reset_requests(rmi_dev);
-	if (error < 0)
-		return error;
-
 	error = rmi_driver_process_config_requests(rmi_dev);
 	if (error < 0)
 		return error;
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

