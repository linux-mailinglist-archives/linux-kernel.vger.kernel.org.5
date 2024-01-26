Return-Path: <linux-kernel+bounces-39747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CE583D5AA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 547131F2270D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548B86A326;
	Fri, 26 Jan 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PjqguNqE"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396A6A024;
	Fri, 26 Jan 2024 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706256551; cv=fail; b=spYcFKwkdAD35+LSlGlYOCUjbAKYH4PtmhcGCBZABsOLgg6puAo3+d2OUqfyCyi72sdhZQnyJIeB8nukYY4BvVsnH/Sjg0mmct5LZuHcE0O0VKWFvazWaeTvVpm7hG2Hi0YnSrMIWYjMZCDjj4BAegO5zDN3vmd6u1oNIwEYTrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706256551; c=relaxed/simple;
	bh=Rca+pkGTOn1V8qBOTuTa2KS/EBSLBggibKR/oeICyDI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hInWy166YIWXzXGXM/fYjc5KRqr4elPGCbgFFeR/BkuXsWSjLjWSXRF6ILAsU19tObPhj3jzs7nx++2hTGUahKxpvVLDbgrTideD1Ecm5gWeHN8onI+WcyDPcJGQDZy/pCOdlzBjl9JlWDGLl6xux7YUDzOf3hYBC0SxvF/+ivQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PjqguNqE; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNxag8Ou7dztMbTVSuTmivMR/7UG8OZPWcTARx4Ut47qO+ZQlyi+yN4JC78nNAVbOA8G5za7FKB1+xLfiqHshQ7O37+o9XmElZzkjvtKegpYcjyQxOqtuFURIEfezRSeOCiI4PQ3P0uutvoBQtyQYbl3ECHMIGOrqlF6T9wTrShjRle+3sAjd6EtLgutHnnTP615wIEcuEYFxME4pFKFl6M7xlV4wLP/iP+jeHabmIXvmoMKMpNUUIxFQO5dFVm1im4ZpqUgwA7l5Z6loR1DCZkJTFnd8rFfFZ/f+LZYwJozXWnfq1uWkPDtKWXeRinxfY4LEwyFIP7HdQPpm59Vng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW9y79Sp5ovfASU9Wv/i0zw9lUzkOy2sk54Ik1mgXx4=;
 b=f2/GgHkYCYz2g9+t8GBKQ9GwpAVth77MtO3vYqAAdtZ98zBSppU6vmfxx8uWAJ+0FqP0bpq54CJbHAlZ2DskYTJd+b+G6e8tT8pOugfkxc2yNC17ZoOUFSTmHXRe89505q3nzlLmXLd55tRdwxXASUPEUkYOPyf1imPWjDhT7DEckuvmPROh+NLjrpAETYQEdVWT0iVhsbEgsDJlz0g4h0bS5MUFT+SuQ6PKle84/dI6eQqmpSBsKY/YLwbjv+3FVpKiocFsnwyoDGg92DutkXzEa24aBcIxMyhrQV0pZ56l/iJJtHR84vHE8M5wsVBHcZLnkkTe9j1xyakD+B1YFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW9y79Sp5ovfASU9Wv/i0zw9lUzkOy2sk54Ik1mgXx4=;
 b=PjqguNqEtrpAmHSR9RjlXUPLVqOdC7uZzNnChBwR1SHaO/UqtFrBbTsq0QC/RKPBnzd6LBumUVsSTreIJl6EXB/H6GdcOr0ZvO+6p5mgIDJmNypBH2TFMTeRxoj+vY1Lg7q/0n4yRb/6sn9CwmM+f9FKalMbXTFg/tMpWalb/ew=
Received: from SJ0PR13CA0142.namprd13.prod.outlook.com (2603:10b6:a03:2c6::27)
 by DM3PR12MB9391.namprd12.prod.outlook.com (2603:10b6:0:3d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 08:09:05 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::46) by SJ0PR13CA0142.outlook.office365.com
 (2603:10b6:a03:2c6::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Fri, 26 Jan 2024 08:09:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 08:09:05 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 02:09:01 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Fri, 26 Jan 2024 16:08:10 +0800
Message-ID: <1be9c97cafb1406a607184ea48dcdae883dc4cd0.1706255676.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706255676.git.perry.yuan@amd.com>
References: <cover.1706255676.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|DM3PR12MB9391:EE_
X-MS-Office365-Filtering-Correlation-Id: adc8cd7d-251d-4dc8-04fd-08dc1e461066
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ox3Dx9HW05YyWO/SQhki4+sYjq7r2yUYypGA9BZ3sNe15iJzGmopSGMIRYxIbF16i/u+p3N77PB5WAOcg2UyMjgAdfGKoqdWbEIttS0kn/YNZxmnambHI9gsWOJFQ7mQr6XVR5udHQjwGN6U3DU5ZM67yRkI5o7W9ia4g9IujYY1VoHoLUwxzxm0Q7JMHcEdUxe+aoJNqoOEpSvmXAVk5VTuTNN6UOx/BcmYhnTAUdojwD/VUfw6N4aHbM+URDa3pBmYncotBcnvshYbXmwO8gTw3n+WhFNzL3kBSNBZraymBm+gX1XnpuT75XHJ7+rAOlxRZe9TUoUtvFYpzG/Yj8fIPn34OTXC4qdkmJMqqkGb+UZpV5elGdFyp/3MYFa73pDEn4cd4D0JKgQfqVNZJYq727TUXofxgC5sqzeamXRS9vEmNr4+gI0a+xgCmHc8Q/V6BzJm9KvUY8nPOFq0iCZUg9c0oDN6rEip3+IM5XZoUSKAvN9AFNNYPOYYHNY0ZPiPF7YUyoFCQ3umWtQS+fnX087n8WABjOLKNpLfn9sBZFLRY0Bga0P9bNY7NBm3eLrn5HUuQoHZV4Yke4DI0Rv4yVEqQIX6SKW4aDYqWq8f5ofbvwodsrxrhNOdXWkib54jII9SbqYEx/FtYxO5dJEnwi61/ahq9hieHXqd7PD6ycf/bNfUHXPG3+ZthP8aEMjl6ZcvBTysGcXqYYeVwkMOWH9JjQ8Bz+e2bqF4FRxcXc0h4EYTpJhN3dZ77feGpK1IDRPXhJPo2te/nyFBjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(186009)(1800799012)(64100799003)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(83380400001)(41300700001)(47076005)(426003)(2616005)(16526019)(26005)(336012)(81166007)(36860700001)(4326008)(5660300002)(44832011)(8676002)(8936002)(478600001)(6666004)(2906002)(7696005)(54906003)(70206006)(316002)(70586007)(6636002)(110136005)(82740400003)(356005)(86362001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 08:09:05.0026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc8cd7d-251d-4dc8-04fd-08dc1e461066
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9391

From: Perry Yuan <Perry.Yuan@amd.com>

Introduce AMD CPU frequency boosting control sysfs entry which userd for
switching boost on and boost off.

If core performance boost is disabled while a core is in a boosted P-state,
the core automatically transitions to the highest performance non-boosted P-state
The highest perf and frequency will be limited by the setting value.

Signed-off-by: Perry Yuan <Perry.Yuan@amd.com>
---
 Documentation/admin-guide/pm/amd-pstate.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/admin-guide/pm/amd-pstate.rst
index 1cf40f69278c..d72dc407c4db 100644
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
+        ``active mode`` and ``passive mode`` control with below value write to it.
+
+        "0" Disable Core performance Boosting
+        "1" Enable  Core performance Boosting
+
 ``cpupower`` tool support for ``amd-pstate``
 ===============================================
 
-- 
2.34.1


