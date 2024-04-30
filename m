Return-Path: <linux-kernel+bounces-163547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1ABD8B6CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5D661C229D4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7401272DF;
	Tue, 30 Apr 2024 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WbkQsvh8"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79F17F5;
	Tue, 30 Apr 2024 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466245; cv=fail; b=fTiiBL8ujNc/TPRyY505Vh1j3i5pEn42ymalgEJSvPot/ROLGjIwkQLZbn0DzYfX8Fcwbx8L21EXxfuq5ZswZoET0hEXs5Ol0LvYbByfdVIPaahUvo+MDhHzXNpczRWOb6ehxwKo1g5oUwkNfiW51uOAAv5aJ06mFQNjzO5fmM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466245; c=relaxed/simple;
	bh=B1TI5WFMjMIkYD5EBG9A4mDjZ3CWqJ/rlk0+r/a55JM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dBLq6shqyf4PJpvFD32J82CSd/WcTHARfOXsGZ03MXF+51+raUhspfrU0sqUALGNIlcqbjAjn1uqTrTnYzenLRIPw4yYY8AyI8XiECLN1f93mW+hvf7DbnQylIPokSZFhe3ouz7bYHYu0l4dF0Ink3LpLrKoDNvLHHRQEleOPf4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WbkQsvh8; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b8Dkuohqid87VoWE6UHmpb7i3JxS7tMrF2p+LGRG2p3ChIwcssLxflQuhooam3b9RYqUMTcYzis7GhGA3q+F5TdSaPuc13hpxreT+OV2nmefxmwAtjT448gwG5jDuMw3lXWZZd5izRZyAkGux8SEmDo373/wiiIek0YCR0eh1cAWWBRgY4Qc07jVZPckJlojHPqdabZSN8xDwWWLmd901eVlVUttCMw3p0LVFKU4SoJT5vtbIBQ/F9q+LwF3CieAagCR1KyGOfl/jLlBxTLHBounx1VuqHWhJ5t9QfnQoiyYmL2Os+M+c48y3r5Sx6o73BpvwZpLvzO/S6dIOUYzNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czOPGs/aQBYCMQQyGaf/1BOHlY6yjvrwBR4yYLY47PY=;
 b=hb4SoJN8aP0ohqf6fOcHqTNQE23wmuly7rvZx5/603IkuxWA9U+Ea7Ho2D/RRyTUuObCZeOuk1V5dXcd956lJGeiEXo8ZPrNPfVG9NMsRYfwOJrFOFNo/NO5s7VTzB8vvwboy0HRubGnATmN4RfXgU4Ol1Qxdkax4y5R+GsdaB2ZFjfzpwb2SCHhl/ANBGuo5j6lPzp2f39wbqIJW06mP+PrxdnfB8OKEQuJduy2WjE6/Inwupoq6cRp7I1GMjMMvfNqg3TCNF0Dg60vn4s2USPHkLPMUkjyN3EurhPjI681MzkXQH5pj2qiqR13IVER3tROQ6o4Olrrs6we11OVxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czOPGs/aQBYCMQQyGaf/1BOHlY6yjvrwBR4yYLY47PY=;
 b=WbkQsvh8zOUC01SonHLj6d4ixoh9WpEShkdK1xc+BrV3pOTO0DUchW/gc8yAIgHt9JpTgG71Vn43SVcYPSlz46pElzId+gHS+d0mCIUSgfurh/TuKc/nqCSmge4gBkDHcJLPWZ3IrLHe5MsO/JNe3OH7qvfp0sYZR8hIsBPokec=
Received: from BN9PR03CA0638.namprd03.prod.outlook.com (2603:10b6:408:13b::13)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Tue, 30 Apr
 2024 08:37:21 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::e5) by BN9PR03CA0638.outlook.office365.com
 (2603:10b6:408:13b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 08:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 08:37:21 +0000
Received: from BLR-L-DUGWEKAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 03:37:17 -0500
From: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
To: <trenn@suse.com>, <shuah@kernel.org>
CC: <ananth.narayan@amd.com>, <gautham.shenoy@amd.com>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Mario.Limonciello@amd.com>, <rafael@kernel.org>, <Perry.Yuan@amd.com>,
	Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, Ananth Narayan
	<Ananth.Narayan@amd.com>
Subject: [PATCH] tools/power/cpupower: Fix Pstate frequency reporting on AMD Family 1Ah CPUs
Date: Tue, 30 Apr 2024 14:07:06 +0530
Message-ID: <20240430083706.69641-1-Dhananjay.Ugwekar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b877413-2db7-4693-0b5d-08dc68f0c0dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p9d4kgHtHorQO3j0CfYsC3bimkvYstdxcelotUcmUbwWMsKXk7Bq7gHt0tMp?=
 =?us-ascii?Q?46k68IhIn6I9NGCVsS6dNqDEOJk5sgFTIHT/zBCuTyVO48Z4+rLxlXTNo+4F?=
 =?us-ascii?Q?50piuyKQIbNcLQ4TA2VOSwr0R3SKTibJ3U1xtOAdFiQfEbCThVdkxirZU5Dy?=
 =?us-ascii?Q?qOOCVfX0mBx4COYodOxVbHFFoYZrrZhRCQHd0Cr2HvSWIn5hxl3aECs3iCGh?=
 =?us-ascii?Q?0rYJphSeQuNiXZCdcQFRh8KAnE/oOWHY6J1hiH6gaM2WDYAT7N7jssLri7By?=
 =?us-ascii?Q?6TTcerU3pKWVU071kkeJxku2WfDeix8Q956U8uE4pWDHCsdDIH+nvLzGmX9I?=
 =?us-ascii?Q?sV4oJ+QdP5kQy84MpItkYYryACRmTN+xA/7JNJbbEBaiplVH/FZj8czBgDNd?=
 =?us-ascii?Q?Tm/myNyk07+dXYbbq+4+I42QmdbhHXSOhmxUIrIWn/rzyfSY+WSJz6Vh4jwb?=
 =?us-ascii?Q?hoYJAa7aFXNnTyZr/ODjkznDPU/Ywk/ULPJ3DkMgpldiAQYFTDu19rcJnd/7?=
 =?us-ascii?Q?Fm2v3DNiVvvpNlK3HSycvfXRoFJWjFj8+7VBaka1+xuSDR7R6r1V1Pn5Z0JE?=
 =?us-ascii?Q?nt1Tuh/3t3VvNN0a42BgZrA6bMxWMLUKCyrmzr6ZLqfCcLQXTq+jYXUnE3jd?=
 =?us-ascii?Q?FRyP410JN/g+3s/KLIbKJH1sNTPeb8UNdk+n2vOyt40zAwhyFbLrfhWM8eJW?=
 =?us-ascii?Q?07X6B3hZvVDOX9DhV7pi25depx2tXFzIRdsVL/5EWQkcQ7F2icBPKPenL6hC?=
 =?us-ascii?Q?/0wIHafffJVReW1GpgfUU62QobQGMUwCXpRcyAq2q6lqWormoR2dwizRSDeM?=
 =?us-ascii?Q?NA2SKRg/hE0Q8ah4drLWAvatekVTFYnztbh4SLacaoiIhMN2OGDupklS1dWd?=
 =?us-ascii?Q?2shRocLukmn1OJDiD5xw/XwdqJXNe2bHsucX6bjm6+QHa/Op+jlCOUfqfctF?=
 =?us-ascii?Q?BgplN497FH14Xfzq5osqmgPrNU6nBEyhzOp/RMbT2IGfms9fWH8IxQFbIaMV?=
 =?us-ascii?Q?xo5qAaKvdSjV1d0i9i0oLTlO0rBkuZpAxCa34XwGhTmxPQ6MtKliT0FbyYmB?=
 =?us-ascii?Q?a2uj9WZwu2VZD2Tsri2dLnJFaKYocbQzmAcBDtwaX9oONmGBVpOKZ0NOpbU9?=
 =?us-ascii?Q?yihGlXtVnDp3rtDANp6UkKpfraVLD5r6CW6wFc/oQCkGAsfmB0h4ZVWiVuSD?=
 =?us-ascii?Q?KkONHKtpcxUk45E/A4MnO90gHwckj4fEAFd2l2AGUYbJv6o4VGjQ29RUotbH?=
 =?us-ascii?Q?Coj5EXhrLTKsmK27sa9SaL1EcnWQ2pTmjisPogPtKQLHVQIkyN54e+P1pgkm?=
 =?us-ascii?Q?jAxNGClVxkl8oKS/yw6eWwv2PxqkSmTJ7euSH8cGCL746ibmxBvO3Jh2ZO2p?=
 =?us-ascii?Q?W06nkbGXdmBgdpEOfWF8T/dj9hXk?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 08:37:21.6385
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b877413-2db7-4693-0b5d-08dc68f0c0dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

Update cpupower's P-State frequency calculation and reporting with AMD 
Family 1Ah+ processors, when using the acpi-cpufreq driver. This is due 
to a change in the PStateDef MSR layout in AMD Family 1Ah+.

[ dhananjay: commit log, tested on 4th and 5th Gen AMD EPYC system ]

Signed-off-by: Ananth Narayan <Ananth.Narayan@amd.com>
Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
---
 tools/power/cpupower/utils/helpers/amd.c | 26 +++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/tools/power/cpupower/utils/helpers/amd.c b/tools/power/cpupower/utils/helpers/amd.c
index c519cc89c97f..0a56e22240fc 100644
--- a/tools/power/cpupower/utils/helpers/amd.c
+++ b/tools/power/cpupower/utils/helpers/amd.c
@@ -41,6 +41,16 @@ union core_pstate {
 		unsigned res1:31;
 		unsigned en:1;
 	} pstatedef;
+	/* since fam 1Ah: */
+	struct {
+		unsigned fid:12;
+		unsigned res1:2;
+		unsigned vid:8;
+		unsigned iddval:8;
+		unsigned idddiv:2;
+		unsigned res2:31;
+		unsigned en:1;
+	} pstatedef2;
 	unsigned long long val;
 };
 
@@ -48,6 +58,10 @@ static int get_did(union core_pstate pstate)
 {
 	int t;
 
+	/* Fam 1Ah onward do not use did */
+	if (cpupower_cpu_info.family >= 0x1A)
+		return 0;
+
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF)
 		t = pstate.pstatedef.did;
 	else if (cpupower_cpu_info.family == 0x12)
@@ -61,12 +75,18 @@ static int get_did(union core_pstate pstate)
 static int get_cof(union core_pstate pstate)
 {
 	int t;
-	int fid, did, cof;
+	int fid, did, cof = 0;
 
 	did = get_did(pstate);
 	if (cpupower_cpu_info.caps & CPUPOWER_CAP_AMD_PSTATEDEF) {
-		fid = pstate.pstatedef.fid;
-		cof = 200 * fid / did;
+		if (cpupower_cpu_info.family >= 0x1A) {
+			fid = pstate.pstatedef2.fid;
+			if (fid > 0x0f)
+				cof = (fid * 5);
+		} else {
+			fid = pstate.pstatedef.fid;
+			cof = 200 * fid / did;
+		}
 	} else {
 		t = 0x10;
 		fid = pstate.pstate.fid;
-- 
2.34.1


