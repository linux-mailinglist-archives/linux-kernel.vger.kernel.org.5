Return-Path: <linux-kernel+bounces-39734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E6183D586
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ABBF1F26B58
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA80657DB;
	Fri, 26 Jan 2024 07:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HwiKmrbL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2051.outbound.protection.outlook.com [40.107.223.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38259125CF;
	Fri, 26 Jan 2024 07:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706255931; cv=fail; b=QU9XvtInD/uXDKqTaIorWrZTwPKC0oPHaXpAT/K2hCc/5AzNOe/XpuiaEh+taCJMcCk2Vt4GQ/X5cA0jksCWJFgLI+mH6FbbSX1ccHzURgum5DVwUCIvp0qIYMs5+8UkXOP/sjyUyYPb0tMxl0kyvDguCl1P8+ERKhwnE/Xr6ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706255931; c=relaxed/simple;
	bh=LtaEqIfxFZS4huW9aaG8eEPYx7fpmVqhpqHwMBD1vno=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bz+LWC41OB3O+jidQicArfTARCVy5SU0TPiGCIySGYSCcW4vVgPY2ZbWa2wkY5p+etJhck1HLHw51eblnwNmY6SX0AIsOVcEbiBt77bUpKScwKKwpcVrMJaTAm6HxNnbsVgqWNxQX3kG8E0Sw5Axo4d2Z0ax1bYS+jgnpTY/08U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HwiKmrbL; arc=fail smtp.client-ip=40.107.223.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4UQ8JGgw9fAMr8kJY0+DBUo4t/HSlaBeERZCgTR3WZzz7w0oyeQDy6F3SJuwlrmf89Py5xoms1VSpCsT9nrnTTRlMT1brkjSVvGF1Mo8+ikcLgFYITWfE7oo5tSRkE9cRKLnC00WkNgJXfvhFllPEqVS0u/EeC3jcvlfy5mVHNxCh2nrgiMsi+tq6TpiwyDKhhB4TLy0ixkzLZNZw/rM8IV+8fP2x2UysfgzNXFQa36aj8GXNB5RoMUNCecRCB63pRjqja4Yui6J8Yqve6ZQA3wAKN0cWUhEHr3AAWGYDTFNNmZPe+Dyxhj7a2wQQqf9y+9wRl8j8knHxQwAa5Lgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1BT9/HhOlBhCqHHbgyA4zE9BXWpo0q27U5Et772Pck=;
 b=QiILCLO/qzkSi8HY8wQcnpecaG5LVY9cBLKdx2gMmUxdXpzEJO4r9yLjKNuPsicADzstMwRe8BKGDrx/Ifo0espihTtl/Kin9fUAOSgyIY4NCrJq0q8m9454hWRmk57JTs2hMA1XG4Dt4sL01utfO/U4DXjvvyBf8w1xG79eL9eqCWurgLHQ2SG0D1ZjmwM6htWLH6a/MetSPY5Roqr3jU0On8x/lE7NqEoRdFcpeFV+2ZnsfGi3ko0Sek2C2pCBoKttMwtSfAjBMF6MtFvg+VWfRhUt1vgZtzFc+oHMPalr9Tlfw98pjjeeEeUgHQHT4isybr/0hboGVBNQ0spHBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1BT9/HhOlBhCqHHbgyA4zE9BXWpo0q27U5Et772Pck=;
 b=HwiKmrbLI9A57Xaq5p1mAkTnYN86A06p/1bir64IxPu5IJvN/yyoyQU1am5oU2+sf7ZClYX4sNgvu7vM+BD6PLGd5a93CiUn7PdeeZR9nuSTY8suVDClTz7jUyTfyfA//q1r1yVr+Bw1vHWbZIKfcE2jLkoKVhOFt7MRVlkQMyE=
Received: from BYAPR05CA0072.namprd05.prod.outlook.com (2603:10b6:a03:74::49)
 by SA3PR12MB7805.namprd12.prod.outlook.com (2603:10b6:806:319::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 07:58:47 +0000
Received: from SJ1PEPF00001CE7.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::f5) by BYAPR05CA0072.outlook.office365.com
 (2603:10b6:a03:74::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.20 via Frontend
 Transport; Fri, 26 Jan 2024 07:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE7.mail.protection.outlook.com (10.167.242.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 07:58:47 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 01:58:45 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v3 2/2] tracing: Include Microcode Revision in mce_record tracepoint
Date: Fri, 26 Jan 2024 01:58:00 -0600
Message-ID: <20240126075800.1174583-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE7:EE_|SA3PR12MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: b4578f20-4b88-435a-638d-08dc1e44a049
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2rRwTxZYMFwhBINFWCg3CVUxzxgKVRPc8Jg360R1dQ26CQ3DYMqJ6bvnX7NV1VyaUSbngsYHOSUOeM8hycyFhFNFazF/QNRoujvUoDCXE8xzmJdLw7tSh6dSEUg0xWTLAFXNMLYnh1Byi6HolO+hs3RRKCmzVYfmzHFsMAf+MdWcDqBj3kd46ZPEyBdNxRCBlq4VHSSc9e1Q9Jcl8QYv93nkHloWoByfULRJ8qvAmxxuYC/WsyyDQs2JgbK/IFVmhopEDFq09dxJO3mecoJ6cb2O2h88gpkz1S128GyVPuS0X5XNNG/gOs7kP+C2hkGaamwXDkh6iriu7FaqWRLD6PnCvWTbq3DvIYr6zXlcnkY+MxZmFwNdUISSZ9kat+p9yRf4WC3svny8hX6LfHqWnFM7gw00iN1L7yvwPwGRct/tnxvjZbgkr7yE5fCr0ZrJTd1ZwZHgzbYTE73NZ24hcXXjMxcSJcNmbbZekRU1Qj/aBD3THsHqDcbLOymgAJGV3gTXheg9V3d6cuA4ElSCWEj+GGlS41ACnacCYJ8WXQYD4Jo7NAajTR7K0C60vNaYdf1zYdHn0G8cIhzi9B0jV6GjTAlcMKQpDjpKhoLtxGk1DncTCjieF023hykRnzUr8coz/QVemKedszoEiHKlSg/+m+0xeDNdcu3Oq8hu5gAjL7Lbb16YJtCnD5uYyqfjZLsDGEd18zmQqmVA6tFyvFOgZyZxwKPh9kDRFQu5BfLa9RAui5pvHKF8BDdfR5hL6mP7aUjBLFhdrvtxCVvXZw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(41300700001)(16526019)(26005)(7696005)(1076003)(8676002)(83380400001)(426003)(336012)(8936002)(44832011)(4326008)(6666004)(478600001)(70586007)(54906003)(70206006)(110136005)(86362001)(36860700001)(316002)(82740400003)(356005)(81166007)(47076005)(5660300002)(2616005)(36756003)(2906002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 07:58:47.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4578f20-4b88-435a-638d-08dc1e44a049
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7805

Currently, the microcode field (Microcode Revision) of struct mce is not
exported to userspace through the mce_record tracepoint.

Export it through the tracepoint as it may provide useful information for
debug and analysis.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
---
 include/trace/events/mce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 41a5431545e2..2857f6801e73 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -34,6 +34,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u32,		microcode	)
 	),
 
 	TP_fast_assign(
@@ -55,9 +56,10 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= m->cs;
 		__entry->bank		= m->bank;
 		__entry->cpuvendor	= m->cpuvendor;
+		__entry->microcode	= m->microcode;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -69,7 +71,8 @@ TRACE_EVENT(mce_record,
 		__entry->cpuvendor, __entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-		__entry->apicid)
+		__entry->apicid,
+		__entry->microcode)
 );
 
 #endif /* _TRACE_MCE_H */
-- 
2.34.1


