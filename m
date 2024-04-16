Return-Path: <linux-kernel+bounces-147111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1118A6F9D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FB221C213F5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D7132C1B;
	Tue, 16 Apr 2024 15:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FDRe+Ipe"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2055.outbound.protection.outlook.com [40.107.105.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C333132803;
	Tue, 16 Apr 2024 15:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280756; cv=fail; b=rsFuHLSfyCoOPhi6ee1TJhSBjcdLXeigc/dHkXPo3D/bj0sw9tCV7j9QaQY/uPZVRq3TNsUuQemX23bhhsRAdr3KhQH09JguDQwR9lTq+tm1N+mn4HUumc5VOF8/RoABvycL3oIfYUlZDDy6PXue35XOoJUqQaJ0B19HdkHMkZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280756; c=relaxed/simple;
	bh=ulz3ztrFQHAijsuTfpfyzdmdqpvnNkr/D+Rxhwb9fL8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h1qXXZuwuNPzUWkCw65/rNPWlIt2EX1aw56FFVJ8gZbYNfSIqTqhLxVyfaPdUPw65N/6ESakrM89Geg6hp83v+tvfOw5FNHhx9CBxsyL7zqEDPfKy1XYbqfYj0ZKbppHKsl/LIew4E+G0iTj5KGZGn9d+jHYHm/DXmsaHc3RVok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FDRe+Ipe; arc=fail smtp.client-ip=40.107.105.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WVw37qgDFFz6c9e+jRu2HYn0lfS7R03JL6b+w/pYVxuQjlQzEaVKNXNGu6FRtxVPZShYhq0PE3uWMbfi1uGd5l98P9fnULBXtWIBsh9X1yI0+UvpXYX7uotfq1C7E2upQWCSfQqRn/IvFILzSre5U+op3TpRcoATIjG4IVTzkBG72/euojyr+kLu7fa7hBSTYN7gEKloFHVPbv8mz3K9fhQChaBnnNW74WoR4sGMVpBGPt6fJD7f9L96o3rj8vJNBolZP9MIo2jpazf1qT31LL2gEZ8Q0YxkiyY+QYjO1I+SkKbOrLlTSkchLKj77WaOqrT9HdTdGWBwxf0v+k26UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8CYpcLJaH5GZ6nn5K7B37bkO4JM0/2S0/2FuV4UqDvQ=;
 b=Jvh2EJMPvVVwD93UBPzVuugIw/shHUB/E7OZLGSoio9u8kD/YzVjr5qSLKey256jKEEoYJC0x1H1G9+LgG9rUmSeXt7uqPf7QzsD9BVO8OtRBnPO635rYopT6tNRTQyH4g0A2YOpGX6/SAr1lQ8Ec7bGUZeH+z2BLX69FR7oSLdB3eP2omcH421pOAKQktylDKqQnC4PZT8zRXXjT6n4hH6VOPftSjqD5FTnWkUHRlNIF8AWI69YXIBsgrndbTXWeNrUO3ZCUbMFnvbOUSS+wZnyzLyP9fQW7OUmEEctw+Pq004gNzZHJYmRYoOHGQ51/WAsfaJgA0uZ9izT6lJX4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8CYpcLJaH5GZ6nn5K7B37bkO4JM0/2S0/2FuV4UqDvQ=;
 b=FDRe+Ipe6cqh+keZHkWegv77gICDkp0X8IyljtLxuE/vpBXEnRmPc5JH51tGhcLAqRpTYBCWk/S58Y1EjOgQZz4J2d/+Jyf6QcbSEzgn29hIJVNwsVync15By/nhNFiuAML9hXJ9p/zEqKdN0uppQ7cvCIUBHQIbaScrwVvLTzc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB8183.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:19:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:19:12 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 16 Apr 2024 23:26:41 +0800
Subject: [PATCH 05/11] arm64: dts: imx93: add nvmem property for eqos
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240416-imx93-dts-4-13-v1-5-da8ac02e8413@nxp.com>
References: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
In-Reply-To: <20240416-imx93-dts-4-13-v1-0-da8ac02e8413@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713281223; l=922;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=FYexzw67Izd+aM6TWmuwzfi9yGy8drc70xRRExfgVok=;
 b=2wvhCPRwhBHDPNJrfsQI6Y6bXXRQVwsxvz3tBVTAn8pslfoAVp/AoDkOeWdBfeZXRzDWuyz3b
 CO5WNLl+w1EBGqnVRVc0HXHfWyA4+dBAYVD3ty66E1bKXOy5qvx6GmP
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d47b71a-e7e7-45d4-94fe-08dc5e289230
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9XbCe9ixSlpc5+wDBXbhKHi7DNcouMNZpOFFBi2nLvFFc8vznjJNw/OmRVCWPDdfrCPC5KY78Vh3KgFH9VLz3Jsc3mzCUZ3rzmamP3txYfb24gsNJO3/HTgxU/1/tyiNgpv/EI/dTm72bKSyQW99DR+BKyktwJeEagEChX0yUm7l/sQkWGE5RhDBP2OVX4T7NtSSvMxJwBj30CHaYzHmtIWoYLyNoovDko6SGPd9nt2VYZHdlW/b0LUQFoXu8B3FDr+Zqnj10dewq6NZU2KJ19imun1kBYlNYTSH4YZZqdGTJyFxK+lq4TomDCErnOyuntxkPFCK/LkVQEsonQ90RSE19YDJ6ACVRxknWyGGvjYZFdFmkNpobSbUNC42eoJgtp32rsNOG7qT7xZWRH/ypqvvRsa5sCkulsmoto0LdGkH1uUgf5akNgtbA5IcPWGy9/dOGp2Log9z9/T/+rvEf0g1mnuFS6xeOlImEA6jbodXe7KUGyceR8QjNRbGtTdxl49gJt4/9BiUtCIYQjWz8p16A3aAboNM8IGd1aKMpEuH30OF8rrFhIkULyy1ilDkCViNNkJoiobsszsYPBByyXlhZQXIezxL1r5LnSd77+xYz2DNNxvFPR4LgQcu7j5vVVFkzUvl/M70Q4+hF+DY6bj32vB9BHlZH3D5hQm5wwipAR5ePdtfeLs9FfV/w/yNR6OAh3ekAgMfTj1Xz0mgzucAhUUnG4iNcu7Oznwqn4I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(52116005)(366007)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UXYxMy9TcmUwZzRCa0hRWWZhQ2lmK0g3NzdqNkgzMzZlWFJpbGhaaWF3aTlU?=
 =?utf-8?B?WTIvMTllZnJMWUhuVXRqN2E5eXhiQjR2Ung5T3FodjQxeWcrSWJGTzRwL3Nk?=
 =?utf-8?B?TlRtaHdlaXFOZWRJNkV1WEl5N2FqaG9xLzdVamNIODNmNGMzdTNZWmVhNXlL?=
 =?utf-8?B?aDVqeC9ZY2EvellUZkFzL2JPK1A3RkhDaGlTa0pwZW14TkNYK1c5M1V5bXlC?=
 =?utf-8?B?enVqN3FiajlGTFVtUkRtaHlhTzFWTDNxK3RkcjlBT0ZHWjRmNlF6UlcyTkN3?=
 =?utf-8?B?WTZ1RXJKZStLRWNUdm5ueDNBUHF4Y1hWekZHZVVEVlFyTVBxNFlhMjE5STJv?=
 =?utf-8?B?bjBROGFZNUZUK1kraVFuQUhSdXk3UEt3akxvOUdVSVBlTHVYYlB6L2piMm0w?=
 =?utf-8?B?L1lvV20wU1NMV2ZRWjB6Wk4xZWJTQk11SHkwRmYwaU1hL29TakRvemlsUmll?=
 =?utf-8?B?aEErYmcvOEk5SVNBdmZDeGsvR1ErZXZpVHFTMkYzM3h1NDFlWklsZkp0Mm1r?=
 =?utf-8?B?bkVEdWdiWVBENlZSdFVRcU5VRzJmUTVzMDl5a2dkb3gzM01XZThXb0dkdmtQ?=
 =?utf-8?B?NnpLamk5RUFmelFxM1FuQkhyNTRQa2xERVdGdnFUdld4RUwvM2Y1Q2laWVg3?=
 =?utf-8?B?NjlvN3Y1SzUxM25BS0QzMDlRaVBuTiswZi8rS1U0SFZCQjhSaisreUd2cjda?=
 =?utf-8?B?RFV1VlZqaEhEalRoVGdDWGtVelJaMWMxa2hnQk1pajZGd3k1azNzNCtMTlRU?=
 =?utf-8?B?RDhFY2E1MEZXSXVwYjUzUGsxY0ZPaXVxYytFcHlIRGZ4eE5wKzliakRmem9I?=
 =?utf-8?B?cFpqMmhEYi84MzZVSHVxYmF5bVl1ZERtUjhFOUFmUG1JMEVXUFc5U3dMQnc1?=
 =?utf-8?B?YXNkQkE5Um5mTWJNcW1DQWhyTTlrWitLdEJVemtiaFNobVZUMTB2UHR2MVJ5?=
 =?utf-8?B?QXhmN053a2NmT21xakVvRzFOWFhsSlRWN0RsR2s0WStHQmkwWW0wSUx2UkJa?=
 =?utf-8?B?R3orWlVQWURBTlZmMVF1UXB2NnE0VldkMG5LQkkrZVFhUWJDc1NVUjg2dGhh?=
 =?utf-8?B?VFFuNFNsT0xQaUg1cHZIT0ViREcvRVBaMUZpL2k4YlNsTmNjN2pVNWkzL2tP?=
 =?utf-8?B?dnF3bUlCY3A2MU5ubHUvcE1OOHhWaFlzTVpJR0tVS2pEUDNCRExHeTNqbjFJ?=
 =?utf-8?B?OXU5d295Yyt0c1pJdDN3Z3VrYnZtemMzc2VyN3NCdVF3dTcvOWdiWk9rVXFx?=
 =?utf-8?B?VHFVVEJ1cWNOUjVuSXRnVHc5WkN2aWhIR0YwdXJmQ3MzV2lqdGVzTEU3SEJ5?=
 =?utf-8?B?K2R5VE4xd2Q0UVVQbWdWbnpZM1VhMGRuRElWMGVDaFovMTdJT0tiVlcwMEFv?=
 =?utf-8?B?VzVoK0VnM1NleVhCV3oxUy9DTG9YeEdyQ1V5TU1WalpmUGlJMFcybVNuUzBh?=
 =?utf-8?B?WmQ3VzlMcEtyM3htMGwyUkR2L1NRZVZ3MzhVNk8zb25RREZ4dE1ERGh1NGZD?=
 =?utf-8?B?Z3R6WWUzWVdNUnZFMXJWbkYxVkVMb0FnV0NDMzBMR05Zc1p1VE5xcCs1clBX?=
 =?utf-8?B?azVqa1lHRStmTU4vZXRqbWpmV0ZwbEduOWx6ZksrRnBIOERZNldRZ2RFbEJW?=
 =?utf-8?B?ZXVXOGxPYVc5T2lrVkErODRXZnBXeXpRTzI2S0pFZVc5dUo2amxaSklTSzVj?=
 =?utf-8?B?a04yOTBIcndIc05DSUc4ZGU2VXIxeGxxNUpnVVF6dHNKc2ZiaEFrRGNmMVdL?=
 =?utf-8?B?c2xLc2wzTmltUzZLQVpwNWVrZDBDVlp4VnhockI3YStZMmtTU2lkNFdWTDlk?=
 =?utf-8?B?ekFCVExxTTlZVG9vK2p2ZlBGU0lteVNPZkxFOVVwa3daOEI0QzRLZk8zWnNL?=
 =?utf-8?B?TDM1eXk2UWNDNFNNUDIvdkR1d1ZEc0g0N2d1eVNndDJBZCtRanpxbDZ4VUNO?=
 =?utf-8?B?RUhRT2xGYk8zRXZFRzZKQll4MWFPOU1aN1cwV2YzeVVRMGtheUlCVmtNOE1P?=
 =?utf-8?B?ZitKTHZ2emlPa1hYZ0hyZXViN3daaXZnejJRempoeXRtVnNFa0RaWHFVbFdF?=
 =?utf-8?B?M0xvcTdiV1VoZDc3ZmljZ2p4R05OWXJyZ0RBOVpMV3hwSm1YV0lMNzRCTlBI?=
 =?utf-8?Q?Etijt+EOViZteCWLd8h/BXb3C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d47b71a-e7e7-45d4-94fe-08dc5e289230
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:19:12.5081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yNAqYHaMg9iD0GELPP2D5PH4yuKv6Sy9k8gSmrORqNrhrvKa4SddpnMJI+oydHXtJRwMdTrx66kzogudof0CGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8183

From: Peng Fan <peng.fan@nxp.com>

Add nvmem properties for eqos to get mac address.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index b09014b9a719..a83ac1bb1e41 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -1091,6 +1091,8 @@ eqos: ethernet@428a0000 {
 				assigned-clock-rates = <100000000>, <250000000>;
 				intf_mode = <&wakeupmix_gpr 0x28>;
 				snps,clk-csr = <0>;
+				nvmem-cells = <&eth_mac2>;
+				nvmem-cell-names = "mac-address";
 				status = "disabled";
 			};
 
@@ -1183,6 +1185,10 @@ eth_mac1: mac-address@4ec {
 				reg = <0x4ec 0x6>;
 			};
 
+			eth_mac2: mac-address@4f2 {
+				reg = <0x4f2 0x6>;
+			};
+
 		};
 
 		s4muap: mailbox@47520000 {

-- 
2.37.1


