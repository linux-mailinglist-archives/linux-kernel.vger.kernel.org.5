Return-Path: <linux-kernel+bounces-107236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E922587F9CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1872C1C21A5C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCFA5916D;
	Tue, 19 Mar 2024 08:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dMTcSdg0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4DB54645;
	Tue, 19 Mar 2024 08:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836951; cv=fail; b=jWfDXPU/lakhp9t1JwLqnSST5nZ35ZSWD8FUtDXLEGMUfADvo8jbJ2b20fI76lpYhOr0HxC8M3TZGYi00YoQhurMmEAL4QwOcHvsw7By3J4aazV3Rj9v6HPdVYqvxDxevk/0IPfNql4CwFgGbsIhkLIo2hi1WYUsVp37/qhn4HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836951; c=relaxed/simple;
	bh=Uegy1dPjPJXcJatYbxxKEJnRlswxiN2wQD0bFVrhO/Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foCwCOn3ipaEV7HIbjtVQCIOBsXp8yQXkYV/dbDBxmO1Kt/UEF9djPZatLFURzzIE/nqQQMU5aY5Xc0zkVR17zkLrNif/GmDUqwlhqrfImYClBK2ShhnRI4bHA44rNOHG2bamqpCe2gKdmqjIhMWJkocrbXK/ljefZkGOmHSSEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dMTcSdg0; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKA/RDRkDmmSjKVyoULcMig/yD6vedy/HVYOrh1qD/JdboC3Mdm97+oWu4dY3hZX1b19sopmdtovB+/GyttmlS2rhPQR1RgXbD3gvg6lKRSUu0qBCmLR8MEqd8DC1bIykDknVKi7ybcozksV3DPgTVY3qPi13hC6DM6JSkobQEFDm0ChSkKA7Y2Q6W4FAOanRj4hg+huPklsY3SKe7cJt1LRQvmoNgROf1Uj1YA9fyBSmlLmC7LdkIm5sHR0FLESyC+Y8Qenl+ZzJDT3wXur7GrT1K025lIYPMwXJYGAGP/3lBHVHUD/u8j/gM8szzSFE1OTPdKR25mqa2kf1xhaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSAtW8xlj2sL6Zjhj4yanoKUkddG/Gthab4cpoJRwDE=;
 b=VchyGMtSKzMk59yxw9ILqtfZPIYvg3+tcuQzuT9mDvj63cKU++WPR2W12Ts60ct+TnTWDOH6yT+ZoT29/5ugJRIR+xjr0kcn4JBofJ5VRYha7leD4sZC+1mvV0d6wIUZP/+cPkt9BO2hynreDBpD/wqPgsrKOuXY//rEnTJ93nPMDZW367ZAUqYcCeWZw2C3oyFzvdd5HuQXMnbZ28w81dJSmFfwXaq7wwABCk0HW1PkWGfXt9SgTyibnrle40slFadXYsTBPIQSIDErWmICBjD+4hhJetAJH5HxRblco7UPggFGo6Oy3p1xN/uZG21GreLCxfQRtRy842iP8UaaPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSAtW8xlj2sL6Zjhj4yanoKUkddG/Gthab4cpoJRwDE=;
 b=dMTcSdg0WilZ9s/93XIS5YJP3/6cGCyb+O9/ppQx3CVkyHLyMjjeKIotKkRVCaQDnY1ckZ8zai9kFJ4fuOMaveYlQHR4BuuvoVhxpqRxI9cnM6Gs4i20guS8Mv5dD/eh2MwGqV+iZZRZHGaj/r8C7TYJkCn/MdgeYNYVm3HHZAY=
Received: from SJ0PR03CA0029.namprd03.prod.outlook.com (2603:10b6:a03:33a::34)
 by IA0PR12MB9047.namprd12.prod.outlook.com (2603:10b6:208:402::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 08:29:07 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::45) by SJ0PR03CA0029.outlook.office365.com
 (2603:10b6:a03:33a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:06 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:03 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 1/8] cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
Date: Tue, 19 Mar 2024 16:28:36 +0800
Message-ID: <4b00dae2cc2ed3146a747a7fc72438972c689dca.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|IA0PR12MB9047:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee6e07b-c14a-410f-7bd4-08dc47eea4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tez5Q9HRNFDCUIPYCqS+71neyZwVQ6uLCuSoGkPf4MFAF6sRLreoqrP5WfvLomnnT00NOsggAVL00I7RdlJYzy3ISACSISuWA67ZaOT59ljD+FsiF07TUiOtm6x5/U5buBLsg5dPfC/cWFX9WMMK73LYC57v7UzDh7bCURfqSwR2NGuPVJOBn0IHfz2D6OTJ3ULASQFAeQ3Qcg7W+LRzS4LCluYgbrT4aozQHut/jelBN8d4cLmCBKz+R0XejZ838F+F8c2qjKfvkSFuwkRkIOt9PFlHDD1KSyi8Wx3ho2uFKjcDm/TJCzdcf2orYUvjUNmVs9bZpEnGeKWGayJP3tvyR1ZS9MvdqDnoPlRuJCfPBMD4VOmfyzhkcB143bnwbq5Y/Hg1hx5BRt5VQws/+aL79kDla+xhKDTbKa1WbY7UYmtHLE2CoGbB98V6h6VlMxNYTfVOO3bS2+T4ZgYzRz1aPH+KfT4xvBfw5DCtN1lx7c97dXnb90EVgSkX7vr79JSxtWxDnRbyJURZW7Wt6UqqxPDrDoz3HUDT41TZtcl99gpfKvGLrj4lSVb1BnORZ3hyxwmPqEoI0TQZkpQccC/JUzw6x14jNTA6FjZnQqwtYbRMAD/AyIXv2DRoksQjV40xg7WC+TtBTQE8hNTAL3avA8uhnNtXAX4J4v96qlTycPB7lRidO9/oeyqRL1DFtoavlo0MmPO4o2pSuf2GAplYeKrejmqN3Gnv2WoXRZ/47awlNYy8jHwuJNVxtAur
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:06.8589
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee6e07b-c14a-410f-7bd4-08dc47eea4a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9047

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The four fields of struct cpudata namely min_limit_perf,
max_limit_perf, min_limit_freq, max_limit_freq introduced in the
commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
scaling_max_freq update") are currently undocumented

Add comments describing these fields

Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
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


