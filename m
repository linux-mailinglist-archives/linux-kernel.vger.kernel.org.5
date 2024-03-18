Return-Path: <linux-kernel+bounces-105906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8B187E63F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 569B2B20A70
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8252CCDF;
	Mon, 18 Mar 2024 09:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pgxvIJIX"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854B82D602;
	Mon, 18 Mar 2024 09:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710755339; cv=fail; b=ZBAihyFEq2RU8dyyOIA7m20/RBJcT811KKwA72E8Mf88LaSYg/aiN7xg3t5TWzOwYkz/vqCCr/LbRYQGmWBnCfzDaWjIhobxafk+4/RsgXqF1i6lLBbFXb9Bh1NpIOHkLzycsfjfHhE5GV90qrOomqeiGzzHX+MmEw9RWPoejX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710755339; c=relaxed/simple;
	bh=xY6iItlNZSZwjBPo++PcdILljkhv1E1HSvYll/18NBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pk8g0OT2XndaHvherD0n3ByxvqIEFZYT2cpq8AsR6sntRaGlwg0+6MCtsQwQgXyhOlGEZg/HjNBYAlVzFGf/9DMhTyHhpgnoAE/xkUuVe/piCukKLHgiQF5o726TsxAFzZOt3tiI6FmA2X4SYhQGokCFTrkZ0n9xOcEdYO70/6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pgxvIJIX; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANeGlfktCOykY1k4hi4y4G4LY9QQpMe8GHQhYgL4tt8LAAlsDoJAyxLTgrDa2h5uZsttwzxpYERGtuZaQGdWKfmFfQ0fMl5EZgSEmjTu+TaWWCkzNrCjzkvV+eGtpYuOPfvs4Pe7/PObLSrntLuNRVRMPftYQyrDpNESX4XLyeO8gEKAoVlf/zqdDFEeN+O2vrpv+nvtY+fB4Laf1xraRgYm11ptd0e8QNX4DZ9N6oS37vzvEEVv7PXi9LVM0se9XVOZ84krUDBiYqaEF5hE6TeoVvAEnQ3uvwCE2V1PI3+VoyuVh3w7QDRwLmHCHKrZaJmJeT46Zp4Y82gO2KavOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R/PGnTtqjWsCA7SmW4CIaekSpMtRb7qW9NwgjPgDWws=;
 b=fe3TMKJFXbdataCZgi/n5Os1jt+eBaucinXlcPd0GllmG/pykobaRyFcNn1hBdxxfp0n3AkPcOs8gzuxmCO8iOttzcziRPSitj2GwOD2F9Lj8wyveEDeOCP5klbAMrKeJtJVOsEZoaJ02J+Iws1D3yIuO2c6B6Z2cmQbZKgIxILU9NUDO1i4Eq+wPlIO95SwGLNZKpKpUK11nxBTGMrkkpJYBKzkQvP3HCHCCQuIWWDSgMNyvvB6a0MT7A5srvPq3/h9kbY1RNlC6WXV+vX3RP5uaeqizvXM0UG2/TVVOKuW6ljjScrRcbFpirXD8fwXUS5iTZ+GLx/+8hBhFTux7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R/PGnTtqjWsCA7SmW4CIaekSpMtRb7qW9NwgjPgDWws=;
 b=pgxvIJIXYHvP29rU0lVDzD/dcmZjeCR5D6B4ePhFn4I7vbl9yU7tFt/yoOtgAnPPskFPxgc2+JLBcJTSIatvdND9jOQfYSLrMfwVs1qQONep+/ah0WXSPq4avxw6hrhpFKZRTB8FF63JRJ6owTEgKmqSDpXalHCBOns9bNk+qqc=
Received: from SN6PR05CA0005.namprd05.prod.outlook.com (2603:10b6:805:de::18)
 by DM6PR12MB4298.namprd12.prod.outlook.com (2603:10b6:5:21e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 09:48:54 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::22) by SN6PR05CA0005.outlook.office365.com
 (2603:10b6:805:de::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 18 Mar 2024 09:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 09:48:54 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 04:48:51 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <Ray.Huang@amd.com>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>
CC: <Alexander.Deucher@amd.com>, <Xinmei.Huang@amd.com>,
	<Xiaojian.Du@amd.com>, <Li.Meng@amd.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 1/8] cpufreq: amd-pstate: Document *_limit_* fields in struct amd_cpudata
Date: Mon, 18 Mar 2024 17:48:20 +0800
Message-ID: <0988fb808bf358c98f6ae8ad8f65cb0c7e1129b3.1710754409.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710754409.git.perry.yuan@amd.com>
References: <cover.1710754409.git.perry.yuan@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|DM6PR12MB4298:EE_
X-MS-Office365-Filtering-Correlation-Id: 32430c6f-0a8e-433c-839b-08dc47309fc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AhwKV2IYD8ciJ5ZwJmI3bowXI/C48uyg4WMIu7oC/dahMcw5AO6YtHP9zDWmkJEJd8lBNE7d45qU9SBxMdr68td3m482wec66WHQSeXFfIHI2ZmBcoOJsebGGonJ5a/5GEjH0BRlMDXnhmjTeGcTXc0ogazgwVCLKv4Z9fN5TL0NupqkhJ9WBvHrjjLVpwZX8cRGJ9zlB/HwA3TuQQcl5E1xq1/IGsk0pL0b+5GJyFhubWNQCyO/rwnKfcUWrbHsvhcfnihODWhHIXXg3NJuAd4lVK7LdriGpGhjHfI33orpreP4BZnBjrDwe8puikHRFRcD/luuAQZRGWNDb8BVR+rKpqAoLz1T6LMbDXKTf0K4G+GprHt1U0WsFzYsBYn95H7JZWtC5l1QEAIn7zve4Bos0vo7M3yfU0RJfNmqSmBX7QKomZpm6x20nKe8K1lMHII0b5FHaazlIkmsu75rsyZt2LdNR3agf/tg5kwoXWW5BX4ECPmGcDvBy1dnUKVIEenBIagJAP1LKHDaUI6+HP2vaHdZf3biC6gY8lT6ehWkLE5NVpwrJ4dDmRy11x/tEE7KRYh+bLZKfAuDOYnxcWD5p4Zv2A2usDmwA0MooZMUa1Q9XElknPhGDH+MuWY6eqJy3RKrk7Kg74+fZo8Fck27xJD6k7oLw0N7X++IiFOxd65uxM2tkL/2vMCjoC5fkSuGy+waY+XCgW+ZdYcbJGD/uFk4z3f30ts7Jr3tb6FLKPYoU2CSTun70BxuBUDo
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:48:54.3928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32430c6f-0a8e-433c-839b-08dc47309fc9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4298

From: "Gautham R. Shenoy" <gautham.shenoy@amd.com>

Signed-off-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
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


