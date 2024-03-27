Return-Path: <linux-kernel+bounces-121999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E0B88F082
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2F1F29C615
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C5D15350C;
	Wed, 27 Mar 2024 20:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u1tbNQmG"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2065.outbound.protection.outlook.com [40.107.96.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E73F8152537;
	Wed, 27 Mar 2024 20:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572903; cv=fail; b=N6CTwo5KQWp5FFMCGl0j00nJXnj8P+kLVLerRjLufRRdNc14D6U6D2lzfWOqav+Lv3PEYeklRUuhqgHPcmtaVHRTAqShXoTtysJ5Cg7JA4Ns/gHBhavQubzDuIfY0KeS7puY7XrKUxqGJv7JRuvxsHH5PpkxVgYsBPjo5QGOTdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572903; c=relaxed/simple;
	bh=Y040xdzNSKZAwglJhGqmq4D07zf67B6leV4ult4LE4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nS3TGZiN70Nzg9SDgHhHMWJ+TkpN8kUdGXpGoEMPhelLZCxkUdA4pVSWMR/rD0wi7dRHF9vq0ZjvOiqpGnt16oLUXgIma18InJb2StPjDBssFAYTj0XPHlzmUH2Ubi+rikgEydeulYN9vq9UbnLa3MgwcAB5eCufP/3oPTFqNZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u1tbNQmG; arc=fail smtp.client-ip=40.107.96.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1ie2qEAOn+D54rUqp1aQB2vGD8JihBgh2g4D3KhbhlrjoIOmqtYZUaEHamu//oQqewhBh7kfo9vrQSK6+SzjNqgwisgaXsoqlefJT7SCRt8Yu6CJLUpigQlYjmPqVNxS+eZfNpfYlTLm8R6Y3xvqVX2ZSOcbW0uw2UH5oUYyXeNaqX2CuBP737mnISaoqRXwG61eNPun8BNFS2KVyjuX3v16toXLBD7hgYMCmTS7euzf781dH26EWTN2tZxbBNJLLEW6lVwzfEPKSAB84b0fKpdjpdx7XJCb4fY/STpHeZpkAYNcLyUBsx82w84muu1wtFU4dzhY/VqKmvuOvbeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yv4aZiYVOtsVk6kLkr6ayho0dX72NerINjbeb3rsJuM=;
 b=MQVwxOv6b9Zt14dLu8fYafiA6/x2q4KFTkE+prXr93eY5W4J1V8l5zjKk5QMJPQIZg/FYVMOWDhwUeYRkBFDpiOWxacHa3go0qmovLgUT/khuRiofLbhSGbqkGA8uhN3h72XJJ9DzGDrDvK9oqX7t830sYzQ8i9lCj5AHFrceb0n7UljffKNex8MBUzJrA9q6ogRl+c149/QChPYj4XYxWXMk0/oeA2/hzrGqptscE4xsE/ImTZiRX35FZd2lSch8LwxM6PTie7UDrIslhLE0qcxfYdLiBzvPKLRI+KjmawmJqTekjgahIdFcFV0F2r07OareZpNkiaOOgB3hyz0Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yv4aZiYVOtsVk6kLkr6ayho0dX72NerINjbeb3rsJuM=;
 b=u1tbNQmGCuABHtRDBmZtUl4zDVQNzhtXZD7zUwG41N/q33JpbX0dCe1RGJ/zcYRv2KnZUiPz0nm87ua4kQg/NzIOK6+s9DuraUnL4wOiH9IQiqvSeifc1XID42aJIe6V2rfr9x4XHrL5vUb7dcI0j+OsXUXz78rMWJYT4/qNmMg=
Received: from CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::24)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 20:54:53 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::88) by CH0P223CA0006.outlook.office365.com
 (2603:10b6:610:116::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 20:54:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 20:54:52 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 15:54:52 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v4 1/2] tracing: Include PPIN in mce_record tracepoint
Date: Wed, 27 Mar 2024 15:54:34 -0500
Message-ID: <20240327205435.3667588-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327205435.3667588-1-avadhut.naik@amd.com>
References: <20240327205435.3667588-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: 88992df9-9658-45dc-a62a-08dc4ea0268b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AjT0K7X4fosCTIMbQr9Mfk/pDZbJVX5W+RA7B1mFe+kvpy1oNcnGMjJ0dP19TL1wY5wOl+yGiTuLpzyhA4WHJ8O3FVqTGSan+RiVXsUaP9YuYIBbfYDkM6hixIA7ebABUmNhVphf+cwPar/moZOXKcNLm3SsZGnOmmxyZu4iZayvqIpKPi4i+46XWq199B0dOb+oagZd9ldOQYMcAMZSFGA1L4cQ9mRahgUPyQm3LNOCxckrK8jusE7OVIDi2KuSIFXVXL9zzjkZ7F1++rFtIu4NqFCXr7Q0ZE2eWKag/wtbFlevgLaFv6SbqAa7AyU4F2GJxX+YDaeoxatnSJSj8GtBSDOvDstqtgDfqtk3PiCmXl21IUGv1fgu7f4lGVQFIJLsZsI43e3kXFlcJ0jlivXkTUtMTbabDVgQAZmOC7j4qgeJFEUTANjvgV0mRNf+IL/aEQBF1DHSF47sqQcAKOKfi3rhjX1oU9HEDm0fz4eqbW/jhwwpUQtVDXEYmfqUqW8CTl559u9fTZopgrBPvgXFvat+bZ58TieUMU1MqgGC2GXMaOKDHioGSQvm+JVd7YtWjQx0Jfz+8NVC4F2i2QzVDBnQJ2jgGUDKBPup7IvBVC7dj2o1tA6Zgm1AJWPojMuMp5Mb2ShxfBP0llLzcKN3NvR+yhg0VT0DLPn2nOY5BHO7FKnbISAHzhPfK0PxVVa953jjAqm3CKAW0d8ooMDIiUNTFFWR0PLVrsIjwkxyo4ibQGa4kSiS8SqWL7LW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 20:54:52.7562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88992df9-9658-45dc-a62a-08dc4ea0268b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065

Machine Check Error information from struct mce is exported to userspace
through the mce_record tracepoint.

Currently, however, the PPIN (Protected Processor Inventory Number) field
of struct mce is not exported through the tracepoint.

Export PPIN through the tracepoint as it provides a unique identifier for
the system (or socket in case of multi-socket systems) on which the MCE
has been received.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/mce.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 1391ada0da3b..959ba7b775b1 100644
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
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
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


