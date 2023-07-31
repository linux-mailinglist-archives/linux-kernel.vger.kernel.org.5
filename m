Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 762B5769152
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 11:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbjGaJQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 05:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231918AbjGaJQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 05:16:47 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2079.outbound.protection.outlook.com [40.107.13.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183AF11A;
        Mon, 31 Jul 2023 02:16:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5FseaEaOlkAvcafRLJcIOePGUKWKttFsJuCBWRyKcdQp1KNCV7LCDM1ED8nkz1C+4bXvfYUpGb5YMdw4DVy86v+cP6nrt2enpK0/pxWKunJgKQw+I08b4dZQ0QxmwdnqoVMA8JVr1mSYD7C7lBJHDnFNrg1NdBbKxrnPGTSVfIFpdR6DdrKyd0lexg1mQ2Gph5E/8Li6Go3oxZjkvkBcqxRYSU0FDimbGJDE6mH438oPjk4v4EunCmxoUhwTE2N6i3V09MLiKAHa8t+XTjCrvZV9fFUBxEGrC4pWH7pMRFX8+jBL9S67jMOsWxx43mIrUZOBCLiBQKWfStXO7VBUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iZiZJtq0vTcNOIoQ44scOYgmc2EplySMps0/Pj2WC8=;
 b=UxeGWXZOFjyOfjishJL1IRYjv4BS9e2Royx9GzV/WyDQo6+tZ+rabCX/Hhv/Kujft+46sHUwCtn4edC+Z9KElck4HVjw/aESCQK0dIIDlsDyP1Xu28S0HoqIm3AFKpGwuSxfsa1HcxJ/ZAzwaqe8g2gk0DlHzdFu+t+DI5mX6VnX6gYu2M/v3BUmm23GHIrHmSjBCVCQCKflGzV0mT0nQN0RtQ4GxHiIIdxJq4Sxawlo8EjfF8TTrZ8PpzkDcIp2YLSzSc1a+xHQqfI6GJb09S3xmBmTd25/6SBCO8pWbBGWa4Jrp26uDAqNjnNAVSJ2Nc/5J0+jKaZWefj+WCADtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iZiZJtq0vTcNOIoQ44scOYgmc2EplySMps0/Pj2WC8=;
 b=FzFWbt+QKq/3cUhF0KQbubJcFDI+oYMm7quEgLqxKkzm3cWMnUc6DPYQDZjtd3bIlcBISFwksSspI5pMrKuYNiV+JO3eqDy9+ZcUtuELZbfHttHkLTzpDfwBvi+WHvPEuQfhATm8BgTWUR8M0XqIjtNqltZf+DpqnPFwiK7nr9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by PAXPR04MB9280.eurprd04.prod.outlook.com (2603:10a6:102:2b6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 09:16:40 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 09:16:40 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v5 03/11] net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
Date:   Mon, 31 Jul 2023 12:16:11 +0300
Message-Id: <20230731091619.77961-4-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230731091619.77961-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0044.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::13) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|PAXPR04MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6d5281-53db-46ab-3d08-08db91a6d94f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEyERKekj5adrHGoQD7qf+U8hJDpJ8AbYVMyZIgMiNReLr9CnZl/aeESYG9s8Dhh1k9HmwRMiXnZ39/FaUtwM9sjm+GXCkGk9EX9Vg/ZuppAv8mSZG1QNI1fGV6jpDXE4UxQE9LI3IRIUbSdKEFdj3HCgiAiQghyCuA2fiR4CFJxSs5nmo+kYAlDDbDQlVyH22WS1aQ2Zf6EFA4ikXmtVMNp6HUGOVh02gCyotfH8o5xTmg73WaToGxWIG6tQv8asDaAOdoXckAK9PMnr5ieB8V7yqM8a9/zdlF1O6RNp2Nxvk4uiYxrsmhf2Z1BGlILRB5orrLaD7WGWx/5vQN+DfQuS3UlAkbhoLXMLpjMmu8V0F3uTZ4ncJw15te7UtYwigyTjo0Zp+I8LgNzMLptDHEx52pPJkIA7KNWK9mNLEUch6PUwmzKdDTAp4FmZXW9BLoH4+JgcRiGL2AC7YNwJ2sskEnzg7XlZXcrhrPR5OcyJx2mP14UJkvvWjpt/918kLCZhWvebNs39Lj10DW7fg6hCAGwzRAaEIeD7BSCrewUeAVQSnsU7kX2mtQ6GQQjhjM+oKpPRIZ2ieyODF/MLsZnPhGOolQ0qyT7LzG9RavXw0aLClLKYlJAZBNz1SW1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199021)(5660300002)(66946007)(66556008)(66476007)(2906002)(4326008)(7416002)(316002)(30864003)(41300700001)(2616005)(6486002)(478600001)(6666004)(52116002)(8936002)(8676002)(1076003)(26005)(6506007)(186003)(66574015)(83380400001)(38100700002)(38350700002)(86362001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7SyU/ExbW7Q93CrTUvYYLY47Y/ldpfHp2KLS3wfSaH96iA4AQMdywzuakMqj?=
 =?us-ascii?Q?2RIiNMH5EpLWwt0qkE8X17stcKw/OdR/2jl05uwjynlCSzmyLsGkXTnZRMpA?=
 =?us-ascii?Q?Rw+J4gPJ0EgQ6e7g4I9nwq1Z/+rLohLz+z0QcvDHHkuIDn1ocutTVTmG3eSv?=
 =?us-ascii?Q?Q47O9/CylgSW61cI4im2iw7bbXTzHg5F655tgaSmBJ9a2zV6EDNTzCsOw+Dl?=
 =?us-ascii?Q?50VmBgetV6Sd8tuViEZ8rR1Z3l+xe/Z3ESCFySdQtqx7eY0LfUl9VrBLTCFR?=
 =?us-ascii?Q?UEbSfsRT8VvwW9qD/WthA3upkOBBebcU9nZxJwGuDDgj6BEIC2WP6/3bi1mF?=
 =?us-ascii?Q?Y7XYiJNa+VxfbbHQoLUgKVfrFT79IRmgLsiJe9gNUXMOM6vmQenXSldpcd9j?=
 =?us-ascii?Q?ufQb2pTQs+hNeiDHtDEexisA90eETBPmapj4rdzULB+zeya8qRlifz7+Ei1/?=
 =?us-ascii?Q?CqrOYerLhbeu4HgQctS/m3mVEsQIiL9TtlgifEGIHwuN5eLrP8V/pl1Y6f8F?=
 =?us-ascii?Q?oJY82FqAlknMpqhe1ql49GaSvvgg6EgjMUt0FZua7LHLQaKUFdyGs2GtfayH?=
 =?us-ascii?Q?jJsvy/X2yivCvTsRVnRiyIKwzFabyvFWRbWPmrZdR5CscEMiEF5dJ9DvhDJm?=
 =?us-ascii?Q?+oaQn67kMGR5EUW08U1VcAqTCwRf9ZtNoFlgxRZPw/D0ChmeoNkazZB0SL/x?=
 =?us-ascii?Q?dKcdz+8PyLCZ75WYHvtcEClxMvQ4zAk4pMd1Bz4sVjlhGmxSoypHJlernBu9?=
 =?us-ascii?Q?bfsErOSe1Iq7GmxgIng6rOrnl2yGf9B7JJ9wMXm+9glxffGhTtR8RGtzt1Up?=
 =?us-ascii?Q?q8NITAZU5Ax0U6oDUD0Cet4tMHCvH0zLh3eR1qTihf1u9knrtcS+eWCO0P5E?=
 =?us-ascii?Q?y9QjQkBonMspyJX/FpM9ylFUlCe7f3K+bUy/jurLxhwunVvzn1NhYgjaO7Xl?=
 =?us-ascii?Q?n5oGmRPqzArQlflp8hadeunoXGHUDqy3fsCrWa/y1d0P/6D/b4UiQBHa3vC7?=
 =?us-ascii?Q?qaXeLF3kxx1rhT1JX6noH5la9JI2UznrtFeZMf0ttd7P2Lek76hlz6Py5kS5?=
 =?us-ascii?Q?Iq0pTfAVLNRQZAlluZzaRzoO8UxJ++6Ssjp981285h6qLXWMley62Bgi/JRj?=
 =?us-ascii?Q?Lc74Zjd3R4F01z7/HkTVbTmchdfW8GnxIz5QdPXbHrEqpu41SOdaYS1Ga3zw?=
 =?us-ascii?Q?EHKBGn9BEDVQdGCepO8KHBP3sImF8om2yZAWEQp9Pm8U8uqtfkhMCBjGEANR?=
 =?us-ascii?Q?eRSFCSqxJnHeCm0UIZW/eeya8G30ywBEIaYZ0FoedKyFbq5AvR9g4dI9xyiC?=
 =?us-ascii?Q?8Wkn8I/QhYeOQLApPheoJB3tQaocXRo/t59nDGB09+g3PJ1ApTM5tA2XrwNp?=
 =?us-ascii?Q?q42OEiDUHH12GfQf2/iokVMLeYTz70GjYyWUCm/+TEz4Zdv9d2EBt54Yyo0R?=
 =?us-ascii?Q?6PvUCOAyIhmU+u5/sVUnAvlza6Qv+WrXC83ZIB7S2Ve6E0fVDXI7jQQMVq9m?=
 =?us-ascii?Q?KhsvTNnDDgJ1u87o4fCmFeokOqbd9BJlAHIfKBdRwg7AsnhMfWLPnjHxSlQ1?=
 =?us-ascii?Q?qrrIGo8wbA/C76LFtObB85bFp6UQWD2n6trgX1Fe51PbOm9omN76lA8cxUia?=
 =?us-ascii?Q?TQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6d5281-53db-46ab-3d08-08db91a6d94f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 09:16:40.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dNTZTyMfhFzlNRMba3dzQKildDFgT+CzcIEfND4aJ+9dpQNpDyPILmzQfi9yV05g06qjFyEy2yCO6P4Nu5bGzbCPncMi6WWAnZiqCFVMEDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9280
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Between TJA1120 and TJA1103 the hardware was improved, but some register
addresses were changed and some bit fields were moved from one register
to another.

Introduce the nxp_c45_reg_field structure and its associated functions to
abstract the differences between the PHYs.

Remove the defined bits and register addresses that are not common
between TJA1103 and TJA1120 and replace them with reg_fields and
register addresses from phydev->drv->driver_data.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 574 +++++++++++++++++++++---------
 1 file changed, 406 insertions(+), 168 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index f1f15a1b6cfc..d5981985b320 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -41,10 +41,8 @@
 #define SQI_MASK			GENMASK(2, 0)
 #define MAX_SQI				SQI_MASK
 
-#define VEND1_CABLE_TEST		0x8330
 #define CABLE_TEST_ENABLE		BIT(15)
 #define CABLE_TEST_START		BIT(14)
-#define CABLE_TEST_VALID		BIT(13)
 #define CABLE_TEST_OK			0x00
 #define CABLE_TEST_SHORTED		0x01
 #define CABLE_TEST_OPEN			0x02
@@ -89,59 +87,18 @@
 
 #define VEND1_PTP_CONFIG		0x1102
 #define EXT_TRG_EDGE			BIT(1)
-#define PPS_OUT_POL			BIT(2)
-#define PPS_OUT_EN			BIT(3)
 
-#define VEND1_LTC_LOAD_CTRL		0x1105
-#define READ_LTC			BIT(2)
-#define LOAD_LTC			BIT(0)
-
-#define VEND1_LTC_WR_NSEC_0		0x1106
-#define VEND1_LTC_WR_NSEC_1		0x1107
-#define VEND1_LTC_WR_SEC_0		0x1108
-#define VEND1_LTC_WR_SEC_1		0x1109
-
-#define VEND1_LTC_RD_NSEC_0		0x110A
-#define VEND1_LTC_RD_NSEC_1		0x110B
-#define VEND1_LTC_RD_SEC_0		0x110C
-#define VEND1_LTC_RD_SEC_1		0x110D
-
-#define VEND1_RATE_ADJ_SUBNS_0		0x110F
-#define VEND1_RATE_ADJ_SUBNS_1		0x1110
 #define CLK_RATE_ADJ_LD			BIT(15)
 #define CLK_RATE_ADJ_DIR		BIT(14)
 
-#define VEND1_HW_LTC_LOCK_CTRL		0x1115
-#define HW_LTC_LOCK_EN			BIT(0)
-
-#define VEND1_PTP_IRQ_EN		0x1131
-#define VEND1_PTP_IRQ_STATUS		0x1132
-#define PTP_IRQ_EGR_TS			BIT(0)
-
 #define VEND1_RX_TS_INSRT_CTRL		0x114D
-#define RX_TS_INSRT_MODE2		0x02
+#define TJA1103_RX_TS_INSRT_MODE2	0x02
 
 #define VEND1_EGR_RING_DATA_0		0x114E
-#define VEND1_EGR_RING_DATA_1_SEQ_ID	0x114F
-#define VEND1_EGR_RING_DATA_2_NSEC_15_0	0x1150
-#define VEND1_EGR_RING_DATA_3		0x1151
 #define VEND1_EGR_RING_CTRL		0x1154
 
-#define VEND1_EXT_TRG_TS_DATA_0		0x1121
-#define VEND1_EXT_TRG_TS_DATA_1		0x1122
-#define VEND1_EXT_TRG_TS_DATA_2		0x1123
-#define VEND1_EXT_TRG_TS_DATA_3		0x1124
-#define VEND1_EXT_TRG_TS_DATA_4		0x1125
-#define VEND1_EXT_TRG_TS_CTRL		0x1126
-
-#define RING_DATA_0_DOMAIN_NUMBER	GENMASK(7, 0)
-#define RING_DATA_0_MSG_TYPE		GENMASK(11, 8)
-#define RING_DATA_0_SEC_4_2		GENMASK(14, 2)
 #define RING_DATA_0_TS_VALID		BIT(15)
 
-#define RING_DATA_3_NSEC_29_16		GENMASK(13, 0)
-#define RING_DATA_3_SEC_1_0		GENMASK(15, 14)
-#define RING_DATA_5_SEC_16_5		GENMASK(15, 4)
 #define RING_DONE			BIT(0)
 
 #define TS_SEC_MASK			GENMASK(1, 0)
@@ -152,18 +109,11 @@
 #define VEND1_PORT_PTP_CONTROL		0x9000
 #define PORT_PTP_CONTROL_BYPASS		BIT(11)
 
-#define VEND1_PTP_CLK_PERIOD		0x1104
 #define PTP_CLK_PERIOD_100BT1		15ULL
 
-#define VEND1_EVENT_MSG_FILT		0x1148
 #define EVENT_MSG_FILT_ALL		0x0F
 #define EVENT_MSG_FILT_NONE		0x00
 
-#define VEND1_TX_PIPE_DLY_NS		0x1149
-#define VEND1_TX_PIPEDLY_SUBNS		0x114A
-#define VEND1_RX_PIPE_DLY_NS		0x114B
-#define VEND1_RX_PIPEDLY_SUBNS		0x114C
-
 #define VEND1_GPIO_FUNC_CONFIG_BASE	0x2C40
 #define GPIO_FUNC_EN			BIT(15)
 #define GPIO_FUNC_PTP			BIT(6)
@@ -181,8 +131,8 @@
 #define MAX_ID_PS			2260U
 #define DEFAULT_ID_PS			2000U
 
-#define PPM_TO_SUBNS_INC(ppb)	div_u64(GENMASK_ULL(31, 0) * (ppb) * \
-					PTP_CLK_PERIOD_100BT1, NSEC_PER_SEC)
+#define PPM_TO_SUBNS_INC(ppb, ptp_clk_period) div_u64(GENMASK_ULL(31, 0) * \
+	(ppb) * (ptp_clk_period), NSEC_PER_SEC)
 
 #define NXP_C45_SKB_CB(skb)	((struct nxp_c45_skb_cb *)(skb)->cb)
 
@@ -191,6 +141,21 @@ struct nxp_c45_skb_cb {
 	unsigned int type;
 };
 
+#define NXP_C45_REG_FIELD(_reg, _devad, _offset, _size)	\
+	((struct nxp_c45_reg_field) {			\
+		.reg = _reg,				\
+		.devad =  _devad,			\
+		.offset = _offset,			\
+		.size = _size,				\
+	})
+
+struct nxp_c45_reg_field {
+	u16 reg;
+	u8 devad;
+	u8 offset;
+	u8 size;
+};
+
 struct nxp_c45_hwts {
 	u32	nsec;
 	u32	sec;
@@ -199,7 +164,69 @@ struct nxp_c45_hwts {
 	u8	msg_type;
 };
 
+struct nxp_c45_regmap {
+	/* PTP config regs. */
+	u16 vend1_ptp_clk_period;
+	u16 vend1_event_msg_filt;
+
+	/* LTC bits and regs. */
+	struct nxp_c45_reg_field ltc_read;
+	struct nxp_c45_reg_field ltc_write;
+	struct nxp_c45_reg_field ltc_lock_ctrl;
+	u16 vend1_ltc_wr_nsec_0;
+	u16 vend1_ltc_wr_nsec_1;
+	u16 vend1_ltc_wr_sec_0;
+	u16 vend1_ltc_wr_sec_1;
+	u16 vend1_ltc_rd_nsec_0;
+	u16 vend1_ltc_rd_nsec_1;
+	u16 vend1_ltc_rd_sec_0;
+	u16 vend1_ltc_rd_sec_1;
+	u16 vend1_rate_adj_subns_0;
+	u16 vend1_rate_adj_subns_1;
+
+	/* External trigger reg fields. */
+	struct nxp_c45_reg_field irq_egr_ts_en;
+	struct nxp_c45_reg_field irq_egr_ts_status;
+	struct nxp_c45_reg_field domain_number;
+	struct nxp_c45_reg_field msg_type;
+	struct nxp_c45_reg_field sequence_id;
+	struct nxp_c45_reg_field sec_1_0;
+	struct nxp_c45_reg_field sec_4_2;
+	struct nxp_c45_reg_field nsec_15_0;
+	struct nxp_c45_reg_field nsec_29_16;
+
+	/* PPS and EXT Trigger bits and regs. */
+	struct nxp_c45_reg_field pps_enable;
+	struct nxp_c45_reg_field pps_polarity;
+	u16 vend1_ext_trg_data_0;
+	u16 vend1_ext_trg_data_1;
+	u16 vend1_ext_trg_data_2;
+	u16 vend1_ext_trg_data_3;
+	u16 vend1_ext_trg_ctrl;
+
+	/* Cable test reg fields. */
+	u16 cable_test;
+	struct nxp_c45_reg_field cable_test_valid;
+	struct nxp_c45_reg_field cable_test_result;
+};
+
+struct nxp_c45_phy_stats {
+	const char	*name;
+	const struct nxp_c45_reg_field counter;
+};
+
+struct nxp_c45_phy_data {
+	const struct nxp_c45_regmap *regmap;
+	const struct nxp_c45_phy_stats *stats;
+	int n_stats;
+	u8 ptp_clk_period;
+	void (*counters_enable)(struct phy_device *phydev);
+	void (*ptp_init)(struct phy_device *phydev);
+	void (*ptp_enable)(struct phy_device *phydev, bool enable);
+};
+
 struct nxp_c45_phy {
+	const struct nxp_c45_phy_data *phy_data;
 	struct phy_device *phydev;
 	struct mii_timestamper mii_ts;
 	struct ptp_clock *ptp_clock;
@@ -217,13 +244,86 @@ struct nxp_c45_phy {
 	bool extts;
 };
 
-struct nxp_c45_phy_stats {
-	const char	*name;
-	u8		mmd;
-	u16		reg;
-	u8		off;
-	u16		mask;
-};
+static const
+struct nxp_c45_phy_data *nxp_c45_get_data(struct phy_device *phydev)
+{
+	return phydev->drv->driver_data;
+}
+
+static const
+struct nxp_c45_regmap *nxp_c45_get_regmap(struct phy_device *phydev)
+{
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+
+	return phy_data->regmap;
+}
+
+static int nxp_c45_read_reg_field(struct phy_device *phydev,
+				  const struct nxp_c45_reg_field *reg_field)
+{
+	u16 mask;
+	int ret;
+
+	if (reg_field->size == 0) {
+		phydev_err(phydev, "Trying to read a reg field of size 0.\n");
+		return -EINVAL;
+	}
+
+	ret = phy_read_mmd(phydev, reg_field->devad, reg_field->reg);
+	if (ret < 0)
+		return ret;
+
+	mask = reg_field->size == 1 ? BIT(reg_field->offset) :
+		GENMASK(reg_field->offset + reg_field->size - 1,
+			reg_field->offset);
+	ret &= mask;
+	ret >>= reg_field->offset;
+
+	return ret;
+}
+
+static int nxp_c45_write_reg_field(struct phy_device *phydev,
+				   const struct nxp_c45_reg_field *reg_field,
+				   u16 val)
+{
+	u16 mask;
+	u16 set;
+
+	if (reg_field->size == 0) {
+		phydev_err(phydev, "Trying to write a reg field of size 0.\n");
+		return -EINVAL;
+	}
+
+	mask = reg_field->size == 1 ? BIT(reg_field->offset) :
+		GENMASK(reg_field->offset + reg_field->size - 1,
+			reg_field->offset);
+	set = val << reg_field->offset;
+
+	return phy_modify_mmd_changed(phydev, reg_field->devad,
+				      reg_field->reg, mask, set);
+}
+
+static int nxp_c45_set_reg_field(struct phy_device *phydev,
+				 const struct nxp_c45_reg_field *reg_field)
+{
+	if (reg_field->size != 1) {
+		phydev_err(phydev, "Trying to set a reg field of size different than 1.\n");
+		return -EINVAL;
+	}
+
+	return nxp_c45_write_reg_field(phydev, reg_field, 1);
+}
+
+static int nxp_c45_clear_reg_field(struct phy_device *phydev,
+				   const struct nxp_c45_reg_field *reg_field)
+{
+	if (reg_field->size != 1) {
+		phydev_err(phydev, "Trying to set a reg field of size different than 1.\n");
+		return -EINVAL;
+	}
+
+	return nxp_c45_write_reg_field(phydev, reg_field, 0);
+}
 
 static bool nxp_c45_poll_txts(struct phy_device *phydev)
 {
@@ -235,17 +335,17 @@ static int _nxp_c45_ptp_gettimex64(struct ptp_clock_info *ptp,
 				   struct ptp_system_timestamp *sts)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_LOAD_CTRL,
-		      READ_LTC);
+	nxp_c45_set_reg_field(priv->phydev, &regmap->ltc_read);
 	ts->tv_nsec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				   VEND1_LTC_RD_NSEC_0);
+				   regmap->vend1_ltc_rd_nsec_0);
 	ts->tv_nsec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				    VEND1_LTC_RD_NSEC_1) << 16;
+				    regmap->vend1_ltc_rd_nsec_1) << 16;
 	ts->tv_sec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				  VEND1_LTC_RD_SEC_0);
+				  regmap->vend1_ltc_rd_sec_0);
 	ts->tv_sec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				   VEND1_LTC_RD_SEC_1) << 16;
+				   regmap->vend1_ltc_rd_sec_1) << 16;
 
 	return 0;
 }
@@ -267,17 +367,17 @@ static int _nxp_c45_ptp_settime64(struct ptp_clock_info *ptp,
 				  const struct timespec64 *ts)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_NSEC_0,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_nsec_0,
 		      ts->tv_nsec);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_NSEC_1,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_nsec_1,
 		      ts->tv_nsec >> 16);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_SEC_0,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_sec_0,
 		      ts->tv_sec);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_WR_SEC_1,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, regmap->vend1_ltc_wr_sec_1,
 		      ts->tv_sec >> 16);
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_LTC_LOAD_CTRL,
-		      LOAD_LTC);
+	nxp_c45_set_reg_field(priv->phydev, &regmap->ltc_write);
 
 	return 0;
 }
@@ -297,6 +397,8 @@ static int nxp_c45_ptp_settime64(struct ptp_clock_info *ptp,
 static int nxp_c45_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 {
 	struct nxp_c45_phy *priv = container_of(ptp, struct nxp_c45_phy, caps);
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(priv->phydev);
+	const struct nxp_c45_regmap *regmap = data->regmap;
 	s32 ppb = scaled_ppm_to_ppb(scaled_ppm);
 	u64 subns_inc_val;
 	bool inc;
@@ -305,16 +407,18 @@ static int nxp_c45_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
 	inc = ppb >= 0;
 	ppb = abs(ppb);
 
-	subns_inc_val = PPM_TO_SUBNS_INC(ppb);
+	subns_inc_val = PPM_TO_SUBNS_INC(ppb, data->ptp_clk_period);
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_RATE_ADJ_SUBNS_0,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
+		      regmap->vend1_rate_adj_subns_0,
 		      subns_inc_val);
 	subns_inc_val >>= 16;
 	subns_inc_val |= CLK_RATE_ADJ_LD;
 	if (inc)
 		subns_inc_val |= CLK_RATE_ADJ_DIR;
 
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_RATE_ADJ_SUBNS_1,
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
+		      regmap->vend1_rate_adj_subns_1,
 		      subns_inc_val);
 	mutex_unlock(&priv->ptp_lock);
 
@@ -358,21 +462,25 @@ static bool nxp_c45_match_ts(struct ptp_header *header,
 static void nxp_c45_get_extts(struct nxp_c45_phy *priv,
 			      struct timespec64 *extts)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
+
 	extts->tv_nsec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				      VEND1_EXT_TRG_TS_DATA_0);
+				      regmap->vend1_ext_trg_data_0);
 	extts->tv_nsec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				       VEND1_EXT_TRG_TS_DATA_1) << 16;
+				       regmap->vend1_ext_trg_data_1) << 16;
 	extts->tv_sec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				     VEND1_EXT_TRG_TS_DATA_2);
+				     regmap->vend1_ext_trg_data_2);
 	extts->tv_sec |= phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				      VEND1_EXT_TRG_TS_DATA_3) << 16;
-	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EXT_TRG_TS_CTRL,
-		      RING_DONE);
+				      regmap->vend1_ext_trg_data_3) << 16;
+	phy_write_mmd(priv->phydev, MDIO_MMD_VEND1,
+		      regmap->vend1_ext_trg_ctrl, RING_DONE);
 }
 
 static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
 			       struct nxp_c45_hwts *hwts)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
+	struct phy_device *phydev = priv->phydev;
 	bool valid;
 	u16 reg;
 
@@ -384,16 +492,18 @@ static bool nxp_c45_get_hwtxts(struct nxp_c45_phy *priv,
 	if (!valid)
 		goto nxp_c45_get_hwtxts_out;
 
-	hwts->domain_number = reg;
-	hwts->msg_type = (reg & RING_DATA_0_MSG_TYPE) >> 8;
-	hwts->sec = (reg & RING_DATA_0_SEC_4_2) >> 10;
-	hwts->sequence_id = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-					 VEND1_EGR_RING_DATA_1_SEQ_ID);
-	hwts->nsec = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1,
-				  VEND1_EGR_RING_DATA_2_NSEC_15_0);
-	reg = phy_read_mmd(priv->phydev, MDIO_MMD_VEND1, VEND1_EGR_RING_DATA_3);
-	hwts->nsec |= (reg & RING_DATA_3_NSEC_29_16) << 16;
-	hwts->sec |= (reg & RING_DATA_3_SEC_1_0) >> 14;
+	hwts->domain_number =
+		nxp_c45_read_reg_field(phydev, &regmap->domain_number);
+	hwts->msg_type =
+		nxp_c45_read_reg_field(phydev, &regmap->msg_type);
+	hwts->sequence_id =
+		nxp_c45_read_reg_field(phydev, &regmap->sequence_id);
+	hwts->nsec =
+		nxp_c45_read_reg_field(phydev, &regmap->nsec_15_0);
+	hwts->nsec |=
+		nxp_c45_read_reg_field(phydev, &regmap->nsec_29_16) << 16;
+	hwts->sec = nxp_c45_read_reg_field(phydev, &regmap->sec_1_0);
+	hwts->sec |= nxp_c45_read_reg_field(phydev, &regmap->sec_4_2) << 2;
 
 nxp_c45_get_hwtxts_out:
 	mutex_unlock(&priv->ptp_lock);
@@ -498,6 +608,7 @@ static void nxp_c45_gpio_config(struct nxp_c45_phy *priv,
 static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 				 struct ptp_perout_request *perout, int on)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(priv->phydev);
 	struct phy_device *phydev = priv->phydev;
 	int pin;
 
@@ -509,10 +620,10 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 		return pin;
 
 	if (!on) {
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CONFIG,
-				   PPS_OUT_EN);
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CONFIG,
-				   PPS_OUT_POL);
+		nxp_c45_clear_reg_field(priv->phydev,
+					&regmap->pps_enable);
+		nxp_c45_clear_reg_field(priv->phydev,
+					&regmap->pps_polarity);
 
 		nxp_c45_gpio_config(priv, pin, GPIO_DISABLE);
 
@@ -541,16 +652,16 @@ static int nxp_c45_perout_enable(struct nxp_c45_phy *priv,
 		}
 
 		if (perout->phase.nsec == 0)
-			phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-					   VEND1_PTP_CONFIG, PPS_OUT_POL);
+			nxp_c45_clear_reg_field(priv->phydev,
+						&regmap->pps_polarity);
 		else
-			phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
-					 VEND1_PTP_CONFIG, PPS_OUT_POL);
+			nxp_c45_set_reg_field(priv->phydev,
+					      &regmap->pps_polarity);
 	}
 
 	nxp_c45_gpio_config(priv, pin, GPIO_PPS_OUT_CFG);
 
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CONFIG, PPS_OUT_EN);
+	nxp_c45_set_reg_field(priv->phydev, &regmap->pps_enable);
 
 	return 0;
 }
@@ -725,6 +836,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
 	struct nxp_c45_phy *priv = container_of(mii_ts, struct nxp_c45_phy,
 						mii_ts);
 	struct phy_device *phydev = priv->phydev;
+	const struct nxp_c45_phy_data *data;
 	struct hwtstamp_config cfg;
 
 	if (copy_from_user(&cfg, ifreq->ifr_data, sizeof(cfg)))
@@ -733,6 +845,7 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
 	if (cfg.tx_type < 0 || cfg.tx_type > HWTSTAMP_TX_ON)
 		return -ERANGE;
 
+	data = nxp_c45_get_data(phydev);
 	priv->hwts_tx = cfg.tx_type;
 
 	switch (cfg.rx_filter) {
@@ -750,27 +863,24 @@ static int nxp_c45_hwtstamp(struct mii_timestamper *mii_ts,
 	}
 
 	if (priv->hwts_rx || priv->hwts_tx) {
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_EVENT_MSG_FILT,
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      data->regmap->vend1_event_msg_filt,
 			      EVENT_MSG_FILT_ALL);
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-				   VEND1_PORT_PTP_CONTROL,
-				   PORT_PTP_CONTROL_BYPASS);
+		data->ptp_enable(phydev, true);
 	} else {
-		phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_EVENT_MSG_FILT,
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      data->regmap->vend1_event_msg_filt,
 			      EVENT_MSG_FILT_NONE);
-		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_PTP_CONTROL,
-				 PORT_PTP_CONTROL_BYPASS);
+		data->ptp_enable(phydev, false);
 	}
 
 	if (nxp_c45_poll_txts(priv->phydev))
 		goto nxp_c45_no_ptp_irq;
 
 	if (priv->hwts_tx)
-		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
-				 VEND1_PTP_IRQ_EN, PTP_IRQ_EGR_TS);
+		nxp_c45_set_reg_field(phydev, &data->regmap->irq_egr_ts_en);
 	else
-		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
-				   VEND1_PTP_IRQ_EN, PTP_IRQ_EGR_TS);
+		nxp_c45_clear_reg_field(phydev, &data->regmap->irq_egr_ts_en);
 
 nxp_c45_no_ptp_irq:
 	return copy_to_user(ifreq->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
@@ -795,57 +905,79 @@ static int nxp_c45_ts_info(struct mii_timestamper *mii_ts,
 	return 0;
 }
 
-static const struct nxp_c45_phy_stats nxp_c45_hw_stats[] = {
-	{ "phy_symbol_error_cnt", MDIO_MMD_VEND1,
-		VEND1_SYMBOL_ERROR_COUNTER, 0, GENMASK(15, 0) },
-	{ "phy_link_status_drop_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_DROP_COUNTER, 8, GENMASK(13, 8) },
-	{ "phy_link_availability_drop_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_DROP_COUNTER, 0, GENMASK(5, 0) },
-	{ "phy_link_loss_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_LOSSES_AND_FAILURES, 10, GENMASK(15, 10) },
-	{ "phy_link_failure_cnt", MDIO_MMD_VEND1,
-		VEND1_LINK_LOSSES_AND_FAILURES, 0, GENMASK(9, 0) },
-	{ "rx_preamble_count", MDIO_MMD_VEND1,
-		VEND1_RX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
-	{ "tx_preamble_count", MDIO_MMD_VEND1,
-		VEND1_TX_PREAMBLE_COUNT, 0, GENMASK(5, 0) },
-	{ "rx_ipg_length", MDIO_MMD_VEND1,
-		VEND1_RX_IPG_LENGTH, 0, GENMASK(8, 0) },
-	{ "tx_ipg_length", MDIO_MMD_VEND1,
-		VEND1_TX_IPG_LENGTH, 0, GENMASK(8, 0) },
+static const struct nxp_c45_phy_stats common_hw_stats[] = {
+	{ "phy_link_status_drop_cnt",
+		NXP_C45_REG_FIELD(0x8352, MDIO_MMD_VEND1, 8, 6), },
+	{ "phy_link_availability_drop_cnt",
+		NXP_C45_REG_FIELD(0x8352, MDIO_MMD_VEND1, 0, 6), },
+	{ "phy_link_loss_cnt",
+		NXP_C45_REG_FIELD(0x8353, MDIO_MMD_VEND1, 10, 6), },
+	{ "phy_link_failure_cnt",
+		NXP_C45_REG_FIELD(0x8353, MDIO_MMD_VEND1, 0, 10), },
+	{ "phy_symbol_error_cnt",
+		NXP_C45_REG_FIELD(0x8350, MDIO_MMD_VEND1, 0, 16) },
+};
+
+static const struct nxp_c45_phy_stats tja1103_hw_stats[] = {
+	{ "rx_preamble_count",
+		NXP_C45_REG_FIELD(0xAFCE, MDIO_MMD_VEND1, 0, 6), },
+	{ "tx_preamble_count",
+		NXP_C45_REG_FIELD(0xAFCF, MDIO_MMD_VEND1, 0, 6), },
+	{ "rx_ipg_length",
+		NXP_C45_REG_FIELD(0xAFD0, MDIO_MMD_VEND1, 0, 9), },
+	{ "tx_ipg_length",
+		NXP_C45_REG_FIELD(0xAFD1, MDIO_MMD_VEND1, 0, 9), },
 };
 
 static int nxp_c45_get_sset_count(struct phy_device *phydev)
 {
-	return ARRAY_SIZE(nxp_c45_hw_stats);
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+
+	return ARRAY_SIZE(common_hw_stats) + (phy_data ? phy_data->n_stats : 0);
 }
 
 static void nxp_c45_get_strings(struct phy_device *phydev, u8 *data)
 {
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+	size_t count = nxp_c45_get_sset_count(phydev);
+	size_t idx;
 	size_t i;
 
-	for (i = 0; i < ARRAY_SIZE(nxp_c45_hw_stats); i++) {
-		strncpy(data + i * ETH_GSTRING_LEN,
-			nxp_c45_hw_stats[i].name, ETH_GSTRING_LEN);
+	for (i = 0; i < count; i++) {
+		if (i < ARRAY_SIZE(common_hw_stats)) {
+			strscpy(data + i * ETH_GSTRING_LEN,
+				common_hw_stats[i].name, ETH_GSTRING_LEN);
+			continue;
+		}
+		idx = i - ARRAY_SIZE(common_hw_stats);
+		strscpy(data + i * ETH_GSTRING_LEN,
+			phy_data->stats[idx].name, ETH_GSTRING_LEN);
 	}
 }
 
 static void nxp_c45_get_stats(struct phy_device *phydev,
 			      struct ethtool_stats *stats, u64 *data)
 {
+	const struct nxp_c45_phy_data *phy_data = nxp_c45_get_data(phydev);
+	size_t count = nxp_c45_get_sset_count(phydev);
+	const struct nxp_c45_reg_field *reg_field;
+	size_t idx;
 	size_t i;
 	int ret;
 
-	for (i = 0; i < ARRAY_SIZE(nxp_c45_hw_stats); i++) {
-		ret = phy_read_mmd(phydev, nxp_c45_hw_stats[i].mmd,
-				   nxp_c45_hw_stats[i].reg);
-		if (ret < 0) {
-			data[i] = U64_MAX;
+	for (i = 0; i < count; i++) {
+		if (i < ARRAY_SIZE(common_hw_stats)) {
+			reg_field = &common_hw_stats[i].counter;
 		} else {
-			data[i] = ret & nxp_c45_hw_stats[i].mask;
-			data[i] >>= nxp_c45_hw_stats[i].off;
+			idx = i - ARRAY_SIZE(common_hw_stats);
+			reg_field = &phy_data->stats[idx].counter;
 		}
+
+		ret = nxp_c45_read_reg_field(phydev, reg_field);
+		if (ret < 0)
+			data[i] = U64_MAX;
+		else
+			data[i] = ret;
 	}
 }
 
@@ -884,6 +1016,7 @@ static int nxp_c45_config_intr(struct phy_device *phydev)
 
 static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 {
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
 	struct nxp_c45_phy *priv = phydev->priv;
 	irqreturn_t ret = IRQ_NONE;
 	struct nxp_c45_hwts hwts;
@@ -901,8 +1034,8 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 	 * The irq signal will be asserted until the EGR TS FIFO will be
 	 * emptied.
 	 */
-	irq = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_IRQ_STATUS);
-	if (irq & PTP_IRQ_EGR_TS) {
+	irq = nxp_c45_read_reg_field(phydev, &data->regmap->irq_egr_ts_status);
+	if (irq) {
 		while (nxp_c45_get_hwtxts(priv, &hwts))
 			nxp_c45_process_txts(priv, &hwts);
 
@@ -929,24 +1062,28 @@ static int nxp_c45_soft_reset(struct phy_device *phydev)
 
 static int nxp_c45_cable_test_start(struct phy_device *phydev)
 {
-	return phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_CABLE_TEST,
-			     CABLE_TEST_ENABLE | CABLE_TEST_START);
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
+
+	return phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
+				CABLE_TEST_ENABLE | CABLE_TEST_START);
 }
 
 static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 					 bool *finished)
 {
+	const struct nxp_c45_regmap *regmap = nxp_c45_get_regmap(phydev);
 	int ret;
 	u8 cable_test_result;
 
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_CABLE_TEST);
-	if (!(ret & CABLE_TEST_VALID)) {
+	ret = nxp_c45_read_reg_field(phydev, &regmap->cable_test_valid);
+	if (!ret) {
 		*finished = false;
 		return 0;
 	}
 
 	*finished = true;
-	cable_test_result = ret & GENMASK(2, 0);
+	cable_test_result = nxp_c45_read_reg_field(phydev,
+						   &regmap->cable_test_result);
 
 	switch (cable_test_result) {
 	case CABLE_TEST_OK:
@@ -966,7 +1103,7 @@ static int nxp_c45_cable_test_get_status(struct phy_device *phydev,
 					ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC);
 	}
 
-	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_CABLE_TEST,
+	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, regmap->cable_test,
 			   CABLE_TEST_ENABLE);
 
 	return nxp_c45_start_op(phydev);
@@ -1005,6 +1142,28 @@ static int nxp_c45_check_delay(struct phy_device *phydev, u32 delay)
 	return 0;
 }
 
+static void nxp_c45_counters_enable(struct phy_device *phydev)
+{
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
+
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_LINK_DROP_COUNTER,
+			 COUNTER_EN);
+
+	data->counters_enable(phydev);
+}
+
+static void nxp_c45_ptp_init(struct phy_device *phydev)
+{
+	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
+
+	phy_write_mmd(phydev, MDIO_MMD_VEND1,
+		      data->regmap->vend1_ptp_clk_period,
+		      data->ptp_clk_period);
+	nxp_c45_clear_reg_field(phydev, &data->regmap->ltc_lock_ctrl);
+
+	data->ptp_init(phydev);
+}
+
 static u64 nxp_c45_get_phase_shift(u64 phase_offset_raw)
 {
 	/* The delay in degree phase is 73.8 + phase_offset_raw * 0.9.
@@ -1182,31 +1341,14 @@ static int nxp_c45_config_init(struct phy_device *phydev)
 	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PHY_CONFIG,
 			 PHY_CONFIG_AUTO);
 
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_LINK_DROP_COUNTER,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_PREAMBLE_COUNT,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_PREAMBLE_COUNT,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_IPG_LENGTH,
-			 COUNTER_EN);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_IPG_LENGTH,
-			 COUNTER_EN);
-
 	ret = nxp_c45_set_phy_mode(phydev);
 	if (ret)
 		return ret;
 
 	phydev->autoneg = AUTONEG_DISABLE;
 
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_PTP_CLK_PERIOD,
-		      PTP_CLK_PERIOD_100BT1);
-	phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_HW_LTC_LOCK_CTRL,
-			   HW_LTC_LOCK_EN);
-	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_TS_INSRT_CTRL,
-		      RX_TS_INSRT_MODE2);
-	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
-			 PTP_ENABLE);
+	nxp_c45_counters_enable(phydev);
+	nxp_c45_ptp_init(phydev);
 
 	return nxp_c45_start_op(phydev);
 }
@@ -1266,11 +1408,107 @@ static void nxp_c45_remove(struct phy_device *phydev)
 	skb_queue_purge(&priv->rx_queue);
 }
 
+static void tja1103_counters_enable(struct phy_device *phydev)
+{
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_PREAMBLE_COUNT,
+			 COUNTER_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_PREAMBLE_COUNT,
+			 COUNTER_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_IPG_LENGTH,
+			 COUNTER_EN);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_TX_IPG_LENGTH,
+			 COUNTER_EN);
+}
+
+static void tja1103_ptp_init(struct phy_device *phydev)
+{
+	phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_RX_TS_INSRT_CTRL,
+		      TJA1103_RX_TS_INSRT_MODE2);
+	phy_set_bits_mmd(phydev, MDIO_MMD_VEND1, VEND1_PORT_FUNC_ENABLES,
+			 PTP_ENABLE);
+}
+
+static void tja1103_ptp_enable(struct phy_device *phydev, bool enable)
+{
+	if (enable)
+		phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+				   VEND1_PORT_PTP_CONTROL,
+				   PORT_PTP_CONTROL_BYPASS);
+	else
+		phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				 VEND1_PORT_PTP_CONTROL,
+				 PORT_PTP_CONTROL_BYPASS);
+}
+
+static const struct nxp_c45_regmap tja1103_regmap = {
+	.vend1_ptp_clk_period	= 0x1104,
+	.vend1_event_msg_filt	= 0x1148,
+	.pps_enable		=
+		NXP_C45_REG_FIELD(0x1102, MDIO_MMD_VEND1, 3, 1),
+	.pps_polarity		=
+		NXP_C45_REG_FIELD(0x1102, MDIO_MMD_VEND1, 2, 1),
+	.ltc_lock_ctrl		=
+		NXP_C45_REG_FIELD(0x1115, MDIO_MMD_VEND1, 0, 1),
+	.ltc_read		=
+		NXP_C45_REG_FIELD(0x1105, MDIO_MMD_VEND1, 2, 1),
+	.ltc_write		=
+		NXP_C45_REG_FIELD(0x1105, MDIO_MMD_VEND1, 0, 1),
+	.vend1_ltc_wr_nsec_0	= 0x1106,
+	.vend1_ltc_wr_nsec_1	= 0x1107,
+	.vend1_ltc_wr_sec_0	= 0x1108,
+	.vend1_ltc_wr_sec_1	= 0x1109,
+	.vend1_ltc_rd_nsec_0	= 0x110A,
+	.vend1_ltc_rd_nsec_1	= 0x110B,
+	.vend1_ltc_rd_sec_0	= 0x110C,
+	.vend1_ltc_rd_sec_1	= 0x110D,
+	.vend1_rate_adj_subns_0	= 0x110F,
+	.vend1_rate_adj_subns_1	= 0x1110,
+	.irq_egr_ts_en		=
+		NXP_C45_REG_FIELD(0x1131, MDIO_MMD_VEND1, 0, 1),
+	.irq_egr_ts_status	=
+		NXP_C45_REG_FIELD(0x1132, MDIO_MMD_VEND1, 0, 1),
+	.domain_number		=
+		NXP_C45_REG_FIELD(0x114E, MDIO_MMD_VEND1, 0, 8),
+	.msg_type		=
+		NXP_C45_REG_FIELD(0x114E, MDIO_MMD_VEND1, 8, 4),
+	.sequence_id		=
+		NXP_C45_REG_FIELD(0x114F, MDIO_MMD_VEND1, 0, 16),
+	.sec_1_0		=
+		NXP_C45_REG_FIELD(0x1151, MDIO_MMD_VEND1, 14, 2),
+	.sec_4_2		=
+		NXP_C45_REG_FIELD(0x114E, MDIO_MMD_VEND1, 12, 3),
+	.nsec_15_0		=
+		NXP_C45_REG_FIELD(0x1150, MDIO_MMD_VEND1, 0, 16),
+	.nsec_29_16		=
+		NXP_C45_REG_FIELD(0x1151, MDIO_MMD_VEND1, 0, 14),
+	.vend1_ext_trg_data_0	= 0x1121,
+	.vend1_ext_trg_data_1	= 0x1122,
+	.vend1_ext_trg_data_2	= 0x1123,
+	.vend1_ext_trg_data_3	= 0x1124,
+	.vend1_ext_trg_ctrl	= 0x1126,
+	.cable_test		= 0x8330,
+	.cable_test_valid	=
+		NXP_C45_REG_FIELD(0x8330, MDIO_MMD_VEND1, 13, 1),
+	.cable_test_result	=
+		NXP_C45_REG_FIELD(0x8330, MDIO_MMD_VEND1, 0, 3),
+};
+
+static const struct nxp_c45_phy_data tja1103_phy_data = {
+	.regmap = &tja1103_regmap,
+	.stats = tja1103_hw_stats,
+	.n_stats = ARRAY_SIZE(tja1103_hw_stats),
+	.ptp_clk_period = PTP_CLK_PERIOD_100BT1,
+	.counters_enable = tja1103_counters_enable,
+	.ptp_init = tja1103_ptp_init,
+	.ptp_enable = tja1103_ptp_enable,
+};
+
 static struct phy_driver nxp_c45_driver[] = {
 	{
 		PHY_ID_MATCH_MODEL(PHY_ID_TJA_1103),
 		.name			= "NXP C45 TJA1103",
 		.features		= PHY_BASIC_T1_FEATURES,
+		.driver_data		= &tja1103_phy_data,
 		.probe			= nxp_c45_probe,
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
-- 
2.34.1

