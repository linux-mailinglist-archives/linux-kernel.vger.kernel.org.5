Return-Path: <linux-kernel+bounces-107242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E3087F9DD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF9B28305D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EB37E11C;
	Tue, 19 Mar 2024 08:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g3blV9rU"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5806F7E0FB;
	Tue, 19 Mar 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836966; cv=fail; b=lUUyJzTgMv9+e8BUZYPE3JKFtjAOhs3X6+R9aBMW4vYN/RBHO2Z06qUy1ANAo312AjG6utRhXVmWwcz2r7EfhQRsTfSfBdFEj/yP+jmSX14u23fjUmaTjk9OHVan+rnWKkQKRfTjlHjCA6KEyezR3vShoC0uYDvsxUWGFsnXunU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836966; c=relaxed/simple;
	bh=3H6EIOerWdW7SIzsLkKc3x5YT4eoaZVfOp39Oh/T5tM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KmGATd0CnIhyh32ix0Y8inKtvJQxOP4ioTtzDnlN+i4oG1LLGKYeMorwHbz6QfulvK/n+9/aXsctV6YK+23rTq/pUttRd+pV/5k65RuF4ViZNi8bV69/RFAvxE2ohZgJ4qIaG6lq+1UTuvYThKl2gMHtlRr5IhP+NjxEFWidTzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g3blV9rU; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RezqcnBmbGhYe1KK/CxpCidttwflzBkBnH6FhmVvp3BUo8cKrG0hOasc6iYhp+GYkBzIn6P4tFUOBQ8p90g+oTtqiT26hjR5Qc1iGluv3/B5Ip33xbIdeVHulhVNmPysFwKIA7ftG96WcR8ZC4WmxqYS9fq25qUv9YbbNrQ8OHlmLelerxJxnhZVmreKFU7Fp2+d8GxU5Kw2Yubx6n0qqZJkAqODymQrEzOGiM8L6z7o0dHpCyGt/qG9WljzDwWHpQTjpCQxzNlKLg1CIvtFX0g0VLS/S250KjlUSdWvGYx1dkgtXkfkjIqwcmfxi4/KBB8wCNPAzYXJ8GbmPiEW8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akg66VxiKSozXs5N7b4vfJ8+iUO7jA9oCp1+SbotMb4=;
 b=ZepXZPJUZIfYsVYZNG+26dTiCWdUJ9z543CuHxsx0Gpl6WPYuVDZAPNZUXswgQ+xkbwrbBJo7MsTCssFBhweV9nrNKWKbVLyOF4EjqSsMC4QMeaPH8ZYWtGihtPb6lGuzV2BYu6PARp77KG6oBkrnquc3vw052VEsr6YtqeAoW0S/VK915ER00/zyCSCZab8cicLDwGs8/scfEO7Mr+VsPNIv+j3uIB9C55nJFSOiVAsJpmvwvkrhgQgdTPyrxobRvA+cITdMg5MOXKxlS76uCDlOKPSjYaG+eQJioGHQuiHukGB8MLfaDEktjVqjkWgvE0gVJy3gyn6BCxByMvk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akg66VxiKSozXs5N7b4vfJ8+iUO7jA9oCp1+SbotMb4=;
 b=g3blV9rUW263O3karWlm3c6WurMBJlwuqnePICKGefJPb9JGX3RvvfHGXLqGxnae7yqz5+Bcf7bxb28jqiWVFVq6ZRbc1CmsXeE3mBEViL0GZ6xBQSKglOPvOS5FgQq+Inp1R2zw1Dqg6WQEMG6iAfLVPQit/A04Kg0vVC9V0V4=
Received: from BYAPR08CA0067.namprd08.prod.outlook.com (2603:10b6:a03:117::44)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Tue, 19 Mar
 2024 08:29:21 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::5a) by BYAPR08CA0067.outlook.office365.com
 (2603:10b6:a03:117::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 19 Mar 2024 08:29:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:29:21 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 03:29:17 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 5/8] cpufreq: amd-pstate: Bail out if min/max/nominal_freq is 0
Date: Tue, 19 Mar 2024 16:28:40 +0800
Message-ID: <884cab991815707eb10b720e6f72978cbb5e54f6.1710836407.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 5158945a-b3d5-4df9-7992-08dc47eead58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/iyVT1pLe6UfGT+vO3DSRSozLGRKgHpMY78UmEHzwm+em4/BzPSejW7sBQge3C0b5tcu9xtb93OXvDQmbLrZbdmmvM17RYzLqSgMTVPBkylELWFCEw9nIEa1T2S0CJN2yQbZZik3al3xJdN4TMCeQ5E8ebtrn+bldKK1NGWfGlNXGZmva4+RDIRMtqYzf5cW5ld9ZuuMnoMOxSmdY7KDUSoYlHIC5dJ3Pl3OXJfRZySq2OGpAECMuzCbxmCzYIBBN22XL5hgzQDwtrHhaBtaW1W+cYP5WEO3Z/Dm0ODoLstQl2cT3SaD99R3gmJ9APO1deAn6IpNm3x3b3ibNQfv7T2WfjICHtqKldFtWmvoaaP3JPTp5xvksbyWa/LQJN8vHXeIYwhrY/VdqLANuwlO2tWustp9DRtREBs7at0tR5FVn7VGkFGkRXrFwmgbXuj/oIWyZxRN1Tj8PvTCgMfJymNJgOwWyDq9gzh18QuPFa5AL3uRAB7aN/PIXOzUt/EB3SArY22C1lCEs362QcSWKuXQ1BjV1JmrRa/ZDV7V4Qt77k939cw5pAd/zAIl5KKMyrlSC+F1IV5Uxmz5MA885O1TusUd2Nx3KWky/3990ftG2cZW7P37sO87i404QN5hinfk+laLFZc+skjT+jEo0EfB7cQRYo9DBvj4exltMnHmD2D4MoEmWm0hoLfHIDYSSXzpizeegKkuamsU8Fb7CeV5wdZeSbAEk9TPw8ZLVuNqv0ICmJ5GgRPIy8uqXwby
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:29:21.4562
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5158945a-b3d5-4df9-7992-08dc47eead58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710

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


