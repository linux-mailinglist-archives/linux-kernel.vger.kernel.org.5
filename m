Return-Path: <linux-kernel+bounces-31479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 46083832EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE6328784A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B664A5A105;
	Fri, 19 Jan 2024 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jH5ybtBx"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD555A0F7;
	Fri, 19 Jan 2024 18:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688619; cv=fail; b=gw7hayNgctxktnDHmaJhDWGgguqyM2yvCQc7Uzzp87QykaIECAxy4nQp24ySfoMVrf2V0Dy0ozC5n66kHaUAaJOf2GudrcgWZoUvf0cT1/F3LdfvdRjOAQxQxVWJ1DxnSdfY1jmi3nI9ndHlnQzgssEom56fVAhrViSw0H889mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688619; c=relaxed/simple;
	bh=DKh3yLjrrt5k2W5AcvmXGyyRQf/zVqXqG0x4vk3tDOU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=plkk71uKqiwyJ6A9H2AgEqBn17Z74V/+/b9efO8aTm40os4AmF/HSvdDPxN6+DJEEIRFB2WOK7uoHdvKVHo5wVEGv+Kf5QXJCKTCodYxxJfvea4f94UGxeGFrXGf0GYfexHJmzZ7Hq/Ov4QSSG2Rg6gbLVQ5oPeiiudzJ+IVopY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jH5ybtBx; arc=fail smtp.client-ip=40.107.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bhebuxzMa4QHX70WervU8lWyQgIU6jpMpmu3aXj5n6Urr8IKNYN7hsUlzLEu+xv6tEBMsqtK6TifNh6Sun8zO77rdSbLHdZ+qS3WFzVM1ZF2ELHHX5GjQr3mP9g3HE7+ZwhhE4LE6qj1H7z5b79KYuMq6vG7n5stskVdK6iF6EXMkeV1i7xO5tNLKxIdUkb/wZp4mhrz9dA6qF7t6oN/e7PW+hFW5daAeNgwcrP/hlU9DK0UlFRHg22Z5QX23si3MlV8UDzXBlsy5PpC2CPnfp+kDkjPUTZPB/CnQu8Ol0TcKOw7ecYUV78nnoUzaDSDzq4BlRPSbO1PlEKixXbwug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=azlJxW+VEjEpo3lAdBo5uCmm+DYWDy9DzhYX/OuQGQQ=;
 b=TV5gT0rumGPkjM0spdRpu/RziVybqYpT1C0Icxg6i3B5GphQhT+E0Phfxj/AMB+uA1cFNUqKe9oEW0vvUj8zDeIayr8NOxgvAkohGfSQ7utuoJ7kKPc9lzD3c5xfUDyMXin7OaRf7Tb2SqoJVX1IYt2guiQ4yvHR3AzpN+zpIUTu4D8xw+xdWQ3MKXBGlOObQdXcnURsTHTTsNtDt5RVvXOaT4BJwOYEMzgRsDgN95kblpBwQsykA/0YRFPpZmL7kpIn4l3IuFVevTeDJveFWQMktQDTXuyK1I6BJgNMJ1SLMIMGB/eDhzySW28jvq7KaFUCHCG+h++qXHH2gCbdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=azlJxW+VEjEpo3lAdBo5uCmm+DYWDy9DzhYX/OuQGQQ=;
 b=jH5ybtBxGGGdCSUUeuE0vE1Ulcvow6YLyjbbvc0neAkHLt/p8wjHi0skV1Jypnv1BfCkRn8qnMQulkWxUZvx5YRfB+Z+TFxsEjwNMF9E2cNEcQ/fhOntY/rE+9cdJVayCkmmAikYGE1JlMGDTXrCjrYfBAsvRsEjLsnGSDSjCiQ=
Received: from BYAPR07CA0083.namprd07.prod.outlook.com (2603:10b6:a03:12b::24)
 by PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.26; Fri, 19 Jan
 2024 18:23:36 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::91) by BYAPR07CA0083.outlook.office365.com
 (2603:10b6:a03:12b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Fri, 19 Jan 2024 18:23:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:23:35 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:23:33 -0600
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
Subject: [PATCH v2 09/17] x86/resctrl: Introdruce rdtgroup_assign_enable_write
Date: Fri, 19 Jan 2024 12:22:11 -0600
Message-ID: <7ca401166b5e78f128743716bb2b603bc6fb11e0.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: fccb366e-5e15-49f9-d6da-08dc191bc029
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pXshrudK1aQmD1NT7BdFXtKggnW17zN+/cF4PhuORyuGpNqxOzagz2n+BBVU/ej78sVjGBJfH28Yl6lnZbeH6w/3GPfpiFFISqLBwZX6j0vuBjAoSPFCUnyh/DzB0j6N0tNPDytOCCr+Cm4tcbePpxAqy63LldmZ3OycQA89P2QgOQCel+ucRVHltuRQvQZh8v+MdWwHrTk34Je61h0leZdC1grJiHUGO5uHzucG0j2OuLDIuztfq1qDCJbJLfAgWKu64DqcA/HabyUoG9QmfzNe4rCI0jpIDaojogu6tIBX5Y5EpYmkjMCQcE95MQmV24HkOhY9gJynf5OCSvkaEf5fsG3tXiH+2vGD+IqiISFHLhTJQTgKtM/Y3Yjl288uDp0uG8vUL50527/BbhRMQBc+opMM6JQ4PsdD1T8ZQpPdqq83egPuVVpMpqq10dNWccMEEVlicTRWj9tcl4Hna+jFuF/5YXe+tMsLv+wmm7/c9TTnDGSSNeSJ3ZWS6eTNUz3gw8pXQpvB4UOEVRDBXT/USQXN6UHOO3Su2D1x/Rvu0zhvBxMREYFDudVsIKfU+L/+NG/rkb6QW11kBAv22Nk2djahdLSr+BYNUoNzECWxpVgM3RaiuMD25e/6jFCrfZen5oRN0kSqBI0fXB8FGIfIcQSo9B06R1GT2cXhcoZCio4HykvpUdJRquv62NUS7J5BZuR3INfZjFMoy5+Ew4I52tRJAR5HcjGWrhCwqX0YNP9oFaJEQUHH/yq/i4mSRMB014+PgfpafaPNnWkVOw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(47076005)(2906002)(86362001)(5660300002)(7406005)(7416002)(44832011)(4326008)(8676002)(8936002)(316002)(54906003)(110136005)(70206006)(70586007)(41300700001)(36756003)(81166007)(356005)(83380400001)(40480700001)(36860700001)(16526019)(426003)(336012)(40460700003)(26005)(2616005)(478600001)(82740400003)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:23:35.7296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fccb366e-5e15-49f9-d6da-08dc191bc029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870

Introduce rdtgroup_assign_enable_write to enable ABMC mode.

Users can enable the feature by the following command.
	$echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v2: This is new patch to enable/disable ABMC without mounting the filesystem.
---
 Documentation/arch/x86/resctrl.rst     |  6 +++++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 34 +++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index f94a4d314690..f09239cb93e8 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -273,6 +273,12 @@ with the following files:
 	assignment for monitoring. Feature provides an option to assign the RMID
 	to the hardware counter and monitor the bandwidth for a longer duration.
 	The assigned RMID will be active until the user unassigns it.
+	By default, the feature is disabled. Feature can be enabled by writing 1.
+	::
+
+	    # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
+	    0
+	    # echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
 
 "max_threshold_occupancy":
 		Read/write file provides the largest value (in
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 4f160dbf6376..9c8db9562c91 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -833,6 +833,37 @@ static int rdtgroup_mbm_assign_enable_show(struct kernfs_open_file *of,
 	return 0;
 }
 
+static ssize_t rdtgroup_mbm_assign_enable_write(struct kernfs_open_file *of,
+						char *buf, size_t nbytes,
+						loff_t off)
+{
+	struct rdt_resource *r = of->kn->parent->priv;
+	struct rdt_hw_resource *hw_res = resctrl_to_arch_res(r);
+	struct rdtgroup *rdtgrp;
+	unsigned int enable;
+	int ret;
+
+	if (!r->mbm_assign_capable)
+		return -EINVAL;
+
+	ret = kstrtouint(buf, 0, &enable);
+	if (ret)
+		return ret;
+
+	rdtgrp = rdtgroup_kn_lock_live(of->kn);
+	if (!rdtgrp) {
+		rdtgroup_kn_unlock(of->kn);
+		return -EINVAL;
+	}
+
+	if(hw_res->abmc_enabled != enable)
+		ret = resctrl_arch_set_abmc_enabled(r->rid, enable);
+
+	rdtgroup_kn_unlock(of->kn);
+
+	return ret ?: nbytes;
+}
+
 #ifdef CONFIG_PROC_CPU_RESCTRL
 
 /*
@@ -1891,9 +1922,10 @@ static struct rftype res_common_files[] = {
 	},
 	{
 		.name		= "mbm_assign_enable",
-		.mode		= 0444,
+		.mode		= 0644,
 		.kf_ops		= &rdtgroup_kf_single_ops,
 		.seq_show	= rdtgroup_mbm_assign_enable_show,
+		.write		= rdtgroup_mbm_assign_enable_write,
 	},
 	{
 		.name		= "cpus",
-- 
2.34.1


