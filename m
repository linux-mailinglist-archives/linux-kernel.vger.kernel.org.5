Return-Path: <linux-kernel+bounces-104029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F8487C80C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C0561C2209B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD813FF6;
	Fri, 15 Mar 2024 03:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yI+cflRP"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B0A168DA;
	Fri, 15 Mar 2024 03:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473986; cv=fail; b=B2PoTtGiDkq8uGhDJyYUD4LN5SJjntEtIb9e4fTON9otN0tsaR5f6JDhtIlnKRvxIW1Kfsz+CY8bVXJYg/DS1qcACymso/Qb/uA5FHzBn4YnyyBMLRl80VJsBH9eE0u8tR8ITzl1dPywAA2n6BvlKzg8Yz7bogHn5zGs1omjrW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473986; c=relaxed/simple;
	bh=qfSuaVQA6vXMoMlgSbz3rEmG4v18F9u7XcIjVetNxnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAPGf+seXsK+DjHPojPVZ1XkCcW4zr/I67Ck/bpyc83XL2Kf/tb7HKpsX8jh+S4ByyAAStxeWcNZLkjEkOzEx6KqLXvR5etTR0vNlh/5iUt1+PtwwAL5wf1GkYDgNnII5381JGxA4BwB6KXNGz1qdBZqfdzdL26qbYEx1gLOCpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yI+cflRP; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FEWz+vUQCKKYg4nbiYLARFq304tbTBRhvi78ZEIz7PXhsY+Fwv5DYpvydi6qw+4P5lsYex8bsgsH24Qwa2uPODULphLgy4WK62Bu7VjwGJLr2u3UB0ynxo5tHd/PpEPLaEgw5GNhGvq6Ou0BCCD8R/v/DUKLaRym8UYY7zbXziLHL/iWyUkqe5fri4NmYqCvIo7wF84ZDgiW8SlNgwSLn8MhDhH38Gc8TRPpnrLvIb0sHcfY536TwHgZp4qIrpftUv7jv1Y3wgDpWwuMfedBJeP47cRnk2OioSsdttJ6UnG2wzTIeEBdRw3ssIbUIC62rwTOGdX1htRe7FbXTnADJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n2wYoB2us2t1x4ls6RtaDCh2zxYC76HMyowEGuLDO0=;
 b=kO4O1sEY7VzdwMhgyK33WhDWw41xkWpMH3p1CjexHTosKuYlzfKTy6aSrqhbacdg7ibR3qjLQVNBK/W/V05aMM4yZnHfnxG5pPYlnEQa96VEICvJ2JF1J0cfDwT6NaYOKcJbEeUn96VKsSUTIfC7pwQ8HyXgRUj2odiAtLEd5sHqA+OutmIoSUGoz4B7dYEJhvWfTbRhT5xoGF56LC3sr9tk9gtXjVxEg/xo6zTpHkqXntUAixYak4TqGb+v5rCUMCKxFZMNtDp+udWN7ZLaOVJe7BnrEm/mxqXBSH7SpadklLaHK5OFYLF2JIeVYk8ah4j3CuL7TZSuCzX00/rfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n2wYoB2us2t1x4ls6RtaDCh2zxYC76HMyowEGuLDO0=;
 b=yI+cflRPjjL+9fWj/teu53BCJPrtgQpyog+0e3YuLlLwkSXrch2R8ybVOWOW9ahHIId6tg7UEJAc7QZxGHjQ3BsocQtiW/qutFCUKnnlQH2ymtFbffrM0gT0kHiMG3RHTeLCtfWiG2bY4D5m2fBtu6VielTq9G0Xo5sVvy2Re0c=
Received: from CH0P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::8) by
 IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 03:39:40 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::99) by CH0P220CA0005.outlook.office365.com
 (2603:10b6:610:ef::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:40 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:39:37 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 7/8] cpufreq: amd-pstate: remove legacy set_boost callback for passive mode
Date: Fri, 15 Mar 2024 11:38:08 +0800
Message-ID: <549ec092e5ebed43e4ccf539036f92fb03d716bc.1710473712.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5887bb-8cb4-4d1b-1802-08dc44a18bc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0xcvaFqkgS7wtwxx2xYstSjDsCao76VnE3zX4h2+EiLkRhlDQYHOS2saUnie8ej8a3BM+ryL+g1TuHKoaYN5TseHfQGDESnaLzlpbWPMFAODVzelprDbp1yW9oK65Vs5qUSc+tVcT5BsP6frUBfPAmLbiVxeYnAF+oJKyTO1/unxM9af+XLhAV5TcN+g4JxRXQnIrYLGA9H+VrFXGJ5yZ52Py5CopggcnF2gz6emdwTQRIf41/wQbAX/UM4EDbVrso4dKrPSIqX/9xX8x1NKq8kzuTOhKhZt752K7mBKNlFoZcBFtNkNf4eZbfJRW10w7pyTk8ubLP47ug9/FASrHdeTnTllyxj7+Av14Uu5UkcIRnYsMzDYKc1VNlaGsEkWVYujE7MKQHnZVqnHEmMabZjRWAfyg2YG+yP6FGDns1ZiqRYjOXNxhy/ZnZilfuFV12BDhbSMXlvRwiaRWQ9qmRVi3LrDCQqmIu4GokH849CTY5vAHrQ6cjsPZ04Ak3eLPMF3dh/ccsA8v6B5eD6h0xJAyhVUpgxoUh7NudWUTcoKKAobCink366nh77Aq6AsuQgc3bqtLn0RJdcxqwlvMN5gM7Hwo+4EcC3lncxrOgNnbkU7n4vHZtbzSphD9EiTvqq+T1eJ2xxJFZXA7y4opfeY/q2iNpZtl2WKdmHMvgMmPchCom9STqkadnN5yE5PfgT+YRIA8Cn4nFbu29V73pOua7CalOwInKRVvBKErAzxlD8vspKbEBfn+M7psLwM
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:40.4188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5887bb-8cb4-4d1b-1802-08dc44a18bc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

With new freqency boost interface supported, legacy boost control
doesn't make sense any more which only support passive mode.
so it can remove the legacy set_boost interface from amd-pstate driver
in case of there is conflict with new boost control logic.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 include/linux/amd-pstate.h   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 1fcb35d5c3fa..7c39c44be598 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1757,7 +1757,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
-	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 383359f9cd6f..e89cf1249715 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -56,7 +56,6 @@ struct amd_aperf_mperf {
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
- * @boost_supported: check whether the Processor or SBIOS supports boost mode
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.
@@ -94,7 +93,6 @@ struct amd_cpudata {
 	struct amd_aperf_mperf prev;
 
 	u64	freq;
-	bool	boost_supported;
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-- 
2.34.1


