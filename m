Return-Path: <linux-kernel+bounces-54312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A5384AD93
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFF13B24C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EF97C0B6;
	Tue,  6 Feb 2024 04:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XzZx1I3i"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D017A736;
	Tue,  6 Feb 2024 04:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707194106; cv=fail; b=fw7uFfcJVTm3/RyjfnnrWB3iHzSWmuOlIqJcEHwLpaj8u521jdUJByL6qAPK0No0Mymo7tiaj6OoOocuJE0ZBzk+D4QbRHScraMP/1Ipx0lUFVIS6D4OdjRl0nPlKUPFMw+tUOY/xdtIeS4IQU1cOzRfiJztpP2LzDD+NEWiCdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707194106; c=relaxed/simple;
	bh=a7HUM9GDkpRgPggDObzXxL1tRHl/EW7CtZAkMKBnLBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NZOmnia32+PSoxO5oTaAbZHGNsy2Psd10SvJoiWrmaXArNdgphkqnPIOSjm7O2kKptg9lyyDQUWu27hw8sDaPEcHHjttdo3zDYffDJWlr5FhjEUu84SNQUgrEahak1xIjrvztgASXytktYX/YhdLD5Ga1TTU0f1G3UFcubNZa2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XzZx1I3i; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AaGiQDuOMGWTFYDPI+vBVT/kJKyQXBME+rD6TwjuhA9nYPnH8PI0BkxXy6rm5jwJkJ1rzHezdzXgtjWuhBex0N9Z0RwQzrV4M12X3hI1bcEyGYpx2g8cmmbzMAVcHiD5yqW5D/KjbAJUBkRJ2hF1km5JmxuiM7y3fA1o+ITXoO7m+rEtQ4HlX+vzQaoHnpL8dn4U5O5fNHqeYuNz1SU2zo+PJS4FSmYjDIlp0Aebl/ErO3lRMjq3+F1e8DgqlxMXNOXgoUHZgbbULoQYRABwvkEB82u55kjGTeqol7Jz92Y+j7n8GTMXTq4hF1cMXfhz/Nq3Hj7sL4xpNk4jnV4diw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=CyUqpA/x30AGKY7JJfL2IwUEVpPvX9+J8ObCftPOeFLA9ILKaVYJClSmEQVzznuszxXKmNw3H/gnxs7IMIDPnm6xMMkn4ahhDiIsGZicF1DZHR7ZRqOsxMwlNM19TlXbx+8M+Cb1kTKtzbqOPvgPjyEEfLdmooiIORkPIoWx1Xjlz7QnsUW/Ty37Ll7xKdb+Vx+EAr9Rr4iKwkQXeB2WZPPS62DNbU6IHiVZGCAUw8rL8YyO0iCC2ZIradGW3ezbIClOK/0WdEMgso0wx8kYHh82S+LkEIXvw5fKCfVh+SurN2mjfXksXSp7qFH9G4XyLsmxf1Ef7xzbmYthzdPiEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=XzZx1I3iRiyF61wIURd++Q4oWbo4x3Y/tH2yapB5kyntOqM243E4I4jZE3rmjNdpd8a1pDAYaqvhYxLiXgmM4YST+Fc6xf604/LG7RFMraSAt1ub+KVaiUVXzUiR06awjrLGQhJzBU/ywjS/e0yOhh1VU0q/nTsYdy6fNxw1tH4=
Received: from BN9PR03CA0280.namprd03.prod.outlook.com (2603:10b6:408:f5::15)
 by PH8PR12MB7327.namprd12.prod.outlook.com (2603:10b6:510:215::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Tue, 6 Feb
 2024 04:35:00 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::e5) by BN9PR03CA0280.outlook.office365.com
 (2603:10b6:408:f5::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 04:35:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 04:35:00 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 5 Feb 2024 22:34:49 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Date: Tue, 6 Feb 2024 12:33:55 +0800
Message-ID: <ebbe3741501a31b1ffcea208393cdd8929df6455.1707193566.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707193566.git.perry.yuan@amd.com>
References: <cover.1707193566.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH8PR12MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: b8bde978-d09e-4aaf-c7c7-08dc26ccfab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zkHdkeW8qnHahGxo8HD3ppSzpEW9OZwjVnN5kUlpGpKBI8nW69IcgJwStTguQQNGerbYo46m9oKgdVhmhudBmMWxAF1ua/E1CJGK1anAO1ZsoeAXQhZHO1cIb8E6KPb2taJNJQHW0zUkHiZ0a7ZkkUsJPHcMgOxHrFNDectg5haZTficpkwKgKWkuudFHfNbUbLf6UAqMC2sCH0qn40nvH2yQzjA9hEn28eo5BONvY+rNPfPwxQba6lX5rKdg9EQtauBi/zgLDX20AGWWwmFQmyzGBDHSjeWsGi/pckWy5Si/tWeIhI0zaZwBVlIyZ9xVzX4eOBrhC9d+34J/LS0zQWQfbnNaYbO3fy1NE9A/YDjbb3I3JMm+fp3O3xfWNjNA7FW7jIhA/FY3945ZR60YcTC6ob3uJdC5ojUctB8qbKLH/ohlDWpcyNFECQCF7/HOuO2WW6tLGFsK9+sxMHcEariWG9QXECEHvsdJ6P+cTzRuhpX2PkwGa7sAwvegp4pVCz4xjdsN5/eaWqul6lKiOxMABYK83XUP3yiI6VNucjZdY7gUq21BQt/9u1wkfSu50bhW1MY8upLC830px+f5BVs9xMU/UU7lHAuikzUviQMwHIflAgqQjVQkxi1QZXvcus/V2jb4zriim2Lkw+NbcwG1mzmcYtF1D32iElsNllzl/YRbI3xLFHaLk+zf9cfqahJlWK/9NuXl8LJ0EW7gfKC25erXHsn3iPpVclj/ISSRKmzJJjbJ+/PbuVmP18doO09jc5Zq8FqLXmFThiCMA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(186009)(451199024)(82310400011)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(478600001)(16526019)(26005)(426003)(336012)(2906002)(2616005)(82740400003)(356005)(41300700001)(83380400001)(8936002)(54906003)(6666004)(4326008)(36860700001)(8676002)(110136005)(70206006)(6636002)(316002)(81166007)(44832011)(70586007)(7696005)(5660300002)(86362001)(47076005)(40480700001)(40460700003)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 04:35:00.0962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8bde978-d09e-4aaf-c7c7-08dc26ccfab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7327

Address an untested error where the nominal_freq was returned in KHz
instead of the correct MHz units, this oversight led to a wrong
nominal_freq set and resued, it will cause the max frequency of core to
be initialized with a wrong frequency value.

Cc: stable@vger.kernel.org
Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 08e112444c27..ac7faa98a450 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -640,8 +640,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return cppc_perf.nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
-- 
2.34.1


