Return-Path: <linux-kernel+bounces-118097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 866B088B3FF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135781F38D61
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC8874C1B;
	Mon, 25 Mar 2024 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zzvXCRDM"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F75763E6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405622; cv=fail; b=LGhVei+GI0vB1wJSzz9rk5J3kmmGPp6HAMjGwHZFuiQ6xyZ0YZ8+uzXX2nLakHyiXZG9T3LL7x4toEg2jfdIbEcnabR8bcTTir1Org/nlWQ9H/QUOUl4OwCt5pjwiXlJl0b/dBOTy+hf0rrTjyfAUTr0eOLivW6mHMc2rHXyJRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405622; c=relaxed/simple;
	bh=PB3ScLP4+/wcGJgVO8STzESNjf5T1O50EMshE3dpi5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lU3iGGchFDQUM/4vwTo8kNZE+LePjcd7mXo/72OtXM6FTLJ62NfkiVfYezBHpI3WhzN7Re4n4QrZ6lDBQCqVSpMdbDNk5rwsFQjsGiJ1aktEZofcDunC3vSeuLxL3quiuTtp3bZoKafDyb+/u0MYiX+h4M0kfHrM8Hb7XRHyLmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zzvXCRDM; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXOTJU6Cf9/aCtmFldYeaphVgnOakk5rUa0ChKCCc2JzFXZhAtzSrVx1S/l3+IaZD8NdoIvzZbORkOQksJjR6VA6R7B7pVjPLfd9rLQdUN5fwPuWKcvKEbcyc3htDbzh3wLCQV2B7M002ImwJ//dKod7Ewern2lPOgP1YMbDJh3HvVEl24imNy9qpDzPIqLBEGIskbZYh+eg7N2robm9zaxOPTbUaPv5KJnmjgfqrIf89HHPPaaJEtbrYMllbFLH3/MJMMRe0Y8favRpnY/9fMz8ZAgPxWSGRQrtINa1Mnlrnnkc01FrnV4say/oX+AaMnaINA2W5IrFE0NncqsAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN5QZrGS3+Cj+q5tlmfvaqsYgq1ZY9uSlVZFVWphlp0=;
 b=PULCyS03oPETwjfiKZ13CvGMSfj5f1Pnj022Wi2tjOZD6TxtkfJl+1UX2rlVaKeK8Vx/hth6TMu9S+E2S+1AN7wCQz0eEl+O3yltunUHHLrY7pVDO6uMjVeaxn3O/RI2QJYdDfyiUmONPNuqGDph3FaWA1e//pgYBy/C2qPnSHj32KfniQ5yI1oZC4fhQqTq+abkHaY3tqrvvLcddMXtkPLHqCiNKDx0Y6Hcn3jI5jSzEUgZff0zV+kO5+NXskUM46TtWECcDMZpizul2lyG9uMmnyhiLopvzqViEOkrNku48Y2xFGwD4QTTrMWcE/LbQhhMzdpCmIasN4+t0esGTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN5QZrGS3+Cj+q5tlmfvaqsYgq1ZY9uSlVZFVWphlp0=;
 b=zzvXCRDMuVMEjcbzZm1/nlBNsa5Goq/34yVISYqC6wIGTGbOVIuX538+cv8pH5u0imKVjAhIh7XLkfiECRPoE2f15r1+YuSs8oJIK5TQfficK/iNtyExpzL5hwreZzOP5ctfP5onQg83R0PFwMQ6zJD1C9vDE9+M2mugNNMttas=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by MN0PR12MB6317.namprd12.prod.outlook.com (2603:10b6:208:3c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:26:58 +0000
Received: from SJ1PEPF00001CE3.namprd05.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::f3) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 22:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE3.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 25 Mar 2024 22:26:58 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 17:26:57 -0500
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-coco@lists.linux.dev>, <svsm-devel@coconut-svsm.dev>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v3 02/14] x86/sev: Make the VMPL0 checking function more generic
Date: Mon, 25 Mar 2024 17:26:21 -0500
Message-ID: <1b0d8ec8e671ad957a2ad888725ce24edeedf74a.1711405593.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1711405593.git.thomas.lendacky@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE3:EE_|MN0PR12MB6317:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d9c53ea-3f57-4b6e-8e14-08dc4d1aaf53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C9Om5KurYmE/w+e6vbSQM+zHhj6TuUFGga68qqB2IlZ0vQiONkjZ052rhjb0fXWTy+hYVhBikF0lqXifP1YMmworOV76IoA+vNmHBAXzp4jfy0k292PBLfwUI3h/cnEKK84pEeCmG8Ei7bMFSiH74TuGW7sx/ckfiDW59Zo8udE0rEYsYYnV9VThC617LlfAwXEW5QwheD/2tMF3axKoM7n5asspNcU3GIFxWL8Gy2rXzzUJYujoP5EnjtPHH8QbWoJq7741k7d4+6uJjFazjglIZzqstIG+JBDi/Ayt+L4oa12P3g9yRNM2nARLc7DJKczSq5AjuwIih7aX9+osoeW5E4aBwRjsL3ynY+Bpkk852uB+xmnxFYIOqLmCNGUa3gCLzTfW2/tUyjUTFW+d3smXbXU8Si1gehkSvmpL7cEqi1IPrSRm1Y2yVCmYcjwzcLwDEkcL3V0cCB7KdYt8chkPoodxl53FgXB5cQ6H1HNMW6ndiIulzmhx5ZsNAzitNAuKzs3i9tOLHDKy55ZsZRQKrHQur3v4teuxMjzD8Iw5TAIPxOKROpU9NssTSP5Wpmucfux1DmFVSJo/LSgQa4RoEnf/So8dMKyLxX9cIMX8Nip3nUdiMYuixQYJi73ZMQlMqsU+c3c8LgrLD9fnFRF2vrUOf0j4VNhKEV9FLgLQax+XhBfUFuoMdWpOlDczlz9bzIhcEbQa+wQyLfHeI8VyypAMPixdL4C3B3AQMdIz8z1BiFDX9ezu3As3h7xP
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 22:26:58.4338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d9c53ea-3f57-4b6e-8e14-08dc4d1aaf53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6317

Currently, the enforce_vmpl0() function uses a set argument when testing
for VMPL0 and terminates the guest if the guest is not running at VMPL0.

Make the function more generic by moving it into the common code, renaming
it, allowing it to take an argument for use in the VMPL0 check (RMPADJUST
instruction) and return the result of the check, allowing the caller to
determine the action taken based on the result.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/boot/compressed/sev.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 5ad0ff4664f1..49dc9661176d 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -335,10 +335,9 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
-static void enforce_vmpl0(void)
+static bool running_at_vmpl0(void *va)
 {
 	u64 attrs;
-	int err;
 
 	/*
 	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
@@ -347,12 +346,11 @@ static void enforce_vmpl0(void)
 	 *
 	 * If the guest is running at VMPL0, it will succeed. Even if that operation
 	 * modifies permission bits, it is still ok to do so currently because Linux
-	 * SNP guests are supported only on VMPL0 so VMPL1 or higher permission masks
-	 * changing is a don't-care.
+	 * SNP guests running at VMPL0 only run at VMPL0, so VMPL1 or higher
+	 * permission mask changes are a don't-care.
 	 */
 	attrs = 1;
-	if (rmpadjust((unsigned long)&boot_ghcb_page, RMP_PG_SIZE_4K, attrs))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
+	return !rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
 }
 
 /*
@@ -588,7 +586,8 @@ void sev_enable(struct boot_params *bp)
 		if (!(get_hv_features() & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
-		enforce_vmpl0();
+		if (!running_at_vmpl0(&boot_ghcb_page))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
-- 
2.43.2


