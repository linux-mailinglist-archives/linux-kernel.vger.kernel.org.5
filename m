Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC077B0B85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjI0R6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjI0R6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:58:02 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD9910C1;
        Wed, 27 Sep 2023 10:57:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98377c5d53eso1443233866b.0;
        Wed, 27 Sep 2023 10:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837467; x=1696442267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3vTTatxpTmSJDREvGgzvcF6cpLVGqrOuRB25FxTUfI=;
        b=WBrXIyE86mKyJiFTrIFftIataCa+m/CG/t6ZgkNOusstzhwT5TDfiFOe8EwxQAYzEN
         zgbmreHk9H4pc6bxH4I3YAlsCrikc1po4tok/JCUvQ6fkHAQK/Wjr7kOh0BQyVVBu94i
         0zxp0rMs1y4oihsyQZwivd8zTusXDiQXSfhf1uFSlLPrBcZIB1gpsGqeLTR7pID3YG8y
         UrHPjhJs9RNJ18ruOBDQC68IZ6lNDTrCheWkXs/Gne2sKaq4KK1ZUwb+g5VLCDzH9uHZ
         YSoVUtiSas3voP71+38uPhK/LHfshP7lEYRdtxup1QQ3YWJ9uk0ypZsyyUzv5b4EZ/i4
         R3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837467; x=1696442267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P3vTTatxpTmSJDREvGgzvcF6cpLVGqrOuRB25FxTUfI=;
        b=RTswvHV23pD4SBM3JQWYMouM/7coItE2hNC/DWfRV55v8kUsKetJV1jv2cnoG8G4oc
         a6RFnAmfG8RanpoJT1qoEN3LgWgPAzlD3Yt//DyjFyHCyBrS3crZtUe3VIsjQTMInCOM
         zz+r4N/pN0J8UCx6m6e+D54txvjhbGs6mEJblCXRW6aPaB6xtpaRvJbRwFumBnd/3o6/
         ErX5uF11obgVwphMqn4cT1aEJTMc900+pJsTZEKr7oJw2LHF8s846HceS0fuzG1W2hRg
         xu8926heLgaYPmptehGzMKLOWgJeKAi9hBWN3Rsw8QRzV9PTWI8YRUi483SFDQYvXDwo
         vP7g==
X-Gm-Message-State: AOJu0Yz/+L24IFbp3rgXaOW7ClFaCpaHR9JyRLyDxJibiw1RKpAYRm59
        Ggah9DIfd6uidBsGgOC3PXk=
X-Google-Smtp-Source: AGHT+IG33Renqty7Wc4ToIjLQ5qrskTs936voOLBcqdnSBzIYVBUVFpyhhgmOiH2SwwbHEqMXJrJIg==
X-Received: by 2002:a17:906:297:b0:9ae:7d2d:f2b1 with SMTP id 23-20020a170906029700b009ae7d2df2b1mr2379262ejf.73.1695837467527;
        Wed, 27 Sep 2023 10:57:47 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:47 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 10/14] USB: typec: tps6598x: Add port registration for tps25750
Date:   Wed, 27 Sep 2023 13:53:44 -0400
Message-Id: <20230927175348.18041-11-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 doesn't have system configuration register to get dr/pr of the
current applied binary configuration.

Get data role from the device node and power role from PD status register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Add port registration to tipd data factory
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 68 ++++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h | 10 +++++
 2 files changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index bd877e4cdb72..e775c3c9bf64 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -39,6 +39,7 @@
 #define TPS_REG_CTRL_CONF		0x29
 #define TPS_REG_BOOT_STATUS		0x2D
 #define TPS_REG_POWER_STATUS		0x3f
+#define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
 
@@ -101,8 +102,11 @@ static const char *const modes[] = {
 /* Unrecognized commands will be replaced with "!CMD" */
 #define INVALID_CMD(_cmd_)		(_cmd_ == 0x444d4321)
 
+struct tps6598x;
+
 struct tipd_data {
 	irq_handler_t irq_handler;
+	int (*register_port)(struct tps6598x *tps, struct fwnode_handle *node);
 };
 
 struct tps6598x {
@@ -207,6 +211,11 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
 	return tps6598x_block_read(tps, reg, val, sizeof(u64));
 }
 
+static inline int tps6598x_write8(struct tps6598x *tps, u8 reg, u8 val)
+{
+	return tps6598x_block_write(tps, reg, &val, sizeof(u8));
+}
+
 static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
 {
 	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
@@ -1083,16 +1092,73 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 	return 0;
 }
 
+static int
+tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	struct typec_capability typec_cap = { };
+	const char *data_role;
+	u8 pd_status;
+	int ret;
+
+	ret = tps6598x_read8(tps, TPS_REG_PD_STATUS, &pd_status);
+	if (ret)
+		return ret;
+
+	ret = fwnode_property_read_string(fwnode, "data-role", &data_role);
+	if (ret) {
+		dev_err(tps->dev, "data-role not found: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_find_port_data_role(data_role);
+	if (ret < 0) {
+		dev_err(tps->dev, "unknown data-role: %s\n", data_role);
+		return ret;
+	}
+
+	typec_cap.data = ret;
+	typec_cap.revision = USB_TYPEC_REV_1_3;
+	typec_cap.pd_revision = 0x300;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+
+	switch (TPS_PD_STATUS_PORT_TYPE(pd_status)) {
+	case TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE:
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK:
+		typec_cap.type = TYPEC_PORT_DRP;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	tps->port = typec_register_port(tps->dev, &typec_cap);
+	if (IS_ERR(tps->port))
+		return PTR_ERR(tps->port);
+
+	return 0;
+}
+
 static const struct tipd_data cd321x_data = {
 	.irq_handler = cd321x_interrupt,
+	.register_port = tps6598x_register_port,
 };
 
 static const struct tipd_data tps6598x_data = {
 	.irq_handler = tps6598x_interrupt,
+	.register_port = tps6598x_register_port,
 };
 
 static const struct tipd_data tps25750_data = {
 	.irq_handler = tps25750_interrupt,
+	.register_port = tps25750_register_port,
 };
 
 static int tps6598x_probe(struct i2c_client *client)
@@ -1195,7 +1261,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_role_put;
 
-	ret = tps6598x_register_port(tps, fwnode);
+	ret = tps->cb.register_port(tps, fwnode);
 	if (ret)
 		goto err_role_put;
 
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index c000170f4547..3a9a43394134 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -203,4 +203,14 @@
 #define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
 #define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
 
+/* PD STATUS REG */
+#define TPS_REG_PD_STATUS_PORT_TYPE_MASK	GENMASK(5, 4)
+#define TPS_PD_STATUS_PORT_TYPE(x) \
+	TPS_FIELD_GET(TPS_REG_PD_STATUS_PORT_TYPE_MASK, x)
+
+#define TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE	0
+#define TPS_PD_STATUS_PORT_TYPE_SINK		1
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE		2
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK	3
+
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

