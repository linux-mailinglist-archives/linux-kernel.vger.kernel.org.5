Return-Path: <linux-kernel+bounces-101322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0347C87A584
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3635C1C20EA8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782D13A1A3;
	Wed, 13 Mar 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fx7y2Leq"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB503BBCD;
	Wed, 13 Mar 2024 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324319; cv=fail; b=GfBNxvrSViFaLxiluhhvlfmO+tJaapial3a0fO/CMVZW+IX/wQry0ESf7I8sbCNxBz+NSrjc4qS1bGmC9KDRjvoByiyV7lKNWskqg73sTDKqjzaDZVkGYhrn8oCwbxKf7IF85tt1n5dFcqNp3VlWF4e0sRPZQx2cW1GqC+KBr+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324319; c=relaxed/simple;
	bh=VQYmYiArcYPOCwXYH2OSIeRlsH93cEG7r5xGn06R5Mo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6desgx/Sc2Pf4LzHx57X5+HNtgUnBIe7lHDEkRhl17sOv+CEH9w7F7AlJNgb8NFL7StZh8awucL+l8YlegoYNrAtRCQOf1r81p+ileb1Qu1wnYz6FVNQnm6564Zbyk6hBE/8ESYJGpEVZIbPIZ6gyPodE6xnQ7ygqn5LZUhHP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fx7y2Leq; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AftPOq9OaYjyMac3XYXqtaehlMe1wtK0KKj9ck0H7kdYwnbN9iDqsuZQFB5BCTq5SOOqTT2Oz+z4bs7c+8FR0CMQPrPLjcWALSUp3jBhyKLrRFSz0TslgVAE/m3zBH3xwpGBWx27P14V5/RqUhd/1e1TSx3Bq/dtE16LRIbHB815fEaWV1kbhJcxDqS8TNKnnxXR0StpV09sebeuT2qNGPMRNRYfhsbuFSHZzlL5JE55Lz5oql8UM40yXo2KIOM6gVWSMSVxI3LV6yOQqyTPPmEi4SBINzPWSIWFOJXCfEMs8AlJWm8t42aKdxALrQIn6t5kYV7+zUY7FZC8kg4Xhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDGT5beOhaesEsOnd1HFjQW/L49aJkGIqMFpBAJi5Bs=;
 b=fNmT/oW9lRRTEYVA3H1EgPXQTotBVrfGZ+WrEoTdY1mmMjcbd4gCIqsGBJnE1nzhU71BSv2tbL67TDqe8ZMZHYydZxClXLtBdR3W9ODPPJaHiExcVQ+VB0MwyahwVokEzW/fK2DEEEdakYdU5OS8IyEGNwB4VRP8oEXy/PS948ijlxw107dPTX0nfygn/ADc26tVM4OsYU4G++KQpzIk8HyLRG3uQJ/h7b7cr1S2/0UUbB4gsuY/iZOeDAaVULAMoOtQQWIMXS0vGUU5EvsAmBby/fDtNm/baW6g3/gYTyUgSAbAAISOeelCxJDjWmyu494hQEw0mwpmyJFDFxQytg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iDGT5beOhaesEsOnd1HFjQW/L49aJkGIqMFpBAJi5Bs=;
 b=fx7y2LeqLkjq0xzGzFYXS5w+19pDHT7UTQX8r2B0At/zPW2UcUPzIS1rIQY6qDoRRSZ+PdmC0qmFU6GkjIndqSM/Mki0sK4KJQy+NdbOnFld4Yrsit1DzEWQvXH/h5+6BS2hOqTr5VyWtXyb+ORJpPUkvORmEUc2rccQhhNYiS0=
Received: from MW4PR03CA0231.namprd03.prod.outlook.com (2603:10b6:303:b9::26)
 by PH7PR12MB7018.namprd12.prod.outlook.com (2603:10b6:510:1b8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 10:05:15 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::7b) by MW4PR03CA0231.outlook.office365.com
 (2603:10b6:303:b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 10:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:05:14 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:05:08 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 4/7] cpufreq: amd-pstate: fix the MSR highest perf will be reset issue while cpb boost off
Date: Wed, 13 Mar 2024 18:04:41 +0800
Message-ID: <faea296aa8eb87374d1980e68d4fc314a48b1453.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|PH7PR12MB7018:EE_
X-MS-Office365-Filtering-Correlation-Id: b969cafd-3da5-4e05-84f1-08dc4345141b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m3/MghirK9frelaoNexpdH2OZEwWGqtfIa5a1d1XWwPR00fc0BO//21BTnNTwoh7bQAJb1gdPplENKH06MPm+2BcPGFZN/Hiz4LMWzl8LQ+wVa4JpIVwAY9lnCoQHqUNaDpDHXRcVy2i6cz9XLpCoRr/w+k+gTb17hDxVIT6R8nAvyrbr6K2SPYKq7G8DTC07vHXE05MZgq+tRDTmgDdQJv/c+ph/fJDaRPKsmYZkfNDKhioV7UqOaGfL57S8rkR6re7VV7vyGbC6QSydssj19hmX4RDNm19Gd6xzzSFCFW4kANId/JYkNydFbgCr6TYAhnl1c0tSJa3W1FaYL09GuWzU5hqXw4Mo3hI6sTQp+s/CN8dlFXpqawgZ2lkOzOPT7fcNSVyRaaQ02HYZP1uyIkEI+M+sfeoPBZa5Jt0ZoAHjziK6coiIxX3MC60TntSL6sKenyqp2HD0VZIZKbzRjJE6gE/dD4DDiJ67UywKxbHDYzdfhtqSWTA7J//bumwN+ts0cAfV8nPQNNf1U3ruvy/bOQeDLahdOkdy3jdlv9HHPhzI07cys4lzebGoik1OghRZs6CqpJTLIKxpYpiHB+toDoSIZEfRHhxvmUna5XGunXRglZJeRdMZan8bEmYDZELACu4LOKbBx2y1u1y9Mx9jLPz9B+JnsujtXXYUfD2ZZNxV0KySk1zYA1vZ0kENOicJWQ7fPHytf2l9EBoTTvT2c1QLWlDjKuDMLZ6orixICv2chg4MURV5GZ+eFK2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:05:14.7357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b969cafd-3da5-4e05-84f1-08dc4345141b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7018

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
index 0965fbf660dd..d7afbded6e3d 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -440,6 +440,7 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
 			      u32 des_perf, u32 max_perf, bool fast_switch, int gov_flags)
 {
 	u64 prev = READ_ONCE(cpudata->cppc_req_cached);
+	u32 nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	u64 value = prev;
 
 	min_perf = clamp_t(unsigned long, min_perf, cpudata->min_limit_perf,
@@ -459,6 +460,10 @@ static void amd_pstate_update(struct amd_cpudata *cpudata, u32 min_perf,
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


