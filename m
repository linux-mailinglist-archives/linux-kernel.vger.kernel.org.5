Return-Path: <linux-kernel+bounces-126896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A063789441A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:15:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F08C4B214B5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B2648781;
	Mon,  1 Apr 2024 17:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JdtLx6E6"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEB4AEC3;
	Mon,  1 Apr 2024 17:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991730; cv=fail; b=P8kRVHQjCCZYSQ1pGy5I8EMPPMpDkQPz37jG9AyfoePEtNeQj80K9c45i8h0nOpSSt4xyTdIEpjaiDGI0L9/xilWkyWMsVJDtGLkEh4lNqbfJ5P2nKKw9PKgKb0dkFJmHwO2cmr+Wv38fUPgmJDTTFNUpfJox1OZ9olkhnewpcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991730; c=relaxed/simple;
	bh=or1j55GHxNjuMRt5VuMlfBagzt+a+svU8lwBWj0jjZM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YAAXP48MKuh5G1tHf8GUiw7Tw1rjO/Xp+L9GL0ku8+8Z+rafPJzAiOsTSewNwzQp6US9U6hO6iykJuH5FURtlCZd0sYmUTyqLWOhbCeHITzunURUhHumJZIyXXbZKpNbf3IkQZaYqER42SP5Tx700ufRA8aOChkUgbBlMi7He40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JdtLx6E6; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8tEG8n+dUwMITN6oEMvWW0NdMo6CpFnzmRIN03FBJuWsJSUdiIpHdgFFmHxZw0L29r747u9oLJxaEFpZ8258VvYMF3Ck/7183bWl7T5ts3F73XWngKhHmI+I1n4CdRDKGbCZInCURvSmAJBz5XHjNbF/5hgW1US+uL56KXLc33N+vqMFBmvnTND8W+deno6D1SwLLQXnPSdGnZcca7URrjPAGGx2/vzWOd74oeOzm9CBOL7ZIILU0w8yEtGFkxSASIhcynuq4ciEuwWQ0Ef+b65iMQxxqKXJ842SJG3KJGBvugksvscYLIepGff5NLds0e5AE1ExgKk389L9N9J6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyuuF8lB40MkrPXDywaOJZPd11HbnYFg4yLe0qegb+E=;
 b=fNN1IaV6qcaqasjIl97Yh5qUPv6p3q8Ry0n3i+AkeQFxl4RDzdzfRtJPYPvs70bVyGww4Ek9ZppqNjbqAUCmsbNS92GtvLb8ZA9lzBXFZ1rOOhPpMuycZjMtwqlSTEvu48YS93pFX5+GpuunIdS6ecfek/7YLxT8bf9YzKfrn7YMJx5PMZA4VD5tqwETKSjNiGVdzqAtYk/7ODUP8DeVyrQMTlMGbwBw8xvLWKt4hoqeCrv8cLrdKVOFAsrtImD6czP/StqbycrbkkLgW+qzP33QzMHR5gXOQvXvSl7cnwT6fHHMJLTclyFDrwoBKcUNaRQZbGcCB3yJusRuhFB33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyuuF8lB40MkrPXDywaOJZPd11HbnYFg4yLe0qegb+E=;
 b=JdtLx6E6eMZvOKRZd0WrN7nDOnFKdpmnYxNXYZV9xRprgoBc6SV/ABENkUvVO7mo+zwEjWUOMmjjy1jsdFqbE8sDOrg1RmmDFrfoENJJuvpWQaNXEtAx0ulyxc5rXc+x9HZdNX+9VFpMTlJ9eLqzw8WYGH2A6bFcFEcaRel0itc=
Received: from BY3PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:39b::18)
 by PH8PR12MB8432.namprd12.prod.outlook.com (2603:10b6:510:25b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 17:15:24 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::f8) by BY3PR05CA0043.outlook.office365.com
 (2603:10b6:a03:39b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25 via Frontend
 Transport; Mon, 1 Apr 2024 17:15:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 17:15:24 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 12:15:22 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <sohil.mehta@intel.com>, <linux-kernel@vger.kernel.org>,
	<yazen.ghannam@amd.com>, <avadnaik@amd.com>
Subject: [PATCH v6 2/2] tracing: Include Microcode Revision in mce_record tracepoint
Date: Mon, 1 Apr 2024 12:14:55 -0500
Message-ID: <20240401171455.1737976-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH8PR12MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cdf76a5-418f-4f5a-ad4e-08dc526f51cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kusQZYfEcMtzc9zOjYe05OW4buPE4wk3XGpxYzTXQzQbqyv9M/97SSGcxfu9V2thWN9XT1xnOokYu4Nn6OdVEFeA8kGsjOcSQsYc6pWpOXMh+5/a6c1+WqYO4ZVDid9JT2+WVy/2khQImMGhnMbUme7KCHXDAagQgJkHd9U3q0IwFGV5gZ4X1sAiqH7eGzvsq1ZsDkqh4ClJDzkOlxsV3yas8tldXxkXvRItoE7wsUJB4hvk3Aj7xEibEJrO5LP98FGSG4wpF+epCBczGsz7rx//Eh86XwG7XuThA48nZh+OagDouUreax1J12CUs5H18BL4kBoWK7s3PlyNzBwXcOEkxGJLmH5VGiYgHKrheSVfRWbdQQPTHSLjFF3YIOK9XFf6rK1yWDjEw4NMlxBaPzu7ezOa9M2K8XK1K2XEJjpnSlnO8KpBUJyreJil4an3wRbTTkisjMpJUD3BObZA8xmrKbLr6m1l6fzteHhr3dz9nywUmQkaO1BsY4NxqDxU/b1Bcz/5DKCEsm4Ez/YJ9QDQqNhlVkjq375WtfL8q4JJCQ/HdO/D7gXCjWyO4UtL2N5J8/8pO5P+ZTfA9FpShDk2W2s6varvZd+7uiWGDDp81W1+GO6W7C03paZPZkgpymmBiZYOeepBn0fsTcuEQWFwbAqilxqA2YfkEQwmXz0t7NgZ9XFetbOEhLeqXoo9FgG/his0DnpbBj2ioA9Np+j7eZa+nQRe5rqzoIQApB5bBfeZGsxcdLsYA6sJ1OM7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 17:15:24.4523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdf76a5-418f-4f5a-ad4e-08dc526f51cf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8432

Currently, the microcode field (Microcode Revision) of struct mce is not
exported to userspace through the mce_record tracepoint.

Knowing the microcode version on which the MCE was received is critical
information for debugging. If the version is not recorded, later attempts
to acquire the version might result in discrepancies since it can be
changed at runtime.

Export microcode version through the tracepoint to prevent ambiguity over
the active version on the system when the MCE was received.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 include/trace/events/mce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 294fccc329c1..f0f7b3cb2041 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -42,6 +42,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u32,		microcode	)
 	),
 
 	TP_fast_assign(
@@ -63,9 +64,10 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= m->cs;
 		__entry->bank		= m->bank;
 		__entry->cpuvendor	= m->cpuvendor;
+		__entry->microcode	= m->microcode;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -80,7 +82,8 @@ TRACE_EVENT(mce_record,
 		__entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-		__entry->apicid)
+		__entry->apicid,
+		__entry->microcode)
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1


