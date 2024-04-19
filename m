Return-Path: <linux-kernel+bounces-150962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0FA78AA731
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201031C20D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF543D515;
	Fri, 19 Apr 2024 03:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mgV9vpWq"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB5722301;
	Fri, 19 Apr 2024 03:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497390; cv=fail; b=D5KV6g4EyksuOa1y/kQCH3Nku6AM9xuxB97B+PW2mb9kigTiA5OS1lM1o6+zX3gRKfJFyzq0VRkctfB8CfT+qXvN+ZTLtb6zkXsT/tD9BsIennf4E04aueuwCWXvR4eEwYxcRD6DLDYYJKZcsSkVUcqWsnbOE5hIRKT2+gsL5Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497390; c=relaxed/simple;
	bh=G5KiBP2fYGV57i4N6Iy2S/SHJ5StjpqTeJPC2rBgcTQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sUk8+UBahyLD8jvvgYThfUftsiBPMWFvQsyPfMHYjWJhsPm4dDBXddrTPKhB7V/98BV/R7nUBeueNE9Sc4lMbB6Sr2UFK7Y9zjF4jmjrWuKTAfEJ/Ikmt00hBQwZYPztGJKUoUY1GS8A+Hm1j5Yr6Of3YleJhSlUeKdiEBHRZjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mgV9vpWq; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQdgwxiqaHs6XJvOdZtKR96ksj7QHY4xp/Xl8NqSb5WIaAZJ4kQg76gxmyaO9tZbnOryPmzRa2m4WKCxDy5VQe/LsSI4ROKsp38iSTUsO7uQ8EDQpUXl4hdxlzru/aGBsVxtqHrweqOn/UDUHtAPgG+lrnzvOQgMcCw7HNePe+UQyMioj8gV9Q7y0Bw2VveBKiH2VCl4e6DyBTht6fEZGpkh38YZPaWW1q7mlrZnfVu7XDGhgrTnslriUwq+d9Zi9K6NdtW4nONZw+XzUdLYInMS7Bwymvqxw0j9FGMTEoDgDiw6RYkNe2R8Z8FgFg5LXnhNx7EKnMKRntuuW96paA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Utj7ItaEHtvIsv0ZHYVfFXFu+fj+P2M3yxfR5i0ip94=;
 b=T66EnH1Rv877j4+s/dqAHBD+/IcKphtVj2sFOoecWmiRrajP4V0HiJhazjCgJfQ0I3AtOqFT7VB2Lf3D8m7DPbg29yCtnxXM2jX6LdWxO1jCrjUl2bHnsuZ8czamv6bzhIG8b7EEJyucu7uisDEje4Bo+sQiwbL6bAhMot0sJeJ9c1qdM2QhvzLiBsPWBJb1kyf4KVwNWJnZiI196I0WJ7X/knr7oiSdYeYiWgyt7FGw+n0AOiZRYlGPmnOQvA+PKvaIfzsKzVOR3ChKV2JXUeSmSkOoSm0YXaxA+imwW5C64VnIKjxvYlpv9USFU2O1mX8+biQFYsU5pQnhJTyrZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Utj7ItaEHtvIsv0ZHYVfFXFu+fj+P2M3yxfR5i0ip94=;
 b=mgV9vpWqbAdEwKfw9Lcu4fZFlLumCg+0N7QFI9zPBs3ktK1Q6fL6mZz/f51e7Wq4uwIA3hHgpLZ+u6zmc7+cd+aQRcBo9muvO6owSC65+CLDW+O+dY6M/kCDg9aPM8CvatgM+KhEA8YNWeOvFIWRGPkFN1e13yoOlUV4gvwRsA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:46 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:46 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:04 +0800
Subject: [PATCH v2 09/12] arm64: dts: imx93-11x11-evk: add different usdhc
 pinctrl for different timing usage
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-9-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>, 
 Haibo Chen <haibo.chen@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=4577;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=llEiY/5OnUc6shhi+Ccz28hv01yOemdhaRxTciJwC4k=;
 b=xZX59iOVXW+b/glp/r9LsjmXa+DnLTCDtcRz5WRkry4joMT/8pvzl7RQNZItPEWHLpOXdAX28
 80muOt8qY53Dv1bqJA99ncMYMwA/sKM3WOIl7qhxpIVPDvyo+jNjnXQ
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR02CA0025.apcprd02.prod.outlook.com
 (2603:1096:4:195::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8802:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a58b4e-3c66-48be-e434-08dc6020f608
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IqzRbTVZ+qHs1E2GtPi9dURk+W98qMZ66aDGU0vKd9YesXqIxrd7IYNtdVLy6xtToNYnNhhBUeqrUY2ztCpRWnq0Bw67yEMd3eKdwnFJ1AYzRE8Un20neX5aAAo2t/XLrweUt8G53LDq50sTuwhKjNEzBBqkTcxmSdHtZR7IaRY+sLTNX44jAXHx8PJywXpwVKH2Kb2LEO7PglbBDk0FpIi5wXjKNm4f5UeLhiUrS7YCUlRGQnzWnH5UQhdI0vYLuOf2i1K7kJDiA6EZVPQCBbOGPl2gBi2dVL2gdCYw2TkJjHpCUMYHicrOvghI9/3fDwbzh1M14wAJgM63xb7FZdG0mjuKcMOK6+dp8qkPwofYZJjVPfSa+eWlKn2UafYPzCrZfTT4yFFoEYaBDtZhLNGJXTgdSiNyzzUXZFozdf7eeG9ZBxE2Mlj5G6IJXzy6oKGARk3Jx3cTy1zYLeMzf5u8a8QEYBZwTia21Pa9++de/9jNFS2yCTJ1K6aJ31h8tkmE25RY0SQBSxWR79zBN14sAAAAxBS0nUJUoWpGsYQRZwyEXxfTna9aAXFC4mD5trQIOELPABY9xfvqz06iECoc73S6G0nJawwDZ6qjUMhofLR4EunPs9rmYot1ZiIarEAFTZVc3xAXKXMi+dR9Cmq8fXmfNFjA1gWMOxi0eYpg8sSTH2+Nd3tYEQFA+OBoYZmHOhonkWqLyi3nW2xEeu9QBAFEqiA4CJyhiqEupDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3A5bkE1eU1RRUdCQTdHcXQzOS9udGY5cFNhQXZqZ3cwRGU1aERweCsxaURk?=
 =?utf-8?B?RTEvQ0ZYWUZzV0NkN09zZ3lLZGNBTjg5OWtYbURqYW56eTRSRTJjYWxwbld1?=
 =?utf-8?B?cTFZMElQcDh2K091SUM2U3RsNlhZbWJ0UG1ZMHI0c1EzNVNzM1lZdDUyOXBM?=
 =?utf-8?B?SFV2K0ZRUkt0b2ZRQm94bXQxODlKeldKRHFWdEZqUU4zbERGcU5kRTNZY3FB?=
 =?utf-8?B?M3k3Ri96anFSMzF5YUtET2hUc2tUYzZPQ1UrNWgyNCtSRWtHalo5MmRxc3Ey?=
 =?utf-8?B?ZkNNeUNNQVl6WHJiYUlQQnlSV0Z1aEs5UzhNeWJxYTM2TWVVRkVhN2thVWxE?=
 =?utf-8?B?Z1FlU3Rvdmt5azRldjB3emduOHJGNlp5WU9NY0V2TGtIZklMd3M3YUNJcDcw?=
 =?utf-8?B?SjRrNTdVQkVnU1JFOFVkV1lOMnJGU3VRUnFhbU9SQXB1S2cxMU5qMCtiUEhw?=
 =?utf-8?B?OE81dWs3WFMzYzJmVkhEMkl6Rnk3bkZZaWNrWWRpRWZUdFFNbVloZmQvdVB0?=
 =?utf-8?B?K3lJTjNVcjJHU0J4K3JzdVZBM2F5dVhwaTJYazMzNmxCc1JaVjhETmFOaTN5?=
 =?utf-8?B?SUxPNThRSFJYeGtWYlppc2V0eFh1MXhNSHBnaGpNYnJPSU96REIrL20waTRW?=
 =?utf-8?B?ajV5OXlnWWJ4QU92Yy9ETjlmWUJITmkvU25UYXFjRHdZTFRadUVoYnZKSEVx?=
 =?utf-8?B?eW8xSkNIRzBBbDIxK0VzRUMvWldHZ0NMZjZFendBWE0veERTWnVzaU9Lcnd4?=
 =?utf-8?B?T0xZSlk2NlVxNTcwTnNXV3g3b0xwamhKMVcvT3A5TENJM0s4ZmNZbzc5MjVT?=
 =?utf-8?B?NUxkS3diU0VoTlp3ZDF3NkVHdExiWi9md1hDSWphdGF3Tmh4NkdwVFJEK1Vp?=
 =?utf-8?B?WVNzS0IraTRKV2wvb2M0QUhhbWlTWFY4RnlKNWl2MEFWbTFJTGhycVV3Q01j?=
 =?utf-8?B?VG5pMXdiQXJ0cEN1OXJoc3hlTk1IUVhaTlhXNmIrakY4MkFHWmt5UHdVR3ZM?=
 =?utf-8?B?UTYva0QzQ1pleU9qbWdpZ1pCS2dqZitCd0lKdzdibU1QSjNYV0xHOFF0ejdW?=
 =?utf-8?B?a0RjYWxUK3NtQ052SzVjNnFXZTdENWFRUTFhQ1J1cm5kS3c4T1NSYXlubEp4?=
 =?utf-8?B?RnNaK0c1dU93QnVhK0prV1R2OVBPV1RVUldkQWpINERnRVBsc0tyMVVYQU9q?=
 =?utf-8?B?WUFiUDl4MTZWNm5FZ29GaTVFUTQ3UUJXSGdaeTgwcUJCK3lEcTJwRlVucWRF?=
 =?utf-8?B?c2R4Z2hBeEJYeTV5b3ltdE4zc0lZNG9FdHJySmlKRmZaOVV6QTB4UXVTOUJo?=
 =?utf-8?B?V2tTYUU1a2wrNFFZT1V3SUJHbWUzK3lBeHBxYVhpc3lOWnFCcksvK3hpNFdu?=
 =?utf-8?B?S3JMdVRiUGs0bEh5S3IxRlBmdDk2TWJDOVhHdUdHZEVURUJYdVZnUmxOYjRV?=
 =?utf-8?B?MzM0b056OUx4TkFvOHIxdjh1SHhwdi9ZNncwdmIvRzhQV0QveWhpMndPdmt6?=
 =?utf-8?B?Y1lMUXBkM3JjMlNoOU00Rk8rR0FZcHVnc1dSMk1MM1pMd1VqNHpjaHg1RXJE?=
 =?utf-8?B?QTdTOEl3UHRrSytNY1EyQ1FySlBYaWdCclpKcUp0UlB6TDVlYmNQMEhibFR6?=
 =?utf-8?B?cDNLdHJESDF6LzgxZGtuQis5clVmWnlrRGdyRXZTSzFHSUUrdTZyeUlLcFhs?=
 =?utf-8?B?V2ZoeCtwTHV1c0xmM0F6ZEdFcmpiUkd4K2xFamZ3MFRvOVVYOXlxSy9EaHg5?=
 =?utf-8?B?QllQUXZMcmw2REJFZFV6cTVaZEI3K1AvTFptSllsVWFTdFNHaSszQlRxMmQ2?=
 =?utf-8?B?WlJYWTIvbEhRZ0Uyem0wdG1uQXZCeVpaQld4M3lBY204VDFnbmlqcUdYT2xD?=
 =?utf-8?B?bGhMdjFHbmJUc0p0cW9zY2pheFFHQXhCN3JpbGhXZzI3bkRTLzhDWEcvRmFB?=
 =?utf-8?B?bVNyZDIvbndQUUlkMWdsOHF3S0t0SjRPR3JGVTBRV2tXQTNLT1dkUDRSUkIr?=
 =?utf-8?B?VVR3bnJFOFdCaVZpdFdocWlsZWZBMGVQVS95QWN3azNkNytBNTJYcng4RjVx?=
 =?utf-8?B?QitqKzBDOHh6b1FSOGROTjFLRnNiYVQxNVErYzFtVm52Z1hkbXp6c1N6TjB6?=
 =?utf-8?Q?d0O5LcHI+1oaoBB+pyXTQxqlX?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a58b4e-3c66-48be-e434-08dc6020f608
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:46.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RIUCpTr3/wgYRYkexxY2E/stTSrgTH6ePIZI58a0c4SGCauO/N5M2/Kf2BrYZr84ZuXo2C8TXkDuXjxZoVfL0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Luke Wang <ziniu.wang_1@nxp.com>

imx93-11x11-evk dts use the strongest driver strength for
default(high-speed), 100MHz(SDR50/DDR50/DDR52) and
200MHz(SDR104/HS200/HS400) timing. To make usdhc working appropriately for
each timing, add X1 drive strength to default timing and X3 drive
strength to 100MHz timing.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts | 68 +++++++++++++++++++++--
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 2b67724db685..f848cb0922ef 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -161,8 +161,8 @@ &lpuart5 {
 &usdhc1 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc1>;
-	pinctrl-1 = <&pinctrl_usdhc1>;
-	pinctrl-2 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
 	bus-width = <8>;
 	non-removable;
 	status = "okay";
@@ -171,8 +171,8 @@ &usdhc1 {
 &usdhc2 {
 	pinctrl-names = "default", "state_100mhz", "state_200mhz";
 	pinctrl-0 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-1 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
-	pinctrl-2 = <&pinctrl_usdhc2>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-1 = <&pinctrl_usdhc2_100mhz>, <&pinctrl_usdhc2_gpio>;
+	pinctrl-2 = <&pinctrl_usdhc2_200mhz>, <&pinctrl_usdhc2_gpio>;
 	cd-gpios = <&gpio3 00 GPIO_ACTIVE_LOW>;
 	vmmc-supply = <&reg_usdhc2_vmmc>;
 	bus-width = <4>;
@@ -391,6 +391,40 @@ MX93_PAD_CCM_CLKO2__GPIO3_IO27			0x31e
 
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc1: usdhc1grp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x1582
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x40001382
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x40001382
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x40001382
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x40001382
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x40001382
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x40001382
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x40001382
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x40001382
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x40001382
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x1582
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_100mhz: usdhc1-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD1_CLK__USDHC1_CLK		0x158e
+			MX93_PAD_SD1_CMD__USDHC1_CMD		0x4000138e
+			MX93_PAD_SD1_DATA0__USDHC1_DATA0	0x4000138e
+			MX93_PAD_SD1_DATA1__USDHC1_DATA1	0x4000138e
+			MX93_PAD_SD1_DATA2__USDHC1_DATA2	0x4000138e
+			MX93_PAD_SD1_DATA3__USDHC1_DATA3	0x4000138e
+			MX93_PAD_SD1_DATA4__USDHC1_DATA4	0x4000138e
+			MX93_PAD_SD1_DATA5__USDHC1_DATA5	0x4000138e
+			MX93_PAD_SD1_DATA6__USDHC1_DATA6	0x4000138e
+			MX93_PAD_SD1_DATA7__USDHC1_DATA7	0x4000138e
+			MX93_PAD_SD1_STROBE__USDHC1_STROBE	0x158e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc1_200mhz: usdhc1-200mhzgrp {
 		fsl,pins = <
 			MX93_PAD_SD1_CLK__USDHC1_CLK		0x15fe
 			MX93_PAD_SD1_CMD__USDHC1_CMD		0x400013fe
@@ -420,6 +454,32 @@ MX93_PAD_SD2_CD_B__GPIO3_IO00		0x31e
 
 	/* need to config the SION for data and cmd pad, refer to ERR052021 */
 	pinctrl_usdhc2: usdhc2grp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x1582
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x40001382
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x40001382
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x40001382
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x40001382
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x40001382
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_100mhz: usdhc2-100mhzgrp {
+		fsl,pins = <
+			MX93_PAD_SD2_CLK__USDHC2_CLK		0x158e
+			MX93_PAD_SD2_CMD__USDHC2_CMD		0x4000138e
+			MX93_PAD_SD2_DATA0__USDHC2_DATA0	0x4000138e
+			MX93_PAD_SD2_DATA1__USDHC2_DATA1	0x4000138e
+			MX93_PAD_SD2_DATA2__USDHC2_DATA2	0x4000138e
+			MX93_PAD_SD2_DATA3__USDHC2_DATA3	0x4000138e
+			MX93_PAD_SD2_VSELECT__USDHC2_VSELECT	0x51e
+		>;
+	};
+
+	/* need to config the SION for data and cmd pad, refer to ERR052021 */
+	pinctrl_usdhc2_200mhz: usdhc2-200mhzgrp {
 		fsl,pins = <
 			MX93_PAD_SD2_CLK__USDHC2_CLK		0x15fe
 			MX93_PAD_SD2_CMD__USDHC2_CMD		0x400013fe

-- 
2.37.1


