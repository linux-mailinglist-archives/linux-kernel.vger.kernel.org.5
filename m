Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5327987EF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 15:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243148AbjIHNeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237530AbjIHNeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 09:34:15 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2040.outbound.protection.outlook.com [40.107.22.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDA1FD0;
        Fri,  8 Sep 2023 06:34:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4xZdYPFLNtKyvUkTT+aByqCNWggxW+zCYVg5i01Elb8KV0eYL6sKveNJysAPp8YoM23u4auzeJoxWokgzHW40UvxzoEC3h/G7AzXKYmuM9GJ7gdgb6C55Zdr0tsC6ySbOHUm6Qmuec8LexhRIVfgAyUqj81MtL2UA2hIjsQYtkbBdrB0NhVR/hUR1MsGM5l65A55l1PH1ey1nqG1lZ4fF1fywdMkzh8gEplzY+05R3TQwXVNCaHjs0FdmuTAgD/xUqQn/VVLKolh5tAK638s9AnT/utZzNwIaXtY783Hf/Q3oots9ZF7NCzINkNxDu6UTDy514Tsn2/ZgcpKyUSeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfRCwM/U35hSsAtCOa4WQ8WoLPqqrD9RsWsa8QHdcfs=;
 b=ePcxh2Anw2DAGdItHheP8T2FBmKPT9qmC7IqQU6GYT38jAV1d0Z5qdc/cIRFuda6R7VpavIIUWbYp+0SmWPQTSCyFAbqMeY3u8rvh2h/Np8LUohZkmuB0FufB8YvdqCmVQN7BcLU/A8TPbH3OfUQn4xXhLYdQ18aUrdqi1vyeTBNytYVmdO58luQmlIpl01fcwJZssgsr9sxbAU6HaKtyKL0EwuHs8l6jl1Tys12b+dwzlIot11SmZ1Us+9chq2JPYmavI5tQMONNymkDdiiiK761rzGQj23MWyh58eqNhRt4RiDRGfREeiGmO+3COuaeJhlNB/9Bl9d2+71y0QFkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfRCwM/U35hSsAtCOa4WQ8WoLPqqrD9RsWsa8QHdcfs=;
 b=eIsZQcSkWdhtWgwPOwkcTOn6QAqsasACImXDc/4Z3gJ/JuEy8rHOxV7CobP4UoHrHXN/40Jdf0Tx09YNF4GTYIPDWZtYOI3ky3/PqIW+6W4BEMIEdX1fXW/x818VkYJCNV7Nm5pP9mgC7TwtYX2gZ/lPg1Ja2GNJlb4z3TmpieE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9718.eurprd04.prod.outlook.com (2603:10a6:102:381::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 8 Sep
 2023 13:34:03 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 13:34:03 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/5] Fixes for SJA1105 DSA FDB regressions
Date:   Fri,  8 Sep 2023 16:33:47 +0300
Message-Id: <20230908133352.2007218-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0036.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::23) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9718:EE_
X-MS-Office365-Filtering-Correlation-Id: e71182b5-d7a1-4b3e-361e-08dbb0704438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sZR2nWgCtRnqH1Wd+NS9tTHrpOBIXE/EzeF/1uN1XGOrWB5FlMD8syEHD/35RRZ8cZUmO15DLIIhPEG5vCjDjEjVFXCYfuKRN+sRAanbysmAKVkIC8InjPi9fvl7RU9FpZjNWiqUgRPWJwNkoqG7xTGzlfxcPRSbkYCRvj+S1Zt25Nv4GlRS9sFFNmUikSiXUp1WV6gUTbxPr2esQHPMVR6GVCtlQ8xsIaJYZ5BtuX7Qe8AD0ubOq+zFhwp2KXZGewllmvUPsVQyrrZvj5tX3adGv6+xsoPtR29m5G6cF02pC1iHXNAWx1hEkiCydfMA1IIgcgdVBSAMnPx3oJBWDW/nLEIrfSMKja/nG3CuGVvB7UrEc4AgyelKpDiTlUpJnWql26AssPGgRJjDJuPQE2jJe6hZkWs3k4nakMK8IZ9QW1O+zu+Q2a84j2A4Re5JxKL0GfhosgVaUgXciMhjDSvtTVG0r/D5ojNMGuJVjqQVRpgvua37Sklhbbb32OscfLtYEG6SybGAgZIWtLR649ir2/zooBXz4eV7vRqCyfiNeovivoMZPOEX6op5pvd1aGtHu97F2j8NcSKkqokSBhi//oHbcW/yH2GNlkbySfc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(1800799009)(186009)(451199024)(2906002)(38350700002)(38100700002)(36756003)(6506007)(41300700001)(6512007)(6486002)(52116002)(66556008)(54906003)(2616005)(66946007)(66476007)(6916009)(316002)(1076003)(86362001)(8676002)(8936002)(4326008)(966005)(6666004)(478600001)(5660300002)(26005)(83380400001)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bMLsKtQgNDupTWMQklugsa3ZziyuY2fhuFdfzHufAWt1Z7hldgo9NYCK6vi1?=
 =?us-ascii?Q?hdwriZIhnCWONRM5p6pfzpHrQRmaLDhpkedv53mSfTuPkjmwKIM0ridkV9Jj?=
 =?us-ascii?Q?PqFcutFgC2U5JVZVakwo0alySjiF6kIoJw9pErF2nvgtmqE7COT6xEPDykze?=
 =?us-ascii?Q?L0Fs8L3W+6uvRgdow/84dHnkPbKN0dXZLFq3D6zNIi7c/snzvoacMgjmTTnV?=
 =?us-ascii?Q?tPVy3cbpnM+ItLnBOzKad5xpWyYSzHhrdLsIDL2yxmLXHj0O7322u5FRxehb?=
 =?us-ascii?Q?Q17EIRcp/E8FED0Zf9LBACzIqG1ODlmd/VB4ANW7KhrL5svFqsiNvph2sKfL?=
 =?us-ascii?Q?KevXov3WB+9UekkFuxI/+qDupcm6Idf2BlhoEMrBZeiw1uArElBjzA7lR9QD?=
 =?us-ascii?Q?uMi1l5nkWLTKWWdFB05TqPiJlFXxKEh/Mpr0C7fPS9lP6G2UFovRMQ9dqcO8?=
 =?us-ascii?Q?L81Y+6btWopY6sUoVfcMP2ypXcR1wdAR6AbxGV+8GEFK6jzjrJvkRKKafltv?=
 =?us-ascii?Q?5/Qye9J2i4iye7EPEf9BZXXO+zdu24ET4IJhEpP2UF6EaMb5bzF3ocKBEwri?=
 =?us-ascii?Q?hcwCJD1LVqTE1fIPr1lIGw59WOs5QukgLxlYNLII9QFTO+BUAJNC/fO4s9wR?=
 =?us-ascii?Q?ILRV5HWD6S9Lq2pJsJjw6mZLnYz31PAD+c3nPjoc/bwD3TQR7I8i/RbeeS5E?=
 =?us-ascii?Q?ga+EV/uWUdJzIuQcfVxYueO6z4ROTPGiNK69AmujijHWSsTAxQBrt7zR8Ifb?=
 =?us-ascii?Q?opgEtmKaTgmiyedKPbCLTkr/+aueLS4eZr1SqPud9yqNmrJDKG+Vx0+CiS74?=
 =?us-ascii?Q?oFsHGulUaqYQ+zd7uX5Qp77mrwF+EY46jN0akfINOfyFmGJE24juf1TBK+Hj?=
 =?us-ascii?Q?EjV37vhQoYC9eWB60lMgLYgImmE02Oe0lFvL/dpCzVg6P87LAirM00gXlbON?=
 =?us-ascii?Q?5mYdOXcl5LcHi5uL+WuAtFZDfrDFkpStZQyuUyhVM3anC9FSJF61KsNeLQGq?=
 =?us-ascii?Q?r76kaZJodKJCjsUeBfDKs89/Z+fbtOcjBqZgtU/K5PdiSgeisksI7lvBjZeN?=
 =?us-ascii?Q?M4S57tw+7XqNvWb7KTnzoSERq5YvnNr1ioldAYV5gw0M1JM60vK450QO83aW?=
 =?us-ascii?Q?d5JDphsoPArtobOwsh/Unp6Xc4qp/7uX0YkQMzJI8KnHo1nnLB191TcGJUla?=
 =?us-ascii?Q?F20Bkqc2jtzsXKLSHypOLcHRfnSjyTov/ZtogzXI4OPC2/GVHx6xsodanLXv?=
 =?us-ascii?Q?ZsGN6CAQbqvIdYXNGO3nMSpNrfx4LUls15j3kMIRd3NIQ9i8hT5wk/xnb2x8?=
 =?us-ascii?Q?kWIH/cA9VexMGv18OC6qHcJqmR0wEaoXxEHOxsi0PIokmmyLUBKZEu94EAQK?=
 =?us-ascii?Q?J/85qzLUHqDLr5lNfhWEXV1W1gvjDBQYGy5UFusDvzENtKFMrZbh4goTR98o?=
 =?us-ascii?Q?dMwvQMe9nQNtHP+ABVmIiuT4Hx9k+cSeuZqgUvY9r08DZ8BqwR7Gaa3411EA?=
 =?us-ascii?Q?5mwGfYONoPNZgClGSRHMHV0gtMuIKGWbPIPPrwS782V7iMbYNmdM8Wh3rMmN?=
 =?us-ascii?Q?0ZNQYAOHV6KOhC1osVZ0oOTWPscN4vA7ZmObDOXEbRNTk+OMH/aGIl38Tk9E?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e71182b5-d7a1-4b3e-361e-08dbb0704438
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 13:34:03.1922
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InF4H1JBRNEAfruYM61k+CnTWpMRoaaJXaZUD7qRE+8i4StYRjwHs8GTlarAYshDv9IjYFvbLBVhQvP6slFkcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9718
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A report by Yanan Yang has prompted an investigation into the sja1105
driver's behavior w.r.t. multicast. The report states that when adding
multicast L2 addresses with "bridge mdb add", only the most recently
added address works - the others seem to be overwritten. This is solved
by patch 3/5 (with patch 2/5 as a dependency for it).

Patches 4/5 and 5/5 fix a series of race conditions introduced during
the same patch set as the bug above, namely this one:
https://patchwork.kernel.org/project/netdevbpf/cover/20211024171757.3753288-1-vladimir.oltean@nxp.com/

Finally, patch 1/5 fixes an issue found ever since the introduction of
multicast forwarding offload in sja1105, which is that the multicast
addresses are visible (with the "self" flag) in "bridge fdb show".

Vladimir Oltean (5):
  net: dsa: sja1105: hide all multicast addresses from "bridge fdb show"
  net: dsa: sja1105: propagate exact error code from
    sja1105_dynamic_config_poll_valid()
  net: dsa: sja1105: fix multicast forwarding working only for last
    added mdb entry
  net: dsa: sja1105: serialize sja1105_port_mcast_flood() with other FDB
    accesses
  net: dsa: sja1105: block FDB accesses that are concurrent with a
    switch reset

 drivers/net/dsa/sja1105/sja1105.h             |  2 +
 .../net/dsa/sja1105/sja1105_dynamic_config.c  | 93 +++++++++----------
 drivers/net/dsa/sja1105/sja1105_main.c        | 69 ++++++++++----
 3 files changed, 97 insertions(+), 67 deletions(-)

-- 
2.34.1

