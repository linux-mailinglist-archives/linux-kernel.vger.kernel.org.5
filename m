Return-Path: <linux-kernel+bounces-158171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D108B1C80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7969F2850F1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C67D8005C;
	Thu, 25 Apr 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="W2Aa8wPF"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8FC75808;
	Thu, 25 Apr 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032507; cv=fail; b=jh0koCqY43GJDQD3aYfrmrSoUoDtDGFGfDEst7GoISA0HVznPtNC03/d4x6MUgdGxGjj0jlnyWq3ok3Tucahjr9gUcW4PyVjz6zRdO0l0L2/TfUXaX4LxlP1gxGEsASv4qHMjN5QnSS8KAM0GFEIulfUUSdMVd8vDjIuHDmr/0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032507; c=relaxed/simple;
	bh=AvIG2FhDdHY3ZHVuKnfGKa8TZtGrwrKZmlBslmAR6ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MdnO9SL5QTd37QFS63/TvaO2WosSiGUJD2wnVrIz4k3kfrgkki9amh5r3By6m19ig5MvYmfHpap+x51Ad4Kb7HZ8QwXjnc6Yk9I5zaU2LYRabOoOLmyEMx5mROGPefcBTlmLt4ZsnVpSNWn1KCw5CqrfuHhPdZBfhwbj1yqACb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=W2Aa8wPF; arc=fail smtp.client-ip=40.107.93.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CUI/osIzO+fyfAW6wCGVm5FNOQR8MtsQGEZfuhY0t8AFOhCDnkFIXucyYSew2YZNAKC1QCtER4wVRhCMeiDYI+hnUC32zPRlUQbVQ/PUB+mCJY6oolwHcJR8zPq8cgxp/jqlrjMVKmPthl8ms2EJ2AOM5U5sS0a6MbIUYS+iLF/KQ7BolJgGzmqOjRCxsk07kKdvP50OVhUs5kwrwK08oDsGCNclbWICT7tio+3aLQlnTimwUZZ3L3b2NLWFwhyjMKsO2sLPVy353bKuby55xNRkb0rF//Y1a7pooKUR37PtykIsLdz8Mbu7VlQC7NleSI9womWOdEhZsZBPsKmLVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AsmTbquJ9BY+dgfDmlFkoA/xm+DY16dXBsdnIdf6d9I=;
 b=H/Jk6e6mCW5ccXQN+sJ86MOsKkaYIvwaK035PsjPxcOiTN75R6Y/vjy8UQkMNwLbJeSdBk5Vujy/haCOdmUXk8HE0+WpFcW1EsNfkP2XNGt2Cn7T9ecUrmK7FzIiAHizBFj6lcerL0ZEE96p3Afkwi4RigicoYvMVSIz/olaVEKb0h8KZUK+I0y87R+iFFY5fWqSQstvRAj0l52zW/bydiEuXLLc4818P8dTZPi65znsmHckIx0wUBp6RftfuPeD9MMYBnv7aoOD2JewwQvQJN4wkeqlNpoT+HD/v0dSqFBv2Qn7harZ6JFsKeEkwjZmEAm/kWsaKzNBB9824QJj8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AsmTbquJ9BY+dgfDmlFkoA/xm+DY16dXBsdnIdf6d9I=;
 b=W2Aa8wPFW/UVElkNgb+GFeaxDo0hs2nHZi1GnxvINQNTI/rSZIQu6yZRkR+Dpy1z47iOIEVWec6YQPVl3yRZUK9GvucAu2aV39B4ZE+/H7xXyGWNtsfET7eTfoeZYnbctePzya6Nf/jkOnQ6D+KxE6floMLF2cSiqDB7THDlP5M=
Received: from CH2PR07CA0055.namprd07.prod.outlook.com (2603:10b6:610:5b::29)
 by SA0PR12MB4446.namprd12.prod.outlook.com (2603:10b6:806:71::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:08:23 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:5b:cafe::ec) by CH2PR07CA0055.outlook.office365.com
 (2603:10b6:610:5b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:22 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:18 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 2/8] cpufreq: amd-pstate: Document the units for freq variables in amd_cpudata
Date: Thu, 25 Apr 2024 16:07:52 +0800
Message-ID: <102336d846b82a91faa09240f1751635b2d9d7cc.1714032153.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714032153.git.perry.yuan@amd.com>
References: <cover.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|SA0PR12MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: 0094c119-6d2d-4b0d-b5ab-08dc64fee053
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A1R8XV7SUDXGFfVNddXsbOSGEDcTAz+IVIsZ8ndsYC1yuRVocYTTv+rxqFv6?=
 =?us-ascii?Q?m4RUNGCrBKvVJqkvZldhsf1bRkeDvxb7rpyyQ8RUDkz2XVL/CRMaIqH1AzA5?=
 =?us-ascii?Q?yNuAhw58usH7XebjL1brJ6xd97JVn4CVETsNCTjTkZVQsac+IbCajgCBU5u5?=
 =?us-ascii?Q?SYmrjITrqNLYwQ3ezA9mbUEsS9pYyHBYGr98dfpBy20GqZ/F5cd62mqVYq/b?=
 =?us-ascii?Q?u13CIwpmiWzWEtpzqnTPnqhMxmjJGnBsMI/j3IWJgt0QaZhtEmk3W/yHB86R?=
 =?us-ascii?Q?l/jMzpMZfqyVSfcP4P/678whRlUM6pAMg3j392/kX+c4dsYrxEn9YDnKX7Ud?=
 =?us-ascii?Q?G3EpqrfOyjSLvhiLVZrzhKNiAux8COUCaUXEFjz/fQUDmRk+talEIyITrxmG?=
 =?us-ascii?Q?Z5mcFmzYZLVEW6HYC6A0yyZsjtyxYOzLlBSZbWr4qhX3Luquyk+c54eS1wW0?=
 =?us-ascii?Q?CZJmUYO2vuJQWHcbkvn5wLD54KbVZb/1Y/Ez6alDPQKYqe4ra1xehnxORUel?=
 =?us-ascii?Q?bxw1ysv9RgJCBlA/nUmtOQgjobRdztvjzhBgwP4FMyPOwcXASVht+8mq80np?=
 =?us-ascii?Q?j5KP+hVwamcl4ixyee+/yb/LJonIH5+MqCc0YNy3ysmf8z/a3ZY/P1v5tKoI?=
 =?us-ascii?Q?bY6lPT37tYg38ouHgB7iqkSEcMdNzPirwPfpdDZGertiwHDvbGG5/03GwAQs?=
 =?us-ascii?Q?HbNXjCTtIs/KC/5slLaalk8IGE6JlZvHzGZG1dS4EIFMv+ZzxrcS3uYVolYJ?=
 =?us-ascii?Q?KHNFXyGC+ECb74YCVIB8eRvSd3ReZZVdutrsFe3Qss8R5iyzXUbZzOZJAxM+?=
 =?us-ascii?Q?hxgXVq+ea/uMXt5StxHz/1phFNk9DY7lGVv/Owx5WC8v89unyv2Z0d3jFyKq?=
 =?us-ascii?Q?qlWnCxYMP5+otuqFnDmwp99XLNcMqqO/H1a72S/L4fJkWg+iaLqmmwVUhnO2?=
 =?us-ascii?Q?ENHswcqE8ECwtoQf+hLQbTcpWO8plS5Hf7j0M6VbJUhYXH1Oe25VTdH2OVxz?=
 =?us-ascii?Q?BJHkE/ibv2iAFX+fvx9b4mtw6dQ0j7NNwej8G/gCtQk1Ob2Jiy5HXiTMz9U9?=
 =?us-ascii?Q?nCin6tOVxeYdjmG25Nx1aZETkxu2WevFCAabSW7BBEQjcJAARg3sGxi8Ia96?=
 =?us-ascii?Q?Uv5AooktX4Sc0W68GV8gIfKEPxlmT9CmgGV2nZzKRY1hvb3hHjnS3ANMg5DJ?=
 =?us-ascii?Q?Rwps3bDJsb3f0/0Ph9yfWvEjmon90hNnH8mODajLyV6YegSlHSmNZcKpS1wG?=
 =?us-ascii?Q?N5aHoIlRpN8r8Cqufb1dpkWM9J32UWAf7s+Tw5sKHsnninaR2pBSZT+NaTr4?=
 =?us-ascii?Q?kIhTlMnY+fXD+2Txq/nkwxrhg38vo/U/5JgWV6UsgN3lXCxmnmVvOiOALFx3?=
 =?us-ascii?Q?+If1OHt5ueIIN7ah+WMBMv3yf+YZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:22.7195
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0094c119-6d2d-4b0d-b5ab-08dc64fee053
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4446

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The min_limit_freq, max_limit_freq, min_freq, max_freq, nominal_freq
and the lowest_nominal_freq members of struct cpudata store the
frequency value in khz to be consistent with the cpufreq
core. Update the comment to document this.

Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 include/linux/amd-pstate.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 83fb3fc647fc..ec0b0fa3e9bb 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -51,15 +51,15 @@ struct amd_aperf_mperf {
  * 		  priority.
  * @min_limit_perf: Cached value of the performance corresponding to policy->min
  * @max_limit_perf: Cached value of the performance corresponding to policy->max
- * @min_limit_freq: Cached value of policy->min
- * @max_limit_freq: Cached value of policy->max
- * @max_freq: the frequency that mapped to highest_perf
- * @min_freq: the frequency that mapped to lowest_perf
- * @nominal_freq: the frequency that mapped to nominal_perf
- * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
+ * @min_limit_freq: Cached value of policy->min (in khz)
+ * @max_limit_freq: Cached value of policy->max (in khz)
+ * @max_freq: the frequency (in khz) that mapped to highest_perf
+ * @min_freq: the frequency (in khz) that mapped to lowest_perf
+ * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
+ * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
- * @freq: current cpu frequency value
+ * @freq: current cpu frequency value (in khz)
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
-- 
2.34.1


