Return-Path: <linux-kernel+bounces-101323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AA087A586
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A0C1C20D89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD243D39B;
	Wed, 13 Mar 2024 10:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KITMVJU9"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE093CF68;
	Wed, 13 Mar 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324321; cv=fail; b=m4tJVm3nxBThsQf/4qkvKee6v1BMomXqxRyfnHg30GbxN/eHzr0yzWTxTiyh2cRDSoaDSlIjzNZubZB3dmqkIg0TIY1r2lJB4tU0XQvHuqdQtEKxuX+WzfuMZA3PcpUoR+vQMEcE/fRBTGKxpIyxca9KlLSIDQgW64E1JB641ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324321; c=relaxed/simple;
	bh=xEj6liAj6IMhbWAhkHuDsMO4hCwxjqNXMN9NlrsX8rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fv+P+HcB5PwAcPcPdbP6fO1t/PcXYzP3wUyg+hJRAeDfoTfpmrrNm0pH0bBYwB3IB3gw5VVp48KRy5dgrQiF2FnOIL8xrwkDvhbYNuHepCNBMq1VMBRFMfzLrvDh+t0mPXX5PU4wqj7xflzg4vuQ2GLkBGU1vm1pRoAst5RjuQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KITMVJU9; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkbfM/mk8tLNq7j6KIbClCP8yY0GTM4W4nuigkxmoXqj/FV84VpJ9neuRmazuLuwYTkfNx9y3tEhlF4/AHXo/O2vlIZUpcXBGZUyPfrwH1f64OWxomgoYCfpXkkWIpAgth7q8qHZ1S/OImX3JFJFWHFhyos0ZfwtwecpVj8z2K3c2bJUhL9AUmuviVd32gLvq20fXRY0kl5njxpGMatv/YWkJ55V8kacXG72tGCFQDZA2XKBly2RRqvkuU/5YbhqMC50JtzhoNTVkxCffCew4lQYtHEJEMGGexXx2qtVUbvEDsgC+4Ed6nRQ2Iv11wED1MFRmx5SL0aqeOI22KX5vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=hOKhensbje0FKw8I9S3RE+8rcmPq5NRm+cVRCXMCtSFac1+xAHUBdTKtACc58cGUBGkMrho94nIpalY0bvKW6AcOspZUH4muRFgGv8j8YdGAIacEHIck0QlQ3lAdGz2A6kwGahbSAI+yWwynDH4lqy/Te29b1nEpQCF0dHMKmoE95u8ZKSIxT7UOWTmoQUNbxcgF22XR5x/xjWdutFrDh1dh6keTJGGBPlk/uw+VdHtovaJCIlZ7iMnFYvv2SPjpkfOuZMue4B6JwGFNnk4iOsHpVgUSsSb2a+YdV6Wu8LsLGmyYxxhY4h6Op8OwdWB8rBGOyQf6epM1ncrCflBd3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=KITMVJU9OHhmI0166b4vluh40K1yyCFzpRQvxM88GCrEdj7aQPfMZmS0x9n9ue2l7Efb18lml3W4jhGYZOVHf20N8c2E0KO1ZAzXwt9Ft2FfhNnSWQqDnv9r5a1XLVrI446P3ro1kmUwTCWPze/IpDrOJghgsZZctM9G/zbzJgc=
Received: from BYAPR08CA0062.namprd08.prod.outlook.com (2603:10b6:a03:117::39)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Wed, 13 Mar 2024 10:05:16 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::e7) by BYAPR08CA0062.outlook.office365.com
 (2603:10b6:a03:117::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 13 Mar 2024 10:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:05:16 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:05:11 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 5/7] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Wed, 13 Mar 2024 18:04:42 +0800
Message-ID: <da1c4709ca3d99ef385ac98b68c58eddeb0adacf.1710322310.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710322310.git.perry.yuan@amd.com>
References: <cover.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: efefb17c-8f2e-4ad7-83c5-08dc434514fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fd/AAiYFbAC0bazfRsO+xXbbwf6RiSZSxLy6VNyS/RpWbDQSxY89WBwMWG4DZ5OmFVgn6rAeNiByNouU4g6ARBsmC1vatPDClYRLISXEwO1HyBsBWzuAQf9WQHmR2GG+sES9mRDztYqP/fepjFmc1SatHBP2xpxSEhzKOp7SUxXTtjYQgfLNF76d60O/eYqkPwR8Vo7yDq54Z/Qvi8bnIZr+X2bDeky3hTtgUhugsmwsxevWqe+wGerJdmIAFXaU9jRvAR4my2e7WWsdm54dAfAo8FLfnxb8r+2AbA5ALHs4bz66RlMye/XNQQqBZUKiInZRJqG34L1kxtOxWSNR8qMJl72zoRTbBwodzbTSblrOMFyPSCHVy3uvaNGFJxcmrZxf0ypODDCN6UeourTXc88eEIenNLEjNpLH461BIeVutiF/ep1/S74eLdfQ6bbGV6vSu+liMaakDdxnGu39SMMor6jHI50EkH1nkjIg6iFcqF5STZtYVGh2mHfsOQuElOXVEXpN0+ac0/EbQ/5hPLaUuivNxDxIeidNvl1MTtseYYUP+MZM9T0b/p5lk4hRx1IOeGtLV+rz5Z6yTB3SX0T3WKWX4zrS9KV9O3WzXuhp51IRYV8WVtvSj5HMlElw1Q7kpGAKi9qZhY5UzQR/oHAe24CkRnaHxG3nviLPnYU+fHwTNsNC5AXIaGR8tQWNrIIWMD+2XD0YzVKkDxneehxSxru3CvjzalS/Rp3aXh/rwQyxS2n5rJ/cz/D58XU5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:05:16.2102
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efefb17c-8f2e-4ad7-83c5-08dc434514fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119

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
index 1e0d101b020a..82fbd01da658 100644
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


