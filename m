Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2194809AAD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 04:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573120AbjLHDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 22:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573107AbjLHDrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 22:47:22 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0181712;
        Thu,  7 Dec 2023 19:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=etaF+um9hs5iwzG9VsTUbh4p0jwkvXGLqUGow6LESUvsZb/JmV+u7pFc0VY74Ha1VXDIxdBF1bYwIUw/bXbLJ8ZNIPtMXjQKexhNRXQhJxS3RIz0SzPkpM0P/bO9tepYq20M4UJ6qGykrxxch1/vvEL4a9TZYjQzL3olvBJDaH22eGY8/w8cAKglB8qXF/bWBIU0MPQy084oXSVQTLmg/HZtjjrKqBAuWzl9xEjusOoU+JAea4+gRMTZb2HFqYFPG0C053KMp1JfIUxNvHqcBP/daq0lPfG166L5KsfoN4Yt5+mQVaNto8+e+F1Bcxb5tZsITiqlLHcIfAxZRyzRZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RNLqeStcbMhiXWbh5ZB7UKjCZH2hPuYNHaaUFTlOJVY=;
 b=LgqaAgtBWtEMG4f3Td4GNui4SkJXtVWjLTcvST4sbUIdtmVCSKDOvBeYoM3Eyjw4OytcM76pcnmzneCrWXNkK1bFyYe7Uk/F353ZRP5dg446qgGmye/r7o5Q3UaKTByNhEwAoUfAPAaQznGWV31nCwpTZ4mlsZB/4E301/cvGHmeF6UYScqd8JQhitqS5MYxUK+rl7PLvy35j6NH85P/yCEKyGEPdy6/eBTljkf0Mvg6kYnbfR6+NEkGQB+elIHGe9Q8LBqqzmwfbFd6P8E8jsNQelrLuh2JOL6U1OTNqvyfgv7h+58EODg9XQrOBsYNBG72cc46Ziy+1ytU3pcogA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RNLqeStcbMhiXWbh5ZB7UKjCZH2hPuYNHaaUFTlOJVY=;
 b=nCa8lVYrR0cEnvdZ72NBml38TOuBGavcC7ayUfsBaC3vA4/HSI7tBVWL2P98dIFfq3XwHnX7BO3nzChqOHtAYRUFGaM6EqZEztpSbJ8ReuR+tnjkBGG3tW9BqDQuIJsMr6B1CP2moQF+qcjeLTQCwJNhmOxx0wMWzI0w3WkaGy4=
Received: from AS9PR04CA0118.eurprd04.prod.outlook.com (2603:10a6:20b:531::14)
 by DB9PR02MB6506.eurprd02.prod.outlook.com (2603:10a6:10:212::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 03:47:23 +0000
Received: from AM1PEPF000252DF.eurprd07.prod.outlook.com
 (2603:10a6:20b:531:cafe::14) by AS9PR04CA0118.outlook.office365.com
 (2603:10a6:20b:531::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28 via Frontend
 Transport; Fri, 8 Dec 2023 03:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM1PEPF000252DF.mail.protection.outlook.com (10.167.16.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Fri, 8 Dec 2023 03:47:22 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 8 Dec
 2023 04:47:18 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 8 Dec 2023 04:47:18 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 8A917F7DC;
        Fri,  8 Dec 2023 04:47:18 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 3B83lHtb1248445;
        Fri, 8 Dec 2023 11:47:17 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 3B83lHmO1248444;
        Fri, 8 Dec 2023 11:47:17 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH v4 2/2] power: supply: bq24190_charger: Add support for BQ24296
Date:   Fri, 8 Dec 2023 11:47:08 +0800
Message-ID: <20231208034708.1248389-3-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231208034708.1248389-1-Hermes.Zhang@axis.com>
References: <20231208034708.1248389-1-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DF:EE_|DB9PR02MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: a210a8dd-337f-4003-8f5a-08dbf7a062e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OiU3mTjGZlXhMVLdu89pnAmuNSswl84aVAFfw5G8c8Dp061LT5TptJqyJU8eTJDeg7lSBc8hoCqkN05und4hCAs9hV0giues3DKNF1Rn11qDY+UhpLXLwfKKZNNZiS4g9yWCNtEEKtuyYp1diJMNGd84a8iMeXjVQrfxTREvgBOZ6cRS/GZbku4cPx2tZZBu1vLH9ElZImhlnhG17zuDBA12EG4ywOHUL8WIWN1RFHESMuFdwESzz2HIWz6J99+3KXY2IR8Lo28fAp8VcfxpvW2FjTx9X6UYEEosMKjIBH5N5/gxpVlLMJ+G+dhkaNQydPcA6ujq4rqenegx9WY9D+vVeDSNzWInzJTZnvMbwQHra3GBG2a/HyhLSPauz++aNLeUowJtE0IPQ+TMvTMJ/rhQYxOfULRzp5i6PzScUMMVfyE900vPf99DWkIW9m71B/nAA9ODzzfSD1ALoWIMmaGAt77c9qQbC/RJIxtRFIaVl68PqCMHmEbhvF9RSyZAoMY4nMEXKMYE/4SIeWSG+VJiqCWIyFNk0k9KUcKrF59H6iYkjbG/+tNqsQvBbVYE6VzCPd3zAMNUUiTFSr8brsUjE5VxAmEp5bSULSxKieZYk2iuw+UToL57g6fiWf9jYImrNztl3ylOYV6/5/37NiyzxSwIK4h5+TZulttR2eMLgw3n4rBCbGYhbQvO1R8dtE2zG7wT7AIH3E+GB/mtuYJ8h15r1F0pSji5H4abcAOPAq0w7aYCI61J91fU4Ph6jSN4cFUFukdKL+o20nncDw==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(47076005)(40140700001)(1076003)(426003)(336012)(26005)(2616005)(6666004)(83380400001)(36860700001)(40480700001)(478600001)(70586007)(70206006)(54906003)(42186006)(110136005)(316002)(8936002)(4326008)(8676002)(40460700003)(36756003)(5660300002)(2906002)(30864003)(86362001)(356005)(81166007)(82740400003)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 03:47:22.8587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a210a8dd-337f-4003-8f5a-08dbf7a062e2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DF.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6506
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

The BQ24296 is most similar to the BQ24196, but the:
1. OTG config is split from CHG config (REG01)
2. ICHG (Fast Charge Current limit) range is smaller (<=3008mA)
3. NTC fault is simplified to 2 bits

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
---

Notes:
    v2: restructured the code to support bq24296 and add Acked-by tag
        from Conor
    v3: handle the match_info in the modern way
    v4: fix compile errors

 drivers/power/supply/bq24190_charger.c | 457 +++++++++++++++++++------
 1 file changed, 354 insertions(+), 103 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 1db290ee2591..a8995a21fadb 100644
--- a/drivers/power/supply/bq24190_charger.c
+++ b/drivers/power/supply/bq24190_charger.c
@@ -36,10 +36,16 @@
 #define BQ24190_REG_POC_WDT_RESET_SHIFT		6
 #define BQ24190_REG_POC_CHG_CONFIG_MASK		(BIT(5) | BIT(4))
 #define BQ24190_REG_POC_CHG_CONFIG_SHIFT	4
-#define BQ24190_REG_POC_CHG_CONFIG_DISABLE		0x0
-#define BQ24190_REG_POC_CHG_CONFIG_CHARGE		0x1
-#define BQ24190_REG_POC_CHG_CONFIG_OTG			0x2
-#define BQ24190_REG_POC_CHG_CONFIG_OTG_ALT		0x3
+#define BQ24190_REG_POC_CHG_CONFIG_DISABLE	0x0
+#define BQ24190_REG_POC_CHG_CONFIG_CHARGE	0x1
+#define BQ24190_REG_POC_CHG_CONFIG_OTG		0x2
+#define BQ24190_REG_POC_CHG_CONFIG_OTG_ALT	0x3
+#define BQ24296_REG_POC_OTG_CONFIG_MASK		BIT(5)
+#define BQ24296_REG_POC_OTG_CONFIG_SHIFT	5
+#define BQ24296_REG_POC_CHG_CONFIG_MASK		BIT(4)
+#define BQ24296_REG_POC_CHG_CONFIG_SHIFT	4
+#define BQ24296_REG_POC_OTG_CONFIG_DISABLE	0x0
+#define BQ24296_REG_POC_OTG_CONFIG_OTG		0x1
 #define BQ24190_REG_POC_SYS_MIN_MASK		(BIT(3) | BIT(2) | BIT(1))
 #define BQ24190_REG_POC_SYS_MIN_SHIFT		1
 #define BQ24190_REG_POC_SYS_MIN_MIN			3000
@@ -134,58 +140,23 @@
 #define BQ24190_REG_F_BAT_FAULT_SHIFT		3
 #define BQ24190_REG_F_NTC_FAULT_MASK		(BIT(2) | BIT(1) | BIT(0))
 #define BQ24190_REG_F_NTC_FAULT_SHIFT		0
+#define BQ24296_REG_F_NTC_FAULT_MASK		(BIT(1) | BIT(0))
+#define BQ24296_REG_F_NTC_FAULT_SHIFT		0
 
 #define BQ24190_REG_VPRS	0x0A /* Vendor/Part/Revision Status */
 #define BQ24190_REG_VPRS_PN_MASK		(BIT(5) | BIT(4) | BIT(3))
 #define BQ24190_REG_VPRS_PN_SHIFT		3
-#define BQ24190_REG_VPRS_PN_24190			0x4
-#define BQ24190_REG_VPRS_PN_24192			0x5 /* Also 24193, 24196 */
-#define BQ24190_REG_VPRS_PN_24192I			0x3
+#define BQ24190_REG_VPRS_PN_24190		0x4
+#define BQ24190_REG_VPRS_PN_24192		0x5 /* Also 24193, 24196 */
+#define BQ24190_REG_VPRS_PN_24192I		0x3
+#define BQ24296_REG_VPRS_PN_MASK		(BIT(7) | BIT(6) | BIT(5))
+#define BQ24296_REG_VPRS_PN_SHIFT		5
+#define BQ24296_REG_VPRS_PN_24296		0x1
 #define BQ24190_REG_VPRS_TS_PROFILE_MASK	BIT(2)
 #define BQ24190_REG_VPRS_TS_PROFILE_SHIFT	2
 #define BQ24190_REG_VPRS_DEV_REG_MASK		(BIT(1) | BIT(0))
 #define BQ24190_REG_VPRS_DEV_REG_SHIFT		0
 
-/*
- * The FAULT register is latched by the bq24190 (except for NTC_FAULT)
- * so the first read after a fault returns the latched value and subsequent
- * reads return the current value.  In order to return the fault status
- * to the user, have the interrupt handler save the reg's value and retrieve
- * it in the appropriate health/status routine.
- */
-struct bq24190_dev_info {
-	struct i2c_client		*client;
-	struct device			*dev;
-	struct extcon_dev		*edev;
-	struct power_supply		*charger;
-	struct power_supply		*battery;
-	struct delayed_work		input_current_limit_work;
-	char				model_name[I2C_NAME_SIZE];
-	bool				initialized;
-	bool				irq_event;
-	bool				otg_vbus_enabled;
-	int				charge_type;
-	u16				sys_min;
-	u16				iprechg;
-	u16				iterm;
-	u32				ichg;
-	u32				ichg_max;
-	u32				vreg;
-	u32				vreg_max;
-	struct mutex			f_reg_lock;
-	u8				f_reg;
-	u8				ss_reg;
-	u8				watchdog;
-};
-
-static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
-					   const union power_supply_propval *val);
-
-static const unsigned int bq24190_usb_extcon_cable[] = {
-	EXTCON_USB,
-	EXTCON_NONE,
-};
-
 /*
  * The tables below provide a 2-way mapping for the value that goes in
  * the register field and the real-world value that it represents.
@@ -211,6 +182,9 @@ static const int bq24190_ccc_ichg_values[] = {
 	4096000, 4160000, 4224000, 4288000, 4352000, 4416000, 4480000, 4544000
 };
 
+/* ICHG higher than 3008mA is not supported in BQ24296 */
+#define BQ24296_CCC_ICHG_VALUES_LEN	40
+
 /* REG04[7:2] (VREG) in uV */
 static const int bq24190_cvc_vreg_values[] = {
 	3504000, 3520000, 3536000, 3552000, 3568000, 3584000, 3600000, 3616000,
@@ -228,6 +202,68 @@ static const int bq24190_ictrc_treg_values[] = {
 	600, 800, 1000, 1200
 };
 
+enum bq24190_chip {
+	BQ24190,
+	BQ24192,
+	BQ24192i,
+	BQ24196,
+	BQ24296,
+};
+
+/*
+ * The FAULT register is latched by the bq24190 (except for NTC_FAULT)
+ * so the first read after a fault returns the latched value and subsequent
+ * reads return the current value.  In order to return the fault status
+ * to the user, have the interrupt handler save the reg's value and retrieve
+ * it in the appropriate health/status routine.
+ */
+struct bq24190_dev_info {
+	struct i2c_client		*client;
+	struct device			*dev;
+	struct extcon_dev		*edev;
+	struct power_supply		*charger;
+	struct power_supply		*battery;
+	struct delayed_work		input_current_limit_work;
+	char				model_name[I2C_NAME_SIZE];
+	bool				initialized;
+	bool				irq_event;
+	bool				otg_vbus_enabled;
+	int				charge_type;
+	u16				sys_min;
+	u16				iprechg;
+	u16				iterm;
+	u32				ichg;
+	u32				ichg_max;
+	u32				vreg;
+	u32				vreg_max;
+	struct mutex			f_reg_lock;
+	u8				f_reg;
+	u8				ss_reg;
+	u8				watchdog;
+	const struct bq24190_chip_info	*info;
+};
+
+struct bq24190_chip_info {
+	int ichg_array_size;
+#ifdef CONFIG_REGULATOR
+	const struct regulator_desc vbus_desc;
+#endif
+	int (*check_chip)(struct bq24190_dev_info *bdi);
+	int (*set_chg_config)(struct bq24190_dev_info *bdi, const u8 chg_config);
+	int (*set_otg_vbus)(struct bq24190_dev_info *bdi, bool enable);
+	u8 ntc_fault_mask;
+	int (*get_ntc_status)(const u8 value);
+};
+
+static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
+					   const union power_supply_propval *val);
+
+static const unsigned int bq24190_usb_extcon_cable[] = {
+	EXTCON_USB,
+	EXTCON_NONE,
+};
+
+
 /*
  * Return the index in 'tbl' of greatest value that is less than or equal to
  * 'val'.  The index range returned is 0 to 'tbl_size' - 1.  Assumes that
@@ -529,6 +565,43 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 	return ret;
 }
 
+static int bq24296_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
+{
+	int ret;
+
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0) {
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
+		return ret;
+	}
+
+	bdi->otg_vbus_enabled = enable;
+	if (enable) {
+		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					 BQ24296_REG_POC_CHG_CONFIG_MASK,
+					 BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+					 BQ24190_REG_POC_CHG_CONFIG_DISABLE);
+
+		if (ret < 0)
+			goto out;
+
+		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					 BQ24296_REG_POC_OTG_CONFIG_MASK,
+					 BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+					 BQ24296_REG_POC_OTG_CONFIG_OTG);
+	} else
+		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					 BQ24296_REG_POC_OTG_CONFIG_MASK,
+					 BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+					 BQ24296_REG_POC_OTG_CONFIG_DISABLE);
+
+out:
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
+	return ret;
+}
+
 #ifdef CONFIG_REGULATOR
 static int bq24190_vbus_enable(struct regulator_dev *dev)
 {
@@ -567,6 +640,43 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 	return bdi->otg_vbus_enabled;
 }
 
+static int bq24296_vbus_enable(struct regulator_dev *dev)
+{
+	return bq24296_set_otg_vbus(rdev_get_drvdata(dev), true);
+}
+
+static int bq24296_vbus_disable(struct regulator_dev *dev)
+{
+	return bq24296_set_otg_vbus(rdev_get_drvdata(dev), false);
+}
+
+static int bq24296_vbus_is_enabled(struct regulator_dev *dev)
+{
+	struct bq24190_dev_info *bdi = rdev_get_drvdata(dev);
+	int ret;
+	u8 val;
+
+	ret = pm_runtime_resume_and_get(bdi->dev);
+	if (ret < 0) {
+		dev_warn(bdi->dev, "pm_runtime_get failed: %i\n", ret);
+		return ret;
+	}
+
+	ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
+				BQ24296_REG_POC_OTG_CONFIG_MASK,
+				BQ24296_REG_POC_OTG_CONFIG_SHIFT, &val);
+
+	pm_runtime_mark_last_busy(bdi->dev);
+	pm_runtime_put_autosuspend(bdi->dev);
+
+	if (ret)
+		return ret;
+
+	bdi->otg_vbus_enabled = (val == BQ24296_REG_POC_OTG_CONFIG_OTG);
+
+	return bdi->otg_vbus_enabled;
+}
+
 static const struct regulator_ops bq24190_vbus_ops = {
 	.enable = bq24190_vbus_enable,
 	.disable = bq24190_vbus_disable,
@@ -583,6 +693,22 @@ static const struct regulator_desc bq24190_vbus_desc = {
 	.n_voltages = 1,
 };
 
+static const struct regulator_ops bq24296_vbus_ops = {
+	.enable = bq24296_vbus_enable,
+	.disable = bq24296_vbus_disable,
+	.is_enabled = bq24296_vbus_is_enabled,
+};
+
+static const struct regulator_desc bq24296_vbus_desc = {
+	.name = "usb_otg_vbus",
+	.of_match = "usb-otg-vbus",
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+	.ops = &bq24296_vbus_ops,
+	.fixed_uV = 5000000,
+	.n_voltages = 1,
+};
+
 static const struct regulator_init_data bq24190_vbus_init_data = {
 	.constraints = {
 		.valid_ops_mask = REGULATOR_CHANGE_STATUS,
@@ -602,7 +728,7 @@ static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
 	else
 		cfg.init_data = &bq24190_vbus_init_data;
 	cfg.driver_data = bdi;
-	reg = devm_regulator_register(bdi->dev, &bq24190_vbus_desc, &cfg);
+	reg = devm_regulator_register(bdi->dev, &bdi->info->vbus_desc, &cfg);
 	if (IS_ERR(reg)) {
 		ret = PTR_ERR(reg);
 		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
@@ -678,7 +804,7 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 					    BQ24190_REG_CCC_ICHG_MASK,
 					    BQ24190_REG_CCC_ICHG_SHIFT,
 					    bq24190_ccc_ichg_values,
-					    ARRAY_SIZE(bq24190_ccc_ichg_values),
+					    bdi->info->ichg_array_size,
 					    bdi->ichg);
 		if (ret < 0)
 			return ret;
@@ -777,6 +903,24 @@ static int bq24190_charger_get_charge_type(struct bq24190_dev_info *bdi,
 	return 0;
 }
 
+static int bq24190_battery_set_chg_config(struct bq24190_dev_info *bdi,
+		const u8 chg_config)
+{
+	return bq24190_write_mask(bdi, BQ24190_REG_POC,
+			BQ24190_REG_POC_CHG_CONFIG_MASK,
+			BQ24190_REG_POC_CHG_CONFIG_SHIFT,
+			chg_config);
+}
+
+static int bq24296_battery_set_chg_config(struct bq24190_dev_info *bdi,
+		const u8 chg_config)
+{
+	return bq24190_write_mask(bdi, BQ24190_REG_POC,
+			BQ24296_REG_POC_CHG_CONFIG_MASK,
+			BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+			chg_config);
+}
+
 static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
 		const union power_supply_propval *val)
 {
@@ -835,9 +979,50 @@ static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
 			return ret;
 	}
 
-	return bq24190_write_mask(bdi, BQ24190_REG_POC,
-			BQ24190_REG_POC_CHG_CONFIG_MASK,
-			BQ24190_REG_POC_CHG_CONFIG_SHIFT, chg_config);
+	return bdi->info->set_chg_config(bdi, chg_config);
+}
+
+static int bq24190_charger_get_ntc_status(u8 value)
+{
+	int health;
+
+	switch (value >> BQ24190_REG_F_NTC_FAULT_SHIFT & 0x7) {
+	case 0x1: /* TS1  Cold */
+	case 0x3: /* TS2  Cold */
+	case 0x5: /* Both Cold */
+		health = POWER_SUPPLY_HEALTH_COLD;
+		break;
+	case 0x2: /* TS1  Hot */
+	case 0x4: /* TS2  Hot */
+	case 0x6: /* Both Hot */
+		health = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	default:
+		health = POWER_SUPPLY_HEALTH_UNKNOWN;
+	}
+
+	return health;
+}
+
+static int bq24296_charger_get_ntc_status(u8 value)
+{
+	int health;
+
+	switch (value >> BQ24296_REG_F_NTC_FAULT_SHIFT & 0x3) {
+	case 0x0: /* Normal */
+		health = POWER_SUPPLY_HEALTH_GOOD;
+		break;
+	case 0x1: /* Hot */
+		health = POWER_SUPPLY_HEALTH_OVERHEAT;
+		break;
+	case 0x2: /* Cold */
+		health = POWER_SUPPLY_HEALTH_COLD;
+		break;
+	default:
+		health = POWER_SUPPLY_HEALTH_UNKNOWN;
+	}
+
+	return health;
 }
 
 static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
@@ -850,21 +1035,8 @@ static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
 	v = bdi->f_reg;
 	mutex_unlock(&bdi->f_reg_lock);
 
-	if (v & BQ24190_REG_F_NTC_FAULT_MASK) {
-		switch (v >> BQ24190_REG_F_NTC_FAULT_SHIFT & 0x7) {
-		case 0x1: /* TS1  Cold */
-		case 0x3: /* TS2  Cold */
-		case 0x5: /* Both Cold */
-			health = POWER_SUPPLY_HEALTH_COLD;
-			break;
-		case 0x2: /* TS1  Hot */
-		case 0x4: /* TS2  Hot */
-		case 0x6: /* Both Hot */
-			health = POWER_SUPPLY_HEALTH_OVERHEAT;
-			break;
-		default:
-			health = POWER_SUPPLY_HEALTH_UNKNOWN;
-		}
+	if (v & bdi->info->ntc_fault_mask) {
+		health = bdi->info->get_ntc_status(v);
 	} else if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
 		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 	} else if (v & BQ24190_REG_F_CHRG_FAULT_MASK) {
@@ -1015,7 +1187,7 @@ static int bq24190_charger_get_current(struct bq24190_dev_info *bdi,
 	ret = bq24190_get_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
-			ARRAY_SIZE(bq24190_ccc_ichg_values), &curr);
+			bdi->info->ichg_array_size, &curr);
 	if (ret < 0)
 		return ret;
 
@@ -1055,7 +1227,7 @@ static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 	ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
-			ARRAY_SIZE(bq24190_ccc_ichg_values), curr);
+			bdi->info->ichg_array_size, curr);
 	if (ret < 0)
 		return ret;
 
@@ -1395,26 +1567,9 @@ static int bq24190_battery_get_health(struct bq24190_dev_info *bdi,
 	if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
 		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 	} else {
-		v &= BQ24190_REG_F_NTC_FAULT_MASK;
-		v >>= BQ24190_REG_F_NTC_FAULT_SHIFT;
+		v &= bdi->info->ntc_fault_mask;
 
-		switch (v) {
-		case 0x0: /* Normal */
-			health = POWER_SUPPLY_HEALTH_GOOD;
-			break;
-		case 0x1: /* TS1 Cold */
-		case 0x3: /* TS2 Cold */
-		case 0x5: /* Both Cold */
-			health = POWER_SUPPLY_HEALTH_COLD;
-			break;
-		case 0x2: /* TS1 Hot */
-		case 0x4: /* TS2 Hot */
-		case 0x6: /* Both Hot */
-			health = POWER_SUPPLY_HEALTH_OVERHEAT;
-			break;
-		default:
-			health = POWER_SUPPLY_HEALTH_UNKNOWN;
-		}
+		health = v ? bdi->info->get_ntc_status(v) : POWER_SUPPLY_HEALTH_GOOD;
 	}
 
 	val->intval = health;
@@ -1601,12 +1756,13 @@ static int bq24190_configure_usb_otg(struct bq24190_dev_info *bdi, u8 ss_reg)
 static void bq24190_check_status(struct bq24190_dev_info *bdi)
 {
 	const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
-	const u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK
-				| BQ24190_REG_F_NTC_FAULT_MASK;
+	u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK;
 	bool alert_charger = false, alert_battery = false;
 	u8 ss_reg = 0, f_reg = 0;
 	int i, ret;
 
+	battery_mask_f |= bdi->info->ntc_fault_mask;
+
 	ret = bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
 	if (ret < 0) {
 		dev_err(bdi->dev, "Can't read SS reg: %d\n", ret);
@@ -1633,7 +1789,7 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
+			!!(f_reg & bdi->info->ntc_fault_mask));
 
 		mutex_lock(&bdi->f_reg_lock);
 		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
@@ -1696,12 +1852,11 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static int bq24190_hw_init(struct bq24190_dev_info *bdi)
+static int bq24190_check_chip(struct bq24190_dev_info *bdi)
 {
 	u8 v;
 	int ret;
 
-	/* First check that the device really is what its supposed to be */
 	ret = bq24190_read_mask(bdi, BQ24190_REG_VPRS,
 			BQ24190_REG_VPRS_PN_MASK,
 			BQ24190_REG_VPRS_PN_SHIFT,
@@ -1719,6 +1874,40 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
 		return -ENODEV;
 	}
 
+	return 0;
+}
+
+static int bq24296_check_chip(struct bq24190_dev_info *bdi)
+{
+	u8 v;
+	int ret;
+
+	ret = bq24190_read_mask(bdi, BQ24190_REG_VPRS,
+			BQ24296_REG_VPRS_PN_MASK,
+			BQ24296_REG_VPRS_PN_SHIFT,
+			&v);
+	if (ret < 0)
+		return ret;
+
+	switch (v) {
+	case BQ24296_REG_VPRS_PN_24296:
+		break;
+	default:
+		dev_err(bdi->dev, "Error unknown model: 0x%02x\n", v);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static int bq24190_hw_init(struct bq24190_dev_info *bdi)
+{
+	int ret;
+
+	ret = bdi->info->check_chip(bdi);
+	if (ret < 0)
+		return ret;
+
 	ret = bq24190_register_reset(bdi);
 	if (ret < 0)
 		return ret;
@@ -1736,7 +1925,8 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 	struct power_supply_battery_info *info;
 	int v, idx;
 
-	idx = ARRAY_SIZE(bq24190_ccc_ichg_values) - 1;
+	idx = bdi->info->ichg_array_size - 1;
+
 	bdi->ichg_max = bq24190_ccc_ichg_values[idx];
 
 	idx = ARRAY_SIZE(bq24190_cvc_vreg_values) - 1;
@@ -1781,6 +1971,64 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 	return 0;
 }
 
+static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
+	[BQ24190] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+#ifdef CONFIG_REGULATOR
+		.vbus_desc = bq24190_vbus_desc,
+#endif
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24192] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+#ifdef CONFIG_REGULATOR
+		.vbus_desc = bq24190_vbus_desc,
+#endif
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24192i] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+#ifdef CONFIG_REGULATOR
+		.vbus_desc = bq24190_vbus_desc,
+#endif
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24196] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+#ifdef CONFIG_REGULATOR
+		.vbus_desc = bq24190_vbus_desc,
+#endif
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24296] = {
+		.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
+#ifdef CONFIG_REGULATOR
+		.vbus_desc = bq24296_vbus_desc,
+#endif
+		.check_chip = bq24296_check_chip,
+		.set_chg_config = bq24296_battery_set_chg_config,
+		.ntc_fault_mask = BQ24296_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24296_charger_get_ntc_status,
+		.set_otg_vbus = bq24296_set_otg_vbus,
+	},
+};
+
 static int bq24190_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -1804,6 +2052,7 @@ static int bq24190_probe(struct i2c_client *client)
 	bdi->client = client;
 	bdi->dev = dev;
 	strscpy(bdi->model_name, id->name, sizeof(bdi->model_name));
+	bdi->info = i2c_get_match_data(client);
 	mutex_init(&bdi->f_reg_lock);
 	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	bdi->f_reg = 0;
@@ -1940,7 +2189,7 @@ static void bq24190_shutdown(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 
 	/* Turn off 5V boost regulator on shutdown */
-	bq24190_set_otg_vbus(bdi, false);
+	bdi->info->set_otg_vbus(bdi, false);
 }
 
 static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
@@ -2029,19 +2278,21 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 };
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {
-	{ "bq24190" },
-	{ "bq24192" },
-	{ "bq24192i" },
-	{ "bq24196" },
+	{ "bq24190", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24190] },
+	{ "bq24192", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192] },
+	{ "bq24192i", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24192i] },
+	{ "bq24196", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24196] },
+	{ "bq24296", (kernel_ulong_t)&bq24190_chip_info_tbl[BQ24296] },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
 
 static const struct of_device_id bq24190_of_match[] = {
-	{ .compatible = "ti,bq24190", },
-	{ .compatible = "ti,bq24192", },
-	{ .compatible = "ti,bq24192i", },
-	{ .compatible = "ti,bq24196", },
+	{ .compatible = "ti,bq24190", .data = &bq24190_chip_info_tbl[BQ24190] },
+	{ .compatible = "ti,bq24192", .data = &bq24190_chip_info_tbl[BQ24192] },
+	{ .compatible = "ti,bq24192i", .data = &bq24190_chip_info_tbl[BQ24192i] },
+	{ .compatible = "ti,bq24196", .data = &bq24190_chip_info_tbl[BQ24196] },
+	{ .compatible = "ti,bq24296", .data = &bq24190_chip_info_tbl[BQ24296] },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-- 
2.39.2

