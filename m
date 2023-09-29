Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77A27B3578
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjI2Oc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjI2OcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3F10EA;
        Fri, 29 Sep 2023 07:32:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a9cd066db5so1980668166b.0;
        Fri, 29 Sep 2023 07:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997938; x=1696602738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZqo0QnMnwdkE02SOtYyzKU82ptFvmGy4+S5Awxqt5k=;
        b=doq8e3a+mFtthrHpSNrMxzm9dsf0BJXXApRFy9dZqlKfi12eyDqa59IGlRxXsFG5VA
         79oyrVkMiIrSLXnUvVmbo066cryXVmJsP9X+0FoxDY28pTfRbUU5eHNpWYAAZIGTbUkD
         7ERTjk5aEvvnhV0yud54etcO+kbnZ/78VNJnn03t95kDfE0JtyMmvXV1G6V2BxEfAe35
         RDIF/KKtjVNJGhahz4/X3YpMdtB4rnWgZFPKotdxnuj1Oarfjt+sx//Uc4Jo3JRAsMcz
         6FG1Nopvl8MCo17li5lvbrRBbqoX4xIuk7Z8quawOhU5dCirWdcBfQliZOUTp689irar
         fh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997938; x=1696602738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZqo0QnMnwdkE02SOtYyzKU82ptFvmGy4+S5Awxqt5k=;
        b=f9uZTL5s7lvMvdHkP5TZTo3NqLu2h16GHXsm8b/MreGgiNIpod7T2S4g/ZBC+8wR/P
         uE/+G5HzY9qBNX9zbAHSdrD4gB0EcmfKoejbl4sot70a6Ci96MzeBwXHmnI2zCOiJc01
         dRUFtHwzGX+YHyr6hNNaOfubeiGjv0MfOcrvCMm4eR7p1FDS5F2r0PVA/GzXVl0o17Q6
         mou2ffqbTEk2fE28Jhn03oNd7myNokqFoM6K9wOJeZXi/xzJe0RrT+kiujY39xwGxjQ/
         nEEDWaMvOfywB63N2ZayPHgf0C6HRL/hF7o32bmWFGWVuRYUu6Z9XUI0Ja7exJUXVF4J
         KxHg==
X-Gm-Message-State: AOJu0Ywk6cEyZiFhSiVCpJ0SBPzIy7Zd66MOZ5QMppOLl7We9XVBNBcT
        YvODkaubhnYwIQvxrentSuxeOPXwZGquG+YcMa0=
X-Google-Smtp-Source: AGHT+IFcb3XDEqU1Cr18wIyKWKeKe2Q0uif+5jzJ9RhMhTdQPqnTZc+Rm1QjB9KA+xCYk70BkuaE8g==
X-Received: by 2002:a17:906:104e:b0:9ad:ef08:1f32 with SMTP id j14-20020a170906104e00b009adef081f32mr4600317ejj.37.1695997937923;
        Fri, 29 Sep 2023 07:32:17 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:17 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 12/14] USB: typec: tps6598x: Add trace for tps25750 irq
Date:   Fri, 29 Sep 2023 10:30:53 -0400
Message-Id: <20230929143055.31360-13-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps25750 event1 register doesn't have all bits in tps6598x
event registers, only show the events that are masked

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v8:
  - No changes
Changes in v7:
  - Add driver name to commit subject
  - Call trace_tps25750_irq directly from tps25750 interrupt
    handler
Changes in v6:
  - Add trace irq to tipd callbacks factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c  |  1 +
 drivers/usb/typec/tipd/trace.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0955ee214eb0..9df8da8f5d4b 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -583,6 +583,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 		dev_err(tps->dev, "%s: failed to read events\n", __func__);
 		goto err_unlock;
 	}
+	trace_tps25750_irq(event[0]);
 
 	if (!(event[0] | event[1]))
 		goto err_unlock;
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 12cad1bde7cc..28725234a2d8 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -74,6 +74,13 @@
 		{ APPLE_CD_REG_INT_DATA_STATUS_UPDATE,		"DATA_STATUS_UPDATE" }, \
 		{ APPLE_CD_REG_INT_STATUS_UPDATE,		"STATUS_UPDATE" })
 
+#define show_tps25750_irq_flags(flags) \
+	__print_flags_u64(flags, "|", \
+		{ TPS_REG_INT_PLUG_EVENT,			"PLUG_EVENT" }, \
+		{ TPS_REG_INT_POWER_STATUS_UPDATE,		"POWER_STATUS_UPDATE" }, \
+		{ TPS_REG_INT_STATUS_UPDATE,			"STATUS_UPDATE" }, \
+		{ TPS_REG_INT_PD_STATUS_UPDATE,			"PD_STATUS_UPDATE" })
+
 #define TPS6598X_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
 						      TPS_STATUS_PP_5V0_SWITCH_MASK | \
 						      TPS_STATUS_PP_HV_SWITCH_MASK | \
@@ -230,6 +237,21 @@ TRACE_EVENT(cd321x_irq,
 		      show_cd321x_irq_flags(__entry->event))
 );
 
+TRACE_EVENT(tps25750_irq,
+	    TP_PROTO(u64 event),
+	    TP_ARGS(event),
+
+	    TP_STRUCT__entry(
+			     __field(u64, event)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->event = event;
+			   ),
+
+	    TP_printk("event=%s", show_tps25750_irq_flags(__entry->event))
+);
+
 TRACE_EVENT(tps6598x_status,
 	    TP_PROTO(u32 status),
 	    TP_ARGS(status),
-- 
2.34.1

