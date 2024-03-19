Return-Path: <linux-kernel+bounces-107239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AE187F9D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCF41C21A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DC37D071;
	Tue, 19 Mar 2024 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4ZgKtM20"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D8D7C0A6;
	Tue, 19 Mar 2024 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836955; cv=fail; b=GCW929YQucq8JvOqCDV8HVIsz3C+JAji3FEIwzoHl61S1aCCVvyZILsGkSu2edBYfpV/5aGaWVjruBkwG44G/FUfVT5PoQbXQaKXuhUS3dQHe/3T21fEk2DDRFgRbIBM7ueQfZLvQJfqn55DACZqMFRfsp+xMp8ki38ke5XbjIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836955; c=relaxed/simple;
	bh=Yr9wdyvingd3lIRRk7qqywV6i/5N0l+mbsB1DkkaYxM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ni6PL64joyKbV8tyOdmtwP5YNA4l0cTX68CvEAZirHvApImsgNAnpl/7/tYlO/s/I56dOdQDYjGTPkXw+kqp4LbMVu4mXc0pRC4M0SJtfU9ec9qmIxdUjBL4Xe1rN5FcNorV71eIl8MZDvEW1pq1MS172UpmmS1LmuHDi/v3cGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4ZgKtM20; arc=fail smtp.client-ip=40.107.223.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Li0IlAAMTj1OwxT9IZUqsIqrQyZc0bu0ZTf1LvTCV7HIKhn04bnAI/jzYZeLwIBZzVZiFSl2m5ms1SuLOBryYwJuiXg03d9/QxEqXSPNSgojkqBHrzJiW8uuoZnwNSeWrppcwf0FdPimuqYSfoThxeqJ7DLiOmzYypGdMepmuy5Mz3uHFhRcauNRlYUHugwJtTl5kPGmAbaAdIEhVqdipMBu3QZ0F8qmf0+nK3Mp/bDiGqfrM76u1TDZOclI2Bkygihek0o/UtDNEbwoHhxa28lWACX6vR3Cd1FUD0eLz28tz2mdq66yKEZBtlQWcGKR2rcBzlTnBZYvtDwQa3lAfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmMGYmAfZoM8710DzJKs9Npp9QaOVlOTT5Egye2i8uM=;
 b=NDGG5OcM/oANN5Q7hWyvAg9Y5I5jmTcjkeAng2PkIuPWktcZLpt0Noc3D06WBBT+/5rrw/d6lKXO1lkJTfkw6it9PdpdbR26b9GZ/f0pAPceeONL4JQbUaOtJNOXdDzqi8X9XpDgVeC9px4YG9Mro+LgHWNc70UENdnBiFINIFgNjemUj8FDGSdzg4MMRfdcfBngJHPMYaSw9lptCrBUfvD2EZos/nOA+RgFL/8UIrSBQ2fmDNxgoVZcfRT5ZsBsp2GpUgjnnmo/Z66Fb9l9ggVvvX+01BvDPwVwRSS0mLiAfOEZQ4GsFO2u8PF3QdvPPVoQKvl//3hYA9jFYba29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmMGYmAfZoM8710DzJKs9Npp9QaOVlOTT5Egye2i8uM=;
 b=4ZgKtM20ekcR9SCt268EiO9qvWeCuz8nuxQOGTd2CLvCSMOimuB1Kk1JVzRKuuA1iuwEXPZFKoBLpVoMXIHpwlhyFiBmfICeQfzZdrTBr/i3qn6yU00vxH2wUVxGWpyOv6PXQ4VYBxm5bvz+bWvMA/mKsSQQV3K6ysA67yCF0zk=
Received: from SJ0PR05CA0118.namprd05.prod.outlook.com (2603:10b6:a03:334::33)
 by MN6PR12MB8591.namprd12.prod.outlook.com (2603:10b6:208:471::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 08:29:11 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::9e) by SJ0PR05CA0118.outlook.office365.com
 (2603:10b6:a03:334::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:10 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:06 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 2/8] cpufreq: amd-pstate: Document the units for freq variables in amd_cpudata
Date: Tue, 19 Mar 2024 16:28:37 +0800
Message-ID: <0ee190df1d882d826faeeee28a000b06eacf6034.1710836407.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710836407.git.perry.yuan@amd.com>
References: <cover.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|MN6PR12MB8591:EE_
X-MS-Office365-Filtering-Correlation-Id: 22bd9725-3788-4591-9231-08dc47eea6ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5+9QYS6KXkhhJ7tP1lgxzmR+Ud9Fs2vk3HvAsOlgrXMTo6+CV9aR0NL48kZaRPewGN2+f8zdDaCQ0wDEWwEz4cwp6tc8kHz9WNSWyH2LqbrLusm1GhDUEkucZWh1G5tJiWuNoZ2nwePho4SpXaZP7p0TmFgSW9DwTcqkWRX9yb9+d74sZzjDyg0paS1xZBAZ/U+l6Onw8t+KoMHMfatieAKEdc0HH0xKo6m53hJOknmCEWe7TvRB8H3sclJEYfGjlSLdpX/9xDA0k9GNuRzwv7dI8zBzNfED84AxZlW/FD7DuuJRdu0VTUsygSoDQNj2nPxf9bA/kjmlUeSmpnhL9BoO8WFetdQsPNYL6TXRAbREQTR0c9aOgBwh5ZTPTf/fmiF5CA2lmufYRZcmgRCY2hIYB5y6T7ke4alHTGzYbHw46ll/5TFbzmpCj9iV1s+hAAjU21fT2ImNjvtx1XwntLRVk/+mrz/SKpl+2KZsnNEpUxuaO9FUFyki2iY8XHdhPJQ0dX1rquyaL8OeswG0tCtjxm4bCwzHfxSIb9U6iNICnK43ZKLqSzU4FaTPXRya++64+QvEfWG7mBkJulhtwdy0WvH1g4eE0zmqpetZPgY1Xs/epkrctMjMb16PlVS5tMa2zSU+hGRL208/1Y9eWYqAM7NoOaqlBrmZGUtjLNb8CCxruIBTXo9NsHVmBJ537gqC2qwxpH67uHNKSoQB/5ocX3Pb39CaCRRqiZWkb2qvseujPCSuK5lysMcb3K8P
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:10.6671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22bd9725-3788-4591-9231-08dc47eea6ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8591

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The min_limit_freq, max_limit_freq, min_freq, max_freq, nominal_freq
and the lowest_nominal_freq members of struct cpudata store the
frequency value in khz to be consistent with the cpufreq
core. Update the comment to document this.

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 include/linux/amd-pstate.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 212f377d615b..ab7e82533718 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -51,15 +51,15 @@ struct amd_aperf_mperf {
  * 		  priority.
  * @min_limit_perf: Cached value of the perf corresponding to policy->min
  * @max_limit_perf: Cached value of the perf corresponding to policy->max
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


