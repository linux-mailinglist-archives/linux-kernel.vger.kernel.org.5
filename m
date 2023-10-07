Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B327BC416
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbjJGCHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234036AbjJGCHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:07:40 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DEDC2;
        Fri,  6 Oct 2023 19:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foTQdC+g+UrxmDlVUMBqxTmoVghUqFqQk/pOqKN9mzEbpKcek2QipfubNqKhI6STwM5wkIoeft0uRbWgtanpx5LFhhbrG5Ulgjuh6+TBhs4Q1ndwand9OqkWBp28F32kd2M/N2xVdShx9OLZIBVZOgDLJ5NQ/e4xAZj25LqbVNruFveqHHoIeFjV04Pd+oQIg+tJZ95spq1KIglRQa50zz+PFkvWpXZvNlZI22KU1SHbINSn5to25Pd5fV2l52Kv1WKuxGzBThwUESBrExUi51Qkm9MuIjOzBWmqub6EZWpkpitMaNt8ZxYlR9Ug0a596LG/FBYdhDOqjAlTamfd9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW9X9bnnOTdDc/r8zFmr8xltgyAPRNc0bwg0+lUE+70=;
 b=NCVXqMVdQkWJGyXAt0pytD169obf8FvKVB7smtRlwxdPYoCZaxA+fIDp21lp5laDagLXGIeADulbfg1ICQT4T7VHMc8r1GwAyLlT6x8AxlTDFBY4DUw4DX/HZn7KTZic88RvhiBRqJ3xTst/iVz/IPy68dEsMCwFECyr9sjxfZ+KfDpdPoBHJHQOPKVlUuwDj/laR03ENmriO6njj42N8LWdZmnNFjaX+sVPEW4GZN/no5ZWEYRRJEqE1uCebaDKTJfp7w9txX5owIdVFOPJSjXSi/AYS+sk2GqZoRKrO3n1c6S/Rz5qYghXe3NvU5OU6yP8uL0kPsyGbzQL6ZG52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW9X9bnnOTdDc/r8zFmr8xltgyAPRNc0bwg0+lUE+70=;
 b=f1m8gLSFHoiHnbaSbZMKI5SKOwpMLjxrIv5ZmS0hKJVCZZxQgFiM//Xc7j+KF7YpdtyvATtTEklkSsX0u+AawUhDjm1Vl2Jwor/YJdffGOoosABv6kw8TC5myJGdSiQ4Av89X/ZAOnLYYVVv/8m4R4sgAHtQ4XWjpU/0l493t1Q=
Received: from DB8PR06CA0043.eurprd06.prod.outlook.com (2603:10a6:10:120::17)
 by DB9PR02MB6553.eurprd02.prod.outlook.com (2603:10a6:10:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.38; Sat, 7 Oct
 2023 02:07:32 +0000
Received: from DU6PEPF00009525.eurprd02.prod.outlook.com
 (2603:10a6:10:120:cafe::b5) by DB8PR06CA0043.outlook.office365.com
 (2603:10a6:10:120::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Sat, 7 Oct 2023 02:07:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009525.mail.protection.outlook.com (10.167.8.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Sat, 7 Oct 2023 02:07:31 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 7 Oct
 2023 04:07:31 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 7 Oct
 2023 04:07:29 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sat, 7 Oct 2023 04:07:29 +0200
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id CC87B2895;
        Sat,  7 Oct 2023 04:07:28 +0200 (CEST)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.15.2/8.15.2/Debian-22) with ESMTP id 39727RIK1912681;
        Sat, 7 Oct 2023 10:07:27 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.15.2/8.15.2/Submit) id 39727Rnm1912680;
        Sat, 7 Oct 2023 10:07:27 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>, <linux-pm@vger.kernel.org>
Subject: [PATCH 2/2] power: supply: bq24190_charger: Add support for BQ24296
Date:   Sat, 7 Oct 2023 10:07:01 +0800
Message-ID: <20231007020701.1912553-3-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231007020701.1912553-1-Hermes.Zhang@axis.com>
References: <20231007020701.1912553-1-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009525:EE_|DB9PR02MB6553:EE_
X-MS-Office365-Filtering-Correlation-Id: 08114fa4-4d0f-46d7-534c-08dbc6da2a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ElEbjzDU4fxOQtLa/yH9TiuWlmxVQAMJ2CU5GZaOYNttFlcxSHuLC1lbECq6VCJ5SUM2uW31bm5jkdwQzezyNI52vv1ROcxa0m8icYO/l8e1t0T1ceTwKqz4myrbxf2IuIMZIbasA0TYjGf7v1GAUOHoPjaQd154N85ZC+rK+JnTKM4BFJe9yxAMhR3JG4Ok/ddmt3YaELnhHYCTCiV4nN3XKBjXet20PXs6qo3QSboQCeUPQoxMWyDNvZS/DGYcBhG5NDEsAzMXo0MT14Ys9yUJGLwpaBoDXxLVzpiqVhzumO+WCGqmzBnjlUeFWsa/jsKwlx233nJGXeB/z0pRr6b0lV7i/u/YWYDJXcCY9Ws2BVTE2ekGCR5Z2QmPYblt4833vMG4cTlzw56CoDK2eW9TkjTrYgUh3Th4sLTfgLpTTzvPkho3hPf0lXX/i5HxM7G1/IwGHWlWs3HFwZNJxyt22Kf8SSV9H5o3RVl1qebyyAR21BYPQNPL/BOycXH3jM35c7Hc0hy9SilUUcIAh67ZMcfbLJV8JMH4alYGEBsi+eVBhcRatpmEIkpXiqIBWP17iZFj/LOnp1AsgjTM+TPcsermPQ3zFoY4evH9MsEEfGtS06cBdkdD0RjGINQZXc8ZkzdsAhaYLS0XXRPJJKAZbqFzclkLAE9Mrdioo8CH9xp3mrlHlqfPpTR/sGSemUb05X4liP3tzPAVzIRR1/30rMLU16DCvZGvJQfOld+iYPLylYDojkxysr6HO9rHHKud5iz8NB7UrsMfLJkQA==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(40460700003)(40480700001)(478600001)(6666004)(82740400003)(36860700001)(81166007)(86362001)(356005)(30864003)(2906002)(83380400001)(336012)(26005)(426003)(47076005)(1076003)(2616005)(5660300002)(4326008)(70586007)(36756003)(8936002)(70206006)(8676002)(41300700001)(54906003)(110136005)(316002)(42186006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 02:07:31.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08114fa4-4d0f-46d7-534c-08dbc6da2a6a
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009525.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6553
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 drivers/power/supply/bq24190_charger.c | 269 ++++++++++++++++++++-----
 1 file changed, 217 insertions(+), 52 deletions(-)

diff --git a/drivers/power/supply/bq24190_charger.c b/drivers/power/supply/bq24190_charger.c
index 3f99cb9590ba..5d6059e6395a 100644
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
@@ -134,18 +140,31 @@
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
 
+enum bq24190_chip {
+	BQ24190,
+	BQ24192,
+	BQ24192i,
+	BQ24196,
+	BQ24296,
+};
+
 /*
  * The FAULT register is latched by the bq24190 (except for NTC_FAULT)
  * so the first read after a fault returns the latched value and subsequent
@@ -176,6 +195,7 @@ struct bq24190_dev_info {
 	u8				f_reg;
 	u8				ss_reg;
 	u8				watchdog;
+	enum bq24190_chip		chip;
 };
 
 static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
@@ -211,6 +231,9 @@ static const int bq24190_ccc_ichg_values[] = {
 	4096000, 4160000, 4224000, 4288000, 4352000, 4416000, 4480000, 4544000
 };
 
+/* ICHG higher than 3008mA is not supported in BQ24296 */
+#define BQ24296_CCC_ICHG_VALUES_LEN	40
+
 /* REG04[7:2] (VREG) in uV */
 static const int bq24190_cvc_vreg_values[] = {
 	3504000, 3520000, 3536000, 3552000, 3568000, 3584000, 3600000, 3616000,
@@ -515,14 +538,39 @@ static int bq24190_set_otg_vbus(struct bq24190_dev_info *bdi, bool enable)
 	}
 
 	bdi->otg_vbus_enabled = enable;
-	if (enable)
-		ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
-					 BQ24190_REG_POC_CHG_CONFIG_MASK,
-					 BQ24190_REG_POC_CHG_CONFIG_SHIFT,
-					 BQ24190_REG_POC_CHG_CONFIG_OTG);
-	else
+	if (enable) {
+		if (bdi->chip == BQ24296) {
+			ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					BQ24296_REG_POC_CHG_CONFIG_MASK,
+					BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+					BQ24190_REG_POC_CHG_CONFIG_DISABLE);
+			if (ret < 0)
+				goto out;
+
+			ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					BQ24296_REG_POC_OTG_CONFIG_MASK,
+					BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+					BQ24296_REG_POC_OTG_CONFIG_OTG);
+		} else {
+			ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					BQ24190_REG_POC_CHG_CONFIG_MASK,
+					BQ24190_REG_POC_CHG_CONFIG_SHIFT,
+					BQ24190_REG_POC_CHG_CONFIG_OTG);
+		}
+	} else {
+		if (bdi->chip == BQ24296) {
+			ret = bq24190_write_mask(bdi, BQ24190_REG_POC,
+					BQ24296_REG_POC_OTG_CONFIG_MASK,
+					BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+					BQ24296_REG_POC_OTG_CONFIG_DISABLE);
+			if (ret < 0)
+				goto out;
+		}
+
 		ret = bq24190_charger_set_charge_type(bdi, &val);
+	}
 
+out:
 	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
 
@@ -552,9 +600,15 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 		return ret;
 	}
 
-	ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
+	if (bdi->chip == BQ24296) {
+		ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
+				BQ24296_REG_POC_OTG_CONFIG_MASK,
+				BQ24296_REG_POC_OTG_CONFIG_SHIFT, &val);
+	} else {
+		ret = bq24190_read_mask(bdi, BQ24190_REG_POC,
 				BQ24190_REG_POC_CHG_CONFIG_MASK,
 				BQ24190_REG_POC_CHG_CONFIG_SHIFT, &val);
+	}
 
 	pm_runtime_mark_last_busy(bdi->dev);
 	pm_runtime_put_autosuspend(bdi->dev);
@@ -562,8 +616,12 @@ static int bq24190_vbus_is_enabled(struct regulator_dev *dev)
 	if (ret)
 		return ret;
 
-	bdi->otg_vbus_enabled = (val == BQ24190_REG_POC_CHG_CONFIG_OTG ||
-				 val == BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
+	if (bdi->chip == BQ24296) {
+		bdi->otg_vbus_enabled = (val == BQ24296_REG_POC_OTG_CONFIG_OTG);
+	} else {
+		bdi->otg_vbus_enabled = (val == BQ24190_REG_POC_CHG_CONFIG_OTG ||
+					val == BQ24190_REG_POC_CHG_CONFIG_OTG_ALT);
+	}
 	return bdi->otg_vbus_enabled;
 }
 
@@ -621,6 +679,7 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 {
 	int ret;
 	u8 v;
+	int ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values);
 
 	ret = bq24190_read(bdi, BQ24190_REG_CTTC, &v);
 	if (ret < 0)
@@ -674,11 +733,14 @@ static int bq24190_set_config(struct bq24190_dev_info *bdi)
 	}
 
 	if (bdi->ichg) {
+		if (bdi->chip == BQ24296)
+			ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN;
+
 		ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
 					    BQ24190_REG_CCC_ICHG_MASK,
 					    BQ24190_REG_CCC_ICHG_SHIFT,
 					    bq24190_ccc_ichg_values,
-					    ARRAY_SIZE(bq24190_ccc_ichg_values),
+					    ichg_array_size,
 					    bdi->ichg);
 		if (ret < 0)
 			return ret;
@@ -835,9 +897,17 @@ static int bq24190_charger_set_charge_type(struct bq24190_dev_info *bdi,
 			return ret;
 	}
 
-	return bq24190_write_mask(bdi, BQ24190_REG_POC,
-			BQ24190_REG_POC_CHG_CONFIG_MASK,
-			BQ24190_REG_POC_CHG_CONFIG_SHIFT, chg_config);
+	if (bdi->chip == BQ24296) {
+		return bq24190_write_mask(bdi, BQ24190_REG_POC,
+				BQ24296_REG_POC_CHG_CONFIG_MASK,
+				BQ24296_REG_POC_CHG_CONFIG_SHIFT,
+				chg_config);
+	} else {
+		return bq24190_write_mask(bdi, BQ24190_REG_POC,
+				BQ24190_REG_POC_CHG_CONFIG_MASK,
+				BQ24190_REG_POC_CHG_CONFIG_SHIFT,
+				chg_config);
+	}
 }
 
 static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
@@ -850,7 +920,7 @@ static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
 	v = bdi->f_reg;
 	mutex_unlock(&bdi->f_reg_lock);
 
-	if (v & BQ24190_REG_F_NTC_FAULT_MASK) {
+	if ((bdi->chip != BQ24296) && (v & BQ24190_REG_F_NTC_FAULT_MASK)) {
 		switch (v >> BQ24190_REG_F_NTC_FAULT_SHIFT & 0x7) {
 		case 0x1: /* TS1  Cold */
 		case 0x3: /* TS2  Cold */
@@ -865,6 +935,17 @@ static int bq24190_charger_get_health(struct bq24190_dev_info *bdi,
 		default:
 			health = POWER_SUPPLY_HEALTH_UNKNOWN;
 		}
+	} else if ((bdi->chip == BQ24296) && (v & BQ24296_REG_F_NTC_FAULT_MASK)) {
+		switch (v >> BQ24296_REG_F_NTC_FAULT_SHIFT & 0x3) {
+		case 0x1: /* Hot */
+			health = POWER_SUPPLY_HEALTH_OVERHEAT;
+			break;
+		case 0x2: /* Cold */
+			health = POWER_SUPPLY_HEALTH_COLD;
+			break;
+		default:
+			health = POWER_SUPPLY_HEALTH_UNKNOWN;
+		}
 	} else if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
 		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 	} else if (v & BQ24190_REG_F_CHRG_FAULT_MASK) {
@@ -1011,11 +1092,15 @@ static int bq24190_charger_get_current(struct bq24190_dev_info *bdi,
 {
 	u8 v;
 	int curr, ret;
+	int ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values);
+
+	if (bdi->chip == BQ24296)
+		ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN;
 
 	ret = bq24190_get_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
-			ARRAY_SIZE(bq24190_ccc_ichg_values), &curr);
+			ichg_array_size, &curr);
 	if (ret < 0)
 		return ret;
 
@@ -1038,6 +1123,7 @@ static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 {
 	u8 v;
 	int ret, curr = val->intval;
+	int ichg_array_size = ARRAY_SIZE(bq24190_ccc_ichg_values);
 
 	ret = bq24190_read_mask(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_FORCE_20PCT_MASK,
@@ -1052,10 +1138,13 @@ static int bq24190_charger_set_current(struct bq24190_dev_info *bdi,
 	if (curr > bdi->ichg_max)
 		return -EINVAL;
 
+	if (bdi->chip == BQ24296)
+		ichg_array_size = BQ24296_CCC_ICHG_VALUES_LEN;
+
 	ret = bq24190_set_field_val(bdi, BQ24190_REG_CCC,
 			BQ24190_REG_CCC_ICHG_MASK, BQ24190_REG_CCC_ICHG_SHIFT,
 			bq24190_ccc_ichg_values,
-			ARRAY_SIZE(bq24190_ccc_ichg_values), curr);
+			ichg_array_size, curr);
 	if (ret < 0)
 		return ret;
 
@@ -1395,25 +1484,44 @@ static int bq24190_battery_get_health(struct bq24190_dev_info *bdi,
 	if (v & BQ24190_REG_F_BAT_FAULT_MASK) {
 		health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 	} else {
-		v &= BQ24190_REG_F_NTC_FAULT_MASK;
-		v >>= BQ24190_REG_F_NTC_FAULT_SHIFT;
-
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
+		if (bdi->chip == BQ24296) {
+			v &= BQ24296_REG_F_NTC_FAULT_MASK;
+			v >>= BQ24296_REG_F_NTC_FAULT_SHIFT;
+
+			switch (v) {
+			case 0x0: /* Normal */
+				health = POWER_SUPPLY_HEALTH_GOOD;
+				break;
+			case 0x1: /* Hot */
+				health = POWER_SUPPLY_HEALTH_OVERHEAT;
+				break;
+			case 0x2: /* Cold */
+				health = POWER_SUPPLY_HEALTH_COLD;
+				break;
+			default:
+				health = POWER_SUPPLY_HEALTH_UNKNOWN;
+			}
+		} else {
+			v &= BQ24190_REG_F_NTC_FAULT_MASK;
+			v >>= BQ24190_REG_F_NTC_FAULT_SHIFT;
+
+			switch (v) {
+			case 0x0: /* Normal */
+				health = POWER_SUPPLY_HEALTH_GOOD;
+				break;
+			case 0x1: /* TS1 Cold */
+			case 0x3: /* TS2 Cold */
+			case 0x5: /* Both Cold */
+				health = POWER_SUPPLY_HEALTH_COLD;
+				break;
+			case 0x2: /* TS1 Hot */
+			case 0x4: /* TS2 Hot */
+			case 0x6: /* Both Hot */
+				health = POWER_SUPPLY_HEALTH_OVERHEAT;
+				break;
+			default:
+				health = POWER_SUPPLY_HEALTH_UNKNOWN;
+			}
 		}
 	}
 
@@ -1601,12 +1709,17 @@ static int bq24190_configure_usb_otg(struct bq24190_dev_info *bdi, u8 ss_reg)
 static void bq24190_check_status(struct bq24190_dev_info *bdi)
 {
 	const u8 battery_mask_ss = BQ24190_REG_SS_CHRG_STAT_MASK;
-	const u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK
-				| BQ24190_REG_F_NTC_FAULT_MASK;
+	u8 battery_mask_f = BQ24190_REG_F_BAT_FAULT_MASK;
+	u8 ntc_fault_mask = BQ24190_REG_F_NTC_FAULT_MASK;
 	bool alert_charger = false, alert_battery = false;
 	u8 ss_reg = 0, f_reg = 0;
 	int i, ret;
 
+	if (bdi->chip == BQ24296)
+		ntc_fault_mask = BQ24296_REG_F_NTC_FAULT_MASK;
+
+	battery_mask_f |= ntc_fault_mask;
+
 	ret = bq24190_read(bdi, BQ24190_REG_SS, &ss_reg);
 	if (ret < 0) {
 		dev_err(bdi->dev, "Can't read SS reg: %d\n", ret);
@@ -1633,7 +1746,7 @@ static void bq24190_check_status(struct bq24190_dev_info *bdi)
 			!!(f_reg & BQ24190_REG_F_BOOST_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_CHRG_FAULT_MASK),
 			!!(f_reg & BQ24190_REG_F_BAT_FAULT_MASK),
-			!!(f_reg & BQ24190_REG_F_NTC_FAULT_MASK));
+			!!(f_reg & ntc_fault_mask));
 
 		mutex_lock(&bdi->f_reg_lock);
 		if ((bdi->f_reg & battery_mask_f) != (f_reg & battery_mask_f))
@@ -1696,12 +1809,11 @@ static irqreturn_t bq24190_irq_handler_thread(int irq, void *data)
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
@@ -1719,6 +1831,52 @@ static int bq24190_hw_init(struct bq24190_dev_info *bdi)
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
+	/* First check that the device really is what its supposed to be */
+	switch (bdi->chip) {
+	case BQ24190:
+	case BQ24192:
+	case BQ24192i:
+	case BQ24196:
+		ret = bq24190_check_chip(bdi);
+		break;
+	case BQ24296:
+		ret = bq24296_check_chip(bdi);
+		break;
+	default:
+		dev_err(bdi->dev, "Error unsupported model: %d\n", bdi->chip);
+		return -EINVAL;
+	}
+
 	ret = bq24190_register_reset(bdi);
 	if (ret < 0)
 		return ret;
@@ -1736,7 +1894,11 @@ static int bq24190_get_config(struct bq24190_dev_info *bdi)
 	struct power_supply_battery_info *info;
 	int v, idx;
 
-	idx = ARRAY_SIZE(bq24190_ccc_ichg_values) - 1;
+	if (bdi->chip == BQ24296)
+		idx = BQ24296_CCC_ICHG_VALUES_LEN - 1;
+	else
+		idx = ARRAY_SIZE(bq24190_ccc_ichg_values) - 1;
+
 	bdi->ichg_max = bq24190_ccc_ichg_values[idx];
 
 	idx = ARRAY_SIZE(bq24190_cvc_vreg_values) - 1;
@@ -1804,6 +1966,7 @@ static int bq24190_probe(struct i2c_client *client)
 	bdi->client = client;
 	bdi->dev = dev;
 	strncpy(bdi->model_name, id->name, I2C_NAME_SIZE);
+	bdi->chip = id->driver_data;
 	mutex_init(&bdi->f_reg_lock);
 	bdi->charge_type = POWER_SUPPLY_CHARGE_TYPE_FAST;
 	bdi->f_reg = 0;
@@ -2029,10 +2192,11 @@ static const struct dev_pm_ops bq24190_pm_ops = {
 };
 
 static const struct i2c_device_id bq24190_i2c_ids[] = {
-	{ "bq24190" },
-	{ "bq24192" },
-	{ "bq24192i" },
-	{ "bq24196" },
+	{ "bq24190", BQ24190 },
+	{ "bq24192", BQ24192 },
+	{ "bq24192i", BQ24192i },
+	{ "bq24196", BQ24196 },
+	{ "bq24296", BQ24296 },
 	{ },
 };
 MODULE_DEVICE_TABLE(i2c, bq24190_i2c_ids);
@@ -2042,6 +2206,7 @@ static const struct of_device_id bq24190_of_match[] = {
 	{ .compatible = "ti,bq24192", },
 	{ .compatible = "ti,bq24192i", },
 	{ .compatible = "ti,bq24196", },
+	{ .compatible = "ti,bq24296", },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, bq24190_of_match);
-- 
2.30.2

