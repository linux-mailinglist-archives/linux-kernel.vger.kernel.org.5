Return-Path: <linux-kernel+bounces-163495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E248B6C1E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC0C9B21DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CD405F8;
	Tue, 30 Apr 2024 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pbXyyVZ0"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E78A3EA98;
	Tue, 30 Apr 2024 07:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463361; cv=fail; b=Y8suaQg8r6uSpdbHtHJXOq20Wo3MR72JkeiRRH10pA/lKyiFFocQVWNQeUVS3dgCf9zi9fNfFmEETugKitA+wKzN4tdWYXa3xe/AtnL9CZqo11FnyKZpyr9g/IbdAS4fhQV/T2O/dDNt/NyB49Mr0RkZGTHk+0+vB5jq92cuxkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463361; c=relaxed/simple;
	bh=8Czrx8Q0txSlV/JIpsebCnLkr1Xm0QcAhj2F5tMQXVc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gLCy8oXrVLrWm26uh0wBoCqAT0o9iqkZ3yTxN5qCgO/MYhh4Nm3w7OGQ1N2JXjujpaR/ktcHHc8cYlRXp/yCBxQ+Osrz7Wukz4YIEadoBJ+AWUFDrhn0QRuH362BbHHF5t2M681qxZGxhJbf1xB6bz3LLBRvFIrkkdJ+0tklM5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pbXyyVZ0; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FKG3MiE6nyQaUBggVgCj6h+TE/TBm/cjA1jPqpZPT4BlaNXi74Scy4GZ45aF4JiH8OIeO7qWWv0dQyBbWC01Rrq6HO6wOeQnowGIvY1AJK/XeQZ47BwvOHZmM2EImmZbqrj79JyJIki7NErT5ik3dCxnZ4z5bAvZPv3iOlOVZuDfqojQQf+I/Pt/+GRH00/0qknf7KL2F+qy0mNXmjsjcCiBjMLp6QxxEi+XNAapZtDc4XlmKBUNuywPtilXUIKCPGob3TDPynf8+EkrRESzxpzHft49gIwIzj1nw7wYWFO5O0cid3jZQQ2CrSjxxKgp/9bumbKNHnMBwx6MSx8/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXPIGsb9Xws0lqIY0/sp/d5aTIf7YZ07Onqhi39yybk=;
 b=aby+oWM6GSTlHtt39Id6oEZiH2KxRrN8Z6h4yksTSBpjcVp/DBFSjRYx2Jn+heQjTy3XuIdro0RikBjaxQw7etd7qYViAUJ2eyNL0wDkaJSAVfYoyElPBj+L1AEj/mQndCIp3Wi3CFcWd9dxEtUdy7ikcwGJQzKJLA69WfRy6JWU9AawyZI4VrVtHKAPaFoWSDZ8kO3CekCoVyK8uoQcoJQ2Cd8zGRado8fQOCedhcjzeAbaFlzHtG5APQn0ATp7cIo7NOCPO+73KeG07iTuYPS7atcScgtk5PKHHIPNdpdem1tNoGY2iRGX6v/1YAmSqn9DmDPCLhHRPsfM02WsSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXPIGsb9Xws0lqIY0/sp/d5aTIf7YZ07Onqhi39yybk=;
 b=pbXyyVZ0sT/R0x62Rh20NqRrLVsJ6RyEFgVZGXWp7t/2+j3WXQLaZvwQVmNZd9bNFu9fM8h40mNNojKlNeHPNEL+MW+aLorMazLuEy/snidkP03pHDYCfspzT4D1vTV2RP4TtZ/auAPImXIULVn6vOSwtjPII+FybS1TjeDrLcw=
Received: from CH2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:610:60::39)
 by IA1PR12MB6163.namprd12.prod.outlook.com (2603:10b6:208:3e9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 07:49:16 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::e3) by CH2PR14CA0029.outlook.office365.com
 (2603:10b6:610:60::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 07:49:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 07:49:15 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 02:49:12 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] cpufreq: amd-pstate: remove unused variable lowest_nonlinear_freq
Date: Tue, 30 Apr 2024 15:48:57 +0800
Message-ID: <20240430074857.2069301-2-perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430074857.2069301-1-perry.yuan@amd.com>
References: <20240430074857.2069301-1-perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|IA1PR12MB6163:EE_
X-MS-Office365-Filtering-Correlation-Id: 5478c305-02e2-4ea4-f3d7-08dc68ea08df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TEvD08waE4WhutpQtjDkXiC337mRoFkTa0O/VptOFNQTXXYPuPZlTEA9DZsm?=
 =?us-ascii?Q?4AiTr5GdZaAkerAWjAfH1aGm79YZWvVz4qcdjqNoL6pXHirXVD+4BDcr9rqQ?=
 =?us-ascii?Q?WcJwbL/YsLPQsmZxYwhdBpUSrMAMxUyBUtZMRwsWMaVe30P31/li6YwvTX8L?=
 =?us-ascii?Q?6BtbmEswfJnszhfMZ+Y2DToGejiL/WooTIRRBUVbFV510W+AXpkyqAl3nuJl?=
 =?us-ascii?Q?g9ZeJEWJVHHXeaGVreetNWaRncbV6cSzrzA1OHC1V5I0ezITFFsecNK5l5lj?=
 =?us-ascii?Q?HgyiKMD0nTcJkn4039gzK+M79lvc1Oa6K1NL10f9tEphIfivHSYdlorvxk0R?=
 =?us-ascii?Q?fu3AIQwxfWpzY0Kk01dP6GhepTj8MW4eaZHU01SJbxD3de0TdZ8raQeO++QZ?=
 =?us-ascii?Q?ybViTkpJ9GsZUS1kWW7USl3cgJFVF+C8V/5X8XIOixZti9HV9PTgd9moWzh1?=
 =?us-ascii?Q?0EWQHjggLoXTmV1BQYMs7oFu8Hh4nKDPAzAX+Kji6O/KF9e9ZBnMQRu4RvV/?=
 =?us-ascii?Q?AnXdxVhjD4ztSNK/vpOlAZGm1U/b/rjjD5ZU6aUhkOr4pbmuQoOmcKRK+Cz/?=
 =?us-ascii?Q?18q3X4sdW/6kPs61xoqS41krqIDDV2SA/QDCyqhqpotq753dQFNF10cKCw9h?=
 =?us-ascii?Q?d6Y/LRDf4G1pLrDmSMLmcIESKAux3YJiZfMcnmmRyqyKQ9Hz96fvT4nvKFl0?=
 =?us-ascii?Q?mQhc8H/pngCMKlTsQedwiBO0InadAcMg859DG5eYIiLgvdpneQ/sX91N9+06?=
 =?us-ascii?Q?z5ydYEnelu1QyGKHgYDOPKlx02eQbFvCvp8JwKuFqbhhWg7lvKALjst7qCrj?=
 =?us-ascii?Q?AzM8Q5sEhC0RUvCiF7uJWr5Zo9No5euYZ4xTLej5zsJ5yoxnm9Ei7zzxLwvy?=
 =?us-ascii?Q?brjHbDSb7K3VlwF/hXkW7XUt1eBWnEPG1L0hP8kxJkECSV/fBFuM9nh6VPjQ?=
 =?us-ascii?Q?ajNc23/d3lTl22Jw32Of5TzFVWhvjWtSXnT1gDJMwjaCgRxudcxje3BQ2yEy?=
 =?us-ascii?Q?xUvdmb+PwsjbYGKDMJ9t1fA8W5he4cdWyWRlx+VUvz/DTdOO0yetYVdewPOZ?=
 =?us-ascii?Q?pCt0WhxrFViI5HV2ChP2oVUCq/DIeEb1WcF3qKsMLLUhZmU1LdeiCBSNNMQM?=
 =?us-ascii?Q?B3Vgispl8mdeHORFwVd5jajnLNHwMQNVVMu7sOvKB9aCmT0VuXkH2DVd2vCB?=
 =?us-ascii?Q?bYe18EZHJydlJOgZ2EndBrD3vh5HR0/UEPd/x9m9UhkdDt6oEiPYml6TUc3t?=
 =?us-ascii?Q?7bxnzJ6ERG2pdsPhhetriI/CrPnZKkYBdXc5LUFCA0agGVhNdo87iGEoTdME?=
 =?us-ascii?Q?iRadRd4EweBcy7VGch9OfH8HW7SJMXQBVg4I34nOhSo09dgb4boekj8ZPiaW?=
 =?us-ascii?Q?9Np1ld2nulQZvp9F8C11qYCU2OUC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 07:49:15.9673
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5478c305-02e2-4ea4-f3d7-08dc68ea08df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6163

removed the unused variable `lowest_nonlinear_freq` for build warning.
This variable was defined and assigned a value in the previous code,
but it was not used in the subsequent code.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202404271038.em6nJjzy-lkp@intel.com/
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 85656342a101..2db095867d03 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -878,7 +878,7 @@ static int amd_pstate_init_freq(struct amd_cpudata *cpudata)
 
 static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	int min_freq, max_freq, nominal_freq, ret;
 	struct device *dev;
 	struct amd_cpudata *cpudata;
 
@@ -910,7 +910,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 
 	if (min_freq <= 0 || max_freq <= 0 ||
 	    nominal_freq <= 0 || min_freq > max_freq) {
@@ -1339,7 +1338,7 @@ static bool amd_pstate_acpi_pm_profile_undefined(void)
 
 static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 {
-	int min_freq, max_freq, nominal_freq, lowest_nonlinear_freq, ret;
+	int min_freq, max_freq, nominal_freq, ret;
 	struct amd_cpudata *cpudata;
 	struct device *dev;
 	u64 value;
@@ -1373,7 +1372,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	min_freq = READ_ONCE(cpudata->min_freq);
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
-	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 	if (min_freq <= 0 || max_freq <= 0 ||
 	    nominal_freq <= 0 || min_freq > max_freq) {
 		dev_err(dev,
-- 
2.34.1


