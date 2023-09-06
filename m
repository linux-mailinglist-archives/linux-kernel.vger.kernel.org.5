Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 261E2794109
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242922AbjIFQDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242927AbjIFQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:02:58 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14DC1982;
        Wed,  6 Sep 2023 09:02:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nqd4bY4JcJjY6LOgDHO7sBJG+U6ayP/8EWs/4YjQtMWlXWdjxwtba9vodSM2FfiCknhw881cwIYTqThSdzC2BRo+g9hlHzC4FACTfB30+NXT2hSJH1NM5hOpOFifx6Tchmi1M3cl/I7qvT+oGI27YmmFeWkgyJo/PPsk9/hzCGrbI1bt6fImlFXesSGOfRDv7OeXeNWrlYog9t7DvI3fb0jqckRzjJOrHDIsX3cPmttplH9qvG7Vt1Z6OFLmZYMOxSJcsuzinVnyZryV+OmK2JokeI6Rm8M9xaW7URUQ4+X9C84mHLoJKBBGxZj9ei6Q9QCrs4qMaFxOljzx35rI+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQtF6J+1qyu5D4WRwNy8Ka/h4HPYS7Nr5SrWyoMfeic=;
 b=nz448d1MXVqhHw1+iI34dcT5NzGVTlNabrUCyZ4d1bmanii5V7RaaNjiNCE8PvMBt1+JdS+ZuhFM1n/vMp8N0eTE4BeIdVZMiVifunCA2s63R2NOPyzOuR/DTUP3U4NVuyOzWFIUAzqdxUlalG06tCWcM0jCWGigSAGSonrXxTxt3pmb+0XtQXy7FxZpaJNEedRQUTU8VzOjlYavFMOLn+hFgYbcq+ZKsZqMdQ5fbtr94xtgAtZMEfMC2h+CRSdAtzsszuHbyuIBW/pdCNk0wbHPk62dUPavINS901+6SPZs5X3tzrsUF3EOW9UEl6M/6KBTghzetFLDAf7v6YKddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UQtF6J+1qyu5D4WRwNy8Ka/h4HPYS7Nr5SrWyoMfeic=;
 b=bpekuw4Tc7+OqMrKAGbzXeDFfE+OtY2wrK++KwUpsHewnl2/YujTI0l3191MuPqEYxBd1STZtejEzXPDxuxWaCPtVA95GkPOStorFl7Yju0O4AJJzmULQYhGUQEYkiMFDB2SJmVlat+4XoyTGh21/jW+5wzQeV7ZSx/Aw0sLUt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11)
 by AS1PR04MB9429.eurprd04.prod.outlook.com (2603:10a6:20b:4db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 16:02:35 +0000
Received: from PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee]) by PAXPR04MB8958.eurprd04.prod.outlook.com
 ([fe80::d7c:390a:4105:65ee%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 16:02:35 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com, sd@queasysnail.net,
        sebastian.tobuschat@nxp.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [RFC net-next v3 5/6] net: phy: nxp-c45-tja11xx: add MACsec statistics
Date:   Wed,  6 Sep 2023 19:01:33 +0300
Message-Id: <20230906160134.311993-6-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230906160134.311993-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::17) To PAXPR04MB8958.eurprd04.prod.outlook.com
 (2603:10a6:102:20d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8958:EE_|AS1PR04MB9429:EE_
X-MS-Office365-Filtering-Correlation-Id: e8d53f62-fc91-4134-db3c-08dbaef2af60
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zriBAziaG0+vS4H+7W2nAElbnJF0KXJ646LyM4r1aYs18z2rxpyCk5UOaBp191ebk7r7cwPBgmJnAPCBVOaHxSfaASE88WYg3N8I65o5Vua9jONuXpCMJQiDOwV9kaQqG7C1+a7qqis99KJAL2N2Hi+NnlXLFbNINgEzX85fy3ElC91Jpoz7G9RLHARdlJ/auqVki3UMuX2IdwK8lEjYBTILVx5C1uJaGdS6OK/j6mHCBjWlwwsWIA+jC7OcDahQ6TvIXYFEEW3B6r6OzpB2CmNuQliPgjNoXccv5wTADnS2fhJaEDR7YkXc6tH0jskOIhGmCTuoeSCtl09XgR1Qn2TcpYAfJUDR3kjVSnrK5HJXUsMvaXU52qoa7A0C093q4DqjtuVF1dr1yzApbWxxYP+GEffDJr5z7BzKBXavvhlHpbet0prwYy26GR8cPpuks5yjupLEvOa7XI6s6UhRPulTW2Tx5tb9X56aJ3jH9vTPxGw9qd+yIubbcjVOLeuZhfyVc+YwfRh52+VGmbjiMKL1qkxjv+5ltzCl5Aj1a4PexfTaht4znuvXPfp9vAx0fVOHMBy4uyjc4Op5b4hrVFjtfMDXvpCtQ8tCjmIOL8PJ7OLl9tQ5XJGWGJp/BWc5yrs/mtefrI2auCaLaxLjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8958.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(451199024)(41300700001)(7416002)(921005)(38350700002)(86362001)(2616005)(478600001)(83380400001)(26005)(6512007)(1076003)(6486002)(6506007)(52116002)(38100700002)(66476007)(66556008)(66946007)(316002)(2906002)(30864003)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?get3MFQZqDDmdyXnLWNTBg8AiHaesExLHg7qgSAFMiWOOZMpELuRqgkQOvsn?=
 =?us-ascii?Q?2wgsACPJPa6SscryLWm/n2JPFJf+ppaNqVCXsnHrA+C8CjxTvUNpnoWER4OA?=
 =?us-ascii?Q?mA5PKmTPhQTx9bGAAcS0V4oOHyuexuAc6Wj1F0cFtFyCEFYfcIJojIOgfQQv?=
 =?us-ascii?Q?gsbJTsLfVZxQaPoBGKXsQ/J+15sDj/wqqbzi9bwUUjpWv20r8f2vjhwjpfwf?=
 =?us-ascii?Q?A07x0igX9NrD7Hi/28/gywc7BfXbItqKPMYUfy0Fey99Nn6heHzIb9Z7BxQo?=
 =?us-ascii?Q?78A2jxuFa1g5+fveGp8sOmGL6mSwiXN0ksr65fEwGb59MotUBP+E7Z0XGaug?=
 =?us-ascii?Q?ytw1R6O2xVUN698t/ZkU6/8/FuWFABkRg4fseOBn8OPSyZGQUaCUzHFbDUx8?=
 =?us-ascii?Q?DsXMvUoRDwxPalN4B82ST7ErontIZoh4wko0CgKyhfgEZWjR5e61N64rDctO?=
 =?us-ascii?Q?50uT2GFlNtEED90+pjD5Pbhx4P3HwuRxCAOR0CRl6iDqDBxyVvq+Duz53C6+?=
 =?us-ascii?Q?nJqozGNKAkcZqstyg18ZWs0TCIWj3jOO7LW6YrmCSR4NFIgADZWJE+YzsiJ+?=
 =?us-ascii?Q?wKOrRWARUAyKY7kU1acZWoaictJGdVYTnkihyNtAVWiDiRG5XmHbB8L/43D9?=
 =?us-ascii?Q?A/wXZBf25WT7sFiKo9NkJzIRIdl3POJZc+3Y/7iSwWTEuZCnGRI/Qm5Q9Ncn?=
 =?us-ascii?Q?a/8K84Nrt/+LyYcIbJG4bAQ65ZTelQiR0by2YyCC4v3z72yimnpCOgY6R2zx?=
 =?us-ascii?Q?UJlr0SQMQXUhr9mRSZv85A7ymxsWeVuZKX0kKzKvvTD0Wjp5jAGolkCusJ/r?=
 =?us-ascii?Q?r1fbnIbmZh0/ee/2FrIyKT17RjKfgPZJMMa9ydgYy7KxF8wjSeL/iDeP5iL7?=
 =?us-ascii?Q?i1FOu0A2ULnXwa5SYHi8EuqB2XNDMSFDNHJu3Sw7ggIWR6kQ1fK0u+M3Q20F?=
 =?us-ascii?Q?3rFpau0/fGWflbRBabQfp278G1WG6zYyDDy/EeVPZbPQbjz+sy528IrUgMTb?=
 =?us-ascii?Q?iuq9jFmQwzlwgUrWk/wtyiaojBOH/17DxiK5+m/kzzpI5EfYkvA52unTOMk6?=
 =?us-ascii?Q?Ot0+2OVK7ksHwBFbFLPHRBDrOe9W6UsdPsS21MXDMiryGL+VmnTJ04Jwn/qj?=
 =?us-ascii?Q?9xWH9J9LA08OreeG0qP5q4Ae0n8t5zvtIVMFRUyQK1iXE4ATF9BWlSEyZUJU?=
 =?us-ascii?Q?6CA4gOonSu7SKc1Uvj4I3ykuGyV8KPYmNOtKKxk6G0bVgHP6xcViD0ltKv/h?=
 =?us-ascii?Q?sVVAgh3IhqquMDsxATwaJBTsU8BrJ39YuQ5gaxftV5xSi3KPsVGNUHZr9JXs?=
 =?us-ascii?Q?8e7yKek46WfLMmE5qOBGiZLzWz7RcANhdboTpJMLYUh1N1UEl5asnDyCLeaH?=
 =?us-ascii?Q?N51RlVDzdHYu7dArY6bkK0KeD5u0T1qIpq91QrL1zlt8SkM4wOovGJCZub9Y?=
 =?us-ascii?Q?gDcH2xh381pnk38vGmTR96lArzmBxuGH5LYLlb2jxIj2U0XTKoZf9TQZV208?=
 =?us-ascii?Q?DLlEdOk7yo4xezD+DoCJYG0/DIuDhOXTfdanQrCJb5PiUIOyXgmbMx0ZoTXe?=
 =?us-ascii?Q?wx/hDpqXriKoW0z8JVElNxoj0cEaolqBYlDtPrXMfNGpyiWbbzCITfrrbqE8?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8d53f62-fc91-4134-db3c-08dbaef2af60
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8958.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 16:02:35.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DdFYyqBZgUyC6MqJJNzqGIzvEiYXcSMNbcKxnSYxDYtQ0F8jYi9zFwT8RrQLflQvcaApoJAOb5/loeTs4mJUMzvdNvZA+waOkbQzrqG9po0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9429
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MACsec statistics callbacks.
The statistic registers must be set to 0 if the SC/SA is
deleted to read relevant values next time when the SC/SA is used.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---

Changes in v3:
- reworked the implementation around struct nxp_c45_sa
- changed the way how OutOctetsEncrypted are propagated to the userspace
- changed the way how OutOctetsProtected are propagated to the userspace
- read and clear OutOctetsProtected

Changes in v2:
- split the patch from "net: phy: nxp-c45-tja11xx: add MACsec support"

 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 337 +++++++++++++++++++++++
 1 file changed, 337 insertions(+)

diff --git a/drivers/net/phy/nxp-c45-tja11xx-macsec.c b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
index 4a403d6ad75d..ec827b2080d8 100644
--- a/drivers/net/phy/nxp-c45-tja11xx-macsec.c
+++ b/drivers/net/phy/nxp-c45-tja11xx-macsec.c
@@ -137,6 +137,35 @@
 #define ADAPTER_EN	BIT(6)
 #define MACSEC_EN	BIT(5)
 
+#define MACSEC_INOV1HS			0x0140
+#define MACSEC_INOV2HS			0x0144
+#define MACSEC_INOD1HS			0x0148
+#define MACSEC_INOD2HS			0x014C
+#define MACSEC_RXSCIPUS			0x0150
+#define MACSEC_RXSCIPDS			0x0154
+#define MACSEC_RXSCIPLS			0x0158
+#define MACSEC_RXAN0INUSS		0x0160
+#define MACSEC_RXAN0IPUSS		0x0170
+#define MACSEC_RXSA_A_IPOS		0x0194
+#define MACSEC_RXSA_A_IPIS		0x01B0
+#define MACSEC_RXSA_A_IPNVS		0x01B4
+#define MACSEC_RXSA_B_IPOS		0x01D4
+#define MACSEC_RXSA_B_IPIS		0x01F0
+#define MACSEC_RXSA_B_IPNVS		0x01F4
+#define MACSEC_OPUS			0x021C
+#define MACSEC_OPTLS			0x022C
+#define MACSEC_OOP1HS			0x0240
+#define MACSEC_OOP2HS			0x0244
+#define MACSEC_OOE1HS			0x0248
+#define MACSEC_OOE2HS			0x024C
+#define MACSEC_TXSA_A_OPPS		0x028C
+#define MACSEC_TXSA_A_OPES		0x0290
+#define MACSEC_TXSA_B_OPPS		0x02CC
+#define MACSEC_TXSA_B_OPES		0x02D0
+#define MACSEC_INPWTS			0x0630
+#define MACSEC_INPBTS			0x0638
+#define MACSEC_IPSNFS			0x063C
+
 enum nxp_c45_sa_type {
 	TX_SA,
 	RX_SA,
@@ -175,6 +204,11 @@ struct nxp_c45_sa_regs {
 	u16 ka;
 	u16 ssci;
 	u16 salt;
+	u16 ipis;
+	u16 ipnvs;
+	u16 ipos;
+	u16 opps;
+	u16 opes;
 };
 
 static const struct nxp_c45_sa_regs rx_sa_a_regs = {
@@ -186,6 +220,9 @@ static const struct nxp_c45_sa_regs rx_sa_a_regs = {
 	.ka	= MACSEC_RXSA_A_KA,
 	.ssci	= MACSEC_RXSA_A_SSCI,
 	.salt	= MACSEC_RXSA_A_SALT,
+	.ipis	= MACSEC_RXSA_A_IPIS,
+	.ipnvs	= MACSEC_RXSA_A_IPNVS,
+	.ipos	= MACSEC_RXSA_A_IPOS,
 };
 
 static const struct nxp_c45_sa_regs rx_sa_b_regs = {
@@ -197,6 +234,9 @@ static const struct nxp_c45_sa_regs rx_sa_b_regs = {
 	.ka	= MACSEC_RXSA_B_KA,
 	.ssci	= MACSEC_RXSA_B_SSCI,
 	.salt	= MACSEC_RXSA_B_SALT,
+	.ipis	= MACSEC_RXSA_B_IPIS,
+	.ipnvs	= MACSEC_RXSA_B_IPNVS,
+	.ipos	= MACSEC_RXSA_B_IPOS,
 };
 
 static const struct nxp_c45_sa_regs tx_sa_a_regs = {
@@ -206,6 +246,8 @@ static const struct nxp_c45_sa_regs tx_sa_a_regs = {
 	.ka	= MACSEC_TXSA_A_KA,
 	.ssci	= MACSEC_TXSA_A_SSCI,
 	.salt	= MACSEC_TXSA_A_SALT,
+	.opps	= MACSEC_TXSA_A_OPPS,
+	.opes	= MACSEC_TXSA_A_OPES,
 };
 
 static const struct nxp_c45_sa_regs tx_sa_b_regs = {
@@ -215,6 +257,8 @@ static const struct nxp_c45_sa_regs tx_sa_b_regs = {
 	.ka	= MACSEC_TXSA_B_KA,
 	.ssci	= MACSEC_TXSA_B_SSCI,
 	.salt	= MACSEC_TXSA_B_SALT,
+	.opps	= MACSEC_TXSA_B_OPPS,
+	.opes	= MACSEC_TXSA_B_OPES,
 };
 
 static const
@@ -416,6 +460,41 @@ static void nxp_c45_sa_set_key(struct macsec_context *ctx,
 	nxp_c45_macsec_write(ctx->phydev, sa_regs->cs, MACSEC_SA_CS_A);
 }
 
+static void nxp_c45_rx_sa_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_sa *sa)
+{
+	nxp_c45_macsec_write(phydev, sa->regs->ipis, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->ipnvs, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->ipos, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + sa->an * 4, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + sa->an * 4, 0);
+}
+
+static void nxp_c45_rx_sa_read_stats(struct phy_device *phydev,
+				     struct nxp_c45_sa *sa,
+				     struct macsec_rx_sa_stats *stats)
+{
+	nxp_c45_macsec_read(phydev, sa->regs->ipis, &stats->InPktsInvalid);
+	nxp_c45_macsec_read(phydev, sa->regs->ipnvs, &stats->InPktsNotValid);
+	nxp_c45_macsec_read(phydev, sa->regs->ipos, &stats->InPktsOK);
+}
+
+static void nxp_c45_tx_sa_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_sa *sa)
+{
+	nxp_c45_macsec_write(phydev, sa->regs->opps, 0);
+	nxp_c45_macsec_write(phydev, sa->regs->opes, 0);
+}
+
+static void nxp_c45_tx_sa_read_stats(struct phy_device *phydev,
+				     struct nxp_c45_sa *sa,
+				     struct macsec_tx_sa_stats *stats)
+{
+	nxp_c45_macsec_read(phydev, sa->regs->opps, &stats->OutPktsProtected);
+	nxp_c45_macsec_read(phydev, sa->regs->opes, &stats->OutPktsEncrypted);
+}
+
 static void nxp_c45_rx_sa_update(struct phy_device *phydev,
 				 struct nxp_c45_sa *sa, bool en)
 {
@@ -634,6 +713,23 @@ static void nxp_c45_tx_sc_update(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_TXSC_CFG, cfg);
 }
 
+static void nxp_c45_tx_sc_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
+		if (pos->type == TX_SA)
+			nxp_c45_tx_sa_clear_stats(phydev, pos);
+
+	nxp_c45_macsec_write(phydev, MACSEC_OPUS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OPTLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOP1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOP2HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_OOE2HS, 0);
+}
+
 static void nxp_c45_set_rx_sc0_impl(struct phy_device *phydev,
 				    bool enable)
 {
@@ -723,6 +819,32 @@ static void nxp_c45_rx_sc_update(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_RXSC_CFG, cfg);
 }
 
+static void nxp_c45_rx_sc_clear_stats(struct phy_device *phydev,
+				      struct nxp_c45_secy *phy_secy)
+{
+	struct nxp_c45_sa *pos, *tmp;
+	int i;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
+		if (pos->type == RX_SA)
+			nxp_c45_rx_sa_clear_stats(phydev, pos);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOD1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOD2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_INOV1HS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INOV2HS, 0);
+
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPDS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPLS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_RXSCIPUS, 0);
+
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0INUSS + i * 4, 0);
+		nxp_c45_macsec_write(phydev, MACSEC_RXAN0IPUSS + i * 4, 0);
+	}
+}
+
 static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 			      struct nxp_c45_secy *phy_secy)
 {
@@ -732,11 +854,20 @@ static void nxp_c45_rx_sc_del(struct phy_device *phydev,
 	nxp_c45_macsec_write(phydev, MACSEC_RPW, 0);
 	nxp_c45_set_sci(phydev, MACSEC_RXSC_SCI_1H, 0);
 
+	nxp_c45_rx_sc_clear_stats(phydev, phy_secy);
+
 	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list)
 		if (pos->type == RX_SA)
 			nxp_c45_rx_sa_update(phydev, pos, false);
 }
 
+static void nxp_c45_clear_global_stats(struct phy_device *phydev)
+{
+	nxp_c45_macsec_write(phydev, MACSEC_INPBTS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_INPWTS, 0);
+	nxp_c45_macsec_write(phydev, MACSEC_IPSNFS, 0);
+}
+
 static int nxp_c45_mdo_dev_open(struct macsec_context *ctx)
 {
 	struct nxp_c45_phy *priv = ctx->phydev->priv;
@@ -930,6 +1061,7 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	nxp_c45_mdo_dev_stop(ctx);
 	nxp_c45_tx_sa_next(phy_secy, &next_sa, encoding_sa);
 	nxp_c45_tx_sa_update(phydev, &next_sa, encoding_sa, false);
+	nxp_c45_tx_sc_clear_stats(phydev, phy_secy);
 	if (phy_secy->rx_sc)
 		nxp_c45_rx_sc_del(phydev, phy_secy);
 
@@ -944,6 +1076,9 @@ static int nxp_c45_mdo_del_secy(struct macsec_context *ctx)
 	list_del(&phy_secy->list);
 	kfree(phy_secy);
 
+	if (list_empty(&priv->macsec->secy_list))
+		nxp_c45_clear_global_stats(phydev);
+
 	return 0;
 }
 
@@ -1099,6 +1234,7 @@ static int nxp_c45_mdo_del_rxsa(struct macsec_context *ctx)
 
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_rx_sa_update(phydev, sa, false);
+	nxp_c45_rx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
@@ -1185,12 +1321,208 @@ static int nxp_c45_mdo_del_txsa(struct macsec_context *ctx)
 
 	nxp_c45_select_secy(phydev, phy_secy->secy_id);
 	nxp_c45_tx_sa_update(phydev, sa, ctx->secy->tx_sc.encoding_sa, false);
+	nxp_c45_tx_sa_clear_stats(phydev, sa);
 
 	nxp_c45_sa_free(sa);
 
 	return 0;
 }
 
+static int nxp_c45_mdo_get_dev_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_dev_stats  *dev_stats;
+	struct nxp_c45_secy *phy_secy;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	dev_stats = ctx->stats.dev_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read(phydev, MACSEC_OPUS, &reg);
+	dev_stats->OutPktsUntagged = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_OPTLS, &reg);
+	dev_stats->OutPktsTooLong = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_INPBTS, &reg);
+	dev_stats->InPktsBadTag = reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_INPWTS, &reg);
+	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+		dev_stats->InPktsNoTag += reg;
+	else
+		dev_stats->InPktsUntagged += reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_IPSNFS, &reg);
+	if (phy_secy->secy->validate_frames == MACSEC_VALIDATE_STRICT)
+		dev_stats->InPktsNoSCI += reg;
+	else
+		dev_stats->InPktsUnknownSCI += reg;
+
+	/* Always 0. */
+	dev_stats->InPktsOverrun = 0;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sa_stats tx_sa_stats;
+	struct macsec_tx_sc_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa *pos, *tmp;
+	u32 reg = 0;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	stats = ctx->stats.tx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_macsec_read(phydev, MACSEC_OOE1HS, &reg);
+	stats->OutOctetsEncrypted = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_OOE2HS, &reg);
+	stats->OutOctetsEncrypted |= reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_OOP1HS, &reg);
+	stats->OutOctetsProtected = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_OOP2HS, &reg);
+	stats->OutOctetsProtected |= reg;
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		if (pos->type != TX_SA)
+			continue;
+
+		memset(&tx_sa_stats, 0, sizeof(tx_sa_stats));
+		nxp_c45_tx_sa_read_stats(phydev, pos, &tx_sa_stats);
+
+		stats->OutPktsEncrypted += tx_sa_stats.OutPktsEncrypted;
+		stats->OutPktsProtected += tx_sa_stats.OutPktsProtected;
+	}
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_tx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_tx_sa_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, TX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	stats = ctx->stats.tx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+	nxp_c45_tx_sa_read_stats(phydev, sa, stats);
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sc_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats rx_sa_stats;
+	struct macsec_rx_sc_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	struct nxp_c45_sa *pos, *tmp;
+
+	u32 reg = 0;
+	int i;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	if (phy_secy->rx_sc != ctx->rx_sc)
+		return -EINVAL;
+
+	stats = ctx->stats.rx_sc_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	list_for_each_entry_safe(pos, tmp, &phy_secy->sa_list, list) {
+		if (pos->type != RX_SA)
+			continue;
+
+		memset(&rx_sa_stats, 0, sizeof(rx_sa_stats));
+		nxp_c45_rx_sa_read_stats(phydev, pos, &rx_sa_stats);
+
+		stats->InPktsInvalid += rx_sa_stats.InPktsInvalid;
+		stats->InPktsNotValid += rx_sa_stats.InPktsNotValid;
+		stats->InPktsOK += rx_sa_stats.InPktsOK;
+	}
+
+	for (i = 0; i < MACSEC_NUM_AN; i++) {
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + i * 4, &reg);
+		stats->InPktsNotUsingSA += reg;
+		nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + i * 4, &reg);
+		stats->InPktsUnusedSA += reg;
+	}
+
+	nxp_c45_macsec_read(phydev, MACSEC_INOD1HS, &reg);
+	stats->InOctetsDecrypted = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_INOD2HS, &reg);
+	stats->InOctetsDecrypted |= reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_INOV1HS, &reg);
+	stats->InOctetsValidated = (u64)reg << 32;
+	nxp_c45_macsec_read(phydev, MACSEC_INOV2HS, &reg);
+	stats->InOctetsValidated |= reg;
+
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPDS, &reg);
+	stats->InPktsDelayed = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPLS, &reg);
+	stats->InPktsLate = reg;
+	nxp_c45_macsec_read(phydev, MACSEC_RXSCIPUS, &reg);
+	stats->InPktsUnchecked = reg;
+
+	return 0;
+}
+
+static int nxp_c45_mdo_get_rx_sa_stats(struct macsec_context *ctx)
+{
+	struct phy_device *phydev = ctx->phydev;
+	struct nxp_c45_phy *priv = phydev->priv;
+	struct macsec_rx_sa_stats *stats;
+	struct nxp_c45_secy *phy_secy;
+	u8 an = ctx->sa.assoc_num;
+	struct nxp_c45_sa *sa;
+
+	phy_secy = nxp_c45_find_secy(&priv->macsec->secy_list, ctx->secy->sci);
+	if (IS_ERR(phy_secy))
+		return PTR_ERR(phy_secy);
+
+	sa = nxp_c45_find_sa(&phy_secy->sa_list, RX_SA, an);
+	if (IS_ERR(sa))
+		return PTR_ERR(sa);
+
+	stats = ctx->stats.rx_sa_stats;
+	nxp_c45_select_secy(phydev, phy_secy->secy_id);
+
+	nxp_c45_rx_sa_read_stats(phydev, sa, stats);
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0INUSS + an * 4,
+			    &stats->InPktsNotUsingSA);
+	nxp_c45_macsec_read(phydev, MACSEC_RXAN0IPUSS + an * 4,
+			    &stats->InPktsUnusedSA);
+
+	return 0;
+}
+
 static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_dev_open = nxp_c45_mdo_dev_open,
 	.mdo_dev_stop = nxp_c45_mdo_dev_stop,
@@ -1206,6 +1538,11 @@ static const struct macsec_ops nxp_c45_macsec_ops = {
 	.mdo_add_txsa = nxp_c45_mdo_add_txsa,
 	.mdo_upd_txsa = nxp_c45_mdo_upd_txsa,
 	.mdo_del_txsa = nxp_c45_mdo_del_txsa,
+	.mdo_get_dev_stats = nxp_c45_mdo_get_dev_stats,
+	.mdo_get_tx_sc_stats = nxp_c45_mdo_get_tx_sc_stats,
+	.mdo_get_tx_sa_stats = nxp_c45_mdo_get_tx_sa_stats,
+	.mdo_get_rx_sc_stats = nxp_c45_mdo_get_rx_sc_stats,
+	.mdo_get_rx_sa_stats = nxp_c45_mdo_get_rx_sa_stats,
 };
 
 int nxp_c45_macsec_config_init(struct phy_device *phydev)
-- 
2.34.1

