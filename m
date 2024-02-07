Return-Path: <linux-kernel+bounces-56196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3F284C739
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83FF82873C5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43722330;
	Wed,  7 Feb 2024 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oFcMU9MP"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C8625630;
	Wed,  7 Feb 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297776; cv=fail; b=g4phJeLUpai/AHroGKWIMaswtgUfJw6iWdnymGeA+QAxmv2VAYAH//nAF4tWg/pQI3jrQUUOeZCS3vBv8GBBBeyEvIbrwWnGz3OOrckaJQvDlCytq/TW9DaKCy96hcd/5ZVvr9fVKHzr5IoG+CvzY7l/jGU9maZvY/fxZLGcgXE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297776; c=relaxed/simple;
	bh=TJFAg4I2jHFGmdAh0oRR9ZBrmJM2j6B8NgGO4bpN4jM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyUcSqzqhapqXVahvwK/p9rXKi+gC+FMgBeBBNP+iAw6YxSRmoCoJgQEZRsHfKqKj0w1Hxl034FIwI+bgghQhRIbyNsM3AY8Ajcok1Wd8V0v/n+TLQHPJuZlmUPC6DwThinaFKBMyTZN/gzKJcgNPAtT5sDrzBBuwGAQz++sBeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oFcMU9MP; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K0LZ7TVO1J/oVVgM5G+OWoG0hAVgL3ebOPkzCIFTIgl1oLFpUB3KT7BSidVDZapxrCbkaF30w8qfAjPSDBDA5pyjADJQE2V9UiVXoLkkYfdQGrJnsKbAkjdpHkchcpkIhf5fcTVlsCl/EO8Sy/bLV66tbiiEpfVn+9Im/L3LQFfOJ7AMJNIFxJSrClVobS2LZnoPuyWII7XlZZGRaYLjXxjUZayKZXJ1bAVtm5dBMMWns5czBdF/lrfFqXnbUZXSeN4PS5oIZHWsuZOK66tFjxYhpm9uwUxZXh43fiLar3gDFaM4CXak1FFHjWPqpZr1zUSuXEAyVaflTbV0FS+Qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=to88gmxh1QF8HEJXDCCFWLRhtdORll1W6Q1f49gQCBo=;
 b=N57jATBIiEiy5m9pSHT3bJFfQ366pF/f3nc7ehl5dSrOGL2AA0c3uz8+Yz4PRXhYd/OxbhYCiTKzNcrVrCeARFvky60ahzZe2KDu52vuhKGk/Vx7h6hBn5L6p53Fp0OlDpbT2rwAE4Xguz0fiHYC8EAKtIDDJNAa2cRxDKoCe0x+dlvBPCAT9bchsCuycd+g8IC+qZwuy/023fWjGgmw8LUhyGkEPpale8PkZw5dmN7SDXhrhGnM8c1j6vj4YVtgt5fbke7GZNvJ1R7zLXJbdvTjDZOeNTOn3o0uGo+XotI0J59XYxK7bXl3HDJOvtj7okAwTE/x2DZIQirlq5E2SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to88gmxh1QF8HEJXDCCFWLRhtdORll1W6Q1f49gQCBo=;
 b=oFcMU9MPbgipZgDBHFwJQVxbG3YEgRei7Q4NHpeOH/ojvxuBpvG0lA/31n+9Mx5i3/6hcRN/lBqLkelxIbrGLCLGfSHwfvSAs2v13aCQF8mIzMJbn8y1Z173XSbBpvoOM4ImtOXuFbRxeyBDYIZDA6xlSyCMFHZvKlGs8f8r5xU=
Received: from BN9PR03CA0098.namprd03.prod.outlook.com (2603:10b6:408:fd::13)
 by SN7PR12MB8433.namprd12.prod.outlook.com (2603:10b6:806:2e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 09:22:48 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:fd:cafe::ad) by BN9PR03CA0098.outlook.office365.com
 (2603:10b6:408:fd::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Wed, 7 Feb 2024 09:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 09:22:47 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 7 Feb 2024 03:22:44 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 5/7] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Wed, 7 Feb 2024 17:21:56 +0800
Message-ID: <b8e4048f2e7ec7bc9546537a208ab558da1a07b3.1707297581.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|SN7PR12MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fc4be82-c65f-4e5d-3472-08dc27be5956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	empCAzgWmz6oIuSWkD3t4QJSKCSXiTMIhuzBnR0U98GPwF0x9OVR261TZCSiPtid9ZBPIs6v5BUHlqCFUUSnzOJHvc0ThElZ8ZuqVKrbdffUgC5Z2oVBOhTCImiu91fcZhE0hrX2yPc+v355mMRfF6w8AWt8I3hFQwx7KFA4cvyPiXqapPS/hH0rjOegphIQuj/8DWzleUiTI754O2o2KQAtn1eQsyqzzABEL6PTOtBWY4+W1C4JPGP4oVX87ld0VKg3Mrx55N51RTGQ20vv/W9zuWFtskHT3dWo1kvtnwIcmR2Za3aF73RKaweFJReB8C2JXQbdz6JhpFtjaYp5ExBG1q5jI7wBuhyngTwI+56/2kMaAyKxV28IX8hEpvVkSfG2Yfgr8Epa+JTU+YWBAZYO3Uyc1/gDklXqwmJCSUdFUibIkb2gFdRykJTvPeI09jOQjOqn6qfL9PyUQYSvYrEWWqReu1SmcRTrFUGSEln+vLp6jSdPUDsIW/OPRr36JvRLRUO+LxQody36JN1glKUxD5T+SF733s5ZR9AD+Q7gRW22jciQQjiW6FqvdxdmQQoiJ2VFnVx2yxU4pv69ZBiyr28L2q/X0DfyVrQ7BLZCAOSg5ap6qRGM2oELWpn9jHEApD3ujRr6WHXDbgSJwpRFhE39sq1E1qCHGMMV+qLAD0YoIV7DHQJJzLca1E2/mVt4iNL3g0CXJIGb+pT4QAYGaavv6KBlvMLJphsXuVRyYRtDq8DDM7xXF1MdgHRpQM5nSW7yGz6GamVgLYR9pw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(41300700001)(336012)(4326008)(478600001)(7696005)(2616005)(26005)(47076005)(70206006)(6666004)(54906003)(426003)(70586007)(2906002)(86362001)(44832011)(16526019)(8676002)(81166007)(6636002)(316002)(83380400001)(110136005)(356005)(82740400003)(36860700001)(36756003)(5660300002)(8936002)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 09:22:47.5390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc4be82-c65f-4e5d-3472-08dc27be5956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8433

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which used for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 0a3aa6b8ffd5..fcf5b75a5341 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -440,6 +440,17 @@ control its functionality at the system level.  They are located in the
         This attribute is read-only to check the state of preferred core set
         by the kernel parameter.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this new attribute file which
+        allow user to change all cores frequency boosting state. It supports both
+        ``active``, ``passive`` and ``guided`` mode control with below value write to it.
+
+        "0" Disable Core Performance Boosting
+        "1" Enable  Core Performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


