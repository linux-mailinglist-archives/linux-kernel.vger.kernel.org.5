Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462907AD148
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjIYHUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjIYHUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:20:17 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0EF3106
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:20:07 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5043a01ee20so6837930e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:20:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695626406; x=1696231206; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxM9GVR4VSyyuE43awaZA1Wf9nkVTXawgZ7CU1WHNlk=;
        b=QHfa9thXAP8hbolUZ3uR7e+tTwQEAdB3+Ym8szSQSFnWqNyxNdIVEydIYtqslqTjmZ
         97+NyqIIVufa5W3hTkTJ/r/JqCnSHqEVSsvHC0UecsVVknupUG6YkZFCKLlt82C4Jsy6
         SWIfzuuVsinAxXydqfYwR+RSphaZQ5JXTFyyECYCM1Kkqs2+92xLcrJmyiTdbovBQ9+g
         /yipWL1c0wbM27DlOE3HgajaSjMbHbrLB2n/2Zs9qC795Q9jCpF7okOhIByWAu1KF3Vd
         sdGyhsqoIxm/AOB08hFSvZlBU4WkrUwZOdKkJQZlzJe2pdK96gxVhLSAIYHEXbpIq8KL
         NIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695626406; x=1696231206;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxM9GVR4VSyyuE43awaZA1Wf9nkVTXawgZ7CU1WHNlk=;
        b=GwD3ddsRrb6uG1/M3+G13eKQ9mlyItZ5RClIqAAWWg1xwK0V6WrFiiSjVfo/+mkDQ3
         TSkz7kiwwjZNepyCd+10kfUcz0Is8tW3DBsjcxgTJds+Bp5p8XMlI33+Rwv4Q31+BfrJ
         GqOB4zTTOY7CjoYmX2IpP6522SmdGcXwDn1era0gIqIBP5BOO288ZEa0N1VzyAgb/zbd
         n049npGalzFtVa2DZTgH8xFLE3CF1S1R9AhBPA+woTDHcHMBk9Pw2Q/Q81iLlqGNGHiC
         8ZxjujUCp/HW7bBBl3lSUtwLOFhAedCSE6QWNnDGdEA1+zhdqHl+EqG7O/E/brOe4f1L
         /Ojg==
X-Gm-Message-State: AOJu0YxhFbzszZyY7y5H0qc3j6UEZUmA731eKSPah2i9lTzDbkfEfqVr
        kP9mQHfQr8pDJI6fMV1j/MpLhF1D1XUAvkMXHIQ=
X-Google-Smtp-Source: AGHT+IH9RYHbsNVG2GTkCHs4fYdFHNC+MasCDWLJCCpp7bAXAoYxyYMpn94cn7HTlmva8cvMQcpUoQ==
X-Received: by 2002:a05:6512:2812:b0:503:1913:ed8e with SMTP id cf18-20020a056512281200b005031913ed8emr5445725lfb.61.1695626405907;
        Mon, 25 Sep 2023 00:20:05 -0700 (PDT)
Received: from [192.168.1.2] (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id b11-20020ac2562b000000b0050096cc3ba1sm1722178lff.255.2023.09.25.00.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 00:20:05 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 25 Sep 2023 09:20:05 +0200
Subject: [PATCH] watchdog: ixp4xx: Make sure restart always works
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230925-ixp4xx-wdt-restart-v1-1-fe2b9b131dbf@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKQ0EWUC/x3MPQqAMAxA4atIZgPaFv+uIg5qU82ikhYtSO9uc
 fyG917wJEwehuIFoZs9n0dGXRaw7vOxEbLNBlUpXfXKIMfLxIiPDSjkwywBbbM41Zle162GHF5
 CjuM/HaeUPpERByZkAAAA
To:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The IXP4xx watchdog in early "A0" silicon is unreliable and
cannot be registered, however for some systems such as the
USRobotics USR8200 the watchdog is the only restart option,
so implement a "dummy" watchdog that can only support restart
in this case.

Fixes: 1aea522809e6 ("watchdog: ixp4xx: Implement restart")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Other solutions like implementing a pure restart notifier
callback catch in the driver is possible, but this method
will minimize the amount of code and reuse infrastructure
in the core.
---
 drivers/watchdog/ixp4xx_wdt.c | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/ixp4xx_wdt.c b/drivers/watchdog/ixp4xx_wdt.c
index 607ce4b8df57..c0bf03125ec8 100644
--- a/drivers/watchdog/ixp4xx_wdt.c
+++ b/drivers/watchdog/ixp4xx_wdt.c
@@ -105,6 +105,25 @@ static const struct watchdog_ops ixp4xx_wdt_ops = {
 	.owner = THIS_MODULE,
 };
 
+/*
+ * The A0 version of the IXP422 had a bug in the watchdog making
+ * is useless, but we still need to use it to restart the system
+ * as it is the only way, so in this special case we register a
+ * "dummy" watchdog that doesn't really work, but will support
+ * the restart operation.
+ */
+static int ixp4xx_wdt_dummy(struct watchdog_device *wdd)
+{
+	return 0;
+}
+
+static const struct watchdog_ops ixp4xx_wdt_restart_only_ops = {
+	.start = ixp4xx_wdt_dummy,
+	.stop = ixp4xx_wdt_dummy,
+	.restart = ixp4xx_wdt_restart,
+	.owner = THIS_MODULE,
+};
+
 static const struct watchdog_info ixp4xx_wdt_info = {
 	.options = WDIOF_KEEPALIVEPING
 		| WDIOF_MAGICCLOSE
@@ -114,14 +133,17 @@ static const struct watchdog_info ixp4xx_wdt_info = {
 
 static int ixp4xx_wdt_probe(struct platform_device *pdev)
 {
+	static const struct watchdog_ops *iwdt_ops;
 	struct device *dev = &pdev->dev;
 	struct ixp4xx_wdt *iwdt;
 	struct clk *clk;
 	int ret;
 
 	if (!(read_cpuid_id() & 0xf) && !cpu_is_ixp46x()) {
-		dev_err(dev, "Rev. A0 IXP42x CPU detected - watchdog disabled\n");
-		return -ENODEV;
+		dev_err(dev, "Rev. A0 IXP42x CPU detected - only restart supported\n");
+		iwdt_ops = &ixp4xx_wdt_restart_only_ops;
+	} else {
+		iwdt_ops = &ixp4xx_wdt_ops;
 	}
 
 	iwdt = devm_kzalloc(dev, sizeof(*iwdt), GFP_KERNEL);
@@ -141,7 +163,7 @@ static int ixp4xx_wdt_probe(struct platform_device *pdev)
 		iwdt->rate = IXP4XX_TIMER_FREQ;
 
 	iwdt->wdd.info = &ixp4xx_wdt_info;
-	iwdt->wdd.ops = &ixp4xx_wdt_ops;
+	iwdt->wdd.ops = iwdt_ops;
 	iwdt->wdd.min_timeout = 1;
 	iwdt->wdd.max_timeout = U32_MAX / iwdt->rate;
 	iwdt->wdd.parent = dev;

---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230924-ixp4xx-wdt-restart-d6bf28493173

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

