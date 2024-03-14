Return-Path: <linux-kernel+bounces-102741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3445F87B6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 04:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56CD51C20B14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE7523C;
	Thu, 14 Mar 2024 03:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Suuii5eV"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2076.outbound.protection.outlook.com [40.107.249.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BFE33F6;
	Thu, 14 Mar 2024 03:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710386488; cv=fail; b=K6xIqZ3IekQf5ZzqObFr5e+69fhSh3PjsE9C9ywffdxfjIQmL/DjGrkZnvRbP9lhjXI2p4SKVqDN/5IqGh2r6XuAHASCVEIuQekjZIxnz8hfw2j5dJ5RUjYrxb/i/Wa5lMuYKzjS+s4BdQvY55ypbTiVU6ISbsszyvkH56/wa9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710386488; c=relaxed/simple;
	bh=lyOC/AicWUNjYHRu6IwVXvsc/Z/LkmDJB/dgx+brg/w=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Fg0k//NleK5B4afPRlJfb4GBtkLhBq7sfMcZdKrkYKCF1ZTDWSLK36FrxC6v+BJtboaE/Zyci/EirDp5Kqf0v7mYbqJLoKUct2Uer3ogzaQD3jS3i9tJdTlImsT5Jadfmr4Iaz3nQc/nwxbsUEJa9dCm/2jwUmMFzCnD2TwLWCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Suuii5eV; arc=fail smtp.client-ip=40.107.249.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmRat4AxAblVuixFYFVME9RtUUVBBjjhchi+xtSqZmoP2nLWgPe4ak3dmHHhUPAYhwFyZ8gkrC4Rv0BJN/gU7RocaIZz9c8fukfahE5LQVtDi62cqedfLf+NkdNOEGZgVeCGeNDNLmKp9j6fjyIeXWoeUY5QJl2nEg/31RRLvrDYfOijNaoJsXT+YcIKiOs0ZdILCcqtwoSyrOLSUJnEiJYhUAbPtGbxNmYy5E0GHIQDu0vFtGKOssTURdtpvloLgIR3l/OEyeRCCItbfvi9Hoks6AbkQ9eb8YFLQNOTeTwpIimRuMUQRBOGZ+M26RPEN0zSWCmiScxVHMHKDiCtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WqKAEmIOvshZwrA8Z0TWRCT8HIhVA0ftPp43laegsY=;
 b=PHm1g1gvQWH8mpLSEUGjOKWTL8i9UkWva5Qfa28858LcTAuSr6fUJbom62Dvg6LOJK6m+7NzFeotpqF47ORKKsa+a/9VLtZiQPjzUaP3kX9uadJXw05tQBsK6EkwJgq63zfRMyZNcdozImAtWaHN8MVxXIYGWaCAnBKW6VsKqAstlFRDi/hukHdDv9VNjr2Y0YZW5hMb4UguLFvvxoxfOjVeCa4Okr09pJse9RqQbt4uz4p/hHSA4sjV8ZHaV0tCGxr/ugOSyTkXbDgw5WTPL4XvG5FFW5iaLMotvZ4n4WsjcIjE5PnRi40Xw2M408PRGQVN0aarkVrJ+Y8NWquRgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WqKAEmIOvshZwrA8Z0TWRCT8HIhVA0ftPp43laegsY=;
 b=Suuii5eVoFXzBZjRWLJcokGcs1sf23lDFuLL/UXN9OjPVrb7AuEoz8R4BY9ohj6QfDgpntWTQ9Cg1f6pR+se0lJK7MEwkpQDzla73/VF1en1xiu8N8emQQVCgvn1tUOBIgmFC7AAWRBawdu5LeNwQ7HddPBR+lMX9HwwF3xk08g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 03:21:23 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 03:21:23 +0000
From: Joy Zou <joy.zou@nxp.com>
To: ping.bai@nxp.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de
Cc: kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 0/3] add pmic pca9451a support
Date: Thu, 14 Mar 2024 11:29:20 +0800
Message-Id: <20240314032923.2360248-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DB9PR04MB9377.eurprd04.prod.outlook.com
 (2603:10a6:10:36b::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9377:EE_|AM9PR04MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 60c7ee7d-723e-448b-f9bb-08dc43d5d368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	krill3BiuKQI/yJD/4DDjnNeA4JuwSAVl3ZwWmqtjxTIso5lfNaN9VQzS68+PkpeviODG5Izy+jFQ8KABG2oH4nQCYi6jBzHg3vTvueDUxlM+AJJHUdSiF3lCgFQf5k8N9Lr13NKx9SGA2F/oHgrKEEMZMky5JwiD8N0GOpsmXXDTnu74bIzF65fcjlKRIrEuUn95Y0TPWUf/0BNpk6lxu1k0n8TDp5qUqbeL4OgweajLyZijWQydyOZIssnktmiFPYWURyvYnU2/SNI5vcBgpddB6GSx+s5yioKnrlktBaBk9LaCdp6r5Beqcz1sFNzVXGgocFdrLBX50AMeEMvtlJbEmHCricHB8gXPdpSt8dCVYdER+Buw0ByqxzyA4dsJ9eHv/NNRQsShQcAMZ5nTPbC0Zmhfbpx0d0uAJDEg9GYTt+eZQqoPie1Few93egkHPQIblogixSvptLWUKCaQOJiuPv+pdD2e6wNfjXiYtBTv7PrVpC8Zje63gfyt+rMAvPFprLeC5aF80aqUvjoZaZMnBIWyMMVgA3mubpjquwnRve2EtRlGrziDg8wrnF7xWIgr8Lxdgpej9t6yIQD8A2vM31hai9Wf4yAycGnGPLJqpWHs/Dq6ZhZQJ37cAvr9MUBpCOl3gNwWw/YBlnS7GiKHDTAa84GHVqW5eRcHo1E3ERZicRxr0zXjckybr4vaOTjXKqFz09l6H+j+nEhKseiiwE88VH+cCSIO/BAujY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(7416005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bjW1NYmqrwqPug/kZ03xq3Keq75Nl91QMmdBQI/hr0lb0FA2q8d++K64rg3M?=
 =?us-ascii?Q?m9sDmsohmQC5mQMJHH2nwEu59hEYzbAJUStO59qIfqZ/PsJXiF5nedlwq+Rr?=
 =?us-ascii?Q?zlrfG/ddJJELOWJO6gp8+2Ovx0E+xWdex4tQAZX2gZ03uke0BCwMWUzR51az?=
 =?us-ascii?Q?EwGwGzBQwh1p0zhQ+Y5Sdb0kWTK8V6C7D4t2Ve8xjJg/zJzJNeGti4qMAaYW?=
 =?us-ascii?Q?PUN2PlNx1ZTcurRbmRaNoh6liqLaX33+U3LKjE1s4s9Ayfh76t8PTv4uARxd?=
 =?us-ascii?Q?ZG6jKlykb3bm4vSLhS50CqyKbXZqKyOJBS6J58FUKJahGIFxz7Wt8ezBxifa?=
 =?us-ascii?Q?HPbvuO8y9UyXolV2DtVNfaMSAxSxXwBYjZpguRMKAVmtEdXTzasIBnYfVaqp?=
 =?us-ascii?Q?ks+/Pl/OjrQk1k+/PnCPvRCpNot2kpkv92EHS5g/yoGTftAWpGi556X8HHO4?=
 =?us-ascii?Q?oue80NbWlnUgVrRaaRKoVubR3/IujM/EfWdl0dAVhuHh+xpN3H4W3G1Gg8U9?=
 =?us-ascii?Q?3sSGkN1xRa4EhYhmj/DDIuW1WZ/95jiV/JaLAOjZv2RojBmwH9JL+vOBDCfS?=
 =?us-ascii?Q?kJ6NQpV8SxBxIC6IhPk5VzokcsAksua3g248E0V1ZgNoyvh2qV2AFoA7s4Hz?=
 =?us-ascii?Q?oduTjYeC3r2EAwRRImAKHYEi8vXhMrHlub3kuyxtMqyoBFyuJ/vkrjMMIhWf?=
 =?us-ascii?Q?FsbGLTjHVPYzlvmyojUppxOz+A1HqrKnkJaOBQxH+wGKo0txmmRTCwSr6UAD?=
 =?us-ascii?Q?x2hbRtkTgx7rR3BpuDNKryba9d3ndoLsAdTblikvybiqF7Ts+DURC6NyPCt9?=
 =?us-ascii?Q?Jy7ae3sV7rzc8psdAmDOTNfaunncMnJQLAb3CIjgv1SXIusGlNh5FyvUOFo5?=
 =?us-ascii?Q?WtQZsFlu1d1C8Rzucs4ops5eUQsh1B8pXY2Zm52FGUddBkDKLlxyWvDmZdLq?=
 =?us-ascii?Q?g9UYCHGNB+xkvl4/LwmA2+wXr83Xjbx36NpYdemHSftCXYI0xlMT5PzIdfmu?=
 =?us-ascii?Q?tjrjvkJfVwwNEToLmGEroriAD0Jf2L/VDW4XwKIGr8qcu0/pVRcRlXt8H8Oe?=
 =?us-ascii?Q?REdcWHwa/3Vj7aHc9sXqD3fSC5r/svO1ffbNHfu5ep5bMHPzRlJVuFATIGvw?=
 =?us-ascii?Q?znv3ddf7UL24/uZVCIgPEwVl7SEOAu9Qaugx4IXDaZdh2CcYpNjzmug6SrRa?=
 =?us-ascii?Q?NeyMPCvs9SFrW0sVBU6kkN+njyfijWB/m/ULTltOPYGTV9TdZq39idqri2Ej?=
 =?us-ascii?Q?x4Ok6NryyQkz3SVDT2qNSfOdzGHGP7K0BgxxRyDrhdwi77Z+RQ07lIDN92fn?=
 =?us-ascii?Q?zWHOGipdUaZfRqcRBbL6Az1K5Vsl6AYS+LBE95uitUbhTbe5WDUmTWfyx1LX?=
 =?us-ascii?Q?o9Q/T4MgjnjoyaRN9VZkm/KzkckaypCqUG2j4HAYt5Gla3BAANEWpBCAmcWk?=
 =?us-ascii?Q?95acGhsNC95jS5jsJTPPAz25M7lqVncd9sU5LfGupQSFHCbaCXFDq8gCqQuV?=
 =?us-ascii?Q?OWRf9GL/U+NdBmi0ZGQ3d6bsRuybVUQMk5p4kwtwpREf+hGZfhtaC+UdihgR?=
 =?us-ascii?Q?i8NfasXLKSoiPXshRNIlmjx11n9AugxnaL0xzNbP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c7ee7d-723e-448b-f9bb-08dc43d5d368
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 03:21:23.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tkxAB7BF/8SF2P0yhXuM/m4BAJ1MSksS1jzluf7PaY05+QHOMkAG4zDL6PuZgCN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570

The patchset supports pmic pca9451a.
For the details, please check the patch commit log.

---
Changes in v4:
- modify the comment for uSDHC but not i2c.

Changes in v3:
- modify the dts voltags constraints.
- remove unnecessary changes in driver code.
- modify commit message.
- add tag for dt-bindings.
 
Changes in v2:
- drop old part support.

Joy Zou (3):
  regulator: dt-bindings: pca9450: add pca9451a support
  regulator: pca9450: add pca9451a support
  arm64: dts: imx93-11x11-evk: add pca9451a support

 .../regulator/nxp,pca9450-regulator.yaml      |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 112 ++++++++++
 drivers/regulator/pca9450-regulator.c         | 194 +++++++++++++++++-
 include/linux/regulator/pca9450.h             |   1 +
 4 files changed, 306 insertions(+), 2 deletions(-)

-- 
2.37.1


