Return-Path: <linux-kernel+bounces-101324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA7587A589
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:06:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0C83B213DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2093D56E;
	Wed, 13 Mar 2024 10:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jKAxdt0j"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E785E3D0A9;
	Wed, 13 Mar 2024 10:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710324322; cv=fail; b=FjYBRrW86GIgz5jlWhKaoUbW3xzX6dAOIY5aNRRktN91dmhSqK8285O7Q1X0lzev/pfKtNlLC4F3XTrYg9fkdAdYiUsvjf2eY6mtEY+wg0xE7awksJ8u5ukNvQHPnGnmPDhEjnNJ74oKw3VpwQU3C9eWnE6nDG334n2DNNLq044=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710324322; c=relaxed/simple;
	bh=NaQlWgruB8f75lyyUje9ch+TOpc5FR0j63DSnL8OiQo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C95zZIe2lMK+EXVme+2+A7wQXT0bOD0VIbvadbn5trlqnQe8xDVVHaJzSrFrIic4hh88jvdis7VfvboPi4xWdflq3LrlTEoEiUxaT6l1WmtknyJuvPEOmP/cXxCd/j2/jzQalTjik3lrXfjOVzqvqEzhPfXAfAcj1LNnnBWiGLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jKAxdt0j; arc=fail smtp.client-ip=40.107.220.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db92L22DY7igmTlEhU2NMErtAGDycWvnuKTqaosnzBWAUyvHjP/3qdzw2PC+cw11Dn1+2SzVXSfv2IsgWsbt4mbYvlN5+RJ7aMTZf/NY8gyygwc/YuP2f5LYfapcL2ory1it4KP7Gh0shdkdsOoRVHYIZ3TAz+4i/3j48/WfkIKIzFoc3apWJ2ZjRdQQGA7YP62OyNOhcXfOPM6Wmg0Z1/RIAI8hgu3j9xGONd2c51DOFi7MVyzQ0nyQmOtyVwYZesLTE/5x3x363eRMYze5XqXtCg+sicb0aJuM26/8wWhtCWboOnoB1IZp53CxAvhkeqGG8XRxcz+NQDfBo/uqeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=admHVOE3wrrt3hMxyBkh1upakPhDQiP9yxu/Eykl4TY=;
 b=Fg8za6GMqx7L/oGhjQ04QLXFRBo1uRxXleqasyViFOY6eT8pOCQhEyoPkBmtYPTREd3UIZ6W+UHJV6IGGXQ76Lhd+NyCTW/GPTJJ5reUkc4QTT5zK9afzrvO7e34t5RZJP/w4u3Ttre4n3j29YTcc/9KMWYSZcXFGfpERg8SDCwCQPLis8y9xiEq4SICh1a2PbY9zpPOY2674eevN04bxK89EJSM1GEIjeKBNm18HejhDIJyZs4URLMg3BluvwR3vJbyqjUDub7HviekCO/wolNkdJZFETBW1KiZk99DMgGJpmqw9NzoWuF1P6313t03rTx7g6k8yz3099/aKz4P4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=admHVOE3wrrt3hMxyBkh1upakPhDQiP9yxu/Eykl4TY=;
 b=jKAxdt0jrJw0pTMig4JkzgOYGyjnKeUbLpCR4R7MrWiOQ8Bq5+fk5i1we4oxCZejOg0jeEbgQLfK3IOE4ttAFJ2QyEwcXD4ldRiHv4f3groBA3c9mZ31F5jRRrdGvffrTFLKF71wnmp3Euyg0iOahT7nIX4X4ZU3KMQuvKueQT0=
Received: from MW4PR03CA0231.namprd03.prod.outlook.com (2603:10b6:303:b9::26)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 10:05:17 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::20) by MW4PR03CA0231.outlook.office365.com
 (2603:10b6:303:b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Wed, 13 Mar 2024 10:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Wed, 13 Mar 2024 10:05:17 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 05:05:14 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 6/7] cpufreq: amd-pstate: remove legacy set_boost callback for passive mode
Date: Wed, 13 Mar 2024 18:04:43 +0800
Message-ID: <c9653c82afd9a11a7d3fa466f60d64d7e457968c.1710322310.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb33923-f454-4cd5-23f8-08dc434515bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eiqpKe6HPgYqvwosMYsT+PCNOBqHNin6DXW6oi1VAtypteGuSEvtawpKdJ9J1ztbpWBANM9MOt5pM/Jo8maO2f3G6onuldtypWwl5q8pdy0NlbfIpyhuKzQneQZMzh60zudLbtFXSZdw3XWYg37e65xCe/dgrClJQDyGVmxVmSDw7wML/cuSl9NJA8oWMOCXJea9//ejU95o+4b/x7jtAsJMZcQc1RyKew5oL8UTMsfbCm/X4/x8OwYOrSGRXc8bpl9OHjWMqBSOPj3TUATNcohu9rTyY88boEaRu3pEi+0IdmhthXbMUID3pYa0h0ImvHNy7kGF6YdyhtEk0nCDDV0DQObZhDdrb/0GBLqohdU4nkYjZymoCb0BRLpg+Yjy3Yf9KmCsPuSlig6IcG6WksvBm+ex4Ko4S0XWgV7xzfF4EtzkszCBmKWSD9iq1LntvVaiQAiWIeLUg4uWJPelb9A68YiaPPcTRzuhOrIGikXVZXB60j2ZPcfhp+sP6myH/0mWcY5bbVf+seTQXRxVdeluOyP4JRxSQO7BQrUVTeFI8uLCk8QhyyrjsDddofiJCeNBl/mq2TJWIuR9K3j0LRPQ6v5XUtLy/zpvuV7Fk4xu7PJb1zGp0OP2adGF7WQex2hA2cUiT40XJTc6b/wI4BNlupS22LTRdsS2qPffK2pUjMlIXkx7Jwf/hA0qNxca822I2MbiOPLQXzvvKc6HHRrDG7zusk4WfRaWR8f0sXx7rzU/BJFMIFoTb3v2AtVT
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 10:05:17.4857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb33923-f454-4cd5-23f8-08dc434515bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754

With new freqency boost interface supported, legacy boost control
doesn't make sense any more which only support passive mode.
so it can remove the legacy set_boost interface from amd-pstate driver
in case of there is conflict with new boost control logic.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 1 -
 include/linux/amd-pstate.h   | 2 --
 2 files changed, 3 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index d7afbded6e3d..4a24db868cb1 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -1689,7 +1689,6 @@ static struct cpufreq_driver amd_pstate_driver = {
 	.exit		= amd_pstate_cpu_exit,
 	.suspend	= amd_pstate_cpu_suspend,
 	.resume		= amd_pstate_cpu_resume,
-	.set_boost	= amd_pstate_set_boost,
 	.update_limits	= amd_pstate_update_limits,
 	.name		= "amd-pstate",
 	.attr		= amd_pstate_attr,
diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index c6e2a97913de..7130b297c522 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -56,7 +56,6 @@ struct amd_aperf_mperf {
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
  * @freq: current cpu frequency value
- * @boost_supported: check whether the Processor or SBIOS supports boost mode
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
  * 		  AMD P-State driver supports preferred core featue.
@@ -93,7 +92,6 @@ struct amd_cpudata {
 	struct amd_aperf_mperf prev;
 
 	u64	freq;
-	bool	boost_supported;
 	bool	hw_prefcore;
 
 	/* EPP feature related attributes*/
-- 
2.34.1


