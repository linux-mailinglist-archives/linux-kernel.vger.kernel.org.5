Return-Path: <linux-kernel+bounces-39732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A377583D583
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 702BAB211C2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7C8651AF;
	Fri, 26 Jan 2024 07:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aoiESQ0w"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D2D125CF;
	Fri, 26 Jan 2024 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255919; cv=fail; b=Uu4g0zrBXwhO1VwUEwdPOOt6+fRJquY9jI0QTN3TAbCSLqJpr3KtR99FBJJC7rjAhTGrZ811lUJT3zsiMm8dXOe3iYQnRR+c/D09gorbSWeQyaFApyBaPOuvBUZr+flYhaZxfhIB8RxlPKgb/Mrob9/+F2sxXdjn55XvoeW0gnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255919; c=relaxed/simple;
	bh=kfe1GWGH6We4CpzUw9jLvUi/WPmb/kr/O0doU8G2wdU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JmsUfJZ1mLE3WZBkTcklPcYt+Hq6MpTCSoIQxBoYzfSVwYSNhHDPOQp1gPZrChAQJz3bH0xbEG0EnjRZM9po/diisBBxJcLSSVBy1Arbdhmn3xcijpbDUO551hOkx2BfdWoUKHIZl+1poXBEzDex9joqsr8Ac8QoPeP1y5RobE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aoiESQ0w; arc=fail smtp.client-ip=40.107.101.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPfac4cxPWALRliMKUb1vp8zszU/bGw1y7EVCpuKs3gTj1oov7U+zk/3Qs7Lx237Aj/Bn+TXtEiTi4XeYKJGzsqZAMgFhILaU7HxNipdUyqqNQsieMDgoS354RhOtWn04EGl4LkEyG0HMwITAYXPIh832HCMuuTnjpEe71ogG3NhQTKphY03JBAI/wb0lvnvAF7mXNWqpZ7Kc1rIJL0Q262uFvk/M7tSur+Eubv2HyY8jaBj2I3k2C/sXjQ+Evtl4ua/AMeR0PsOCKHF8GU76ftDdm/kbOLp0NXdw25bnXZYOH2rV0bq0o/pwhJalefi5j1zrKL4NIkanpBXsEgQIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OOXscpekE8NEFll7oSU7UvWedjU5rhS/gUrIKyLwu90=;
 b=l5h2HJcWkoFWN35cJbir+3bx1delVKXhMCKlusUgryPQwZHC21eAX9jbEPKGDK2+4kg8lQK36g0r+2VNXi1vK6hisWy5x6X/bk+P3XTRLqg+LKA3h5QfnLt1I29AJ8euMlaAQLYr1zVs9umP+c8EmvX0S+Fks4maOIj2ebCVj58Hme4SS2Y36hvuZopn7Lyj/OQjzRuftc7vJ9zx94vdjPMu9B6zHA79JNAi1W5SMrTAZ0wweyTYR4iyqXPxLdoTmj9cjvQq1AfMpDXADV8PQras5RDGedtrhYExVGon0ALU92cpDbipa6ZvhzcpjRTgliEogq2DTGiLSRtjTeCnYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OOXscpekE8NEFll7oSU7UvWedjU5rhS/gUrIKyLwu90=;
 b=aoiESQ0wTCmlTTgUEMjh/9DFLNJk1GhVxBKWLIm+y0A7CsR07G4mUlrs6LrcrogvrCx49l8CrrbNhooRALcZvpjiXrZ1vU1pxVDuZUuk60MPgw3x4FlHSBV2Y7f675bmNrL99BGC5qKpTgJ+eCjsZyiX6w5iQJWG5D8V4WEMSGQ=
Received: from SJ0PR03CA0227.namprd03.prod.outlook.com (2603:10b6:a03:39f::22)
 by MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Fri, 26 Jan
 2024 07:58:36 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::a5) by SJ0PR03CA0227.outlook.office365.com
 (2603:10b6:a03:39f::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27 via Frontend
 Transport; Fri, 26 Jan 2024 07:58:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 26 Jan 2024 07:58:35 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 01:58:34 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v3 1/2] tracing: Include PPIN in mce_record tracepoint
Date: Fri, 26 Jan 2024 01:57:59 -0600
Message-ID: <20240126075800.1174583-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126075800.1174583-1-avadhut.naik@amd.com>
References: <20240126075800.1174583-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de8d26e-99ee-486a-7ec1-08dc1e44995e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nBU4+zqxkw+FW9e02+yiMcXc2gJmKrqYzCHOBPoyU7kTKonjPKxxvEAYY8GSGVwFgTfrxCq3Hc0yk1P8L+wRMsfYRb46UGe8qId5Sn7WeDzPc0dYIjYoHK84dONHe30n57Umi8GlSuVOTzHC99JQJa8dTDwv7LDT1aBRG5siG4As6hpornE14nrWWajNehZ2KW2q0QsxuLqNbvmRU9AMeKN3LC4vag7+SbdCjhiSB8j+W8JnobLgk0C6Hz2kLGipVzua5UghcSsYRRVTn4iTkQaFNLa0bC1qXAXpgM3vrs87Iy6fRmuOituFT5ST2ZTKSsCgdYf6ecUogK99iphRSGPmziVnc4PCzZwP0FzxWpG5RFvLGvNBbV4M1vMiax7aUHNRfylzQsjAQpSo38NSVqMsDYonQbeE0SLO4v6wZdk/iGCyxej2BJYehPK1ZdvhafpTunEE/vjo4wAZZ4zBvGGC7hOS5pGEP3bj7p0Px0ouBuoDl27qovGv2yDSJ0Bi79oH2W6zg69d5qXEtM7O5Q8TlYRdt3lH5TEn1CIVdjijINY8o9zbNSzoLSystx0Wshq37CcaCmvZ7bx13bLNXgshVhgrUjki4o/YBCEoSB6LiE8rDbv25yJEPz6DiBpxoBRTw09AuTMmCnPbQklhLlFhOPRZW0e6WGlop08iFr0EcH902Z2jt0ShBCpkxoQlK3goD6aEAzsHZ51AwNLwDEHLefeTozfgGZ3FCAjRxKOE7hxc/5IBUaWxWeuSWM9revww8FoBgXMKEjI1srvQeA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(6666004)(7696005)(316002)(47076005)(70206006)(70586007)(110136005)(8676002)(1076003)(36860700001)(8936002)(336012)(16526019)(2616005)(426003)(26005)(83380400001)(478600001)(54906003)(5660300002)(2906002)(44832011)(4326008)(41300700001)(36756003)(81166007)(356005)(82740400003)(40460700003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:58:35.8234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de8d26e-99ee-486a-7ec1-08dc1e44995e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666

Machine Check Error information from struct mce is exported to userspace
through the mce_record tracepoint.

Currently, however, the PPIN (Protected Processor Inventory Number) field
of struct mce is not exported through the tracepoint.

Export PPIN through the tracepoint as it may provide useful information
for debug and analysis.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---
 include/trace/events/mce.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..41a5431545e2 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -25,6 +25,7 @@ TRACE_EVENT(mce_record,
 		__field(	u64,		ipid		)
 		__field(	u64,		ip		)
 		__field(	u64,		tsc		)
+		__field(	u64,		ppin		)
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


