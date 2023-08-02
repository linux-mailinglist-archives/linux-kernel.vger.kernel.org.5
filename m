Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7792E76D7CC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232853AbjHBTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbjHBTcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:32:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9532A26AF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 12:32:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso2002835e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 12:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1691004729; x=1691609529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EsAms/GBsK+1iUec9cOrJls/H2UjnYhAk3txEAwGRk=;
        b=edwj5ZoJK2mDlEgtJqkJ/LdE4dco1cDR22RFFEgaEqH2xEWa3vDgeZwwqHuKfynDWd
         CZMBcVzj5hq3971PzjjYTe5iENmfw2OIvTTDTG/GH/u5iRxOj1lxrK2ncXbUXt1AjBZ7
         plKxrLw4l5wbr9CNds67+T2rgRLlDNGkonef3XHU6Ipn02jIheM4hPU1cV0B5Kzp4kAj
         BG+fMx+7e7Lliiw425s8H4zC4cXN98DNhlfe7oeZqyiRUrUesc8Y37ercCaGEYSVHmwy
         zOdSoNNnxxXROw1SZ4QI2SAQGJDS1sTh554bVaWFKbyN5DrlqfcqqDuLTPGaaJ/k6MML
         kHMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691004729; x=1691609529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EsAms/GBsK+1iUec9cOrJls/H2UjnYhAk3txEAwGRk=;
        b=B5p/khs+sH/0tkSCUxhOkP3+ihsbCIfkHPQHn6VSIgfX/O5SWfvTM2kwx7vh2gPti3
         3oIR1BfjP/dUoXP+3OKQXmkYld3/HGD2WMgq7rEU6RL9hounj2eE7rImAEyD0RbZbM95
         C/6pt52sJiFdQ8tTf+4XBhFy8Dcnjzbz3cjeLC/p+UKg7YraPLoNSZ+m0SAIaPD55x1a
         XMBiGxPcQVoS+8kF2PhWfD4/Y6taZT3PE1VSwzsacMFIbOEe1QGtAub5xaTHI3uCyoFq
         7HfF8gANsdn64EBMCDEOxcXeoQqsmUTf/qQYMieV9bGDfDVr4AZj64snG4Fb42YjHV+9
         zxnw==
X-Gm-Message-State: ABy/qLY6hdAzxFuwYq8LfE0cTSSzbjvsPuS/waF0vV6E2SB1JhomF3AV
        WJyR1WuKko3o1WM+TUg/+UNWwA==
X-Google-Smtp-Source: APBJJlFrzwhE0MkELPlXRviUaVTxXRhZlYtI8u2+lwHL+P64bvSFC3r5bDcFmn24dcR1JFVEtCF0GA==
X-Received: by 2002:a7b:cc8c:0:b0:3fe:159d:422b with SMTP id p12-20020a7bcc8c000000b003fe159d422bmr5475260wma.32.1691004729038;
        Wed, 02 Aug 2023 12:32:09 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d43d2000000b003177074f830sm19666773wrr.59.2023.08.02.12.32.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 12:32:08 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] hwmon: (pmbus) Add ON_OFF_CONFIG register bits
Date:   Wed,  2 Aug 2023 21:31:52 +0200
Message-ID: <20230802193155.2170935-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
References: <20230802193155.2170935-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

Add bits found in the ON_OFF_CONFIG register.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/hwmon/pmbus/pmbus.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
index b0832a4c690d..7a28bac7f171 100644
--- a/drivers/hwmon/pmbus/pmbus.h
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -243,6 +243,15 @@ enum pmbus_regs {
  */
 #define PB_OPERATION_CONTROL_ON		BIT(7)
 
+/*
+ * ON_OFF_CONFIG
+ */
+#define PB_ON_OFF_CONFIG_POWERUP_CONTROL	BIT(4)
+#define PB_ON_OFF_CONFIG_OPERATION_REQ		BIT(3)
+#define PB_ON_OFF_CONFIG_EN_PIN_REQ		BIT(2)
+#define PB_ON_OFF_CONFIG_POLARITY_HIGH		BIT(1)
+#define PB_ON_OFF_CONFIG_TURN_OFF_FAST		BIT(0)
+
 /*
  * WRITE_PROTECT
  */
-- 
2.41.0

