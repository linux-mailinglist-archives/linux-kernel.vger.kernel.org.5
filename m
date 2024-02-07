Return-Path: <linux-kernel+bounces-56194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0636584C735
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 674F2B23E5C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66D624B34;
	Wed,  7 Feb 2024 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yzdNJSBx"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D32137A;
	Wed,  7 Feb 2024 09:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297764; cv=fail; b=FgzQ8KiyzGOCdBfGwvWGutlJy9X1b/E9EX+eBwemf3f0MRhSHMHLbG0axEtZnk/EIfrPBRZk6M6nvbdLT0UAVFEm6ep1tnaIZKuSE7EaveX4ZKlUrl/E64chivbNofUqDpUUm80zTBKh9HN19n31ZqFt2sMenNLefpjCUMXXvhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297764; c=relaxed/simple;
	bh=64jBJYA4Cs075/f/uPjvw/FTIdn6ik0Gs19e7wdlMOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIIyGYLPuCKsAWCRv2ZlvWpo1KYJGRDb0Z5nk3P1B7FYjN5gzkMyRDpCS1zwvNGFcfHBYPWyTMUX1dRUOngXMGHSNMnfoLvVBn7EdMHqSlnsRlkFv7MpYqquWxw7QWzIEtMIESkwQjcl42FAcEnDaubhJTgA+wTGSytahyCe8tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yzdNJSBx; arc=fail smtp.client-ip=40.107.94.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SU5AP0Bm+TaMbh9sPNer7RiCMjfcmmmkgtXiO+0hME3HB2dVGNPm/BlgAI/sQGRgma+5Uva7Lrr8+lvtnQMOZW5CmX0VIGwlsp0BlHqdt3NnGMum8AmglBdqYXq0vZM2haAYKQlyBZMMhfeSn7QvKVfkqBg4Xy5rwvWTCHr43JJCobj+ZToZCv4MzkRtbzC3V+IrvHUQaa3ARnwURfVH/9f2Zfa4FrEIGYD77vQEFV8vOm/ZaUHQ1yJTv0PW6KSKmiZxHo2At0WIoqXdj877zCLyXgbHDXL6K/xTyIUbq9sxLBfV/KelwkO8epXhrogAxbZQ4O0lbMgPuzSzy34hmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/rVk0283MxXHy0R/9Vif05RiEbfK6zC0NjlWRGWqUg=;
 b=iyXy3Jd0uEYKEeBv5UXIdUOIOysjfQwDzjuJ8djvSKZ7+IFMOQcygJncQMlXAGXVtzT2zuSBbMuN6XRR5pUi6ZO37wWzWBzT7+uVEwVyRsYVGo6/0Slk95DySRNXz81hLQe4LTFxhE6NEOtoly7re4bfyteVxKuysXzq3xx22BcXABYOLN74uzZl2iemGlkczFUkIfSgFuTmGHs4Csw7oCkgMIOUea/BjON5FDkrIHc7VTRsAkeWE2kgCPKCvXM5EybbJYiJk9keFxxFK8P1nAxUc1TbjMueI7MFwehFW/hpUMqo872j60aLRJ27oyAfGV+2iYA6iHxS5NQZCpf3Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/rVk0283MxXHy0R/9Vif05RiEbfK6zC0NjlWRGWqUg=;
 b=yzdNJSBxlXFLQNTnqSFRCemWQteMTWseWusglVfBdBZUB8+U7itBVg6H562cSNRdu/YrY+hsTFprp9J/N5qaJRI8LNP2a90tYAZ+6DUKg/F/M6+7YZJ7102c9QqlheeDZjAgaRmd2hGBz/ZL67xFWx80RzRzGRHK++3ukMBztf4=
Received: from BN9PR03CA0102.namprd03.prod.outlook.com (2603:10b6:408:fd::17)
 by CYXPR12MB9280.namprd12.prod.outlook.com (2603:10b6:930:e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 09:22:41 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::97) by BN9PR03CA0102.outlook.office365.com
 (2603:10b6:408:fd::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:41 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:38 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/7] cpufreq: amd-pstate: fix max_perf calculation for amd_get_max_freq()
Date: Wed, 7 Feb 2024 17:21:54 +0800
Message-ID: <34e61ea5f1615ee0d464197ab4f521cf8b02617d.1707297581.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707297581.git.perry.yuan@amd.com>
References: <cover.1707297581.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|CYXPR12MB9280:EE_
X-MS-Office365-Filtering-Correlation-Id: ee044cf4-6f76-4e1f-2542-08dc27be559a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UUDlskq/+lA95TKy1u58J47fQ8/MFEfg4+WbOs0HinomWpAfoN3vlZ2mGoBJbEPp5NQTL7Gm5MmZu/yrkMqRSfX+4uI088fXe11DbE7P4WB3d5d8CzD6AUCdJ158It9MLWLtA+ric7N1h5CH4byVwI1o3S+Ew7gPPi5mPZZRcISAi6F54pEd7BS0GQjcYcYWTgHP3w19Xa6nbHrXFoTuawQSCP7opPcbzY9fhDH3LX5nIrgM6Nh8CdaKGRvD8l00+T0AUFMSTvU0yFnMxJoc9aheoMQDY3DQgXlrxrinV+pYQvHQw7feVLIHNCPTQAyB+5lTx++5K//ItYItj5lPN9oSa2FJu30O6+55H6hTKBKWGY9IR41yU4t53wML0L5QvHnpMxXHUYv8BncYK7Km4ySjG09s1uOhuwVfSuSxGlyZWPzvwm4dW4VUkSdxSYkMCkWZXz3LNrWlWjSk4M7pyKo9zxZO/velTYrGl2E3l6ZmFi5vQ2/OSSymX/Z3IvapeCcm2rFCePfaikVXcl1jQFBXb4RvscA5Y14vDn09pG4R2tPt5e9/CKDf5XB/umaH6PxTjTHwL18mUxwioBChCdZ1JQ0AryePXcJVCSTB/X3jAky2S9QHpR5lrR6h0nivf5DUQvW+ZwOkpd1FUA4e8e68zGMoDcLFAtaI83yPqV9tCrtTRdEtv99hmIpNeaYrfwNmoFQvRyf61TqOqKGODrZpZQbPoJrB9ivL4sdawY2a/4K4PhIWABICH0RUViEqybz6HeCnMxcKFhp6xS4Ziw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(40470700004)(36840700001)(46966006)(83380400001)(54906003)(6636002)(82740400003)(110136005)(356005)(81166007)(16526019)(47076005)(70206006)(5660300002)(6666004)(26005)(7696005)(2906002)(2616005)(86362001)(478600001)(4744005)(4326008)(336012)(316002)(70586007)(8936002)(44832011)(8676002)(426003)(40460700003)(40480700001)(36756003)(36860700001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:41.2734
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee044cf4-6f76-4e1f-2542-08dc27be559a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9280

From: Perry Yuan <Perry.Yuan@amd.com>

When CPU core Precision Boost state changed, the max frequency will also
need to be updated according to the current boost state, if boost is
disabled now, the max perf will be limited to nominal perf values.
otherwise the max frequency will be showed wrongly.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 82b43bb2ab83..1f86ce920d6c 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -624,6 +624,10 @@ static int amd_get_max_freq(struct amd_cpudata *cpudata)
 	nominal_perf = READ_ONCE(cpudata->nominal_perf);
 	max_perf = READ_ONCE(cpudata->highest_perf);
 
+	/* when boost is off, the highest perf will be limited to nominal_perf */
+	if (!global.cpb_boost)
+		max_perf = nominal_perf;
+
 	boost_ratio = div_u64(max_perf << SCHED_CAPACITY_SHIFT,
 			      nominal_perf);
 
-- 
2.34.1


