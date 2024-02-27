Return-Path: <linux-kernel+bounces-83933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D349686A03C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:31:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4996B1F24C14
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213DE524D0;
	Tue, 27 Feb 2024 19:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZES9GKT6"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2158C1487D6;
	Tue, 27 Feb 2024 19:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709062273; cv=fail; b=ZBrLpKKR5ncgXrkMPZA+64XT4Iqog6963lz7P75QhaoSGF4V9LSkw/JN91GEpodlMpkuEtseRqgwdEXXuzaM9LsDI0N/b8mKCUYRcTzy3Rrb2MyK42wzIYPsiqVEqK4rcM0uhsOe7RfZ6D0MHECYvR1zabRF/ufW4B6eg+0VRo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709062273; c=relaxed/simple;
	bh=pee93SEQ2pTVDJ7d0+UvoKsgkeGlqMVC0dwB/mQKbhA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=oRDBX/uGqal/EdSStfBLnawx8f8B3CjPJWFEEBWWKZkj3qPay+DXf4FZurEl9gVyVsz8o9dEBPhO8pB1HwIVDAExZEGl0MXpo3uEJkmf/M/2XfpZ8fhxK1lhUEQmBXUVs4xWRzcWkpZEqk6gGZancrIoF+4g1fg1NE+uT+BnHVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZES9GKT6; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qvk3B0lsOXJIjEJRbs+FXiLXvrM2oSZaVEGtTNJX2O4iCxnSDZKMGwR2kZTJ3zTNTnGuZq9GIKWOrKf/Hr7TOEnQcVJxjjnsPGmf8K+2xhex4iPCECAE1ra2nBH0+FLrCt+ncJkmDvZUU56XeRIxVOsO+36S1md7diZVHKG2MFs5+bNchCQsNUgcS2Mwd4N6UgVN36Fxx1/yT5d6VYVbQ8A1o39HcMGyjtNsb/9j9Quht+SaTT9b9C4Fiori/81m/4Vuc+XiPrt+Y3gEQ8h7Z4SYuj6EMebMhwTSLeLe2B19m3UQ+IdEIF+wtcZ/EkK5BzdYbyI96DHO5SMP3/Iq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8EojhKQxOO3uSAfk8DLIUue1+Ijb5U94mPX+PI8oCI=;
 b=jO6M7/Xv+tuwCJnqvRCoiUv03oID6D6iWW2RrUGDKK8h+j9JV5F5aoBjixn2HVyPsPsDkn4wkRFZjA+rdkdISKXo7CNAvn4gt2vWkW0xuQPKqSg12vF51vPm8j4bW4ffbavcsdBdq0mZfAEPtCLsI/HnUIAKxPec+i/dLMxMzZOmCc9x67N3J3BbiPV3ff1+eYVhlviF6LjSRWZsYaPwslZIsLbw0CR7jb4pPzLm/riWSm100zn0Wu8Ng20nByorlu5NuO/PMTeSPTzjf0KC22Pnu3ahfuxGEKjRTpAmq9RQKAlhLtn9Kce51Cl4Rb95mwDki34OxYXEf+4I4/WXYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8EojhKQxOO3uSAfk8DLIUue1+Ijb5U94mPX+PI8oCI=;
 b=ZES9GKT61zvLHZSxFbUSHCA+7ShNI40jMuXVWfMyKVcoeqGlJPf/a8scbVkacZImCAxMVNQaHLPIJ8EApCjRW688BawuSiy6ENZtdbHnPkPuLKsdoqnKzMThE3qkTBzrVgoXsztGVEn+lXrEi6hfhBt3SYeFjbxl4ufs6ECOLbs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA1PR04MB10283.eurprd04.prod.outlook.com (2603:10a6:102:463::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Tue, 27 Feb
 2024 19:31:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9af4:87e:d74:94aa%7]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 19:31:08 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] arm64: dts: imx8qm-mek: add adc0 support
Date: Tue, 27 Feb 2024 14:30:46 -0500
Message-Id: <20240227193049.457426-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0056.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA1PR04MB10283:EE_
X-MS-Office365-Filtering-Correlation-Id: 0053feab-4537-4668-c623-08dc37caa5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PSJxXNtFlB4afDsjuEC/DPEkxhmlNf5wHReaPBmmU68p2aO3Fgw8tXgLsoIEv7S8fcW/1zoZv0PKvvZp8QXCOpuRMcHLbAMsok3Rxu4vlv9kkSygANYyUatmAuliDi/dslHfKcQP+Z8klNhTqyEmo6HbECQHWPrL7JWkGI3FF5eGYh9tmh5L9Ooxpk/a+/tQJB2koWp7VyOuS2m41MBs5r81T01ZUnR0c77Pr3LT5VpMufMzitVNB/cklI8utxyQwG5BwNuesauapvkzZdDXuSjc9LPuC+UwAzehIkQ2g/x5WRPjZ94FPQTzIs9Oll06pWE5ih3aSL9Csfm9WIqF6T9HX7vR8FlMxJyD5ZSXhR97UesW987SiH0j1T4RihA+6c3hDNcyADXFtwVWwiZYlkrVJ2AzfWEDzLy8s90tOCEhzphNj15SrYmoXOd4SusRB/YFqFZTLQfJ8JWrO3o1oN9xaoqtj5cXO8hvZzX7SMEaUH09Uj9DXB2i3+m5GBjiwN1OW/W2eHJQk6+XS501Oz/90HE1Ry7AxmHqzbm+qwWeEWZcGYlt6pGSfHIfFdMEq6K1JPWkIIq0ks7ZUb3bvyVMXbZzGE4vbsCp+gXjmomqlDFjJXihSbAfBLnRXRZqVGSJKwJSlTB1ZtZaqYrkG95RpLg0fj5YBofG7nr/XKrmgVFPZ1g8IbkpD093R/I/H1nehN/JBBN+KBXAVNJhbpKjYmQQLUVFV7ZpRNow8b8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k3wdduClp1qyk0VLZivgnFYulcOqmcfAYXXZZjf3gaB+sNBFPtcBEl8UYhbw?=
 =?us-ascii?Q?Zxsiq2sgI+Hc7x/NFMfj2NbyKD/0hfWpyd6Hy1G656tXdWyt44LB8/f+O5N3?=
 =?us-ascii?Q?PcYhcJxlLPaYp0NGYeyhMUSYosQOIfHIOu7rcyl2RafCESp9ZfJSXtTWwD/x?=
 =?us-ascii?Q?f0eXd3QTDYkm3m0jUxYqg9MvhJtJR2MHg9s2wd/kwmke76dk3FguFkjg/dqs?=
 =?us-ascii?Q?b3axwpYBUd1MZuAA982/3aaGLrhjhqjWiivSUCne+tmZB1ImAE/+d2AW6vBQ?=
 =?us-ascii?Q?jqM+gjNuq/rHPxbVn9D+af+TNohU9wf0MfcCHTaVIGA4j/5JYw5JEozWz4QE?=
 =?us-ascii?Q?2VoVVQOTF+N4yaZ4UpT8loOLEGgleqWp04hPplIJYZ7f5TspkZSLNA2PDsT9?=
 =?us-ascii?Q?kV7ZoJXZqPqaJd1yoMqV0a68ylegHTJNgsT3xeyyxLxoaB4VuKpGqyY408Ht?=
 =?us-ascii?Q?u4CvjabUtiw2jZdojzelBXd/Sp2cVTLy7RSdUrKs0ug7bGz7v/62VhaZdcb5?=
 =?us-ascii?Q?XiAszWeP6xElMUkbxe6uFqG6s8At3Lnu/bVXdZXhfgiSKv5zPyJPZ4CtXIgv?=
 =?us-ascii?Q?AkUmkMjb99BWrggrt3YTuWibiTVLKcQ+A+gvPmOBrD6UUZnxv3zdRB3j8Glu?=
 =?us-ascii?Q?yBCdjsNOvokgSKibEcn9RllM31G7eFho/wquWP40zSLwTYrwgHhTfIbrewLC?=
 =?us-ascii?Q?Dwy7+UGFY8+U4ImZUAOMABO3QnHqwI8T5RfKuvVAvk72FAv5IIDPoyEcIPsF?=
 =?us-ascii?Q?lRQnk1ZN23RXOHb9Ba9EJDVibCg2hoQrmLwHHEnD9Oiw4RS5HvVqK6KMYsHc?=
 =?us-ascii?Q?wt5MyzyFV36KvSv5U8ByFgSlG8iPTVtjtcfrf8E+/wOr6EXgXEZa0n3cWgKY?=
 =?us-ascii?Q?t0nYKn69zlxqp+oubyYw6ahfrsPBfXjXeVRKPOk2mk9+TeBURP7lHeRP/LJ6?=
 =?us-ascii?Q?HHTmm58aOj74jWopW8vslNPpOYoY46V0Jpr2gq9Npkkp0F3SpADOYXFc/2nP?=
 =?us-ascii?Q?l0ggmoCq/YmdF/5ML8qifcD0Zs0Ru+ZQnN2gp6vInMQn1mcUYsrHn+dWrxMU?=
 =?us-ascii?Q?sDN4DX1hmgDXzRGVeZ+j9bDA6lpYYGiexSQ2Iqk60Up/AYILM/brYwCcm2mB?=
 =?us-ascii?Q?dNL/e9F5WhZWMDt6902UrC7nGM6Xxu9LQOYMxGoIsyVs5ZUN9LQKV+/QBg/W?=
 =?us-ascii?Q?TnYzxhTRs06xu1OXMUBd2IgyqIVj9sD12swrl6luzXlsrNP3JAWCRvMyaGis?=
 =?us-ascii?Q?T/3b3wXaVC8QaeIKPOgk9UI+Rde8bFC+V/B6JBZo717/QCvoQCICBCAlpfcL?=
 =?us-ascii?Q?pI5BB1lZbIRGW+r0mPg7rKwcEJrfR0Lj1NLjSmz6PWIJ41PFUAoa71BchWGm?=
 =?us-ascii?Q?WwNyChIvmsfcX+0RNS1JrP+OUrsH1mdThejM5SB2Ee/XkiPgVR9zMgKWeVWT?=
 =?us-ascii?Q?Yg3EauT4eZe5n06dTNkqfwYEfNqTRk/F+KYoPmo7/gi9vhgVDo5WzoakYRts?=
 =?us-ascii?Q?TlYLX3NeXA6psAce0xXNib3nOYJuFBYjQq4eQajTe51mDdoWS1gQG0b97MxF?=
 =?us-ascii?Q?Ys5hU5qG2nZV63n1REJyebb5A10ew6vIYhaPn5U0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0053feab-4537-4668-c623-08dc37caa5b2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 19:31:08.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ksb3LTjb6mmTKddBz4S9TFlYBqDEYT9z1FK/l5jVjpvdXWPEkDl394Z7IlVfKOUz6SpdYxBSw8CnK9/Ec3IPLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10283

Add adc0 for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - none

 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 77ac0efdfaada..0c4972724b041 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -39,6 +39,20 @@ reg_usdhc2_vmmc: usdhc2-vmmc {
 		gpio = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 	};
+
+	reg_vref_1v8: regulator-adc-vref {
+		compatible = "regulator-fixed";
+		regulator-name = "vref_1v8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+};
+
+&adc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_adc0>;
+	vref-supply = <&reg_vref_1v8>;
+	status = "okay";
 };
 
 &i2c1 {
@@ -130,6 +144,12 @@ IMX8QM_GPT0_CAPTURE_LSIO_GPIO0_IO15	0xc600004c
 		>;
 	};
 
+	pinctrl_adc0: adc0grp {
+		fsl,pins = <
+			IMX8QM_ADC_IN0_DMA_ADC0_IN0				0xc0000060
+		>;
+	};
+
 	pinctrl_fec1: fec1grp {
 		fsl,pins = <
 			IMX8QM_ENET0_MDC_CONN_ENET0_MDC				0x06000020
-- 
2.34.1


