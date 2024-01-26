Return-Path: <linux-kernel+bounces-40748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9286783E51B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:19:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E947B22597
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6ED25545;
	Fri, 26 Jan 2024 22:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c4vMQ6fW"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2087.outbound.protection.outlook.com [40.107.101.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B019724A1D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307449; cv=fail; b=gzXRZC9vAEkpUErXcInortuQrVHovspbFe6rKluMWd9DX6K66ulRqUPxuyD5dEaiJbBLa4F4q213VBNHNYZ0QlhHXzojajCADCdAq9VdLKfTJVMFnEoO+XSCLQRTKNuXIs8vx7B5nOH0NPIsrHS4wuliMmekWAWR9BEH3urSE7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307449; c=relaxed/simple;
	bh=zv2NoQvY6xBwiGu7+L1yCl0+0ZhJ9c4RlMQQbLkvlU0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OEeKg2qbkDvnYUwW9Y6c+FC2W0SeJRmh4+pGy0tj9pNlXDrAzIa1V+62i5S7HLmi/AlJLNgdZF8YaoDKIpi9GgVMaYZhGKRAF9qrkcvhHeB9twBraclhruj0VcvoiAlYSC+peFMRxpZ4AFzeMdcEbIZE0l9L+1NCL8YK+TjEKT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c4vMQ6fW; arc=fail smtp.client-ip=40.107.101.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTAbdzSkOsIfeGLpxEirSJsMl4xbCuXypHKx4XhQJt5voNLfKbabJm9tbbzknb05XjggzgqiNaNTtHi2ekOmn295utq/AefymmtTVgfG87Xs5bp4qczUxVNYlV/nZi6u7kalsp4L3OuTqCQmrVVQSFIsWC2BpPhVHO9cFrX5cErX9SJJaDWLtBterKwdBjpAIpWNmOGaSJRT0AnkLYC6qur207+K6ZA2rQYkILzfhcCjGRJMPzRwKtM0vhsiyw3LfESgywLFiVCNHmv+XnupMqfpmbi3Xt+ucPT1kSCtp96ZC3U6n0Tay38EfuMqQA22q3HgJ/04sPlAScHnt2Dp1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/QH1IkoxWFLqenf6Jg0sLYZt/55pkjiGykghjEXdr0=;
 b=GXswpnKaDWcpugAptwXRU8SDuzuszdVPXmOdFy+XGb5NtxNp24gFIQTCrkhIxVJr96AAVPEFXl6JLDiBCAR7V4xNmccTEd0QFJvGR8Hk30UUus7bEp05Na3T87bnfxFqk3X2Y3c5RMCjgdFNF0BFJNufeVgtGMsVm5H+r0x/nGVncVc2wVGMLjjuGUSYi7f7fvRhrbE09O4c2jDxpXAR4Ati+rzWc8HdAe0OPQMMsJ+cSEKAD5SEDogcQy/fOp+h++6vL70scOpQ3TG0AS8/fdr97/bWrweLGcOYr9aArYtNkat4G0r1ioggguqJelJe8iT5bD/pgoPRZ0aFRY8ECQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s/QH1IkoxWFLqenf6Jg0sLYZt/55pkjiGykghjEXdr0=;
 b=c4vMQ6fWggepC9jEDT/4CUBTa9crdjvTU4KKIYP5oy3b+BxlAkmatbKJPcxZmU15G0/Cnn8T1B4od27qjbplLVtmuDVDPzTPX1E7cRCra0s2SwXGG7uHA9QgrpCrOs5h+mvOHK733teKXwY39tnRKhrkOv2okkIzznjCmEn5VpA=
Received: from DS0PR17CA0003.namprd17.prod.outlook.com (2603:10b6:8:191::17)
 by CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 22:17:23 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:8:191:cafe::17) by DS0PR17CA0003.outlook.office365.com
 (2603:10b6:8:191::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Fri, 26 Jan 2024 22:17:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Fri, 26 Jan 2024 22:17:23 +0000
Received: from tlendack-t1.amdoffice.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 26 Jan 2024 16:17:21 -0600
From: Tom Lendacky <thomas.lendacky@amd.com>
To: <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
Subject: [PATCH 10/11] x86/sev: Extend the config-fs attestation support for an SVSM
Date: Fri, 26 Jan 2024 16:16:03 -0600
Message-ID: <10637f104d1ed7f21e281a4890f2c549d1e85985.1706307364.git.thomas.lendacky@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|CH3PR12MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: 526225e5-71f0-48ad-debf-08dc1ebc923d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1K+fefvR2rtQhE5xxxMqTolfOLUrp+qtt2pgpzgQtQyoqA+SC3uWSyVeqhtBOnPr+xGfRE5Y48GPis+56DRNvcasK50TEf9OG3KZ9DNt0XXGj/WFEgjldnM7AL6rMp755znV8tAl06KAWd5yWi3fPzHPG0bHrb2EkopkU1RE13AR1ga6n3iVqalUwHB6BrlPHiaayKOxchED75mm2pCINWw0Z+DAYDFKNeb2gNgo60iMPVKDiKwxTS5JadfcIsKQpJ7XG3qTpFAMBQkgDo/G/1gvOeKf2P800M03JOaTQT+bO3kE5AOfT40grDmEqZ01BWb0MDhQ6Kdpj0diihnXeDwtvLs5TLyIY90HRqtQg0FMvIWvMObvwDlGgvQjIOOSRF/oxBq/aog2m34/A7Dr0DLcDOHSPBRwc/TK+qoHF6+OcW3CbbuPK84+8WNdc+dG6uF99nB0uUmh214wFJ/7ZAuJGmtw+eLlmqdiglSBVJv1m4EbYDfL47bfZJiFzgh79DmfvlVgHopmdyx4D5KYY0rw1VzPnv7/iU3PSqV+myjtEYaBCLVqWv2QRNiG+biJSCDWvn8zOP4zgtCLYpPJE1QxMXJHfsxnia+nzh2YW2rndRYqgZel03cyHJ1D83od+gvTOgtBFzVptct7u5/MzDnw/0w/sTOkHgtwX6VdXq8dJtuJadvMud4woKCiu+vzlkjdvsnIbAatr23IetNDOt8PVMij+FG9OuWfP0PvRpfAwFoqlTJfBCXAlwkeHzsZlr5vgiNLVuRrPOLIqYtL6jpiMP8tAYerLfKVYDeC6ZI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(46966006)(40470700004)(36840700001)(110136005)(70206006)(70586007)(356005)(54906003)(316002)(8676002)(41300700001)(16526019)(26005)(8936002)(40460700003)(40480700001)(81166007)(478600001)(966005)(2616005)(82740400003)(86362001)(6666004)(2906002)(5660300002)(7416002)(30864003)(4326008)(83380400001)(336012)(426003)(36756003)(47076005)(36860700001)(36900700001)(309714004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 22:17:23.5199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526225e5-71f0-48ad-debf-08dc1ebc923d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7738

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

  - 'service_version' (input)
    Used with the SVSM_ATTEST_SINGLE_SERVICE call, the service version
    represents a specific service manifest version be used for the
    attestation report.

  - 'manifestblob' (output)
    Used to return the service manifest associated with the attestation
    report.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 Documentation/ABI/testing/configfs-tsm  |  55 ++++++++++
 arch/x86/include/asm/sev.h              |  31 +++++-
 arch/x86/kernel/sev.c                   |  50 +++++++++
 drivers/virt/coco/sev-guest/sev-guest.c | 137 ++++++++++++++++++++++++
 drivers/virt/coco/tsm.c                 |  95 +++++++++++++++-
 include/linux/tsm.h                     |  11 ++
 6 files changed, 376 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
index dd24202b5ba5..c5423987d323 100644
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
@@ -80,3 +95,43 @@ Contact:	linux-coco@lists.linux.dev
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
+		under an SVSM, like SEV-SNP. Specifying any non-zero value
+		implies that the attestation report should come from the SVSM.
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
+		service_version attribute.
+		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
+		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
+
+What:		/sys/kernel/config/tsm/report/$name/service_version
+Date:		January, 2024
+KernelVersion:	v6.9
+Contact:	linux-coco@lists.linux.dev
+Description:
+		(WO) Attribute is visible if a TSM implementation provider
+		supports the concept of attestation reports for TVMs running
+		under an SVSM, like SEV-SNP. Indicates the service manifest
+		version requested for the attestation report.
+		Secure VM Service Module for SEV-SNP Guests v1.00 Section 7.
+		https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index b126e50a1358..4cafa92d1d3e 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -194,6 +194,27 @@ struct svsm_pvalidate_call {
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
+	u32 service_version;
+	u8 rsvd[4];
+};
+
 /*
  * SVSM protocol structure
  */
@@ -217,6 +238,10 @@ struct svsm_call {
 #define SVSM_CORE_CREATE_VCPU		2
 #define SVSM_CORE_DELETE_VCPU		3
 
+#define SVSM_ATTEST_CALL(x)		((1ULL << 32) | (x))
+#define SVSM_ATTEST_SERVICES		0
+#define SVSM_ATTEST_SINGLE_SERVICE	1
+
 #ifdef CONFIG_AMD_MEM_ENCRYPT
 extern void __sev_es_ist_enter(struct pt_regs *regs);
 extern void __sev_es_ist_exit(void);
@@ -287,6 +312,7 @@ void snp_set_wakeup_secondary_cpu(void);
 bool snp_init(struct boot_params *bp);
 void __init __noreturn snp_abort(void);
 int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio);
+int snp_issue_svsm_attestation_request(u64 call_id, struct svsm_attestation_call *input);
 void snp_accept_memory(phys_addr_t start, phys_addr_t end);
 u64 snp_get_unsupported_features(u64 status);
 u64 sev_get_status(void);
@@ -316,7 +342,10 @@ static inline int snp_issue_guest_request(u64 exit_code, struct snp_req_data *in
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
index 849df3aae4e1..83bc5efa8fcf 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -2378,6 +2378,56 @@ static int __init init_sev_config(char *str)
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
+	memcpy(attest_call, input, sizeof(*attest_call));
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
index 1ff897913bf4..3693373c4227 100644
--- a/drivers/virt/coco/sev-guest/sev-guest.c
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -783,6 +783,140 @@ struct snp_msg_cert_entry {
 	u32 length;
 };
 
+static int sev_svsm_report_new(struct tsm_report *report, void *data)
+{
+	unsigned int report_len, manifest_len, certificates_len;
+	void *report_blob, *manifest_blob, *certificates_blob;
+	struct svsm_attestation_call attest_call = {};
+	struct tsm_desc *desc = &report->desc;
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
+		attest_call.service_version = desc->service_version;
+
+		call_id = SVSM_ATTEST_CALL(SVSM_ATTEST_SINGLE_SERVICE);
+	}
+
+	ret = snp_issue_svsm_attestation_request(call_id, &attest_call);
+	switch (ret) {
+	case SVSM_SUCCESS:
+		break;
+	case SVSM_ERR_INVALID_PARAMETER:
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
+			goto retry;
+		}
+
+		ret = -EINVAL;
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
@@ -797,6 +931,9 @@ static int sev_report_new(struct tsm_report *report, void *data)
 	if (desc->inblob_len != SNP_REPORT_USER_DATA_SIZE)
 		return -EINVAL;
 
+	if (desc->svsm)
+		return sev_svsm_report_new(report, data);
+
 	void *buf __free(kvfree) = kvzalloc(size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
index d1c2db83a8ca..33fa26406bc6 100644
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
+	report->desc.svsm = !!val;
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
+static ssize_t tsm_report_service_version_store(struct config_item *cfg,
+						const char *buf, size_t len)
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
+	report->desc.service_version = val;
+
+	return len;
+}
+CONFIGFS_ATTR_WO(tsm_report_, service_version);
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
+	&tsm_report_attr_service_version,
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
index de8324a2223c..7c36b8448b4f 100644
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
+ * @service_version: optional SVSM service manifest version requested
  */
 struct tsm_desc {
 	unsigned int privlevel;
 	size_t inblob_len;
 	u8 inblob[TSM_INBLOB_MAX];
+	bool svsm;
+	guid_t service_guid;
+	unsigned int service_version;
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
2.42.0


