Return-Path: <linux-kernel+bounces-43885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FD9841A63
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B33F284407
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F8C39855;
	Tue, 30 Jan 2024 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0ZlzXSXQ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C838F9F;
	Tue, 30 Jan 2024 03:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706584778; cv=fail; b=GX6wXXLtkEiEXumKEURZsXgA5zgJ9gP+kyWW4ZWyjtg5ukcVPXxR7ipTjsxG2+Wg7m00JavhHvlmgJPqHGC3AMjzvI5ieF/7FLCyWFs8pI+5OnDvMW5gIa/uzX2fnHPE8PEIKlAxtNDy2C/fgSY4FnpkFQipQ/+eUKeWD94Zh10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706584778; c=relaxed/simple;
	bh=XyjWnshcEDULNzAsOzZlPe3A0bFLAu46xTf90O95YoM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ll83lxhLCVOHOasaHj0ShPoNQV5xuj304U2LSFZap7OMI7CVaTIlXlEbzn8MlxzRGajAVZ2Ds40iW+SODRgrtRgMfzxGHmt9CHlxNCPGWPBwvuXxRvhx1f1Rz+1Vt8/x6QOQR8MvxIirrcRAJcVTjBhfNHNIFNTwq3gCzytbURs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0ZlzXSXQ; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mYsR5+t9DyzI+5mL+HeWEEzaa6ycUKRuJyejoLjWazMHUJPyEG4Iol09dxN2CG8H4zkUXDu6CHaglccSm1A2PQM7ZVz83jJNtFB3KR2cZxl6bsI7KnkZ6q0yNJEbICQkvhdUf+rzyOu9dSsfFH+X9NU0IehCGzS9l7UI6PuXnxRYKsHMM1AdMBA2k+irM9+VwappsWg2xBvyITxHViCvA+33cXFk3VdnlZ1f7lxyEoYwKPwUl3wJrhRiCMbw/KSW/W5hgk92vq7L/P1oyupC7veiOdcThUq1srQI/9pQnqzMoBvFhrsKJT012/SQpE6JoDzoLcWQEtroYBEIEdyOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SteV2fj/1tqjvsxT3BWmi8J7tpQHkhvb/96scmcUgRU=;
 b=XHpkTvnkiouxqYA5N3/NJbnyYKHa+zCha5csjQ3+UMkFpmt1siVDbe0gWkov1pxVyLXorPnGxp6nhp/FbUoQKkmPOkM+d5OPsYKTmymnRY7P00Cj2lpBGchalV/TrCw5UylSf3wOl4kUUaDJV2DbUn3ZeJjfIRy+jlRKPXLM2DAlHQanWYmialrLC9MT2jJ6bNna0zjiiHLJme17p39890J0SG4FA+nxXhsA0eOW4ojinCNy6XNc80JPrMtGp6zI8uqOlNnNowPX0Y0UJxHu08QFxNqQXfiDU3A6eWJlf76i+QRmnB0jmwF/ssoevrPeVC8V2uSBUDKzwPh9do8tBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SteV2fj/1tqjvsxT3BWmi8J7tpQHkhvb/96scmcUgRU=;
 b=0ZlzXSXQVEFz45PKno52MAf7WMgE74iqK0QTZBvpKsh/rWFgMnl/ODHLstZ9J7qzYXZAodD1IWIn7QWSBDa6SLCf21Lrw4cwk3GKbCnxgevl1zij2jipNsuhc0oQw6mklqgLJGjln2KBZrMcqgTqrOl0THdIceukjuvUnON4NRU=
Received: from DS7PR06CA0045.namprd06.prod.outlook.com (2603:10b6:8:54::26) by
 MW4PR12MB7309.namprd12.prod.outlook.com (2603:10b6:303:22f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 03:19:32 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::8d) by DS7PR06CA0045.outlook.office365.com
 (2603:10b6:8:54::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 03:19:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.79) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 03:19:31 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 29 Jan 2024 21:19:27 -0600
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<Borislav.Petkov@amd.com>, <viresh.kumar@linaro.org>, <Ray.Huang@amd.com>,
	<gautham.shenoy@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 6/8] tools/power x86_energy_perf_policy: remove the invalid feature options for AMD processors
Date: Tue, 30 Jan 2024 11:18:34 +0800
Message-ID: <18bf21eb8c1bba3ad86acb0c88b531b0b43c3339.1706583551.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706583551.git.perry.yuan@amd.com>
References: <cover.1706583551.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|MW4PR12MB7309:EE_
X-MS-Office365-Filtering-Correlation-Id: d65ea6dc-11de-4310-15fe-08dc2142466e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TTDUDc+dBkxYEjuAQHT5VbtTIz4nwhgrspdYOeWxhz4IUmmBMwXP0wcTwnN6IvOv9LNuEf64u2LL78NgY9q9PEyBUuaOQimDMp3QMTuE6cBdCuhVONRreu+iqSPhmxglic7+n0BzArYYC2AvsT1JAb8sFjXLDrRzAKrhDKl6FSVKmv5NloVH90VXj/ir09xq+hfUXLPjFu+Z70LdsQ/Az5/fLc9ObkC42Tu7U019IYxFpd+1ei97pLdkyZVDbf9bWGswZX7khPws9hd4E0bhI+YVEUQ749ZawRNqCaRWm3tiz3LaIJnU7Ncn4ILqLc8geuIYVBNOD7eUNXw0fh5HGrTLwwZszjYWT45+ic1GaceaKrWHKKUO+SXeqglYzfY/9kEJl/Ly3KDKdRp1zJp9dYMxQKvygAjwjL/dYSVVNdif/IQWtMnDTujivVbQn6EbtaMiQ8keg+sURt8jWjhonIjmphwxZb0AfI3Uponpv9goIez4wYpMR7/X9nOeAZrxu3GhJ/b87QIo8Hubh8ZNloULiUUa+epgk8rfDCY4PsNW+QItSuvlZG3YO9gC1BDfr+ElpfjunLWcHenkyUW3KE3ew+OYp4XUWZnICcNsVOX7NsL43ek7vVluPT8Le1aWMeRQw+SgfKTX4SRuxPtdhOa+nesdNqALCOgK+nxKSblEnILNnyU2i2G7XcozC5y+UOCyhK+uCn2AnH8B2mpOBoV5ayjPullyUS0Q2Ia7a9QOlWrgopgZQqSjffEXgQDwgwo0PuJKYYPdRcWBIwt8Tw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(336012)(426003)(2616005)(16526019)(41300700001)(40460700003)(40480700001)(36860700001)(47076005)(36756003)(6666004)(478600001)(7696005)(26005)(83380400001)(81166007)(82740400003)(356005)(86362001)(44832011)(2906002)(5660300002)(110136005)(70206006)(70586007)(6636002)(54906003)(316002)(8676002)(8936002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 03:19:31.1851
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d65ea6dc-11de-4310-15fe-08dc2142466e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7309

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


