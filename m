Return-Path: <linux-kernel+bounces-106672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0D087F1C9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E3C71F21E07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26558ADE;
	Mon, 18 Mar 2024 21:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2DsmLrU0"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BBF458ABA;
	Mon, 18 Mar 2024 21:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796175; cv=fail; b=De1woiBIaxWjyQVTU0RXaHRz0/p92oCWwtjql9GAgb6E2P/C/dM/SJqGjX1PU0kqxsw7juVLy9CyLMu7Rp1kmtoW92PZM01yj2FHLA/OzyCynnfypuG0FlZYyArUNc19Aj0FNMltp2WqqwNAqMaiOTS5wCDZ+grYBQ/o4hlWwzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796175; c=relaxed/simple;
	bh=Rs1iJUKu5Pj9W/shCw0G3HArfRuLyGfvQTDvmlPR7+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J+Q5M4u8eXIJBbV5fn5yRL5fBA6QYBNlZ65/lZ/dHeJ0vIEa14JNaDWTwKGQMtTqOsGeI7S8uZ38/6iqNMVmpvwbCz9At13qztZofckLoFZapZMx/jPMWdWy8ldV5AbjO21+9nmavcKN63jd/qnn/zq1hYmncLwGi/Nh/As3xIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2DsmLrU0; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xi2A37wr/YkX52Mm/jJgyjs4vnvOEy2wOQkrvumdiHqAHULPANNFJ2kjy+wGOHV2CGDn8+HM/GK6ZiKcFla3UyEsmtBskhtQtjaGb/2vPHKwLlEivsCV58emFA7MU0JvCq6md+wUvGG7EpCZHqB9YxJpQ5GmrPx80s32NvA6qI5Xvp2goTirpPQsfGfycmf4GIKwSCFv2JZiZQtxp4F+liyTT8I2oD00McrkMK1Q3Vwlh14xz2cTFBexGMkcB6m+1TpgdAss2chLT9ioblGiingM1mhN5iG5Ghvvnn/RTJusJEmAaHTuDNq4SfVWunjZdu1TFXT6HBvCxVN9/F1XhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yfvOl7OMXtczHrRxsN8kO1IjTYqSk8r6l0Qd8Hy0/Q=;
 b=UQokN+fEXipSbGTfdOlL6RiHzE+6vpWIHWB94OnbsNGJLjW4rYr0sJFsMP7SudU7KX2Y4QwwMdOyCB7pS+jF3ZfnzcjbB9Ddnw4a6yFHghDkGK2KtiBJnE9Wmsnq4tZ+Qg8nr/sxqx09pjfA1SHiKCSXrDq28Lpp6oeVf89Js3n6MZPUZrpkKegqrx/jFFUKP9fsbbWzJZANIxsL9fvBa8PGxJIaiVgju250p1mjNmvSCmsn253lXYp0i4F3m3hIEEZjmzwYoweswMOlo7N9uPVtZfQJk8aEHuu6OY4pH3N/mG3EMH11xLUgbYAI1qu8bFhWCxLSTnd9OSxxWtH4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yfvOl7OMXtczHrRxsN8kO1IjTYqSk8r6l0Qd8Hy0/Q=;
 b=2DsmLrU0i8EIfOLifHMj7gktmevR16vR3WhL9usrFdtAFdnZJAFRBkS0hCY8+b42dZB0ArC1RRaMD8JEmGRDJXSOITqGjiD15rLSflEo5RgYsZuJp3fSTUAAIpXBYcnQ2R93DE9BlEgIkjkhhKUBW90Hrskls94IUQ3iA/h1kRA=
Received: from CY5PR17CA0034.namprd17.prod.outlook.com (2603:10b6:930:12::19)
 by PH8PR12MB8431.namprd12.prod.outlook.com (2603:10b6:510:25a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 21:09:28 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:12:cafe::74) by CY5PR17CA0034.outlook.office365.com
 (2603:10b6:930:12::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 21:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 21:09:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 16:09:26 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>
Subject: [PATCH 0/3] ACPI/NUMA: SRAT/CEDT fixes and updates
Date: Mon, 18 Mar 2024 22:08:59 +0100
Message-ID: <20240318210904.2188120-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|PH8PR12MB8431:EE_
X-MS-Office365-Filtering-Correlation-Id: acf0fe87-f503-4d8c-e991-08dc478fb2ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JBocndyl3UwGyWfEuNgCB7FNG4Aue917ip69iEf0Cvf6jP9N67ODGYrAQArkyaRZGSBZdDtt4Xt0eGrCCEhHBOPGpBcdYq8fmnLeDKpzp/JbpDg0O8ip9N91LifNONRIaQie91zf8pIsVxC9wJfFD/ByAvY2B9E2wbL1ZswDmGQper4/1Kn0JYurU8YXz93P57T0bWzetYTPDSGa2HQot8DnhFzZUmjlo02+pRDPKa2SrN5kSWAP3FCNwjfq6IRMfYyDd6GOo0FjklDw0JQOhS5efik7WfTmkkCf4Kr7D4S7Zg8yyBprizfmUJtr30Qysgxb7cT5BAVIJgLUKyEz0ubXFe2RP7/SLW5Jfq+DfbG3p6UrDt9tYE9wVOdNy8piHwbHAyVPZO6IINcqj+lIlWVwMkxbmaue4CbOzJnEz9TJiCeHWKxUoBqoFm+uaaxY01PNyoHktbaYgWnSr6XP7iBDsM0zjMCuJ0dS1QUIN3QOHuNILh5KLo4SiZL2Q/got6/G6MYv1RUtVXYsIh8v3w5/kk1hQIxvnCphiAk9U6Z5XJAW2ZeCp4gXfUGtrNmupF7RY2JXFVgwtXAe/Q+EeU1Fd1AfIGpsvswENiXPpD/WgyxsTM1LXO/dpgtoDtYA7WrVXXN+eR7QTlh+W2BTXTNm20J+lUtFU9HahkLBtM2STDrOlTFsQ7GSRkJudgbkboHBdXfZ01GTuFNQR9NBpk7U/XpiwGy+5yEm9OiZkSDit6bWS8fQ8QlihCu3Jly0
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:09:28.5356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acf0fe87-f503-4d8c-e991-08dc478fb2ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8431

Some fixes and updates for SRAT/CEDT parsing code. Patches can be
applied individually and are independent.

First patch fixes a page fault during boot. It should be marked stable.

2nd patch adds diagnostic printouts for CEDT.

3rd patch removes architectural code no longer needed.

Robert Richter (3):
  x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
  ACPI/NUMA: Print CXL Early Discovery Table (CEDT)
  ACPI/NUMA: Remove architecture dependent remainings

 drivers/acpi/numa/Kconfig |   1 +
 drivers/acpi/numa/srat.c  | 178 ++++++++++++++++++++++++++++----------
 include/linux/acpi.h      |   5 --
 3 files changed, 133 insertions(+), 51 deletions(-)

-- 
2.39.2


