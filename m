Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E2F7F2616
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjKUHF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231811AbjKUHFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:05:24 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779CBED;
        Mon, 20 Nov 2023 23:05:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY31m+34OOEneyWC6A+ObW7L0DOhErqPJ4RWgzT7neOnf55MQZBly9qxgxWUSDElKzEXgXNP4sLV/cllOGP3rZoObHHHBHVC7NrjHP/MIbT4FBx1WxMKe1ApWqSG18TlB2gN2SZ9UdJb0qbi4KZ/zn1QRPbZYqY2U+f4rw6mWbl3f2v5ymMyzJaoVezPUOcNQ8iYRDN5kHE6wTKE2zExNsxcTE2UJcfmb3IJ0JEq1vrcCE9rtqkhTXwcHSlTdRtAM2rWWFzTWo3lCWK/qEXrDSvHZzA+Ajeb+R+DUSuInn9ZhZHH7zbCCetirM7WNn9+zkzdCDn7OgkSn4eGg/g1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+0H1J1dDoxVUlvhcUvSKjdx+LBMlWIYAdsVDlDju7Y=;
 b=HL8j+R0op90YKog3+2Rr+vkOS47uFPQNRTOGUDrQ9MYRGk1r8qT6P9bKh+V49Wk4RR5MGUsraQs33h41NzbfxYSMMUzfroKEyX65089OSGH6jtW+xbVEoKGxQ/Av0uvph9nb6gWqxvvuxcUoxls1ZWQLDJ4Y0g4kg10ztHwf48v4RD28UvrsktzIZQ5VBEgOs2uPXANQkOdLl2C1lK2HOyRmFsD8sd6xFW6g9SiU7w4xJqLhxw1vnIJfmT8bPgFeVzAI5sG24ltAblvS/lHsqfwyBc4QvApqgs9LF0MTwoPCti8R2S9UOUZhiBiVm9TVsWgQMpgoF2jUN8IITT5U1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+0H1J1dDoxVUlvhcUvSKjdx+LBMlWIYAdsVDlDju7Y=;
 b=ZwlChEhPzcEXzsYB35YY80sA6r9cWQR4Y1nAd+eqW+5ETTgTRG3o+N5vD2nT7EoKfPMR0pSmpymvnXH6FWDB4vYb219u9b7zG+A9aXA4NocLiDglnzlOiLOxp76+XycVgBLrTkZeMU5QZFGQae7pZ/PEuk1aU34zt3z9t8TbhIU=
Received: from DB8P191CA0013.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::23)
 by DB3PR0202MB8963.eurprd02.prod.outlook.com (2603:10a6:10:435::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:05:16 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::73) by DB8P191CA0013.outlook.office365.com
 (2603:10a6:10:130::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 07:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:05:15 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 08:05:15 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 08:05:15 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id C2FC9E4C9;
        Tue, 21 Nov 2023 08:05:14 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 3AL75DTB3061392;
        Tue, 21 Nov 2023 15:05:13 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 3AL75DNA3061391;
        Tue, 21 Nov 2023 15:05:13 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH v3 2/2] power: supply: bq24190_charger: Add support for  BQ24296
Date:   Tue, 21 Nov 2023 15:05:05 +0800
Message-ID: <20231121070505.3061304-3-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121070505.3061304-1-Hermes.Zhang@axis.com>
References: <20231121070505.3061304-1-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|DB3PR0202MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 17d76668-efb9-4b41-9984-08dbea6036c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z9dAyPwICQdyS9ZTGfJXOf/jZvPCld0jU1hmVa328D8/XlT+nYt5wQLPRv89ozKC3NUfoK49bGcESjXPoOJBtEQqe8ajfR45LNh4g9D1zWvj9dgUqBYKmnYuX1WBO/fb+MKRJinFihbKchLsxd3Ru9xkE9sOhq9esZNimzraletwKzuhG/gy1w8B5e5HmWRH8SZFjpwgoz0i1yxKbXTVxWFTpvOwo91H/y1knyvGtLnbuLi4cbENdUdrGGV3hNmCQ/wo9nsG/m+eqrv/imCn7yi5Ac1/loUy873PHiQSeTaLJY+nlBu6QNUFqAZGrqQxEkMVCSp53tZWkRZzLGSFUkB/WaqZ4aL9NZvw2QPTsLLAdevuEba6fLxMNzaTDeowPomRDwWMozDd5mcrtCx2RdBYuY6uc80ODD8/NaTL5Bcj9gBsSOAURsMFtrWvtIhHnPTGvoVNYS9RB9e/8/twhxa9mFrqRVXNnjF7pdGB90JFTlwTHjbWyMBIWXF59ZTFJylEMnp4vfoajUHNMxroOGs5ffuwEZmvVSf4hG4pjRRQ1OPi3Zg6RQXGi26K1agyyVlj1+92x4+8UATJMaDiCGg4uy2JUFHGUptIxRgJDKhvD7rykupbZ8qOqV+qoSi0Y6UIv24THNb3z/B0V5589eIEz/HRMalZ4l11mKXcsNWDEDR5cDIPyn5eROjCtXtvUt7IwHlKl+JOv3giauA0aWSZJUMnw5TQt/ThUNxjlDRgNUIEuaJWQtyBCDbbc5ehExXnFxTgsn2Voc3Ipm26XA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39850400004)(346002)(396003)(230922051799003)(186009)(82310400011)(64100799003)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(316002)(110136005)(42186006)(54906003)(70206006)(70586007)(36756003)(6666004)(426003)(336012)(40140700001)(2616005)(26005)(1076003)(478600001)(81166007)(82740400003)(356005)(83380400001)(36860700001)(86362001)(47076005)(40480700001)(30864003)(5660300002)(2906002)(4326008)(8936002)(41300700001)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:05:15.9308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d76668-efb9-4b41-9984-08dbea6036c8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0202MB8963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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

 drivers/power/supply/bq24190_charger.c | 445 +++++++++++++++++++------
 1 file changed, 342 insertions(+), 103 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 1db290ee2591..23d05ad45f0b 100644
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
@@ -228,6 +202,66 @@ static const int bq24190_ictrc_treg_values[] = {
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
+	struct regulator_desc vbus_desc;
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
@@ -529,6 +563,43 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
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
@@ -567,6 +638,43 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
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
@@ -583,6 +691,22 @@ static const struct regulator_desc bq24190_vbus_desc = {
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
@@ -602,7 +726,7 @@ static int bq24190_register_vbus_regulator(struct bq24190_dev_info *bdi)
 	else
 		cfg.init_data = &bq24190_vbus_init_data;
 	cfg.driver_data = bdi;
-	reg = devm_regulator_register(bdi->dev, &bq24190_vbus_desc, &cfg);
+	reg = devm_regulator_register(bdi->dev, &bdi->info->vbus_desc, &cfg);
 	if (IS_ERR(reg)) {
 		ret = PTR_ERR(reg);
 		dev_err(bdi->dev, "Can't register regulator: %d\n", ret);
@@ -678,7 +802,7 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 					    BQ24190_REG_CCC_ICHG_MASK,
 					    BQ24190_REG_CCC_ICHG_SHIFT,
 					    bq24190_ccc_ichg_values,
-					    ARRAY_SIZE(bq24190_ccc_ichg_values),
+					    bdi->info->ichg_array_size,
 					    bdi->ichg);
 		if (ret < 0)
 			return ret;
@@ -777,6 +901,24 @@ static int bq24190_charger_get_charge_type(struct bq24190_dev_info *bdi,
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
@@ -835,9 +977,50 @@ static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
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
@@ -850,21 +1033,8 @@ static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
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
@@ -1015,7 +1185,7 @@ static int bq24190_charger_get_current(struct bq24190_dev_info *bdi,
 	ret = bq24190_get_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
-			ARRAY_SIZE(bq24190_ccc_ichg_values), &curr);
+			bdi->info->ichg_array_size, &curr);
 	if (ret < 0)
 		return ret;
 
@@ -1055,7 +1225,7 @@ static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 	ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
-			ARRAY_SIZE(bq24190_ccc_ichg_values), curr);
+			bdi->info->ichg_array_size, curr);
 	if (ret < 0)
 		return ret;
 
@@ -1395,26 +1565,9 @@ static int bq24190_battery_get_health(struct bq24190_dev_info *bdi,
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
@@ -1601,12 +1754,13 @@ static int bq24190_configure_usb_otg(struct bq24190_dev_info *bdi, u8 ss_reg)
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
@@ -1633,7 +1787,7 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
+			!!(f_reg & bdi->info->ntc_fault_mask));
 
 		mutex_lock(&bdi->f_reg_lock);
 		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
@@ -1696,12 +1850,11 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
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
@@ -1719,6 +1872,40 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
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
@@ -1736,7 +1923,8 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 	struct power_supply_battery_info *info;
 	int v, idx;
 
-	idx = ARRAY_SIZE(bq24190_ccc_ichg_values) - 1;
+	idx = bdi->info->ichg_array_size - 1;
+
 	bdi->ichg_max = bq24190_ccc_ichg_values[idx];
 
 	idx = ARRAY_SIZE(bq24190_cvc_vreg_values) - 1;
@@ -1781,6 +1969,54 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 	return 0;
 }
 
+static const struct bq24190_chip_info bq24190_chip_info_tbl[] = {
+	[BQ24190] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+		.vbus_desc = bq24190_vbus_desc,
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24192] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+		.vbus_desc = bq24190_vbus_desc,
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24192i] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+		.vbus_desc = bq24190_vbus_desc,
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24196] = {
+		.ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values),
+		.vbus_desc = bq24190_vbus_desc,
+		.check_chip = bq24190_check_chip,
+		.set_chg_config = bq24190_battery_set_chg_config,
+		.ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK,
+		.get_ntc_status = bq24190_charger_get_ntc_status,
+		.set_otg_vbus = bq24190_set_otg_vbus,
+	},
+	[BQ24296] = {
+		.ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN,
+		.vbus_desc = bq24296_vbus_desc,
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
@@ -1804,6 +2040,7 @@ static int bq24190_probe(struct i2c_client *client)
 	bdi->client = client;
 	bdi->dev = dev;
 	strscpy(bdi->model_name, id->name, sizeof(bdi->model_name));
+	bdi->info = i2c_get_match_data(client);
 	mutex_init(&bdi->f_reg_lock);
 	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	bdi->f_reg = 0;
@@ -1940,7 +2177,7 @@ static void bq24190_shutdown(struct i2c_client *client)
 	struct bq24190_dev_info *bdi = i2c_get_clientdata(client);
 
 	/* Turn off 5V boost regulator on shutdown */
-	bq24190_set_otg_vbus(bdi, false);
+	bdi->info->set_otg_vbus(bdi, false);
 }
 
 static __maybe_unused int bq24190_runtime_suspend(struct device *dev)
@@ -2029,19 +2266,21 @@ static const struct dev_pm_ops bq24190_pm_ops = {
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

