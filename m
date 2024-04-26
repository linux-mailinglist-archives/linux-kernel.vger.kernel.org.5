Return-Path: <linux-kernel+bounces-159578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE7B8B308B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CE2D1C23044
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D7413BAE7;
	Fri, 26 Apr 2024 06:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pbVoeC9W"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B7413BACC;
	Fri, 26 Apr 2024 06:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714113335; cv=fail; b=mOpi3I8lDXK3rJF4Jax/O5sS2OzhFUTRwZJf3a2mHST3+LxMnKVKlRC8pcfoeRRgee6afE3z3syKfqbuvdEvYw2HFyZkLmkqGCoO7SjdRfCoO5kEnJZeFfJIfkCsSmF+BGRPK3lPEy6w6dFprwAeSwt9I22cvZDHSpkIXw5hxks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714113335; c=relaxed/simple;
	bh=bbCjkV7VMdqY2QMuGewAhU1IIKSJtxmnfxr/pxmA2ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iP3Beu6sZneNDhWKyAl8ECUhKoxRalGiZdZe0W0tIH5bkh5dcHEUGtJHFaUqCnC1hmp53C+sFs2wvsO3/LPEQTMmrQwoCWdyVhoZdFiZusnLsmKo8JD8LeoKQ4KTiHA5SDpdbyiqSS3nGgr4NIA8bUISFGg6K/5c2WTFzAd4kTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pbVoeC9W; arc=fail smtp.client-ip=40.107.220.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo+vLZZLnXZ7crB9RmGD/a2B0/Z2G9+Dp6iGcZ0bEjAxn2rXBBf/aiCqrG5iU6x4lHwuc/6rQYrVBvZHGiegoyFEWnLYkRb1KEw3gVPH27WHsqNQHAw+kQeRzwj02iNY0ZhvHKQzziOns2PDY9aoBnQqu6DrTBEXgsRsse+jlc9fQFc77WxguV9dxDCo+ZhVr07elbwDiMWK2GD11M21g0lT3Mu02VsJFT5xht7GH+rrVi0kkkM8MTQuTXyPsqndfu+tcMbm5c7LyoiTZE32+dyjOdBUw8XNc6XHzpQLaHwOuvBPC/l9Eki3FPoXPwgZ9zBxQuyJor7Qvmp0neddmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tkx4txtTZjDcX2X2oGcNONU/mWr2BAsDpinZTQ/7X7Q=;
 b=clYZJQq9bNpjpvNikqqoTOV7bDz7LTBCaR7MI54tfc1hWlZonKVhimxOFrlg2ktQYHkv2AsXG7biwBXOg9uq18wFWC9aNt8U06UleqpjkcB+tNbEfklS9V+yNXAIz0hiwU27GQyFdN7clHrg1LSIqJ5dUmifK/L3Ek1ONmm6jLHXoAhxbPkB/HhK4XJzur0H0abpYniKAUVz1yar/h7v4RQz9yt5ONHW7+FSDSZuSzl/U5/8G0gW4YS6YEP45AgcRGCZk+smeLT3l14w6mf1ej3YnBrSctoMds16+hPxGKFSrC0CV6GtBXhh8SMiYCQNhyeWFKNqI9gTsvIKeYJ0Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tkx4txtTZjDcX2X2oGcNONU/mWr2BAsDpinZTQ/7X7Q=;
 b=pbVoeC9WNfuOZqpQJoiRaNUr2JALkBvvOt+wUCEkAIuvxpmAFPauZx7lk+KynlDAFqaogw6R8abr3V9GtdjWCTgzXJurUlgcTIBfACh+Rylqt8VDqho1dRROOzDaw26v+rLGaLZVx9+FWmWsRoKOrCcOudSNi9NO7+t19iRjVto=
Received: from CH0P221CA0041.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::25)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Fri, 26 Apr
 2024 06:35:29 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::a1) by CH0P221CA0041.outlook.office365.com
 (2603:10b6:610:11d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.27 via Frontend
 Transport; Fri, 26 Apr 2024 06:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Fri, 26 Apr 2024 06:35:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 01:35:25 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 6/6] cpufreq: amd-pstate-ut: support new cpb boost control interface
Date: Fri, 26 Apr 2024 14:34:49 +0800
Message-ID: <e4077298495eae7fbeacaa8a7630e677583dd729.1714112854.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714112854.git.perry.yuan@amd.com>
References: <cover.1714112854.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 9dff46c7-8a4c-4263-afd9-08dc65bb1077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fVaqTDTPedEAPyO+qkYYAlIKM0AKd28+5Dk6vjhGZgSFeyqx80B63vCAvjVX?=
 =?us-ascii?Q?J9UnfsU+PCv7xyNLJp0OnfyI363/hZF6Yq8RXex3HJyizJYugk2vUxlwHgtK?=
 =?us-ascii?Q?ZPZ1cfZeL+esvDBxFLWEyORU9+hQIDv2ACyUNTNzAOYjSrdnukqjuwLSUyLT?=
 =?us-ascii?Q?1C/it2/q63fZMG7Hf8/TBacXoTDetSWSpGJMcCfoc1H+ISfu5wDksR6MCaQy?=
 =?us-ascii?Q?ymyMlDQIcNihOklAXUBN6fgZeya5Z7qHil6GSw319vO+RkVb+sSsiJndk2Ht?=
 =?us-ascii?Q?tVeU3uRqRXawJKP2D68fK/RJ1oArzOlnYEXsKU7HQbXpSl36o4b5z+gWtzG/?=
 =?us-ascii?Q?uUbh6QBwmIrJzqSzPyhLzZyB4CI1BHyR49SZmjJ2zCcDw04sRZa9WsFd/o97?=
 =?us-ascii?Q?8Zd57jJ/BHiy0rBD1blNRyyIxJiJwPGiyx6SP8bUhnGFcGYvhPkWyDHEAokr?=
 =?us-ascii?Q?F0tD2Z4fINgkJVH7yojvc4zK+J53SnC7l1CM/R43Yf7vZGHIq8I4RLPV69JH?=
 =?us-ascii?Q?qeFF/ksj+Gfahlb9iTFNh0buokt3qA0sgnZEVd1f/XR1xxC05y/TRQ5MumQl?=
 =?us-ascii?Q?hdubvYgIoBy+RhDlUq1qp7XHqSW+1GPOBk/VDU2mssNrBoVBiKrCwZbf1+3G?=
 =?us-ascii?Q?iveWFwzOVPP6VguPMz+k62YhIq+LFKzD44+EMMgOpTjXurU1M+OOvm6R1lor?=
 =?us-ascii?Q?qYPOd645z5wVxsIbrfcLj3i32EQ1QnK+2snW+2+C5jl1K3IoHQebxurozDDS?=
 =?us-ascii?Q?E6CR5WAXNuGLkKK2FcF9V8TlbuQOIZNF/9N7OGV4cDIAqvcHjXPLr/qygrDO?=
 =?us-ascii?Q?t1omm3+t3ml8om6x8PLx8FaFzajq4kSg7KOXQvzlAp0HYkdBFWeIFjz9BxcM?=
 =?us-ascii?Q?e2AMvBQUgtVqtfxSfV1uSClPYvrIUWkhwHOpV1khgMUEkIyjQG1c1jBm9BS2?=
 =?us-ascii?Q?XpOcDWQsqpk3s5ynGv9U6o20qiP9/rve8c2AMEG0oUwb3SdO8y4RMplPrQQ+?=
 =?us-ascii?Q?ewgLAP7NRf86uS9vYpWTkyQYApMW2m3d5/uhgG5+sm0NLYRynNHyquF3DQcl?=
 =?us-ascii?Q?yfiJw8icEDyelX057IIaJLk6SSMPrZuEHAJ72QOY1dNl7QwgPYvlXCeDOSgu?=
 =?us-ascii?Q?iskZ+YC9iJiDHUU2gZUIl3fw77r6iSrQ+oR6ur1bLKhQRwuPWgX3OZ5cGnq4?=
 =?us-ascii?Q?lhmr2nevKHzu8eRVjNrIG4bbxoNCEXahmY7ekRvTQHk0Bg47ZmLj+5jjv+0O?=
 =?us-ascii?Q?xEC4vCQLIr/dTzeMWfVwTYAqBUx/i+qGYctNfHUkny/47iSt+0E0spxxK2h5?=
 =?us-ascii?Q?/02voDKEseJUvN8siDNpg+TCh3MILeFxmQbiOVRW2WRs58V4v29LUwexGFcb?=
 =?us-ascii?Q?FRlQzpAFsv2vIYSSfVKXubGNcRa1?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 06:35:28.8711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dff46c7-8a4c-4263-afd9-08dc65bb1077
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049

As the new CPB boost control is enabled, pstate unit test needs to remove
legacy `boost_supported` check and start to use new CPB boost control
interface `amd_pstate_global_params.cpb_boost`.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate-ut.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/amd-pstate-ut.c b/drivers/cpufreq/amd-pstate-ut.c
index f04ae67dda37..b3601b0e6dd3 100644
--- a/drivers/cpufreq/amd-pstate-ut.c
+++ b/drivers/cpufreq/amd-pstate-ut.c
@@ -226,7 +226,7 @@ static void amd_pstate_ut_check_freq(u32 index)
 			goto skip_test;
 		}
 
-		if (cpudata->boost_supported) {
+		if (amd_pstate_global_params.cpb_boost) {
 			if ((policy->max == cpudata->max_freq) ||
 					(policy->max == cpudata->nominal_freq))
 				amd_pstate_ut_cases[index].result = AMD_PSTATE_UT_RESULT_PASS;
-- 
2.34.1


