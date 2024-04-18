Return-Path: <linux-kernel+bounces-150505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50628AA03E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E1B26387
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8889A176FB3;
	Thu, 18 Apr 2024 16:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UkoaJ+gG"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A6A175544;
	Thu, 18 Apr 2024 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458233; cv=fail; b=J4jqZ9/ZhMJ4XLQEZIYw3o6CcJYABRdOF/+peqcgG1cKYGggPLg3xB+S8NBuvaa+KnexUYPkRmsX1T2B/miKK/PyHvXXa7rxQk5AccAFpMN3O5q2DA0oDScbVxekVnl/1nJQ6nyijPWP3HGbzi0eM4YKDfiV/vdJKAmVEYaDIOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458233; c=relaxed/simple;
	bh=Jfg4Vvplj+RzCDKt5gzAaPXK5833pBM2PeC9Y+Nj6Hw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Te5OJkZm5joDkoqBZXRSdbdSbtqhisXu/sxx9VuRF9WeNSAYsuwAooFpA30tP3K5m5w9pxVuGJBo/8XelBml71CfKoJvx5VKSoGSNxdcjelZk0fOodP6X7VOGVPKA3BvqWggAVdrC4fIldrfRKA2DpcWbCZR0eWPmkLQO8r6zFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UkoaJ+gG; arc=fail smtp.client-ip=40.107.104.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVnpPM32e2sxZXdwuU2xRVDqabo1hFkdyXZvBo7pFv07NbkjGuIktqlon7dEqyVcV3SUwj868v9oFNMQGVjqnuGIbbuPwnX/8PNaRdiOYzgkEHPkMAw55PYK6Igqkuj8gCowuBNXromxgDe/Pp0S8ILqFLjD45rf4Hl1dszleIXwmzRBLAo+EhTXo7pAXYUxG19PEB4LhGpI7XcN1DESq9Uu14ePbRBS+6+k9RT4LlTFChloBiLXZHyls/Ns4/wyUWH9Q2ixt9UKy04Q4+0iAOxUDH/Ggx2XcXuzSPYaI0N9/CjRAtSLtTGhT2OLk7t3N1nLG/Fe8OtOKCzyI0d+BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Bwjtl05Hm+41tt8t/fWxL05NkXLXiF7wCsejzJxWq0=;
 b=eMrq4JLLjK/p1Ohn3zHCBLppR6JNkCwZ1SukY7zq+5GFhSC7A0nX4EMeBfKJZRPjtwF9U9vOcXp/MuJvUNq8wj3SPbp8ZYgHW6PJii2pJ4s2GasWBOPOPOfsJZHnQP5NLv73I90t98ST3RAl2XAckcL9ueKA4WNzGjYlNP6Me67U85H8JS5JJ6ICi/CHlxFKsXdMlqvnThaxBy+FS/SQAif7D5gE6B+q6RNH+cC6LILH8QxvM4M4dsXQlSXDiy8F6BSMJhiRO/vCKwRB7UJGW6baYVPGw3zw1035D/6+TVezbCtwegg53IuEnXWZml487IRGQWiGZxyQ3pnkSrHVmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Bwjtl05Hm+41tt8t/fWxL05NkXLXiF7wCsejzJxWq0=;
 b=UkoaJ+gG1YZDubElMoCjgQNdkYT8btuzd0butdNdGeCzdFzlmWl5DsVNcCCkpZgji/CClKMhUzQgg/vV4YgXCpHlogfIn0t0wWpk6bH+v4zUvQzzsl9WNCWhrGnpRbWZN75EpvmTmcmOiGUitcLKoz3qJ/qLasQDKReGylklPQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM7PR04MB7079.eurprd04.prod.outlook.com (2603:10a6:20b:11d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 16:37:09 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 16:37:09 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 18 Apr 2024 12:36:40 -0400
Subject: [PATCH v2 05/10] arm64: dts: imx8qm-mek: add i2c0 and children
 devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240418-dts_8qm_audio-v2-5-e40fe76b60a6@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713458209; l=1711;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Jfg4Vvplj+RzCDKt5gzAaPXK5833pBM2PeC9Y+Nj6Hw=;
 b=rZ+MThLPG/fcvG4Rpq5t8dpQNQycbu+juxgqWCI7YhNtqeb2t6wMqRMYia9J6GV6jC10Bi+r7
 l6p0zAzblSGAsuloUcRQyFXtCGvjnkSRZ6czGcGhq0zi19gx+PC+VCS
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
X-MS-Office365-Filtering-Correlation-Id: dbc1984d-1f56-4956-9c8a-08dc5fc5ca97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jsz3teHbg3sqal4aI+wsk/VA1gvIldvuIyxkkrnJT2wcnrD0X33HdKMwo8nfNq+JEeRLlwEoh3NCmmf9fR1UuTV64wsGWAKgw2uc4DYqrQ+Gdo53nzJSZK77rSUXHgEaKdkzCVi7yXZH3uDNfG5FA285/IFauEhuyoTGUGXd7KNf1PGuehaJSGOLlunL/LnlpANEqQcPEwkAivfbcJNPVKfnBTZKgAiGHDrQmWzXHXFQgpT+hoepl1A51/4NkLbIO8ky16FQZvve8/3yzSlgbh2fqI1DWQsIC+JNr66Kvkk+gNU4viBoeKXtQkCqbdlA7jHzRITuagArBdtCdEHUVfsZqLapD3ZWeXnslETDuYkDhQcumYgzhmwbQw00HIcAEYi9v+YkqvDZGP03FS7nWiFqgJwTDNHcAd3jNUk6UbkMy5iDtBApU54KM9ZTihSz11gcVipTui44gVC5cTfr2luQezp4tDwuJG8q1q1pq4DLI60X6kNBoKBkEVXk/Y978Nr+unTBDhEuuKLig18zwCBP+/mlN4BPfSv9bY1xxKIdAyv+PJGgPRxrMigGI+VEnovw9b6wUV3cwimzS4dmo3U6HMsALYi5pfq1vHFsSDWxnsToPG2JIVOAj/nqi5NR5o2FZZCxbxCiyNtGLMvYjQMGMf8U4tBu6plb0QHBrLziZNi5jxBJ0kXwMHgEM/yNdfEhrG9zbiu0AGQZD1QeMA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y0NMNG9mdGpCdnY3UHBIVXh5UVBKOEJtT0p4RUNmYUE1S0dtSERvbmNmbWto?=
 =?utf-8?B?Zkt3YlBUNkJIQnRoYnJZeWgxVHd1U082WUxIaHdlNlkzKzkzNUFCdWJwYTBq?=
 =?utf-8?B?UW53TTNOaWtna1dubXBmRHNCR2x0TVhTZUdBYTNwWXNIVklrOFAzZkYvYkl5?=
 =?utf-8?B?cmlVYlNJNFJVR000UXlpR3MzUTBYaEUwT05OWlRadDRQb2RaaTFiMW1jZjdp?=
 =?utf-8?B?TmJoOWZXWEhlM2ZEL3EzZXRkMFk3cnVPODRvUHgyMkRzSk14dnFoQkVTb3Y5?=
 =?utf-8?B?MmJIZUNhcHlCdnNiWmplKzRHdDEzVS95VkltaHJML2s2QXJKMk9YN0NPM0E1?=
 =?utf-8?B?RjFvbUxRS3VhRXhucjVIcjdzMzJ6QlgrSFRnbXYrS2o0bkwxd01EMjduWTZu?=
 =?utf-8?B?L2k1R2F5bmFXeHFFNE92MXRpekk1Tk4wSTc2RFk2YXlma0c5MEFZdVY2b283?=
 =?utf-8?B?QTMwc0ErUGNOZlVwVWI3dGpsdzVxZlZLNDVvejZBSXJ6SjRwdVpCVXl6Z0ZM?=
 =?utf-8?B?VHlRQmRORlJNY2tSZExQOW5GcWxrTm1hblB1bGYvUUsvQURveHRlQnFOTmo5?=
 =?utf-8?B?SHB0VjVxcGRqY3diT1JOVXVkWkhLNXFJSVNHQ0RYRzR3dTlPK09MS1c4ckx5?=
 =?utf-8?B?bXcySnJsL0lKNCs5aUxrM0lqUm1VdCtJVTVPYVA3azM0QWhSK1hFWXRyY1p2?=
 =?utf-8?B?bUxuRjd0MkhhQkF4MHBZYmFmelBuWHFWeklJbzdOR2YzY1g5bTNrM1FzYTJu?=
 =?utf-8?B?eUR3M24ySEhEVnNiN2FoS0RGN3lzNE5wYmYzcmJMc0prYy9FdHR0N0pkbEpJ?=
 =?utf-8?B?MTl0WWJOak1mRSthT0NWVDNjd2VUY0FobG9XbG5YVlNqRGlVWEtFWXRSblNG?=
 =?utf-8?B?aEUvaEhvVU5QMnZOZFNtUGNNbzV4Q1FwUjFJOWhYazhlZWVuOUVzVFVNVzNz?=
 =?utf-8?B?Z0JMRi9yZm1qdHZ0K3FSNG1mNm9HOFlUSk8wbFdRN0tqZ0l5S29SMHlWcS9O?=
 =?utf-8?B?VGI1ZzJMR1pNdXIvbll1eHBMRU1UWjVlNW1yaE84Rlg1RkVBOHhyS0dpdVBR?=
 =?utf-8?B?S1pySTRFT0F0RWdpVEdOdEt5YUJlb0RVNEdnbVV6SzJiQ1BWWjJJZFJ6bisv?=
 =?utf-8?B?OGhZT25RSDRUSnpMdUhKclMyemk2K2RYM2tYUEh2a29Vai9JSnZKcmlUUTE5?=
 =?utf-8?B?Q1ptb1U1UmxFTjNDREpBQ3hhcFU0S3o2bUVhb0RDVzJYTWVybXQzL2lzSHo4?=
 =?utf-8?B?Wk1mbXVaOG8weXlGSEVZRTFZMkVGc3lXck5JY3ExWXM3NjYwK0RFcVZSQjJh?=
 =?utf-8?B?OUxrTU9DRG1VYnZ6RVVXT0xPczhPMW5zQVhVNk0xalhpOXRNT2JvQ1htZlM2?=
 =?utf-8?B?RlVtQXMxOVp5b1dHcHZzVGkxWndoeUdlNC8vQml4K3RScTJVVzlDUW0vKzZN?=
 =?utf-8?B?N3ZDb2Y3dExJeXEzRndNM3hRWmh3d0Fmem1aRjhMM2NPcVY3dXFVRk90ci9H?=
 =?utf-8?B?bmlGeklESkMxNmpnRUpoQWV3TmYzb2hpTlAwQ1M4NGxVZGJwRnJsaUh0Qyth?=
 =?utf-8?B?R2RCeVNUOWJGZWpVdldvOGVaZnYvNnE3ZTBSVUVQYUNXa0R4MnVaMWZPMFpV?=
 =?utf-8?B?T1JkTHBqbk9SRXdjRStSQ3JCcmRrWElQbGdndVBhM1pLY3VsUEYzcHo1V2ZE?=
 =?utf-8?B?ekl2QklJOW44RkdOZGZ4ZWdsQUdpRytmeCtWYVNTUVRiU29WTTc1NzJtYUFV?=
 =?utf-8?B?UTQyRUlxeFlTNEFnVDJZa0o3THZPM0p1VW1tSEQwdjR2bE1QRlZjZHhtWGJp?=
 =?utf-8?B?djREWGNqb3lOalBCTDNsY01PYVFPN1hHTGYyYjU5WUw3OEp6ZjU1STJFSlBX?=
 =?utf-8?B?U21mMjNiT1AxUjFPbTZOOGcvdnUxWjlHbUduN2NKSXg1Z0pDRVpHY1hzL1R2?=
 =?utf-8?B?NWZOQTc4eGphVTVHL3JBL21LR0t0VVM0ek9zckVxRThWclg3UGwrSllMV3Z0?=
 =?utf-8?B?OERhcFQwMHpvSFJJNjYzazR6UnhlMWxaK2llSU42amd6eFVXQkF2UVdRRmc0?=
 =?utf-8?B?YnNoVEZia1p4ZXMxd3BRL3p6MkM1Yi80bWxmTzVHMVZtSWhzVjRJdjAwamNH?=
 =?utf-8?Q?NXGfPaNnZlJ5QZEqz44eEXhyT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc1984d-1f56-4956-9c8a-08dc5fc5ca97
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 16:37:09.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8B/pZpoSM0ivaYlmNPxD/ViLKxBxDIrwQCo1jMRQNgHPGYP4lTsKVeGFQicBJQNidN1gDqQWEIEpJtcxY1+Q7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7079

Add i2c0 and all devices under it for imx8qm-mek board.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 50 ++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 9f8d3df00f793..e5740f301bde0 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -96,6 +96,49 @@ &adc0 {
 	status = "okay";
 };
 
+&i2c0 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	status = "okay";
+
+	lsm303arg@19 {
+		compatible = "st,lsm303agr-accel";
+		reg = <0x19>;
+	};
+
+	fxas21002c@20 {
+		compatible = "nxp,fxas21002c";
+		reg = <0x20>;
+	};
+
+	isl29023@44 {
+		compatible = "isil,isl29023";
+		reg = <0x44>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <11 2>;
+	};
+
+	mpl3115@60 {
+		compatible = "fsl,mpl3115";
+		reg = <0x60>;
+	};
+
+	max7322: gpio@68 {
+		compatible = "maxim,max7322";
+		reg = <0x68>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	l3g4250@69 {
+		compatible = "st,l3g4200d-gyro";
+		reg = <0x69>;
+	};
+};
+
 &i2c1 {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -283,6 +326,13 @@ IMX8QM_SCU_GPIO0_03_LSIO_GPIO0_IO31	0x0600004c
 		>;
 	};
 
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			IMX8QM_HDMI_TX0_TS_SCL_DMA_I2C0_SCL	0x06000021
+			IMX8QM_HDMI_TX0_TS_SDA_DMA_I2C0_SDA	0x06000021
+		>;
+	};
+
 	pinctrl_i2c1: i2c1grp {
 		fsl,pins = <
 			IMX8QM_GPT0_CLK_DMA_I2C1_SCL 0x0600004c

-- 
2.34.1


