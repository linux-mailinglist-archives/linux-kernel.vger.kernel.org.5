Return-Path: <linux-kernel+bounces-43883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C3841A5F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C5E51F28585
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C346C38390;
	Tue, 30 Jan 2024 03:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AWlev+Rn"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD765381A2;
	Tue, 30 Jan 2024 03:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584772; cv=fail; b=uhhPtoJmQiYvcVwUXS8Yv9s66/C+/dzhLzj5+4FkTPHNgy1+hF+HM1NpY431CpaYWvpRlgmfuDxgGwFQmZ9+ya3VilDJvflftYtoggiV/tJ9Dofi1V49SzsXAssToxhicJGiWdZBZqk9Zjfj135yuM3mBDYxyVgbt1y+I1gRy98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584772; c=relaxed/simple;
	bh=a9eUX6AQ65FqSCC63RDtsYkieoasv4p8b61Gwy4hIWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzbhenPi3yEdR+CyuKQzhg7ZCJVp2X8pImrJOpTzCJ6sVbMmutbzNh9munOaNTJ4V6hMEnYuVwZaC+gGAS1ZcVYwNwrIZ2piJy1tGd//FDwWzjwZXS06E6XF8m88FGxtxEwn31EcmkvaVp9/GjXdm67xZqWQqq7v9ZlabF7Y3u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AWlev+Rn; arc=fail smtp.client-ip=40.107.93.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfZNxJaWFYchdIZV7XRQ7cXw6EI77u+JrKqmA1zvX1DwMYIDH9DwdJeNut5kgHYWU2bCCouWokml/MKBSHd+rSJ6v3HFUsx1jEJaQT1I4VkkOKn+Ad/x84MEOTeDQa3co84Y+MlVpIlTTbg7qIjJDX8yJOBymxheyXc09HUxwSp6K98S7F0tsVfCSgawT/fEqZfwFkaE2EEUobOfkIOZxwQsDh1samFbDUWHTaESuUlqWQ991hongzyhP6hK7bRrT7hBf8Xu2pv58eIpDMqRzuMgcSFYaHpR/G2aEgGlmbbUkvEDvyKPt/gru9fECJf6BBc+OhWPwkFoYNz1ELpKkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUn4qpiUjibqWARrg/Th5+gTRHvCjqaXV/07KD7RMPE=;
 b=DHbN9mBhzIYO9LhpSJHQld6J4FXzgNSJW2oxDntSRSePvKtZfS4GrUTFI+PNgWQfOkf/DjYyXtUBy70IHQan8NO7/cULc4ytF9IqpAM5k3U/oQ6HhnZWfwttiasZHsPld5WP5CWZM/rZBn6hyu5iW7Mw6f+30Nc0SxoCztzdU0NLi6L7KanOHHj+Qzprly+u5mb3s/EWethKX1Kus1/8Q0COIVJ6zaiX1dRfSAUGwV0wew/XgjsI6I+Z7YE2JZBTtMFdphAeGWAFIOo9AXQluxJqDK7kW0+mlJjiFYGxe5TTLo674Ma3goq5CslGEXXYn6fw95/5IxJua6AURMdcFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUn4qpiUjibqWARrg/Th5+gTRHvCjqaXV/07KD7RMPE=;
 b=AWlev+RnpkqCXBkaKcqgrzXWmIGdqLRIi0FyyujRnTpSOo9dCDy/BVfZYXFa+vutS8DmmE3f9e8uSt8PyY9bch/i730e+M5ptjPbjRsqPIpS/Dlmomjn9ZnKplCQ0A83puonE4MZvsFRRAO3gwUxAHalZ+DBe2i8Eeuz1fHQaAA=
Received: from DS7PR06CA0028.namprd06.prod.outlook.com (2603:10b6:8:54::33) by
 DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.33; Tue, 30 Jan 2024 03:19:28 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::18) by DS7PR06CA0028.outlook.office365.com
 (2603:10b6:8:54::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:15 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 5/8] tools/power x86_energy_perf_policy: add nominal and lowest nonlinear perf values showing support
Date: Tue, 30 Jan 2024 11:18:33 +0800
Message-ID: <31bb6289418648cdc29b175fe81a55e63c0ea64a.1706583551.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706583551.git.perry.yuan@amd.com>
References: <cover.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|DM6PR12MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b23e77-0cc6-4fa2-792e-08dc214244ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RxsKZSlNZlnBaMGdCL8f385oEUXOf3tXvripP6OLxAZ+1lM0uvA283UmSMdZEwCzyxfxMA4aznbBZKIOBkb347eSkfbQ9GNcgzC/GaoZAQ+FO3Z1691lKNjwCFMzj1PlOwuUEPgh5OTIo5Y4zVSwvY1CLW9HKoC6EAAnJTFcO+1xFs29UROPk9wrr8Kgomv1xJfIGPPyiu32Ef29WccAmEprmqr4TnDQxHVu8OH7uHN16nUmfxtwvAyXiWrL/giU/F6vwMGMvRf70KOpxcTbS/tDya7NuDz23Bj+4/imMQOtgcInpPW2AR1FIJxQl+N2vk2i/So+jqsu5GfFRo+IDpVawxXC85XKmA+4sk9EXCCLkYBbIG9ajyEQ9nj3h63fGAxKjF+f6FXHaHnldcox2a5hI8sdKfO0UtfLpFjO9/4sIt03oUVZDZxx1OpLbEyYfZelI8zPAe57sfoodKkVAQKeCfhnoRK8MPXwHDLMyhsj+1UXlOZaPzGQwhwel5ojTeOo8TEGHF6IVUwr9pQLTMs5miuuP1PpCXMwChmEfoCFe7xHw/ozX5yOndiFhkKr8UdFGhhRP83IY1xERY4f3doZ3ylRuaOS7ysHLdzM5Hn4qUhqfBdwpqPidTwYw2A4Gh4p8OOYvDM4GTGLgJ+9ldsP+dk8yILVGNT8dx0VBxV8t2kKoX9UAgfjpXshQAExA1g2BQDTZLdmbyWsYhrzW8YV0kpIzF7OBUe0k72AQ6LtQ4L2zDohwpJMDpZrdDbNLrFSffJHg0NT1Iu9IgpMLg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(82310400011)(1800799012)(186009)(451199024)(64100799003)(46966006)(40470700004)(36840700001)(47076005)(6636002)(316002)(54906003)(110136005)(70206006)(86362001)(70586007)(83380400001)(40460700003)(478600001)(6666004)(40480700001)(8936002)(81166007)(36860700001)(336012)(26005)(2616005)(7696005)(8676002)(82740400003)(16526019)(426003)(356005)(4326008)(44832011)(41300700001)(5660300002)(2906002)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:28.2320
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b23e77-0cc6-4fa2-792e-08dc214244ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4452

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


