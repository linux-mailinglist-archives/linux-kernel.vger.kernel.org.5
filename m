Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07AA7CD6C2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbjJRIkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjJRIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:40:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C545DC6;
        Wed, 18 Oct 2023 01:39:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDEXPSJrtJA8HfVJcSYurSVHR3EUUw1mOsBnmXeytCyc0Y2Cc4LxbLnr6kXCXIG29GhfxhWiDGK6k2nCYpXtogHFs9EykkRko6mfVqWTdMan+QdrO+J1ISw8oI+YvUR7clRwtyGGbYlqclpelLg3PWfwb7kHJVsMr0smkTjRPiGP4DAli/qGOfhF32rCEQNlQibexvPOykZ1YFucDshkzKXfB4JHwM8dCDTSC1k16UO8rzjZda7Nq7YwuTdndOL5t+5X2e8s+t8+bNbbQDrnxogvf0NREluMix5FLo8YO91RU16FVh2LVYWozoLiA7ktYTUVPimJJug3GA5MPpaoFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqzE34moofRzhgnJ4poWl28P6MiWOYAu3SBkqzCabq0=;
 b=IRW7LXEyKLb/YuD5gLqxUWGJBkqy0Gk7XEeghbStC3CG8caiynRBTKRTNJ3sVXkyuwINjK7mPuYgPZlD1+chR61NGYN5NYPy/ZiSE9afxITzSQlROwc9btauN549hB7QiGyuY/YlFmvCIm6r0j5cHDA6b2KM/bcSIIYy8ihlRBKVHqc8ZfpnLE2mU91Qq+VAuEJWIMSBrhQujOwTxyVM/C3vSTB+qdFsMsosaJrnu27freGq9mGhUJaI2HMgTSeQ02C420pTnKIsnfDiSJzzKdpl8Y/ESdAApL/5VOvIfZ9+h9zSjwB4v07EBtPYF4aJMp/ELHDzGJ5/pG1Jh3XPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqzE34moofRzhgnJ4poWl28P6MiWOYAu3SBkqzCabq0=;
 b=YN+GMpXqOka9tXqueSQAIL6XqgF5T6g+OkytJJfIZ42cvi6HeYsBGB8RsEeJApMhswOM0gHQIU8MB5q0iq1uOwGUjy/rmUcCXo97Q0epTRzUkAYhQkAvKRRF+xGNiTd373taC9FtO/Dc7QtTCyvcRR1QWyi1ZO8QLFqMfV7TL7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 08:39:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::b9ee:e067:5935:4965%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 08:39:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, estevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        inux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] arm64: dts: imx93: update anatop node
Date:   Wed, 18 Oct 2023 16:44:14 +0800
Message-Id: <20231018084414.1950241-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231018084414.1950241-1-peng.fan@oss.nxp.com>
References: <20231018084414.1950241-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: d84784d8-7778-46f1-3ba4-08dbcfb5cde7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: asNDxqdJQBNmscVzxQk7nCQoBSMNlBMKbkMIlvCl1GYVItnvmz5TDxH7yt36fBRh0McVzv0wsgG6zQTGXw4dSIWxacdJBA8LhZO/cJb1CcMu4FndgPEuuj2C0fOQlmMdsf5AxSFzOGQj2RQYJOmzU1R9Knqen0mmHw68Sig7s4xmyUKxibkhBZVJObofCV5QRN9tNOFKMrbqRPWvRkU4k8ko8a4NP5RNtWOuZ0v7RQmezaEieA2ORmdiZrNN7z1k6pK8o85ct9GDdTBZ1iUuVsC4kQeQOnGOme8MuwJ7fweysXXPXAb/R5GFlNMN2W3yhrmpipso05cGML84hD273Lx/YG0a6yLXANGdrYY5iAJ+bSIe1qzdTyu150B0UBxOOCyrVo5dxkMxty7l5nvXjU5xqndKUXToU6g+LrpvvNleL+HBYlxu/ErJzWm9V4CEcRExZj6+fWzSrxpftPui3BkT+FB956wwzGTblg2cW8x8h95ZANzm7d9myi3aRIeiWGfbusOMrvP8LnOIQHzjAhFWLxX32boZK8jMGF0ShjMKdJTtuXXuCl7xO9B33vU0EeF67d07XHcDfZQxyxSdCQeIVDyB9OjJ/6IM+aPLR4/IJ7HWireFvJXHBKPVyOnp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(7416002)(15650500001)(4744005)(2906002)(86362001)(4326008)(66946007)(8676002)(41300700001)(8936002)(316002)(66476007)(5660300002)(66556008)(1076003)(2616005)(26005)(83380400001)(52116002)(6512007)(38100700002)(6506007)(6666004)(38350700005)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qp67Noy1U2+bsUPMs2GtE+t8qkDtfTSIz3zEwNkPC0UzvDv7VjgiY7ydV6b+?=
 =?us-ascii?Q?vW9iaMVadJPJPMVBw7TpLyRJ6Srxt++lBUWTV/2yWXlGDQMJOm/zTgp1PXFU?=
 =?us-ascii?Q?6sLYq+u2wES52KPPuIR6YgC321/UHsL7fp0GKlSkoYW1F0MAfncm8R0pxFb/?=
 =?us-ascii?Q?ZYGbl4wrc1t5/F3CHUjAS746rxMQ3xFAkC7tWtWfP8+8jYBKLxzWwk9hVpv4?=
 =?us-ascii?Q?8Jq01gBbSA1iLds3pbzM18YJc0jHnPZTnnnp7xAeuy6vvQrjW5W2KnpQFN02?=
 =?us-ascii?Q?ity3HVYQiZB3vtCzLkVpqyapolV+IvR3Q6xkuAurBqRetr++g4Hc9bTeHJ78?=
 =?us-ascii?Q?pi7Ai0Ddkz3PEduMUcHhkL5Y+J02luvFh6m+0jGcSB8xeoubmXmh0aQXIAur?=
 =?us-ascii?Q?Wd86N7sLtqgYKQdjTideJ8aKmZLnkQxD9H7bRX1QFF6xa0gR89axeCUSnLfw?=
 =?us-ascii?Q?J4GLE10gcxBQQGZ2DKWHZs0VPzrj7/uWfJIEjZpWyq+dYnYKZzQ9p8SFUhxx?=
 =?us-ascii?Q?EDtAp7BmCD7RD8COzP/EiHFhUYd//nmpS1GM/EOF9VqA9MFLU0RaJTbjCFco?=
 =?us-ascii?Q?STXPzMd2V4hl4EeCotloAtQC1UbaAIdzqHogIZ+TV86sSY6OzT+gBE9T2p0x?=
 =?us-ascii?Q?UvZs06sNsIcD6C3hTq+9AfCoy52zcScwLGu3DF+PwbzEMeJImpKlkcfLJmE8?=
 =?us-ascii?Q?ZEAdIZUSEMAnrridvVDeZsxiGwBaPhg4D7G12hZoYoFn7JWloznnR22IFAAb?=
 =?us-ascii?Q?Ss39433Y/59N//sOYPvYYNePsDiEFEkh1ahhcxesDnsE3VGD4XzCUNVMSXpl?=
 =?us-ascii?Q?kQ1aS+FvT02okMvauLF49phIBaPmVwrxVO1Fih4h1aHrdAWTNOAdxC/a4an8?=
 =?us-ascii?Q?eObAOKJWP0cq8DamNgdLXXn5IvPAGNzaOOQI+e7Vqpb+LwM/MqMzO2ILFT8/?=
 =?us-ascii?Q?DBwUgqN4A02keuDDn5Zi1elTqL9gAxhtKFa+XJ7QdJ++VRMCDlLPE3ZDcY50?=
 =?us-ascii?Q?Atg4CanWDiA+8kHtQTH7Lj0PYCqdAM5vWL8rPkH1oTpCxgRgPu9haUQMj+Sq?=
 =?us-ascii?Q?TlDc59/1bJBp2wpa/ICz/Mm6nSrImFhbg924SGNVYwfzwN3ROtdTgk9bZfKq?=
 =?us-ascii?Q?fYiYx3Ya3qRUkPPOUbaeNsbgEOFs8gAbm3n/O6Nd8n4l6ImOZHieizM3nAGS?=
 =?us-ascii?Q?RCuTNFfvYU0+pEQTH0eKYYCvdaBwZ1aNDn2q3A4LN4249ASo72j6t8Xvk7jQ?=
 =?us-ascii?Q?XWXNEB2OvJhZfw+H2D0+6gPIVn6Jzf4UoGLaZoChl9aODbkKOjUdO7K4yQFD?=
 =?us-ascii?Q?Mi0SoRPN9pLzpySdYxPmystec4nJ/uW/sKC5XNP5Jy3P5i/PT9DhQhg/LO1r?=
 =?us-ascii?Q?W/2gmpNQGAHDYJms+Mm+qD1rr9ONx7yySS/H1/e/bxs6PGhAo9SXAc4doxEo?=
 =?us-ascii?Q?dRE1FNxS65PRXTOvybX5sjaEFpZRoWx5yY0VCUt2QxOexYkB6Qbf2dGb6aA0?=
 =?us-ascii?Q?HI5lyUxB7TpvxgA19t1WURLVZ8h88XxoAOJrwf4YI+N7EusDy2Ri9/Gbz0X9?=
 =?us-ascii?Q?c65zdpKUtNXH2w25hBYMeenRnDQqHM6BQxMkUNeg?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84784d8-7778-46f1-3ba4-08dbcfb5cde7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 08:39:55.8356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2P0sW+IUuXgV2zFXxx/wo5eOAK4xVwkE7gSWaQ+yOuZwQQSgGbCpmx305wXdaE7lulItQ4ZLAmzMca7XmqRTzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The anatop module actually generates PLL to CCM. Since the
binding doc has been updated to clock-controller for this module,
Let's also update the device tree node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index ceccf4766440..4e7a51ae743d 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -422,9 +422,10 @@ mediamix: power-domain@44462400 {
 				};
 			};
 
-			anatop: anatop@44480000 {
-				compatible = "fsl,imx93-anatop", "syscon";
+			anatop: clock-controller@44480000 {
+				compatible = "fsl,imx93-anatop";
 				reg = <0x44480000 0x2000>;
+				#clock-cells = <1>;
 			};
 
 			tmu: tmu@44482000 {
-- 
2.37.1

