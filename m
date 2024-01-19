Return-Path: <linux-kernel+bounces-31475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96EC832ED3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280B5B2467E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38E58AB4;
	Fri, 19 Jan 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cul6DsFR"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2066.outbound.protection.outlook.com [40.107.95.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE3D58AA2;
	Fri, 19 Jan 2024 18:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688589; cv=fail; b=CkIL3QF73qrCO5arYOHtp9TSRztnLf5TSEGOv9EctJKewhGyD+TFQBYlAbRAMzZzujjLq8LiT4tjGaypwP8OuJKqHnDtkfwbzya8e3bRwJ6vF7aDi0oelsKu+ELPZiPp55bOc17f+IZe47D00Ufd11YRdZlYAsMIYuGxXx8hK8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688589; c=relaxed/simple;
	bh=pkomXC+Bgt/N5+lpZXQRjeb7o1T0Sqkl/3cw90ZnOfc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RE1+CAD4gD7xMFybYdPPXBSX94DGf0+LbmNjbRyqLWAt8wa/Z6Y/RiEofIY6ZFJ3ROLPe9UJfI7WGa+DqIBMt9UnruB7vlz7qasg24z7wW1XyO9nNgnbNYenmMvGjdJHK93f4JcK5t4uYsNOc+fE5cz865YATCHrpWRQQsRbk24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cul6DsFR; arc=fail smtp.client-ip=40.107.95.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG/R0MAI5t7DLjmLw+4FHVLf73fXM+/JPjgVxibrBtLNgY8CmFTlSxdoQ8K6LRq+buh1kosyXhXEM37WWPxeLK7hpXlJ/JGi4YYvz6TYEeqVNLmjE/Yk2i2wdx5XLxweFAm8MLCclo66CJ/JwJI0drTAXajimwRQvfK19vNbhDzes7wJYSuZFgFSMKq+BoEEDWjWECASgQ01aNSSDnjH3RDR7A584laPB1/Rr4KluGZyxKEINJ93RRT0E2TwWaSQgvjfUiYjOEdfOk9v/CSZba3IXK/nxc/o9IlBMwkpkee9Hm4aKdArbVHTRPvaSd+o5VUSiUi2lj5/oFRgoe0NcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7J7UIiI1RZtksfelzsfXZKK9lrMyDXrZUvxAZXU4ePI=;
 b=Qoa9j5BuaNflxTsGLP04S0rP8oBdlNnmXYxQOH0ETvLHwzjRGc6bE0mAztnZJsHsN+PY22EBbUxE61Va1N2GVjnP5UR9ryyd9oQZ35SElYKiPUOCFe4UKe4XS0ugIT0npI9lPTKur1X3y8aApMbrbj8PzMhvM1Qd/S/OA7PDx5ak2DyuNH+/UowsFTMceh7GLvDg5B8xa++KboR+kvz22YlUdyshhWkxWlb+j1Mqhv3Qtc/TO10dQdAz+jczbc5AMs9Pa/3tu25ney9GcJBHxjWeC7l+fscyW2mc6KfT8r27fb6XIwI2Z1QPPp4Fl2NST18bT3EwG8cM/f1JzhTyEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7J7UIiI1RZtksfelzsfXZKK9lrMyDXrZUvxAZXU4ePI=;
 b=cul6DsFRtiVT+NUZyYck7Io4bNVVuEV3PoJ33AS2fVaBqiQjZF8uo09Y6KRYhYez+q1Mi2Itoujo+aQWL7m/0LhzBYcduKedVvBTzYIXpIIXwPBJtUZn9Y4mYN5y2oN6kz2qF5IXC+1bYej8LNhqBKlI5HsHs+WHqQbG9ZzA3lM=
Received: from BYAPR07CA0088.namprd07.prod.outlook.com (2603:10b6:a03:12b::29)
 by BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:23:05 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::eb) by BYAPR07CA0088.outlook.office365.com
 (2603:10b6:a03:12b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:04 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:03 -0600
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
	<eranian@google.com>
Subject: [PATCH v2 05/17] x86/resctrl: Introduce resctrl_file_fflags_init
Date: Fri, 19 Jan 2024 12:22:07 -0600
Message-ID: <a51709a36b553578545e6f68a254fd401667bc97.1705688539.git.babu.moger@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com> <cover.1705688538.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|BN9PR12MB5052:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8b4bf7-558d-4a93-dae8-08dc191badc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GTGS41qjBf8/hvJahXTkmVtja794dyOzaArw8+6GwvaCQi8w28Btn2cSkEUXadVZJdvK5IzSACSdxkk+NkAM9F9nEW9Rrz6NV75xjMEC12r80tNSR5oq7UjkpcYb8MeA2jiW4E1Jl7fSJ9ZMRE4m8NDH4vbG4NW1Nos+cJeDy0ZutMIbFkcOECRoCBN0Z+KDEDItwPAYeRLIFvGy+rpUn4RbKD5QPabyqjjzRbwG6EC1QNzJF2OhjCRduhtE6YkC7S2UfK3rCuOfXGliTgyW+L9vMkM0ToeOMFJzh9aSmHIq5P+b63CEu09xWJ1zTtMNYL/eo7mS2jhPHO+l6V4FNM+l1/NcNLWY1oxKHPXgEgctV9hzNzXNGWtxL7XI9lHkkP4mNWL5j4uHkIhkzzpN8z4VJaWIwF5yTIo7QhnUpPcvQu90qyxKMiQEwJi/0JxW4AcXn/O4VlcsuhPughRWlhEos1E/utJczGxK7WahTL1rvKp8hmKYTUuQjBfpLxrchQRh0dqDHvP8yIRuXh0qYlo01uI1MIMiRfFlzc8MgrnW377/I2bNZhddMBzsGVvXX4o0U1ypJUF4/684PdCsL3yjNvZyR68KH0AqAI/GXo+iFM8IXVahnHdkwrgS1+wHmK44eW0jX91+9zyb0SDCVdzkUzqhLNiEFw0YxszLOKKN0Pz8ch+gRQsU1INtcLAbxrkSDCyTjpjPOOK4GszCIGV4vbpRXVnxSlJn3ls/LU+iedskbe5Vzi4AR35/KxeD2TbQCwdHNUcte4s4jBjq1w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(426003)(26005)(7416002)(7406005)(5660300002)(70206006)(70586007)(54906003)(2906002)(16526019)(110136005)(7696005)(478600001)(4326008)(316002)(8676002)(8936002)(336012)(2616005)(44832011)(36860700001)(82740400003)(47076005)(83380400001)(81166007)(356005)(41300700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:04.9171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8b4bf7-558d-4a93-dae8-08dc191badc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5052

Consolidate multiple fflags initialization into one function.

Remove thread_throttle_mode_init, mbm_config_rftype_init and
consolidate them into resctrl_file_fflags_init.

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v2: New patch. New function to consolidate fflags initialization
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 +++-
 arch/x86/kernel/cpu/resctrl/internal.h |  4 ++--
 arch/x86/kernel/cpu/resctrl/monitor.c  |  6 ++++--
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++-------------
 4 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index f40ee271a5c7..a38609c82b9e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -221,7 +221,9 @@ static bool __get_mem_config_intel(struct rdt_resource *r)
 		r->membw.throttle_mode = THREAD_THROTTLE_PER_THREAD;
 	else
 		r->membw.throttle_mode = THREAD_THROTTLE_MAX;
-	thread_throttle_mode_init();
+
+	resctrl_file_fflags_init("thread_throttle_mode",
+				 RFTYPE_CTRL_INFO | RFTYPE_RES_MB);
 
 	r->alloc_capable = true;
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 01eb0522b42b..52ba2fc5c6c4 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -565,8 +565,8 @@ void cqm_handle_limbo(struct work_struct *work);
 bool has_busy_rmid(struct rdt_resource *r, struct rdt_domain *d);
 void __check_limbo(struct rdt_domain *d, bool force_free);
 void rdt_domain_reconfigure_cdp(struct rdt_resource *r);
-void __init thread_throttle_mode_init(void);
-void __init mbm_config_rftype_init(const char *config);
+void __init resctrl_file_fflags_init(const char *config,
+				     unsigned long fflags);
 void rdt_staged_configs_clear(void);
 
 #endif /* _ASM_X86_RESCTRL_INTERNAL_H */
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index f136ac046851..a6c336b6de61 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -815,11 +815,13 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
 	if (rdt_cpu_has(X86_FEATURE_BMEC)) {
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
 	}
 
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 9b82ba977d98..3e233251e7ed 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1980,24 +1980,14 @@ static struct rftype *rdtgroup_get_rftype_by_name(const char *name)
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


