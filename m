Return-Path: <linux-kernel+bounces-104472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FC987CE66
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78B81C21BC3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAD22E418;
	Fri, 15 Mar 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tn3J89YH"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CC01AAD0
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510940; cv=fail; b=C+fyKVPkkKN6PaWCHj6irwLwpSJvQGqMeRqBrqPEZ/Q+orsqkZ9X9cMewJcjPT6HoGOiompDyM6R3u59IpXbQ2XOpI4YToI5WYFofXwKXj15blsO3MDhwQ8Tt1j9BnQb0GL8DHExNL76C4Hv8GDVH/ZDSGD+983aXXoNpU6YPeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510940; c=relaxed/simple;
	bh=mbs3Y3A8FeR1q86KRZbWYHG852dAaMb/qQetVmbaPjU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YJHgMLfoamF5A4Ckz9ipGXdHAGD+8ND0frQH99Tzggowlr5U+6gaEqyCkHLejLeXkLF+n+Kveyd3o+Z6vzbTkPvtDX8ar+FuWdk2vqtw0Z4hB3DgSpBC+JKxpZnVV4dw5dZVs9llGQRllMqObFFqoAmC8yaWYPm4/a+HNt2Pj3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tn3J89YH; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jkXtKnKHPPp2WIqBngO8kMhj9zaTvKl5/h/dGZgVGo+UhJTBURzqp4zEaIY5ROMTm3fn5YkIFu8vwV9CVju4swDhfBz7uJN0tQEAXKHjJpBEkrfCS5rRl8QFtSbVK0P+E4P6v7buD6nnv+/KIztlWEzVRRPjiMXEo+CG2Fa/5mE0KZ9mekIGYSr0h+JVO+4Jp15jjg74pW04LfP0quQKTASsrgjzUrTY0GL9/A8h3HvI1TceVmINya1n6Vlm7fVsXvyfGHE/qB72FIG2mIty6XzfDpiKeS9kqKMUjXDG1Pn2i8Ap1pqDL6X201pBGirruCw2h872J99froydj3hKjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhz1E4xPPvvLISV7AOBhGItPzQ2EiLhJyXRRmFwD0W0=;
 b=FvgW2xgj45GDckbyjCUcPsIBl8/tjM+N7pEm5OIG2jJ7XQhAYSvpDVMTSNhCjh1NVfaCMHhq+eN6buyZE9TNkBJlVguyglflFsHj5h7DxnUjE214393KemjTnWKz4nBQsj/RWoz5904fsF2jSyGcxYRiDM1L2Fo8YvLV8llkJuCHsgBEk2oYqZ+XMqPb99QiRC9DaLcua/aUIRPMc0UaPhlsNobdnBY/CypimziRGsoMU6qHtPqEyhU2GzROhIRvp7b9H+9qHqlRH39Q/F+ArG6nMZhNbndG9OUL/gDlxlVcAsiReFNn8jhqrncYZqyks0jTwKWdkZlFp1QxlZH3Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhz1E4xPPvvLISV7AOBhGItPzQ2EiLhJyXRRmFwD0W0=;
 b=tn3J89YHOVdQG+tyYI/VNREmZYt/esZ6l2euCx5Bp8jc25XPRg3FCaq9VOmSD5bWIGnpq2W9kDVmf7d4SD8umNkbknan6hpM7uTxeQRJsMvbmOkJX09JwvA3P9YUq8K2IBUWGQAy4iqCp2jhKENwxekqwQ8S/NBodP47tvRRSfY=
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 13:55:32 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::56) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Fri, 15 Mar 2024 13:55:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 13:55:32 +0000
Received: from ethanolxb491host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 08:55:31 -0500
From: Swapnil Sapkal <swapnil.sapkal@amd.com>
To: <linux-kernel@vger.kernel.org>, <mingo@redhat.com>
CC: <peterz@infradead.org>, <torvalds@linux-foundation.org>,
	<juri.lelli@redhat.com>, <dietmar.eggemann@arm.com>, <rostedt@goodmis.org>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<vincent.guittot@linaro.org>, <gautham.shenoy@amd.com>,
	<sshegde@linux.ibm.com>, <kprateek.nayak@amd.com>, Swapnil Sapkal
	<swapnil.sapkal@amd.com>
Subject: [PATCH v2 0/1] Fix lb_imbalance reporting in /proc/schedstat
Date: Fri, 15 Mar 2024 13:55:00 +0000
Message-ID: <20240315135501.1778620-1-swapnil.sapkal@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|MN0PR12MB6222:EE_
X-MS-Office365-Filtering-Correlation-Id: d3f1e6f0-8daa-4563-3000-08dc44f794e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RPxr+LJtFUpphGGtXMMH3M5ta/N8KSRoDxU1kv0Op5vOCAs/yhIVU9wWauseRlICi2wb4WOwtcWcjTuvHr+oW8xWCmDs9qNiHwdZryZCqSkcCFAAE6VMDXEyo9df4F+89lR5d4WkJ3u5AtAsYNGDHnIhZKR4KkgfYIgOzcXYj+ype2wTAGsOGCZaRHWai7NM7GB409QjkSyqVq0attMPp3NPQJBG3eJdzMx0OQRLHrnQ6rda/oAI98fDZIQ4GDCmupwgoMdPn6Y1gTT7xZMkRzEPmkldTEiLJKKM4dQp5EmnCwnMUhPMVwpb8YZaRdroupEK+eG6kwCcE5GrWBiiA0Ldq0M7jPxrea7qY3amy+wP8HZtC0jCNjScT3ysj8GEd7wA0WOiQ0haVKq+6yEhf4tDoYbC68/K/YoG69DsklbEsjwZHRiDW5CowkHMa6SRATGbKY8gVqrm1YNsBzDhJ/h2Y1T1R+XE523bzxBLFU/KQEBS6tOmQP++NRLrrn363MUAADFAb/sZU9sSaIzuNqBUJRNAufhVwH2foipn1BnboANP1r44b2NG8tGwh9XYNepg3fTHxaFWzNB/vVtS172O0OZ8LDco9sAssLzh6HAl2nniJTH0uds+3yciLY02wqkLd85feb+t69FoT8ysn2r/WCtBIdV447j1mdtFlqT+oCoSRxN2Zu2o+vQodHey9CFEXBXT0vCPOJUTGVEujw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(7416005)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 13:55:32.4761
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f1e6f0-8daa-4563-3000-08dc44f794e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6222

This patch adds new fields to /proc/schdstat. First version of
the patch is sent here [1]. This patch goes on top of the
commit d72cf62438d6 ("sched/balancing: Fix a couple of outdated function names in comments")
from tip/sched/core. This change is intended to be a part of v16 of
/proc/schedstat.

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

 Documentation/scheduler/sched-stats.rst | 119 ++++++++++++++----------
 include/linux/sched/topology.h          |   5 +-
 kernel/sched/fair.c                     |  21 ++++-
 kernel/sched/stats.c                    |   7 +-
 4 files changed, 98 insertions(+), 54 deletions(-)

-- 
2.34.1


