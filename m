Return-Path: <linux-kernel+bounces-104026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF8D87C806
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFA731C22178
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DFBEDDB1;
	Fri, 15 Mar 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bh5ThzXG"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2083.outbound.protection.outlook.com [40.107.212.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34895134B0;
	Fri, 15 Mar 2024 03:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473976; cv=fail; b=NI4UHdwB1qOyKcX1ZX7aWvDOQinAkjrZ0DlQAU9E/Sba3Cq9/hJAvAMZTL2zWzBVxfYyoIMVNUVKJtLkdQgY4MZL7/YcQq4kSU9rk0Pf/ezWD0wLkk3XyGg6MgorMMHnZgQNOlFvKgLQysE2GmT20GbHKt2J5ThfgPIUPaFRRTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473976; c=relaxed/simple;
	bh=+uFcfpJDE68rgL47pzCgAFUoFsWg0SjQdeV1gtJ2GgI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRmGsO0XXJqgncmcmpqnhq7Q/vxRJar9H7ssXmWWAMygQt4/PCL1uuFAxzFQ9BO47jdhNCOMvSpNmKEVCwHZPzYT3TUrdYvDyHeTz1ZhLuDoMvuTrlD2KBWOxXdaeeEWHKcm6jPdKPwrJUn3Hl7YfD5NaQmJiAQ0w/MH3nYa1Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bh5ThzXG; arc=fail smtp.client-ip=40.107.212.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfLsXskDRYsda/FbnwgaVbId2HyoS357P3EiFNIjm1FPKbwVWvkijf/ZpZ6AEPMf27RiJOCS+gJklBJj/okzZMNYzOpTwvMkCFNfjlGLc5tImyjzJDes9ClGH2ezXRMKdqw4cCbtQIlwRU8Mqs1+nLKJaKrYle1ZZleRe4RfUSBMqcyubUoQaWQQ7M/3Co7VYl5HLssuCaMjlR0N21yn5EuiwQAWnubjYQFwlghXbwpZlVxC/LklklzfWzgMn7NkVCil1UCnOJ01iY6jqv0EXXa2TaR6v+We1El2JwQ7E7akneNRoKW5h1fnf9L+Ul2ZsoAL+Hr5iRMlPDfX3TW1gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ujo8mSxiA2CXgf67YDYZPo7Yx/T7kfjvWkjYF2sXU8c=;
 b=arkudcpKdMD8N19qHZTvC6lqzZkzaA1UdfCHemJ0COnKoVPfUcTe2l6aB7AE7liRNjRDYnAZmEkAmx9xpKbWyxHm4Z1jrYXgfVORGs6mtboVBwgLzYyCGUAsw1wvbmQnDFsnlVRezNt1eWoPVtsehTT0GCZn4RIvCOyl0eAiGS/ZLf6aFIW0j9hs3Zkxf613l8t0JZPX9/YlVoGjBx3Zaj5/jvSgL1qM4Adkr7/ic1eEANIs6PuDeMpcZFl+YaDhN63utFjELntV0mE9KiisVgjmsbWuuEs/ZTyxQ5Z/wCCP1VZ51QFi+KveLBdjfYeTRtMgZcEfs4atjpVrxNT++A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ujo8mSxiA2CXgf67YDYZPo7Yx/T7kfjvWkjYF2sXU8c=;
 b=bh5ThzXGpahJKEtUap2s/52QhykLDXJPVd81mK2rPcCPlbU5P2wEOK4YAqzbMquOe9I97gt1VeEPLXnsSxxcArwSO92AVygnrLZneKeqDu86qs7lVMtGOms94hKftZowEoR+0V68xDga9hWgSaiySukfs8JZcfsTseMH6y7T88s=
Received: from CH0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:610:e4::18)
 by MW6PR12MB8897.namprd12.prod.outlook.com (2603:10b6:303:24a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Fri, 15 Mar
 2024 03:39:31 +0000
Received: from CH2PEPF0000013C.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::5) by CH0PR03CA0193.outlook.office365.com
 (2603:10b6:610:e4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013C.mail.protection.outlook.com (10.167.244.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:30 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:39:27 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/8] cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
Date: Fri, 15 Mar 2024 11:38:05 +0800
Message-ID: <cb7e254f8def659a35481dc48d90d2b4391e21f5.1710473712.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013C:EE_|MW6PR12MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: df912904-23d3-4957-7b5c-08dc44a18619
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W5VcEBSUKiXQjzbl1v/SoYascTYY2MgnOx1vQOig4KJfxZpXHs+h3it224/sglcjJvj2V/D81HdpRpOjXot2EiHd00nD8XyM4JCGCqVPeGntmcpppnwzEVfN20SUI/4OLQxzCaTkwyPx7MiB/JeewzP5SPBF4gR5o4M0gQP0a2wf5tbRlL+dz/ppHaI6zvDRDdUxVL26a5YJAx3LrD09ixqTOy2KozB6Ourg3vvkOlNWver5N1/cf5m5uqu/Rb7YiSU8m1jtLSFmgDsBP4DjU6v/PP/u3T/TJvO6bm4E2L2ynEJWY3MtPt94dkA6I4OZ1QzkTIUQR3PekZKlMvv2oDGbs7pswloVKQUBsuJxBlJNf26mm2XMHsIMuw7JGuk2QWl/zzajenhORTBvrk+O4pia5h0vIXonz0bb9In8CUymnTURzgqASND/dk8k6OUJ5FRy07TnLFzjffgo6AEB7dZYSfxhAGrhuD0hcsfrJ6jv8KgWOsOYLSxVAwPFzHYWuPosA8YFKRT9yH1GXB0IuKSlmV6xL/VkXh0HenvDohcfYelLUmQyhVAsouhSi0jJ8uTZFRyQfWr4vANFOUvCnlalV6//V2+oZmzfO6nDawifS41RyzX51VWJoWGDvqKDnFRkHuuGFic+h66kcisFkR8Rn8KAKXF4EhumDUYGYyOcg79XgnLbpJS/u/gVsBrfZz/PofoG7VDfTvTRhq3xcB1EJ6P1UC+8beYW27zPlHiPGeOI/iKs1qyepa1p9b17
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:30.9383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df912904-23d3-4957-7b5c-08dc44a18619
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8897

From: Perry Yuan <Perry.Yuan@amd.com>

When CPU core Precision Boost state changed, the max frequency will also
need to be updated according to the current boost state, if boost is
disabled now, the max perf will be limited to nominal perf values.
otherwise the max frequency will be showed wrongly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 025f35bd3b01..a4bcac673fdb 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -676,6 +676,10 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
+	/* when boost is off, the highest perf will be limited to nominal_perf */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = nominal_perf;
+
 	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
 			      nominal_perf);
 
-- 
2.34.1


