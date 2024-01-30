Return-Path: <linux-kernel+bounces-43966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C56841BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2E01C251AE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969A554FB1;
	Tue, 30 Jan 2024 05:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Egt+P5rZ"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2047.outbound.protection.outlook.com [40.107.96.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C69F54F93;
	Tue, 30 Jan 2024 05:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706594238; cv=fail; b=TleIg+bdIIHRDo1kd5dxgsVqsYHBTaUAwQUwSkhYaoHBzjeVhWCaR9i8cPKYqgpWP5PqIJ/qZhZ6ULZIOKgjxBJksa4JetWyS525iuOdd0Z8jeEGhg3mBWqFHyByQ9tmQMhEd7edTCG8eRanTYGOQsCGH5t9GRQxqXsR1j6zazc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706594238; c=relaxed/simple;
	bh=612kO+TH6TlNm4ODdMrCES1Lkpwd9h1t0jXfRl79f10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtq9anbDLOe/roEcBUu1QD/owjRwp4Uqp1qhwlfc5ljbazOE98dOVhWfeN79RqX4Q3pJ6iirbvxkB/svigesEPJce4FWjo/SgIgaGu0NitCiBUzX9/dAlZkIelnFi9vtvA3tNJi8vAZotXKTCe18yiCBaR5OOWgSBKKw9dQtrOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Egt+P5rZ; arc=fail smtp.client-ip=40.107.96.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XBNXksSAuWoP9QpHMAfdy3qYIdbuP3b/EnFgilb8imG7SprkxgDTidf28s6XBDjnCYAlKXt5wyUqYyaW8KOZGLrfbN+OQ6tPZxv0HE9s7UyfiQjaBVJ09c9ItApbD33Crheyxf0OMfVFyc+NwD0c7exEF76SOZ1tD/9DCHJEhMDuIOw9gyEubCV00R8phF77nEWyjHrsovStueVQu6owHH54IJ34Qy6XBY+vszOs9BEEi+tpA03uW5r/qYT9pBSOdjIygISk88Egjp/pcWVQX17p3MC0/BENYaKjAHwvoM00yyYgafv0Q+syEll1gsmf2teFoV7A7NT4gZYSP3xKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y51n67YWs6bh5EFkFdb8SW3bQKZLCzt2euRRQ7ae0J0=;
 b=Q4Zn9xwLgqlSIpI8B7fjSkBH7Vfb/m18e4hAhgvmBRamE9nqIV6NGtz1/7wD9aYgbLSu/k+oagja3EX60k+kdcsz7nf2dDZiPapy4BAm3LuH4LVVfBe/MJ6alxtPTyMInroGiw+Q0D3cCyswsaonUf0DLI9FjBWQgzQw5rpcOFViVUwL8YYeORieqdALuPfGfs1TXi9YH9m34wehZlroR9RfqGFLvLjaZX5LdxH2TQtO+QxtHTWQtrnWmXdFiw6dhofB9LzSdcU0oqn19YXA9aKNrvqSCPcG7FNA5eewDxfoDnx5IRf1uZIkd4hVLX59i/2An9JZQWqsoqb+G/zREw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y51n67YWs6bh5EFkFdb8SW3bQKZLCzt2euRRQ7ae0J0=;
 b=Egt+P5rZct3pUuzIWJ0VvBhYsY8+R897Kou7meDQGi/oVMPCp1B/w0nMyvSx61lpmyd+RZ24m5MtkYymYHELzRKDcDU38IRIxc2kyWFiGvjuynuHrZjoRpuDrQvBDEOYlWaKI+l0HqImNcT45HYi+gPBjnCBU3PVJ+4vAca6Er8=
Received: from DS7PR03CA0079.namprd03.prod.outlook.com (2603:10b6:5:3bb::24)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 05:57:12 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:3bb:cafe::77) by DS7PR03CA0079.outlook.office365.com
 (2603:10b6:5:3bb::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 05:57:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 05:57:12 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 23:57:08 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH Resend 7/8] tools/power x86_energy_perf_policy: rename some perf output strings for AMD processors
Date: Tue, 30 Jan 2024 13:56:31 +0800
Message-ID: <5f70fe6c01a05dc355d6a0e47d32d5e24500ca82.1706592301.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 033e266d-c827-4043-082d-08dc21584daa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wh237xJc+CYUaSaSdg7dzpCswQFyp3X/IZqf0MynB4LSH0me/h1tQC0R312Co1+Ks5smRBIsIsyz+qgD6hSvounZVA4wVquz6gB2RXh4glSs6SaeqcBf+kvSAy0pJL18/TseDJRxMvEOoNiCmX9yQnhkzMA5T/A2IKWMhAO8c9hWwZWrnhalrpAv0WdshD7IbuTmdq0j+rlXKdedxG+3PRp5rr/tI/775UQhyufhi+R8O1sO7nl/p8j1oKn8G6Y6uGkuCi6a8Ovps6WLeyFW+sNuir2d3MMfrJIS8qyJwiP26sZ0zmUnaP6iAQAESostS5eldtM2HzqVvP6Pu//J3zmxO5Z+kH8HTMVL/dvjoKufWqYvS7RKDwnPOxygqcMJN8L7cMhnZJ1bJ8iQoiEccIAtetVLgoT17OcTC9HfR830Kkx6l+xLC1F5WhyydDfxyozC7hhWr7SGlmD+x7k8UuhvVjtkP81GxGoSDJtfySETjDKzbJ+1DDAkJN7pAl4xlQcYtEb+7+aGJdGBYBHQqETOMp+dlCVCNhHBTybWhe8BxX5xs6M2e8nmwV52S7Uq5RUIA0O796sS2YfEHeGDq8YPyWYhTkIlgcOu85SIwaxigm0Q2thkjJnj9ea/dSxlHjyZT9/B6MtZPxBuD2wIL17RXR2hOXAIk/eVlehhVFWjAuPhWlmwswh2g39rX9u3Joec4ac9br2tGyq9GJnZ83aGHzIL6a5SCrU9FpQnj5vh2EKeI3zl2TOujpOhOr9RSN/7K1q1db1Bs2ZoejLg1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(6636002)(8936002)(8676002)(4326008)(44832011)(2906002)(5660300002)(86362001)(110136005)(70586007)(70206006)(54906003)(36756003)(36860700001)(47076005)(316002)(82740400003)(81166007)(356005)(7696005)(478600001)(6666004)(2616005)(83380400001)(16526019)(26005)(426003)(336012)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 05:57:12.2501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033e266d-c827-4043-082d-08dc21584daa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794

rename some perf strings using same definition for AMD CPPC performance
capabilities.

cpu0: [AMD HWP_REQ]: lowest 12 highest 166 desired 0 epp 128 window
0x131497d0 (80*10^7us) use_pkg 89

cpu1: [AMD HWP_REQ]: lowest 12 highest 166 desired 0 epp 128 window
0x131497d0 (80*10^7us) use_pkg 89

Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 .../x86_energy_perf_policy.c                  | 23 ++++++++++++++-----
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
index ada1aaabad8c..845cfedab06e 100644
--- a/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
+++ b/tools/power/x86/x86_energy_perf_policy/x86_energy_perf_policy.c
@@ -864,10 +864,15 @@ void print_hwp_request(int cpu, struct msr_hwp_request *h, char *str)
 
 	if (str)
 		printf("%s", str);
+	if (genuine_intel)
+		printf("HWP_REQ: min %d max %d des %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
+	else if (authentic_amd)
+		printf("[AMD HWP_REQ]: lowest %d highest %d desired %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
 
-	printf("HWP_REQ: min %d max %d des %d epp %d window 0x%x (%d*10^%dus) use_pkg %d\n",
-		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
-		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7, h->hwp_use_pkg);
 }
 void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 {
@@ -876,9 +881,15 @@ void print_hwp_request_pkg(int pkg, struct msr_hwp_request *h, char *str)
 	if (str)
 		printf("%s", str);
 
-	printf("HWP_REQ_PKG: min %d max %d des %d epp %d window 0x%x (%d*10^%dus)\n",
-		h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
-		h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
+	if (genuine_intel) {
+		printf("HWP_REQ_PKG: min %d max %d des %d epp %d window 0x%x (%d*10^%dus)\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
+	} else if (authentic_amd) {
+		printf("AMD HWP_REQ_PKG: lowest %d highest %d desired %d epp %d window 0x%x (%d*10^%dus)\n",
+			h->hwp_min, h->hwp_max, h->hwp_desired, h->hwp_epp,
+			h->hwp_window, h->hwp_window & 0x7F, (h->hwp_window >> 7) & 0x7);
+	}
 }
 void read_hwp_request(int cpu, struct msr_hwp_request *hwp_req, unsigned int msr_offset)
 {
-- 
2.34.1


