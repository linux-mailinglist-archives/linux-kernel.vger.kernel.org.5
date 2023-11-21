Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212037F2614
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjKUHFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKUHFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:05:21 -0500
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2082.outbound.protection.outlook.com [40.107.105.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001390
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:05:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elMpAd2IvJki4jCclTv+kzRxQ7iyGvc3WJsHumN8SWtah/tJXwT+G7dRbckPPLiI37VKwSgc5vVEyVSwF8sH4MqzYgHbuaWkcZvMw++GEbNRBZntwxqkKOyaEYjxk24aU2ZCGlaMXcWPt4Oj6Zd23hV48fB10Rnokx/5MFMuDB/heuzD5aBPJpMVkvLwQcHXp826S7WJt1164ediD9cFRIJ+cx8GI2MjYHL64u6y//DlghC39E/lui73FNXoeVfs6wKpNh+ZGXUCB1luFm2rRFVDJxdjcKhcmCK7Zf89q5cpSCqAaKddVZ0zSVPESonWAwfzAfL5h7jZCQLiuZGL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwKzSN7U6Kq7X4KCuDzy7MUlkTaM59VUWUOFrrgJz6Y=;
 b=VxTky/x0XgnfsIh9qGU1yfZvnhnwqCrzLRjEgFjKdLpZrPi8hVNbW6QTwD72aKryMAS4APO+bl7MU3Z12EXr6SEbwHaU8nikwc2NDJublidL1X+CB8cLKXs9kgFs3+pzyhzwG9BLA4sloC5heYQTWSGVIEkLvnl5W+uUnpeJ8s+dWcMxTKgUbD8in18X3eopFtmv57tCFv5Qq+wsH+KPWVk0nGvWYpEIU98MiVs+zA+BQzBs+6hN3UsiWdvuq3cgANoyF36O7+BFaGW9T+CTAGyMZeumaV5krn7mllVQVc+1T62CaU5Lftfea4Rwt86kYQsZU5qGz2BLioLzg489ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwKzSN7U6Kq7X4KCuDzy7MUlkTaM59VUWUOFrrgJz6Y=;
 b=ARmrByO1kLaBAyNs1zYXKdS6NKldmHJR2KguDDpnKC0a86y4kxqATXRVd47/KbpKMAQqJKvzuvdF0pXURmyM05pbqa5v3ILwgs4VOLXR1EcY+MD+Y+OfdFosEQ4d4K8PnUyR3hvnsLzoB7OHO/JUxOsBgDoFZOzEhfqoZQepLW0=
Received: from DB8P191CA0007.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::17)
 by PAVPR02MB9205.eurprd02.prod.outlook.com (2603:10a6:102:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Tue, 21 Nov
 2023 07:05:14 +0000
Received: from DU6PEPF0000B61C.eurprd02.prod.outlook.com
 (2603:10a6:10:130:cafe::b0) by DB8P191CA0007.outlook.office365.com
 (2603:10a6:10:130::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27 via Frontend
 Transport; Tue, 21 Nov 2023 07:05:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61C.mail.protection.outlook.com (10.167.8.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Tue, 21 Nov 2023 07:05:14 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 21 Nov
 2023 08:05:13 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Tue, 21 Nov 2023 08:05:13 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 0F035D9D2;
        Tue, 21 Nov 2023 08:05:12 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 3AL75BLX3061332;
        Tue, 21 Nov 2023 15:05:11 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 3AL75Bh63061331;
        Tue, 21 Nov 2023 15:05:11 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v3 0/2] power: supply: bq24190: Add BQ24296 compatible
Date:   Tue, 21 Nov 2023 15:05:03 +0800
Message-ID: <20231121070505.3061304-1-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61C:EE_|PAVPR02MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d065508-0032-4767-2f17-08dbea6035bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dNgAZLPd0qqASoa+Srfv2yXxtkYIk3UHdnTIaOQf8gCUX8ClOkglOgDeecBvsFzZLGiHaJvKMvijqoCU7XEhI+yne10bQdIw30krxfLHF9mySG3J4qnvHeyJ0ZbINMmctufF2H0vHEQ4tNYjdmXtEhwiABsvkgV73MLKJXPj0GdB7eKB+MqlCOY5folLQlvLtl1dhZQaBax0LTczminQDqwY24dWv1zoKEdfqZJJKhGUtXjc0YVBwyfSADk1sdsh5xltNbQIW8ITv99oPs8+j/5CPpqcBPJLkL2OmOwOUq1un9q0FPW5oY1rBb8OOuKnaiSQSiub25IateStbOpjRXq1pGzX4DPAh+aDrPiNLE0ur3pth4afDM2SvUq0lUcvzXjav31/JXyjLvzRYUywpDOsY2RM26HPgaHPUFEp6ePduAJH/xs/rPtmHKgViTWmNMzDHYDZNLUNJkp4JP5JPyeKUlj+E6nkmZlMGcB6LSio2Ws8x/zNtaJG351j+ibIpvTLt8MNI5XtE//pmVKPAo3mXMsNVrCIaxyDNYkJx8DAHS4ma9wPvAOVUe+ao9vTJPv+9K+VZ0zjhRVOTnyZ3MmIGFWCA19mhGoSc349AUKZbLJxCvDmXhb8Luk5EvJaciIHghJsH9X1ND8qUhqviEdjCPurZJ4kGXN+f5qe/lprW334IyMnYbrRqVIOaHLDbF5j7mEybqulVNUx0yhmPxJWvjUgkMAzps0Cc30472LJzin/+QPzXbBKkkXaSQmmPPN14gJ01wa8w4AUAMIbEg==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(186009)(82310400011)(451199024)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(5660300002)(4744005)(2906002)(81166007)(356005)(82740400003)(1076003)(26005)(86362001)(36756003)(336012)(426003)(83380400001)(107886003)(2616005)(36860700001)(478600001)(6666004)(41300700001)(8936002)(8676002)(4326008)(70586007)(70206006)(110136005)(54906003)(42186006)(316002)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 07:05:14.1651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d065508-0032-4767-2f17-08dbea6035bb
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9205
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

Notes:
    v2: restructured the code to support bq24296 and add Acked-by tag
        from Conor
    v3: handle the match_info in the modern way

Hermes Zhang (2):
  dt-bindings: power: supply: bq24190: Add BQ24296 compatible
  power: supply: bq24190_charger: Add support for BQ24296

 .../bindings/power/supply/bq24190.yaml        |   1 +
 drivers/power/supply/bq24190_charger.c        | 445 ++++++++++++++----
 2 files changed, 343 insertions(+), 103 deletions(-)

-- 
2.39.2

