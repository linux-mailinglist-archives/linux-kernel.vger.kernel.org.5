Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517827AC267
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjIWNtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjIWNth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:37 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9C81A7;
        Sat, 23 Sep 2023 06:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFKgXbVoJj4EaJYLNAmWJJa9qp9f9tHKGggXdk8P6FYsYvC12FMAhgiETHFtQzpQb7iGvfplzXyXxrlWquNJXVvKBwDlC8E0MHVl0JtUZuD1lip+6FdJDiCdRE/2pCbsHRSuHCu7XnFVVHCh8YKsb4dEGjbXG3X4HaURIETVF86SnXyImvwL80mqsoYJZs+mZArJCx7bjEVG/qrNHDo073VQHQc821rmnezYqKpLvyGNWBGyBRSJB0chAdax6jbSMgCta/OddZMN5D1re/YorXsoMgzJtb5+Ip0HI+18+CFCQrGvLe3h30jLU3ObBhU7C6sx0v/4eVoRdU3+U3a1+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qigG5kUcxAwEk9WKAMwLV1yzRRj89M0MJtvmmZxb0iM=;
 b=U4v5VFT8f3/gsfXdabLEq1WLm+azxfl92H8f+/YbVVWmqG1pP7sS1fylW5v6sq2mpbWDqfQkZbhad8Llx6Pfh2EiuRn/z5RJZwdoCTjCNSzgqmAGF2RFs++AHFtiwGxXovJoF7aShEGaLoKlYn5CuFcFj/L+StSsuVxamcKCzFMK2R1IOTLo3MF2I/aFTs2m5RHzLTf0R0rU5Ua1Tcl/JsvLb0HynRkuTjqdIX2xrc95gEg3L/IxrSboB0h4G26ZZ1j82OdNnyvr0wHqnHN8BHR0urNRDj4bhWGXDZq3IsK4kODSEm65PTIHWYkD0Obh4VyoT9tan6G2Xcp8PZXlDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qigG5kUcxAwEk9WKAMwLV1yzRRj89M0MJtvmmZxb0iM=;
 b=r4sN/v6UzCTCH+TTzJvQjk2A7uM5dockNIcyuG81N8Srq7eRs4RocDVJZLMtNeXE4HfZAz6iCIRmXDSeEI58YeU5+zn9PhwyzxmBPlv1UOKAz3Ve4v0uNNtSIhCwWvP6N1W3CJhJNpQAXHiHUQ51dw1dTvxfCn5kvduvLNK3V+U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8396.eurprd04.prod.outlook.com (2603:10a6:10:24a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.25; Sat, 23 Sep
 2023 13:49:24 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:24 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [RFC PATCH v2 net-next 02/15] phy: introduce the PHY_MODE_ETHTOOL mode for phy_set_mode_ext()
Date:   Sat, 23 Sep 2023 16:48:51 +0300
Message-Id: <20230923134904.3627402-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8396:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ebe1571-e53a-45ba-34d9-08dbbc3be58f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8cdED9KtdwcPd7PrbdlBc5/lotElwqi8F9SVvwa1vcjOGjw2UVOz3iOEWPNXD4mR9/vDvdz8EKv5NyiqJPvLTc+2Tug+uBced7rxGRGci8p2/WjrCD6+gx7z+W1VFubgSS8wWgZQaNTQYbvU2ZirKLy+HxM40F1Ob0NtbS1jD1YV6OSGBF+ORhbhtBvbS4srJosqZSKbctcwKg8z7pl8j3VFn2rWblonedaPGgzs3wskG5W5wIUkyHGz1Bdzvxxhqi13otm7RNpSj/M3367ChGY4/QXKyhfaMHCtyQJ/KwhX+TuPWNgAS/UcdjBCrm/qG8uoKAj+60c2I+xl/kNEfDlC2VKb2b2NOHkskMNUlrX9nUm0va1zpbVHLVe352seNp0TAyb5lP1DN0K/iYyyBgwdo1M8Fo20axUWxhuJHwR8rD8BAZFZr4/QV3+QJadrlytGX9KYVnyYowe807s2bTzSYQCAs7htAydqZ4uPmKb4Zqn40IXIYJ2o9rPOhvNIOmGTjiOQEHOdoaKNmjwFCuXKUT698tHLWu3QcnZxmLSB1Cpi2fsjx2yKcKTmieA03F3fnqktEyIM5fxfxMcVrEN7fC+Hes2mZ/oBhDzSlXFYs48oHRhorcrc4Tt0ZCu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(186009)(1800799009)(451199024)(6512007)(52116002)(6506007)(6486002)(6666004)(83380400001)(86362001)(38350700002)(38100700002)(36756003)(1076003)(2616005)(26005)(2906002)(19627235002)(41300700001)(316002)(7416002)(44832011)(54906003)(66946007)(66476007)(66556008)(478600001)(8936002)(4326008)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R/IE8Kxf2kbD5sK49xlUaeFrEwp4sO7iBwdBoO4NBc2nXvWN7jHMNvm3hSDZ?=
 =?us-ascii?Q?2Pdp3Lo4ycAGJMMso37omyrmR/CzqnKmhrM6SsIHtGahQv/ROCcGtSo+eNg0?=
 =?us-ascii?Q?HbSYlA4Q7ozlaNE889PXv0jdRTee2/PwtOYP+FrUMR6IXdhENxwRPAVirCLE?=
 =?us-ascii?Q?I2hosw56dFPM5LXj6SRMTlq29ThJylvv1bC3DvAFhzrWt8TiCvrsH6Tjf68E?=
 =?us-ascii?Q?Q4s2ZpxgLzEs0gtPsXS3H22aBzMvnoJRRH8PoKYa1SBjCkr2/JjQhzySvrDZ?=
 =?us-ascii?Q?C+N3CJhqWSULa7/NHdTpxFMwfNIyQn6BM70p3IHx6egxAjY1c+qi9iD1HTNq?=
 =?us-ascii?Q?FxnQFjqOqQY7IN+QTktk9wFn1X3F+QZfW9eA0UBDZLGFewXkoFT1M4VyviTl?=
 =?us-ascii?Q?5xJFJfIT2s7DiK/B2sHezwlRlhA3j/q74tcAhKNz5MN3xo+f2mx2Q2Lp7fUJ?=
 =?us-ascii?Q?CSLxG/lJ4zAk2KlYOfIx/hdAODVbyPatlzLhuj5s8GgTBlwr4s03afXYFYKS?=
 =?us-ascii?Q?EqH6RSXcJZkPIelFXGQrV+RYgWc+2jXTTcS+lRGrvt7mG/f3VOjkHZHo7ns9?=
 =?us-ascii?Q?yFSPhuVYrFg4vywOIwiSCuhnnCgYHvVLdgwlTnSXw+VLlhcGBohdX32cgs4c?=
 =?us-ascii?Q?MRNvwDYrG8bWtsTCxVMYB1R0Z2c5AqpIcCalBFidu4XChVcQ9efLmLYvxwC2?=
 =?us-ascii?Q?kedgDfn8YO9mJd2XlZV1Nemgcj3pMCD5JtnpnDOFq053xCfX+/LM0nmsbqon?=
 =?us-ascii?Q?fJro9mI/0ggWcPYIwpQtksOKkoKCfgQHJUQp9JVqUXaed7J60KOzdLPP0nAa?=
 =?us-ascii?Q?6H5OywEdH8ZqB4NS1zgtJnInXCRIHwPO1yJV7gJnXSzL8Yu8i1BReFsIxdf5?=
 =?us-ascii?Q?ITny99J6PqtxJPnVpSATQ+vykCwnmDJ6j9skrXCW8nC85tElAaTirFd6CMqF?=
 =?us-ascii?Q?U676Je4QsI5OBvGTrvDX47ynMfFW1R9ZiElzW1LnudTTGdJp/IxnG/r9/0mf?=
 =?us-ascii?Q?QOu4D/1k1GTLdVA6FRwfV2bD06Thk1+XWhOoyleJFR6lZmUjz28YL2Eqxp55?=
 =?us-ascii?Q?33Oe2oRydssVd7M3lwOLVihvJKOYiXzjPkmdZwzLH66NI3X4hd1sf+95Ktcg?=
 =?us-ascii?Q?4yNdN9KDFJmUD7DPPRv68hlJZ7SW6RGPDLD3fnnMYNGJ8Hv15YIRFq9+84Rw?=
 =?us-ascii?Q?pZ4nmqRpOOToiS2+5beFzQcSC/pyIAlgOQnQoiBj8k4mGrq6tBFpGEFgCEuN?=
 =?us-ascii?Q?ZHNVv8Ogs1LuLoMVxDTGESW17/Vo2dW3A233VLYgz/689l7ImtWKmyNvZmDo?=
 =?us-ascii?Q?WCJMuA6Fu3Ovtx1o/h/+VpxswSZMknplqnEX3WIMyq8vieWWAdzG/2YKInKS?=
 =?us-ascii?Q?Jx634tRC/E3QDKJw8WBdcQ/hq2oeinwIYEydvB2627VJdstXhMa1J+0h/T1O?=
 =?us-ascii?Q?wyENs06TczXvqLBXfzCV8perjm/go2KOLvtuQ76Jr0YdszwGvJhH76jlM78s?=
 =?us-ascii?Q?Z2YXSuT2ZnuZPlTbfceV7XUYgfSWFrviC1atu9VIY4hafybfgC9P4FJND7zt?=
 =?us-ascii?Q?hwCuxgtM9BHeX81GU4lNNcvi546GXCFoaKzG9G1C8ao2p6K6qjtOP/30yNww?=
 =?us-ascii?Q?Ag=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ebe1571-e53a-45ba-34d9-08dbbc3be58f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:24.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WN0zbgKSr7IbtrN+B24lY/U491xxOPXwrPEqQUNFdnHgRDYkvpTyHqKnjrUUOkN9AkUAn/neHovZ9Xen8ghhxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8396
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In networking, we have 2 distinct data types:

- phy_interface_t describes the link between a MAC (or MAC-side PCS) and
  an attached PHY or SFP cage

- enum ethtool_link_mode_bit_indices describes the link between a local
  PHY and a remote PHY (for example, gigabit RJ45 twisted copper pairs)

Currently, phy_set_mode_ext(PHY_MODE_ETHERNET) takes arguments of the
phy_interface_t type, and there is no way to pass an argument of the
enum ethtool_link_mode_bit_indices type. The new PHY_MODE_ETHTOOL
intends to address that.

It is true that there is currently some overlap between these data
types, namely:

 phy_interface_t                enum ethtool_link_mode_bit_indices
 -----------------------------------------------------------------
 PHY_INTERFACE_MODE_10GKR       ETHTOOL_LINK_MODE_10000baseKR_Full_BIT
 PHY_INTERFACE_MODE_1000BASEKX  ETHTOOL_LINK_MODE_1000baseKX_Full_BIT

but those overlaps were deemed to be mistakes, and PHY-to-PHY link modes
should only be added to ethtool_link_mode_bit_indices going forward.
Thus, I believe that the distinction is necessary, rather than hacking
more improper PHY modes. Some of the PHY-to-PHY link modes which may be
added in the future (to ethtool_link_mode_bit_indices and not to
phy_interface_t) are:

	ETHTOOL_LINK_MODE_100000baseKP4_Full_BIT
	ETHTOOL_LINK_MODE_100000baseCR10_Full_BIT
	ETHTOOL_LINK_MODE_25000baseKR_S_Full_BIT
	ETHTOOL_LINK_MODE_25000baseCR_S_Full_BIT

One user of PHY_MODE_ETHTOOL will be the MTIP backplane AN/LT + Lynx
SerDes PHY combo, where the backplane autoneg protocol (IEEE 802.3
clause 73) selects the operating PHY-to-PHY link mode.

There are electrical differences between the PHY-to-PHY backplane link
modes (like ETHTOOL_LINK_MODE_10000baseKR_Full_BIT) and their
non-backplane counterparts (like PHY_INTERFACE_MODE_10GBASER), namely
the number of TX signal equalization taps and their configurability.
This further justifies distinguishing between them in the generic PHY
API.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: rename PHY_MODE_ETHERNET_PHY to PHY_MODE_ETHTOOL at Russell's
suggestion

 include/linux/phy/phy.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 6be348f1fa0e..72ef4afcda81 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -39,6 +39,7 @@ enum phy_mode {
 	PHY_MODE_UFS_HS_B,
 	PHY_MODE_PCIE,
 	PHY_MODE_ETHERNET,
+	PHY_MODE_ETHTOOL,
 	PHY_MODE_MIPI_DPHY,
 	PHY_MODE_SATA,
 	PHY_MODE_LVDS,
@@ -52,7 +53,7 @@ enum phy_media {
 };
 
 enum phy_status_type {
-	/* Valid for PHY_MODE_ETHERNET */
+	/* Valid for PHY_MODE_ETHERNET and PHY_MODE_ETHTOOL */
 	PHY_STATUS_CDR_LOCK,
 };
 
-- 
2.34.1

