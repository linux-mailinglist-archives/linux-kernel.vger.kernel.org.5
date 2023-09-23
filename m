Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E16C7ABE8C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjIWHlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbjIWHlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:41:40 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13181E5E;
        Sat, 23 Sep 2023 00:40:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307d20548adso2852253f8f.0;
        Sat, 23 Sep 2023 00:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454857; x=1696059657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFRprVF8T6twSRScySzSwWxXFkNe84Dxw0ZjvDU4rH8=;
        b=XH9XUUVRxcFpWMUQGiZLjVCumR8xtRY0RJ6pmiEyU2taSxAckChJO2tOMn7GxB9tPH
         sDNaaldungjOaLiSNuB4xpRsS3btdAfaQcCMPs/6UZeV4YcFLPSORtVZcVS3uILeMadK
         nYnFcZokQqgWI2qYKje/4iGAFYtgII+W0AslZdWEEpMI/mogSJH3VLtqp4AVQ/qZ4TXQ
         GlY2HKmdc4G7ke6UUYOCYHlArKEEJSs+L09ljoRAG4ogGVhogTMSUy+2s57u+OgHDA1P
         /clCjdc66KPXGm11I+vmuy/QdgN8pV8Ku8giAWnqFzwIEXXX7q6mCzpkC3SJ4oSMtddk
         Hl4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454857; x=1696059657;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFRprVF8T6twSRScySzSwWxXFkNe84Dxw0ZjvDU4rH8=;
        b=BzRkas67prZMib2+uC+S6WLtUTvwRvUD6qcHskPbNNC3BZcwwbOwKCXP4WyRuR1fYo
         Rag3ks8zx1a1v1vYEvh0Pjs+8SV7MjbtCP/9cJJO2wVhzrijQsXmTQ0gRNLDatkMRMXs
         iuPLv7Xbf1OfjaKqGUH60h14sfUr8i5Xatv0J6ILJVDsHKFUXQ+BLNWga8OHMnqQeCYj
         VX6ysCFY02p1osyedy731NmIIffs9VwQTDPh/DmysRdCovEIwCc/z42NxRMhItcasHoh
         EvQ+3RXz0SvvMRCZpfxB/Z8u63nMggVoZD+0nMR3VrQsQ8n73Zkf5PQhcAYdEFp+6Fc/
         GgHA==
X-Gm-Message-State: AOJu0YzGWUQvZ8UjOzDJxQGPz7/uVEsFAbgnRtcXvJTS5jOpObEJpY2T
        H9dSZ1RLIV/PQy8FBG2+5SN7y3Q0anmHUpO+myQ=
X-Google-Smtp-Source: AGHT+IGSQmarAP5y4ioAQOv/vxCwMMfjKEHLGVNcVpedYNzEAHWDH7thWMgTz53K7wTqtf88C2TRZg==
X-Received: by 2002:a5d:4fc9:0:b0:320:7272:8fbe with SMTP id h9-20020a5d4fc9000000b0032072728fbemr1765631wrw.17.1695454857228;
        Sat, 23 Sep 2023 00:40:57 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:56 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 13/14] USB: typec: Add power status trace for tps25750
Date:   Sat, 23 Sep 2023 03:39:58 -0400
Message-Id: <20230923073959.86660-14-alkuor@gmail.com>
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

tps25750 power status register is a subset of tps6598x power status
register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
  - Add trace power status to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     |  8 +++++++-
 drivers/usb/typec/tipd/tps6598x.h | 19 ++++++++++++++++++
 drivers/usb/typec/tipd/trace.h    | 33 +++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index a1acf682bde0..e8190f1f57ad 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -111,6 +111,7 @@ struct tipd_data {
 	int (*clear_events)(struct tps6598x *tps, void *events);
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 	void (*trace_irq)(void *events);
+	void (*trace_power_status)(u16 status);
 };
 
 struct tps6598x {
@@ -501,7 +502,9 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
 		return false;
 	}
 	tps->pwr_status = pwr_status;
-	trace_tps6598x_power_status(pwr_status);
+
+	if (tps->cb.trace_power_status)
+		tps->cb.trace_power_status(pwr_status);
 
 	return true;
 }
@@ -1146,6 +1149,7 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
 	.register_port = tps6598x_register_port,
+	.trace_power_status = trace_tps6598x_power_status,
 };
 
 static const struct tipd_data tps6598x_data = {
@@ -1154,6 +1158,7 @@ static const struct tipd_data tps6598x_data = {
 	.clear_events = tps6598x_clear_events,
 	.register_port = tps6598x_register_port,
 	.trace_irq = tps6598x_trace_irq,
+	.trace_power_status = trace_tps6598x_power_status,
 };
 
 static const struct tipd_data tps25750_data = {
@@ -1162,6 +1167,7 @@ static const struct tipd_data tps25750_data = {
 	.clear_events = tps25750_clear_events,
 	.register_port = tps25750_register_port,
 	.trace_irq = tps25750_trace_irq,
+	.trace_power_status = trace_tps25750_power_status,
 };
 
 static int tps6598x_probe(struct i2c_client *client)
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index f86b5e96efba..01609bf509e4 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -161,6 +161,25 @@
 #define TPS_POWER_STATUS_BC12_STATUS_CDP 2
 #define TPS_POWER_STATUS_BC12_STATUS_DCP 3
 
+/* TPS25750_REG_POWER_STATUS bits */
+#define TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS_MASK	GENMASK(7, 4)
+#define TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS(p) \
+	TPS_FIELD_GET(TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS_MASK, (p))
+#define TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS_MASK	GENMASK(9, 8)
+#define TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS(p) \
+	TPS_FIELD_GET(TPS25750_POWER_STATUS_CHARGER_ADVERTISE_STATUS_MASK, (p))
+
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DISABLED	0
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_IN_PROGRESS	1
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_NONE		2
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_SPD		3
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_CPD	4
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_DPD	5
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_1_DCP	6
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_2_DCP	7
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_3_DCP	8
+#define TPS25750_POWER_STATUS_CHARGER_DET_STATUS_1_2V_DCP	9
+
 /* TPS_REG_DATA_STATUS bits */
 #define TPS_DATA_STATUS_DATA_CONNECTION	     BIT(0)
 #define TPS_DATA_STATUS_UPSIDE_DOWN	     BIT(1)
diff --git a/drivers/usb/typec/tipd/trace.h b/drivers/usb/typec/tipd/trace.h
index 28725234a2d8..739b0a2a867d 100644
--- a/drivers/usb/typec/tipd/trace.h
+++ b/drivers/usb/typec/tipd/trace.h
@@ -166,6 +166,19 @@
 		{ TPS_POWER_STATUS_BC12_STATUS_CDP, "cdp" }, \
 		{ TPS_POWER_STATUS_BC12_STATUS_SDP, "sdp" })
 
+#define show_tps25750_power_status_charger_detect_status(power_status) \
+	__print_symbolic(TPS25750_POWER_STATUS_CHARGER_DETECT_STATUS(power_status), \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DISABLED,	"disabled"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_IN_PROGRESS,	"in progress"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_NONE,	"none"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_SPD,		"spd"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_CPD,	"cpd"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_BC_1_2_DPD,	"dpd"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_1_DCP,	"divider 1 dcp"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_2_DCP,	"divider 2 dcp"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_DIV_3_DCP,	"divider 3 dpc"}, \
+		{ TPS25750_POWER_STATUS_CHARGER_DET_STATUS_1_2V_DCP,	"1.2V dpc"})
+
 #define TPS_DATA_STATUS_FLAGS_MASK (GENMASK(31, 0) ^ (TPS_DATA_STATUS_DP_PIN_ASSIGNMENT_MASK | \
 						      TPS_DATA_STATUS_TBT_CABLE_SPEED_MASK | \
 						      TPS_DATA_STATUS_TBT_CABLE_GEN_MASK))
@@ -299,6 +312,26 @@ TRACE_EVENT(tps6598x_power_status,
 		    )
 );
 
+TRACE_EVENT(tps25750_power_status,
+	    TP_PROTO(u16 power_status),
+	    TP_ARGS(power_status),
+
+	    TP_STRUCT__entry(
+			     __field(u16, power_status)
+			     ),
+
+	    TP_fast_assign(
+			   __entry->power_status = power_status;
+			   ),
+
+	    TP_printk("conn: %d, pwr-role: %s, typec: %s, charger detect: %s",
+		      !!TPS_POWER_STATUS_CONNECTION(__entry->power_status),
+		      show_power_status_source_sink(__entry->power_status),
+		      show_power_status_typec_status(__entry->power_status),
+		      show_tps25750_power_status_charger_detect_status(__entry->power_status)
+		    )
+);
+
 TRACE_EVENT(tps6598x_data_status,
 	    TP_PROTO(u32 data_status),
 	    TP_ARGS(data_status),
-- 
2.34.1

