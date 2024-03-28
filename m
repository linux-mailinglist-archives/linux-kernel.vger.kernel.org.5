Return-Path: <linux-kernel+bounces-122854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54AA188FE76
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE0A0B2166C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEC97E792;
	Thu, 28 Mar 2024 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U4+g4GQd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6845474B;
	Thu, 28 Mar 2024 11:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627154; cv=none; b=ef8gQl2lX/mfkNx1Xreq5fFIw8SJhWw2eePvJn3bB1FqiKn6aq6/vcp5NpjlTb53Xwzf/bLWtEcQLG2LOxP6skco2D1A67ensugGFnKX4odIZSIZSXamawx+/R4jJcyE5y6NvzUn3jKzAPbDcNdKC1AcpC90cl8iQscIpLBGyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627154; c=relaxed/simple;
	bh=9nsT8fHj6sfhBsSfZYt5q8FpfT54bgl+bVhOjsgfDiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mu5Ym9ugPUqRa+bQHqQ+l0+p9bsNnV50JQ+4UFhqUeY3UTGNaEJtpGJvdzWf4tsgefVT8/hccDbkh1e1RddcR2CwfDV9847qUPB/vOKevmliF6huQWnKMLTu7c3PRECbMVitjcjQfjMjAICxLB7BhtcFuF1Y2VhFeoh0S0WMbz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U4+g4GQd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7ECC433F1;
	Thu, 28 Mar 2024 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711627154;
	bh=9nsT8fHj6sfhBsSfZYt5q8FpfT54bgl+bVhOjsgfDiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U4+g4GQdOI6JToTQkRHWdWTqomcGll7yLt+UMv38d5WYMs7CYWMlXSGWwWS+GXRWn
	 E8rNGB2bF5M6qZeTCO962l/Gu8iv/sp0pxla4/rG5uA/oNrmQo8f6d+8PldC6mVSke
	 goJdaRrlpo305xugrT+1jCSmim3dZtZivhEyBEX0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: lee@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 2/2] video: backlight: lcd: make lcd_class constant
Date: Thu, 28 Mar 2024 12:59:07 +0100
Message-ID: <2024032809-enchanted-conducive-3677@gregkh>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <2024032805-putdown-mushy-a0f9@gregkh>
References: <2024032805-putdown-mushy-a0f9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 79
X-Developer-Signature: v=1; a=openpgp-sha256; l=2535; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=yCsQQAr22nUmFXlA9JkgS4sO+euLEjucK5Uqyl8x3Co=; b=owGbwMvMwCRo6H6F97bub03G02pJDGms0b2bl367zNNasmV5Vp74ykaFDXN3nwrnmXJCq/RL3 iH/kNo1HbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARiwaGeer+U79vdj98eRl7 jsrWsiL3d57bFzIsWOcevdJ+kufkX1N47hx/1/LLXfduHQA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the lcd_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Ricardo B. Marliere" <ricardo@marliere.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebased on 6.9-rc1

 drivers/video/backlight/lcd.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/lcd.c b/drivers/video/backlight/lcd.c
index 77c5cb2a44e2..ba4771cbd781 100644
--- a/drivers/video/backlight/lcd.c
+++ b/drivers/video/backlight/lcd.c
@@ -159,8 +159,6 @@ static ssize_t max_contrast_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(max_contrast);
 
-static struct class *lcd_class;
-
 static void lcd_device_release(struct device *dev)
 {
 	struct lcd_device *ld = to_lcd_device(dev);
@@ -175,6 +173,11 @@ static struct attribute *lcd_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(lcd_device);
 
+static const struct class lcd_class = {
+	.name = "lcd",
+	.dev_groups = lcd_device_groups,
+};
+
 /**
  * lcd_device_register - register a new object of lcd_device class.
  * @name: the name of the new object(must be the same as the name of the
@@ -202,7 +205,7 @@ struct lcd_device *lcd_device_register(const char *name, struct device *parent,
 	mutex_init(&new_ld->ops_lock);
 	mutex_init(&new_ld->update_lock);
 
-	new_ld->dev.class = lcd_class;
+	new_ld->dev.class = &lcd_class;
 	new_ld->dev.parent = parent;
 	new_ld->dev.release = lcd_device_release;
 	dev_set_name(&new_ld->dev, "%s", name);
@@ -318,19 +321,19 @@ EXPORT_SYMBOL(devm_lcd_device_unregister);
 
 static void __exit lcd_class_exit(void)
 {
-	class_destroy(lcd_class);
+	class_unregister(&lcd_class);
 }
 
 static int __init lcd_class_init(void)
 {
-	lcd_class = class_create("lcd");
-	if (IS_ERR(lcd_class)) {
-		pr_warn("Unable to create backlight class; errno = %ld\n",
-			PTR_ERR(lcd_class));
-		return PTR_ERR(lcd_class);
+	int ret;
+
+	ret = class_register(&lcd_class);
+	if (ret) {
+		pr_warn("Unable to create backlight class; errno = %d\n", ret);
+		return ret;
 	}
 
-	lcd_class->dev_groups = lcd_device_groups;
 	return 0;
 }
 
-- 
2.44.0


