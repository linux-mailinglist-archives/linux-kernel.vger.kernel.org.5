Return-Path: <linux-kernel+bounces-139278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A193A8A00DF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:49:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E83C1F24B4F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB971836C4;
	Wed, 10 Apr 2024 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDX50g03"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37298181D05
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778548; cv=fail; b=EPEILt0VfmSpkfVBbfCQQtnvxNym9VtBaeo5Q5b2LG8cnU0Lecp5n5X8J/oL+QgFO/HT7csFcTy0IJlnoT/b3qsUad17sOvxyxqxcdo6/5JqvP2J/zinMz7ScrCeUADe3OgDIa69kqJ/0Va3L0swxfOvLQPDaZw3IRE7MOOMhkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778548; c=relaxed/simple;
	bh=JcjI/JniUujztWhN76pYL+vuY45gBajo/Ol6E2mUdfM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ruXqH73I8PX9dIhIeqGWJN4vxzFqesWMWHacUeLQ/3Zm9LAXbZOjZ6QC+Fv5sPWpRSnuVGbdN3eldZ++kx1cIl6zFz7iLY+u7Zjqm/o6jWlaz95oLKAsEeSAJ/x5jGyCRaii81aCP2a+90A8w8W6BLjDiVRGXcJBuRfaD+Tl+74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDX50g03; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ItA2HYzklBqNdbLijzteMpEt8IpC1bHrV/OcdtY2oblEm1SpOdFX2kfpKE6Hu1jbantAJam80Xu3nspDU9ppoUWhZ8Nf/8ADQVgR8G5m7DxoJEziRbrQzNVU9cQz//XdFnyasRG6MriP2K5yRtXXBRWP4rWEwNlmEAgcFFldWfFbPHw/MVCCSRCvc8xBI0SPgfLxLa3yKPn0jBo8cSc5utR64ggaIWce9nKv13Xn7tULaHL6dMvXCaEoPkmi0QNGLDw6itJGrc6sflhZFz1HQwO0fzpbfJLKZ7R7oGqGNH9RgKUPn5EEBtn/HU8GSt1QOpw4DXwv+jKVLHPFdCb3OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6aGShkfhPfFFWeAFRLHJuhfTDAE6nHPfx+9E7Z29HTo=;
 b=cTSirRTDi7jJFDA8LmODI4Xd1BIGOC6Hu7ZEiR0pDcqfBatghRThIGRXZXf0LoNJn8fCZe7hTBXjDLT6yggwhShpdWPBNZNAsvYA1BhdOVpBiFwVYxdIc5OObNHQQP/nJbDnwd0kaFcWdYEF1LPTCzF+gtVkfYL8U/qk2IajIzUtaY2yFtjvEnT2Pdew0TJlSzwTEBobKR617XJWqSgNLV2+4Fiy1tXL/33Qv00Af5/ld082O5Zmq9hffUCd+XHXiUXFf4tcmGJOXOmhbWvjTGjhNSTS8tgA3gCu/EqtS/W3EM6BEyAnh5neTvid8G9BW2eqzWXvt58UZwovjhbk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6aGShkfhPfFFWeAFRLHJuhfTDAE6nHPfx+9E7Z29HTo=;
 b=PDX50g03Uxd2jBK0see9BqGTAY1jxGn6sjyLz/Gn0OqSbYIecdV92i0mrmg3RMRilwzQdpGNlKH76KNeMSIO00ex65UkHTmYCybGmmRzrH+mR+/NlMkg79rE4eRIKIlUuhddRltHwe5rUtCTzrfU9HhYZ33cpBcEBXTTwhKO2Jc=
Received: from SN6PR01CA0004.prod.exchangelabs.com (2603:10b6:805:b6::17) by
 CY5PR12MB6130.namprd12.prod.outlook.com (2603:10b6:930:26::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Wed, 10 Apr 2024 19:49:03 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:805:b6:cafe::ea) by SN6PR01CA0004.outlook.office365.com
 (2603:10b6:805:b6::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.21 via Frontend
 Transport; Wed, 10 Apr 2024 19:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 19:49:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 14:49:03 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 14:49:02 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>, "Jason
 Andryuk" <jason.andryuk@amd.com>
Subject: [PATCH 3/5] x86/pvh: Set phys_base when calling xen_prepare_pvh()
Date: Wed, 10 Apr 2024 15:48:48 -0400
Message-ID: <20240410194850.39994-4-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410194850.39994-1-jason.andryuk@amd.com>
References: <20240410194850.39994-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CY5PR12MB6130:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b51e1fe-9d0d-4a1f-b88d-08dc5997465f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XVBm9L2PuCo/0Qc+UBqidKjVjR1Ng3tgNhwQm5HXMaeH1RzxriqOARAJ0wvTRznI28+gqoR72iS1SJBtWk8uWhF/zTU9wm8nOK9KftL7vv+3kyo6gJZalot8BbqAnUokwL6joS1OY7XCH5/aCwO6ujkF83zBTJkBB/hneMBhr4KBdw+z1zrXOx5viON23J14BXMYoiWmT3Y9oiife+5ZgiHbj0pY+ZdN+F1tjEbwIywATO8fNB/AKtfipu/ZScNwmohwCZcJxinf2jkF5k3kg/OaOiuFVflTPhaCBRES8l5pahuURX6g2jAC5b05DqzlYYzK7HdWGSJ9Se1WJnbcKcwf19Pyt0+boLne/t639/xphIfYZdYXVa7dmrup/UbKjtQ+zTOtAHjyqiN4LAf9bfbapQuaAdL0ZkI+UVuvmDMQKn8YprZkO3wWtAAsJFJCNRiQk/bD3EFlftYgOBAMz2MXkXRX63THgzXXcSWEzsk5qGhU9V3i+p95RmAUXLTV6hdcEwy8mn8b9rMskUB2sI6M5A+UPta/dXj4sT+/UeLQpWWHobcfT8eFQD9KI03QC3PGbUmbdsZOsoYBds862k8gfuKtDzFHDxyNY70Mr3gVMxn04d/YLqFSahTa395tjyVcRCOYP6pYRNT10hbVL9HkS7aumNPO10Im6csoKoLdbOXEN5rBBx9ixqnSmpvlUSTYNFkZAAybn9iX9vtnVQw+sW3/2Ake2M7jMRCCg++ZoDLNRX3N0bc4DBfoS6H4amMHVxvNRjCe5bnQDPG4gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(376005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:49:03.4754
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b51e1fe-9d0d-4a1f-b88d-08dc5997465f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6130

phys_base needs to be set for __pa() to work in xen_pvh_init() when
finding the hypercall page.  Set it before calling into
xen_prepare_pvh(), which calls xen_pvh_init().  Clear it afterward to
avoid __startup_64() adding to it and creating an incorrect value.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
Instead of setting and clearing phys_base, a dedicated variable could be
used just for the hypercall page.  Having phys_base set properly may
avoid further issues if the use of phys_base or __pa() grows.
---
 arch/x86/platform/pvh/head.S | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index bb1e582e32b1..c08d08d8cc92 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -125,7 +125,17 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	xor %edx, %edx
 	wrmsr
 
+	/* Calculate load offset from LOAD_PHYSICAL_ADDR and store in
+	 * phys_base.  __pa() needs phys_base set to calculate the
+	 * hypercall page in xen_pvh_init(). */
+	movq %rbp, %rbx
+	subq $LOAD_PHYSICAL_ADDR, %rbx
+	movq %rbx, phys_base(%rip)
 	call xen_prepare_pvh
+	/* Clear phys_base.  __startup_64 will *add* to its value,
+	 * so reset to 0. */
+	xor  %rbx, %rbx
+	movq %rbx, phys_base(%rip)
 
 	/* startup_64 expects boot_params in %rsi. */
 	lea rva(pvh_bootparams)(%ebp), %rsi
-- 
2.44.0


