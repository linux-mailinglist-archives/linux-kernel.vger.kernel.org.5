Return-Path: <linux-kernel+bounces-105908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DBA87E646
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925051C20968
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1334F328B6;
	Mon, 18 Mar 2024 09:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fZyWplBr"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2226D2D022;
	Mon, 18 Mar 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755344; cv=fail; b=rJTiju3mGqXulQUcYjmvKcrNq2bl0kph93UskQ3StPUOt+fvVmVvWwc/I49c5gphId78RMHNmhwRogOHTlbpvV6CIObbmujr7qjY+NrH6/huqvhSyo1fygnDNYkobIyTQ+FXg4vBiL8kuiqY4kkGfQQrvzbFuQ7fJ8yrlWru/cc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755344; c=relaxed/simple;
	bh=U+K/qwnVOCrghpyem5JUVBbl9CjG8kDY+HdY/Y8+yjQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A17i80y5SZadaOyD3ZWaaer4UfaMIiCJNGWzAc0BQzjNwQTqkwktxvy23Rp1gZWy0Ug4U7J5BZgL44hMVAF9rwqfE0KmAnCr7w75z8qbghzIQ2JjZPDgUzkbSkgov/zeKaqpJA75ztJETqyGoixmo9p4ohStL/OsNT2AW5JJsBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fZyWplBr; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Urq+9OsgziYK5xCMGCe3KqmXXAuTi0Et38ltekQDpZnePuCGRri75Kf+Shkv4kSe5mHScrxAXvhCiFuTi5XbGB651ub/qy6BOft6FroxR91jYlqKuiKVF1TsrmgfNqrtxwTF4T0hDCrYJJAmNv+CwgTjtl6nx6EAflgL5tNxt+syVaWtRDYm9IBHXdnGQ1oVbNkqB1AFURwKmbihmNf0Vsvq5d2M/JBCf2ayBXkqjG2VWIj1T6SVhcp/i2bl+M5x9dB3RKTRxqwt1PwlnB27VPMP2U4otgdm9YtJ9rSRaWk/iTwY/pQVTnFXJ9hy5Mi3r8BGzHhJxNxQqPM0YNN1Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qCxHw6EK+/fYuVDkckQOZin+iabU1nr2iRwfudvqNww=;
 b=lFXpaQhINgNeiJm1Ka621g/oEjGDi5m0OAjLlze19ROBwYyA4ymujTZOTd9jZ8jm0do9aZTc0kWBFj0gLeuw1WKzbisREVHP/EHQobAS18IHUIed8Mn6PgzF3ZARmdN798qNQ0ZJWTQPdo7lremBZw5IjNIic06xKnv6dUEOaqXBc7yn4sUrTj8ZVCkPNY0iFXiCauindx2yJXoM7Z/uHx5lVAuWzK0gh9vaO7CnllLWNtw3z+1fyt6Cz1C5OSersNq8P8Q7GBCj0U3AQ+mVCIWEE8wYnGdBFiEF0UPGa/zRCVeU7oWclNgKJKWv3Crzszp9YibVZRvDd/NtzTQDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qCxHw6EK+/fYuVDkckQOZin+iabU1nr2iRwfudvqNww=;
 b=fZyWplBrPXTBQxxKz6fHMyonxnqYOGqtLmVvDetS0jk815w+YpuUrpxBe4j09BGLInzFtaQOrC+zmDjIg0TgArtL33w5oYBpkN9PvJr1DMUTqsuU+ZBcoojo5uQKQBZ7bhEyockFNEeTvUOj/kJ5mB8k0Z7E5q+bpie6dBQ0H8E=
Received: from SN6PR05CA0017.namprd05.prod.outlook.com (2603:10b6:805:de::30)
 by IA0PR12MB9048.namprd12.prod.outlook.com (2603:10b6:208:408::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:48:57 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::d6) by SN6PR05CA0017.outlook.office365.com
 (2603:10b6:805:de::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11 via Frontend
 Transport; Mon, 18 Mar 2024 09:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:48:57 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:48:54 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 2/8] cpufreq: amd-pstate: Document the units for freq variables in amd_cpudata
Date: Mon, 18 Mar 2024 17:48:21 +0800
Message-ID: <b9a60328afad40581eeef694937cebd6158f1f2d.1710754409.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754409.git.perry.yuan@amd.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|IA0PR12MB9048:EE_
X-MS-Office365-Filtering-Correlation-Id: b31e9d15-f82c-4b2e-94a8-08dc4730a1a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uEgo1EvoscPykm5NRFgF2C0ngI2FQd+Boq3v+6GN9HDFtfq//0Ykb5N+1PN/1LgEIMAfTg67Qd0ih5iD31/yA3M4vbiO4+LD2D/O8yCRAA4F3jSOhRjoQ1X3b/M7ZFRA6lLSjZJJVRMN4X5N6b7lF1EWhXvFum4omOtoRVZgGy6gbw6FX6OnrQ93DTnAFLdDkBZUzeKGmZCEMohO5Bv1IzDIohClOLLoz9wd8wf0vHfjVtrc6lKF+uaLB0al+IlhBd+FMFeFn5tnfMex+4N7uCLrgVmtNOcjawTvS7BcYqLwpCncahe0NLst/Y32XnJR/pLP8uJyDQd6yNMKMm2Uhnv7GLq/DTqjqKk01TsEKqRR1mZFXcD2Qw/raaf880gHBGT+MVtnukoL9k6DwgItKhvzLP2BmZqIauMw2eMdbjX3FcrJOGcOG+GSuiz2SLHrtyWHMc5Q19/YAWh2+cFjOJ7tDLcN6UWco3vgA9YaJ2h8pcC+aNj4mSRCQR0iNGp6uq643nUPzeFXZOrzWa5LhOcuLDyYfJoCo8d7z4+V8EvAGdzvio8EV9dHPBEA25O5h3DfBN2aazKfx0laFDZrYTzZkdUZzvwxVDMgUwavf072eZDzV9IHQV+z6cdrQK6lAFTsSduVjJgPC2Il3noDiqOp9MeSBLNj5k6yNvVK9hdLyw0zePb+fhcjOdnCZJtFb2olgrdx+2ySSP+Jrr9mRCXQRtRt+4VW2QZmY6VK2fHi1t+Xd3h+fNwnVus+FmF7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:48:57.5022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31e9d15-f82c-4b2e-94a8-08dc4730a1a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9048

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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


