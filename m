Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7867C021E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233826AbjJJRDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjJJRDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:03:31 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2179F8E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:03:27 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3af65455e7cso4251145b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696957406; x=1697562206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H86zckYiqRNxgX1bcNOUJ+zu+Dq30VZLht0/S0yuknQ=;
        b=Tefb6p4VHiGDMBNsRqI6hF+qQ8xANWyrg41wYFTY4/kIz8cgkkDmjyTVI5hrxmay2c
         fZ2o3LK6lWYFQS0OkOp/FSS2Zqcw8UIeLjKKbcND9Y8eVViSNBfwqwV/+I7GyGtKq6F8
         QgmYAmvTwR0sKKDUdZ8pS4fARIBEcdMUHfngM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696957406; x=1697562206;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H86zckYiqRNxgX1bcNOUJ+zu+Dq30VZLht0/S0yuknQ=;
        b=blcta27lGgLYzEMIXynfHBZqAujh2v+q8eJ5ZvTFjES/OtiwUAYt0X3KJN9oLBwiNe
         svCTsn58UWwJtYNTKZdlX/Aluioz1wWTiuMFkQvUm64gXR07IcaIarWtdxxO0SbiYwZC
         XfIdV+EWItmE6wKdtAq0PVWJC/AC2puUcKM428yDhVIeFRzfOBFs5Yx8RA2TUdviKpEN
         VGeZYulrkTfkHBGnBrKiyDecC/d7/Omzbb/WLL2mAwmu/FXjcVqjMoJD1VOWZlur+Cbo
         6/dGRvX8N1ZAbOf0/euLCWsCxFL8gfNR2cs9mwQIccCw3KxXFLzAI543HEeqVRwcFehG
         PN7A==
X-Gm-Message-State: AOJu0YyRAI3f23R0/OKSIzntTwVYs1zx4LSy4lj/lBtNVbCazCrshCyd
        o3Fr/QT61a/TmIn1XxemGUaPblHM9iNVcpJyJg4=
X-Google-Smtp-Source: AGHT+IFsmpVeeU1U2G3hOUFYUMnOCQCGRncepoE7+Msf9uKlhl033pemtHu446KfUkEk7bvHoXhfnQ==
X-Received: by 2002:a05:6808:2221:b0:3a1:d075:348b with SMTP id bd33-20020a056808222100b003a1d075348bmr23571923oib.59.1696957406268;
        Tue, 10 Oct 2023 10:03:26 -0700 (PDT)
Received: from lalithkraj-glaptop.corp.google.com ([2620:15c:2a:201:8277:241d:6301:89db])
        by smtp.gmail.com with ESMTPSA id d19-20020a05680808f300b003a747ea96a8sm1992190oic.43.2023.10.10.10.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 10:03:26 -0700 (PDT)
From:   Lalith Rajendran <lalithkraj@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lalith Rajendran <lalithkraj@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_lpc: Separate host command and irq disable
Date:   Tue, 10 Oct 2023 12:03:19 -0500
Message-ID: <20231010120319.1.Ifbec35991a2b629b57452d2d9f96d840d152a16f@changeid>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

 drivers/platform/chrome/cros_ec.c     | 90 ++++++++++++++++++++++++---
 drivers/platform/chrome/cros_ec.h     |  4 ++
 drivers/platform/chrome/cros_ec_lpc.c | 21 +++++--
 3 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 2b49155a9b35..6f520c13c0f3 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -317,16 +317,17 @@ EXPORT_SYMBOL(cros_ec_unregister);
 
 #ifdef CONFIG_PM_SLEEP
 /**
- * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
+ * cros_ec_suspend_prepare() - Handle a suspend prepare operation for the ChromeOS EC device.
  * @ec_dev: Device to suspend.
  *
- * This can be called by drivers to handle a suspend event.
+ * This can be called by drivers to handle a suspend prepare stage of suspend.
+ * Drivers should either call cros_ec_supsend or call
+ * cros_ec_suspend_prepare and cros_ec_suspend_late.
  *
  * Return: 0 on success or negative error code.
  */
-int cros_ec_suspend(struct cros_ec_device *ec_dev)
+int cros_ec_suspend_prepare(struct cros_ec_device *ec_dev)
 {
-	struct device *dev = ec_dev->dev;
 	int ret;
 	u8 sleep_event;
 
@@ -338,7 +339,23 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec",
 			ret);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_suspend_prepare);
 
+/**
+ * cros_ec_suspend_late() - Handle a suspend late operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend late stage of suspend.
+ * Drivers should either call cros_ec_supsend or call
+ * cros_ec_suspend_prepare and cros_ec_suspend_late.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_suspend_late(struct cros_ec_device *ec_dev)
+{
+	struct device *dev = ec_dev->dev;
 	if (device_may_wakeup(dev))
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
 
@@ -348,6 +365,24 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	return 0;
 }
+EXPORT_SYMBOL(cros_ec_suspend_late);
+
+/**
+ * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend event.
+ * Drivers should either call cros_ec_supsend or call
+ * cros_ec_suspend_prepare and cros_ec_suspend_late.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_suspend(struct cros_ec_device *ec_dev)
+{
+	cros_ec_suspend_prepare(ec_dev);
+	cros_ec_suspend_late(ec_dev);
+	return 0;
+}
 EXPORT_SYMBOL(cros_ec_suspend);
 
 static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
@@ -365,21 +400,20 @@ static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
 }
 
 /**
- * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
+ * cros_ec_resume() - Handle a resume complete operation for the ChromeOS EC device.
  * @ec_dev: Device to resume.
  *
- * This can be called by drivers to handle a resume event.
+ * This can be called by drivers to handle a resume complete stage of resume.
+ * Drivers should either call cros_ec_resume or call
+ * cros_ec_resume_early and cros_ec_resume_complete.
  *
  * Return: 0 on success or negative error code.
  */
-int cros_ec_resume(struct cros_ec_device *ec_dev)
+int cros_ec_resume_complete(struct cros_ec_device *ec_dev)
 {
 	int ret;
 	u8 sleep_event;
 
-	ec_dev->suspended = false;
-	enable_irq(ec_dev->irq);
-
 	sleep_event = (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) ?
 		      HOST_SLEEP_EVENT_S3_RESUME :
 		      HOST_SLEEP_EVENT_S0IX_RESUME;
@@ -388,6 +422,24 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec",
 			ret);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_resume_complete);
+
+/**
+ * cros_ec_resume_early() - Handle a resume early operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume early stage of resume.
+ * Drivers should either call cros_ec_resume or call
+ * cros_ec_resume_early and cros_ec_resume_complete.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_resume_early(struct cros_ec_device *ec_dev)
+{
+	ec_dev->suspended = false;
+	enable_irq(ec_dev->irq);
 
 	if (ec_dev->wake_enabled) {
 		disable_irq_wake(ec_dev->irq);
@@ -402,6 +454,24 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 
 	return 0;
 }
+EXPORT_SYMBOL(cros_ec_resume_early);
+
+/**
+ * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume event.
+ * Drivers should either call cros_ec_resume or call
+ * cros_ec_resume_early and cros_ec_resume_complete.
+ *
+ * Return: 0 on success or negative error code.
+ */
+int cros_ec_resume(struct cros_ec_device *ec_dev)
+{
+	cros_ec_resume_early(ec_dev);
+	cros_ec_resume_complete(ec_dev);
+	return 0;
+}
 EXPORT_SYMBOL(cros_ec_resume);
 
 #endif
diff --git a/drivers/platform/chrome/cros_ec.h b/drivers/platform/chrome/cros_ec.h
index bbca0096868a..41defaa5e766 100644
--- a/drivers/platform/chrome/cros_ec.h
+++ b/drivers/platform/chrome/cros_ec.h
@@ -14,7 +14,11 @@ int cros_ec_register(struct cros_ec_device *ec_dev);
 void cros_ec_unregister(struct cros_ec_device *ec_dev);
 
 int cros_ec_suspend(struct cros_ec_device *ec_dev);
+int cros_ec_suspend_late(struct cros_ec_device *ec_dev);
+int cros_ec_suspend_prepare(struct cros_ec_device *ec_dev);
 int cros_ec_resume(struct cros_ec_device *ec_dev);
+int cros_ec_resume_early(struct cros_ec_device *ec_dev);
+int cros_ec_resume_complete(struct cros_ec_device *ec_dev);
 
 irqreturn_t cros_ec_irq_thread(int irq, void *data);
 
diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index 8982cf23e514..afb9f7dbb2ba 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -537,22 +537,35 @@ MODULE_DEVICE_TABLE(dmi, cros_ec_lpc_dmi_table);
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
2.42.0.609.gbb76f46606-goog

