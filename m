Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB787CCA06
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343887AbjJQRly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjJQRlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:41:52 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2939B0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:41:49 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6c63117a659so3617982a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697564509; x=1698169309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1Pn9eJVdwl+J/sFLPoMCtNv2U3ugpV05N/p/0aVkH1Y=;
        b=EQqsSkgEz73UpHuuW8bi4OGC+Dy4Ytc+u56FiG+l2PmWzrAEEah3bDK3TJ6CyNKYvJ
         jqyUQK1OXZ/DibnIMY7iFCYBWm7TtUKtrr55u4lfcCGHCPOdHtP3rDTCPJI5y/sl2/+2
         k9D7vBkBI9aroT575VbSvQ9WMAy4X1Xf4nHAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697564509; x=1698169309;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Pn9eJVdwl+J/sFLPoMCtNv2U3ugpV05N/p/0aVkH1Y=;
        b=XurUN+d+j3dDRC3dtuZBhusvjd44WKmZkmCnO8pO1pBl6/sabIhz3xx+TE+TE2WKRI
         9656BvH0UIeRwrNMTR6JVz0VOMp57Y+OMYiZbT+WeHShkEBhBhMO7Hoizkvv/kh7Tqer
         ajd43wr12RS36y9jxkp97hVGsfBTiEUAIXQehoSdZy8NRTaXMuu3cxsikNiMOTPtDtnS
         o8Qkf/lxRUF/Ccrvih+dw8bYIkN31sec3aC6BUrWltIts76qdheZZzKYOteIXNu4pQXe
         BDvfEcFtF4WI759Gw2GwaPlR0qs4x0y6v2Nhd98xZH4KHJrRNK9i82su4OTZCexL0QBX
         oNhA==
X-Gm-Message-State: AOJu0Yz05lT+B0wrMUlJCuco/ZWYwYA1G5BFjczZezCkE3+LRXiUUtUZ
        itZf25LFSIQClyC0RUJvjPQeXO5BxntXUTOe/vQ=
X-Google-Smtp-Source: AGHT+IGszE3Pnh4d2ZDJ8/XflC6nRCbUIzOSW0KfglBrRor01NS4jJl9PFXi4JjJsJqQSWvmhcOpGA==
X-Received: by 2002:a05:6830:118b:b0:6b9:62f5:ac62 with SMTP id u11-20020a056830118b00b006b962f5ac62mr2715609otq.35.1697564508798;
        Tue, 17 Oct 2023 10:41:48 -0700 (PDT)
Received: from lalithkraj-glaptop.corp.google.com ([2620:15c:2a:201:f4f7:57a:9a7d:3e2e])
        by smtp.gmail.com with ESMTPSA id m16-20020a9d6090000000b006c20f55525esm339246otj.1.2023.10.17.10.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 10:41:48 -0700 (PDT)
From:   Lalith Rajendran <lalithkraj@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lalith Rajendran <lalithkraj@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v1] FROMLIST: platform/chrome: cros_ec_lpc: Separate host command and irq disable
Date:   Tue, 17 Oct 2023 12:40:48 -0500
Message-ID: <20231017124047.1.Icc99145043c8d44142bb5ca64ea4c63a417c267b@changeid>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both cros host command and irq disable were moved to suspend
prepare stage from late suspend recently. This is causing EC
to report MKBP event timeouts during suspend stress testing.
When the MKBP event timeouts happen during suspend, subsequent
wakeup of AP by EC using MKBP doesn't happen properly. Although
there are other issues to debug here, this change move the irq
disabling part back to late suspend stage which is a general
suggestion from the suspend kernel documentaiton to do irq
disable as late as possible.

Signed-off-by: Lalith Rajendran <lalithkraj@chromium.org>
---

 drivers/platform/chrome/cros_ec.c     | 120 +++++++++++++++++++++-----
 drivers/platform/chrome/cros_ec.h     |   4 +
 drivers/platform/chrome/cros_ec_lpc.c |  22 ++++-
 3 files changed, 120 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 5d36fbc75e1b..e18ee397bf0e 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -321,17 +321,8 @@ void cros_ec_unregister(struct cros_ec_device *ec_dev)
 EXPORT_SYMBOL(cros_ec_unregister);
 
 #ifdef CONFIG_PM_SLEEP
-/**
- * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
- * @ec_dev: Device to suspend.
- *
- * This can be called by drivers to handle a suspend event.
- *
- * Return: 0 on success or negative error code.
- */
-int cros_ec_suspend(struct cros_ec_device *ec_dev)
+static int cros_ec_send_suspend_event(struct cros_ec_device *ec_dev)
 {
-	struct device *dev = ec_dev->dev;
 	int ret;
 	u8 sleep_event;
 
@@ -343,7 +334,26 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec\n",
 			ret);
+	return 0;
+}
 
+/**
+ * cros_ec_suspend_prepare() - Handle a suspend prepare operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend prepare stage of suspend.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_suspend_prepare(struct cros_ec_device *ec_dev)
+{
+	return cros_ec_send_suspend_event(ec_dev);
+}
+EXPORT_SYMBOL(cros_ec_suspend_prepare);
+
+static int cros_ec_disable_irq(struct cros_ec_device *ec_dev)
+{
+	struct device *dev = ec_dev->dev;
 	if (device_may_wakeup(dev))
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
 	else
@@ -354,6 +364,35 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	return 0;
 }
+
+/**
+ * cros_ec_suspend_late() - Handle a suspend late operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend late stage of suspend.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_suspend_late(struct cros_ec_device *ec_dev)
+{
+	return cros_ec_disable_irq(ec_dev);
+}
+EXPORT_SYMBOL(cros_ec_suspend_late);
+
+/**
+ * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend event.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_suspend(struct cros_ec_device *ec_dev)
+{
+	cros_ec_send_suspend_event(ec_dev);
+	cros_ec_disable_irq(ec_dev);
+	return 0;
+}
 EXPORT_SYMBOL(cros_ec_suspend);
 
 static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
@@ -370,22 +409,11 @@ static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 	}
 }
 
-/**
- * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
- * @ec_dev: Device to resume.
- *
- * This can be called by drivers to handle a resume event.
- *
- * Return: 0 on success or negative error code.
- */
-int cros_ec_resume(struct cros_ec_device *ec_dev)
+static int cros_ec_send_resume_event(struct cros_ec_device *ec_dev)
 {
 	int ret;
 	u8 sleep_event;
 
-	ec_dev->suspended = false;
-	enable_irq(ec_dev->irq);
-
 	sleep_event = (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) ?
 		      HOST_SLEEP_EVENT_S3_RESUME :
 		      HOST_SLEEP_EVENT_S0IX_RESUME;
@@ -394,6 +422,25 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec\n",
 			ret);
+	return 0;
+}
+
+/**
+ * cros_ec_resume_complete() - Handle a resume complete operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume complete stage of resume.
+ */
+void cros_ec_resume_complete(struct cros_ec_device *ec_dev)
+{
+	cros_ec_send_resume_event(ec_dev);
+}
+EXPORT_SYMBOL(cros_ec_resume_complete);
+
+static int cros_ec_enable_irq(struct cros_ec_device *ec_dev)
+{
+	ec_dev->suspended = false;
+	enable_irq(ec_dev->irq);
 
 	if (ec_dev->wake_enabled)
 		disable_irq_wake(ec_dev->irq);
@@ -407,6 +454,35 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 
 	return 0;
 }
+
+/**
+ * cros_ec_resume_early() - Handle a resume early operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume early stage of resume.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_resume_early(struct cros_ec_device *ec_dev)
+{
+	return cros_ec_enable_irq(ec_dev);
+}
+EXPORT_SYMBOL(cros_ec_resume_early);
+
+/**
+ * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume event.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_resume(struct cros_ec_device *ec_dev)
+{
+	cros_ec_enable_irq(ec_dev);
+	cros_ec_send_resume_event(ec_dev);
+	return 0;
+}
 EXPORT_SYMBOL(cros_ec_resume);
 
 #endif
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
index bbca0096868a..566332f48789 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -14,7 +14,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev);
 void cros_ec_unregister(struct cros_ec_device *ec_dev);
 
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
+int cros_ec_suspend_late(struct cros_ec_device *ec_dev);
+int cros_ec_suspend_prepare(struct cros_ec_device *ec_dev);
 int cros_ec_resume(struct cros_ec_device *ec_dev);
+int cros_ec_resume_early(struct cros_ec_device *ec_dev);
+void cros_ec_resume_complete(struct cros_ec_device *ec_dev);
 
 irqreturn_t cros_ec_irq_thread(int irq, void *data);
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 9083a7d58d53..ed498278a223 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -560,22 +560,36 @@ MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
 static int cros_ec_lpc_prepare(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
-
-	return cros_ec_suspend(ec_dev);
+	return cros_ec_suspend_prepare(ec_dev);
 }
 
 static void cros_ec_lpc_complete(struct device *dev)
 {
 	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
-	cros_ec_resume(ec_dev);
+	cros_ec_resume_complete(ec_dev);
+}
+
+static int cros_ec_lpc_suspend_late(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_suspend_late(ec_dev);
+}
+
+static int cros_ec_lpc_resume_early(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_resume_early(ec_dev);
 }
 #endif
 
 static const struct dev_pm_ops cros_ec_lpc_pm_ops = {
 #ifdef CONFIG_PM_SLEEP
 	.prepare = cros_ec_lpc_prepare,
-	.complete = cros_ec_lpc_complete
+	.complete = cros_ec_lpc_complete,
 #endif
+	SET_LATE_SYSTEM_SLEEP_PM_OPS(cros_ec_lpc_suspend_late, cros_ec_lpc_resume_early)
 };
 
 static struct platform_driver cros_ec_lpc_driver = {
-- 
2.42.0.655.g421f12c284-goog

