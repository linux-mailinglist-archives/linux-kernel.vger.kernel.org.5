Return-Path: <linux-kernel+bounces-126895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0DE894418
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE56C1C2169C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9334AEF0;
	Mon,  1 Apr 2024 17:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cz71dSQ3"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2041.outbound.protection.outlook.com [40.107.96.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6140948781;
	Mon,  1 Apr 2024 17:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991720; cv=fail; b=tlBfpmZ1CjM7TKHyKwmF1z99SeDX8LqWW04vgwp8XGLB4rNy7TK4gEW8G7Cit1NuVvssP+4fGrRQy5QiiCYYP9p5u1LjCZMAsYFvIUYLNiA/1QxduXWJgmM5nQ9kn7CKJRTmvgremljvxKcCW9C8WsWJ/N8n2kzQm0mpVP9Jb28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991720; c=relaxed/simple;
	bh=YnWoJicTFm+PI6G81czHDbozd/m9I0uQ8xiClJACEWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vCS9Sf9kZxtC24QqfTJt3Xra2v7bzz0ZXEug/feRHgvEq2gWDQk9ftLYbuWs9DGt7DEN38zR3Shjealqpnbaan2dTWkNY7Niu4/i3mxNHqelsBKuUInFCnCmSoe+RVSkHsBKpmWJPeC3GJDHOw149f5PDxebevlcbQpCQZM/rCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cz71dSQ3; arc=fail smtp.client-ip=40.107.96.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHeOtUdgAdhZBKsgwue0aa6PPVB3IW4lzFqDMLGwAuE5o4yhdVvWZBkCigsTXf2Cwf5z9zX5fQXruXIEDVnkAmXI0fWPrH4aZp0h0A27wUDIYjF1s/J4IPcy2mJn93PK/741KNj+DdcNGY2AL72tE4PPDuEbC4iw2VpvG6LK8ZvxnyIm6807/xVvBCTatDquY+fzuduEMrbYKffcv84veTYJSFDl2975JX3PpAImF5wh9cC1+BhXmRL11nmGNbJvzJu6vaKbWxo1cz3TF0IUTfO8yrTcYqp22+0MqMkPxvUITCU0WQEtVUmk289nVA1RIgjqoX289CJdw25+5+aH0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOQWYGyLCjG9hkBQcr0XLruHlRsI8C/CsN5RXQzv5Vc=;
 b=BCTlaFXkSyzHUMrcPu/l3vnU/v2s94FK9CHo0carwJ7eKocWRjDLhO38kXCtUnsyQulQmvMjQ0C1zNtChCXVI0BHDfrWFlvRYcotyPhlb9HuL0CeWdDQVX9XB1JU7gQfeVOzJqhzoDM4QqWDBCBJAVw62Ha7YM+VGLEqjK/vH4odZGu5o5ESAirpiH4/3Z6mqkpMc/Cx6NtRmQYCwccYrBp2iGhrwFVbFbPuGm6w1zqjVvV/dV8ud9xdIhdfLrQAH1MH6B5VoQ1zWUYTaN6nmajM6W79woG2SqQAWHMLjsxIWU1F5fxEaCqVnM6W68Ob8VOYqnhHyJjxWnofjo7W/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOQWYGyLCjG9hkBQcr0XLruHlRsI8C/CsN5RXQzv5Vc=;
 b=Cz71dSQ3Hab0B4Gr13YvMz8gt7vpFe6IV0XN/dBryeiXDB5eIs2coqpKcT+ymJ/YoV5e1KWEMLXg1LtXIBKcNxVYNxGocyW0g6VQGMng6SH7P/9cj00MVgey0w5tEwndijAdfzLxGlQL+H5Qd1bjTjY9ytcv3iTn9mFWyl4WxKg=
Received: from BYAPR06CA0012.namprd06.prod.outlook.com (2603:10b6:a03:d4::25)
 by MN2PR12MB4063.namprd12.prod.outlook.com (2603:10b6:208:1dc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 1 Apr
 2024 17:15:14 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::95) by BYAPR06CA0012.outlook.office365.com
 (2603:10b6:a03:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Mon, 1 Apr 2024 17:15:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 17:15:14 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 12:15:11 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 1/2] tracing: Include PPIN in mce_record tracepoint
Date: Mon, 1 Apr 2024 12:14:54 -0500
Message-ID: <20240401171455.1737976-2-avadhut.naik@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240401171455.1737976-1-avadhut.naik@amd.com>
References: <20240401171455.1737976-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|MN2PR12MB4063:EE_
X-MS-Office365-Filtering-Correlation-Id: aa098e71-2cf2-4115-a1a1-08dc526f4bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u0cmVv5WN8IfM2I/lClLSm3/Cz2O2bRBM/9TbF9w5Dpa++iTALyt97lKyVXeGs4Ys27QCVgfXfsZZ2aMcveQo48Bw/jyEJtvizplfcn8s5Y9mLTvqCmKUsDXd8/CczO82znwktLfI0pi6M6T3HAxSPlmRFQLmOBPdGRKwOBKAyx+dQnqRaMWimjg4gQfXJ27g52lDyjK4QtHRL3TfRJ6tu1GyWqvIg9Qq7TlNsKRH2SBcCXdUHRIy0+A+BdUazo8i4QY7rlTJbDSyuqElOtYJWAkWJrZIk5ohkz4isnlPnoZHHNqzSovfu7SW9zhZvuHuTTzGThuShZxqtl5jtIisywbMyggbfrdvdbXhGvP3DnqJZJOZkfk03uU7UeaCsHF+E2f3h1c/YPktIVbUOvXI51cbOEc5BT4mJCJ6HaXYw1LqWDJ6Hv3Q/0uMR+nUCNfzwYW82MuAuXpUJ2B7pmJnFQToSiLKloxuvAjclQiTmmIspiX6ppm42ghdr9Lh9zremLXVHq4xZE0unjx1HNO7eT8W9CbyMkTSSH86OC3oa7nxx2Zt5BLeF58c02X6wSCJlW+wXv7lQicaYflcx7gSLhSzfYzWoYHtPe+qlZBHpQTOTjt4RCwzgocgYyz8EokVV7W4o632Mk56yNBVHhXeBeHyoQs9VkTWfJGu4U2W23vQQ6AThu9iXyG2FlJ10JTVpqVuanBFT+JtqmNSxGI1ohzi2xVZO5uHZ1dXYZwNjRkrQowWW+NM+a9rLnIG+de
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:15:14.2808
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa098e71-2cf2-4115-a1a1-08dc526f4bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4063

Machine Check Error information from struct mce is exported to userspace
through the mce_record tracepoint.

Currently, however, the PPIN (Protected Processor Inventory Number) field
of struct mce is not exported through the tracepoint.

Export PPIN through the tracepoint as it provides a unique identifier for
the system (or socket in case of multi-socket systems) on which the MCE
has been received.

Also, add a comment explaining the kind of information that can be and
should be added to the tracepoint.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/mce.h | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 9c4e12163996..294fccc329c1 100644
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
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -65,6 +75,7 @@ TRACE_EVENT(mce_record,
 		__entry->synd,
 		__entry->cs, __entry->ip,
 		__entry->tsc,
+		__entry->ppin,
 		__entry->cpuvendor,
 		__entry->cpuid,
 		__entry->walltime,
-- 
2.34.1


