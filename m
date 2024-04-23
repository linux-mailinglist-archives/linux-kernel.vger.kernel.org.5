Return-Path: <linux-kernel+bounces-154642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 982B58ADF0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E175B22DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C90548E4;
	Tue, 23 Apr 2024 07:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SHMubgXB"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E6954645;
	Tue, 23 Apr 2024 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859130; cv=fail; b=kNa1j/BJ1f/xcZkxH2LKq8YGmnBRS0DiovTPyxhdd603lrxZFKHxTjnVU55+a28+CXw5pLjc2TSrd8VGXXeYgAYHhb6uwLWndsRmSZGDbvrAsK7AuB3ru8oS+OyeebjP1mm17hBNQ4li8J9kgvWRgvgFu8+UVbpVNIftqHZVexc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859130; c=relaxed/simple;
	bh=7qVpJHN69a+YM7VR5sMzFULPFNuxFuQfsn4vU1YeY4c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iupX7H06aL4D/zvlzMl3E80MuAEeRQ3aXJnGdzMqPAGZL4vQpgrSl2qzrJ9oq/AuMwMeoGkKXMmZ3akXRi5nMHcD05Ny22Qq7BG1hWp8xYREMnOW2XvGO9FDmWnzJ51XvtQpTQS35UOmumoUA+5UN68c7ex3/gkuNZ2/DW+k+YA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SHMubgXB; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F81n6tzL0IAksGZ8JOrEYUkwa5mJTIfpWIxQHuH2a9J9ey0CX7/S0mlOA5j9otXi4r52PT7ejYKjRbOXmXRJcjr2P08Gmjln5XnqvGSvAYaht8DLBaAhK6o1WsddlFIkEuJSzXEOgpVXPd9lhRLCwpC6vXCzYNnmhYJTwn03dDeV7EKyvd7wuKj4djZoha8P7o7MXWv3Jlm4pArRmbdZB4l+4d2/9WwdyanN7GsfgZJ1HKoUvl60DGNhDxnJQcYCsOcolARMZgPfFnao3G73j3TwJF8MzsZJBjjxYGxxvy+Xqn68bVPbwgsubuvOUe1etJSSfptyqm5p9w1kiFCQAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HXeCwDP1hShOrQ2Q2cbuT0Gosp0Fwy3kjqWF577x4k=;
 b=QGoUCcB6Kw9SCdRybkUgOFK72c96oGDgpk/jyP3DYJllQLXFfCE6oBoOlqJX55ptruoC4xZq5wAIS8jZyIVTER6irUH9YZB5wO3OI8xY8lvPjzmrCkMw07/OaGnSuRmOqT4L7vfO9pcqZ+HLDtNTJwqrPjopd4AVU5e6djZ7s8oMxH1u8Dzy5OU56CBE0sbd6rNn4vORURu8SgUlaWlmwR9n2JrOmU67pOmmysD52RQXSgyq3x4aymRZwvEQUHUfto7E8vcMZC66ZskWN+PeBjQDiME6gc6GCEy8xLt+gOdYjCo/ZOD152NL3WqU4QKKG2gZeNAfVxcuiN4FM7nUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HXeCwDP1hShOrQ2Q2cbuT0Gosp0Fwy3kjqWF577x4k=;
 b=SHMubgXBFyEpem8R78tbMVBPAQ+839spSuCM4NcrapO66nSysSrXLjRuStXIMIW82UEPmCcY4p+PFI2o5Z5A48UZs5lk2YJD2hqRvtlfZ23VDB1XzoE1q5gYtbtOCgYDH1yZk4Jrr/pt5hPLYNNBYbItDLyqvQvvQE4u/I6gIbc=
Received: from CH2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:59::30)
 by SJ2PR12MB8829.namprd12.prod.outlook.com (2603:10b6:a03:4d0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:58:45 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::a0) by CH2PR03CA0020.outlook.office365.com
 (2603:10b6:610:59::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 07:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:58:45 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:58:41 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 1/8] cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
Date: Tue, 23 Apr 2024 15:58:17 +0800
Message-ID: <c50374885172571e1c25d95552dec8467c37ea24.1713858800.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713858800.git.perry.yuan@amd.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SJ2PR12MB8829:EE_
X-MS-Office365-Filtering-Correlation-Id: e361bc8b-6b1d-4f79-8f28-08dc636b336b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZlcU6X9+Do5cQ7NGC/t52bmrC22Mup1MbcbaXNdcYFU+RX2MP0y+R7UnmfEq?=
 =?us-ascii?Q?AnEO5S5IthynmEFGTzvmSB5sbbdMFVprysc3NbRXXnTDDDJMikusadZeRrr4?=
 =?us-ascii?Q?zEWmkZz9VInGNq2365KtIn/x3OTDtwsB8YQdxCwNMT3TiMtlNTrzNsjRXqKI?=
 =?us-ascii?Q?0fKdKkOo5kvh8s4WdUzw0XJjr26Lckza9qbnEQ8k7QVoTsWH+0ASsVyruRmS?=
 =?us-ascii?Q?tjmaip9QZ/zQPQWdLL4d6QBIYRodMVdeQWs3xsJHbIazsKBvGv8OCA7P9Gur?=
 =?us-ascii?Q?Ei9AoamWcW0GCdCKfm0X/5x3WNohcR9/RYTKJuZSrT7oeuTceUHilzA6x5Zk?=
 =?us-ascii?Q?DS+F66f/AB/aK1zW7iMcecrjFZAapUwi30ZE0Wnw319a5o/JD1/Cxo7ieKMy?=
 =?us-ascii?Q?LfaR7Bs/i1PtIVzBYg6i01vLODXtlGMdxYzE2EsJidBUs7vBCroKeBVEsKCv?=
 =?us-ascii?Q?/OyOARef/sUWSCViYLaiEYR9gzh/4eCypRVuvI1ZQMfLxcYOL1jZ8BbMGz44?=
 =?us-ascii?Q?9NHhrpG18h7qEXHsmgzwwLEzHtgy9JAtKhVdn3I4TCk8zZjBhOuKylQtHe+H?=
 =?us-ascii?Q?JGBoJgqcDVTkIsNq7FQqO9KaF6YnGwtMnUZjbDmVsOdzOKA0y82FcsQWB0i1?=
 =?us-ascii?Q?rd4FZz6IiLZqgoC9y8FCGBVe8jp/MzhfcQuuiaxRi0jRcFgjitHplbI1qprn?=
 =?us-ascii?Q?59mR8ojzGXApkJJ3GqAZsxws0sZoOKMsmTxkuLuETim9iqqgkpWojrWZrSQ/?=
 =?us-ascii?Q?876jKBCiFA3FvkmO4uggbRzHC9N5lBHtaLodhgOOR5jK9TJYfWiRYMG02p5p?=
 =?us-ascii?Q?hOJnLIacfSMN37UXqnAXbxIllYm2K8VmfHPBwLZAJFUoSv+J/+7KyUPMkyql?=
 =?us-ascii?Q?gNJmjxRqXN7bX0zQkWDaSOaigSu7bQFjtndjOcFqUyOItiiX2od4B7rWc4ap?=
 =?us-ascii?Q?RvIPCCa8130b11HYZbawlLl/GrRnxuPVVfAC2Mv+6U/CJGc2t+FCN/iKP13E?=
 =?us-ascii?Q?lvZtQFJjlTG8ihg9ms5Hvcbg0c31OTA8z64b/cUQXMvMuPxPG7NENGgJUMXn?=
 =?us-ascii?Q?KLEsLUzpfrMxDenBlKUV7nkR3xB2ecEl/Cl1/U7qXQT46qHjOSRNKqSSne8E?=
 =?us-ascii?Q?I2p8Pjhc/XDM46hd5wmfL18UpT4WGgsJSz4yItFmsHPLuC8miCQ49Vlw9Cbj?=
 =?us-ascii?Q?QqkaFIBaMBzlnqSEiHHmCMsSIh+mujFJkf+qfVywLOOB3BNxBTHMfw1VcTg7?=
 =?us-ascii?Q?eVEsGRQi+hzdk7TCcZq0vl2ii7AQQaC+8XV9JpAzOmKbeHJ263rbw1QuzRG/?=
 =?us-ascii?Q?/3mAHF5rdl1JFDfDsmzUY6WmrefxqsGXpHvBgJ5tsX1oGqP3EuQnVF2WJizn?=
 =?us-ascii?Q?qtWzDYZb5WpO9MOYmZWlX6giUX3g?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:58:45.4480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e361bc8b-6b1d-4f79-8f28-08dc636b336b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8829

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The four fields of struct cpudata namely min_limit_perf,
max_limit_perf, min_limit_freq, max_limit_freq introduced in the
commit febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and
scaling_max_freq update") are currently undocumented

Add comments describing these fields

Acked-by: Huang Rui <ray.huang@amd.com>
Fixes: febab20caeba("cpufreq/amd-pstate: Fix scaling_min_freq and scaling_max_freq update")
Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 include/linux/amd-pstate.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index d21838835abd..212f377d615b 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -49,6 +49,10 @@ struct amd_aperf_mperf {
  * @lowest_perf: the absolute lowest performance level of the processor
  * @prefcore_ranking: the preferred core ranking, the higher value indicates a higher
  * 		  priority.
+ * @min_limit_perf: Cached value of the perf corresponding to policy->min
+ * @max_limit_perf: Cached value of the perf corresponding to policy->max
+ * @min_limit_freq: Cached value of policy->min
+ * @max_limit_freq: Cached value of policy->max
  * @max_freq: the frequency that mapped to highest_perf
  * @min_freq: the frequency that mapped to lowest_perf
  * @nominal_freq: the frequency that mapped to nominal_perf
-- 
2.34.1


