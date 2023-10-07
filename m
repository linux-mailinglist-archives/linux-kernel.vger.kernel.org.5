Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D88D7BC411
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 04:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233997AbjJGCH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 22:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233040AbjJGCH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 22:07:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2084.outbound.protection.outlook.com [40.107.7.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE5EBE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 19:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OyMAj9coADF3Oak1xStrRPQHH4o/4Ymh0ZoBNkyIHb8iOCkNIrkIsANpKYGFQP7zfgfjHgZ2E/juE33H6IfXHD7n1RwCxtUVAEvwaDfaG21YR6te8Sso4a2UxzIn1K2aSixWiEGXxNjfSp3X7kzjiwGXKOGfitYIHinyHsEujhDXLb6oFriarKHJQBWqU0AsqchC5HhN6snuNawXfU58IwYjUc+U276yspQN2BHrk9L078rxSrPO0vzmpEDbXUD5p/OaWloJFiBHGig7jd0Taf4R3KOAEF5WqReqCUNaqmPBbhgPPzb6qMzWZxc2gOuiiHh12cB8yk1YGaIgPuD5+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qpOKGl600u8ZcgXLMaGWdsTOP+VoreFmwo9t1ZI+6vc=;
 b=IFOQcGXNqyXT2VnxOMkcEjfx8JF0lEbs1/fEzRCLmV+lwQ6xm5dnbVC+3exC60H4WOOV2g3FJuPGWilphB5snabcYLdHKcqqfOdVmDUoaB1+zKaN1pXj77ptSrJNhN0Cms+JQbrfKr1EGYvtrmDqrhgpk8hZ5M/lS8I6uW57Sp6YCZhZJyQ0sP+ZBTvQot+jnflETfkzvU6YMxR5Cc+4H8YheSOPq6ouW4X0jiV6s6eJefHAJbveU8c/Er1LmSfTppeDWZHwcTuqHqoYyY3Guy/GEPBISK5wGyJgCj9tGkQhRZLZVQUu5Yv5GOE80mcOCxXpUq9pusxq8yWc7fwaHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qpOKGl600u8ZcgXLMaGWdsTOP+VoreFmwo9t1ZI+6vc=;
 b=bIfRPdW3XnCqV32guvcZ3xBcVnGUGkh0t6LNw43Go2X9jgQnAyV2B/vcIyq4OcMGhwok9pON4KNHF28h3t0M1JNtp9EVC3wYW9JIEMbM4YpvOI5FHjCCAIPzXJxJKa47IB3yCkB8gbl6BVbJtoRDP0RaVv5h6ml5ifv3QViH5T0=
Received: from AS9PR04CA0173.eurprd04.prod.outlook.com (2603:10a6:20b:530::17)
 by AS2PR02MB8951.eurprd02.prod.outlook.com (2603:10a6:20b:5e4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Sat, 7 Oct
 2023 02:07:22 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:530:cafe::80) by AS9PR04CA0173.outlook.office365.com
 (2603:10a6:20b:530::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.33 via Frontend
 Transport; Sat, 7 Oct 2023 02:07:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Sat, 7 Oct 2023 02:07:21 +0000
Received: from SE-MAIL21W.axis.com (10.20.40.16) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 7 Oct
 2023 04:07:21 +0200
Received: from se-mail01w.axis.com (10.20.40.7) by SE-MAIL21W.axis.com
 (10.20.40.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 7 Oct
 2023 04:07:21 +0200
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sat, 7 Oct 2023 04:07:21 +0200
Received: from lnxchenhuiz2.sh.cn.axis.com (lnxchenhuiz2.sh.cn.axis.com [192.168.77.59])
        by se-intmail01x.se.axis.com (Postfix) with ESMTP id 81CA82895;
        Sat,  7 Oct 2023 04:07:20 +0200 (CEST)
Received: from lnxchenhuiz2.sh.cn.axis.com (localhost [127.0.0.1])
        by lnxchenhuiz2.sh.cn.axis.com (8.15.2/8.15.2/Debian-22) with ESMTP id 39727JKi1912652;
        Sat, 7 Oct 2023 10:07:19 +0800
Received: (from chenhuiz@localhost)
        by lnxchenhuiz2.sh.cn.axis.com (8.15.2/8.15.2/Submit) id 39727IUv1912651;
        Sat, 7 Oct 2023 10:07:18 +0800
From:   Hermes Zhang <Hermes.Zhang@axis.com>
To:     <sre@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Hermes Zhang <chenhuiz@axis.com>
Subject: [PATCH 0/2] Add support for BQ24296
Date:   Sat, 7 Oct 2023 10:06:59 +0800
Message-ID: <20231007020701.1912553-1-Hermes.Zhang@axis.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70F:EE_|AS2PR02MB8951:EE_
X-MS-Office365-Filtering-Correlation-Id: 789af4be-3af0-4797-50e4-08dbc6da244f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHZgMBX8d0qI5X5G7hvab0eTT50CCYg4Q9QqY+yJ/oyOWPzuMprn/7GtHdgeycA50sVOyd0dxIQ5XGQAKgzeE63ITTAMo8uLh9xVPJLjX/M7gl52EbTOu6lw4V3J8D15g3XU8KDa3Cn2Oh134AGuSrkdUDsed68WcCZQffebY36Sh6mhE0wkWRrTv4TkohXCkgm9iYdbq7TgiE2KLNA0PywkSMJD9TUOzHbEUvnjvE9VOc/i7A+OnhgjsEv7eYcLWmPIfwzdC8myy/AfZOWwnbUOmMaK7P3xxjKUXQsBprkuYY2EKSd/+PYHnwKkHclLkpQFdsHC7YVpt/v/BiGd//A6VvdEolmBHuuiSUdcJDOjhBgy6MbPiajxqbllzyolP9BTk2oPYJjYDccIis8mkFuNZJEh7wSN6DMIQ+9e06AO1kf2bq6vT50sB+ZeY5AnPhmJ/s6QKJLL2/oWMAs0OELvQPfoFuKVy3vzQDsarIMmy+4zEgogSNo1wZJBHGDAvnFMvkCQrWc2r50PbWbd+5RO00RxJvzFmp8sjHTYF8npJB46Yc9V0LI5umwdbXPDmtz48ngveBsSvDDTm28jF9g7tJgv1cRJtNfP/fvDS37P1FNLfBhik8tedoXQS5VynFNX6tdlt5w30UWDVlqZda0go9VGIPZcsY9NoLvwRiGoO4UvS3YqB7FK4/xUUBzOlE2LWtvVlqHbXZyChwwcqP+/ZI163y8/SYTgnXVyaW4a8AKI7cjyOhypP9w70zxrHstRyOWqvVYFm9xrG+zF+A==
X-Forefront-Antispam-Report: CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(82310400011)(451199024)(1800799009)(64100799003)(186009)(36840700001)(40470700004)(46966006)(36756003)(40480700001)(36860700001)(8936002)(4326008)(82740400003)(83380400001)(4744005)(8676002)(1076003)(107886003)(426003)(26005)(2616005)(336012)(47076005)(6666004)(81166007)(356005)(40460700003)(5660300002)(2906002)(478600001)(86362001)(42186006)(54906003)(70206006)(70586007)(316002)(110136005)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2023 02:07:21.6936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 789af4be-3af0-4797-50e4-08dbc6da244f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB8951
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hermes Zhang <chenhuiz@axis.com>

In this patch series we add support for TI BQ24296 charger chip in
bq24190_charger.c. These chips are almost same in the main function
with small differences:

 1. OTG config is split from CHG config (REG01)
 2. ICHG (Fast Charge Current limit) range is smaller (<=3008mA)
 3. NTC fault is simplified to 2 bits

Hermes Zhang (2):
  dt-bindings: power: supply: bq24190: Add BQ24296 compatible
  power: supply: bq24190_charger: Add support for BQ24296

 .../bindings/power/supply/bq24190.yaml        |   1 +
 drivers/power/supply/bq24190_charger.c        | 269 ++++++++++++++----
 2 files changed, 218 insertions(+), 52 deletions(-)

-- 
2.30.2

