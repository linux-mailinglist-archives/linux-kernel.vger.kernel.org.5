Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C251C76BC63
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjHASZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjHASZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:25:32 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BFF2139;
        Tue,  1 Aug 2023 11:25:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UaiEYWQZl1jnTfb9YIBE3sswllBDDjuqr6F73Nukp46M9fz0ThI3afa4z/ZfoCGrg6MONFwNrmVND6r1cyLHulhXsyhXAKu9bDXsa5355snOz2bh+o2QpyCtuM9+11sMGGDFd3QUm2A9YK6gl79QPzgKT2Kf/i+QwNSDWdM0fFZHPj9gBfqnWMUhl65FD6gv4gy1FFJA85D8hVpna6knZldCpQkTR6sglaPnbbxlQMKxm7VvxAUHCiCUUkjxZShPAS5fYvAW5HOyc6YMgX44BvfG4JwM9we2FXEVpeWcU6AnW9g6tGd0uN80j0mhHSTTthjKhcSFr0JAzAHvqpXoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PT2LhXAb7Qa81tvY13DJXGaa97oNVj+kSBsXvh0ysFA=;
 b=BR/zNIdKJOd5eXmggcBWvu3YXrz9XpG3EuHRuInxZzdHW+ap+ickPaqDMgPaxG4+M7AA9fsYPf3zbL2wBqUq5JZxWahzGF5UJP3lXGgdKCkBTmy0HhoinvK/XnOZT7Hu+FFlhCtkt/IQKzxUsHXUm8qO+24jyPv1uIBXE6TL/HWCJFna2lX6xBWvyclZrRFgeKPSw0QNKg6OcQMbtZJegrbZcrqFUB4rss3aYxr1XZ/UVhTk9KbuvcPI6gmd1aEcSGiWT2C6lyBV725vBYayOMmrZ0lvc8y4/sh5eZ3fekvpRv6eQ2fnZsaZI5myt/GepkL+tZhdHPWjmHCT+3Ek4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PT2LhXAb7Qa81tvY13DJXGaa97oNVj+kSBsXvh0ysFA=;
 b=STMdJaQLAk0klLoSBczp3GUpUIG0g2XN92eZVE/hh1Rm9QxpeXzUPFstUUAonyM4KnElWg+2xY7bfoz7HvRIisWXB9RBAytDdh7oR/UjmnCu2iMXY2ftEcFhke4jjwTGJnBGNrNqAudStPC7ammSAokeIhSC7evCAhUYzF+dma8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 18:24:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 18:24:54 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: [PATCH v3 net-next 09/10] selftests/tc-testing: test that taprio can only be attached as root
Date:   Tue,  1 Aug 2023 21:24:20 +0300
Message-Id: <20230801182421.1997560-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0030.eurprd03.prod.outlook.com
 (2603:10a6:208:14::43) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM9PR04MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c8ef80-3968-490f-68f0-08db92bc9a56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aGEytpl4HeQmpDSiuBvnTXvwxfjw8fPC9WR4cqjHso5g8vFjTzSqGlbd0PiuxZknNLf8+agpFdTN6jzGGnTwP6qvkGFsMsK8RyqOXzBhafLmRc2XCDpGwI/dW4u+ZZMsNjKP1dHo1NQV2munetvAV+JpWJ/IK+ijYR7P+fBuH/4/FRZg+lud+nxPh72AfyDZvMTzAZD66Z3mira3m3Sv9SeWRznrFSiPKHpfJLaEMrRITMUTrKr0X9HKb9VPGgwwpjzhYqRYr/Uw1NcBtSk3Tkh5YyMPm8c6WjrfbY3UvJlFMIXG7sUwNiNfjIPAn+X/KFdBFL5Pixq8He4OmP/5mF6gYuUAe+IGMUzuNw8o9Gw+xgmg05jlO0LhbFZYm7DNPJYiGPdHdnnuVyvCoXgp+/WR1PYPmTu8sH3hs7PyJBTgDLDEgD8kJKw1nLqp6gJT/noTelCghlKCT1zs3Ihi6cRHc6ncsQV3blIvzDLWyebnDThryEivaEZzw6YX6tR0GbiPHoUKzVo320s66bW/2EHKCfbdhkzLTq4dqJJYtdLUaDTTxpZeFH/KWqQbe6NHGYrgMtqRQUYwtIXSTEhdYoZl3z/H3Yu5gJF1T57UvWSx0SJC/ro8RyYfhLX51bhr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(38350700002)(2906002)(1076003)(6506007)(26005)(186003)(38100700002)(52116002)(316002)(83380400001)(2616005)(5660300002)(66946007)(44832011)(8676002)(36756003)(8936002)(6916009)(7416002)(54906003)(41300700001)(478600001)(6512007)(6666004)(6486002)(4326008)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZqPEqP1j0rQYnFqTg6QdRgobxHJGKIndg0VtJ7Mby5cj9yLU3YBv4P5O/WJ?=
 =?us-ascii?Q?Ct+UImR16JdHhuQVll3bfyTvqcUFWPrt4uup2e9fRBWghxsZMh8h0rf1uzp+?=
 =?us-ascii?Q?DcezEHp5f1ErXBotl08M7KH0eR3XArWyqcWAQJX2hBG7qCmkan1ZID6QLdmZ?=
 =?us-ascii?Q?tFkSKsKoAFwkrMN0Wdl/8++J2VIwKqozlcKQocFvJOWvwmC2+7DtLsi9/S+K?=
 =?us-ascii?Q?GoFCsh5Sd/1cc4pIdVhw6kNdXLYaeML27v6TXD9LBYolvtVq/jnTwI844sQq?=
 =?us-ascii?Q?H+oGcaODqRiXDcKPABpKEf4PdGjV2liwOI9xDVJ0Aw2FbpVZmVvnLAPKxz26?=
 =?us-ascii?Q?4m9mgoeNFI9dP6ORNP7Z6YtA+Z3FdQO5cu5cnlolrBzdHTPhou9lB6BrqPLb?=
 =?us-ascii?Q?+tuMzhuZwF+7qvoP3pEDMqN9aB/A74Cu96/0IeovCVPEU2PxqyDSmP0qOqdE?=
 =?us-ascii?Q?Kz557I4Y2mWDjAqgt6CWPBSlUIOuIPi1HuIF9udfnRWpoIToXaNeUYf1kRSF?=
 =?us-ascii?Q?TkJUVsyeoV2ICNTI1hH2oPMWgZHg5gw1CXdFuYrs4eibrqM+wzc0ZlDPGleS?=
 =?us-ascii?Q?WLmk97lz8obMnYEjYYjCG6FNEWnwrztO1EE9EO6frJ6UKdYPZNJbqLYGPFBN?=
 =?us-ascii?Q?53UUoKiDcfPgdUeeDVs5V3cg0f6hCVbn/kvC60XwqTlZrivL/E5da4fqEmbp?=
 =?us-ascii?Q?1yMQW8n0+0pP9aihUBFrDQ0TNw5gkyJysgZAtHHp47SBZyj0zSSgOtVrAgo+?=
 =?us-ascii?Q?8KRFF7o3uR/glw2AU5qJDKAHlx+U18ZApzIkJw0K0u+2YkhtPSQC3BJKvwgh?=
 =?us-ascii?Q?wxE4PQIvOiBkUBMuG63ar+2HPNUBJfEkk91ur18vWS0k4Gw9uTF9QApM9epY?=
 =?us-ascii?Q?z+P7MPI448LU8ydpnvwSVVN82rle//L3yhKD2ytwVr7l74hbzUGCHUJW0FjU?=
 =?us-ascii?Q?hl9cjVmSzS328CjXjOMs+BY1W5ammj6B4e9you9ndveKTy0vmJUNLuO/0Sgi?=
 =?us-ascii?Q?rDTRraybwZGKiiHTGxjZ86xLi18Szs3JYVM70Y5mBrL9FsMV+bqW+TMW6WZM?=
 =?us-ascii?Q?1LF8IxhUq3421xZMkoyovdUOjBoIV5EeXctVyJZarrF1x35F+6jVPrpxWWUg?=
 =?us-ascii?Q?afmvywirg+GerG+qN6Ujo3JaN0+BqpYDiooBnUJMZKrIkcGJCrAjvMD3HV2n?=
 =?us-ascii?Q?NY1zNfgH54UYVIl9KYpKzd90JJhwtVy52cB9dEvui5R2okmr/TVsPwYGvGIY?=
 =?us-ascii?Q?5aEPx6H0HiYVN36cdUilDT8SuY7EhDdaPTN2a56a6IMBqdIFn637NgLiqvjA?=
 =?us-ascii?Q?UjRpLdsu+kSs6hqJTKrHdst9I6I3dlDyBXszXhkWkKE9VfrOvWZqgVC/Exgg?=
 =?us-ascii?Q?6feEYYlRZmBJ6TUFFqgWFr4qD4Hn15ZC70OhIh4XPCNdjDO0X7Y3HE4ZSeMv?=
 =?us-ascii?Q?42Arkvk2P2HkuxgOO7Bxk+CHvDqs2e+sD/OMA/gDOe2B+NDidWgZnYY5eu7X?=
 =?us-ascii?Q?ubtfY/mihF1lX9cL/eQRLptlFz/aEHZAcA82P/tbWXI464VgT8PhnUFYtzk1?=
 =?us-ascii?Q?gO7chMikiw2cNSeerkiiOCK1X3FUobEm40iwG553RuzNBi36XEJRdanWQMt7?=
 =?us-ascii?Q?LA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c8ef80-3968-490f-68f0-08db92bc9a56
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:24:54.5442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9/EdROLb1rDcyCM96qe2HYF7Y/GzVNW18Nljnurz+KyFRWjvwoD8urDhGQaQLpaYpNStCaMAMPMYE7CGdhj0QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8796
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check that the "Can only be attached as root qdisc" error message from
taprio is effective by attempting to attach it to a class of another
taprio qdisc. That operation should fail.

In the bug that was squashed by change "net/sched: taprio: try again to
report q->qdiscs[] to qdisc_leaf()", grafting a child taprio to a root
software taprio would be misinterpreted as a change() to the root
taprio. Catch this by looking at whether the base-time of the root
taprio has changed to follow the base-time of the child taprio,
something which should have absolutely never happened assuming correct
semantics.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
v2->v3: none
v1->v2: patch is new

 .../tc-testing/tc-tests/qdiscs/taprio.json    | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index 68a7264e083d..8dbed66a9acc 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -131,5 +131,53 @@
         "teardown": [
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
+    },
+    {
+        "id": "39b4",
+        "name": "Reject grafting taprio as child qdisc of software taprio",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI"
+        ],
+        "cmdUnderTest": "$TC qdisc replace dev $ETH parent 8001:7 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 200 sched-entry S ff 20000000 clockid CLOCK_TAI",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j qdisc show dev $ETH root | jq '.[].options.base_time'",
+        "matchPattern": "0",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $ETH root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "e8a1",
+        "name": "Reject grafting taprio as child qdisc of offloaded taprio",
+        "category": [
+            "qdisc",
+            "taprio"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 flags 0x2"
+        ],
+        "cmdUnderTest": "$TC qdisc replace dev $ETH parent 8001:7 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 200 sched-entry S ff 20000000 flags 0x2",
+        "expExitCode": "2",
+        "verifyCmd": "$TC -j qdisc show dev $ETH root | jq '.[].options.base_time'",
+        "matchPattern": "0",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $ETH root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
     }
 ]
-- 
2.34.1

