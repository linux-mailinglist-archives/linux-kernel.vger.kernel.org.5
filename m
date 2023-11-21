Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E557F2612
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbjKUHFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjKUHFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:05:21 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A49CBC;
        Mon, 20 Nov 2023 23:05:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh9socSdin742ZggBlvIt1ikPUzZq2jR7IiUZ/kCoGapPxYlyQl6KkwL3Al6OrO2Ie+ZmM3aZ/vtpchWzs10vVTRCsuqOxUqQuTX3BOrNJ0YkB3IJ9NvbOrtpm/9F9feuRbub0xHHRcuBBmq9JHn3ARQDvY7p9gtUFAIBSRTlpiYQl9PhTdQ02iip3XZSITA0OOrj+MplxBHD98pPVFk770Re2EhjANXkoc029GjT6fPWRoLhseYl/NFgSFt/4J6ZDucmQHnujGlOQOPT5Gogx4pdB69Zx4c8DGCP+GXs6xPZ4rYBQqUqwwX57bfteih0xFD7waSI3m7a+3xjNoUlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97141ulRIXfjPLSYCfixVI8yid1sjARqDM3/8D4TL1s=;
 b=SPNHkcRDdhXWkLe4vyTbsFxWVBLJZZoZpDQBdWWmE5B41diEv61SuuacmHT5D2hmE3Fl2so0PEGqPjUaMLjx/9nPTqPc60STO8EFgniUkFKTd9kBDVSCfOGQ7yjVssH1xsQ0/4vcyST2mJA3ONOX851a5wrJn7C6LQHKJv3vJ12zmLcj+Ao8hXK44UEu7gV1zWk4pNmOi3MumIlMpZ/0sU+F/0jThENZozVujwB6hpaFjShacgVi2F4tEfPTZfiNC4xb6JtNGqaoqMQSDQi75DL/Jk0ndT9lmsxCKNd4Qz6EbSUgnDs8S/CrtGQJhWSaH/9DOX/DEY2WJ3l9ZW//nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97141ulRIXfjPLSYCfixVI8yid1sjARqDM3/8D4TL1s=;
 b=eEKX1AClU3++Q1VBj395nsUt0jko5KF8W2SBmzu6r+Q9kcvpy0PZPxxM89bqMcIuBbPgGsIlnaqW+K+/vUIEG2/CH4pvia5Uh47lsis+YCkIJ7SQeYle4AqcGfYviiMisLb4O4N2qxHKEH2XTDgRLi5IA+vkzKTjNmk9iSgmL68=
Received: from DB8P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::17)
 by DBBPR02MB10529.eurprd02.prod.outlook.com (2603:10a6:10:52c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:05:15 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::d5) by DB8P191CA0007.outlook.office365.com
 (2603:10a6:10:130::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 07:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:05:15 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 08:05:15 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 08:05:15 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id B7341E4C8;
        Tue, 21 Nov 2023 08:05:14 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 3AL75Cfa3061354;
        Tue, 21 Nov 2023 15:05:12 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 3AL75CF43061351;
        Tue, 21 Nov 2023 15:05:12 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] dt-bindings: power: supply: bq24190: Add BQ24296 compatible
Date:   Tue, 21 Nov 2023 15:05:04 +0800
Message-ID: <20231121070505.3061304-2-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231121070505.3061304-1-Hermes.Zhang@axis.com>
References: <20231121070505.3061304-1-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|DBBPR02MB10529:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da6a01a-d20f-4eb9-4cc6-08dbea60369b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ict2WSFi+UqqYu95ta3DATwOECDUI5l5DL4ULtAuPkacsstbP4je2bD8jkSuEnVEA2pPNG8uDHoHmaIzSfc6yKFT/xjoYWxj3F1SLLpuoKoJZ8RQU8uUZpk4yFY1i9NhqrJbPPNxOgLaaimUClKzfgLbQvV6Y3AUBMSeemdK3+A2/T61i/cbNpi1gDx7lpvRS3189B43gNocanAdk6rchb+37CSjC9qOSXRSmLGWC9iASJleJJKvEKvW9nzSw788DUVU1t+VqUUZRxmg8qel/8KH+LspAOiG25EZinJprlzIahnDEs3AAjhoxFjhHX/U2VdxAVb81Y7MFbbun9FhOtWLOhXdCFp96Idgn6c5AHwrZVpswo1tda9jJs1ttc851AXSG5gHOY6IcS6tPIXf7s67oxYI+MiNLS+Ua7ZejG+en3aFsr/FlcCTMCDMu+hWcdrmnMIs8fM5gNWlr6lTdBW5XKKvCuF/sibYmZKcf0jvbWLrNK0Reew+4uk6+yqCSo8Ouc7oDYFyJRgBR4GBORbPe1N5LrBcRU+FcbilITyg0+L5sstWgA0C/0ClXGXYeafuXmft9jmUWL/Muk0q9mOvP/7LT301Yt6d0/D/qMWf/rJJ3Zd8hnZMmJJJXXenPoF19oV1kKkHWAK2SX9HKlwvFr97vl4gR3HMqbBjN6uNRmslmrEu3+Gn3999SA/uvPhUuFSU+eAz96buIv9Ta+cQyEzPGmg+1aZRu67wOwV5988Op0TfrPDD6lz5OrbNQEKDeeoLZcMs0x2k667EbQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(40460700003)(426003)(336012)(83380400001)(82740400003)(86362001)(356005)(81166007)(36756003)(47076005)(36860700001)(41300700001)(70586007)(70206006)(110136005)(54906003)(42186006)(316002)(8676002)(8936002)(4326008)(5660300002)(4744005)(2906002)(1076003)(26005)(2616005)(40480700001)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:05:15.6339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da6a01a-d20f-4eb9-4cc6-08dbea60369b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR02MB10529
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

The BQ24296 is most similar to the BQ24196, but the:
1. OTG config is split from CHG config (REG01)
2. ICHG (Fast Charge Current limit) range is smaller (<=3008mA)
3. NTC fault is simplified to 2 bits

Signed-off-by: Hermes Zhang <chenhuiz@axis.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

Notes:
    v2: restructured the code to support bq24296 and add Acked-by tag
        from Conor
    v3: handle the match_info in the modern way

 Documentation/devicetree/bindings/power/supply/bq24190.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/bq24190.yaml b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
index d3ebc9de8c0b..131b7e57d22f 100644
--- a/Documentation/devicetree/bindings/power/supply/bq24190.yaml
+++ b/Documentation/devicetree/bindings/power/supply/bq24190.yaml
@@ -20,6 +20,7 @@ properties:
       - ti,bq24192
       - ti,bq24192i
       - ti,bq24196
+      - ti,bq24296
 
   reg:
     maxItems: 1
-- 
2.39.2

