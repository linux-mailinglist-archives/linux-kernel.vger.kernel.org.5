Return-Path: <linux-kernel+bounces-42587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 279D484037D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11E8281C68
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342985B1FE;
	Mon, 29 Jan 2024 11:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FisUofuE"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2047.outbound.protection.outlook.com [40.107.100.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA99B56B96;
	Mon, 29 Jan 2024 11:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526439; cv=fail; b=d4bCZ/L7hRd6IPYsoZ4aAMZx4lTCxOuAoJWGjwcpDqdR74PsZYgmdJMKgNxGNqE35W4QPzxESsUO7zu/TUejMTDtSSY/VxL6DwoM/Lwy1HPgA7GKf9BAk1rCl5SyQ4PjelVDK2dvWXj8JKqPv53dIuv3Tzej7Gggpj8dv6OZcqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526439; c=relaxed/simple;
	bh=SkgdEr20X+54nnsJiGd+jtnxsvYF5+dU0TXZ/CCy/pM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLvnlcbRCOHRvgz/QAlMNtT5EfTpDMcoSsOEcsWUzo/AXC6dPbUuuHySmOt7BjX3CLrsJ92tos5CEvOstVgEd2N34nV/Y/xwRJMYwYcNpr5t66GZqOpluZmGAJ+JFf9ITgfU1V3WVaV5G5oDzJ7HqHJ4TFaZwb7Hh3hsQlPkSms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FisUofuE; arc=fail smtp.client-ip=40.107.100.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/hhYOSTW5VJJ5G0QjCO/JiOn9wKA+a3YG5ApL6FYJCf+b6oD4cuvpMfysviscccXOrzp6ugJSvfM7slx4PonHPzLhESeK0CU40H81lMM0/qjzJsNVTZKCKhPR8DB08xW6HSeWrccZeHQzvC2wX+SIgrQsJtm/5fSdhK/gakuynIM2FmqdNIsN5oYErTGodOImScYN++tktSPwJ5lXc8Xa+85DOqmBIBeJNp5LO9jsEMp9lkWBJBguXtSi5DGG7rNZrtFTN/w6eht4p3ah8FFn9JHpEBQoEWfTVavKk/cjigG/xREPOPDMn+ttt1Ju4rnToYqFQ9rRg8c1I2MqLpPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQLMv0TBjQm7us/LaGvFyZIRMe1q+hi8pizCeO6Dmy8=;
 b=HJ7SOMRANrGOOfJ5tzWEfpUezBJEel7m09HA7SRW01hla/867xjjhG392bP9qAy+IMBFmB7vrqiwjYuxMrkm6ea3FyX/FwS7amJekDOCZ/g4L/b+CYKgqIvNne5AMi+yRTltV2PlImDb0zYFqF173MUd3a0/luzluQ8XJjHHo9M5fend2xoQuxIn8+mLybqZdFiXUxV8FDMfuaXo0G4Yvv0njb+YQbf/HRGapJfD9QUWlbegaRbiODefT8o4hthOFYdyhWMNOu6P/FNoSRZhWqMWhRVD4x3az4DUqErJTxaH2+nHd9mchPLsIP0BgPUVWHOpEQI7b7XfMym21xkZHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQLMv0TBjQm7us/LaGvFyZIRMe1q+hi8pizCeO6Dmy8=;
 b=FisUofuE7Hi8YxbY2nHe2Hyh+i35AAC5rXcr7cz3f43qdPuuHh7Fz+4aYABARWqiL0aAy/lqZvE/+9OOLT+PRwGvkpktGPcpthXJUvdxMCVL2ljqytEpyK9sIVM6bxirfqEFpFUPuJRSu4Ft49RJjtjSp7mcdC/XoLt6pUam7Qw=
Received: from DM6PR21CA0017.namprd21.prod.outlook.com (2603:10b6:5:174::27)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Mon, 29 Jan
 2024 11:07:14 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:174:cafe::3) by DM6PR21CA0017.outlook.office365.com
 (2603:10b6:5:174::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.9 via Frontend
 Transport; Mon, 29 Jan 2024 11:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Mon, 29 Jan 2024 11:07:14 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 05:07:09 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 2/3] perf/x86/amd/lbr: Discard erroneous branch entries
Date: Mon, 29 Jan 2024 16:36:25 +0530
Message-ID: <3ad2aa305f7396d41a40e3f054f740d464b16b7f.1706526029.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706526029.git.sandipan.das@amd.com>
References: <cover.1706526029.git.sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 703c873b-f242-4a69-a68b-08dc20ba72fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KQixVHjhR/31fKXI66bOnl6daUHJQHs6KaJm0caxb7VP7EKLgYyRAkoHXcnf5LbdDxQfAoQitCyDELEHYa1+09X2Ncb7m5gw91FSzMfuxNZFej8Nk608rwFPjEhIK9Ek+aMIhXDad+pTNAfdl1JxL8Im2ioEyoT8FbW7O3vJKJ92bDBGvwog0rrQnZ4p117/ZsMZ9hL5GIpy4m8aTKltVRBllf/TKTtF5vZuDtyGCiCXHHRytQsM5uQimKuYC+aNJblTyMnanO5yUZGi+vhXv5tG3YFZEn6vAbQkKkazcz0vxaOIRTa9pL7rJQOztWVKlvq9g5/kXKoJcioypqsBUrvUfyQK4dviwwcFy0lrmRGfMuBjElsye7/UdOGpY2mkvwOGEvUPo2NScJGd5ejthI8JbM8Wcv3j4fHvCUOim1lp00VerVLq2f7TOAmdW+O/T9pBxtv7EXU5I/3RqoYSvikCfdyTqcI1cjTZMvL4d1v328X1iDrN9W5ASSvIML0x8W3iPKSJs9em63q2crS9XC97wlgbykTk3n+CdKjGZSB1QHJx6HU3znPKp9LDoek16BLuRxsrtkadW7Y6lPxVf00196tOZy7GczuHw8GaycphcNcRLwRs6IKdsPzedlLEH4eLGJ/FgyPkaakAPdnp9BChe33uMMUZphvxIlawyZjNUvTIwWXY23+vlt5sfOlWnIKQI3kDqIrlUBml7INurFFm/O6p8xtG+52XaZy+IPynXcJPILzG716j10zygBWP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(36860700001)(83380400001)(36756003)(47076005)(54906003)(316002)(70206006)(110136005)(70586007)(86362001)(8936002)(8676002)(966005)(478600001)(6666004)(4326008)(26005)(16526019)(2906002)(336012)(426003)(44832011)(7416002)(2616005)(5660300002)(41300700001)(356005)(40480700001)(40460700003)(81166007)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 11:07:14.3371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 703c873b-f242-4a69-a68b-08dc20ba72fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312

The Revision Guide for AMD Family 19h Model 10-1Fh processors, found at
the link below, declares Erratum 1452 which states that non-branch
entries may erroneously be recorded in the Last Branch Record (LBR)
stack with the valid and spec bits set. Such entries can be recognized
by inspecting bit 61 of the corresponding LastBranchStackToIp register.
This bit is currently reserved but if found to be set, the associated
branch entry should be discarded.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305518
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/lbr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 110e34c59643..43bf2dbcdb82 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -173,9 +173,11 @@ void amd_pmu_lbr_read(void)
 
 		/*
 		 * Check if a branch has been logged; if valid = 0, spec = 0
-		 * then no branch was recorded
+		 * then no branch was recorded; if reserved = 1 then an
+		 * erroneous branch was recorded (see erratum 1452)
 		 */
-		if (!entry.to.split.valid && !entry.to.split.spec)
+		if ((!entry.to.split.valid && !entry.to.split.spec) ||
+		    entry.to.split.reserved)
 			continue;
 
 		perf_clear_branch_entry_bitfields(br + out);
-- 
2.34.1


