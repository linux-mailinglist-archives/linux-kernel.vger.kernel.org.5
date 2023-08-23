Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6E27851AB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjHWHgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbjHWHgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:36:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2089.outbound.protection.outlook.com [40.107.14.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E6410FB;
        Wed, 23 Aug 2023 00:35:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lYU5mFOuDy3aR31fqpHX3ho6XFKMW1N+SUZ3J53ILSvrOp+iRFUJOV1aUjMmadd7Vmgcxbvji6fHm2qHeDi7JgKq4VyzHjGH9jksK0HXPh7w92C4FwO6lxjBdgz3DZEioUeM2yPm5P3N7HDunWMmteh+vozXVnt1s/ELZ5Kp5vRRecmz1M2UJgpXZWBsSDUM9HT5b1ViL6FhjVvnYj01cv/dzLXDyfJNIGT/wg4s8d1nO9rGjhOzAnsn4viKNh5aj8BOTFK7x7lN4zOCCpTM0n0jYcG17dacmaAmlTidk/kVZ0Z9zSB1wmffiG2vc0WVzB4wRLjZII4QMFr8q8AkKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAi2jwPG9wg48wBW8AHqsUs1UeohO406vf8Vn4Xx0Ho=;
 b=SCGlKTFurL3INpKnu5uRNh4mWBMO7jtQlAxc9lnIa9u2+YSqBMOzg4E0kN1nR25G4ILTi3S1HDBDfjzR0IDekzvgz3/hQrXGx/oYuLj1Kq6DHa1BVESF9Xe6A1Svreh5bsjCuUeX5ZYfBOEZnzRBCq0t+yaF+oKu9FCnMHsLFWMhHGaG/JMFo4T0dLocW9IStSxRHCIPOiLHp13b7hX5vK4vR8QNUzLY8YYI4kVjWTZ1s/NliZxrqJ+/XYsrbntH1TxkoSqQZAhSVSVT0iVDYh55ImmEPNwAtz24wPvT5BoRzGKGcIBEVKL08rwmTZiohozUc0ZumA/e88GZjChJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAi2jwPG9wg48wBW8AHqsUs1UeohO406vf8Vn4Xx0Ho=;
 b=gYqmBfd8uAoVd4DbPoau8+CUmo+OnloLzrpkFEoGI25ZI+WQ87ia33AVu7TwfYd68jopxbwKQXl7HQcnUZOwRwkNfOXqtnM4K/iuriiY/z0cg49ZHK63wqI5OAjOsXjhczVHDIbglw9cLonaTGylDP4NsE77wG4oYylnIF1moc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com (2603:10a6:10:2dd::15)
 by AS1PR04MB9504.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 23 Aug
 2023 07:35:19 +0000
Received: from DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915]) by DU2PR04MB8630.eurprd04.prod.outlook.com
 ([fe80::175:d311:2cb4:7915%7]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 07:35:19 +0000
From:   Pankaj Gupta <pankaj.gupta@nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        clin@suse.com, conor+dt@kernel.org, pierre.gondois@arm.com,
        ping.bai@nxp.com, xiaoning.wang@nxp.com, wei.fang@nxp.com,
        peng.fan@nxp.com, haibo.chen@nxp.com, festevam@gmail.com,
        linux-imx@nxp.com, davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>
Subject: [PATCH v5 05/11] arm64: dts: imx93-11x11-evk: reserved mem-ranges to constrain ele_fw dma-range
Date:   Wed, 23 Aug 2023 13:03:24 +0530
Message-Id: <20230823073330.1712721-6-pankaj.gupta@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To DU2PR04MB8630.eurprd04.prod.outlook.com
 (2603:10a6:10:2dd::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8630:EE_|AS1PR04MB9504:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fe03b2a-fae2-4511-7c28-08dba3ab8009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KVUI18a7pVX1cEy61uBhQjjhJ1aC1sTr6PAm9wBPbUT5sobgvQTjmkEkx9O+aBquEN5sJT8GxtwRZOv7jAJw1O6S3/4h9fkgPXfLWTVlXIQYFsAZeef9eVpMPh/JNqKWxveq+GPcmeisw4D3tjYRAurCepDlGWInJSPK268OXbVOpTRz+187YB8hcE5rQxDndWRNxOn1pXZu6wHWTaRZcFI2V9awlJYhfJHkxNwL93/hD3CK/tqdvfsBSdXCjr8fUWN2TooV37hSpWZZrYuna/0ETi2FygipecQKgXvDr/VOn0ap/MRUnQsln1URiO2ZE2B2Xx7uhJY9AG/VKKc0OvlEVQXBw4dEJvX/rY8N/oo27YzwyMoKb5uPZDBJSzdowOGBfaqZ7zBrKwUCEpblQwEh7PXYLj83ltTDFf8/y2n/bNCmXZ294viWSZAVWPo5YHtJacaTJIldDS474GNmTPqY5mi2/GE2A3Ehren+jqxvFl4KWGmK8DspmrcuJf48c+41Pd0gvWyMPSlnFWNmlERGZiM0aF1BekVkzDtrFpqUclSLHWVc+pPSP+tEjeCZX3Oywv2UWpW8RLO00ZZKY5dM2AOnCRKi3H0Z0umEloUWl0A7+rOaPxqVvYlA4TApxWdt+8G5vPO8rEv1Q/mFVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(346002)(136003)(1800799009)(186009)(451199024)(36756003)(86362001)(921005)(66476007)(66946007)(66556008)(316002)(41300700001)(6636002)(478600001)(38100700002)(38350700002)(6486002)(6512007)(6666004)(6506007)(52116002)(26005)(1076003)(8676002)(2616005)(2906002)(5660300002)(7416002)(44832011)(4326008)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LdEhQl6MRDXb19pkzX0lr7ESIPGeZRy7Y2dcVKhjdMicbgp5MKNb3pumNznD?=
 =?us-ascii?Q?/lG0fEVeHT5OzMvvbQVareOw4L9JTaJYD/bX8OvFzRUBXKRZuJiQVZMjX4BN?=
 =?us-ascii?Q?tSZOK++MtyMb6MOg7JdXceyx8FbGMSX9RdO73re+f622ksvMAwmi+NF++yKG?=
 =?us-ascii?Q?3ak7t0P2ay5V13hTX3/8AFA+88t7doFkdDE24yvRyvb7MbD4UuJjvzFJHe4q?=
 =?us-ascii?Q?gJWlHHbYaZW2wwZL2LWGbNketDgOMaUi4TXqr1RAr8uThro/4K5p3b2Ol2Pm?=
 =?us-ascii?Q?ZxV+Nhr0v3OPU3+6O7f7f/kLNVhRDRsM2xwDuyZwKSctYyJZ8KkiIEDfhVBq?=
 =?us-ascii?Q?tQ5r7An0L7Qayu8MCPvg8fdAfbMEI2ZTHpG3tRzR8sU0IqLgCOOPO0EQXjQo?=
 =?us-ascii?Q?9fQa/wKZ0YNQ1Le4Aw3WfHMsIMErY4sjsKeGRbzfk/z6a6TCdjfmzcXRyQyH?=
 =?us-ascii?Q?/wCoO95bgTnV8nxtyot7qmC8s9+Y5Z75XR9L4+h+utS0aq/Mv/Ca0uMSUKwj?=
 =?us-ascii?Q?SaX2hybxDEWIBzCNgtN1TngJz0vksGETpEG+YMmbFoBvysbgxlzgg+emzfpM?=
 =?us-ascii?Q?Wc8/gBnKdOP9oy6SOZUfDZ36qvMl7uNCQSfzx+LQiw4ali28GHnEonbWDpeq?=
 =?us-ascii?Q?t/D7aOzmGhkx3R8bSc9C99uX9ncjf0nW2a/Im243Rx/FOIuGT9mFM7s8V2hX?=
 =?us-ascii?Q?E4NUARu9cml/UXNf8v/+90y2lwq2eFUBEHM7VmSp6UWs/2Xkx994h5flhGsP?=
 =?us-ascii?Q?7tiQpXn/GlvyttH/JjfSu4iIk4zotfas5yb6s1mdxvlmM6jH3nV5WELLXbCq?=
 =?us-ascii?Q?2PPdWDp2Tn4SHj/LXWXkHCoBRFY/sjEl5silpfyuwBaz29oBx4Gu0TxHd7Gc?=
 =?us-ascii?Q?EqQCGAhoaQdLmEoNQuw0VpZme0McBV8K01WQXyEopLgZ33qdLyZOjGkkUEdB?=
 =?us-ascii?Q?T2oPpSgIEXcBGm6neNSmbbq9L8BoBsRlFJahXPQ9kQI/QIfQE+wEXgj83dRo?=
 =?us-ascii?Q?iMcupHr/gJFan/t1qsoKRvsmXR2wHJVUMOI//WiqBXLAVFdph6MYCsIk0ITd?=
 =?us-ascii?Q?+urE3nN3Tx2m8eYjdbYyS5cJ3Mjgbhr9bBoJW+/UET1MXJqyGXDq08iMwwKY?=
 =?us-ascii?Q?Yp63Te3RmIEmQsx9N/VwMyZqOOcR15o2Z8CXSquaXziZULlLm/T03pjNBjE9?=
 =?us-ascii?Q?sNmYjreTPSHofs04u18mMohjh0s3lvdqy6VCEZyfWRNgsgyKkMLYz5WkJqgS?=
 =?us-ascii?Q?XtPcIo8fceaVL3d1L2/7UURwEJMi0vb0Rv6GQ39P64WdrbqWnZAW9yAJJImg?=
 =?us-ascii?Q?lv1otlBbx9vldOTqoDZ4xYduqEtgrWbLXmOTbycask6Wg+oi+n9ac+FvU6+/?=
 =?us-ascii?Q?Jdp5C7XrPlbly1cqXEw9/F1dmdGkFrU8MkmsPiKjDna4d1cty8rPFOuvVNZd?=
 =?us-ascii?Q?K9B5Ev56kIwAm72MNPW9Fy707dtkBjyd2f545XFLAVShJ3zTzYqh6FArsuYP?=
 =?us-ascii?Q?WHL6nHhDA/KwkN7L8aDUEx63ZQsSjhOMEKl1m45G6L0qEyWxTC9o4OnXQtA9?=
 =?us-ascii?Q?Tl8mj+5t+lIQFquHice32RRf9uGW79fKHqhzCqhM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe03b2a-fae2-4511-7c28-08dba3ab8009
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 07:35:18.9785
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 336QCyKdPjluJQ0Z+1Lg977wsFZQIeVwETGOm15S4A5VkvY7X5WmVJMLg/jOhLdLo4PsPdnOFLyT8VE4wC8xBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9504
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EdgeLock Enclave are has a hardware limitation of restricted access
to the DDR memory range:
- 0x80000000  0x9FFFFFFF

ELE-MU driver requireis 1MB of memory. In this patch the we are reserving
1MB of ddr memory region from the lower 32-bit range.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index c50f46f06f62..0abff3a55abc 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -7,6 +7,10 @@
 
 #include "imx93.dtsi"
 
+&ele_fw2 {
+	memory-region = <&ele_reserved>;
+};
+
 / {
 	model = "NXP i.MX93 11X11 EVK board";
 	compatible = "fsl,imx93-11x11-evk", "fsl,imx93";
@@ -22,6 +26,17 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		ele_reserved: ele-reserved@a4120000 {
+			compatible = "shared-dma-pool";
+			reg = <0 0xa4120000 0 0x100000>;
+			no-map;
+		};
+	};
+
 	reg_usdhc2_vmmc: regulator-usdhc2 {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
-- 
2.34.1

