Return-Path: <linux-kernel+bounces-150503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 418018AA03A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED24E28389C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B9316FF22;
	Thu, 18 Apr 2024 16:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oJPMrIY5"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2058.outbound.protection.outlook.com [40.107.104.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E6B171E75;
	Thu, 18 Apr 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458227; cv=fail; b=NKJISMtZRZyAB5mgFWdQEBYI3T+ZM4aSXXjIUarBcUTPifd5Kvh+ALSeNQ7ZpL7lVJZvzcvKUUZEef449ZCUW6Et4QcQBMu84+REQMFJ0gfdW1gp7tsJiwmNK9BKG9NjicPbvQxYmHjijT7TxNjk3DDAB1XMSEvfeU7dagi24o0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458227; c=relaxed/simple;
	bh=Rh/b9AhzPHgqfUXhyPNS+ooEafl5IZyY/rGIVJCUJfo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=N88LKHZku2I4ZegjAyQH+sXuXkrvfUCBA7crcXOGroO23h6Kq3IARxvVAxyxGjtg9ZB2kMczcRH6uUQUbfMn913Rf8Jf69HFypyzmhOSMWEyUewOl8FWkso1R53ldUydvCM0raBkDEFxtiI9LM3o1+39oGZJM+keQXAhKzkmBa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oJPMrIY5; arc=fail smtp.client-ip=40.107.104.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmw0cKy428AIzezwB5bBlciy6YNe/V4gnomhHNmWE56o0q0Hca54ixCIHtLhyX/gNCBbCSyyRHV5mrctPcbmHk9IvNbwmBXlFR8GneEO9JEAn/cKzRgDF468ITyyL2+bMMdqnt5pPKa1LHzhHMKBZb1Ed1d8whA1ts/PDE91jRzLQYKMTR+gGAFq+KJmtZMTD8hiiVUjghvtGVeCUZX6Hj3AX7jBDhVhY5+kkD2IdcCvTuhsKRDjug9lwhtTfDaXaGEgABDUJdleOkH6la4ZM/aZcVNLDxNBg/+swKeXAfHMY3NyCqXlRKw+AA4p551c2wxGQQtSrbms+fZsojvT2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jikigYYfD0fsPyQJhI0NprYi0N4hhry476mPk/hhN3g=;
 b=FmnN8wa0zgtFpKD2jPUmRES667l8cq1KlhU0p3LUFLentuQV/yRF3eeushBvQ3XxuJD7WhdtgIt3upBC++UB+cXW1jKSGdu5FDosU2Bm8uybh2pUFVyBwCAUFeaYwBX2DNuH5IqRczA5DmcIxGz6zCkAUgeRC0+5CbqTxf6IC+wi76x4PDh+35Rr27lH0NSkxC7IdA+Zjz2Uc/9FePYO/6tKD6xWegXtauK24TKFn6E7AdmwD6hcacc7QSi+moAMIbRJq3kDrs8PN21T8Y8FcdKYV/4f5iDOn6C2akxtN0pKnwuwc4RfU+m5IxkVeOqvOwLluZNghg9Lqol986jORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jikigYYfD0fsPyQJhI0NprYi0N4hhry476mPk/hhN3g=;
 b=oJPMrIY54G88kmU94tWdF9GEUM+J+K5jXUblRhbdJpSVbOcugg/23i9dHk7+7MloR2mZA/lg95iRAIYOKe130Dv9JgGW24OVu6QIw6d+3ii6XzioPhveIU2q+RmbEQ40T47eDO6w4JXKYSve2bdh2RLD9szXmNaWQ3RFAXpscvw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:37:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:38 -0400
Subject: [PATCH v2 03/10] arm64: dts: imx8qm-mek: add sai and wm8960
 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-3-e40fe76b60a6@nxp.com>
References: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
In-Reply-To: <20240418-dts_8qm_audio-v2-0-e40fe76b60a6@nxp.com>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=5359;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Rh/b9AhzPHgqfUXhyPNS+ooEafl5IZyY/rGIVJCUJfo=;
 b=smoAAaW1TMZZz3v44cvHQHTphVRrXxEMsfxGTYFHBHSlzWGbu9l9D12K5DAw9++NN2bxf7GPN
 aIDF900FUXzAat21vlTeGO0k3jHwJ+RrmSN/niVzFy/CRssawtl7LGt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY3PR05CA0045.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM7PR04MB7079:EE_
X-MS-Office365-Filtering-Correlation-Id: ade923b1-76eb-4d54-0559-08dc5fc5c6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UPsLw41rVf+yQNFHohkWhZdK6cC3NNnsx6rRT+TeD89yT76/XnEgSdAAXI4ajto7E6aufGk3cFKaIHjZnI11O+K/zJts9SDaEkCPQZQGXz7eCWOMtG0qeN/84NMRSfFiIEaxyjL+kHbwFBYcCWaO7WuQZmRuZbRZyMGkHCcLF23+fc3yKWIzk0BmrOq9YKToIJ5Z98YAvXRLhKeQ99UvF6wuQ1O3Izb3W6SLJ9tIHZaQRw8PHgQpfqcMvFUxG5NNL66gzCYk5bN2yB/y9p/bXJKdjFZ/hDTSY1LbQ9ZfV2Or7cDtLZiivXtI0L1Yw57bcVyx8PGEAX6SBWT2CSSLBYbB8l9H9XAXDT4Xhl2+RThLVE/AAj1du/LdZs/VCJFyq3VuWTmZyR/8eV4QDFjEGWA8lXJtH1yjwHZv3oi5nHQ81Ywx1WENCTJSCAf7HRSgfPDlPbH4uHLVBY0vXkMhPZEyNoQyRy+D1ZaP9O5tcZzYX5ZonnIm4KkxNh6B1+8N43vUTzMhw89p+dai2+sXUSZgl2VjCUvgY+RS+V9JkyitZ79s2GsgtIoeuMAz/br5nzbop5yI892XLwHP4DEzBFQfp96HAXx/1YLRnSelavHdEIOTZZlJfFf86VMV26CDUT08OE2I+i0Rvcyl7lRbeHUK9+v5XgIS9H7kuvOaoI6e+0mzaFIvUKW++lEmnIiQ9aBvHjpfXe3ykmcTECR4Tw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NFBlVUxsK0owbm5iSXhpR0NrWERwcitpT1RaY3BSMWpzY3hEdEQrZzZrS0RZ?=
 =?utf-8?B?NytkWkdCZUFKVktDSE9Uemdma2VZNEN0Zi9FWWIxYWFzczNaYUI1Nmw5WE5G?=
 =?utf-8?B?T3p2NzBZb1lzdWFvSmRpYm03ZnFheTN0dGE2bTRkZzc0ZFhSN3JUSmdtRDJN?=
 =?utf-8?B?TlIvYzRhMlZGZkEzYUFMMEFPTFVtU1l2YTN2MjE2bG5VeWxZcjBpVlRJdE9L?=
 =?utf-8?B?R3Jvd2N4eHlsZUdCdUVUYWppL2NhaTNwZ1NDd3E0eGl5WWpIR2U0SjhYMlgx?=
 =?utf-8?B?dWNpU2NUbCtNS1B5SHQ0dG1pRjdMaG51L2lPZVZuNkw4Uk9VQnNvWHd1ZUlF?=
 =?utf-8?B?VVdzaDU1QzFmKzZlekVDWlhWOHIyWUpPVnhMVjdFY2lYZHl5ZXBxZEs1YWFF?=
 =?utf-8?B?ZWdLSUtGQ3dLWTBxYUpFR2RRY3ROSU5namtYNjRCdkJUTkQ1YlMxVGd2NzZ1?=
 =?utf-8?B?VUpjaFdVaW9HTHlxTUdnUnlrVngzWWsvaGR2R0YwUklPZlZOSE91Rkp2OXBJ?=
 =?utf-8?B?RlhmS0VjQ1RSR2xRYW16UDdQSS85OFpEZnU2Y3ltMGRiUVJIUk9VdVZTVzdI?=
 =?utf-8?B?MHlhZjlKTmNHZmQ4Qk1kQURid3JURXpnWFZQRmQ2WVV3QmJWYi9EUCtCbzJl?=
 =?utf-8?B?cFRWcjNKVk8vdUR0UGRxMkl4dTBOYmlBekJYNTRFVGFZUm1XZ09jOGtVMTJO?=
 =?utf-8?B?WE5RK01Zcm9GU0tTdXRreXdISkJ5R25ZRmJnNDlBVkZ2MXcvV0llbENYaDJa?=
 =?utf-8?B?MkxSYk4yMVRackw1R29LOGNJNjgyb3VKL0lRTngxOExWTzdOSUhaWUJERmQy?=
 =?utf-8?B?STdGd0dXZVpZanF2SldXYXVEWC9hWjM3ZTlSbDFJbmYrdndwR1FUUDZNNTVa?=
 =?utf-8?B?NTV3Nms0cWQ2UnVWamV2WUl6YU8vYlpDNXVjMXl1eXhhT1pnUFFNV3pCblJh?=
 =?utf-8?B?L1hDY3gxK0xqb0VXdnVJZ2tIaEZyWkJRV3Jwc2RJdk1lOW5FS3l6WHVWbS9M?=
 =?utf-8?B?d0V6cjE4NWl4OElTYlRPbW03NEtpdUpURDhjb1VXbG1jSGlWUVhNbGVJV2Y5?=
 =?utf-8?B?cS9NVU9ZajhONG9ucEdkN2x3QkkzOFR5Y3I4cXN3amdLdUNXNTAzckwySi9I?=
 =?utf-8?B?UUpGYlFWOHg4ZVZndHcyRWNhOWRRZTFhL0xBMDhxSlE5Qys3OUwzUWc2RXF1?=
 =?utf-8?B?Sk9HZ1NhWXVQWThaYXJsSVdudHY3QWNmZXVoVWlKeExyWVVXaWovNi9remhr?=
 =?utf-8?B?Y0hhT3l4OUFiVG5iU0pkb0FiRXhBK2Y5N0h2RXN2TTNKczNhRWVaaXVES2Fl?=
 =?utf-8?B?alRiZmNrNzFUUUFlZkVYdkJQN0padGhmU1ZWZTgzemM3dWdmbVYwZjhYYzI5?=
 =?utf-8?B?UHlqN2xGdnJiZ28wZkIxbGhBZXlVejF2UCt4cGs2MnUzZHcrYkNRTUdLZjlZ?=
 =?utf-8?B?OWI5TXdVK0RNM3VhZW0yb1NUT3B6ODBWQnA5RmhrMDZtNUdZVDhxRVI2eVha?=
 =?utf-8?B?SFUyQUFoWTMwU2VuaWtaZi9GdU0vWDA5MS80dG4xY3JVMExvc1h6RjR3OWpL?=
 =?utf-8?B?dldVZlQyWGEzOEEydnpJdmdWdy8zQnRpeDdGN2tseXhoWEdVcVZJUm51elVW?=
 =?utf-8?B?b1hweC9OcGhJRHZPMVZNa1Q5TkFiNUhYR2VlR25rck54b3hZZ2Z5MWdoN1lN?=
 =?utf-8?B?K2gwTXZjM3h2UGlVa1JmVDlHOXh0SFNOTTBOWHMrTlU1NHpWYnBUQzNIY2RT?=
 =?utf-8?B?WWN1Y1N1TENOMGtoQ1NadFNVSHJqOUs1NGJOOTltZzNad2ZwMXVaNmo4K2lm?=
 =?utf-8?B?Qk5UQS81cDZtQktMSEQ0SWtISjdiVUQyQVFJVmNSbnd4a3dlNWJyUU1GcTFZ?=
 =?utf-8?B?bnUwUVI4WjB2dzdyNDVtTXd1VkpSSnQ3Mk14QzNIZkVWS0FaR1BmNi81d1Bp?=
 =?utf-8?B?cUN1MGNPQXdmTGdkTDYzNmhqS2lYZmdJTTVUbnRRS2R5TytLNkc1TmNEZXEx?=
 =?utf-8?B?VnJpWk9KTmZkT0I0K1h5VXdCTTJZTzk5a2hlUmhyK1pPY01VODNEOFhqTjVK?=
 =?utf-8?B?RmF0L2o1N0VONmlmRnJ2aHd2ZURUZzdyRWRVUm1nRTVJN1VxaDVzaVJVWGlU?=
 =?utf-8?Q?4e8Zug+8yYk+nVnQ5tVLEDYm4?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade923b1-76eb-4d54-0559-08dc5fc5c6b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:02.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jWlgRKLZ1Ro1RcSueE0HxKqzgppWVbgAXOLVFlonmEv28GtizyWgVqNBfpdqko3zD2Ys7q+6x7b3eFa90ur3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

Add sai[0,1,6,7], wm8960 and asrc0 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 140 +++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 5c6b39c6933fc..9f8d3df00f793 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -46,6 +46,47 @@ reg_vref_1v8: regulator-adc-vref {
 		regulator-min-microvolt = <1800000>;
 		regulator-max-microvolt = <1800000>;
 	};
+
+	bt_sco_codec: bt_sco_codec {
+		#sound-dai-cells = <1>;
+		compatible = "linux,bt-sco";
+	};
+
+	sound-bt-sco {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "bt-sco-audio";
+		simple-audio-card,format = "dsp_a";
+		simple-audio-card,bitclock-inversion;
+		simple-audio-card,frame-master = <&btcpu>;
+		simple-audio-card,bitclock-master = <&btcpu>;
+
+		btcpu: simple-audio-card,cpu {
+			sound-dai = <&sai0>;
+			dai-tdm-slot-num = <2>;
+			dai-tdm-slot-width = <16>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&bt_sco_codec 1>;
+		};
+	};
+
+	sound-wm8960 {
+		compatible = "fsl,imx-audio-wm8960";
+		model = "wm8960-audio";
+		audio-cpu = <&sai1>;
+		audio-codec = <&wm8960>;
+		hp-det-gpio = <&lsio_gpio0 31 GPIO_ACTIVE_HIGH>;
+		audio-routing =
+			"Headphone Jack", "HP_L",
+			"Headphone Jack", "HP_R",
+			"Ext Spk", "SPK_LP",
+			"Ext Spk", "SPK_LN",
+			"Ext Spk", "SPK_RP",
+			"Ext Spk", "SPK_RN",
+			"LINPUT1", "Mic Jack",
+			"Mic Jack", "MICB";
+	};
 };
 
 &adc0 {
@@ -65,6 +106,77 @@ &i2c1 {
 	scl-gpios = <&lsio_gpio0 14 GPIO_ACTIVE_HIGH>;
 	sda-gpios = <&lsio_gpio0 15 GPIO_ACTIVE_HIGH>;
 	status = "okay";
+
+	wm8960: audio-codec@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk";
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				<&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
+		wlf,shared-lrclk;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,gpio-cfg = <1 3>;
+	};
+};
+
+&asrc0 {
+	fsl,asrc-rate  = <48000>;
+	status = "okay";
+};
+
+&amix {
+	status = "okay";
+};
+
+&sai0 {
+	#sound-dai-cells = <0>;
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai0_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai0>;
+	status = "okay";
+};
+
+&sai1 {
+	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai1_lpcg IMX_LPCG_CLK_4>; /* FIXME: should be sai1, original code is 0 */
+	assigned-clock-rates = <786432000>, <49152000>, <12288000>, <49152000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai1>;
+	status = "okay";
+};
+
+&sai6 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI6_MCLK_SEL>,
+			<&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai6_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
+};
+
+&sai7 {
+	assigned-clocks = <&acm IMX_ADMA_ACM_SAI7_MCLK_SEL>,
+			<&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_PLL>,
+			<&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_SLV_BUS>,
+			<&clk IMX_SC_R_AUDIO_PLL_1 IMX_SC_PM_CLK_MST_BUS>,
+			<&sai7_lpcg IMX_LPCG_CLK_4>;
+	assigned-clock-parents = <&aud_pll_div1_lpcg IMX_LPCG_CLK_0>;
+	assigned-clock-rates = <0>, <786432000>, <98304000>, <12288000>, <98304000>;
+	fsl,sai-asynchronous;
+	status = "okay";
 };
 
 &lpuart0 {
@@ -161,6 +273,16 @@ &usdhc2 {
 };
 
 &iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			IMX8QM_MCLK_OUT0_AUD_ACM_MCLK_OUT0	0x0600004c
+			IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31	0x0600004c
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c
@@ -256,6 +378,24 @@ IMX8QM_M41_GPIO0_01_DMA_UART3_TX			0x06000020
 		>;
 	};
 
+	pinctrl_sai0: sai0grp {
+		fsl,pins = <
+			IMX8QM_SPI0_CS1_AUD_SAI0_TXC              0x0600004c
+			IMX8QM_SPI2_CS1_AUD_SAI0_TXFS             0x0600004c
+			IMX8QM_SAI1_RXFS_AUD_SAI0_RXD             0x0600004c
+			IMX8QM_SAI1_RXC_AUD_SAI0_TXD              0x0600006c
+		>;
+	};
+
+	pinctrl_sai1: sai1grp {
+		fsl,pins = <
+			IMX8QM_SAI1_RXD_AUD_SAI1_RXD			0x06000040
+			IMX8QM_SAI1_TXFS_AUD_SAI1_TXFS			0x06000040
+			IMX8QM_SAI1_TXD_AUD_SAI1_TXD			0x06000060
+			IMX8QM_SAI1_TXC_AUD_SAI1_TXC			0x06000040
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


