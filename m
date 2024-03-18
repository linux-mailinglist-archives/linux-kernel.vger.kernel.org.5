Return-Path: <linux-kernel+bounces-105912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D0787E64E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E44221C20DBF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41D72D05F;
	Mon, 18 Mar 2024 09:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UaaAMIxN"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C7D381A1;
	Mon, 18 Mar 2024 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755354; cv=fail; b=XcVOsfM9dsnbhHMx4ynIooSVWFvJjFoXDM2C7h+fQnfthwK/WGem9fLWN0eVroln6hVQJoY2d9oyEGEbfFjKZnaVeI511daKFDHirqBiV2THWejdsitCd7TPz3xlpA4SkdzAWiVo3DsO5wo66E/ZHUz6Ud6ZVj9Nvq6zOHij6a4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755354; c=relaxed/simple;
	bh=3H6EIOerWdW7SIzsLkKc3x5YT4eoaZVfOp39Oh/T5tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImlGodDTUb9wq2wQhKOhUrtIG3FB+MGCBq1dhHV/8bs5dlDPBKPFO1yMzQYgS//q3DHR8UI6fAouxDpbaVdpeLgiJZ5bpJ/IzHW9KnRbiT5iMXJkwhKxM6aJFxa+pwx7+8C2vTDwJELuTTdXpAK/wH564dpmTugkxNX1hVPy/dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UaaAMIxN; arc=fail smtp.client-ip=40.107.93.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY2oVNCHAKfVVG08lpxiry99FpN14Pm0frGxvMHft3VHmg54MOebQ+dGKo8iKZhPa43n1PsjN1kiuLLHuIFoTpwMo3q/IAV7pVasl4p/k1Uc1dkmKeH6BY3+E2wl4MORnb2hrpCL4sJXLWl9OrAftyHjgp/Eil5jhKkXe2eBJHDsdLB/pTFE35eiKdpzmb7O1pESts3hAnGAna+g/FrRy6OhKySMvBxlFRrLpRk9ccS3DPQLaYYJcT3tvkxM1lgvWRQK5otSqdXonduBVbWYAmCQgTQ0YdTDOUk5ieSWiFU4ky92Fp5j7PtO0HKDnbzMCWbpO/6A5VucBiF3ze7EaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akg66VxiKSozXs5N7b4vfJ8+iUO7jA9oCp1+SbotMb4=;
 b=N5fFDtclvnW1O230DW7xadlIFgrm3TRfNdbfhnRB7RHX2fhN8xMf6m3Yxm2Jn84DSxwAD/2tSvZPS7tJXG2Sk8U1YPEqiCtfHolygZVXM3RSkbsQHxoRaTpZVjYhRiGXA18TgRMmkOnTNs6nh9UCaqL0q04zc1V7QH/6+NYDdjg9+5ADY+HTJPv2zzrXW7+pKxuMe2Ylpx174XaeOHLer9o/V7KF3Z4QHpCwyhdknacf7tdmLr2IsnUXZ7SxExYYxcbz7R/9ylo3d6Wg3HDplN1obNkE4I7QR0qEOHwPiNT/VVttOFj+d6TP70p5hMxSOeSFVBUfXwoLYkygrX3kng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akg66VxiKSozXs5N7b4vfJ8+iUO7jA9oCp1+SbotMb4=;
 b=UaaAMIxNVyqRXTEw7ATwx4lHcRN5MsN3bsxzPRFayEsLoDdIkCsvUUGFvJd0VJVQlyZiIkScxYOt0YZnvtfadmd2r+rGxQhqP865S8JpNTyqs12CTGWCJabXiQ0x/WUOCkMNaSJTl5oKjVL0kI5FhQSHX/ltYTmUC4VmDyf3NfE=
Received: from SA9PR10CA0003.namprd10.prod.outlook.com (2603:10b6:806:a7::8)
 by LV8PR12MB9334.namprd12.prod.outlook.com (2603:10b6:408:20b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:49:10 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:a7:cafe::6b) by SA9PR10CA0003.outlook.office365.com
 (2603:10b6:806:a7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 09:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:49:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:49:03 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 5/8] cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
Date: Mon, 18 Mar 2024 17:48:24 +0800
Message-ID: <75c1584f93abc52ba4adc7894ccc7f8f9ca721c2.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|LV8PR12MB9334:EE_
X-MS-Office365-Filtering-Correlation-Id: 92a86aa9-6091-4de5-929e-08dc4730a8e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SvEHQstOOxYysuNpfpLrBZ+Ox1+eWGcBrO56ebooHfFbaFsXGgwTgVgH8qELxMdK8leRCGFW+DS/a9s78kT/8l4gNPWWu/u6YR46S9Y1cUup1SBV6bFjCnRH09a8qm1thobrMOlw1NsRanGwxNs3aixxyk0L6xmyQ47ZbdCdOszdJeZOPsLwU63wIq3+s4OvV5lGmE6lSmZq41W8wFyxccOqqp3FCj6KqU75R4bUq5LoBEjv9pEHokyf97DXgBiYIG7mZzEn8QKYckgJiM1F/kxlL/GxrVqxO9fnzL/P1UQ1qbdjBt/Mu4fnRkSZ6tfRu96QTu7Whl0d25EjLf/RB0Zc0SlfUw+eqFp3tVoQ3Ps3f4RqhHM181GC0TymtlDMOHWBkK9YZEQcR1Af48NqWLlIJn/FDab5h+piFnqtkUOpqsR5KpSxSISBw7LbCXtni50ZJQHYBvg8s3taL3KSb2AMYDa11BVXK7D5ZC6gDQBvZD2WfgIr6eRNT0hsGQd9B9eZAaCVq2J8EcHbmZEllLH+K56ImHK3lWlNmstGj9Wgcg6vCaGqFgnmeOHcNK5PT/wFuPvuoSI81khdxA9vlDIFRiSWRDer+eJ4rnqMBf5y4rjGuwci3o6gkHLr2e+oCWv3Yt7Svm+KGep3jTz+yJMdDZrmm5Vzhixnxgm+EUT+QqEQWRBM9BKuUWUOuHZUsGz+eL08VCNjfpdPCMaNRxi3Swd8ecz/GrRA1CK4si8rvCgixOpvA/u+Md/Ql9tl
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:49:09.6631
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92a86aa9-6091-4de5-929e-08dc4730a8e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9334

The amd-pstate driver cannot work when the min_freq, nominal_freq or
the max_freq is zero. When this happens it is prudent to error out
early on rather than waiting failing at the time of the governor
initialization.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 132330b4942f..6708c436e1a2 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -839,9 +839,11 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
 
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-			min_freq, max_freq);
+	if (min_freq <= 0 || max_freq <= 0 ||
+	    nominal_freq <= 0 || min_freq > max_freq) {
+		dev_err(dev,
+			"min_freq(%d) or max_freq(%d) or nominal_freq (%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
@@ -1299,9 +1301,11 @@ static int amd_pstate_epp_cpu_init(struct cpufreq_policy *policy)
 	max_freq = READ_ONCE(cpudata->max_freq);
 	nominal_freq = READ_ONCE(cpudata->nominal_freq);
 	lowest_nonlinear_freq = READ_ONCE(cpudata->lowest_nonlinear_freq);
-	if (min_freq < 0 || max_freq < 0 || min_freq > max_freq) {
-		dev_err(dev, "min_freq(%d) or max_freq(%d) value is incorrect\n",
-				min_freq, max_freq);
+	if (min_freq <= 0 || max_freq <= 0 ||
+	    nominal_freq <= 0 || min_freq > max_freq) {
+		dev_err(dev,
+			"min_freq(%d) or max_freq(%d) or nominal_freq(%d) value is incorrect\n",
+			min_freq, max_freq, nominal_freq);
 		ret = -EINVAL;
 		goto free_cpudata1;
 	}
-- 
2.34.1


