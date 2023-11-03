Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C74E7E0202
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 12:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346562AbjKCKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346544AbjKCKbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 06:31:51 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9CE187
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 03:31:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4083f613272so16673655e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Nov 2023 03:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1699007503; x=1699612303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KB8BFBrWt5cdMdMUbKVX9KzIODIdRsQC4ffz0FV6Nlo=;
        b=BQbOkBG5D8xC+rLBl6HS8V3sz+zcI7nYraK5NTOLXsfQTQ5G5+EtV36rDrI2uNWyOY
         ttm/uc26mGXdYBXIsdg+/7TSakBnOXfkbFjdlbOkredpDBFlqtG/qLcXeauoHXVpKCWt
         LGsonDmJhaUD6P7tDtY+bZWq7AXAWET/In2uF7f/M+AOXZRugrUm5ST2jmj7920mEJpJ
         ckYkI2zR0qolIKrbFdweslOjk5E3GujlVGvAr6cZ0JwwfiVp4mKsEWpcWqqdF+pOZYeY
         0D1V8UG+hLw9q46odRV6SZ+O6IlN7f2bBKKvGq1gDToRdVsC1axK1JUH1dD9Aqs1tj0e
         Z/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699007503; x=1699612303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KB8BFBrWt5cdMdMUbKVX9KzIODIdRsQC4ffz0FV6Nlo=;
        b=Us1dDiMzlacnH1j1bi5x1msseRW/Qa+EQM/LkKLp1XQPYxgo8Sn+tTIST5fK+Bxe+E
         6Z/xO9rwAUcNzmFKVAz6yMXouH0BgL0rsF++zy4kYE15Sad19cTeGtRgXZ1neoNTuM6s
         iTx8C8ak45OPHxCYc8Jvo8lrhUfLCo1xMwTfF09kioQ45sS2xgUeidyr6xZO4ZhLSYGx
         h6dpMHikdCNMnI+7aRMRaOiyhAHHDqO3f4y6y8kRrzk+7Da3lB+1wBv6KuJepGw6b7FW
         NeZfUytbld4p4eHBvlhcL28lzY4duRz8FeRCmWGTsCM1Rr5mZXZUFtrYkYPyxHyzZpfD
         F45Q==
X-Gm-Message-State: AOJu0Yzax0AeKA3tgrJFL+HzJ+PXBEMer88xBSspM3EHcC30+gTdBdHO
        G2CWAKO6lRiZ+wAImgGIG8iV7HClNVJ4lPIrPL/1Lg==
X-Google-Smtp-Source: AGHT+IEIlB2E3hb2daCNNGhpAtJIEYOq+xWyQtc40nSeuD54pfR8jsdJ3zTJksQ7asKTBUpW7gelFQ==
X-Received: by 2002:adf:f390:0:b0:32d:a98c:aa1f with SMTP id m16-20020adff390000000b0032da98caa1fmr15069898wro.1.1699007503174;
        Fri, 03 Nov 2023 03:31:43 -0700 (PDT)
Received: from zbox.lab.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h17-20020adff4d1000000b0031c52e81490sm1511297wrp.72.2023.11.03.03.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 03:31:42 -0700 (PDT)
From:   Alexander Hansen <alexander.hansen@9elements.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
Cc:     Loic Prylli <lprylli@netflix.com>,
        Alexander Hansen <alexander.hansen@9elements.com>,
        linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] hwmon: (aspeed-pwm-tacho) mutex for tach reading
Date:   Fri,  3 Nov 2023 11:30:55 +0100
Message-ID: <121d888762a1232ef403cf35230ccf7b3887083a.1699007401.git.alexander.hansen@9elements.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Prylli <lprylli@netflix.com>

the ASPEED_PTCR_RESULT Register can only hold the result for a
single fan input. Adding a mutex to protect the register until the
reading is done.

Signed-off-by: Loic Prylli <lprylli@netflix.com>
Signed-off-by: Alexander Hansen <alexander.hansen@9elements.com>
---
 drivers/hwmon/aspeed-pwm-tacho.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwmon/aspeed-pwm-tacho.c b/drivers/hwmon/aspeed-pwm-tacho.c
index 997df4b40509..b2ae2176f11f 100644
--- a/drivers/hwmon/aspeed-pwm-tacho.c
+++ b/drivers/hwmon/aspeed-pwm-tacho.c
@@ -193,6 +193,8 @@ struct aspeed_pwm_tacho_data {
 	u8 fan_tach_ch_source[16];
 	struct aspeed_cooling_device *cdev[8];
 	const struct attribute_group *groups[3];
+	/* protects access to shared ASPEED_PTCR_RESULT */
+	struct mutex tach_lock;
 };
 
 enum type { TYPEM, TYPEN, TYPEO };
@@ -527,6 +529,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 	u8 fan_tach_ch_source, type, mode, both;
 	int ret;
 
+	mutex_lock(&priv->tach_lock);
+
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0);
 	regmap_write(priv->regmap, ASPEED_PTCR_TRIGGER, 0x1 << fan_tach_ch);
 
@@ -544,6 +548,8 @@ static int aspeed_get_fan_tach_ch_rpm(struct aspeed_pwm_tacho_data *priv,
 		ASPEED_RPM_STATUS_SLEEP_USEC,
 		usec);
 
+	mutex_unlock(&priv->tach_lock);
+
 	/* return -ETIMEDOUT if we didn't get an answer. */
 	if (ret)
 		return ret;
@@ -903,6 +909,7 @@ static int aspeed_pwm_tacho_probe(struct platform_device *pdev)
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
+	mutex_init(&priv->tach_lock);
 	priv->regmap = devm_regmap_init(dev, NULL, (__force void *)regs,
 			&aspeed_pwm_tacho_regmap_config);
 	if (IS_ERR(priv->regmap))
-- 
2.42.0

