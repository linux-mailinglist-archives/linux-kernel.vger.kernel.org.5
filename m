Return-Path: <linux-kernel+bounces-142670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7111F8A2E9A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935DA1C20ED4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33665A7AB;
	Fri, 12 Apr 2024 12:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="ordhXqKM"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2104.outbound.protection.outlook.com [40.107.6.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E159176;
	Fri, 12 Apr 2024 12:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712926460; cv=fail; b=HB49QR+AvbfKxepNqMXq2y4xDwoYYu5cziFLlli+TpsiejGR8VMGnr6LKGQLKbzE+fBk1uq1GgcMoDbgwPBDHE2WpqyG12x/+RvuDfrHm2M5BdvchlpW3ALvIe4pRwxbRGMCb6N2fNgRdoUzTa5WYjp5Jxetu1bno7cR9XPJQww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712926460; c=relaxed/simple;
	bh=YrpaBesaou38B//nLngO7Zwy7bzhFJy9Q5x9ECOQRKM=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=pQF/SzZtIjL4yMQBTICOrRcWyMP+32RWyMjPauMfqsack08uDzURvEn6pPRuwSb1Xc4xJSME5KNCIlEyNHv+rHCwahc/dAypteCd8swJYpTmj8NWXgplxn1PA3+qmLYPDSmWGASm4WFqE9Gsmsejr3cSmKgecXb8aPvTFc0k5kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=ordhXqKM; arc=fail smtp.client-ip=40.107.6.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXTpZr9N4QN88Sm5E1p4g+ChwsmfkbOIQOVfcqRhAYIEKKiC9tJ0Q0bd1WTLPQGjvvVXAdDVb6oB3S6JmNaHZMu9HL28ZHLLOBryW2adGH2zAHl92myDTFj2Zxah/WDNzgDAJSGekyG3Zi2xfBTsq8OxuMVAejc2054oeVOvbT69KTnJ8LUyAN+9sjLIe79n47JJo+LnuU0B7IBqp0stus2ydl56YCjn62CfyfYJQMxj65cdD1hgbiiYXrhU3WXF+llFjIe1c5mwYtpXDD/Ja+DQcekZdySKGIKTkmgygFrKhpFkcZdRfZn0uvla++Vyj9rJJ28hlpTYrEgeE1mFLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/1gcQX/leK6ekaFoTDv4LAsU4fL6vDa0jXW/D4stic=;
 b=cbdnWZ/lP4Bagzj1eZ/+Cy4Hb/GETbvc7ts7s63R2OGMirG2WO1f8xmItVNQ44u+/fqg3oMOwfE9k3If8yWMWzAwCFeOGAWCG3tZWXvYotEOfjWS3HWZN9GlBjQrvBzaalT1R3oIlPTALBLhRp6AraWBkxEI0fPj5UWSETIfwG7C/vdQAP3UuOF/iWTQEpkdPJBXWBRcO2Id8ghH1ltdf4pH89+SzQYr9WqkNtxg9JET8gAvtYoBMHvoNziKr7/w83kz9DoK6UlazsVJ+mGeY1xDaL9hvWAAa+FWkrIOiN97QnMqOmDb++cGptGjDNZKnp/7i13TO/gX0fI5ImP7ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/1gcQX/leK6ekaFoTDv4LAsU4fL6vDa0jXW/D4stic=;
 b=ordhXqKMnDjU7UqpDeGfUTXoPn9zQju/55MzlNvSXuVpxQe/CUZ/ukIzioI2n2ZoNUHlQ+GK/Na7LmK7CpWI2egDq/MKnZ7HQvLfLr+mOlXCtss/UZ6P34hnmjni6PQvdrh3/mrEG5n2PQNKIq3O2UVFgRa4zsDW/Wj92T6+qOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS2PR08MB9643.eurprd08.prod.outlook.com (2603:10a6:20b:608::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.49; Fri, 12 Apr
 2024 12:54:15 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::e86a:6893:ac7:dad9%5]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 12:54:15 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Fri, 12 Apr 2024 14:54:09 +0200
Subject: [PATCH] arm64: dts: rockchip: add wolfvision pf5 visualizer
 display
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-feature-wolfvision-pf5-display-v1-1-f032f32dba1a@wolfvision.net>
X-B4-Tracking: v=1; b=H4sIAPAuGWYC/yWNQQqDMBAAvyJ7dsHErYpfkR6C2a0LoiHRtiL+3
 dAeB4aZExJH5QR9cULktyZdlwymLGCc3PJiVJ8ZbGWpImNR2G17ZPyss/x1DPJArynM7sDW1OS
 JjDSdhxwJkUW/v8HwvK4bTrB0/XAAAAA=
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712926454; l=5645;
 i=michael.riesch@wolfvision.net; s=20240405; h=from:subject:message-id;
 bh=YrpaBesaou38B//nLngO7Zwy7bzhFJy9Q5x9ECOQRKM=;
 b=q6Z6Eb9T7boSG0h5IOc9ybH54ESnKhmSd1GTXzfqtnpHdRMs1PsszhLSwBkkgoiYMQbOnCRKH
 bfqMDQEs2pRBKCruMo5zFKFlfj2rB6SIVY0Kdjg/o1HpRD2MU2QLT3k
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=cSJmgKSH3B6kdCIDCl+IYDW1Pw/Ybc6g9rmnUd/G7Ck=
X-ClientProxiedBy: VI1PR09CA0142.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS2PR08MB9643:EE_
X-MS-Office365-Filtering-Correlation-Id: 481e4fa0-a4ba-4abf-e5d0-08dc5aefa897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lXojnNHFdseuSnZlwyoE+kEzeH9GDvUItFKzLveuzRc+54q12g1MJPxH04eTOUkP909ZzMraiqa18qJUHtZS02yUqV77lDAvCPYZ03su3JY6X5/RGyfurX27m7kpGuLRnfCbVKpxfBeR/7EbdJxgur+DVJ4VMY3B4TfH/lq60TLFWn+1Qi8yY4w7cREW3/tppPCfrpS3GAh+kptJbjrOMc5Dj0ldJtl6BI3uvZ9zpPFS/LOxFBDkoMzF5OlH8BWq1a4mENA0RylzqQYU4EqvwVbcUrdsWhVq2gDRIC2RcNRRn11zRR0mqFx99AH6egO3TEP4Ey4ZqJax6aT0BOCcADBG/MMiU74niPHWgoJMznBYrLb2A071la3F9ilzjkKaaAilEUbXYA0KDF+IzMz+eYnST0iaiwHXH1zBMSqgyCLnR3y5cTHreQsMxvP+59mbuJrYwSQJerXwbVsAJw473U4+24p95Z0xs1fQU67XT0PeSjx1qut+RBKMD0f1RHlYxkQ63rPtBkwuSziA7Dn3I++7u4gWS/VSaGEvohV/bVVFyQWhS3XoWgrETNu0fNjR8hwTUufWywvp/Y4iYNt8dR0dDzLoDZmM3Nn/OhWH+ckE5JkOQdBe+QOQC6pE7MTO+P3MEMt2IKSDQaRw08r4bOeO2TonS/6+5CB/qCKATMAZM8HSMEvvXFOo8AFUjMOK9o+Kk3MBddi4ibXjxiBg0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RHdER0djaUtmdzNiNm83TGFqaTk0SnBNV1NVODdEMTBUTUswbUpOcW9TVHJ3?=
 =?utf-8?B?RnlRNzZBeXhZVEdOSGxwM1llWmYvaHlvc1lRWGswaERMQUdLSkNVUmFwb2xp?=
 =?utf-8?B?c1lyWEZsM3ppNDJybGt4QlNYV2EyYUFEK1o1RnlNKzJJUXF2VWgvSlhqOEpw?=
 =?utf-8?B?YStkelQ2aDZ0MllHQnovdEJ5bUdWRi9pOG1TVFIxUjgzVGtEZTRuQ29jRmR0?=
 =?utf-8?B?WWgrV0ZPa0pHMUxwcUM3SUFzRTRWNTBQWmIxVFRzdmtIS2tEZTdMUnlKTkxy?=
 =?utf-8?B?Y3VmU3lCNHdpaVdMWUtNZlJVL2tya0s4dlVuTjh1SGtyemZJc0ZWTytJejZJ?=
 =?utf-8?B?SWtiTXZaYjJNb09uMU5KN0hCWHlUN1pobHVlWFI0QjlnTnFpUTdMWE9NTVJV?=
 =?utf-8?B?bm1qS2VEOE1CU2h0U0NzYTlNYVJTTGRnR1RxUHVad2MwYm5nc2xOQWlnRDlN?=
 =?utf-8?B?VlNwMkRyZmlVRFJIZlYrOEs5Y2lsbkZ1Ni9aRHpXMHdORWpzdE1TSy92VDJh?=
 =?utf-8?B?UmNRbGpTOEtaT3Zua2FNUE9sRXpiaVE5S2VFS1FnRkZSWkdySUcwbVMwaElB?=
 =?utf-8?B?a2dTVWlwTGcxdEdhdm4zaHFmN2lPY3VqZnNEKys5MmFBTnRWOHlwM3owOElK?=
 =?utf-8?B?d3c2YWVzNzNMUHhmN0VFNk5LMlVVYmJidVd4KzNUV2J1Z21PS2ZVY3JpODR5?=
 =?utf-8?B?Zy96a0hVNUNrOERGY2FRY1g4U0FOeGdHdGsvSHBjaWRhUlNBL2NKc0JPR3Ft?=
 =?utf-8?B?V2YwQ1hGZXZvTlFEelNrczBiNHd2NjFvTC9kdUkrRFRId1ZCUFlaVEd4YVhY?=
 =?utf-8?B?cDNwUWUvbXdxd29td2JRRFl5ZURKTStPTlNVT2d0Q2NFTXVRUlRZS3dWbVox?=
 =?utf-8?B?QUhFSCtOOWpYdkhJWXBoZ3RTLzlxNXpoVHp6bCtoNldOcmpaeUIvR2RQVHVH?=
 =?utf-8?B?T3NzQk05ZVppRmJPUHNROXR2VlRrQ3VRNlpqSWxZV1ZPT0kxendOVlhzQkN0?=
 =?utf-8?B?b29sbFJOZ3AvQjQza1lXQjZiZzNGNGwydm9vUmpZa0JsblJqMklIZk5xdllp?=
 =?utf-8?B?RzdoTTd0ZmpOSGJPTnU3K2djU0tPcEF0ZG4xb0lJQ0NublZoTDRIMHBTbXpq?=
 =?utf-8?B?TDZFRXBVNFdabGJjek55aFUrdjlpdk9JQ3QybzFOc1BadjI2ZFMwVWFlNjhk?=
 =?utf-8?B?aGxLMTc2RG5PNkplT3R1L0pFWGFFREtOanVSaUtnWExLQ3RuUXBsVDNIRnBJ?=
 =?utf-8?B?eUN1UGJzbWRMZjlWVjV3bTJQUHd0RVdZSVViK0pQSHJxSmNNSWNnVm5EQVdn?=
 =?utf-8?B?UUN6eUtaM2RHc0ZUSUdacjRIN044ZVZObWhqdmFGODRNaWdMa0o1aDR0K2NR?=
 =?utf-8?B?N2htMHpRZXk0Yk5aeXljU1RmeERLS3dkdHZKaUZWdVgvMkJiSWRhZ1J3bmFj?=
 =?utf-8?B?WnRBWEM4b1o3T1h1ay94bEsrL1dKRUNObXRrSU9nS3d6WU45OEpzWGt0Tm1y?=
 =?utf-8?B?aUNBOHJhd20vSEl0WDQvSHAxWGF2UXJHRHJBVGxIRzNSL1lHV1poR1BNMThU?=
 =?utf-8?B?VU5UNFZkNnJucm0yTUQzbE5vRDZVdkpSakFUSFR0QWFHQU1VMmk2aWcyTjdl?=
 =?utf-8?B?THNDdThYRGFZZVg4QTZXbDdWVkFaZEo1NjlaUnovdUdMNFFDVnlvOHNHUWlx?=
 =?utf-8?B?SFBsalFWaHpBOGkrYy9PamVrV2xLNTVHYmc0WjNaZUdXamMycDlDTFVHL2pB?=
 =?utf-8?B?WWRqRUF0T2pYQ0phMXk4K2RmTkcxNFFyVUUxQVdLUmd3Mnd1blhyN290UXZu?=
 =?utf-8?B?UnllZ0k3ci9BSzVoU3hvWndxaUV2N1lrZitHR2FwSnRrNmt2Tnh4ZVNIeno3?=
 =?utf-8?B?TnEvR0FyMGs5Mm9GWnNCQ0JkMnljY2prVCtvb0dEQnJNc0tQd2R3aTY0cUNP?=
 =?utf-8?B?cG01MHJnaVhFVDdRb1JvUFFmV3lQS3RQcHVnTGF6MkkrLys0aUtRZlhacWZN?=
 =?utf-8?B?TmlmaldDUDhtZ2lITU9NNzI0Y05DY2dyTVJGVDhVakg2NWRTZ2xsMFlveWYv?=
 =?utf-8?B?L29QWG50c2pLdDlabTMvSHNYTkJqczAvaisyREQyekVtcU5OMUdOemxNYXBQ?=
 =?utf-8?B?N080NTdZQ09LTEZ6MnY2YUhiM3UzSjAra0RMVXAxUjA1Zzh0WnNaRzNOTHo4?=
 =?utf-8?B?Z1E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 481e4fa0-a4ba-4abf-e5d0-08dc5aefa897
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 12:54:15.2552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uR3hlbMSQuj1LybNyOHHS/N/GfDs6uDSLvq6OZfgiEy2WXJSsOrBpjczLkdmwaexYUZqi8cUfde7GAaB9A6oOUkNYNPlEACZDW4BMAyuhGk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9643

Add device tree overlay for the WolfVision PF5 Visualizer display.
Since there shall be additional variants of the WolfVision PF5 display in
future, move common definitions to a device tree include file.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
Habidere,

A further addition related to the WolfVision PF5 mainboard that
has been accepted recently.

Looking forward to your comments!
---
 arch/arm64/boot/dts/rockchip/Makefile              |   1 +
 .../rockchip/rk3568-wolfvision-pf5-display-vz.dtso |  17 +++
 .../rockchip/rk3568-wolfvision-pf5-display.dtsi    | 121 +++++++++++++++++++++
 3 files changed, 139 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 7da198be8787..3b2086134a94 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -110,6 +110,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-radxa-e25.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-roc-pc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-rock-3a.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-display-vz.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-wolfvision-pf5-io-expander.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-coolpi-cm5-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display-vz.dtso b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display-vz.dtso
new file mode 100644
index 000000000000..70c23e1bf14b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display-vz.dtso
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Device tree overlay for the WolfVision PF5 Visualizer display.
+ *
+ * Copyright (C) 2024 WolfVision GmbH.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include "rk3568-wolfvision-pf5-display.dtsi"
+
+&st7789 {
+	compatible = "jasonic,jt240mhqs-hwt-ek-e3",
+		     "sitronix,st7789v";
+	rotation = <270>;
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
new file mode 100644
index 000000000000..b22bb543ecbb
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-wolfvision-pf5-display.dtsi
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
+/*
+ * Device tree overlay base for the WolfVision PF5 displays.
+ *
+ * Copyright (C) 2024 WolfVision GmbH.
+ */
+
+/dts-v1/;
+/plugin/;
+
+#include <dt-bindings/clock/rk3568-cru.h>
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/soc/rockchip,vop2.h>
+
+&{/} {
+	display_backlight: backlight {
+		compatible = "pwm-backlight";
+		brightness-levels = <0 255>;
+		default-brightness-level = <255>;
+		num-interpolated-steps = <255>;
+		power-supply = <&vcc3v3_sd>;
+		pwms = <&pwm10 0 1000000 0>;
+	};
+
+	display_spi: spi {
+		compatible = "spi-gpio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		cs-gpios = <&gpio3 RK_PA2 GPIO_ACTIVE_LOW>;
+		miso-gpios = <&gpio3 RK_PA1 GPIO_ACTIVE_HIGH>;
+		mosi-gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_HIGH>;
+		num-chipselects = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_spi>;
+		sck-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_HIGH>;
+
+		st7789: panel@0 {
+			compatible = "sitronix,st7789v";
+			reg = <0>;
+			assigned-clocks = <&cru PLL_VPLL>;
+			assigned-clock-rates = <700000000>;
+			backlight = <&display_backlight>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&lcdc_clock &lcdc_data18 &lcd_rstn>;
+			power-supply = <&vcc3v3_sw>;
+			reset-gpios = <&gpio3 RK_PC4 GPIO_ACTIVE_LOW>;
+			spi-max-frequency = <100000>;
+
+			port {
+				panel_in_vp2: endpoint {
+					remote-endpoint = <&vp2_out_rgb>;
+				};
+			};
+		};
+	};
+};
+
+&i2c1 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	st1624: touchscreen@55 {
+		compatible = "sitronix,st1624", "sitronix,st1633";
+		reg = <0x55>;
+		interrupt-parent = <&gpio0>;
+		interrupts = <RK_PB5 IRQ_TYPE_EDGE_FALLING>;
+		gpios = <&gpio0 RK_PA5 GPIO_ACTIVE_LOW>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&touch_int &touch_rstn>;
+		wakeup-source;
+	};
+};
+
+&pinctrl {
+	display: display-pinctrl {
+		lcd_rstn: lcd-rstn-pinctrl {
+			rockchip,pins = <3 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		lcd_spi: lcd-spi-pinctrl {
+			rockchip,pins =
+				/* lcd_sdo */
+				<3 RK_PA1 RK_FUNC_GPIO &pcfg_pull_none>,
+				/* lcd_csn */
+				<3 RK_PA2 RK_FUNC_GPIO &pcfg_pull_none>,
+				/* lcd_scl */
+				<3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>,
+				/* lcd_sdi */
+				<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	touchscreen: touchscreen-pinctrl {
+		touch_int: touch-int-pinctrl {
+			rockchip,pins = <0 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		touch_rstn: touch-rstn-pinctrl {
+			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&pwm10 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm10m1_pins>;
+	status = "okay";
+};
+
+&vp2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+
+	vp2_out_rgb: endpoint@ROCKCHIP_VOP2_EP_RGB0 {
+		reg = <ROCKCHIP_VOP2_EP_RGB0>;
+		remote-endpoint = <&panel_in_vp2>;
+	};
+};

---
base-commit: 56f939cce5e13f57a5fbdc75b451dc10a3b4f0c3
change-id: 20240412-feature-wolfvision-pf5-display-7134d441f68d

Best regards,
-- 
Michael Riesch <michael.riesch@wolfvision.net>


