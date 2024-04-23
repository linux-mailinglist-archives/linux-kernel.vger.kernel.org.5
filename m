Return-Path: <linux-kernel+bounces-154648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CD28ADF18
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8051C22DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E359161;
	Tue, 23 Apr 2024 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NA39QfMN"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C09458ACD;
	Tue, 23 Apr 2024 07:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859157; cv=fail; b=I3uh9utT2xJFh42kmJq4d+oC6xrUmqyRifUFzx2NMIEmXYkCE4Yg0zRd49apVuEQgZk1b2Dyh7bdh2MDqcUiwREKKyWRMRv3ZmS9MIH3hfliWb7gh3wPBW2GI1SbLY5b8J3hktr+xA44RRydzK6wZrPZaSCwak/4VJnDEeCMw0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859157; c=relaxed/simple;
	bh=yMZuIbGw42YjORpyBThUbZaZYwLpoIiSd88evb9PS1g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jn1B5gG9fQZUstXTQTiPQT7XM15scqcT3nSQAjU00SVytUQiCFfSomRtHl4g1bAHHrlOru73km7QcBoazEoz+soPsfZI8fSEYFE6kOg/EVxwa003ThDO54udIXwO54doB2n9vlp9LTPbgtBiwZHS3qF0Ku2RIHXCDhDu5Xae2Bg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NA39QfMN; arc=fail smtp.client-ip=40.107.94.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfX+mZayTMfE3E6JfS0ZdZrpONZ+6sA61/9eYc6QD3/dLecXX+Yw07FRQEB2GYnZ+YBr2Pz4aUvSbPuGypVYil6gv2uE3dUZvMBqwdN0q+Ny19Dntq0qXiIuz3Pc4nAkyearJB7VxFCDvwiPm7YLBPk6uz6cz9Xn+5akOAZL/5qlvh+ryKzMhK6FwACvPp2DmoZY7BlU/UExIf7iabXTIdslUD9gOC6XKWj6/ANlV7iWoRpMpuc/NEZlBYTSXh0wyenac+/5M7CAb5OZ4nUraejZw055gJQpyPYanuFGi7EMz0THnv7eL2ihkpH5Ooghhk5nHYCABVc+XMkpbzooEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NnIfoUNNUSgZSFxKZmxAZtt+uHq/r8v5ejdRJ9wrWCM=;
 b=I2dtd/zifhgihCJD+z1w4xpVZ7L3CSY9qgsnlh2tX1QcH1YVRFvVohmkyqzHivDT+mHT/Ylde5nyauG8VMADTgnPaPcd83Qt1gkVEtvuIcmaQbxrjAsGBpnHXL6Dy9M0KEmsxWys7wb7c8Zx1XnvK9IezKgaL4ZKK9NyATMw/24MiO280clR5HZBzed6EnBl6CJg3S8jfe/29HKb0SgQD59YdxEqb8oPVe6LlgCqYprG9O9ci410KgfB/eAd6i/IhO7w4ZKPmJUZ2qs6ATohU62PtXhcw1DfYflhUMqmOJan+NnQ06TQJdh7aZTLVyp11rBGjCYE/oHXTbTX++NrdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnIfoUNNUSgZSFxKZmxAZtt+uHq/r8v5ejdRJ9wrWCM=;
 b=NA39QfMN+GocqaSkmXI/1KB+eSn9peizNQo7Nz+XhM2yi5+ypdnlxd/UOSv8jN5wn+J3g2Bl07dFTak82BzorAKcXIV3ePrL4lZGPkL8BKvgaY3tDSQT5S9Lb2kUV8wSWBRwK3lICxhXM63wOhur6JQDJAsCCzx3ZTtklXHUIu0=
Received: from CH2PR03CA0030.namprd03.prod.outlook.com (2603:10b6:610:59::40)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 07:59:08 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::fa) by CH2PR03CA0030.outlook.office365.com
 (2603:10b6:610:59::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 07:59:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:59:08 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:59:02 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 7/8] cppc_acpi: print error message if CPPC is unsupported
Date: Tue, 23 Apr 2024 15:58:23 +0800
Message-ID: <c19cca9e807db4c626b5c3a52221f0d072bf46de.1713858800.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: bc5a5811-8ef5-4c8c-702e-08dc636b40f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QbWHOWmlE4IjcVSRGR/3mb67RedpqyPvFGn2Xc5vwNX9qK6qy1QJxexMD7Bl?=
 =?us-ascii?Q?cW64+//VcsGSx3BK15Q65lAUy5YIt4MzAONC7UFWe37AwXy/T6Ube5b+ij4J?=
 =?us-ascii?Q?ImyK8l+/rgiTk66kxo+6s5t/TR8KuyZwxfvOZp04/DIlOcV3Hu1pbXARCWTA?=
 =?us-ascii?Q?OSs/0R0qvm5xKjBsKwWZxEic972+c+3p6ciVYE1yx4rFm4WuP/mDbg87C0hh?=
 =?us-ascii?Q?CQAouYLxaPtOOWdlHdq5Mr9iRVICAF8NnopY52jKUB27H70arXwU0dh0b7gu?=
 =?us-ascii?Q?yjkiAS4m3eGiiZApzyKN73DGWb4vN6kqZJNh+3lQlgiKLTZy58fwqlHx3WeX?=
 =?us-ascii?Q?fLAViOzgzZew/I8ePolNfLr7C3tzn1PcO4xbLcx7DvacWeBlir+GLDvTpTYT?=
 =?us-ascii?Q?fRzTZghQ9wtCku6cmN1sSwQdBSImS5Vg0JTLAoGPlE7EP63Su69vbWmhe15S?=
 =?us-ascii?Q?wl4w5bTpjXi9L3Rr6VmCBtamzTl5+011A6ddKAo2w5s9UD/XvrA2Dj7z1uC+?=
 =?us-ascii?Q?wrEk02pjGlbajj5e5Ai+n/EcktX+LgpKuyrwgc4wiYSXzqztkyHxYfiFpk2C?=
 =?us-ascii?Q?Bsz67dTgJdC0AzuCSQXiKu/OS7jbrvrx5IrWDkOUklzAtHsi6KspLLJtSevY?=
 =?us-ascii?Q?8GEQCVUN5BcWVzN/OqxEJJ0kQZfXAcLlpCGdn5LFDDy6zmydSWMmFnubjtDg?=
 =?us-ascii?Q?o1Rj9EkkRFq8bmxjgpM/aDTIQFu6pJeSvB69JmrMblLvL5x/BbALpZWxcZdC?=
 =?us-ascii?Q?jVPG7BkbUfssg29xLJVmxo3K9NlIfTooHTDAOMqu6UCkhi1MiM1YXNWLDpWw?=
 =?us-ascii?Q?xNF6Bd+RS+wltQC7sM6JMHFGjjtdwmJ5CGrgVKCrcEWsxe+DDURFuGMkZDHP?=
 =?us-ascii?Q?T6Lyh19wMLXGbNNQRPZ/lK4bItxP02frCtPzpsu+rMxG77OTz/hG7rirgFIu?=
 =?us-ascii?Q?tUidCptGwFv3lDDCaqvr7yLFtvu7JNdk2k2N7rGOUY2Xo8vz4hHO2fzWuRtF?=
 =?us-ascii?Q?ISz3qB2+o5MsZL5QyEVRQ38sJo71zev1lIQH3yzMGfglPpqLy97Gjy5Sjw6l?=
 =?us-ascii?Q?8j+DdpI/JZG4MTKn6XipuBuWAAxn8AIpsrrC6MfsvOx2sKNtMMbYmjb3Udm1?=
 =?us-ascii?Q?W1N0gDoZbTj0LqTlKPh3dxZmG9olAThYfqYApUMCiTME7bL9fu4esPZOKKzF?=
 =?us-ascii?Q?mzXgHjI/QlIYbrNg3WjO7LXWYY/1tQh/Fqj6dP/Iy0uJylynBYYANNa3AgGi?=
 =?us-ascii?Q?2Ml8PAoFIyN+jxbMy4sbqaFPAAjB+AEjmfesxeH7Wwi07WM5Tg96jzzApfS7?=
 =?us-ascii?Q?w1iRbZHd1WUaRHst3kSgxFUtGuzhjyHeTXEhbczcQ4gmUoUwokF4Wy3ml+7O?=
 =?us-ascii?Q?+unhj6cXpRF2ZS+xXYgcXKX5vS57?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:59:08.1358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc5a5811-8ef5-4c8c-702e-08dc636b40f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048

The amd-pstate driver can fail when _CPC objects are not supported by
the CPU. However, the current error message is ambiguous (see below) and
there is no clear way for attributing the failure of the amd-pstate
driver to the lack of CPPC support.

[    0.477523] amd_pstate: the _CPC object is not present in SBIOS or ACPI disabled

Fix this by adding an debug message to notify the user if the amd-pstate
driver failed to load due to CPPC not be supported by the CPU

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/acpi/cppc_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
index 4bfbe55553f4..3134101f31b6 100644
--- a/drivers/acpi/cppc_acpi.c
+++ b/drivers/acpi/cppc_acpi.c
@@ -686,8 +686,10 @@ int acpi_cppc_processor_probe(struct acpi_processor *pr)
 
 	if (!osc_sb_cppc2_support_acked) {
 		pr_debug("CPPC v2 _OSC not acked\n");
-		if (!cpc_supported_by_cpu())
+		if (!cpc_supported_by_cpu()) {
+			pr_debug("CPPC is not supported by the CPU\n");
 			return -ENODEV;
+		}
 	}
 
 	/* Parse the ACPI _CPC table for this CPU. */
-- 
2.34.1


