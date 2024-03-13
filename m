Return-Path: <linux-kernel+bounces-101325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C77CE87A58B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669BC1F21802
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89633D0A9;
	Wed, 13 Mar 2024 10:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QEGyuIAy"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E3F3DBB2;
	Wed, 13 Mar 2024 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324327; cv=fail; b=dmuiwcSxSHpl+WSRWwD9NLtyzcjSQDprgehcm16UnpeDse8UY+u6/Iq+F3jBdDOQfqIxZ6lZRQoLG5ceMLEmj4+xCgjlsjgPdySu3CdieeMsPCkNthVHxT3AdE9OnrIT0i1Iu4EUZdXil4zGMUToXs2M4kFJd2ZZCR+U9W40fCw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324327; c=relaxed/simple;
	bh=G02pH48d8Db06kvsEBrKMIuPJnL8wLDz6Y2MuwmFRDA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q2gviyhDs/emSx5cBR2lZ8XTV/oNMgCV8yyhsPR7DyFVvq3F8kHwq9dAn46v3T6fYQTTyEvpR3ocFjl/pdleEacx2ha49QEt4tmVHJLzAb/ixWaHG+r/VAfzdqkD4PqoyCC3sp1wFawVaK0rqwpoX1UMhgrWr8iYP7dIzZOpVls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QEGyuIAy; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3Qg1CUCGH1d8xnXjTXgHOEo0yOfBQjmxO6km2fYvrsVtZyU3KhpZDybLkldNqNF+20NPXwT8KSxUacAjc8ocReN4I6Q2ThE9293ItXBq0ksyhvVh0tDNaFIHg+V1QHiD5HvOiw3OdGXXFFdFwYU0w5vi6AIjAsH54ntXbq0BCtNS42TbiN+miKQyE0g38XJQQUryS6YJjKVlPxuZzRz1VUgG8KWKdTRgmA/tEirb0Zj36bBezI/eTl1D7FHTI28EB8Eh5SCGg8Zbew4gAIXclRsS5eL8wMhdNrgACe/hHlYSZkVlE1rlaahLXZS8dwmgAnAUo9kWFlFnT7OkUBSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1sLe1zptm6M7KMO+14mkYFferByd7hCOhOYHL7G7mY=;
 b=hXu2VXh5FkugJBiOSU/MI4Kohmx4FSMdvyLgL0ztlv+QEhx5F0KHYd2vLeOOfYPfPWQj+hLdAnvvpXkCtgU64DYcYlrFr9+wenR66an9VwLuYpNVbW4VVydfC0VYKD3uBfR+7gVTmB9V0tfMvCOa9X4fkJd88NqxIyUyo70L9WIZd+V34ZKiXCKGUNF5lGD1k1cGRQhuMxEkJedpSnKaYBDJTi34t5DyWI4erK+C2YkCkM19sC+tFEAX+Lza33ipqYgOCGEP/One28R4fhvE4Lj9g+gPM5JVaLI7Tc5Sd2hJ1XS/OOygo2rD3HUZ53nlT3Nao8GrAYjLCScGLat3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1sLe1zptm6M7KMO+14mkYFferByd7hCOhOYHL7G7mY=;
 b=QEGyuIAy9isScqbr1W2ns40qYHDj1BP1emxo+twvMIj57os4QwjDrqEMslHUp84nbR4XUcgDmaQ2UWLol1lBIgeWn1d7eNcTWJMLBqs+4gVsPnM2MizF+zzlc5W4YUP4GXbDuvKBNDUNYCRRbJq4Fpz1Y7AEWa2JC0K/IyyyPvI=
Received: from MW3PR06CA0008.namprd06.prod.outlook.com (2603:10b6:303:2a::13)
 by DS0PR12MB9348.namprd12.prod.outlook.com (2603:10b6:8:1a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 10:05:21 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:303:2a:cafe::8b) by MW3PR06CA0008.outlook.office365.com
 (2603:10b6:303:2a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Wed, 13 Mar 2024 10:05:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:05:21 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:05:17 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 7/7] cpufreq: amd-pstate-ut: support new cpb boost control interface
Date: Wed, 13 Mar 2024 18:04:44 +0800
Message-ID: <1932134a71717f9c4156d7755d40af6f63dc98b1.1710322310.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710322310.git.perry.yuan@amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB9348:EE_
X-MS-Office365-Filtering-Correlation-Id: b18f8761-2501-4bcd-36ca-08dc434517e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zoUjMm1ppxIoNvhM7DjqKICK3lSoKQOEmct0/W+k+25oOaPY4Ez4YZpf8zNt2qpn1HmeakL+E2EGvsKW9DVXevwmW77eUFG97MXWTVLql93pag5sz6D5j8Vru5L2qSlbEPbFZAanmggbimtCeoXQvL7O65QCesfsab3uJW80MUV+7m9nHOQTlTFKnW3LA6rbKMGrOCf3qb0zQMHwS5WBVBxl3sNnSTuiV1qJRkeGOQEwzO+28SHq+RB9dsSTrYPwZnJ3j91wQoSU0zuJ7jWoYCrQmQThm+CkUFbWgKfZ5k6ElYBbNhHOKYikckSw4GNVqhLaVJ8gdJiZfyUnotWaIYjR4LaKLwQpwgw3gNDmZqjIOWV7QZSWIvpOw42q6VWQvcjtYvgDB2jcuNQPkc+j5d1xcSSUag0Q6rs1KONqkT0TP3aFl9c6f5l/pFpu4TzzH3CnCS+zOFWaP0jXNaC07fy+7Y/OlxmeJIivBOMR/OTzT/F6Gfyjd0Ci8DWyk0RuP45RTNfR1iGhO15w91PdzjiWwG8FFmj5Ynm0jQSAeGEreoClBunHZH+ikD51/BhHKsKjSTEstLxa4bIk8Bu5r/Ezg9a5ip9RCpGUwNAQYWHFx7SpNMcR/Kj2h90k9aiz7OMumSHGzTLZPc6z1FCUawok4y5J00Bc9m2zHt62ezNAw5xAiUZW73PzEXbfjXMVVAJhZVZT0/kLwon9mFw2fYM9wZLIFth/5uOHHEj4eot4wsVc5b3XE6rFioJDtACQ
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:05:21.0776
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b18f8761-2501-4bcd-36ca-08dc434517e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9348

As the new CPB boost control is enabled, pstate unit test needs to remove
legacy `boost_supported` check and start to use new CPB boost control
interface `global.cpb_boost`.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..b3601b0e6dd3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (amd_pstate_global_params.cpb_boost) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-- 
2.34.1


