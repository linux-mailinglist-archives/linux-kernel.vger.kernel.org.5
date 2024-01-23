Return-Path: <linux-kernel+bounces-36198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D2B839D65
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 00:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AF861C2572D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E4354F80;
	Tue, 23 Jan 2024 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pOxiiqov"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E5154279;
	Tue, 23 Jan 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706053920; cv=fail; b=gb57iqWR5yL+UxPjHTbfuKzxFHL9vFObMDkoTg7n3OWPK0ySZQcvyYU8RQ5XTbgJesGdIjL7ptHeMV+hl9Jk7FWrguQNBsxWmL/CmL5iLj7fGVciq3pz/1hOpQ5/Fd/Mima66KP2UxlbPZW8Y+H78T++hPYcOrgH3UFpdAS167g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706053920; c=relaxed/simple;
	bh=NqxRvSTQyoRKXt3tmzF5NVxt89X1ZOKw7m4wj6eWflQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VyfbA+T3vSfuynYeaKe2zsTf/i1cn43s1ByOpQk6xATM3yMXKcPLM6qsV0RdmEzC8+EsUYZxNNCwE3ld4LlN4wlFAF02FC90Zdi52UehBwHaRFEKy86lXK7tzOSq8loV7pFtNj9p4C0jKZ2U+VZKI5RXZZvZnWFAoUw1+oJCJWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pOxiiqov; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QCInVQP9YqBwvfwkGUHYo8mG9wJL1lX3BzX7VZAjfirtF2WCEgOS48TTZXaG/yNnyw4TMJiVNcFW23zPFEbGWXTsrfh4BRiyb7M90wtG8jvt4oLrM+rsOmBC9Q6FtviTvZcXdXqbbJIOiMXMoriJjXXeyS3MRn43gSOdVDCqygUUBfEdggeyntmo51sH52uko7x6BdhjYujjUYGpmPk0Qqmd6K3zTw5Yi2gFJNUDF++6AZ+gcVB69n9gC33jdbEsELytwSgs77C4lEWOVwO3JXrVOmNIncOjYKrpjYRUrfFyTShzMkRWKhm5/EuldZB0h2AASJHDKgozXkPY4QoMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUvZyZeEyAKy1Q9MxG5SF//0HE+AqfLvar/e0N9dwVg=;
 b=OSRU0tBSpoHGKDUziwOSRva3tcbOsGbdvfnLm09nTXKJVpooSfu41FDfSYkrw677DoXVNT14JKB6nmNFEFNNpaOT0HH/31hHoZNfJqDFgKGo/FM/pGBrMRpLGDHcD3cndg8OGr4pmOixgZw8M8841ju8NBoEwEddOZLqGx9M1E9EryxmbMAddd+/XVZ4RBRoPg7lFCCYVvsgkYmd4M4V3wawPXZIMAC3g4fqv42x5kQUyuIjGCdzM3G2v0h+VU3SuAHST0a25qajU1wV2BI3jRJ7h5n53YbBXxxaGWSE2Ii/+5oIrJ7BPmi261m6OuSwtz7VcZ6W0XLG5OCY3lDRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUvZyZeEyAKy1Q9MxG5SF//0HE+AqfLvar/e0N9dwVg=;
 b=pOxiiqov3EhYK7BJDqBQVhhVHCqQ+0o0UgU1u7JOY4E3PDSW9XDK1eW0d3Vo+ri7jKPQFPEe9iWtKNOJJqS137yDg1+Kqyn6pf4AFZbLFd/ousNY03ozlQDIsP2dGbZ7P1aUU6HaCEin6GjWRPP73fMwZ3ZLChGgcRv80RRxjCg=
Received: from BL0PR0102CA0044.prod.exchangelabs.com (2603:10b6:208:25::21) by
 BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 23:51:57 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:25:cafe::ab) by BL0PR0102CA0044.outlook.office365.com
 (2603:10b6:208:25::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Tue, 23 Jan 2024 23:51:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 23:51:56 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 23 Jan 2024 17:51:56 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH] tracing: Include PPIN in mce_record tracepoint
Date: Tue, 23 Jan 2024 17:51:50 -0600
Message-ID: <20240123235150.3744089-1-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|BN9PR12MB5130:EE_
X-MS-Office365-Filtering-Correlation-Id: 50638fa1-d48e-49e5-8a08-08dc1c6e4897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	THJreMWjqAy1Wy0JDwA7UV24b1B7KTMvzFh+gSBlohowsasDIgDUeHb7h5AFe1boltQEuW4svDBNQbSxnpEVSxrm9z/riAjtCm8Cy5Z1/FZvm0ez9gcKt8Z2MDxEA/Sy2qiHUibrCWtUQy+vcbp1D98WvKWAUfC9q0Wy0ZozqF6ubYdM1n2Ee+nSMNM7EoC6rRK7+QSSbjCFuknpZHXOgzWMXFqOhud5COjeeOFmD8khFTUvwcSRA2LL6jF3GgskQBUegIqmBtFrq25vUYK7cZNfKvE402h9COVq8J9W12qpRLpoPnz9lJCP/lgew00mcrUfG1DZ7i6pvJjdxIjiA+2dMXOhSnzJNHmGU1BJnTjE7Ez8KrbOuXhI7rku1cZUbi2crv7jwg+X50Sbjg8fBdsaFOmQURC1tRf6ZqyWQ6kIonOvCic0Uc0mfRezNTm0aTVExB3XUM+MUa+QnV2oe+pRCKTpWnNrco6PEswXUJuPXTCRfqhZtxeyA8hDOLDioc6RlN/JXf7umyxooRtSglIrvDEvtY1Bla8f82Nn9T1dpRc6Xq+bd/AL2EuSD35LLtMSbquF++9l9jhvhSKOSxDbFhPxeb4q3r53iWp07SoyU+ztvJJIW1Mg2Y85hTHUkUrV7vhA6Uwtk0SjIpOd8l+7/vuaHcD319TvyMR3VD7Ync94L+rUhKP1S/tvgfnQ40cZ6Ch+pu7t/YdCuDML1KlRlKD+RERPWLnaFgHR7JOONMSXvX2Ivi6JAvjNmUfFIbjOI1LK2Uzqqb1LYtMJSA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2616005)(1076003)(8676002)(426003)(4326008)(336012)(83380400001)(44832011)(8936002)(47076005)(316002)(7696005)(6666004)(70206006)(54906003)(70586007)(478600001)(5660300002)(26005)(110136005)(16526019)(36860700001)(356005)(81166007)(82740400003)(2906002)(36756003)(41300700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 23:51:56.9170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50638fa1-d48e-49e5-8a08-08dc1c6e4897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130

Machine Check Error information from struct mce is exported to userspace
through the mce_record tracepoint.

Currently, however, the PPIN (Protected Processor Inventory Number) field
of struct mce is not exported through the tracepoint.

Export PPIN through the tracepoint as it may provide useful information
for debug and analysis.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 include/trace/events/mce.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..657b93ec8176 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -25,6 +25,7 @@ TRACE_EVENT(mce_record,
 		__field(	u64,		ipid		)
 		__field(	u64,		ip		)
 		__field(	u64,		tsc		)
+		__field(	u64,		ppin	)
 		__field(	u64,		walltime	)
 		__field(	u32,		cpu		)
 		__field(	u32,		cpuid		)
@@ -45,6 +46,7 @@ TRACE_EVENT(mce_record,
 		__entry->ipid		= m->ipid;
 		__entry->ip		= m->ip;
 		__entry->tsc		= m->tsc;
+		__entry->ppin		= m->ppin;
 		__entry->walltime	= m->time;
 		__entry->cpu		= m->extcpu;
 		__entry->cpuid		= m->cpuid;
@@ -55,7 +57,7 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor	= m->cpuvendor;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -63,6 +65,7 @@ TRACE_EVENT(mce_record,
 		__entry->addr, __entry->misc, __entry->synd,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
+		__entry->ppin,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,

base-commit: 451b2bc29430fa147e36a48348f8b6b615fd6820
-- 
2.34.1


