Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A81DD75F990
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjGXONk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbjGXONA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:13:00 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE7BA3;
        Mon, 24 Jul 2023 07:12:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1uJoIdJW0Fl7F+pesA1MTZtstg/RGMTI2XGJKA7UmVec7BNlalvlmjKlfLhcIecd+heicLNBI5LtoCkWwdH5IKrwPTewCAYnrZCq7hRRNT0HAaHEBY0tm+LhhDEVJ8WnQhmROj17sfG6LSI9RuFrdm55te+dmcfJROh+neL6daKvPPayoVzbIkl6lVMIDxjzQk5ZPDZby75goAFMdpDH4qWIl0ZpxXdcRYeLqfMyNVBHv+SKpmhAqEaskADGr2NRv98uK9wkFJwRipldU5KpyfA487RiuyjJewTNMe/+QUMI9nblk3PsmH8AY7RpyQ7xm7Kk0+WAgyPzhFJERvhcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rMZXnkKBo4A1dquBnTEdn3tY6cHET5be9BRP2PQYBbw=;
 b=KoH/eZORM8ZNKeF3b0zkmUq2bcQUSx3REOISlNo46FmydWhofAQXhQAeS8goMamSdxm3bT0cvzvl6xD80P5+AKskhaYMr2l5p+OVX7s0nLer/r6c0+OlEBOVfDfT9hmzfJKOpcnzugyJogjPsPAcz5KUpi5gwN3DqM8KOTv74zWHA0/AtBgZaNZrie2IhVcNyN7/bIXIbhUvcaiooudUUb24CKDkN8VpZjmiDJ3AcrSHfGONB7OpltlyLtvbOXtg44obs3p11c5Lh46Jk5zJ4jmXsPdK9gnpEdBmA/3wafADJNgRmj9JDlmM56Z+pshmFjnrvZwCvMlSm1DfJnEqqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rMZXnkKBo4A1dquBnTEdn3tY6cHET5be9BRP2PQYBbw=;
 b=jvuWdT6K6sJs0v7PNBKGA9OhIeUHWhJDgV9olWJ/ckWRmxjb6zqXAG7hTGKfUXsBqUUd1BVc8msC6K8IOYbbsC/+0P6BtYjKi0RX30NnfhTRvj4rgPMav7vD11bByXKMnRk33D0wJn5pKuZ0VvwH44kHTqiaPhn59Ap3ww25C4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AS4PR04MB9690.eurprd04.prod.outlook.com (2603:10a6:20b:4fd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 14:12:51 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:51 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 08/11] net: phy: nxp-c45-tja11xx: handle FUSA irq
Date:   Mon, 24 Jul 2023 17:12:29 +0300
Message-Id: <20230724141232.233101-9-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AS4PR04MB9690:EE_
X-MS-Office365-Filtering-Correlation-Id: 265c978d-657c-488a-dea8-08db8c501122
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +QaF01Ce13+JK+sHt+8DLGCBPYRV1u9dCfyJ6vx5R0fxrRqydDVeyF2vyqt7OOeb9ITo2wSROi0z+aV5sFmjuG9FA1LGCE8CaN5xztVEQJhmY0cLo66MP6exzNsOm2zDzU4I7EyKr1UkQii4pgRpcS3tqpmAhhTq045uJ7mdexFmK+hgA87D6sQshzEEpi4vxS6qJliWIHYKx9jnTGD2uX9QViDnQPMDR2YjEDJ5RqXGb1vxzcpGvEOytLAW2mFbjIyM6r/i84j+ATnip9/3J92kUEPoF2p6JEVZWQmr+S0XKKIvvo/MhYAPmyNEcKYBoQy2923BevtFmN5kLOa6clvUkl1GTEf2lulDOodWboFcT9Q2NF0pdpEr8sas6V/0bPc8PxK1xk+GBInvzNU/2hMN2oVme6tUBqI69ejGXVXb340lSsXnzWNtBQwKY/tqkmVkYFcFUaurmsAHqrE7sW4Gh0GZX+aF6qw23y5mtvgkkLDAJeiG7ApgvnCSDcjWPqgyc2omLEmm+02A5qs8HI0eyk8KvMllmBFRWs3kpEEttunr/A7tVYwNCYeTtNPwcyVyQ8lQ39Tly2bmFCRF2gnjVVF61nYly3E5OMuzhtC0cK9RPkKr+5lR+ehfemkw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(8676002)(8936002)(478600001)(2906002)(7416002)(66476007)(66556008)(66946007)(4326008)(316002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(6506007)(1076003)(186003)(26005)(52116002)(6486002)(6512007)(2616005)(6666004)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YBojARZhcYNQS0bTy5LKarET0UHT1zVyEek/7xO8K9BNHi3AXtVXQMrkn7wP?=
 =?us-ascii?Q?YfbAxFgNfouRD3YeAmE6zvYmcKm8VPsSHUdTldJzyvWGJU/IpVtwbNhdDRtf?=
 =?us-ascii?Q?TZsiSb17wGw3Bb7sO4Rz9HNA8pEDmUUZ5QtlJOs3JopLpDyEAemxJoP7Uht/?=
 =?us-ascii?Q?YngZ/HQKZtcbJurAZEt+DXAMVnBbJ1AvAzc2JjlQV8Co2l7kpgcCMbtrK6CV?=
 =?us-ascii?Q?ca1wdNOh/kWJazrj+emXdeLmG8WjzRhd030pAjjoFN+WXyCBmuRKrs5WY4mt?=
 =?us-ascii?Q?cb2AQbi0wH1Te/J1xPw+jTqE0EpgmJb6OgoHXGxeJJ+g7+pNlFCFmRP9LPgN?=
 =?us-ascii?Q?03nFX1O5bdyki5WwMad0fIPcshnBCagGvaPmpuKPV+BaCG3Yc+LHGN94QhWc?=
 =?us-ascii?Q?Q3wBSBYsUus7wojYj7LNXAYpX4tOErBNu3Ujq+kLck8cQCFG8YtPundAYxAD?=
 =?us-ascii?Q?jnTI/YcRcXT48nqgdvdZiShyw3A6AnZSPj7xU7pp1/6JBzPDIVSXFzDOOf0E?=
 =?us-ascii?Q?ZH/RIClLdiP8vMDcNj1v8ccSC6e+osB11B9AL3tEd7rpmgEyD4SSxjmWXYZy?=
 =?us-ascii?Q?s9pxYUH07JplE/5GJ+mlHBwXyUjLrVgZxiiH0ov3NADUdxKP38RiEOREtScf?=
 =?us-ascii?Q?y3yW7EBkDpLH/lcG+RKwt29kqMMTxvGPho5KVR0W7o9qyZFWhBudpp0bIzd6?=
 =?us-ascii?Q?aqB7BopMyktHD+Bbgd5rKdQLn89zJ2M7K0f4TJNZ88p1qEIFMJ2Ci8lUXSxv?=
 =?us-ascii?Q?UcldUm1gSTNKWPii2nWvRXCTHQJ39jVlZtAJldgf2VwzFJcpQuAd9zIm9CBT?=
 =?us-ascii?Q?OI+RMIYzYYaztpif1zDKq2QdutX6DaZiT1t7cH/pdj+J73OYBXXasITNueCt?=
 =?us-ascii?Q?hwVFHUy72gqawIfsnO1qSyUGGXPOMfkNACLS0Rg+1RBogxt/w6Os90CLb5bZ?=
 =?us-ascii?Q?2zWb4jAeTeuOkBthZjV3XA21Ltkvc7DjkWy5D+x8W5rgI1Gz8DIvI+UPEvc3?=
 =?us-ascii?Q?zAbWDzQCOSFFaH8aPzWGP/r0OvP8OeDZC5qC54NATp32JRdhNdOUk5sxtb0Q?=
 =?us-ascii?Q?qWJ8xmHhOb6yxXvyRhMMU4Fowi1dVQi5aTkjCaAohajlBPLlfG8aOInezUpu?=
 =?us-ascii?Q?QIhF7f5x5In2DOrEvAnzqo7zav3QQvuEIwYtJMp/eG/qDzFcvDDP3oU0IYjH?=
 =?us-ascii?Q?tuDXosTZBgUY84uvt43dd0uhkB6akTl5MGChefHg1mOjdpKzKJggNd2Lujdt?=
 =?us-ascii?Q?DpdXQWueeL6l0giKPEJituWSc0dt11BDZkm31ve7RyxUAX7hZQSOYnMjPyR8?=
 =?us-ascii?Q?Yc5SEHxMAQrmjcpmXllhz+fcKUqiTLsKEVU1mTBJN+KjWe7m6axwMSrhkU75?=
 =?us-ascii?Q?O/pfE5RuqmvL42kR+A1o3SdYO/Y5jTWAepHezujg/7EuPGo7ftHALa2MRfM+?=
 =?us-ascii?Q?8jXRDK2t5s9STus6GhWLXGj1rhATESqLtXU9bUBg3JB2E2+TXIaTbKX8NUxz?=
 =?us-ascii?Q?j9inRlAcn9Z2poUOFzBmtaFFWt9ug8QloTfQm06tClBn1dlBaNZgJQhZ6/ro?=
 =?us-ascii?Q?eCrqNli7xg4CwTvrI3zP2pYsqgY7oel6P3eT06NE0kY2gtpx64YP5pSjtinz?=
 =?us-ascii?Q?lw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265c978d-657c-488a-dea8-08db8c501122
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:51.7612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nko/VI+NDrG+zTwtBopIUWbXkZiQWqMgiO/w786p+cMy3strKPuw2Ny1trR8MVwNnEeKJO1vHNHoDw6LN5U3BFtWQuAGkz5urh4i8wn2V/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9690
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TJA1120 and TJA1103 have a set of functional safety hardware tests
executed after every reset, and when the tests are done, the IRQ line is
asserted. For the moment, the purpose of these handlers is to acknowledge
the IRQ and not to check the FUSA tests status.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/nxp-c45-tja11xx.c | 79 ++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/nxp-c45-tja11xx.c b/drivers/net/phy/nxp-c45-tja11xx.c
index 0567a366af37..a826c845ee7d 100644
--- a/drivers/net/phy/nxp-c45-tja11xx.c
+++ b/drivers/net/phy/nxp-c45-tja11xx.c
@@ -29,6 +29,11 @@
 
 #define TJA1120_VEND1_EXT_TS_MODE	0x1012
 
+#define TJA1120_GLOBAL_INFRA_IRQ_ACK	0x2C08
+#define TJA1120_GLOBAL_INFRA_IRQ_EN	0x2C0A
+#define TJA1120_GLOBAL_INFRA_IRQ_STATUS	0x2C0C
+#define TJA1120_DEV_BOOT_DONE		BIT(1)
+
 #define TJA1120_EGRESS_TS_DATA_S	0x9060
 #define TJA1120_EGRESS_TS_END		0x9067
 #define TJA1120_TS_VALID		BIT(0)
@@ -39,6 +44,9 @@
 #define VEND1_PHY_IRQ_STATUS		0x80A2
 #define PHY_IRQ_LINK_EVENT		BIT(1)
 
+#define VEND1_ALWAYS_ACCESSIBLE		0x801F
+#define FUSA_PASS			BIT(4)
+
 #define VEND1_PHY_CONTROL		0x8100
 #define PHY_CONFIG_EN			BIT(14)
 #define PHY_START_OP			BIT(0)
@@ -262,6 +270,8 @@ struct nxp_c45_phy_data {
 			     struct nxp_c45_hwts *hwts);
 	void (*ptp_init)(struct phy_device *phydev);
 	void (*ptp_enable)(struct phy_device *phydev, bool enable);
+	void (*nmi_handler)(struct phy_device *phydev,
+			    irqreturn_t *irq_status);
 };
 
 struct nxp_c45_phy {
@@ -1162,6 +1172,37 @@ static int nxp_c45_config_intr(struct phy_device *phydev)
 					  VEND1_PHY_IRQ_EN, PHY_IRQ_LINK_EVENT);
 }
 
+static int tja1103_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	/* We can't disable the FUSA IRQ for TJA1103, but we can clean it up. */
+	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1, VEND1_ALWAYS_ACCESSIBLE,
+			    FUSA_PASS);
+	if (ret)
+		return ret;
+
+	return nxp_c45_config_intr(phydev);
+}
+
+static int tja1120_config_intr(struct phy_device *phydev)
+{
+	int ret;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED)
+		ret = phy_set_bits_mmd(phydev, MDIO_MMD_VEND1,
+				       TJA1120_GLOBAL_INFRA_IRQ_EN,
+				       TJA1120_DEV_BOOT_DONE);
+	else
+		ret = phy_clear_bits_mmd(phydev, MDIO_MMD_VEND1,
+					 TJA1120_GLOBAL_INFRA_IRQ_EN,
+					 TJA1120_DEV_BOOT_DONE);
+	if (ret)
+		return ret;
+
+	return nxp_c45_config_intr(phydev);
+}
+
 static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 {
 	const struct nxp_c45_phy_data *data = nxp_c45_get_data(phydev);
@@ -1193,6 +1234,8 @@ static irqreturn_t nxp_c45_handle_interrupt(struct phy_device *phydev)
 		ret = IRQ_HANDLED;
 	}
 
+	data->nmi_handler(phydev, &ret);
+
 	return ret;
 }
 
@@ -1599,6 +1642,21 @@ static void tja1103_ptp_enable(struct phy_device *phydev, bool enable)
 				 PORT_PTP_CONTROL_BYPASS);
 }
 
+static void tja1103_nmi_handler(struct phy_device *phydev,
+				irqreturn_t *irq_status)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   VEND1_ALWAYS_ACCESSIBLE);
+	if (ret & FUSA_PASS) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      VEND1_ALWAYS_ACCESSIBLE,
+			      FUSA_PASS);
+		*irq_status = IRQ_HANDLED;
+	}
+}
+
 static const struct nxp_c45_regmap tja1103_regmap = {
 	.vend1_ptp_clk_period	= 0x1104,
 	.vend1_event_msg_filt	= 0x1148,
@@ -1663,6 +1721,7 @@ static const struct nxp_c45_phy_data tja1103_phy_data = {
 	.get_egressts = nxp_c45_get_hwtxts,
 	.ptp_init = tja1103_ptp_init,
 	.ptp_enable = tja1103_ptp_enable,
+	.nmi_handler = tja1103_nmi_handler,
 };
 
 static void tja1120_counters_enable(struct phy_device *phydev)
@@ -1697,6 +1756,21 @@ static void tja1120_ptp_enable(struct phy_device *phydev, bool enable)
 				   PTP_ENABLE);
 }
 
+static void tja1120_nmi_handler(struct phy_device *phydev,
+				irqreturn_t *irq_status)
+{
+	int ret;
+
+	ret = phy_read_mmd(phydev, MDIO_MMD_VEND1,
+			   TJA1120_GLOBAL_INFRA_IRQ_STATUS);
+	if (ret & TJA1120_DEV_BOOT_DONE) {
+		phy_write_mmd(phydev, MDIO_MMD_VEND1,
+			      TJA1120_GLOBAL_INFRA_IRQ_ACK,
+			      TJA1120_DEV_BOOT_DONE);
+		*irq_status = IRQ_HANDLED;
+	}
+}
+
 static const struct nxp_c45_regmap tja1120_regmap = {
 	.vend1_ptp_clk_period	= 0x1020,
 	.vend1_event_msg_filt	= 0x9010,
@@ -1761,6 +1835,7 @@ static const struct nxp_c45_phy_data tja1120_phy_data = {
 	.get_egressts = tja1120_get_hwtxts,
 	.ptp_init = tja1120_ptp_init,
 	.ptp_enable = tja1120_ptp_enable,
+	.nmi_handler = tja1120_nmi_handler,
 };
 
 static struct phy_driver nxp_c45_driver[] = {
@@ -1773,7 +1848,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
-		.config_intr		= nxp_c45_config_intr,
+		.config_intr		= tja1103_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
@@ -1797,7 +1872,7 @@ static struct phy_driver nxp_c45_driver[] = {
 		.soft_reset		= nxp_c45_soft_reset,
 		.config_aneg		= genphy_c45_config_aneg,
 		.config_init		= nxp_c45_config_init,
-		.config_intr		= nxp_c45_config_intr,
+		.config_intr		= tja1120_config_intr,
 		.handle_interrupt	= nxp_c45_handle_interrupt,
 		.read_status		= genphy_c45_read_status,
 		.suspend		= genphy_c45_pma_suspend,
-- 
2.34.1

