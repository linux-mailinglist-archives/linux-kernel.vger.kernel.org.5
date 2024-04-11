Return-Path: <linux-kernel+bounces-140077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF1F8A0B27
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C232A1F23233
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432D213FD8E;
	Thu, 11 Apr 2024 08:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rvh1fOHw"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95451DDE9
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824052; cv=fail; b=TVDc2lnrSAoU9EPMRvfYQ993Z9s18G6Y74ffiyQ5rMPa2WH++ofJXSB/sFs3OteCw20Mal7S7gYLHnv+LJ8EehZpfbL0B6T+aavNSfq+mSqYtYxXvv6ImKjACw63KwbfgDtS7bUC2DNmkZ2KiZaKGFnlTGNbauXXFZhyg9raF8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824052; c=relaxed/simple;
	bh=cYGRJCZShMuKyrlnAhRZe+TzxQzhrjgKn2+ArOeYBx4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZPkrUqTLswdhVteJGFw9DWawdqbMbYppRgbf+qN2ATPeJFSf7N81pWZuAsJovKtFHChMYPzgldvR55p/xTLx/wpyjduY5z8FYkX9kHqXP1LoVPAb0F4whQ3S+WJM84J4RDOzF9527GOoA3+4wjwGJEJziWQoRf7u66gfB85niCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rvh1fOHw; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ik7+KYQXazMaNQ0XME0PrwW9s+P6fi4RC6AmByo/sEBN+WynqTCF1O220mZJKSxfagCe6SdPAZ5Ck8y+bxC2AINBR4rr/ayNSfrf334tmb7TurRdFGJQjoC5II6Am33rhonP9EExT91Kau/qw8XOHqLJqtEMaY+YvtujeY9azIv23jvC+pPPsu6rYOFAX7G295tE6gkEyaHFwgRttNxCp6Y8P4BVcb9zYbZVD51QCElo4Ti96kULsUqek0pimdnqGwo1LNZTg+ufk/aOKDa4gkpDkIw1vimrghzppBPJ7SzW9wI4W7Zc4yNARNGq20YwdOPjbP1Mvdb4t1ip+ZhBfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+//6eg9xNj6sPX2YEG8c45puH8WnsvFC0DdWxmTd7wQ=;
 b=fFIFmeH3Ih8ZTW698rQjbsUGjmW0fIqy4DyCx2S5g9bZ6YexG/o6xx2KXzsl2yG6r0jh0/3gO8FBmIHs44LYM5xzLH4PROntKUZ7hp+WNnIK2HwPn9ZZq3VHVQxbjSQSVmRyMvb2D/xdkn1bUFLK5Nf7IBQMaD/Hd+RDLC7Cc42cRAkCa+wvRlNh9I8GYsDX9gdinAfAo3QS+Wb8ReiBhrQCCGt/LWjKEaqtVNiaIlMDYwmi6yGBCrw7g9Tre3yGo3fEKzznOgdaeFTKCzMqoUw8MWHHW3PWZ8bCH90c4ez9EeKyxAlbXwpgd09d1t+rpG6N8P5hLepN8fRSsyPAbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+//6eg9xNj6sPX2YEG8c45puH8WnsvFC0DdWxmTd7wQ=;
 b=Rvh1fOHwmZpKQgROCtNI+GaqjK/4qzjigcrfIgwytpKyhYE5XZpHWqGeQywcPihJVDyKfURS+1nDagXHC+lpbGn3oAt3qJm5AAE69eebzqEpmFACP5h+SN/ML1IYDyF4GDJQSASXWBkz0sJpmRrLnKL8IBrKIxKf2CzkGGL3hbM=
Received: from MW4PR04CA0378.namprd04.prod.outlook.com (2603:10b6:303:81::23)
 by MW6PR12MB7071.namprd12.prod.outlook.com (2603:10b6:303:238::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 08:27:28 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:81:cafe::7f) by MW4PR04CA0378.outlook.office365.com
 (2603:10b6:303:81::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.22 via Frontend
 Transport; Thu, 11 Apr 2024 08:27:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 11 Apr 2024 08:27:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 11 Apr
 2024 03:27:26 -0500
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Rob Herring <robh@kernel.org>
Subject: [PATCH] microblaze: Remove early printk call from cpuinfo-static.c
Date: Thu, 11 Apr 2024 10:27:21 +0200
Message-ID: <2f10db506be8188fa07b6ec331caca01af1b10f8.1712824039.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1112; i=michal.simek@amd.com; h=from:subject:message-id; bh=cYGRJCZShMuKyrlnAhRZe+TzxQzhrjgKn2+ArOeYBx4=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhjTxea/3LTCa4SG5+uezadyv/RceOe94dbVsy3+Zav4zV ZcuRNp5dsSyMAgyMciKKbJI21w5s7dyxhThi4flYOawMoEMYeDiFICJ3BZlmB9zN0RgPcdf+c1H Yq72rj/ivX/PtIcM84P5OJaUW+q1rv4+bePuv1+rPpinfwUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|MW6PR12MB7071:EE_
X-MS-Office365-Filtering-Correlation-Id: fd92ce1a-5b67-46f6-f889-08dc5a01395a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WHTU29YXleha3/zviijRHfpM+dx7IkacCp9Rfhq1+PGiOW4zIpRSUjwpqq9i1TpjXNRut0QH0WcK6GZoj6qvaOLPHFnxW6bkc5Glya8MNfF4lkbVspA4SXwzdepCwTAJeDY3jmQCYt/ueTw5dD8Y4OP1dh/JmY/Oa5WLELajI/7pSBm7Cxvx22dK0k+nlKUQnVKQyEiSV5CX5tN86PIyQ+Vj9d/4Sgk7ylRTYKo2EO98/B8+ImrPSNPb2lEtqkSFoDGDbjMIfZOBsK7/hRhO43jX/ztvzYh7X6g+LoKS4zIM4O6VSKpOER+P7NzmnPMEeZ7ejj8VU8H+jRb2dxatbUd8042avkQ/eRgszlildFbGhM+jB7ZjZDLxPqIbMS/d7iu3jjg5Pk8LZl/wtmvqvdVDklyXCgXvTGXVx/K1oNGUCgC1BUFDHQg0faU9oGMoFKAD98rK4lABiOAXecFM9dQdtSYbdby9ewM7cECcOpwl65wSF5WlDGn1wvZrSsEWmoV7gOr0HkyzBYACBAzIzRhspvyzdRRH1DsmXjKzBmK91zkYAQYk7SP6EaTDWqU83FaZXIvVPl8FFSy450/fvzupwCuYWfGq2t1XUGWoZOpaNCF4aygEDTdT6hl3n0rRUMumKngoarUSnhaV9CivJq9oUVOY2f7w3Yjofrp70u0BQjPfT3dthkIKhsbrIzF/qzjpefwWAy31O8T6snEutogKJGHiOHw+Qli8Hkver+67g66kynfnzuP9luff8LWh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 08:27:28.1935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd92ce1a-5b67-46f6-f889-08dc5a01395a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7071

Early printk has been removed already that's why also remove calling it.
Similar change has been done in cpuinfo-pvr-full.c by commit cfbd8d1979af
("microblaze: Remove early printk setup").

Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support")
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/microblaze/kernel/cpu/cpuinfo-static.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/microblaze/kernel/cpu/cpuinfo-static.c b/arch/microblaze/kernel/cpu/cpuinfo-static.c
index 85dbda4a08a8..03da36dc6d9c 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo-static.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo-static.c
@@ -18,7 +18,7 @@ static const char family_string[] = CONFIG_XILINX_MICROBLAZE0_FAMILY;
 static const char cpu_ver_string[] = CONFIG_XILINX_MICROBLAZE0_HW_VER;
 
 #define err_printk(x) \
-	early_printk("ERROR: Microblaze " x "-different for kernel and DTS\n");
+	pr_err("ERROR: Microblaze " x "-different for kernel and DTS\n");
 
 void __init set_cpuinfo_static(struct cpuinfo *ci, struct device_node *cpu)
 {
-- 
2.44.0


