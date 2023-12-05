Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BD7805F24
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345780AbjLEULK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLEULH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:11:07 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 358681A2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:11:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CpgbqiwEsNdiVDT8RhX9RPy3jN2DQ8AyQu3D0yqlGYn1Eit7z/ZndPpLde/EwbXr1S9iIs4qJGGEb83VY9jM9qRiMan2T2LrNA3t3CeTkRENkUPp31LKfL5C3heYTy8XndTZZIGt4/zYfPIyp7Q/JPCadlHIetGLga2jaMW6yKOxVu11QLP/gDtp9TTALvaWqW0DMyJS38faohj/oNBKYYpqc+98hUVrWYqsi3ro/4nO1MAyPAz1LTaocdEdDCC8JphiVOp9NWEyLToevtK05bPk/maRUvUOtJx5O3KGhitmPKXt9HqyfBE9ImXyqUOCyaKcVhNnSldAvG3GXzlSAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlzKxx6TMxImBgXB2nrF7KDl7M0rwCdlDssGlSlczoE=;
 b=KHkv/pSJFdyJPMCtjARcqkIRVBnjy99RInsgc77D35U5YqAdVmceFiP3B9ifv4nk0kYWy/m0lqtTeZf/su37I1Z/nS6jVE84Kho7oBJB/jWrvjJoDQ4DDLuOzNfjj4Id5YIxlNSd0gQl2Wocvr3QG7lc3vRaZYOQ1eEDcbAOBcAL2Ibq+8y1ZFNYpwBKU3CWfJLDmzf0v4BPhCD02y5P1VjhQGByl6n/LdSFTl/BRwLVxtewnL0Zm1IEG3d7apQSJsehnqU4tnc3hBSHWpZJgS5Aq/itnow+2NpmiV/MTcfZDd0Eiu02hCp25nBMnE3RUY3Ae7yUNzxnecQ+EOrqXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlzKxx6TMxImBgXB2nrF7KDl7M0rwCdlDssGlSlczoE=;
 b=FHij8AZaIVksN5F6sTYjcyVhGUCsRpb6vvkpZuySs2NGMuANGx7Js7ZhNISUl0VTxD2OpdPG+cTxnMbZpTz895+LTC+Ke6+zk0lrOe4vjSMYFKynx6zTZxo8dizXCwj6DL+v0o0yPdM2Clsh25vO6bSqt63DM1W7Jr4STjwxa5s=
Received: from DM6PR12CA0018.namprd12.prod.outlook.com (2603:10b6:5:1c0::31)
 by DM4PR12MB7742.namprd12.prod.outlook.com (2603:10b6:8:102::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 20:11:08 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::10) by DM6PR12CA0018.outlook.office365.com
 (2603:10b6:5:1c0::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Tue, 5 Dec 2023 20:11:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Tue, 5 Dec 2023 20:11:08 +0000
Received: from jallen-jump-host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 14:11:07 -0600
From:   John Allen <john.allen@amd.com>
To:     <jwboyer@kernel.org>, <linux-firmware@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <suravee.suthikulpanit@amd.com>,
        <bp@alien8.de>, John Allen <john.allen@amd.com>
Subject: [PATCH] linux-firmware: Update AMD cpu microcode
Date:   Tue, 5 Dec 2023 20:10:11 +0000
Message-ID: <20231205201011.2511131-1-john.allen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM4PR12MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: 72859f67-2a02-4b41-810e-08dbf5ce518f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I43FwSCWxmII7zt1GdcW3UhsVL+3uX9PhWw0B3HIkxWwIxM8UK8ojR1piktLdSpxxLCc9exOsPqHcLGEkSEmgr1wb1aplK2Tq3PafMpGPprMEtE4BS1S4K0tEYTLtS71nsJwkZt2Smgpv6beyikG9HnuBprrGg4zgjq4ysF0q85Rjaidti6UdUQy3YCY2Y+tYbSOisJB3sRCpcI8NvmteNnGCdvTjM52WAHvPk2+gEN9dvTo8gSiGTtbIL0GmqdQIxy/jBpQlCD0pp6iEisp/5bfj6s5XJ1NHGx1sjT0Rd/7Vt82UxcexK+oYvcfjA8AXXbPoWq+8n8FDov7EE8PYMjDjn3ofp+fJ9NC1YTeGtsWSPLd9sVFGD9h91AFo1IBuubzgt2btDkRmtE9183ybr0Kpv5Fk/QrxzJvHpQfwsY4mm9menGwW51TROBubvWwaZ3NuLFzaNJld+KWkSd3+e9SgWKD3ZXX4ST2BY+bD12MaYGnGbC26U9e8sH//fc5JcGwiMeS6WQ9sJ4vGuCN78O9SFovk7xr84OZhDbA4vPXGlKR9lRIH7oYWo6SKBmFTcMPOQC3MJkWnUvvAQtM/IRuTZOdp6G5cIIGdwXXZgUjk9haYClkIToM8PPj3Gdm5I8eZXtk28zGLTAUjeJ7rYtVeiFwTJapaMwMfm4KcbrMSj/LdmVK4Td7S69dM4VvEJmhMT1DWKu8mGMcStYOJ/nMsWsX1rxsRknpVqNsd/QMA1UDoATTSGoYNAVAvyKr1UjK9rRxxS25njIgi6i7Gw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(356005)(83380400001)(47076005)(82740400003)(81166007)(426003)(16526019)(40480700001)(26005)(336012)(2616005)(7696005)(1076003)(36860700001)(6666004)(478600001)(40460700003)(70206006)(70586007)(54906003)(316002)(110136005)(8936002)(8676002)(4326008)(2906002)(41300700001)(44832011)(86362001)(36756003)(4001150100001)(5660300002)(15650500001)(19627235002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 20:11:08.1765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72859f67-2a02-4b41-810e-08dbf5ce518f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7742
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Update AMD cpu microcode for processor family 17h

Key Name        = AMD Microcode Signing Key (for signing microcode container files only)
Key ID          = F328AE73
Key Fingerprint = FC7C 6C50 5DAF CC14 7183 57CA E4BE 5339 F328 AE73

Signed-off-by: John Allen <john.allen@amd.com>
---
 WHENCE                                 |   2 +-
 amd-ucode/README                       |   2 +-
 amd-ucode/microcode_amd_fam17h.bin     | Bin 12924 -> 12924 bytes
 amd-ucode/microcode_amd_fam17h.bin.asc |  16 ++++++++--------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/WHENCE b/WHENCE
index 832c66ed..dc847c5f 100644
--- a/WHENCE
+++ b/WHENCE
@@ -4037,7 +4037,7 @@ Version: 2018-05-24
 RawFile: amd-ucode/microcode_amd_fam16h.bin
 Version: 2014-10-28
 RawFile: amd-ucode/microcode_amd_fam17h.bin
-Version: 2023-07-19
+Version: 2023-12-05
 RawFile: amd-ucode/microcode_amd_fam19h.bin
 Version: 2023-10-19
 File: amd-ucode/README
diff --git a/amd-ucode/README b/amd-ucode/README
index 86d69822..a982ea1f 100644
--- a/amd-ucode/README
+++ b/amd-ucode/README
@@ -32,7 +32,7 @@ Microcode patches in microcode_amd_fam16h.bin:
 
 Microcode patches in microcode_amd_fam17h.bin:
   Family=0x17 Model=0x08 Stepping=0x02: Patch=0x0800820d Length=3200 bytes
-  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x0830107a Length=3200 bytes
+  Family=0x17 Model=0x31 Stepping=0x00: Patch=0x0830107b Length=3200 bytes
   Family=0x17 Model=0xa0 Stepping=0x00: Patch=0x08a00008 Length=3200 bytes
   Family=0x17 Model=0x01 Stepping=0x02: Patch=0x0800126e Length=3200 bytes
 
diff --git a/amd-ucode/microcode_amd_fam17h.bin b/amd-ucode/microcode_amd_fam17h.bin
index f9841b65b8d6ea156a402f45bba17f0e31eaf4ea..4afcc9833d26adc165647ef1c5fa9ada2a7d9124 100644
GIT binary patch
delta 2716
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
W0Duet03#q31_%J42n4fz8UGkt8ZYPo

delta 2716
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
W0Duet03#q31_%J42n4fz8UGmAKS?tH

diff --git a/amd-ucode/microcode_amd_fam17h.bin.asc b/amd-ucode/microcode_amd_fam17h.bin.asc
index 34a40245..49a9f32b 100644
--- a/amd-ucode/microcode_amd_fam17h.bin.asc
+++ b/amd-ucode/microcode_amd_fam17h.bin.asc
@@ -1,11 +1,11 @@
 -----BEGIN PGP SIGNATURE-----
 
-iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmS4Mm4ACgkQ5L5TOfMo
-rnN35wgAkllCunxE6J5hQyLMx5o4WTHZkbNvXmu6nV1Y3vjiL1oeaK+pmx8BlkPt
-fGZJCe/068kqmp3N4EtOZLxXn55t3jNBYectPr0RmFqpjMsEJEcfXfuXROA4N9Ti
-Zd/o6X21eHEsm0kK0q4YfppfgTd5Ze7k1jTkUuuU6/yh6uRk1MiFreEzkPO3Aayh
-iEWlYx33vq3HccTPgdY3D64Zr8gmgKG+8mdEvqb1jK4SVZ1/9vy4OKIIpUZB/eqx
-46h9Ejwn9pktnYkHi/A/zCREEcIQ10HXFF5bjxJTFQkM5S46/QEO7uuvnpMb+6Yy
-4V1/QIWMG6ixqCRx9GqbBK7GHdYODw==
-=+IsI
+iQEzBAABCgAdFiEE/HxsUF2vzBRxg1fK5L5TOfMornMFAmVCWc4ACgkQ5L5TOfMo
+rnPh/wf+LAIyLbenqgpit5OPRZBhw/zWk3Wtl08328h1LJilI+ebJxtjYLlL8sQc
+NAkfN2f1RqRAoqhktxEMiWc9G4C7gqji1CTKTFLdALk+NaHPFA9z1E8nc+aUp58Y
+EXfmr0wWjKdMfyGzkDt+gX2QVGom5yN2uAe+rg/OeepuzvVMQtijOHsu4jKlDk4o
+lcuD8m+oRxCA4umPGQVNoeAhqTK+0MIAYQ8Igv6v/yk6bmYvd9CTCs16OrL1cFPm
+153kvq2agnmqLlB9Tl9yVApqkE0iinzWBBDuYuno+1I/tfs1k5AOmsxGa1CVVz45
+ZrYL1jovjWpW7VTiyKxIUlR2SHv22A==
+=B89Z
 -----END PGP SIGNATURE-----
-- 
2.25.1

