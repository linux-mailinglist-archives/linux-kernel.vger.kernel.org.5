Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506A78041B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjLDW2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 17:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjLDW2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:28:22 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3834183;
        Mon,  4 Dec 2023 14:28:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRfSSmtcJsybAqdKVWMhhs2GV2Eh3fon5sJJzsUpFGd51xtjIfXUHj2QbugT4QhyC2nVQeVoGJJKYy+9UCAIfXRBMABO8gea4pLrqpbEvFHTwsslfmOmfKSraQyE0gmQ4CG1UKmgUVbpBNJQbW45IqABdXF9biILZv9YPeyXHuIXLLZ/zcZe3hlGCLee0knw3eDe/ypNbm39IKPhHObShARMTjzXh/zD5uwHJc0Eo251JiJYIh76aZkLzpt/HWAVLCal8xkdBRc4FAbJ0mr1jjgWm0S4GQ8UDQkilPtLBgFwq6KeLQ8lATGFExFJ3GJRcEi+IQRepi4p0wcir8J+cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T5skvpHUgtjScMvYeBqq/3vwfVU7ab5H5lB8pp5a3ws=;
 b=R9QyfoBkjJBvXSOCRMKa0VvNePMbsGWRy5xcQF4Ptpg+4E9h5ihBYxVc+o8L/nbsfhG9lb4GtHMgFAflM/VcAIcoOg0D6UFNiWs81te2T9DB6BnOMjwthSxCZVGkDDMjHg37F0KKpbIBJ9AUaoPhFiDbQEAsw4bcs0E+jM87iIQO9HZU/U4hKNixDWznr9UcNjdZGGwuMx+C6J0iRBl6naPhisU5gsjagjT5TmzQGU97ElrNVx1d5aXY6i6Rnv8INw+Uag8cYJh7zG5TcriIaP8/3oybX7A8vY3qWPRIR4iokSuyV/yon3sOEgB9q8Sh03ZinTMD7kjY/7y6BHJi7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=PHYTEC.onmicrosoft.com; s=selector2-PHYTEC-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T5skvpHUgtjScMvYeBqq/3vwfVU7ab5H5lB8pp5a3ws=;
 b=PH4HD/YJp5Wck/21Q0bTRI9zw0OMDILLovaHuCb/rM2kD/ZFHykidgd3gkJ8D6SI+eof0PpfphDYk9Lo5J5oOA3xbrM85XeukLm1MxCgL6gnbBWeu1+qhITeLXGyZnD+Lz0OsHfRjEeiBBDox8W+drwuqAQVecIxHVGawC/zxbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com (2603:10b6:a03:537::8)
 by CH2PR22MB1912.namprd22.prod.outlook.com (2603:10b6:610:85::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Mon, 4 Dec
 2023 22:28:25 +0000
Received: from SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef]) by SJ2PR22MB4354.namprd22.prod.outlook.com
 ([fe80::388f:1cd7:191e:21ef%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 22:28:25 +0000
From:   Garrett Giordano <ggiordano@phytec.com>
To:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        w.egorov@phytec.de
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, upstream@lists.phytec.de
Subject: [PATCH 2/3] arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add HDMI support
Date:   Mon,  4 Dec 2023 14:28:10 -0800
Message-Id: <20231204222811.2344460-2-ggiordano@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231204222811.2344460-1-ggiordano@phytec.com>
References: <20231204222811.2344460-1-ggiordano@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:610:1f4::19) To SJ2PR22MB4354.namprd22.prod.outlook.com
 (2603:10b6:a03:537::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR22MB4354:EE_|CH2PR22MB1912:EE_
X-MS-Office365-Filtering-Correlation-Id: 2498939b-99fd-49d6-f4b5-08dbf5185473
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P4C8wuP+2POLjEZxs951d6mFRX34q1py2uvK0+NmPljqsHyIVn+rts3fvgtOVuZb3VEaaGHOjcYHUU9dke12azLl37SlNFEU1DSl7Q997bSStkaHTncNU0AN36EvExN1s529QeNr9g6jt9CmpNWNZwda8De95NzmXt3sNBo0kb0L2kz7S1ffjjasbrue0QZoM+SSzCj9Gc+Iqd0RjJIFC5JtJ4+fznJvB1xwMt4cweIvSVsroRR9QSQYH2eZnzjcIMFJwn7yEnNnBX1l6TV6LG5mXaCcxRWeGcgAYmd9R49B9QmTkJPoo3ibPJE+DBmFJubgxaxV5iKkZUnNDvTE2h5FJ0iUr8gRmXzR0gFDA3RcxMcqgSKH0bmHzoSO/mUFzJfTYkrdQzOY4p4epayxkWGLu9n8wNCXFXf1mENLL3/dwJ9uyhoeTxwHpzGLfubJHskd3dBuEFhSAZxRXCKOQLhjRceSqYT7CR5Dyu+tvykvYWTw8GfEUEq4TCgvr7OQ7tSlb533H13074epe+TaFXTNIVn3ntaUc65nG+httaZNJvbkqWMsmlPWumHi/tRelIMY+/BDAOUmFhaT3sHFfxwQ+wEiW+Su3KfLVfkiFg7M7DrhMKEBbsJNTtHCs8Qx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR22MB4354.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39830400003)(376002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(5660300002)(86362001)(7416002)(4326008)(8676002)(8936002)(2906002)(38350700005)(41300700001)(6512007)(36756003)(2616005)(1076003)(6506007)(6486002)(478600001)(26005)(6666004)(52116002)(38100700002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MVkBZCDLoXVOS+kCDUQTzdVzGuIKAgKVsokmmj077gg7s+zS88hNYhntKXZF?=
 =?us-ascii?Q?fLo19HY0emL09Dlep8qz/6N6hjcU2z8LNbsyUYgUaaQ6jMQpWz5w1LHB4k69?=
 =?us-ascii?Q?dUqH7AzELiDOR5PQM40QG/zDUEAvhh1GP5nu1Aiw2ietlGKzJSZ0+v3EU9Vu?=
 =?us-ascii?Q?RHWdNBdzHbid2Enz72nG7SPws4zANGb8rAWGIyuHOnNdzjrKe592d81XEiLs?=
 =?us-ascii?Q?H8pUVZVPpClksMQU7LTAPCSPiuFDkHB9Syvb6LHFbfHMPqHEZgndAxOWrxKd?=
 =?us-ascii?Q?kU+iuBF2p6V6G+77l+NlcI0973zdH+EN9d0AeRuGyEGgb5mCcB1LI/gW9m7u?=
 =?us-ascii?Q?iAImymen/HWDGI2zG6V59+hAISmrNKkJPqvbA5R+zNuQsMjehe0XMlm4UjAa?=
 =?us-ascii?Q?dDArSFWA4vRVrS4iexYnqmWuAn7pGDbNqqSGPkyVoWpinQQePpUA0ilMzy5b?=
 =?us-ascii?Q?bwRDBQOZeZ7plxvMgaj69Ni52cTU6LAJ6enlGrbgC/P0yop7VP1lXqQ4scCJ?=
 =?us-ascii?Q?PI08/e8nbIpiJ+6oIeJz3XILAc5wADoE3RuTAIelxicmPsWJdaSin/630a4z?=
 =?us-ascii?Q?0QXB10jz2fCCI63OSMBKPqnbTwAM2qJ6x8km6HCJzdIYLY138kdGGIMa0a96?=
 =?us-ascii?Q?VcSt5g9+RLfBRX42WU0uqv8xWVi5CjV5MuMgg4gYwgE77bsF9iCbwbkBTtZz?=
 =?us-ascii?Q?TysKEwf388Q475QDVPA88vNSC9GCv5SRLQGdRfl+EMl3h3HQ5Z0opERWnbor?=
 =?us-ascii?Q?YkHG846qypz/XJr6Ud5qFzNc+Vl+bM3L+NfB60F30g42KMsxeWxBgE+3MNEC?=
 =?us-ascii?Q?IUsuU4YqopR/xsnZQh7IaKhu3zP5VM3jGoznXPwFN44iBjdG8xp8lC2+01bS?=
 =?us-ascii?Q?jYVnaIUZ26aKuDFNMy6KSlo84Gj1ommYnln5XsRsTyv70GUj7YT9+pReoxSO?=
 =?us-ascii?Q?D1ccrP3eBCYDeS8Mz3Mf5CVrMZxxBzbW22g7axq+/J0RGlCOQoBvacF0StPn?=
 =?us-ascii?Q?QPS0wvyY0T7DigGVE+x+wpVo+6i7pJrATDeGm3p/stEyaHdiNtqQO7RTHjCQ?=
 =?us-ascii?Q?s7/+fN5th5V6eeRlr4CIgeygYSJWz9HUZSg1D6BcwFH3en6R9ULtkjtYPE6l?=
 =?us-ascii?Q?t4EL/X9/iPwocW+DYz8Tb5mjyFARlLii2Xo4XHhdOtlgKCkUNniRXYA0gvAU?=
 =?us-ascii?Q?1o4woMDkNnP8zhoRKRcjh17LLTEiFXG4i/t1bGJYtaOLUDs0WpeqJEVUeUEs?=
 =?us-ascii?Q?9aS3wKFvh5HgFb3t3n7RBUQDZhNsbaj6EVHKdJqdmsRMh0iPIbFlRHqOFYP3?=
 =?us-ascii?Q?AU/OOVyPTN5js5HbH0E4tq24WfowlG/drnlE4Tfrrian02ShP+jr1mlE0BQ+?=
 =?us-ascii?Q?b4n5ZRrfpxnMDzRagIBi2ZMALxJkZz7HNGIf2xGZDlYvZOGAZtEZeeN4xDFl?=
 =?us-ascii?Q?Jd+2tWCOEdfowPhIRSiQo5EjcyGgCcyUMl+oDVAFO8NL/LZzGGXZNFgnaa2w?=
 =?us-ascii?Q?hO6evGaa/zPbEAlaIZoalZd0S6JXFLgrbL4y27XnFnqlePOBaI+NdKInPVIG?=
 =?us-ascii?Q?baG/5FcF6wWy7/nQZtL10vLFGtKRQNmB603CYEsJ?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2498939b-99fd-49d6-f4b5-08dbf5185473
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR22MB4354.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 22:28:24.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnpgcFvB+BQtaCSuN/5+6vrnRwYePwTcrlM/yvRhLq8CtjvzQK4Ua66T3ST9eK7cx9V+XHoUBkCPTrnGTHsgKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR22MB1912
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DSS outputs DPI signals via its second video port (VP2). The DPI
output from DSS is 24 bits (RGB888) and is forwarded to an HDMI
transmitter (SIL9022) on the board.

Add pinmux for DSS DPI output and HDMI Interrupt.

Add DT nodes for SIL9022 HDMI transmitter (TX), and the HDMI connector
on the phyBOARD-Lyra.

Additionally, connect the output of DSS (VP2) with input of the HDMI TX,
and the output of HDMI TX to the input of the HDMI connector.

Signed-off-by: Garrett Giordano <ggiordano@phytec.com>
---
 .../dts/ti/k3-am625-phyboard-lyra-rdk.dts     | 94 +++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
index 171354b13e33..81319d68b624 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
@@ -35,6 +35,18 @@ can_tc1: can-phy0 {
 		standby-gpios = <&gpio_exp 1 GPIO_ACTIVE_HIGH>;
 	};
 
+	hdmi0: connector-hdmi {
+		compatible = "hdmi-connector";
+		label = "hdmi";
+		type = "a";
+
+		port {
+			hdmi_connector_in: endpoint {
+				remote-endpoint = <&sii9022_out>;
+			};
+		};
+	};
+
 	keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -93,6 +105,37 @@ AM62X_IOPAD(0x244, PIN_INPUT, 7) /* (C17) MMC1_SDWP.GPIO1_49 */
 		>;
 	};
 
+	hdmi_int_pins_default: hdmi-int-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x040, PIN_INPUT, 7) /* (N23) GPMC0_AD1.GPIO0_16 */
+		>;
+	};
+
+	main_dss0_pins_default: main-dss0-default-pins {
+		pinctrl-single,pins = <
+			AM62X_IOPAD(0x0b8, PIN_OUTPUT, 0) /* (U22) VOUT0_DATA0 */
+			AM62X_IOPAD(0x0bc, PIN_OUTPUT, 0) /* (V24) VOUT0_DATA1 */
+			AM62X_IOPAD(0x0e0, PIN_OUTPUT, 0) /* (V20) VOUT0_DATA10 */
+			AM62X_IOPAD(0x0e4, PIN_OUTPUT, 0) /* (AA23) VOUT0_DATA11 */
+			AM62X_IOPAD(0x0e8, PIN_OUTPUT, 0) /* (AB25) VOUT0_DATA12 */
+			AM62X_IOPAD(0x0ec, PIN_OUTPUT, 0) /* (AA24) VOUT0_DATA13 */
+			AM62X_IOPAD(0x0f0, PIN_OUTPUT, 0) /* (Y22) VOUT0_DATA14 */
+			AM62X_IOPAD(0x0f4, PIN_OUTPUT, 0) /* (AA21) VOUT0_DATA15 */
+			AM62X_IOPAD(0x0c0, PIN_OUTPUT, 0) /* (W25) VOUT0_DATA2 */
+			AM62X_IOPAD(0x0c4, PIN_OUTPUT, 0) /* (W24) VOUT0_DATA3 */
+			AM62X_IOPAD(0x0c8, PIN_OUTPUT, 0) /* (Y25) VOUT0_DATA4 */
+			AM62X_IOPAD(0x0cc, PIN_OUTPUT, 0) /* (Y24) VOUT0_DATA5 */
+			AM62X_IOPAD(0x0d0, PIN_OUTPUT, 0) /* (Y23) VOUT0_DATA6 */
+			AM62X_IOPAD(0x0d4, PIN_OUTPUT, 0) /* (AA25) VOUT0_DATA7 */
+			AM62X_IOPAD(0x0d8, PIN_OUTPUT, 0) /* (V21) VOUT0_DATA8 */
+			AM62X_IOPAD(0x0dc, PIN_OUTPUT, 0) /* (W21) VOUT0_DATA9 */
+			AM62X_IOPAD(0x0fc, PIN_OUTPUT, 0) /* (Y20) VOUT0_DE */
+			AM62X_IOPAD(0x0f8, PIN_OUTPUT, 0) /* (AB24) VOUT0_HSYNC */
+			AM62X_IOPAD(0x104, PIN_OUTPUT, 0) /* (AC24) VOUT0_PCLK */
+			AM62X_IOPAD(0x100, PIN_OUTPUT, 0) /* (AC25) VOUT0_VSYNC */
+		>;
+	};
+
 	main_i2c1_pins_default: main-i2c1-default-pins {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x1e8, PIN_INPUT_PULLUP, 0) /* (B17) I2C1_SCL */
@@ -184,6 +227,26 @@ cpsw3g_phy3: ethernet-phy@3 {
 	};
 };
 
+&dss {
+	pinctrl-names = "default";
+	pinctrl-0 = <&main_dss0_pins_default>;
+	status = "okay";
+};
+
+&dss_ports {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	/* VP2: DPI/HDMI Output */
+	port@1 {
+		reg = <1>;
+
+		dpi1_out: endpoint {
+			remote-endpoint = <&sii9022_in>;
+		};
+	};
+};
+
 &main_i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&main_i2c1_pins_default>;
@@ -207,6 +270,37 @@ gpio_exp: gpio-expander@21 {
 				  "GPIO6_ETH1_USER_RESET", "GPIO7_AUDIO_USER_RESET";
 	};
 
+	sii9022: bridge-hdmi@39 {
+		compatible = "sil,sii9022";
+		reg = <0x39>;
+
+		interrupt-parent = <&main_gpio0>;
+		interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_int_pins_default>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+
+				sii9022_in: endpoint {
+					remote-endpoint = <&dpi1_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+
+				sii9022_out: endpoint {
+					remote-endpoint = <&hdmi_connector_in>;
+				};
+			};
+		};
+	};
+
 	eeprom@51 {
 		compatible = "atmel,24c02";
 		pagesize = <16>;
-- 
2.25.1

