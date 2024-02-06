Return-Path: <linux-kernel+bounces-55710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A272084C09E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7AB1F25042
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4A1C69E;
	Tue,  6 Feb 2024 23:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mIl2RvR4"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2062.outbound.protection.outlook.com [40.107.105.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B43E1CD1E;
	Tue,  6 Feb 2024 23:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707260743; cv=fail; b=HKmPYbVVwdbbIu0K+jFf1qXQGUuk8gab6zxQTkk6gSOTW/NN8jzmI/tpSjnmn9nuGsyv86Dxk3s5y91C6MTRRazyGC76Hw0jmJfR5l45QJPeWZhP8FHI4+psx64lIUr6ytVhhN5JKOUmGW/zvQtZoN3hem3pzQ9xl9mOpWpBxnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707260743; c=relaxed/simple;
	bh=pXylXQe/bGEhiBRotm1yb/RdwObM8/D++Aa6gTgSamU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=MK+oBZmeRplpcuW38+e/Gb/t+i/ex2aju6VbTWUzK6VPPdsZGE+yvHSq5f+5qBu45PeuhG/SPygZKBl+OG44T3G2+ZtcJXOvnuQgpC8ddk060LNeICF4dIhMPm0UhzvUgA/B3oO3K6QV5bHUPasVqnDEu8vlX6pYGGBoVjpZ0cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mIl2RvR4; arc=fail smtp.client-ip=40.107.105.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hBf0N1Ovw5f3uxnTho8sChIT7mxI5AiUoLrthR/J+5hBFr0nU/gK39I56ThiKdydWJ2Igm8w7ALKYSPqrFpqbISATiW2lbI4TNRpjqNyuXwUk7W5pl4nY1PTHFgZzDW306Mdk6F59HqIbXe+rFamLXDEJ6v39dkV+LuKSR/Sr3W0IT+q479nClEEB8cboajmBhv2w9MQIREjNRhKl2LHepiXGv6j+bCPMnRm9IXMfCrph5qaY+JU6MQXfqhtkNOaubcDDc87p4CyNS+i76DoF7sou9iaaSICReeyqsPsIKpLF6GM/vYwLIRdZ6WRFljslVr0ygprndArJqn2M8h/3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ffra0ksB8iUKBwhjRBTwhhKH0QPNZxkfJmFuEDlfSO0=;
 b=KTCYiXm7lCmP/ypWWm4yTetsQVDzRX+ME1ljLOslu2/zbfBOI80IeUisQsZRXkWzypNNTmSNNNwizKXFgMEG+93E/jqY9Af8jqxlS+VaujaulY4Oayt+xbGR+hhAN1D6HK1jaVT+CQKlUNPFFWpPgA9JJSvgWWzTxlEQaThiZoggBoQKotq6zADJem7XltrJmzdRoh9V8t87l9psNqaAkY1AiYPN8eYPThTkv57Q9ZU2t0Rf52lENJQSHrOhKaynfYUGLAi9+Coyu3KGHBNxJGZYTUipCXSTOOtw5KzN1oPr6uqPABzx527JFOP5qmFymK9wmC4Jz1y68HpiwgsXAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ffra0ksB8iUKBwhjRBTwhhKH0QPNZxkfJmFuEDlfSO0=;
 b=mIl2RvR4NUplKe/2cl7f2dVTPDq7pjxeIgRrG2xf4XDzNnsffZ3tLtXUZHawrwdtntZI5Ir+8rUKObrqyh8jZvkLXa1rHynJEvC6H+ESiDO0M7xMDrgNLhIbw/uKaDkRsS/gMFKFRUrLftRUBMdVM+WRQK06d9NuO2AnSTRSh0o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM8PR04MB7988.eurprd04.prod.outlook.com (2603:10a6:20b:24e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 23:05:39 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 23:05:38 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Shawn Guo <shawnguo@kernel.org>,
	Li Yang <leoyang.li@nxp.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE LAYERSCAPE ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] arm64: dts: ls1088a: Add the PME interrupt for PCIe EP node
Date: Tue,  6 Feb 2024 18:05:25 -0500
Message-Id: <20240206230525.3578868-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM8PR04MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: a4d45548-c027-4a2e-266c-08dc27682240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OpDdjNjAH0uV2fcEEHMHjD1UZV9SIOu9LBo3bKxUKQPz9MUtwuu3KHaAVYX59GUeXaRL9wmnshO6umDU3A/vY/rHq258FN5SSWzdUKkKsjNhjMuJaSXFMI13fQIU6myFhbXo3Sxdh4cWBDYXxXO7OsLN1PWloGr/oB/6ClxYx6bQXVb4nhGQadHlsQR86t0fWfZdoWQEk8ewOnZxdnNuvZq7VixZe8rF8bNabJVwY5+LKpb7Hdl60gWMYUmOXNyOVzHdTmS1OmryyXrYvvOA28NXNFCoU1yvkWyjZewyQx6Tn9LSqo6nwLx8plDwNsOs5/yaNGg1sGm54pBBu07DNjH+hdihKvisaEvn3GrBR2K7Kk1zf7W/HR8mdiP6pEB92k8TeQtuAykoWgAgdNX7dubrqILlLHsW4/WNyJ4N6XsxWtm+zirIF97vukmH61pv8xxVkaRp+yjyZo8ku8v2elEooH7zyg1G426Dvl1CQiJYQyhHg8rHjPQRHJ85DeES5a59KmepEp1EkNno1a0KoMVlJzzx2IChptXsq7A5yV+qcLlUyjNDOFSsG16pRxtC3nbOyiJ6qtJs0Pz36n+mCQL0uA/UUKD54JZTgJIiqOCOZi8qoZ9R7f7sKJ5u6/N4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(41300700001)(110136005)(38350700005)(66476007)(66556008)(66946007)(316002)(5660300002)(36756003)(4326008)(8676002)(2906002)(8936002)(83380400001)(38100700002)(6512007)(6666004)(52116002)(86362001)(6486002)(26005)(6506007)(478600001)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JKuEuoBltbn1aUunYveRg8PvaKlAjQtNMKCSknhVmg3ppMCpkKmwnPcYqu3z?=
 =?us-ascii?Q?jNkM2LB8M2t+Zg8ZYZuE/8JCwaMTaeRSw4RnR2Q0cO+T8MlXZ5ndr/IEXsOV?=
 =?us-ascii?Q?bgVOCHnduP6YvefeqRhqRyIri8VT9nnJ+5dmzvKu1bsKi9QkwmC4nTisMx3X?=
 =?us-ascii?Q?v/V7P0Sy2UsiSnPkCZKVCp/5wCl13ok7TYMe89oZUoEZZ0dYNJhGuKQzMJa+?=
 =?us-ascii?Q?oojYl+e9cfJTptG1eWBjoxUc2xoMBBaT8kVDUc5z2Uld6i/kyYCqfcwpwCD4?=
 =?us-ascii?Q?dLmjXD583HmumqxoiBtP9Bzi6vAAEvqfKqE5F6GAG31V8X7x+HVEnvFMCXUe?=
 =?us-ascii?Q?C/W4Uhdn7BDPsKZsLclypscpMimb2dyNlkO3hVgVfaGJ/PSMRm10e54+MnLW?=
 =?us-ascii?Q?YPxSwtyHPxkmvoOsFBJGZzYj6HD4StMOd5Tp0PhuHIknTCQ5cQjXDqemFSHm?=
 =?us-ascii?Q?izaTxo7xn5DjOFtPxKhGjsbGrl9fpzm4TROeTTejtrYJvjpdAwtu0VJf1fDc?=
 =?us-ascii?Q?sjaKT974GRJjrBgxYugnChvwnL8pM5LBoYNQsqtOkfUXp66S03XEmw62IDvE?=
 =?us-ascii?Q?6eDE3T5pmDvvdSCnkHUHxclRvVg4blWXWQfK5MM2mTXCKNDvgjk9HsyGKkpJ?=
 =?us-ascii?Q?5JS8KU7bbP5wj84bG2CACr9N+Ca9lzdHaVOBUlFk4vGKUmo+ibZPO9PlrEYC?=
 =?us-ascii?Q?H5Q+aS0ZibYXhHh2hkvLpb9HTtMU4AmZaSRmVO0HIhOiE4LLwVjpQ4T6nhhx?=
 =?us-ascii?Q?kzDXA9Pf0fzHgxytvpmwh+UHYM6upVsGJAO+x/c96Y5oNUiQ/r0Ek+QqRKbw?=
 =?us-ascii?Q?61/eUdIBmArZ36OgyxDQt19RPnyJVFgys35AGDotEtOQW552kEVFtcUD6wDy?=
 =?us-ascii?Q?vOqPS8KSZYVmbau7IrmDOR1dNapNu82uAZf6itTKMkASaP74mNIx3wieCsYg?=
 =?us-ascii?Q?39yWxVny8uHXaVCH1fVI2Fnmolw51MUwAMfE/0x0nuxpzPsXcV0ky6mdiQad?=
 =?us-ascii?Q?E/TbF74dGNEQp6sxfESMn0q0VX9FU2mSNu2pxJDBsD0fmck/r21sfJzaf8S8?=
 =?us-ascii?Q?vRgUsEeE9KSml2CmmzyJyyaB5QIKTDLKcJ3udFF+it8QXIT3smwYCCNDpgdK?=
 =?us-ascii?Q?EMr54M9rR0Abjvau2vpmCBtpwDVDkacXrrnqVpiiSjSMtN9QX4L6Q8szJx+L?=
 =?us-ascii?Q?czKzSS5E5VG0bccw/6482mfQ+jphwtDmwwFNLUf0PVLTCEng40LkTc77LF4m?=
 =?us-ascii?Q?FkcyoJnV2hd89hqRV5yyzywpj/xZdEZEe/SnyYlHTwPgTBBfZXTO4AK4x13+?=
 =?us-ascii?Q?nycxml35ejE/ZgANPpc2gc/9jQc/EEXCW6OX2diSS8K7F+TpCZHdZ3tDsYwp?=
 =?us-ascii?Q?9vTF6qy5e2d8g0ooUrDt25f3xd3LzWyvbkVd7F3jBMny0gwJFkYJZ2FH+bad?=
 =?us-ascii?Q?8e9XV5scvTUzJQ+l3pf5QOoeTVh+pEBZP7QEf5wuHpYAOkuOe1yjik9KST6B?=
 =?us-ascii?Q?0A+2x7Yv9gnN/hh4YIoqtSxI9TbqXZOt7T6/JqS9tKTyq3D0lajvb+oAAEyv?=
 =?us-ascii?Q?IDhZBp24vZExSAhdbZy4lz+mxqQngge51NPyeFql?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4d45548-c027-4a2e-266c-08dc27682240
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 23:05:38.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xf4VmvS4l/pg3PP3Obbm2N4saPGPcMXAl3wAYKxoj1SHMN2eSUzSAZo5KFQsL+uqDYBTg5Qf739Anbq/mfby4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7988

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add the PME interrupt porperty in PCIe EP node.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 8616d5e0c3884..604bf88d70b3a 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -591,6 +591,8 @@ pcie_ep1: pcie-ep@3400000 {
 			reg = <0x00 0x03400000 0x0 0x00100000>,
 			      <0x20 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
 			num-ib-windows = <24>;
 			num-ob-windows = <256>;
 			max-functions = /bits/ 8 <2>;
@@ -628,6 +630,8 @@ pcie_ep2: pcie-ep@3500000 {
 			reg = <0x00 0x03500000 0x0 0x00100000>,
 			      <0x28 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <6>;
 			status = "disabled";
@@ -664,6 +668,8 @@ pcie_ep3: pcie-ep@3600000 {
 			reg = <0x00 0x03600000 0x0 0x00100000>,
 			      <0x30 0x00000000 0x8 0x00000000>;
 			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
 			num-ib-windows = <6>;
 			num-ob-windows = <6>;
 			status = "disabled";
-- 
2.34.1


