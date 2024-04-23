Return-Path: <linux-kernel+bounces-154710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C318ADFFF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36581C22B92
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8505A4D1;
	Tue, 23 Apr 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n3SYQzX8"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBCB535D6;
	Tue, 23 Apr 2024 08:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713861697; cv=fail; b=I+QeSlZ+qDQFw10g4c5vD5fXrAg61KNhTJSQNTP1YQu1rVkjVVJhYs+HC8DMBnpziAwjRDHActdUnT7BybMmTC7AytcK/sI+oEphWOg2Iphp4hMQu4eGP4qXCsS6l37NrAK7c+DwTmVaNMt30ncmvT8yOKcXJ6pPHBvQeLSHYEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713861697; c=relaxed/simple;
	bh=xEj6liAj6IMhbWAhkHuDsMO4hCwxjqNXMN9NlrsX8rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W0Wmo+Oo+ll/eZJVimT7j2QhY7cW8X/3UDHP2ox7NH1aWv/NZUdoE9bnf8ElNltKTW7hgsqAzTfjAMjxBQ3lOJwfKKJzF96YGlXHSfN3nLC6NGRPUu8+SsPOcdS6TMbkOfHaChJEeZ0HyozLP+uHEEG8F8hahmCL/kL/jYoQvN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n3SYQzX8; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axJFB7gZ0CCo5Xvxwh8xAO+DMP5gajJRGfOHKB+62gHhzni5ahgNRs49sv90IUEWG29VFurZdSFQBT/vagfU75So/BlprnCDn7IIBSEUXtmpvxJ3i9anUo9IPQ6jQeeOMfSogxRQnY9atgyLQ8Tjccfd9qOiCEK/ZMZ1qcpJpnwRfIfxQOD1eMxRj3uua81HrYjDKVZgZx67QJBGU+vTTbbLhX6ZPaTt7lXrCdCSnC46bQKg/7uoH73vtKxiBFhodMa9I6VtPk19qytfQMNrfFi8X5qLTxvzNByGOJwe4B/EM+GdTLzJQIgEMMV7zhX4BD4lZsuY9D/mpk+hCROO4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=oelHB/Q/ftFYf4KfH56WdpS97aRRezz3FsfXRTurvadwJ/dBEL9s09b9Gb1DVP3i74Fo8PWr8rqshPsFEHroNnO+rxF9l8lo5tL1AJRtFDggVg0GSjSFvkDP5zgN5cpw8s3wO0Yrj4Y2u+8JNPnjTmTkHdtR3Ut1zCaC3BYjt403g5lPJ3VFWHjsD89KRS1/bJwraG1W2p53zIeY287zXGFvPr+t0BAvfCu99MsR3DHApwcpXT5sbm8HsuUkYAAy9yN++AqZ3lUsRipPGYEiQadpe0TDhK++Is3GYznFGplATW3yU8sx6deHbDo+pOG/WuYmse3bz8jDO5vDkJqKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=n3SYQzX8IEwDSjzxr85iF45KcTQ35rU9SJn8TydH6iQHTi6aSTeL8pqNKrOA3TTffxCv9dfBQqakLZHZdZzHcBOHdf6j5wMEUt/KR9pnCMFwDi+8xxZ0TcEJAg+ZwEXCegaaJJ6GqYhoQrJoWBkTGawgCPmmhX0WmkSyLbhN3Ts=
Received: from DM6PR10CA0002.namprd10.prod.outlook.com (2603:10b6:5:60::15) by
 MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.42; Tue, 23 Apr
 2024 08:41:33 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:5:60:cafe::28) by DM6PR10CA0002.outlook.office365.com
 (2603:10b6:5:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 08:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 08:41:33 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 03:41:29 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v7 5/6] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Tue, 23 Apr 2024 16:40:58 +0800
Message-ID: <3be5a8273d727b180b833ec01b785e394ac5d2fc.1713861200.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713861200.git.perry.yuan@amd.com>
References: <cover.1713861200.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: f7d1ea91-ac32-4698-ca03-08dc63712e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vlNRDmDMDEI280qD0kRYUCOZ8Kew4hq/Tq7mdn94pQO/lbrpKUfwTUhXT81w?=
 =?us-ascii?Q?QLs9wgqZ3Q7eqi1myFuj/+NoNEthhNaifAMkJyzNucEZDXueWbFdxRzDOjQi?=
 =?us-ascii?Q?Z+7JvMPUYq1kEOQZjVpT89LvRc61vllMtmLlx7ghjhIjI2AOZmYYxdeLwSDn?=
 =?us-ascii?Q?269RjDpSd+4jW+q14bGgEyWop0eRfKnw6EqXantRWAirOQd75FOQtrdT5NNJ?=
 =?us-ascii?Q?/REpBaEVY2WUV0IDAsyXnyctEzMKXrNgSjT5BDq8HsfmmxvKz9ki8D7qVWUb?=
 =?us-ascii?Q?LB8paIf+ke7ObexXvAFcw0qWRf7XEeNw814j33uuUi/+jNfUdsUPbonuoAOE?=
 =?us-ascii?Q?j8WxJ++mbIyqpwHyEhpuM/WDuPbmk7exhuR+GTxxWuqrcusacvjBQUEzxQu6?=
 =?us-ascii?Q?i/FUqI+HEIUPHLA3CwHJwsnAyCHTtWO8JpAHVDHBYNDUO1NFABi2ZArT9pDZ?=
 =?us-ascii?Q?FG+czyD1xZepSNqig9Cc9mnhPLu7ybR+ANh3Es7QWK7m7sFXh0BLqQ9E+zKB?=
 =?us-ascii?Q?hdfnoF8e/bw0gl5FTsivwnQkSSAFqHZbPkIXlnbC0ojNG/WCRTrXhZjfFNlt?=
 =?us-ascii?Q?AUo5XH6i9BoaktY3ybm8zgFizV0J37KveSoB5sY3TyqEX+emmSgvXANGlIOp?=
 =?us-ascii?Q?OHJGN7qvwsiDkjZRqe1hypATS3ULKbF8RlHtmO6ZiMYeZOvtEWSKR9SJrEkp?=
 =?us-ascii?Q?LNr8+JqEE2LtNAbZs8XFHcA/W0Mqjr9nkp3K1ili0aEMmliY4CwlPFih6By4?=
 =?us-ascii?Q?Z9rtw5e3QMhfVFctRqMlE3CXr7syD3J4N5YsgsnThr5YTocDLlZIJNBrFJkB?=
 =?us-ascii?Q?cfwOtqQ67IPjZY8zwu6r/Ck0RWqMtekm/04M8iWKBonfPEojTBUl3AeQhUXv?=
 =?us-ascii?Q?a6CXt4BY5ez7u68TJ0wj8odFLuMLAuzR+V53nl/4BtWnTNBzMgKkLePjcLAN?=
 =?us-ascii?Q?ydHwRIoP0pJK6D88L2/6MLw3t5DuRR3RnMgf7yJ5TG6xIKA/OS/rT6nr0s01?=
 =?us-ascii?Q?TL3F+BAE1auH3roALqcMtUFWesnc0r3Mx4QaTXqhFpjw/iTGbxw6pBL19Shh?=
 =?us-ascii?Q?R+y9LHPsirONMh6m6zpAZ6SvaYPxo3VqON5V3QhOiNphupxpSSliWznOz2qy?=
 =?us-ascii?Q?w+wHVhR0wS49dIh/PemUKHt5hQg3mSwPQ9ho3Ad38r5AmYA59Z0nvhFyOqeL?=
 =?us-ascii?Q?bMd1pDackDFOT+FLv3P2sEhNl2Y+kz+h1Rh0MMV4GRxwmEEdpASi0KxPucYt?=
 =?us-ascii?Q?RXzjb8aeq8jENsz7ovY3Zs8MT1otKnzwZXKb1tY52Feyt1ZJyqPoKrcc1xRR?=
 =?us-ascii?Q?3uGbfAOHSRSvqXttkaOAtBGvNKfVSKOJFt+qVw6sGCsac9WwmFj72dsZlJ6l?=
 =?us-ascii?Q?2swZhh9ypURfLnF+u2rs0dVvmXZe?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 08:41:33.4267
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7d1ea91-ac32-4698-ca03-08dc63712e12
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365

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


