Return-Path: <linux-kernel+bounces-34701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7B583864E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FC4F1F24282
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 04:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BAF9290F;
	Tue, 23 Jan 2024 04:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ak1b4y88"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2053.outbound.protection.outlook.com [40.107.212.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E301C3E;
	Tue, 23 Jan 2024 04:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705983349; cv=fail; b=LQzEbFzJykmmvytkfq3gyo3RYiakuVgiQlLxnYC1QDk5NFvtt6eReLmQc3ubR1osP0TZgUdI625ZtyFFhsB1i4VoTOYLmJNuHrbToh1mRToFXkbrJmHDmhgGrwsvngUfw657bBSDiUpU64P02EIWk199/9bzwMh7PsZUrGeJ1fM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705983349; c=relaxed/simple;
	bh=TIwImqYC+8h+ymtsr6+FNbOVGlUOTVz+Qb2aLJJBakY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snBkE373aeG0o294Gx0x+Y5E8QtjRdbmNsWTFfn4zT8w0Z3is/FT4SGkjpnQUSya/oVAGvOm4qyolAVjIFogPO3sGUgTaVgl/oKeGkkAOnb9TiibJuSIEYshXT+7zsd9Ela2pAGaoEx6GgDSF9PWV/3KH3T3Wmg/Ke/axO1nIbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ak1b4y88; arc=fail smtp.client-ip=40.107.212.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iuf1yydzKqNIH4aAlHY3X/PdHUN5FotZ3GS7/6onnTnYarb0mXzENRtmE+Q0k4A9jaW9IL06+vRY3u+FLPnY4gNX/smfBfdIW7N9JGe9yRY3Xm0ocQm/7TidjmWnF7EXk5bZxFWt9c1NC1xZ0aWGWbH45QfwKtHdZN2NVvys9C8TVbdsFXVFhprEL7xi7tIP262/l3Zgyoal0p25RNQUStWw7Wn7bhQsiSB4PNcnQ9qXtP0Y+tC6d7KEl/ya1lb0Gv+G6DIZE7EHcJXM16wv0PIx5eXc7bDx5s3SklIDFmGLHdetVECJDQmNuiVmbVud0ahrdw8tzryQkHUlRi9Axg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eg0dZ7Pa3Twz+SKfEqDQoD657HboRsRoiiTsPgerPAo=;
 b=LN7QVnqF1hn6zkuGqwNoSqpAIkns3mQ3D4HUDVYNatsCxHhQBlvhGfBUMqb5eMxDzCa5FaIFokhZqbtbH+L6l72w3rvLS+fF0wK4GPPt++pgAxqNbFM3eyGFS+02uyqS+eewBuoxI5YWONdo7vupWniOyF2c0Jmzqbw1w75m8cl9Kf4Fj5i5p+zaA5b2wDp7i9ueWr29flHW+IuikFJVpFwbwjhDYG14c+ysOmSAmh5FtkUOFg9QmHUUlfD300x1CHZS84fIZGyt525MXZXieEEDvLqJO29XfkSz+KwMQwnUbhu34QUy0f7seOOfuEyWs8+wAWbSzloI6eO6FbySdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eg0dZ7Pa3Twz+SKfEqDQoD657HboRsRoiiTsPgerPAo=;
 b=ak1b4y88M+WytBs1alYr0wP6zpeEBayJuG3RKaiw9idJFyssLNPksDq7dnMYcc9WO8mOch8/lOJu9qbMHI3n9KaLm6i4i3TqwS1f//xVfaIX4XS9Oa714TbiDlKBWOZxxr2/HiD1MH/wAyUzPLu9laHnpaByXsYPyiqDJLwdnjQ=
Received: from MW2PR16CA0019.namprd16.prod.outlook.com (2603:10b6:907::32) by
 MN2PR12MB4317.namprd12.prod.outlook.com (2603:10b6:208:1d0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 04:15:43 +0000
Received: from CO1PEPF000044F2.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::b4) by MW2PR16CA0019.outlook.office365.com
 (2603:10b6:907::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.33 via Frontend
 Transport; Tue, 23 Jan 2024 04:15:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F2.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 23 Jan 2024 04:15:42 +0000
Received: from quartz-7b1chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 22 Jan
 2024 22:15:40 -0600
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: <bp@alien8.de>, <linux-edac@vger.kernel.org>, <tony.luck@intel.com>
CC: <linux-kernel@vger.kernel.org>, <avadhut.naik@amd.com>,
	<john.allen@amd.com>, <muralidhara.mk@amd.com>, <william.roche@oracle.com>,
	<corbet@lwn.net>, <linux-doc@vger.kernel.org>,
	<christophe.jaillet@wanadoo.fr>, Yazen Ghannam <yazen.ghannam@amd.com>
Subject: [PATCH v5 3/3] Documentation: RAS: Add index and address translation section
Date: Mon, 22 Jan 2024 22:14:01 -0600
Message-ID: <20240123041401.79812-4-yazen.ghannam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240123041401.79812-1-yazen.ghannam@amd.com>
References: <20240123041401.79812-1-yazen.ghannam@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F2:EE_|MN2PR12MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: 478f45d8-4745-49a5-44d5-08dc1bc9f6fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	apu9ZF95PB1ylKWVn+M/8tkYGrgkOKPeDXlkyag/9P9/j+3g3gGpslrZnUQVkiUx5CP9XdvR4PKIPL16sNYTKhjy2uUIJBg7FVk5HOD12ZIZdy68cGxxZHcUHILseqcfQ7hhOXmnO44AlthdMRL2o+j/zc/3v/aOSG5OjJo8iU6eNLy49/VKt3h1CcK70C9/mcV/jHfbh+N5+FWIy0zgyuEc45qfQou6iPgFjMOdNEgSalZbB9JlQ0AG2YxDKzal28tOHxg5iR3RIjWZeBHWxpQGjN9URUXp3M/srnomG+WxT1yGELSqW4vrlGtujMtFQd+uO5606YvnzOPOD6O9ucuA4a3CBD+PHaV2WakgcIIyOAwihctsQdfJPOvTsyd809wR8UxpZ1K6ZyXFuNAZTsqylXl6j2k2t/m0qp+tNSpUMON5bQsgGFPoy6QoG2K91mQN01UmicELSbReKRqUvcDNGEQ9EQ2S0S7fMMlFVEr6YimAx26MunFQyenFdckBt9ByfFodypfztM2CPraEfVd97gBhpMiUM7FXED8OUhlkGMiVESGbZm5KpU4ehfISvMJCswpMPmVxPva+OZkSrFWplRLWFZcp6jI575foLIVw5lNj+9jJ4XHcharbur6mEXGiHUwHAL3dL1fpUz4JeE+TFWH2h+oWc+0QHd+ViFhseSgIQhFmB2T02p/rCF64Sa6Sa0Sq+Dx+X6+t4DWt0VSNqLTy1tmYseXK/FYfcyJgwu6UbFk1RDgFz8R0XCkexNgD8HyXEvuyqudEr5oAtl1Vd1aZx9v3u7Qrthcr3Cs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(6666004)(426003)(86362001)(81166007)(70206006)(54906003)(316002)(70586007)(2616005)(356005)(110136005)(41300700001)(36756003)(336012)(7696005)(44832011)(5660300002)(47076005)(8936002)(8676002)(4326008)(83380400001)(82740400003)(1076003)(16526019)(26005)(2906002)(36860700001)(478600001)(40480700001)(40460700003)(966005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 04:15:42.4244
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 478f45d8-4745-49a5-44d5-08dc1bc9f6fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4317

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
https://lore.kernel.org/r/20231218190406.27479-4-yazen.ghannam@amd.com

v4->v5:
* No changes.

v3->v4:
* Replace "CS" with "COH_ST" in glossary.

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
index 000000000000..f0ca17b43cd3
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
+* COH_ST            = Coherent Station
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
index 25537a37338e..5b945fd5a3b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18359,6 +18359,7 @@ M:	Tony Luck <tony.luck@intel.com>
 M:	Borislav Petkov <bp@alien8.de>
 L:	linux-edac@vger.kernel.org
 S:	Maintained
+F:	Documentation/RAS/
 F:	Documentation/admin-guide/ras.rst
 F:	drivers/ras/
 F:	include/linux/ras.h
-- 
2.34.1


