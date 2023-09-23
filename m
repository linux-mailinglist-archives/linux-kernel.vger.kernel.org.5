Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A6E7ABE87
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbjIWHlU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbjIWHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:41:03 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86E11B7;
        Sat, 23 Sep 2023 00:40:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-405621baba7so2332475e9.0;
        Sat, 23 Sep 2023 00:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454850; x=1696059650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8C1BpdTLIqkeAo1qVT5MUljEOuVfc1JZhKQZvSuKMI=;
        b=g5TLC8ecMyQ7XYfWw4ANaA6edhv567/us8aIW/Puh2Iyhw8QFithk1iuBPrk0dSCYf
         Wm72uFPAhb5xuzS3HPiIhbG8BMdy6Q5u74klJt8J898PJvJvPF5SS48aSJX/yQ23Mo5T
         krKlXUp1zApk2dMB1fXVh8lZufHcWcNEHvOWYv0eK5SFpAXWN7mD7epMZDqxoBHStUX+
         Vmd7WslPPxXuBjDqa/SoIceD8F3MfUKpNI/kgEVWUggaPWFV59F24It0lqJ+GJtM9pMV
         uecTGCkadOsyEXqGunhe3HhkDqt3Sv1LcDGd3uWaxUUNSyIvTOLoJseeDYECwyPV/zK3
         D2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454850; x=1696059650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K8C1BpdTLIqkeAo1qVT5MUljEOuVfc1JZhKQZvSuKMI=;
        b=uymMMLJBHpLosuqvZefiXBG5YBN/1VdBXguCm1tMa2MEPwyX4VvBl4lzsDhTV41ymv
         3Rh8pbv2zApKyQyaMy/ucgslpSNjINemvfN96yUCiSP90VvhMjLVRhBjyc1KBkofu6Gp
         /sleQgAjc0TwqWSXQ8gWoMvhK4yILNqVWpsZeWWEUF2DckgnvU7Y5/YfELT/EOeT4pBl
         ini2vwdZVwgphLl9QC+9pk+AyjNUW1jJX/4BASiDTySZ8XRXfWIVvGCP5FGj6QM2Ta58
         KOF+LbZmxi9X3n16D7TSRujvagOwPozRIk1DfUSM0zxAxMOiOnbGk7IXHZSV4Yv6Tbw6
         KyOA==
X-Gm-Message-State: AOJu0YyJjsJ2+Y8dxrNzdwpYFD2AMLsnNK+YHDP/UsmtG07yVvKyCe6o
        zhVioPPxbqhC8ZmUeF/Vf/0=
X-Google-Smtp-Source: AGHT+IFAGrCW8nTg8vLWnGPW+OiD1h8MgxN7RnVUSHn7V1jB3cpXxSdlIrMWbb7clpyYtZP6nXWnpw==
X-Received: by 2002:a5d:534c:0:b0:31f:dc4d:3a0c with SMTP id t12-20020a5d534c000000b0031fdc4d3a0cmr1497345wrv.0.1695454850042;
        Sat, 23 Sep 2023 00:40:50 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:49 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 09/14] USB: typec: Refactor tps6598x port registration
Date:   Sat, 23 Sep 2023 03:39:54 -0400
Message-Id: <20230923073959.86660-10-alkuor@gmail.com>
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

tps6598x and cd321x use TPS_REG_SYSTEM_CONF to get dr/pr roles
where other similar devices don't have this register such as tps25750.

Move tps6598x port registration to its own function

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v6:
  - No changes
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 99 +++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 75e4030afae4..ee53011ec5e2 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -999,6 +999,58 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int
+tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	int ret;
+	u32 conf;
+	struct typec_capability typec_cap = { };
+
+	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
+	if (ret)
+		return ret;
+
+	typec_cap.revision = USB_TYPEC_REV_1_2;
+	typec_cap.pd_revision = 0x200;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+
+	switch (TPS_SYSCONF_PORTINFO(conf)) {
+	case TPS_PORTINFO_SINK_ACCESSORY:
+	case TPS_PORTINFO_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_UFP_DRD:
+	case TPS_PORTINFO_DRP_DFP_DRD:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DRD;
+		break;
+	case TPS_PORTINFO_DRP_UFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_DFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DFP;
+		break;
+	case TPS_PORTINFO_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
+		typec_cap.data = TYPEC_PORT_DFP;
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
 };
@@ -1018,11 +1070,9 @@ static const struct tipd_data tps25750_data = {
 static int tps6598x_probe(struct i2c_client *client)
 {
 	struct device_node *np = client->dev.of_node;
-	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
 	u32 status;
-	u32 conf;
 	u32 vid;
 	int ret;
 	u64 mask1;
@@ -1096,10 +1146,6 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_clear_mask;
 	trace_tps6598x_status(status);
 
-	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
-	if (ret < 0)
-		goto err_clear_mask;
-
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
 	 * struct device. Instead we simply parse it to read the properties.
@@ -1117,50 +1163,13 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_fwnode_put;
 	}
 
-	typec_cap.revision = USB_TYPEC_REV_1_2;
-	typec_cap.pd_revision = 0x200;
-	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
-	typec_cap.driver_data = tps;
-	typec_cap.ops = &tps6598x_ops;
-	typec_cap.fwnode = fwnode;
-
-	switch (TPS_SYSCONF_PORTINFO(conf)) {
-	case TPS_PORTINFO_SINK_ACCESSORY:
-	case TPS_PORTINFO_SINK:
-		typec_cap.type = TYPEC_PORT_SNK;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_UFP_DRD:
-	case TPS_PORTINFO_DRP_DFP_DRD:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DRD;
-		break;
-	case TPS_PORTINFO_DRP_UFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_DFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	case TPS_PORTINFO_SOURCE:
-		typec_cap.type = TYPEC_PORT_SRC;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	default:
-		ret = -ENODEV;
-		goto err_role_put;
-	}
-
 	ret = devm_tps6598_psy_register(tps);
 	if (ret)
 		goto err_role_put;
 
-	tps->port = typec_register_port(&client->dev, &typec_cap);
-	if (IS_ERR(tps->port)) {
-		ret = PTR_ERR(tps->port);
+	ret = tps6598x_register_port(tps, fwnode);
+	if (ret)
 		goto err_role_put;
-	}
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
-- 
2.34.1

