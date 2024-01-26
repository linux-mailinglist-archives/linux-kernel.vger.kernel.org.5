Return-Path: <linux-kernel+bounces-39741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BACE83D59A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC5A1F21279
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FEB367732;
	Fri, 26 Jan 2024 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ho9dW2v9"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF1F62A07;
	Fri, 26 Jan 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256531; cv=fail; b=m22B4AiupIG6vQBowyUVNzoya5f9i8l+QU7UW2qrHEDTrAhspT0hXt1mO9BHmbVUfEHUE1pFclCtqjrxkiZqdf/3xxKL9UvOadkLnUL11O8/sC7xSeVXMKQFo63jS0x1lAPgbdLevb63y2g0074+4QygnBSJcNUee8LCA/IshVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256531; c=relaxed/simple;
	bh=3yJMwxobrIJsk1KFSskxiV7y8hdpzxIHbTp+/BbOeNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPyu9PffEhjlBrEpUi6oZQhFA9oD818wyKutX587K47cjw4UfBqhCk+jnzt5TarBTwLjrRwrH//lWk5bkDce8elHiAPWUta6jSQesGiQA+ZoGXCdTqym6yCzNSl+GOmRToAQhCC+WObjFHfnB+KP4vCneXw3UWBpmElJFJOkkuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ho9dW2v9; arc=fail smtp.client-ip=40.107.220.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OElq9mczbaQFuZqMnX7FWrPIBXdICePICw9B3BpX9aDcFFlgm7ude0Gqa5iaqu/+UHWvmwKkQKa2kJqPYuWoEUP5wXe0lBvZa++z0ZCQnRCeqLmy0BKdXLnQid1AwGiIN16ti5Mj9LeNXIq6d55IsWbFhgiGNQ73rLIDreSeqU0xqD6AbniObccZt5zjccckvniAtoUiNyGTBS7uSZmXZgEvv3iOHiTuRG3uX+uxS0JZF62BiMLHV1MIXaFgTf+n9c4fhSGWcsLF8DZKoXd4+NhHieSIwzSiklxxNm5NB2KclrlFm1LSQ8qcidsnGvDGIK5kT+ojrVd7yiBWt8jGzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pubakwJL3Bbb/5I1Ypp2OiUAZ8NLMJkn861b8yY7Nes=;
 b=VGCfJBBlJCE/QVVFGyOjMRCHLiWb5HsRYYD/XDk+y7Dv56JGRMgDkM+6RrR1CyagBlakXkWPDtErA+v1HZYZNne3StemAJMFL05qUHQV9I9quCM3vkpXUU3hHd0tiZeqa2CCRirqnwW+tDQx4FjN2Q137+XqowASkCQb8GrnznhxozLxhaEZ0NLXadQXeRngyRe/zesqlbxEZVJ3f0Ld2bQDQdWWUL9yPbNao0wpUu8YFBy3TVkra9GYvTEP07XnZO+o/a6iQphAPSyNi7CiLQqvN+QXgvLmoDsHO+lJlpb81luB1q/Dvgt7v0taTY1wIJuFWIkhBLC0j8qBvHj2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pubakwJL3Bbb/5I1Ypp2OiUAZ8NLMJkn861b8yY7Nes=;
 b=Ho9dW2v9pZfuyAnBSnOoHTEArUD7Unpj5pubAE3TdLFP1FsyXraapWlCSc/G2O+WOcNWk5pn1EsCT/WQvfYOh0wrJIHmGsohfVFOMW71dA63BTbQUCGYts1/N+XSXUhQpxXJOfkiiBQY0XJNZVYr81NCFQYhcXZZGa07Gd1lDoY=
Received: from BYAPR01CA0008.prod.exchangelabs.com (2603:10b6:a02:80::21) by
 DM4PR12MB5311.namprd12.prod.outlook.com (2603:10b6:5:39f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.27; Fri, 26 Jan 2024 08:08:45 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::e1) by BYAPR01CA0008.outlook.office365.com
 (2603:10b6:a02:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Fri, 26 Jan 2024 08:08:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:08:45 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:08:42 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 1/7] cpufreq: amd-pstate: remove set_boost callback for passive mode
Date: Fri, 26 Jan 2024 16:08:04 +0800
Message-ID: <3404e063b86a5517b70d497b066c3fdeb5d8bef3.1706255676.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706255676.git.perry.yuan@amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|DM4PR12MB5311:EE_
X-MS-Office365-Filtering-Correlation-Id: 71ebeea6-447c-4ae7-519d-08dc1e4604bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/gerS5qFq2ay3zGra5aFPPirwoZQtjLSb8LzhMvVoxThLX80XGNbLw0jMLLTwi/eJo9UuCBVxVgWvORKeUUQgqF31Ma6IQFaYU1xki5BbGwpJNLuISupW1AgEXreVWOzekYtCXdiOJAfYqm80AasdNc/7Rj0b9CmhXUTXhtBHPDDpw3NfG+Zh5p5xC0yHE7nftxWWFh7Gp/f+5iOu9+sBqp99xRbu82K606VVs803FUjzJwKnNGmUNAeOwHKf7BobBXFz6QEEmLd5VCn/+3U5/JvAgAkDTJfcb6XHce7CmyyoJOhU3sIeObTcri8j4IiyMJgYdWT3eF/eOpICtlcE/+mXeHsumaw0q6fdJWXFXHMuP4rPxNw+OLp9aPDO9+8vQ18YNPeaKWS0pRhoEVeNiv4WyO192oU2+ezfsmBvl+WbQphRyCjCqElnWW9pIC33mqhsBf9SX98eCKQuymPKD858L6AkURLZqEDj7FENa6QYfJkA1H0gNFbq/MdYkpKORuuDXzSJE5Hrj68oGUJKc9ZG2oDttHFXgSAHAR34Jze7y1Wl9+/mJEvee36SVAddZqWc0cGDxg9V1Xm0ORLNqUtGwg99FFiwCV6A/YdW7aZAmlP+/PIhMcyzCmUHx5Uu2a51LDovbD8LReZNSwu4Wule2KU7a/9dE73frTpQCJanaNqEhMTgB/fDW7OT9gZS+KcWB1+9qHwfNEGXprhjc3LexgLuLyuZD59EjqrJ5KnLgwFT1RKW1p8o3+cSrvMQoUd3PxTlfKMLv+KvNNItQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(41300700001)(26005)(16526019)(2616005)(7696005)(6666004)(83380400001)(426003)(336012)(8676002)(8936002)(4326008)(5660300002)(44832011)(478600001)(6636002)(54906003)(316002)(86362001)(70206006)(70586007)(110136005)(356005)(36860700001)(82740400003)(81166007)(47076005)(40480700001)(40460700003)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:08:45.4199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71ebeea6-447c-4ae7-519d-08dc1e4604bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5311

From: Perry Yuan <Perry.Yuan@amd.com>

The following patches will enable `amd-pstate` CPU boost control method
which will not need this common boost control callback anymore, so we
remove the legacy set_boost interface from amd-pstate driver.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9a1e194d5cf8..8f308f56ade6 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -632,31 +632,6 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	return lowest_nonlinear_freq * 1000;
 }
 
-static int amd_pstate_set_boost(struct cpufreq_policy *policy, int state)
-{
-	struct amd_cpudata *cpudata = policy->driver_data;
-	int ret;
-
-	if (!cpudata->boost_supported) {
-		pr_err("Boost mode is not supported by this processor or SBIOS\n");
-		return -EINVAL;
-	}
-
-	if (state)
-		policy->cpuinfo.max_freq = cpudata->max_freq;
-	else
-		policy->cpuinfo.max_freq = cpudata->nominal_freq;
-
-	policy->max = policy->cpuinfo.max_freq;
-
-	ret = freq_qos_update_request(&cpudata->req[1],
-				      policy->cpuinfo.max_freq);
-	if (ret < 0)
-		return ret;
-
-	return 0;
-}
-
 static void amd_pstate_boost_init(struct amd_cpudata *cpudata)
 {
 	u32 highest_perf, nominal_perf;
@@ -1391,7 +1366,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
-	.set_boost	= amd_pstate_set_boost,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
 };
-- 
2.34.1


