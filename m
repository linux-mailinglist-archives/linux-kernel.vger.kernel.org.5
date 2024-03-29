Return-Path: <linux-kernel+bounces-123941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E6F89100B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC1E21C24334
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD73C1CAA4;
	Fri, 29 Mar 2024 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VGiVzKDa"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CEA182A1;
	Fri, 29 Mar 2024 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711674459; cv=fail; b=U4YHzMUPX3XtWKxQ1AcVlKBXnN26DezQeI7gg3oeeNrzuuJPhUucoE+MAee0NJZg+6FJGZpqPvVdgLLYWZMLSLMLxa0xUuv+CUUz5bx+Q764zDRKMSG3gggWyqq7LN/svRT8gBVCxu2sEmntMppSaT2LUdAbsfi+0FL2km8XYAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711674459; c=relaxed/simple;
	bh=mTzTr2yBXRhcgYs2+vrickK9/ktmtYAX86BgarBT6g8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TIgS6jQ8g9gHorThZRFFW35ZYQxvPc6f+UEZpfrHrumM9AdO25/1sWZcWz1zsQLDP7MDlECQUQwm8yLxcARG1IUjCiTqKDxxXKizuJsXHJd5srgNTb3D9d42PrahH6w8dXauJ2lKVFa5yiOiQg20HABw77+InaLUZoWaAnFTAtE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VGiVzKDa; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG2h0Hqz/k0YN22Qu97JnKYS5CZ1mEdRw+ipgBPxbqGLI6IH95KuNoIeJQDmTgpOhMNjl/dqsiheixVEV+J0GXeqTFVLzW8nq1bG1VfqpeHHA54OmLBED7xen0vZgnO1eW45ckb7OVVY2hKjasZV4AFVquFmDDTZYeeNaqdep9BTogUX+AIgc47PLOsn/rrOpyFVGAa9GVuDmHUuJMmdySLt5GWGvrdFLoVo46eljHnNeP8bpr/mVksoTKEzF3YaYUvx5px2KPi+o6yJanFCaF8bTLzZCVB40ZOm69Ldhgb81CLou6It2VJ9GYDDl9FVeFZn2c+pGFc4HHBvIyqE4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaENX+lLEp5EGPbThUWz8uwtmmeolMR+QpH9oAlyhz8=;
 b=cFRxy0EnSyvEm75dsgUn6KikjLUlphntMMFANuthOV0qFsJO+fUw4PgUWrp9hAB8oryYM0P/W85KvPIEeJmohtx14s3OqO8gBMqB+oAn1X2iuYK+ywAPLXczaWWydUdAcT5fDI3YhRgtXyug8SBA/vQrS0T1OJY3F2X3VOn2CBc8n7yrZLY779FG81ibrIdUs8zs+ldhVTjTIL8kvE+quHjsTu8uxSUq+iCGv0wvDiCjFNMa9ySQ5yh0Osx7n2wXX2LEKSr1YUo6XTaz/CUXF2L9o7MiYXqznTO/E1p31mqGGs+3l/MlOJ21QdXNaCBVgudurA4h2Y0MeJ5aP4SUuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaENX+lLEp5EGPbThUWz8uwtmmeolMR+QpH9oAlyhz8=;
 b=VGiVzKDapu/qqX40nvHZ04eertTPRSU1BrXAO6X7mgnm4R4BnRub8tQvqxTxoNtf0Y5Jjhf5+j7q8dXp19S/MPTSbTsJY/vqF29DjYfQRdMLcqiPirs8R2/z0huypoOx/ouvhQODzSVf69Hi0kVqDPsKCOmmmK+bIerNLsIwem0=
Received: from SA0PR12CA0002.namprd12.prod.outlook.com (2603:10b6:806:6f::7)
 by DS0PR12MB8561.namprd12.prod.outlook.com (2603:10b6:8:166::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 01:07:33 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:806:6f:cafe::b6) by SA0PR12CA0002.outlook.office365.com
 (2603:10b6:806:6f::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 01:07:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 29 Mar 2024 01:07:32 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 20:07:31 -0500
From: Babu Moger <babu.moger@amd.com>
To: <corbet@lwn.net>, <fenghua.yu@intel.com>, <reinette.chatre@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<yanjiewtw@gmail.com>, <babu.moger@amd.com>, <kim.phillips@amd.com>,
	<lukas.bulwahn@gmail.com>, <seanjc@google.com>, <jmattson@google.com>,
	<leitao@debian.org>, <jpoimboe@kernel.org>, <rick.p.edgecombe@intel.com>,
	<kirill.shutemov@linux.intel.com>, <jithu.joseph@intel.com>,
	<kai.huang@intel.com>, <kan.liang@linux.intel.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<sandipan.das@amd.com>, <ilpo.jarvinen@linux.intel.com>,
	<peternewman@google.com>, <maciej.wieczor-retman@intel.com>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<eranian@google.com>, <james.morse@arm.com>
Subject: [RFC PATCH v3 04/17] x86/resctrl: Introduce resctrl_file_fflags_init
Date: Thu, 28 Mar 2024 20:06:37 -0500
Message-ID: <363c14eeeac99eb0453ac3429f9e7bd446b2acdb.1711674410.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>
References: <cover.1711674410.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|DS0PR12MB8561:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7b06e1-a749-4893-1623-08dc4f8c9d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7GaxCYLQs9YJK0mMgOFxXlLgsHaiVUt2SdHDM2zDAZ9Z6lulsCBXirky6qI0Xb8wDMxaCjJ4qXFwg4hw0Hu/LUkY/nriIDZQ2Kc/EnRfv1+rV6WRs0Kd4amul5Er2+mAHQkOQNz2iGrbdfkwrEq0SS2Vsc3by8afLMGH97Ce0AKyPuZMhIHVHsQcLlElUJrd1DeNe1POrUFcXfk9iwT3JjVOPdZWCjYV5wlWJaJSVRbfEhhvaCxf7swWzhjHmlWQ/JuQ6C3BSOeWZK7CRLUPAtv84rPLo9YinVDE8n4Mis/oJKrSaazCeE6if8tQnyefDRawHwFKN42YyuJme9NT+lW3FPW0v6i1tCWv/kwuc66pb8JEyEW+/R2pWXV5xF31YNySdkH3qLGhN5aMAk65hPRmxX1Ei5zRZICdCzHjKCeJ3QFNtraO0RQb7GT5+NacO4C4Qd5QkorfprBCPrrjAQQ4Lzy8os1oEjlOx9TK8LXLYA70tFQNlW+zRAnaMLuCfRdAw2HLpH97aMaci2laGpazR24B7SSeQH+NZQCMCjAt4k4pUXN0fFWL0GcZIxOX7MG+MmlpHkDGKYwjcm17j4AonKwrK3hnQoCEed43IuLCBURMzpdpCy27crBgtIJ6sQ9vf6mbtnXmlYlsU1ESlf74LXX/IjtcbiAIdWi10yLgZ2H3L9TK0rJqxJe6eLu6ugUcd5LRqYhhQtqob/xusoKtQ2ppM51jV8OHu3uJHmS5JpszVDnGz6rsopNJITeK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 01:07:32.7580
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7b06e1-a749-4893-1623-08dc4f8c9d06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8561

Consolidate multiple fflags initialization into one function.

Remove thread_throttle_mode_init, mbm_config_rftype_init and
consolidate them into resctrl_file_fflags_init.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v3: No changes.

v2: New patch. New function to consolidate fflags initialization
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 +++-
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++-------------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index bb82b392cf5d..50e9ec5e547b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -229,7 +229,9 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c4ae6f3993aa..722388621403 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -602,8 +602,8 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
-void __init mbm_config_rftype_init(const char *config);
+void __init resctrl_file_fflags_init(const char *config,
+				     unsigned long fflags);
 void rdt_staged_configs_clear(void);
 bool closid_allocated(unsigned int closid);
 int resctrl_find_cleanest_closid(void);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index e5938bf53d5a..735b449039c1 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -1049,11 +1049,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_TOTAL)) {
 			mbm_total_event.configurable = true;
-			mbm_config_rftype_init("mbm_total_bytes_config");
+			resctrl_file_fflags_init("mbm_total_bytes_config",
+						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 		if (rdt_cpu_has(X86_FEATURE_CQM_MBM_LOCAL)) {
 			mbm_local_event.configurable = true;
-			mbm_config_rftype_init("mbm_local_bytes_config");
+			resctrl_file_fflags_init("mbm_local_bytes_config",
+						 RFTYPE_MON_INFO | RFTYPE_RES_CACHE);
 		}
 
 		if (resctrl_arch_has_abmc(r))
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 011e17efb1a6..dda71fb6c10e 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2022,24 +2022,14 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
 	return NULL;
 }
 
-void __init thread_throttle_mode_init(void)
-{
-	struct rftype *rft;
-
-	rft = rdtgroup_get_rftype_by_name("thread_throttle_mode");
-	if (!rft)
-		return;
-
-	rft->fflags = RFTYPE_CTRL_INFO | RFTYPE_RES_MB;
-}
-
-void __init mbm_config_rftype_init(const char *config)
+void __init resctrl_file_fflags_init(const char *config,
+				     unsigned long fflags)
 {
 	struct rftype *rft;
 
 	rft = rdtgroup_get_rftype_by_name(config);
 	if (rft)
-		rft->fflags = RFTYPE_MON_INFO | RFTYPE_RES_CACHE;
+		rft->fflags = fflags;
 }
 
 /**
-- 
2.34.1


