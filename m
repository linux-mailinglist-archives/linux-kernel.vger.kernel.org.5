Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E202B7F4CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343853AbjKVQje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbjKVQjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:39:17 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB30F1FFD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:37:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nb3AjvHkBcNEpziRnnctBItO1qyRtvmf2tlfHiANwHD7+P8xIm4NznfDUOaex0HX7V5Zj9fkKIlnbbvwaU7PGCV9vXrOJQV97b3nd935Ppe2VmLOghj+E/z6iKvU9KJiCuUGo4dsV9+SlcsgWywEg8lX6cp9EH0Vtw+NCfPAHmzWIpDeslc6WJuJBJfby7jSsgZ7bFFxrUN6uqsuQVGx0CdV1Aa8Gw7nrBLLRLmeqFrOqAgC9xIjakMsIKDAs2jGMithIuyOEU9zuuXeihQOCR6cLUeSB76drdPmttampyxF1AxYH+g3dLF/iGbGgMzVqFRTc1f/A8+TrnDwbtLdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAsaGoDonctE7Y9m83x4EeG+S0H1q+LgU7jAsL8BZk0=;
 b=Ykp/vJTjtDu0EmWi+gXx9OdxzGKVALkAvV/86bycnqWCeX58OPLGnmAU1N+eml6OXFTbj+x5Qx8X+nPFJXXUYn5Q1R7DqpJT0ZL2jx3dbkaT22ch3zsq2OfpbTymnaUwf+yGFKqvoYgRnzJnJICLI+DPu9NVMkvyThM1Lm6KHIvtGVq3aFE7BSHTbLjfX3M4LcZh+1baEM93nCu15wvb2u9GEnDMmBXeff/b0dGAbgJeh494BfZzmJnLEb0elcp2L037iNAm5pRn8PuzwjVOX4JqxlC6fLPtGmvTX41Z8pz96rpjoX9mLQbiSJ9N+ZW1us0vQThz/Cvtr1Uv1K/reA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WAsaGoDonctE7Y9m83x4EeG+S0H1q+LgU7jAsL8BZk0=;
 b=1sH7lV1o/togqzgVpwo40UpybDBOspvjB/34o8QeTiMtx4gFxleekUm8LA3oOgiD5jW0ybSTJUBEa6nJnVYUKFnN6gaHkKI9WEf9CEwlwOg6aRKEjuw5QNMkcXWHrXt8Uolox7RE1gQtBZYcY17WvgRPZPXppfk59VsgkQCmkuE=
Received: from MN2PR16CA0031.namprd16.prod.outlook.com (2603:10b6:208:134::44)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 16:37:40 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::82) by MN2PR16CA0031.outlook.office365.com
 (2603:10b6:208:134::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Wed, 22 Nov 2023 16:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Wed, 22 Nov 2023 16:37:39 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 22 Nov
 2023 10:37:34 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Joerg Roedel" <jroedel@suse.de>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v3] x86: Ensure input to pfn_to_kaddr() is treated as a 64-bit type
Date:   Wed, 22 Nov 2023 10:37:00 -0600
Message-ID: <20231122163700.400507-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ea392f-fc9b-4cd4-425c-08dbeb7957cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzaTnIiDla7BxcXYdIGagROLbGx+ocYG3+BhsGcCC9X/Z1Z6Kh0SKp+jDrpCFx/yYv5K5x/aoU3DGqNGhnKl9SkS4CcaavTWFVrK/byB70GGMbBE0rmotvSRLM91XSmMso8xd2W0cSjm8hA/rfPCAJnLIu1BaV07qNRgUKORx34ecGF3GABUB2XwLgPED9yQLv0/54BFng7xqQGgBF5R6w1Q+B2xPeftgeSRPtaaLDlu11uPZlVmfEmgQovwc4wh35mrMbmfmH0ghLMRRyvlEHimARvMuKuh1SlvLXQ29I9dQJd8cSympXzTK0oo2xlqiiVkM9qdWTH1mhDnE42tlM+sNtpw8PZDmNYaaXIcXAe7qjQj7SyUO+hlQjb9zxKYkqz7weOI6zkrG4wJnD/0URlN9ZupBMJ+AgJgIYYxlSydfXavy9QyxGzNRh7KTb+teHVeOFLygPpba30Der/+NDbSayiIugePuPSbr2o2maKlGKNQ9QtbcFT5ilFqMHx5+yWWW6Ga89XN1Uh4RBeDl4lbSmYCNg8DgTEmJGA9Yo1q7Oy8E7dqaNu8T0vw3is+6CengVHTww+j64PsUFu4UUFaOm+nlq4YsfRmg8N1eb1Edhlkr5V851M/G4EYmzUjWm9GACgMMuOuwTYKhv3NMo+7bZkgP1XzLBoM6xJEcIsB+l0fQQpSmkOla2LLdwn2zrwCWcwJizjWlY1DC+wW0U8kZKZ3+goC0+9XAc3YJziPdE8dBcjBGj7FPTHDI5Qu7yEI/ixMLZE4oOdzClu1kg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(396003)(136003)(376002)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(44832011)(8676002)(40480700001)(41300700001)(8936002)(4326008)(316002)(54906003)(6916009)(70586007)(26005)(70206006)(40460700003)(66899024)(47076005)(86362001)(16526019)(6666004)(478600001)(426003)(2616005)(336012)(356005)(1076003)(81166007)(36860700001)(36756003)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 16:37:39.8850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ea392f-fc9b-4cd4-425c-08dbeb7957cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 64-bit platforms, the pfn_to_kaddr() macro requires that the input
value is 64-bits in order to ensure that valid address bits don't get
lost when shifting that input by PAGE_SHIFT to calculate the physical
address to provide a virtual address for.

One such example is in pvalidate_pages() (used by SEV-SNP guests), where
the GFN in the struct used for page-state change requests is a 40-bit
bit-field, so attempts to pass this GFN field directly into
pfn_to_kaddr() ends up causing guest crashes when dealing with addresses
above the 1TB range due to the above.

Fix this issue with SEV-SNP guests, as well as any similar cases that
might cause issues in current/future code, by using a inline function,
instead of the macro, so that the input is implicitly cast to the
expected 64-bit input type prior to performing the shift operation.

While it might be argued that the issue is on the caller side, other
archs/macros have taken similar approaches to deal with instances like
this, such as commit e48866647b48 ("ARM: 8396/1: use phys_addr_t in
pfn_to_kaddr()").

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
v3:
  - Use an inline function instead of a macro to handle the cast (Peter)
v2:
  - Move the cast down into pfn_to_kaddr() to fix other possible
    instances (Dave)
  - Rename from "x86/sev: Fix overflow when computing address for
    PVALIDATE"

 arch/x86/include/asm/page.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c332cb9..aa8930da42fd 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -66,10 +66,14 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
  * virt_addr_valid(kaddr) returns true.
  */
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
+static inline void *pfn_to_kaddr(unsigned long pfn)
+{
+	return __va(pfn << PAGE_SHIFT);
+}
+
 static __always_inline u64 __canonical_address(u64 vaddr, u8 vaddr_bits)
 {
 	return ((s64)vaddr << (64 - vaddr_bits)) >> (64 - vaddr_bits);
-- 
2.25.1

