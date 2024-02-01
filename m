Return-Path: <linux-kernel+bounces-48813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D75A8461EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 21:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B1328CACF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 20:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966A112B14E;
	Thu,  1 Feb 2024 20:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P7oZIf9y"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0A12880A;
	Thu,  1 Feb 2024 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706819008; cv=fail; b=YyDZmk7jsSGHB1KWDG6yT5RrnJZM655ORH6QmMYnyFZSFelL66X05lYabXb8/HotB48BLp1KGNee2aAPZ1Ao6/QwQrPy9qGCQrGwYy6pDwxzVycSxohGpFLxgIMhLqjpVXaMu5uCxSI/+m+PI/WTMC4Iyx7tyGC1NbO6gqNrLNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706819008; c=relaxed/simple;
	bh=wr9vnZjPWhBJ8uuNvNagZ9WKFNRRzKZuytw2UDEDZ3s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=dAxyUHRdECANiME1oqUzN4J6TXZOT8zR66uBVNZFZi3dkk1vuBWfeRw2aTCVQXt6GN8B9oIoNAArgwKtPo705yDOlw/Euu9QPSFmelLR0PayJTFymC4HJPZkbjYOfPOKTD74XfN485EclqgFZ00EqehX2WygHFUqYeWY4Xiw6k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=P7oZIf9y; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hd40Q446Zrx9fUZUqOrZ5GN2k3os4IUaPYw8UYaMDNoajQ3eZc6uEaraC/4jg9y2cvuwNEDLGIqDHq7d8RHIS95fMt0rMLCfUSObur+LTyZMEO4JFk1PXyLRaVGNo4UQyqaq/+p406g+inMgty0RtPZLCz+r/E37VRWc3NIsPR4Ab7XIw6wE5p7hyBYQwkXF3ArKK679OmzOe4EHJ5wm35t+17Piwu+TDanXUV6pLGe2Umcqg6ZovX1JVfKCR3dbfImiPCIvj1cdJjl16W3dIs89NDV5YKsIkn9mQ8mmfEhjkaXCHbCXra/6y3tuP5A9ottjIUL4lHZpO3r0HsdRfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qq19yytUA9OY7vL0NGDwYeRLY4AC+ya9bTwLOseoxGw=;
 b=lJmQIaeABoS47O8fZHcIy2KB6CBVHQMhbhLpcW3mXBPv7vxRS6ZXq+RMMRya52k4vu7oy2PDJn0QRGKEG0tJ6EtE43Ql40RYOKzQeWr9Atmt9CtN3cMO5nhad0WIuR3fr/poL2dXBpllqNLFYqNPr2+jK++MJkoWcwDWYxLJLHNumDsdp5mYkoHXfIAtK1eKX5EgUP9Crozd/HEtbemkL4Q9nMUwda8QPbHbc4gqn+mvUFJKZ0bn1bGH2/ixfIWBuY8Yct99eDfyRHTvfOOMT/BguO+Cu8Acl3EOv/mbnlPSkF5AY3RshL4X7WNPeO++VyzUG3DuG0qAbFRKgu0/9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qq19yytUA9OY7vL0NGDwYeRLY4AC+ya9bTwLOseoxGw=;
 b=P7oZIf9ycdA2Ge0vwwG0bsXsWbCXX736gDBMi5xm9Ll08CwPrf3k9H5JpANsjg4eKpFV4jWWGSJFaglSTkYV8wVYaiH1cRfHnM6rUilZgfKhfzn04cHBfen2VXE+L8vqznWykOfLB3QTOaCpjCVZwSCdwRX8CqNlL2bnAoqzO9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Thu, 1 Feb
 2024 20:23:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 20:23:24 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 01 Feb 2024 15:22:43 -0500
Subject: [PATCH v2 3/4] arm64: dts: imx8qm: add smmu node
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240201-8qm_smmu-v2-3-3d12a80201a3@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706818983; l=2277;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=wr9vnZjPWhBJ8uuNvNagZ9WKFNRRzKZuytw2UDEDZ3s=;
 b=+atxvXuLznTM/geO+cwO2+xFA3Y+oVHY4kKch6Wfv1drqaQaLgX5V2FrE6uGEgMsD3CQAWy8L
 IPsti2RB3viCaQk9Li0lDk4EHytZ90xex5fDOT9ZwxShNqrLgjlTB1T
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
X-MS-Office365-Filtering-Correlation-Id: cc243067-c877-445a-aee9-08dc2363a42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0HEoBabJAxeil8KEqlyJ6L8E/8Db43+m2IxH613Dm5gCiYwmnenkA4e/8PCzp3Cc6j1Io1mArDFcLa0QVZ+CfMYJFxZ/TkuWKIJr33846U5Q+CNxGSYDC3hGiqSUmTAoxuMYN+I7vV17CH2bfISOCYp4so50BQkZxFnjU0j1zsGWGxmkxv+vmZlOCS57IKAM1GsgzoDhyBoLSGV116lU3YVvqFLGwNW52YbpuMTB+PPr9Ys3WESzSfzRzWrtJ6iXxnHXl1HeKRNyTTshBEFKUgW6bfokB5CAaGz46I+Y7i8JqQAcuEdc5RlZ9RYmvG1JDbFKHBXgadPlZ1OMjW2frUDhzYk8Feo4CawSfLken+L+qSHb6G/4AS2G3iuZvG1wEQARJH1yjshbGfvVYvfFPObvy8JwWHdxC16YkO1qE4KU/T76VLjMzO2ecyVvKk9SiYeUoijTqLdmQObFLFcoBsAHRRPlULDLE2XDRirCc0O9iz430aKPjQEdw7LGxtlDOr4WaqGvxWI7l5YZeeaH2HkL7U71pMG5Y6zWD6R5fR39uL1G+o5ou6nKRMsgnJ6QQeyWLSbYKVtej2/q5LfzcC9b+8VpPVFvNxJS8VC3xWAES1HomiVz6wKhHQiIpwp5A8hNh7sGp1Tkj7Q1iW2N6N5YQFnL/2Y7Z0Or8QSLVUI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(39860400002)(366004)(346002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(2616005)(921011)(41300700001)(478600001)(6666004)(6512007)(6486002)(6506007)(316002)(52116002)(7416002)(110136005)(66946007)(66556008)(66476007)(36756003)(8936002)(4326008)(8676002)(5660300002)(38100700002)(2906002)(86362001)(38350700005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Zjlmb1FjeDFTalZ3MG1kNkt5SFhDNnhkWExQd0lrR1QrTk55ampBdXBCeTla?=
 =?utf-8?B?Qy94WDBGM0JSb3AycHdFWkhmZjY5TUVYTUY5NzhQNWsvdVYvWDliaU9sdGpL?=
 =?utf-8?B?OEE5OG9ZTXlvZ09QWHo2c0dtOGtvMkNmTEZVdUo4aTdrSCtBQUNkZ0YwQlE4?=
 =?utf-8?B?VzNTNDQzK1Q4aTU3Yk4xbW5JT2JtWWpJaU4wajZkSXZHeFhPOW1jQ0pUK1dH?=
 =?utf-8?B?blh5R3AwYnAyNFN5clFDVzdlNDJIVzVLbk9lNTgxK3dvQ3dJYXFmNTdYd2Fr?=
 =?utf-8?B?clMvbi8xWDVLeWpWR1ZZN3BqK0FCQjVLdWZwalhMZnQ3MU1lWmJqckZsRUp0?=
 =?utf-8?B?dXBPdkdPRUxkd3VtNXVKREt4T3N0eUZnMXdmTTd4WWVIemJ1Q1N6bDFMV1M5?=
 =?utf-8?B?NlBYZHVIRHpuR01tLzd6aHhzMzRjNmF2VS81b05yQ1Y1ZzBPSFgzazdycUtU?=
 =?utf-8?B?MW1pTTVrUVhsYUJmN04rQ3BrUG5zV2daZXJ0ZHdMTGdYVzEvSVJaQS9xN3Y5?=
 =?utf-8?B?Qm5vbDRiY1UvaytTY1dST3JjU0VPbDZETzllQkc1N1J4YVZZU29OeER4ZU1I?=
 =?utf-8?B?NXhiU0ZtY1ZSK3pDd3ppYWpYSHQzT201TldnZVdGV1ZkYzZwWjRhcGVxZmk0?=
 =?utf-8?B?YmxiaitpcnNhZHQ2L3RaYjlSTVlRM2RMV3NId0M1cTlPTGFFa2ljMHg5alpW?=
 =?utf-8?B?U21QTTdDOXBOcmhxUHcwd0lERVdyOXZhTDhpc3JDODhTUzQ5WVl2ckQranR1?=
 =?utf-8?B?dVdVTlg0T2VNUS9sdnlRRncreTdIQmFNQTB5cUlwK1hYOXFLY1NYbVh6VGdq?=
 =?utf-8?B?M0VkRC92dGhsbkFYUVpPMzgwNWlvUEN2VVdYVTFrVlNIa3hRTFdXc0s1SmlT?=
 =?utf-8?B?V3I5ZGowbE9kZzZPRWdPWmR5blQxTmZHT3lQS2doOWhSczk0YzFta0ovY2x6?=
 =?utf-8?B?SzBBOHQ1SU9zY1FGdEQ2dWQxQzJzbmsxMVZZTC9SU3lySTF1TVl3ZTFUbndQ?=
 =?utf-8?B?UjNBMWg2S1FWSjhlcmo5Tk5YemNGL1J0Qmd1RlFuTnV2WUl5RU1WQW5zS3lr?=
 =?utf-8?B?ZXBRa3NXWnJTVlhrWFJuMVNia1RBRVQyRVJFcW45ZTVJWWRpVVViYWdVSnJv?=
 =?utf-8?B?R2ErTkdtNjZFL1hPckZmeTFYNklUZGdwbkx6b3dpQUtQWURBeWpRbWxkdXI3?=
 =?utf-8?B?U0ptbU9ETS9INjdzRTd0OHRFZ1N3Tk5ibExDZ2thVXNxWkV3V05sSkVLS1lx?=
 =?utf-8?B?Z0NkR0hibnlGV0pmMm0xYjBtWXBRMzVIUUZXOGhSVHdpNnpDdnIwUkdjb25q?=
 =?utf-8?B?aEJ6TVp2NVZmSDhUVUFteTYveW11d3E1RVpvYmdLbUJ0Y3FTeDJxeFhaSTdO?=
 =?utf-8?B?WlRWbTM1aDZvUGVpL1dPY1VLck5qWDY3ZFFRY2sxNHA5OHdIVm4yYVpkeU01?=
 =?utf-8?B?WVZ5MGMrbS9TcTFVOHBveEw0cXRRbktZaFloQjJnV3B5YnorVUhpUEc3Y1NX?=
 =?utf-8?B?bVJrVnhML2NSamxkdUVJUExYRk1na3RxL3RpR05oZHBPcUN4ZXU2VU9mRXgx?=
 =?utf-8?B?Vms5SXdHNlMvcmczNjEwZGpYejJ2RUM5TkhjQ3h0amFWbXpUM0dDT3pVazJL?=
 =?utf-8?B?ZlRoQkt0dXQ3UXZWT0xnbUNQam1nYVJKYmY0OXNHaFhRcFpoajN5QXpndGU0?=
 =?utf-8?B?L0w5ZE1SL1dNVkw2WG0rTGkvaUxFTjF4VVRsaVBsMVZpNTE0Q0xBWk1wK3h5?=
 =?utf-8?B?VXJuRnJrcFVyR2hxbDFLRHQ5NG94K2NXRExCd0NZcDUxWUpoSmJ0cldYUDlF?=
 =?utf-8?B?ODBYQ1p6bmxMUnY3V1RSQUxtbk84ZHBJZTVKR20xTjJuRUYwSVgwZWF1M0sr?=
 =?utf-8?B?S2xoZlhxWjVBVnV1dUJZaUR4ektkUEtmc1Qwa3IvaVlSYUZpM1krR3BUeWRP?=
 =?utf-8?B?MVQ5RHlCZlI3ZldSWllUT21uQnpLaGI1bEZtaEhCa0l4aTdkNXNlanVBZGtn?=
 =?utf-8?B?aG0vUHUrcndEUGJKZWpqYWVsSDg2Yk5wN0ptTGw1K2hlR0RpOUVISzgraDN1?=
 =?utf-8?B?cHNmR1JZNEJGUlZhbU9tTVUvTG5nU2pZRWNpczRjY2lmQy8ySkRCaHNxeWw3?=
 =?utf-8?Q?Jd+iJmTar30Jrk5MFiz4GaO9R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc243067-c877-445a-aee9-08dc2363a42b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 20:23:24.3954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccEFlK/1BYQKEimizYGk/Ed7nGnJZoOMKikw6Nc8qNuLy1m/wuNanWnhGUAYtqHwZcuMIEVLs8qXmw+iSoK69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741

Add smmu node for imx8qm.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi | 41 +++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 31744fc1ab085..b3d01677b70c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -265,6 +265,47 @@ timer {
 			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>; /* Hypervisor */
 	};
 
+	smmu: iommu@51400000 {
+		compatible = "arm,mmu-500";
+		interrupt-parent = <&gic>;
+		reg = <0 0x51400000 0 0x40000>;
+		#global-interrupts = <1>;
+		#iommu-cells = <2>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	system-controller {
 		compatible = "fsl,imx-scu";
 		mbox-names = "tx0",

-- 
2.34.1


