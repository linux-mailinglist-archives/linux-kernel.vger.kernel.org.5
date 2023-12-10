Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFEED80BCCC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 20:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjLJTtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 14:49:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjLJTto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 14:49:44 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E971BF2;
        Sun, 10 Dec 2023 11:49:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErG3Dd9DNdIxOsMx95LXzhYdbXsB80maITryTgVfk0ziEaZiy8k02fu3QRaWqkaVrUwyJuG0I5WhdoVLMdaXZgdNncKdWWeW/PuTQAphcAtdzREFWkMcaSXYlsQfNj8sw5weMD/fxzenlULVye959FNfjeaY56/pZPgAEkT8A+rs9etVB5nj8/qAvZiX8sJkoUMuoXX8LZ8ozzCFduQ1UJ723cCWuxtIQpk2k/vbRAhdogmh3kNOHLPJ0GAVkCumgFy+YdYWLxvNMGyIvFuSmRGhNZojCaa0tIuvnYNKt3ygflz39MO+6/nviWIJ1LKE9rowFAq8ZL9857qiGov5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYTbgsI92H8omPPurHk55DG66SvkCxg65Kk+T+4lZAU=;
 b=HiNHxEtvb1G2X+xULT4r73l0r1IuYY+SZ3zcSg0pWyWXAJ4pOIJaSs3KmAfhPgeVaeSQ539Uli06qJJuOgkzmagWJfxVOQ8mGGuYNVysVHtQAoBHAV3iTxLbA/3OmrTrjj7zbWz45pyWeQkseEZXRNVibd0EZDZgJcZdPpJx1Vz+mv3gKjB9N4id1s/g7j3NbOju++VU18dadmlJh4qD2zh1gsEdeUIm0t04LeGFPz4tDN7yG6YtpmdGJ3yTon0ccB89bijZPQsEhyCTcB/QxXD/m9qZJsjP1viMksh+wP6oNxn6boHhx1IyIEihyoPGvphP+6TuLqE0GlPR8aCQxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYTbgsI92H8omPPurHk55DG66SvkCxg65Kk+T+4lZAU=;
 b=fXnrnMWQiA4Cn6u1O2uWrYz/hUpNmAVq89BWF9PfRRWfhxcXfRsSJsUlgGvuPvkZ+22HZHrAlRZ0EP2KCBzFGDKbUxeiBQmu3tQRKZUKgKo6IkbXCQzl2ID0mie1ZNcFZIOKC9s/0tCSEzGr5G8M0F8dMHJY9YQ4KJwZ06Qm74I=
Received: from CY5PR15CA0245.namprd15.prod.outlook.com (2603:10b6:930:66::11)
 by DS7PR12MB6237.namprd12.prod.outlook.com (2603:10b6:8:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 19:49:47 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::94) by CY5PR15CA0245.outlook.office365.com
 (2603:10b6:930:66::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 19:49:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 19:49:47 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 13:49:46 -0600
From:   Yazen Ghannam <yazen.ghannam@amd.com>
To:     <linux-edac@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <tony.luck@intel.com>,
        <x86@kernel.org>, <avadhut.naik@amd.com>, <john.allen@amd.com>,
        <william.roche@oracle.com>, <muralidhara.mk@amd.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v3 3/3] Documentation: RAS: Add index and address translation section
Date:   Sun, 10 Dec 2023 13:49:32 -0600
Message-ID: <20231210194932.43992-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210194932.43992-1-yazen.ghannam@amd.com>
References: <20231210194932.43992-1-yazen.ghannam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DS7PR12MB6237:EE_
X-MS-Office365-Filtering-Correlation-Id: 327b1121-136b-48cd-b98c-08dbf9b92a1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KQih5XPSYC9ly2DmEN2d6vfw0Uzhfh+eDWQDl+yuGm4h0zx+gcXzI1z1N2eM00s/DffCDF8cqzRgL4OEku/dJr7JFVVO/gA/fXWd0bDjg16K0s7hPXkP/jA05NH+7NfhO0dIJKXuxgIKFj/aGWlul/uw9KnttE+hwvwohnLhLBihZzrIvhhUmlGOHjCGYAReuGwsCTR3zVfpMxFCPNQKwDgkyzQ2LcyyzHEnTFF/jITA3pAlfRjZGfma3WaTZhbynXzwkF7DalVpLtX8cKGNHx4hQ3D7FTEaJ3W7sBHnlnQLwBqjYTJVC0kAdAfJFXC+mIUBdhYLmsIdPa96qhBJm69BBRQis7giJWReNaHhWtEYM6JS3O1q2bdhW1bbYYHDARA4MKRHMyoAFQsHE3pk6vSbULpbEz46B+BE15xQFPozoM0yeZRxIMc97Iu7R9tshtmr3GXiroe6LvtZxBQuDi7CfwZq1CHZo6p4Ab60kX5VnfYtCgE4Kd0hd0wje/Y7RWHqCI2JJGYaClYvLcx0ikhCVE5gJ8UErX+6o/88L5GBaPeRnTdwLq15qvc57iZW6m58a7qYvX6I9S/nPgTbMpEnDhu5AOHB5aTuIBhADvERbmUV1+AqpSisNXueRfpU2SjIJbsIvkf5injFN+72HYjeixO9o57R7ORj2xe+2tH4vKBEkW/J2g1gw3bRW43pIYhiHVqFxUbZ8uB78iVzTrGBzmd5fiOxFM/UF8swweCHp7c3g2RnFe2I4xoDveYctXW8kWSwwvcJoVqHCfqhYQS22Y+7EiLNAPqHVdBlq+Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(1800799012)(186009)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(26005)(16526019)(2616005)(1076003)(478600001)(7696005)(6666004)(47076005)(36860700001)(336012)(426003)(83380400001)(2906002)(44832011)(5660300002)(41300700001)(70206006)(70586007)(966005)(54906003)(8676002)(8936002)(4326008)(316002)(6916009)(356005)(82740400003)(81166007)(86362001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 19:49:47.2623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327b1121-136b-48cd-b98c-08dbf9b92a1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6237
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a lot of RAS topic to document, and there are a lot of details
for each topic.

Prep for this by adding an index for the RAS directory. This will
provide a top-level document and table of contents. It also provides the
option to build the RAS directory individually using "make SPHINXDIRS=".

Start a section on address translation. This will be expanded with
details for future translation methods and how they're used in the
kernel.

Move the error decoding topic to its own section. Links to other error
decoding kernel docs will be added.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lore.kernel.org/r/20231005173526.42831-2-yazen.ghannam@amd.com

v2->v3:
* New in v3.
* Move term glossary to Documentation.

v1->v2:
* N/A

 Documentation/RAS/address-translation.rst     | 24 +++++++++++++++++++
 .../RAS/{ras.rst => error-decoding.rst}       | 11 +++------
 Documentation/RAS/index.rst                   | 14 +++++++++++
 Documentation/index.rst                       |  2 +-
 MAINTAINERS                                   |  1 +
 5 files changed, 43 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/RAS/address-translation.rst
 rename Documentation/RAS/{ras.rst => error-decoding.rst} (73%)
 create mode 100644 Documentation/RAS/index.rst

diff --git a/Documentation/RAS/address-translation.rst b/Documentation/RAS/address-translation.rst
new file mode 100644
index 000000000000..4b62ab007fce
--- /dev/null
+++ b/Documentation/RAS/address-translation.rst
@@ -0,0 +1,24 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Address translation
+===================
+
+x86 AMD
+-------
+
+Zen-based AMD systems include a Data Fabric that manages the layout of
+physical memory. Devices attached to the Fabric, like memory controllers,
+I/O, etc., may not have a complete view of the system physical memory map.
+These devices may provide a "normalized", i.e. device physical, address
+when reporting memory errors. Normalized addresses must be translated to
+a system physical address for the kernel to action on the memory.
+
+AMD Address Translation Library (CONFIG_AMD_ATL) provides translation for
+this case.
+
+Glossary of acronyms used in address translation for Zen-based systems
+
+* CCM               = Cache Coherent Moderator
+* COD               = Cluster-on-Die
+* CS                = Coherent Station
+* DF                = Data Fabric
diff --git a/Documentation/RAS/ras.rst b/Documentation/RAS/error-decoding.rst
similarity index 73%
rename from Documentation/RAS/ras.rst
rename to Documentation/RAS/error-decoding.rst
index 2556b397cd27..26a72f3fe5de 100644
--- a/Documentation/RAS/ras.rst
+++ b/Documentation/RAS/error-decoding.rst
@@ -1,15 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-Reliability, Availability and Serviceability features
-=====================================================
-
-This documents different aspects of the RAS functionality present in the
-kernel.
-
 Error decoding
----------------
+==============
 
-* x86
+x86
+---
 
 Error decoding on AMD systems should be done using the rasdaemon tool:
 https://github.com/mchehab/rasdaemon/
diff --git a/Documentation/RAS/index.rst b/Documentation/RAS/index.rst
new file mode 100644
index 000000000000..2794c1816e90
--- /dev/null
+++ b/Documentation/RAS/index.rst
@@ -0,0 +1,14 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===========================================================
+Reliability, Availability and Serviceability (RAS) features
+===========================================================
+
+This documents different aspects of the RAS functionality present in the
+kernel.
+
+.. toctree::
+   :maxdepth: 2
+
+   error-decoding
+   address-translation
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 36e61783437c..07f2aa07f0fa 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -113,7 +113,7 @@ to ReStructured Text format, or are simply too old.
    :maxdepth: 1
 
    staging/index
-   RAS/ras
+   RAS/index
 
 
 Translations
diff --git a/MAINTAINERS b/MAINTAINERS
index b9b060917680..1e2d42cb7df3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18107,6 +18107,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
+F:	Documentation/RAS/
 F:	Documentation/admin-guide/ras.rst
 F:	drivers/ras/
 F:	include/linux/ras.h
-- 
2.34.1

