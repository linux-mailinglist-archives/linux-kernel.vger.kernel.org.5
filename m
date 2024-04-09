Return-Path: <linux-kernel+bounces-136838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C62F89D8D7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:06:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3561C214A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D06512B14F;
	Tue,  9 Apr 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b="FiXdfnCX"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2091.outbound.protection.outlook.com [40.107.105.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F30A12B14A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664384; cv=fail; b=K4C0gBspOX8vRSmTrbdWrCSYUYiPoAbsHEh7vZ/jLlzdIyWTRXeVluL1rDfB+KHsqf6h7JvOUQ09y4l+N/QfnUrkaEKQvbEvFCz6pRKOzJUNn79O0WN73Uh4TmX+v4P9piojVwMX+OPmUtLMoDIr68LRocXMqwyQs3egzP+sU2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664384; c=relaxed/simple;
	bh=Q/boqwpU9E6Czuo6p4KnTWXrqQ3pSejSPsWMdJC3T4w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hOMlP7AjEAGYzpnAn3Mj86xGsmI2sLPxmJrCg6TirLDeGilJaPAk1WqdWRbhd2JNAncog26EvXsPM6CXJRbxA9oBQ2pXtbWPM6eyRmV9aYHRuJcDOaYZIG3I1C/BYy3FC8XY5gr6jelNPGRg5oQzmrXbnDcfR5bNHqMJI4KVF7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info; spf=pass smtp.mailfrom=bachmann.info; dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b=FiXdfnCX; arc=fail smtp.client-ip=40.107.105.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bachmann.info
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMJyZEzNtEPxLRqSGd6goawct1WL5jSVZgMPHjVwdE4hOMGJSJ1CiquybKRmD3jcBL6MPEC4LLGfFLHrM8Jp7esTmxbF7tKuj2aZ9KCvF83OzoTHyQ+HMc1Fy1gievI+S95ENHD3UH2rxPB4mxsUxPG8e4ewAGN+3uf1FrfXEFnAj1ITNg67e9SHiQHGSZ48c4plhHTKJ1S0f6TpAydcDKsREQdsrcaONL3dl3esqI6Rn2MbsoURje9KZTzYJ+51TS0NVkM12YoX5S3c9Z6XpqxUDqVyIof4+pkn2rUKttR98S28TsAhrO4o4ADw7mAJgzf0kLgkF8t4hZS4MvmgcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FE+mbr22yE1LKqtOnaOEPdOloF9Z3lJCMUA3Xxb65xU=;
 b=BYFARi70SZY+Iz4gNliMnZvYwUoS6fiG05PQ+/J++Dx4Rhd0q52B8HBy62ldT0EDdai+CJj9DlcrdwoLD0iDMVUjlUtz2KA4PZNELjv69qzgv+LFqohOfbYMMcKltjN1UFyfBI4XV7YWj7c9vAD0wu9rCPv/Tkx1ie0pajQ+/CRoBAYf8o4pEYWOU+YBuwo+uyOUExRxu/rayJ+3FIl8onlf2/pyoJ8lOk6otQNmfDJbu9YD1dh+Dq5yDMWHAsIkJhX6fg3S1WMv2mIJ7/PqBk+blHhN0Y+C1oS8WFpzzBtNBTYu+oLMgsPsKFPN4m34tEI5CexL+MXxStr8fdECLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 185.67.228.71) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bachmann.info; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=bachmann.info; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bachmann.info;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FE+mbr22yE1LKqtOnaOEPdOloF9Z3lJCMUA3Xxb65xU=;
 b=FiXdfnCXBGl3HEK50EZVBL5CHcRSBC3r5q5GYripcD0ipinYyovpgSy90CpGkK+IddlTossL4trRE9qc7TKIxK3uPNzrKjSt0iF7a2J8xACfO6wZGlmci7MhK4/8Eua6SeuXBO+Cx4R+LkDpeg14UKKfDfiN3XWxSXkyfRVw7XU=
Received: from AM6P194CA0074.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::15)
 by AM8PR05MB8131.eurprd05.prod.outlook.com (2603:10a6:20b:367::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Tue, 9 Apr
 2024 12:06:17 +0000
Received: from AMS0EPF0000019A.eurprd05.prod.outlook.com
 (2603:10a6:209:8f:cafe::c6) by AM6P194CA0074.outlook.office365.com
 (2603:10a6:209:8f::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 12:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 185.67.228.71) smtp.mailfrom=bachmann.info; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=bachmann.info;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 bachmann.info discourages use of 185.67.228.71 as permitted sender)
Received: from webmail.bachmann.info (185.67.228.71) by
 AMS0EPF0000019A.mail.protection.outlook.com (10.167.16.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 12:06:17 +0000
Received: from ATFKPCLXPAFO.bachmann.at (10.204.124.241) by
 atfkex03.bachmann.at (10.10.10.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 14:06:16 +0200
From: Pascal FONTAIN <Pascal.FONTAIN@bachmann.info>
To: <linux-kernel@vger.kernel.org>
CC: <afd@ti.com>, Pascal Fontain <pascal.fontain@bachmann.info>
Subject: [PATCH v3 0/2] misc: sram: Add DMA-BUF Heap exporting of SRAM areas
Date: Tue, 9 Apr 2024 14:06:03 +0200
Message-ID: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: atfkex03.bachmann.at (10.10.10.31) To atfkex03.bachmann.at
 (10.10.10.31)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019A:EE_|AM8PR05MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 78632876-f42b-41b3-f314-08dc588d75f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Wn8hV56ItsiQdQ0luj+k8S0RjZFONZ6IBaLYBzu/Lw/PiYu27MkaYJxXOxiwzi3I7xI1jihkJVTYL8GAqwIv80dJfxiL7f7Y+wMIW4Y5OIBmwvOmuRffWJCE0PY3al9LFyCOXocFoad3bjaFncNf2rL16fqjr1ldWqiTymZuy2glZkvdh/PCP9GBlCEFZ0C9cqZbzzJASD96xpJB14jyp9bEnYFmD+SY33JESQIhm/SvZDT0paTB7I8orykThtRU9wVTjzRQkVb2ZR+A1Unn+RiQ40B4p6iBZ9NfwLVjMUVQa/2G6Rx2otIYZ1L1nwtfsMnUJkEnDQy2rIKNOYlf5EpojATKVVBhsozzpxOqA0ZNQox6+XKmXUrE/V/6DV/XzpRmfmWtpMx1h4PEn3+Y2JZd6VVT918UGrYzyykcTAxq5fmAX2o5T9dKb5Skq0Gv7BL+t8kPgD6UibdnviuphnzpV/DL5obSMZDPbcmdkChizv/wB3skiuwVBWXfoX0dHVBZb9r4La6jNOm9EPqjHEtQQEqfeQCC63MpgRblLGHB3Bf+4GamMMQvCENdO6TU+8RbO70OluqN1+eRTnF9oKGfB17K6YFDlxiPdXvZLUFZxS3T9tMA/YROmM+d1nK9a1jRokq82qznA7eVr/HkyjeWmFG7UhlcG7kPNRP2wA9248EiCvO56W+8cr/Dz2yR3BZK5G5N1OBKUk5R4v2reAf62/Z4K1nPHkdH2gOytKNmoxjVkdbj/WxP9eW2adiB
X-Forefront-Antispam-Report:
	CIP:185.67.228.71;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.bachmann.info;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: bachmann.info
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 12:06:17.1672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78632876-f42b-41b3-f314-08dc588d75f5
X-MS-Exchange-CrossTenant-Id: e3bace4d-d2e7-4d8f-afb8-152509ee3f1a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e3bace4d-d2e7-4d8f-afb8-152509ee3f1a;Ip=[185.67.228.71];Helo=[webmail.bachmann.info]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB8131

From: Pascal Fontain <pascal.fontain@bachmann.info>

Changes from v2:
 - Move sram initialization to device phase
 - Solve compile problems found by kernel test robot

Andrew Davis (1):
  misc: sram: Add DMA-BUF Heap exporting of SRAM areas

Pascal Fontain (1):
  misc: sram: Move probe of sram subsystem

 drivers/misc/Kconfig         |   7 +
 drivers/misc/Makefile        |   1 +
 drivers/misc/sram-dma-heap.c | 246 +++++++++++++++++++++++++++++++++++
 drivers/misc/sram.c          |   8 +-
 drivers/misc/sram.h          |  16 +++
 5 files changed, 277 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/sram-dma-heap.c

-- 
2.39.2


