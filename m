Return-Path: <linux-kernel+bounces-39150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F227483CB8D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A095429B206
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9A91339A2;
	Thu, 25 Jan 2024 18:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XpIRc+ZY"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2047.outbound.protection.outlook.com [40.107.102.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36321E501;
	Thu, 25 Jan 2024 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208560; cv=fail; b=t7XTmLae4lhk78klRgbLcRuCDxyZaM8HepjBS4naBXDe+h54ByJrcb9J7lG7I/lToprmDp04ZGLsUTrvzuD9P8tMuY/eU5D2Nycmgl+b5DgmSeIswcSew8+A8S3mnHBB9xgdPquQFzGeCDVyzsiBDQHhfdIFaSKPBiY+inO4PfA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208560; c=relaxed/simple;
	bh=rTIxWH9xzwGWtmN+MBjk3Ytq3rNc+oM6TnEsbv8eWXE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ru+jhZRFQp7Afw1SmwU069QdIzk8mDYhSc3lF6zzFmjs5gMcKOg3VoNR7DZMfTT3IYv8D8UF8RXwaUut6uXJbLINQlPfsHhWulb4DE9O+G3/TmJVQ1fLC/dYHJrpRpMMTBCgFLvJGSKoMV8H6Qj4u/YFMirkqRy2KZPwpRrHNow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XpIRc+ZY; arc=fail smtp.client-ip=40.107.102.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOFU5DgVNoVAemh+Et/m+DivXXFztAffOSPNbYyml0LKSkPV2Ev9ZNgq2p3Qaqg9pJcrPlrDmR7K/hhMeNvq2quKhpuo0qvEaS7B2cs01W4HzhwFbgpX8w4xry8PBF6E7ogmoABywE5rnAXZzD8A6W5u5VBg9TqWszdDCwsqN46YI6MiHHDWhU5Dg/RUQbYSlzdvsZvREdPgULbf2mki5xMKvHO/CcI1gMSDEA/iTBlqR8RibcdYiQA5jEkjcFOBAJPyDQDQnPQYwCM2a9YGNuJxrmHk+Gq+jJoj8e6ioz3epvpd2LP2/9jD/yR+sSNdX1kQLGVLKYpVJl+Ec6XkcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBZUls33JQHugjOoIXiWYjPiva8JkqyXJlNFaJS/ZtA=;
 b=Nz26A3Cqe9hx6BTiY22hIs4B0iLoZg5UVsziVv7hL5Ju9YKSUqM4/DUdsfxQLTIBU9GLL7eXYYdXIqM4nPMiq2k9r8UE4LONsXmxfGCLu9bHj3whAffDbjqTpwlpQvWluXYppVB7Lhrp3mDJUVLwpCkINYW8XlXtEaXzAcrKkB1Z/k/vvRXeH0secnvQmeLQsf0fKO6xGtkK3hxXPqxkHWuAcCSe4yuIaaQVNUIZ4vvyyqBZb5A9p/dzO+gbkC7O2JhIGJcwz3hwSKMlPh6ILTYI9r8GimZ0psyW2pVsvJF3tbmG1NG8km7WrfmrpRpCelDojHr1ZHw7nVmsMUhm9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBZUls33JQHugjOoIXiWYjPiva8JkqyXJlNFaJS/ZtA=;
 b=XpIRc+ZYnvUMQZNK1Ihh6xLfjsGmAWz+suxJuqNLmkkDJAz7jmiZFjoIg3LTQWYIKnTFDAJzTm+KSTtjKpPATnHYvkUq2njTZA0sYpiRRchX47FAB3lKWulv8wt1B27br4W1olQAlfsKWnVHgz7j+lEEMhKFRlrAf5+ijCcsmbg=
Received: from MW3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:303:2b::31)
 by MN6PR12MB8472.namprd12.prod.outlook.com (2603:10b6:208:46c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 18:49:16 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:2b:cafe::b2) by MW3PR05CA0026.outlook.office365.com
 (2603:10b6:303:2b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 18:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 18:49:16 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 25 Jan 2024 12:49:13 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v2 1/2] tracing: Include PPIN in mce_record tracepoint
Date: Thu, 25 Jan 2024 12:48:56 -0600
Message-ID: <20240125184857.851355-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125184857.851355-1-avadhut.naik@amd.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|MN6PR12MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c20d3a1-3c9f-49b2-dd98-08dc1dd654cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E+P2ThFsM6aPD4S1Nhsp/wAKqdcNqNRKEtOIbMUrqhskE2qqCyDEsrvnII5HYnIP3NYDwqSk1ldBanME1fptki+6cNpd27MWj/k0rPYu4/AYeE7LET+qkAROiBoLsTepOuCwxrq9Xy5h+EqYJPy1FUS9Q4te2Mm7dZNazYn8XEp9DjXvefGMBmOxWvAjZ40dTdKh2mNnd/mqLA3JQehyc01/3L46cEJL4hrvSsLC/sLuur+aNPhIXEpLE1GPBlKq+fHL9eyyJjcfb0VGd7aDRc2lwh3mdKnwVnFsRALPPAmr+pifiTgj01ZdA+3VS4g/Exk2uV/3KSSHapHx3+0aswps1MasvS9OCW5W3+BXOe+uXk04wrGnBG0J5v0HwGQ3kUPnbX6DhYdsv65UWxWqlav0SpfYuDU78DXqIBYJo+04Sluv1URucS+u6vrkhDxu0hHTES2VH5/CHxJq7eIr+0jDAn8L6QBh1D2W3xlRUwogEcvtpF2kR/df9jMln05wXB6QZVgohVMWQXWyedl7GlL7UtTbtTVeJ32Ff5SHZUrm49Z2y7cisM/Mxl29J0rVAbY+KlmhIhNVK6m/YOGQ6ENxauA9ibVdlHukln4qWL7GkzDfFyGtv913E5vtw+3fEqF+LLhcBSrz8yY0oeOOYuLsdBrBRlhfTCn+yZ4+NpX4rL93cCkbwEmarw5hE/XCGB1j9I7ashO0bz5ktA3q3jqMoltbdRmrxjVBz/hr1ep4NmGgpt4QEWNOi3zU1JHZpmYpbJ22wWOQdVJGnN/4fQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(7696005)(40480700001)(44832011)(1076003)(2616005)(82740400003)(6666004)(26005)(47076005)(16526019)(426003)(36860700001)(83380400001)(336012)(478600001)(8676002)(5660300002)(8936002)(81166007)(70586007)(70206006)(54906003)(316002)(356005)(4326008)(110136005)(86362001)(41300700001)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:49:16.1477
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c20d3a1-3c9f-49b2-dd98-08dc1dd654cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8472

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
-- 
2.34.1


