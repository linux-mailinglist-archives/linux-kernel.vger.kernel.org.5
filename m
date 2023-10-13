Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E85A7C8DA2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 21:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjJMTRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 15:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjJMTRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 15:17:20 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA43DA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 12:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNwbYPQZqbVAl9cfcWsarwVDyd1OSuIRDhbFaLuP80dfhhBQY1/6+HEEMxWESuhF7NmdIgrccxkYA38+43jSr/1AM0aqp6iyBQlxdgPQy/44x1EZrIZ8k3UXmBIbzawler3o0qr2cI5P7F+MWetkyhbZTUDvXcmXbWjoF/22e77sk4Ha+Vov7Hls+s295ApYlR3tIges6xflGrZC7TG2TIJCt7bTfgVc9bxupcETjQOWcRwP6lWGAZHvUNtGTUR6UNoo5rBQ6LN2FLLLLuMEXT22tqV7oOiZNzqg694aCHZt98ozFF05/TxJt5kFtA9MzZVb5BldEpxjbaUEXqWeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjWhudPDWvAvzA/rySwfixGz4bMwX7zc9UflUYJrzUM=;
 b=PdiEjQwNEfGIxxCRD2Komfbk/qJibEB7McaGa1FKBf65YKxNazRBMcdBmHZK4OzaYC77HApbM3UCcG133G5jZixwVg51r6XxE7Cj3N65nDxuxIw7I0Zv63iUFSwyx4ObHEVXoR8PWmJcMmhbeXSdoYGz0RZHPQZT0539D2gGmYEn91U9Yy/6i/jJ4mRfP85Mf7vHvp0zpBdgf4L0ioyYyblc8+Tzj5Q7Fd/SCP2vyD+wElGi+7jwp0bhXKQyHWb1vzdCceICFfuk4uKzppoBA/oFBZmg80BVnZQOqh4JJ0IyZNRuem6GFNv253HvtUjP+LMGFCEk3CzpL/MTYAZeWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjWhudPDWvAvzA/rySwfixGz4bMwX7zc9UflUYJrzUM=;
 b=Jdug3iCWKIm09mujvMuDYXUYhQNIhZCaFNyYl799Fm1B2tPy5N3swGAB05V0G8bEyoxW6D/I+EouMWFeq7d7xzzi3HQpdOJ09JACDnvdakWM/iDUkr29Td5H1qv2KeTsi0D8BFkN2+XmMtwrmWBFqNrtLR338ee+Sk3T2ReNb4E=
Received: from DM6PR05CA0064.namprd05.prod.outlook.com (2603:10b6:5:335::33)
 by IA0PR12MB8325.namprd12.prod.outlook.com (2603:10b6:208:407::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 19:17:16 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::b4) by DM6PR05CA0064.outlook.office365.com
 (2603:10b6:5:335::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 19:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 19:17:15 +0000
Received: from ashkalraubuntuserver.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 13 Oct 2023 14:17:14 -0500
From:   Ashish Kalra <Ashish.Kalra@amd.com>
To:     <dave.hansen@linux.intel.com>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <x86@kernel.org>, <hpa@zytor.com>, <thomas.lendacky@amd.com>,
        <linux-kernel@vger.kernel.org>, <peterz@infradead.org>
Subject: [PATCH] x86/mm: fix pg_level_to_pfn for 5-level paging mode.
Date:   Fri, 13 Oct 2023 19:17:03 +0000
Message-ID: <20231013191703.422085-1-Ashish.Kalra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|IA0PR12MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ec05fb3-7eaf-428c-2163-08dbcc21030f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0K/3vmSJBnPDFvrMn1uc+Psg7gg8f9VmdijaIQRpVO764qNU9mWWhNy3ICuq1183NLQa0+IdUtz/bVwbDEPuZSOZwOs+a1jElURrK3F8Qwv4Pdc47wO78J9R7lWhA0PeJ/YBUdZnaGkPUVdf/2pPRKPFLUrP0i7CU3gBVEh+PdX5yRVbOQEA5k6wUGH8twPwn5bSFtovmE+4oVJ6lgdwMHMn/XRhe7Nq++GQbqrLX5mRYaa4cZv0V3XHabSa9ClH+jt2PTFKujt1UQTDNhrL8PoB2+kyJIg4h5OsS/4PYeii6yQolGPvB9+HLuRQKT7qfdMmDik7Bre1FTcw+dvZYUaPXBoVQ+jBuoWKemAUE/BLkgoGjhsC1J1AQIBVhq/fkW3hK5e1nVMp2hDru0A6af3ROeaqOf1BLyG/6T2ZHqRAc4NoKCMnGrINCBB//w7o1yVaS0XhUtdRvdN3bkgtOm66gFXXsJcSCCxIkz5anqhYmZbY+4rEghpMTAQF0epmyZ8JDJ+9teK+VXw2S3DDDWYatnkEwNxvGuYa73TG3w+Jp4cRRUVpO2cRchH+rfD4gbFy06Yenc3nlpLf8d5LBOMrsRONO5rUJz+JX18va7wHFzuRr/QznnkJnNhyGn5g8xpPwAmlakCIpklQLLYgiTnfMko6JtOS0NK7UzmxURq2Rpy/SH5L+UnBV0Cb1lwyWmetNyRFAU2p1NHHceRoncMS25FGUfScOn6l9R0ur1WFQzqKuxbVKkQAiGj1l5xxrZUu6FqgnnQyXbrlzMFk0Z7oDUQ7v6fQvvBnjo950w=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(451199024)(186009)(1800799009)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(2616005)(26005)(6666004)(7696005)(81166007)(82740400003)(356005)(921005)(86362001)(36756003)(36860700001)(16526019)(336012)(426003)(47076005)(40480700001)(110136005)(316002)(70206006)(70586007)(2906002)(4744005)(8936002)(5660300002)(41300700001)(8676002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 19:17:15.9586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ec05fb3-7eaf-428c-2163-08dbcc21030f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8325
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ashish Kalra <ashish.kalra@amd.com>

Add support for 5-level paging in pg_level_to_pfn().

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/mm/mem_encrypt_amd.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/mm/mem_encrypt_amd.c b/arch/x86/mm/mem_encrypt_amd.c
index 6faea41e99b6..45914568596a 100644
--- a/arch/x86/mm/mem_encrypt_amd.c
+++ b/arch/x86/mm/mem_encrypt_amd.c
@@ -267,6 +267,10 @@ static unsigned long pg_level_to_pfn(int level, pte_t *kpte, pgprot_t *ret_prot)
 		pfn = pud_pfn(*(pud_t *)kpte);
 		prot = pud_pgprot(*(pud_t *)kpte);
 		break;
+	case PG_LEVEL_512G:
+		pfn = p4d_pfn(*(p4d_t *)kpte);
+		prot = p4d_pgprot(*(p4d_t *)kpte);
+		break;
 	default:
 		WARN_ONCE(1, "Invalid level for kpte\n");
 		return 0;
-- 
2.25.1

