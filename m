Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8A9784650
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237413AbjHVPya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237412AbjHVPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:54:28 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2072.outbound.protection.outlook.com [40.107.21.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04C1CE8;
        Tue, 22 Aug 2023 08:54:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2bb19VVTbAtj4UHZ92832355GDhqQHrs/OaphZQ3MgpH2FbVR5MfDdyA40oxbUHlyTbsySo6kAsZejqa+NRrh+hagUUZF0nEa63Zp/oIGazA/dqFn6/6EZVZqCQaxJBqYNnf2+2ShrbdoGG9PGiPlbrNPJSKc86RMMS0el+5wigo6ICoslXaiq8USAVlXthd82gIhJQ+Fu6ZnbnPdeEqYn3KlqS0dt5IPEe+6M+MTH1wB3r3HAgXWP6/OKp3Y9FzfnIq+RnSjacF94vIpn3TpO1hj5pZ0/nrFXLWG4SCQ/EfrDvQy7/8U01ZiUPr/vk/g9s0aXJj/lWYuFT/TuoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoKq+GPP/B46ElivoTCQgGKrrF9scCau2s4rVbKPQMo=;
 b=alChsArpDKU78lQjLN+w2biXN3N3BtQlHJRknC3GE85soAn7mtyafk0gwtUH6Jg8CXKzHbSd9LKnWOrnDFTUQi8Bfmd/4nmiX/kWqJN0PkO7tjpb4iMg363ag3dkEwmuhnt1MNqx4yaL65d3T5D1iJqbOxNrOokylcmjeyxnDB106cSY/bAcZDRIpBQTh4JHmlHI0G2/faRAQgndyrMMCy1uMtI3dTHTWXOVxcsXLTyEJha0plna+u0/bG/i9mrWNIvVA+08wnp91mVcUcS+CpOKDrMk09KpLo0g6ObRcQPb43ABdISjzvGhgnbz5qTZoLh/VViMYOD4twXtEa3wrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoKq+GPP/B46ElivoTCQgGKrrF9scCau2s4rVbKPQMo=;
 b=gDJRM9sOTHWzpZL3TNFgRpmzpxspGxnhVuYke/cqz7xjpDBGqsVntr+Le3VZJV6OVIffjgRPJMjxC/zXqwSOJoLRGBxzRJpbe/a51xicF8DokrllozRlctPfiB+aoxekTElEBscIPWs29nPpucyWPoystzmo7XxGQUUZeF77XxE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 15:54:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::a680:2943:82d1:6aa8%3]) with mapi id 15.20.6699.022; Tue, 22 Aug 2023
 15:54:13 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     frank.li@nxp.com, shawnguo@kernel.org, joy.zou@nxp.com,
        shenwei.wang@nxp.com, sherry.sun@nxp.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, festevam@gmail.com, imx@lists.linux.dev,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de
Subject: [PATCH 4/5] arm64: dts: imx8: update lpuart[0..3] irq number
Date:   Tue, 22 Aug 2023 11:53:32 -0400
Message-Id: <20230822155333.2261262-5-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230822155333.2261262-1-Frank.Li@nxp.com>
References: <20230822155333.2261262-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0231.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::26) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: e9fb2f48-c3f2-4b57-439d-08dba3280803
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MDgarPlgMMw9btIgDaCFbkIQy3ApnGCNBUYeNNjJYRB7IFzlnv/U2qQFDxYXPXDPag9P2/t4GsOBMEmPpPg7zTmHeP8F3vBwDfhdDhIykm8cOVoNuYx+sPTx6+i+aYlnw9868JlEtXj5Mi+usj8p3L36/dfFImNnKE0nIZGSWzJUwY/KR68riIJ8cwZgE6X5ew3AtDBvrZg2hniP12sCWBdU5sN5cKDeLoe+eWsigyRK1zzAJN7PqSD88/mmF4hF5aPCoD94L3QNG6s4fen7Qx0wAAKO3w/ZZRaiCYB3LvrDoZAJ5MxZPW96dyFaYS9EZrppIf+KBHnkTPU0inmZFSPohG9iuKjZDtPMqRQ/199daN1Ng8+yjpRYZK7Cq7WnCTtrG6UBjM+5iIl2oZv5bGhAG839IGW/RN76wmN9dn1TFedw13sw04vnVwDfo4mH+jfBPJLaOK6HKWExTvCZsCC4s0VHmrMQVdRGb4QKHkDFQ6yO/QvOw/PODS4G4NkdQwWjKuXxM1vIfqs4PykH/2+ACPIIMZKFzQd0HbcdlUe58PPd5UxlibwRJinncUCSRMJr3CWIppSnymDPDSD6ONgfCmr31uId5kpGjrFkrgLzEU0QZYoip/DhV+CvASEc9ODbWVp7ssAEuCAuDFvnBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(7416002)(38350700002)(52116002)(6486002)(38100700002)(6506007)(15650500001)(83380400001)(5660300002)(86362001)(26005)(8936002)(2616005)(4326008)(66946007)(316002)(66476007)(66556008)(6512007)(6636002)(478600001)(8676002)(6666004)(41300700001)(36756003)(1076003)(101420200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wmzuRMIG2oJRHlhBDVRJyfPN0YbCxDx6Tq0k6n8a/hJx9hFTMYxA0S/VFdIE?=
 =?us-ascii?Q?c6ZQ/4zkCqM4xA1/NU0XlAAHeVBolVYSlzjeAffWYoSONSsxkgO+J0Bv6UPT?=
 =?us-ascii?Q?VNudcLCJX1kT1XGONW3vUseeBClYokyuXWutB/8+uuUtrfbSS0Y8n/jC2+14?=
 =?us-ascii?Q?P7oGkUVg0YXV4wPO5tU8ZExW90Vh53+m3KYxftAU7atKeeoS4liELREiL9K+?=
 =?us-ascii?Q?hLRbrHsDaH9XO0JcC+X5JfHEPe1/bn9SBXhk8TnF42leTKG+bDjUNrlwZ1rU?=
 =?us-ascii?Q?3GMZIlnP3IaBwZNIJ+FosENMnws4McmucJk1iGNZBzD63WdyyVHonlMuQKpV?=
 =?us-ascii?Q?2TZWMRyOyW4iJNvvARhbyhFOsGFlaRtB7Pod5V7ke8yYm/ZNQ1Gna8Yp2SWY?=
 =?us-ascii?Q?5ZhjVofxdKj9SssEviZ8xwkBv2lVjdyEqwWekAhjVFofcDIm84trbpFofEk0?=
 =?us-ascii?Q?SBGbRp2uyzbBUGQ4vYlsIUCc9faN2BKQb5hadbPAX7EfOeNptOfuwnRUqO6Y?=
 =?us-ascii?Q?X9yNE/PENdJJwWNM9eKa1/fwExvg/4D76j7mbL243n1YDcwQBOD1DBDG9P0b?=
 =?us-ascii?Q?pVtnI5cxfpUuw/ampnlkq0KZh/G2gsSLobIq6XLj7KyV25JhUGyTpstZZrd+?=
 =?us-ascii?Q?nc/lJt5Fysv5aDMyTC+Xgmrm+qbqkr6DJtW5bKHxiS2PMCkH/PBjCg7JaR4k?=
 =?us-ascii?Q?AijgNuGx3prjjT3bNtExoGloDXrypjQr6PaJWhlHU4Awxj6Oq9NRB+jXQdnd?=
 =?us-ascii?Q?abyTEj3eYB/yu3Z+P6DQzzlzhIUz50RmJbI8HhMI+AbGAmMA0k5cnvM8FjhN?=
 =?us-ascii?Q?tP0VL1wJaYjmZhnHhE0e3c6uJrp8L0100PzOMGUL+4PS+4NhXoS9wgvoAtUW?=
 =?us-ascii?Q?ohN9K3pfcKujQLX7Hx78u7fnEn8aXpO/VqlLqI6v4vvGKmN0KDQYOntd2nGo?=
 =?us-ascii?Q?uQmrpiO10mdIWQqQVtB8pIpYWcm6QHcjlDHw3kqEEe0wYnSzfSULUzhNDhHp?=
 =?us-ascii?Q?DXAvzmZeUONQ2nWkZkNs77oM397pe3fXPtW9CvQSwQQCOMzsUwvV819VX7zj?=
 =?us-ascii?Q?NV2zPGCK3H/GYPddGgfN7lQjryCpXSzd2BCFQNtx2/47qD0IOorRhCpmE6Jp?=
 =?us-ascii?Q?pBLKhEzIUdIn5W+n/ivqSh+7R1PuDtfBmy3G/QDqChbjB8zyo0U8ORvuWplu?=
 =?us-ascii?Q?g0weqYmXxnUG0Z0ol5x4URhFH+BifVZYnR8+S97oQv0fMcL1MY+vX6O+eSJ6?=
 =?us-ascii?Q?aIBu8K9VeYDMgjQ1OJMhO6vw9eUic0eUIcwWqw9fcKajNW0z5rNPp6k6EMUJ?=
 =?us-ascii?Q?wwVIOgNgvqR+BKIwAaHyVZHjCUZMj9EBQUjXbQNpy8cYqAlnWxwgjdMGrRpT?=
 =?us-ascii?Q?igKjmtUUE4KjEYuTi19cQcdMVYgr6tcJZ1RslMQ5bn1vbHaFQ0Rhrvfudon5?=
 =?us-ascii?Q?3+PGdl5yuMcx3MJy/G3nwl1dK8g/+QfSRhz0yZRPEBn/pc1Vcnstprh3WnfP?=
 =?us-ascii?Q?abZLXT9K/tmBWuLFOb2pGVtTuK1hMBdjvuky2shkd/KQTytewWfK1lEs+RtN?=
 =?us-ascii?Q?Dd74uaKvfkliVjGQhsm5nhgmzPYNiFXXmLbaFsju?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fb2f48-c3f2-4b57-439d-08dba3280803
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 15:54:13.3439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ohIWulYBEPBU/BTbBW5W4pqJLBSppPaQGrFZ7S6KwxqQI0Yno8rgk6YlPb87cxv78Qhuy/tdDeHVBOylgNnpbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Original irq number combined UART irq and DMA irq. These doesn't match
uart driver and dma engine's expection.

Update to the irq numbers, which just uart can trigger.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 92ed02e6048c..f26f8ee5d2f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -86,7 +86,7 @@ lpspi3: spi@5a030000 {
 
 	lpuart0: serial@5a060000 {
 		reg = <0x5a060000 0x1000>;
-		interrupts = <GIC_SPI 225 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart0_lpcg IMX_LPCG_CLK_4>,
 			 <&uart0_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
@@ -98,7 +98,7 @@ lpuart0: serial@5a060000 {
 
 	lpuart1: serial@5a070000 {
 		reg = <0x5a070000 0x1000>;
-		interrupts = <GIC_SPI 226 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart1_lpcg IMX_LPCG_CLK_4>,
 			 <&uart1_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
@@ -112,7 +112,7 @@ lpuart1: serial@5a070000 {
 
 	lpuart2: serial@5a080000 {
 		reg = <0x5a080000 0x1000>;
-		interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart2_lpcg IMX_LPCG_CLK_4>,
 			 <&uart2_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
@@ -126,7 +126,7 @@ lpuart2: serial@5a080000 {
 
 	lpuart3: serial@5a090000 {
 		reg = <0x5a090000 0x1000>;
-		interrupts = <GIC_SPI 228 IRQ_TYPE_LEVEL_HIGH>;
+		interrupts = <GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&uart3_lpcg IMX_LPCG_CLK_4>,
 			 <&uart3_lpcg IMX_LPCG_CLK_0>;
 		clock-names = "ipg", "baud";
-- 
2.34.1

