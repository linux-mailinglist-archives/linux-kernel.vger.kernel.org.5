Return-Path: <linux-kernel+bounces-131686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFB9898AC9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EA981C263F1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4158412AACB;
	Thu,  4 Apr 2024 15:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="u2XQGM4z"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45441272C0;
	Thu,  4 Apr 2024 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243668; cv=fail; b=o1a1ecqmf0WG5sKASnGSDJd1uRX1g9sToamqpBkEwrnvvPEvI89GF0e4eri5r1H7FnKEbpGeQD/nKfPDzflEoxqD3pOYgFg2RHvkC0q4YzjhMPsl6qDEV9Y0MZ1xpU4cdYYK/kJmzI7bQG4L+zhii0pPTA1CxfOFQnQRaYY/NDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243668; c=relaxed/simple;
	bh=NofrJPj+4U+pgvzx34DXwBfKPJYrta8BFCUCH0PYQPw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFgoEc/gPQzr32dMflCuEEcnihLxlw2zlfoRkoDTffjQ9PytLNV714HK2gYPDgK5wm5fQoN2NS97hNi0IqN4ZBDTpkog2a6D93EebQccs9Dys/wJKm5CvleCGHrpdGhM1FWBAVvs/AbI8mNyAAwglVGpxfwtimbjSElJyUGDLAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=u2XQGM4z; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A88sqEM17b0zCwoT00NJXtivZxD8rDyAMSi806SbOy8GoVuttgz0qbvA7eh4EIpaVK+5lal1x2JCm/l0n1TrJJ8QcYIlZKfJawgn+9JyYrS1asHTZg1f0DuERVDL04IOKRTi/XRDeIJzGcm8ag+PW+z4/PsgRPLApKihhQAscisg7I7f/+YDc0dol7vz0D7Hx62wV0ir31LNuZN5moNziEqGCwwVGXoFieBe+2YMbEVKijlGJmfs/cXnYoTG99k5bC1XnUtxWEDUOI/ZvTdvCvAePx/mJgB4cWU+Bu249ALDRuvJ0fERJglyYuvkWNB7P5R84MtMWLCWQUyXFTfv/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzgGYP1AxCR3CLFR0mIyPVC1VQGoPa5NlguqXZbbgik=;
 b=MhvqxP2TldXcJCm7rlIyee6AanpBUBoA2Fbaq8WafVzCE7XGPcBkVGv6rlEDCp0Ztw6kGLGjMQsfubadxPxQATF7dupuJUlA+coLUb/dIQFX7gUuODXGOPnHaHRkkfA3RW5Fw32TDpFOwLk3izUca9ZULFS29B2EQaVpvs5x5bxdhPWVVk1HTcowaIEXJfx/WH+Bk7kGYAi5yzHRzO3lHGL9pQxRjGtC3yVgL8W3en2/fv9xlr4shKQMAYIIlLlei8XZU+Xd3mgLGrei4332Cgzlc1GXBB8v3uemX5lULa/aUPJ29gM7Ftvl5fqE5vmceayLTolovvrzqqWM05kOmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzgGYP1AxCR3CLFR0mIyPVC1VQGoPa5NlguqXZbbgik=;
 b=u2XQGM4zjdKBvMaE88JBgobeJG2IehdGzxAI09VcXh+o/bT9nN7WLUfvH2Y9fmNbFvRnszFsd22/NHkqtHf07B1oWr+i3VrNKpM91uhM15voueFfaboMIT+19ycj0Qv+7ygqffcZkv5r/EK8uEVFtYcvx0sAqalRbn/S9JqlbqY=
Received: from DM6PR18CA0012.namprd18.prod.outlook.com (2603:10b6:5:15b::25)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 4 Apr
 2024 15:14:21 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:5:15b:cafe::99) by DM6PR18CA0012.outlook.office365.com
 (2603:10b6:5:15b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Thu, 4 Apr 2024 15:14:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 4 Apr 2024 15:14:21 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 4 Apr
 2024 10:14:10 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <linux-edac@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>, <x86@kernel.org>,
	<Avadhut.Naik@amd.com>, <John.Allen@amd.com>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v2 03/16] x86/mce/amd: Use fixed bank number for quirks
Date: Thu, 4 Apr 2024 10:13:46 -0500
Message-ID: <20240404151359.47970-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240404151359.47970-1-yazen.ghannam@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|PH7PR12MB5781:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bc4052-ec9c-48c7-310a-08dc54b9e7b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bRAKIZ1HfHIrd5DWssVy2axZCGv18XCh3noYvQamFnkEe7OllC/w56DRpx6bFWrgqpgbVlBRJDaqHWeFwLyfHKNhn8HeYuhYncNoae+ozZlHXDC94DGRuySlm1/P+dp5vvjpV9YZGjOlZ3xWhjKllMpuhRk9g1/N5BLIkZtJeoohQt8Jpp0oo+Fg4Rx1a5LzGbONUyUWCSmilpSNQY99VT5QqpmzM6E+B2khUGKgn3BYcx/8JmJJJAWTvy0bDE6OkSsITM7a3iUleD0Bj2z4ln6OftVYioboNNKkqqo87wMPjNiEU+HJ6xXbm0aANUM2D7IWWJfznnqPPyUOFKZHqEJyUCvBa1THzzlyFOEpnnQ5+70A5nWi/fqqrAa7XgJCWS/5LijdxmQwrWLgzufQsjSPvVlvSbp1VRkTRxgtgyjnumG6QhxQDmHFwnFlkJKcBSKfFJQ1dHzMMJ953UgEacL6K9mbZKyC3dLev7zs0o1uCtgHzKS0IOjFCz3UiJXp3u9QNyCE0MXsa7sSxYhG9sotT7v4BkfCRF4TENC7uxbiO5k0R38Tht6ogmSLkAbBDjclsreZln0u5geSYeMBjL42EWId/02rRkrti3oPOOpb6rLRRgce7vTXojkGIOuBMJNlzJbSwAqK4YZv6Jh8yjxGW3kiBTjQbw80oyx9X2CWKExCEcHCyqadg9IZk/BCUlnXN/rHdHchc06OWeEWUg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2024 15:14:21.0715
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bc4052-ec9c-48c7-310a-08dc54b9e7b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

Quirks break micro-architectural definitions. Therefore, quirk
conditions don't need to follow micro-architectural requirements.

Currently, there is a quirk to filter some errors from the
Instruction Fetch (IF) unit on specific models. The IF unit is
represented by MCA bank 1 for these models. Related to this quirk is
code to disable MCA Thresholding for the IF bank.

Check the bank number for the quirks instead of determining the bank
type.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---

Notes:
    Link:
    https://lkml.kernel.org/r/20231118193248.1296798-8-yazen.ghannam@amd.com
    
    v1->v2:
    * No change.

 arch/x86/kernel/cpu/mce/amd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9a0133ef7e20..bc78e751dfcc 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -605,13 +605,12 @@ prepare_threshold_block(unsigned int bank, unsigned int block, u32 addr,
 
 bool amd_filter_mce(struct mce *m)
 {
-	enum smca_bank_types bank_type = smca_get_bank_type(m->extcpu, m->bank);
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	/* See Family 17h Models 10h-2Fh Erratum #1114. */
 	if (c->x86 == 0x17 &&
 	    c->x86_model >= 0x10 && c->x86_model <= 0x2F &&
-	    bank_type == SMCA_IF && XEC(m->status, 0x3f) == 10)
+	    m->bank == 1 && XEC(m->status, 0x3f) == 10)
 		return true;
 
 	/* NB GART TLB error reporting is disabled by default. */
@@ -643,7 +642,7 @@ static void disable_err_thresholding(struct cpuinfo_x86 *c, unsigned int bank)
 	} else if (c->x86 == 0x17 &&
 		   (c->x86_model >= 0x10 && c->x86_model <= 0x2F)) {
 
-		if (smca_get_bank_type(smp_processor_id(), bank) != SMCA_IF)
+		if (bank != 1)
 			return;
 
 		msrs[0] = MSR_AMD64_SMCA_MCx_MISC(bank);
-- 
2.34.1


