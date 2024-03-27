Return-Path: <linux-kernel+bounces-121998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DAE088F080
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE5929C38D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE0F152E03;
	Wed, 27 Mar 2024 20:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LxwWO766"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6F12D77C;
	Wed, 27 Mar 2024 20:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572886; cv=fail; b=hwxKeZJAmQZjZ+aLsVR2IK/Cq25izS+JCYcaSp3ydQsMuwln5guS2SEz4YQpHqOeB12BqaqW4MQ2o/KKJ/UTR2QU3k//rz/S+j9/iIc/z0SsxBZdq4yDWSc40MSF1Lh1oJjF19Rh2iLFChFaS/ajbWroc7iFVmEeCTUZxXxQMGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572886; c=relaxed/simple;
	bh=RNZbQbeDUq0N6LhfV47Csftymp1SbrMvz6Ol594Djg0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JTm68QB2aN+zM82yKsF+skd2y/gY7843jwy41OJjkWzJ8vbgwbDCNGIYEjMsyEjOhb7KNZRyiz+repMCD5XxWKSEEiIUGox0W9CqDuTktKwzZZRoRFW6NmkuRweyiiZDJxIqB56OpMyoqIBwI3Fn2SkguZJVblLJlWOQz2CnTkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LxwWO766; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQTQynlsXgb6ISbfMUSg7QMXT7OEhD9w13nBIzZJiDqwnMOrG+c0LQV6NGbBqjsRJ+oi6xz8lojYfVcFn7NEatHqs52UIMwzezCF7Qa3MociGKMYP1LhpZvZcDd2dg55qAgKafJDbQEYsziUKqzTDbPfYzhSVgFurwt36olSdAcY/H3cgwQs2vYdqjXrJgtlLvN5KiRuy1B5knvausTkwGAkeG6hb+9ry2kVsrFRS2uweFb2hX/TO8kg9U0I0KYX7RFnQ8lQ1zOjsZRu+jKWHdcvEHWp3Qssoex2WaYJ2Hs3K4iNVhA+kJ3GSiaCLWMmZeGWtCyAbwyh2XoeBBI8sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CW2QXv1IWMlE3MUe8cEwf0KqG88ICo5FYDkHIueGpcA=;
 b=LF97VbnIXuGxMHX04U9nCX56xF9PA8RynpB4W0BJm3RQdhF8BU/dA/2WDAhT5QW7bdcCeVG6ZO/wpMoMCOnHXP+wttE5CnNQ5UxDKgTikGWpOrh4lguX4kA3P4cEt0yoCTiy6sMLk84p3r9lB/739IeKITAEg2KPt9CMpSAH86F/lADxztqorODEClnXu6bO86jvMmtAzEsFZPfnEaZ4+OOdDeZjzUnMmoYtH8c3gf8oWjJPDiaha9wEGk98lh4x8c50XIHfDzt6UYd7TnXIJ+fB7H/pDVmVAZwZr2KOplaHj5UPiSCQU05Dznqwp9EwQlEA0CNQFydlkcX45vrAqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CW2QXv1IWMlE3MUe8cEwf0KqG88ICo5FYDkHIueGpcA=;
 b=LxwWO766XVe/26TpSW09afRzjp46FwUwkSUjtrxLWpxbwwTNjxjZ3FUOpJumoyD5U0aKzJ4uPvv6MJfHByvVcnxXoNHinozovZlPvuzD1Szw2XK/fPBUteL4e920YZTSplypCmTg0s46gBXoz2HjeGFPOTTlCm1lOmVMqYpmprs=
Received: from CH2PR20CA0017.namprd20.prod.outlook.com (2603:10b6:610:58::27)
 by IA1PR12MB8556.namprd12.prod.outlook.com (2603:10b6:208:452::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Wed, 27 Mar
 2024 20:54:42 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::5f) by CH2PR20CA0017.outlook.office365.com
 (2603:10b6:610:58::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Wed, 27 Mar 2024 20:54:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 20:54:41 +0000
Received: from titanite-d354host.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 15:54:41 -0500
From: Avadhut Naik <avadhut.naik@amd.com>
To: <linux-trace-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>
CC: <rostedt@goodmis.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>, <yazen.ghannam@amd.com>,
	<avadnaik@amd.com>
Subject: [PATCH v4 0/2] Update mce_record tracepoint
Date: Wed, 27 Mar 2024 15:54:33 -0500
Message-ID: <20240327205435.3667588-1-avadhut.naik@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|IA1PR12MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ea0768-75f9-4352-d585-08dc4ea02005
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eTK4EBm+rYjwgpXDIOUFKONMJIBr+UnMfeLzv3o+0x7OwxcimBx7licaSebgQE2LXIKBxlptOWHd3D2RDqVnL8NzpeBc5vQB8FQYwsmqPC6noYQfBPS1BjB7FRYNYneVTSispqSVqejDrHYF5eRHq+BTOTDUwZusbH4VtqSzRZEDCJsxS2nHxcDkkNwD/62DFujwJbJveEyFKfhYpJdhnwm81GhecJf5nW+mNbctED5FKX36V2jRppuAEQmi9994qYXJMG4OFJs1IehHpdjH/s1tUXyL1MtD4Zx4jpdKhFYa05OQQIE7asfe3oUqc5lh+LACQVTYSfNtZKx4hxCtL4FS1jVTFVa8I1VmmG8N9CM7RtPgtzgku/Q4QOmbkieTttwClLfkphkDVLVTJ/fwoHLcgylGOVve2hXKw0UfhCXwh/YprzoR3Vx9qiFKhZSmkvEQBbt45mirtvfVAL5RxNq/EXqNOJM+R7xRNsRvbEIgJqJFsLq+ccAqeBc/otRj4n0PdD4QzmiptWiCJSTI95z0ZlkPlOUJTFBJwSA9RoQTaG3CDH1+PAg4yNH/dWcE8C3ahAgJNCiYbZrOxRsOdPKpTEmSRFyuA0T/kKH95NNPXKRFz2AYlO6d9oqfkIw9TV5W4o3CMePVa9lUiSGSwTFnFG4UPiCjCF61X1xzeIuD33XWVdfQrjbzqw5+6omsWExZ0phNB/Qthd2AfC+bErP25uAYWSk2K7KJwYraDDTAXVQi2QpwZForf17t0NgF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 20:54:41.8130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ea0768-75f9-4352-d585-08dc4ea02005
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8556

This patchset updates the mce_record tracepoint so that the recently added
fields of struct mce are exported through it to userspace.

The first patch adds PPIN (Protected Processor Inventory Number) field to
the tracepoint.

The second patch adds the microcode field (Microcode Revision) to the
tracepoint.

Changes in v2:
 - Export microcode field (Microcode Revision) through the tracepoiont in
   addition to PPIN.

Changes in v3:
 - Change format specifier for microcode revision from %u to %x
 - Fix tab alignments
 - Add Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

Changes in v4:
 - Update commit messages to reflect the reason for the fields being
   added to the tracepoint.
 - Add comment to explicitly state the type of information that should
   be added to the tracepoint.
 - Add Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

[NOTE:

 - Since only a comment has been added and only the commit messages have
   been reworked i.e. no code changes have been undertaken for this
   version, have the retained the below tags from v3:
    Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
    Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>]

Avadhut Naik (2):
  tracing: Include PPIN in mce_record tracepoint
  tracing: Include Microcode Revision in mce_record tracepoint

 include/trace/events/mce.h | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)


base-commit: 818ea9b4c8237f96ac99dc0b2f02dd6d3f2adb97
-- 
2.34.1


