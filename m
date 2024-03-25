Return-Path: <linux-kernel+bounces-117245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C08E88A90D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E3CD1C621A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFFB1581E5;
	Mon, 25 Mar 2024 14:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="QmP3n8l+"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2121.outbound.protection.outlook.com [40.107.13.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23F7157A52;
	Mon, 25 Mar 2024 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711376590; cv=fail; b=QhORttSFR0jT8dsfIlAVj+X7lT1eXkENv6TNR9d/ojffPxvL5NrwcOYBWXCqDvdybY4+3y5jNZLxaiH6RT6HW5gUm3CcBGLt1e6T46i59jhsq0batxBJwKh+HGMHKkSt3ifgavOZxkV+H6xXSaUSyr+pdMnnmGq/wx+/q1gGFHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711376590; c=relaxed/simple;
	bh=lUbkhNbsay9TZo8mYnLZCVe94hy+LymooW6LliQ+/js=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ghdp5qdwj1dD4b7Y2GGvi/NO2qGP3PAT+8zwYIPZm+MTPbust9WZu9A49Do442JLBHhTm9ieSfi2Xb3bn8/Glgnkv3jpcJB0PBSCOPY1XNvfEjyLhbL094arJaEMF5unC+IAfMA9cNyLQoYa53+5PaX7VAjf1w1ZNlkz06o/k+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=QmP3n8l+; arc=fail smtp.client-ip=40.107.13.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WS+8gtLieMHPx8EeNzaVO2efsuGmxOMyI+4VKlPqvbTieB/lOrIPHF3GVzI1FvbsXeuFj8bbZVKmQ7/EF3nIzk2anKrldZLoN3EQ8Wa/Zl6DwV5rAKRD7siN7teT9x6x3vJLKi2CGF+VmeVNviZj3J5EVHYEJovQd6PaqauTTw146gOz+plLhq180MFXq4MNEhXoXphZgdo/QDDorPojQKc816DHOyQHB98BBrLXvOUSl8rdQmCjdokLRnfaw5Lo3utdCZRehj+nlIen+HGxojnJ298SX8KJMzX8LZe84pUBAMRsMe1OHGjvkGQYuibHMtDgKNrrSHCK7TjdweNBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jAbps8oncDARBHdD5xJiRQfPLqDkWGPxLBgvBWO7Vwk=;
 b=C9TNjVvHobCW4vhgHWFPp2dx3vCQ4K2VrvFYPdC8vOA8JIJ0eY3v1rAZMgrPAOUqkMxYGHmGhAOlxBrPLkrU49JDZlPRVMLDJWx3NhnZI0xS0CjhIm6z8I6vNHBgYkZBQkN+dzdG8S7lGcTcIFdnvylQEDPpnj8lhnnmmH+lULHi2TFGaXT/TJMxD/xBGOGiOaQ6lCVnfYPaiv/6Bf/mBFaFBPOUeEA4KZu7QCKEu7dFtMth3430/Y3Scf6dd8xgeavkIaDy2EotMuLKiVXDbvIZmy054EoVfGRzO1g5S2ttiWC6sXYmok7RiBm4wIqXtg9bMV4Nwb1M/hJ8k8iCxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jAbps8oncDARBHdD5xJiRQfPLqDkWGPxLBgvBWO7Vwk=;
 b=QmP3n8l+G99QUGVftfx3Gb5e2HpGbOZn5ukg1TIfiXTBMqAKDrj0LbQ9nLKtNMsiIpaIqMDkuW/tbqMMfLso0q3qgqDWKDAgPNE0K8l/FwGd7pQnHRL/V2aUdAjokd2MF9aBi96f8cpFxuNV29EUH9fsuGD2MK+BHZGaJfDVG8M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by GV1PR08MB7731.eurprd08.prod.outlook.com (2603:10a6:150:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Mon, 25 Mar
 2024 14:22:58 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9%5]) with mapi id 15.20.7409.026; Mon, 25 Mar 2024
 14:22:58 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Mon, 25 Mar 2024 15:22:33 +0100
Subject: [PATCH 3/4] arm64: dts: rockchip: add wolfvision pf5 mainboard
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-feature-wolfvision-pf5-v1-3-5725445f792a@wolfvision.net>
References: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
In-Reply-To: <20240325-feature-wolfvision-pf5-v1-0-5725445f792a@wolfvision.net>
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711376575; l=13620;
 i=michael.riesch@wolfvision.net; s=20240305; h=from:subject:message-id;
 bh=lUbkhNbsay9TZo8mYnLZCVe94hy+LymooW6LliQ+/js=;
 b=Nr/+NxtoipdQUw8WAEEogOA4jpUAuG64h4AyW0nXeiF+kqNI1R5dHAurf+beo6Tr+8t9ufMjG
 H0VoyczvzUMCBKt7X4lE9raHre96+5swPhB4qluK0BB6n7w8gdDI46p
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=vXktx+l75RJD3KAojVKL7503UCD9nnGRcgujrB9SRp4=
X-ClientProxiedBy: VI1PR06CA0127.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::20) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|GV1PR08MB7731:EE_
X-MS-Office365-Filtering-Correlation-Id: dc4a707f-3d3c-49bf-27c8-08dc4cd71179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yN9ETMkkIU7j4uWJ+jE/8iouiQkFs4ZZCxqkNfTLBIHBqy9g8z14c5YiBFAyUKRZv5Nr0uD0jHgKq5eKmlKsf8Cg1KqO0QnR6d1w74y2Q9Hks952FE9ov6PwXa6pg2LMo/GEgZo/8CTl+4rzZwXaJ9fVN1DVHBZpYBk8v1+IEUi+mvx3Ovyr2ikkkneF5pgf/FnldGayxCsK8FLlyolSR1bi9W9P3tZx3ShBlwyCWNjG3nHIUnOZk6dYZC1hjw8FuoqbrmQS01xg1tkZ6H/yzW3CqGwDWT8FEYramrJGmAs3yAkMAePySW47K9e0UT6liQ+pNYND/AB0bmsiKGWNLPCcZDEmCIUUNIZUPUTlrY2jxOTxIUarJrZ1PQBO4T8SpvjekVkAhycFdDtsLQzxnMJkFAl0+/cNUtTzIY2eArzoRWHz3wTEc9Tci2ETP1TnMizmmTYbCrVQ19WpXBcs7gUpfmV1a1n0UkPWHo2inNEpTmu2Y//Yi91ZzOVgPZxHoaYAIFgj7MUkmfHlZxtalAtEzoIFeJ+T9y+H6mMC3/m2utdB5ngvUOV4FdKi84BDp48yrZ5F2wXb0Wj0kmxD3nZOWK0oMXImQhMBUvVIHSIxPxpqaPWFTF6dC/G5txmSmUAMHTA8j4aohazj3qx1BP1Nn/e1lbD9EuX6OekfO/MekOxatfDhPH0ma6+BNdgN5WKejcxaQBKMQQS85DXp8H6/TGve9a9783o5UVPKM38=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGN2ZzZDUS9RMmZGeGVxeFVtUnFxaWY1dlBDSDRWbitPRng0OWdCMnhKVWlL?=
 =?utf-8?B?c2dRY3JHenFZdXJQWXFxKzVKK1cyUFh2c2NhMmF1ZllldWlOUjhkL1dEYUhC?=
 =?utf-8?B?VVRxaUQzRGswZWhYSTJSaVBnV0o2a3kzN2MxU1RnOERuZ2hCUXNISFFCV1dx?=
 =?utf-8?B?UFRRQlVDdzZSV0JtamtUTWpGb3o1Q05SRDJyc3dnV2JJZDg4V3FIMHlKOVk3?=
 =?utf-8?B?K3I5Ym5GNmYxdzZaQXZsaTV2aGtMTHJJNDNXdEUydnBWeS9sUVlpdjZ5TFlR?=
 =?utf-8?B?c0pLT0NEdjByS3hmbUVLSTdiYTlVWStWOUlHRFBoTFhJcnBzYXljMzN0cFZ5?=
 =?utf-8?B?YU43b1NSREY5OU1nKzVzSy92MXRTQTlSTGQwL1lEOGNBREI5S0xHY1FoeGpI?=
 =?utf-8?B?Rkx1OUZNeDV1ZTVnSWZINHllV1p5TWdMUEVPaXV2cFZWeS9LUU1VR3dMeEts?=
 =?utf-8?B?U3dHcU83aFY5NUlxbC84QWMxSXdUd0VnY01kaVVTdTU5WG8xWDQ1eHVZS2Jl?=
 =?utf-8?B?TlZDa2U4Njh4bi84cEg2bmxWYlFvZks2MUh1ODJvM0QySjk2aDZtN0pWOHY0?=
 =?utf-8?B?NjV5OW1acTQyc0xYZi9hOVlKTnhqNW1lRlZGWi93OW56T1Q0bVozbFNmbFZZ?=
 =?utf-8?B?cEhCWlY0LzZDUGsxU1p0LytBbkxDSmlBR1gyZGZWY01aVlJHN3g1R01IZnhl?=
 =?utf-8?B?QURraHVQd1B6WnNhR2hFc2JSaFpuWHhQTzF4RlVERURrUitYTmVveS9jaUNi?=
 =?utf-8?B?aFBLVnpRSWsrUXIxQzdQdVVwTG9aaE5meGN6UU94SzgrZUpORWVTZTlaamw2?=
 =?utf-8?B?QWlkZkRIV212ZDZNbmtjakZGKzVOZU1uZzJMVDViQkNKVnB2MmtHeGQ5ZEJm?=
 =?utf-8?B?RmVuRVpYNmZ4ZkN4MEdaOUpJWVFqMmJnZndRTlZBdWRCRFVYM3FkZ09PWDJz?=
 =?utf-8?B?MEJrNUdkeGE0VERHNFBCQmN1UlZiUkJkTE10cmJXRDZsbmF5NkZ5TUxmNUxx?=
 =?utf-8?B?SDJuTnhnbUZjM1o0TjRlUFRzMk5FaS9MbHBOTlVqcjQ2WDhqSTBWOUtMWU1j?=
 =?utf-8?B?NmNWTkpmZFNpdWpoWEZORnhyU2F1WFhEcmZIL1B0M0dXSGJxMjNaRXBSa2JU?=
 =?utf-8?B?ODY0SlFYbDdRcHpWZmFFWEk4NEMyRi9za2lkVzVYRmI5MnJWeVpkOW4va0JB?=
 =?utf-8?B?TXFZY1FGQ3FxcVY3aHI4Nk5LSVlSNHQ0RS9iQUpZdlRBSjNEeHJIMjNEeDlX?=
 =?utf-8?B?SkF6dmhpYkY1NjJydzIxUWdXYjBvWXMvWUhZOWdGeVQrOHhGc3hGWHNJb2l6?=
 =?utf-8?B?QnduZEIvK0ZiZzZDU2ZhVWxKWDBHVVFwQmNOMEZPRy84Z1pNc3ROaHhSUmpR?=
 =?utf-8?B?NStRMUc5eUFlTmljNUVpdE55amh0NG9HbW1MZ09NaC9QNlBDZG53b3M2emI3?=
 =?utf-8?B?djlSUGsrWVpGUHNpTVc0b2d6UE5acy9PaFVPeW5mUkJ5N2MwSkVqYnMzZ01T?=
 =?utf-8?B?SUVjbXFmcVNmRnQvRVB2S0NBRktYWVFRUW9kaW1ja2gxL1ZIa3VDN1gzSDFt?=
 =?utf-8?B?Zy9MS2k3ZGVFY29FanIyK09CUWFuR29JNlFRbm43OHg5UlNlTnZ0K2ZYYUNs?=
 =?utf-8?B?cDJQV1gyOXF0K3Jma2N0YjdCMWVCMGg2aFVxVkRKaUY2UVJ3dll2RXZXOTlp?=
 =?utf-8?B?L3lHWldRbmpibUJ6L2JiSWdYYkF4WjNsVGNhQm9Fb0x5c3RFTGN3NzJGZlUr?=
 =?utf-8?B?R2k2S0Zsc0J2VHRmOTZ2UWRyaXJQcW85N043YjF5TEIzL0ZEWHpkTXU5Umsw?=
 =?utf-8?B?UGtXaUJRUzA1eURjMk5ucDdQOUtrZlVTTWdsc09aTVFGbysvd1FQMGdNWHJ1?=
 =?utf-8?B?bE5qZm9iZGlVNktCQ3I0L2VVRjVpaEl3MlloaFE1MjFtNVZPbENCVjFCTmlD?=
 =?utf-8?B?cmJzY0JBdGhiSUNMdGR5YUtqc3JZbVNOWjhwVm5hSHNsZk9mcFZhT1M2NDhI?=
 =?utf-8?B?bHRNNUlIT01qRzN3L2RkK3RuR3NON0lRdGpUbjFnbDI5akJIUUxOalFHNy9M?=
 =?utf-8?B?NkloNWhaTllBN3lqOFEySGsvekF0YjdWSUc4em5DK1pBaWZiMVBScm80czVF?=
 =?utf-8?B?bjM1WHdWeDN4YjdKTWNlUFpZM2pFcUlYYUgyNXUwUENiZE5WcVJqaUJ4bnh5?=
 =?utf-8?B?K3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: dc4a707f-3d3c-49bf-27c8-08dc4cd71179
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 14:22:57.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDHjvBWiLlLQXjTOT6AqWh6VcV7gFxVtuEphVdVZEa8I9mXgSWDPOfJ2uEOammDzLAYSbqQyx06ngY2gxfr+ibI0cL7Vn5r1a4WU4tGpHG4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7731

Add device tree for the WolfVision PF5 mainboard. It features
 - Rockchip RK3568 SoC
 - eMMC
 - RTC with backup battery
 - on-board PDM microphone
 - 12V DC jack
 - HDMI output
 - USB-C device port
as well as various expansion headers for different extension boards.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../boot/dts/rockchip/rk3568-wolfvision-pf5.dts    | 528 +++++++++++++++++++++
 2 files changed, 529 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index f906a868b71a..8fb35a363e4f 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -107,6 +107,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts433.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-radxa-e25.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-wifi.dtbo
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
new file mode 100644
index 000000000000..a814749eaa97
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5.dts
@@ -0,0 +1,528 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Device tree for the WolfVision PF5 mainboard.
+ *
+ * Copyright (C) 2024 WolfVision GmbH.
+ */
+
+/dts-v1/;
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/regulator/ti,tps62864.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+#include "rk3568.dtsi"
+
+/ {
+	model = "WolfVision PF5";
+	compatible = "wolfvision,rk3568-pf5", "rockchip,rk3568";
+
+	aliases {
+		ethernet0 = &gmac0;
+		mmc0 = &sdhci;
+		rtc0 = &pcf85623;
+		rtc1 = &rk809;
+	};
+
+	chosen: chosen {
+		stdout-path = "serial2:115200n8";
+	};
+
+	hdmi_tx: hdmi-tx-connector {
+		compatible = "hdmi-connector";
+		hdmi-pwr-supply = <&hdmi_tx_5v>;
+		type = "a";
+
+		port {
+			hdmi_tx_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
+	hdmi_tx_5v: hdmi-tx-5v-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio4 RK_PC5 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&hdmi_tx_5v_en>;
+		regulator-name = "hdmi_tx_5v";
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc5v_in>;
+	};
+
+	pdm_codec: pdm-codec {
+		compatible = "dmic-codec";
+		num-channels = <1>;
+		#sound-dai-cells = <0>;
+	};
+
+	pdm_sound: pdm-sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "microphone";
+
+		simple-audio-card,cpu {
+			sound-dai = <&pdm>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&pdm_codec>;
+		};
+	};
+
+	vcc12v_in: vcc12v-in-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "12v_in";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
+	vcc12v_cam: vcc12v-cam-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio2 RK_PD1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc12v_cam_en>;
+		regulator-name = "12v_cam";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		vin-supply = <&vcc12v_in>;
+	};
+
+	vcc5v_in: vcc5v-in-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "5v_in";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		vin-supply = <&vcc12v_in>;
+	};
+
+	vcc3v8_cam: vcc3v8-cam-regulator {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&gpio0 RK_PC3 GPIO_ACTIVE_HIGH>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&vcc3v8_cam_en>;
+		regulator-name = "3v8_cam";
+		regulator-min-microvolt = <3800000>;
+		regulator-max-microvolt = <3800000>;
+		vin-supply = <&vcc5v_in>;
+	};
+
+	vcc3v3_sys: vcc3v3-sys-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3v3_sys";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc5v_in>;
+	};
+};
+
+&combphy0 {
+	status = "okay";
+};
+
+&cpu0 {
+	cpu-supply = <&vcc0v9_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vcc0v9_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vcc0v9_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vcc0v9_cpu>;
+};
+
+&gpu {
+	mali-supply = <&vcc0v9_gpu>;
+	status = "okay";
+};
+
+&hdmi {
+	avdd-0v9-supply = <&vcc0v9a_image>;
+	avdd-1v8-supply = <&vcc1v8a_image>;
+	status = "okay";
+};
+
+&hdmi_in {
+	hdmi_in_vp0: endpoint {
+		remote-endpoint = <&vp0_out_hdmi>;
+	};
+};
+
+&hdmi_out {
+	hdmi_tx_out: endpoint {
+		remote-endpoint = <&hdmi_tx_in>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+
+	rk809: pmic@20 {
+		compatible = "rockchip,rk809";
+		reg = <0x20>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PA3 IRQ_TYPE_LEVEL_LOW>;
+		#clock-cells = <0>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pmic_int_l>;
+		rockchip,system-power-controller;
+		vcc1-supply = <&vcc5v_in>;
+		vcc2-supply = <&vcc5v_in>;
+		vcc3-supply = <&vcc5v_in>;
+		vcc4-supply = <&vcc5v_in>;
+		vcc5-supply = <&vcc3v3_sys>;
+		vcc6-supply = <&vcc5v_in>;
+		vcc7-supply = <&vcc3v3_sys>;
+		vcc8-supply = <&vcc3v3_sys>;
+		vcc9-supply = <&vcc3v3_sys>;
+		wakeup-source;
+
+		regulators {
+			vcc0v9_logic: DCDC_REG1 {
+				regulator-name = "0v9_logic";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc0v9_gpu: DCDC_REG2 {
+				regulator-name = "0v9_gpu";
+				regulator-always-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <500000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v1_ddr4: DCDC_REG3 {
+				regulator-name = "1v1_ddr4";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <0x2>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+				};
+			};
+
+			vcc0v9_npu: DCDC_REG4 {
+				regulator-name = "0v9_npu";
+				regulator-always-on;
+				regulator-initial-mode = <0x2>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1350000>;
+				regulator-ramp-delay = <6001>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v8: DCDC_REG5 {
+				regulator-name = "1v8";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc0v9a_image: LDO_REG1 {
+				regulator-name = "0v9a_image";
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc0v9a: LDO_REG2 {
+				regulator-name = "0v9a";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc0v9a_pmu: LDO_REG3 {
+				regulator-name = "0v9a_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <900000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <900000>;
+				};
+			};
+
+			vcc3v3_acodec: LDO_REG4 {
+				regulator-name = "3v3_acodec";
+				regulator-always-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sd: LDO_REG5 {
+				regulator-name = "3v3_sd";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_pmu: LDO_REG6 {
+				regulator-name = "3v3_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <3300000>;
+				};
+			};
+
+			vcc1v8a: LDO_REG7 {
+				regulator-name = "1v8a";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc1v8a_pmu: LDO_REG8 {
+				regulator-name = "1v8a_pmu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-on-in-suspend;
+					regulator-suspend-microvolt = <1800000>;
+				};
+			};
+
+			vcc1v8a_image: LDO_REG9 {
+				regulator-name = "1v8a_image";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <1800000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+
+			vcc3v3_sw: SWITCH_REG1 {
+				regulator-name = "3v3_sw";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-min-microvolt = <3300000>;
+				regulator-max-microvolt = <3300000>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+
+	regulator@42 {
+		compatible = "ti,tps62869";
+		reg = <0x42>;
+
+		regulators {
+			vcc0v9_cpu: SW {
+				regulator-name = "0v9_cpu";
+				regulator-always-on;
+				regulator-boot-on;
+				regulator-initial-mode = <TPS62864_MODE_FPWM>;
+				regulator-min-microvolt = <900000>;
+				regulator-max-microvolt = <1150000>;
+				vin-supply = <&vcc5v_in>;
+
+				regulator-state-mem {
+					regulator-off-in-suspend;
+				};
+			};
+		};
+	};
+
+	pcf85623: rtc@51 {
+		compatible = "nxp,pcf85263";
+		reg = <0x51>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&clk32k_in>;
+		quartz-load-femtofarads = <12500>;
+	};
+};
+
+&i2c3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c3m0_xfer>;
+};
+
+&i2c4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c4m1_xfer>;
+};
+
+&pdm {
+	pinctrl-0 = <&pdmm0_clk
+		     &pdmm0_sdi0>;
+	status = "okay";
+};
+
+&pinctrl {
+	cam {
+		vcc12v_cam_en: vcc12v-cam-en-pinctrl {
+			rockchip,pins = <2 RK_PD1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		vcc3v8_cam_en: vcc3v8-cam-en-pinctrl {
+			rockchip,pins = <0 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	hdmitx {
+		hdmi_tx_5v_en: hdmi-tx-5v-en-pinctrl {
+			rockchip,pins = <4 RK_PC5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	pmic {
+		pmic_int_l: pmic-int-l-pinctrl {
+			rockchip,pins = <0 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+};
+
+&pmu_io_domains {
+	pmuio1-supply = <&vcc3v3_pmu>;
+	pmuio2-supply = <&vcc3v3_pmu>;
+	vccio1-supply = <&vcc3v3_acodec>;
+	vccio2-supply = <&vcc1v8>;
+	vccio3-supply = <&vcc3v3_sd>;
+	vccio4-supply = <&vcc1v8>;
+	vccio5-supply = <&vcc1v8>;
+	vccio6-supply = <&vcc3v3_sw>;
+	vccio7-supply = <&vcc3v3_sw>;
+	status = "okay";
+};
+
+&saradc {
+	vref-supply = <&vcc1v8a>;
+	status = "okay";
+};
+
+&sdhci {
+	bus-width = <8>;
+	max-frequency = <200000000>;
+	non-removable;
+	pinctrl-names = "default";
+	pinctrl-0 = <&emmc_bus8 &emmc_clk &emmc_cmd &emmc_datastrobe>;
+	vmmc-supply = <&vcc3v3_sw>;
+	vqmmc-supply = <&vcc1v8>;
+	status = "okay";
+};
+
+&tsadc {
+	rockchip,hw-tshut-mode = <1>;
+	rockchip,hw-tshut-polarity = <0>;
+	status = "okay";
+};
+
+&uart2 {
+	status = "okay";
+};
+
+&usb_host0_xhci {
+	dr_mode = "peripheral";
+	/* The following quirks are required since the bInterval is 1 and we
+	 * handle steady ISOC streaming. See Usecase 3 in commit 729dcffd1ed3
+	 * ("usb: dwc3: gadget: Add support for disabling U1 and U2 entries").
+	 */
+	snps,dis-u1-entry-quirk;
+	snps,dis-u2-entry-quirk;
+	/*
+	 * Without this quirk the available fifosize seems to be miscalculated
+	 * in cases where many endpoints are used. In one particular situation
+	 * 8 IN EPs and 3 OUT EPs where selected and lead to stalled transfers
+	 * without the resize quirk.
+	 */
+	tx-fifo-resize;
+
+	status = "okay";
+};
+
+&usb2phy0 {
+	status = "okay";
+};
+
+&usb2phy0_otg {
+	status = "okay";
+};
+
+&vop {
+	assigned-clocks = <&cru DCLK_VOP0>, <&cru DCLK_VOP2>;
+	assigned-clock-parents = <&pmucru PLL_HPLL>, <&cru PLL_VPLL>;
+	status = "okay";
+};
+
+&vop_mmu {
+	status = "okay";
+};
+
+&vp0 {
+	vp0_out_hdmi: endpoint@ROCKCHIP_VOP2_EP_HDMI0 {
+		reg = <ROCKCHIP_VOP2_EP_HDMI0>;
+		remote-endpoint = <&hdmi_in_vp0>;
+	};
+};

-- 
2.34.1


