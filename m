Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69B117DC0CB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 20:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjJ3TmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 15:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjJ3TmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 15:42:04 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5A0FA;
        Mon, 30 Oct 2023 12:41:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50930f126b1so113764e87.3;
        Mon, 30 Oct 2023 12:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698694914; x=1699299714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lar4q5BLMYdDXvaz2nduMcPI3LQymFQyRA6QLE+IUPA=;
        b=ezEuQAG78dFYDbgmWoNTMEmlazVoka1ZX3+B9wtfVhNm1kTubhDSVtGHH2WzryPqkt
         mIyWcrcBE1pqLocHcpUstmW528iOSIFkr/tn3MSu4WXd96Yq4numxIos6R2kcqCLf3Lz
         vzyt3I/C5Y3EVJM65ZAqUDu4VlOtHBFyI7TEsWWpG53MnJJEI4M4KDwON5pyOr9dv8ni
         YZYGv3AvWhUKs4kXZ+ARnbyjjKUIxUX2bD96og4ZLdTHk6xx2L/07sB0wyQ3WqwitIs0
         ctFBmCysgdr/mbHszS/lWr80dDzXIk/57uzUT8TUwhMFKf8e3BAL6f4NKCJwEPKv1dC8
         5hqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698694914; x=1699299714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lar4q5BLMYdDXvaz2nduMcPI3LQymFQyRA6QLE+IUPA=;
        b=hFc5GW5sMrhRFCx1F4TdmULIsKEHYOajTlSH4MSrzAkLB8kfp1BiT4CfB1hTlPH9XN
         kj8+Q2kAnqKZzAzddCZG+6DLolu8OQ4Oh+FynAtJConzj47LnUducD/OINEYcr8J1yi8
         IJkmWF/oe0R4Xt2Tg7yFZoIM3rARA6aVjGlz1iJfEkQtmQOTgYqCYuhL/+6IewZcspZV
         f4mcklTZnnmgaqISivAyjFLr4bIPmmR6KAj+UHAUYm5pN7ZB9cSAbKntmJyGHhpFcXQY
         r4eQQX+IlpOQUBhhVLq+R2j+YnOwgozpYOavwqeEg5avRxycMnHqosQKxo81T6AwLlet
         ThmA==
X-Gm-Message-State: AOJu0YwPD79IbDYvyNbOI2JbBrsn7g2rUtwy9nspvHKVy/cSOhhabmpz
        47R8Y/1Lt6zdluuyDCUy4ME=
X-Google-Smtp-Source: AGHT+IH+3c0llFdOIqdvRFMxP4l3aG+SHTpOangVXSQK9c8H1rpB1Edje3c0vyxB5BwAnebEomqDfw==
X-Received: by 2002:a19:9112:0:b0:503:2561:adbc with SMTP id t18-20020a199112000000b005032561adbcmr7309202lfd.64.1698694914471;
        Mon, 30 Oct 2023 12:41:54 -0700 (PDT)
Received: from hex.my.domain (83.11.208.51.ipv4.supernova.orange.pl. [83.11.208.51])
        by smtp.gmail.com with ESMTPSA id m10-20020ac2428a000000b005057184ae62sm1527802lfh.96.2023.10.30.12.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 12:41:54 -0700 (PDT)
From:   Artur Weber <aweber.kernel@gmail.com>
Date:   Mon, 30 Oct 2023 20:41:47 +0100
Subject: [PATCH v2 5/6] regulator: bcm590xx: Add support for BCM59054
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231030-bcm59054-v2-5-5fa4011aa5ba@gmail.com>
References: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
In-Reply-To: <20231030-bcm59054-v2-0-5fa4011aa5ba@gmail.com>
To:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Stanislav Jakubek <stano.jakubek@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Artur Weber <aweber.kernel@gmail.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698694906; l=25592;
 i=aweber.kernel@gmail.com; s=20231030; h=from:subject:message-id;
 bh=Vcld9l2CUccXXlMEKsE/QRX28i7sxc2Cj+81kZnastM=;
 b=vNEL/nJ5tg2zZ09Wpqx0YFdPp6HrOb5rioB+TITbaS0ZPxsttDnPv+1NES3QWZv/HlqhJx6rq
 imSwO7rbcv8AdCkAFf0CHw8HXQkq06GVciubF04biqhkEtrOWjBzLJU
X-Developer-Key: i=aweber.kernel@gmail.com; a=ed25519;
 pk=RhDBfWbJEHqDibXbhNEBAnc9FMkyznGxX/hwfhL8bv8=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM59054 is fairly similar in terms of regulators to the already
supported BCM59056, as included in the BCM590XX driver.

Add support for the BCM59054's regulators to the BCM590XX driver.
Switch from using defines for common checks to using functions which
return different values depending on the identified MFD model.

While we're at it, fix a bug where the enable/vsel register
offsets for GPLDO and LDO regulators were calculated incorrectly.

Also, change the regulator enable bitmask to cover the entire PMMODE
register.

Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
---
 drivers/regulator/bcm590xx-regulator.c | 624 ++++++++++++++++++++++++---------
 1 file changed, 465 insertions(+), 159 deletions(-)

diff --git a/drivers/regulator/bcm590xx-regulator.c b/drivers/regulator/bcm590xx-regulator.c
index 9f0cda46b015..8b90eae06ca6 100644
--- a/drivers/regulator/bcm590xx-regulator.c
+++ b/drivers/regulator/bcm590xx-regulator.c
@@ -18,37 +18,54 @@
 #include <linux/regulator/of_regulator.h>
 #include <linux/slab.h>
 
+struct bcm590xx_info {
+	const char *name;
+	const char *vin_name;
+	u8 n_voltages;
+	const unsigned int *volt_table;
+	u8 n_linear_ranges;
+	const struct linear_range *linear_ranges;
+};
+
+struct bcm590xx_reg {
+	struct regulator_desc *desc;
+	struct bcm590xx *mfd;
+};
+
+#define BCM590XX_REG_ENABLE		GENMASK(7, 0)
+#define BCM590XX_REG_3BIT_ENABLE	(GENMASK(4, 3) | GENMASK(1, 0))
+#define BCM590XX_VBUS_ENABLE		BIT(2)
+#define BCM590XX_LDO_VSEL_MASK		GENMASK(5, 3)
+#define BCM590XX_SR_VSEL_MASK		GENMASK(5, 0)
+
+/* BCM59056 registers */
+
 /* I2C slave 0 registers */
-#define BCM590XX_RFLDOPMCTRL1	0x60
-#define BCM590XX_IOSR1PMCTRL1	0x7a
-#define BCM590XX_IOSR2PMCTRL1	0x7c
-#define BCM590XX_CSRPMCTRL1	0x7e
-#define BCM590XX_SDSR1PMCTRL1	0x82
-#define BCM590XX_SDSR2PMCTRL1	0x86
-#define BCM590XX_MSRPMCTRL1	0x8a
-#define BCM590XX_VSRPMCTRL1	0x8e
-#define BCM590XX_RFLDOCTRL	0x96
-#define BCM590XX_CSRVOUT1	0xc0
+#define BCM59056_RFLDOPMCTRL1	0x60
+#define BCM59056_IOSR1PMCTRL1	0x7a
+#define BCM59056_IOSR2PMCTRL1	0x7c
+#define BCM59056_CSRPMCTRL1	0x7e
+#define BCM59056_SDSR1PMCTRL1	0x82
+#define BCM59056_SDSR2PMCTRL1	0x86
+#define BCM59056_MSRPMCTRL1	0x8a
+#define BCM59056_VSRPMCTRL1	0x8e
+#define BCM59056_RFLDOCTRL	0x96
+#define BCM59056_CSRVOUT1	0xc0
 
 /* I2C slave 1 registers */
-#define BCM590XX_GPLDO5PMCTRL1	0x16
-#define BCM590XX_GPLDO6PMCTRL1	0x18
-#define BCM590XX_GPLDO1CTRL	0x1a
-#define BCM590XX_GPLDO2CTRL	0x1b
-#define BCM590XX_GPLDO3CTRL	0x1c
-#define BCM590XX_GPLDO4CTRL	0x1d
-#define BCM590XX_GPLDO5CTRL	0x1e
-#define BCM590XX_GPLDO6CTRL	0x1f
-#define BCM590XX_OTG_CTRL	0x40
-#define BCM590XX_GPLDO1PMCTRL1	0x57
-#define BCM590XX_GPLDO2PMCTRL1	0x59
-#define BCM590XX_GPLDO3PMCTRL1	0x5b
-#define BCM590XX_GPLDO4PMCTRL1	0x5d
-
-#define BCM590XX_REG_ENABLE	BIT(7)
-#define BCM590XX_VBUS_ENABLE	BIT(2)
-#define BCM590XX_LDO_VSEL_MASK	GENMASK(5, 3)
-#define BCM590XX_SR_VSEL_MASK	GENMASK(5, 0)
+#define BCM59056_GPLDO5PMCTRL1	0x16
+#define BCM59056_GPLDO6PMCTRL1	0x18
+#define BCM59056_GPLDO1CTRL	0x1a
+#define BCM59056_GPLDO2CTRL	0x1b
+#define BCM59056_GPLDO3CTRL	0x1c
+#define BCM59056_GPLDO4CTRL	0x1d
+#define BCM59056_GPLDO5CTRL	0x1e
+#define BCM59056_GPLDO6CTRL	0x1f
+#define BCM59056_OTG_CTRL	0x40
+#define BCM59056_GPLDO1PMCTRL1	0x57
+#define BCM59056_GPLDO2PMCTRL1	0x59
+#define BCM59056_GPLDO3PMCTRL1	0x5b
+#define BCM59056_GPLDO4PMCTRL1	0x5d
 
 /*
  * RFLDO to VSR regulators are
@@ -56,74 +73,69 @@
  */
 
 /* LDO regulator IDs */
-#define BCM590XX_REG_RFLDO	0
-#define BCM590XX_REG_CAMLDO1	1
-#define BCM590XX_REG_CAMLDO2	2
-#define BCM590XX_REG_SIMLDO1	3
-#define BCM590XX_REG_SIMLDO2	4
-#define BCM590XX_REG_SDLDO	5
-#define BCM590XX_REG_SDXLDO	6
-#define BCM590XX_REG_MMCLDO1	7
-#define BCM590XX_REG_MMCLDO2	8
-#define BCM590XX_REG_AUDLDO	9
-#define BCM590XX_REG_MICLDO	10
-#define BCM590XX_REG_USBLDO	11
-#define BCM590XX_REG_VIBLDO	12
+#define BCM59056_REG_RFLDO	0
+#define BCM59056_REG_CAMLDO1	1
+#define BCM59056_REG_CAMLDO2	2
+#define BCM59056_REG_SIMLDO1	3
+#define BCM59056_REG_SIMLDO2	4
+#define BCM59056_REG_SDLDO	5
+#define BCM59056_REG_SDXLDO	6
+#define BCM59056_REG_MMCLDO1	7
+#define BCM59056_REG_MMCLDO2	8
+#define BCM59056_REG_AUDLDO	9
+#define BCM59056_REG_MICLDO	10
+#define BCM59056_REG_USBLDO	11
+#define BCM59056_REG_VIBLDO	12
 
 /* DCDC regulator IDs */
-#define BCM590XX_REG_CSR	13
-#define BCM590XX_REG_IOSR1	14
-#define BCM590XX_REG_IOSR2	15
-#define BCM590XX_REG_MSR	16
-#define BCM590XX_REG_SDSR1	17
-#define BCM590XX_REG_SDSR2	18
-#define BCM590XX_REG_VSR	19
+#define BCM59056_REG_CSR	13
+#define BCM59056_REG_IOSR1	14
+#define BCM59056_REG_IOSR2	15
+#define BCM59056_REG_MSR	16
+#define BCM59056_REG_SDSR1	17
+#define BCM59056_REG_SDSR2	18
+#define BCM59056_REG_VSR	19
 
 /*
  * GPLDO1 to VBUS regulators are
  * accessed via I2C slave 1
  */
 
-#define BCM590XX_REG_GPLDO1	20
-#define BCM590XX_REG_GPLDO2	21
-#define BCM590XX_REG_GPLDO3	22
-#define BCM590XX_REG_GPLDO4	23
-#define BCM590XX_REG_GPLDO5	24
-#define BCM590XX_REG_GPLDO6	25
-#define BCM590XX_REG_VBUS	26
-
-#define BCM590XX_NUM_REGS	27
+#define BCM59056_REG_GPLDO1	20
+#define BCM59056_REG_GPLDO2	21
+#define BCM59056_REG_GPLDO3	22
+#define BCM59056_REG_GPLDO4	23
+#define BCM59056_REG_GPLDO5	24
+#define BCM59056_REG_GPLDO6	25
+#define BCM59056_REG_VBUS	26
 
-#define BCM590XX_REG_IS_LDO(n)	(n < BCM590XX_REG_CSR)
-#define BCM590XX_REG_IS_GPLDO(n) \
-	((n > BCM590XX_REG_VSR) && (n < BCM590XX_REG_VBUS))
-#define BCM590XX_REG_IS_VBUS(n)	(n == BCM590XX_REG_VBUS)
+#define BCM59056_NUM_REGS	27
 
 /* LDO group A: supported voltages in microvolts */
-static const unsigned int ldo_a_table[] = {
+static const unsigned int bcm59056_ldo_a_table[] = {
 	1200000, 1800000, 2500000, 2700000, 2800000,
 	2900000, 3000000, 3300000,
 };
 
 /* LDO group C: supported voltages in microvolts */
-static const unsigned int ldo_c_table[] = {
+static const unsigned int bcm59056_ldo_c_table[] = {
 	3100000, 1800000, 2500000, 2700000, 2800000,
 	2900000, 3000000, 3300000,
 };
 
-static const unsigned int ldo_vbus[] = {
+static const unsigned int bcm59056_ldo_vbus[] = {
 	5000000,
 };
 
 /* DCDC group CSR: supported voltages in microvolts */
-static const struct linear_range dcdc_csr_ranges[] = {
+static const struct linear_range bcm59056_dcdc_csr_ranges[] = {
 	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
 	REGULATOR_LINEAR_RANGE(1360000, 51, 55, 20000),
 	REGULATOR_LINEAR_RANGE(900000, 56, 63, 0),
 };
 
 /* DCDC group IOSR1: supported voltages in microvolts */
-static const struct linear_range dcdc_iosr1_ranges[] = {
+static const struct linear_range bcm59056_dcdc_iosr1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(860000, 2, 51, 10000),
 	REGULATOR_LINEAR_RANGE(1500000, 52, 52, 0),
 	REGULATOR_LINEAR_RANGE(1800000, 53, 53, 0),
@@ -131,121 +143,404 @@ static const struct linear_range dcdc_iosr1_ranges[] = {
 };
 
 /* DCDC group SDSR1: supported voltages in microvolts */
-static const struct linear_range dcdc_sdsr1_ranges[] = {
+static const struct linear_range bcm59056_dcdc_sdsr1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(860000, 2, 50, 10000),
 	REGULATOR_LINEAR_RANGE(1340000, 51, 51, 0),
 	REGULATOR_LINEAR_RANGE(900000, 52, 63, 0),
 };
 
-struct bcm590xx_info {
-	const char *name;
-	const char *vin_name;
-	u8 n_voltages;
-	const unsigned int *volt_table;
-	u8 n_linear_ranges;
-	const struct linear_range *linear_ranges;
+#define BCM59056_REG_TABLE(_name, _table) \
+	{ \
+		.name = #_name, \
+		.n_voltages = ARRAY_SIZE(bcm59056_##_table), \
+		.volt_table = bcm59056_##_table, \
+	}
+
+#define BCM59056_REG_RANGES(_name, _ranges) \
+	{ \
+		.name = #_name, \
+		.n_voltages = 64, \
+		.n_linear_ranges = ARRAY_SIZE(bcm59056_##_ranges), \
+		.linear_ranges = bcm59056_##_ranges, \
+	}
+
+static struct bcm590xx_info bcm59056_regs[] = {
+	BCM59056_REG_TABLE(rfldo, ldo_a_table),
+	BCM59056_REG_TABLE(camldo1, ldo_c_table),
+	BCM59056_REG_TABLE(camldo2, ldo_c_table),
+	BCM59056_REG_TABLE(simldo1, ldo_a_table),
+	BCM59056_REG_TABLE(simldo2, ldo_a_table),
+	BCM59056_REG_TABLE(sdldo, ldo_c_table),
+	BCM59056_REG_TABLE(sdxldo, ldo_a_table),
+	BCM59056_REG_TABLE(mmcldo1, ldo_a_table),
+	BCM59056_REG_TABLE(mmcldo2, ldo_a_table),
+	BCM59056_REG_TABLE(audldo, ldo_a_table),
+	BCM59056_REG_TABLE(micldo, ldo_a_table),
+	BCM59056_REG_TABLE(usbldo, ldo_a_table),
+	BCM59056_REG_TABLE(vibldo, ldo_c_table),
+	BCM59056_REG_RANGES(csr, dcdc_csr_ranges),
+	BCM59056_REG_RANGES(iosr1, dcdc_iosr1_ranges),
+	BCM59056_REG_RANGES(iosr2, dcdc_iosr1_ranges),
+	BCM59056_REG_RANGES(msr, dcdc_iosr1_ranges),
+	BCM59056_REG_RANGES(sdsr1, dcdc_sdsr1_ranges),
+	BCM59056_REG_RANGES(sdsr2, dcdc_iosr1_ranges),
+	BCM59056_REG_RANGES(vsr, dcdc_iosr1_ranges),
+	BCM59056_REG_TABLE(gpldo1, ldo_a_table),
+	BCM59056_REG_TABLE(gpldo2, ldo_a_table),
+	BCM59056_REG_TABLE(gpldo3, ldo_a_table),
+	BCM59056_REG_TABLE(gpldo4, ldo_a_table),
+	BCM59056_REG_TABLE(gpldo5, ldo_a_table),
+	BCM59056_REG_TABLE(gpldo6, ldo_a_table),
+	BCM59056_REG_TABLE(vbus, ldo_vbus),
+};
+
+/* BCM59054 registers */
+
+/* I2C slave 0 registers */
+#define BCM59054_RFLDOPMCTRL1	0x60
+#define BCM59054_IOSR1PMCTRL1	0x7a
+#define BCM59054_IOSR2PMCTRL1	0x7c
+#define BCM59054_CSRPMCTRL1	0x7e
+#define BCM59054_SDSR1PMCTRL1	0x82
+#define BCM59054_SDSR2PMCTRL1	0x86
+#define BCM59054_MMSRPMCTRL1	0x8a
+#define BCM59054_VSRPMCTRL1	0x8e
+#define BCM59054_RFLDOCTRL	0x96
+#define BCM59054_CSRVOUT1	0xc0
+
+/* I2C slave 1 registers */
+#define BCM59054_LVLDO1PMCTRL1	0x16
+#define BCM59054_LVLDO2PMCTRL1	0x18
+#define BCM59054_GPLDO1CTRL	0x1a
+#define BCM59054_GPLDO2CTRL	0x1b
+#define BCM59054_GPLDO3CTRL	0x1c
+#define BCM59054_TCXLDOCTRL	0x1d
+#define BCM59054_LVLDO1CTRL	0x1e
+#define BCM59054_LVLDO2CTRL	0x1f
+#define BCM59054_OTG_CTRL	0x40
+#define BCM59054_GPLDO1PMCTRL1	0x57
+#define BCM59054_GPLDO2PMCTRL1	0x59
+#define BCM59054_GPLDO3PMCTRL1	0x5b
+#define BCM59054_TCXLDOPMCTRL1	0x5d
+
+/*
+ * RFLDO to VSR regulators are
+ * accessed via I2C slave 0
+ */
+
+/* LDO regulator IDs */
+#define BCM59054_REG_RFLDO	0
+#define BCM59054_REG_CAMLDO1	1
+#define BCM59054_REG_CAMLDO2	2
+#define BCM59054_REG_SIMLDO1	3
+#define BCM59054_REG_SIMLDO2	4
+#define BCM59054_REG_SDLDO	5
+#define BCM59054_REG_SDXLDO	6
+#define BCM59054_REG_MMCLDO1	7
+#define BCM59054_REG_MMCLDO2	8
+#define BCM59054_REG_AUDLDO	9
+#define BCM59054_REG_MICLDO	10
+#define BCM59054_REG_USBLDO	11
+#define BCM59054_REG_VIBLDO	12
+
+/* DCDC regulator IDs */
+#define BCM59054_REG_CSR	13
+#define BCM59054_REG_IOSR1	14
+#define BCM59054_REG_IOSR2	15
+#define BCM59054_REG_MMSR	16
+#define BCM59054_REG_SDSR1	17
+#define BCM59054_REG_SDSR2	18
+#define BCM59054_REG_VSR	19
+
+/*
+ * GPLDO1 to VBUS regulators are
+ * accessed via I2C slave 1
+ */
+
+#define BCM59054_REG_GPLDO1	20
+#define BCM59054_REG_GPLDO2	21
+#define BCM59054_REG_GPLDO3	22
+#define BCM59054_REG_TCXLDO	23
+#define BCM59054_REG_LVLDO1	24
+#define BCM59054_REG_LVLDO2	25
+#define BCM59054_REG_VBUS	26
+
+#define BCM59054_NUM_REGS	27
+
+/* LDO group 1: supported voltages in microvolts */
+static const unsigned int bcm59054_ldo_1_table[] = {
+	1200000, 1800000, 2500000, 2700000, 2800000,
+	2900000, 3000000, 3300000,
+};
+
+/* LDO group 2: supported voltages in microvolts */
+static const unsigned int bcm59054_ldo_2_table[] = {
+	3100000, 1800000, 2500000, 2700000, 2800000,
+	2900000, 3000000, 3300000,
+};
+
+/* LDO group 3: supported voltages in microvolts */
+static const unsigned int bcm59054_ldo_3_table[] = {
+	1000000, 1107000, 1143000, 1214000, 1250000,
+	1464000, 1500000, 1786000,
+};
+
+static const unsigned int bcm59054_ldo_vbus[] = {
+	5000000,
+};
+
+/* DCDC group SR: supported voltages in microvolts */
+static const struct linear_range bcm59054_dcdc_sr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 1, 0),
+	REGULATOR_LINEAR_RANGE(860000, 2, 60, 10000),
+	REGULATOR_LINEAR_RANGE(1500000, 61, 61, 0),
+	REGULATOR_LINEAR_RANGE(1800000, 62, 62, 0),
+	REGULATOR_LINEAR_RANGE(900000, 63, 63, 0),
+};
+
+/* DCDC group VSR: supported voltages in microvolts */
+static const struct linear_range bcm59054_dcdc_vsr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(0, 0, 1, 0),
+	REGULATOR_LINEAR_RANGE(860000, 2, 59, 10000),
+	REGULATOR_LINEAR_RANGE(1700000, 60, 60, 0),
+	REGULATOR_LINEAR_RANGE(1500000, 61, 61, 0),
+	REGULATOR_LINEAR_RANGE(1800000, 62, 62, 0),
+	REGULATOR_LINEAR_RANGE(1600000, 63, 63, 0),
 };
 
-#define BCM590XX_REG_TABLE(_name, _table) \
+/* DCDC group CSR: supported voltages in microvolts */
+static const struct linear_range bcm59054_dcdc_csr_ranges[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 1, 100000),
+	REGULATOR_LINEAR_RANGE(860000, 2, 60, 10000),
+	REGULATOR_LINEAR_RANGE(900000, 61, 63, 0),
+};
+
+#define BCM59054_REG_TABLE(_name, _table) \
 	{ \
 		.name = #_name, \
-		.n_voltages = ARRAY_SIZE(_table), \
-		.volt_table = _table, \
+		.n_voltages = ARRAY_SIZE(bcm59054_##_table), \
+		.volt_table = bcm59054_##_table, \
 	}
 
-#define BCM590XX_REG_RANGES(_name, _ranges) \
+#define BCM59054_REG_RANGES(_name, _ranges) \
 	{ \
 		.name = #_name, \
 		.n_voltages = 64, \
-		.n_linear_ranges = ARRAY_SIZE(_ranges), \
-		.linear_ranges = _ranges, \
+		.n_linear_ranges = ARRAY_SIZE(bcm59054_##_ranges), \
+		.linear_ranges = bcm59054_##_ranges, \
 	}
 
-static struct bcm590xx_info bcm590xx_regs[] = {
-	BCM590XX_REG_TABLE(rfldo, ldo_a_table),
-	BCM590XX_REG_TABLE(camldo1, ldo_c_table),
-	BCM590XX_REG_TABLE(camldo2, ldo_c_table),
-	BCM590XX_REG_TABLE(simldo1, ldo_a_table),
-	BCM590XX_REG_TABLE(simldo2, ldo_a_table),
-	BCM590XX_REG_TABLE(sdldo, ldo_c_table),
-	BCM590XX_REG_TABLE(sdxldo, ldo_a_table),
-	BCM590XX_REG_TABLE(mmcldo1, ldo_a_table),
-	BCM590XX_REG_TABLE(mmcldo2, ldo_a_table),
-	BCM590XX_REG_TABLE(audldo, ldo_a_table),
-	BCM590XX_REG_TABLE(micldo, ldo_a_table),
-	BCM590XX_REG_TABLE(usbldo, ldo_a_table),
-	BCM590XX_REG_TABLE(vibldo, ldo_c_table),
-	BCM590XX_REG_RANGES(csr, dcdc_csr_ranges),
-	BCM590XX_REG_RANGES(iosr1, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(iosr2, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(msr, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(sdsr1, dcdc_sdsr1_ranges),
-	BCM590XX_REG_RANGES(sdsr2, dcdc_iosr1_ranges),
-	BCM590XX_REG_RANGES(vsr, dcdc_iosr1_ranges),
-	BCM590XX_REG_TABLE(gpldo1, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo2, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo3, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo4, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo5, ldo_a_table),
-	BCM590XX_REG_TABLE(gpldo6, ldo_a_table),
-	BCM590XX_REG_TABLE(vbus, ldo_vbus),
+static struct bcm590xx_info bcm59054_regs[] = {
+	BCM59054_REG_TABLE(rfldo, ldo_1_table),
+	BCM59054_REG_TABLE(camldo1, ldo_2_table),
+	BCM59054_REG_TABLE(camldo2, ldo_2_table),
+	BCM59054_REG_TABLE(simldo1, ldo_1_table),
+	BCM59054_REG_TABLE(simldo2, ldo_1_table),
+	BCM59054_REG_TABLE(sdldo, ldo_2_table),
+	BCM59054_REG_TABLE(sdxldo, ldo_1_table),
+	BCM59054_REG_TABLE(mmcldo1, ldo_1_table),
+	BCM59054_REG_TABLE(mmcldo2, ldo_1_table),
+	BCM59054_REG_TABLE(audldo, ldo_1_table),
+	BCM59054_REG_TABLE(micldo, ldo_1_table),
+	BCM59054_REG_TABLE(usbldo, ldo_1_table),
+	BCM59054_REG_TABLE(vibldo, ldo_2_table),
+	BCM59054_REG_RANGES(csr, dcdc_csr_ranges),
+	BCM59054_REG_RANGES(iosr1, dcdc_sr_ranges),
+	BCM59054_REG_RANGES(iosr2, dcdc_sr_ranges),
+	BCM59054_REG_RANGES(mmsr, dcdc_sr_ranges),
+	BCM59054_REG_RANGES(sdsr1, dcdc_sr_ranges),
+	BCM59054_REG_RANGES(sdsr2, dcdc_sr_ranges),
+	BCM59054_REG_RANGES(vsr, dcdc_vsr_ranges),
+	BCM59054_REG_TABLE(gpldo1, ldo_1_table),
+	BCM59054_REG_TABLE(gpldo2, ldo_1_table),
+	BCM59054_REG_TABLE(gpldo3, ldo_1_table),
+	BCM59054_REG_TABLE(tcxldo, ldo_1_table),
+	BCM59054_REG_TABLE(lvldo1, ldo_3_table),
+	BCM59054_REG_TABLE(lvldo2, ldo_3_table),
+	BCM59054_REG_TABLE(vbus, ldo_vbus),
 };
 
-struct bcm590xx_reg {
-	struct regulator_desc *desc;
-	struct bcm590xx *mfd;
-};
+static int bcm590xx_reg_is_ldo(struct bcm590xx_reg *pmu, int id)
+{
+	switch (pmu->mfd->device_type) {
+	case BCM59054_TYPE:
+		return (id < BCM59054_REG_CSR);
+	case BCM59056_TYPE:
+		return (id < BCM59056_REG_CSR);
+	}
+	return -EINVAL;
+}
 
-static int bcm590xx_get_vsel_register(int id)
+static int bcm590xx_reg_is_gpldo(struct bcm590xx_reg *pmu, int id)
 {
-	if (BCM590XX_REG_IS_LDO(id))
-		return BCM590XX_RFLDOCTRL + id;
-	else if (BCM590XX_REG_IS_GPLDO(id))
-		return BCM590XX_GPLDO1CTRL + id;
-	else
-		return BCM590XX_CSRVOUT1 + (id - BCM590XX_REG_CSR) * 3;
+	switch (pmu->mfd->device_type) {
+	case BCM59054_TYPE:
+		return ((id > BCM59054_REG_VSR) && (id < BCM59054_REG_VBUS));
+	case BCM59056_TYPE:
+		return ((id > BCM59056_REG_VSR) && (id < BCM59056_REG_VBUS));
+	}
+	return -EINVAL;
+}
+
+static int bcm590xx_reg_is_vbus(struct bcm590xx_reg *pmu, int id)
+{
+	switch (pmu->mfd->device_type) {
+	case BCM59054_TYPE:
+		return (id == BCM59054_REG_VBUS);
+	case BCM59056_TYPE:
+		return (id == BCM59056_REG_VBUS);
+	}
+	return -EINVAL;
+}
+
+static int bcm590xx_reg_is_static(struct bcm590xx_reg *pmu, int id)
+{
+	return bcm590xx_reg_is_vbus(pmu, id);
+}
+
+static int bcm590xx_reg_is_secondary(struct bcm590xx_reg *pmu, int id)
+{
+	switch (pmu->mfd->device_type) {
+	case BCM59054_TYPE:
+		return (bcm590xx_reg_is_gpldo(pmu, id) || \
+			id == BCM59054_REG_VBUS);
+	case BCM59056_TYPE:
+		return (bcm590xx_reg_is_gpldo(pmu, id) || \
+			id == BCM59056_REG_VBUS);
+	}
+	return -EINVAL;
+}
+
+static int bcm590xx_reg_mode_is_3bit(struct bcm590xx_reg *pmu, int id)
+{
+	switch (pmu->mfd->device_type) {
+	case BCM59054_TYPE:
+		return (id == BCM59054_REG_CSR || \
+			(id > BCM59054_REG_IOSR2 && id < BCM59054_REG_GPLDO1));
+	case BCM59056_TYPE:
+		return false;
+	}
+	return -EINVAL;
+}
+
+static int bcm590xx_get_vsel_register(struct bcm590xx_reg *pmu, int id)
+{
+	switch (pmu->mfd->device_type) {
+	case BCM59054_TYPE:
+		if (bcm590xx_reg_is_ldo(pmu, id))
+			return BCM59054_RFLDOCTRL + (id - BCM59054_REG_RFLDO);
+		else if (bcm590xx_reg_is_gpldo(pmu, id))
+			return BCM59054_GPLDO1CTRL + (id - BCM59054_REG_GPLDO1);
+		else
+			return BCM59054_CSRVOUT1 + (id - BCM59054_REG_CSR) * 3;
+	case BCM59056_TYPE:
+		if (bcm590xx_reg_is_ldo(pmu, id))
+			return BCM59056_RFLDOCTRL + (id - BCM59056_REG_RFLDO);
+		else if (bcm590xx_reg_is_gpldo(pmu, id))
+			return BCM59056_GPLDO1CTRL + (id - BCM59056_REG_GPLDO1);
+		else
+			return BCM59056_CSRVOUT1 + (id - BCM59056_REG_CSR) * 3;
+	}
+	return -EINVAL;
 }
 
-static int bcm590xx_get_enable_register(int id)
+static int bcm59054_get_enable_register(struct bcm590xx_reg *pmu, int id)
 {
 	int reg = 0;
 
-	if (BCM590XX_REG_IS_LDO(id))
-		reg = BCM590XX_RFLDOPMCTRL1 + id * 2;
-	else if (BCM590XX_REG_IS_GPLDO(id))
-		reg = BCM590XX_GPLDO1PMCTRL1 + id * 2;
+	if (bcm590xx_reg_is_ldo(pmu, id))
+		reg = BCM59054_RFLDOPMCTRL1 + (id - BCM59054_REG_RFLDO) * 2;
+	else if (bcm590xx_reg_is_gpldo(pmu, id))
+		reg = BCM59054_GPLDO1PMCTRL1 + (id - BCM59054_REG_GPLDO1) * 2;
 	else
 		switch (id) {
-		case BCM590XX_REG_CSR:
-			reg = BCM590XX_CSRPMCTRL1;
+		case BCM59054_REG_VSR:
+			reg = BCM59054_VSRPMCTRL1;
 			break;
-		case BCM590XX_REG_IOSR1:
-			reg = BCM590XX_IOSR1PMCTRL1;
+		case BCM59054_REG_CSR:
+			reg = BCM59054_CSRPMCTRL1;
 			break;
-		case BCM590XX_REG_IOSR2:
-			reg = BCM590XX_IOSR2PMCTRL1;
+		case BCM59054_REG_MMSR:
+			reg = BCM59054_MMSRPMCTRL1;
 			break;
-		case BCM590XX_REG_MSR:
-			reg = BCM590XX_MSRPMCTRL1;
+		case BCM59054_REG_SDSR1:
+			reg = BCM59054_SDSR1PMCTRL1;
 			break;
-		case BCM590XX_REG_SDSR1:
-			reg = BCM590XX_SDSR1PMCTRL1;
+		case BCM59054_REG_SDSR2:
+			reg = BCM59054_SDSR2PMCTRL1;
 			break;
-		case BCM590XX_REG_SDSR2:
-			reg = BCM590XX_SDSR2PMCTRL1;
+		case BCM59054_REG_IOSR1:
+			reg = BCM59054_IOSR1PMCTRL1;
 			break;
-		case BCM590XX_REG_VSR:
-			reg = BCM590XX_VSRPMCTRL1;
+		case BCM59054_REG_IOSR2:
+			reg = BCM59054_IOSR2PMCTRL1;
 			break;
-		case BCM590XX_REG_VBUS:
-			reg = BCM590XX_OTG_CTRL;
+		case BCM59054_REG_VBUS:
+			reg = BCM59054_OTG_CTRL;
 			break;
 		}
 
+	return reg;
+}
+
+static int bcm59056_get_enable_register(struct bcm590xx_reg *pmu, int id)
+{
+	int reg = 0;
+
+	if (bcm590xx_reg_is_ldo(pmu, id))
+		reg = BCM59056_RFLDOPMCTRL1 + (id - BCM59056_REG_RFLDO) * 2;
+	else if (bcm590xx_reg_is_gpldo(pmu, id))
+		reg = BCM59056_GPLDO1PMCTRL1 + (id - BCM59056_REG_GPLDO1) * 2;
+	else
+		switch (id) {
+		case BCM59056_REG_CSR:
+			reg = BCM59056_CSRPMCTRL1;
+			break;
+		case BCM59056_REG_IOSR1:
+			reg = BCM59056_IOSR1PMCTRL1;
+			break;
+		case BCM59056_REG_IOSR2:
+			reg = BCM59056_IOSR2PMCTRL1;
+			break;
+		case BCM59056_REG_MSR:
+			reg = BCM59056_MSRPMCTRL1;
+			break;
+		case BCM59056_REG_SDSR1:
+			reg = BCM59056_SDSR1PMCTRL1;
+			break;
+		case BCM59056_REG_SDSR2:
+			reg = BCM59056_SDSR2PMCTRL1;
+			break;
+		case BCM59056_REG_VSR:
+			reg = BCM59056_VSRPMCTRL1;
+			break;
+		case BCM59056_REG_VBUS:
+			reg = BCM59056_OTG_CTRL;
+			break;
+		}
 
 	return reg;
 }
 
+static int bcm590xx_get_enable_register(struct bcm590xx_reg *pmu, int id)
+{
+	switch (pmu->mfd->device_type) {
+	case BCM59054_TYPE:
+		return bcm59054_get_enable_register(pmu, id);
+	case BCM59056_TYPE:
+		return bcm59056_get_enable_register(pmu, id);
+	}
+	return -EINVAL;
+}
+
+static int bcm590xx_get_enable_mask(struct bcm590xx_reg *pmu, int id)
+{
+	if (bcm590xx_reg_mode_is_3bit(pmu, id))
+		return BCM590XX_REG_3BIT_ENABLE;
+
+	return BCM590XX_REG_ENABLE;
+}
+
 static const struct regulator_ops bcm590xx_ops_ldo = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
@@ -266,7 +561,7 @@ static const struct regulator_ops bcm590xx_ops_dcdc = {
 	.map_voltage		= regulator_map_voltage_linear_range,
 };
 
-static const struct regulator_ops bcm590xx_ops_vbus = {
+static const struct regulator_ops bcm590xx_ops_static = {
 	.is_enabled		= regulator_is_enabled_regmap,
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
@@ -279,6 +574,7 @@ static int bcm590xx_probe(struct platform_device *pdev)
 	struct regulator_config config = { };
 	struct bcm590xx_info *info;
 	struct regulator_dev *rdev;
+	int n_regulators;
 	int i;
 
 	pmu = devm_kzalloc(&pdev->dev, sizeof(*pmu), GFP_KERNEL);
@@ -289,17 +585,23 @@ static int bcm590xx_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pmu);
 
+	if (pmu->mfd->device_type == BCM59054_TYPE) {
+		info = bcm59054_regs;
+		n_regulators = BCM59054_NUM_REGS;
+	} else if (pmu->mfd->device_type == BCM59056_TYPE) {
+		info = bcm59056_regs;
+		n_regulators = BCM59056_NUM_REGS;
+	}
+
 	pmu->desc = devm_kcalloc(&pdev->dev,
-				 BCM590XX_NUM_REGS,
+				 n_regulators,
 				 sizeof(struct regulator_desc),
 				 GFP_KERNEL);
 	if (!pmu->desc)
 		return -ENOMEM;
 
-	info = bcm590xx_regs;
-
-	for (i = 0; i < BCM590XX_NUM_REGS; i++, info++) {
-		/* Register the regulators */
+	/* Register the regulators */
+	for (i = 0; i < n_regulators; i++, info++) {
 		pmu->desc[i].name = info->name;
 		pmu->desc[i].of_match = of_match_ptr(info->name);
 		pmu->desc[i].regulators_node = of_match_ptr("regulators");
@@ -310,33 +612,37 @@ static int bcm590xx_probe(struct platform_device *pdev)
 		pmu->desc[i].linear_ranges = info->linear_ranges;
 		pmu->desc[i].n_linear_ranges = info->n_linear_ranges;
 
-		if ((BCM590XX_REG_IS_LDO(i)) || (BCM590XX_REG_IS_GPLDO(i))) {
+		if (bcm590xx_reg_is_ldo(pmu, i) || \
+				bcm590xx_reg_is_gpldo(pmu, i)) {
 			pmu->desc[i].ops = &bcm590xx_ops_ldo;
 			pmu->desc[i].vsel_mask = BCM590XX_LDO_VSEL_MASK;
-		} else if (BCM590XX_REG_IS_VBUS(i))
-			pmu->desc[i].ops = &bcm590xx_ops_vbus;
-		else {
+		} else if (bcm590xx_reg_is_static(pmu, i)) {
+			pmu->desc[i].ops = &bcm590xx_ops_static;
+		} else {
 			pmu->desc[i].ops = &bcm590xx_ops_dcdc;
 			pmu->desc[i].vsel_mask = BCM590XX_SR_VSEL_MASK;
 		}
 
-		if (BCM590XX_REG_IS_VBUS(i))
+		if (bcm590xx_reg_is_vbus(pmu, i)) {
 			pmu->desc[i].enable_mask = BCM590XX_VBUS_ENABLE;
-		else {
-			pmu->desc[i].vsel_reg = bcm590xx_get_vsel_register(i);
+		} else {
+			pmu->desc[i].vsel_reg = \
+				bcm590xx_get_vsel_register(pmu, i);
+			pmu->desc[i].enable_mask = \
+				bcm590xx_get_enable_mask(pmu, i);
 			pmu->desc[i].enable_is_inverted = true;
-			pmu->desc[i].enable_mask = BCM590XX_REG_ENABLE;
 		}
-		pmu->desc[i].enable_reg = bcm590xx_get_enable_register(i);
+		pmu->desc[i].enable_reg = \
+			bcm590xx_get_enable_register(pmu, i);
 		pmu->desc[i].type = REGULATOR_VOLTAGE;
 		pmu->desc[i].owner = THIS_MODULE;
 
-		config.dev = bcm590xx->dev;
+		config.dev = pmu->mfd->dev;
 		config.driver_data = pmu;
-		if (BCM590XX_REG_IS_GPLDO(i) || BCM590XX_REG_IS_VBUS(i))
-			config.regmap = bcm590xx->regmap_sec;
+		if (bcm590xx_reg_is_secondary(pmu, i))
+			config.regmap = pmu->mfd->regmap_sec;
 		else
-			config.regmap = bcm590xx->regmap_pri;
+			config.regmap = pmu->mfd->regmap_pri;
 
 		rdev = devm_regulator_register(&pdev->dev, &pmu->desc[i],
 					       &config);

-- 
2.42.0

