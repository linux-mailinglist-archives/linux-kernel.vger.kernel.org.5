Return-Path: <linux-kernel+bounces-167275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588488BA6E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5D21C21FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 06:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3E013AD07;
	Fri,  3 May 2024 06:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BHgA5/Nd"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173A213A899;
	Fri,  3 May 2024 06:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714716373; cv=fail; b=PXSvtyS/vDItwViJDVJyInxI1hh0vksakpaMsuwY8zxNIJMyb8Q8wuNdhti6IDybwgf+1M0fZrqj+OFHQqMNqL+ctenadObAiWtIwUQLkuiMk9tIRcvE+sLmK5mBA/8OGSrdKubK4+paSNrdzHyWHwvxafm8uege6icjc4jt9vg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714716373; c=relaxed/simple;
	bh=EPPtClz1yWTjgc0nBZnz4chGEFTibrGR91gO/XnAsb4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fmnXFqdQARZkn2OKb2r4naoXNwBjowOe7I5m8TQ5otbys4ASVT1Fac8AeD/e5orBgguDDTLfMw6urnf2Ckp2VzWTBlYacw4gx6CAbMVj2UX35c5+HscPHB+OgWQO+S4k0WA4O0d280NGA2jSp1EM5oSKob6LSMd3XDD2w4J1GDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BHgA5/Nd; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTPWYxOdaG4/WxobSkIFLUo+5ivrLiJN48dOIAF+F7+1/ax4/nMpNZ+pNYpvl6ttpNnejLmbT+MInfeL/7023hYiyQo2M/er+Y5hVrqhrZJbwuNmUFqUp6QpIDlGDGzXGtnSxmp4eoOn+gV/YbunMUb6LZdKJMMZPNSZ+UEyVFmwoBYVJY/4EdU3zCH1iXG0vPFkh1mgatIpSha5d/rIeDVtWd+5aDNF15bUUk7oU45yZGRd3srgf1wCN/tlcaAfaUPZBWr6hhaDJzsVeVzdD/lqsMeNCKWwwEqrluA8X6bRQuKMdUfEoB2Wj2//gorh3CMoJ2TcuXOckhv+HmCfyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlUEZrg+1RAu3uwa2B7oJ2UP61PK9Ey3V+7H2WbGrus=;
 b=XoUcbQIx2IX4RV5XwI+UyJYC6OPHhV3/pem1Aq+mwwpl4TXXDraKJ+Px9Jwx800W7n7ueHLoDHlo6E3CaRaMKqKhxuf4QL60AFxVw4AfVMfodcygFKeaB5iP+DbMfx/90/kGus63jRe0DRFDaF/DuHNOzvSCQfLyft9xz53hJsskgDlXCq/xjCV/a/x+sUGxwtry9T2JaazAjUgwQiQxuhPDhsN7aA9rNzhkEIQlJ9UFzgV/sCNphmXYwv179RCV0t2hGb2CDuTji2S+DNq+EPCW6Y2joT9TTs+NAwlLK0gx9FVDKn4Zljw2/DS5pxt3mud5Pwa/oTVVSgkWRMD/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=pengutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlUEZrg+1RAu3uwa2B7oJ2UP61PK9Ey3V+7H2WbGrus=;
 b=BHgA5/NdCOW52/qOvB/qFpskhehnGe8PyeZBI9pSsWFVSH+s2VMglToTCYDt+LJkm5tPuBigDT03NK1GUy9rki8nMz9Ut6q8sY9ebiHJIE4b+67zvKNjDyYjhHRQcn15s+EcxPFF9tmu+1jdS2F0sNaBJye6otxl6ZKVW22UKgY=
Received: from MN2PR19CA0063.namprd19.prod.outlook.com (2603:10b6:208:19b::40)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 06:06:08 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:19b:cafe::92) by MN2PR19CA0063.outlook.office365.com
 (2603:10b6:208:19b::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 06:06:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 06:06:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 01:06:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 01:06:07 -0500
Received: from xhdharinik40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 3 May 2024 01:06:03 -0500
From: Harini T <harini.t@amd.com>
To: <mkl@pengutronix.de>, <mailhol.vincent@wanadoo.fr>, <davem@davemloft.ne>,
	<edumazet@google.com>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<appana.durga.rao@xilinx.com>, <kuba@kernel.org>
CC: <linux-can@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<srinivas.goud@amd.com>, Harini T <harini.t@amd.com>
Subject: [PATCH 2/2] can: xilinx_can: Document driver description to list all supported IPs
Date: Fri, 3 May 2024 11:35:53 +0530
Message-ID: <20240503060553.8520-3-harini.t@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240503060553.8520-1-harini.t@amd.com>
References: <20240503060553.8520-1-harini.t@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: harini.t@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: d32858aa-e640-48f1-d0f6-08dc6b371fda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QNaVA7QkCEZVYzOxMo0oCPokqBCDhErj5zQRMLD+2sIgSe8aHTHpFDnr+Iv4?=
 =?us-ascii?Q?gt1mmcME6ofMn8m0MPd3ot9zZbO+masfEZLjpAx7EzQnTobvgWOviVH72fnW?=
 =?us-ascii?Q?hqbJG+CxAw2H/zFE8snEFRqWZJfgQRZarwgz0nGuWKewM6tQxw2bJG8Mxytx?=
 =?us-ascii?Q?zu7w+RHlNq1RKa4y32urfSSXwmElzOTzdt9twWNCFy44qxEcAV9KY1i39vOC?=
 =?us-ascii?Q?cgsz+qsMQJ/j+f/2IPDgOJ4YH1M/iXF99leqy4rE+NisIc+Z53s7a1mfLe6t?=
 =?us-ascii?Q?dTK3fSxW8cKFO/RAZeBlIooEw484kHOMQbAdxTmTE+acwVOHZKK+krTsK5q/?=
 =?us-ascii?Q?3LIaH+xwjRvo07PnIJm1drK3caZ731qBzlJ7D3U8i5SNH81IAt1+hWnPam4P?=
 =?us-ascii?Q?PpD6nrLKlKkajYGbh9qiteWThtHgFWGVyF8kH8zqmlDBWgGNQPy/6kWh073o?=
 =?us-ascii?Q?w5MDoR3Zmq7NwlVH+i9HYP+OgR/LHk7XVMGQmXIA1WFatD52+Ah+kbnLewqo?=
 =?us-ascii?Q?W8hsSFrV8pGU5V1trO5Llu3qQO4GnSfZ/gK8wP6KhcmlybDNmIJ3QFou350a?=
 =?us-ascii?Q?zUKeaOO3Dg+OKv1du7jCWwMLcXv+hwL5m2axWC3KB3HTrv4nsZl6U9doTzpy?=
 =?us-ascii?Q?XyXDqycT7iru0DdzG8n5MuS9rG2waXKDcKYmiAzYfFLuVLpFzdxJn7qxZnF3?=
 =?us-ascii?Q?0//Hnao4VBws8Psp3M1yBDTzpQ4JMKkgdKoVj768rlpVxOLEV+F40GqDr7lz?=
 =?us-ascii?Q?tVKaJqQykUpvnj8jqSPF5aiHnU4GQn1jYcLe9eVTFoc7eJuhG571X2Wp9hQK?=
 =?us-ascii?Q?BBIGAKADNs+0u5wcRbJQhhQHkEhivXyBqBXigkGlBeRsJ4bYhAyRtFXdux4v?=
 =?us-ascii?Q?RaMqJntAEnZpucjfu2X6EBYxbmJ/S0U+DN6TqqVbMkmOay8OY9GzaewJZPRw?=
 =?us-ascii?Q?I/1q6CI6D2kJUzzLMZgSp+KSJFWu3gXMI6/4FYQMkAIm66kHgC16ZHNSlbLO?=
 =?us-ascii?Q?fDycoSqxyLY6ypS4GVBS1JbEZWSxxqOiLRniwyDBi8bnO6QoDAxXQb4sgdSO?=
 =?us-ascii?Q?sF1qf6PB0L3BCLdczUAl3EwCQgKLXOdMjL0qbwn2AZiF7xIEiFNnohZezxuT?=
 =?us-ascii?Q?mIk8IP+OJ4YqbyKw3Y9liIgvDNjuPU4Bo9LX6dmad6jCX8dt0SzXeyYNjY7K?=
 =?us-ascii?Q?rFZoMkLXGGpLWNlQ7UiPyZuryPnIOwYCnmI+/BnLhFzPVgr4KFc73ILsYyCN?=
 =?us-ascii?Q?Yo2elUsBmySrOrQtYo7iGGscOzXK9V466oYNbwPAbJVRTrvNQCXRQmeuGYX1?=
 =?us-ascii?Q?0I8CZSswXsupGzSR9xbm8yjVkDMqYIxUaRNMwkZOgDnGC1cmDYLZAjXz10qr?=
 =?us-ascii?Q?XwtqQng=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 06:06:08.1106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32858aa-e640-48f1-d0f6-08dc6b371fda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367

Xilinx CAN driver supports AXI CAN, AXI CANFD, CANPS and CANFD PS IPs.
Document all supported IPs in comment description.

Signed-off-by: Harini T <harini.t@amd.com>
---
 drivers/net/can/xilinx_can.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index fae0120473f8..d944911d7f05 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -6,7 +6,7 @@
  * Copyright (C) 2017 - 2018 Sandvik Mining and Construction Oy
  *
  * Description:
- * This driver is developed for Axi CAN IP and for Zynq CANPS Controller.
+ * This driver is developed for AXI CAN IP, AXI CANFD IP, CANPS and CANFD PS Controller.
  */
 
 #include <linux/bitfield.h>
-- 
2.17.1


