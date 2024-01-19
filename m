Return-Path: <linux-kernel+bounces-31473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A95EC832ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDF041C23825
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C8457897;
	Fri, 19 Jan 2024 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vi1otRsn"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C0157887;
	Fri, 19 Jan 2024 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705688575; cv=fail; b=iYR/Ub18wPbCuXxpr1k4qbJd8udy4dC044+u1RwiqdZjBz+jOpgUtGtgMKB2edCn0V/9I95aTU0HYtPBf+NaFbR//GAinqOLHk7nBVCSOm3nT9sUKTmUzo+OWxdJisv+jIDp4ftEvkKah6oAzjStoI10bk+7U5TqD7msG2Jmozo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705688575; c=relaxed/simple;
	bh=71WYkZlspcX1au/bMnOE8w2XaiDCSXPejV0s4g6x56o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMW9CxfI9sHn6Dkmft5TVxaIAnn8X6ieBsHKgG7HBAeOekRXjBXKzdu6L+E3tpEWMiTvPhq1SepoxqWN3o5oJJql7aaGyImCoZaG5PflckMnoxrGjSEpI5mEpo9EYiOSNX8dGu5u9ky+184K3XEeS0TYpUrMPIT3zvQFcx+stGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vi1otRsn; arc=fail smtp.client-ip=40.107.243.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhsiE1uUq7Dgfao8dAZfuC6HAtrrgq3Pgbs32Mfsdm/EcvdpRrlsqAPwWFmNaCoyYfl6vkTIzYcyx8EviWEKJ0o3r14UjmlUEyLpRJmvP6oXUgxjrSR8TG3pgvzt04DBZGS5vYwusDTC6ez47iA4m8jyqi704JbQiuwuGQddr+OeuGbF6GDRWicfc10Naw8Fr4XOHSiPPyAhWztlZ1oWpV5vPEuxCn/dihkRYZ8bLT3TtCa6qw7m85mZUeodT+aTCBBzG05owivTEQHqJt7IU1MhUP4kVqIM2t43CbBeil9Xsjz/4Iqy92UdTmVjRR4cZQHB0SMwh+i2YnIYkAQfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M3lmsgetiTOaxvPMJO39TifrO6foi4Y4iOoYARN0ivY=;
 b=A/ieRYzIAonr4KShly5hkBSsflpvwFyMqFFf7BaTdlEgoMUe9F87h6gxmD4QkIlc6/mxEpRtskiyvpcSI/E+h+j5v536ww4e08j/VXRlQapXOGb04DVZzx9yrnLlZlWJfXAzBgEy8Kb2xfJPrCcBwCSQJjCqoJIJwzvW53ta1joNBp0H7aNBAQ9KgcN3684u/dIi4Xu0ufw/5TPAXuDLTf3rxpYgPmVWbDABX3/1d/TbTmlvcAgvHfCa8XoRm4ZLrPg5Qe3L9gpsoUVOuzFdsXSFHsJVpvEBeNAWztiEgTSVVqSohHkr/JGyJJZxCXiliRfbmmFFpHyS4N0D0HarUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lwn.net smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M3lmsgetiTOaxvPMJO39TifrO6foi4Y4iOoYARN0ivY=;
 b=Vi1otRsnsSbf5W/S5dF39ysjSV9yucQnuBAW62BeleCegqRDtPr7AdNBVEN8qB6D5FILa4KZLBHtzT7ebEoRVI3RVPZgL01CuF/bxtsIwUa1TL+76nNSxq0cwLrAQxXl/rlTgGTrdtAU4jYLBLCjHOOJXaAsJgcXh8upG/0voLw=
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by PH7PR12MB7185.namprd12.prod.outlook.com (2603:10b6:510:201::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 18:22:49 +0000
Received: from SJ1PEPF00001CDC.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::db) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.9 via Frontend
 Transport; Fri, 19 Jan 2024 18:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDC.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Fri, 19 Jan 2024 18:22:49 +0000
Received: from bmoger-ubuntu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 19 Jan
 2024 12:22:47 -0600
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
Subject: [PATCH v2 03/17] x86/resctrl: Add ABMC feature in the command line options
Date: Fri, 19 Jan 2024 12:22:05 -0600
Message-ID: <0f3a974abd186346fb9d6087b58e9722a4466719.1705688539.git.babu.moger@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDC:EE_|PH7PR12MB7185:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a9c528c-2fc2-43aa-897d-08dc191ba4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ld0a2w7PZ8OO5f/BXV1BYoahoYFhVw6k5p2YoFk7zipFSgErRMv55V6d5byXUuGo0id2fgY1DsuG4+RGGqDcn+66nUgQ8hAa8Rr/qeYSyeC3SJP/Z1UKEbpt5ldE6MGFGHa921bkKHh2KqVLIDMe2x2bFrsIuO0GhzCjScgr/yx841e97pMPU9mCB0BIb10Ll96vpbXIdVMldgK9lhgzW4s6yXLD/aHjaoQ31CGCDjutSwgc57kXQRqP44zY9+PsfsWH1d6Cik9HVyV04u1MV3Q6Iz4qwsxdm1ODxWEpTxn/oxrUCEi8TAvBU8micDXhSAXLJCta9cyBoYknEzqO9q/yepYVOunsA/8D7uh+uUmwHl4EjprkcTc8EHeIe5tchLXjD4Tp61VuGbahYJsw+GFrqoKDh4PIjfiS7/XTrDTH4zqWTJ0JZGVw99bLIAzJxequsFNq5/CHMoRpT54UdNBAyp7xYuI+PGjlk2Nn90MMeILQa1hKGOvWjfGPoJ/EVETPlZrgQh56eE9+2reDPw6SegRH/9dq43K3JOIU/e3IWXUzopDcuieccyXKLUlAVTD0aKkOERfyZYiN3ZzUiroMF8HekfSGibkgOzvuI1sCPhp1thHHghV5z/1W55lrsVRyG4qFIVD+/AQElLNS+eX4iaDvY/QplZaOiwpjMRiAesHcVzFSRBpxI3iqb/HiMC+/+CRzEbJqZI8ab2lq5A1jzMrey8ayhRO7fJc02ZZD+pj+s0q3SiOkxV/sf5j232TeZg/knES3gGDB5rukTg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(41300700001)(478600001)(36860700001)(40460700003)(40480700001)(82740400003)(81166007)(356005)(47076005)(16526019)(26005)(6666004)(426003)(7696005)(54906003)(7416002)(7406005)(44832011)(86362001)(316002)(2906002)(8936002)(8676002)(4326008)(36756003)(336012)(70206006)(70586007)(110136005)(5660300002)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 18:22:49.6231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9c528c-2fc2-43aa-897d-08dc191ba4ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7185

Add the command line options to enable or disable the new resctrl feature
ABMC (Assignable Bandwidth Monitoring Counters).

Signed-off-by: Babu Moger <babu.moger@amd.com>

---
v2: No changes
---
 Documentation/admin-guide/kernel-parameters.txt | 2 +-
 Documentation/arch/x86/resctrl.rst              | 1 +
 arch/x86/kernel/cpu/resctrl/core.c              | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index b28d80b5af33..68b2c4f799b7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5492,7 +5492,7 @@
 	rdt=		[HW,X86,RDT]
 			Turn on/off individual RDT features. List is:
 			cmt, mbmtotal, mbmlocal, l3cat, l3cdp, l2cat, l2cdp,
-			mba, smba, bmec.
+			mba, smba, bmec, abmc.
 			E.g. to turn on cmt and turn off mba use:
 				rdt=cmt,!mba
 
diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
index a6279df64a9d..d816ded93c22 100644
--- a/Documentation/arch/x86/resctrl.rst
+++ b/Documentation/arch/x86/resctrl.rst
@@ -26,6 +26,7 @@ MBM (Memory Bandwidth Monitoring)		"cqm_mbm_total", "cqm_mbm_local"
 MBA (Memory Bandwidth Allocation)		"mba"
 SMBA (Slow Memory Bandwidth Allocation)         ""
 BMEC (Bandwidth Monitoring Event Configuration) ""
+ABMC (Assignable Bandwidth Monitoring Counters) ""
 ===============================================	================================
 
 Historically, new features were made visible by default in /proc/cpuinfo. This
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 19e0681f0435..4efe2d6a9eb7 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -678,6 +678,7 @@ enum {
 	RDT_FLAG_MBA,
 	RDT_FLAG_SMBA,
 	RDT_FLAG_BMEC,
+	RDT_FLAG_ABMC,
 };
 
 #define RDT_OPT(idx, n, f)	\
@@ -703,6 +704,7 @@ static struct rdt_options rdt_options[]  __initdata = {
 	RDT_OPT(RDT_FLAG_MBA,	    "mba",	X86_FEATURE_MBA),
 	RDT_OPT(RDT_FLAG_SMBA,	    "smba",	X86_FEATURE_SMBA),
 	RDT_OPT(RDT_FLAG_BMEC,	    "bmec",	X86_FEATURE_BMEC),
+	RDT_OPT(RDT_FLAG_ABMC,	    "abmc",	X86_FEATURE_ABMC),
 };
 #define NUM_RDT_OPTIONS ARRAY_SIZE(rdt_options)
 
-- 
2.34.1


