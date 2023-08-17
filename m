Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D642177FA4B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352797AbjHQPHW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352808AbjHQPHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:07:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF94192;
        Thu, 17 Aug 2023 08:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EausO78CWhJXke4/uyL/aFrKfJAG0R+1aG4O5z00vUQMnA1skzVbl2TMlFyrxqfFymPdaZwWnZZawma8StTlrs4oP/aWEOLU+qkM8ufVbmxJVKh0pbkk6xcww1uiHMRQ7Dya3W/+M2vGARAAQcmYyVHGkJvHmOppdiQUGcjegO27pb8PTrXY0+aAJhVAanGN8yzbwFHNR1AjIUlEOBJhwxrKOo/auHTD/PPk1phSLufDEljjjrMwLonXsidZpHb8HjxL5IJc9/TPZOXoMpWOfmt3oIMc1RApB+FW+kzCtqo37M64Xx48Pgubc5bygkIZ2uq3B0GTOA3hU4S5rR+QjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DtDnQb3t799BpMV2b8fe2VqVvoQ50dmSVlrU7UEntU=;
 b=a3ibNcMRmXXxCMIQle9kMpBJDT99YI6hVxR1z7rvD0v8q/CLt7OQdbi1jsdKeVq95MJpx3wFvvHyP6zty5u9F0u8vfNTpPoE15Kij5Gf6rMYo/bTGyN+bu7EzJ0cxUdcP4zNcoa6AM5ayo02VDgoEMSz1txi2xyEoOy7NwStUTGZSY10cjB232PlAnX3LLu8zQYj4DF82IBSH02V1VZYdGRbF44oRyIYLRDshwcghV3kl7wyIJtMiST/nmdX0XNq1ZypIFWFP08gxnudRXR53CMBUwbIc9NkEHMadM91xZrNNUXoxKYPipZn6DcDY2DroMnocAMTEbB64fraMqhIxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DtDnQb3t799BpMV2b8fe2VqVvoQ50dmSVlrU7UEntU=;
 b=pDx39EBWs5KAFBBEAI7qiOyB9X632TspLelwMRgWdiiVm+WdYVeOnlIOuRaOc4RTOz3T/Ejll8+4jatsyfFZm0oq1b7j60SBnNVGutlEHP9Ab6w3Nb61kAcsGeHI6ncFWljD9kwFKuvTBrn0wk2VF7Z3dwx2avdxCrJ/EM37IFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9469.eurprd04.prod.outlook.com (2603:10a6:102:2b4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 15:06:59 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 15:06:59 +0000
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
Subject: [RFC PATCH net-next 2/8] phy: introduce the PHY_MODE_ETHERNET_PHY mode for phy_set_mode_ext()
Date:   Thu, 17 Aug 2023 18:06:38 +0300
Message-Id: <20230817150644.3605105-3-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
References: <20230817150644.3605105-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0137.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::34) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9469:EE_
X-MS-Office365-Filtering-Correlation-Id: 6308542f-9714-43d0-8d9d-08db9f339aa5
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CMnFZY7dLYkR2qLU1rQWVMl4HBbIIJx+j/8zTXzS0M460yXtcLMRb0Eqzwu/2IlXirOeqUVionfH63UpthejHUn9h01CjbwpfJzTEWTysOzB9UW0RgNMc1eVD9ivCLxcujG19OS24ibyDwpamKGdEE+DMq5mgF0YeFvWVl1xXcTEQLOCvFouQ1wjzBVzmtNnjBtga+kYLw0wGVk/glICjaeNaF9Tlbr1yRm81AOcpyhHJNluFnqPwZh5K5HCqeCFPotWQzms56mF6CIp7IkUSXbzbrQgjHBMvV0xR67mTMnitsjjw6sG7rFR3o+uczC92O8rmoI1wXAwezfw7xaLvInGlr/RGoN7UTJtln4wwT+um3+MVnTpIsEBLKcidH3UAISM5ldB/3mLKY2BcD/LaD+nTHDIkq+BUi60xSTK5LyPCw6QqYv+7Dztd8K7iFnzEMzk/ep9vxgh3GTB9WY6bbrYtMsi2nrwDOEaH4BaayOB2WcZLALhtzLjKVrtekT4gmDOIpSFFOi67mNyGF5hdwdoVA3KOtyRtKrdEyZLuqUECUbCxCy4+UAM2o4IA9jef96Iqs/TRjLp9strlCidVdsPOfzDA/LUKMpU4B2oBwmJ41WUZprcyEOZwV5ztgCH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(346002)(39860400002)(396003)(186009)(451199024)(1800799009)(2906002)(83380400001)(26005)(86362001)(7416002)(478600001)(6506007)(36756003)(6666004)(2616005)(1076003)(6486002)(6512007)(52116002)(44832011)(5660300002)(41300700001)(316002)(54906003)(66946007)(66476007)(66556008)(4326008)(8676002)(8936002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CxmRyHz48aEQpFLLWw/qc4AOk9++fTBgxl40zFDmD25sbKbUGPXYmsA9PsRB?=
 =?us-ascii?Q?+wKbcuSNbe+UnSfBJOZAEwVaVKOgth9X4ws8uTDUruSBCfc7WWxQZCdxAGdn?=
 =?us-ascii?Q?2eSk2jcsR7mDm5IJLVL7xK9wQvKpgUx/IQxe+re/vkhceSJFRPDHrI+VhNnD?=
 =?us-ascii?Q?55oNIPJ/RCVxnSWg4OzdMOX3vwZAaDRtr8F6RdAS4p4dAM8NwwTdTdiJGDdV?=
 =?us-ascii?Q?WjgnCkuufiFOKd3A75JwdtL41RNHWmWxY0xOMRcRgJqrBF957KoPV3r5rvw9?=
 =?us-ascii?Q?qEd4b+D6J8Vgu4Zod4iQ66Ku7Dj9FTr2OBxPfAKuWvrCa8fvKJ+RzASHW0H8?=
 =?us-ascii?Q?IExnBF835FuEhcepW/RtV22BNdl6phNVvObQmB+BhC1J87+RChdWUGXnzy3w?=
 =?us-ascii?Q?k5eQkzuKEuygWNj+swtUe/weDs+aDJt4UjHVCk7Oein8c/VlmjJRblcYV5H4?=
 =?us-ascii?Q?wGbP1/jyp/W3MXOBFafgk5lXAXZV/fO3XhRVECRFAnBhQ6Y05oMYT5L6SiBv?=
 =?us-ascii?Q?JrqKogTatDdNvqoEYTS7XZyM/JKCewPkQSZAiaz8G1yI7/NurVg/EoQ+TsCD?=
 =?us-ascii?Q?5czl46W5K37yj8pqWk1Ldy4klgtx+edD9ESvia1BMSHy9w+ggHF9JpP1vAf5?=
 =?us-ascii?Q?aIw7K9UZP4yAUAaev6KePwQo6Cxnb7JRKIWr/q03omHtwKhC6bVV2iNYmc6b?=
 =?us-ascii?Q?g3jXVJtlJR0CwTDCGHZmldXsXRF1tXKLqYYbJSq85d83yh21uWOOrnZcguuD?=
 =?us-ascii?Q?iPqKMm/48Ol5BL+dDg+MDgiSFCPiAYCcWkz5ehAC9B0Ux0VMzlJ33QfozDbR?=
 =?us-ascii?Q?QzEldwnuzNCZGvklp2B5pgUIzqtKB7qOBb7pbiTHniuUvQn0WMqSsXIRcimY?=
 =?us-ascii?Q?QEeWTOjm1gVjosdRwc/AR91hnSokh4yZVD8no5Q+pPP5TXmMDWcgKvtvt/P0?=
 =?us-ascii?Q?Z9trYWeO8OktbF3P+fbaVF93xli/OFeSsqA8U+0N3+EDQwkfch4TJe1zgAwA?=
 =?us-ascii?Q?vyvwBRac3y/W1Y0gikEKfFn6L1kPnC5Sz0nrh9JyXpMbOmFZmy+Ko1lB77eV?=
 =?us-ascii?Q?P6gqVNtBEx4o+o7dszt7YCuqsi7FooCRCv+YJESHjnL6EDvrBwAhJCHdDTKQ?=
 =?us-ascii?Q?DB2VY/jPDbwCIuu6o5oX4nmCeQKtupIQE+d0a44XQ/syqKv7LpUrathheYTC?=
 =?us-ascii?Q?W7zeZzEOKHO12ysUjOP+xjuIRKW4RWqfOgiz6lW2DNjrDJPM5EHr8dlsCSR4?=
 =?us-ascii?Q?xkGXzhHoMxXgH/5s0QzgslzPV5gBApKdenSD1cH8fJAvukAjznusrucC2Vft?=
 =?us-ascii?Q?LtJxOtDqtJEJ6mu07xzrOl0Dpt3K8irYoYBSs8F6tzcKESypl14qRF/+K2N/?=
 =?us-ascii?Q?UW6qNqdfH7+2cbX/KWfAck7oG7+TjvH/PydzrffGyf8zgqhD5R7vPHuOUROo?=
 =?us-ascii?Q?HpJulvbV6T9PCVUGMgSxgc7vbLICy7vLsFdgne1ODE8rT4mWFieEfmikLWXn?=
 =?us-ascii?Q?Jx2VeLI35b9RDD8T84erCAORJmyxxunurUoAECDvirzNYDSL9elT0yDq/Old?=
 =?us-ascii?Q?ME9Qz5atpcMaaY5onXSsx3XJevj5iGb0eB6qfDJhxb9LDRYs7WA98olEGCg8?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6308542f-9714-43d0-8d9d-08db9f339aa5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 15:06:59.1643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iq3RO5yRogk6C/K9C6CdovgTJPttt2ebCYNP0P7vmqwGuEXyIDm7UCZwwo6FwPbWDXyrWx9zBNjxpNYOAZIVbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9469
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As opposed to PHY_MODE_ETHERNET which takes a phy_interface_t as is
expected to be used by an Ethernet MAC driver, PHY_MODE_ETHERNET takes
an enum ethtool_link_mode_bit_indices and expects to be used by an
Ethernet PHY driver.

It is true that the phy_interface_t type also contains definitions for
PHY_INTERFACE_MODE_10GKR and PHY_INTERFACE_MODE_1000BASEKX, but those
were deemed to be mistakes, and shouldn't be used going forward, when
10GBase-KR and 1GBase-KX are really link modes. Thus, I believe that the
distinction is necessary, rather than hacking more improper PHY modes.

In particular to the Lynx SerDes, it can be used (as the PMA/PMD layer)
in conjunction with a separate backplane AN/LT block to form a
full-fledged copper backplane Ethernet PHY. The configuration of the
lanes is relatively similar to what is done for a typical MAC-to-PHY
link, except that we allow tuning the electrical equalization parameters
of the link (support for which will come as a separate change).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 include/linux/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/phy/phy.h b/include/linux/phy/phy.h
index 456d21c67e4f..7e10761303fc 100644
--- a/include/linux/phy/phy.h
+++ b/include/linux/phy/phy.h
@@ -39,6 +39,7 @@ enum phy_mode {
 	PHY_MODE_UFS_HS_B,
 	PHY_MODE_PCIE,
 	PHY_MODE_ETHERNET,
+	PHY_MODE_ETHERNET_PHY,
 	PHY_MODE_MIPI_DPHY,
 	PHY_MODE_SATA,
 	PHY_MODE_LVDS,
-- 
2.34.1

