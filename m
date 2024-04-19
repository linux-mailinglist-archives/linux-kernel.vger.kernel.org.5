Return-Path: <linux-kernel+bounces-150958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D888AA729
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 05:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A92412825CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 03:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49059BA2B;
	Fri, 19 Apr 2024 03:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="F7ZGKrhi"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A697FB644;
	Fri, 19 Apr 2024 03:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497380; cv=fail; b=S94yYGA4pMnOdr6Ti5pyftKkVd7NwrZuJHIxCgq9UIbQ8IZhLnRx5KQC47LlAEJSIqTBY7LK8JTejg235zuv0jtOeuNGW3oseiLDLPY2PQvo8IVw5yiMNLf8h7Ikfh3xt477LhopYiQWhM+QWl7O7/dZ9G4n4MG5lMm7THNCB64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497380; c=relaxed/simple;
	bh=H6P/IHmWqxu1GkTp63chh39ybr09NJ+7jfUMaLW6nTg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=YZka9OY1rHUpIN+Nl3/DZi3kUdplooVWYMD7AXXj835pz/cwRW+GKCuDaIhGPNMfcx8I48Smf/qrxUv/zPJ1EE4W9RfjyPAfulAPsG1IkmnJf0HO10mTuLdx/1u4QFvS9Vpu8DgewAcxCva6QcZ4LpUDRZratJr4qd97+SaR8Us=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=F7ZGKrhi; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpNPyw4vUoInzN0gE9urienPlz3agsLuDllxEbZLh2g79KmYzHGL42kod0E8g+wf12q8xfj6h2wO5PIOPwDtwKTP/mSh52jjYoAvHnEhvXVjPva4x26vKLqWByOIpdxXQcO47zUvq7lwEqI4F0FZ+0geFxDPRkBrAFcbBiksrV6JpEK2vvHg4QO64zK6bNuh76jTyP3pQ0POzKyXvhbYwR80D2Aqc9cFAFTr5hOaB/gS2BKeCQX2fFJr+4qFuf7Bq1vSK3m9sr9zOsiq/8gjYL1WGp9q2HBR92/NaNNeC+INznGmil9E62iNhruj1bi+qmJUn8HR79DQlFG2aG+yLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a2oYGnDaq5Px2nxpcyVWPQ2vj4ThoPvMYsN4wymC79A=;
 b=JZ9JSjS2Jn3f9mQ76p59UOJ2uwiCEFLDEEvpgIpIGYZEuX14UhIQO74/X42LtFuq5MZ/00c6qc8oo7ooDD8MzQTZxpK1huOh8mlFcy6dIMqlOLqbGlpbfMc/G2iQQB34m32jFha9jT7Dla50SYyZE7a4uykGyJl3bGZRdWMTR2DRSBtb07/67mFcbRajdO7qOYylQ0EXcNq+PZjQr3jOQCSU4sKsqD4bVi2NJ1jUlYaSCTc1ni6E5k8m0jV3QJaf/F+7VSTNIKaFIfw1zkog+nJcFPzdzdyqcUQTnWXGHrfzHUv8/RJCc6wMizgx6+DJIhsmSFDx9QBDwt7X8JxX3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a2oYGnDaq5Px2nxpcyVWPQ2vj4ThoPvMYsN4wymC79A=;
 b=F7ZGKrhiBR9fXUUDPKkcp6h4QfNuj2Hed+9dW/ZJYNyP+xfYFeXl0TJ9ur8OyaL4emHcMUfX642c7h5Z566byc27NwWtJJkOL7VC4bQWM2wz1tJidfPQBh+2saAoKe2OCVZkB8T4YijnWNGeDKTfNUPit3pcoE7s2kluL12zgTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8802.eurprd04.prod.outlook.com (2603:10a6:20b:42d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:29:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Fri, 19 Apr 2024
 03:29:30 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 19 Apr 2024 11:37:00 +0800
Subject: [PATCH v2 05/12] arm64: dts: imx93: add nvmem property for fec1
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240419-imx93-dts-4-13-v2-5-9076e1d7d399@nxp.com>
References: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
In-Reply-To: <20240419-imx93-dts-4-13-v2-0-9076e1d7d399@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713497841; l=954;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=mlwccPXznhmzT7zlEU6EiK4d/4d7CrH5Ytxq9K3mDt4=;
 b=UKr1hNHrQ6EBxIv+gy9sgCyFo8PO6NF8edeo9PkBYC+W0yg3gDwfOujTAcJ2hA+My9i+p2bQ+
 O3JsoHRUvGvDxukflYzJRfFRhVnxewG6hV/OwsZXUL2V1CaicnUefQx
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
X-MS-Office365-Filtering-Correlation-Id: 787d9dc8-d6e0-4766-4b27-08dc6020ec46
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LFQtT8+QtQll9YqmNecV4t86a8MEvX+zMRIyfZA6XQJdx3yR56JyFcH9vVNZYpYK72aTBcq76nxXQsKnyBXvqrgI2CFjwdCgEXRRwM3sgbNd1mg9v8yDKJvA/4HW3SzDNEpG7iIVJ2tvnD8M+DWZDr/xWKYWLnBy2MsWgc//WtXNrLHl2ttXZF54hp5DnNK9MAL6FtsqE9w4+8zZbQYu8A2T3oaqCWdLP4pbpyAI4h0dB3vVyMim9OGM5PIe/R/aup1Gd0ceicvb8kDJ+zd6EoRiptDDFDVbbiJBjNlIFsHEdPQ0pLymI2jv0H5GiYbWdD9D05swgbgstFCDWGS+J8HYzUx/O3Bk9QI2/r0K+5/lifg+m7c01YaPFAwoRApcUi4IkvOBrAJtn4RHlcDZv8/ghNWxYnHIK0VaEhSkKOMLb3BpfXO4uy74yXSDCevLVEjLa0NMN2N20in8O2zXrkXqQ5kmwaALF75vWeCatWtuJp9cHp0wsto1Fq2mZ8lzjeXQCT4HiAZFygsnlgqPsb2ZnJdni9oYproC3ps0hkvLbtaaWPmBscarxrYR0eeAYKuwcQ8V6CkOZPcu1SSq3xEWC8SG3+FLZEatyqHBBbS0p9LEuo6GOeOCjddCkS1jST5B8dPJCT8YG0OnSqqFBxzyvCbe0Kqwbhf2vuIwqU83RVXNcy7mF4gNijyam0MlY4cXVGirHXY32OwUxe3Fkp623ulGyHLUdk0xKj3iXHU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWgrRW9jMWFLQ2sraXdCOUZEcEtucjJoUXZWVGpXS2ZQSEdyeHhqbHpMaHdD?=
 =?utf-8?B?aWpJYnVFbUw3R2NJa1FKNnlOb3Buc1VyZldjM2c1SW96V0ZqQW1iOTNCakNj?=
 =?utf-8?B?bXZHN2ZpTVFQL0xPaVRVN3VTaXhuZmVSQ29JWk5TaXJwS2QzSmNIaXhOV0R1?=
 =?utf-8?B?TW9ndHZhM1hrN2hPb1ZTaHZUckxUdnM4RTZKREVhVzdXN1VxaFVaVXF0TVBt?=
 =?utf-8?B?MDJheThxQjBsSUpDc3Q2RnV4UnhYZ2g5UDlHb2V6VFlKeXNUcHI2djA1TkIy?=
 =?utf-8?B?QUtGUVJiMFd2a092N2d6VEtxU0k0L0ZGdW1aZ05TYkJyZXl2VXNLTUhRK3VO?=
 =?utf-8?B?Q2FMU3VPbWRDd05WdTVZaTZlZ2xUc1JoSTljcks1VWNTSS9US1pIOUZTV1RU?=
 =?utf-8?B?MzVMRVhGclQ1M1FlZnBNYkQzb2RnWG9tT0ZuekxJV1FaK3FBbzBkMERiTnM1?=
 =?utf-8?B?SkdBT1FubFJ0Wm1tVEszc2V0WGIvQWM5K1hCTTUrMzdXK2hKVDJkaW8zOG8v?=
 =?utf-8?B?MnkxLzR3WDJZcHo3bVArZVJXVnNEZS9RMUNpd3ZWMzgxaXRiRDF0bitGUzQ0?=
 =?utf-8?B?MUNQa0VLb281SFpFM0o4OTFES1dxVWZpdjBZRHdyQldyd2hQa2VQY05wVXVU?=
 =?utf-8?B?NG9ROFEzSGJBaVBidHdOUHdEU1lzU25QcnI0L2l5WHJ5WkFYdHV0TWNQV3Vn?=
 =?utf-8?B?UTNlQ21SdVBsSWpDc1hva3hLZDZLOXRqOGdZRklaQ3lpbGh4bE1aYjY5Y0Rq?=
 =?utf-8?B?dTdTcC9GZzVJR3IrTmJFaHlybmhwdUZ3enJPSjZhckR2VGhseGh3ejFrSCtO?=
 =?utf-8?B?VitaejdaTXdKWHdDRmJsSCt1MzlvaTBvTnIvMnZEb0dueVBaV01nSm01eXli?=
 =?utf-8?B?Vnhzc0NyK0c2TmVsMlB0NTlYVGNiVjdUNGJvZk5PL0hYMkc4bHl1Q2N6ZEEz?=
 =?utf-8?B?Umh0OWs3RjF4OTRoNkdMMGpJM2x3NUxnK1RwWWhqbXZ1ajdiaEpNZlhEUkYv?=
 =?utf-8?B?ZnZTNjA3dllveGtRTkhTbmtST1B0MnpWa1lxNTI4UWZSQXg0eExSMEIvbWJZ?=
 =?utf-8?B?TTIyMUpoT0ZGaUZmSGlXc3dNNU5CMk9tTlRYZWIzVUdHY1NqRGxtU0pBbjRG?=
 =?utf-8?B?amxkRUJ5dGJNT1Y4bTRsV2lsS0JmM3ZYbHFxUk9seEJ5a1MzVkZIUlV2UThs?=
 =?utf-8?B?K3BXOWEzV0VCUXRuR2xkS1JxWmIyVE9kdGptckwzeTBUVnIzMERUSzZyR2dj?=
 =?utf-8?B?ek4rOGNETFZqcC9Gdk9ndnpmMVBMMWY1WVRQSmNWSkw0VzgvVWdsUUZvWTNl?=
 =?utf-8?B?c3lqQ1cwTGJFb2tVSER1bWRkOUVtK2l2dU9mc05tY1dvbFJqNjA5RE5telFR?=
 =?utf-8?B?SzBUVi9XQmZuYW1vbjYvN1dpM2xjTUdwNW52N0Mzck83b1NoUFFvaDV0UzM1?=
 =?utf-8?B?OTRvRTJFM3JBUUFyYTllWlZqMWUwMWh4WUFSNEtNb09WTlo0U3BhQWR0UnRh?=
 =?utf-8?B?ZDhtVERUTzltTE9rK3pvUWFFNkhXOU9ISEU0QnNxYlViQmFWZWV3emFkUEM5?=
 =?utf-8?B?VGwzRytIS3pUa3E3N0Z3SEVHVWJXenlHVjQ5UTJzMVB5SWhLVjRrQmQ3Vi84?=
 =?utf-8?B?UGpscWw0WW5ySW11U1VGME5zbStiNHVhUUxUanVBQzkvTnJibC9HOG5SWmg4?=
 =?utf-8?B?VFdxQm9naVFvS1NVSy83bll1ZlBFekRRbG0zYlEzdWxlZGdtQWE0Z1pQT0du?=
 =?utf-8?B?SG1XdFRuU05Vc3hvZmllVjlqano4aXQxZGlLUUpUaVhyODQ5SEdlbFZseGJS?=
 =?utf-8?B?Q3hUZW5uME1UVU1nNEtIYWFhU1pMaHhuV00vajZMUm5KVXNTZGw0RnVrT1Qv?=
 =?utf-8?B?MnB3WGFjaUVKMEh6dG9MT2xEaGxHbW16NTZEYW1sOWp2eUpGMi9WU0kweUZK?=
 =?utf-8?B?dnR0NEtWTDkreEVta0srTVd2WVBUY1pVcjBnM1BxamFNQjdXd3RsdjEwRFl3?=
 =?utf-8?B?anA4Q3NVSi8vY1VubjRza0p6bUpFRE5FbVRQdGhONWdEaURxdTVLQnVBbWth?=
 =?utf-8?B?OWhpSCtDWFh3Nk8wNG1MWUZJU3laYVhnbGpuRktDODRkWTUwaHdsNzlSNWt4?=
 =?utf-8?Q?i7teFgcl/4RzjPAuNtNqEqpPv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787d9dc8-d6e0-4766-4b27-08dc6020ec46
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:29:29.9871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ys+mxUz00vrLDBHCKy8Z3zpuy/x46VtihYBZFXDzZCiXdXJl5Yh7fcx+eZz0y46AT53AsSk3cpm9pgvc7r83UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8802

From: Peng Fan <peng.fan@nxp.com>

Add nvmem property for fec1 to get mac address.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 9a7cb59e2c7f..04d0b1c2ce02 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1068,6 +1068,8 @@ fec: ethernet@42890000 {
 				fsl,num-tx-queues = <3>;
 				fsl,num-rx-queues = <3>;
 				fsl,stop-mode = <&wakeupmix_gpr 0x0c 1>;
+				nvmem-cells = <&eth_mac1>;
+				nvmem-cell-names = "mac-address";
 				status = "disabled";
 			};
 
@@ -1177,6 +1179,11 @@ ocotp: efuse@47510000 {
 			reg = <0x47510000 0x10000>;
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			eth_mac1: mac-address@4ec {
+				reg = <0x4ec 0x6>;
+			};
+
 		};
 
 		s4muap: mailbox@47520000 {

-- 
2.37.1


