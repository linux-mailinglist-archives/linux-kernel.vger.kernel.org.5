Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A077F5E9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350590AbjHQMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350469AbjHQMBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 08:01:32 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::60f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB742133;
        Thu, 17 Aug 2023 05:01:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYvTkb8T4kxWhWrt/rlkMnywBpkPYmf+xWsbcq7sbPJWTpB4ix3/5/a2iM6ZO1lvpa5qHEsWYer7XohwHuqBhqdwPvyrfPKoaeXI3y4lQjEMg9BnDE+PDNCkU0aAN3hFmV4TeDcLiAplTPGQRgz29zsqLI3u8gOBUGg23J7JqCdszVyrdt64a+/7mJlleSgKJnnhN/aakiO8fiw0Vimxt2073GKNX7K5L7RH2f5u9BherEnrcLKiOWV+hhaSy0qY4KePDZeMbK2CVNkYAJWQ5jE7zjVVwpjHd4lDfnBplYCx8VMvh890qSmh8BLinkdimbONQcKMu/6BfFoUBNGGdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hvsMwEdERH43HjLjc6LGRt/cy/uxcRTDgxAYqtreUA=;
 b=D/SM6LMZBSzLb5Ajs3NhzXVLnFtwFSsWW0BU5X+Yh13i6hPOGOkKFvi8n0DIILcwH8y+sX2+4PQa3DrgoctXM6vhfxcl+mvuWD69u+Q2ULVLm6HeCWQGBQgDyMCudcscszicWK+YjgiyvMqEgGL0gAd/wEeMQNulTQQJqEFPO+I2K/gBUxQx3E+AKLf/PP0/MIN/it5jP7whxGcMbNejoC8ZWRmH6ays4B//RfMuYOAw8SiS4YQGIdotBOQ6stTK8losNyfU+u+Vq1ai36/xH/m7Bq1El2nSYdPU7TPzds6qV3DRp9dIDyL3JQQKOQMPOdhiefJ/U7GBjF8xVv8Wtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hvsMwEdERH43HjLjc6LGRt/cy/uxcRTDgxAYqtreUA=;
 b=YqodbYgjWFPgZ5oJTCISBKDPuNSGFb3D+0i9o/4IpTqv7nZVo3Lu1nSrbsdhVaFTCxAQ92GWMwTQ9QIrq5qa7Dj4kIndVsTTFUzOoL/hRkpmQL/3wGToRuWDE19T5YJy6FlWZaFWt5wbddvi5aKHh8mx29Cl5kBhA2nRAJGRmgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Thu, 17 Aug
 2023 12:01:25 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 12:01:25 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Walle <michael@walle.cc>,
        Richie Pearn <richard.pearn@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: dsa: felix: fix oversize frame dropping for always closed tc-taprio gates
Date:   Thu, 17 Aug 2023 15:01:11 +0300
Message-Id: <20230817120111.3522827-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1a6394-3793-46ae-3a1b-08db9f19ae35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iUTkBn5KVok4iW7GYnagcUPX+emwxls4Z4BjNIUcdCmr/B2HZSsnv44Xyjs17TTy4+HiQCSpSPReNQv/4ImmdypH3DtFeEtMLImtE2loD2ubM2CSSiHhRer6fg8wZm73jCqMrmTBFz80HpOcsx/DMJnIpgh6fJNyvo8Grx1ce+IhesBCtQtZN9RcXHJQzpM1acfrnadWObqrrOnYMdfahksM9ccEHsxFgzD1VWJ0YzqmI0QkQbgU1ggaUPpDcp7BD217L76jufu6juJZBPdr5R5vf+ltlI4SEjoJtauL0bu0C5eVv4wHDep7NbYdxKJ0ow0LQfACHqBNffA9o5tjTQWGmjTphpf9JoW1Ig5LPVW9qYI/BTx6YbLhyfZJD4c/lUr4yATE9GfZhkbv1hQDrw8x46cZ7N/dVhJGB7cxQLz4HMlE4h5X1najuwN2DAtqhroH6VlKkqQp6o4MiRK0EI0/GMus6K57T4ZB/aYNIBv1JEZU5kg1CblNwgMDR0eG4aEi5jF3ab1zLB7ylVXvZNyyba8WGJgNm6tCzMk/OTBBiGDdv7QgcBqD8GfTlAJ8GYqcJJM56ELRMVIGuNXu3ZeKG6iU9MAln5pBFIyK05QvsMLMP8dr2KXJMkkYgxa0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(1800799009)(451199024)(186009)(316002)(54906003)(66946007)(66476007)(66556008)(6916009)(5660300002)(41300700001)(44832011)(38100700002)(38350700002)(4326008)(8936002)(8676002)(26005)(2906002)(83380400001)(478600001)(7416002)(86362001)(6512007)(52116002)(6486002)(6506007)(36756003)(6666004)(1076003)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5JuaT6Uu25lo/K5gGaW6bmd+lY4I+Rc9rQUcMKu99CTjjL0P/yru+yP3zwE?=
 =?us-ascii?Q?gfB9vwHioGN4IwhU//TolaxyFvxdclAS3DPYj+PvR/1XoxL/V/R1S9rmbZTv?=
 =?us-ascii?Q?dxE1oHPsIOKcKJhoKcbUxJ9dJgwPZ86nzZTPiOuM9ku1l7rphPURUv1Lo3A/?=
 =?us-ascii?Q?R6UWTJlyKKuVQ7gH8+H3GoQK1BDjjiNjED2ehTywd+dSxvKOapEZ7aJZmYaf?=
 =?us-ascii?Q?43zVNIy3cvcn04h74Xt1ASj7Ay1StkhAvyn/wS243Qi39sdQ7ZNx9mj35JIk?=
 =?us-ascii?Q?S0XOdVU2Cq/M5oslQ7v+kvWU+xD947u9Le3KXjnvbAfILOVjQLpWaEochJLs?=
 =?us-ascii?Q?N1FuH2m3M6Y+pHdaSd89/FT+wX/8Vp40Z5MAlXVBDmX8CcYRSJKoBpUjswDu?=
 =?us-ascii?Q?7wWHP0QaJPDc3HkToDV1yksR2l1kIFlRACMoH/ZnY2PehZMlicG/oJwu/8G6?=
 =?us-ascii?Q?dz8gdMGVlxThUTGWuaHPm1vHVI+AkOdyL2Dlqam96crr0eBoLj7qKWOXfOZR?=
 =?us-ascii?Q?/JKlno5jojtTOoLGvx8uZZLDWjKa9S0IbaxJhK6FSmYTYsWuouBmr3Y55lEV?=
 =?us-ascii?Q?ilUYY6b9lJAZaNcYPJKZth08/AQ/thgP5awHLnC8K8Pu6q715pnMnYpYXXpf?=
 =?us-ascii?Q?W6FoSCw/heFgaeUGCmnRk8zSZGtokV8BdRQS9GEMy3+THraIB3+N7yCce8Yi?=
 =?us-ascii?Q?XXVHwVaUwXjGk7OiAvs/TAzxtN8TIqnVA4Ku+2Ri5enQMqD3sMlD5VuYyKzc?=
 =?us-ascii?Q?qLyy5ApIpDEt1PKy8pXgASqBhoZyvo421Ido92UFW3OZG0kP0hzzfP97p0qg?=
 =?us-ascii?Q?3SAyzpS8BLMMmFQOcHN4Xe+dF+WulKkEkh00xKqIbITpcy14NgwGdBn+rEsM?=
 =?us-ascii?Q?zhZoD9wazwYXToHxNdElrOFLRG7ZP1uciBDIbBZGA8NRtDP8niO6TOOFjvQt?=
 =?us-ascii?Q?wCnnk+1OlUp0q3KDvUpC/AqsvmO/KUF2cDdvubHNX1CDwpSVkwD6pIYPV5vy?=
 =?us-ascii?Q?7CYaG1DpxfR02eYm2gOC9qVL9F/ob0DPZHP/zRRCNn3LtVp9EsgBAmVFfWXb?=
 =?us-ascii?Q?iewOQDGm0bIEN9vo6rQRKn23v1zB2uvKH62sv4LMHQCSsOlqfzZhtaoc/7h4?=
 =?us-ascii?Q?Y5CECF85N43g8BWVhAp4dI7f8/Syuhk5ps8ZeDCDUF3yBPrsNwwbMDEei/sZ?=
 =?us-ascii?Q?NWyVJV0S7WrpAUq1rv2Dl0wmnKo688YRkfMmsjq8ZL1AkGQqRHKsiYO314O/?=
 =?us-ascii?Q?b12a+0zgbTNc5Og4gUffeEJOC3VKhkJDJNwWtwXM54aQxyYr+i6W9kEJAdeG?=
 =?us-ascii?Q?Z3zlKb6cUR4a6CPnty25N/BFc2expy8cYUms+uVXSONYa/v8Bmf/Zfz+tn9I?=
 =?us-ascii?Q?K2bTgAz7ll8CEjqVdvZXwMJP0IVJo60cWSHZqhKqGkJ2Fhm881DnyYQg9qGt?=
 =?us-ascii?Q?QGOKgCRk/1TyJVETGEaNh9fonGLK66huhFjCn4c6wAcuxNtlcx/V3+uA/k1n?=
 =?us-ascii?Q?/n8ZB7pL8AIETBAtMDofRd1s3XxpFJDgc6oi3T5fYjbdFjKGSlLX/hrf7yyr?=
 =?us-ascii?Q?2ir83XZ61WZ8Qk8X2zWsi7ci5DP2FcQsJXx2zSLgwm6kfJYRCmDMZfqy015s?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1a6394-3793-46ae-3a1b-08db9f19ae35
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 12:01:25.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ky9iVfOENQQM1pACm5Eh29cGmCn7ltpH3myE30aRyAeOzGs3Ka4O4Tq4VBEa6xfdJ+unXWCFLXy9AFJMCC45Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blamed commit resolved a bug where frames would still get stuck at
egress, even though they're smaller than the maxSDU[tc], because the
driver did not take into account the extra 33 ns that the queue system
needs for scheduling the frame.

It now takes that into account, but the arithmetic that we perform in
vsc9959_tas_remaining_gate_len_ps() is buggy, because we operate on
64-bit unsigned integers, so gate_len_ns - VSC9959_TAS_MIN_GATE_LEN_NS
may become a very large integer if gate_len_ns < 33 ns.

In practice, this means that we've introduced a regression where all
traffic class gates which are permanently closed will not get detected
by the driver, and we won't enable oversize frame dropping for them.

Before:
mscc_felix 0000:00:00.5: port 0: max frame size 1526 needs 12400000 ps, 1152000 ps for mPackets at speed 1000
mscc_felix 0000:00:00.5: port 0 tc 0 min gate len 1000000, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 1 min gate len 0, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 2 min gate len 0, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 3 min gate len 0, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 4 min gate len 0, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 5 min gate len 0, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 6 min gate len 0, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 5120 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 615 octets including FCS

After:
mscc_felix 0000:00:00.5: port 0: max frame size 1526 needs 12400000 ps, 1152000 ps for mPackets at speed 1000
mscc_felix 0000:00:00.5: port 0 tc 0 min gate len 1000000, sending all frames
mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 5120 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 615 octets including FCS

Fixes: 11afdc6526de ("net: dsa: felix: tc-taprio intervals smaller than MTU should send at least one packet")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 4a6e52929d25..3c5509e75a54 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1070,6 +1070,9 @@ static u64 vsc9959_tas_remaining_gate_len_ps(u64 gate_len_ns)
 	if (gate_len_ns == U64_MAX)
 		return U64_MAX;
 
+	if (gate_len_ns < VSC9959_TAS_MIN_GATE_LEN_NS)
+		return 0;
+
 	return (gate_len_ns - VSC9959_TAS_MIN_GATE_LEN_NS) * PSEC_PER_NSEC;
 }
 
-- 
2.34.1

