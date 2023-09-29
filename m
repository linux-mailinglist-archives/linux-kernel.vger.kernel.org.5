Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2F17B3581
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjI2OdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjI2Oc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:26 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E870610FB;
        Fri, 29 Sep 2023 07:32:21 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9ad8d47ef2fso1850782166b.1;
        Fri, 29 Sep 2023 07:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997940; x=1696602740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4cA+mZWyPkCkV/BDJlpA7F0WPLb7gs/FrHfljohURs=;
        b=HY3sGX96P4QoQ4faJEt8f8sREXCBNcb6H5QDd4jkeCbRPGKC8e8gR+YKoszoSqkJdd
         1NqhZsZk4rEGNQzhxPdRBmDTWZcgiRkXm2hPs8Bgkm+XY/VqB30yRzcMf1pqMy+qCGmK
         eVbuAjtP1+PJdU3h6W/Io6UtSQqpWxQ4aaVxz1XJDNwyM69bKFOIl2hHbZ0OEJQtomYJ
         zN7hTlV7zeyac3PbJ0YiSW7CmfTKDXMk1C5xY3fFrnJaK9Un4eImw3Vc5Zjihq1p0XAK
         ksGwULld/DgwyXewtD5vdDpoUUJdx+c9NTr2ykn10ASZ7z/NjWnLSXgVipOShyvWUQ0p
         7gWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997940; x=1696602740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a4cA+mZWyPkCkV/BDJlpA7F0WPLb7gs/FrHfljohURs=;
        b=KBQ1nwwIY9Y9CmkPUbTM8uRJPYOjWrYKvhTZ1sMiejkJRd+RbJGNIyIaYOrFmH4w/k
         TcB2jkghbQO034Dpyxpvv+Fy/rvTfJJHHKCvpNrNcA/lFUZ8liKZjAdfyI35ZgnDkCDC
         aTjy1RENWhloh+VKK9hExznqjHSuMXElChHByQ1Xha5aGlE0BYgG6qSPDBCdlRbCBXDu
         zHYpU5sQPtGCXGKFoohU0V9BL1cDiu4WdoATJZkEKR3VXZEO9SOgxg7rHmOhnJJzvmla
         BytBQ6urxtxrNjZUlGnRBi0ZpkBIwpscWZDq+32RQF4hFuyPktbfr1qvnyTULgpVZM91
         R3sw==
X-Gm-Message-State: AOJu0Yx8B56DuEe4wSiPoXiLQjLRW+wwwL3qzznsZbS73IF9fzFr40Gi
        roFqxwDpRkVYzriJQIiApEI6E6OIx0gg3CbkPuM=
X-Google-Smtp-Source: AGHT+IEK2xcTO7nEqzY0Peys4rr2D4BDgq+55/sVDzcTi3VngfWXi99H59iSclgYNhg2BVtdzw+kVQ==
X-Received: by 2002:a17:906:854b:b0:9ae:54c3:c627 with SMTP id h11-20020a170906854b00b009ae54c3c627mr3503943ejy.71.1695997940123;
        Fri, 29 Sep 2023 07:32:20 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:19 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 13/14] USB: typec: tps6598x: Add power status trace for tps25750
Date:   Fri, 29 Sep 2023 10:30:54 -0400
Message-Id: <20230929143055.31360-14-alkuor@gmail.com>
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

tps25750 power status register is a subset of tps6598x power status
register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v8:
  - Change tps->cb to tps->data
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Add trace power status to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     |  8 +++++++-
 drivers/usb/typec/tipd/tps6598x.h | 19 ++++++++++++++++++
 drivers/usb/typec/tipd/trace.h    | 33 +++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 9df8da8f5d4b..c7bec4464b8e 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -109,6 +109,7 @@ struct tps6598x;
 struct tipd_data {
 	irq_handler_t irq_handler;
 	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
+	void (*trace_power_status)(u16 status);
 };
 
 struct tps6598x {
@@ -499,7 +500,9 @@ static bool tps6598x_read_power_status(struct tps6598x *tps)
 		return false;
 	}
 	tps->pwr_status = pwr_status;
-	trace_tps6598x_power_status(pwr_status);
+
+	if (tps->data->trace_power_status)
+		tps->data->trace_power_status(pwr_status);
 
 	return true;
 }
@@ -1170,16 +1173,19 @@ tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
 	.register_port = tps6598x_register_port,
+	.trace_power_status = trace_tps6598x_power_status,
 };
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
 	.register_port = tps6598x_register_port,
+	.trace_power_status = trace_tps6598x_power_status,
 };
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
 	.register_port = tps25750_register_port,
+	.trace_power_status = trace_tps25750_power_status,
 };
 
 static const struct of_device_id tps6598x_of_match[] = {
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

