Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2B80BA86
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 12:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjLJLqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 06:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjLJLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 06:46:53 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8540EFF;
        Sun, 10 Dec 2023 03:46:59 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d0a5422c80so30802445ad.3;
        Sun, 10 Dec 2023 03:46:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702208819; x=1702813619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYrj7YLRRwrzGfDcX9P83UR5bzTmRqcF6ZHNEAxJQ20=;
        b=MRZk640CVq3689f3oKKHZvPMh3vGIGcNaJ1b74Wq0FeegfiePX3Gy1aVEYPQWjMLFu
         yHqAciYTEzhZpLm9fXD8d0FS3OW+mUJASpxld4SOInn8eyWdwfrysWd9gTNjstsYpuMy
         YL91PE6s4k9ODtniz0FU58f+KTZBe4LUfy89y02rMbtS0AaBXCNvWS8BwRUB49FSylIF
         pao9JYF3sjk5uvMwvkbRorNUpp+ZJuVvUyat9mXPyiUUK0nTiAgAx8kLRyVsP2GC8lMS
         8OQsw799wqSqeXCWkC1RNwmwB63ce5f+WvzXj2XxQEFRWLhvzatpLn86Pt57CziORdG6
         wYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702208819; x=1702813619;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cYrj7YLRRwrzGfDcX9P83UR5bzTmRqcF6ZHNEAxJQ20=;
        b=R4EGO5odPEJAVpkRY4YfMdo3Zx6LU+9WtYBYKgk6TG2MC1uGvJaerZ/aXd6TAo0R94
         kwzVtHLiNV8/zGmVQ6zJccPGqMv3iMnA81MtqEXVuzWseA5TVck2DbIJ6ie0E41X8R/w
         ZtxsUDscNigeByhORzYjWsBaziWnbv5h79w6cWyVloGyI/mogSJngb9rvsHOrZH80Dvu
         5KD9nxFyDVk+z+sL4aKR2fKetVrqX6qadmN0RWv9BiZVNObmXr2Xu/UlQKY1P3bUnm+L
         OFxXM+lusbsZxZMF+45IHcpxm2lladXYnVzztxuM5opBKU9LAY/I5Qy4h60QCbbkRYKI
         DCVg==
X-Gm-Message-State: AOJu0YxOiufr9DGoU0W5123B9vs59Gz3CqJS3qK0S/BhDpS6MLzoOEUi
        Z6Kel5HfB1ZpXko31TtvESCjmAQpYM8C3g==
X-Google-Smtp-Source: AGHT+IFS7QyqPm6Ns8xgWm7p3EoE1Dx73/W6mdljlGtKg+rmee/uz0jr1B9J/PKIFEJysWm7TS6oKA==
X-Received: by 2002:a17:903:2311:b0:1cf:c42c:cfbd with SMTP id d17-20020a170903231100b001cfc42ccfbdmr3432116plh.0.1702208818896;
        Sun, 10 Dec 2023 03:46:58 -0800 (PST)
Received: from [192.168.238.123] ([103.208.68.40])
        by smtp.gmail.com with ESMTPSA id gc4-20020a17090b310400b00288622137dfsm6331921pjb.5.2023.12.10.03.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Dec 2023 03:46:58 -0800 (PST)
Message-ID: <881c6ba1-1701-41be-a4ac-81cdca5f0eea@gmail.com>
Date:   Sun, 10 Dec 2023 17:16:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From:   Amitesh Singh <singh.amitesh@gmail.com>
Subject: [PATCH] feat(kernel/pca963x): implement power management
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 From a22dbd7390ce875e81d67f14f05f593d7f03d5c1 Mon Sep 17 00:00:00 2001
From: Amitesh Singh <singh.amitesh@gmail.com>
Date: Fri, 8 Dec 2023 15:08:33 +0530
Subject: [PATCH] feat(kernel/pca963x): implement power management

This implements power management in upstream driver
for pca9633 which enables device sleep and resume
on system-wide sleep/hibernation

Signed-off-by: Amitesh Singh <singh.amitesh@gmail.com>
---
  drivers/leds/leds-pca963x.c | 41 +++++++++++++++++++++++++++++++++++++
  1 file changed, 41 insertions(+)

diff --git a/drivers/leds/leds-pca963x.c b/drivers/leds/leds-pca963x.c
index 47223c850e4b..462f917dc986 100644
--- a/drivers/leds/leds-pca963x.c
+++ b/drivers/leds/leds-pca963x.c
@@ -39,6 +39,7 @@
  #define PCA963X_LED_PWM		0x2	/* Controlled through PWM */
  #define PCA963X_LED_GRP_PWM	0x3	/* Controlled through PWM/GRPPWM */

+#define PCA963X_MODE1_SLEEP     0x04    /* Normal mode or Low Power 
mode, oscillator off */
  #define PCA963X_MODE2_OUTDRV	0x04	/* Open-drain or totem pole */
  #define PCA963X_MODE2_INVRT	0x10	/* Normal or inverted direction */
  #define PCA963X_MODE2_DMBLNK	0x20	/* Enable blinking */
@@ -380,6 +381,45 @@ static int pca963x_register_leds(struct i2c_client 
*client,
  	return ret;
  }

+#ifdef CONFIG_PM
+static int pca963x_suspend(struct device *dev)
+{
+	struct pca963x *chip;
+	u8 reg;
+
+	chip = dev_get_drvdata(dev);
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg | (1 << PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+
+static int pca963x_resume(struct device *dev)
+{
+	struct pca963x *chip;
+	u8 reg;
+
+	chip = dev_get_drvdata(dev);
+
+	reg = i2c_smbus_read_byte_data(chip->client, PCA963X_MODE1);
+	reg = reg & ~(1 << PCA963X_MODE1_SLEEP);
+	i2c_smbus_write_byte_data(chip->client, PCA963X_MODE1, reg);
+
+	return 0;
+}
+
+static const struct dev_pm_ops pca963x_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(pca963x_suspend, pca963x_resume)
+};
+
+#define PCA963X_SMBUS_PMOPS (&pca963x_pmops)
+
+#else
+#define PCA963X_SMBUS_PMOPS NULL
+#endif
+
  static const struct of_device_id of_pca963x_match[] = {
  	{ .compatible = "nxp,pca9632", },
  	{ .compatible = "nxp,pca9633", },
@@ -430,6 +470,7 @@ static struct i2c_driver pca963x_driver = {
  	.driver = {
  		.name	= "leds-pca963x",
  		.of_match_table = of_pca963x_match,
+		.pm = PCA963X_SMBUS_PMOPS
  	},
  	.probe = pca963x_probe,
  	.id_table = pca963x_id,
-- 
2.43.0
