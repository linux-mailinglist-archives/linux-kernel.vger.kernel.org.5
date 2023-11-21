Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4810E7F25C4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjKUGao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjKUGal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:30:41 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2043.outbound.protection.outlook.com [40.107.20.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF1090;
        Mon, 20 Nov 2023 22:30:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQSBds08eTpCkvKEIsOPe4o9Kf31EFVU1n6JanFcp2DhLywmquB/3Rl7fE+mK27MR+RvJUc9au1xBT4MvSRQS83SiCW0NfnM7eB7V9BBOkrVL8RnUU3Jn6vbh6CL8FLY1YbQ2TFNy1ViDUe4CAguX+ZP0JvQBmzwMARdKX7uvYe4copOq3ZNc4itirp91d6agAmpXBOxKa2sQlbXCOmBTei7rstAKY4JddfGmaE/CSMKr/y62eZYry3n/K20l/O9Ce4PWpgHaCZ2vl0KdSqIiVMXm3eT0Z0EYN/y49oFZg8cwrEmcKIgi3nRmfCIz7FloPR+xybHQwpL5idKiINr5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zw5vmyrFm8kuzrw8zK9QKKgxU+FQj1oWpv6V0SukcVo=;
 b=NyPqNxHvyDvm8IlqnEdTmDYqDNMjJ6CwVzz3W6/a0D5UjnJzLhw2TItQYli2V7Owbs1HnlO61IoJUMr6EzrVHwvFKt3weq3Mv6aIvp66sL38LfynRKP31OSnSAKPA/2JHgzpqqonVngVmYXHokPfIXIAfN3kS+hKFi2ZKlw2bdeekLA17U+xuUFnyTiO203Wqlo4aQIkmb8xB8G4PhF+iPxhKSjvMyzOtt7KzxE0KKDe4KW9TyM6GdJAi+288iW1dG9jxjJgrShnt5ZshPs4S7W0JhZvRpiyQdxVZ/OWE6u8Fw7Iavo9HtQaJOJcpGG3OZyh1Van9ZAxR5wfFihXrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zw5vmyrFm8kuzrw8zK9QKKgxU+FQj1oWpv6V0SukcVo=;
 b=M+IPTiWezGDjjYIDN4ey8d6RNVnFcTGt8V1jKwvr5QQZUwq7BLmpBTP/Ft+Mi8I+7jsf8KXeZ9V7xo/OySLv3rxR4LYRf8hgnKI6BCktYLH7OXQRN5wKQYnHeg36gR2PSsIl8oOA2aOujcIHDmvUbny+B8vfBTAmSUFhkXlaDsg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9823.eurprd04.prod.outlook.com (2603:10a6:10:4d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Tue, 21 Nov
 2023 06:30:36 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::ff06:bbb2:c068:5fb3%7]) with mapi id 15.20.7025.015; Tue, 21 Nov 2023
 06:30:36 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        sboyd@kernel.org, abelvesa@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 2/2] arm64: dts: imx93: update analog node
Date:   Tue, 21 Nov 2023 14:34:46 +0800
Message-Id: <20231121063446.155300-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231121063446.155300-1-peng.fan@oss.nxp.com>
References: <20231121063446.155300-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9823:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fd6b55-ee66-4c7c-da45-08dbea5b5ecf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dx0x0s1zmRvfSu+KvtiHIS/ibx0Yt5SLo5eMcQ7bIqyxY87ypSObomyzvOBNG8+ZzX+sCFRIpgTmrTLSt3gpr7Iy2fSs/1jXzqgxDNjkioqr+IvvapWZ2/JEeushwud5cx/atJmRxnZCjqT+Nk+TC2rHFGzSJS1iACM104Rtm0pBgIqDr5nkAn3fLsLDWYeTjID7wYniV3uJwY7pWnSPeD83V4bCC8j6nBpboAVP1ULSbbutJPOlPxzXjYKgzGMW1WQTSCKgewOEN/gsdOCiNOxx7Dy+LtOgtJLoSvvGkNHwU8GjQxaVPBRtrA2gkiVVTACNqPj03QfRTE3+lnCghKRqOHf4wPtW6risz3jyDaW+d6kkC+gUATtWrnFI1npE6Or4fPRMbzqA+FLIOLLbojH82bozyIUBlXQTshz1VLcxZVqQNfLKguGDYF9+ekWAlBvV5ESiIHBWu7PZmwSxtn+u/4K6w2EOzRtHyosZmduJeKOC2ipTqd0Tv7Qt1k309TlQDdwMKamslayr9KqKa4slfTDO6rF9NjBoyCu6cTxM9Z1F+KPhZES+JQsZ1H0BlzNoSr51WjiyTFgkTXoisCLwdvXb9FnJ7P8knXkLs7b/K1j/cjCjcbIZFh2dw/Uc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(366004)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(8676002)(4326008)(7416002)(8936002)(15650500001)(4744005)(26005)(38100700002)(6666004)(66946007)(2906002)(66476007)(66556008)(316002)(86362001)(478600001)(5660300002)(6486002)(52116002)(6506007)(2616005)(1076003)(38350700005)(83380400001)(41300700001)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0AlIc/iW8y4C420ft9+SLBMgQVy/h1skQhKinOUqUzB0X/TuZ6kOK2bJWIVN?=
 =?us-ascii?Q?YgK8clbk2UKFBp6orgwtJxTYXNiTDd5asaNoHy7DX/U8eECX/1+pWJuYxUCQ?=
 =?us-ascii?Q?7JlJ71xT8t4bJetB143/dJKCRcNMmRx9mAqm+buhrndde+c6Ucz33CSikLI/?=
 =?us-ascii?Q?0IXh0O+qX4jh91XtOenAmfn1a6nP1z6LOWukNELRbBYxDE9O4fEM6sFWKytD?=
 =?us-ascii?Q?hAioV0w3kBYnNsfCMT2kAK0sRiqkKaBai9ehpVe5kvl6CEttkcPj2zOyiUSR?=
 =?us-ascii?Q?MziIGhBMd0gL16hC+FUy0wlL8GUsCP1uO138taUYQuWl09gGMOvo9yenPCfF?=
 =?us-ascii?Q?TKt2Sis4hHLe8rjbbvlvaE8f1A0wN7kpmrbqB+OthfmVMfFKxcr96ri/0BSZ?=
 =?us-ascii?Q?gkieq5iudTtKWYRYH6Du4BzyLUSNIypiwF80HKkT9FAZ4E4ePGrAoacAC11D?=
 =?us-ascii?Q?dYT1mmf6AY6C/Xp4j2CBipZQX0LR+OQgxrJcKDWIO5PL7EoLW4qH/kwas8aC?=
 =?us-ascii?Q?aT6wqQUio58fBV7WARBMbqKPkEs/JCq3ID8eNw5KeuydE4qI2P0nNdDKe2SE?=
 =?us-ascii?Q?+tl5Qa9ILIlwjIxwYMXYXdCjKKvsgUBMqDPwCJG6YvCgC1z+XBjU4TJgfzsD?=
 =?us-ascii?Q?XGODcjc1I7h15dN/Xf149HmRbfq9tyGLGKnDiCvnoLYeckpuy86WTW3VvrdN?=
 =?us-ascii?Q?/ZFmAYwVntGb2VdlFKhCysUc3bv4gJKaOaN6JvbEEwMG+DRcifbaQukIhXgx?=
 =?us-ascii?Q?tPsrDHtBQMcss0cadtsGAKgYMvkOa0Tl6wUEv82RRfplupXxhkjsGKwJNu8z?=
 =?us-ascii?Q?YxNwvByYHl2nDH4y6g88V7BBhAc2MUWZus1Jg6BcCbSS+RqV/qktbKg1kIC0?=
 =?us-ascii?Q?ds/A55RxDkn4nvfbvs4brFDAqE7XABj9CrSAaqaHnb3PeunOE0hcK0KqIc3+?=
 =?us-ascii?Q?nhrnom7dtFWmcI9XmiHhRHFH9V91wz2KPQMPTAMx/PsRr0ww/Z44087P9NXY?=
 =?us-ascii?Q?AATc+ndMvz4QsBclSpQtz87q9oGzWzPC6G8MJ+KZn7S3q8SmlkjlKIneI3jV?=
 =?us-ascii?Q?1xsdc7rLHTU+5bsD723Jkdg8siaXX9BrP41cEIywX+PuSQFHxA0joMKgsC0o?=
 =?us-ascii?Q?w7p+fPPoiOlkcv6bpcmDlI8/9TbYl0rE1h/2ZAsYx0ydjsbYW1R9jlJjFJ/R?=
 =?us-ascii?Q?58k4XmvL2w4xVJ4wqrjq1hMBbEBEEFWr2JBdTiqLsmarAiRzNTRsGsPjqRxS?=
 =?us-ascii?Q?KmPFJWpNHxZpYVpsFzls+VN/+UZwkf1Eoe12TTF2y7Zg23Dd083OHdjM4POw?=
 =?us-ascii?Q?gGAqu0k+G37uv4ibyj6iJAqvysHqRPBEEy+FAIb9Wf5ZNE5uMcedJNCXJw4i?=
 =?us-ascii?Q?5IuiT6lL4vlpXjL3pVtL6xPtUUQxOn4121aocV9vb8NFNMUUOgBdL7WHOlpO?=
 =?us-ascii?Q?h/jGQSrJyEIIBEt0ufTjF14ZKMqxwmP6JlfeiHVZ7m/ySSUBt90/9PjUXy6g?=
 =?us-ascii?Q?KHHOidv+2mCFSIfNejlBV9qVh/P2wnaexvzYcWaZG32RlgfT4fdCnt1FuWSw?=
 =?us-ascii?Q?y2VKXaPxmWbl8BbSV01rBOlDDDOw41HzyZ/oqAQG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fd6b55-ee66-4c7c-da45-08dbea5b5ecf
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 06:30:35.9844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 90hwD/M4Vp10xgpwFZLSFFLastIMXuvCoYBDKN4+Y82o05Ja3zCYA02TqdWfwu7kKTKKu2N3wo8VXVEo198vyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9823
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The analog module produces PLL and OSC for Clock Controller Module. Since
the binding doc has been updated to clock-controller for this module,
Let's also update the device tree node.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 None
V3:
 None
V2:
 Update subject/commit
 Drop node alias

 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index ceccf4766440..235f1ae583e5 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -422,9 +422,10 @@ mediamix: power-domain@44462400 {
 				};
 			};
 
-			anatop: anatop@44480000 {
-				compatible = "fsl,imx93-anatop", "syscon";
+			clock-controller@44480000 {
+				compatible = "fsl,imx93-anatop";
 				reg = <0x44480000 0x2000>;
+				#clock-cells = <1>;
 			};
 
 			tmu: tmu@44482000 {
-- 
2.37.1

