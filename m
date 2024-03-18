Return-Path: <linux-kernel+bounces-105970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5700187E6F7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA404280EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B2C3BBE1;
	Mon, 18 Mar 2024 10:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bhZikUVz"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2083.outbound.protection.outlook.com [40.107.96.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA5F3A29A;
	Mon, 18 Mar 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710756710; cv=fail; b=O620yhF61uaeOcIhN//9y8wO+o16xmEigu8KdD7B9uutwEk/avv/gn0N4ohuP5P0uzDs+ECUweEDkDy0DXNI/mKmTeoS/uxaRPi5GbPsEYC8L8ETCjJLB+VWyAEB57TE608q0Vx20Zmv4QanntBOxXWK/4JU7HGyPqiSMT1Cv/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710756710; c=relaxed/simple;
	bh=m1QQ+FWWV3RUDF1uvHRUYpoh0aRKA7LM8m6KCGCSsdc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPaBmOwWEiZukwq/9d4Ijx1nPXRh0jXHNgeAQMT8H/99OofTSJWqyp+W8cUZ/Om9KRbnkPmEXdLJw1C1c1FgddjjEqZU6EbQh+dj7kSyars24dBTiA5h/I7D1wB39FtwM2pbWsKFOqWNd7lsBcEDG9j1JCzzDGuQY9VqQ2lxe1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bhZikUVz; arc=fail smtp.client-ip=40.107.96.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG3t3fZ8yBAqkkHI4zNlmO0siAbr120bm5f9XN6Xuge4VrU2gafrD0Ie1kMIjKI5Mr+gESTKhtb19/LZ5nf7pzAfw+qdgfgVh3Zf82k6QpBdIsjI1NyTgrxq2Pn0vqZuYmSZCUe0rFwnYyFvo8a4B1fENIyK6lznpoySh0GOUxN+Feko2JQTecxuyX7/UnlKeybVA08ZBPbyFYr8qTiS8nPK4KXM71WfthMd1gPmawcjfRDl9c9vARVuZVL1CB6D9VMO/+ycfuEXO5pWyGpoK5ZmNKYH1L6R6jD50B7BSR6tU8BjlEB7hn2qKyYsTHoB7Scmb01kQc4cdyOqr2kMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dg669zp2or/DzO43fJYX3Hpy+TmMmMMi+43WGH0vfC0=;
 b=ZKrBIwhHgtdvMGGq6iiNySSpYJ70BCyVp0Pwk85fXfSApEgyA1p/4drI02myUqXn0qXhhIonmAzvfYM1rE9xHU0omLVfauPe2LuyLXgrqv/OZkF3pmiWgZ73h0AC55YocGoDHwXXQ0+LlD8KNcsh8f7INywYx3o4sPeu7AM7x7S7CxZOVJZkA6VSibs5KtKGpIAQCX/OlCYFERnsNiwrx2EEALH3sCRRS5njvzAqi0kXKQkFMGwpV5oLJUVpZAchopjNorcW5eTTQ+5QHwDSeCkmtTpfQI3/voHFHUFlC9FHoGIiHgtY+kg2EckyV6A5VdrKZxkbgLjU5JaDrClNGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dg669zp2or/DzO43fJYX3Hpy+TmMmMMi+43WGH0vfC0=;
 b=bhZikUVz30h7PY6fyw3+X3mSc530jmNl4lBPeVRKqRaXF+y61d27XzdFjzfuqiaSx5N6hRN88SJ7AAI4y5HWnA6UqfS86EOD5E4N5SSErIFcRAASgM0gj0vXBXpdrvIjd9kvWkUQlXAAtNJX8x/xARX4rR612G4mSgHF+t+6Mx4=
Received: from CY5PR04CA0025.namprd04.prod.outlook.com (2603:10b6:930:1e::28)
 by SJ2PR12MB8135.namprd12.prod.outlook.com (2603:10b6:a03:4f3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 10:11:44 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:930:1e:cafe::d7) by CY5PR04CA0025.outlook.office365.com
 (2603:10b6:930:1e::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Mon, 18 Mar 2024 10:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 10:11:43 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 05:11:40 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/6] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Mon, 18 Mar 2024 18:11:11 +0800
Message-ID: <8e04afd3f5f8f9f9aa1a4b7954ad4b8946d11d31.1710754236.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754236.git.perry.yuan@amd.com>
References: <cover.1710754236.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|SJ2PR12MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: e79d78d6-d818-4d1c-008b-08dc4733d009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mWZKWT1Ekzh5O508Jma8MRPno2l79nNZ0mqy9AGskdRRIG+q9JaYeYgNsmc/iY8DpAAa42smCm9fQyInKdOj0K/AFC6ykZL09fGnBKsB49Rm7atx74DOuW8M+Oh9wJBLzQjh9CCsgWbCXtencUFJcFI562vBz8Ahl6Ims3bVddlqgsinvZ+Dba8I4wHRiQJKsM1vYk+BahB4FlZLPcPXY7Z8iflfilGmDPhITcBkbCUkrqtSXLgpMN6EB1XwPi2Q0om2huIoRS9iA1GrFnc8B77Lmo3KlvQ9UAS8ro33GY+BYU/On+5FEFjl6NGj3U5c9iocMypMC3TM7Ms5L7yPo4mEZXHSPP+a+H+saVt+WhVc7WLCdKDs7lOUIrzhzlbpP1c+ndMrnbZeqKGUtXBEUdelxC4subWrX7DFuslyEvhU6r1zrcuzrfS8TdtZ7tTIhKhTAfdAVWDdTH+UNIuiEaBwgqiW2sU7JGZr+DRJ9wxlp1Bk4CI6Fn0qPQKhvKg0/A+5ZnGEh7YyrZWoo3IgP98JbXp3zxK7qxACwZMps9gVlvabqRGPLVswMn/Sk87HNjP4E00djRdgpJsuV76C4SPb7VTqxIw/RWy+9JKnTxpqOj0mj0iu4XlqekTyDgQ+TGZmu46o1Yt7W32/vH8FC8yCDfnl4y6HPeuTdulf4SJxueunNwx8WNppUPk7X3baDRLhavTNu8gFCxr2qY7PrJvqLccKFOUiFnaQRM/fQPHUCoNRKlWZedDTc2Vjsoag
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 10:11:43.7829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e79d78d6-d818-4d1c-008b-08dc4733d009
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8135

From: Perry Yuan <Perry.Yuan@amd.com>

Select the min perf to fix the highest perf value while update pstate
CPPC request MSR register, here we need to limit the max perf value when
CPU boost is disabled in case of that highest perf value in the MSR will be
reset to original highest perf value which cause the BOOST control
failed.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 4cd2818045c7..513f91611cd5 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -476,6 +476,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -495,6 +496,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 	value &= ~AMD_CPPC_DES_PERF(~0L);
 	value |= AMD_CPPC_DES_PERF(des_perf);
 
+	/* limit the max perf when core performance boost feature is disabled */
+	if (!amd_pstate_global_params.cpb_boost)
+		max_perf = min_t(unsigned long, nominal_perf, max_perf);
+
 	value &= ~AMD_CPPC_MAX_PERF(~0L);
 	value |= AMD_CPPC_MAX_PERF(max_perf);
 
-- 
2.34.1


