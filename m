Return-Path: <linux-kernel+bounces-158049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F42A8B1AAA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D89791F215D8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981EE3D3B8;
	Thu, 25 Apr 2024 06:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b="P2beOp/n"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2041.outbound.protection.outlook.com [40.107.215.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104CF9F0;
	Thu, 25 Apr 2024 06:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025236; cv=fail; b=tfLBPB5W3uxXqWdI2ISXB/lDGQwj9NudLchy2/zRQoyjdBXAfASerJX9VaQiPLZ/cnGHpaR75JYohJ7cJU2/CyuPiDjSyRpL0/USLGuLS5Wzq5UUAHPnjntwoaKAfx94dkVV2qkX/ifIWEgBC/bR0K5ajlQwOpf+YFYUERvauts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025236; c=relaxed/simple;
	bh=XifhEpBBJ4VpE6V3L2KN9tkg2uDaONSfUkwFZyCc6CE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kL/A0xMXxUXdwT0uT2r07cJE/aORqRsO/4MmBEKcOGsHW1O1FzfZ6PkiFnExO7tSPM2At6ZB/vkj8BzjkQyVpwENwAvfcb6MwO9JkG8v7I/bgVJeYiQsvOQ4duw3As0j6F7vB7qMkJorEG30Hjn8qHh9zNY2v0crmAwE+kkCZLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com; spf=pass smtp.mailfrom=wiwynn.com; dkim=pass (2048-bit key) header.d=wiwynn.com header.i=@wiwynn.com header.b=P2beOp/n; arc=fail smtp.client-ip=40.107.215.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wiwynn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wiwynn.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk/CLLRiYnOgZJwBl2uqAZqbWqNVLUR+WY509WO/MN4vfZebdCQIMDxAlw6uECvPXkwdcL/InvffAplICQIqgDwj1NdY3ynhLmHkTKHQAVzCPBTwy+L8lJpnRVsZkbQeVg5XdwqdB0XbDmgy8msjJ/fixT4Ntg40990Q+HpObNMuaAoKBdnW2KqeR6EJ5UNC2PyoPRBvpTfdeL36Sc9U5kg288ZG5Y6rhkvQi6/io0T+kG8YDGPkiaADR1rBSGJYB4+un7jXiVSEl06YFhWWjAvSrH1TXaIrsqxdThECts//JtWuIM0RDfJMyFd9Wrob4abgsAasBqnNRcD2ZSgddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76ym1qanZjf24E0MQC315rUWdqS1IXErqE4QWfxXeYA=;
 b=JHyD2yLiyNTj+G+Mz6uHY+i06K1Y4g/VgSmj3Dp66fgbm05Xn3W+PMvrN1tA4Z3xZZfBfZFka3f58pxkQGp0sTQ9vTCxQK/SKMxsAAYHXZ4PrM/tZXwJnWH8CysqXlc09B/0VdtpKItJJiOpVZEBpc9bQybg3Yol4aT4USg892D3ilwK9Ee8LjFc0w5k18e5OVO29hsppO9a66yCGG9rXR/ln+cCZTc4aYsTUxRUkp4DnJnEWqmDffjUo2Hl67AafHpjEAJpYgG24IbIIoitHtwOY+3l1EhP9JVVflZstFSGiNxRfQL98fqLacHix2j5NXaiRA8xqPJVqZkRmKHtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 211.20.1.79) smtp.rcpttodomain=stwcx.xyz smtp.mailfrom=wiwynn.com; dmarc=fail
 (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=wiwynn.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wiwynn.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76ym1qanZjf24E0MQC315rUWdqS1IXErqE4QWfxXeYA=;
 b=P2beOp/ndSzDwzTHuAlF4tWhHaduqXVH+51xAA2Qwdmy9Ck4c8E36ntawpNz4FtV1cIuP/5Hlg+hCShKzwl/8FlMsLBFMkOERx+BS8gg2X2IpzJJ6LwpcZgrS7ivCy8WKZ9jF31mf8dhzyAOBXxd1LO4huOJhtUeVo97kgybuZ4KtTNf94e8P5jSD0S8U9w9ivoKfYtiUZRUbCgjml6XgOwOpE4UQ2ifVRNZUObtufm7PIwaBuV84RCxC22Q98N7JLITx1QsrhcWSFjCVPZhrs49bVh06B599+bHl9uyMmcQmO+ClsPWHD0HTt6AekEyR3Nf85eaBw3I74VW56CEtA==
Received: from SG2PR04CA0201.apcprd04.prod.outlook.com (2603:1096:4:187::23)
 by TYSPR04MB7081.apcprd04.prod.outlook.com (2603:1096:400:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 06:07:09 +0000
Received: from SG1PEPF000082E5.apcprd02.prod.outlook.com
 (2603:1096:4:187:cafe::f2) by SG2PR04CA0201.outlook.office365.com
 (2603:1096:4:187::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 06:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 211.20.1.79)
 smtp.mailfrom=wiwynn.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=wiwynn.com;
Received-SPF: Fail (protection.outlook.com: domain of wiwynn.com does not
 designate 211.20.1.79 as permitted sender) receiver=protection.outlook.com;
 client-ip=211.20.1.79; helo=localhost.localdomain;
Received: from localhost.localdomain (211.20.1.79) by
 SG1PEPF000082E5.mail.protection.outlook.com (10.167.240.8) with Microsoft
 SMTP Server id 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024
 06:07:06 +0000
From: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
To: patrick@stwcx.xyz
Cc: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Update yosemite4 dts for nct7363 and hardware
Date: Thu, 25 Apr 2024 14:06:23 +0800
Message-Id: <20240425060626.2558515-1-Delphine_CC_Chiu@wiwynn.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E5:EE_|TYSPR04MB7081:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 49bda39a-6c24-48bc-115b-08dc64edefe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400014|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kmfoWYPSXiUD8KsHUGsi3GpbkyrE3DONlnD6sh2urbhYM6aY1OQsoP4boevH?=
 =?us-ascii?Q?gtTDYgeY97NLcsgdsC4FfszCXfgNmTqIXRV04gFm4m06/oGx1pDitbAG9wV/?=
 =?us-ascii?Q?0RbHavulmYZjgH7G7zYmZ5A4DM7gJHkyw9NqiBajvYRz5HdrxunTU3VS1wMo?=
 =?us-ascii?Q?0j2vRpT8r/ObSlxfC0pUXeYCxtoLsA0861f9Mkd/X0Bn1JGTiqpYXvNRdOvO?=
 =?us-ascii?Q?lUhUydu0XCGJimEsunAQFWmeJYxEP5eyn/HmY2VHgBgpdDAcIhYAn4ihdyzp?=
 =?us-ascii?Q?A0I+oE7j3eELndJcfmTOZ98ryQMK6SSDq5QslqcsVgfZKOJMH4J3FTAm9dFW?=
 =?us-ascii?Q?U+C61RBwBsGxZvfXs+xD38e+Q5MRQc1UEJMAN3AFrnNwJot/t2Y6LEZkMViP?=
 =?us-ascii?Q?lcAjWcam1NiPu1Q3yz2rAbh9Yh3zRP0B72xXZud6ZDgNq66ykLKYF7gN7mBZ?=
 =?us-ascii?Q?zguKymoLv9GoFFotEuCpK0ReZdDM2fluuuu2WR5RaosHnvymhnnxrtgbm4Sy?=
 =?us-ascii?Q?saB89iPi0MVys2SyDgeJ5XXQJ8auZsRcXH361JDhhoSQe4dK7vbD1tDnysWv?=
 =?us-ascii?Q?WgwiJXBxn/v1lBMKDnjsMv7ic0YsbnnX/C62HWnICYL9o0zxDYzqA1PUPk8l?=
 =?us-ascii?Q?Nj7PBthJvZ9l8W3TRpG6KTg/i6lvovl10o/8jiFEvZCDYeuyuROaCdMsDBiq?=
 =?us-ascii?Q?V8pmjLxNGoIT3m/VdwgsudUmrD6yAUlBbTSG7xaGnVXskc2VKCLMqyOErZ0U?=
 =?us-ascii?Q?kPdO9+m9N/5+qfzOMCkCYKEWmPZ5fbMKUU7OZCbUl1oG/ZhuSPMxpL3qUH6+?=
 =?us-ascii?Q?sm9NJdgYEJJMpq/9UQ8X4wkEQ9aAnaPas9NOF4F6QY1b2n8UC3ikjXRNlMv2?=
 =?us-ascii?Q?J1X3Yb3UgGa1uhicjB8rqVKPzYB+hBbOgIY3nMIG7qoWyhxSiuyr2k03hjdh?=
 =?us-ascii?Q?xKETHU2tZua+2Whtj/N6SzT1xPL0NnxPsM+WL1f5BARaddV8m1gSonpLiuV4?=
 =?us-ascii?Q?K2uD+KGAilAsn2d+8DnwXxikM2DJ95Axf7yfF4zZGjr8/DIgjzPGpioCp0bK?=
 =?us-ascii?Q?l0cpD9AneKWuVCFlm4rUCH7vJOT9TYxmG3UGtVS7hZThq2/EJ9AMH4YuvMSX?=
 =?us-ascii?Q?t5oO/SNeX70pXh7jJdJON/GpuWv89b8MvoM1Xcma/8AZQwuqXg31eaDgZ8Ba?=
 =?us-ascii?Q?LvtWcAlqPnGhmo0JQV60sww/zxN3Q5Wcr1HhwPydZgf6pTcu6JPaaRUQZo4y?=
 =?us-ascii?Q?o1rdqu6dG2TJJttXIxVQ6lVIhVRCX5hGYeb6AOVJdJ1Fnmcw6Mj49MMWAz7m?=
 =?us-ascii?Q?5zEw8lgc1VNYK9n2TOZZaf1PS56UVbxIRUVtf1DnOLGaoUKBKw+OQP9Du0Ds?=
 =?us-ascii?Q?QPKIUFw=3D?=
X-Forefront-Antispam-Report:
	CIP:211.20.1.79;CTRY:TW;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:localhost.localdomain;PTR:211-20-1-79.hinet-ip.hinet.net;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: wiwynn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 06:07:06.7842
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bda39a-6c24-48bc-115b-08dc64edefe5
X-MS-Exchange-CrossTenant-Id: da6e0628-fc83-4caf-9dd2-73061cbab167
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=da6e0628-fc83-4caf-9dd2-73061cbab167;Ip=[211.20.1.79];Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E5.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR04MB7081

This patch series includes two commits that update the dts for yosemite4.
The first commit revises the mux and hardware configuration in the DTS.
The second commit adds support for the nct7363 device.

Delphine CC Chiu (2):
  Revise mux and hardware in yosemite4 dts
  Add nct7363 in yosemite4 dts

 .../aspeed/aspeed-bmc-facebook-yosemite4.dts  | 222 ++++++++++++++++--
 1 file changed, 202 insertions(+), 20 deletions(-)

-- 
2.25.1


