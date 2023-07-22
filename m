Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88CA75DBDC
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 13:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjGVLUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 07:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjGVLUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 07:20:45 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9333A9C
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 04:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2on5LEmIACJfbuSi9dIyFyGw1Ghj3vyX2UqsdGZrSrMXoHBcojCfDHj2bb53nBNTPMlOI4+oADUMeMn7n9PrfwsW95bFTF2csdQU5BLLbX7pd4aBXbsEvpOg1ckNq2o8coWMensqjGUqiSGlqxkuepMChHCNxyzvvUOeWgPPrGwZWwFGEkfp1nV4sb8a4X8ZhhO6J21otBjeIQNTsdBqoI9q5uQjhg7v3V7s9KsPUJm635JlkcBmExLigkPS7soTuiw3xj2/sWdfLqvhcI5bG2LHXPqTDCedK3y6MCqzBfYUIXCddg9hNP9OIFAXnk/X90hQ3If2PQ4BBKLGqPJOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3tgvaZKGyl4nDbChRpthhng+3C8nnip3DQgCAw7+Dgg=;
 b=HcDkwzGXfC0veY1ubxFEm9Cvlx0NOuACjEaklKzZVxj8btomfzn5MS2mmcCK40vQOJn4q76Yw4XBr/wAg15Y10kmyWLvMcbVujT2lfMWtxEj6N0al6bt6W3/OKSBDNNarshfVLeAQtNpfUIrK5vEdGAmC75SksGLKukdToK2Ab9ZevlfHATR//cJk8oTY8INVdTLorIuz/MXSeJq71guYidmZO/gpx/UNcf+Cgh/2wdISY7KltRRi2cDr2ng3grnZTl+IcV79FFms6nARthjRch5JLiOuBU7rR8CaMRcYwpzmXNadQs+DUWqUkHttcGweApcnwd6OrkV6PBYxq265g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3tgvaZKGyl4nDbChRpthhng+3C8nnip3DQgCAw7+Dgg=;
 b=ZWm57U2yJwYOT2hZAG+QFOs6VoUHTkRr3QPZ95S14MUQ/apwmH4FNWGchKOR0GqPGGfqbINL/w/aqrqi9OsP2BNMwy6oATRn/ry7vTcZleQUfAX3wEXeIlmCXbLpsGUGwTYnRn4WsppTlOKJOeVUG2QLLOz00A4N6NsXWjbWxtE=
Received: from DM6PR06CA0051.namprd06.prod.outlook.com (2603:10b6:5:54::28) by
 BL0PR12MB4961.namprd12.prod.outlook.com (2603:10b6:208:1c9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Sat, 22 Jul
 2023 11:20:35 +0000
Received: from DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::e1) by DM6PR06CA0051.outlook.office365.com
 (2603:10b6:5:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29 via Frontend
 Transport; Sat, 22 Jul 2023 11:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT102.mail.protection.outlook.com (10.13.173.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.22 via Frontend Transport; Sat, 22 Jul 2023 11:20:35 +0000
Received: from gomati.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 22 Jul
 2023 06:20:31 -0500
From:   Nikunj A Dadhania <nikunj@amd.com>
To:     <linux-kernel@vger.kernel.org>, <x86@kernel.org>
CC:     <bp@alien8.de>, <thomas.lendacky@amd.com>,
        <dionnaglaze@google.com>, <pgonda@google.com>, <seanjc@google.com>,
        <pbonzini@redhat.com>, <nikunj@amd.com>
Subject: [PATCH v3 06/14] x86/sev: Cache the secrets page address
Date:   Sat, 22 Jul 2023 16:49:01 +0530
Message-ID: <20230722111909.15166-7-nikunj@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230722111909.15166-1-nikunj@amd.com>
References: <20230722111909.15166-1-nikunj@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT102:EE_|BL0PR12MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: 9023d043-a33f-44eb-9451-08db8aa5ab63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tx9dKhk7VWMlHowmUBMRCO+UzbJAFWLfl4H7oWAIDLxgf3657Z/r+Rv0IKqAOcf2hlGkol/CChm2soMMZZOqwfQgoLinXgMwy5n+9wbeE/R+EIP7oq2XW3FN3lwto41NTIy3hQDI70eerk3Y6uZZfzBOhxe/1f/ZSTDQXBSk+pRaMu/QgIUyv+4hQrn+jxYisnn/kk/gqO/VlkRK9EN/l3THedTW8z5YdMpvvvIQVzGLDMeAM52AvkevM7X9yCfgLH9VMV+JCRNtPAlrjTesSnh6mSeDzuKFTPPX7ga0ap136TkSwPGeeS8oZyPqvl4UWasB2KgXlOpqBFqP5WO91XKzjZ5WcVvGcLMISKWzkr6EE6PK8TpDi2Fm3D9vjA1Im2KtVOS0uhvglfN7FbNCorNeRUXNbP/7xOr4aOoe+Q8ibqg+Cy0aNuL9x6D7hAlkHGlUsNsIdOJMH7R/VjLfgfEWkoTAQmq/zlG6hI0L4t3e3kWoCPwFHnHJeCzEDV1GYabOpgeKT7Ir7QBfiMxuBqUUXytwwSTUmDFA8aiL3uL/H92ac2Y65OuXqc1v7D/fwrwauhTxFYsyemXnx18IV3WgtqjQXb0256AALjKKgkGLQueF6UdcDAFWwHT+11y3f2uLS6mmCX3JpzEn3FOao+JigK9s4IYnYG9duwehrF3N/mMsIn0KA1S0mWyG87PN7u7FebtlheNFh+OqhV08DAVQHhM2iZuwyZF++mMQf4RK2td36MD4/Hd7JL68iJpFxczebKT4X12ml7+b37i1vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39850400004)(136003)(451199021)(82310400008)(40470700004)(36840700001)(46966006)(40460700003)(81166007)(40480700001)(356005)(36860700001)(36756003)(426003)(2616005)(47076005)(83380400001)(16526019)(8676002)(5660300002)(8936002)(110136005)(478600001)(54906003)(316002)(4326008)(70206006)(70586007)(41300700001)(26005)(186003)(336012)(1076003)(7696005)(6666004)(2906002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2023 11:20:35.1630
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9023d043-a33f-44eb-9451-08db8aa5ab63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT102.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4961
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Save the secrets page address during snp_init() from the CC blob. Use
secrets_pa instead of calling get_secrets_page() that remaps the CC
blob for getting the secrets page every time.

Signed-off-by: Nikunj A Dadhania <nikunj@amd.com>
---
 arch/x86/kernel/sev.c | 52 +++++++++++++------------------------------
 1 file changed, 16 insertions(+), 36 deletions(-)

diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index a10cf9f21e22..a63a3edf13d0 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -72,6 +72,9 @@ static struct ghcb *boot_ghcb __section(".data");
 /* Bitmap of SEV features supported by the hypervisor */
 static u64 sev_hv_features __ro_after_init;
 
+/* Secrets page physical address from the CC blob */
+static u64 secrets_pa __ro_after_init;
+
 /* #VC handler runtime per-CPU data */
 struct sev_es_runtime_data {
 	struct ghcb ghcb_page;
@@ -561,45 +564,16 @@ void noinstr __sev_es_nmi_complete(void)
 	__sev_put_ghcb(&state);
 }
 
-static u64 __init get_secrets_page(void)
-{
-	u64 pa_data = boot_params.cc_blob_address;
-	struct cc_blob_sev_info info;
-	void *map;
-
-	/*
-	 * The CC blob contains the address of the secrets page, check if the
-	 * blob is present.
-	 */
-	if (!pa_data)
-		return 0;
-
-	map = early_memremap(pa_data, sizeof(info));
-	if (!map) {
-		pr_err("Unable to locate SNP secrets page: failed to map the Confidential Computing blob.\n");
-		return 0;
-	}
-	memcpy(&info, map, sizeof(info));
-	early_memunmap(map, sizeof(info));
-
-	/* smoke-test the secrets page passed */
-	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
-		return 0;
-
-	return info.secrets_phys;
-}
-
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page_layout *layout;
 	void __iomem *mem;
-	u64 pa, addr;
+	u64 addr;
 
-	pa = get_secrets_page();
-	if (!pa)
+	if (!secrets_pa)
 		return 0;
 
-	mem = ioremap_encrypted(pa, PAGE_SIZE);
+	mem = ioremap_encrypted(secrets_pa, PAGE_SIZE);
 	if (!mem) {
 		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
 		return 0;
@@ -2093,6 +2067,12 @@ static __init struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
 	return cc_info;
 }
 
+static void __init set_secrets_pa(const struct cc_blob_sev_info *cc_info)
+{
+	if (cc_info && cc_info->secrets_phys && cc_info->secrets_len == PAGE_SIZE)
+		secrets_pa = cc_info->secrets_phys;
+}
+
 bool __init snp_init(struct boot_params *bp)
 {
 	struct cc_blob_sev_info *cc_info;
@@ -2104,6 +2084,8 @@ bool __init snp_init(struct boot_params *bp)
 	if (!cc_info)
 		return false;
 
+	set_secrets_pa(cc_info);
+
 	setup_cpuid_table(cc_info);
 
 	/*
@@ -2256,16 +2238,14 @@ static struct platform_device sev_guest_device = {
 static int __init snp_init_platform_device(void)
 {
 	struct sev_guest_platform_data data;
-	u64 gpa;
 
 	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
 		return -ENODEV;
 
-	gpa = get_secrets_page();
-	if (!gpa)
+	if (!secrets_pa)
 		return -ENODEV;
 
-	data.secrets_gpa = gpa;
+	data.secrets_gpa = secrets_pa;
 	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
 		return -ENODEV;
 
-- 
2.34.1

