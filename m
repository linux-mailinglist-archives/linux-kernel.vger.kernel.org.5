Return-Path: <linux-kernel+bounces-43965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD415841BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B85428B132
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:58:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40E853E29;
	Tue, 30 Jan 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zXuCj0N2"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744905381B;
	Tue, 30 Jan 2024 05:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594233; cv=fail; b=eFEqGz4Qi2GgAmgo7AudSD9vpqBTIzbOqIToMmo4FBHNjhS0kOz8eQPTnAgT1R8AMTByJnQnj8b6aAfM0mNPxbxAyl0KPqXNVGtMPJU2kr5lB6Cq1VXGPU6lEj/v42NAT6Iy0SnrANBjRJGS8yRFyGEt6YgoswaF4VLwXAvmTpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594233; c=relaxed/simple;
	bh=XyjWnshcEDULNzAsOzZlPe3A0bFLAu46xTf90O95YoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtAPca3ucgcKIofl/hXltmb/M/CH3jXFw3zCfjz1CFuNTnLlV6XcpjRykYFizU5ebx1lkNxZ8C3FlbQCSWLEeQ0437GltjfsgcwwC/XaIbkwNtv3HX/uP8TYNjRLEglaV8B/1ROlcMjmrGiRtJJ6oeKhaqDbg75BzWNXYo8bmZQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zXuCj0N2; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ERR5AiHtqUc5KMxDcBba+QRn8fz7I6AMBjoX6NkmSfgL71Rb1UPFXpZyEoWeu1hlcSaOpauRR4WG/lMuXqxCnfO1JYseQTCtoaeKY+vLnxrsMKM8d9JSHt5dZPXqoFRTkdzgtVj/bVj8mK59SryYCzAiMOIn/pLYoZ4SM0JY03b1nyYcsk4AluJNv2hSussIYkz08BCNZheylTZKl3NcYkiUlDTl02gWOLRklTQ4FgXWgk1qoRel3rzNHaoMri2NgUoQmJ/TlCWXOFShvP5Q6cYbtSr21OcEOCTTFHs/FFOmWAzGhiB3/Vnq7MCWDzMlNLZQeXyLVUABl3TzL9moTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SteV2fj/1tqjvsxT3BWmi8J7tpQHkhvb/96scmcUgRU=;
 b=oa/JD8OsIGWW/QvOTX2aFZWh9QRI8Ye2iFJFqfIziNhbG1mW6obNwJflovxZgiq38Qrj3vS4rvZ2H6vwjTxRL4oh3ezlPpqZ2b5bbQPgj4pbji8T6zlUgrZjgzSJrpUILPej0kFH6ubmoJ4HboS1LdoC1wm42O+rdmuhtDV5Jkq0IZkYkax/6ooVT2tHp7pMLssDuwPLDgyZVa7K1NI8gTgRw2kJqNypKcEDyY1hKDyvzLjmNKk31N8KeFlrXFTqRJLWXvkArNIbG4J3srffbjuGRCRi3iYB+hVaraE2oVlxnCYkBRCexrCmBAvP0SKRiBkbzwvplekJb7KBVcI4ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SteV2fj/1tqjvsxT3BWmi8J7tpQHkhvb/96scmcUgRU=;
 b=zXuCj0N2+r0RvMKvALT8LLYIcL/Z9VGTYpfd4rnmCbgnl0hvkDdgxpWcS0Sml2EMCmn+IzS11hE+cmbQVqfHLMLTs5c6RUCO2Nm3gGCWlCHO4l0gDXVA9yU1fdpsAYzsqV9MNTi4OQXLvXqJfdzZn+ZtuWErja6wtIkjJUZeZkk=
Received: from DS7PR03CA0085.namprd03.prod.outlook.com (2603:10b6:5:3bb::30)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 05:57:09 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::14) by DS7PR03CA0085.outlook.office365.com
 (2603:10b6:5:3bb::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:57:09 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:57:05 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 6/8] tools/power x86_energy_perf_policy: remove the invalid feature options for AMD processors
Date: Tue, 30 Jan 2024 13:56:30 +0800
Message-ID: <bc53456d6748a7fcb6a0c3ea3f136873fbf1d646.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e24534e-3824-4248-81cf-08dc21584bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x4MKI7TYMR9VWeatB/F1Ht9Y0cdCm/Ma8+PAYFLPq8LnLn+7bubIZY2fE70iO93SxWVXZG7tpG+zNi4Ph67Ew6hSBNiFM3cJRHk727WOF4YH47u9lyjS2cPkWrdz0eFUgR5XK+AeUw/dMQgvIQUoliV8MaiSn2x8ByNIhafJiH3hi6TEf56JBzdDzlWVh4M1Ked8xSnEW5BgNZyLDuFUulEWEZ8emL7qAolvtGAAef37tgwSKhsRKwqN0vjROJQ+HJQnuNSlmYKyHTrTvM3BgATMNsxqOcKcB9dftVD56QayU9gZtF33y4RxKUa/Wj9vDjdqkeDmP1kTWu2Be30FiQ+YML/uZScjUixEaGLlhAdmJD6o9MosdSSRWsqB+5Wd1LYP7jJ0MMlFVy2b2aEqJOjGN/IvG1nJgJjsYx1kQV/7cziPjxC5VN+kB2hPA801nl2xfbONCVoBMJ28gQDTXgaJPwrWrmsHbB2BVt23rR6RgRUFzf3QcAyk8he8gsaM6h1aitvOhuRh72vwmA45Q3vvNtrkxoYL9XBRCF/EWLyR/zx11yumm1IzBALalRIgqYTVG/9sMfUaz2dSIcJhasw7lZIgThBWZHKx+027lk3N4bsmY0Mz+iQEvCyzQGvGAQXboCkixuaZhhqeQjiDY+dtYL8CMg9f/xJCtx9v6CaKRdILPOmS0iByK7izp9fzGZdr4Bc8K1+LMqOG2X2jZFDK5114pzJfK1y8OPVtQ0RSv1UzTjhfdQ9EHb88W9K7S0kZDx6EzOIESmtlrY+L1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(70586007)(6636002)(316002)(4326008)(8936002)(110136005)(8676002)(83380400001)(16526019)(36860700001)(70206006)(478600001)(6666004)(86362001)(5660300002)(44832011)(2906002)(2616005)(54906003)(7696005)(36756003)(81166007)(82740400003)(40480700001)(40460700003)(336012)(426003)(47076005)(356005)(26005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:57:09.0001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e24534e-3824-4248-81cf-08dc21584bbc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

EPB feature is not supported by AMD CPU, remove the unsupported options
to advoid confusion for the failure result when using the parameters.

Here is the new help output with  below command.
$ sudo ./x86_energy_perf_policy -h

/x86_energy_perf_policy [options] [scope][field value]
scope: --cpu cpu-list [--hwp-use-pkg #] | --pkg pkg-list
field: --all | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired
other: --hwp-enable | --turbo-enable (0 | 1) | --help | --force
value: ( # | "normal" | "performance" | "balance-performance" |
"balance-power"| "power")
--hwp-window usec
/x86_energy_perf_policy: [-c cpu] [-v] (-r | policy-value )

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../x86_energy_perf_policy.c                      | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index 7bc668d22728..ada1aaabad8c 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -105,13 +105,18 @@ void usage(void)
 {
 	fprintf(stderr, "%s [options] [scope][field value]\n", progname);
 	fprintf(stderr, "scope: --cpu cpu-list [--hwp-use-pkg #] | --pkg pkg-list\n");
-	fprintf(stderr, "field: --all | --epb | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
+
+	if (genuine_intel)
+		fprintf(stderr, "field: --all | --epb | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
+	else if (authentic_amd)
+		fprintf(stderr, "field: --all | --hwp-epp | --hwp-min | --hwp-max | --hwp-desired\n");
+
 	fprintf(stderr, "other: --hwp-enable | --turbo-enable (0 | 1) | --help | --force\n");
 	fprintf(stderr,
 		"value: ( # | \"normal\" | \"performance\" | \"balance-performance\" | \"balance-power\"| \"power\")\n");
 	fprintf(stderr, "--hwp-window usec\n");
-
-	fprintf(stderr, "Specify only Energy Performance BIAS (legacy usage):\n");
+	if (genuine_intel)
+		fprintf(stderr, "Specify only Energy Performance BIAS (legacy usage):\n");
 	fprintf(stderr, "%s: [-c cpu] [-v] (-r | policy-value )\n", progname);
 
 	exit(1);
@@ -1309,7 +1314,7 @@ int update_cpu_msrs(int cpu)
 	unsigned long long msr;
 	int epb;
 
-	if (update_epb) {
+	if (update_epb && genuine_intel) {
 		epb = get_epb(cpu);
 		set_epb(cpu, new_epb);
 
@@ -1318,7 +1323,7 @@ int update_cpu_msrs(int cpu)
 				cpu, epb, (unsigned int) new_epb);
 	}
 
-	if (update_turbo) {
+	if (update_turbo && genuine_intel) {
 		int turbo_is_present_and_disabled;
 
 		intel_get_msr(cpu, MSR_IA32_MISC_ENABLE, &msr);
-- 
2.34.1


