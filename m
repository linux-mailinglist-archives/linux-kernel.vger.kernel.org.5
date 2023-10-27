Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912387DA226
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 23:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346485AbjJ0VDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 17:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0VDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 17:03:11 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3E11AA
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:03:08 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6cd1918afb2so1400347a34.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 14:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698440587; x=1699045387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YOMrffz5Be8q59f2n1V56UEGi+uPbGllpV6VpXndKIw=;
        b=TvX8DZdNrb7M7P9EOZaNiHX7C/jDv506BHplrtZryHhKZgVy4soh6EZrDpJlcsasSy
         uv+sojwgwsv2HnMo23IM/VHXj3SI6WBamjrvs6GEbeZMF5re3Nb0NlJ7MFRgy9UTvLv3
         Op6RvjPJOPt/hl8j4cmvUuYvhQlyrNj2tCIqM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698440587; x=1699045387;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YOMrffz5Be8q59f2n1V56UEGi+uPbGllpV6VpXndKIw=;
        b=be0iGnG0qEK0irvM7S6uVmseXpWY01qVANzecFhdFiOxvcuOH4hqficRrt0V8L3Iw/
         5V/kBKPS1iKC6QdUGpY+h8QtvvqvNTE63hTiunfYRLLPpNpqkid6NCCkX0ZG8Expii2H
         H3KPoqlP99XPNoaraRDzfs/VYAfG1ZZDka4sIrPDS1L7TGwRatvAvvPLksfdxHJhnQjE
         GNAIgnATKb2dOdI30/N7mrOvZt6s1ETDYVWCp273FfbPFAL6PGAC6rKCOlTqK/UbXCN8
         /RQ/SyxH+Q0dD4ZXBdOloKlZdPrIeSF+zDeDnHg+GckIggr6piPiYTDp+b+atcNuoHkL
         9xnw==
X-Gm-Message-State: AOJu0YzobO4HZ5GdKhWM1e/A8jauL1gNv3TuBgeYTaJpwcPwdMwAi6sL
        qy1qJZfq9qvM82A1VPCsLK6ixqkf6H1VwoW2K0Q=
X-Google-Smtp-Source: AGHT+IEQYsrkU3VaWUeexAHIow1udxvl5BxT66a8hnZY6T1cg9DddX3oIPZXQRYuLDnb/D/DxCsk3A==
X-Received: by 2002:a05:6830:1bc2:b0:6cc:dbe8:b861 with SMTP id v2-20020a0568301bc200b006ccdbe8b861mr3920297ota.22.1698440587546;
        Fri, 27 Oct 2023 14:03:07 -0700 (PDT)
Received: from lalithkraj-glaptop.roam.corp.google.com ([24.28.107.251])
        by smtp.gmail.com with ESMTPSA id z10-20020a4a984a000000b00581fedcb06csm534626ooi.19.2023.10.27.14.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 14:03:07 -0700 (PDT)
From:   Lalith Rajendran <lalithkraj@chromium.org>
X-Google-Original-From: Lalith Rajendran <lalithkraj@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Lalith Rajendran <lalithkraj@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Tim Van Patten <timvp@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v4] platform/chrome: cros_ec_lpc: Separate host command and irq disable
Date:   Fri, 27 Oct 2023 16:02:22 -0500
Message-ID: <20231027160221.v4.1.I1725c3ed27eb7cd9836904e49e8bfa9fb0200a97@changeid>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
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

From: Lalith Rajendran <lalithkraj@chromium.org>

Both cros host command and irq disable were moved to suspend
prepare stage from late suspend recently. This is causing EC
to report MKBP event timeouts during suspend stress testing.
When the MKBP event timeouts happen during suspend, subsequent
wakeup of AP by EC using MKBP doesn't happen properly. Move the
irq disabling part back to late suspend stage which is a general
suggestion from the suspend kernel documentaiton to do irq
disable as late as possible.

Fixes: 4b9abbc132b8 ("platform/chrome: cros_ec_lpc: Move host command to prepare/complete")
Signed-off-by: Lalith Rajendran <lalithkraj@chromium.org>
---

Changes in v4:
- applied maintainer feedback from https://patchwork.kernel.org/project/
chrome-platform/patch/20231024105820.v3.1.Icccaed152371dbab868295a6c83d257e8409
cf2d@changeid/#25569045

Changes in v3:
- Replace commit message s/Although there ... this change move/\nMove/.

Changes in v2:
- applied maintainer feedback from https://patchwork.kernel.org/project/
chrome-platform/patch/20231017124047.1.Icc99145043c8d44142bb5ca64ea4c63a417c267b
@changeid/#25558414

 drivers/platform/chrome/cros_ec.c     | 116 +++++++++++++++++++++-----
 drivers/platform/chrome/cros_ec.h     |   4 +
 drivers/platform/chrome/cros_ec_lpc.c |  22 ++++-
 3 files changed, 116 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 5d36fbc75e1b..badc68bbae8c 100644
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
+static void cros_ec_send_suspend_event(struct cros_ec_device *ec_dev)
 {
-	struct device *dev = ec_dev->dev;
 	int ret;
 	u8 sleep_event;
 
@@ -343,7 +334,26 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending suspend event to ec\n",
 			ret);
+}
 
+/**
+ * cros_ec_suspend_prepare() - Handle a suspend prepare operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend prepare stage of suspend.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_suspend_prepare(struct cros_ec_device *ec_dev)
+{
+	cros_ec_send_suspend_event(ec_dev);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_suspend_prepare);
+
+static void cros_ec_disable_irq(struct cros_ec_device *ec_dev)
+{
+	struct device *dev = ec_dev->dev;
 	if (device_may_wakeup(dev))
 		ec_dev->wake_enabled = !enable_irq_wake(ec_dev->irq);
 	else
@@ -351,7 +361,35 @@ int cros_ec_suspend(struct cros_ec_device *ec_dev)
 
 	disable_irq(ec_dev->irq);
 	ec_dev->suspended = true;
+}
 
+/**
+ * cros_ec_suspend_late() - Handle a suspend late operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend late stage of suspend.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_suspend_late(struct cros_ec_device *ec_dev)
+{
+	cros_ec_disable_irq(ec_dev);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_suspend_late);
+
+/**
+ * cros_ec_suspend() - Handle a suspend operation for the ChromeOS EC device.
+ * @ec_dev: Device to suspend.
+ *
+ * This can be called by drivers to handle a suspend event.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_suspend(struct cros_ec_device *ec_dev)
+{
+	cros_ec_send_suspend_event(ec_dev);
+	cros_ec_disable_irq(ec_dev);
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_suspend);
@@ -370,22 +408,11 @@ static void cros_ec_report_events_during_suspend(struct cros_ec_device *ec_dev)
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
+static void cros_ec_send_resume_event(struct cros_ec_device *ec_dev)
 {
 	int ret;
 	u8 sleep_event;
 
-	ec_dev->suspended = false;
-	enable_irq(ec_dev->irq);
-
 	sleep_event = (!IS_ENABLED(CONFIG_ACPI) || pm_suspend_via_firmware()) ?
 		      HOST_SLEEP_EVENT_S3_RESUME :
 		      HOST_SLEEP_EVENT_S0IX_RESUME;
@@ -394,6 +421,24 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 	if (ret < 0)
 		dev_dbg(ec_dev->dev, "Error %d sending resume event to ec\n",
 			ret);
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
+static void cros_ec_enable_irq(struct cros_ec_device *ec_dev)
+{
+	ec_dev->suspended = false;
+	enable_irq(ec_dev->irq);
 
 	if (ec_dev->wake_enabled)
 		disable_irq_wake(ec_dev->irq);
@@ -403,8 +448,35 @@ int cros_ec_resume(struct cros_ec_device *ec_dev)
 	 * suspend. This way the clients know what to do with them.
 	 */
 	cros_ec_report_events_during_suspend(ec_dev);
+}
 
+/**
+ * cros_ec_resume_early() - Handle a resume early operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume early stage of resume.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_resume_early(struct cros_ec_device *ec_dev)
+{
+	cros_ec_enable_irq(ec_dev);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_resume_early);
 
+/**
+ * cros_ec_resume() - Handle a resume operation for the ChromeOS EC device.
+ * @ec_dev: Device to resume.
+ *
+ * This can be called by drivers to handle a resume event.
+ *
+ * Return: 0 always.
+ */
+int cros_ec_resume(struct cros_ec_device *ec_dev)
+{
+	cros_ec_enable_irq(ec_dev);
+	cros_ec_send_resume_event(ec_dev);
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_resume);
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
2.42.0.820.g83a721a137-goog

