Return-Path: <linux-kernel+bounces-105863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A34D787E5AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:25:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 185F91F21C99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3742C197;
	Mon, 18 Mar 2024 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C3vN0UVL"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F8A2C182
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710753929; cv=fail; b=V9CGXlRlMsoOfPl5Zx7uHqhz4yn5BUj85WGAYo4DNyUv52Ba8JZ19AuSlNNmtSG7viC1YAyKjh0sHiNbvcjP/bbejWqdhOGoiClbDAweaL9FUBXjHWEpVqwgQApbphkPGLo93YFUFIfZEu1BmQVS5nMKD8m5bu39tPVjRtOR3tQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710753929; c=relaxed/simple;
	bh=odH5jlLSQhcMoZmuCZu616Md1FybhIbB9/qTYfyDVjY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hAd/xJjP68NIXUSQiOgp71RRHzlMWyiIE8ilCjV7jRjKvdfc6rm3eRv898QyWtN4bkL/btkNB/mtraLakQY9ZrUCIRpY+kzZqYysLJqGLusg5SYH0+o9DEr0XWN8qHTODqiAitnrV48jMOE2OaGZuRRuJ4Bp/ZV+nDJ0fDPqXCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C3vN0UVL; arc=fail smtp.client-ip=40.107.223.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hivyW/RALLM99PpncukaPyeKVvuFyQIHHl+6dlKBzqhZUQUb5lSzovxTBUYesRtKpRB3yNuV06EbxI/UoyzjAiL/AeWWIVgg5+MN8V02yFbiI7LwGj9rJOWzMWg50WHIW4sIqI6c2OWnR062DKwhi8Pgml83nVpAOWQOZMYi240Mzp36FoGqusQW9RzM8Ga+fDagHpGaZFmHULvDdsJrSuIolx+0cuNTYjw67DYCWpTveTTjA5rY603jo9U9VAqwH7ZyanF7s5JfN0+F80zsafsLV9uZFkPbk1EafEm7Ap5U3DpuclTgrvB3qynQQ7+TjQQ0YHAqAVGt1fsb11vgEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sc6ndLlZxpmTfL/YevkG4pAQPjAWt9RKn0NQwdav4S0=;
 b=QcrSukw+0dTtKGNAcgcO8VWs/7j8H+I1aequvBUH+agm2dTowJPV1Dc/lGZoTy8g6NQEXnVSbm1HY/0R6Fih5q20qSM/0FjzPc21jJat/9IsL3KNlYcYO3oWN+CwSuwbcHA/ZZjxEksCFYkzQ5kL/otV6JldDPxQzzXmHifAs6FQVUOo/qKkDnLyUp4bKWjMPl5h2DujYQ4kkxgr/jZzsW0tg79xbrKdlrLrWeWU4zuy9A4rg4GjP7Se2dLcNbm/TJq006oaTNcf796DAJjh89tarpipz7Mz467fkS9SXehDN1qdLDIfaxKIVE9Q1xdnb31T404QIhAldYpUM4DJEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sc6ndLlZxpmTfL/YevkG4pAQPjAWt9RKn0NQwdav4S0=;
 b=C3vN0UVLbqR+6o7hUmY1FH4gkO6s74JNYVBw/VSBZJ8n8S9E2u+O6GTUFJuEJ1vYbXntrnzicAc90XDHWfGVfZgh7N7EYeyqEaqlK87nollRrjcL9rjIDoKI6shC8yz7+DBehS21OMK8miwCrLdlJw3gVClbDGo/Kb4vR0Blpto=
Received: from DS7PR05CA0059.namprd05.prod.outlook.com (2603:10b6:8:2f::32) by
 DS7PR12MB5839.namprd12.prod.outlook.com (2603:10b6:8:7a::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Mon, 18 Mar 2024 09:25:25 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:8:2f:cafe::eb) by DS7PR05CA0059.outlook.office365.com
 (2603:10b6:8:2f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Mon, 18 Mar 2024 09:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7430.0 via Frontend Transport; Mon, 18 Mar 2024 09:25:25 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 04:25:24 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
CC: <peterz@infradead.org>, <torvalds@linux-foundation.org>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
	<sshegde@linux.ibm.com>, <kprateek.nayak@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>
Subject: [PATCH v3 0/1] Fix lb_imbalance reporting in /proc/schedstat
Date: Mon, 18 Mar 2024 09:24:32 +0000
Message-ID: <20240318092433.1791798-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|DS7PR12MB5839:EE_
X-MS-Office365-Filtering-Correlation-Id: 73f1543b-c1b9-4a3e-3bb9-08dc472d57c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ie4ogdXlbOKc+RaecJFA4fWU1jW0XUSk0RZbKo/w0cBWDRmVXCKGtKeGSAC2m6XLSxXT4hOUf/Td9TIRDplR7xCvmP6oUvXannySRntJ5PRqO0YP5YIc4HjYo4sdN/FclNW/LkWdvBC3bguzmDQR2qlwRQVmcLGUzvV0kc+QKc4RMAzsLSdTHmvW0xx+FL5nG9cFn/zQa1kbHo8CEN/WdwcughE+UPLFZvNCm8sc6SDcsRkuBG5Yvj1pYn8gUYm3ZzDdl5BZRDMslnhY3+yeIMrwx2ZkFHUmHLDZrkNsSlNYiZqwb35PrKQIhCHFOiJXvdglXahTVtBfEHyI+lePxqIHobSkTgPudzs2rSaEQOTfR9o/YiEa94qXWeDvomY2FDdDu982eEQJ2mTl5qHeapFxFzdbbLYUtIXPCTN1KEss+ZtiLZWmvJwJvD0XIdTYTAeAuNUXkWXa/dwNfIPHx86FbHYZvK05bhoOcxrxWEnTnBC8f+SZZdbOz4KLcLwJaLZKxSTCkwTJYvNKILXXfrHk0RM93l/k6gheEUxrAbnIjI9SrstZDGswe0SOJl57od0qCoavKoFI6xAD2jq1ezuH+MNYa7hglm7foKO8a3nHajgNTBFEaobY+gjdqnC4gzqenvICYZ9d9BvLGvRErZFn+CbtkS+wvRNYCaI12OIGHtcz21Nv+EkSghvtKQm+bKYBipU488+Z9HDK6F5LEA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 09:25:25.0877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f1543b-c1b9-4a3e-3bb9-08dc472d57c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5839

This patch adds new fields to /proc/schdstat. First version of
the patch is sent here [1]. This patch goes on top of the
commit d72cf62438d6 ("sched/balancing: Fix a couple of outdated function names in comments")
from tip/sched/core. This change is intended to be a part of v16 of
/proc/schedstat.

v2 --> v3 change:
  - Incorporated review comment by Shrikanth Hegde
  - Added reviewed by.

v1 --> v2 change:
  - Added links to previous schedstat documentation
  - Incorporated review comments by Shrikanth Hegde

Motivation:

In /proc/schedstat, lb_imbalance reports the sum of imbalances
discovered in sched domains with each call to sched_balance_rq(), which is
not very useful because lb_imbalance does not mention whether the imbalance
is due to load, utilization, nr_tasks or misfit_tasks. Remove this field
from /proc/schedstat.

Currently there is no field in /proc/schedstat to report different types
of imbalances. Introduce new fields in /proc/schedstat to report the
total imbalances in load, utilization, nr_tasks or misfit_tasks.

[1] https://lore.kernel.org/lkml/66f1e42c-9035-4f9b-8c77-976ab50638bd@amd.com/

Swapnil Sapkal (1):
  sched: Report the different kinds of imbalances in /proc/schedstat

 Documentation/scheduler/sched-stats.rst | 121 ++++++++++++++----------
 include/linux/sched/topology.h          |   5 +-
 kernel/sched/fair.c                     |  21 +++-
 kernel/sched/stats.c                    |   7 +-
 4 files changed, 99 insertions(+), 55 deletions(-)

-- 
2.34.1


