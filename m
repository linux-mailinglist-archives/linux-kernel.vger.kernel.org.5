Return-Path: <linux-kernel+bounces-162161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEA648B56D1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C4928366D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 11:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D25481BD;
	Mon, 29 Apr 2024 11:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hP8IC2Bi"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523084501B;
	Mon, 29 Apr 2024 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714390466; cv=fail; b=gnsYA+43AFUQOmrrXFEFD4AhaL9ofsrAETbm2J5RtMCFKLsyyORiGycDHyvs0zRRbwI8IZgj8FXYEb2yU5qBvvFqXEs21u4mKLiMzEeQPp0xPOTjvdKIrDVmFKprN4zKQSI/XyhQaWWNb/5tfFY0aqIduMg1ILO8TZYLf9RHnF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714390466; c=relaxed/simple;
	bh=uPmPQcjAMt8ybLjGMg3W5gswS5PuAyDH90JD2HKZXeY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OqYAS5kLgpMnNFheNQjfmuCgFm6bEzW2EpLfGz8KJ3pqzX2iEtsKGror+WzQR69f9cCDQe2g1AVnxELuyA8g9eDY2htsErWYv7WYxFCbbuFMKpAbAMdlE/4niSDlc9nfeqA13LTb/kSpv9ebs7UnzfQS9Baag6UWl1dyR3+Ha/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hP8IC2Bi; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afrm1j7SZHBx8remLKryzwT6Q4jimog/90235QzQdKeLms5YV+SrQtTTw9iogUNnRxxMcp7RyRNFo2eje2HSHwxbFRpQ0duKHEDyCO1t0m1jb4Hg/TiZwP6+faCefeSbUY5exbsaDyUC8DcLtpD7t7THfQCrDZdM+YInzJypSHRye3gf/41ZfZA9ST0BG2RX0JGJ0DphHuazLAUS0/QFjukga/P96O5yGOnxqtBCRm7vDpd8aJZRuE+jAtZeu07Wid92E0liqggsvViWnfngaNoZZnDJ48IEEES6lIoJlzv6ZHqIG0g+27CYMExi8GXTTau3t3VPuQ+pg1CZ8bBxGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d7m1wv2Guxa3PKGgI4y7Htm/Pem1WWJCXAeWDSUbMC4=;
 b=Ph6eHDaWxXVfkZwIMUxutW+N6syNe4TAF0pYIF/HW8JW6QNuRhiKbcqN8yWC93sBXsYFN6IN7Hk49eB8jzHI7hChglnwJjNYQsDc2OmRv32twFR0be1a4w7FPSCvkvjAC2zqvRI0D6DV1EeEtcN1d9pa0GIJIbXb2jMmqWX2A/MD7otlN3NVeOPe2ICob1dfkjIimIsLsg6LeO0HsaRncXR5KkkNjJqIV+bN+PuDSn20vaOv4HHDwb+mAOWI8I8D09gXRYQ2ccs9kyFi4d1CQjMr28bmTfFF1gB5zHBAR9E0bjigFkKpGoSEmrEVdEoO+xF7Ikvz0lBAEQ+vn488kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d7m1wv2Guxa3PKGgI4y7Htm/Pem1WWJCXAeWDSUbMC4=;
 b=hP8IC2BiS+92FIalI32zHsWdAZLXao58UUWMEHnzU9c1CVUcfoGI5Gsv/gCGpAiSy/qShZZ3BhykQHyncUwULRgRNJ1Y78DyP6u9UYjLMLjsDEISC4EnwQz/rSIsZfVzO2w60x1DQon7Vb6CXV6TNuPdip38+x0SARbMaUd+lMc=
Received: from MW4PR04CA0064.namprd04.prod.outlook.com (2603:10b6:303:6b::9)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 11:34:21 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:6b:cafe::92) by MW4PR04CA0064.outlook.office365.com
 (2603:10b6:303:6b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31 via Frontend
 Transport; Mon, 29 Apr 2024 11:34:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Mon, 29 Apr 2024 11:34:21 +0000
Received: from hr-amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 06:34:17 -0500
From: Huang Rui <ray.huang@amd.com>
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Meng Li <li.meng@amd.com>, Xiaojian Du <Xiaojian.Du@amd.com>, Huang Rui
	<ray.huang@amd.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>, "Mario
 Limonciello" <mario.limonciello@amd.com>, Perry Yuan <perry.yuan@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>
Subject: [PATCH] MAINTAINERS: cpufreq: amd-pstate: Add co-maintainers and reviewer
Date: Mon, 29 Apr 2024 19:33:56 +0800
Message-ID: <20240429113356.1708284-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c732a2-091c-47a2-5856-08dc68405028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|82310400014|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dKBbndngQSu46y67mhc507zhANVCIk+anQm2ajjiMWozJmVrhDJDUpI4mrmI?=
 =?us-ascii?Q?OmX3FaCPGPlRd3mh+hbXsnpNFl0rBSTTk+svqJt6N9j2uowJISfbD/cJfH22?=
 =?us-ascii?Q?flpLvidTl+rlxWi81Np6IIYvMUeisVVhy/T4Vj4ZfC9XZYQ/HCzpsXA5NuWh?=
 =?us-ascii?Q?ijLcjlHNQFoiwxjdsXv97XLzSVmr2Um7j+BgzFXxm/KWJsSHVZ5/3FVtSGUR?=
 =?us-ascii?Q?sIXezp3p1ZsJ5fm9aNDl8uP4rrr6k+reptQdHGv/iEhwyTZvrs+rdph8YRIz?=
 =?us-ascii?Q?JeJv6G7nFchrTMz6o0IzU/jfvECTTh8zE/5aU41Gm7fNtF1pT6/6pc3+8EwP?=
 =?us-ascii?Q?kKX2h04OE/9aIZNpNKmp6sERYChtleIMCNktj3igbI9BJfYgIUWtRM6Fajh4?=
 =?us-ascii?Q?gzrKuODf6kHyAtWwN9IhpP5O5jCkKaotqa5WeKJJHRiGQ2CXrBNimhpx6Uwb?=
 =?us-ascii?Q?wDBXAJNuP29mPs3olOvPqMngLACgmImJgBTKFGU3sXEViV0U/m33rh9SuUc+?=
 =?us-ascii?Q?kRw2OHNWiJUmHXvpUxNCQuG8STZAd9dgR4vWjesJjDBgEx8CqUC7ZEAOKesl?=
 =?us-ascii?Q?Fp302+qiabCopsJLS+9KFz1+9xKBr9+5bdk0b7gJ9iurYV2oAl/tpufLXm4v?=
 =?us-ascii?Q?eO75CPJFbsV08K9ewmABmPeiO6H9l/1LSwM6s61462OzzWOjZGJVcHyIXLQ3?=
 =?us-ascii?Q?T8VX48g5eGsNd75RHkuZJlFNwD6PufwYaWqkxGyVqF47kfhO+jUxsi1reYAU?=
 =?us-ascii?Q?jARWcmDv+tHcsxszJ9gXb+FWVrzIGcF8KWiWPO4f5ih0g+AvEBatKuhp0dhx?=
 =?us-ascii?Q?RJG1VEziaQozFawcnI5OenWhygWMWrp7A/mx3ueWBTE81Ps7mhpZgeNSMvbf?=
 =?us-ascii?Q?Fxmfh6TF6SD1UUmX32bLgrleFWDM3sZLR53JBYK47BusDTaB84fJ4/c2gmuC?=
 =?us-ascii?Q?pR7VCBivnimpGVOy4R8cSQ5JFSmr5p6jnKuBVKhnL+GSLTHEqWzkr+JakOgr?=
 =?us-ascii?Q?ji3frU4UyKjjHgBiy7csJbF9jUXLUviw5TuPEju0mrk0EcyZiSY3JCKqjuVM?=
 =?us-ascii?Q?64bWML3wBMeOy14oSC44N5yLphYAWgloIXTFxJrGE0Ups7XPk1YMr3mCmsk7?=
 =?us-ascii?Q?KQW7KqjvI4Z6UZTLtkFKrk549XwazsSOOMmxRb3dSGp2WyM1pzIoUCs0Hsup?=
 =?us-ascii?Q?PTvqD4wbwvPFQZMGNrvr+y0psy1fiTw0gCp++YxsXpxvUTrVMG/ODmKH8McQ?=
 =?us-ascii?Q?0AKtP21NIp0Lc59eZyo2DjyYiTaMAPRW7ELtSzXlXQU0VbUA+dwx08cy/1+d?=
 =?us-ascii?Q?CnDm7WwegCYDpShwmaTo3NcavGOMP4LS/SO/Bn+mFjFCKjLOKG6jlR1eo59R?=
 =?us-ascii?Q?LN0wsPpbu+1MFPqQ2p7mmoasQnAr?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 11:34:21.0222
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c732a2-091c-47a2-5856-08dc68405028
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122

I'm happy to add Gautham and Mario as the co-maintainers, Perry as the
reviewer for amd-pstate driver.

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Gautham R. Shenoy <gautham.shenoy@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Perry Yuan <perry.yuan@amd.com>
Cc: Ananth Narayan <ananth.narayan@amd.com>
---

Hi Rafael,

Recently, I was assigned other task of virtio-gpu support for Xen, so
apology not to review the patches timely. After discussing with our AMD
colleagues, we want to add Gautham and Mario as co-maintainers of this
driver from server and client side. If one of the maintainers ack the
amd-pstate patch, then this patch is good to be accepted from AMD
perspective. And also add Perry as reviewer, he is actively contributing
the patches on this driver for a long time.

We will try to keep the patches reviewed on time in future.

Thanks,
Ray

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ebf03f5f0619..96644624308a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1062,6 +1062,9 @@ F:	drivers/gpu/drm/amd/pm/
 
 AMD PSTATE DRIVER
 M:	Huang Rui <ray.huang@amd.com>
+M:	Gautham R. Shenoy <gautham.shenoy@amd.com>
+M:	Mario Limonciello <mario.limonciello@amd.com>
+R:	Perry Yuan <perry.yuan@amd.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
 F:	Documentation/admin-guide/pm/amd-pstate.rst
-- 
2.25.1


