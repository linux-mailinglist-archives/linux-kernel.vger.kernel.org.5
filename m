Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0EFC7E82A8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 20:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346138AbjKJT2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 14:28:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbjKJT2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 14:28:16 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBFE35782
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:52:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drjv/ZclZKRZIiPAkIbi8+dIU4lbnyWDsS0SPwRbrc9q7mqQ0puHCfbE0XOisBI6ppEhxXPifu3+vT0GzZZGfRD149nor2tpcKyopmtqQNO4HUerMyRpr+ovJ9NJBXRJiiHudvEDvy64T4MEcbgkZWthWF3vLkp1ElU9G0Hjp1dBzT0aIcTlmdWSD7J/vqldhPgSeKKq3YXKHrbF6lOIGuS6vpfjUNskxH1kDXYMpzqr0uhDTI4JJh9AFcWN8Xbb2kGxK/3Px7PNXAjDBZGIVx4jWbYioFFXALs/1ZJaaZYcaFotq/6cd8IY25XYyDnVB7u2SMPBB+B47D0CKHLBsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhbDhl9fGrAbJROG1/ANZa8jolGGLRUlU7HWkkoS6xo=;
 b=DwKIwJNIo505x+zYhG4KkcptVQZGbCj22MqM6sR2mNEt+TdZFM6pIgPAKSyGXOcfY7cBdeLsevISPhUiWPDLTGXuFCljOTW8V5GCibyDJ3zbmy8fE5vK45CVfUnURbQYgM80aKlrwGPb9FNa7SFDYbc/AKrwxpDoZefZ+Eq+SJhnbhehpD4VvYJac2+Gd2Ex9YwL+n6UGbgHrhONa+OEfixFQxKOAnKoDPeSvondF6yMy96YWCdWIsj1GIn7Kcl1FroXCBybgdD2YE021LKWv/msppHcWElU5PiTMM29H5GN6maIFIzKINI/WipDVNtUhQON8SebRbIByMDnb1hblg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhbDhl9fGrAbJROG1/ANZa8jolGGLRUlU7HWkkoS6xo=;
 b=aQszyRtSn4cOh5KUpLHMrjh9xy925i6UAldrUQTndHHWjdX7yRVxuFJZFr8OIB+E0/NfSTnDzzJxh7NeZcemeBne90P+Yg4huJ4QpY86Pmv0Nv4qxbgXcdZfG50cAVyt5THzYJsidYVxaDi/FGQDhK3sUv9Bai4KuToqxfSa4Xk=
Received: from PA7P264CA0020.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:2df::16)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19; Fri, 10 Nov
 2023 12:52:26 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10a6:102:2df:cafe::56) by PA7P264CA0020.outlook.office365.com
 (2603:10a6:102:2df::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.19 via Frontend
 Transport; Fri, 10 Nov 2023 12:52:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 12:52:24 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 06:52:23 -0600
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 10 Nov 2023 06:52:19 -0600
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <Richard.Gong@amd.com>, <posteuca@mutex.one>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] ASoC: amd: acp: add Kconfig options for acp7.0 based platform driver
Date:   Fri, 10 Nov 2023 18:22:09 +0530
Message-ID: <20231110125214.2127139-1-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: b57403de-e0e1-477e-3996-08dbe1ebe2eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kYSQwaYs/ZSAjQT40RhFi9Q9ImuaUqtaDG3uoTM8DzmOlOXVIVcYyj2VBj9ewDEF6kKHEubGWorBsTQpIe17ug7evjr0L33NDQdJGzsiT7ojQbFbXb/7POjGIEFxcvoUyLHezasXNY9fYKofFGCQZKCnLmXfqWMTsNhjfCXrUqtw/q8YB9n17nhDLcTdXb/KTiBlmMkuqONgF5Q+UJ+TDrrSXCK3eTzN7fr50j1U8GEdgm9c8tLR0ah4zJtZbLZvjO+SIPDiDUp2qsX/CeM1dfp/cE+XtH7Em1VQUAxW3d4ksgu+mS5UlJjy7v8ygsI0hPQ9rGGFEm7j8uq2S10ZxuQi7HV31CLDtqaAPRxSOT5D2Ty3BxufC5FI0UjUtXlwq4uazhsjoO1joCzoY9jB/qcyCPq4/QasAQWM2RT7mvqRmVtOx2Hj8v1S4YrqpPyTMYZg8pcgvm2OICBcqjWZRwm3TX0EbFWtkuzKIb89KZ5yFAYDlz2bwzNn09QIcX2IjZz6xrUl4uLDNRtpCn79rbCqfW1lIHuP80yZSmFKkqkulTbhYe0pnoKPo3T/knWys7Cll4RevN+s+zu7Byap7lb6qpfLP2tJYitzE0BO4+DK+BCayo//fpM9YmVY+FyvLVEFksUxKRvFE8++FCLFfKQtq+9JadeDz0FQw4WTUQjzU/cNmDUTILXJec2pJja9aKxf1c0RuT6yFR2pspUv0DP+9XtS2taAK4ckwXeTEfPii8vhqx4iogCzXCyPJQ+oJgxBo+7qA21uMsvGQH9Oqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(2616005)(5660300002)(7696005)(40480700001)(1076003)(26005)(40460700003)(41300700001)(6666004)(2906002)(336012)(426003)(70586007)(70206006)(81166007)(478600001)(356005)(86362001)(110136005)(36756003)(54906003)(316002)(8676002)(4326008)(8936002)(36860700001)(82740400003)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 12:52:24.3062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b57403de-e0e1-477e-3996-08dbe1ebe2eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ACP7.0 based platform legacy drivers can be built by selecting
necessary kernel config option. This patch enables build support
of the same.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/Kconfig  | 12 ++++++++++++
 sound/soc/amd/acp/Makefile |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
index 5fb322212938..c8ac0027f741 100644
--- a/sound/soc/amd/acp/Kconfig
+++ b/sound/soc/amd/acp/Kconfig
@@ -73,6 +73,18 @@ config SND_AMD_ASOC_ACP63
 	  Say Y if you want to enable AUDIO on ACP6.3
 	  If unsure select "N".
 
+config SND_AMD_ASOC_ACP70
+	tristate "AMD ACP ASOC Acp7.0 Support"
+	depends on X86 && PCI
+	depends on ACPI
+	select SND_SOC_AMD_ACP_PCM
+	select SND_SOC_AMD_ACP_I2S
+	select SND_SOC_AMD_ACP_PDM
+	help
+	This option enables Acp7.0 PDM support on AMD platform.
+	Say Y if you want to enable AUDIO on ACP7.0
+          If unsure select "N".
+
 config SND_SOC_AMD_MACH_COMMON
 	tristate
 	depends on X86 && PCI && I2C
diff --git a/sound/soc/amd/acp/Makefile b/sound/soc/amd/acp/Makefile
index dd85700f1c5f..ff5f7893b81e 100644
--- a/sound/soc/amd/acp/Makefile
+++ b/sound/soc/amd/acp/Makefile
@@ -15,6 +15,7 @@ snd-acp-pci-objs     := acp-pci.o
 snd-acp-renoir-objs     := acp-renoir.o
 snd-acp-rembrandt-objs  := acp-rembrandt.o
 snd-acp63-objs := acp63.o
+snd-acp70-objs := acp70.o
 
 #machine specific driver
 snd-acp-mach-objs     := acp-mach-common.o
@@ -30,6 +31,7 @@ obj-$(CONFIG_SND_SOC_AMD_ACP_PCI) += snd-acp-pci.o
 obj-$(CONFIG_SND_AMD_ASOC_RENOIR) += snd-acp-renoir.o
 obj-$(CONFIG_SND_AMD_ASOC_REMBRANDT) += snd-acp-rembrandt.o
 obj-$(CONFIG_SND_AMD_ASOC_ACP63) += snd-acp63.o
+obj-$(CONFIG_SND_AMD_ASOC_ACP70) += snd-acp70.o
 
 obj-$(CONFIG_SND_SOC_AMD_MACH_COMMON) += snd-acp-mach.o
 obj-$(CONFIG_SND_SOC_AMD_LEGACY_MACH) += snd-acp-legacy-mach.o
-- 
2.25.1

