Return-Path: <linux-kernel+bounces-43964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 487BC841BA9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B48C51F27BE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7953E13;
	Tue, 30 Jan 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DcJ/7k8l"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652FC53811;
	Tue, 30 Jan 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594232; cv=fail; b=BA5s136J5C7jYNnWrN65RNQwKfKmBPMIHF2B+Q6nSbOgtcMM7ssPQw1OUM8ww2+DVTiyMCVFMtAI2RPISAEXaimUxLlaSbO2syrfqmuPzmhZvqQGphrmNMqHkVXbm6SazkeG0vMU0060WnpV+MpzhzyGImBJ5k3TgndyF3SN6gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594232; c=relaxed/simple;
	bh=a9eUX6AQ65FqSCC63RDtsYkieoasv4p8b61Gwy4hIWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=urL3/Chqt0fig5Z1+PBitKpcOMLDyxQECnbkwdoz3LYRoU6HPn8Z8PS1P5t99gZ/1xWfT85APrpRGjZvuRZaEdaqvnsmphZj7EFVAlM4s+gJDUPDjB4u37xhSVrz4/puEnjCHgzVf83Dt8zEU7A88Rxvv7YMIcrSUOp/Tq0sJzA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DcJ/7k8l; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T2fWQkFs7+51TnHaIbV0RGzjbgICUCjUIkiIPzfmCwUCNZtjWb9MtfKHEHnNFdgXn1c+lB6qQVQSBuCych4AI8Q/tgzHaD509PDlIelWzGBwBbInz3QgZ9rOlk36R4rgTgAIEGyk3e0ZS9TcOFsBOsbrZln+g4UyyTdeK2Qw/1ezN4a+tpbmKhQRC9GxkSggRxR43rYT8CjflYWE+FoRmA9vfXccB3utJOs+FlZpdszOrKzOXTqv4Y7VIGyRj3Kc79hxIxtd51345Gl13diu7LAQrMPhbweqgmcz2k7FCzja7diRZ+ziStVB+b3v/pZwl1QjKkR3TXLxUsufKR8pRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUn4qpiUjibqWARrg/Th5+gTRHvCjqaXV/07KD7RMPE=;
 b=AK/TW9iMqqutiQQqrK32JTKswFZpL7oqyAQNwYtDf/7bpvJSZF4F72JjLZGKGYviBs90FrhtbBgoPo8u1A3rCANyFORvOQJXMFKP2b48psvCn9fv+HMEK9iSv+XL2NCJ7eeEgwg82LNmzQggWlZI7RIpz2koIe2H3b3KEssBAkXoV0eCKXyl97RB/4VTpSCahC8fdK+liBRv0zMW+YUFH897F7+/WBa71O6HYDYab8VjlGo+0rP2IX2AQHC1bCnz6SY6G5y1izX1+N5SxNGqs6LQCpTIMAkDeHB9XdeWKE6grIaQgxW4uA46FIlVBUXZuIAWRQb+F1zfxx7mo/UrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUn4qpiUjibqWARrg/Th5+gTRHvCjqaXV/07KD7RMPE=;
 b=DcJ/7k8lAaGpx6sr7WVsNHwnCxe4qS5mgqGtZfYULkZdn++zv2ejURbqneROMkZcfWL5l36xv+N7dk3+PIlhf1BHU4Nu1arpcYmnsbyVo8drAZbK0H4jAAhpMSr2b2xt7mBT8YeNAFrbd0jY+0ok3Yo6mKPIZBNtRyMCZHUpNzc=
Received: from CYXPR02CA0006.namprd02.prod.outlook.com (2603:10b6:930:cf::10)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 05:57:06 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:cf:cafe::8) by CYXPR02CA0006.outlook.office365.com
 (2603:10b6:930:cf::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:57:05 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:57:02 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 5/8] tools/power x86_energy_perf_policy: add nominal and lowest nonlinear perf values showing support
Date: Tue, 30 Jan 2024 13:56:29 +0800
Message-ID: <2307c615b12b9d0063ef92b7642fa0708a6b99f9.1706592301.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706592301.git.perry.yuan@amd.com>
References: <cover.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: df1f7141-94e6-45d7-e9a6-08dc215849e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Uks1CS3B2Hb88Jjj+ZtSUCL5hqs2dzdpO2VGvOAQsyeFa9MQm7tW7oL5xAFACdLBd7gqGpQDx7UmuT+IMYlm8rKOB63iCnrZNzO4/sNDPBIvl6eo4kEDvH1yDjvljw+qu21uzrLFVZtnGSTlFcXOF1KqywCvGTY6lD+ZzHyftEIMdA6l0WahUNsflRZYvOd0Bru4+JXosFraMQ6Ij6CsJzK3pTqaW73mYixfNLkp2Z7IsrZhwKKAaVm/to5DMH/EiomY5Tbn622IpHod/lu9lKX6vQ1q7zf3voKmLa3KCXV9yStEH1b9zmC8X6B3kgylPMWXOm00aN+i4FshPyXNG6i2wBlbvmUHArOAPo9XEQhBkx6vz1rH6/RFbQ/MjBzPVtRyPoUAmogeJLnwevniTd7jB8C7LMwW/L+IfsktL3tcKjvFCt/m+vKW2DzAx3qniGj8QKsU5ud794QsgF3/8ZNgyncz1cFLqp8xNvvH2mCcXPsSereoFmf/W7/pvBlNQFNkq43ufWL1Vo5LTp26kvVA362RX8jQP0lEkaqAtaa3nKvM7fTaEzHmag5+oDRjY6N9r96vQ01hZhnEHl1Rm8Fx8mDADYgAzl2refI/zC+fFyx/FIjFY/mpXZC6eojlwoLDElcjOfkj0MSnjT45bw9+aIc4bCH7umXClwDwLshA0rcUmjG6/tbRCwGu3lR5KXslfAgfL3uS7+GyOC1y3hVI2uc4ahlWsFiUr0S7sOQEnZNfnR4qnvRMFknIyo7KKjg5eSIM2uNxst0QfnGs0A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(64100799003)(451199024)(40470700004)(46966006)(36840700001)(316002)(54906003)(110136005)(83380400001)(70586007)(86362001)(47076005)(70206006)(6636002)(478600001)(40460700003)(40480700001)(6666004)(36860700001)(82740400003)(81166007)(7696005)(426003)(336012)(16526019)(2616005)(26005)(8676002)(8936002)(4326008)(356005)(44832011)(5660300002)(2906002)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:57:05.9579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df1f7141-94e6-45d7-e9a6-08dc215849e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395

Add nominal_perf and lowest_nonlinear_perf read and print the values. It
will help user to check each core all perf values of CPPC and change the
EPP profile as need.

cpu0: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 196
cpu1: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 176
cpu2: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 201
cpu3: [AMD HWP_CAP]: low 12 lowest_non 86 nominal 121 highest 181

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../x86_energy_perf_policy/x86_energy_perf_policy.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index a08403ab219a..7bc668d22728 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -38,6 +38,8 @@ struct msr_hwp_cap {
 	unsigned char guaranteed;
 	unsigned char efficient;
 	unsigned char lowest;
+	unsigned char nominal_perf;
+	unsigned char lowest_nonlinear_perf;
 };
 
 struct msr_hwp_request {
@@ -820,8 +822,13 @@ void print_hwp_cap(int cpu, struct msr_hwp_cap *cap, char *str)
 	if (cpu != -1)
 		printf("cpu%d: ", cpu);
 
-	printf("HWP_CAP: low %d eff %d guar %d high %d\n",
-		cap->lowest, cap->efficient, cap->guaranteed, cap->highest);
+	if (genuine_intel) {
+		printf("HWP_CAP: low %d eff %d guar %d high %d\n",
+			cap->lowest, cap->efficient, cap->guaranteed, cap->highest);
+	} else if (authentic_amd) {
+		printf("[AMD HWP_CAP]: low %d lowest_non %d nominal %d highest %d\n\n",
+			cap->lowest, cap->lowest_nonlinear_perf, cap->nominal_perf, cap->highest);
+	}
 }
 void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
 {
@@ -840,6 +847,8 @@ void read_hwp_cap(int cpu, struct msr_hwp_cap *cap, unsigned int msr_offset)
 			errx(-1, "failed to get msr with return %d", ret);
 		cap->highest = msr_perf_2_ratio(AMD_CPPC_HIGHEST_PERF(msr));
 		cap->lowest = msr_perf_2_ratio(AMD_CPPC_LOWEST_PERF(msr));
+		cap->nominal_perf = msr_perf_2_ratio(AMD_CPPC_NOMINAL_PERF(msr));
+		cap->lowest_nonlinear_perf = msr_perf_2_ratio(AMD_CPPC_LOWNONLIN_PERF(msr));
 	}
 }
 
-- 
2.34.1


