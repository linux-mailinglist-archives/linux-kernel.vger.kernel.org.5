Return-Path: <linux-kernel+bounces-49517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57133846B5E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B9E1F29384
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C636D612EF;
	Fri,  2 Feb 2024 08:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="drQY58MO"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2056.outbound.protection.outlook.com [40.107.94.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADB860ED0;
	Fri,  2 Feb 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706864186; cv=fail; b=feba7NN2JeVPljhqQsEsgdoQ13g1ZKpSvEYozwp8AP6uDrhS4RidXlUDsu/vFQqRWmkJxtFuzCqpHtwYQG4inekp5qm031yBLmK9XBNS5y/WWVedJBQ5h4QU78ShGLzR3N8ZVkRBjDA/wgO+Dx4yCMTV4LgLT0MuTyb13wZ7Q1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706864186; c=relaxed/simple;
	bh=a7HUM9GDkpRgPggDObzXxL1tRHl/EW7CtZAkMKBnLBw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YlWamgbhxtb2EIz+FHEJlHmfS7PIffQrZvZyySzGFVZn93sW8Nhdh+4HK/ix/ag3a9K8uubYJXMLEqmddTUB6xwIpJvT0wTFa5tS4GnVjP4odC+RDmWpXFnldiveSfHh+3XsMaqPMazwDrRXTwJf1BXtvGRmZAqJ8KwDXDaeXNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=drQY58MO; arc=fail smtp.client-ip=40.107.94.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CRszPPRfBPokWBYme4MdN9zWFmQYezcvffqhZPiENjoLrWfUB18sVjP8Tz7Q+c/0YjlOAnZ/ZlzqseaIkRfmZHbURRtJP7KzjKveckZ5WCGZ+sJACVO95AeNgimlX69yEstx3CszLnDBqBIqTftODlNUoTYNMCDwUHT7HCrIGEBaRQ7VG20sdxcLeUgTRo7GINNcl+v3BYgBW9mFcY1oSJzYBj3rhVfcQMmbbXxAnZyhUE0hkNuZSeXu2nzDcYud5qF/kadwbMDn9TmptY5TMpEjs7s2VJ/ET2pIVXYQDIRyVP0YweHbclU/PUDdf9HaaMiMyM2kjl+c1URM+wKebg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=Af3EIxxUrmhhUC8csQwdAcDdSvj5IUetqLY7CNIh5sAkn7dp03U4YZLz7VXpi7kRsMRX4VsaCD55uJ5x/TDo/0BgPVVjn3ipNPnAM47S0O+bpDzoxvA5kI8XG9ih1bJpSsVjZ7vX3vC5+Q+ZzlXkv4qDblD1GmpBSMr7ACAuXUJBjKWL7ZHW1T8fNEUTBHZGkcC7S7DmaJ4fflTyWXdK2KHqTPKlMgkc8KJYaw89y07hy1cKFHxMl+jDVN/HEoc9cTuEbX/WhSw93TalCq4UlK6rhWkwfa4V9lkmzI/3FN5NJeTAm6Iu6nS/gP6+ELk12TTzj8HnV7n7gs+tIuiCIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wFgA1+hhdAvzSZ0OZkDcArmwSqv0z4KqbobNxKdpI6o=;
 b=drQY58MOgyqqsTIgZSEs4cxWjaWxPZlN7vSPqwdVCHMQ/VvoQvQWAxEufgCKrntLBPQcAY5LtQhwtDAUH/bjYS4UcK9DNEQEPBP7PL7qQhivsRDDnHp0G7wt+ePJKynrWxHzMdWL7kWiRjI/4cZWPWn04L0cssC9aWwOhjVSf9E=
Received: from DM6PR11CA0047.namprd11.prod.outlook.com (2603:10b6:5:14c::24)
 by PH7PR12MB8777.namprd12.prod.outlook.com (2603:10b6:510:26b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Fri, 2 Feb
 2024 08:56:22 +0000
Received: from CY4PEPF0000E9DC.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::e1) by DM6PR11CA0047.outlook.office365.com
 (2603:10b6:5:14c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Fri, 2 Feb 2024 08:56:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DC.mail.protection.outlook.com (10.167.241.82) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 2 Feb 2024 08:56:20 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 2 Feb 2024 02:56:16 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] cpufreq:amd-pstate: fix the nominal freq value set
Date: Fri, 2 Feb 2024 16:55:34 +0800
Message-ID: <ebbe3741501a31b1ffcea208393cdd8929df6455.1706863981.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706863981.git.perry.yuan@amd.com>
References: <cover.1706863981.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DC:EE_|PH7PR12MB8777:EE_
X-MS-Office365-Filtering-Correlation-Id: 92186082-0e4e-45ea-f248-08dc23ccd312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jdAvmcxVUIoJhWXDkIkE+z37kj7ra/fFEKX+b49uL9aEXHgU91T27Efs0pIMNOKdUVuvOHl5a7NREgef7651driBDi283WTWLGBQKih+MUr01sObXAR1KlOVcogSDaQ2AWPpp/IsL7t13rIRm19Z2nSsAucUyndh+7B/w0ik6BPsFNer0NS+XgDtH0RE0YPPABF30uqvVtMSBtFDmMvYV7p2BqbqaYU798mM4MJRBTeK8E9vmOAi/9g0plpedjDIfOxcj8h1lzzZc3Pp/GWWGqLpFk3xqR9I34TOTqndNbVoXGF1yvVzDCD+aa/fAj4ay9/DU1Kn4CTVwCpO6VS+BPlAl2t1h7b23fzHjgWpc+6OYX6CFSBm9nevtvgpukMfaBqtavWgh+JOG3X6u/ChG0hcOfAR7r0dJ/WkSSK/ai8jXGtzc9nRg4b0AzU18dthdOEP2j94qsePt0abS4bSef7Oj5J2Hg7dihknVtI/iULwaFQ5/LAedyCZVXLthwxUIPeMYPHYZDCwTyoJsJ55M7NQD3G2DY7BCqA30BtD7EUPqWyOPAHhf74PKy/v/vGCu6rA6Wq5ZvZgC6IkDZSATytephB6jrQcqKrvTg3faqNTpZdslutjI/QYhIS4GP9TSu5d6T28e5dw/PyKTAv6vtL6X7sQYc2BBKo0nT/wnh0RuNDO2+H+BaFv9uLKwoB4PvqNLtNOdLbKPvilsJBTSU+pOhTfyMq1vnLKEs34FymnCFqyghUBPYTP1/479Sj9tLa107p6mH5uYXUy2uQLtg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(41300700001)(83380400001)(86362001)(36756003)(81166007)(336012)(36860700001)(26005)(356005)(44832011)(16526019)(82740400003)(47076005)(426003)(2616005)(7696005)(70206006)(6666004)(54906003)(110136005)(2906002)(316002)(478600001)(4326008)(8936002)(70586007)(5660300002)(6636002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 08:56:20.0365
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92186082-0e4e-45ea-f248-08dc23ccd312
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8777

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


