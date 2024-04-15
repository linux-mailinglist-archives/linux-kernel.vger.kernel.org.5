Return-Path: <linux-kernel+bounces-144910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 392FA8A4C84
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8563BB237E7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A8B59B40;
	Mon, 15 Apr 2024 10:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="O0LCBjKZ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2087.outbound.protection.outlook.com [40.107.7.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0BB58AD1;
	Mon, 15 Apr 2024 10:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176909; cv=fail; b=OBTYLbHlawoOPpLzkZKaGICGq7LkA7pQDRvYftzthJLWjPryCgmyPvDc/FVn95PuBorv4rOF+alrF5hjjI1v7RPf0SPeYOOoJBPAeVLAxQib2mTU6d+bbJhZtKOWuh+OqTG+gwkZAMMilMrLVbewBEOT6HOCA1yxArhqrjj7qvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176909; c=relaxed/simple;
	bh=wEKbzjGVLq1Q/4LaOSsV588Gx4OL/cLpZ0eZ5B/2MyE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jcGPQJOjSglbZgZgB4dUfo17u6n+HW53P455zP+Q53of1a8ypzRXR/HKlyc3YkfHwN1cm7i4eQr6kQ1tTehlP6X/keVGtMlaEgVLrjloWMJD25Bp+Wd6UFSlQ8lfz6PApsoM6cFBG6AaQCNLpkcC52sWBSTmwDx7OGaa3Lv+Lhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=O0LCBjKZ; arc=fail smtp.client-ip=40.107.7.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TBDcNELDNy2eXyq1hCXdzg/e4qSAMstiX4onUTximEouysTOfgoBTfRO74mG9HuS+9pig5kxTNG1vGcY7VjBDRVfBJE9fBy8sgLs5/Ll8gm929odGmiYEzVCmDAzI5Oep4B7o8zaKBaBVT8wRFBYuqo7uhnbEPf5zzaiATAYSuY0MoPO4RwfOqhJHar6ZeFRmiWMzuOjZ5qhrvEqC57PgQZ9zAyLmXFqu9ee1k4+xPT2WmkQDni3eoS91aRwZD7/u1s0V8MuknilNyYo/LKehu3ijKUSIS38+PadhItoh2rDbp1y6LciiLfKtlMKvL1OfIszR0HhqLDiDT7dqv88Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS8xZlJ0aMm73UmUIvpcSW9ZGy5YuyyuSPsRl/3thiQ=;
 b=bdw7xkJ5J0PVaYmAWCUJD5dbzy7XtyORJtx1vWBmM7kQSY8eO5B7Bue38vD6m6epn2HDmfzYFO5WqtorJicsEP2CponhGQHGBtBPvHh4MNRQw05FLdbp+I9AhKiIUN6Psuo97wS26aIF4jSdha7yxL/NG54oqFwzLAiie7mMAJMLpE/tS8enojCz+82Ct+I0IGJNO8wWseCRXiCyDcdP14+Z9q8Al1EbbBLlocENw5+jCI9YLGallgqcQHZ8xBtXV6iefJqDEip37xWOvI1bPQpOFolMmIy+BhFP23Pt5EZHKWtg8N4H5j9R6dK09JYmeLxvAs2w6J199nBBjYjXPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS8xZlJ0aMm73UmUIvpcSW9ZGy5YuyyuSPsRl/3thiQ=;
 b=O0LCBjKZCFYnV6v42vl2grS5qr41ABXuqIOweSwaQLTu6YJPAd1ZOD6wv5V/H7P+Ko9ah20/JpzHD5Z7EPH90wWlHpBDIPZr9Xx3oeqHa76iOuQD0Pme06SxYaHQiHrnC3LO1+4B6rG8WzTgy0Xw6A+5e00RLOPLU+qykG8LuEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB7895.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 10:28:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7452.041; Mon, 15 Apr 2024
 10:28:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	xiaoning.wang@nxp.com,
	linux-imx@nxp.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells property
Date: Mon, 15 Apr 2024 18:36:21 +0800
Message-Id: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0151.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS8PR04MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: 7167738d-9bec-4a84-d52e-08dc5d36c705
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P03QLMoBSwGVj8DWv6fyBVxWqwt0ndy4as24UsdV50DzEG+HQuka0ZVcFRH+6WkUzPLzpgt7VMcB7ntuJJ7RZC2XThJ/sq8Z3hbk/tap8OnjVDX3JKkx452VX3fmuzr1wp/IkuUuK6rWPcqVbCcnDHVMZtgWF8KolRkg4YJlNFoxMnLFfs/CyHO/QWNfEKtJqNqYPXff+/N+/GmhLt7LqMO90+9/EWPD1D9b2BCMPy5bRGb5rd+hf7LT3szJVpYeLV1hV722vHfrl/l7R3m1ckt/5x9Ds3+ciinktj6um+P0qlTWvNz56baXf1G/W8MJ6D1ndVHpSJDfj/1eAtAyf7+DzxOpo/ucR/V3ZIZ0QcYS/CWpr0Dq0E7bmrfpbFHdLZ8FFOBLvrO+/QpMmKntIcupfrm8I3svGWibDgSD7yfLnJRtoIjuukVuAWfVlgLvM4COaS7adoOo6ThqId1lF70EK7N2usX8AM0xd3AnMpJLDK2wmPlYdTHffY5k0upGaVQNs1vZfJ/uLKaAU9WaGV2408WZmMKWiLMovCJUm67LmkxNF/WqHB1waba4vVKb2guNq7Ls/byEFvLwhTDg+t6JRUWzcV2EnlReQF5sW3umnHXtzvEbBGo9B9zKJmz7LZw5QsM8kTyBqNivpOecdhCZPPpPUhlZpDI9kzjRfvtLm10mrYASibjkaxf/AcECirkjhgCkLV+xjveyA7IJp0imlZfhD+YgYOhOEQttj4g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5evUoYYQO5g0ISF1Zv2FVhzZF5slwvGGMYGG8v50nRw3Sc7C9p/GdLfKnQuT?=
 =?us-ascii?Q?37MWX0V3mVkhh3VKcLzE2eATnOiAtPvP9ah7n9+0LQj+TG2IiDfD9V5cP9Rn?=
 =?us-ascii?Q?GKqSFcwqC9Q+GvPDvQ7FuwLqc3hpHnGr8Big9f/Q8dHk0w69blgz2ArDc5IC?=
 =?us-ascii?Q?yjSkf57b0YhW+OwSdyyMZNzhMlDQnmZohKArz8dTkeSx4JXytf+mX3AKdiiZ?=
 =?us-ascii?Q?nw5bcg0vKlPrwalcMXMu12V7PiYcz5A5hP9EwshgRo0vvWQU985AlAZGsHwt?=
 =?us-ascii?Q?JYPI6nqkLjFJmAMEQASCu616lotI3/fHNaHGc2l621N5wUib94PJgZmtCMXR?=
 =?us-ascii?Q?eeNX+Mk/k91Z+qtZLjIOCUUVr9+C8ROzXvFCkXanAsvmNp5m3RlMySluR1qy?=
 =?us-ascii?Q?mok9tjQPV6GZFpAw/asFaVF39QQ1Qs+oMYY+JaokLIZLkXe7dgU4umW18Abq?=
 =?us-ascii?Q?Qp4h7BzcQ4BUvIqEazjMwgJKSNeJuQ/zpSXB59svxbOqr8Pb2F1nGfFm5LYd?=
 =?us-ascii?Q?seo/nVi/lv6d7TC7fHeElz2zTaBt8goPvz28mYTZWPyBb4kQ/BGeCSLrwlvS?=
 =?us-ascii?Q?NtFyTj7RBsKUb4vgAHG0fr0QWGxDYDZPaMh9R5hI/mr+6BGmwyk3T3fqZJBa?=
 =?us-ascii?Q?oN0a3U/8/BqSN8DIogDeRG0YvF26ywfB8GK7ZHoTproTwsRZ7C9+OWIWPMR/?=
 =?us-ascii?Q?mrjIuwGrpzbNZ8cN6674HuDmNj8D25LO7NmVIjOlIIM+wuAlt4RmH90z8kEQ?=
 =?us-ascii?Q?TR4UQ595fURZMRr3bb3XoQNxXI3P/5X+Xo2hx+nxmjI5YgMn96OUH2+oYion?=
 =?us-ascii?Q?uX+IMT6EDb7mbArCo2wUL1VEorBztjyelRnM3RuuVHX6NqxvQPDd2eIlL+Cb?=
 =?us-ascii?Q?3ACL4P632RThneXvEYYF6XoBRjUzwv0/Qh6zfb3OfeMb4Z4840l99vAiNZEv?=
 =?us-ascii?Q?FwkRh8pPAe7ut4ktor6rv2zKviea10o+Eckh0pwJE6ZgoJbcVRewbTd9h/eb?=
 =?us-ascii?Q?GEXOtvmPjUGU6i7WmQHnpaKr2MmMwM4ofl1neHxNSC3++j4HjQML8zwLPX0I?=
 =?us-ascii?Q?9vJTNZqOJE4fWZe/RxxDzPDNYCBrHrDQj7iPpPG8nNpiDy9Gov2m9O6nsY03?=
 =?us-ascii?Q?1wSYd0xzWv4fo9oaIoaao7AwUiA1122/a75WZsksJawDn1AAXq7gnTsxQVQB?=
 =?us-ascii?Q?QS7wBIlTHR61rCl/n3uXd1+U83SCRB9eQRzTlNsV5nY+PsdlwYDzXQF1CBOo?=
 =?us-ascii?Q?E4klw5D1zzPylO/JTZyKR9BeCcRomybOnadFzuzMP6KxuZKFyX75uXviTEu9?=
 =?us-ascii?Q?lVInU6ncWAn5mIpXjvm6TPBKRZxDb2rSItEmtTICJWJt2ZMUOmftzaJWaUNm?=
 =?us-ascii?Q?sH/OCxhEzpZ6blY78CY72fWlsszm7M9x9hLJQSpkR+4P4ngDoCpfk7OW4K4D?=
 =?us-ascii?Q?lUDPmHk3K8wgk/NFcgIIKM4ZJCdaypAcdI7Mey/oAW94VrRpNBaCJDx3K8au?=
 =?us-ascii?Q?NXn6T/t14ebkjLwXjUWHLPVWr6FgY4I7+/pGhTS/lcNuWM7nWFBTihLi+jSz?=
 =?us-ascii?Q?Z+ACPTOl1QpRgYaUJzkCDytoB8jPd2KVmGiQSYbd?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7167738d-9bec-4a84-d52e-08dc5d36c705
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 10:28:23.3066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpBAJiGPCqZxnbcs+SSz9/eVNNtMAmAfCvcAFClRBY2ochjZEjRWaXyLa0wBwKlvLmxJMx5mBNivWoC+SOMO4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7895

From: Peng Fan <peng.fan@nxp.com>

Allow nvmem-cells and nvmem-cell-names to get mac_address from onchip
fuse.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
index 4c01cae7c93a..87bc4416eadf 100644
--- a/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,dwmac-imx.yaml
@@ -66,6 +66,10 @@ properties:
       Should be phandle/offset pair. The phandle to the syscon node which
       encompases the GPR register, and the offset of the GPR register.
 
+  nvmem-cells: true
+
+  nvmem-cell-names: true
+
   snps,rmii_refclk_ext:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-- 
2.37.1


