Return-Path: <linux-kernel+bounces-145834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18EE58A5B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7389BB24C31
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B723615E5DD;
	Mon, 15 Apr 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XIEqAqz3"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2081.outbound.protection.outlook.com [40.107.105.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98CB15E5AF;
	Mon, 15 Apr 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210436; cv=fail; b=G2P36o/tawq9DJ1y/zJ7/s7RfY/Zj2XWuiSku+9XRuABmWXCHjhl+2alowxlI3jTy0lUJfY4uvEqZL3wAJ7KhBXkppiLogLCBpTREP+n2+bS+7+c+xk+D/HkPKSuQoolgCmY/9bM7ltQTuicQs8PTn8ZcVm+Csu/p0VeQQEzA0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210436; c=relaxed/simple;
	bh=f+JqUQ1Tu0rXb9A4lvR6ENX7ENB3nwMHpcuGLkZ9Tqg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Iww+r61PbhzkD4ms8Kc0zQZWlQ1eCnibm3v5ep8w32m64OjsgnkYKlkEHFuxyMoX6tWLgp/prTId4+jsUFfpqbcsj/E2Ll8SeWBkZx1HV2lsyJuhzfB2wvdrcO250VZyrC7Yt8xrwCgs4UYVZ/r5K5H3g9LLs8o4jt9BxYObYyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XIEqAqz3; arc=fail smtp.client-ip=40.107.105.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeRE4OJSNdDihVeSmsCjcnjMkfFXbPwpcsT728ZWuV5HWajxyLTJj7Sh/zdcoRU5DsoZpp4z1/gKAnc0cTK/RE3O7TpvqYzlffgf6hvHn8TuQ9yp+l7HmVZzbyvEZKJBMv5Ag8t4hr1/79pxwZ8Wx8tsHlDclXDcbb0C1ikYH55iXu9xsK0f5BD6GiBQuGiqblgV3jZ58r5lD7/aXfapS1inVmj+ni5xRzvIcSyWOxtOT/LaY1BCmGBicwHi23zO3MW1F8/y7inyBwlH97tonIkdvPnqlvyIYuqMsQWAxvF/N5TlbOLkEvuJrvbxoXYm5OXFsHdePhBMTEE/ZTwbXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+t+VVeG58klg1hoj+WVnQ+V2ED1aK406z4370Oa0w6I=;
 b=PxdslWhYRUoKD2rgntxiC28ilZmJsFCHhcrTbvq8gC9206srhCUoetcICJoBHuW+YZJtpoEPGI8SkDZCvefGsRdPvvRe7pjVixO7D2slgx14yNp/drY5aI4NyfQ+Tv4KMZdPLNumItJcjXOZE77SNbzlmueDBkF7cM3CdYdyUwpLs2xw3r5SLBkKkwEVzxEnfAUUG1CzdYl9IOuA0EkGPfkpSfC1TLR9k4i+RNmA1lVh6yN3DUt2Vzf84s+RkArPaXcjr/NaGorSwBJZ4w2fgVp1EerH3sprpMUnBnNpJ82M/Eo5pTce3iGM7loecTdmke8/Jp26BTyx2pMFEoYZTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+t+VVeG58klg1hoj+WVnQ+V2ED1aK406z4370Oa0w6I=;
 b=XIEqAqz3dAm7h9LjUrCv2yQfvYJjS1Z9dHOv9IBRD5ab7xMahfF8TIdUAjr/akO+qiDPRafDFYWx4161bZkbIv6tKMFTVAGRpH7q6jjMWzV2A/vJO/9gldhZElGO/iF+yJFMIeyYjdGiLsNvlTd1w4pFeX+XAjxkJCyrVC4GTwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PR3PR04MB7290.eurprd04.prod.outlook.com (2603:10a6:102:82::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 19:47:12 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 19:47:12 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 15 Apr 2024 15:46:39 -0400
Subject: [PATCH 03/10] arm64: dts: imx8qm-mek: add sai and wm8960 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dts_8qm_audio-v1-3-2976c35a0c52@nxp.com>
References: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
In-Reply-To: <20240415-dts_8qm_audio-v1-0-2976c35a0c52@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713210421; l=5354;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=f+JqUQ1Tu0rXb9A4lvR6ENX7ENB3nwMHpcuGLkZ9Tqg=;
 b=aagvGSO+s8mgI4RY8cLQvgaqtwKifO00gb/hkAE5q77Bv1OprsGYchmgVJddKfpv/etv+An8r
 hABiC8auhpQBWrYzxul6xz3q+PJ8jxjeA+TVK9si4cTjxQdkrox2pPg
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PR3PR04MB7290:EE_
X-MS-Office365-Filtering-Correlation-Id: 11a9379d-196d-425b-a386-08dc5d84d854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nLrLWcMVv2ppqr7rRYOiRnG0DpRRR6MiKrQK2ONscylBUGynzOo+0h7GlcdLAZj2U8JDBoU+cOQ3K76jiQZh3UgEotfQxzwR0VqYmLPD/TfTxfT8lRkz2IZoPY2++taN18Npry12xaMoYeXcGia8tQg22uDwc6lnknL9bE7IFhbKvgeC2sZWtJIfG5vagbACXRlPgGvjL/xjLAvBqnUKIb3HNBmmiI9qsgjRDZVOsPELAB8i4ZITvmIG6ElISbQIPOcrNcC5qP1iCJExuI0m9i8DrYMGwdxkCnNjZ62qtyMlbgHxJz+YyN4i++pRAp8/CsLolD7YXmuazUlVBXjQ4lviTnHx9fCHo+N3hvQ4aNoCHSo+qtDz+32q5e4S1y1bxxHWJYr7uRgqLhBPvTWc7hQ1BfP2+1EQrnvJfwbJYAREBoZ1REruYHzNUolhVI/OrVdO82UHZkKHeyXRbYhoYvm+N7npbpRlN6Y4RYjgy38+iW4vfMp5YfjO38q+83Jyi00+4NHHnAFJRSWmx3LcI1sd2HOutB23lUvWCYXdelFSmMDdG3VoHNHVJxc4GmOO7Kbh1XEjJbJUjyWLWIj+X3xImFtbXOArtbGhIHdOgKJAWDdJHMfq354FDOnQNm5PTjtVrL5JV5+N+RdkSYaoUh8CHXjn5G/88enfyj16fpm8m1PxjVhMz6ucYymm7H9LExjoVRoN4/ccb/OkNVMvsA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eklzZkpoK2xITHpTeVFxSDZvVFFlTU5lT00zK3ZZSWN6NHZNeW1pLzU3QTJx?=
 =?utf-8?B?UkhpSUhFLzNydExqS0hyU2FsSVkvMHViczZ0UWJJUStJY2g0N1lJNFdXZWpZ?=
 =?utf-8?B?aHB1ak9MdXdUeUFYeUxDcWh1Yk5vVnk4M0M4SzhLUzd4Qy9XZ01pWHAxb2NK?=
 =?utf-8?B?cHlkVC9Ha2Zmb0pqcTdyMDlYSWV2MVJqdlFvUVFZWW9sL3F3Vk5yZFdxbXJP?=
 =?utf-8?B?a3pGQ1BWSFA3MFhQQnV2Z05DUWpkWWhDNTFpWFVJdW80SFFjd1hFSkpaK2Ux?=
 =?utf-8?B?VG5mNEN1bFlJbUpCR3ViUzJUb3JzRVJaRXBkRzNhelZZdjJuT3E4Si9SWWh4?=
 =?utf-8?B?dkdVcllOMWtXdUxUVWV0Sjg0ZFdXQTJDNTFUemlWOE9iaEdOKzZQbUZ3bTg3?=
 =?utf-8?B?SlhhcEo1SU5Sd2VQVjczM1MyWStHaHZOU0xmT2pqVngvQVFrWmthUGtOT0lV?=
 =?utf-8?B?SEdPQk51Rnd1emZZZzNFYjJ5Y05iaXIrc3ZDb2lPY3lJLzJQazRiY241VG41?=
 =?utf-8?B?bmtRUnZrNEFqNkpUdkRWY0hyNHZ6NVkrVGdvRHpVWWttNWhzOUMyZWdLc0FG?=
 =?utf-8?B?TElwTnUwdlh2S2pXcVAwdlVXc1RwOGh0bXpwSFp1b29SOGdpNXRkVkpEOFJ6?=
 =?utf-8?B?QjBEcThtbzVJQkNnWkt6WG9LVXowOGdhemZWSytZeE8wYWdmTEsrZ3Bma2tn?=
 =?utf-8?B?eG9wbHdSMXVtSi9WQ21CcUdEN0lYMmU0OHJ0OXErYk94djU5V2dIbWxtaHNr?=
 =?utf-8?B?QnJsNnlFT05wVnFwVFFwSlA5KzIzL25sNVI2ckQ3eGFpYkFkME5DTlhBZGZ1?=
 =?utf-8?B?U2cxMHpPb2J1Vi8rZkhwK0dsV3pIbmppaXRqQlB4U1FlM1lXNnZEbzlEMU1q?=
 =?utf-8?B?c051MHd5UEphWXNncWlMZ3dLb3ZMQW1GTlJiZmd0SnpqcFBDd2x2OHdRd0xl?=
 =?utf-8?B?alIvQmpXMjhXalJaNGtHYlRWaHZtdmxDV3RIbUNqcFZjU2E3RkNRYXp2MXRn?=
 =?utf-8?B?WTFnZDdIVVlIcDE0eDVKZGtRQ3hEZXkxTUhOSFpib3p3eWg4ZjcvQXI0Tk5L?=
 =?utf-8?B?Zk1TSFRtd1BSSk5pUGRYNCtCSXNMZ05Mb0xHelpvMFNHU3JpT25XTytlNFgv?=
 =?utf-8?B?MDN6K0VPUk9ia3pidFk5VFVIQUNNSXpzMEU1dzNtMU5PeGtlMEh6L3NkSVQ4?=
 =?utf-8?B?RzVkTXJHTWxrVko0Q0p6UU5jNW55d2xwai91NTlBVGJiOStDamw0L3h5aHVE?=
 =?utf-8?B?TVQ4SjVvenluYy9HTG1BWW93SGV5U1JRVEJFekcrZjNCSGc3Nnlic2ZvZXJv?=
 =?utf-8?B?RGJGVnFDQ1oxUTYycmc1RWxKVjJiMUVZano2RWs3ZVV4RnVJTU5nYmFsc1A4?=
 =?utf-8?B?VFhsdTFQVnJMb2tHNDZyYlNRckZlcXU0MUQrdmxmeHlVejZ2Tkl0bmFIRU4r?=
 =?utf-8?B?ZDY1VDhPNG9OVjhHZWFLWTFJUXpXaCsyWHpBQ1E1eEtyWEk3Y0IraGVadzYv?=
 =?utf-8?B?YjVuVElONmIvenFVTW5NTEpsZzJCbWloSUNCSkJNbmowdDZ3Qjg0ak5DZEkz?=
 =?utf-8?B?aFNsL2J0YTBiU2c4VDVvZFlFUWpDNlc5QmlLTzdIV3hhMEZaeXpjRnhmOUs0?=
 =?utf-8?B?WjdKQjZhMzRncFhOekx3cGIyVXRQeVhMNHJJaHBOcDB2UGFLdk4rek1TVFZF?=
 =?utf-8?B?NEpzc2hvajJ2NUNHRmFPUDMxMGg0QWQ5N0pBTW44dHI5ZVE2UXFKNVFvOTla?=
 =?utf-8?B?VDN4OXliUk96SDdGS0dEem9sdUdXWjg5ckFHZUhyM21qR0tXYVkraEQveHV4?=
 =?utf-8?B?MHcwRmxBbkVLN3lIeURxZ1JuZktSbUcwWms2U3BwV1RpNFpPZkxQV3R4Rlc1?=
 =?utf-8?B?bjFlcWZENzFMRU82ME9Nc1p6UkdVWEExYjFMYTJkZmRvZ3gyOFBWbitTbHZY?=
 =?utf-8?B?SFMwQzVEaE40b0dQUldqaVlMTTJUcnNPa0U2K2FtQ09wdDJodXUxWkFVSVIr?=
 =?utf-8?B?dTR1WXZidHZKVlV3OGM4Qjg2ZzQ2TG10M0twV21EWU9iTngvekVOVkxJc0Z1?=
 =?utf-8?B?cEJRRmVEN1REb0lMQktZWFVucW90WUVXNG1TbFhta29FSDlxbko1WXc2eC9H?=
 =?utf-8?Q?um450GRJnpx5L2ohCRl0WkPDe?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11a9379d-196d-425b-a386-08dc5d84d854
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 19:47:12.6950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CCyIViGVFxoFT4h+jkygE7+Ah66TVgCqke5CJD3Llw7n5ZhzBf9pQFJeNEinm0YQegVQ5qEEuLgRS6ofL6iw7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7290

Add sai[0,1,6,7], wm8960 and asrc0 support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 140 +++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 5c6b39c6933fc..9dd84126493ef 100644
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
+	wm8960: wm8960@1a {
+		compatible = "wlf,wm8960";
+		reg = <0x1a>;
+		clocks = <&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		clock-names = "mclk";
+		wlf,shared-lrclk;
+		wlf,hp-cfg = <2 2 3>;
+		wlf,gpio-cfg = <1 3>;
+		assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_SLV_BUS>,
+				<&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_MST_BUS>,
+				<&mclkout0_lpcg IMX_LPCG_CLK_0>;
+		assigned-clock-rates = <786432000>, <49152000>, <12288000>, <12288000>;
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


