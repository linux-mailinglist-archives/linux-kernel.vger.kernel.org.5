Return-Path: <linux-kernel+bounces-123875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C96F3890F21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40A9BB22059
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686588F5C;
	Fri, 29 Mar 2024 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DgnHmVUc"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E158F4A;
	Fri, 29 Mar 2024 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711671704; cv=fail; b=Sm5xMEP2EEbAkj3KYAeQmLElESOT8rIBH1AvowKgsLkG6CDnpmkxPNabHvCQ3LkpwsKitEXtheRegqOuewgUZu3Xw4SBFi/cnIPwmX18fSOWOBLKZtJHR9EotcGSU8VY2EQrHbm0bC+NEGKBZafSFb9QmZXFkVz0dxt3Op+aXGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711671704; c=relaxed/simple;
	bh=JNhYmKBUnMoBrfohVEozKaFOpmhMZ1PUZVhcCQUQBmo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsQpG3Jb5XKi1qeBICLkeBv4Ej5719ysyhh/QOpSGj8MQpL37YHUk+POf2eLsF5wQ3RfL9Y9CVSzvYSHd8sZDByoc71cWkC0qoOjI7J3ySGFFNoUKR/l9HWhiO1ed0PSvqDp0551kw1JxiL6I6qLd4oHPzWrkBG2jq/laXs9wQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DgnHmVUc; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIpYTULv0ePnCSOZ/xpyyY0vUEHqCzNU7qd+6In/DIoNK4d7hemme/iEPytT38VbmXDJSmC2AbA0dh/wZZT2ISjl0Twq9WJ8uxcngWLKqFh8tzzHfmCSJ9nDkJjAtGFAqM9VVN30+1LQkFdJa9nh8DDQ8DcHC/gidG85IzI8cHuMyyS/pXqHgkY5uPqxNMJYgFEJgUO1tiXKogo09zYWiw1ISbhHlgZqQ4OypILzlv6io99uTWh3v/GWzxM+0+/KxO1Ab2K/+CH7soZgkR8symCEbElOQJ3aX3sq2heKQ1mYwY1te1/8CfHsxIiutPeuLlohWMDAxV1T3w9oPZgb0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hM3RVu/Yq+xz+WubqeZNExCSlS0NGkq4s08Xy+zSjsA=;
 b=hBYzYNj0BlPFJxrqeYyLhah3KNjBR2fzfG9EaUvENjI/hTa3sBuMpcPrTnkQXreUOD+YY6ORvZoxS/viNZGDTNfVpihIJF5ouFLNwtQI6I66K+wI8UBlYwhRbslwRoyZMqVaxvyVwnOizdWX72EzRNeQtvgd8FzJMlhOwceBHiy5dDjL2O2fSek3ElZBDO0WVriiHBMNUwZ1dIBwc2D9bDydQvCtfEprvlJLcrTT4NsfcXeqawcbqhK+qsY7ND7v7ojm6rskfVam988Gp2IMF/41IvFAY6BrmSudIo6j7M2eQXQygD8LwJ3KwH0Qf7PiVdoSPJfAK5E8A9dVFGiJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hM3RVu/Yq+xz+WubqeZNExCSlS0NGkq4s08Xy+zSjsA=;
 b=DgnHmVUc9gmuTNe/5ukPTB3VYBoHJMWsMdH8PvagseCBvXwbt/PzR8tQsky7s69su42KrG7orbKH+NRjLiuiIIH1BnPr+wT4wWEqR6pbvI3ulGDEIUVmAYG3qNPpPuP4th/wPvQg6htsPpbqv9BsmjzA8fEoBg+q2J5mPZEvZ2c=
Received: from CY5PR15CA0080.namprd15.prod.outlook.com (2603:10b6:930:18::32)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40; Fri, 29 Mar
 2024 00:21:39 +0000
Received: from CY4PEPF0000FCBE.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::4d) by CY5PR15CA0080.outlook.office365.com
 (2603:10b6:930:18::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.38 via Frontend
 Transport; Fri, 29 Mar 2024 00:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBE.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 00:21:38 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 19:21:37 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [RESEND v5 1/2] tracing: Include PPIN in mce_record tracepoint
Date: Thu, 28 Mar 2024 19:21:15 -0500
Message-ID: <20240329002116.436824-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329002116.436824-1-avadhut.naik@amd.com>
References: <20240329002116.436824-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBE:EE_|IA1PR12MB6332:EE_
X-MS-Office365-Filtering-Correlation-Id: e5293a31-6159-416f-9c93-08dc4f863368
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tmy5BXZKoLtYtFvVfc/ysLeWQBnewPJaaPI6U73Y3+gbXiEAb+vlRCWEQr7ANj7yID9RXJPwNbnDnxng+tLxp9LBhJ5icmAVSc6Rh0L+sHL80PMmiTFf7lc9uAEjd7G5l7KgAE7tt5K2cDGGZFTIqYH+C08v/ht1bHw6H20nzDPSfE90nkg4L3UbICRMyq2k8YdA5DR1Z9HTxUW0uvDa0loO3AHbmD5ClNiijVdFNw7FkccljGIiHxQM8dYT1K3VEuC9mJhqfWgLPO3GrW9AjAMTOUlkWpqfSWwVFckr/AjNlH7uvlozX8OP0IkDgUsCbKX2EHWXiNnQFuTWJPTqWDt7rD69zy6KlliGL2VZ5jFbI2eFtDaSYIT1f3rFHIkx3znKCBvw4RONIyjVauzKM7a87AZiNf/HKvQDykCh9LSCDZhtB1jGpWgYtzJZSXvUkB0LKuocRX80HNhtMN9A8jLyMorXB/EdUGd4a+Vg+AR9jxGpumPkteUA+yk/tfXotw0pykGja4kn0QxiKwcv50L+cgBrsrC4wNazaX6NUvb8OpJoYIuCV5KmrFlyPqY62CLivlja5gY/PBU2SKtZUEbJJvJvdM1l9h7Si/GpBwL93odaqzFYIsNTyhHmvXP2VIL2/B4lih9TRsHLRqOyQkLCx7VzWN8J6+ymqPNuVxmNq06K8N1kQWEDcRO/DZG4Nr3NMWcclzcW21KkpT5TEZp2ZXHD0s6l22RwAcDtMKJZp/WHX4gQs1uKw/jZwcRh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 00:21:38.5379
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5293a31-6159-416f-9c93-08dc4f863368
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332

Machine Check Error information from struct mce is exported to userspace
through the mce_record tracepoint.

Currently, however, the PPIN (Protected Processor Inventory Number) field
of struct mce is not exported through the tracepoint.

Export PPIN through the tracepoint as it provides a unique identifier for
the system (or socket in case of multi-socket systems) on which the MCE
has been received.

Additionally, also change words which are not acronyms from uppercase
(ALL CAPS) to lowercase in tracepoint's output.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/mce.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..2e339ac9d706 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -9,6 +9,14 @@
 #include <linux/tracepoint.h>
 #include <asm/mce.h>
 
+/*
+ * MCE Event Record.
+ *
+ * Only very relevant and transient information which cannot be
+ * gathered from a system by any other means or which can only be
+ * acquired arduously should be added to this record.
+ */
+
 TRACE_EVENT(mce_record,
 
 	TP_PROTO(struct mce *m),
@@ -25,6 +33,7 @@ TRACE_EVENT(mce_record,
 		__field(	u64,		ipid		)
 		__field(	u64,		ip		)
 		__field(	u64,		tsc		)
+		__field(	u64,		ppin		)
 		__field(	u64,		walltime	)
 		__field(	u32,		cpu		)
 		__field(	u32,		cpuid		)
@@ -45,6 +54,7 @@ TRACE_EVENT(mce_record,
 		__entry->ipid		= m->ipid;
 		__entry->ip		= m->ip;
 		__entry->tsc		= m->tsc;
+		__entry->ppin		= m->ppin;
 		__entry->walltime	= m->time;
 		__entry->cpu		= m->extcpu;
 		__entry->cpuid		= m->cpuid;
@@ -55,7 +65,7 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor	= m->cpuvendor;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, processor: %u:%x, time: %llu, socket: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -63,6 +73,7 @@ TRACE_EVENT(mce_record,
 		__entry->addr, __entry->misc, __entry->synd,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
+		__entry->ppin,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-- 
2.34.1


