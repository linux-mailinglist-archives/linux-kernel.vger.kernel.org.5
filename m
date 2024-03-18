Return-Path: <linux-kernel+bounces-106673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B9987F1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86306281FA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A859B42;
	Mon, 18 Mar 2024 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rgDaR5E0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B543558ABE;
	Mon, 18 Mar 2024 21:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796176; cv=fail; b=XR8i8fsKFJOC6ZPKKsAabLG+xEbJxqu4OFTzLAzWNAArdspMmnXEalaBBeaaut5Z5NocRqlVq6ZIqXNeGUexMYxmYoRDuSF5b32KmY1T+9I5dIXNkaD8IgM7TVGMuEUuOufUxteb0ACsZsrUGd2Lpy7QfGRuA8fJdxEp/q98ZKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796176; c=relaxed/simple;
	bh=nk1BgPKRoO5icOGB2FzyrMY0rbvumy19SCcLeZeu6R0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4f9UVCHKyv+q00XwMvK2xG+jyPxIrpUT8VvrUscLqak/CO+szyF7jLcLjXZzae3WIKULmUAVR2ZpQEZc8u2eSjAyhC+zNyTuX0WTEA384RaZqrPdCSwgEfJo+5HF67p+eVtK7N25CPgQpNgmXEzQXQKFCDHWPKVfL0vlTdoLYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rgDaR5E0; arc=fail smtp.client-ip=40.107.92.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VQQEsrrVz+JQMG77uPaNHTnh/EI/fKvmlY3tpAeZAzbj0nUGHtdLFnSIKp0fSG7AYAhH0Q+2uJ/3LGZJjJRtGNm+EqIz0O4Zycnp3GEtk/RriinTOxIsR3EZLBhSf7X3jBxmYnHSXO0aif4sm8oZ6YE4h6jnd3srXLa2dkpBlwTEbALyO45fRQZszXA8QfPkiz2CpJO7YolRPKp5128shhSg2DKzQIYd0NI+/caJIlYjnJsjet2bYH33kha31DFIWzRbROgnlf279/I47Z/5ytQA8mUwqo6M/GXtUSp36fzM1K0k7eiAhNMs1KIb2HT5ypPDCGWfaey4AFIt2urKKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zoLFzG2MgkwNippgJ7PxCr/qYu5ZBNIIQFdlZpjxFkA=;
 b=hTtqa8OT6Xx6pzAjkbeEIPZ0rMFKBg6uloFwo+1wD3Yn0rBgI63EXdNZHVIoQQInEpClem2zv2uT1cYlyZYf8cyKfdsFmO5dGFm1VIm2J/70n1WLkssatiCZYHucovTnk7vSgDV8THyFi8xSB4h7r23N7dVG1/V879Nj5Htr9va46zkC0yVL1wfzly9YRScZX4UPPxF4zg7dP4/oGMRwrHduHkWxW8fNVQ/bmB0uqAjFqx2+IvVV6pcpQrZiu21MjLK7LlBl16d+wOlvysFsXga+gvnPIl9aEz+QcGCo75XBp4pMYOZw8JaFxzgJz3M8LiIjp05v3UUuSFjGykOIDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoLFzG2MgkwNippgJ7PxCr/qYu5ZBNIIQFdlZpjxFkA=;
 b=rgDaR5E0Oaxrgpdr/zvsSFOvQcsYZNGogiTGUzRKgZI7Jo3ywz3RpI3acE1XMHNsmhEwFxWwSJln/HwG+zamcmujOuqa2US5IhEcStw36PyPqtMsEJmRWSR/DfZdJFO5qE60Y393TIZLA/2rjyMnI/9h97JEQ/+dj+tza+QFpCI=
Received: from DM6PR11CA0040.namprd11.prod.outlook.com (2603:10b6:5:14c::17)
 by DS7PR12MB5790.namprd12.prod.outlook.com (2603:10b6:8:75::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 21:09:32 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::68) by DM6PR11CA0040.outlook.office365.com
 (2603:10b6:5:14c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 21:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 21:09:31 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 16:09:28 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Alison Schofield
	<alison.schofield@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH 1/3] x86/numa: Fix SRAT lookup for CFMWS ranges with numa_fill_memblks()
Date: Mon, 18 Mar 2024 22:09:00 +0100
Message-ID: <20240318210904.2188120-2-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318210904.2188120-1-rrichter@amd.com>
References: <20240318210904.2188120-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS7PR12MB5790:EE_
X-MS-Office365-Filtering-Correlation-Id: 86bfa99f-47b8-4947-3770-08dc478fb4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	agGpJoZ+W4No8AfIAyJTPBFyo0Hj7j4i/4KP7S+LE8saTSvGCqrQR0QgsZ9Un4W3cGtWcBhKhmQjzXNVYY6oeK0byxyH3thm9Erw3PaBSO2f5/dFgHNq77KMNuuf+WrRku3YRoya5rpHmXRYsLoB4+P58KYtaInIwZsM2+CSDLUdhHlh0yOgNZpFqTyhzVFWIKkII193sKLxtFr5sJrJYFnJwkoWpSySSW7kv2IRM1DRus/KontrRq1O02UjmawlmwrLaVYuu9odaizW6SVs+KOq72uWl5CWllw4yfLJTTXTKXjLYrIZ9fpk1e81aw005a5DvaV+jNf/36z5x7TMVIo30DnZH9s2VQi+UmUBUrD9+cMUn3FxL00DrjPEFEM8YtyMuKefvpxDCsU2Uz1Pbsj7stLuZJV8l543NDJy+HlGJfb21X2jDSRhvAQu/6dPFAV4Nm+pdv3Fv0R21D0zKB49wQmCgEIEUdRuthC3t9DzzlFjHbjqRCQfknY3b8cTkoAcIJ0aX5pFeRKcsXcjDfS/ik68xE/H/clmMAPJR2XNEsABgxC1OJLQBVpvb4LRipxkbVww5v+o9a+iLlbao8q6BYEbRCpijBru3tImbUha/s8HieiDNW5I6Q3RNmNhi261ygPsBaWpN9V3Yog0Rp9OBejiZA2nsBjSVq81JLNiQkmx1TEpVE500PpQ1QQCDq/ey4ZKvo8UHW9ALu2PJGpTKWXs5FLhSsQeHvshtPnj5vNaIkUcKwBmsK3Cb56x
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:09:31.7926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bfa99f-47b8-4947-3770-08dc478fb4e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5790

With kconfig option NUMA_KEEP_MEMINFO disabled the SRAT lookup done
with numa_fill_memblks() fails returning NUMA_NO_MEMBLK (-1). An
existing SRAT memory range cannot be found for a CFMWS address range.
This causes the addition of a duplicate numa_memblk with a different
node id and a subsequent page fault and kernel crash during boot.

Note that the issue was initially introduced with [1]. But since
phys_to_target_node() was originally used that returned the valid node
0, an additional numa_memblk was not added. Though, the node id was
wrong too.

Fix this by enabling NUMA_KEEP_MEMINFO for x86 with ACPI and NUMA
enabled.

[1] fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each CFMWS not in SRAT")

Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Cc: Derick Marks <derick.w.marks@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/numa/Kconfig b/drivers/acpi/numa/Kconfig
index 849c2bd820b9..2f4ac6ac6768 100644
--- a/drivers/acpi/numa/Kconfig
+++ b/drivers/acpi/numa/Kconfig
@@ -3,6 +3,7 @@ config ACPI_NUMA
 	bool "NUMA support"
 	depends on NUMA
 	depends on (X86 || ARM64 || LOONGARCH)
+	select NUMA_KEEP_MEMINFO if X86
 	default y if ARM64
 
 config ACPI_HMAT
-- 
2.39.2


