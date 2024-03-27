Return-Path: <linux-kernel+bounces-121854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6502088EE90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08131F35AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE2714F137;
	Wed, 27 Mar 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3S9HG0RH"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5E712EBEF;
	Wed, 27 Mar 2024 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565560; cv=fail; b=h+G/cwYhF4xmnvE/wdlX8/EYB1dPicQ1XJBO8EVQ1D5um4jMElavQ4mU9+EzZ/9w0k1UAC9cjNl2OoFBCJlX0Ml0K6cxcFSQSwFTdeJrjTKG+HsvcsV0NNgpcvmq30kXfU6F8KyWF/MgQVPmA/W06XGu6saHCoBcqZLKSXZ5qDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565560; c=relaxed/simple;
	bh=kt+8xCq3XLd84Lywq4OMXt5/M2mpaCjXPWpPOPDk2kI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h1pbcFpDHwDjT6dHbZBxnWt6ZRGV1pZ9LuRrJLS2y1/tBmn2q66CrhKrFYgT62jgib3SZYp0KZGnHpPR2zIk9C8/lpRG2DPdqDRavrP7dxM0QOpO0b+n6n3gPoER0dKN26ua+zrYuWTtssgrkuY3YQHw3/8ypFAVkWsOiFnkXk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3S9HG0RH; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dh/oFsa76lO5qRDWOQT2Lo2NIKevd2AWH6vlUISGTf5DoPQnNHhVIHWhR8PCsueOUwK3m7UFU9HOqwmntmlETlJ3esOKgkIVexO+mA5MQbcMORHvzaiWEJSWXhIxs6fBhExATr4j56sng/2IFZs2aY5tZaMwUAaoXEpPZJJ8caz6MskIJe5BGAw9hg6GWXelJji3r14yBBUjog+5x/D0EbthhqgTCypfTzlzQew16qBpnydt4eEt14sjfTX8cQgmndz5GmiihEueS7zQp+sjJ2YTqGp9yVtvNywHsy3FZAmjCX1z+vMlUWGqmo9RnjyQvZEjjVMdJfULhaXrxH84sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8HPmtjx3tIgLjT5XFDecE2BeIfnWZ4KU6vxTzvpwAUI=;
 b=Yn1qSx729G3+ZPI9i1W0xFUbMmY1hYP9DBi+iYkeU+9NVgyJYb4P4W9Zyyw+G0V86YQz3zYJ2WCgKuKmz4PRqGZTv0Bv7qqgwfBSGcsSSKEzlx8Y9J5oHiMmYvtbK0CWIsVFL+lfghluGtT1cYuTs3VXNTGsESKQrE8sEZWClJmx9MrFSkc/K5Eu4G15YPWBgex+mo9uvxkkoHmfxtaIJMAN0blpSCUGzSwrR/krRnz5Tfqo/Ear+opKKmsvpdeKkYmLHBkFdgrb3+r6mnG+ngt+835KxWD1MOTNcXOq42e7UT+A/NTHb+X12WjPmH2ClJDIWnTPvpI6//z6Q0Z3EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HPmtjx3tIgLjT5XFDecE2BeIfnWZ4KU6vxTzvpwAUI=;
 b=3S9HG0RHl4eDEqSNCGfDA856c/n/CsHmCA7oK5gm1W+J62KD/vVrJR68YOkN8omLrnUKBOaYJS0STWDSO0Q/tfkMMWx/WIBd5lMsUdp8f8k2ElZLp+NasIFOTXshMhwlJSK6i+O+VA5wbjslZSlFoGetLn5rDcKOmQrBdgyd8xM=
Received: from SN7P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::33)
 by SA0PR12MB4368.namprd12.prod.outlook.com (2603:10b6:806:9f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 18:52:36 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::8d) by SN7P222CA0010.outlook.office365.com
 (2603:10b6:806:124::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 18:52:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 18:52:35 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 13:52:35 -0500
From: John Allen <john.allen@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>,
	<yazen.ghannam@amd.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<muralidhara.mk@amd.com>, John Allen <john.allen@amd.com>
Subject: [PATCH v2 0/4] RAS: ATL: DF 4.5 NP2 Denormalization
Date: Wed, 27 Mar 2024 18:52:18 +0000
Message-ID: <20240327185222.98998-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|SA0PR12MB4368:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebac95a-f265-494b-88f6-08dc4e8f116e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nARdxeXxJz97HvDvGIShP9uqMCjW2Cj4sDW5JB+a16D4voPohNH/JJS/ZfVsBXCB9hvr2bzSa7YGg+fciKmocrMUv9ecZ5N8g8RwWKbtixRueAHoJsaMT2inNlr8EBjhRd8xM5mNLZ7JrRTuqdt9zhNoThf2gyKXuxdlrhrFN/kaoErapYOu7VbJqYzLI5MlhTV4VQ8HjD17ztacqF1ArVcwZpDutDHtc6LjKeXvzIDDRtgnTn8Hj6siKt3JtCAA4BRFJNczkymZoaM1+bZEXjuSY9rDX64T0S+HDEfHPGxQg4KFcfZvvlNXZHUzS0zcOG5jpeRKygxydyzLdkyBSozpiml6O8e8Hhp/OsR/2UpWEgsKHjB3u7Eze0WZIO/lUCabj/R8aFeN8YpojulljxH5tZGMGStZW2pAgYxFylzhYdND6UhtpHrqxRwwXai7wGDmHbHz/33eXQNsnBGNVV1tIrVk0+cBm4tepyg+p2f0RVfvw4lTqbiKIIQ+/XS2CzDH7Dhp37zP1Wqn8cDSKDWbdC7MSuutFJ/rsApFJkG2qrpQIAWGhjZewICJ9RUr2sdn3dZSOVC7duNHGXG1LWAlKTDkh0RmZ3u+bBM6yV455BCtjlUa6FFcC4SnZdPEnVCeGSbGEGo5vXHT0KzOFT5NoGUpID5p8QTJOx4wSJCfNU7NquwfeH43umBfW4oGkzPeaCqSKgUnXb8wbjomnrDV/kvQ2AiP8mE0x+kXWDocgB9ndGj8wgBvMJDQ5GdS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 18:52:35.8733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebac95a-f265-494b-88f6-08dc4e8f116e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4368

Implement non-power-of-two denormalization for Data Fabric 4.5 in the
AMD address translation library.

Tree: git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git
Base commit: bd17b7c34fadef645becde1245b9394f69f31702 (origin/edac-amd-atl) 

v2:
  - Fix compilation error.
  - Make remove_base_and_hole the inverse of add_base_and_hole.
  - Move all map validation checks to validate_address_map at the beginning
    of translation

John Allen (4):
  RAS/AMD/ATL: Read DRAM hole base early
  RAS/AMD/ATL: Expand helpers for adding and removing base and hole
  RAS/AMD/ATL: Validate address map when information is gathered
  RAS/AMD/ATL: Implement DF 4.5 NP2 denormalization

 drivers/ras/amd/atl/core.c        |  48 +--
 drivers/ras/amd/atl/dehash.c      |  43 ---
 drivers/ras/amd/atl/denormalize.c | 530 ++++++++++++++++++++++++++++++
 drivers/ras/amd/atl/internal.h    |  45 +++
 drivers/ras/amd/atl/map.c         | 105 ++++++
 drivers/ras/amd/atl/system.c      |  21 ++
 6 files changed, 726 insertions(+), 66 deletions(-)

-- 
2.34.1


