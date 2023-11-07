Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A017E4B17
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343810AbjKGVsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjKGVsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:48:10 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDD110CF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 13:48:08 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-359343e399fso21026795ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 13:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699393687; x=1699998487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s08RBoZSpHbsDlBdpZDIYrmoRYe1Os4Jlgu75g52b+A=;
        b=as2UIWGOz3L39ymOa4CeOga1gFYC3tdHuxoIU/rRKRus8baoxZQQNznmQYFbwl2rI9
         YMeaoA/sn8ozW9XYN5z+scyhxmBaF+M+PZ9JFWN4RS8UrZnP10IWn4PJfcQMmMLBf2xT
         LB8RJ0MpJ7di7v7bm60CTjGyKGSgboOw8Q9/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699393687; x=1699998487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s08RBoZSpHbsDlBdpZDIYrmoRYe1Os4Jlgu75g52b+A=;
        b=mAlfWSwxCbpIsteuEFoG2kfF0HOWSezmRNKQM5+yOrXyEOcQaj1qKewlEqiLXoXpyi
         SzpAeVJXHb2Po8nONxQDntWyfdqnPoKNEVT5dk+jp3r5S3VmWFVROz7UspooDdWqVs3v
         VhneAJLcyhr0VazqjGm0KlNYt43z5R9ekmExhXJJon/7T/wjoFdkHk1EonHMR72fSaP3
         02AE5AwHdR79EbQPbgnHb4PnbLHhYLMN8x/YLuQ5llV21L5IgMx2+5C817lXZ5tpUE9j
         VXZEJ1OZo65r0ZfrZDrBVxz+3gCCkybb9QGdBFz2MxNY57cNFaovHCBYroKpDc+R7Gur
         SRkQ==
X-Gm-Message-State: AOJu0YybX+LSx4HY8KXi6AjmS01Q/vmA72yy51vBtUqU2do0SyiRSuqT
        ezAXUWgAoyEKDnjIXPnSNOh2vfh+UrkamJTme/Q=
X-Google-Smtp-Source: AGHT+IGFkrXZWf+NvDPMtqiW6zyxFWsm4GDluk9yZviTuskanTcQ7EsMpWBGuOMRHG9x/57ueEbISw==
X-Received: by 2002:a92:cd82:0:b0:359:4287:28fc with SMTP id r2-20020a92cd82000000b00359428728fcmr147662ilb.7.1699393687330;
        Tue, 07 Nov 2023 13:48:07 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.162])
        by smtp.gmail.com with ESMTPSA id l2-20020a056e020e4200b0035161817c37sm3389024ilk.1.2023.11.07.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 13:48:07 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Subject: [PATCH v1] spi: Fix null dereference on suspend
Date:   Tue,  7 Nov 2023 14:47:43 -0700
Message-ID: <20231107144743.v1.1.I7987f05f61901f567f7661763646cb7d7919b528@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A race condition exists where a synchronous (noqueue) transfer can be
active during a system suspend. This can cause a null pointer
dereference exception to occur when the system resumes.

Example order of events leading to the exception:
1. spi_sync() calls __spi_transfer_message_noqueue() which sets
   ctlr->cur_msg
2. Spi transfer begins via spi_transfer_one_message()
3. System is suspended interrupting the transfer context
4. System is resumed
6. spi_controller_resume() calls spi_start_queue() which resets cur_msg
   to NULL
7. Spi transfer context resumes and spi_finalize_current_message() is
   called which dereferences cur_msg (which is now NULL)

Wait for synchronous transfers to complete before suspending by
acquiring the bus mutex and setting/checking a suspend flag.

Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
---

 drivers/spi/spi.c       | 56 ++++++++++++++++++++++++++++-------------
 include/linux/spi/spi.h |  1 +
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 791df0e69105..8ead7acb99f3 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3317,33 +3317,52 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
 
+static inline int __spi_check_suspended(const struct spi_controller *ctlr)
+{
+	return ctlr->flags & SPI_CONTROLLER_SUSPENDED ? -ESHUTDOWN : 0;
+}
+
+static inline void __spi_mark_suspended(struct spi_controller *ctlr)
+{
+	mutex_lock(&ctlr->bus_lock_mutex);
+	ctlr->flags |= SPI_CONTROLLER_SUSPENDED;
+	mutex_unlock(&ctlr->bus_lock_mutex);
+}
+
+static inline void __spi_mark_resumed(struct spi_controller *ctlr)
+{
+	mutex_lock(&ctlr->bus_lock_mutex);
+	ctlr->flags &= ~SPI_CONTROLLER_SUSPENDED;
+	mutex_unlock(&ctlr->bus_lock_mutex);
+}
+
 int spi_controller_suspend(struct spi_controller *ctlr)
 {
-	int ret;
+	int ret = 0;
 
 	/* Basically no-ops for non-queued controllers */
-	if (!ctlr->queued)
-		return 0;
-
-	ret = spi_stop_queue(ctlr);
-	if (ret)
-		dev_err(&ctlr->dev, "queue stop failed\n");
+	if (ctlr->queued) {
+		ret = spi_stop_queue(ctlr);
+		if (ret)
+			dev_err(&ctlr->dev, "queue stop failed\n");
+	}
 
+	__spi_mark_suspended(ctlr);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_controller_suspend);
 
 int spi_controller_resume(struct spi_controller *ctlr)
 {
-	int ret;
-
-	if (!ctlr->queued)
-		return 0;
+	int ret = 0;
 
-	ret = spi_start_queue(ctlr);
-	if (ret)
-		dev_err(&ctlr->dev, "queue restart failed\n");
+	__spi_mark_resumed(ctlr);
 
+	if (ctlr->queued) {
+		ret = spi_start_queue(ctlr);
+		if (ret)
+			dev_err(&ctlr->dev, "queue restart failed\n");
+	}
 	return ret;
 }
 EXPORT_SYMBOL_GPL(spi_controller_resume);
@@ -4147,8 +4166,7 @@ static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct s
 	ctlr->cur_msg = msg;
 	ret = __spi_pump_transfer_message(ctlr, msg, was_busy);
 	if (ret)
-		goto out;
-
+		dev_err(&ctlr->dev, "noqueue transfer failed\n");
 	ctlr->cur_msg = NULL;
 	ctlr->fallback = false;
 
@@ -4164,7 +4182,6 @@ static void __spi_transfer_message_noqueue(struct spi_controller *ctlr, struct s
 		spi_idle_runtime_pm(ctlr);
 	}
 
-out:
 	mutex_unlock(&ctlr->io_mutex);
 }
 
@@ -4187,6 +4204,11 @@ static int __spi_sync(struct spi_device *spi, struct spi_message *message)
 	int status;
 	struct spi_controller *ctlr = spi->controller;
 
+	if (__spi_check_suspended(ctlr)) {
+		dev_warn_once(&spi->dev, "Attempted to sync while suspend\n");
+		return -ESHUTDOWN;
+	}
+
 	status = __spi_validate(spi, message);
 	if (status != 0)
 		return status;
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 86825c88b576..255a0562aea5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -566,6 +566,7 @@ struct spi_controller {
 #define SPI_CONTROLLER_MUST_RX		BIT(3)	/* Requires rx */
 #define SPI_CONTROLLER_MUST_TX		BIT(4)	/* Requires tx */
 #define SPI_CONTROLLER_GPIO_SS		BIT(5)	/* GPIO CS must select slave */
+#define SPI_CONTROLLER_SUSPENDED	BIT(6)	/* Currently suspended */
 
 	/* Flag indicating if the allocation of this struct is devres-managed */
 	bool			devm_allocated;
-- 
2.42.0.869.gea05f2083d-goog

