Return-Path: <linux-kernel+bounces-51629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB066848D7B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500161F2247E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F20224D5;
	Sun,  4 Feb 2024 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iI24y+8V"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6053524A13;
	Sun,  4 Feb 2024 12:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048819; cv=fail; b=c7TdyxxzKMC/OSgP+TLk8qAdNMM22HMmPeXgGBRzD0GOCf6r/to1H9/COUzv5foIfJAa94A5lIZo/F7BzUE+EnVpOx0CUMnvps0g4xRX6x/n1p+34PKve9NQeUZKdVmp83uPmK8VwXSa4wFuXZgMtkOqxwuTEAJRAPYmNHFekQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048819; c=relaxed/simple;
	bh=SfOMU7sqP7IWAY5QPMluTtzgpipdi53spr0DF8MYbgw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GHCj5qNs5aOjlyeveLHTZC2kFGu178KxL53creWgY8oLL/Dq65y5jqGvzJD08y9VSTjC6V7GTADiu+IEsxTO70jK6Nch1xRun1j6azssFU7poXiknG73Yf8qX7kjm5wd/nS8SwtShttCX2KH+pSv6spMiqW/9dK4gWsfs6wNtac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iI24y+8V; arc=fail smtp.client-ip=40.107.237.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc8wz98gbTxDnzTwGrZTwK1JGzRHk/FsORNYPCP3zJkw52SZo2Qy4BkkH2wyzp2Dt9mZGtwNtY1cRaQZ1i/QKqOD1EBH7cJGLIM7y7s5LzKb8fFyPqyPr0i8Qmub+GDxadZny4ccQ5Mpr8KYP402D/uQSqgAOnFP2Ct5dh/kRW5rzeAeedgHk7l3sNKVc1l8/YtS+boL0Np+5NyIsPmQ5T5aR8fKidLL201bp5+j2pKcOR9O/osYZ6ena69mH2WIoaYP/L83soGkw12424jYEjOszrNAWljeNudCS2+PoKbl01ff1iostY8alyUWFR9GyS0I9msjhq+T4IqDfPkpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5zCI8pIG614ER69xydgIMnJNCLI28gBf+TOBAAw0E8I=;
 b=cbG0uVrdjbM3/chOKjqEs1tNkeuQGY8Y+7hwWemJqUwzCRpdISLafuHGzm6Dxm5wrlnBUb2OjW8b5017gPyNxCG1l4I1vnTC2WriK/k9om3RngsQK5QVJhDxxbt1aI/wy9fjuixryqcfgi2irO08ZzjdgbyNzm63Bc205pNVsj/zfPI8oDwWwwunXyuFVrwUUSolJ8ppqGTRW1+G3wuxFZRJNRcqrbKVZzleS9m1+V3Vj51rE+5j9ZpZggFpdq3OhSLkwgQY2Ls/xBJ4JKIc0i+hgpUJ95SGQsX3GhniPLYLowMzgZcViZjZ3aI60PRfgcJY9IjcWNIYwJMeF0/Uvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zCI8pIG614ER69xydgIMnJNCLI28gBf+TOBAAw0E8I=;
 b=iI24y+8VDyNvsvfDpCL4GeYOMWaw68Ef9pwcqvH2e1oiiRnQSELg5eC1F8byCYQgtBFrO6YQfAvXtWZNhqhDACb3y7tc342Fy8EItp5i6gyQ9IUJK+CSo3vDfLR/1IEcNs5eTQ1ctg7lH/X9n5JCbZD1NkDQ41J83a+eNzHBqvU=
Received: from BL1PR13CA0133.namprd13.prod.outlook.com (2603:10b6:208:2bb::18)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Sun, 4 Feb
 2024 12:13:31 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::b4) by BL1PR13CA0133.outlook.office365.com
 (2603:10b6:208:2bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Sun, 4 Feb 2024 12:13:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 12:13:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 4 Feb 2024 06:13:28 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 6/6] cpufreq: amd-pstate: remove legacy set_boost callback for passive mode
Date: Sun, 4 Feb 2024 20:12:57 +0800
Message-ID: <e0746643c781f638c9e9cb8a6d2ceebeeb906f95.1707047943.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707047943.git.perry.yuan@amd.com>
References: <cover.1707047943.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7b8f1f-c431-4935-d081-08dc257ab3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PGN+z9lFddyRb9dwOyeBboYezJn+V+tTVQDMxdVq3lKVc9/XBgf+KYHiSRbC1oId4KXZ8+4kb0RrUpF9S/xfRd/5O38wNvv4zjvoG0gvFjUesxfRzwk/iehGgAutyeCZQjcMuGUW1iM/MXOnDFFhJAFNf4bjgO5NsLzPl0T3oRtcFhzOnKfQ1n2bDppDTaNHrQrT5sJKEFgkNKi9XiZtZIBOvo/pU7+AHVQzv0QgJLzAEzdqawtpi/JIuRNCxTqq/k7/7sVvF0c/yU6UJ1ugKTsc294CYwg4YYVcZhAiibXBuT67iOWYu/GrTUsOBUjQKGQUkRk9OtTUhxA4yxMt3o6eNRMYhkAp6cizoV9QW6e6URZ2z9lfDPFwbHsk0fWRlLnlagfvwXyxLKdzrJZEWjyupGHDHYGzyTH3fmG4q6e5w2oBz5/AqlH0WKDMQM23fG6pxKOkTVDt/SDKutWhCw5/5dtNdie08sciF79j/mf3VaHSbMLxR15J6BDFXK5+mvHRFriOoMw1tSHoR75ioWV+YCdRw3MtfwifdrB37Erf5hVyLFoFxZsyyyZBLCTacihj3xuoBzxISk8c0ubaICj/YvxUq1AHGfIR4YeQMu/xSFTxr+HNgypFwgcBDOuvaDiGwBNe0FShm7hbuH1ahvT9TQ45D4aCz1taDhDZyy5DBRXBNwRnlx2hh1kE5evnb/xaA2gxkaPVsj20aUvS9Ua5avReRdN0APUee0OouUoC6f/Oh95vCLlvKKn0vSUs/W/ug4GlStwmKFoiWnyXHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(36840700001)(40470700004)(46966006)(478600001)(47076005)(16526019)(26005)(2616005)(336012)(426003)(83380400001)(356005)(41300700001)(82740400003)(36860700001)(8676002)(8936002)(54906003)(110136005)(70206006)(316002)(6636002)(5660300002)(2906002)(4326008)(70586007)(44832011)(6666004)(7696005)(81166007)(86362001)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 12:13:31.3129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7b8f1f-c431-4935-d081-08dc257ab3dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

With new freqency boost interface supported, legacy boost control
doesn't make sense any more which only support passive mode.
so it can remove the legacy set_boost interface from amd-pstate driver
in case of there is conflict with new boost control logic.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 include/linux/amd-pstate.h   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 02a76b8fb298..4e377efdd4ed 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1492,7 +1492,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
-	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 446394f84606..66d939a344b1 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -80,7 +80,6 @@ struct amd_cpudata {
 	struct amd_aperf_mperf prev;
 
 	u64	freq;
-	bool	boost_supported;
 
 	/* EPP feature related attributes*/
 	s16	epp_policy;
-- 
2.34.1


