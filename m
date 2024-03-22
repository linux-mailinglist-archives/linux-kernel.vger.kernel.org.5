Return-Path: <linux-kernel+bounces-111559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F96886DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE049288569
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357446441;
	Fri, 22 Mar 2024 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UBtIitbV"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2076.outbound.protection.outlook.com [40.107.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E686DF4A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711114919; cv=fail; b=IRRXVbplBdOJVYQpUgKZyiawbL/Nd+DtXBPbDe4d/XSv7KlqxK+d4LY/3G+WcTTUc7GpIDADyvJKR/y9rITPWB/mVSqwVsMDt91Ujqlzm5OcvvXbQPoOXZr4mQBG2fzsgnG5Ja+PbrMdKgYUU9jHIDizDc+OkEzPI8tiAAnkq88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711114919; c=relaxed/simple;
	bh=xL0SCJmrq+d98P5fUAV9Ga/yT08pvrOltuBn2j5Ox4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JBEUdA82CAAdv2AbyAx0R8YuYoWhbQcyQQ1pRRbogaqm2441LuolMz9ncDAhK8MgfBgqnKmCrbU56hl8YTQqk71vuIDg59YHQBuLfBjTC3EDDHtKgTZmLa78AAzYVthyAMZ0TXmCS/04OEaemfLd9if6iMiLMyTI3KMb1FldHqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UBtIitbV; arc=fail smtp.client-ip=40.107.96.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OOgfLgIdA234CHZd3MIZTAlObh2Nv5gEkVf0Ti8nmAvk5TdLkVjGSBAfWdsrmpBCO5IWJNfBivq9QeYRr2gWFs6x1jPcerytdccudZlRWk2YrDtHLyzYWt+RIcJR5dNrSvDq+xowKC+B16y8dfDJpZyAs3vZAHGkPM2Ov89v+6omIxzZOjmJwD2xSqHvTOUy+rk/bmSsWnUrhGrrMV01ivyeLdV5RYaHp9tUGPycBLv+xNJ7o9JxBGr8UjHtfR5LdU/US8dbnjhv2sRUvP4oxVYtU9ut3dR7vsIPi/cOo0tYAKV5V6InNgRNGQr3wu9fE/SOGFjxIJlwsmIELtF4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JinLGu6fO7JCo3S3EpMhOjKa8gdBuHJRZxKdql5Jgks=;
 b=oGDe9vl/gAxNj9OVSg2ZRAnlZ2Hu8M1634nyuEpZ+nbBXqRMkrRqomva8HMD9bhYUhuXPVVn629fNpssPr+ybZuvTu4ffDuINBXvmN1lTQeZE62HOqU0NxLXaHDNyodzuV9rOmQZixCY5egKAcgvMW6nM1km2qcgL73uIJQi8scvd6k/G+ZTKqsl6hNNUlkFbVn95fPyXdZVWhlu2p7PP0ib40lZjumK1UmG3fo0FaELz+BYy7jCPPpR2rgkLJHQPNObhXwJFapHXzAk8JiQOr1UDAYFDn2K+5BFehUpbJ1n9fXPcDX1NPLtvfHafWE+B7yNjltSsT7Eag94VwTXWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JinLGu6fO7JCo3S3EpMhOjKa8gdBuHJRZxKdql5Jgks=;
 b=UBtIitbVMiSuRGH7ar/SuPjqj1MvyuV97wDHyEE64QtfgfYsuTyOIcFmBI7phTd+IPMdSMWwJvJUjjx1m2cqIa7A/GCz4HOSrPgL27pk3BS/mzHEnscetqX9YfOvfnSPbgCmRzWJmCtrYkllA1UDepx6022Szi3BS3X821EwybU=
Received: from CH5P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::23)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Fri, 22 Mar
 2024 13:41:55 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::f2) by CH5P221CA0022.outlook.office365.com
 (2603:10b6:610:1f2::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Fri, 22 Mar 2024 13:41:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 13:41:54 +0000
Received: from BLR-L-RKODSARA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 22 Mar
 2024 08:41:49 -0500
From: Raghavendra K T <raghavendra.kt@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	"Mel Gorman" <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	Bharata B Rao <bharata@amd.com>, Johannes Weiner <jweiner@fb.com>, "kernel
 test robot" <oliver.sang@intel.com>, Raghavendra K T <raghavendra.kt@amd.com>
Subject: [RFC PATCH] A Summary of VMA scanning improvements explored
Date: Fri, 22 Mar 2024 19:11:11 +0530
Message-ID: <cover.1710829750.git.raghavendra.kt@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c3b7de0-ae25-4f23-d1dd-08dc4a75d65e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NSEUnjgjz+HQG1JC/eje6py72dRUyXDAJrbiBn2TCg1Al8CezMY01XegXuvHzxNypkSKZdoSeoMycxBGoCKRghzY+UlvC95xVBrQsztXx/fqy+PA6q7yFP+NHF4+JNMnqJskCqdR2rX2qHVrLqNEqnr6ImjQh9kmVl/+ux4MekKiVuL/CP7oId9n68DTBx127CwkC5YcaOvq/P+s33YCqMduW2LagAoBm79PoywG9lNtu0mo8rHakRgosQsA3zIFVOZI3WxNWquF1KVWzTpOX76HmJNHYvXqFnDeStaWYJRUIv0oKtPm9t8xxWJNOCFervh0uof0FR2mqx5ULprzTVwL3KxJvPPrPCWdqdwKRySI/OtyjOH+48JuGEptYJufdYMnuZxbPbz6MG09K+VGYmK99o/vE7g6cIwqklu0wGLP2es51FTgKi350QJ3DEfYcdoySb7LzS31nHfa87HBN8c4IDZyrrO+rv1R0o8s/rqrL0HQWAWSRgwtVF7pvMJdGWguAMn5njfgZYio7cYeQ2W6ctzrb3AuscZF3jxX+Vct3SozjpXfqvuaRSNIe2F4OI2+rUvFIoq1S6N3OwOI9ojBjUlIGirwCJ0NjfkGDsIjrRanIJpTgG1I72yhgXKoGKPnpQJavhDr6h+m+957V/IxvE25IFTdM7FRxxRdcroYihJ2Rex9Hdy1g9ZTrEIn17/ZUSQPCDOfR2S2lltNyfB7hLL80UehT3gXTsnJ+c2aJhPGJZlhg86CI+Qqyd9f
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 13:41:54.5122
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3b7de0-ae25-4f23-d1dd-08dc4a75d65e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872

I am posting the summary of numa balancing improvements tried out.

(Intention is RFC and revisiting these in future when some one
sees potential benefits with PATCH1 and PATCH2).

PATCH3 has more potential for workloads that needs aggressive scanning
but may need migration ratelimiting.

Pathset details:
==================
PATCH 1. Increase the number of access PID (information of tasks accessing
VMA) history windows from 2 to 4

Based on PeterZ's suggestion/patch.
Rationale:
- Increases the depth of historical access of tasks
- Get a better view of hot VMAs
- Get a better view of VMA which are widely shared amongst tasks
with that we can take better decision in choosing the VMAs that needs to
be scanned for introducing PROT_NONE.

PATCH 2. Increase the number of bit used to map tasks accessing VMA from 64 to 128bit

Based on suggestion by Ingo
Rationale:
Decrease the number of collisions (false positive), while whole information still
fits in a cacheline

This is potentially helpful when workload involve more threads and thus,
- unnecessarily do VMA scan.
- create contention in scan path.

PATCH 3. Change the notion of scanning 256MB limit per scan to 64k PTE scan (for 4k).
Extend the same logic to hugepages / THP pages.

Based on suggestion by Mel

Rationale: This helps to cover more memory especially when THP is involved or
a hugepage is involved.

PS: Please note all 3 are independent patches. Apologies in advance if patchset
confuses any patching script. Also more comment/details will be added
for patches of interest.

Summary of results:
==================
PATCH1 and PATCH2 are giving benefit in some cases I ran but they may still need
more convincing usecase / results (as on 6.9+ kernel).

PATCH3:
Some benchmarks such as XSBench Hashjoin are benefiting from more scanning
But microbenchmarks (such as allocate on one node fault from other node to
see how  fast migration happen), suffer because of aggressive migration overhead.

Overall if we combine ratelimiting of migration (similar to CXL) or tune the
scan rate when it is not necessary to scan (for e.g., I still see VMA scanning
does not slow even when rate of migration slowed down or all migrations completed.)

Change stat for each of the patches
======================
PATCH 1:

Raghavendra K T (1):
  sched/numa: Hot VMA and shared VMA optimization

 include/linux/mm.h       | 12 ++++++---
 include/linux/mm_types.h | 11 +++++---
 kernel/sched/fair.c      | 58 ++++++++++++++++++++++++++++++++++++----
 3 files changed, 69 insertions(+), 12 deletions(-)

base-commit: b0546776ad3f332e215cebc0b063ba4351971cca
============================
PATCH 2:

Raghavendra K T (1):
  sched/numa: Increase the VMA accessing PID bits

 include/linux/mm.h       | 29 ++++++++++++++++++++++++++---
 include/linux/mm_types.h |  7 ++++++-
 kernel/sched/fair.c      | 21 ++++++++++++++++-----
 3 files changed, 48 insertions(+), 9 deletions(-)

base-commit: b0546776ad3f332e215cebc0b063ba4351971cca
===========================
PATCH 3:

Raghavendra K T (1):
  sched/numa: Convert 256MB VMA scan limit notion

 include/linux/hugetlb.h |  3 +-
 include/linux/mm.h      | 16 +++++++-
 kernel/sched/fair.c     | 15 ++++---
 mm/hugetlb.c            |  9 +++++
 mm/mempolicy.c          | 11 +++++-
 mm/mprotect.c           | 87 +++++++++++++++++++++++++++++++++--------
 6 files changed, 115 insertions(+), 26 deletions(-)

base-commit: b0546776ad3f332e215cebc0b063ba4351971cca
-- 
2.34.1


