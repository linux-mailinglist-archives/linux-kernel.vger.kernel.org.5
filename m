Return-Path: <linux-kernel+bounces-43967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1F5841BAF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAA191F283D9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578425647A;
	Tue, 30 Jan 2024 05:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jnyUtK6i"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA07755E57;
	Tue, 30 Jan 2024 05:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594242; cv=fail; b=dbDnl+GP0toJtozaaxFD0Yl6yAJRVXAqmLFHBeBBGmOyEE2zHOmQ/L+GXDsFBv/s8qyIvOBT8mA7uxZIFQNyBow5y1l8HZRgWwzIjlAK7zKId9uMC17I2KFIHm4qHrt7ReKSdzIaaVMXLQjgGU28iaI9IYIrtcwDDC6gNdooyPA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594242; c=relaxed/simple;
	bh=3ME+v1M95ybXx96nhasNEZ3w22e2BKuPtRJR41vGdaE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KV5g9Vb18QY35zEbD/EeDgU1rjTD1v6Ra3tL2+DzNqK6Tv0hamclH0KTRZSHIyfnapZ04FObePYXsbBekIMvCB1Cqc+onXHYl2RZSOyt72ObF6+WkL343HWOfgxgH/k4tTEnd+Kj4jjVLmPDsuN4HuJ5gOl1vFA+qPrznRqlBg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jnyUtK6i; arc=fail smtp.client-ip=40.107.102.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixOZ1WQL2F071K07/saPCf0+kcc5Us2pU6yE88S6eiEqtQLkXcv4zcJD8+rQcUe5nxz/tZryPkZbtjxegOfQeS+4iY8LH48mykwr5HCc2miXtlAklc2F2MDjllJdNKfS18qpYg98YMAbBvvyJxrsinW5IVDI04YbVBpi5ADvnqxNQnRb09Mtb8wDup81FB4bzVnSgwbJDRw30ERFN4zC3V/cbEtr0TSFDgmoNfBWHOHUycEvLvtILJHAEeRgbRQiilGTfE3MHmSTsu4sPgOmeOjKfXblf6ysJ44gRTfkPASqTqQztvB00w9FnDQYf4/QP6oWUlWVcGb+NLHqWZJ0xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/WUTkD0MHNo9tADSWnprHWaLAzSOW0I26nQ+yW648ws=;
 b=DTZeYky/sxI1niYL2NEEq5DYynb3Hv8xARlJTeP1547PJkiLtBkx4x9ZWCqyTOi0e+7RW2jt8wMuZXCzgA+8QunepiClLLvAWSyc8uuOyWD345mA3F+BYSgt/0Asj5RSFGlbh14r96f9yReGnF/VJePPMfT/kamPTV+vZlvxhoeMaSNfjvzRW2nT6OoFDzPiP2a3kIVynH4/snpzxht9z3dsZNEpi+5soESmdc+e6REbf8Yvc6kRlEx1TBP9PuhBQDCrw91abEqd/FsKpyGk76EJrL9OKFF6lRjrMtejNtthymQB5c7Lk5IYDevhobRxVDnC9nJfTHh9ARsX64yJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/WUTkD0MHNo9tADSWnprHWaLAzSOW0I26nQ+yW648ws=;
 b=jnyUtK6inEbIZlz9amxC3P9+xs/+kNO1/VF127Lqw1cE6lR3jsqBNLl6nj83L+KrCPBguKB9HrenVbyp/LU/QS+BgIRwf/+AQWV/TCgThszcdYyumbxEMiWZ0leq1f5QTZlMQtrQwSaMrfexe2SOhfCpKj3xHrHxxPxQuEaIwUs=
Received: from DM6PR04CA0010.namprd04.prod.outlook.com (2603:10b6:5:334::15)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 05:57:17 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:334:cafe::ca) by DM6PR04CA0010.outlook.office365.com
 (2603:10b6:5:334::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:57:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:57:16 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:57:11 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 8/8] tools/power x86_energy_perf_policy: change intel msr functions to be static
Date: Tue, 30 Jan 2024 13:56:32 +0800
Message-ID: <6905c6ca13c5cbb513f2bf6c2a937dd228e3fd57.1706592301.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706592301.git.perry.yuan@amd.com>
References: <cover.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 9518c57a-5bb1-4720-8843-08dc2158505b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GdkuThEhOxqlDtRhwoeP1nwnIJzLy0QfyRdGlNkckti58wEvyxJHiif2dnlPEfQ6mVrm6Z1mDtBXujh7ZygPrpqkWP+NfsyLtLFCAdJznogvMQS07XIPpura+Q6Ok/vBeJiWa0DTAHZZ02TAIUYGhwHGuanJ3YNI4MEM/n2TqWJeIdSig2In8JgYrLgbn3pkLhPkDikMJI8X3cnmPPy7f0YMpVZ1+fBSGTSJkBKkjGh10FRuAS6r0tTqqT4kxVEcAzdlThCuMYMj5XzP9TJClgvZVaaEWkJekbbfLQWvqlvUXzISVzja7kVmLBbH6qLxYcGzdA5DaZFu2HqBg1XZPEnGxxOtOT9kybM2d4N2RrKXZ5ArilHx5FduzX+BPE5/PBHOyGMNNG7W9VK8jlbZoLSLq/Oe2mX35WX55+OkLS36xysq/pa1g88bUoWaJn79W84b65gNIi6Jc4oDjDYlC6vyknwa1M2dy+qugG9dCXlMnfhLdSr0TIKXEZ6u5I+oynnzp2bgnvURHx1B7pSGJG7plDkBPObTtf1QUs+hIEMlkWSXE9M0vGbNZ/oVdnve42xoYU7KFwgWR6acS6KTIUjnK6aqFTy74tdXWL4mOr78uLgCPpo+0Sr6SAIkbB50LtTvfT/RQ5Oj/BR976PcDmA5Cwig/z7PIBl0mmJbA/gTF+scglpnJgQwDI0lf6BGWsK4biMkb36VI5rJTb+QexNhT4kmunHHf14WCH90VdPFOjj06f9H57XxUhYVvYtIFDTPaEKSJWASwbexP2Z2hQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(346002)(39860400002)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(40470700004)(46966006)(6636002)(70586007)(47076005)(86362001)(40480700001)(70206006)(110136005)(54906003)(83380400001)(6666004)(2616005)(7696005)(316002)(40460700003)(478600001)(356005)(82740400003)(81166007)(44832011)(26005)(8676002)(36860700001)(16526019)(426003)(8936002)(4326008)(336012)(5660300002)(2906002)(41300700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:57:16.7688
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9518c57a-5bb1-4720-8843-08dc2158505b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

change the intel_get_msr and intel_put_msr functions to be static.

No functional change intended.

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 845cfedab06e..a5f2f96fa383 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -686,7 +686,7 @@ void err_on_hypervisor(void)
 		    "not supported on this virtual machine");
 }
 
-int intel_get_msr(int cpu, int offset, unsigned long long *msr)
+static int intel_get_msr(int cpu, int offset, unsigned long long *msr)
 {
 	int retval;
 	char pathname[32];
@@ -710,7 +710,7 @@ int intel_get_msr(int cpu, int offset, unsigned long long *msr)
 	return 0;
 }
 
-int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
+static int intel_put_msr(int cpu, int offset, unsigned long long new_msr)
 {
 	char pathname[32];
 	int retval;
-- 
2.34.1


