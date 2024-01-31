Return-Path: <linux-kernel+bounces-46062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36AF08439E7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1721283463
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D24204B;
	Wed, 31 Jan 2024 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H2d4CZ1w"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1807318D;
	Wed, 31 Jan 2024 08:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691070; cv=fail; b=pz0wdKXVFymL3bX7aBphm7L8F7A2JYvUdW2oxvmIKGGf5AF/De44LGsKonVmupgaxZ9jS+lZlN+XHHsdn8IuT6nvXdNicbPFFl2T0mb4bUcHQShMD+emNoQd5/J2XIbzznXXuPzP+hlgjjmkBhIxuCVmyrkGITb4ORVZGoRzMEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691070; c=relaxed/simple;
	bh=44rngs5iZsvjSQEh0dhCn3fRVuj8p+Hd1+zCJaDd24Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9B4bZdVMTzxIj2dvy2HvwefMkatmg2+wK1aK/uLJRWtKwlXkR6rEn1AjnIbfShGKZmOcXMebLrEJ8Zo3hN6djiRQdmvSFdRyvYZSvdIfbBM4iIMY/CKLrP8BsBWCeevyI7AbBno6YvVzDL0eNIZZTlf8oe21/Lg36RaPBitPDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H2d4CZ1w; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMC5yULxZpqwDjF5DbFHlBxu6+pzvB3pP7d0Xq6ZKCdmVlfLws/L+OMP7iizNYb/Y8EGDH7X36jhqQxJcUKOgG1GepiG0NThJXDonRHBSwUq1E7q8v6zLyGpc1Gri+k6F3kUJyDw0LGmh5Rubfy9vKX/icqlWG/Hy0nks4ri23mhpRvDeKHJcvfxXq6VGJ15/YXgmgLnREz6Zcf8Nb31YPcBcxL3AU/brhDYqNRPqipry2n7jZI0VnHPYgSajUrLG+u3U5u8+qMC2RhzSakdbdBAaBa9j93WjYLSsb0cI7X2l+9cREKbWfv/ZzdlHWReUUkLNFKDrmHN2d4bbd6MYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GlWcKhPdJCtE/SvyranuO5biiYCP77G4HOrJa2+XCQ=;
 b=OGLbQupP6R/rouZXToCxzyquveqLuuMpmgPisZsHZOb1bhfxvS7ibSDEIA3sLyzBVJ6fo35TDUlq9kH0/Z6ycZ3bnqEObBq7wKkSbJ5l1kNVVXrqEnRwB8SZxnUPxIc/nGLREp6XjKcmuIygZdClT7BHa+Ntr0xrgmsSIUBs6LggZaSItVMWRpT68R4WZz1XMBdyBrgK+7eMSxvfurbp8jJW8UiozPguAkuSAQkRDS3Y4LVizWAtigM/R8Dzes/QpIkRqci3IGAAyiLeiEZed2jaV0HR+Y08IlY6WEtu2qFcpselI96f3zL87cexSYcgFOhW9K+BEoDRAe9QxL52yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GlWcKhPdJCtE/SvyranuO5biiYCP77G4HOrJa2+XCQ=;
 b=H2d4CZ1wb9YJj5hxwwLx9B7J5g3aH/vynUExPfniS+oKDDa29vaq1Dlrh0ProV41UDA7cm7c098TVQ899Z7KyCNymjuJI07x3XX46wdJ7C4+DmdFMI97nHPlGVk60BKQHfbPxg9AmlmovrSOZAOExWaM0E0STlW2cSzAlG1VSP0=
Received: from DM6PR07CA0121.namprd07.prod.outlook.com (2603:10b6:5:330::33)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 08:51:04 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::fd) by DM6PR07CA0121.outlook.office365.com
 (2603:10b6:5:330::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 08:51:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 31 Jan 2024 08:51:03 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 31 Jan 2024 02:50:39 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Date: Wed, 31 Jan 2024 16:50:17 +0800
Message-ID: <0c7a38077a19e5055926947ea6ed64bfb7686345.1706690577.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f8485f-377b-4213-adc8-08dc2239c1c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rgn68NBNzb3FNEKKyLRBxxADYoc/N9tx4awGhx3uFjjVrhWpQyDkcCpYpXdEQf/KFMNk1kQsYldlzyb1bI8zCa6onfpxGZmPQFXPK7oYRYdMQhypNo7FXTh5wG43GmT2ZEyhSoG7GnYes7gbQ31chJeWDzebt7G4HDZX1PLSiFAcSIuvHKhc10kxWBPstuI1HuXIR9QtoZfib9CX58k1QGfzNrLPWTEfnDaiWVLJgRmJx1RuqOvM87iY5yAUuBZG+nswYeEuFoRTCKI5gh7fT3F3O+6ciV/Z/wL5lftymEG7TcBEJ6Jai28kUrbsy3xgNhUDA0fk5WLt/SWGMDwH9Uzz6vIRc+b+qxEpi2uPn0ANrqHGL5RpTd+TBTAqRqqFiLD7kSleAXPt/xKZa/XYIUyiCjobIBjnmizCCtVOKt6R+Z4hw2aXEUv17XuyKn3Eq2eiWcIsxISVwsIMeeHYHLbyXYKzaMmM4Et3GEGxSH5Aeng/EwmjthnBzlQgHjQIdAjVFWqT+LWBCugoZGuX6cb+RnRei0729CC0uTWXg5fBOY9y29xk+pUE3PrSigjOSfhoK04ZVKwbNVjmSMZa79EZ3eGqwfPDLrdIrF+n43t3vfm9xJ/3S15Q6058vB9OLiarKt7YZ464jwFo/T/mjGmALM+ktJyXYxq7sEZG6GJ0Jm12CTRTQrr6W2mXx7OZGVYsfmn7SxALenbwp2h+9hwCKXd4DnRopbx9a3GtP29TBSv8SKvyX2nja0V+PECTF79Vyrly+z8OW+CdXg9KxA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(136003)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(70586007)(110136005)(40480700001)(40460700003)(2906002)(4744005)(5660300002)(44832011)(316002)(6636002)(47076005)(8936002)(70206006)(54906003)(4326008)(8676002)(478600001)(356005)(36756003)(82740400003)(86362001)(81166007)(16526019)(36860700001)(426003)(336012)(26005)(6666004)(2616005)(41300700001)(7696005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 08:51:03.8243
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f8485f-377b-4213-adc8-08dc2239c1c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434

Address an untested error where the nominal_freq was returned in KHz
instead of the correct MHz units, this oversight led to a wrong
nominal_freq set and resued, it will cause the max frequency of core to
be initialized with a wrong frequency value.

Cc: stable@vger.kernel.org
Fixes: ec437d71db7 ("cpufreq: amd-pstate: Introduce a new AMD P-State driver to support future processors")
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 2f8656f75a1d..9291a22bd3cc 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -625,8 +625,7 @@ static int amd_get_nominal_freq(struct amd_cpudata *cpudata)
 	if (ret)
 		return ret;
 
-	/* Switch to khz */
-	return cppc_perf.nominal_freq * 1000;
+	return cppc_perf.nominal_freq;
 }
 
 static int amd_get_lowest_nonlinear_freq(struct amd_cpudata *cpudata)
-- 
2.34.1


