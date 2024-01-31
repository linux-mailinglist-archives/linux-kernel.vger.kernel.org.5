Return-Path: <linux-kernel+bounces-46065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B70C8439EF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2239428C827
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343FA78662;
	Wed, 31 Jan 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wejaw3Ee"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E7E76C7B;
	Wed, 31 Jan 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691078; cv=fail; b=nsLSrfv0zxEF08i5r0EMYZMoQkGNvMgDtY41niRUX30q1H9s44lU94v0Pol0c+iawmvFQnZHfCte9tUpvrRZE+Cz37piBjd4ESj48F9U+KgcaZwD86AUmYg5CRs9CvacvI0YeVjP26IH7+DA4rzVU9pGn6tiwHGgbwlG1Zkhtzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691078; c=relaxed/simple;
	bh=XAF5ce3XyZXbPU84LHOZAJVx4GebJKQKHUszBVxcnSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lI+q6bHfT5F+RAwxHHDu7tEhy3HPbsfVut43NR1p3y5/5wTvHFgukJXA78TuLW/0dkAa9m74wbUs/JoBA/1wiqlFJeTxbIjJ/REh4itkwWT0fRBHosBvfHwkbf3f+mJLJHUV4wsM0yrnIoZ415XxZNWTuccYmibffOY8MdVnnYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wejaw3Ee; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VpvKFPMEsbXvffaVsKhKGvMSG55CAEYCqtqjg7+uLezCl3HvAmAXeIAzw4p7K2eNzWvcx3192P/olq9oM3vwwx7MSqD5uW12tJ89k9SW+DrsyEuzIT5OBRJ6lozwby8tvhmmJ54Q5G2VCfaoo1xeAPD+D4/UVej7X8ymuWK0RAwiCt3tjFoDNctpzAQd8Mozhbjb2KJtcX54Sz6jfxAt+EmDzeJVtlVm0+cE83RucKyq9KAykZh2Io0xpAcjQdS7ZPFczsOQ6jKb5Grxqm1VuHo7dAuuATJGew/3KEC6rUGipuU3AyUY01DB8pSvyzzm2nPxQrH+PWaaI3Lp+2LQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCDztHek/N8FFyzqsQAe8naig66K2Nj+RfSp1kzukSU=;
 b=bh9FiH1gSjDAJgRZ5EKH1rQNx4gdV6dqkG7KqH/GLNrc+qbQcsVVM/eH2S3eUf3HV0k8FRezytd6coaDyOemPlfEmq7wwoxhhhRLJKfO3rOo1mN6KqgSWEsNL8wc23FGAR3U9v2YbAAYbG32pkcH5fTy4nDBxnAIkdZMHsIZ3IYkGRJqn2aTy5gO1QJRPShqcN0eV1HU1nNBFzX3EtftiFEif0pZ5U/CQjmZ9UI1r+lfw5qKq41iFrb8Co32Glz2uTII28+JD51D9gWenVV0TdgTZhQajE6Mn749HOE1S1dISVMIRpYSXW1T5Lw7r7IWXQ5mXxvb1nuGF5CacJkiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCDztHek/N8FFyzqsQAe8naig66K2Nj+RfSp1kzukSU=;
 b=wejaw3Ee3fEF+Qk6BhkRTLyoJGCvruAWjozcKon1DMQvzCl/L3cc+sHItOEbLvKH+04aycsRa4mNqw1VIsHAr4hYRwI2TVoppT8ZvoWKnl+8D+amqw5yGHwYfskFqcG5kA6BawNeaLICzxoLO9VXvpzHWXyz0jKON3d952VICCc=
Received: from CYXPR03CA0010.namprd03.prod.outlook.com (2603:10b6:930:d0::17)
 by LV8PR12MB9449.namprd12.prod.outlook.com (2603:10b6:408:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Wed, 31 Jan
 2024 08:51:13 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:d0:cafe::d7) by CYXPR03CA0010.outlook.office365.com
 (2603:10b6:930:d0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23 via Frontend
 Transport; Wed, 31 Jan 2024 08:51:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Wed, 31 Jan 2024 08:51:13 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 31 Jan 2024 02:51:10 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] cppc_acpi: print error message if CPPC is unsupported
Date: Wed, 31 Jan 2024 16:50:20 +0800
Message-ID: <a6c3790105fa30e89f39f0dccc7d699f5c1c30b7.1706690577.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|LV8PR12MB9449:EE_
X-MS-Office365-Filtering-Correlation-Id: 40ea7d61-070e-4319-4318-08dc2239c779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OyalqeluZdf5izcPCiMieoqyKFykZMN6A2m79a4Umt0zFqnywXxoWINV011C7ntcR8IEGQ/dqPhJbsgZ+U3kkq3l5ZLCIXuAJigW35tkW9E0WV4y+NMTjbwiqPdR5M4L8rQu9gBIOSvprK9nAVW4rAFAEfrrHBPw1pcknsrwiwUtI4xAQMKntSuACI9sylrta/dS326Q+yPzRdvjqpjaL4vv3lGn2xvogdqEAihbiwJGkdYzpd95fIgmJ5p5pRezGnDoBD1gAF6sGPTQ3CSSw+WUCev5EPS8BFI4nYnEZu+3g1CIK1hLvNKDjUDXriqYC4RVAmsoXbzEyNm5QgwQSomHiTnVV4DSVhMqg9xWK3fC0TPP0EmFmm5nT0paguegvovesqzhNQY2H7vRmhheK976TCPZk9NibVreFodnzlVWOqymjU6ehupMiOdQqu9S+ADlZhROChvMYuLs7c4VJm/om28GEDKadt9s9r5i8lRhls0rSlcgDqkqzUaI4ARKhIauNonfoiEfNJeBcF2K3i3Mt2sGEbErqFD6oVxw77N3DQ2TDzBkFjuxbSCNHt7qzWZVkpjOk7IqCc+7ANgdW8IGg1qqp3O5wWtINhOAGbS0NcIIfKQMH498ovZ3cEWGcZrq0PVYVw8muSG+Ryo23M/jh/kuXjfwCTInuNtb4XOPiYOHiYyUEzkQWD16Awq9N6CozTOKLjmwDTg9+P9uhq3BTngRpz85gWuNF+YrUMfl4kLlDjDpOugvleMYbJ6lBIYbt7DuOWxnCDH/wNd3Kw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(82310400011)(186009)(40470700004)(36840700001)(46966006)(316002)(44832011)(6636002)(356005)(2906002)(40460700003)(40480700001)(54906003)(36860700001)(8936002)(8676002)(36756003)(4326008)(15650500001)(47076005)(86362001)(110136005)(5660300002)(70206006)(81166007)(70586007)(82740400003)(83380400001)(26005)(426003)(336012)(16526019)(2616005)(6666004)(7696005)(478600001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:51:13.3767
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40ea7d61-070e-4319-4318-08dc2239c779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9449

to be more clear what is wrong with CPPC when pstate driver failed to
load which has dependency on the CPPC capabilities.

Add one more debug message to notify user if CPPC is not supported by
the CPU, then it will be easy to find out what need to fix for pstate
driver loading issue.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Above message is not clear enough to verify whether CPPC is not supported.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/acpi/cppc_acpi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 7ff269a78c20..217c11c12b57 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -676,8 +676,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu())
-			return -ENODEV;
+		if (!cpc_supported_by_cpu()) {
+				pr_debug("CPPC is not supported\n");
+				return -ENODEV;
+			}
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
-- 
2.34.1


