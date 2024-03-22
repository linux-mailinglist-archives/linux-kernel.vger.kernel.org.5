Return-Path: <linux-kernel+bounces-111710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7B3886FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D9F1C21BD9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC60535AF;
	Fri, 22 Mar 2024 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PpRfSUOs"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29B35381A
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711122083; cv=fail; b=CzJQiankDl4+efZW0cPEoeLQe2oz0xE0ClFknAZuht5hWC77AQCnqRdPj+0cORsN8raqehN2nu+GL0KT0Ocd0JZfRPifdi/wIibuzWKC5QzeDLI1jo/yK5O8YgDTMN56f2lRtS8N3S+jIs3lv9pL39GNGRYyun1BcxOm3yC1AU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711122083; c=relaxed/simple;
	bh=6cbcC4Eohy6gkR/AiEP1X/fVhneq8FFHOOJ0EirTtVc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uxSeBRl/M/yLovDZInVWexvGzSzfcKD4nKt1SpH/rDS9zdC1n/1t8uWX5hXNVTFRzJKZ5rTpvJw352ztOrZqfSPyL26RSlKNPoz1xfoySEipgqzIVMH39Y6tR8kwNPq90JcGu+K7I93HRQ45MknPGddSDi+DN7VHr505cgJrpP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PpRfSUOs; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7CK+KuCPkl3x2bJl3FLfAUiB0c0yAaaW6+Pc27C5Y97kUgSGnrJ9FjiPB768zyP9DcIEbIigBm31Gl8Vebc4XQk8Tk6CRJWG4P9C6Vu91ExTUE1rGi+TioNPvgLfMdsfSguKs9b1mNIvODBCMSMmlehzQDigbU1q4jgyO92JOeVAIkSs+p1ntxUsK0nODisARqSDgBsSmtRqCdHWgpepDKPUiiYCzAt01IE3c/jTVctTA/Z6f16q62GaSac2T3GU2xHYNpsf72CBr5Ccq2CM5L4I7OEd/jtU3DdJ1fC5yAUdBr13XZCDBSeP7s0YuSSC0Qo4bLb/1gQlPARndQkeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AuaH1+aI0nPBYWjapmvgtDaK2UUq+1gDrPEkXKFS1JY=;
 b=c9NP90aXNyZfiIIkKJQ86wJyJl5nf/ibVpCiCJMz93G5dI7tvdENYA9wehG1InVwD3oLuHGcPQtz9vI+phKlS4PmA+VeHbZFPtizC02natUwMwnHpy/dY+e6S/O9CxRKUEuTqwzZgrV9Y4EXHMsr3aiqnWuqoOh1f6pdemXWr8lCLFlnWywvDu/G7tP1z7psMZsu8viJu+ZW0B6mvgd0r9MHUljuchRf4vIz4ZBB3hHi0dXD2+qRcXWPk4Z3h+mgrS3PHlzMmCK8ZpLAbZhc22aixW2T/1HY2POZ3GlUJ3vqQ0DynB3Hj9xOtNlCk9VCS9g3+q24MfuJo25wMrgzMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AuaH1+aI0nPBYWjapmvgtDaK2UUq+1gDrPEkXKFS1JY=;
 b=PpRfSUOsZSDyajlX15385D05u8AXQWqnUoNw+UPwDcuzqSVle2w175mFiJyWj+j/B/DXok6qksJNq9j8RaK04+d11dXQGUXxB2J22vvYmKdZWRVpWNEamBkLWxzJPqu+GWgmCUaPCJMbJc6RxIAyz8QyMWRJIUooWhCdR+dtyso=
Received: from BYAPR08CA0020.namprd08.prod.outlook.com (2603:10b6:a03:100::33)
 by PH7PR12MB8153.namprd12.prod.outlook.com (2603:10b6:510:2b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Fri, 22 Mar
 2024 15:41:19 +0000
Received: from CO1PEPF000044EE.namprd05.prod.outlook.com
 (2603:10b6:a03:100:cafe::cb) by BYAPR08CA0020.outlook.office365.com
 (2603:10b6:a03:100::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 15:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EE.mail.protection.outlook.com (10.167.241.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 15:41:18 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 10:41:17 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ard
 Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] Fixes for recent x86/boot rip-relative addressing changes
Date: Fri, 22 Mar 2024 10:41:05 -0500
Message-ID: <cover.1711122067.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EE:EE_|PH7PR12MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ad1c95-a33a-48f7-aa48-08dc4a868481
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ugkvfv+1wA1zjraP99fiFrehGYhlcupI2NQq1RKozIqO7guxWdPag8xgKsYN/qY1mi5qrxwDPxlknqyAaYIj+7xqRC73rRGCclVGUZtsF2/s6k0ZirT7Jxt4Ci18c3DGxRYYTF6irmJsJeWgjpS8gMgFBk0ZKMs5zgdKWaYXGabVadwOwrqozEiLX27zbD1wKT1TNQF7eCqOomddr1cNYsaAX7RnqwztsqjHl81PZTz07t09ZZbMh24QcXXdc+tdvqPABFPjeHD9HtytTZ9sRpiB2rKA85fP8uwdrqZrmyTOyy5NoLJTCgv2QLe32pvzMIzR8CZasGp/FQO0DeqbHSk1PzI2kFqUwNsxkyMLu+zcdt5nRp2xm5V7N8Gs40ny3Ffm40+80tERApko+OArauQqwGLNQgTRjzpA9byVQydrrkU2ov11PNBvgXaDHwbgJQffyrti4ObnstNuXSTjYcMjLdwgg5DsLeTu+GYHsQfKszl8f/kbqHyr1bq2rozMucOd60TFPna/vKF6SyB7cYIiXGrE3H+PyvWfCRUtiB+HJK1sQj0PEyJkjAWluyU4SHGNR36nxt3VJh9mT4zwSltnkEYtIVY3uFOdbzoPP0QmD79Rdl+WRKtw4L5mD0z2WzxSRFmNtZiZR5D7rISxCGEiLcW6O6HccHfFbmphycbkHF0Y2RhIeFtovQ9Oqf2zMPpcF2hxmfgKeMceITXQ1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 15:41:18.5493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ad1c95-a33a-48f7-aa48-08dc4a868481
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8153

This patch series provides fixes for the recent x86/boot rip-relative
addressing changes that causes system crashes when booting with 5-level
pagetables and SME active.

I thought I had tested 5-level paging with SME, but must have missed
it. There are two patches to fix the issues that can be squashed into
a single patch with multiple Fixes: tags if desired.

The second patch is sort of a revert, but instead uses the newer
RIP_REL_REF() macro instead of reverting the fix and continuing to use
the fixup_pointer() support.

---

Patches based on:
  https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
  30052fd948a3 ("Merge branch into tip/master: 'x86/shstk'")

Tom Lendacky (2):
  x86/boot/64: Apply encryption mask to 5-level pagetable update
  x86/boot/64: Move 5-level paging global variable assignments back

 arch/x86/kernel/head64.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

-- 
2.43.2


