Return-Path: <linux-kernel+bounces-40747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B58483E517
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 221302839C5
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F5025558;
	Fri, 26 Jan 2024 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k2pjKN9K"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872A258232
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307441; cv=fail; b=Qi0e0lzwHLFAKZdbjcEexmW2IuRXfVXi6x4rfiWmmZUU9Y29h0Hwq1K9DXmetV68K2AosXLmU01gQOj9aMEmWAH0m9ZKwF73o2qJjyJQ79aHbQX5PaFFk5x+yD+pKBji8w/lGc4TavGz2phOtMxZGVLKRjiegCGtf930oknnMJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307441; c=relaxed/simple;
	bh=stgzIMbyznHHZFAn0ml5w0WpsdxXzcpbNR0bSeXi2So=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hp0/Yc8MvD/nm9BQK9fRrbSlpP4PSJbZyfACQ4BPIRYYm4+T0z4xDCBSxb3hMTBVHGh9xcGonMTnn0V3GAre6GHu5lI2isvlgNQM04m0pTTGzebgAmX+tzXFD5BwebvP2M5+cL7QOXR7IUPKx2rBAL0h9NM2JYPkoOEDg+/rp/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k2pjKN9K; arc=fail smtp.client-ip=40.107.94.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cEqnD3+VAVcDrNRpb1IWWlEsQHYs+5xCdY7eqnnVNR/qGn+fK08XeqQ6BU8jPeVXG44JnQA0MD1WYz/2bkOaGnTCd5oM7+lhIiWLaAtuF3j2+q/yKjoLP6bzaS1Qk6USa06OQxP7em3ouZt8qPbv/NRcxF+5Z+9KL32DfXARd44sAVbakeK1PRZQ4rCmf18oG1KpamM6tQgUe0kfuxBtwMF0qHf3jbkkG49YlIkxU/TeeHmbfL6ADblw+Fx1bFte2lubCNQTx9A8v6JAXsXtigThI4CdO5UkXKleDiW4Y6AFYFHrBeHKIJOpwWMZZBaqupuUcAtSpp/HyqL1c2hi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yrUcdqBxhjfxgvOzkcHfa6rOsPlXdgLnM32EQ4P5+0=;
 b=KJC72tSGo3NK006rNv6me2CSU9wG3meCYdZg5mzT1vrdeEWtN4iSzkSRPxqTJYDyded/SFXxKHQ+QxlqQKSICrsyCH2CmAlWOXhKFXNoFGw1ASRplMtNscT056iYqnz2tIutVaNLFLz0k9ke0wKMr8PPaX+Pu9U3PkQ5XIk3ZbD4tuxSkMD2iDS3zgf5Ya29Kk9R4fuK8c+pxAyqdROE7iyvsbs9pP9VIW1ozoz818mKH3JMKJGWqjWAjnT59LfKE8h3fyP7uJs1pAGwXaC6hwgU3CYq0uXB0JWiI5xJ7ddAOG+oea9sSAhx7hrrI/7ncLO+0/d71qDBK1hAEA5UUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yrUcdqBxhjfxgvOzkcHfa6rOsPlXdgLnM32EQ4P5+0=;
 b=k2pjKN9KiYWuaoGRlhSwIaKbluXEC3nqc/5uYTu6ufq4H4DdJL23tPYs+NaEKFM55oc7Rx5xun5qixZcSCLqXF6hh1KxY9PLtkSJoFP4p5NyPM6CZwsCoLtCFx/Jm9Z8dij19vUGUshvL/Xhgl2nxsSFNVifr3OENlwwO3hnESs=
Received: from CH0P221CA0043.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::23)
 by SA1PR12MB6869.namprd12.prod.outlook.com (2603:10b6:806:25d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 22:17:17 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::f2) by CH0P221CA0043.outlook.office365.com
 (2603:10b6:610:11d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28 via Frontend
 Transport; Fri, 26 Jan 2024 22:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:17:16 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:17:14 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 09/11] virt: sev-guest: Choose the VMPCK key based on executing VMPL
Date: Fri, 26 Jan 2024 16:16:02 -0600
Message-ID: <bd81dc55740417649e9b72dc3fe1e83e517b5672.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SA1PR12MB6869:EE_
X-MS-Office365-Filtering-Correlation-Id: 81372be2-0ece-473d-cc5d-08dc1ebc8e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	P6PEHfIgq1KwzUVQPBrjZqZrOmMTJjs1c8JivhATzLrwdjmIV2iFwpUkyRj3JBb8bKB4hLUqjFGSEYI24EZyjrtUntYdbX9OewzXS8hk+MTBSh17zyOdHbreczLrC8LhGHOGiQ7fycL5vTynMhUF5BvCTu5DtcftiV5S3zwAqEMSu08MG83s/+dEGYNApJT0KoMdzLYIe2JegvpSgQQuTiBT6scbwJh0tzxp0Ze8ezMa/IFpOowrcJ5YZdzC2qzjhNZ5alPvHJAK+QXP33QWHHTKHmjjttiNqSoYmUwpbH3kUZSdVygVfcVUDK6GGlw5zmFhQuzH6aJymbxx5NXYIKO3rJoslc84jhTvQ/khEFUB8rn3EQ0exX4yOQ0IXj3jki1U7pAUnytBux4ao379TQYKTczArOm25lCWSr0rqGVLKxoJ/nGAO9XZ6sdhBtkgLh+U77cWjBu3mXsnPCluLeouvYDcOO0YutnTpZPpzj05t8okhp6Bxdw6TlS/doOtHB7OWQDTUjEgoqL8L3z8SstbXijMRDGDpWWCwx4HdQev/AGBOiNnwyIYwe4r0co0RZKBVxgctOcghdo3GzJSAlZq6c3unWKf5SRjo3ZSyAoX13dz7nVqrzrKZkyBhhFnfSoPB6JwtJr0egHC0wkZYN/lC/L96odH8LpIL8UKMZxK87sFBrhcbj79juMZfSrLMpB7jxxNLDZ+9WQYswF3hBS+7PlgNM2+5em5jpRatpry4kr9/XxZtSHZGJD5HEqOetxc+BuU1hmgMVoB+VizZA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(426003)(2616005)(6666004)(86362001)(16526019)(336012)(26005)(478600001)(70206006)(110136005)(70586007)(316002)(54906003)(4326008)(8676002)(83380400001)(8936002)(47076005)(82740400003)(36756003)(41300700001)(5660300002)(81166007)(356005)(2906002)(36860700001)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:17:16.4784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81372be2-0ece-473d-cc5d-08dc1ebc8e0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6869

Currently, the sev-guest driver uses the vmpck-0 key by default. When an
SVSM is present the kernel is running at a VMPL other than 0 and the
vmpck-0 key is no longer available. So choose the vmpck key based on the
active VMPL level.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/include/asm/sev.h              |  2 ++
 arch/x86/kernel/sev.c                   |  6 ++++++
 drivers/virt/coco/sev-guest/sev-guest.c | 10 +++++++---
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 372bc6183b29..b126e50a1358 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -291,6 +291,7 @@ void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
 void __init snp_remap_svsm_ca(void);
+int snp_get_vmpl(void);
 #else
 static inline void sev_es_ist_enter(struct pt_regs *regs) { }
 static inline void sev_es_ist_exit(void) { }
@@ -320,6 +321,7 @@ static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
 static inline void snp_remap_svsm_ca(void) { }
+static inline int snp_get_vmpl(void) { return 0; }
 #endif
 
 #endif
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 9844c772099c..849df3aae4e1 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2442,6 +2442,12 @@ int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct sn
 }
 EXPORT_SYMBOL_GPL(snp_issue_guest_request);
 
+int snp_get_vmpl(void)
+{
+	return vmpl;
+}
+EXPORT_SYMBOL_GPL(snp_get_vmpl);
+
 static struct platform_device sev_guest_device = {
 	.name		= "sev-guest",
 	.id		= -1,
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index 87f241825bc3..1ff897913bf4 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -2,7 +2,7 @@
 /*
  * AMD Secure Encrypted Virtualization (SEV) guest driver interface
  *
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ * Copyright (C) 2021-2024 Advanced Micro Devices, Inc.
  *
  * Author: Brijesh Singh <brijesh.singh@amd.com>
  */
@@ -70,8 +70,8 @@ struct snp_guest_dev {
 	u8 *vmpck;
 };
 
-static u32 vmpck_id;
-module_param(vmpck_id, uint, 0444);
+static int vmpck_id = -1;
+module_param(vmpck_id, int, 0444);
 MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
 
 /* Mutex to serialize the shared buffer access and command handling. */
@@ -923,6 +923,10 @@ static int __init sev_guest_probe(struct platform_device *pdev)
 	if (!snp_dev)
 		goto e_unmap;
 
+	/* Adjust the default VMPCK key based on the executing VMPL level */
+	if (vmpck_id == -1)
+		vmpck_id = snp_get_vmpl();
+
 	ret = -EINVAL;
 	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
 	if (!snp_dev->vmpck) {
-- 
2.42.0


