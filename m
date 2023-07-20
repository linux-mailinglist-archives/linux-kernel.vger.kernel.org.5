Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1621B75AECF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjGTMyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 08:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjGTMys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 08:54:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C3F268C;
        Thu, 20 Jul 2023 05:54:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iW1WtU0ppMvEfz/XdaBzCz0k+2WaphSW0ETSHdO7p7MIRjgzPpi9PEQJdHDkWmkNv/RhHs3RrKgy7jGdTpdQ5EkascaVyDb6H9rPJVqaw4GVavJVamJeOyJTTREz/jCsdbargL/2b2E4m3NA1hwxpbkZBTwzt2rs/vlgqQgG0TYqRndxLdpHSZZZbKUEa1iBwBmNeNXzJaU05OpBCmQ+vMUabdHJcEvGH76j66+GvB1O0rpS393nuScNm9DreNu8W59esfOx1DrSqzIWSkQlmTWFo3sustc1AsOUlc4JQffAhtPjXT5yae9nn+Jyr6OpioT42COQHQtuI2DfizLnLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Om5MFofT8lAmv+jDjQ3D5jjvGthd1aPCAiowkvn5tRg=;
 b=CzePKim9R9bp7h/aAEv2N9SyasZVT1AA1qky70upmPVA7knbiaWaPRlsg6hwFwT0UBNdGJfdQK6YVx4XjjydjRYbaBup0pJcRRhjr2NF/kA6nem8YkplLW4SBSOxO6gGw/rkf2AeStbIS6WuGlvMBfHlYniZdU+2WHHB70JqETocGHTJ036isU1oujN3B51aXE/VSHRQ3EnWHhhzJTHVsPlMGfB+y4TiyTpGMYAP16NzpkZwz877Ay8i5MAP///HsMYq810WYLD7uBZzx8f9453ScwCPrSZNoVDLisgNORHWddxZlKyF46EOXJAAnEU1hEqdFRY3cH43G+k2HfKcCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Om5MFofT8lAmv+jDjQ3D5jjvGthd1aPCAiowkvn5tRg=;
 b=HCrF+ZFLGWGrP73oAhBOsbC6fWIPT7BoJfpzLe98Bu72Pfh9TUgeyt6I2J9PmCWsNK6Rrxbfz1j7OGafyKzZtYq0aiitz+otQRsfJz7wp9SebpzhNH6ledVTbobUOU2ihodlKS4R+X3WoF7DShHJaMwHBxE6lPcRpfD9fzBXigU=
Received: from BN1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:408:e2::26)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Thu, 20 Jul
 2023 12:54:45 +0000
Received: from BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::60) by BN1PR13CA0021.outlook.office365.com
 (2603:10b6:408:e2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.15 via Frontend
 Transport; Thu, 20 Jul 2023 12:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT008.mail.protection.outlook.com (10.13.177.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Thu, 20 Jul 2023 12:54:45 +0000
Received: from amd.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 20 Jul
 2023 07:54:42 -0500
From:   Muralidhara M K <muralimk@amd.com>
To:     <linux-edac@vger.kernel.org>, <x86@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <bp@alien8.de>, <mingo@redhat.com>,
        <mchehab@kernel.org>, <nchatrad@amd.com>, <yazen.ghannam@amd.com>,
        Muralidhara M K <muralidhara.mk@amd.com>
Subject: [PATCH 1/7] x86/amd_nb: Add AMD Family 19h Models(80h-80fh) and (90h-9fh) PCI IDs
Date:   Thu, 20 Jul 2023 12:54:19 +0000
Message-ID: <20230720125425.3735538-2-muralimk@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230720125425.3735538-1-muralimk@amd.com>
References: <20230720125425.3735538-1-muralimk@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT008:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 57277bf5-3f41-4951-8b53-08db89207e46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nioNs8LLLN9Gk44ol+hQiRVEnAa8xEh8NwmGe7S05BrgxsbZjjK2hE8OuL+oCNK1dlRo6/b4qMWDodD7E+r4gAMFy4J668rfAmAV4qy1wPYttLwl0iIwyATqz6pEEK1XtDYWRE7I69Jg56bWmEgLf0Q9+ediXNT+CYLeTTWuaJyiemivNk9M8zalsurN/V17iRHrhGxpiYt0KBKpOBDA7biSVChVWXYO8Z/uzBkAS5kyq8o+iZ9iOxX7qbe9x6OD453fF4efqU0cHj/VPCkvQEbAuTYbAYRpluOnsDyiYDP26nUmddVG/QcBRdlIcQLXJKcdYvOtohDar+qfOj5rGOzBnmvAGXJ3uEg7JJigzbl7jkGVoIAiMNLY6qNOxL9qsIY/9lZqKX+gb76U2mCyYFyGd/kShqENZlIeE43yFPgzZYTDbLYIT+WpzEUcciDYJp+JKsBWgflv8JXrfggUA73RfoCsLP9iNBlTe2JK2HrS0YO4baNEYpCtuZiAljEX29aidpFwFh9+dHgijefQEueAVHJgfNCQhzIxZNi88dSc3oKOcletbzh4InCjbsA9HIN7gYf3SHrNqeOq+aZvPs3oJmB8J1DPvS7DePsFScf4If8TPJQF3X7eyWZ/48+/4EIKtB0VAGGFAkx1IPIYvTT9VKegmAnNc7k6yLqZQFv+OUu4QapsBBKA5erAz9CHZ2AJ30ZUZXcgYASIh31kHIyK+HaHKWoGsZTG2pR5nk4bk2gKP9iibW0vqFaXJ4gddiIW9ZJARD1HWkxj3pveg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(82310400008)(40470700004)(46966006)(36840700001)(26005)(1076003)(40480700001)(40460700003)(54906003)(110136005)(36756003)(70206006)(81166007)(5660300002)(4326008)(2906002)(8936002)(8676002)(70586007)(316002)(41300700001)(7696005)(6666004)(82740400003)(356005)(478600001)(2616005)(36860700001)(426003)(47076005)(336012)(186003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 12:54:45.3099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57277bf5-3f41-4951-8b53-08db89207e46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT008.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Muralidhara M K <muralidhara.mk@amd.com>

Add new Root, Device 18h Function 3, and Function 4 PCI IDS
for x86 AMD family 19h, Models 80h-80fh and 90h-9fh.

Signed-off-by: Muralidhara M K <muralidhara.mk@amd.com>
---
 arch/x86/kernel/amd_nb.c | 5 +++++
 include/linux/pci_ids.h  | 1 +
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
index 035a3db5330b..0dece8606ae2 100644
--- a/arch/x86/kernel/amd_nb.c
+++ b/arch/x86/kernel/amd_nb.c
@@ -25,6 +25,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M60H_ROOT		0x14d8
 #define PCI_DEVICE_ID_AMD_19H_M70H_ROOT		0x14e8
 #define PCI_DEVICE_ID_AMD_MI200_ROOT		0x14bb
+#define PCI_DEVICE_ID_AMD_MI300_ROOT		0x14f8
 
 #define PCI_DEVICE_ID_AMD_17H_DF_F4		0x1464
 #define PCI_DEVICE_ID_AMD_17H_M10H_DF_F4	0x15ec
@@ -40,6 +41,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F4	0x14f4
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F4	0x12fc
 #define PCI_DEVICE_ID_AMD_MI200_DF_F4		0x14d4
+#define PCI_DEVICE_ID_AMD_MI300_DF_F4		0x152c
 
 /* Protect the PCI config register pairs used for SMN. */
 static DEFINE_MUTEX(smn_mutex);
@@ -57,6 +59,7 @@ static const struct pci_device_id amd_root_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M60H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_ROOT) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_ROOT) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_ROOT) },
 	{}
 };
 
@@ -86,6 +89,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M70H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M78H_DF_F3) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F3) },
 	{}
 };
 
@@ -107,6 +111,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI200_DF_F4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_MI300_DF_F4) },
 	{}
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 2dc75df1437f..70decb578206 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -577,6 +577,7 @@
 #define PCI_DEVICE_ID_AMD_19H_M70H_DF_F3 0x14f3
 #define PCI_DEVICE_ID_AMD_19H_M78H_DF_F3 0x12fb
 #define PCI_DEVICE_ID_AMD_MI200_DF_F3	0x14d3
+#define PCI_DEVICE_ID_AMD_MI300_DF_F3	0x152b
 #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
 #define PCI_DEVICE_ID_AMD_LANCE		0x2000
 #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
-- 
2.25.1

