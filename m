Return-Path: <linux-kernel+bounces-39151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA82383CB8F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6873129B311
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FDE634E4;
	Thu, 25 Jan 2024 18:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WymUOXSG"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B3A133982;
	Thu, 25 Jan 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208573; cv=fail; b=QkctChh351C0FAUi90K0qiTbK+MzqRPRnzLTcrJLtltXFj37SpOOPS5Lf8k0PEyeB9/HLu4VP8WMZsvu+cBpWpO1CS3fkcmSh97nkdmbI4L2gSsM9J8LBwbXkkaXYPUTFGo5Dy3Xfqcykb5Vp6qGdcckS/II02vaX0XKNOPl+mQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208573; c=relaxed/simple;
	bh=NbLBkF6zEH0uoaO7HeY/HuYPj2qnL8rZzd30Wjm/+t8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1NIKqzA6RfPF4vgiUQW/9gCFLs89CFWiFKfV4BrQovdxq4g9fgjCCl4WwPMOfaZCbnt2LQ0UVWABQo2oKLvgXAbMoVR/ANqCC4xh4wSC3EtDW9jo5D72GePmlTQioUxeVxXQ/QnS39kK4CmOCqulte6iHmmJ/azEszPxdrHuTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WymUOXSG; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EPByGBVXLRa7rlvAyZZ2nJtCMvLhuNDeDh2x/JZ0tiLfe+IE+ZuRg1z7W19djjjO2QwkE8ggEQLZKYwyzVmEmyAo9eN2aNcdIUFduzF9SJlFSV1Tz+8Lz1mINv5T28oiPmwT6NK4DAu6lYgWSRP8PVinP8X2kZd4J/hCGxkiPa9D58SJB8CewPKiJRcbKvjVRi10i8Y6o3MXPGLHkoKJDiyoFJxqJHlX7RBXkWSPspVnGaWIhwU2l6Me/eSsEuLwzH0VQ+prknpPWHBVJDdMQW1nQHJknR2/1MicbLDPRV7cuVw5o12c+gN56qDiUT9zJRLdQnKVT8EWuGQFhZL4zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1aS911bnnQpF6alcmkt0tnVlyg+x4JGAWKNBwUWhmtk=;
 b=YAyPIzez5u6KOonIAOY4AaTGglrZ53QrsemQElv/Ro/vYfruMCAysJrrkMiipkpx/kZOhER2H+7Y58fhGvaJKyuVLl3ev9gN1+oaMt/0Fgn8vMN8+HyXjJy/p/D5ci7NjB24noH6aV4W+4WTDSGT5nGZsaEAO59pZlVT5HzmDVm0xir3RsahCF83PbZjVUG7h76EcGFAkNxB7+22LkwAbAkJ4bBadTb2G6qj3aQNNBF52VSZbacfNelK9g6me0dZsIvj/uRQzAXgh0/NivGXNqPx/UyG7LZhyWk0S6b09dzWkYBzgzTl2+sGc7GmacVameWJME9f/6m00H41GdYacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1aS911bnnQpF6alcmkt0tnVlyg+x4JGAWKNBwUWhmtk=;
 b=WymUOXSG1hT9kYTAu4Osa8bkguEzGfE3ezBSLSYmKYx+b6+6aUJ6tpOBgC5lZ1OEm5+l2A2p5JBK2wCy2JIfZrEJMvZoaojV9vcsKr0BrL0oHGKLaAoa3eKI3HPOAVK9ZVN8LREUETYyhsTWJ5IJrWP58bNDCQ5uQalOTHJf2TU=
Received: from BYAPR21CA0021.namprd21.prod.outlook.com (2603:10b6:a03:114::31)
 by IA1PR12MB8078.namprd12.prod.outlook.com (2603:10b6:208:3f1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 18:49:27 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::88) by BYAPR21CA0021.outlook.office365.com
 (2603:10b6:a03:114::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.8 via Frontend
 Transport; Thu, 25 Jan 2024 18:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 18:49:26 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 25 Jan 2024 12:49:24 -0600
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v2 2/2] tracing: Include Microcode Revision in mce_record tracepoint
Date: Thu, 25 Jan 2024 12:48:57 -0600
Message-ID: <20240125184857.851355-3-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA1PR12MB8078:EE_
X-MS-Office365-Filtering-Correlation-Id: 4262f079-1670-4a8a-f45e-08dc1dd65afa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	On6V/ByPgWvve2lGG0sOOJd+Tvt/dAk8UwpZjMGu09MGOz/UaeDtFxQCkXa2YTiLmSIXHfN9DCsl5ujdc1oD2ZVrwKJpboLsM9rL8tPmjDu5rMC99dxpCRG1aDf5beXTcuE1UCsP39XeK6xtuMPdCHIDpsornpQHVo9TgIiSyzwCLstOK6gd1lcclLofpmGCRkGtiilKqXb/0rWDa1DIPfaRVJ+G1kZlQ0FWZrRsBFjZAse9/Q+cPEvXO0GGdzDBsc7WzCdxpIO0GR0TDCCvUG9yZNB2b305OuH8jjdNpNse8fJDzfPxYSVOQR9lWQHAo3x65qJ0drhKhOj/kC5apHW5E0ooeEZ/Z+3vNRUJHYZjfM7hxPgKztyozSjzspFbxJuOXumnm5eDHO77bI7j20q4sMmNY/iDXHgVIFqK/r2xx8qsSWotmlpWRmgQTpLr8c1p0aNgr94WyQq0rnQKnLeGtPtscuL5rkAWN4HUWKIK077x5KCZg/RL8v1na5nQXM7rj+uKW4XK1Pa9b0XCa041q4vtZPyEy9utHfdyZFNhIgUoLgfcpUDJug6biliiKg2cIDZZ6LnMsZpUjo2mrMTmrqyQO4t0HGfi7PvstTLluJ9gYXwZkuTCX0QnNMWWbe/8uU45glrhgZpdk5ipH8WRmtKVHMwoVvnxFpANEt3p2Sv9MRjHqdBCThsMmLmGjbR/bOR+rJn3hzp4Y0q7iMrvQ6UPCLMwmFIis6aMI6rUkoA2kDOrQGN1AEvVWK5w6Rv8n0yJMsuHgMEJj+8n6g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(64100799003)(82310400011)(186009)(451199024)(1800799012)(40470700004)(46966006)(36840700001)(36860700001)(81166007)(2906002)(36756003)(41300700001)(86362001)(47076005)(82740400003)(356005)(54906003)(7696005)(110136005)(316002)(70586007)(70206006)(2616005)(478600001)(8936002)(83380400001)(426003)(5660300002)(8676002)(44832011)(6666004)(1076003)(16526019)(26005)(336012)(4326008)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:49:26.4964
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4262f079-1670-4a8a-f45e-08dc1dd65afa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8078

Currently, the microcode field (Microcode Revision) of struct mce is not
exported to userspace through the mce_record tracepoint.

Export it through the tracepoint as it may provide useful information for
debug and analysis.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
---
 include/trace/events/mce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 657b93ec8176..203baccd3c5c 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -34,6 +34,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u32,	microcode	)
 	),
 
 	TP_fast_assign(
@@ -55,9 +56,10 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= m->cs;
 		__entry->bank		= m->bank;
 		__entry->cpuvendor	= m->cpuvendor;
+		__entry->microcode	= m->microcode;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR/MISC/SYND: %016Lx/%016Lx/%016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, PROCESSOR: %u:%x, TIME: %llu, SOCKET: %u, APIC: %x, MICROCODE REVISION: %u",
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


