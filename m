Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C53F7DB55A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 09:43:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjJ3InS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 04:43:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjJ3InQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 04:43:16 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2048.outbound.protection.outlook.com [40.107.22.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9072A9D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDanm792tmJSaSUOkuSVFE9daOMQGXDDNKA7IXh1As0jL1hcwOgAKHrULEb+wqrQv3vJByVVrHBibd3AM58Jax3EcW1lk3JfB4RFjShX2zbAP55dd3pGQBMER+bR8kA9HskweEvwSoHLGW/NL7U4dknRcaftPMVopDPnsoWDJE4Ng7xsHVq3mlEFmyVqN+iuwTkFeclarzXLLas5VycjnyZB3FnjHDz+7vIuKyL7ejx4Q+5JQu6GdrKYvbPXpEufL9yG8pTjcvMQYpm1EhfA0GzeLY+Z10vQaZuQoRB6uSlcYwVuJVcYUJtlsfApgklK1bX3uJcwfP8M0NAmnd7hRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgSyi0/896+wdF+/q03wfJXxxO5CZk97mwH/vEtm0gM=;
 b=McUvXe/Ypv6oWUvGe9lWIaJmrdvW8kGVSXpvJLWRTj6diic5Ndt6NdP3OCSZegdHijgBL5cQC3bQS93xPH1vbpH1gw8WcWC8PFKUrIS4aSreHiutFTiMyfRIOCZux7Tru8As+SUKfuwy2XylpKnMTkB7bI61XjLDZaU2CIlsFHTyhL/zlMUMFzqjKjikt1wPlSJEz4UNL84I0tkv0Ogcv8uv9hzV2HDxA7+4KmlAzfEeStcqmq6oAAZLkOMiwDaqlKlMH8kC0Q887ocZpDtX+LpW2f0sW6jNeLLgh97c/eOGGCHew8oI6F2brO6ylKrEqnDSUHHqDKU7n/APaML9Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgSyi0/896+wdF+/q03wfJXxxO5CZk97mwH/vEtm0gM=;
 b=h8aowFcObliVAtLXh5U/P9S3JlkWcG6ZDF4q6JwiayntsHLUvqPVf79Zjpl3OTLM6+1DEsu/9MXD6ByPjp7qTEP/UhNTb3an/mR4h/ZkcpSsPvXjhbDOp9zgdz/5ln2RxVScXKB7KXYLjBrvSlmsfLLnVqmtHgG57soH9mkhaW4=
Received: from AS9PR06CA0669.eurprd06.prod.outlook.com (2603:10a6:20b:49c::14)
 by DU5PR02MB10919.eurprd02.prod.outlook.com (2603:10a6:10:525::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Mon, 30 Oct
 2023 08:43:10 +0000
Received: from AM4PEPF00025F97.EURPRD83.prod.outlook.com
 (2603:10a6:20b:49c:cafe::65) by AS9PR06CA0669.outlook.office365.com
 (2603:10a6:20b:49c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28 via Frontend
 Transport; Mon, 30 Oct 2023 08:43:10 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00025F97.mail.protection.outlook.com (10.167.16.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.0 via Frontend Transport; Mon, 30 Oct 2023 08:43:08 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 30 Oct
 2023 09:43:07 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Mon, 30 Oct 2023 09:43:07 +0100
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 7E35B21A7;
        Mon, 30 Oct 2023 09:43:06 +0100 (CET)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Debian-2) with ESMTP id 39U8h5ih593892;
        Mon, 30 Oct 2023 16:43:05 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.17.1.9/8.17.1.9/Submit) id 39U8h4gs593891;
        Mon, 30 Oct 2023 16:43:04 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH v2 0/2] power: supply: bq24190: Add BQ24296 compatible
Date:   Mon, 30 Oct 2023 16:43:00 +0800
Message-ID: <20231030084302.593864-1-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F97:EE_|DU5PR02MB10919:EE_
X-MS-Office365-Filtering-Correlation-Id: d38c2c7d-c471-48c2-77f2-08dbd9243e42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q7SlaxcPOQDnk3ieZ7es1CUD3/IqJywVvA0kRWVqWDZgwFgqsMoUFOohVnYTeyOaWiPEY1M6lt49m0fUfn9xJ36O+LRw1ip0otPa+KJiUJdoHVzmAV38Jllb2FkKP3rdiE3Wdb6+zT2o5cnoC2SRLIX8cnOgD9tBho8QCap2XYq6ijZ5LYo1cDVeyvojt0IamVTFzwWsCaeRyxMAtKphUQT5kxVzqmIfOjapESTXthv/cmXwWMTfKTl4jRi2sk/1pQj55LEjkc9X5iTE51iGX/baGTE6BEskmuvgctDmqg5CZCsYGE+kn8K8Ss+D9W0FO6FgNR1cve0ToDjVYXhdaHmiCYbuC4hYmnY6VfCQ6D9D9F1buhRoqm97f3v9tLs1e90JMJc7JvNeKb+lCHy4J4mQbbmcDyz6RgR23MUn2mLW6cICwiYwfd0NDBE/zjciay78gxKvovm5l32pI25ndy8O7Z4rxXxZBkL4eR5XJoyTE6wGN7X6/S97YLKi8E8wim1oNTDsu8pNvsogPvKbAN49XVyXrJTbWWnY5FUmdSf+K5U0detukfgRC46CY3m8bldETsQHc1UaiRfD6AMyT984q3wc+wHn64wO+eZK16pFTCvelB/dXgNpQK60SuJlrEsJ2EuOVMCkWn/1l7nTs6XT02jhYJXU80ejoPOUI3/GqJHcaSLRix2mMUv+KBvUUc1c9T3a01zlGcg3Gm2Ixj4eG2U0Q2+6l87iMShBes4+EcLEs58003lbyOU2Ot1NCsmCp+iitBYQNI7iAtTw2A==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(1800799009)(186009)(64100799003)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(6666004)(83380400001)(426003)(336012)(82740400003)(86362001)(81166007)(356005)(47076005)(36756003)(36860700001)(107886003)(2616005)(1076003)(40480700001)(26005)(110136005)(41300700001)(70206006)(70586007)(316002)(54906003)(42186006)(5660300002)(478600001)(4326008)(8676002)(8936002)(4744005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 08:43:08.9338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d38c2c7d-c471-48c2-77f2-08dbd9243e42
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00025F97.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR02MB10919
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

Notes:
    v2: restructured the code to support bq24296 and add Acked-by tag
        from Conor

Hermes Zhang (2):
  dt-bindings: power: supply: bq24190: Add BQ24296 compatible
  power: supply: bq24190_charger: Add support for BQ24296

 .../bindings/power/supply/bq24190.yaml        |   1 +
 drivers/power/supply/bq24190_charger.c        | 437 ++++++++++++++----
 2 files changed, 339 insertions(+), 99 deletions(-)

-- 
2.39.2

