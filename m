Return-Path: <linux-kernel+bounces-116431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B3F889D2E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B881E2903E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9297B175CBE;
	Mon, 25 Mar 2024 07:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nub4fOJB"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7138F72D;
	Mon, 25 Mar 2024 03:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335856; cv=fail; b=TpQYkP/VeviEJK6Nc4HLOODojir1FU/N6tK93ekTCt/vhrtq+9DD/1oHtOa5FqyK3NurYFeWL/ONH99Ez2c0iQqu6Wm82aDoNhYsEPzUhEWD2nB2A1aGaZL4NPgkRzXoMDiksf5IOJhwqsmEKUpFLbRkTO0gZsAwTyFCMW71zCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335856; c=relaxed/simple;
	bh=XMwTTO4/bPO+ySOez9eTILEkPi7sQoi/IWbBR2sbI3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RhUdzw/Pjwmmm2XQoWHFCwGKW9iDVInAwmi/U+L6OyIKuzuXSYoE2vPAdZ9tV9Hchl1S4HCbnKiGtUH2Tj0zQdmjA3elqpXaQOVtMasy1PM/sSZeJGZAKJDQB+jetoezWslhXj67JhG8Tu3vIBJDaEV0C9Ii5r9nFQHut6DpPzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nub4fOJB; arc=fail smtp.client-ip=40.107.220.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JD3mApfSZ5QWTdQ7RQjSIpAIVlkbQu//BIlTtHoR5WBMweJjrwIp2fT7t5ianf/FWAr6ppEcuuwkCkxpy3PJu7p3b5qYnckdausX6Krrj7CRBsUlRjAwE3ZrLNHM8Z8xIkPd+Rf04uBNFEXcIfm8Ylj2INb5RmZrDNrmO2k+tmbQRTiOOfTsnzZCWVRJhHi6gG9rrJ/BY7pVRdr5jf1+rEO5YkjspUkSbd2qVN2NpQLOvSkQ0lDjlJUTeomn0sKt/3u2XEACCf7Gtezw5SuxRfUBIcWHq173cVor+1Keaj0QuKsJeqnavdv+Vz0cpzTmofdwTyoBGii9fiSVPMblXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCOhPQqNxvE6zGrQ7PZtmjPqFjFqKmB7RVPXtyNtEVQ=;
 b=HCZFeUSQuFVOaCesjAI+WCMZWa4dkTv6CGWUQxhc+gXSCkBTI2gpF5K5ybPBN6LXizzY2Z1Vg6FCQtfLII1roYdfv7pS8UhYoM254nYwQoorOj6RsenQ5h/ZC3M+FXEEh1gtmzaLBUr7jIgxMKQFKAVwD8/mzRxS6w6HDam3WeMwuz6F7hsOADM+t+V9O3gY4DXDJVToQg5lirtLepekqhBLsv810+uMKTkkpgrXtp4tiJpXFPekFzMlBKI67akMQs/LJxJER1iRtXvXi820dXjoWQFaUpp0Dmpui4Tq7aprxKbYvr54XIwGkSF0COzfd1y6xz4wYIo/H3KfnSuy/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DCOhPQqNxvE6zGrQ7PZtmjPqFjFqKmB7RVPXtyNtEVQ=;
 b=Nub4fOJBd+AnXeC1FgThN/oxli3mDW2yM7r32ahs3hrPROfyZoLM02DdOgV4BDYOGWg7l+QZnQQNBCd9Wm3BH+X/d+/rNjG56wsH7Ea943tbOXDnfo+5tsvQTERphbIuGXolVvYux4caSdP6vg/8NRh5c0jTjalubLArS62/jOM=
Received: from PH8PR20CA0014.namprd20.prod.outlook.com (2603:10b6:510:23c::24)
 by SA1PR12MB7200.namprd12.prod.outlook.com (2603:10b6:806:2bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:09 +0000
Received: from CY4PEPF0000EDD0.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::7d) by PH8PR20CA0014.outlook.office365.com
 (2603:10b6:510:23c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:05 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 1/8] cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
Date: Mon, 25 Mar 2024 11:03:21 +0800
Message-ID: <6b8432f302165e686a01ffe7d1d98852d5e88609.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD0:EE_|SA1PR12MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 2631e266-e06e-4b73-b576-08dc4c783d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bIw1rbzWfCK9cySc1BIyqpW61cQBzBgdMo3+YamswoaK6CQyPaOYC+6oMnuYgPq48J5aQoD4fBASrGglx9VnLTTY76mJj/PfSokYZCKw6drE261ZMe/Mip/JKKLOoF/cH+h4oCQV6LwmwPlIL1DhfE6MFzBFaYeeB+WGIQ1gYsjzues+WHWlWemIXnw3H/PRY+VgdGA4MJzdjBsmkKm5vgPyua6viOGPxpMD65C++sIxBs6Jg3cJEw5xOYaTAzFLJyG8LMcBcavqjzL+gb1Lu7jW3i3OHaDSyCB71/DW3ykcYpeOmMnd+B1JijRY3iLnNnSMif2GKf7tEi5neTJdw95lvMqrCVWfA1Bb+pNOEF5xEHPfb2S3uRZfZ/HX4Z/iWkG/BNdFwNwXL/JVonJ4kpxJnt4/E6exDI2agHhQPIYKWyiczXt5Zf7tem278gwX5wuHvoo9c8DR71gUjBNMgmmAGClp9bDkeSZgM79zmFZzdAb2TXE1D5qIuF15wb7Fx7dB7NP3j/3w+EbaqUrGrYhVJe177ZFtF2FSj063x60o00I+PY08y5gyV0Ldnd5piCFfGpwbQpsS2iRgKRVB9hB0lGV2L7qWwBFhIPzdVy1gW/UBRC2lmMnH9ubZac5R4SyDRWrspevt491vRdqZLHw6hARJ1yWBc3gzv1MWo+cPPefyCXaaX4mXaJbqfQ8/KQxsg+rI8ak5DV9Z1TKjI0xrW8t1IIpomms4N1t7BTVPssQFyPrw8rmSA3SgMNkc
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:09.1288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2631e266-e06e-4b73-b576-08dc4c783d8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7200

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The four fields of struct cpudata namely min_limit_perf,
max_limit_perf, min_limit_freq, max_limit_freq introduced in the
commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
scaling_max_freq update") are currently undocumented

Add comments describing these fields

Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 include/linux/amd-pstate.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d21838835abd..212f377d615b 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -49,6 +49,10 @@ struct amd_aperf_mperf {
  * @lowest_perf: the absolute lowest performance level of the processor
  * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
  * 		  priority.
+ * @min_limit_perf: Cached value of the perf corresponding to policy->min
+ * @max_limit_perf: Cached value of the perf corresponding to policy->max
+ * @min_limit_freq: Cached value of policy->min
+ * @max_limit_freq: Cached value of policy->max
  * @max_freq: the frequency that mapped to highest_perf
  * @min_freq: the frequency that mapped to lowest_perf
  * @nominal_freq: the frequency that mapped to nominal_perf
-- 
2.34.1


