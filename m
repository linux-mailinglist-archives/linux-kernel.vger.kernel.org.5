Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DAE87ABE8D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjIWHl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjIWHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:41:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE29E77;
        Sat, 23 Sep 2023 00:41:00 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-32172a50356so3224038f8f.0;
        Sat, 23 Sep 2023 00:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454859; x=1696059659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaysGuHoAkH6vVtvr388xi78nn8N9gJSrosG9zrGXMo=;
        b=L7FTCx2Xu91JCtlPcHBzgYUaGwsD7cnv87IirWu5C0fnyo+QznLHcmve6jprOTLeZD
         /bQdqY/wDdPDQYPjgy9xpqSy+DPHr/aNHuyezvrOix1c0AVrSvkjdwm/3Xaje0IbOziU
         y9t9lEZJ3B5DViXCHrmCQOr1PP8EVB8F5V1ZBuJErMnfXmnP1SKn46II2kIcX56ouOK0
         y++59Xr/FYOJlnAAL7fHccqU3xFNugMTZKhQyMErkhX7EPLRnCQCRyLqTEhrMy7DA/32
         D04d6+dotaN/MjUoXXjw8QpqMmRhruqZsb6twa0wd9nBm/YdrZchmgnF94O+q/SaPKe0
         rb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454859; x=1696059659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaysGuHoAkH6vVtvr388xi78nn8N9gJSrosG9zrGXMo=;
        b=Frysx5kt/f/G9D/zZ2KRjO1GE0vzbVjwHFt2x34/Ir2eGUOJ2E13c6mu6wg/Vf0/gA
         mDOdQydTQt4gVMMaMhKQttEqnjRRNsFZqlS26ut5DrIBnrvJz3yl9Zc23sdendqgLqq6
         YLxsPyHDpHtMFlnBBwFfflASsiMmuqzA6j4fxQC+nyKJsQjpS362YTMFxzydnrxbEcvG
         o9uwdHOZvFL/Vh2flU9A/tp5zbM0Dt+HyhsN3d+sFtBfdzY85UKLv+ycVSaWQ8fQzULP
         5A+jk9yCkkhPKd8lngfKlI57/QrY0acK0O3mWx2EtdmzQc2GUkE14IlMnpl+V3FGZRR9
         Yszw==
X-Gm-Message-State: AOJu0YzjsgzSmHCGh9FcpihuysAOsIoU51io+kyWg+yqGrhxCpbWzwp7
        JlSGDl0M1c0bEHiJklzzylRTlq4oQv8MZEsO6mw=
X-Google-Smtp-Source: AGHT+IG2ZT9zZmdbCyCWqUVb/HGinMiwM4q90Z65SKsW6vASIWjDGLv+oRF+bB7vlggV6o6lplUh2g==
X-Received: by 2002:a5d:6a0f:0:b0:321:71ae:736c with SMTP id m15-20020a5d6a0f000000b0032171ae736cmr1443656wru.7.1695454859006;
        Sat, 23 Sep 2023 00:40:59 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:58 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 14/14] USB: typec: Add status trace for tps25750
Date:   Sat, 23 Sep 2023 03:39:59 -0400
Message-Id: <20230923073959.86660-15-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps25750 status register is a subset of tps6598x status register, hence
a trace for tps25750 status register is added.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
 - Add trace status to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c  | 12 +++++++----
 drivers/usb/typec/tipd/trace.h | 37 ++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index e8190f1f57ad..2f9eb1ee2230 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -112,6 +112,7 @@ struct tipd_data {
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 	void (*trace_irq)(void *events);
 	void (*trace_power_status)(u16 status);
+	void (*trace_status)(u32 status);
 };
 
 struct tps6598x {
@@ -471,7 +472,9 @@ static bool tps6598x_read_status(struct tps6598x *tps, u32 *status)
 		dev_err(tps->dev, "%s: failed to read status\n", __func__);
 		return false;
 	}
-	trace_tps6598x_status(*status);
+
+	if (tps->cb.trace_status)
+		tps->cb.trace_status(*status);
 
 	return true;
 }
@@ -1150,6 +1153,7 @@ static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
 	.register_port = tps6598x_register_port,
 	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
 };
 
 static const struct tipd_data tps6598x_data = {
@@ -1159,6 +1163,7 @@ static const struct tipd_data tps6598x_data = {
 	.register_port = tps6598x_register_port,
 	.trace_irq = tps6598x_trace_irq,
 	.trace_power_status = trace_tps6598x_power_status,
+	.trace_status = trace_tps6598x_status,
 };
 
 static const struct tipd_data tps25750_data = {
@@ -1168,6 +1173,7 @@ static const struct tipd_data tps25750_data = {
 	.register_port = tps25750_register_port,
 	.trace_irq = tps25750_trace_irq,
 	.trace_power_status = trace_tps25750_power_status,
+	.trace_status = trace_tps25750_status,
 };
 
 static int tps6598x_probe(struct i2c_client *client)
@@ -1245,10 +1251,8 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_reset_controller;
 
-	ret = tps6598x_read32(tps, TPS_REG_STATUS, &status);
-	if (ret < 0)
+	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_mask;
-	trace_tps6598x_status(status);
 
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 739b0a2a867d..afa0875a9de5 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -91,6 +91,14 @@
 						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
 						      TPS_STATUS_LEGACY_MASK))
 
+#define TPS25750_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_STATUS_CONN_STATE_MASK | \
+						      GENMASK(19, 7) | \
+						      TPS_STATUS_VBUS_STATUS_MASK | \
+						      TPS_STATUS_USB_HOST_PRESENT_MASK | \
+						      TPS_STATUS_LEGACY_MASK | \
+						      BIT(26) | \
+						      GENMASK(31, 28)))
+
 #define show_status_conn_state(status) \
 	__print_symbolic(TPS_STATUS_CONN_STATE((status)), \
 		{ TPS_STATUS_CONN_STATE_CONN_WITH_R_A,	"conn-Ra"  }, \
@@ -148,6 +156,14 @@
 		      { TPS_STATUS_HIGH_VOLAGE_WARNING,	"HIGH_VOLAGE_WARNING" }, \
 		      { TPS_STATUS_HIGH_LOW_VOLTAGE_WARNING, "HIGH_LOW_VOLTAGE_WARNING" })
 
+#define show_tps25750_status_flags(flags) \
+	__print_flags((flags & TPS25750_STATUS_FLAGS_MASK), "|", \
+		      { TPS_STATUS_PLUG_PRESENT,	"PLUG_PRESENT" }, \
+		      { TPS_STATUS_PLUG_UPSIDE_DOWN,	"UPSIDE_DOWN" }, \
+		      { TPS_STATUS_PORTROLE,		"PORTROLE" }, \
+		      { TPS_STATUS_DATAROLE,		"DATAROLE" }, \
+		      { TPS_STATUS_BIST,		"BIST" })
+
 #define show_power_status_source_sink(power_status) \
 	__print_symbolic(TPS_POWER_STATUS_SOURCESINK(power_status), \
 		{ 1, "sink" }, \
@@ -292,6 +308,27 @@ TRACE_EVENT(tps6598x_status,
 		    )
 );
 
+TRACE_EVENT(tps25750_status,
+	    TP_PROTO(u32 status),
+	    TP_ARGS(status),
+
+	    TP_STRUCT__entry(
+			     __field(u32, status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->status = status;
+			   ),
+
+	    TP_printk("conn: %s, vbus: %s, usb-host: %s, legacy: %s, flags: %s",
+		      show_status_conn_state(__entry->status),
+		      show_status_vbus_status(__entry->status),
+		      show_status_usb_host_present(__entry->status),
+		      show_status_legacy(__entry->status),
+		      show_tps25750_status_flags(__entry->status)
+		    )
+);
+
 TRACE_EVENT(tps6598x_power_status,
 	    TP_PROTO(u16 power_status),
 	    TP_ARGS(power_status),
-- 
2.34.1

