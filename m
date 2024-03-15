Return-Path: <linux-kernel+bounces-104927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5876587D5F9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A82283D8B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E286C548FA;
	Fri, 15 Mar 2024 21:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x8o4YOrN"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC417BA5;
	Fri, 15 Mar 2024 21:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537379; cv=fail; b=AmeXcjc80N93WXyOftz0vwGgZ8p8C5Z5r+EN5OHrfTW3XBeK/zReCQWiruvAq2OX8tCpFWFnyOlwqTbhyVO/d/Ced+hCRlTWXMuNCVclCD/KxIyYvbojHG1OBH7K31iDUJciI6wCpu6IwsGSLRddVl6euWO1q8Efw5Lrpr85hBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537379; c=relaxed/simple;
	bh=1w+ltHngYaeAEbgXI1d7q1t4j8vxiJPDHlPSCT1d0jE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NBWtV7bwlsZFX1H5fdB4BCKaTZAnNfg3MQDj4D4Lfj/Lxft/4Wgfm35FqKWOAN8CAaOHpD6MzC2zffx5L7v+GMW9CZS6cNThBEUQX0ds+SPTyHTTAsLS4V77yrwx+ufcNub4FXNlXHcyFE/oqjajd4a/Cxqh0WaUwX7Hd9AJFfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x8o4YOrN; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNr/RkOq7dcLVdX+U4Knbeet10OCQHMapO0Zb6jK35RHVIi+MWOpWfceDEYVmqqJoAhwgO1cEDT0rwgcOoL0twTvwDehmU32LrP1luwwC4LlflSFuCYI32LhNvEnATqW/kR1TVnd73thIra70zS1Xl2Upw5AGPLiL3KeuvteJFnQztXzjyVSEDBAZ9ibUA8J4FUU95C8ptCLyL3RoUtlJb1djVXx1Y2e/yMMf1TlZvfAAdDl/IuYSrRG7d9Q/zQtWJMZn7QuAAnvdHgfleS8mmDMOVAIr9I98KVWIfJT7fDA+UWx6+UabSq5lLEryie3dNjzMeGczqbr34P44tAAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoRhqOupdLOowQzHhHpNwLwsERX6sdA09fAQF59/I+E=;
 b=H0ed6oc5qMAr8yyt3Texnw2r5Lm5FYRp05d9xDQPRRCzaYhPW2sCj2YB8raIpF0JYwC6Uu8ALDtzbRi/nAs3LtXA+2+lvGzgjDC2UzosNVuNvjzYXcL5h7nlt2tU3rzjr7j7qdqvl6oaZjf9n1gmmghGh5vb0O/byQNiiz73KG8e8mNA7cRq/8TxMLTLC4+kSvWtcsFH7Qj1jG7sD+ZCktLOiZ6OEnrrJpyJyTqrTFFt1FG53C3uTo7I/OhcnHwhpuaxhyqR5fJNd17H7mjCekUt8JKVUn9ZPHqZVkL7cca7nNs8/mrl0Fx6fdNQZpMKN4Ea8whYaJZIHL4BNlF7Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoRhqOupdLOowQzHhHpNwLwsERX6sdA09fAQF59/I+E=;
 b=x8o4YOrNb1xHcSFUuTG41B5okYUocLqkv3n8GJfuEirtMOboHqx4f7vNcvUBu6QtvmkmXwl9kuU7kISO68uI3EvqF8ctFGTqeqzOlK7XBNtKeBWJ2K3SiT2YQjv60DXiH49AZAw2bpXlL8r4fY1+C4X38BsgebWREZmpSgcFC6I=
Received: from BLAPR03CA0055.namprd03.prod.outlook.com (2603:10b6:208:32d::30)
 by MW6PR12MB8960.namprd12.prod.outlook.com (2603:10b6:303:23e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Fri, 15 Mar
 2024 21:16:15 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::eb) by BLAPR03CA0055.outlook.office365.com
 (2603:10b6:208:32d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Fri, 15 Mar 2024 21:16:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 21:16:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:16:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:16:12 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 15 Mar 2024 16:16:11 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] Add Versal and Versal-NET platform support
Date: Fri, 15 Mar 2024 14:15:30 -0700
Message-ID: <20240315211533.1996543-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|MW6PR12MB8960:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d854a22-2df0-4aec-3861-08dc453524d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WixXjPKmthfNrY/K6xvuP3jCxDaOYZKwF3/9S9QulhDHu/vv2lNdqlJVIQdWpNKOx0DZm3WC7RwBjYOqWN37es0WOXcw2Sjv9tjji4vNz4v4+5mvzkNVaKo0FIFCewF1ouaYYnfweGIVMbul31yhbs+KBZCZjowYfLRpadTeK5Ocy1kL7yXu04pMQ9whbZ5jzW+ewGEcQ3YUt06hUrU2h3QqvPCapSbwbk/Z/HDUS5ehsqiQGX+gS74MmICN0ueJmEDJ21av5xedXnzA+A/QUWNLjgbNYj7aIJeXq6+NsSS0JU4dJy3hoBR0iaQ57PmefyW4A+90DtvnGJa6ZJ8sFs5CF6hRF+EIHJLZam1tseCLmmxNo/dMwo/uK8By3vE7T4Jq6NliaWkPPvYM27y3ZUn7/W9P9XuH9Zyet8tgsYq24Zz3pFBfllkiHe9Ec94m4Yop6drsR+WC/vFvDCijHnYN6mkbr/68pFg5ApANptnr3n2iq6sNSFxdvK1sTucmGFl0J2tcECxto6DmCm0bT7OW1dTG7C/WAMs9GTL7b8Mmj2jqhrIYv0K6hXOQCJntI7WGuRDtahxJO6jvWsH4aKfeRff44VoyafCleDMOmWnvvdgwfK/GBR+omMkTilnK+Yd69hZDnMzc4cto7hJFctqLkz0HuIx1UbgIauAnsgWj+xzijJ16zqGXpAN9gqOGv1mCtGh5/dwae5MaxYFh0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 21:16:13.2639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d854a22-2df0-4aec-3861-08dc453524d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8960

AMD-Xilinx Versal platform is successor of ZynqMP platform. Real-time
Processing Unit R5 cluster IP on Versal is same as of ZynqMP Platform.
Add bindings example for Versal remoteproc node. ZynqMP driver is
comatible for Versal's RPU unit.

AMD-Xilinx Versal-NET platform is successor of Versal platform.
Versal-NET Real-Time Processing Unit has two clusters and each cluster
contains dual core ARM Cortex-R52 processors. Each R52 core is
assigned 128KB of TCM memory.
Add bindings and example node of Versal-NET RPU. Add Versal-NET support
in ZynqMP remoteproc driver.

This series depends on follwoing series:
Link: https://lore.kernel.org/all/20240311175926.1625180-1-tanmay.shah@amd.com/
title: add zynqmp TCM bindings

Tanmay Shah (3):
  dt-bindings: remoteproc: add Versal platform support
  dt-bindings: remoteproc: add Versal-NET platform
  drivers: remoteproc: add Versal and Versal-NET support

 .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 313 ++++++++++++++++--
 drivers/remoteproc/xlnx_r5_remoteproc.c       |  19 +-
 2 files changed, 292 insertions(+), 40 deletions(-)

base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
prerequisite-patch-id: ecf2ff9fd2f2a9a39f55f961b52a5414ea2f2962
prerequisite-patch-id: ff02d06bb3dbd13258cd5748c7486c363bd60478
prerequisite-patch-id: 4869c001ae65dfedaa2e481a3119de03b44a31c5
prerequisite-patch-id: 95e214bf94bce74d86972ea229186f602b5375ae
-- 
2.25.1


