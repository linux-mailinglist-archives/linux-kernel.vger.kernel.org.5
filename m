Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B427CBC21
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjJQHTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjJQHTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:19:50 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDE58E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:19:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIAAqKLwSz263q0qkJIbfqR+8lDP7iXs070p9FQcCBPYMtkJxarnyoB8AO39XBapY6rbfMsspI0N0EyLA/FAo4syZyqffpZVoK0qLeZibmWh0mz2Oq1zwnKZ8pCXX15o7mp94XyAfhUV+XecN9lbeHXgQcJn9bzKDzNxNg2byVThGSg+41gZ+ctPGOLlOZEjCxwXdeSHFZxAyxs0urGg+ULUXDv+dOc4ToVrqHdsDenI4Y6d0XtRyj1JCvD+8/Sr1G1IB6UqP8e9eJzbqf+86Z07D9RsYs4ncSB+RKI7vwxReA+WHrG6oHMxPuiltBUs/hipphSzFtVpw5v/ImAy1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=svkU5QUkFCXMFWAll2A5RvxULrh7brssmtdr+gIlGFA=;
 b=Xafmr2QP2CifQs1TxYNKgdR/kBANOpq/hI9Yh+K7hN/TgbYgysq6AJbFRc246UkNI1e8MphTeXwnCfwgOxKnfAp07sxvTspAjTIKjjbGJS8i13TzZ9wGk7ikiTQIMGtWnagawoql29OPasXHk8gbcJNjJBoEpAiawsMNCwaXKEkK9AawjZOeGln7N8a/m4NVSxjM9Rq9T5xahLNi/068DcBfvXfXW8Gy9BCVh/NPk/Wpd/yn57yTE5IZwyT0OkfsR2gB59do11X3ZRuJh2A3nElZsdyNgslCUm2lzgjx/BQJeQQYZ91O2BziHF9nR492oVrwQ45DVyugKXTwBFVTLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=svkU5QUkFCXMFWAll2A5RvxULrh7brssmtdr+gIlGFA=;
 b=2cS7Nz/KXKlJ8POVnBhQRfWHRsB5HkSFA+2WVZ9wR/jccqp7NsZZ7z5g8HsTm9ta7R/D/M63GLVYyseSoB7pA2FOqR8F3n+ic4b5+EPScb41k2cFKv9mGS84ENtbTiqb32ey0Qb5Bru1731GTnxNySJcJBE3LKXwqf9FthiXd8Y=
Received: from SN6PR01CA0006.prod.exchangelabs.com (2603:10b6:805:b6::19) by
 PH7PR12MB7870.namprd12.prod.outlook.com (2603:10b6:510:27b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 07:19:46 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:805:b6:cafe::5) by SN6PR01CA0006.outlook.office365.com
 (2603:10b6:805:b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35 via Frontend
 Transport; Tue, 17 Oct 2023 07:19:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 07:19:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 02:19:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 02:19:43 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Tue, 17 Oct 2023 02:19:40 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: amd: ps: enable wake capability for acp pci driver
Date:   Tue, 17 Oct 2023 12:49:36 +0530
Message-ID: <20231017071939.953343-1-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|PH7PR12MB7870:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a50ce81-8dc3-4875-404a-08dbcee170f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7IVmJyShvuITw2z7U76BrN+/boeBL0trGS1e4sgnNfvOLkPut2Eelr6lpQphcNacN1BvP4IpcN+2uHm6Sd9qvwLGrXQtTgoTDUPGnSUi5A41GPgnIkvW5m8Z97iN4ctabPJTObtWwobgqwzL2aYAw5wdG99CKPylCsBDi1qUJwwr2B5bPakdjjT8zfY3VvWtZ/KcFRvSddLK4OH7QNmIYK9GnkStgB/7sxXo2wPyMzL40hWRucTw2a8n19YTze81apr5J7+q0KITRVmCXZGg+NwfaUT6qUneyfJsUWHOqPpNVySb1W/o+Wtske7RyBFsnfb2CAZ2PH6tlDFl3cq2Cl5nPQW3a0alrjLZqjTfVCMRov3tuDozpZLW6tdkEHF9dO4L7BfFufF2i/XtAf9SBJMTBpEOD3sX/VysxCj9v8/yBVunoUi8qNqclqjsPmhvxv7xqyCusDFVRjawOmDwm642bowXK6eIPdsrEms6en8XXOZNOijeKt3ddkXtQvWOJod0+ZVb7ZSI8ftqyZeORaZ4gM59JseIOBndDtQFIhPlVeZYTH2NP0un4ackVTj1vLljl1EaFI3Vh/Z7sc9ejch7BVfaRfDJrCWXC9B88J/hH+L1GAkcW/rekLtXlcLrnh/BThHDrPGa5/kz2rAWVo1iXv9U2y3NQVite6aMyohWMgDTKeZJE7ei2rOGPE8ow+mY8bNSpoUzbmMaCbnY9ibmPC8wewhUVbix1fhoX0MIBQTVjcBntPWVZ5xE+SpoaKgfesMB287VZ6Yo/6u2Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(36756003)(82740400003)(356005)(81166007)(36860700001)(47076005)(83380400001)(26005)(7696005)(2906002)(316002)(2616005)(1076003)(6916009)(70206006)(54906003)(70586007)(426003)(336012)(478600001)(4744005)(86362001)(41300700001)(6666004)(8936002)(8676002)(4326008)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 07:19:46.0582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a50ce81-8dc3-4875-404a-08dbcee170f6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7870
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable wake capability for acp pci driver for Pink Sardine
platform.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/amd/ps/pci-ps.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/ps/pci-ps.c b/sound/soc/amd/ps/pci-ps.c
index 7e4c0ec9e56c..5927eef04170 100644
--- a/sound/soc/amd/ps/pci-ps.c
+++ b/sound/soc/amd/ps/pci-ps.c
@@ -650,6 +650,7 @@ static int snd_acp63_probe(struct pci_dev *pci,
 		goto de_init;
 	}
 skip_pdev_creation:
+	device_set_wakeup_enable(&pci->dev, true);
 	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(&pci->dev);
 	pm_runtime_put_noidle(&pci->dev);
-- 
2.34.1

