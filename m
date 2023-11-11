Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD1C7E880E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345470AbjKKCBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKKCBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:01:46 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C163868
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 18:01:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZSPRTqtR9aJ77JDXS+Km2K/M+mWDVhJqKLltpneFhN6kr09LqmY9xZeJzVcOI5LYUOlvqYIzGBugpOPXy1AFeqWEKStypEzDKU9UWylS89mPdWwJoBAoPNUJieM8jQH8SdRRZfjb9zkvrb+70sWzoKBUNwoVBcORyROLRNY+BqIIMzKdpAwWb0oSAJjY8+u1lnFhDxWAP/tjBWgSl85yLpTcoNfZWden7esjFu/AwEHIKnYSzUrW4AJrFmj/QAwPTLC0sOxOLyPmhL3070plLKpUD87cKpGo40ofnF+UqolovDTxRw1khCvLj23sJ5FXujqsu9gb0Xu7PiK0bX51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZNP/eIrIUThMx8ajUtI7m2oEVozcnaNrijevvyXsvw=;
 b=FttJbhLsze1K8I9zehGJ+tXk2JzC1qHgWgOe5jiGjf+RmoOUB6kYQnPeKDvyejFoUGRaMU4f3q/YH9Q4K11MKoOxa7H4xmC9bPFKlGppvNFGxIKzmEgZZU5lwAZZUraNsiKZOGzr6YIqfrZaWEILRHtnml+hMszy8JrfICQ+Mo/8SRvzxbwLWfduoLcf0EiAOTkXqLGVyg4Ozi2paNIO8s8i/fDhx3DVQKbncsQAzozFAoV/+HxDxk7VACFpsDXfBDGYrTSpT1g6MZOCCb+apMUjm3uQd8nllMbABgmJpvv6SzsprozKK83O5Jtt/LpC35XZTfVbi856IWksF/DXvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZNP/eIrIUThMx8ajUtI7m2oEVozcnaNrijevvyXsvw=;
 b=Hgs7HVnMbsB2VnLFqd0jQXAHcxHL1aKnThioxCarl+H320JceZ6dVtUJnLMxOwNtf6gjWQ7zPJkonagZl7cNmprZ5Bn3P701m0I8qfJunGJA+Yv483/GuAHP8AUUGW22g7k2ZZWOchlaDeg/wuEwwuT/WT8zUU/f+lOGOKtVB0w=
Received: from MW4PR03CA0254.namprd03.prod.outlook.com (2603:10b6:303:b4::19)
 by CH2PR12MB4118.namprd12.prod.outlook.com (2603:10b6:610:a4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Sat, 11 Nov
 2023 02:01:40 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:303:b4:cafe::9a) by MW4PR03CA0254.outlook.office365.com
 (2603:10b6:303:b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Sat, 11 Nov 2023 02:01:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.21 via Frontend Transport; Sat, 11 Nov 2023 02:01:40 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 20:01:39 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Joerg Roedel" <jroedel@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86/sev: Fix overflow when computing address for PVALIDATE
Date:   Fri, 10 Nov 2023 20:00:19 -0600
Message-ID: <20231111020019.553664-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|CH2PR12MB4118:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f400989-f52a-4c9d-ec58-08dbe25a2547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vG3oUN89JnmyheENDyRiieQeLEV7pkEWX0E92Rbm8N+bnOsjhO1IiyrO901v+pbaDpGT/iO8jy1I/WoeK8ddWU+rr++afCc8ga6ysB7kroP5UtsCTSbcXRJwrKShP4TC8JETXSpAhOw/kTD2CKWf5A6HXLkG8wXy9osZj9MpRChpNKGi0CY0B36mT1SRpeVFoqF56LzSyC3pKq7evau3cWsa4v0j7WDNEEqHaxjamHfh8mo4etLA62VMQKcUTqX1WvUtT9RuWiUhIIU1HYuAm4QJ2pZQE0dBeuAlJfYiepO/oWpbyqo3owULqcY4HMj9RDaT45blY7Fw3hw9XyicQFSa23VUwl3RM/CzBemDRUucx/A7Uzv3mSUctPUSdY6VaR/i5wSLr2lfTd8an2+WBPWXdvgwQdunqA6MwQ7t1Ld0zF9a50lnrb2cJ/lJtN1K3ScCClnVS/DvJzurR1eiXapoYwLthxztV4xlAY2gXltpX7XTIyMauMw+DDpickHANJ2oa5HawKyI5kbl5E3SxbHzIdUVApKXskmCzCvQbX4BmnKjTxvlJ7LakF4blFn2F+MLLyuFJ2stCOu015+w0riipnkq5cHMp447qTL2Z0nll7DV1OX7azYUvIOU2w1tm1ZBgH0iY5+yvvxVgvCnT6y2330KO1cgJKR8AkeNh3G5qWtwCrOGBmEHZhNVUpYHYbjZXeHX/kzxo4GuKu/9GZ6v+NdSlJqNObjVzIDOf4GG3N88EJD0kcjQ/gdz04IXYAyY9lQ6xsTp1VWLp6PGIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(36840700001)(46966006)(40470700004)(2616005)(40460700003)(40480700001)(82740400003)(44832011)(356005)(86362001)(5660300002)(47076005)(36860700001)(81166007)(316002)(2906002)(41300700001)(6666004)(1076003)(26005)(54906003)(8676002)(4326008)(70586007)(83380400001)(8936002)(426003)(16526019)(6916009)(70206006)(336012)(478600001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2023 02:01:40.2055
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f400989-f52a-4c9d-ec58-08dbe25a2547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4118
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GFN in the struct used for page-state change requests is a 40-bit
bit-field, so attempts to shift it by PAGE_SHIFT to get an address will
result in bits getting lost if they cross the 1TB boundary. This ends up
causing crashes when booting 1TB SNP guests with kernels that support
lazy-acceptance (without kernel-side lazy-acceptance support, OVMF
handles the PVALIDATE for GFNs in the upper address ranges, so this
overflow condition is never encountered by the kernel).

Fix this by casting the 40-bit GFN field to a 64-bit type before
converting it to an address.

Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 arch/x86/kernel/sev-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
index ccb0915e84e1..d92e048f4235 100644
--- a/arch/x86/kernel/sev-shared.c
+++ b/arch/x86/kernel/sev-shared.c
@@ -1083,7 +1083,7 @@ static void pvalidate_pages(struct snp_psc_desc *desc)
 	for (i = 0; i <= desc->hdr.end_entry; i++) {
 		e = &desc->entries[i];
 
-		vaddr = (unsigned long)pfn_to_kaddr(e->gfn);
+		vaddr = (unsigned long)pfn_to_kaddr((unsigned long)e->gfn);
 		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
 		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
 
-- 
2.25.1

