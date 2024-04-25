Return-Path: <linux-kernel+bounces-158170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACBA8B1C7E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA6141F21D05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5122B7C085;
	Thu, 25 Apr 2024 08:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ir9wHI3a"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C0757E1;
	Thu, 25 Apr 2024 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714032505; cv=fail; b=QNgkEkdEgHQZhSAppKE5Q/q8r1qdJOZf5OT7yaMdk6jZUkvxYAg/JcSwdIEMB1C+kyBumLCl4+6eCsXwtiX8boVtOOFcgW4klMnhsoinbdwb8cD+/D+cnujsp+V8mzCp2bJFQBfAR4G1GXlpDCg+IhJH2U7QbUw+8Ljn2gZVonM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714032505; c=relaxed/simple;
	bh=LUaCJ7ztNyvppYDBnyBW5x7KvW39abmf54w03poljfU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5Pw6do1HZUauuaCO9sjoNQmSrvp74clKAvHIaqBPVhwxhktY7xXozT7odtd+EY26Lzq73PLcC0Ll+Wa1Wc4HeLiAIGfK7FH3UDmnrcV/xKEFdBuxEM5uj7iLua+L6NPmCZPJ8I2RE1ZlXoW9D3SsJ2mYEh8Eej6vtoBrc1/fZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ir9wHI3a; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ea4dAFRVlCSmNT6mjePsq9mKqHE0HT/RSdbDGijJE++b/cyGvHgSPxFCzoQ3AlxX4aAVfNaFGWlqoF4ACwnsBlmoEswIw1oYV92R3VMMfxmT/P2irr5MANY2NDXjFLCzMCsuARpnwtsz5mfutDOn4eMGbFlRHFZRH9bNCQwn4vlbNQ4s8Fg2yBPP70JsK8S2jlT+scx0aA/Xurk2LkfBlBDkUIefBKlGZ4uy/hv4GZ1meKFZsxUsW7fQTGViqqkyPmT0xYy1KBc00Hl/y2vWd48eSuF7gcUNbyt12AFFpch56znSPoCjjlkh5oAJNyBZaRuFeNR44Xeqt806ZtLoKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xf4HrOdoNdR4aiMHQM4TVsOCXDzBuN4CwAHp7G4aksc=;
 b=EfM8D5NIhg7Y5k5ysjFYakvPDXtFu4OfBcALbqFWBwDkvkw0oIh74yTlbauiO67RQ4bsNpfmdsuO8V+fWcCADS9eYSXOXpoQU+cIPnElRdwGoRyr1twmaRz61rXWDls5NLGuSWgrxsum1elzC8uF3iTlnFvIs6X56PE9pXCQyzufw0JE2WjPF8CgFyLx/2oxcJTuBaz3UYK3YvbTuQy+foqn6UwpxtA4oEeVnuBpOOqW+Dhu8dXjP41VjFtsd7qiZFS7k7nUSNm77uFFiKe3k6ErIrkD/s0ZWWeiXvRjbxjv9J66czwB+1sJ8XAHxsen4jkzC2yOxRO0IZS4yhEY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xf4HrOdoNdR4aiMHQM4TVsOCXDzBuN4CwAHp7G4aksc=;
 b=Ir9wHI3a97DKirZwyNgYVytVd1XwZh51UHDuxXg6sm/6+HlOShKQgIllXiNSlqRx0vR3J57TbKc2ZhZEdgrr/wpk54Sam401y/NXr6HVOn9EtBBgkhKd3c7hjkPHMWSn0zHWOtiIoQduvZCVXIq+oeN8v0e0ziI6K3QtoAptgKE=
Received: from CH2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:610:5b::23)
 by CH2PR12MB4293.namprd12.prod.outlook.com (2603:10b6:610:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 08:08:18 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:5b:cafe::69) by CH2PR07CA0049.outlook.office365.com
 (2603:10b6:610:5b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.37 via Frontend
 Transport; Thu, 25 Apr 2024 08:08:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Thu, 25 Apr 2024 08:08:18 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Apr 2024 03:08:14 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 1/8] cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
Date: Thu, 25 Apr 2024 16:07:51 +0800
Message-ID: <1d984381f253bcca53bc2fe871cff17ec7770fc8.1714032153.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|CH2PR12MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: e309fdc2-dc2f-43af-f9c1-08dc64feddcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fFmD3TJq9QkN3wjH6oO16/RjM7kyTbM9gfNqfzUoyPhgP6bc59RALqUOIH4T?=
 =?us-ascii?Q?KigDeP9A5g14HFzLcjtiV91uyWBYECj2CT3QEROBHDjLwSpdthCe+7fc0EIZ?=
 =?us-ascii?Q?IVcv056z32QqKPU29+9IoIYXT1z12WVfefvy6mYxIn1H638I7IZNSmSdVC8b?=
 =?us-ascii?Q?fHv4dwT+N2gmbvuzwCc57a8iyYxfMd7FEwZaGaIxbQ9bO4Q5NDIRik3XpRbR?=
 =?us-ascii?Q?6qTfZS5kareb5fjg8bYbBAwoIZBfc/pD0MupzQSU/7p/Kf9uyNw6CK5bn9ZS?=
 =?us-ascii?Q?4mdLkniuFEBGi9ZShFeYiAUQwIIYYN10KFN36FLwjCrYXJpxd4yFpf/t4AlZ?=
 =?us-ascii?Q?1lbxF2BMVZuTjDeUsZRp3ctL2yTPtBMLjjXtDCbzCQbkYWcXTKivIJe7A4KY?=
 =?us-ascii?Q?69y9erIVMAhG/RC0bc2UxPoPKYvyj4aEQuLVG8gXSMORE4bPfZQdRHsl8aZb?=
 =?us-ascii?Q?QnQCL+yPAO7i9IeyHfZwKLwNmK9jav2pNcjrz+fNfFXe2srPnL9mx3QTYVxl?=
 =?us-ascii?Q?CAvhmhwucw4JpsdVD/04bF2KyZw9cn1rfOJv0Ml6tj1w5ZIIKIuGq7GZvJl3?=
 =?us-ascii?Q?X6fNY1Go0nhi7k/f+DF3F2saVjk/gwl3dZ24CYjVk7daSXcKedkzbXvO6VpB?=
 =?us-ascii?Q?J8+9x5fAMLNduI/hoR5iN4bv0f+f2Gsln4EX5yuzDfCv8TvFoIUJJD7uieci?=
 =?us-ascii?Q?4feQoHyhc9dYZ8b5H2SDcyvQaT1WBsftRT8A5TeX2kKOXLBq5qoAbz5ZKCfR?=
 =?us-ascii?Q?fTBvKOyf2TJ0rorEtZ28+d2K61LR7vYe+qUvkPcldVw61tjfW5V7pm/A8zHE?=
 =?us-ascii?Q?tD7/LNqjBQ5iy9AcLHbOMtEwgQ+PyHn1Ezp45hbA+422nq4wLQxbLCCLGM/2?=
 =?us-ascii?Q?tnTQe1c9JXjCR491Tsj8N64ZiaJj8k/hHdpjEyUhKFQHb+DhDuwOoKrZtvUZ?=
 =?us-ascii?Q?HPwIJfVQVBzUJTd0ACSHAuwZnuUdO5rJZ2F203oi1bHkcsims6iMNL0dnBMM?=
 =?us-ascii?Q?UZwOdQCIdKe4jEaiamp8mwp5DfTuTp6oT/AcHld2WmmL8iUPeRetv/xf18sW?=
 =?us-ascii?Q?AF2upvlurhgHfg+kOcgK4S0E/Dz1z0mBTHSQ26mvhdrlvUMqocJA2xAnX6wn?=
 =?us-ascii?Q?rBWlPvZVapeXtdrC1SDA05DhFCPniBUdd9o7Y0C6EkKBsjWBt+2A0NjG3+rl?=
 =?us-ascii?Q?7jOkU8Om0tHXL9jclVQ1JE15+TOvPRF03R/lcxXbyfGhcKoGl1mDtUnBvzRM?=
 =?us-ascii?Q?WB3CsxJ5Fo/QQqVEKqBcyiHthiv6ESz6lL1W6LO8mYC6TFgVHrlxoxdzVPKe?=
 =?us-ascii?Q?GWuiXR6dn5OoT2SccaXu195j14GgYkNVduLiRStT7Fk/d9Av24ZbS5kgYX6w?=
 =?us-ascii?Q?77XOJ5ZhphI7M4YPGD9vNMlK2vks?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 08:08:18.4695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e309fdc2-dc2f-43af-f9c1-08dc64feddcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4293

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The four fields of struct cpudata namely min_limit_perf,
max_limit_perf, min_limit_freq, max_limit_freq introduced in the
commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
scaling_max_freq update") are currently undocumented

Add comments describing these fields

Acked-by: Huang Rui <ray.huang@amd.com>
Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 include/linux/amd-pstate.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d21838835abd..83fb3fc647fc 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -49,6 +49,10 @@ struct amd_aperf_mperf {
  * @lowest_perf: the absolute lowest performance level of the processor
  * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
  * 		  priority.
+ * @min_limit_perf: Cached value of the performance corresponding to policy->min
+ * @max_limit_perf: Cached value of the performance corresponding to policy->max
+ * @min_limit_freq: Cached value of policy->min
+ * @max_limit_freq: Cached value of policy->max
  * @max_freq: the frequency that mapped to highest_perf
  * @min_freq: the frequency that mapped to lowest_perf
  * @nominal_freq: the frequency that mapped to nominal_perf
-- 
2.34.1


