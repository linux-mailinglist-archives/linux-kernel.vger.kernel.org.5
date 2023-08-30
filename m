Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD6078DEE5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242315AbjH3TLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243285AbjH3Kge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:36:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B781BE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:36:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-99bfcf4c814so709322466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1693391789; x=1693996589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EsAms/GBsK+1iUec9cOrJls/H2UjnYhAk3txEAwGRk=;
        b=IFqN6fcI14SmKLJbSqFU0GfgHP50LPqgXXuffoVNziQ9/tGlC/oEJNsoinbrhqL+oF
         iWEWFt8q/rmG6SwQUv7tqoCuHbuoQUG3JEvDHZx25oAdZEvdPhPkrBbrSJTJ5OL8U6Mn
         q6vSq+0j2N2F2Y2W5wzbVW25oml7jO0nyUFd9Q5ovY3VfYLRtCGDqloWeML+oMyncBJP
         J+KbTxJGn2MYs2K5l0zk4cfJPcPv7XcsDPx/dc0Z62pdpcLB5oH+POO275XQDigET+kA
         idpT7jbrsgp15SpUMQrMp2KQ/PF0mrq2P5wCEqwytiF5gFNcEpK2ldFoTATmAyNMfC/+
         Raew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391789; x=1693996589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EsAms/GBsK+1iUec9cOrJls/H2UjnYhAk3txEAwGRk=;
        b=XqOzQ08yAc77LlW1OtYJuFz71GvwH8HZjlHLIGoOygPHvICjQFZGqJnda/wx2O15/X
         8gWTnMvhn2u5y3f1PLST6aic3XRsjgWW5zTggM185oylLSgf1xjAajXQRcPv+7YaDgFa
         PJQVryI4sQeH8JxxYneD6k834eXRuI/qIeYPSEd20Zaiq3LJ2SstoUkUGX4/S85H6jPh
         h72RNGTZHEsuhh00fSBbaom60jwk1IRZ5KrQ7lMKpx49V/jN3bp+Wnkbyjrjl9GHHmKu
         2Qt2njoA1lDEkvVOdkTIrFLT8qbprSeIr21W2WYi5q/kQssIS7aCJ53DWRLuCmeKHLVq
         fVUw==
X-Gm-Message-State: AOJu0Yzqa79uCysVsoNiPwL5miA3H3dKApTyBnSyJh7jBG5PXk/hs5zu
        psb+L7z8Nzdn8deD8gBTJf5DPw==
X-Google-Smtp-Source: AGHT+IE/SnSPHAg/GcOvam5TY1r6/qYU5l+HI0OuRJBzs+e9T7fHkMR8XLJCwn4a61EDkKh4aQ7CKw==
X-Received: by 2002:a17:906:10ca:b0:9a1:f426:bba9 with SMTP id v10-20020a17090610ca00b009a1f426bba9mr1298905ejv.74.1693391789587;
        Wed, 30 Aug 2023 03:36:29 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id s11-20020a170906354b00b00992bea2e9d2sm7027620eja.62.2023.08.30.03.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 03:36:29 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] hwmon: (pmbus) Add ON_OFF_CONFIG register bits
Date:   Wed, 30 Aug 2023 12:36:17 +0200
Message-ID: <20230830103620.3611761-2-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
References: <20230830103620.3611761-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

