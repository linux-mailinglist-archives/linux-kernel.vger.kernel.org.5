Return-Path: <linux-kernel+bounces-167307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682E88BA785
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890871C216EB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FBF146D47;
	Fri,  3 May 2024 07:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kYFRIao6"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2083.outbound.protection.outlook.com [40.107.223.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7731465BF;
	Fri,  3 May 2024 07:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720675; cv=fail; b=d1r8pKBOh90n090+UA4HaOwN0zK0YKByTe4lVOFUy0XGGyKySmBRebGSxHb7NKu3n+98Pe3D50w4R/rFFY2LKzbou/ma8q5/3Nlt0/euKBdznH/+9GLS9UwGv9UWAEljNUM8mnmXwknMamdJm65nooTshoSDGhJ05umE1P289CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720675; c=relaxed/simple;
	bh=UvMy+IBmUeBT7WHELUtCmgLyXENzc0yGbg7bSzc0jDY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gaIIbgPNylJZ+D99gFvVfshAVOt+VPyqG604uau3oVwdyGkUon0FWCMh+OMwAJ+th0F1QjjNcJjYlTctUchBMv6gyvOZvPdqacxTshMHJIMK2TjLuz8Jmrgc4wGmha4+29SkRsCz6XyjFRVtk8emIL6Wxy19mnjfQtuv5DWvzKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kYFRIao6; arc=fail smtp.client-ip=40.107.223.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzsi2qhUW7vPG+3kufyDX+fghMt+cbanhVQybaboMomuqTLHkJdYMQJWzWBAAI7e7D11WWSa+OLHV7e+MVx5dBn+wLA9Ua8HrVO661hONqVUqAtVIcd0ixejVo1GOiUuQZam3jg3eEeE2YRkPYEzMApGb+HMRKUNCBzAhOiqfHa7OdwKM3iEjNY7Y02r1mwfPFWmkxxJfZAsnjZH2i5UIZPjBgn5BuXp9qLzxEdj4Dsimxn//JaaLH52rn2VsZ2oMUJ/iJjfU3rtixjYqHGkWDw3IH59ig+CdvzSorb5wpTzHYMgCa4rGe0Q/t9+QymkWqTJqvmfR9SzRd4nHmK0bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KfvQaX1XMrbDPkspLboR1t0Mo8W6CXkPezqj28176pg=;
 b=ZTb7qDNTci6grxn6lgumI8jrCKwkUtoc3B7HQlEo+qdrvAdskt1snNVrm6U7RYHVhFXg3STBtxzMxv55Ve+XXnMyOfl1aOXbKi+j9shAcSKUWP/yjVUnJ5+d3PbMrrKzEBbpLTGQjIMPZvto/G6Gwf96izE7yV7DSglw+kp3eQHM/1A4GJsm2N5Dgd5UH25Cr6QPq5JK5FcG40509AMss/KE/RJdLclUH/8dv0z/uKrCifokgMdiYHmrQ6wEpckzIWqiLz+YBjhn+CFSaxhSRMYgHNofCJnYNPBiPDF4cZ9Unl+jRZxXkIAUIk1jKrvCz2BYJtONMsWFG6sjELgzbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KfvQaX1XMrbDPkspLboR1t0Mo8W6CXkPezqj28176pg=;
 b=kYFRIao6jO8BPRjwAfzklt+0AXE4V5XG8Sns4g3Tnv5tf9REmQJ+S0oGr/zN7Ob7RGq9/pyx2Slp0RjAVcNGVLUSQiBcOwibDqgljGqR6q+i6cca3+FEX60c7iBYDeVMiizJrnes3XGPuEcfO6/W4czgi2OExUy68vFwYTLlbcI=
Received: from DM6PR02CA0161.namprd02.prod.outlook.com (2603:10b6:5:332::28)
 by PH7PR12MB6857.namprd12.prod.outlook.com (2603:10b6:510:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30; Fri, 3 May
 2024 07:17:51 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::f8) by DM6PR02CA0161.outlook.office365.com
 (2603:10b6:5:332::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.32 via Frontend
 Transport; Fri, 3 May 2024 07:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 07:17:45 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 02:17:41 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 4/4] perf vendor events amd: Add Zen 5 mapping
Date: Fri, 3 May 2024 12:46:22 +0530
Message-ID: <862a6b683755601725f9081897a850127d085ace.1714717230.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714717230.git.sandipan.das@amd.com>
References: <cover.1714717230.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB6857:EE_
X-MS-Office365-Filtering-Correlation-Id: 85dabf8b-e8f8-4cf2-cd13-08dc6b4121a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|36860700004|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fzR+RXSurpRgYn5WfjDwWg5Gm/UHNrvFoYSiXtn3WCWCgR85ayuS3kTmYbrF?=
 =?us-ascii?Q?O2VP4Tu+5r98xZDlIRGK0jBnZ1Zv1dIvHIEk4CAdqg7eGSj8PXKnOW7Uih6E?=
 =?us-ascii?Q?p47992KCVxOhRrxMclHxPBbTe3NMtJHgpNZhtX7Nf7YN0mLPNLGZXMR+1TF9?=
 =?us-ascii?Q?NUpT43m8ZCLRyGedO0IXyAFat4Z/4sybqbGsY7i93cGCS+9nAk/g2rwF4ZE3?=
 =?us-ascii?Q?oUnPMKXl0xlpmi3Wu3rsE+ung7XXf/ubpCLLyct2p9fW0hc+RWEd5kcCyNRR?=
 =?us-ascii?Q?t3nJTD20Zv+6hRhVr1x5fhK+hPztDZtsDGEnEFEn5/WW4mjnrhCHpsfSWZZk?=
 =?us-ascii?Q?qQnUwEWEaFERqOtnwUiQ1Vbl4dcCmWdS0ehVLDz4rrK9QoBRgS8JlnXs9kxK?=
 =?us-ascii?Q?UoFaSjbdtxJtuSCjXAPF2Ggbuqke3+Obaba2YyPRyf+EnlFDzYkozUEw/Two?=
 =?us-ascii?Q?5wr44vLi0RZaFvkWATifZ0wTnW0KCjI5/ceZ1l13ZR0lsnhflnij8BQd1Mz9?=
 =?us-ascii?Q?iAsyNrDRR2zDv9F0u7sXY6+EN5V+eAz7Lo1C9DNLGfwobVN9duu4YfiHpyiw?=
 =?us-ascii?Q?1YIBxZ5E3HlzCQNlDe3eSVO76NFhwOgi+MgTxzFzvB8SROvFE19HXP20HBxy?=
 =?us-ascii?Q?WkrSwWE58n/7RKwbDjuu0Mk7taMEICH9Hy1L6Je9vPBuFJXZyQSSLuGao/nj?=
 =?us-ascii?Q?xjA1vtE+zhF0L+S3WMqmz5upSIjLqcIuaORYMOqRK1kr7Cmoqd5KqaZuCo94?=
 =?us-ascii?Q?O4+b4z6B3J9gc0rCrRga3ANB0UEZjM0YP1y/qZsrTF0U4eNu4sWpC3h6MfIm?=
 =?us-ascii?Q?PnbUGj3WsSWQ29TDy6ndp1rfClSuGynByFUjezE253oe9fmawmjgjCpPmmq9?=
 =?us-ascii?Q?4ZNWOja8UhlFUlzJU4u1ZygWUki4sS9v5Tze660pSS60SO9g7FS9BIYN5sb+?=
 =?us-ascii?Q?6JsuXV+Zlo5HYiZJuU/p+tYDirzb8k7OW5+uRVQzXx3uUzJ67YqXx0x8Sth6?=
 =?us-ascii?Q?aldBi0aiqF4dRm7mvDKv6juwSSxgGaawLOtQOJN1MUFWG3OPLZ8NV7IfdGKb?=
 =?us-ascii?Q?7SKIzsMXce7GCfdsh+74wm5ItokyNRpwELjnXeW3YQ1brpYiFXj0Qxcc+d+e?=
 =?us-ascii?Q?4+sKueNZMVhTAQmVLAYfMkrKYUErnlrbFVhGMw2a613ijjR/C7sAeg9+Sspe?=
 =?us-ascii?Q?Q84K9TaMwf/3ruM/6AwKlFGezFnDGS+5AywWKjMhiD38TkKvdA1VbDG8hE52?=
 =?us-ascii?Q?295/4eF+w+64sesbIr2YvZUi8TF9odgiRUD961UXW+72oE5h5F/6F6CoW2qw?=
 =?us-ascii?Q?gtVaKgoqTtpH6Fq5pb7PWioyzbxECoxGe+KjAVNgdBSl9BVWa0XZaDqlQYTg?=
 =?us-ascii?Q?n2L951DE/RsBW/DtFEUrQcjvfv9i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 07:17:45.9609
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85dabf8b-e8f8-4cf2-cd13-08dc6b4121a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6857

Add a regular expression in the map file so that appropriate JSON event
files are used for AMD Zen 5 processors belonging to Family 1Ah.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 tools/perf/pmu-events/arch/x86/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
index c372e3594a69..c9891630be10 100644
--- a/tools/perf/pmu-events/arch/x86/mapfile.csv
+++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
@@ -40,3 +40,4 @@ AuthenticAMD-23-([12][0-9A-F]|[0-9A-F]),v2,amdzen1,core
 AuthenticAMD-23-[[:xdigit:]]+,v1,amdzen2,core
 AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amdzen3,core
 AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
+AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen5,core
-- 
2.34.1


