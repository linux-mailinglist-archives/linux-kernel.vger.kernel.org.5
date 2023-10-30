Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E057DB560
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbjJ3IpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3IpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:45:14 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A101AB;
        Mon, 30 Oct 2023 01:45:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OKz0ycI3L/pXpIa/scoujBN00CGo87i4vf4LDdkW6NISQN7VxtM9gVC2R9bPzB1oXFwjozwljNtnzP560RblNA3jhKClaAocEuEr2inVwTAuX3q53bu+1mEvcNFaCTFRiI0C7V54VlA+TcTcctm9Kkx5MvfFSnDbr0TZju7AdoV8ZRG5YKkKkARtMULHNY9zKBMOB8YLy18a8VRTd95nSWXgLcvq6qrE4ZoKznCWMi1k2jfRBD81BQzuIZ4hm88HemvPB8PQzW3w62UUIloyN8kpXkGjBthx+05ioDPu5mWY7Eoh2SwEuXLbrjfUSxVoComAIkjmUAh4jmHl+39lZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OVKbeDd3kHAWW6CxBaIX5LutoVamKWWoJJirVxGOTDI=;
 b=auLZt+0kxlnrgrQhmn/y/p8dAfpzu38fxFuW6aq/dmSYrmo1e+3YpAl3UifuK+iOSbm9kRk8BGGdwHDnGT5HkFVQxA9wMwZjwMXcT2oeqacU24nchr2DcKDqSYSpzkJCLeqpvxfCRDkSE/q5fMpa18zSUr6bopnvRWIl2d1t5FofNCRB22rQMxyocBarfpOvxnCTTiZC6av/eFh6ulLUiOPRZTuguZga/GhDNm4S8YeptfCvTiN09eStrDygzYixscTrXOFqDbaCJsH93G6cXlx0HXOJmBY18yq3W+Mod2YODgHoZvLPpW/XzEukiGB2+F7K1100fvVAeZYg+Efsxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OVKbeDd3kHAWW6CxBaIX5LutoVamKWWoJJirVxGOTDI=;
 b=EnqnXpADfHpM7Jz1V2hT86WIK1VGxf4wj4hJTQXIn5COhw7NSm9oHqVQCHpZl9YbIl1cHLjZuMqbqeNRKjIJSIla8LrOlWqYSzhXcM7GRRhDgVVYLTAWp5KlQl+rmXSajkDC1Fc7NOZPI1wqWzIXivc3+YZRux3Y08Tv6YAtnVI=
Received: from DU6P191CA0070.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::18)
 by PAVPR02MB10012.eurprd02.prod.outlook.com (2603:10a6:102:31f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Mon, 30 Oct
 2023 08:45:10 +0000
Received: from DU6PEPF00009527.eurprd02.prod.outlook.com
 (2603:10a6:10:53e:cafe::e9) by DU6P191CA0070.outlook.office365.com
 (2603:10a6:10:53e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 08:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009527.mail.protection.outlook.com (10.167.8.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6933.15 via Frontend Transport; Mon, 30 Oct 2023 08:45:09 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Oct
 2023 09:45:09 +0100
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Oct
 2023 09:45:08 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 30 Oct 2023 09:45:08 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 4F57321A7;
        Mon, 30 Oct 2023 09:45:06 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 39U8h528593906;
        Mon, 30 Oct 2023 16:43:05 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 39U8h5RZ593905;
        Mon, 30 Oct 2023 16:43:05 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/2] dt-bindings: power: supply: bq24190: Add BQ24296 compatible
Date:   Mon, 30 Oct 2023 16:43:01 +0800
Message-ID: <20231030084302.593864-2-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030084302.593864-1-Hermes.Zhang@axis.com>
References: <20231030084302.593864-1-Hermes.Zhang@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009527:EE_|PAVPR02MB10012:EE_
X-MS-Office365-Filtering-Correlation-Id: aabb93c2-0dff-4165-3e15-08dbd9248663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LTb0nhXmJVcSrphYASc8lti4NQGGcpcN0XxNQVEnAXR8kDVmokq6ZpCxpR9h2M8XI0PnIuZ4hU5OuPOZMYWm3XtdZJkjAOdkO1rxkTPBhFJUmtgW/AtIOZEE761Tte4zy9SqKiz1LqUe59r6FJCZKHQ34lr5nuz1sk3gBnsZXxdV1iD91yBGm+pZ/DMlIElwV8fDjWofeT5SHRwoiUYKaqyXllcqvbeTXbztQOf466dOMcWVFPfPSsTbSaf9+GXI57j1A5Hkf0dqaGQKMAGveD063XdvLjjiGc+X3b5PKovI9Ot9fLYktKtqvKVT+JdI2qdDxHH2Hk6e64n754UsUTris6cPFLyVURgqGTcMI0pOv8vPyvqlpzZvo5jvm7TOZvcGIT1ufDvsenH+LkQJ1qBQNk2SzS8fl7JdXbmoaVn5ak3OowlxOQcjYDix1BfweQxIlIKl7pU5up0en0c0RE3cYf3X6fw4Ah7ZD0tfqbK1PDLhZz+lkZo+SswBLNKmJF2aT5oTWOnUlQJcUy1c44DOVGyVtQb9XMv4h5Ck6t0xZ9zJQm4fupVBZMYbswPsdn00iO8BUKXL6wK4nHKu8m0b9G/fMA0j2ofEhfC7m0wHyFIX3kR59BDFEwbm5wQD5pPgKl0SYt6CXFh91rCkZLL8Aj4nDZylMpMLuNEsTcvvaZdt0qb3dkml5+WrJD/H45qhbKJrFxaNg7Ld4pw2PDB78UES+wDKL0JZUi3HVmGyNxR0DQ3+bVIqt6hgrnIjez4PxBYtNxfRngLjdPP1wQ==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(110136005)(316002)(70206006)(70586007)(54906003)(86362001)(36756003)(426003)(336012)(1076003)(26005)(2616005)(478600001)(83380400001)(356005)(82740400003)(6666004)(81166007)(47076005)(36860700001)(40480700001)(42186006)(2906002)(4326008)(8936002)(5660300002)(41300700001)(8676002)(4744005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:45:09.8976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aabb93c2-0dff-4165-3e15-08dbd9248663
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009527.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB10012
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

