Return-Path: <linux-kernel+bounces-51628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89785848D78
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 13:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 415592830AD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 12:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19EA9249F1;
	Sun,  4 Feb 2024 12:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="liW9hAAp"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1557323758;
	Sun,  4 Feb 2024 12:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707048814; cv=fail; b=bHk4YRYk3cg+vkV5qSoITtrY4MzS9h8booPwxgthnlH462LJaWsFPeb6S9/8nsnu5Wnwze3FT3bD9IJFRc/wvRPfACE5GF6zrmuGAVWD8OB5Mm6bCHOB8LCi/DR3jwtBWR/Q3ezTz0QRPXXLFtj0A6JA1Zfs1lBFdvLs1FCW7l0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707048814; c=relaxed/simple;
	bh=lfnMTuSxQRcmVz1JYUsbXFPCaH3u40OXwehJzgE8ZJ4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlVoqs7v01Ggr3o3D10bXMPIhnvoBui94FI9o1AcbklovtZSRo2wIDu3RgozcKdQHUtSUcB98l3tX7rKPP1wk6o7WhYALcA0ygvlOFcUk7Ur88se01gqLXaM5pWL5lTlkijYXzMDZbcjD0kxZDXuURMT03fcrMRlnmq4S3zFPZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=liW9hAAp; arc=fail smtp.client-ip=40.107.243.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qsx+ocgDEJG1fRuUkLz2+RTa3/GeShb1Yht8VqNqehmN1VlBRlrm6tlbyx0kbCRjfaTpc37luHP5cfMeJbUKW+ef2+0R+ovVbM0HWouAvgg8fgx8pDrZ0UVtQVrvn7xAmeeGB/2UUXIvRH7zkf2c+b4eOlSYqiLaL6c9YloQpQGFITlv1FU6NZB23dmz692f4ssR9FhcqT/dteM3Mx4bg6e8XR4xyOfbS7+09fz+0vkT2JhmvogYj9d75OEwib7KN0rYnIGRpQoSQqyCnBzAsjRnNVGeb17fC+9YHje9ki0dK8+qELGqHZ08xlNF1ttHiKQnzTIwvbCjC/fHDVfhHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBO1HGna17IntBRshMuW9ckvitloaQt5inNr20K49PU=;
 b=GVdsW0+mi57xc1qETCh3THXVMNy2RtOwlq+sNNA25U9/Tn4E91AlpJaisyRxP9+deF1C1BG6fCt6L2xI9rA1GcDEzhb7InJx+X2p7Nw9InKhaoYOFNZfH+RzS+UCg6jUTrHQg1aS59tmyoqNkhOIVUL9bBWeuTu1YeG2UvzIytSZx5paKTu/ce0o7kiwX4coviv5Ias6AlJvh84KiB5kLl8hWAtkrww4l4HAC8m5bi2yJFNMzufM9/3xahO6zWDPw/y53eXbcffrEEdW6TstIgP4MSvt+yn3FvZCfcJegignZtApCaXtaldnOo82GAdohwN7mFBjOA1gG0jS9tYRHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WBO1HGna17IntBRshMuW9ckvitloaQt5inNr20K49PU=;
 b=liW9hAApOPHGvs1MOaEsejcO9un1iZJGenc35I4AftqmJw5FBn2YRu5+lN1+L8dq5HiR+DKV/JSu6cBks3vTn8Jf1oTHE7I0OA03qr+wmdrVFTJ1a6a1LTatPM2C4HdEbR89qv9VyNWSAliyZg0S98Td77kUZUli1uuSXZ43ROY=
Received: from BL1PR13CA0125.namprd13.prod.outlook.com (2603:10b6:208:2bb::10)
 by SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Sun, 4 Feb
 2024 12:13:28 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2bb:cafe::1b) by BL1PR13CA0125.outlook.office365.com
 (2603:10b6:208:2bb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14 via Frontend
 Transport; Sun, 4 Feb 2024 12:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sun, 4 Feb 2024 12:13:28 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 4 Feb 2024 06:13:24 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/6] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Sun, 4 Feb 2024 20:12:56 +0800
Message-ID: <168bbc442811eece69a1c4a0353c23fd349db235.1707047943.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1707047943.git.perry.yuan@amd.com>
References: <cover.1707047943.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SN7PR12MB8131:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eaca03a-3ce4-474a-d2ba-08dc257ab1f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6zLH1Y13YGDwJ0Ik0hYu1Q0SmRtJ9pcikY21jFuD6y3EkhV/qOHRIeDqbAoFx9i5G913H9xeKEsnTchM/L3R5XTP34uFAMm0OjcNtjUa7ovCUBVViEabwBSO2wtj2k7jN9tACzEpjWVRVN17apRpcHEaPpriXuOtcviXOBNlaV40vtCNHi+Wh65NujgUEv6Q/yRVcgFyZqQ5vqnynrekrG8nz4H7hViDJZhwGPdmnkSoF+hysLJbtiiOMb2XbLuBDdC06+kcMOvNtQdaeWvuGobRfUKdo5E9Kog/uQv5fhfXR58iw6LXcBpDrJaqC6cYc5+XWRI7CBRoMRLs7nbK29UwoE9QrV326yCVktrW4o5Dh9XxHUfTwp6djgo22Ew3L8C3NZwZ4yX0dMi7n9t4X1pqqZA8T0ANjxk/dDzkVQVjfhZzoXrtA9dbg8w7LsRDOcuwMgQsxVZ7Ryv76rueHnBwZaQRmwEfO/FfvYGNHOsTEZWiUpucf291A8zwIbkMLmH++lyAHbWPE4vxWxd+ZkRj802neUORgw3YGwCZq3ZFqIDHVoKn/c795lbr705hkJHEHc6OXHc6+9WaRK5TXgGYn9vf4Qmg8rFnUSrd/3hDS6tIZDX3mb+1HI7RiaS8aJ2XVcsB6qpsKQPjnKGe4tCY9n8VnlMXPpGGN8QjrmGQcdVZg1QcOwFV5TUwi6Ef6tmao+RV1/fnN+yJGhFav76yO2NdNXQwuFV93QkhjWI8QnahB97+2Dmza73stNAaxfFRRG8gBY5S/cSKDS0Cmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(40470700004)(36840700001)(46966006)(47076005)(26005)(83380400001)(16526019)(2616005)(426003)(356005)(81166007)(82740400003)(36860700001)(4326008)(8936002)(8676002)(110136005)(70586007)(5660300002)(70206006)(6636002)(316002)(54906003)(2906002)(44832011)(6666004)(336012)(7696005)(478600001)(36756003)(86362001)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2024 12:13:28.1411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaca03a-3ce4-474a-d2ba-08dc257ab1f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8131

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
index 1cf40f69278c..abea29ba3d54 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -385,6 +385,17 @@ control its functionality at the system level.  They are located in the
         to the operation mode represented by that string - or to be
         unregistered in the "disable" case.
 
+``cpb_boost``
+        Specifies whether core performance boost is requested to be enabled or disabled
+        If core performance boost is disabled while a core is in a boosted P-state, the
+        core automatically transitions to the highest performance non-boosted P-state.
+        AMD Core Performance Boost(CPB) is controlled by this new attribute file which
+        allow user to change all cores frequency boosting state. It supports both
+        ``active``, ``passive`` and ``guided`` mode control with below value write to it.
+
+        "0" Disable Core performance Boosting
+        "1" Enable  Core performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


