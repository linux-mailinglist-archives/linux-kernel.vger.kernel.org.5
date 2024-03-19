Return-Path: <linux-kernel+bounces-107492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E6087FD44
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802A128396F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60D87F492;
	Tue, 19 Mar 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Atga6e8Z"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2079.outbound.protection.outlook.com [40.107.243.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637BD7F483;
	Tue, 19 Mar 2024 12:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849654; cv=fail; b=COwzT6JGMITxdPSLqV5cYkNlA95TnNKRUUyOotU03p2/rI9kryMKajG2B6aNFNqLcTuMdKzWzRz+pW83Wd+PZm2ndZMXRUbiCs0hOn764Mw7uysAGDb5zvTaGaN5pNt3a9XFVuVTjvHdD4PfexzO+JKRaf456JpqDj4X9FXB2QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849654; c=relaxed/simple;
	bh=UT7FJB6iCyH7A8Hh673DL6YTuhpE99l9kCBnaABRHVA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgPHaEKXdVsKwcetEdsKT/ouIRyyWO5qCrAkltm5uB/cmN+aSY/HGPjeqbxILY+Kzc2wPJsyCTXJlOuC6m2mrsCE5jkSm5RTAagK1hrEq+xdKGoaMN0Ulree7/eSQ67nwaY98qS9pXbvT9cpZANV/fZjQFcv27NfX2tA8FMHpwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Atga6e8Z; arc=fail smtp.client-ip=40.107.243.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MYpiRKRj0NQgITLCGSbYZrO/K3NWPiYAd/5SOqhHUIIWECwveYMgMqd55R0p9D1BpjW/lh7dnr8zA1YZrfNeJ9rfXhcgDxmoIsdGJA0HX4jvodTGEKpjy6YbQZiu4dU0DvRV3qrmfM4o+b4ecueCpk2QYvAU3f6+YYsI7fw7pjRLfQDsPrMP/KCmv6g/n9YrB3ialrmHx32Cd/kYqVCETInjWN8uK0d1J1TWnPTF4iAPiFcJh9kPlbF8nEiJFBpPs4LnLP22qSnKJgHS7jDmLWFZCn9iBSWbGq4tCVidYnTrtQDCWi1Z/BW2vmhviKPAT586WUTsI/D/ZIeVjuHZjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDiMGpAswITnliw62eRICwsL4AZV1FeLjAQ7MJ8aQzc=;
 b=SIxaam7xz3VnSDNWMeUTHslzTaufCS9BijS76ZCdcdF4xcNJ+TGyPtpGcIhQ1AEnW6Lp5lFd7fgGDvtMkKuU99X1P6T7bb4P95RdiH8dM76CyfGUjsreE4jycec7i2zcZRPaL+WD5zGyMxfIotmvWDh+H5W1j0jIJPEPAM1HGQ3M0rjwr8nfV5BygsqnnVck22PQsMnZq4LeNZBFqFCp/pz3HVYxFrpbN91OWkjgudsP+WXVkW4/6Rkk8wSyV5EKJEKYhXQ/4sK13QWG+TDBbU98juyEZDgS0IslFymvcgFp9vX/Fpgjaaunu8vcL6mQupGzk6PxvTmupdoBvht4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDiMGpAswITnliw62eRICwsL4AZV1FeLjAQ7MJ8aQzc=;
 b=Atga6e8Zn1fFxxuqO6P/jU/C59jZ5jXUMVxmW7pxAVrsJ4dqCbQRN1gcqpZKKB0Ec4bSaCG6yIFLVScZBUFQdOHoBRAKIkZbw3gidN7Pl/GsVooXFoKaCFqLW4FBDWfn0fSDNwISUpsy/W7+N6q3/StQhPXfczEJj9+lZlJFp04=
Received: from CH2PR07CA0043.namprd07.prod.outlook.com (2603:10b6:610:5b::17)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 12:00:47 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::f) by CH2PR07CA0043.outlook.office365.com
 (2603:10b6:610:5b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Tue, 19 Mar 2024 12:00:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 12:00:47 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 07:00:45 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v2 0/3] SRAT/CEDT fixes and updates
Date: Tue, 19 Mar 2024 13:00:22 +0100
Message-ID: <20240319120026.2246389-1-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 9838d91d-2aae-4d95-800c-08dc480c36b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FIfNvxIug5i50dUTTIt5mKxsjIV85jvqI3E5iqOQSDjG0K2oxLCYMTTSranmzzAnKhkhQF2owUCAKzSUrQEKKZwxPd5MAqoz0QVNSPvE2Ho7YQVm2ok0juXQ4GzuXyYdWXWRxQUZ7pV4sLoreiie9+cd+D1UiUry7xtD+j9OjfG6nJMYqJ591hivlrg+ZLenD7kZ3HfjpFX4yuxKBpa9SVeKBK79o9YNbmmWz02UEK6lcmYv/CjZyk8kRac9pxVaWXcxYnUHLHU4421w10PZ7dQUKu/Q2GLkgIdwPXwqhOwkSeZu2n3L53s4tpw2Dl8Jt8heSsXIJetwej4Ghk/GPMb6+g/TjXip7TXWUs/gt3T+joNCzEfBdxyo8slDB33TlJArWA4QeHLMbw2t4ntt4KC96imeviW8JgR0kshQEzvup9eul1KdyorrltPy0ej1AxpZLAl7Mk6s3wcUeU1+qqZ8umccP2aW+TscUa0iLzzyjdMswNiA64seIw2Xity/uhoFMaDHm125JWA26RcCcydC6DcWeBsVto6hho4lBTEdUJ9hMbThh8LTcblGh3IDAviRnjBkspT/6wROYCG7l8Ec2j2okDkyZlRDOxH6j/xKL8XsuEGRvbVv8rP51WN0l6AKmn8Bjzn5uuJijZZEWulBrNWNqMkttHDPXU/3FOvFzOex/b9QXjs9ZZjcZtc8DMe6MDpiZUK1FLm8M5NX3DrANl+CW3gdF7PdwDkpN5ILjI0bEfNgPxdAUTz8WyC/
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 12:00:47.4076
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9838d91d-2aae-4d95-800c-08dc480c36b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

Some fixes and updates for SRAT/CEDT parsing code. Patches can be
applied individually and are independent.

First patch fixes a page fault during boot. It should be marked stable.

2nd patch adds diagnostic printouts for CEDT.

3rd patch removes architectural code no longer needed.

Robert Richter (3):
  x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
  ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
  ACPI/NUMA: Remove architecture dependent remainings

 arch/x86/mm/numa.c       |   4 +-
 drivers/acpi/numa/srat.c | 178 +++++++++++++++++++++++++++++----------
 include/linux/acpi.h     |   5 --
 3 files changed, 134 insertions(+), 53 deletions(-)

-- 
2.39.2


