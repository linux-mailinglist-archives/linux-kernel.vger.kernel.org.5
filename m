Return-Path: <linux-kernel+bounces-97468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5B0876ACE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B6CE281C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C53B797;
	Fri,  8 Mar 2024 18:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AHeKhERs"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2075.outbound.protection.outlook.com [40.107.220.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32CA5BAE3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923025; cv=fail; b=RAwND7bPM7FVr1HRWjrabmztczOrCZXU9Q+qKxIjqSwK4QxYUfMVbl2yAPsvjLjQQlqtblzGRYNwOrMbE+gdHEaGZF6FHHqTvLJYlaJXSxO1jDxRpGhCi1TYMenD7EHd3Tc06ohs64l6qWZF47hhl/YJ4Ovy33WgMG4EWMuCFKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923025; c=relaxed/simple;
	bh=OWB8YqMR6+ubxClvOGMFr/5+2vbqxc8R+T+UHSSCbvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qo0iiDEC6kuaxETZyQHciraMFVh8psTMSVLhnhtDAv/HP4Vk41DlLu1s/FBo1/WvkzM0MTh+NAqOhLE21pQXtDimVQXG07DtGaLmCr08rozjK0rVXlvPxe5ytyPeihjXFgUO0mOBCTwnk90bTpx+ZrsIW/WKPrxZPURFCHO8ddk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AHeKhERs; arc=fail smtp.client-ip=40.107.220.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEgpTJnHo66ylZDKIisMx+NADFtArCgF4piBNSQ9hOB95IXzfssZuRZig1QCcQU19raPrucVaMG+bimphdnjBtqNgLJ4IK91cd6wWafJspS2H8GYFewWw7jbEC3/7Yl4HzYhu3jLLaSClcmsv9bMRIbV57caC8jEO95lpqcvgUTEALmU0//71Y1T34BSy6HfxlhrFlHHypViTxTwEfiVM8w0EVj73ntTAKH8dGAA59uj4oG+pWkfATRJ1QjLCKNFlNGoa/vX/xXnGOqvmcy8rKaoXILk92FzR3AVxyxfV/wGmR20OZEz4CUKVi4b4yPzkzekZ/6+o6nhnUI9gii/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAmK2+/fKsarqC5Jy2zMoU/XCCPURo4lIHxka8k69Vk=;
 b=dwtxeqUyIVOhpvfW6jZWTIEHDr4qQh0QB4iS9PVRkvSHqcFD2lFqk6KCuJZMrvck6ztqBKg9SRjQ8zWF9gSVEl2xkqMOrYVtuJsFY5eTl9KsZg//QvsuntFrjUn2kM1+HdAk7BpIfnoDeT+mOvcbUdrU8ThETiqBKJIQsc/e8NmWsW5QlkcuYuSOzkpGXWMi6ybwyujfuwGosS8KO4l20fdRvCqdCC9VFLE828i4rXomTkn3gjDGp8ZfvUizAmJk9pIZrOqHxXtOEaRGra+VIwUxugStEINmoDHwq1G+grQQF0Gxu6MjPtPr+c1SkgoXOsaDHgJIVuWg1yu4/ujaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAmK2+/fKsarqC5Jy2zMoU/XCCPURo4lIHxka8k69Vk=;
 b=AHeKhERsRlcbynMPv/tbjpIGVqH6R390doAE1RpNwNtsRZ1jLgwHBuzD1eGIMK+ebCPUSGuKqawsNXTfYcmv9uWXcmJzvE0QqS8DJktOHeIOXAMJbxl/BJzeYjFkhr9HkhfCNaYwlJxuMe+ghl4HeAiqtJBzF/dzNOBEvy5K1vQ=
Received: from BN9PR03CA0297.namprd03.prod.outlook.com (2603:10b6:408:f5::32)
 by CYYPR12MB8732.namprd12.prod.outlook.com (2603:10b6:930:c8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 18:37:02 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::32) by BN9PR03CA0297.outlook.office365.com
 (2603:10b6:408:f5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Fri, 8 Mar 2024 18:37:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:37:02 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:36:55 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 10/14] configfs-tsm: Allow the privlevel_floor attribute to be updated
Date: Fri, 8 Mar 2024 12:35:25 -0600
Message-ID: <45573c903efedc3d4bd00e902ba6a4b1f0cbbbc6.1709922929.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709922929.git.thomas.lendacky@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|CYYPR12MB8732:EE_
X-MS-Office365-Filtering-Correlation-Id: 88de7f1d-b694-4f59-6ee5-08dc3f9ebf18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2epFRAm+Tw6PGEUop05xB5gd11IT4WSZMytyeBYUfMhU5Cscji7qDR3Hm0uGLki69SoZvnymaOMM1N9YPNCgE01m0zlQwLz5eafKTxKZzcYdSgH3dIr66n4squrtfkG7fwduBr9JRHVV7ogFAVCw2CwI7PfKAsp5ztdJyY7o+OG2oJVKQlWq7FNnW9C3LkPJKdlgP0FnIPzds8pB12P8lPpoqs+2B0qY7502O1VaUCvebf/GluASjV1UQbchzXs+BUtdEReYa/rAlsKdEgebd6mGLzeEvP69Y4G5vQBuvJ8Vzd+jd4aPHr63mmTPn9JQPbCrmN52vMBkL8jKuxtL4SZU0+qZdWKWd12hGS9iCHyC+Rj+zrBaDv9vZnP/ZfyCu9LcHZV28ylBx3rQWhNAt/t83rPFpNv70l58qzsNfEy+Tx/RZPvAbqAkp2ycNgpEeCFLpJQWGzzk3BH8m3jUFXU5EDgyIHbp0uMNgsfSQHWus/tvAQH+wHrANh88B92Ce2igV/MxKysCPGIKNm8YEFH37ImSYOJSU5FRP+253azWx2rWAN1Cbb1BLAGTZrYAkuppllf3oqgWHHKNt1Sx7xU75gioPFxc0XbgZHb2KjihmDgVCCVcaF42oow9bBFkZNdtL6bHqmv28BtluUugNzc5Ft7XozaD1YwMLNk3Zd9T85CzvqlLT8i3uKn8qWl2aSxa7p8UuRsWOj163xwg2HbBpMPVSR4CycgHBogsyv+11tU/2qTqCXrfmXR++Zzx
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:37:02.2887
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88de7f1d-b694-4f59-6ee5-08dc3f9ebf18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8732

With the introduction of an SVSM, Linux will be running at a non-zero
VMPL. Any request for an attestation report at a higher priviledge VMPL
than what Linux is currently running will result in an error. Allow for
the privlevel_floor attribute to be updated dynamically so that the
attribute may be set dynamically.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
 include/linux/tsm.h                     | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 1ff897913bf4..bba6531cb606 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -885,7 +885,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	return 0;
 }
 
-static const struct tsm_ops sev_tsm_ops = {
+static struct tsm_ops sev_tsm_ops = {
 	.name = KBUILD_MODNAME,
 	.report_new = sev_report_new,
 };
@@ -972,6 +972,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	snp_dev->input.resp_gpa = __pa(snp_dev->response);
 	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
 
+	/* Set the privlevel_floor attribute based on the current VMPL */
+	sev_tsm_ops.privlevel_floor = snp_get_vmpl();
+
 	ret = tsm_register(&sev_tsm_ops, snp_dev, &tsm_report_extra_type);
 	if (ret)
 		goto e_free_cert_data;
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index de8324a2223c..50c5769657d8 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -54,7 +54,7 @@ struct tsm_report {
  */
 struct tsm_ops {
 	const char *name;
-	const unsigned int privlevel_floor;
+	unsigned int privlevel_floor;
 	int (*report_new)(struct tsm_report *report, void *data);
 };
 
-- 
2.43.2


