Return-Path: <linux-kernel+bounces-31532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE279832F98
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 718E02831E8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76BE56B84;
	Fri, 19 Jan 2024 20:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TSnFX+3i"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2055.outbound.protection.outlook.com [40.107.249.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1CB56478;
	Fri, 19 Jan 2024 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695060; cv=fail; b=Zuc/8xK2cd7wrymnexTObEA1tlFJqUlVkHwVB8b/j/YXXUlzrG1tiH6uaiuKTtFRyug4qAjRtqHQnJVQlCjdQ9hIgjhOgFkpflUQi6Qrh0PsnW1lFgVghdZbPj4koNLmP+MX059xS3MUHsRScEaaH2Vlt86LHcHRJpZN+0n4AcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695060; c=relaxed/simple;
	bh=NBls7CBPjIaLSLCC15bJ0diuz+tckASLmAX/CHzzD4c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DrQqpqXxQrz1OsHiVLT+QqWd79w6wr6VSb9gvQ8/nYy9tDqIA1l1sZjRCb+2uZH33c5AOFUqFWRDdgDzNoTayRfqHaR9K4ekHi5dc0OcfdbvFRBCfkzxkctgRfYd3Wja0WlALlSAQQjQC4Y/S0dBpq/C37sFxLJHe9ng+95JIQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TSnFX+3i; arc=fail smtp.client-ip=40.107.249.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DE/A/g5a5Xduds51ikgvjLqxn6e/uiC1UOUmMZrRZc+2jIKB1eFQCY8f8eGUqTHpRcItu6+6YFcS9VbdD1vmByHzZ2DY6xkYO3QxNftIiJXdIlLdTxxHRdFBc8AGzH9a3vo6juQlaVEZDrYbIscROS1YcF4W2mYB1SNI2H5q6/HiJm+sST3LGcFMdp/StDb5Pn6AX7myM2WvKAjAJgTYhonDmJplbPd0bzrVeB1Ilyx8LvXN3rmTEUFSYUjsa//VWp04KRvCCIjwaTLmB2GbeNCu+xUf9xsgEKlaXJF+ti0h+M9U9KTQtw4jyxlpER6Qbvlmz8xpMjLIYuiyipcqdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L8uKjMSndWUkNPTgqwWIA6vrX2HXDfxXbIVdmm6KvBo=;
 b=E9TDiWolwjcabgSZNV2tD1b5GBVcsFRL/yJZ4sYKiP08pdKhzZZTPPjdLBQft0tjiVn/VWuiNw5xO7EfNsyUuA0gtsqHiuPuqf3xaoVlkDFbuKtJ20dZJ6JJsVOhoL3ouVArxyG2RLpCWra1/X+RyIR14tYApqhGxhKIhwEBEKbEy3j0tiEcGVyIX1b4pA3PonYA2rVZmYIdVp+XvIsM73QFbpai0DbtHuAwhjdinrdmsT4qMNjjdF8pNxPDICgsQ52eJXhwpaa+9SafdefaZ/3yKUQKD7boqkJvLJN4em07OhsINnlonA1viskog50iZlJ2vqlqZ8FpA+cMigpYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8uKjMSndWUkNPTgqwWIA6vrX2HXDfxXbIVdmm6KvBo=;
 b=TSnFX+3iJWAeoaPVGAKKB/Wh5UdPZBkMctNdkhHiJ2zOz43HZYKvSpAP9wE1KUD5tdVLimGr7CoZzClXY+dlHCGBQ13nFwYLPVh3BRj83tkix1K1UiUM4bN/H+/dkfC+kbQ//EuxTe1ACCE77v2dmL0nCjHjQbA4esW9Hs97vwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8565.eurprd04.prod.outlook.com (2603:10a6:10:2d4::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 20:10:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::b8af:bfe5:dffd:59a9%4]) with mapi id 15.20.7202.027; Fri, 19 Jan 2024
 20:10:56 +0000
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
Subject: [PATCH 2/4] arm64: dts: ls1012a: add big-endian property for PCIe nodes
Date: Fri, 19 Jan 2024 15:10:33 -0500
Message-Id: <20240119201035.3124007-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240119201035.3124007-1-Frank.Li@nxp.com>
References: <20240119201035.3124007-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0380.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8565:EE_
X-MS-Office365-Filtering-Correlation-Id: 682ef955-c3ba-481d-a15e-08dc192abea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hJrF7T2qwbEBU7AePO/O4M8X3pksOKSpkqD0SZJ4ZkjgwQcbGpDMW9AHVlC9L2qEEyDDXwcSrUQS2HOwJaEmk2+gkLKedqr/3OcAfJGS/HdSHkBdMn+hZZ4cAqYc+Rrw6Dmg3NTs4D/T+if3HodWpc5zyQUUZUDmBLUrqGDIXp3H+UWdN24bfC3u+vsBR/KTZTgnGhZMpuWBO0w+36VncRz9ZS7TQ5kVuQ9kjMfGRV0I2Jx1DikdfIU0x5qcoqNvsbchvFT+0h5NcnU2MJqba46ZyQChr/Ram+UpA/MuxLVTV9AILw4fppYENdNBA4QdzAj01JFfH086KvyYeV4612Al8niL+BEqHdA/W92m2PfUgobJAimIZ96N+ph1Or+vLOXtIx+7jnPYtZ9D0O4HSfpyCEbue1H91m3gtLosGgCE6H6n4MVJda2OuX7T7wnFAQCzfjg8p7hN6zU+aWO5TRaTtAqLy+Qw2QluOdqdyBOGRCwt0JgEAesC/9RFYYvkiyEI9+cL+o2ZOspSDRuZ2/VXKSJtyaNGvqHl47UAasCkM2ov1/SIJtfaWClEUPN0QP5MNYLorsn6bdMSw7fDxvDyswDqu9VQWmGnRsakr82ZCsSidjt+MnZOhw1YxiOt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(346002)(376002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(8936002)(6666004)(8676002)(52116002)(6506007)(1076003)(41300700001)(26005)(38350700005)(5660300002)(36756003)(2616005)(2906002)(4326008)(38100700002)(86362001)(83380400001)(4744005)(6512007)(316002)(6486002)(66556008)(66946007)(110136005)(478600001)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YxPiQc7KbIIqhWUj2RNMythEIH058KTZeC9vjPWf4CL5fnRjMsGqrrzBBD6U?=
 =?us-ascii?Q?UJ6RBur6uPpillamtx5kWILP36AbCUL5gb8uAw7aJp6k3uwZqiIu1CKfJNBl?=
 =?us-ascii?Q?mxXCp66w3E0jZcd+s9/YJA6KZQyQD7vPJiQRWst4579VpdVUSxU7g1HBhVC4?=
 =?us-ascii?Q?KLE5L+THfKgTFy4Th835KXawaXNgA4rEOjW28xzfeic+ooXzt5l/IO53qisP?=
 =?us-ascii?Q?UHAJqWr3SVFF7uZDBdGejgcCutkXlZQKQu6nerk5JJz11GMkoRvuGaQl3myU?=
 =?us-ascii?Q?C3G+SF6fhsVC4K/t/9zmv0b5vAJk8Gx1LL5gkit+gS7oWG2YB1d4ndOlr2mt?=
 =?us-ascii?Q?MSjEBOwubDDx+gkA/gP8ibD5ZoOFv/daIM4HhS6loYZ3e0JC0w9yfdoTxkR1?=
 =?us-ascii?Q?i0c19NorddoVKlcYDZtb/tw21bP5PlblgFsfn+pDha7GZ9v7rnun1KbHRWuo?=
 =?us-ascii?Q?THbLGnr60pPpvnE8K/eF3Pq4KKxVNehMtWAV7aJZ76ISik3KPUvUlejASK+H?=
 =?us-ascii?Q?/lBaT8/BdElr1o02+hCx3qtvFJyQL5Ht3np42zZPHYaCis+luhgq5DB1TQb9?=
 =?us-ascii?Q?aFRIjiOqsrZKz8GvnZIiC85kIRtRaTGA0bueVTW5ZT5lBY77dA8wdJG7lWpw?=
 =?us-ascii?Q?Qn2xpSYgnAJOsm4pT4HG3k5uyxmOL9WorbfzTj1M+CBqWzQUy6jzUuLt1ZYo?=
 =?us-ascii?Q?L3PVXXkTnB+BeO+DP5cV2Evj03+93iN5u2dkAoM25Ytw8f71S5KNMIwSX1qc?=
 =?us-ascii?Q?nL3u74EfTyqjGY52crH1kQxVjeF9q7g4R/QmiLs8zPTEQ0xEVjE4/WGZts3f?=
 =?us-ascii?Q?/qR6Pq+E0P1BWXOw/TwpKoHnXnqekM8NbL4MZcInYwc9QO6HzvdBuDZrnDSC?=
 =?us-ascii?Q?Su1Im/CY1WI4mXs8m3d139XY+5GspCBXpOjYxw18dCixCjeoAXRug/6osg3h?=
 =?us-ascii?Q?64qBxbdH7P38wHbQW9GS6YHubgU9XCKXnoOXYwvRVEGLr3Jum4Top8oZVclN?=
 =?us-ascii?Q?7DJKsxcy/RHT29gPNSm55gOxQOCeAwgObXIHlGK0cE0iI76w3ZhkfpMzgofL?=
 =?us-ascii?Q?L0ZUjFRWUBfpyj6ubdixUOttOMJHOo0BlNlfjv8H5CDcWy11oLsTaV8Cuyax?=
 =?us-ascii?Q?F8JDKmSXRT0rFXtffZ8R1u64hZqVfkJ4iKXhGwAEnh2lFRSd4cFo67v88w6P?=
 =?us-ascii?Q?V9RbHBGUzSlvQzp/LCQ5benYm90fOYzY579wh/deHRdZ00M6Q0U4FZbhpzo7?=
 =?us-ascii?Q?4iLC8M6qiCQGofNL1yhMhqeX+XN/1BJenEwTGqQCr7yaM+dnbUHXoiJQW4y3?=
 =?us-ascii?Q?hTWNo1jZEV6cs5JlqJhbGyF0+O890F3RHNtzF12J4CWy/QPT8NqmCQjpUCZr?=
 =?us-ascii?Q?8DpYCQhK47gWucAwvyjG99bsWdzB9kxok1KQIYT9bxD2FvbX4eqF3Z9e744X?=
 =?us-ascii?Q?Z+o7LRNNvgVgeSuZ4AdP9I0YJOxZwWzDXSNUWUqcht2OtwoPKlw5SA2feHKC?=
 =?us-ascii?Q?29WPF9hE6Fcgb1Ow3f5q4KF7x72UgCCpipDRbhgixq5+vLG4Aiictzd3ZWgR?=
 =?us-ascii?Q?Wq5zVddOap0ERMhNa2iIeaL4W0A4EoPKfuGdzadA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 682ef955-c3ba-481d-a15e-08dc192abea5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 20:10:56.0688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd7iRd3CR6qwWUJnDv2q6Lh9wIcssOVK6H9PMOCVRHVJb5PoktPCsPO/8P6IXxwjanLdHquREqogo1gD5b87EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8565

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Add the big-endian property for LS1012A PCIe devicetree nodes.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 2ae0daaa1a04f..5a6d4848fe485 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -550,6 +550,7 @@ pcie1: pcie@3400000 {
 					<0000 0 0 2 &gic 0 111 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 3 &gic 0 112 IRQ_TYPE_LEVEL_HIGH>,
 					<0000 0 0 4 &gic 0 113 IRQ_TYPE_LEVEL_HIGH>;
+			big-endian;
 			status = "disabled";
 		};
 
-- 
2.34.1


