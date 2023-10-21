Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C1F7D1D9F
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbjJUOwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjJUOwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:52:34 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA4A10CC
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:52:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSFuqHFBSOZNkrGsUe/l+I1m1HnhDEIfC7Gbft+534VNpWE8RlroyiOgj9NxkR8ZixlIKy9Uc9zY7+ggwa/qy/T6qZMxBhmagFfbhZAafQ6/rvVsb2yRGpap2PAIyqJ/B2tEY6ikvlYaaUzbdxckRptoChmm2PT2RYkVIxpZZZSoZ//t+vQjhoN73lFRKm+B4clhYAJc1eh2WnY1ES4tTc3t8cqMqp8ZRJ+ELjK/NVSz08HIlpiwOfuHKjqA22ag9wS6ylK6UDVbKBrIdm2+WGC4idjDUtzPkIw6VsV9Njn2HF16lM/tsAHkU4JEpK2AkkarUhg1+kfs68W9lMzTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZH8rugi7wUfF1GJF+mFMINCAm702SP9QIoZUlrbiypE=;
 b=Ftnpwcc6gNJasahnSRjvTiP1s5FZBIGpSh95p0pIXDjlTb8o4IpAJIP4kskwHzyMLn7Saa6I/ajqsJEDqH+lEy5EjIvSSFaqiJHTLBKBUSJGG0wI3S6zqDWvkZtaB3XliN2Tk3yNmEwl6wnyChTu3279ouSJQ6mG5ZkaYNDEym7H4lDYB5bfZBS+9n7hJd5gsirNQXWm8TlwGN3cc8MkWq0aANJdGDLCWSQNJHLwqzX1tdnL+DLhAhDYcAWhYxgF22zp/iDKNo8JiFwHDhgTM/DgdwcEBUtZvTP3PkEScOVDJLY99UNpythZpvUwsu4Iz9Qsv2Jgg/7Zs3EboykACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZH8rugi7wUfF1GJF+mFMINCAm702SP9QIoZUlrbiypE=;
 b=QcL8a76IS5aXT2emHDmNW+IHpnhcf36F6legh2xv4ZPPPJJym60g8TuUdi3dFsmaxWIwnt2fHCPYyswMtwi2srMyuVOo33A1GCxdoXYMjm4BsCmz8xWZft/OC7I50Q2vQ7gc6ji/V0SLwS/vE132vSoJDzKWbeJdb8HY7ZOUGiE=
Received: from CH0PR03CA0402.namprd03.prod.outlook.com (2603:10b6:610:11b::23)
 by IA0PR12MB7625.namprd12.prod.outlook.com (2603:10b6:208:439::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Sat, 21 Oct
 2023 14:52:20 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::cc) by CH0PR03CA0402.outlook.office365.com
 (2603:10b6:610:11b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29 via Frontend
 Transport; Sat, 21 Oct 2023 14:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Sat, 21 Oct 2023 14:52:19 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:52:19 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:52:13 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Yang Li <yang.lee@linux.alibaba.com>,
        "Dan Carpenter" <dan.carpenter@linaro.org>,
        Marian Postevca <posteuca@mutex.one>,
        "V Sujith Kumar Reddy" <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/13] ASoC: amd: acp: add platform and flag data to acp data structure
Date:   Sat, 21 Oct 2023 20:20:48 +0530
Message-ID: <20231021145110.478744-7-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|IA0PR12MB7625:EE_
X-MS-Office365-Filtering-Correlation-Id: 75f554b9-e331-467a-9b43-08dbd2455380
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlYDVOKeiPNPFz9e8yGD42/oahjwuFpc6E+ERbYAJ3k/WEmIyN5Slt+zkE5vnJrYnhSrMbeMRhquC0KPNuDVbfJqrEXnM7QtG6Txpc8LL5pKeIje29r5n+d4NF00WLrNSue2iUgFwyOtNiz4T7bYbERdaV95JFBB1Wnaz6f4TFl88vYNyrFG+XyTHpMPHJl6uweg0bbbkqNgKEeTDupid1dYOqK6QC5Yvw2CR7moILGAOqdRonC9tyROj9xrSa5p1fU56v8n0heVwSnj9yF1xGnVmZ4GqoPLddvXWT+wQpZSabqSoHQ5TY/fvNWEmwRa+ZIFERtFnuElQeN1iCFKNfPcBx2KygGPPf8XZMdZPOM90wirEaWvqSzmeyX4gLYLvzxWarAuoD6YA4mPWquXsyMYUPJNY5ETq5VBtWPCPGLbb/Chq/b0qaugtfDVq5m+wIuH+UvvHhvQ1hVH9PsGIQ1ZgqjtL/oeS1p+ccAXCEQSOWZAOniVhoFcMs63alx6IkRu7JwkLFJ4sxB8H75WSw5S3fsbWkziY25gHVeqoQejw6cTnOZNlXEeSx38kz7+mEpEgwnbPbLijexDeKiquuUdjsxfv3VCW8Gfohu0LR1jaS4ue9DBvqCoagHNPwivzROZvzz/l8yzJ6Ii9wb8fcmL/q7DnTUvO+UzRng//bg97qnFacCL/eCMLL48FqibZv6Q6HVsKzpaEazkHB4xjqFT0gdIeL/pPHvRf//KRWjGHUIUTrUu9CVFMhkAjcY8PztscLeMKPdR9ANaeiEN3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(1800799009)(451199024)(82310400011)(186009)(64100799003)(40470700004)(46966006)(36840700001)(2616005)(8676002)(4326008)(8936002)(40480700001)(478600001)(40460700003)(7416002)(86362001)(426003)(356005)(26005)(7696005)(2906002)(36756003)(6666004)(41300700001)(47076005)(336012)(1076003)(81166007)(83380400001)(82740400003)(36860700001)(5660300002)(70206006)(54906003)(70586007)(316002)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:52:19.7789
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75f554b9-e331-467a-9b43-08dbd2455380
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7625
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add name of the platform and flag data in private data structure.
name of the platform will be used to differentiate platforms where as
flag will be used to know what kind of endpoint configuration is selected
where its legacy(I2S + PDM) or only ACP PDM.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-rembrandt.c | 5 ++++-
 sound/soc/amd/acp/acp-renoir.c    | 3 +++
 sound/soc/amd/acp/acp63.c         | 4 ++++
 sound/soc/amd/acp/amd.h           | 2 ++
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-rembrandt.c b/sound/soc/amd/acp/acp-rembrandt.c
index 1bf7b2e68a11..ef5fe6438efd 100644
--- a/sound/soc/amd/acp/acp-rembrandt.c
+++ b/sound/soc/amd/acp/acp-rembrandt.c
@@ -23,6 +23,8 @@
 #include <linux/pm_runtime.h>
 
 #include "amd.h"
+#include "../mach-config.h"
+#include "acp-mach.h"
 
 #define DRV_NAME "acp_asoc_rembrandt"
 
@@ -226,7 +228,8 @@ static int rembrandt_audio_probe(struct platform_device *pdev)
 	adata->dai_driver = acp_rmb_dai;
 	adata->num_dai = ARRAY_SIZE(acp_rmb_dai);
 	adata->rsrc = &rsrc;
-
+	adata->platform = REMBRANDT;
+	adata->flag = chip->flag;
 	adata->machines = snd_soc_acpi_amd_rmb_acp_machines;
 	acp_machine_select(adata);
 
diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index b15cbdf7fa9b..a591482a0726 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -22,6 +22,7 @@
 #include <linux/dma-mapping.h>
 
 #include "amd.h"
+#include "acp-mach.h"
 
 #define DRV_NAME "acp_asoc_renoir"
 
@@ -185,6 +186,8 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	adata->dai_driver = acp_renoir_dai;
 	adata->num_dai = ARRAY_SIZE(acp_renoir_dai);
 	adata->rsrc = &rsrc;
+	adata->platform = RENOIR;
+	adata->flag = chip->flag;
 
 	adata->machines = snd_soc_acpi_amd_acp_machines;
 	acp_machine_select(adata);
diff --git a/sound/soc/amd/acp/acp63.c b/sound/soc/amd/acp/acp63.c
index f94348ad863d..0cec6ecaadfa 100644
--- a/sound/soc/amd/acp/acp63.c
+++ b/sound/soc/amd/acp/acp63.c
@@ -21,6 +21,8 @@
 #include <linux/pm_runtime.h>
 #include <linux/pci.h>
 #include "amd.h"
+#include "acp-mach.h"
+#include "../mach-config.h"
 
 #define DRV_NAME "acp_asoc_acp63"
 
@@ -237,6 +239,8 @@ static int acp63_audio_probe(struct platform_device *pdev)
 	adata->dai_driver = acp63_dai;
 	adata->num_dai = ARRAY_SIZE(acp63_dai);
 	adata->rsrc = &rsrc;
+	adata->platform = ACP63;
+	adata->flag = chip->flag;
 	adata->machines = snd_soc_acpi_amd_acp63_acp_machines;
 	acp_machine_select(adata);
 	dev_set_drvdata(dev, adata);
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 2ffe1effc6b5..62d0793027f2 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -187,6 +187,8 @@ struct acp_dev_data {
 	u32 tdm_rx_fmt[3];
 	u32 xfer_tx_resolution[3];
 	u32 xfer_rx_resolution[3];
+	unsigned int flag;
+	unsigned int platform;
 };
 
 enum acp_config {
-- 
2.25.1

