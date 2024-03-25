Return-Path: <linux-kernel+bounces-116447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91AD889EFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:22:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B741C35D00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA055A0ED;
	Mon, 25 Mar 2024 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rQPwXJBF"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8065439000C;
	Mon, 25 Mar 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711335858; cv=fail; b=YEV/HthA08kAZbbaX1FZYmHoZoZTb0Z9+hx7GXofNRqjm6nh4RA8oEP9s4GEuDGk2t4U/CLsr+xXagywd581EO6Tb+SamMgvpp9yrmFcZgD3+4eneIbpbdxK149/USzJ3Md+vSOTfMbX+By2hanABmsSyqpCE3+9MXxJG1A6V1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711335858; c=relaxed/simple;
	bh=UeWWdRtmXpWnFKXehz2zu1BULegoqqUWOsJeyXwPLtU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9vpNFeTtFCcFj3/FzxtKpCDg11odwZo/VMLNNB2qNy0+CzAWNNmOlol5bXOyyDlZBttldEeOn67zTCrds/LChPzCoJFGyog2DOk8bG+a0wPzAK4EXUDYzkAWuHZZScbjoe5Jm6nfXB+SeQLFDjuNsSoplVnOLiN9ZHGu8ZYrgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rQPwXJBF; arc=fail smtp.client-ip=40.107.94.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxGt1PNprOUXO8CRLZfUEbf2+lN44MGa1ZmcuWQitihg8LwwIDQ9zmF5n4WEdg1pmjGTNmOyOAj/l+iI7dURcMyYtUsSvtOUcS4QDitHnUzAJHcVjciFO8/9mWeAgIKxiD5wgPgxOCJAxuTA1HNuMo+Z70sJ2g7EZWiBwJcVH2FdQLOZ0IF42FTjW5Ue2ytykPL7PmVeFshUJ5NuDYnbcJZ7s+uUG2W8/hclI4gPnMjq7FLgtVmE5OtJOSQeQ+rLnTUK8i3by7lTj4HJWDDMgrPskAme0Lmr1eKg6XnKLPi0LvKkpNx99VQgHgw7X6WWxJwqHiTD/xNYpzOMlKodTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3PdaOYmZ9vrYq+WiGhyBTG4wUJIEr5G3HmebMTWeCOI=;
 b=HJCFiSbuLhcrSuPaiW+LcyuguMn3TodybZ891O1qlN5IBs2/BdTRQ11oO0Ca/h7c5a3WN7AbDcZ7h3g1h5A+qJ0pyqeCkUKMSCIJuxKnzKLfSaXcpYYBbRSw78DZTsMMpOz2BGVaHlCau0vGuXKQ4il8Ym0JX63WYhVx+KXhRvFQX/teFkIXX46z4cVwvgG8eqdeE6TJRtMby5JPTX5P53kQ52s6oKd1WN65U6ocMkQc7G9EIbyMY8SNTLV2XD+amTARGkZgBgH45rmMIySs6Jh5ZO4Flme9fzQVSqIdq1NVwbHuepNXojemIDL6KEoFNl7biE/BL5Fv2nKKYQHkZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PdaOYmZ9vrYq+WiGhyBTG4wUJIEr5G3HmebMTWeCOI=;
 b=rQPwXJBFrf52z2U9G1OsZ7U9OpwRGqCfLjnMeNQysPMpRZDb0KGfXcAuVkP4fPMMa3zbduQnX0viVMYCBtN6qRQPN8HGbAuUhTv1UWY4PtZC7kKct6NPtrk2SciIIRUx6pj1QpsQIiwp9uAsnUpnRSn8ynN7lpghfm++xdzX5vo=
Received: from PH3PEPF000040B0.namprd05.prod.outlook.com (2603:10b6:518:1::5c)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 03:04:12 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2a01:111:f403:f912::) by PH3PEPF000040B0.outlook.office365.com
 (2603:1036:903:49::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 25 Mar 2024 03:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 03:04:11 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 24 Mar 2024 22:04:08 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>, <Li.Meng@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/8] cpufreq: amd-pstate: Document the units for freq variables in amd_cpudata
Date: Mon, 25 Mar 2024 11:03:22 +0800
Message-ID: <87c6aeb265a0281b3abebd07ba2069d80da21944.1711335714.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711335714.git.perry.yuan@amd.com>
References: <cover.1711335714.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: c19f74e7-66ab-43e6-e881-08dc4c783f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	spyg1Me2qcNtqodwAFSVUXyfeMxs0Sty6Y74O+nkxBWyK3uqYTywHxe9dQ22v5As/hguEXE2FdSxBHNyVKqh98C+9CaEE6ZVFiqJW4+7mCoOx6VI3OeSt0nvuxM2hQfDmvBX08EeqSa0i5SBKtBHsR4KRFTUda5dGZRhy9oBUIvBSD+W63OOy5luxVQ/Khhu8qaPuHPakJY/43IpRFjrVvlF2s8Frx/IJ3KOsb7A/FyidFNhaG+77vLskpfViYXe2LyaLUKKlPcAFMg0bEXSG9kS8JJCRfK3J2qb0omKIJCJDQXNUBIjHmMcMexoA4o5QwGKu/muK5cCK89MYjTYKwac6eOGgDbMI6ObtILaPjqpmvIurqZy/0wBpkkHYpjSX6UpEw7u0gcFo8Exl8XXD9UQiUHNJUVkRrexUxHoDh8/ZUjcP4zle7ahWmi4MlS+jkmc1EJM1EeMP4tLmWFRxltBoC+ROX3I0rl9+T1TNtddbItRmAzrvCOSb7JNAgIg7v5S9L6lGftNTKMBjifYsfCmZjuUwxXALqunWuhsUZttgGBIZTmtaOmEDJ94khU/idoSBPNymSsiV0R3LJzOlFXKluUcahGRoJaVeWdMv35m9DV4s68Y8LIZEm6AxBi7dbs1kSoM+CgsKlAgyAsr/R/OL+sLqz2ACY3puwO7nWeg9j8lYctvBy4riK+impcWxpP+XGo79o0z5Sb40RMx86cQuulVbTgk5cQB5h4l17XBU/oZ9watQbt5jT5ycIiv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 03:04:11.8826
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c19f74e7-66ab-43e6-e881-08dc4c783f33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

The min_limit_freq, max_limit_freq, min_freq, max_freq, nominal_freq
and the lowest_nominal_freq members of struct cpudata store the
frequency value in khz to be consistent with the cpufreq
core. Update the comment to document this.

Reviewed-by: Li Meng <li.meng@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
---
 include/linux/amd-pstate.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/amd-pstate.h b/include/linux/amd-pstate.h
index 212f377d615b..ab7e82533718 100644
--- a/include/linux/amd-pstate.h
+++ b/include/linux/amd-pstate.h
@@ -51,15 +51,15 @@ struct amd_aperf_mperf {
  * 		  priority.
  * @min_limit_perf: Cached value of the perf corresponding to policy->min
  * @max_limit_perf: Cached value of the perf corresponding to policy->max
- * @min_limit_freq: Cached value of policy->min
- * @max_limit_freq: Cached value of policy->max
- * @max_freq: the frequency that mapped to highest_perf
- * @min_freq: the frequency that mapped to lowest_perf
- * @nominal_freq: the frequency that mapped to nominal_perf
- * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
+ * @min_limit_freq: Cached value of policy->min (in khz)
+ * @max_limit_freq: Cached value of policy->max (in khz)
+ * @max_freq: the frequency (in khz) that mapped to highest_perf
+ * @min_freq: the frequency (in khz) that mapped to lowest_perf
+ * @nominal_freq: the frequency (in khz) that mapped to nominal_perf
+ * @lowest_nonlinear_freq: the frequency (in khz) that mapped to lowest_nonlinear_perf
  * @cur: Difference of Aperf/Mperf/tsc count between last and current sample
  * @prev: Last Aperf/Mperf/tsc count value read from register
- * @freq: current cpu frequency value
+ * @freq: current cpu frequency value (in khz)
  * @boost_supported: check whether the Processor or SBIOS supports boost mode
  * @hw_prefcore: check whether HW supports preferred core featue.
  * 		  Only when hw_prefcore and early prefcore param are true,
-- 
2.34.1


