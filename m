Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785ED80F522
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377077AbjLLSCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377068AbjLLSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:02:20 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF363AB;
        Tue, 12 Dec 2023 10:02:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaLdsVWNRLdjgXB54XMJz1ZcmvFFa3tJL6ZsEL/tpgibp5eMnV0a81Z1KkF3PDn3V7JiJr4/9jk3bt1JEG8jsXNjwY6kLf1zDUf4DSV2hQ+1YkxjBqa4YWRCMV6dgtfL/DZR0tz0EaiRF5sb9dPd/pU7KbM9b7TxCwymce2xP3WIPbdLpWy163BgcSjfNVvdkPLCcX4FyQgLms8VJHiocyLg2iOh94j5n28iJEJDzuT4tHYp2LgiETirpqW3EyOTSmUgP3WGDdJ5QcJ4f1o1un2PY9PvK7zReH994eVYtwB8NjTXvisjTQ0cDVrizF5tNJD0FAn1zOtSrSrF9QEvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQJkixhoEZv8s2AuoE8peC4+I58i38wBbi/cK6R+DoY=;
 b=B0xuIqQJ1dx4oP8volJ3F9hKR5DSyyBV0WHLnKmbVYaQeZrS7zaolop3BuRPycBfjHg3fx2MsSdgI8lQ7XywX8CqP4Nz2thB7l45wYF8ww9TbbKhHa8Wgmlw2HzkZScec3MdcJsLbQkW67GYtAm5VyzlHmEvCsKB6csmk958f/gdRPRfzdh4rvVARGP6hbJndjxvp3DHH2yaSnhpDuKpWegvDrJqigdi30BGfXq6XgMx7YbsKJ0RYAWBd2Aatnu5Q1CvdxObzxmcGRg7UoVqRoOuiJC65XllrWLcIR6WvCd6xhRRPR5RkEBXPIZBv9KiDqVU5PtwyGzzw/JV9fmGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQJkixhoEZv8s2AuoE8peC4+I58i38wBbi/cK6R+DoY=;
 b=4u+bTuMkFYsUePHzlEpDsNmRJzkclYzUDipzsssfs6BNop9t8bjmWh7QzqmBKE+Ag8kyDcbb515j/Ng8s8FqZ7dS9DrTkbXkfNJZidSDWvIuJ9jcWHjnRipPWigX/ugrE8JAap000H3HAguexFAiGrP71MhNnqYH1gnmThV78OQ=
Received: from CYZPR05CA0036.namprd05.prod.outlook.com (2603:10b6:930:a3::24)
 by CH2PR12MB4891.namprd12.prod.outlook.com (2603:10b6:610:36::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 18:02:21 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::3c) by CYZPR05CA0036.outlook.office365.com
 (2603:10b6:930:a3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 18:02:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 18:02:20 +0000
Received: from [127.0.1.1] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 12:02:18 -0600
Subject: [PATCH v2 1/2] x86/resctrl: Remove hard-coded memory bandwidth limit
From:   Babu Moger <babu.moger@amd.com>
To:     <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <reinette.chatre@intel.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <babu.moger@amd.com>,
        <jmattson@google.com>, <ilpo.jarvinen@linux.intel.com>,
        <jithu.joseph@intel.com>, <kan.liang@linux.intel.com>,
        <nikunj@amd.com>, <daniel.sneddon@linux.intel.com>,
        <pbonzini@redhat.com>, <rick.p.edgecombe@intel.com>,
        <rppt@kernel.org>, <maciej.wieczor-retman@intel.com>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <eranian@google.com>, <peternewman@google.com>, <dhagiani@amd.com>,
        <babu.moger@amd.com>
Date:   Tue, 12 Dec 2023 12:02:18 -0600
Message-ID: <170240413801.760665.7930294172146734221.stgit@bmoger-ubuntu>
In-Reply-To: <20231201005720.235639-1-babu.moger@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
User-Agent: StGit/1.1.dev103+g5369f4c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|CH2PR12MB4891:EE_
X-MS-Office365-Filtering-Correlation-Id: 980fff2d-40e2-412d-5bb5-08dbfb3c7c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nlnqwDLMTf1ukKC8b1v3UVbQg6zS6v3P+aJkmmhyC+SD/b+iU9E1K0aWMVICJAkNjWfcPK+uKshUmUknMGnc8/jq2P6anuad/bXnMU0RP3AH+BhllOYA+3KeJOPVcQndJNigfsezGYHnOsTb4vmilUcWkhvKeA6Hxu1Jwq9Znqw6MILHcd+Zg3zGoqnsO0t3dsjLKcoj0up6PunUyVD8mCqYxs21aCZmYhZGuSUTSg/BooejJncT0B3N8u492bXz+KsoalG9Ptttl2/w+X3rR9oSVgQkVDw0njV0ak7D6DqeL6Epd4Hkw72G8DyrcGRCaPsr087GCp9eJ3dlD9WVOmPoeSNvR3eivNOMV2XrdaR7oz37m22iUcblZqAo8GKdz82DKzN/MNPmvqDZryPkMk6hZtnrHgzax1Hi3eVf3wzdSM1t1hxhl5kCq7FYUPl3mlH/SDrRy+ypJBa8DpmX562olLqaqDtDNoFwHIkQSAbBS2fa5Ntjly0T5/cbkDqgBxkCKS2W0pb3X929oJi6jiCdZnLEgyIDo6crTfDyuSMxQ5hv1/KQvwr9g03rK/ekR0LDxelTVIqj49Dd4Z4PTLanWAwdrCF8fa3N8BK3uqs7OMm+uconWzoSgoLZnVsD9zIufD8RySVONsSBW2/oGLF10Az5IYlQc302EjEQHYUZbHqOKIZhRml1wxbyfRsCCR34L4TdbJ0dUHJ7mJXDU+Cx31rgAehWp0YtWmj6K3oIUvxLiKeN7jnbdHMTVSEAaahV3BFf7RPasr8PZkULPHzsCZj5CFcA39JF9oMMjqod18qem8Gc9j9lFiK07nxaThpVVTYu161q7nY/V2D7eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(7916004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(82310400011)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(16576012)(110136005)(316002)(70206006)(70586007)(54906003)(40460700003)(9686003)(41300700001)(16526019)(81166007)(26005)(336012)(426003)(33716001)(82740400003)(86362001)(356005)(103116003)(83380400001)(36860700001)(47076005)(478600001)(966005)(40480700001)(2906002)(44832011)(7416002)(5660300002)(4326008)(8936002)(8676002)(71626019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 18:02:20.8841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 980fff2d-40e2-412d-5bb5-08dbfb3c7c99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4891
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QOS Memory Bandwidth Enforcement Limit is reported by=0A=
CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02.=0A=
Bits Description=0A=
31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.=0A=
=0A=
Newer processors can support higher bandwidth limit than the current=0A=
hard-coded value. Remove the hard-coded value and detect using CPUID=0A=
command. Also update the register variables eax and edx to match the=0A=
AMD CPUID definition.=0A=
=0A=
The CPUID details are documentation in the PPR listed below [1].=0A=
[1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model=
=0A=
11h B1 - 55901 Rev 0.25.=0A=
=0A=
Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")=0A=
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537=0A=
Signed-off-by: Babu Moger <babu.moger@amd.com>=0A=
=0A=
---=0A=
v2: Earlier Sent as a part of ABMC feature.=0A=
    https://lore.kernel.org/lkml/20231201005720.235639-1-babu.moger@amd.com=
/=0A=
    Sending it separate now. Addressed comments from Reinette about registe=
rs=0A=
    being used from Intel definition. Also updated commit message.=0A=
---=0A=
 arch/x86/kernel/cpu/resctrl/core.c     |   10 ++++------=0A=
 arch/x86/kernel/cpu/resctrl/internal.h |    1 -=0A=
 2 files changed, 4 insertions(+), 7 deletions(-)=0A=
=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resct=
rl/core.c=0A=
index 19e0681f0435..d04371e851b4 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/core.c=0A=
+++ b/arch/x86/kernel/cpu/resctrl/core.c=0A=
@@ -231,9 +231,7 @@ static bool __get_mem_config_intel(struct rdt_resource =
*r)=0A=
 static bool __rdt_get_mem_config_amd(struct rdt_resource *r)=0A=
 {=0A=
 	struct rdt_hw_resource *hw_res =3D resctrl_to_arch_res(r);=0A=
-	union cpuid_0x10_3_eax eax;=0A=
-	union cpuid_0x10_x_edx edx;=0A=
-	u32 ebx, ecx, subleaf;=0A=
+	u32 eax, ebx, ecx, edx, subleaf;=0A=
 =0A=
 	/*=0A=
 	 * Query CPUID_Fn80000020_EDX_x01 for MBA and=0A=
@@ -241,9 +239,9 @@ static bool __rdt_get_mem_config_amd(struct rdt_resourc=
e *r)=0A=
 	 */=0A=
 	subleaf =3D (r->rid =3D=3D RDT_RESOURCE_SMBA) ? 2 :  1;=0A=
 =0A=
-	cpuid_count(0x80000020, subleaf, &eax.full, &ebx, &ecx, &edx.full);=0A=
-	hw_res->num_closid =3D edx.split.cos_max + 1;=0A=
-	r->default_ctrl =3D MAX_MBA_BW_AMD;=0A=
+	cpuid_count(0x80000020, subleaf, &eax, &ebx, &ecx, &edx);=0A=
+	hw_res->num_closid =3D edx + 1;=0A=
+	r->default_ctrl =3D 1 << eax;=0A=
 =0A=
 	/* AMD does not use delay */=0A=
 	r->membw.delay_linear =3D false;=0A=
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/r=
esctrl/internal.h=0A=
index a4f1aa15f0a2..d2979748fae4 100644=0A=
--- a/arch/x86/kernel/cpu/resctrl/internal.h=0A=
+++ b/arch/x86/kernel/cpu/resctrl/internal.h=0A=
@@ -18,7 +18,6 @@=0A=
 #define MBM_OVERFLOW_INTERVAL		1000=0A=
 #define MAX_MBA_BW			100u=0A=
 #define MBA_IS_LINEAR			0x4=0A=
-#define MAX_MBA_BW_AMD			0x800=0A=
 #define MBM_CNTR_WIDTH_OFFSET_AMD	20=0A=
 =0A=
 #define RMID_VAL_ERROR			BIT_ULL(63)=0A=
=0A=

