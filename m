Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491F1772F07
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjHGTjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjHGTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2063.outbound.protection.outlook.com [40.107.104.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E771BFE;
        Mon,  7 Aug 2023 12:38:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YO9mfXrF4vBKoVKDSym9u0ZdbitkgkAvsKyqGRLdQPIuV0T3XxJkEHcTF+PEKkATvXOM3KS3TfhA7TIle4oHbJkLivujRedfhuAS9loRbI+VUe/CPSKtUDSTmmywkkjfZPIfcx03n4N9TJiRIovEFC63atz2zSDh1C00UReQmQBSduhz5WBVi8q20Kfl7KTi9BxX+xpwYh9FyvV94KlPBtD5apEiwxkGyn3QraikPyQppiv6JELKmWY4ReahhwMTsSoJ14FSt5ALLjTAsDA0leLDGgHHW43IuoZIpMSOIat2PeIe5rbrtchg/oX+HpiyqAdL+G1MoL1eL9qDLidoKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3xMrLEX1BqcLSxrITZlrQvBSaLNXcOGJHw9v5sDdBY=;
 b=LBBtWaevY0p5yAOIsGAMIO5emXWdgwIkEzsMc+EKZaIDmLYuUpMi4n0zNBFjeSMtwEAe2lMqRiNfC8SGdrpyUof4Rnhz4ijVS/iXk9C0VyMsBcIcxbew0sokKDr5YN3brEsXVU156/DBt3TQLJfrBdNWW+PrdfrWvjtJp8vIXDLzdX+WLz5Kl6bwra2lRq1sliQs6n55XnGtYLtfr+6dQxY2QQav20/HEoxyd9GvfHArVAkUUDAyyc2+vpZ6dRzXXqoISUgzIacnS/Jiv2haLrmJl/H9cUhXPFTsY7V51nmTE027oy/JQ5mGu5D6XiWWTQf8Va2OYkRVh18lEGjRVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3xMrLEX1BqcLSxrITZlrQvBSaLNXcOGJHw9v5sDdBY=;
 b=BMBeZZVc23cxdA8pc+GB01SLuQdCJJPtO5bSQ2wsSrpKbnTfnGu0EhkwT/8zidVgozdCuh+zBOHQX4QqDyIF16EZwjhNrA4KUL9Dw+6WVvc6UOX51+Appt5V/5ibxh5SDKhewpUFhrEVoDurtnuOjOKz4fFsIHc0qxCqBjToKMs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:45 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:45 +0000
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
Subject: [PATCH v4 net-next 11/11] selftests/tc-testing: verify that a qdisc can be grafted onto a taprio class
Date:   Mon,  7 Aug 2023 22:33:24 +0300
Message-Id: <20230807193324.4128292-12-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
References: <20230807193324.4128292-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0136.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::41) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: f9d84cc8-35d7-4013-b879-08db977dc600
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JSVevBwQgYa69oIV7J9hZ4EtXSDFcHR+CEqSYHBgVNR0FX/pIogbVIAz4zjaRT9uCqk2JLduXwFRVSnDDYVPq2E5e8Wpq9MNDazoceJJFi2Rj8CXK2CNhPaLMjC+J5GmVl4T9dc53rWX3P9vBuPyDfIIgtouFmjifgSKZMBSf1bE20HAOn8SNhEJ/pM6YcXeAtsypplAHoqHhfk7kFC4WJ4wVSpuaRiFSzX4D6aor2ddE1+4hE+8BqmMH5mDhxBCxqu1igyOzHoCKu5oQTh6isksFxfW2+7CcxbwwiAjWVXI5p2gYv3EhDd0ja2bYgV3CHPYz3eW/XO7VkUlEFpyqjkzUUw4x39HgodY64cG80879REDICRFX8E3VaorMsM376F7hrUa9nXEvEaISowuBS3vYidvR7eTrYpQGaz4x6xSQ9TSmTAX1TvDuIEttcMs6sgXv6XofjnqQGIFhTL/4hThBsLahOmzDb5I3h1GdPRXSFpj5tWb5425ZM/tZTGJ5i/bwCdHSeajIy/iZWb/oEHCZdPb/CK590WfFRMUMXWRYTq0M4/6NypeOCWAwE1fEVOWfq4QGhE1DH8Coh3c1UkcPi9f8YpybuI9lxWcu9Ixk9jIo6PKrTVckPqLT8Lf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(15650500001)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+HABeMmt2QZsAS1xllHzQmFQEv+VIkqz1IRk+A8UkTAYtLrv2VJY/Lp5w6N6?=
 =?us-ascii?Q?Q41AkL9kt23YQJgwO5LJUqUUnTb8EG8vLNR2qF+eam01Oy7fYh22Jx4yP5t9?=
 =?us-ascii?Q?YoPfgyFJ/C7YTxdC6H8sg+MoyK9Tl5mlB5TacXwIufJs+QfayE4x8a676b9n?=
 =?us-ascii?Q?xinz4KHdvkmXI2BLB70EVlJ4BQxaChiRR0HZmFathZIeDCB0YM418GeasoiB?=
 =?us-ascii?Q?y0RZ/2KICXXp+dZtsyj1TBsvwKRSV8CLTu9M+yddzZL3C7/hkbdZnpCQgYIT?=
 =?us-ascii?Q?557z1lbKDLbo8MTPaHvU1h4urXqq3LhzgbWBR/G/pwa/QV+mivsPPL2Tbh+3?=
 =?us-ascii?Q?II+KSzpJekU62lAuy/eLXvoNtrmx3TEqlRbpR4zX32ag4VReOPDXDFlcGWi9?=
 =?us-ascii?Q?iO7S6naVhJQMxLcT/i1cTIBbF/MMkzmbx8PKrqLXoAFl0rFbuiTjjGYYyvRi?=
 =?us-ascii?Q?paLdAaL4HZYWmKMYIYxQ1k+8mzG30CVF4YfE0I+aGoEx1Ti7SmCBZxWqJlgB?=
 =?us-ascii?Q?OeoVvdbFjHlVCGN29TUyNk9secVCTEHHwV0KeaxDSAakREjVycFoK+rkIFnC?=
 =?us-ascii?Q?wge3gE9rLy7ePruBofPzUkzfg/vO6WyMKN9x5y/1EmO7ojWaAaFgb55WvbvH?=
 =?us-ascii?Q?2nYpms0S7LT2yGbkmMZWYFL8a1L4/Bq6edNwYKaD/nDZqZCIYCuz/SmM0t+h?=
 =?us-ascii?Q?L1OjoFlJq829iOjiig3t1HMW9vEMgAtM27kPOhUdozMcdeDkairASJHRoCYm?=
 =?us-ascii?Q?53S2xNWbsY0yBCeq87PKYl/Pi+3Ko+hvM9VCv9XAu3AwGwtJpfmsiret4OiS?=
 =?us-ascii?Q?HcwQt+BUrUyxVACFB8/RCGVGVAr1l7499kma56zhAuGLFp2dPe+zoo8Sbe78?=
 =?us-ascii?Q?cBib1Z+SoCEF8o1ExIZddYT5CZTF35tXBjGbk2OoKHpTpeJuryP9Zp5IjLcF?=
 =?us-ascii?Q?ItOmP1wF/qiIVuys4i0jTRaxeNhAt0VO2mx82GyjXeMlkg1EzZiPeAB8Ku7N?=
 =?us-ascii?Q?XH40OTMl/KG+cPrDFV7j927eWcgCLPg6+nQfVXcWA1/p4vOGkp3xz0VwxDly?=
 =?us-ascii?Q?aseaw63OvGFK6FqBs6WA2C4JmHf9i6x/M0KguVttGJDq/S1tvgpmjpqm47Xp?=
 =?us-ascii?Q?dzBa4EKl80L+JN7Cb1Xf3nhni18oDQJA9iSKgjYe/uZ/aSlxSRcJe59iaULn?=
 =?us-ascii?Q?HYAof+2hrvdRD45sb7tcG9BZxstHTnHIHAFPCi/BDhBs6Mmh8+EYWgv1ON0E?=
 =?us-ascii?Q?UyqqP7lMYAW3Xjn6LHeDUyxPlb0wg379bvw3wVcA1CMd6o5qLHPEqJ+7RFs+?=
 =?us-ascii?Q?pQp9nxsWiNZ/DsSFa2aRkPKK7So4+bXaNvarhHxkOYslen/TnVqpnelBrsZd?=
 =?us-ascii?Q?Xv7wdEKnjX7+BI1mKnGOCO3lhAVMsOcLw8OYd83pjHgWzunKvpicPvor9B8Z?=
 =?us-ascii?Q?E//C0WWL+PGFPljsET/6ZkZFn820vwv8tDm1swUpNVkkdK9nhtUxSl/mqtQb?=
 =?us-ascii?Q?RQ+oy+2P2rUOam/5tuYMfpnvuEzzLCe7Imra81flMlMJ3sWmIRSFZD5tw1Yl?=
 =?us-ascii?Q?t1M8gGGHDfYmvmhfYeLG0TnpEFjOQMNrMoGoDBIwDfT30jNR1MDwOyUjVbPL?=
 =?us-ascii?Q?rw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d84cc8-35d7-4013-b879-08db977dc600
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:45.3584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb8k29buXQruybpWREu5pL7/sbnmoWmCU42WpU2Z40n9ELoTHalOGww7QaYqTqiZdiZRRfdLZtHGuSdI64kDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reason behind commit af7b29b1deaa ("Revert "net/sched: taprio: make
qdisc_leaf() see the per-netdev-queue pfifo child qdiscs"") was that the
patch it reverted caused a crash when attaching a CBS shaper to one of
the taprio classes. Prevent that from happening again by adding a test
case for it, which now passes correctly in both offload and software
modes.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Pedro Tammela <pctammela@mojatatu.com>
---
v3->v4: none
v2->v3: fix expected output for test 6a83 (missing "refcnt 2")
v1->v2: patch is new

 .../tc-testing/tc-tests/qdiscs/taprio.json    | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
index f475967c509f..0599635c4bc6 100644
--- a/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
+++ b/tools/testing/selftests/tc-testing/tc-tests/qdiscs/taprio.json
@@ -206,5 +206,55 @@
             "$TC qdisc del dev $ETH root",
             "echo \"1\" > /sys/bus/netdevsim/del_device"
         ]
+    },
+    {
+        "id": "a7bf",
+        "name": "Graft cbs as child of software taprio",
+        "category": [
+            "qdisc",
+            "taprio",
+            "cbs"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 clockid CLOCK_TAI"
+        ],
+        "cmdUnderTest": "$TC qdisc replace dev $ETH handle 8002: parent 8001:8 cbs idleslope 20000 sendslope -980000 hicredit 30 locredit -1470",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -d qdisc show dev $ETH",
+        "matchPattern": "qdisc cbs 8002: parent 8001:8 hicredit 30 locredit -1470 sendslope -980000 idleslope 20000 offload 0",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $ETH root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
+    },
+    {
+        "id": "6a83",
+        "name": "Graft cbs as child of offloaded taprio",
+        "category": [
+            "qdisc",
+            "taprio",
+            "cbs"
+        ],
+        "plugins": {
+            "requires": "nsPlugin"
+        },
+        "setup": [
+            "echo \"1 1 8\" > /sys/bus/netdevsim/new_device",
+            "$TC qdisc replace dev $ETH handle 8001: parent root stab overhead 24 taprio num_tc 8 map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 base-time 0 sched-entry S ff 20000000 flags 0x2"
+        ],
+        "cmdUnderTest": "$TC qdisc replace dev $ETH handle 8002: parent 8001:8 cbs idleslope 20000 sendslope -980000 hicredit 30 locredit -1470",
+        "expExitCode": "0",
+        "verifyCmd": "$TC -d qdisc show dev $ETH",
+        "matchPattern": "qdisc cbs 8002: parent 8001:8 refcnt 2 hicredit 30 locredit -1470 sendslope -980000 idleslope 20000 offload 0",
+        "matchCount": "1",
+        "teardown": [
+            "$TC qdisc del dev $ETH root",
+            "echo \"1\" > /sys/bus/netdevsim/del_device"
+        ]
     }
 ]
-- 
2.34.1

