Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31CF4752575
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjGMOsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjGMOsq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:48:46 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845DE19A6;
        Thu, 13 Jul 2023 07:48:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HEwxvsSANxnHyepr+pbpPMVSEwOHshLMLfL2Q41H2b72kerp830kCTXMrQLFKlXEs8Zef64m+gH6yUD6t69lzcnu74eWtlT7RezlwuK7zH0TaOSVvoX59YhzjReA+LPeZp5Qt49dO6bBSvhWuZwuSFBToFTXXJ9qLHdt6wLaDd+w+Yz+Bkm9QOTgqWG7lDnKMZk7v2oO0rrzjj9VzFctcwFs2tKpTjs6hEn/DXDrksx/2xqSCOVqXtBkaZ11qOuujBWh9HSqhZQETYmWHrczjwgRJjXv5rYjX5XKDZ9KMXCeBsspqW8wCmcHYV7RpSywvMyBAW30HWmlEjDyA9Emjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3o08JJ2NLz/Fgw25/v/+sKZF2ePY1JWNSfOdLKgsvo=;
 b=kWIOrueqAdL04p6iJklBCV/ipBjd9+8MdQLv3/yeKuJf/5w2BpCmiVCHZeKR24TJpy56XGNGDwGrPAMwjpuaqH2SQbZJUMNcnJbSquTakGPdvGOFiM+XaIjv8bakrdHCLAnHRSlZnRki/sTvciWFgx5FUiDVJymr6HeB//Ulg/oUDx+REvV6Jev/LumKCELOFTZFq2+2+cif5JArnHOcTBecc4k8HieRQ4iyRsy8JBHBPVkSqjbkJye+7IL0gznwQWrbzqwANPPqevaK5J1IsPNjjMAegTUx55OvpmjX+RkM8jUus+PtTRCkzUqh+FeXaneCTPaSfFSXHfjxhcs3kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=redhat.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3o08JJ2NLz/Fgw25/v/+sKZF2ePY1JWNSfOdLKgsvo=;
 b=PKtbDbpyFuUHuP/J7NbNEhtJDtbnWeq362ej92JuiLkE0TwQicY5mIWGemynGIXIcBLHbOPnqyfzQZAMM54RYE4i7Fd1UZ2dkUTaYw8qQoT5Z2rKbB8srxkeY+1Dy3C1FdaP0Jz4EkYHEj+dNeZRvlhW20PeUhv6/0ShbKWwWh2VDV4QTEcaHguTbVf+adqmu/2mmKIZIUQ/BcnvRDQRuVWtWKRhLaz9q5/cwRUgz4c+xxCmJK1WQt6JoBoPxSYlIxuJfsU1HWmUv7I/6+GYZL+z9ZXlTG7RX1vFh0bWIyvHqnFgtCgyMDy5OeJHTojuk938qkbTz5hT20TObIMr0Q==
Received: from FR3P281CA0166.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a0::9) by
 AS8PR10MB6868.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b5::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.24; Thu, 13 Jul 2023 14:48:43 +0000
Received: from VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a0:cafe::5b) by FR3P281CA0166.outlook.office365.com
 (2603:10a6:d10:a0::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.8 via Frontend
 Transport; Thu, 13 Jul 2023 14:48:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 VE1EUR01FT073.mail.protection.outlook.com (10.152.3.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.25 via Frontend Transport; Thu, 13 Jul 2023 14:48:43 +0000
Received: from DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Thu, 13 Jul 2023 16:48:42 +0200
Received: from md1za8fc.ppmd.siemens.net (139.25.69.128) by
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 13 Jul 2023 16:48:42 +0200
From:   Henning Schild <henning.schild@siemens.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Tobias Schaffner <tobias.schaffner@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Henning Schild <henning.schild@siemens.com>
Subject: [PATCH v2 1/3] platform/x86: simatic-ipc: add another model
Date:   Thu, 13 Jul 2023 16:48:30 +0200
Message-ID: <20230713144832.26473-2-henning.schild@siemens.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713144832.26473-1-henning.schild@siemens.com>
References: <20230713144832.26473-1-henning.schild@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.25.69.128]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC8WAA.ad011.siemens.net (139.25.226.104)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT073:EE_|AS8PR10MB6868:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c5ccae2-e525-4807-5075-08db83b040fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DcFUQjI/KgB5V264/vVx9X9mtPuxbmHXTgauX0y8TdreZDKVl1EFehZKRL9WlT46vY6WXc+4gU2ari8ldJSuMKJaSGZri8eZ1U46aYdY1D2dYsVNLn4QcZrWNFVd/aaXFe88FlQygb0sn8HwEEHixRQL5ArLdKJZyqjqPGo1cTRyLt650XVQHaVm3VZndpCOfjUss5D+P0OEm11C31F8YRAf05SyGeAaKM1oR3d3rK41yW0MQYHhRREkPKA//JeD3WeTm9osZRoz+DvQcENmKs64WW1ta+ZaSrrYHK2jc4w1Jc387SJWP9p7JTm167IrmXYnINHNyG/pgrbCeOfii8Hqb+PRrl07+k56OHbNYUuU2ZFoqJpfmp0T5IxF1twbrYdxBs50BIGZHfcNjTSPSe7ZDz8WBC5xI+UL60A1vAlpl9lBm0eaSdgpYqTd5hnRN5Rd1IzJJRdtfqy1/fvZsdKPo2MzyyWjTGSEwtnB8jqjJCnfvBAAA8HnSb8jpooH9Wyq/p1k9gJLpw0OwlwTYgf4G8XXTtL7OvTgG8PcNqph/eqSHrmosVZzaur6fFQvNJUb0qOD2Vj639nLJgZPRB6f+nS0AtqLJmHXeu+M0jAL2TzjRCVBHDHYkeY+ezPGf7reapm4J88G61SYfMrWSisxhdVjuG86ug2ZSC99EOMO+zguDvCBBr6GuhThutRS6WOg7zcbbSQf4YYzSAIiHxrsKgv0G4rUcBik60wz4RmYvBcYiLCGJQMWEh9OGSqhshHCYZQvvlJMXMJEM83+g==
X-Forefront-Antispam-Report: CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(107886003)(40460700003)(8676002)(8936002)(36860700001)(47076005)(2906002)(2616005)(956004)(82740400003)(356005)(82960400001)(36756003)(81166007)(86362001)(82310400005)(40480700001)(26005)(5660300002)(44832011)(1076003)(186003)(336012)(16526019)(4326008)(70206006)(70586007)(110136005)(54906003)(6666004)(41300700001)(478600001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 14:48:43.0323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c5ccae2-e525-4807-5075-08db83b040fe
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR01FT073.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6868
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the panel variant of a device we already did have. All the same,
just no LEDs.

Signed-off-by: Henning Schild <henning.schild@siemens.com>
---
 drivers/platform/x86/simatic-ipc.c            | 2 ++
 include/linux/platform_data/x86/simatic-ipc.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/platform/x86/simatic-ipc.c b/drivers/platform/x86/simatic-ipc.c
index 6d2c94c17414..71487216d33f 100644
--- a/drivers/platform/x86/simatic-ipc.c
+++ b/drivers/platform/x86/simatic-ipc.c
@@ -48,6 +48,8 @@ static struct {
 		SIMATIC_IPC_DEVICE_427E, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
 	{SIMATIC_IPC_IPC227G,
 		SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
+	{SIMATIC_IPC_IPC277G,
+		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227G, SIMATIC_IPC_DEVICE_227G},
 	{SIMATIC_IPC_IPC277E,
 		SIMATIC_IPC_DEVICE_NONE, SIMATIC_IPC_DEVICE_227E, SIMATIC_IPC_DEVICE_227E},
 	{SIMATIC_IPC_IPC427D,
diff --git a/include/linux/platform_data/x86/simatic-ipc.h b/include/linux/platform_data/x86/simatic-ipc.h
index 1a8e4c1099e3..f2eafa43a605 100644
--- a/include/linux/platform_data/x86/simatic-ipc.h
+++ b/include/linux/platform_data/x86/simatic-ipc.h
@@ -32,6 +32,7 @@ enum simatic_ipc_station_ids {
 	SIMATIC_IPC_IPC477E = 0x00000A02,
 	SIMATIC_IPC_IPC127E = 0x00000D01,
 	SIMATIC_IPC_IPC227G = 0x00000F01,
+	SIMATIC_IPC_IPC277G = 0x00000F02,
 	SIMATIC_IPC_IPCBX_39A = 0x00001001,
 	SIMATIC_IPC_IPCPX_39A = 0x00001002,
 	SIMATIC_IPC_IPCBX_21A = 0x00001101,
-- 
2.41.0

