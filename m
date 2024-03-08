Return-Path: <linux-kernel+bounces-97469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A9E876ACF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C99FA1C209C5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 18:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9845D59143;
	Fri,  8 Mar 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L//I3HT1"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C6E5788F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709923030; cv=fail; b=AQL+FX5uYbfmLOC/VYhXnX0Fm6cFy5D7OiHHCqTnb8gSN+PhCLMBEPI6Odg17dA/verJ4MwPrMh0SZOgumcrxPQo9GirQ88ooHUAfycHNl5lnasCekFYo6VcmD/3A6Hg2qEG0anURgxJwxfz0MMi6u5H4NTb64ExgszCJjX0gwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709923030; c=relaxed/simple;
	bh=tWxOwqTK/QeU/ZaK9CV09E9dAk4pCU+kiwpVHWVJ8Oc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaNwvUn1TaHfKikIcuaiLGaRd/8/Y+OPUQPprCXyiN2Hh9sW7uAU64ZMFs+Ju9pbsvzErGM+fKA44nPK4zMfk/K/p8jKP9YfbwHaNT9fKRGGMCHsB5yHf++/ja7sbTWSdEoxhXri9901rPouiarXDkvE2eKAnF+5814bQ9rG1ag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L//I3HT1; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SGA63+ct0IDeqm48x0kyY5Gb9Rvrolf7ydZp0ODcKBamASUAd7FHoIwmoAt4A9lytEr3Y8iWIlazC3n6BGer1Yc6HAUY5/K/aT496nmfXML5vOd/6fBWeq9J5JMfgmD8V1dmM5FbWNHFNTO8DPxArbfR9RqeQbjIP7PRGwclpbaz+ZedrS5oM+SVUX18ru4XKR1jNHbdWjFKKb4ihdZrhS7W2ZC7CxC1WCpR+jW/DFcnSXHDUhvll4b3DD4mTYnMNyU0FZxoZhIRL6KxfW5PlFTK+5jUyC0PEXRpVG0Kz/KYxJmtySTvtqbslm364GDCapBzJtCAMMoLwJweA/jntQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J1day4WXNstJTM7eraxcI1rMDFP0U1S+LpRE8GYn4xs=;
 b=Ab8r22JZc3pEa6JbsV6vpYpVDNB4/1prlAeMbfpod+MqSJBt678w7vlF4OkurT23mumsfNmI5FqUz/n59cQLIcgrn4LT8Hemsxu29xdJuZBCHJ6t7Ra4drTvl1SC7xF1lN+JI9UZF27k3nM98hJrcphA9RK6UVVB7Oa4maejL9dnJU08OFfKIdoNIxcNof70ZfEoA/+4T9xcCt9fHbgRbaehMmTTosdNnCPKEX4ntUHKK8ynPO5BX0+Cm7qqU/mE1jacbATn/j+Z3I1AWQXXyVQJOOTk2PMjeGjunNaONuJUh2OBdvk+j2oxr8DWAv2wHP0qv0CJEjrePK5niJkrYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J1day4WXNstJTM7eraxcI1rMDFP0U1S+LpRE8GYn4xs=;
 b=L//I3HT1296+3poZqu86mZceYer0vBdjKV7dyqIQ3o4ZxTjqdEmvsZVHNyUpHxlwPMFAzQzPf6zk4X7CU0Ber9jJ8HTQmQdLo+HRZEXXxeBEEFTGaQhI/tOAQvESJTirRE8iTnNuiuSDBG3sRzQKg2ujhkfSLLXXWi3sdT1FOgI=
Received: from BN9PR03CA0289.namprd03.prod.outlook.com (2603:10b6:408:f5::24)
 by DS0PR12MB8414.namprd12.prod.outlook.com (2603:10b6:8:fb::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.27; Fri, 8 Mar 2024 18:37:05 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::8a) by BN9PR03CA0289.outlook.office365.com
 (2603:10b6:408:f5::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Fri, 8 Mar 2024 18:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 18:37:05 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 8 Mar 2024 12:37:02 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH v2 11/14] x86/sev: Extend the config-fs attestation support for an SVSM
Date: Fri, 8 Mar 2024 12:35:26 -0600
Message-ID: <a6d236e247c4a0258e5e28c7378350389997cc59.1709922929.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|DS0PR12MB8414:EE_
X-MS-Office365-Filtering-Correlation-Id: 80d3f1e6-9e8f-447b-09bc-08dc3f9ec0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iof8ovZUiqxMsrdFw5mT45otMFRQVsd+FCF/zuutUDLeed1HzodxbDleM0+uzANVYL6sGb8QI5vGCc1at3FS78XslYc2dbTyYEFHJUY2uQ3wSYpFOioYAZ9cik9AVJ4DaWo4u9ZTSl6XQTMhtw+Ucx/1x9mAi+7Z0ZQyJOsZ2YRUa0CqgDpeTIzi8gK2VR6n9dwc74kgKpFnDCeFHadc7AnQjx1i7Ef8IgL0CsnhH/96isArNs8e6h/JSdnssYu83KJDHvEWEfknEjFFgr5dymUEdE5ctiy9o6IzbEmNhkf6moL145xB9/fnsfRvvm5qMsW0cM9L8/TqPwVEtAl8xX9jmckPNSy5KTFjnuxoJ8XYhTBa6zsW/8lhsvc7B9cW7suRbDLoFizDiYX5f/uk0vtll+tAXmfYJ05HKB3AGG4/t2jjk8bW/yW4CuIQIwXVv6YrrTGfojyEUOY4GTJPtQO+gaitF0l7HWkP7PA4K2QfHPoNZpkyTT896YjgxcqdefpgXKhLrcEQq4BiV8EiO1QLir/tqsRljrzq4nGHDB2Eupu4V6tmdMyfxkWrli/B1jIKpUv5ADv6vksr+85PLQdOLIK065BJPbRUajFcahrfeVk3hkRrl2LSrk6Dhesk3u3zcTE+qCWgSmsEEZGlWAP+3nKPIF9pYLg/yCBYP6E1i8dTPKXeFaHjYM6O7ouQiwdCGX6uoijwRlm9KnMWHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 18:37:05.4449
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d3f1e6-9e8f-447b-09bc-08dc3f9ec0fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8414

When an SVSM is present, the guest can also request attestation reports
from the SVSM. These SVSM attestation reports can be used to attest the
SVSM and any services running within the SVSM.

Extend the config-fs attestation support to allow for an SVSM attestation
report. This involves creating four (4) new config-fs attributes:

  - 'svsm' (input)
    This attribute is used to determine whether the attestation request
    should be sent to the SVSM or to the SEV firmware.

  - 'service_guid' (input)
    Used for requesting the attestation of a single service within the
    SVSM. A null GUID implies that the SVSM_ATTEST_SERVICES call should
    be used to request the attestation report. A non-null GUID implies
    that the SVSM_ATTEST_SINGLE_SERVICE call should be used.

  - 'service_manifest_version' (input)
    Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
    represents a specific service manifest version be used for the
    attestation report.

  - 'manifestblob' (output)
    Used to return the service manifest associated with the attestation
    report.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/ABI/testing/configfs-tsm  |  59 ++++++++++
 arch/x86/include/asm/sev.h              |  31 ++++-
 arch/x86/kernel/sev.c                   |  50 ++++++++
 drivers/virt/coco/sev-guest/sev-guest.c | 147 ++++++++++++++++++++++++
 drivers/virt/coco/tsm.c                 |  95 ++++++++++++++-
 include/linux/tsm.h                     |  11 ++
 6 files changed, 390 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index dd24202b5ba5..a4663610bf7c 100644
--- a/Documentation/ABI/testing/configfs-tsm
+++ b/Documentation/ABI/testing/configfs-tsm
@@ -31,6 +31,21 @@ Description:
 		Standardization v2.03 Section 4.1.8.1 MSG_REPORT_REQ.
 		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/56421.pdf
 
+What:		/sys/kernel/config/tsm/report/$name/manifestblob
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(RO) Optional supplemental data that a TSM may emit, visibility
+		of this attribute depends on TSM, and may be empty if no
+		manifest data is available.
+
+		When @provider is "sev_guest" and the "svsm" attribute is set
+		this file contains the service manifest used for the SVSM
+		attestation report from Secure VM Service Module for SEV-SNP
+		Guests v1.00 Section 7.
+		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+
 What:		/sys/kernel/config/tsm/report/$name/provider
 Date:		September, 2023
 KernelVersion:	v6.7
@@ -80,3 +95,47 @@ Contact:	linux-coco@lists.linux.dev
 Description:
 		(RO) Indicates the minimum permissible value that can be written
 		to @privlevel.
+
+What:		/sys/kernel/config/tsm/report/$name/svsm
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports for TVMs running
+		under an SVSM, like SEV-SNP. Specifying a 1 (or other boolean
+		equivalent, e.g. "Y") implies that the attestation report
+		should come from the SVSM.
+		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
+		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+
+What:		/sys/kernel/config/tsm/report/$name/service_guid
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports for TVMs running
+		under an SVSM, like SEV-SNP. Specifying a empty or null GUID
+		(00000000-0000-0000-0000-000000) requests all active services
+		within the SVSM be part of the attestation report. Specifying
+		a non-null GUID requests an attestation report of just the
+		specified service using the manifest form specified by the
+		service_manifest_version attribute.
+		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
+		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+
+What:		/sys/kernel/config/tsm/report/$name/service_manifest_version
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports for TVMs running
+		under an SVSM, like SEV-SNP. Indicates the service manifest
+		version requested for the attestation report. If this field
+		is not set by the user, the default manifest version of the
+		service (the service's initial/first manifest version) is
+		returned. The initial manifest version is always available.
+		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
+		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 34bc84aee969..76fabc7b5e97 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -209,6 +209,27 @@ struct svsm_pvalidate_call {
 	struct svsm_pvalidate_entry entry[];
 };
 
+/*
+ * The SVSM Attestation related structures
+ */
+struct svsm_location_entry {
+	u64 pa;
+	u32 len;
+	u8 rsvd[4];
+};
+
+struct svsm_attestation_call {
+	struct svsm_location_entry report_buffer;
+	struct svsm_location_entry nonce;
+	struct svsm_location_entry manifest_buffer;
+	struct svsm_location_entry certificates_buffer;
+
+	/* For attesting a single service */
+	u8 service_guid[16];
+	u32 service_manifest_version;
+	u8 rsvd[4];
+};
+
 /*
  * SVSM protocol structure
  */
@@ -232,6 +253,10 @@ struct svsm_call {
 #define SVSM_CORE_CREATE_VCPU		2
 #define SVSM_CORE_DELETE_VCPU		3
 
+#define SVSM_ATTEST_CALL(x)		((1ULL << 32) | (x))
+#define SVSM_ATTEST_SERVICES		0
+#define SVSM_ATTEST_SINGLE_SERVICE	1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -302,6 +327,7 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
@@ -333,7 +359,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
 {
 	return -ENOTTY;
 }
-
+static inline int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
+{
+	return -ENOTTY;
+}
 static inline void snp_accept_memory(phys_addr_t start, phys_addr_t end) { }
 static inline u64 snp_get_unsupported_features(u64 status) { return 0; }
 static inline u64 sev_get_status(void) { return 0; }
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 8682af55802c..4e460d9eba77 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2402,6 +2402,56 @@ static int __init init_sev_config(char *str)
 }
 __setup("sev=", init_sev_config);
 
+static void update_attestation_input(struct svsm_call *call, struct svsm_attestation_call *input)
+{
+	/* If (new) lengths have been returned, propograte them up */
+	if (call->rcx_out != call->rcx)
+		input->manifest_buffer.len = call->rcx_out;
+
+	if (call->rdx_out != call->rdx)
+		input->certificates_buffer.len = call->rdx_out;
+
+	if (call->r8_out != call->r8)
+		input->report_buffer.len = call->r8_out;
+}
+
+int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input)
+{
+	struct svsm_attestation_call *attest_call;
+	struct svsm_call call = {};
+	unsigned long flags;
+	u64 attest_call_pa;
+	int ret;
+
+	if (!vmpl)
+		return -EINVAL;
+
+	local_irq_save(flags);
+
+	call.caa = __svsm_get_caa();
+
+	attest_call = (struct svsm_attestation_call *)call.caa->svsm_buffer;
+	attest_call_pa = __svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	*attest_call = *input;
+
+	/*
+	 * Set input registers for the request and set RDX and R8 to known
+	 * values in order to detect length values being returned in them.
+	 */
+	call.rax = call_id;
+	call.rcx = attest_call_pa;
+	call.rdx = -1;
+	call.r8 = -1;
+	ret = svsm_protocol(&call);
+	update_attestation_input(&call, input);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_svsm_attestation_request);
+
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
 {
 	struct ghcb_state state;
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
index bba6531cb606..9daec0ea386e 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -38,6 +38,8 @@
 #define SNP_REQ_MAX_RETRY_DURATION	(60*HZ)
 #define SNP_REQ_RETRY_DELAY		(2*HZ)
 
+#define SVSM_MAX_RETRIES		3
+
 struct snp_guest_crypto {
 	struct crypto_aead *tfm;
 	u8 *iv, *authtag;
@@ -783,6 +785,148 @@ struct snp_msg_cert_entry {
 	u32 length;
 };
 
+static int sev_svsm_report_new(struct tsm_report *report, void *data)
+{
+	unsigned int report_len, manifest_len, certificates_len;
+	void *report_blob, *manifest_blob, *certificates_blob;
+	struct svsm_attestation_call attest_call = {};
+	struct tsm_desc *desc = &report->desc;
+	unsigned int retry_count;
+	unsigned int size;
+	bool try_again;
+	void *buffer;
+	u64 call_id;
+	int ret;
+
+	/*
+	 * Allocate pages for the request:
+	 * - Report blob (4K)
+	 * - Manifest blob (4K)
+	 * - Certificate blob (16K)
+	 *
+	 * Above addresses must be 4K aligned
+	 */
+	report_len = SZ_4K;
+	manifest_len = SZ_4K;
+	certificates_len = SEV_FW_BLOB_MAX_SIZE;
+
+	retry_count = 0;
+
+retry:
+	size = report_len + manifest_len + certificates_len;
+	buffer = alloc_pages_exact(size, __GFP_ZERO);
+	if (!buffer)
+		return -ENOMEM;
+
+	report_blob = buffer;
+	attest_call.report_buffer.pa = __pa(report_blob);
+	attest_call.report_buffer.len = report_len;
+
+	manifest_blob = report_blob + report_len;
+	attest_call.manifest_buffer.pa = __pa(manifest_blob);
+	attest_call.manifest_buffer.len = manifest_len;
+
+	certificates_blob = manifest_blob + manifest_len;
+	attest_call.certificates_buffer.pa = __pa(certificates_blob);
+	attest_call.certificates_buffer.len = certificates_len;
+
+	attest_call.nonce.pa = __pa(desc->inblob);
+	attest_call.nonce.len = desc->inblob_len;
+
+	if (guid_is_null(&desc->service_guid)) {
+		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SERVICES);
+	} else {
+		export_guid(attest_call.service_guid, &desc->service_guid);
+		attest_call.service_manifest_version = desc->service_manifest_version;
+
+		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
+	}
+
+	ret = snp_issue_svsm_attestation_request(call_id, &attest_call);
+	switch (ret) {
+	case SVSM_SUCCESS:
+		break;
+	case SVSM_ERR_INVALID_PARAMETER:
+		ret = -EINVAL;
+
+		if (retry_count >= SVSM_MAX_RETRIES)
+			goto error;
+
+		try_again = false;
+
+		if (attest_call.report_buffer.len > report_len) {
+			report_len = PAGE_ALIGN(attest_call.report_buffer.len);
+			try_again = true;
+		}
+
+		if (attest_call.manifest_buffer.len > manifest_len) {
+			manifest_len = PAGE_ALIGN(attest_call.manifest_buffer.len);
+			try_again = true;
+		}
+
+		if (attest_call.certificates_buffer.len > certificates_len) {
+			certificates_len = PAGE_ALIGN(attest_call.certificates_buffer.len);
+			try_again = true;
+		}
+
+		/* If one of the buffers wasn't large enough, retry the request */
+		if (try_again) {
+			free_pages_exact(buffer, size);
+			retry_count++;
+			goto retry;
+		}
+
+		goto error;
+	case SVSM_ERR_BUSY:
+		ret = -EAGAIN;
+		goto error;
+	default:
+		pr_err_ratelimited("SVSM attestation request failed (%#x)\n", ret);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	ret = -ENOMEM;
+
+	report_len = attest_call.report_buffer.len;
+	void *rbuf __free(kvfree) = kvzalloc(report_len, GFP_KERNEL);
+	if (!rbuf)
+		goto error;
+
+	memcpy(rbuf, report_blob, report_len);
+	report->outblob = no_free_ptr(rbuf);
+	report->outblob_len = report_len;
+
+	manifest_len = attest_call.manifest_buffer.len;
+	void *mbuf __free(kvfree) = kvzalloc(manifest_len, GFP_KERNEL);
+	if (!mbuf)
+		goto error;
+
+	memcpy(mbuf, manifest_blob, manifest_len);
+	report->manifestblob = no_free_ptr(mbuf);
+	report->manifestblob_len = manifest_len;
+
+	certificates_len = attest_call.certificates_buffer.len;
+	if (!certificates_len)
+		goto success;
+
+	void *cbuf __free(kvfree) = kvzalloc(certificates_len, GFP_KERNEL);
+	if (!cbuf)
+		goto error;
+
+	memcpy(cbuf, certificates_blob, certificates_len);
+	report->auxblob = no_free_ptr(cbuf);
+	report->auxblob_len = certificates_len;
+
+success:
+	ret = 0;
+
+error:
+	free_pages_exact(buffer, size);
+
+	return ret;
+}
+
 static int sev_report_new(struct tsm_report *report, void *data)
 {
 	struct snp_msg_cert_entry *cert_table;
@@ -797,6 +941,9 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
 		return -EINVAL;
 
+	if (desc->svsm)
+		return sev_svsm_report_new(report, data);
+
 	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..07b4c95ce704 100644
--- a/drivers/virt/coco/tsm.c
+++ b/drivers/virt/coco/tsm.c
@@ -35,7 +35,7 @@ static DECLARE_RWSEM(tsm_rwsem);
  * The attestation report format is TSM provider specific, when / if a standard
  * materializes that can be published instead of the vendor layout. Until then
  * the 'provider' attribute indicates the format of 'outblob', and optionally
- * 'auxblob'.
+ * 'auxblob' and 'manifestblob'.
  */
 
 struct tsm_report_state {
@@ -48,6 +48,7 @@ struct tsm_report_state {
 enum tsm_data_select {
 	TSM_REPORT,
 	TSM_CERTS,
+	TSM_MANIFEST,
 };
 
 static struct tsm_report *to_tsm_report(struct config_item *cfg)
@@ -119,6 +120,77 @@ static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
 }
 CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
 
+static ssize_t tsm_report_svsm_store(struct config_item *cfg,
+				     const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	bool val;
+	int rc;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+	report->desc.svsm = val;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, svsm);
+
+static ssize_t tsm_report_service_guid_store(struct config_item *cfg,
+					     const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	size_t guid_len;
+	int rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+
+	/* Obtain the GUID string length */
+	guid_len = (len && buf[len - 1] == '\n') ? len - 1 : len;
+	if (guid_len && guid_len != UUID_STRING_LEN)
+		return -EINVAL;
+
+	if (guid_len == UUID_STRING_LEN) {
+		rc = guid_parse(buf, &report->desc.service_guid);
+		if (rc)
+			return rc;
+	} else {
+		report->desc.service_guid = guid_null;
+	}
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_guid);
+
+static ssize_t tsm_report_service_manifest_version_store(struct config_item *cfg,
+							 const char *buf, size_t len)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+	unsigned int val;
+	int rc;
+
+	rc = kstrtouint(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	guard(rwsem_write)(&tsm_rwsem);
+	rc = try_advance_write_generation(report);
+	if (rc)
+		return rc;
+	report->desc.service_manifest_version = val;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_manifest_version);
+
 static ssize_t tsm_report_inblob_write(struct config_item *cfg,
 				       const void *buf, size_t count)
 {
@@ -163,6 +235,9 @@ static ssize_t __read_report(struct tsm_report *report, void *buf, size_t count,
 	if (select == TSM_REPORT) {
 		out = report->outblob;
 		len = report->outblob_len;
+	} else if (select == TSM_MANIFEST) {
+		out = report->manifestblob;
+		len = report->manifestblob_len;
 	} else {
 		out = report->auxblob;
 		len = report->auxblob_len;
@@ -188,7 +263,7 @@ static ssize_t read_cached_report(struct tsm_report *report, void *buf,
 
 	/*
 	 * A given TSM backend always fills in ->outblob regardless of
-	 * whether the report includes an auxblob or not.
+	 * whether the report includes an auxblob/manifestblob or not.
 	 */
 	if (!report->outblob ||
 	    state->read_generation != state->write_generation)
@@ -224,8 +299,10 @@ static ssize_t tsm_report_read(struct tsm_report *report, void *buf,
 
 	kvfree(report->outblob);
 	kvfree(report->auxblob);
+	kvfree(report->manifestblob);
 	report->outblob = NULL;
 	report->auxblob = NULL;
+	report->manifestblob = NULL;
 	rc = ops->report_new(report, provider.data);
 	if (rc < 0)
 		return rc;
@@ -252,6 +329,15 @@ static ssize_t tsm_report_auxblob_read(struct config_item *cfg, void *buf,
 }
 CONFIGFS_BIN_ATTR_RO(tsm_report_, auxblob, NULL, TSM_OUTBLOB_MAX);
 
+static ssize_t tsm_report_manifestblob_read(struct config_item *cfg, void *buf,
+					    size_t count)
+{
+	struct tsm_report *report = to_tsm_report(cfg);
+
+	return tsm_report_read(report, buf, count, TSM_MANIFEST);
+}
+CONFIGFS_BIN_ATTR_RO(tsm_report_, manifestblob, NULL, TSM_OUTBLOB_MAX);
+
 #define TSM_DEFAULT_ATTRS() \
 	&tsm_report_attr_generation, \
 	&tsm_report_attr_provider
@@ -265,6 +351,9 @@ static struct configfs_attribute *tsm_report_extra_attrs[] = {
 	TSM_DEFAULT_ATTRS(),
 	&tsm_report_attr_privlevel,
 	&tsm_report_attr_privlevel_floor,
+	&tsm_report_attr_svsm,
+	&tsm_report_attr_service_guid,
+	&tsm_report_attr_service_manifest_version,
 	NULL,
 };
 
@@ -280,6 +369,7 @@ static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
 static struct configfs_bin_attribute *tsm_report_bin_extra_attrs[] = {
 	TSM_DEFAULT_BIN_ATTRS(),
 	&tsm_report_attr_auxblob,
+	&tsm_report_attr_manifestblob,
 	NULL,
 };
 
@@ -288,6 +378,7 @@ static void tsm_report_item_release(struct config_item *cfg)
 	struct tsm_report *report = to_tsm_report(cfg);
 	struct tsm_report_state *state = to_state(report);
 
+	kvfree(report->manifestblob);
 	kvfree(report->auxblob);
 	kvfree(report->outblob);
 	kfree(state);
diff --git a/include/linux/tsm.h b/include/linux/tsm.h
index 50c5769657d8..c4aed3059500 100644
--- a/include/linux/tsm.h
+++ b/include/linux/tsm.h
@@ -4,6 +4,7 @@
 
 #include <linux/sizes.h>
 #include <linux/types.h>
+#include <linux/uuid.h>
 
 #define TSM_INBLOB_MAX 64
 #define TSM_OUTBLOB_MAX SZ_32K
@@ -19,11 +20,17 @@
  * @privlevel: optional privilege level to associate with @outblob
  * @inblob_len: sizeof @inblob
  * @inblob: arbitrary input data
+ * @svsm: optional indicator of where to obtain the tsm report blob
+ * @service_guid: optional SVSM service guid to attest
+ * @service_manifest_version: optional SVSM service manifest version requested
  */
 struct tsm_desc {
 	unsigned int privlevel;
 	size_t inblob_len;
 	u8 inblob[TSM_INBLOB_MAX];
+	bool svsm;
+	guid_t service_guid;
+	unsigned int service_manifest_version;
 };
 
 /**
@@ -33,6 +40,8 @@ struct tsm_desc {
  * @outblob: generated evidence to provider to the attestation agent
  * @auxblob_len: sizeof(@auxblob)
  * @auxblob: (optional) auxiliary data to the report (e.g. certificate data)
+ * @manifestblob_len: sizeof(@manifestblob)
+ * @manifestblob: (optional) manifest data associated with the report
  */
 struct tsm_report {
 	struct tsm_desc desc;
@@ -40,6 +49,8 @@ struct tsm_report {
 	u8 *outblob;
 	size_t auxblob_len;
 	u8 *auxblob;
+	size_t manifestblob_len;
+	u8 *manifestblob;
 };
 
 /**
-- 
2.43.2


