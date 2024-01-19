Return-Path: <linux-kernel+bounces-31482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4BB832EE1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A02471C23D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20585B209;
	Fri, 19 Jan 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="frZ16WU4"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9A25B1EC;
	Fri, 19 Jan 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688647; cv=fail; b=VhoX7Lkr8CerEZlMUkdl/fwHMBQA22sYM4ugOI+RGajDgcXaRrbKuyY2e/zCAYl/1jvnoVYCqz1vUMU/FCe8PhTXCbVnn9fwx4YnHLzF2B82x+Ab4CnQ3bNys/npZMVI7nsenY84xTYXwWprAj2OslCl5Eedq53gpYYs4/1FBn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688647; c=relaxed/simple;
	bh=w1mLVHCAgAPwnHnn79Lv+iU+fjz4NvdugroD06Z7IrA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DQJXhvWt6BAF9xmxaUJgSbDEBc88/j4yojsf7hmpvSVtAeP6v7LvXc7XWvGp2wi/snD1Ae1rUV+l136oMy221QMU6wMgEYIAy+vAfrtoCwFSbkl5Oi/O/znYCtzEELQlgDOpwRCN5D7zmDkopaz+QQhIsgrielktH/598G6rjr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=frZ16WU4; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZyW3G81sMTTN2MOlIZZyPb/XGMSiDH5VBaDZJrKbTc+gQJ+3MxxJpOMa11RGQxeENd3H56IgzTuPKI+odpLWWHG96DxvuHYWJ+6pV6scKSkHug+nKbKdav0Pi1ppkEKBfQ2YqboICfJLSIuARWKUy50eEIuku1fHvG8W+1jyGB8JEltLCW+bsBecrWqQlY6J5jEYVkTwGTsoQdIN8hzabkZJECVafyAhDpj/FaZqxqoOV5DE/WYq1KlqE+Wur3R6zQShWWP3JtQwTJOPF8eiPldnzvV5K0ukrk+zOtW2Mn4iNtt0fhLIM2jCg+GDt4UUMZvepZnKIxnDIdRp4PAzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pSBLBylTZcAZAHANCASjGX4iJb4rhHJ8oUebdiY0po=;
 b=ix8lVriNOh/cZo+w8TCLeuf5FFxT73oCNk3Yt50ERDBCycyAVGEPchbrXmBy8B89m+uROcB2MEKl6l0acNsiFFE03Dseg0Y7cLV0prSKhSIaEGwtIRTX/fI8h7x0/dyroH0fFwKxWCBNkmfJR3eBxWSZJjEyJ84E8/7epxMtPVzxumgerx42hnYIl6VqOQ2mdBZdkbULyj7jfMi3NuiUTOZOGxQSIN67v8Ggxuc4OwoQRu3AB0++1Hf4WSMUBrUDW1a/++qsY/VtPsfPS0cB4WSR9i32wL9SYsj52Lp2832Rpqm+/0ogGyfMCAwbbCxTjQg1JHNKcWC4falEtclQ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pSBLBylTZcAZAHANCASjGX4iJb4rhHJ8oUebdiY0po=;
 b=frZ16WU41USyPDSDJ+A1ZR1+r4mYBjeCColMCxjgGxVktvY2VxE/Sdtsfx3bq6kETvIcGZPQCc2ZhYrNXwHZmkmcIf/4jjU9xKp6xYdVDVcU7wPzn/VsJMtQYq+e1i6VmKpUZzXcziDNus/ip2m54NGnVbN52WJ1VvpYIac52GY=
Received: from SJ0PR05CA0102.namprd05.prod.outlook.com (2603:10b6:a03:334::17)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Fri, 19 Jan
 2024 18:24:01 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::12) by SJ0PR05CA0102.outlook.office365.com
 (2603:10b6:a03:334::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:58 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:56 -0600
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
Subject: [PATCH v2 12/17] x86/resctrl: Initialize assignable counters bitmap
Date: Fri, 19 Jan 2024 12:22:14 -0600
Message-ID: <936daa3b504fbd4226f3acad5018d1e163853822.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 8925fae3-573a-4faf-ef56-08dc191bcddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BkOpf/oTLaPzrWVif0ML+7hd+WtHkounarQfPYz5kLUsIpu5DOYoLhHi+79c44lJ0zuAGdDimAWA+3lrPAJCd61DGtlnuEKoqjOQG5EEyClMRTM7a3NBggFr+Lag3RVmYgw4YEwDTh1Y7dBfoemA3/98l3i/XS911dqZCy+4iwU5hmhNBYDs9HcF7Lho5BX+Bzf0p1nEMdKqZcRtreD3OCVceIUNj1EVo88E76a/oxdjLZorkohvaY5uPeYopql1mW9Hhu9FT6GqDiuJJrCrikRyl84LortyC8Zztf3jc11ufusbMnyAgYztboytmnOB5pioLi/sJ9HR14u0kAKTwycyMh1iojImW4WzCsCPfaVpkBJ492n5bWBMHJdUq7Pkk1MqK7f5X3dQ7yApGo0hC2lONEQaEy2tpKEzw8lyHfCPr1IunIhJjcSkuNd0JMkpWR/lIASPQv5EhMEqhq+AL3PJ7ZF7DorwjQjjHGR3GNSxJcIYuZbmOvu/vVhMcauoo6vLOht3t7ipJMLHAcjMz0roDF6cCf8tGipkiHBBlE+KUGlOgpOrS/fyH2HcSTLGy3CnEAW1cPPq7yQkqwYx2WpwbGfJ/CPYQi6fxDY3ZTZ7bCp1UCXieq7/Ogf+Er8Q+gPWt94rZzK6+2sES0voIYJ2yIGK1JPpT00xNdNnxWDJgn6/aId86yzJ8uEnR/r+zEwBjtgXxowdTnbz8+HFOIt1TTUCo9GrK3MaxlgCmqR4A6RwMKGP4N5YSPx6wpIbuc6UCWldQ26YEKdOlPXUjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(7696005)(40480700001)(40460700003)(2906002)(7416002)(7406005)(6666004)(478600001)(36860700001)(5660300002)(356005)(44832011)(4326008)(82740400003)(81166007)(16526019)(47076005)(2616005)(26005)(70206006)(110136005)(54906003)(8936002)(83380400001)(8676002)(86362001)(41300700001)(36756003)(316002)(336012)(70586007)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:58.7137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8925fae3-573a-4faf-ef56-08dc191bcddc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

AMD Hardware provides a set of ABMC counters when the feature is supported.
These hardware counters are used for assigning the RMIDs to the group.

Introduce the bitmap assignable_counter_free_map to allocate and free
counters.

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2: Changed the bitmap name to assignable_counter_free_map from
    abmc_counter_free_map.
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 7cae6ac13954..19b0ebf4f435 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -164,6 +164,22 @@ static bool closid_allocated(unsigned int closid)
 	return (closid_free_map & (1 << closid)) == 0;
 }
 
+static u64 assignable_counter_free_map;
+static u32 assignable_counter_free_map_len;
+
+static void assignable_counters_init(void)
+{
+	struct rdt_hw_resource *hw_res = &rdt_resources_all[RDT_RESOURCE_L3];
+
+	if (hw_res->mbm_assignable_counters > 64) {
+		hw_res->mbm_assignable_counters = 64;
+		WARN(1, "Cannot support more than 64 Assignable counters\n");
+	}
+
+	assignable_counter_free_map = BIT_MASK(hw_res->mbm_assignable_counters) - 1;
+	assignable_counter_free_map_len = hw_res->mbm_assignable_counters;
+}
+
 /**
  * rdtgroup_mode_by_closid - Return mode of resource group with closid
  * @closid: closid if the resource group
@@ -2777,6 +2793,10 @@ static int rdt_get_tree(struct fs_context *fc)
 
 	closid_init();
 
+	r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
+	if (r->mbm_assign_capable)
+		assignable_counters_init();
+
 	if (rdt_mon_capable)
 		flags |= RFTYPE_MON;
 
@@ -2821,7 +2841,6 @@ static int rdt_get_tree(struct fs_context *fc)
 		static_branch_enable_cpuslocked(&rdt_enable_key);
 
 	if (is_mbm_enabled()) {
-		r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
 		list_for_each_entry(dom, &r->domains, list)
 			mbm_setup_overflow_handler(dom, MBM_OVERFLOW_INTERVAL);
 	}
-- 
2.34.1


