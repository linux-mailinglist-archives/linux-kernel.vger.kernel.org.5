Return-Path: <linux-kernel+bounces-121586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0FD88EA2A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D18328E437
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF54812FB18;
	Wed, 27 Mar 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0CSMZKmv"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADC42D627
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555387; cv=fail; b=onT6c0GM7zh0PEk+rDBy1nEj5hkDQ/m6g9T1BkNE2y7p5tC2qUMXO6QuzWKUsQ8t2JgNkARYOx2rPrBs+htePTl82C65fIKjr8kdkOcxjUrbQ7WL0KijnxUJhBMnb/LDrqRroZ45FALwc7g2pmWdat5H5nx4hhfdG4JZwWG4M5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555387; c=relaxed/simple;
	bh=NJROWRGBCYF9DJe6MqUGLclV+T95+pArQdycXKSpZ3s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QsjLhHIMpVJA0UDT3ToggYd7Sja2XUkZmgZIt+YysswSWOO9gmAi3yI5hFvH7KyBF7N3+H9g5N4ICSV+VKlw9IQiaYPUnpvXJxxQtWd1S+c9BH95Dw3vowLeWQ8pDORiZaIg6GJh0xBtSx9khIUSbArGqtemZcZrM/ruH+qxxk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0CSMZKmv; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ns+jgFK2sQEQTRe2BGiUIhDDrj+UBZBtcOi8xWmT6VxwUCKe1YxfyVANQOIS/O6E3brLQG7CWtAne/TRg7BC60UJZlju5wDdIY1dYpCeau+dsqKny8/6DPV89AxIz9Zexs3oaHETE4elEM0XzVVjVj+eQCJ2saHUZzM9VQaDvKTVRLV9TfI93ps+hOIDjrzpFjeZnjRsQgz15lORTMyQpj4UR0vsgCf/kOYYD4H+WlmV9zQkMf0N65CjZvinJxWhjZuVHxXlvm3GlaInJjb1g/y6aEdw3Wu4S6KfpF8O+Vf3LH6DQc8Vwtjb/SMilKXSRlGnj2rYLbmJZZqDpmR2SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnX7WaU7PCcNz1hM6L0cFdUzON11JJcThZ8p/lRYjWI=;
 b=QVlTaHMvxLB8ljhebO9Qu5PiB434bwYkaionRpqDRV9vGmbkjijuIbY8qHzpnFIEmnVBf20i0MY0s5cXfSE3biTx516Ey5gkeG30n9L/4RdyehFYcU6DRqB9vJYy6uBK/qQtEKPfnINMsRgF6sVQlZ2jIhlA+5VxulT0bX9Q5SIGMJEqR7Tt6is2Om1FQi7mDHnaqaJi+Brurd58AaidF8RSPtV5Kp09dWqsay8DLUBzA5FKDQrk+mcv+tdnBMnXBRbRkCSaX5uVfvY/4AUniIK0tBy+ANwdNZTj76+JwEtcfBs6/5ROp/0tkkbr/YksWfM6O9Aqu6Z4utia3kWsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kvack.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnX7WaU7PCcNz1hM6L0cFdUzON11JJcThZ8p/lRYjWI=;
 b=0CSMZKmvoTB0xLeMI4t31wdjBSGf94sVG5BgQy+2P+aOEWWBJDkXOcUgGGhlyYZs/qMLhktyCYZn8HTovwQ549/DuP01JSoAH/DdatOZU7KyeDJ5wVpfzqZ/xu+FK4m5WDguNF8X+O6OhS6RbCzrBaJNyEZR372l5OJMsKp9u+o=
Received: from BN8PR04CA0058.namprd04.prod.outlook.com (2603:10b6:408:d4::32)
 by SA0PR12MB4432.namprd12.prod.outlook.com (2603:10b6:806:98::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 16:03:03 +0000
Received: from BN3PEPF0000B070.namprd21.prod.outlook.com
 (2603:10b6:408:d4:cafe::58) by BN8PR04CA0058.outlook.office365.com
 (2603:10b6:408:d4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 16:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B070.mail.protection.outlook.com (10.167.243.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Wed, 27 Mar 2024 16:03:02 +0000
Received: from BLR-5CG1133937.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 11:02:58 -0500
From: Bharata B Rao <bharata@amd.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<mingo@redhat.com>, <peterz@infradead.org>, <mgorman@techsingularity.net>,
	<raghavendra.kt@amd.com>, <ying.huang@intel.com>,
	<dave.hansen@linux.intel.com>, <hannes@cmpxchg.org>, Bharata B Rao
	<bharata@amd.com>
Subject: [RFC PATCH 0/2] Hot page promotion optimization for large address space
Date: Wed, 27 Mar 2024 21:32:35 +0530
Message-ID: <20240327160237.2355-1-bharata@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B070:EE_|SA0PR12MB4432:EE_
X-MS-Office365-Filtering-Correlation-Id: 45aaa59f-fab2-49b7-cfce-08dc4e7761e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sNx3JR7vSgv8UpslFUpOJc2S4o6sU0UEv55LdDbjk+3OXDy7jYYFAvPHrWgKokZoOLdWKcYKnCRKm3JAJE6U3dnDh6EO4x8Zdn//8LU781uJQSXzsHY4LTudSPSipFCHvkeG7B65Lm62SirJ6Vf3ruwMeS7EcH0I8FU8E7FtFUEg+y8SXUkd8ENqhXLNAKzJiCUkB8+4DmKgF7QuIUTRh5/idL9sZ29iV1v+DqZbzqPIpgCyKs/S6Xu/xwczuo3ZtC6LQBQxKLph+Fg0LaETa8iSWKzWZH4mWSCMAndouRA/4Tkh5SSBbxV4NaHDt1J5THDx33ckAcoFn/S2NfVhXUlG3uWUc7tPVTI1+Ycnt/V0Gj0vou90FVP7WHcv2BOalpgpYBF5hqsJmNx/gzshMPJSFyKcPpjU5zJBwMHCP1Xxye6p84Wva+9dVyj3lSkjShe76sTbrTURb8Zi+320Dn63wKsEWNy7z7Z70XErzv/d2P8VMww5nv2wLV38kDjMQChtWnoLspC0dxnmB5nSEVraw1zTa1XXmIAuskfGVUXsz8unWlETulNSjKVcH+O66iTLlLduIaqOBmR+evOkhsr75tSanYAViIB9c6O/MgwazTw6kzBSkECQ6UUbPdaFXRauUZum+GslUv9BAdu+m5oTIGqQsFYjCCAxjXB/OQz1uaPsjUpFijdnuugL1GC5zK+k8IM3MBdTJBRaoHb1tJzrEPTLtX4JSh26c5+wG/wDf1vFMV3vkL7351Odvgh2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:03:02.9628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45aaa59f-fab2-49b7-cfce-08dc4e7761e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B070.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4432

In order to check how efficiently the existing NUMA balancing
based hot page promotion mechanism can detect hot regions and
promote pages for workloads with large memory footprints, I
wrote and tested a program that allocates huge amount of
memory but routinely touches only small parts of it.

This microbenchmark provisions memory both on DRAM node and CXL node.
It then divides the entire allocated memory into chunks of smaller
size and randomly choses a chunk for generating memory accesses.
Each chunk is then accessed for a fixed number of iterations to
create the notion of hotness. Within each chunk, the individual
pages at 4K granularity are again accessed in random fashion.

When a chunk is taken up for access in this manner, its pages
can either be residing on DRAM or CXL. In the latter case, the NUMA
balancing driven hot page promotion logic is expected to detect and
promote the hot pages that reside on CXL.

The experiment was conducted on a 2P AMD Bergamo system that has
CXL as the 3rd node.

$ numactl -H
available: 3 nodes (0-2)
node 0 cpus: 0-127,256-383
node 0 size: 128054 MB
node 1 cpus: 128-255,384-511
node 1 size: 128880 MB
node 2 cpus:
node 2 size: 129024 MB
node distances:
node   0   1   2 
  0:  10  32  60 
  1:  32  10  50 
  2:  255  255  10

It is seen that number of pages that get promoted is really low and
the reason for it happens to be that the NUMA hint fault latency turns
out to be much higher than the hot threshold most of the times. Here
are a few latency and threshold sample values captured from
should_numa_migrate_memory() routine when the benchmark was run:

latency	threshold (in ms)
20620	1125
56185	1125
98710	1250
148871	1375
182891	1625
369415	1875
630745	2000

The NUMA hint fault latency metric, which is based on absolute time
difference between scanning time and fault time may not be suitable
for applications that have large amounts of memory. If the time
difference between the scan time PTE update and the subsequent access
(hint fault) is more, the existing logic in should_numa_migrate_memory()
to determine if the page needs to be migrated, will exclude more
pages than it selects pages for promotion.

To address this problem, this RFC converts the absolute time based
hint fault latency in to a relative metric. The number of hint faults
that have occurred between the scan time and the page's fault time
is used as the threshold.

This is quite an experimental work and there are things to take
care of still. While more testing needs to be conducted with different
benchmarks, I am posting the patchset here to just get early feedback.

Microbenchmark
==============
Total allocation is 192G which initially occupies full of Node 1 (DRAM)
and half of Node 2 (CXL)
Chunk size is 1G

			Default		Patched

Benchmark score (us)	637,787,351	571,350,410 (-10.41%)
(Lesser is better)

numa_pte_updates	29,834,747	29,275,489
numa_hint_faults	12,512,736	12,080,772
numa_hint_faults_local	0		0
numa_pages_migrated	1,804,583	6,709,580
pgpromote_success	1,804,500	6,709,526
pgpromote_candidate	1,916,720	7,523,345
pgdemote_kswapd		5,358,119	9,438,006
pgdemote_direct		0		0

				Default		Patched
Number of times
should_numa_migrate_memory()
was invoked:			12,512,736	12,080,772

Number of times the migration
request was rejected due to
hint fault latency being
higher than threshold: 		10,595,933	4,557,401

Redis-memtier
=============
memtier_benchmark -t 512 -n 25000 --ratio 1:1 -c 20 -x 1 --key-pattern R:R
--hide-histogram --distinct-client-seed -d 20000 --pipeline=1000

			Default		Patched

Ops/sec			51,921.16	52,694.55
Hits/sec		21,908.72	22,235.03
Misses/sec		4051.86		4112.24
Avg. Latency		867.51710	591.27561 (-31.84%)
p50 Latency		876.54300	708.60700 (-19.15%)
p99 Latency		1044.47900	1044.47900
p99.9 Latency		1048.57500	1048.57500
KB/sec			937,330.19	951,291.76

numa_pte_updates	66,628,064	72,125,512
numa_hint_faults	57,093,369	63,369,538
numa_hint_faults_local	0		0
numa_pages_migrated	799,128		3,634,114
pgpromote_success	798,974		3,633,672
pgpromote_candidate	33,884,196	23,143,552
pgdemote_kswapd		13,321,784	11,948,894
pgdemote_direct		257		57,147

Bharata B Rao (2):
  sched/numa: Fault count based NUMA hint fault latency
  mm: Update hint fault count for pages that are skipped during scanning

 include/linux/mm.h       | 23 ++++---------
 include/linux/mm_types.h |  3 ++
 kernel/sched/debug.c     |  2 +-
 kernel/sched/fair.c      | 73 +++++++++++-----------------------------
 kernel/sched/sched.h     |  1 +
 mm/huge_memory.c         | 10 +++---
 mm/memory.c              |  2 ++
 mm/mprotect.c            | 14 ++++----
 8 files changed, 46 insertions(+), 82 deletions(-)

-- 
2.25.1


