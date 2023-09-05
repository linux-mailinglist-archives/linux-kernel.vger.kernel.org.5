Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED1C793163
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239125AbjIEVyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjIEVyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:54:14 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AE3198;
        Tue,  5 Sep 2023 14:53:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BHOsXtmMmM20gYqtrvi3kPWtQySaw3gV4Dv5TnoUI1xFpTvXaOopJs9KaUXtnZEE9iyVcRJbSLHk5VGwlG8iFk6SRUviLfKo4+X03Yi79rAz+4520nqHLvBgPW8z7rTlSlpd9a0Z48F4JzzNSAV0Usk2UcaKsUMZB7No472LXlPtZtC8XDGa1BEPjNNQnbkpTmjZNKESXKvgFC9DOUgHuH1DZ1WQ5mgGOGFkFx1diFpRuRpnY3OHQVdYSpCYSNydgrFS+o6vDlNVG3yJR2at537LuY+u6hAVNKnw7ZWHRD3knh5ZqVc42eu25LQWlZ99add6pvqhz+p9WgzXgwPQ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vOKSd5/PpiV3jiCIKk/8+utgvFKp9rzWzZpqk82Ksz4=;
 b=mVPf310ucUtH+310d+NPCl9eQP8WHZEK8eHomS2bc1odr6OAMPz1KXk+uAEDDypk6SKdVvIDzHVuDPBjD4hg96j2Q2rBG7E7n612fmXEC6kvM2I6GxNGm5Hf2JhV8oAYBeCtf4LBoovdDyWsKANTNcBqP1X2kp2bmIirqNWc2Y1/NuKY4lSd1eGjscHM3kBXxPcDq7ceMzHB5WLM7FA6kPYCeQbLLn8E0U3X88EXyYTCh/RLyLYgzQdDRiEoRF2LerXQPifb33BaelqLZFrxeRPPjaksNsVwdgRbYVJGVSWEIDUZvYjE+yS2KRDxKa8HfVoR4CyQh3gX77Yjp+0bDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vOKSd5/PpiV3jiCIKk/8+utgvFKp9rzWzZpqk82Ksz4=;
 b=fO1X8TkyWgDMMAwWiZuYUgH9j4+G9M7LTXAk1SxAl6Zf8m474++kpGfdnassn4p4ATsyPjd5k88E/1nTMTF1m6tB6StllyPYvAvhd79yPRdxZYgA/l16psCbC3w1X4jvQvKO0mtFuCUPPLU0gXaK8v/1Dy7p2Sm0/P7fKSw8L5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 21:53:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:53:51 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] tc-cbs offload fixes for SJA1105 DSA
Date:   Wed,  6 Sep 2023 00:53:35 +0300
Message-Id: <20230905215338.4027793-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::42) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: c7035f64-f95c-48db-20e3-08dbae5a979e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBzHBFp5kozE69hoIHrroP1g+rGBlhqRr8ihMqx6eoWDf4sRDj4A8XeE82czVkrVP/np3nd9PVa9yQsYoc719Ap6fF685K+881Y2FJWAT30FIM8ORl1hmg6BTxJ0cP32jXdQ7waWhPEyTX7XMwvdLYuzgDWBTaPYbRyxHsjMon0175s2VcsZOT0S1iJ8MdzUWX+yqmAGMyLMLm5MoY6brFvuBfnTqNmDWDgI15oUa3tVbFPxn5PnRqtkZQmIeK1ZO+xxHxwo/L/1PM8XIbN4uQX5PgMS6bNfgmESnv7w6qp305Z/UxHoZk7MD3Gf28bg1lCY0zk4VUgpxHxCc8btWfKSGqwEDsIPz5q+Cs+LninGG0TbY6yxif0wt0thOcyOE6YL7mFvSjNw8hNsdwOwYj0U0fneMJZ6ATobUcbk0/xW4FzA2EOmkPVcr+AmJCSG6n1Kn9qG3mQaxIOYadBeVxixhCQlpdfOiQzqh3wzrAUi40SviMSEwqApsF8TXF2sBcyav1TxbySTgWzhV9lH0nWSsru+jtogaDMwCskNlhMa1hP3VV5w55jaJjbowFK3snAREtwax4LGJYMPF7z319CP2Iv13mNsP/UttrAnEfP4mTfY53bAoMbSawgEe/Ck
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(38100700002)(38350700002)(44832011)(83380400001)(5660300002)(36756003)(86362001)(41300700001)(6666004)(66476007)(66946007)(1076003)(66556008)(478600001)(2616005)(6512007)(8936002)(4326008)(6486002)(8676002)(26005)(316002)(52116002)(54906003)(4744005)(6916009)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eTBgc0gJKcsg0WmwTyjzmvFO4PmkDoH3NIHZQR156lNryAzMP+zFi505vM6n?=
 =?us-ascii?Q?2FjYQdQAEz7rb+tsiJLe9/2TaslJ4R6Ji2xnJJhpmv/5GO/PcZcg2cQVsJRj?=
 =?us-ascii?Q?Os5SCZzDSQvI5uFf+qP/cd/52LLODJoMOtjIrOCpxnjwMP+3j3yciVSrgiyc?=
 =?us-ascii?Q?agkxhpgLu6itOJOTPfdVc1p+nKFmp9fIIwRxbJ2oox4P1uquH/0TUN/Kx5z/?=
 =?us-ascii?Q?/0xyH7yrjVtSxUtaoJ50lm7Qv+JBZecVZtJB2LIwGrgAfUixO3Urpzrkva/5?=
 =?us-ascii?Q?Cb7vmrFSOOEt5QqxcZbMOt7aNok7X0+QUIvyUzQBwS/vJDdkzWz9D8zB1ghz?=
 =?us-ascii?Q?a8kd5/irriaGj01f6RhR8Um9dhXc7+tRHJgHO/lt5KZf8bBuqTTuy58sP93K?=
 =?us-ascii?Q?gsW4eAD7S6NDBEnCszU6PVLMssPRdHouwFrw1rzJcPw1qHFq3XB2B74cfzlp?=
 =?us-ascii?Q?DKTSk0m7aNXI65gEeqF3skoc4TqzBsggO05mbg621TzqRISKUUzOG8T5w+Vp?=
 =?us-ascii?Q?XAXWwDkoCa7elJST5AZIi52UY7n58uISNfnPsL2eU5ZO2PNZePyYY8BQnKc6?=
 =?us-ascii?Q?9/Tlj2ZaEg2cyMlKQapgclTYu+wz1rjlf1sqa5d3bEshgxHkR8uKRd1JkWNS?=
 =?us-ascii?Q?olsOumiICKlqFBC6Vnm6b84AWP7oMX95Os2LwMm/3GY2jCAOhGp4PYBHiHtf?=
 =?us-ascii?Q?MbB7KT+jwiHCXV8kZDkqZnx2j+kZ2MGXQXeD8jznF2kd+4RX87MrvSw+JZ+p?=
 =?us-ascii?Q?HuS/nb2T+jdyYYSKAlMINX9rNVeCYHrietsbuGSgHJ+A4pXNcRCjPaAetY/Y?=
 =?us-ascii?Q?OmkkbU0ANC6eHZpNQLY+pG1LpaB7gl705rHFwz1aBX5zsH7uqQjqy8cuXPS/?=
 =?us-ascii?Q?+D2nQ/xJ3NSKD+ASRijn89POAX1vw17Opfco02tBEgeDi3TABhxbaGPBP/sl?=
 =?us-ascii?Q?8kNRBI8BZbdE92Vk7Qgrtm6mr6poAZFGc1V654qcUjrMdrPqtjp7vIcriNQS?=
 =?us-ascii?Q?Tz/RpLvSpve6t9CEcgbDpJG5IJlxbDplmQqT/oNLXtLtzU/r688ZETuSAM7u?=
 =?us-ascii?Q?aPF+ENVdnt031L9dzn00NajyPyY1Y1R6rgF5oQF5TeEsa53qzzuvAgLDZZuf?=
 =?us-ascii?Q?vB77ZWUg84+/+n5kKr4yE8q2noPxRHbmsBuQQcTEQfdNASK5G1AMawei2lBk?=
 =?us-ascii?Q?PY14ErZWbU5TUhRpFrudd5sCJGt5uHJEZeMdjgbldntu9Tpa7hjBMtFvdPWh?=
 =?us-ascii?Q?t4eX5SctISF/+Zb7DbNVIvoKhj0sHi1s1A9E8ajPAZyoQd+ignd/DcNp4ZYk?=
 =?us-ascii?Q?OOBSaE7h1gYG4b4fhnBRW1JUFxFsWPf137QYLCwIYuAsOvSMVazYRwLYlAP0?=
 =?us-ascii?Q?lRUoiqkoJntu9amvpdxekJWFdzdgyRXNur3GT8+PzgeXS4Q1nEmvkLadR0wX?=
 =?us-ascii?Q?yPzD2LxpE4jSgNbnKYgJ7z9PEmRbnoa0ZNa/RRMJ8fQsBEA3HtWf7AD1N/Wa?=
 =?us-ascii?Q?aA4+XOfKGPOpL795RELrt/t/Cy/G2UmP4aBwy1fjn+P11nkS4ekRAgVtZ8gA?=
 =?us-ascii?Q?M9qVxYJxCYc4uLx9SplZ7YcbNcN+HQsbWtIJaNdXiMnpE3vDJf/lQScOnEfF?=
 =?us-ascii?Q?VA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7035f64-f95c-48db-20e3-08dbae5a979e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:53:51.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4jdI3EdvK2SMWb89ib/7/QQUXhkN8eBiQ4AdoeRNa715OtYKK31NcyDaDlJsbnkKd/ho32b65jj1frVW7CdKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yanan Yang has pointed out to me that certain tc-cbs offloaded
configurations do not appear to do any shaping on the LS1021A-TSN board
(SJA1105T).

This is due to an apparent documentation error that also made its way
into the driver, which patch 1/3 now fixes.

While investigating and then testing, I've found 2 more bugs, which are
patches 2/3 and 3/3.

Vladimir Oltean (3):
  net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software
    and offload
  net: dsa: sja1105: fix -ENOSPC when replacing the same tc-cbs too many
    times
  net: dsa: sja1105: complete tc-cbs offload support on SJA1110

 drivers/net/dsa/sja1105/sja1105.h      |  2 +
 drivers/net/dsa/sja1105/sja1105_main.c | 51 +++++++++++++++++++++++---
 drivers/net/dsa/sja1105/sja1105_spi.c  |  4 ++
 3 files changed, 51 insertions(+), 6 deletions(-)

-- 
2.34.1

