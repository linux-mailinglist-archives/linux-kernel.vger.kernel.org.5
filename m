Return-Path: <linux-kernel+bounces-32595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF262835DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28BA1C23E0B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A6F39AC6;
	Mon, 22 Jan 2024 09:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mNaj1TII"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2074.outbound.protection.outlook.com [40.107.105.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AB939ACB;
	Mon, 22 Jan 2024 09:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914668; cv=fail; b=hPuUuq9MuUqrRqj4gh6uB/ZkvJcloP6vNpEWSYTbpNhUOjxFeheaqc9W7XVxj9V3kUannTNJMPAI+WMrRzUqzPu8xvxaBBzhXbYNDwKaeRvb4kvCv6F6REr//TU4V0OFQHaQhdPcAA80Y4kQIST7qOSNrcTL+DTn+ZONjuHf3Do=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914668; c=relaxed/simple;
	bh=8aV6PuwR/OmoUdKSb+tMaDwo10QYxq4MnIs2A/LQCfo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RKHHVmbU9kFtAEdXHkaTWMw/FbaVSLT1dzdz0fdyVv+j3JvLuEbQwKBznaAHvn8uB6f9jwWgyEnT198JFQR2dIEBVIzrKp7tleUbzHyl/hok8NaUS69FIW3oiJ5SyG74hfdB5tC2eBW66Fe31N4udh4T7qINezXWr2/XQ82Gsq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mNaj1TII; arc=fail smtp.client-ip=40.107.105.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrUSASjXQyxvBnDemRsxLi/fiXHF68O2w3DZCywJYiqfC7km2mo/T9IWSVmbnIZJxMqETB23ENxYSQ0M2j4PKfx69eUH0nP3QUQ34cuBcgxWHwOKELLUhoMV2176YWJ+gLhUph9i82mstoQ0VJ3XiWZmXsm4oYfuSNlxb4ZYZGqyT/3iDZZwqBCbFHP78jfq9TBequUz7odE0rH8Cz8p/mGhkjqF4XM3xa35kja9L8mCXMT7zATCiV19vbOqeeWrs70y1MFdzjUpapZ9mZZJCw/wUTCgz2m+K5GS/bmfK2T8vnuqdMaOEZOTJVwx7CvxBnzfD7oyqpBwZITd/DlMIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/f62LruR6C1nzNCqc/DD24uZquBGCB8d8Z1hqQq1mE=;
 b=l1GyhhblNi4nBZUliEb7xFgRe6wz/G6tJrVS3CBzlfITGx53GUav/OrW0/3EsoGdCTC2RAYDx1prqAyLIHNuvef5rajIUZC9etvxW9o+QEfVVb9CawDgtnAtZhULzgB17dYsf/yLszD8+rAEslbcthUX9o+MACTRjelW0npEZTRXRNOrhwWihHxES6+AgZEUQVqLvbnZpKzX2Dx2JifsvHoFU57riqX0GateOLFwFVUo6dmjHFC8u2jnGb09NCOoOnL5jfEqtVH6/n5VChNcfpnOzpCsjNEaSlKdi62jW4Kc7NJf+F4P33Ozszkj/+KmGJaYegwM3lpkx2XSE9L+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/f62LruR6C1nzNCqc/DD24uZquBGCB8d8Z1hqQq1mE=;
 b=mNaj1TIIpB/Bi9iqUogbnyQIy0cPmgz5m5U2fh/O9oGtP4H1hvIX/oD98mlA0yHEYWmvnx0zu0Gh+sQxxeR13+UbzXKTbT8ZInSJLJJ41n/fPeZ/5LW1ebgNQoobtDEWoIXig1K7fTmR5w7MlOipoDT7UxVTQychBGGd3BrwTEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS1PR04MB9333.eurprd04.prod.outlook.com (2603:10a6:20b:4df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 09:10:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 09:10:57 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: broonie@kernel.org,
	conor+dt@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	han.xu@nxp.com,
	haibo.chen@nxp.com
Cc: yogeshgaur.83@gmail.com,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 2/2] dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95
Date: Mon, 22 Jan 2024 17:15:10 +0800
Message-Id: <20240122091510.2077498-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
References: <20240122091510.2077498-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0051.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::6) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS1PR04MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: af4dc1c0-c825-4a70-8a98-08dc1b2a0b0a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pZ3AhtiKTz+zsTD9/N7NyjWZbh9WeLFj6/02FyGl2llf5ayKB26xFqnTWXUDkwQrmrAQDCOtBMFYzDwRJ9HlZfsYWje3nDqjv1Qit1bg067uONUFJ4TdRvycIw4QYt4nSXrpkZDMNbp+4BnWH+1HjyX0N80EPcsRBl2TKLRl8N5Vr+/fXUgbIrKGmD/2wVpch0ZXTCT+c11c6c4UxrFlnTJnYvP/6lhUAl0mh+EQDRJ3iCXtu6Rfs33osCg9Ct5ZpBJI4/WBPuiHjbeH9ae8IkAugWvYGvBuuhQuKHEaf+aJcT/zyRKV58Cn7rxv+saxhCoYCV3xSf3cjVrp93I2xh/+1vGvkAqJM8c9JoTxv3IgGvcTsNFUSrAppgf5oSUNbufpTDsAFXo8neZSluPubOng8PKzlOW6Z9cNqp/YHXRb0ylLRy33BqqcwmtLbFj3AtPMPzD2Dj63srlox+1m3Pr8kzhLQWmBVw5hr2sruro8WVFg0CY7MmZ0/GUrUD6Bz20rhi8HIs6LfOmm2IIlY3OuLzrjNw3KxWQ9WFOYIFiWazPieBtx0UJ18x7JPrHDMd9iiZHbTTl9jbiK7cRSF+NWf+u5SgVKiaybsDZUk01r78nBNahf2fOTOPBhHy47
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(1076003)(6512007)(6666004)(2616005)(26005)(6506007)(52116002)(5660300002)(8676002)(4326008)(4744005)(8936002)(41300700001)(2906002)(478600001)(83380400001)(316002)(66476007)(66556008)(66946007)(6486002)(86362001)(38100700002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eEzmKOXnQIuVvDZ4T2F1tERUBLuVHCZmZDnhU3bul77XG5sxudAwDYzrMuAh?=
 =?us-ascii?Q?RMxzdqV0HN8mpPJEplEVDy2rQ8wtHmA5YnCAeuLlHk5wl6OV6FimuD5/80X+?=
 =?us-ascii?Q?OUbhpmg4m7cBTYVAV5Raa2KjB+8YmjvtmjNGRDEvnwrjjhAj3pidkZ5apyHL?=
 =?us-ascii?Q?IRkfE1zuorDFUlsSTunF+ovfM1ljJ9TKP++Zzq1n3PyobrAugsQ90IQyzVgw?=
 =?us-ascii?Q?Nuyz6H1bzzLVbS+bCCigKaDbsThfVCUxWLVQYNUre7wLmjQZ2Qpl0/JU7HCS?=
 =?us-ascii?Q?0PmxJlrqZiO2E16Mabx7l2GmItKB2rQC8fXOhdeDdZlyq1pV+loT4ERsoMrn?=
 =?us-ascii?Q?7NphYBK9GY5jc7ZyNYsqaQl7BhC6YHOyUgD0rCrbRpvHj1VQs5U8/37MWQCR?=
 =?us-ascii?Q?nJLrY9aCscTlHC6rhDsVdNcQ4GHcEYD8S2XbJeV9mY7zybDuoFxOlDsNId4v?=
 =?us-ascii?Q?d4KDcqjCWd16pTX89D72mhaRHv49czwfLOgexUnVqYvS074tIa+8T69bLUDD?=
 =?us-ascii?Q?sIFSlUO3v+7q5sxEZIbMVrpIm6ka1XC2/j0sedo9IPx97YXqBtmn7DBhnISk?=
 =?us-ascii?Q?f+k00MEPLY9dgXneJqJdk00cMX8T27OF8Y+G5JfiN1ltR7/ggxFFCV4+J0r1?=
 =?us-ascii?Q?eUkWwFZYfK26jz/fhOuDzwL1kWwam3Uchd1AI65FHIJgb9ue/jC65wGaJpbx?=
 =?us-ascii?Q?7TXSljfvnasqSLYd9SZjjqPCUXJwAnQJyvUQpmsKAQ0e2Q5y5k33WJJcgdZc?=
 =?us-ascii?Q?QBhgs1NFksbKjYNX6FCk/M2XQtsYtlKeraai3UfVT9JzOv67ddwXpvgws8qs?=
 =?us-ascii?Q?Jw1XWfR3Yu8uPnHBmobeTPPRE3GpnjUsav9CnVVOWiZ0hsaOYInXr3OZ2D71?=
 =?us-ascii?Q?H0m0U7i6DlErM4RSE/2AqqNaQ2MTTb4vmyf9akJsLrrO5ZJRFjjV2tC7rScw?=
 =?us-ascii?Q?lj6K8j7HYy9GQL6505hB/iOse/pK3hkp4mbzRp6oWihvgSstzgAATOGCfU2Y?=
 =?us-ascii?Q?C25W6YqB/orweWvnXJzOrOTcNKdqZIXtC1awyvRAJnkzw++obNJWb2QZfH4e?=
 =?us-ascii?Q?Pk/IDqKpZFZ0c5osGWFSLI164Y1zQCsMruEIU9ID0/5kiycMvG3eXst+Q88l?=
 =?us-ascii?Q?I8wA0VKNwRtdWA+Z+IeznKBr1yHlVmSI+Zgab3ttz0LXt6YzVFmGHZ7FQA4Q?=
 =?us-ascii?Q?0iXyKGxEbM1AvXnvVjiNEklIiiuIw2YMPOqdQht0v7zH2xnGBRfoftDUcBHj?=
 =?us-ascii?Q?R/wQmJ+XkaZmtf16RZLeZsuTC0iKjQQWX9ZPSiW0MWbyMwSchIAMCQlSpVlP?=
 =?us-ascii?Q?hPmp7LC1XO0Tu8TiW655JEvngR53FwFT3aWmMazL51JVU1/9gEVnstyPXMoj?=
 =?us-ascii?Q?UrzXD6PTwuwTA4RLdV4keXu7ARbk50THacfvJvzOEPWFkn+lwUgDruXg5LhJ?=
 =?us-ascii?Q?iLJiIgj8dKdohQzbcoiNsDxlKn8S+c1ZDjJLP7Gjyf1B1PqCRDLBV8yynqt9?=
 =?us-ascii?Q?0gmevBXiaHuG6LuEOKACM6DtZcyAXyP+/mHMET6a1kr/FlyBQP1XNBlRV4Qc?=
 =?us-ascii?Q?4Q9J1wyYVPUpFzJNn/ev1P2vdJh0SQvCaZopoN/+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4dc1c0-c825-4a70-8a98-08dc1b2a0b0a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 09:10:57.1119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IZeSY9mV8YEn3UjTPC7bFNF9sCx9KvGC3KbsN1M/AtBctx24m4mw5krJ0IgxManVP5+nu0MpbUBt7sq3bKXEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9333

From: Peng Fan <peng.fan@nxp.com>

Add i.MX93/95 flexspi compatible strings, which are compatible with
i.MX8MM

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/spi/spi-nxp-fspi.yaml  | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 7fd591145480..4a5f41bde00f 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -15,12 +15,18 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - nxp,imx8dxl-fspi
-      - nxp,imx8mm-fspi
-      - nxp,imx8mp-fspi
-      - nxp,imx8qxp-fspi
-      - nxp,lx2160a-fspi
+    oneOf:
+      - enum:
+          - nxp,imx8dxl-fspi
+          - nxp,imx8mm-fspi
+          - nxp,imx8mp-fspi
+          - nxp,imx8qxp-fspi
+          - nxp,lx2160a-fspi
+      - items:
+          - enum:
+              - nxp,imx93-fspi
+              - nxp,imx95-fspi
+          - const: nxp,imx8mm-fspi
 
   reg:
     items:
-- 
2.37.1


