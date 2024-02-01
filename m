Return-Path: <linux-kernel+bounces-48814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27088461EF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0D441C2172D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB8A85628;
	Thu,  1 Feb 2024 20:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="iik3PPU4"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2077.outbound.protection.outlook.com [40.107.104.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02E8565F;
	Thu,  1 Feb 2024 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819013; cv=fail; b=m2AgVK8vZjEYOlEQxxvdkcgOhCO7ts4ICan4g6lakFT+Pbvd/AlgrONS0LkDtBO/XDPBVCl9xUd01XmttJciPPXlr2hDVmFV86eQvH39+KQi257ST3/yKqLcQ7BYmjNFKDG4Zd3/3oQH7VLVgF8lpLIJXPF4JEQhc9lx3YjApcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819013; c=relaxed/simple;
	bh=qsBASj8wELXNSQjge9hEzOH1eTBBwUlo9/pgy3KjJ5o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hyv0ttYthVHsduSfj2zOF9RTBLCmC/hKo8jdMy7Axe9P+7sghO0Hwh/i+Ic8RsuRnTYlWBLRusqTRk/QOcs2QNx/pPZ8/ioxPGEvvFLX2IDTB/WS4RsLkeuLm13coEP2M9lB/KmYqpm/OYFo01rHV6jSBRYqAkB4WbaWI6YNqvU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=iik3PPU4; arc=fail smtp.client-ip=40.107.104.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG0E7hvQLRjQf4WS7WvF6q1YCeMK24tHUZFdyQnuaJ+FghFvpQoz1ayQD0OfqkzOQBYeZe/Trp451DxO9rMEazFLlDynwPKEKTLmcmBKGN4xfb+EGfg1gQFKzJbmCbGN1xSspXu4cawM31gDCVsu0vQcZCiYi0rHDp2R7tCnNQ26a/gOOLZehDyxxa/MUWRos6iGHlid05lmsRL9zKif6PCLuiB1ITu/hXwYMKHSaCq+yWZ5L14S03wXvAWjH4nTtZbCRsmHc1HqxQPAERkBoO8hCAc5mqIlMrl9AIMXT5SljZFSI9S0qJ+ooENONyTEo8k/G9XmJofvfyYbx7vykA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bsrGLd7LU3E/W8W/PARAKzO9bsjv3wSVaXLjxNrXUpw=;
 b=K81HzFTuKwru2jVT7Zs3mrLRAWba0V/rCiakdlzIum6CLfsr4JQe8waKoTYWRyYXVTXTU3fkcrm1AnIpufg8ZLCkiRltzUtFZPga3k/a4PGSrjn/e7d9ie7030qr3nt+sUecFkCtmli58Bt0128Z8b9kFuK1a80FzYCd/dr5kAb46/V77u++h3lQzWc2TZpI4tYfig3xw3xUH88Bo3ViviSpj4o08VBIsYVcV1JgetHACBBoCFb+ZIcJBA7VXhAC+CyuHpUA1nGjXBekCicJ1I2pMsxVLld8inhLR3Hl+O6iG7MmjQbgvRDRKvNLOwtdKlmtL0tPdtgZGh2xYHfVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bsrGLd7LU3E/W8W/PARAKzO9bsjv3wSVaXLjxNrXUpw=;
 b=iik3PPU4V2EkS8Vn/YuxB8FNSW/h/xtwmGZDsp3kT+W3EaWuDJLK0IyDNbiIA67DrUt6t9+53h20Rvaf6mmpG2z5kjL/55WewuVk1pnKL6GJe5sTD/qf5F/hMPufaaWzb/Sgzk97c1IJyyUcsqMflPdxtt38JZOAvyV0fJ7veuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 20:23:29 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 20:23:29 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 15:22:44 -0500
Subject: [PATCH v2 4/4] arm64: dts: imx8qm: add smmu stream id information
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-8qm_smmu-v2-4-3d12a80201a3@nxp.com>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
In-Reply-To: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
 Clark Wang <xiaoning.wang@nxp.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706818983; l=1104;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=qsBASj8wELXNSQjge9hEzOH1eTBBwUlo9/pgy3KjJ5o=;
 b=ErB32Cteh009wmmgkNBUwHXU9oRHHzhSmcOKAq6yabv07t2ybi/qTzrbrowQd0qP0Bzgbi9r5
 4unGprav2SLAXVd3kOapayTeB7EbdtyWf7dSVUwhHKVuklaDbPLsVVl
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:a03:60::43) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 184d3a85-b2b8-421b-5fb6-08dc2363a73b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cRaLVxykCTYOUkriCzIKfFNKvwFKiaoyYrBtlKQBI6BKXwLjn+AMxC+GS6V9NG8V3pOguLj0S6srdVSa1dBV7Vdy57yU+t4DgSPsXqv2xaI3gg2IUOOXCjU7fwYIJNOkiUscCkuEPMlBdqNkf+/m/UGRRUELYyhQMl5SAmK0biJK4JcDIwmvVx1amdaW8DqaNAf09MTxa5fL5Peo3Qy6VRbBj4u/qaSk2/RU52C09/rqOqgR5tMxhENjYF4YAoRY97fTk0JO1vmYhIfrljPNeKNp54pGg6iZg2vS7XCQmPn4v1L4U6drgH0B8q6NhN1wx8fXu4hTfTRaKMAr6s1bpifYm2D1EV0+q+s0asXwI6PaObd9IfrCckRI0LzxcrlkP6jVA89KbCco83QMRdcpqsXsGousNFntrZpt3fn0dl92l1RNZS6XenC35Y3zXlXds8U5EgDS+GuAgEj+TfB/ggU8BaAgVe5W6Fq4C7IpsQjHZQ1fzHx6nhLm2eX2Sc/ghXuQzWPEc/B7nxk/PEgMnaIcGEPY0vfvtD+1be3tz239HeVIldKHN0G1aerbyktdCwbrMZB99+wsKscDaoe5rEWMIzHs1HNhPTjse90CeuvpqhS8QLb8LLjEYtqKA5vaD5NrQAJmMlhXeMKrsugmyxxv6ZVaHGQXLdIPw0xKlTA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(921011)(41300700001)(478600001)(6666004)(6512007)(6486002)(6506007)(316002)(52116002)(7416002)(110136005)(66946007)(66556008)(66476007)(36756003)(8936002)(4326008)(8676002)(5660300002)(38100700002)(2906002)(86362001)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S0FGOGdoaGtzU2ZnQ3hQTnZNMkEzVHF1YjZXRE9wV2R5Y1YrWGN1YXFBRzJo?=
 =?utf-8?B?WThka2tlWnk2VnJjRFVjSWVVc3dYY1VOWEdLZEw1WnZ2WlVOOGRFd1FEUTF5?=
 =?utf-8?B?WDY5bjFZeFhjY2NqQXE2VXdrOTVHeW44cjFLeFZsLzE3LzZ4R2pUcGlrZ3M0?=
 =?utf-8?B?Wi9VZ2Fjb29ob3o3RkZpQ0l2L2R3N21tem9acVdiV0psUmhQdWhIODB1KzFp?=
 =?utf-8?B?VDlEQVlDRWJLdWF4alNCUnVkQ3pHMzM3UUp2SVZMeWwwSU9yM2NqV3BUdFg3?=
 =?utf-8?B?Mm1ZajZrMkdCSTVLbnFCYzJIWUQ1NXAzbVF4cEQ1K0hXS0N5SnNncnIzWDdG?=
 =?utf-8?B?QUxNV2lMVnlpVkp1TVJ5OVd6aUhzTFVuc2dwN2gyZDdub0xNSHUwQ0pnSUE5?=
 =?utf-8?B?dGZIaTFaeXJXWllpUUYyd2hmYVhmR0N5dUFMUkcwOGxTN0N1NC9ndUF4MVdt?=
 =?utf-8?B?a1YvZDROZFhDeUl5ZW81d1lOcUM3MDViQk5GZjZKUUQ1bW5JT044dUwwdlQ5?=
 =?utf-8?B?azU5V3VETHFRd3JQdDFUb1N0K2RKWWNISHBsa3dOdWRRK3I0eFVHWXNoWmRC?=
 =?utf-8?B?MTJDVnlBSzR0dGVmdG1DUXlPZWFBY093N2MzSXJBVmhRaWdBSWJPaWx2QU5r?=
 =?utf-8?B?bGhSTmYwWnpxS3hkZExVOEo4cjBhT1VyYjBsK0VkYy8zWXpVTnd2bmZ4V0lN?=
 =?utf-8?B?ZlV0NDk2MG1pdFYvQjRybjBxN3YyMGQvNTBTbVpobmwxUnJTTDZxU1hLZ012?=
 =?utf-8?B?dmNrODdBV0pjdkh0SmlPbHlCMW4zdFJ2ZUlZVTA3dU5EdzZ4dCtCeVVFaDlW?=
 =?utf-8?B?elJWMW5ZaTI0V1FQb0prT3pzSFhPWDR5Qm1EV1JuZ0podHdFVDVrdFpVNXdS?=
 =?utf-8?B?U1c3Q29HZWYwQVR1TGhid3FzL0tCMlgrZDlGME54VVhJSWxUYWxlRTBhRnJu?=
 =?utf-8?B?aVFTeldzM0RBTUlxVWV3OTFNWXBBVUQzZWcveUNzYWh6ZENUNmJmOXcrVXZR?=
 =?utf-8?B?OFBnbW5Ndm82anI3OVIvL1dTZ2plUStTbUhrZHZpYllzbGV2RGc1a0QzdHhI?=
 =?utf-8?B?Nk43d3hCeDIwbzhEclhPN0p1eE9LTWYrNWljVy9nMnN3SFBheGlyejdlcDYx?=
 =?utf-8?B?WDRjd1BQTkxaYlk3RXc5RGFVVG9vcTFjeFZlMHNUczlPcVNrN2x1L0NuK29T?=
 =?utf-8?B?aUwxOXZzbHZOK3J0WWVnam8xaWgxa25XemNMUEQyZndWTm0wZW5XTzlHK2hC?=
 =?utf-8?B?ZmtXVzhFSGZFQ2NneUhmd3UvOXVNWDdkOWoweTVSWTJTOVRMS200NDhxZkZu?=
 =?utf-8?B?Y0E3UnFqaFJxQ0dXRmpTN2pNWmpCdUtMaW1sb0Nza3orL1pBSEZnNi9jMGh2?=
 =?utf-8?B?NlZ4c3o0NzlHbGVMVHBQRUxyd3ZsSmRTVmpjYTRNV0srUTlBNGU5RytRbld0?=
 =?utf-8?B?MUNFMXBTMGNBRjhkZzArdnd0a3pFTzlzODRNLy9kSWpTWGRrVzdBalFZRVkw?=
 =?utf-8?B?bHppL1BnYWRJbzViR3k4d2JLQ0d5dzJvdE1KdkpJUUZnaEg4MjZtSVdKaGE1?=
 =?utf-8?B?YVlhelR6ajF4MThvNzh2YStiajdjVDEvYmw0NFY5MjdOdlF6OVk5NHJ5Nk1Y?=
 =?utf-8?B?cVpkQVczQnladW1SZGRLdUJ2RGh0YzZhSzMxTzMyS1N2RTVOR2VYa3pqaWhZ?=
 =?utf-8?B?TXJnZkFNUXVwYi8rdnVJTDNMTTkrb2JkQUdJSDhsSlVMNkJ6NVZsb05SdWlt?=
 =?utf-8?B?UWRFNCsyMS9kellhNGxreVR0dzQ4UE5QRnFINU9oZEg3NTJoRTBJSy8yVEF5?=
 =?utf-8?B?SUpCdnlHYUIyR3hsVUppZ1drdU1VZTdFQmFmY3FDQ1haZ3Z5b0NESG9hYlpY?=
 =?utf-8?B?YnNjNDdoM0w3MkNhUy9KbVNMQnh0MS9MNy9keEdGUS9jbkc0VXo1UTdjL1hK?=
 =?utf-8?B?ak5OZXhlZlJvU0hzUEZ4QzZXVTQvR0lJQ0h2WWEzMEI3T0pQMVpPMzc1cU5P?=
 =?utf-8?B?aGlyQ3FJUFlqUldRV1dKbEtKeTRPZCswblk4RlYyQ1loNUwzSHdqY3pyUGFu?=
 =?utf-8?B?bEVidWM2WU1rQ0Jha0xMVnZUZ1JYQTA4TTd6a0FManl3RjdMOWlGT3oyYUR6?=
 =?utf-8?Q?2HsYBJkRP4tRDk+cmrICGMM5E?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 184d3a85-b2b8-421b-5fb6-08dc2363a73b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:23:29.5267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /Yc5ruUaU6a3NPvZXUfqzQZGMOoE5mYya4Wjy1mQYbqVjRmLdSo1YHbW6yIKpzJzJw+dMXmOh8tZ39o5Yzfasw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741

Add smmu stream id information for fec and esdhc.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
index ec1639174e2e5..3cbc861400b43 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-conn.dtsi
@@ -6,20 +6,26 @@
 
 &fec1 {
 	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
+	iommus = <&smmu 0x12 0x7f80>;
 };
 
 &fec2 {
 	compatible = "fsl,imx8qm-fec", "fsl,imx6sx-fec";
+	iommus = <&smmu 0x12 0x7f80>;
 };
 
 &usdhc1 {
 	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	iommus = <&smmu 0x11 0x7f80>;
 };
 
 &usdhc2 {
 	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	iommus = <&smmu 0x11 0x7f80>;
 };
 
 &usdhc3 {
 	compatible = "fsl,imx8qm-usdhc", "fsl,imx8qxp-usdhc", "fsl,imx7d-usdhc";
+	iommus = <&smmu 0x11 0x7f80>;
 };
+

-- 
2.34.1


