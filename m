Return-Path: <linux-kernel+bounces-46063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F348439E9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFA7A2834F7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0976052;
	Wed, 31 Jan 2024 08:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uAxywpej"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BD64CE1;
	Wed, 31 Jan 2024 08:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691073; cv=fail; b=abLWjwrD63GdoMX8Beom2isIpe0+uKfB4o0QyHtE9nNrYcWjwq0CvicaehbIFFgZxFJWZGMvK48xjv6/5LiRHCSOsG+fBaa2cjq4WTlODkopXuwrGnx6vaGjiViHXxYkPiVqT3kw4fti43PUNGQWCiOK+DnNI+JWGqo7/MyC4TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691073; c=relaxed/simple;
	bh=f6YCxrWJySTWnBx6BjcAlA/CMLlvX6mMK1dGU/dP108=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4BOFV7jALvbu6SwhmolHb8T8mnVUaUkJ2vUGWxeE3PTtKH8BX51FCXffZSO4lGluJtxAhBfw3l2z1rr+kg+A5tBbyGx27FOd+ApzSzscMm2FZbuTGSEoYPhSFeXGdQiYYuiLNuXdLGCaymFGdJ+4dlCa+i4OV0Q/Uu67cyJ8UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uAxywpej; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6mP/lLmZ5EO3NMzg4XeHZFwdFv6osgzPzvtwoq6ya/wk0BjPo71MwwU6sn1EKMxvXcI+ZYqO8nFuRDBS4AqWNYunOhI8tHo2aQfVltBWWiL8fQSTZHjn44i09q/HhnOBonpuZSFUj4YLagK/dD6x4FQXhC4+DbaJ9ZB56OlMVeG6sl5nT0BLlbRA1uLYUtPs1Hd0mv2oGtDIJ7xCWoY4MR8HBrTQJPyR5YZD6/YfL4Iyb/SBAdrvrniLPQRKn7JJgIgxYVp8hVLqWl9G2DvhXx+t5mxTjzLRbS6u4m/p33cbl85dEOtYSn/3WUFEeGpUjkFdpFagdXYOxY0MSCgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDmgMtUxX7ysGY9Q/+vh8S7VVZM6WP5pDAL5QXK5CGM=;
 b=FwCq3XMDCIDaxz7UMwW4kEXVfkCAsqLjyGxzxcaFrQa5md77tqqZ9hUwzLFuOvzYXlVLaOsaXjx+ly9B93jRUdvtmrQ6UwMsixbZsbv3GzKlagZ4m/GPvSf//dDoZBRbYv9ZJ/AXqqWCimeTkXAEA7hnpjXL3GjnHLnX0lZgQX/Sd2mNHT9BwNqcsWek/HZLN4ChJOtgdtvHQMBmN81VfeZIkukYRFVxblQSulYVRIZYipjqrvWcHYT7MSvBgeJs8uVL1ZraGAGWq2Fr9Ued5Yr+ftado6GFpURlckYN79U+b/F6of3CH7Gokj4SmQUrzSYXzFMKFFqyCCvAcydMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDmgMtUxX7ysGY9Q/+vh8S7VVZM6WP5pDAL5QXK5CGM=;
 b=uAxywpejTn87kgXKdAh4Q0MhLlp/OciCsoreNupvTFbhl7ilFLyVynfDABjcFx/iL1ICmm+8a08Aj+/XGFl6xGJp34+j+YG8ZvCdNUGMulV1I/O3OxQpAsp0/HBw9LsABg8ioMZpU6A9ROD2UWZuRA2kmkjP0G59A9E6XZIPTCU=
Received: from DM6PR07CA0110.namprd07.prod.outlook.com (2603:10b6:5:330::26)
 by CH2PR12MB4101.namprd12.prod.outlook.com (2603:10b6:610:a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 08:51:08 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::1d) by DM6PR07CA0110.outlook.office365.com
 (2603:10b6:5:330::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Wed, 31 Jan 2024 08:51:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 08:51:08 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 31 Jan 2024 02:51:03 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 3/6] cpufreq:amd-pstate: initialize nominal_freq of each cpudata
Date: Wed, 31 Jan 2024 16:50:18 +0800
Message-ID: <5d5822a829045c02a37d6dac81756be1312a1ac5.1706690577.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706690577.git.perry.yuan@amd.com>
References: <cover.1706690577.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|CH2PR12MB4101:EE_
X-MS-Office365-Filtering-Correlation-Id: 154cad0d-7b85-452e-a42b-08dc2239c465
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M2nILeE9lfp7zS5necQVp5B5TjPMO8h0AxFTRSUmd7G4T0KM4FtjAev2jovhMTwFwud2sHjU0dcTnt3J26wEBsx6iahvOKGGcEUeJ3rGoDtZcnygHDvhoZf3xNhkk7rSZjMPgYABo3XOV1UEPI+Y/l6q0ZC6iY2j63L9xd2mt8+WkNmv9XKkNJ/FhdVtaxIu8SZGqC/0ieTHD6xf2cwASei8/tZmm4vyocBmvcxD8/ynOpr9lsALEFaARkhAQuyhQM8XMmBeNmNNVoDI9cnj0QtjQ2BZxHgL3d6g19ANArYPp1xNlPLeNqin8SEov9bUFvXIWC4EqheOfy1YGrbAg4tjSLfBf28Pp6qJea1vz0ezQODVzdK1Ppe2p5EswbSLacHiAcQEgFXhkuM+c+WR9TSBROUXTDcrnSjo+WClA5KoT5l3AgHw1FY/r9fzOe6lIvqyVYFQUsXDjnOy2ate5zgM+s1q6IzabGWxWnZbpckbYe9dvzhmtlemYIzoOrS/vDG3pDGa9sKLcx6NJTmbJ1SLNSKSEk4moTDBcNgeuMdo9q31152UtDD1cKcle4KZKOlv2caHcEidrKqkG8oGGe90uRNYTPIakxPcIWdLrCzKosRNja8B3uOMMMvOlnbr8+enZXiJKhO3C41CYoLGpzWTqizZu3rLuygpNdr89tnmHgx/ZkokMi0CoYlMfQhcKwlubipEoW/GwD4Us6Iz0p9FUiFrMguCs8coK7TcTf15H6LwP/Qe4ObNttG0RgdE+JtCr/SR1hleXt6lkK8P2A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(40470700004)(36840700001)(46966006)(426003)(16526019)(336012)(26005)(2616005)(83380400001)(478600001)(41300700001)(7696005)(6666004)(8936002)(4326008)(36756003)(8676002)(356005)(44832011)(316002)(6636002)(54906003)(40460700003)(40480700001)(36860700001)(2906002)(81166007)(70206006)(5660300002)(82740400003)(70586007)(47076005)(110136005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:51:08.2149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 154cad0d-7b85-452e-a42b-08dc2239c465
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4101

Optimizes the process of retrieving the nominal frequency by utilizing
'cpudata->nominal_freq' instead of repeatedly accessing the cppc_acpi interface.

To enhance efficiency and reduce the CPU load, shifted to using
'cpudata->nominal_freq'. It allows for the nominal frequency to be accessed
directly from the cached data in 'cpudata' of each CPU.
It will also slightly reduce the frequency change latency while using pstate
driver passive mode.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 9291a22bd3cc..db7b36afdce2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -600,7 +600,7 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
@@ -639,7 +639,7 @@ static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	nominal_freq = cppc_perf.nominal_freq;
+	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 
 	lowest_nonlinear_perf = cppc_perf.lowest_nonlinear_perf;
@@ -712,13 +712,15 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	amd_pstate_boost_init(cpudata);
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
 
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-			min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d)	\
+			value is incorrect\n",	\
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -755,7 +757,6 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
@@ -1266,12 +1267,14 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	amd_pstate_boost_init(cpudata);
 
 	min_freq = amd_get_min_freq(cpudata);
-	max_freq = amd_get_max_freq(cpudata);
 	nominal_freq = amd_get_nominal_freq(cpudata);
+	cpudata->nominal_freq = nominal_freq;
+	max_freq = amd_get_max_freq(cpudata);
 	lowest_nonlinear_freq = amd_get_lowest_nonlinear_freq(cpudata);
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-				min_freq, max_freq);
+	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq || nominal_freq == 0) {
+		dev_err(dev, "min_freq(%d) or max_freq(%d) or nominal_freq(%d)	\
+				value is incorrect\n",	\
+				min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -1284,7 +1287,6 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	/* Initial processor data capability frequencies */
 	cpudata->max_freq = max_freq;
 	cpudata->min_freq = min_freq;
-	cpudata->nominal_freq = nominal_freq;
 	cpudata->lowest_nonlinear_freq = lowest_nonlinear_freq;
 
 	policy->driver_data = cpudata;
-- 
2.34.1


