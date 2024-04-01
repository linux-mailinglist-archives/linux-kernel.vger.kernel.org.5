Return-Path: <linux-kernel+bounces-126894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B00894416
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:15:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E2CBB20791
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDC4AED7;
	Mon,  1 Apr 2024 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jM05olW4"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E492E8F5C;
	Mon,  1 Apr 2024 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991706; cv=fail; b=GoFkVt3X9f+Smaxv6d5v+cwkyyU+FJpBBEcpCZIMZ9HPW5JxJmC+NKPM7crwc7e58ysCVtovwr2qRo6hHpsyQ96dAw1HgchvritrFsLkkPIulIx9kxmRvItg2OikVDkx2C2aihf4LBTHMbnev1Gwiizs+IFr/hwRam3NHWak+ZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991706; c=relaxed/simple;
	bh=I5VKwzjw5VMv8wU5qAIHjhhwZqe7sxaucfGbjSe/xf0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lswPrM8i9TBtHwJxzMn5OlTTYs92GQfazhetBKndA1K9LOfQwLbA1jEH7uHxIYF8hW6h4/6PSpqIDnOnQl3y5i3+bcUWrwvjOj/TizJsd/sKT02oW0H17R9FgsjEJ+f1Cjs2zI4YF68+7M99NBSv5YmthTylXpcUAQk2tHenBf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jM05olW4; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgkYBZANMKfqsVg9ZZs7GKLrXbM9MiswhbqPBtT5Tdio0TtbbCYWGg0tyf41O9WCkhW3lYyrMENJvw4gBz/XwKp2IsFCyh6S7N14L8iZH5XxrjAb6MIIDNdgr5pusYNvTz+yGXWJzz3Fy1UgQFlfk2fedufyw9ZE13SfzOJ3FA3oKOsbCugEX34o8FUqvEp80QHaA9PDMtaXhKH8V1x7gR0fyLMcKMFbzZ6hPWfzrQA9eCFheF+qgsBjTyTVXfrGajHAdWc1ngYyI1ulWUQupA0HNUooL3cWGFn6rr+yxW+Y3JyU67whcn1qWjv+VpRgvTwFI9HKAcslbvP2GkrwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKSCmD2GgkoP/SPFwuByyWNOOsbiL2KF/yfNL1mU83M=;
 b=TsXwmfWiZIJ3uKFaEmEvsatHX7sJ1hTEf6nLxs1WkF5kS957U8Fd1ESXOyrBXPBpjZAdD9tjkTC1iU71hgkSkW7pu8OVIuk5CPcLVLB8+EZeZwL6A4YxTtYpW4A0AC1dWCuJEvOHGlXG2bFZyh0Iw26rUsp8vtKiLWbcc0f/LdZOXJT3Mr/H61BRbHce6+4lWGl+7ThVUCBeAzaouA8vqkRz4Mf8vVsYVxRfKPbO7A/Xb40ySLLJ0YrpHOivOJGqytchVRmfcFTNjKWHHW3+LHtFtpSHmwDGS94CNrRjMpVlJ7tyuaTUJTobV9SYxrTbhnZedrPu4sD001eS/3KMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKSCmD2GgkoP/SPFwuByyWNOOsbiL2KF/yfNL1mU83M=;
 b=jM05olW49/xW8606+N2G7oCA1A7277r1d3GYMPU+QPb+/q+5rGwstjQMXVHM+Fbeg7Vo8ycIYBk+SdkhRUrVt8kMuGCPHuMlCsUn4I6Tqe5YR7l9C/BEoXHCk8x7VkOXOuTGR/BMGU9jkj9dZh6PIklTg0ZT+iZbItAfH7/ORiw=
Received: from BY3PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:39b::13)
 by PH7PR12MB7379.namprd12.prod.outlook.com (2603:10b6:510:20e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 17:15:02 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::34) by BY3PR05CA0038.outlook.office365.com
 (2603:10b6:a03:39b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Mon, 1 Apr 2024 17:15:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 17:15:01 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 12:15:00 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 0/2] Update mce_record tracepoint
Date: Mon, 1 Apr 2024 12:14:53 -0500
Message-ID: <20240401171455.1737976-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH7PR12MB7379:EE_
X-MS-Office365-Filtering-Correlation-Id: b710851f-67a2-4589-4895-08dc526f445f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RMSb2jXTjRxABnWJ88MkVG5mhPblDtYFh6+f48Sdrco3zUk8mehrl40yRn6HdiO07UPD/H/dvAu6lgdp438+4wFws3de7bpiyHIZvsNpt2cy+3M9wxmcQ93vev569WAOicr6EAXExMVmXkU0iTVtHl/OY9y9a5c4skPlkNeS6OvBlqnc7n+GcwnU9qQwrF3vnXENQmIpS3xGoK8u1EafqdXCPUs0rx46VfmTH440rCYVVGJqzDmqG3hQB/iJgrfFqBgWzz6vlonMPEQUAdhImopN/x2x9iVC3hgTY4loJEgilGaHKhGX+rfvt5/aSGzT0gv+Q10oZ0eBsO/LUWhvkYbE0dIunyJ2yDThVDRK2gRD7PIvLNprau0B1r5IOcBedgFqe/BEWJy7sbgRKLUnRkU3uN282Q9BKnn0Olhr6TvpegIX2YvcAd3imZgC8inn/T/gcaOuEQorBZe1NlCl6QazHXokvCLpc2dEuwCuC7Wc44fyTJAIzQOxV+Ej6SSCIb9/zWtiynQUrmK8Z1SVuiDQHSat+A1RUm2TcQyr79gdswxROp5mOE0+FhVwkey65KV/EneQQLWwnYjurzd6zkplg0AENKsqfKFxyIgL3LVoFPUUYAimR91Mq6iVq2k2P1I6GoyRkEfKJGSW6+JZilTNunlxfeO2YEpdJMxKYbBUnkJ9kjqbFtbYohBqzwe0AWepqGTnvXThBIQVKguMCw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:15:01.9366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b710851f-67a2-4589-4895-08dc526f445f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7379

This patchset updates the mce_record tracepoint so that the recently added
fields of struct mce are exported through it to userspace.

The first patch adds PPIN (Protected Processor Inventory Number) field to
the tracepoint.

The second patch adds the microcode field (Microcode Revision) to the
tracepoint.

Changes in v2:
 - Export microcode field (Microcode Revision) through the tracepoiont in
   addition to PPIN.

Changes in v3:
 - Change format specifier for microcode revision from %u to %x
 - Fix tab alignments
 - Add Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Changes in v4:
 - Update commit messages to reflect the reason for the fields being
   added to the tracepoint.
 - Add comment to explicitly state the type of information that should
   be added to the tracepoint.
 - Add Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Changes in v5:
 - Changed "MICROCODE REVISION" to just "MICROCODE".
 - Changed words which are not acronyms from ALL CAPS to no caps.
 - Added Reviewed-by: Tony Luck <tony.luck@intel.com>

Changes in v6:
 - Rebased on top of Ingo's changes to the MCE tracepoint
    https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/include/trace/events/mce.h?id=ac5e80e94f5c67d7053f50fc3faddab931707f0f

[NOTE:
 - Since changes in this version are very minor, have retained the below
   tags received for previous versions:
    Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
    Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
    Reviewed-by: Tony Luck <tony.luck@intel.com>]

Avadhut Naik (2):
  tracing: Include PPIN in mce_record tracepoint
  tracing: Include Microcode Revision in mce_record tracepoint

 include/trace/events/mce.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


base-commit: 65d1240b6728b38e4d2068d6738a17e4ee4351f5
-- 
2.34.1


