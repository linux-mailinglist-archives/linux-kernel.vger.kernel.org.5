Return-Path: <linux-kernel+bounces-104028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE287C80A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:41:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95A91B23120
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFB814A90;
	Fri, 15 Mar 2024 03:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4/cZK6+6"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4276213FF6;
	Fri, 15 Mar 2024 03:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710473980; cv=fail; b=sz0pLnbp4IXvRi6vcB/EZJi14GrxGN2/xI6wa/JwSfytpgsh2i8kifLe8dCkY3SrvYc3+Z53TZAxj2IRWPP8AfIWfoxNERaSSNTXY8bJ02KwpFDr1Hzq4adbXW+4uKyV9rT+PPi6IMXLDZVV92+y2sSlEGKz6idmHF+KGxkntx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710473980; c=relaxed/simple;
	bh=xEj6liAj6IMhbWAhkHuDsMO4hCwxjqNXMN9NlrsX8rk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OW5AAfpEs9fBQH81qMFI4pS0U94XNSq/LlB5Wydz9f+SohBWdr9X+PFVp3wI3x7ihZWmWgSoEJT/ySbMoOj/2zHGMnpPuFdtmQ0yDkF0zno+RWtkctl4BlVdwOYqtmfXb/+Y1X5/sQ98zamd1Q6aeZLoOV4DLcCbTDfsL6n6LS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4/cZK6+6; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpXqQVqDmbGahTdar7a2t4l01Gfw9AATwLEDOmWuM+lstZsxYsJJmYP6RsCOIPlg0b8q26k1oXQAnKUUg3OizBg8bORbHH/93Ph/CcOtOGS2hBsTDl/ndhVoRqxEyCQhR4kOgzXdVV8VaKZKnmXNBdnjZBEev4JXfI9/T4BpWFBrasJJCrrRLWKPaaHGBgZvMeDa68PERrzml3JaHgrII4x8RNZwUwBwK+ubFyNk/ghHHsFSVBMsKXFm4ZWaY/ZxqCl5i7ZHJFZdEf6Vcd1379tXw0fGqoVHldj4u8+L+i5gX8Kn3NbRRwa3GWkhqXXMBIK2WnrU94BXItjffiyncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=YVkgnzDM/9EQGVuA4jUEgHAf0D09xDbPn6TSYMBNb0r4NF+RleMkw0yWwRCACmnK7Dgh9qiF/rApk50n03vXkX0LcfHS6jFegIYzWv+Q9bAgF94T5T+a9EwES99whNnYQACQifOMu8Rfre+/gKqHqd2GhMsJILNpq47E16xqyQYL/Ks1TkFzjojvIfOLQvAuZZeRxS3pc7qLso/9FkhQNXWVDOA8HwtxhBwcsXNkT0PVRtFHpBcxyONL/EdoJoVo4d5ndp4O9YfpBBHZnkGah/btM05F4p+3neGl4CVqzJDZ3DULndHdkPQ5uj7oFUf1Om7aHU0bDQ6V7xXZfkdrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27ao4J8fzUAMRbFzpm1S5an7Hi17ByoMGWcavVPwhww=;
 b=4/cZK6+6+3OK+Ef3W7oYZBAH+/6gsgHpy8NtrknWHqAxT8L/P1z4ETAiY4cXRmVUeqw+J7BVioZd34fLs5UMR/8bmTHGa5urFxkQ7x26CbB+UHZ8u08lgkpeHHB5oiY/AW0bTLcAWOC+H0Hrgu97dbenjoftASUw2jd/Htana58=
Received: from CH0PR03CA0304.namprd03.prod.outlook.com (2603:10b6:610:118::28)
 by MW6PR12MB8914.namprd12.prod.outlook.com (2603:10b6:303:244::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 15 Mar
 2024 03:39:37 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::ae) by CH0PR03CA0304.outlook.office365.com
 (2603:10b6:610:118::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19 via Frontend
 Transport; Fri, 15 Mar 2024 03:39:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 03:39:37 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 22:39:34 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 6/8] Documentation: cpufreq: amd-pstate: introduce the new cpu boost control method
Date: Fri, 15 Mar 2024 11:38:07 +0800
Message-ID: <fa401838bddd96dcac3e6b990e2a86338e4c8a96.1710473712.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710473712.git.perry.yuan@amd.com>
References: <cover.1710473712.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|MW6PR12MB8914:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c533132-4295-49fb-6bf9-08dc44a189ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	H9ha6PiJqDvbg4misZ6arfiW2rp3ROklv/XDOmnANhzOgY5AWHdi2cHsHxkkHz1Qj9uyVqNQBaaa+ZlysijoUv6uXeeRL4Xkvxm6Q/0DU2FA+KSx0rOYLkQlp7K7Kq6Fw2Bk7oy6YIN08FjKfWj8IHmcpPf6cEb3azLhLPAIKfhwBQ47QAX/FOr5h12QcNc3IOZD2Y4wrxO6jIwf23Pobxt7I2eyi6X9P5ceSX9396VGwTf1fCll2rHcjJ20yuTIPreTHTYc+B/ylNwxn4I7xyJIitYX/CjJmwJE99vvq4SUxueUfd3kBADh74jIB5Cw9uDCq0+f6LowZRlCvUmsRnSzq6yuMGYmfvN5k4YcpTF48kOszSSoBQs9Roxbq0AjCj2ygOzmFUJG3WVd31qV7xeAmubmyYhHeLoo3rNCcbpSHe7LAFlD/6t/c213OrE4gBFVGf4BZZVY/bI6vidx2/PZId9QVIi94od2zraE9ifNFqkzs3zhRK4fk1U9sk5aR/i83ba0MgVOXsBiT3QXeXOZfJ0h2NMO9w/lCGUVLssYAxBqiaXKPEZJcrpGwgrsnAAVDHj3MtlcpKbyDqEXyvHTJBJ1zFCQc/mAmpTMeu34KFJU/SD1MtAztfFe1FHHKxMattnQDTMVUkjBjkBpPq483klFuYqmAPBgqUHQZ/mEJDOSpaGZWq7lBc9bsijB0snax54tBa3Td72QZ7khsXsLKbBJSEAi3Jgcp9KDM4/RNGDh6sHduFDiq6K2DJLf
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 03:39:37.3604
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c533132-4295-49fb-6bf9-08dc44a189ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8914

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


