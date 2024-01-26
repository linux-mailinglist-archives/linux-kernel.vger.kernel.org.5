Return-Path: <linux-kernel+bounces-40739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B812C83E505
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB451C2308A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BF425558;
	Fri, 26 Jan 2024 22:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AyHW7+Gv"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BFE45967
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307391; cv=fail; b=biZlWqJX+lHqng0P3S2C21dRl6Dtx7hd4XB3arit/O9sbMNHwnuXaR7K9FIKEaLSjsBhFeVK7xMEf+WEEJpH6mcji4yYBFOilboXaBd0Ul90HjV0ZWTAmenYi05BNeHkaihOfumM69hV3mLTPwMsNJm+EMU9/zZhLr3CNCGjWMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307391; c=relaxed/simple;
	bh=i2Fi68z3YfGPRkY/+5XcHWtsnjVdh0vbFoAlDggqqS4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e8dcYFMoTrIe8udCJQDGUbb9rJkXrf9CH2KiHfAeZG71JmrentYo5N/sXbgeBv0lUVZ8Et8o+pgks2nX9TDhsR6BJ0PDBwU3IeDqSpkq0R9ft0wYMu0b1wZx6RxhaEJwMQ1cwi+3x4QqmUH6nDStGNOEi+5LDwNZephcz1lg5NU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AyHW7+Gv; arc=fail smtp.client-ip=40.107.243.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VF4U8tH1Tdk2N7+kDowYXNfGGsi1TAc4RPPWKpixt63sr5ZIvBUW4GSMTblbknqym4nTKp0jP3iu7QnNCvhSrJSzWsJITTLB4fE4xtGCbB2UycmXjZd80vDwitUE9wB0Dbc0rfBxpFrpW4ocDeQeFdE0p1oTCECrzzE1dirrCJC+5gFtzJRKGzA70/CjWAjSOqNMxdKpdXvx9rnVQE5tR6elBDEPROQrmXGV8jPtTzIxIC2ZrNFTJUgxuCfLFFC6idc0hYAuOnDxwAoEDC0a516Wqev1NP0FVqBNXdjmAjQDY5LOKYCKIvltsG18dl+U35ib3d7TtjMFGqx75mR9Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HcNYUneSi2t4u4aCe0j4mkp1AeoTuPw8mskIMrEw+I=;
 b=BVl6Q9Duv8T0WVI7WXtXCkJ2x7H9fWU0DFXsPKPgW7PrDOICHDKtf+fg28AK2BbsUmquX59W7yc25+mVaSggnBNJilDhDByDMFQ2GQc5shu3qc57je2OuGCQJm34V2xczDrTtzfg3nAYSbk8OkLEV6gpP1U0RoMh0lREgIDvx0YW3zxfl3xZGPFSqSijebTW0RND7UaHPphS49w6MknRkPTpO3uN+KrNQJ4WdJkZR4dEZhUHgx0hbc/NMx0u+yyImu5bu5C+/Egzp5nb3lNo5+9timUNTzji/4Y58V4xY/TaYBePCnJLVzhF7bxJ71rbEVqbkRasVjM73iBLf4zgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HcNYUneSi2t4u4aCe0j4mkp1AeoTuPw8mskIMrEw+I=;
 b=AyHW7+Gva9Ywd7WVB2OdSf2pbUOKkXf5Hpc2ycVnm2ZZE+GGS8+ZiwsfJWx23U73rdpwQS8IR4/YBqyPFsVBOJBkF9kl2zlcBc2c2MAB+yvefAjERt9mIIkAwlYAq9oaEimtBPY6kUIz3/nzJc44aHTlDyOSGberFlsjtDF7eEs=
Received: from SJ0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:2c0::6)
 by IA1PR12MB7614.namprd12.prod.outlook.com (2603:10b6:208:429::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 22:16:26 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::31) by SJ0PR13CA0001.outlook.office365.com
 (2603:10b6:a03:2c0::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.10 via Frontend
 Transport; Fri, 26 Jan 2024 22:16:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:16:25 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:16:24 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 02/11] x86/sev: Make the VMPL0 checking function more generic
Date: Fri, 26 Jan 2024 16:15:55 -0600
Message-ID: <69c954113a51e3a152c9f5308017c13441f29911.1706307364.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1706307364.git.thomas.lendacky@amd.com>
References: <cover.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|IA1PR12MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f729a70-d994-4e82-524d-08dc1ebc6fd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xISJTX+AHB6gSKFTPknlpxAHYl95kJ+GfWYS03bmAM7j7VSVn8XAKvQGLTmymgSK/glTpN6muxm/5PxXTpVUvKC2+pm/J9U83Sx6kfK/s/GGNwwVKntKaVNgrrHkGSTGNr2hixbrB4NgsE1FdKCpUHoGMnsZfVWMH8JfGKbYgW3WZILiKTkVUs3q8O+TM21f0hUgJ92Px03Ak0jjl5i0Uk83Hp+/gqTSBmu3XaGWq1ZihXCdZgM0mXOVGzdFuKkEChCwYv0/GB2C8dI/deV43TNFcds50ABa9YJoS/WOtnn3IsIS0SnL3BhLuxeUEXWGsyOoxYeQcUFitARloklfkjX3MTDKdjPuURX6b9G+h0uAWsx3g1hbvkJJLi1pKVYbVe7yz1xpmr9uRULPPp8qrs3Y4StJ46pqUVYEJeVEPpCHvTOeueopV38Sg/LCUnESYL5gkMasDNn+4KJaH8c8p6/SJXnXt1vsELv7LMIZi5siT0S8ZzER/+sUiYhoZTDSXTYNT6R9FeIJzq4XTzIQDSqd6bH+bDGa4zBiEyfLQwQYOYx+Zq6CphDk6pX2OwbY5ZllsVqq9KnuA/TMo7WbwFW+ett6r1ZQRbpid7x7bPecfqxDunKc8HSRRKb7lHd7yTwvos4/n6/ijathHkSS9ZhcH9jq8VyN4ihLdxW5Clhps1oM4Y3LQXu7GwDExnkGDrS81RsU0spT0u0FDzHYkHznNmWlW5umoZus3uZFzT5Ls0zsJ81jimqjUsBzKuRxHFRTQt+ocnSaWccw8lZnT+d5upFe5fhf/wquiXoi75k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(54906003)(110136005)(81166007)(70206006)(316002)(70586007)(8676002)(36756003)(8936002)(82740400003)(356005)(40460700003)(40480700001)(86362001)(6666004)(478600001)(47076005)(36860700001)(26005)(2616005)(4326008)(2906002)(41300700001)(7416002)(5660300002)(426003)(83380400001)(16526019)(336012)(41533002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:16:25.7988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f729a70-d994-4e82-524d-08dc1ebc6fd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7614

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
index c3030cfb6484..c44fa52d2914 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -327,10 +327,9 @@ void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
 		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
 }
 
-static void enforce_vmpl0(void)
+static bool running_at_vmpl0(void *va)
 {
 	u64 attrs;
-	int err;
 
 	/*
 	 * RMPADJUST modifies RMP permissions of a lesser-privileged (numerically
@@ -339,12 +338,11 @@ static void enforce_vmpl0(void)
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
@@ -580,7 +578,8 @@ void sev_enable(struct boot_params *bp)
 		if (!(get_hv_features() & GHCB_HV_FT_SNP))
 			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
 
-		enforce_vmpl0();
+		if (!running_at_vmpl0(&boot_ghcb_page))
+			sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NOT_VMPL0);
 	}
 
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
-- 
2.42.0


