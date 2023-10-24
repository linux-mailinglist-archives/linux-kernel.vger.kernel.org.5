Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5DE7D57BF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjJXQPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344022AbjJXP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:58:53 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC8010E7
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:58:50 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1e10507a4d6so3364841fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698163129; x=1698767929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2h3Pr99/wr+elIZYIboeXZV4Sf7vm+Md0LWnpo9m7D4=;
        b=V+5hVwrMlIcIt9zWF/kHWHC405nMKDngIWY1HV4lSyC7Qmmsf7Fy5pnKhpPh6lOOEE
         fy1svPRM1kQl17yisgUrjTIr8CDLtgtMp1tUwDVdojhbVCYkzSMXQyf1Q5TW+CbnpWhs
         sJgchG4PlI112ekQWrjQfBhMMOTPJGySEw8cU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698163129; x=1698767929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2h3Pr99/wr+elIZYIboeXZV4Sf7vm+Md0LWnpo9m7D4=;
        b=s1pOSES6xRnkRBUChF1+KmRoxf4P04XPBg7ljgf9vCgsX3KByDjYTj5HOj6gy3B1jL
         KRxTYVPcha4/dftssxRzmqQ7Ovp9SPxl73nUTYcV7Od+yTBtYWSNxIlPJdp0MzisBRYt
         IBB5kUXcYb94moIfyfnKdIR6nowDHhZJtZES+TBneX1ghnroHCN1BXZfwTRtXjnyDFo2
         vFCFGFoOAlpsaqEFPNs9m21g9gNtoDJjIF6hsPMQ0KsV3eCHCTvR0L+dMVBLFEnD7KFA
         PR81X5FCOtS0rZfInEWWUhPbcGfmkS7XnooqgQwF4ZG7l8ki/eIS7B8UmJNxjLZYx4LQ
         KNWg==
X-Gm-Message-State: AOJu0YxhZGvL7zxmPneBIIA2mwuTxX5EMADyhta9w94E/0ILzfI2mkn/
        b0Sm/s6CKxCjvvU1RWoQur+BEBEiNsCPNcTb348=
X-Google-Smtp-Source: AGHT+IFreDcORcG+8B2F6MuWAG0pjfNTXfDb+IiQaEV8LArvld9y9K0AMVGQBqwBzbDVlzTbWn4YVg==
X-Received: by 2002:a05:6870:3d9b:b0:1e9:919d:83ec with SMTP id lm27-20020a0568703d9b00b001e9919d83ecmr16573165oab.28.1698163128949;
        Tue, 24 Oct 2023 08:58:48 -0700 (PDT)
Received: from lalithkraj-glaptop.corp.google.com ([2620:15c:2a:201:ab6e:39db:e561:4a0f])
        by smtp.gmail.com with ESMTPSA id zh10-20020a0568716b8a00b001dcde628a6fsm2174332oab.42.2023.10.24.08.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 08:58:48 -0700 (PDT)
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
Subject: [PATCH v3] platform/chrome: cros_ec_lpc: Separate host command and irq disable
Date:   Tue, 24 Oct 2023 10:58:21 -0500
Message-ID: <20231024105820.v3.1.Icccaed152371dbab868295a6c83d257e8409cf2d@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
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

Changes in v3:
- Replace commit message s/Although there ... this change move/\nMove/.

Changes in v2:
- applied mainter feedback from https://patchwork.kernel.org/project/
chrome-platform/patch/20231017124047.1.Icc99145043c8d44142bb5ca64ea4c63a417c267b
@changeid/#25558414

 drivers/platform/chrome/cros_ec.c     | 116 +++++++++++++++++++++-----
 drivers/platform/chrome/cros_ec.h     |   4 +
 drivers/platform/chrome/cros_ec_lpc.c |  22 ++++-
 3 files changed, 116 insertions(+), 26 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index 5d36fbc75e1b..ff85f7507060 100644
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
+ * Return: 0 on success or negative error code.
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
+	cros_ec_disable_irq(ec_dev);
+	return 0;
+}
+EXPORT_SYMBOL(cros_ec_suspend_late);
 
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
+ * Return: 0 on success or negative error code.
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
+ * Return: 0 on success or negative error code.
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
2.42.0.758.gaed0368e0e-goog

