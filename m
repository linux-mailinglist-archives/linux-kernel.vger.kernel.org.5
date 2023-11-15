Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68E037ED1DD
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344335AbjKOUPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKOUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:15:07 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8476B8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FV3atcwqVb4zrCNIpvWEe+yPQPKqr7zdeapsc8aafeNUyNHNn04elBHJpEGqBHcChcPj85NYya88dha5h1pGY1g9Czg9bmYVn6caePHSKXrMKqLHIZgNbdCTwPmxJYSikDTlG1iNJ1DFRAf0F1XGEeZZOM2KQNDLLcv9NUcR6OQOhb9mAL8KnRM1psMTTQN66IQZfeZIbeAaGAU5CIDV8fHZo2OZX2dPEJ2s6sg8LYPma6ZrIACv0wGjmTF7Il3ZPC9xyNhiY9JBvof8QNd0wD+U2JobxxIHhFB54S9YMlTnagJJqg38wKaT9O/+wxH1N20QwIc26aC4utlzopOJPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8QwUQNX/kFwtmSpxBJ+TVKZb9fvSIbEBIYrIG6fcJd4=;
 b=I6BTKu2mH9jesQj96npZzFoTYTQQaiRQKFmcMENfS2+DrK0gF5Zi2n9UBpkZ24z4SU+kjlvjgpRD7iicNtsJ9Y85TBIQ0gTjl8f/krcvhORwGgS6idA8ec4ghL/sKhYjZMl4TufKbgrCCBWO3ckxHviLBm/DV974Kw4s4RqVwQvkmBb15YVbm+U4Fa3cmi/fzoJjQQyJnQqO8yUV6nAuzFi3y7dSdygQ417EzoPkau4Ek6wfTrhMMzeYLK5A4UvKlQCxZuavDNyIaCVgoo7P1KkBe7CkVTzBZzJ7FZrWMCqxpbBDpcgF8BODxfOKCngsZXCwydqbDPM3VBiQo7a57w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8QwUQNX/kFwtmSpxBJ+TVKZb9fvSIbEBIYrIG6fcJd4=;
 b=Gx0Q525UcM0qR6QW4PkPpWfAQFzkXaq2Q1uWrGzFLgVSY+9/qvrgmjeWwIJ9PCT5zFTvKMtKfRPOnie/XHaCtKf2FOimytZfna4o0V7PhkPTHuHM21YXMlwbVhTUDKMy4NWLAd79vswAP3KkndOrrcTEdRT05vibquwy7GZvT8w=
Received: from DM6PR04CA0011.namprd04.prod.outlook.com (2603:10b6:5:334::16)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 20:15:01 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:334:cafe::93) by DM6PR04CA0011.outlook.office365.com
 (2603:10b6:5:334::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 20:15:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.20 via Frontend Transport; Wed, 15 Nov 2023 20:15:01 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 14:15:00 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Joerg Roedel" <jroedel@suse.de>, <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>
Subject: [PATCH v2] x86: Ensure input to pfn_to_kaddr() is treated as a 64-bit type
Date:   Wed, 15 Nov 2023 14:14:31 -0600
Message-ID: <20231115201431.820278-1-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f659875-363d-4b2c-92ee-08dbe6178c50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1I2+6yfvcREXgYm8YSvUonmbqvcW6TZctHnAx5viGzr+cqhH+0c/A98J8nuw6kWtgMBxmlB0xI539DG+oM90OwcwyBpWC+JY+a0rWNQBJScR74ZUSexNAQQtVu7UTRIB/yZUDycpagsAW95J75WCWBLD+tXHJdBFtmSmd813YEuUYBrEJngX5YyCL5zsvE0lv1WRZKaJMna5dGrkMKQY3enyLS2FFkpe+W6akaWY+0HHHuKs2OGjVkEMJTmMmFy4m3gQfqVGSjlatgNlO4yu3Hff722r8jIMbEiS9m9VEN4VHYaH4M6R9wY0eh8nfUAYkrT8jhZrWoR/WxfqQrwyodQpuLRYDQClXohCa+dzRVIlAaTPA2Oba+mUhMp0SYUPsM0GW8BLhZtwDz8fAE6jTOaix/EB4lWNcXhByR36fD+r3NSKKjnybZUQL4c5pZtnm6zT0opW6GmHZmWTKLySC+d29uXPMVL+c/PlgTmsok9k+tf1dZ2hSQsBMSh6PMn1fQbbzzuAdmlGokz/xHfrEPZqHqMuBUVukFT38wKthJYWO2fM/IwEATEigra0nLHPFxA1a5mt2XPCqOdg7ckW7w9z1yFYGdsykW6CgmNkgywrG0YY9lJLlxvVg2fi8micrRmH1qSBO8dnRGvLxbsU2PPCP7lzHkibulyTrm6A9hNFSFhHqQ/MsWPZpw2AyRrWPNIv3Yznoof9XZv6hWIVrpd1iWiDZ7yCAT4zQTKPM1zjDsoc5AWkPGFr0WIyKJP4Xh1Ft6XXJQaDNQBzY2SRog==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(40470700004)(36840700001)(46966006)(16526019)(26005)(66899024)(1076003)(2616005)(426003)(40460700003)(336012)(83380400001)(82740400003)(6666004)(478600001)(36860700001)(86362001)(5660300002)(47076005)(44832011)(41300700001)(2906002)(81166007)(316002)(6916009)(36756003)(54906003)(4326008)(8936002)(70586007)(40480700001)(70206006)(356005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 20:15:01.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f659875-363d-4b2c-92ee-08dbe6178c50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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
might cause issues in current/future code, by casting the input to
pfn_to_kaddr() to a 64-bit type prior to performing the shift operation.

While it might be argued that the issue is on the caller side, other
archs/macros have taken similar approaches to deal with instances like
this, such as commit e48866647b48 ("ARM: 8396/1: use phys_addr_t in
pfn_to_kaddr()").

Suggested-by: Dave Hansen <dave.hansen@intel.com>
Fixes: 6c3211796326 ("x86/sev: Add SNP-specific unaccepted memory support")
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
v2:
  - Move the cast down into pfn_to_kaddr() to fix other possible
    instances (Dave)
  - Rename from "x86/sev: Fix overflow when computing address for
    PVALIDATE"

 arch/x86/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/page.h b/arch/x86/include/asm/page.h
index d18e5c332cb9..bc8d023fe78d 100644
--- a/arch/x86/include/asm/page.h
+++ b/arch/x86/include/asm/page.h
@@ -66,7 +66,7 @@ static inline void copy_user_page(void *to, void *from, unsigned long vaddr,
  * virt_addr_valid(kaddr) returns true.
  */
 #define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
+#define pfn_to_kaddr(pfn)      __va((unsigned long)(pfn) << PAGE_SHIFT)
 extern bool __virt_addr_valid(unsigned long kaddr);
 #define virt_addr_valid(kaddr)	__virt_addr_valid((unsigned long) (kaddr))
 
-- 
2.25.1

