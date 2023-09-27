Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32CA7B0401
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbjI0M1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjI0M0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:26:53 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958231B0;
        Wed, 27 Sep 2023 05:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BSyXr1XKzym75LWsnT7cdLrQBbd/5vx3Fzp8Zea6LLdgL4Wu3NhbSdsximIp7PHNxk1IGSrrzjdHmJJo/nE5uMLS0kvPXjPb8P3p/pj+RbxknntjjWQ6a3J9xfmwLyoErHCVTzwgNjZ5SBa1H1Cacl1TPIBS5VysuBMNxAA6FmP1WRv182GuCZ3p+4etf0L/Qu1h3XMbmmNIH82k+n/ZUGDVE6Ad0eQ1j9G0t2SWYHaAf/9qhG+Jy55d694tQpEJyJoIS1hQ/aCsYuzCICIdpTr54kKFknRfVDdxEjDlSNBH8XHp12rYaSPvDbxb60S8rbYWggPzgcy6Hdxkvzqttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ooInUKYhlujOhjindkRtW27/T2+Byib8g/PKDo99Fw=;
 b=Egc2POKNN/i8g+LFVlcuP9IgPiQCWJ/oanbMMHW2Ub+aE5Ka4M/B62H6tRmzwMoM7GIwFe2fy2MYed7kZjMEqCB3cG3FQDd4t5utTR5TKQVgbAzpST9NQzAWhWtLLbhpNNOq2qUC+jJ11P54WMaTT2hIT994E1zBIEj18iwiUB6TgtABXXOHzvstG6BFTLeFvRZvEgLA5fdWouOhZ+c4XA0teNbvxVXtWrtJ/uXGRRVg330+LcbSZM/rWg0bphci/DJGFLlal4rqH4j/LW3O+scDcKjvOj5LtxBHDQA0Q1OYDJKRWVgG8aEbCNKf9EJgb3CsB737nCkPlKysC9WuMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ooInUKYhlujOhjindkRtW27/T2+Byib8g/PKDo99Fw=;
 b=ZS1yOfu1J9tqk1knbmvPG6+RmgqIv7x4SV7kle/d5QrP6IZS2W7kQHa0dhdoZjR6TzqjEUFEx9dRhOJpWCgtVtOAtNIZCjt4gm+QVAJ6+PezTLiVQvU+GU3L5CEBPC8nRsB5O4K3tc8RPOrTcNcQkMR4beeWS3jWsaBqn1MMbo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS8PR04MB8181.eurprd04.prod.outlook.com (2603:10a6:20b:3f5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 12:26:48 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::dbc:99b7:7808:f82e%7]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 12:26:48 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH v6 04/11] arm64: dts: imx8ulp-evk: reserved mem-ranges to constrain ele_fw dma-range
Date:   Wed, 27 Sep 2023 23:23:54 +0530
Message-Id: <20230927175401.1962733-5-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
References: <20230927175401.1962733-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS8PR04MB8181:EE_
X-MS-Office365-Filtering-Correlation-Id: 42c9a8d2-08f7-4bf9-1861-08dbbf55051a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Uo8I2eNRTQQYlKM2tUz8/yqXyrf5/sD+rq52OmJ/OagcEisV2H9pDpTaBqTxEKAH7MsRkCLUqi0Kk3tIjtTt5y2eMfSbu/UCBjHoh0DikHxHMRYsizBSxcvAN3my26BfPve1lUDkRhhpam3e5z/Le9QeL+DQyWAslP7mKPBjRRQCCQRE6DIvHZJv4EvqBI19PwlKuYGoYIqNSkmFoJhvjOQVBRMGjfClcDUYb1kVNRFU1KJBndIIsY1cuJvCLaehSNfqIDZ9ANG9UxtIK2ltLcPlzbq4n7lQ8Lf16fmJBIPDdK+hShCA8jUJUyp1qPpCN/A2cx5heeeJJnIWRBqMrQfPq3g0leNX6bV6Ie0aDu9kKgVf+Bv1RwHapH9Q/dc6GfBIcXTf3uRsIpfBIEE9AXxs5gvESk7Y1UgsIxXDlwe1fBrl1oJS8IAwQw5ns8DatQVxYiSsQsxbDpkQECsYOzYqyjhD8Xw5YMcWzl7uBEMz+wXBUxzBLRi+MEqwOrGADEGmR/wR0SsLqJo+hEeqDWv8s6PTNh30HwSrY617/Rtc0F7Got+/5FhLNtCBSFfEbhBAwpzQUpId+Gc4jaIMOwIRX308Q9vRdYdUdl+Mz4hlZ33y+tJrn4Ffxy3U95I4J5PgHJ1lJCWVa2OaaHtqygAwLn9WXHPSaec/1hxTdVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(136003)(376002)(230922051799003)(451199024)(186009)(1800799009)(7416002)(5660300002)(316002)(54906003)(921005)(83380400001)(44832011)(41300700001)(6636002)(8676002)(8936002)(36756003)(2616005)(66946007)(4326008)(86362001)(1076003)(6666004)(6486002)(6512007)(52116002)(6506007)(66476007)(66556008)(26005)(2906002)(38350700002)(38100700002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ViCEZ03EOp6D12GKBj6VNjWmtPV8QlGQbOjFMFKcxMJsmOHAe77PNvCj2op9?=
 =?us-ascii?Q?7oXgkIgeRj0lno0OLMXHeEsVD3W86LguGZo/0njyMR8Q9OF7IFvHhIEBiZbi?=
 =?us-ascii?Q?pYN6GHPgkxX/rqjYlKMYVNVOCRUPn1Hi9yHQuxXcBrLCs8aOW8shLuNVpdSK?=
 =?us-ascii?Q?iGH1HKgOHiSLSckKpU22EaFIGgIBtwhtHQI1063C9suFys3Yb6nC3t8PGGFt?=
 =?us-ascii?Q?nnnirLKLMiiaNLgYVa51qyVapx7/9U5KBJeX/38NcO8DT5T8qFcnscU5C6Hi?=
 =?us-ascii?Q?5l1Kj0Hb1Hv99nYDUwfkufZYVvjrMwdU9fmvC1rTfsXrpkSLtykI+7RGoFi4?=
 =?us-ascii?Q?A4loNZ41BDUqXXOEXZmAOvx4ToaQMApeE2i6cRe++4YtzLzLqx4kzTWwpWBV?=
 =?us-ascii?Q?b1CtY4Ox7DjRAOINVG3jfsLYTJAg4jzGoWDXc867cVKMub/GRL0K6HhbUZTV?=
 =?us-ascii?Q?m4MeFCyDZB0xAnbZCufV97gUBW/tlpsbFaqrHIx+rjmv3Ii4hERBUfYCKeah?=
 =?us-ascii?Q?6AEcgpjHHCe2mBaMLo8gaNFLnk5+hvnQLM5I79EOOISmTimzxngpjG881cTA?=
 =?us-ascii?Q?b0sxjcGVXYZJ+i7F7yQG9z5/qvnFtYhFMZmZFfnKd5AO57Hq8AEhkz3JqkJh?=
 =?us-ascii?Q?JGZI989GfdaCBx1fFIuCJuk/aG+PRpduJ2/g/emn7Hd9vCcW4RNpNZksfP0z?=
 =?us-ascii?Q?bgytHaY8suCpkqiVJUI/5huuOudZ+IsQGz67eAbvzUZ7G+l9r8U+Xz56hlvE?=
 =?us-ascii?Q?09wmE23KAQKKzV+HWYdQAaxxirkJEoIZCnhZQhknYkbhRu02vWeRKe0lP/Tk?=
 =?us-ascii?Q?IRVDykwZZEOle0cqu7bqysnt7wEoEjcPwzPMSi5eoyC4U/uzoC+LZBaMIba/?=
 =?us-ascii?Q?QqryddftU4pOyT5mksmXkofThhrwBgKh8vAwDm/PK8hHiT8AaTkulCadHFIC?=
 =?us-ascii?Q?qKrgeSJptSdzGK19WBuKTkoRL4AaLaUjG4P4Xe2vxzhtf9A+ZpfyyawjAiH6?=
 =?us-ascii?Q?iFxPqI2iDsoO2/Q8qL2SGphJayZzABIhYCAchgfZYTwJ+9q1Xo/wpKVCFKeU?=
 =?us-ascii?Q?bJY+YSPEgIxQjupMQ4VDYajeOFoFQuFCV6BJU0L5mHLIScmb/FGVFIa8Mtzl?=
 =?us-ascii?Q?LrBZ7jZLjOc5RvshleZYRAbgRFgex0IGe71bRyQVkbz7nwN+oTUMoOvoiF1+?=
 =?us-ascii?Q?niEPg1b5AtbOm221ZVQtlPSJbnriXNp9UI1XJJh1O5i19cWJvhTG09r/Lt4E?=
 =?us-ascii?Q?Xs5yxFxVCN46gOiNof/aUfSnOorqc0B7a4eCxMPfhSkUSEVvb2JCmKMo/cyB?=
 =?us-ascii?Q?QK1xoDUMkDXCt/FFSa5dDYPx8fXIomS3aQI1Fp5XYoUKZBnQyAJulhiR0s3U?=
 =?us-ascii?Q?scZ8N5Yd0XPjziAWRa1ZdR/nXL3F3jFRXZ+4DdSJFF4NL9fwEvjkHRnK2M3d?=
 =?us-ascii?Q?VrG3dGwOi0w4wtLf4iBKcNQFs3DSqUSyMKBIGVTTelCCeTa3fdmp8U0nxJRr?=
 =?us-ascii?Q?Jd6F8/stmqouWEqMwUxTAapBJrxTgWB+97W7q4Uj2cB14QI51vv4FfG5kLAO?=
 =?us-ascii?Q?mHudPSDXB/HaXIUuIzqUGpBU6GTSkduu5CzRUiVX?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42c9a8d2-08f7-4bf9-1861-08dbbf55051a
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 12:26:48.6075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3s/wriCgoPEyLL19ujICgaK/5N8H/Rf0mLP0/JUnuApXkGkdobitHB89oIMUepilWUnrQUzepPivxzWWG6uHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8181
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x90000000 - 0xAFFFFFFF

ELE-FW driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 69dd8e31027c..d5cdce62a760 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -19,6 +19,17 @@ memory@80000000 {
 		device_type = "memory";
 		reg = <0x0 0x80000000 0 0x80000000>;
 	};
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		ele_reserved: ele-reserved@90000000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0x90000000 0 0x100000>;
+			no-map;
+		};
+	};
 
 	reserved-memory {
 		#address-cells = <2>;
@@ -146,6 +157,10 @@ &usdhc0 {
 	status = "okay";
 };
 
+&ele_fw2 {
+	memory-region = <&ele_reserved>;
+};
+
 &fec {
 	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&pinctrl_enet>;
-- 
2.34.1

