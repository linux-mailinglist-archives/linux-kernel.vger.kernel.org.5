Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DA9772F08
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjHGTjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjHGTi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:38:29 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2046.outbound.protection.outlook.com [40.107.104.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9401FFC;
        Mon,  7 Aug 2023 12:38:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZeIpxcy62o39xSVdIHpfAyjFkVNYjJT+Cxy16i16UcJDlpOdZ1BuRcnwk4aGfbvxNalS773TavzFXL5Sys8/6gmlHplDOhwjg0RZtAYXhAa00zAFkGv2TsNy91wvcLyomUytM9Lp1p5cK6Fc6oy6N684HSdmPaB+OxgoBjPydCIVHKuvujxrHQtqf8fRqgrbB3lVZEsD7PSjYtfRBQRWXAcDMMd46pTflhr9wLSYrMRL7Z2B30PbVmmA+6vtMHz53QpoOOXVbRKYoKqnCZoSewXS1qYZnRKeVT7q7j7NzVDNPKsValHliKSd3JGVv6OzqRz+6lhQOt0c11KNun+kBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec+hvhmb1NwBXUODdrdxAAF6frPZkuXpBjTF2kk5A90=;
 b=ZwQ3iEjdJXcHWaC7+eXWFtlAiGqFeoM86t4P6VHdUL7TfaJxKmo0yR/TYZyRS8LXcp0HfIP+4EgsgP9DO3JQzfsYyzr5E6b5R7EmQ94Y5pBIZWPrjYRBODq1MRf3tr/b5QG+Rqvj4Omab7H4amua/Bss2G6gdvd3SLdltMJZ+uAqnFFeV5iN2yeXhwOfKXJE9d8Ul4yf/ZSdcvo3beQfO1JzslYJ82hqWq+S8wDd3TVoIk+Hw1sxDocZ3JyWUj26r31ukX7X7DMWCpZBGrTMxKeDjVc8Xji1pXRkc0J6WVsnZZLkoPrRb+WO0Y2CzQ70/KI83QZemLpPqGiWHgGAmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ec+hvhmb1NwBXUODdrdxAAF6frPZkuXpBjTF2kk5A90=;
 b=OFbysyCqBRRjwmNbNpmtXt8MnId5CG+Hkd3nEhHh/yKAkW4+2BRWdQJxUxWH1Y48/9lOO7y5xJyowR7gERY757ok4272fTxpf6giJ9UiMrZIKNboBiNp04GOkZE7NARbRipECvgvmvywvKZoR6z8VpmEbdNjyyJcsZj9es6Ym+w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB9451.eurprd04.prod.outlook.com (2603:10a6:10:368::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 19:37:42 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 19:37:42 +0000
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
        Maxim Georgiev <glipus@gmail.com>,
        Victor Nogueira <victor@mojatatu.com>
Subject: [PATCH v4 net-next 09/11] selftests/tc-testing: add ptp_mock Kconfig dependency
Date:   Mon,  7 Aug 2023 22:33:22 +0300
Message-Id: <20230807193324.4128292-10-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 04863b86-9d9c-435f-0998-08db977dc488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: McfWql2TkZYnz0orXTOgtNvNcda/xnHkZFUGvrU9VsLQWmt0oxrTWjQVKjifS04fIbrpFiy+r32LHhSNovfJj+5tCxsqOk93Pk5+zTwesbEsys6bixdBDBkenuJrg6il7hU1MCd8R82HLC4IEXDxdAPwSjw0G3IS7EtoTdqyeauCnp8BKnHmD41eCMv09fchQXFBSkEwuQ3RIshLcA4WJe7V46jgCcLUSRJ+o1yirM7ycHI0q09Vy5EjlhmPIiMbIvdFn45Yw9meiuVH9lF94wSg1FyXHp/pkDZ43DIJ0UxrT3wqLRvL8PxzhAwDUiy3MYSw3y6NTaJdl/YDRLdFZx9ev4kxhbF/03w2PbMxsVBwKITbxXE8MoRRWm+65RO5RFvVdfoEl0mRXthFlNJ2k57wvTlxyVw0Jy9HXvdzPfhup8u+02/AsSHS6KqI9AplZJaBF4aEJBAYF4u0JYoSgogQWiIAr9uwz7uEfrKrEv6P7XJFgLrt5ZAiMXv7hQxCmndWAdPdf0Jt4RTi0Z0csEABEhF/7KsCUcPR7Ivh+/R7NT6WZdvNJc9Lx6c6IXI9x00MCom8ZMdC1+3GIO8rtNT1BmylnIe4LmpJ+Vd8wODZMgBsuckG1Cw0/+SUdTAt
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(186006)(1800799003)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(44832011)(83380400001)(7416002)(8676002)(4744005)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(54906003)(38350700002)(38100700002)(6486002)(66476007)(66556008)(478600001)(52116002)(66946007)(6666004)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IvcgsayO5XijRQ+jLGsD2jEu+MaUOiZRuD5e11b/3aSdWMOBK4b6Z4bBFHXg?=
 =?us-ascii?Q?Pko82sXb3EyIlAtWlofVtyFFSuPiFvscG3NqBhQpOXmwN1/ElxnxvDiemNZr?=
 =?us-ascii?Q?rq2LxtctMGFpsp9fB7vDCouVnRTDhFuK2j7vV4V3NPPgnziNMYuBhli5XF3W?=
 =?us-ascii?Q?2pZ+zgB9dMSOpnyk1YJB5wKssm7LqY2yDHjMQb+w5iuyBqDB1kFW2M4Ldz8/?=
 =?us-ascii?Q?MclSC+RWrDHopQ9AdDoSpJosIgme0/Lu4/iIsiwwwSlbnk+cxFpKj/0WfnSo?=
 =?us-ascii?Q?qTm9FKk/n00e4lZFUFH1zTEn0QBZTGzpuBTwuuGafnrMRef9EathS3nS4gAs?=
 =?us-ascii?Q?A8d20jJa99BKyFY3g2BPIixsACZ8xlzuIJffHjP6K9DVmJkb4bYs4YK89NPt?=
 =?us-ascii?Q?T4EWy+kR9Da7I9EzlEMt0lvEJTw++YHwfmCytJMf5CjgV6TIqwFnCJS779Qj?=
 =?us-ascii?Q?3EfmBlTC6OdF6XhQkMGmX8eMkxbIOawn3OoQ1hIpuHJa88Yjt/4kWSo4SaGz?=
 =?us-ascii?Q?CIWFYVcwi7GOOwhl8OhdmsZNNoWjAR+r+IgLs1KJzYSCuWjTKx1pGE4bQqF8?=
 =?us-ascii?Q?/q8BqjBxjcPbSQOy20vGXwQ1csFinpTDE8qjJz8RhomA8bWJVNTBqXk3wxEJ?=
 =?us-ascii?Q?Ip/LQZkaWx/ydNOFNikrLCKI+mrJbsMobNRvffaQKZ6hLJXd7ZLeRkFiFMBr?=
 =?us-ascii?Q?q542cyXhNQ8frBarpsCWwiZEgrb7k19Ga54ENZygAkTkoWuJxjTPGgCMFXCp?=
 =?us-ascii?Q?Fb5qjHVser47W5uRNMdimCmxsALwLjloyCTDPYszpFQym2KIEQgit5JMAIK/?=
 =?us-ascii?Q?k3axynhauV8mJp7U9G9+LvplSpN8NjSHyWY9QOclaZCjSVdf9oU6NrQp8L6D?=
 =?us-ascii?Q?I2OvDC2FbYMhuSdojBqx8lirCEYRuPVxK7YuuZnEQaUYymF2njxP8GrgcZ0r?=
 =?us-ascii?Q?BUCLSKWYf4vTBcT6NglBLqyjPA20lAcmb2TuVDikLQEyh08PI7F7tSwwt3Sp?=
 =?us-ascii?Q?1PU7E/qmEqxYZ11kLusgqajBOq2/mWmyQcNDrUNqiXO5VFxJ48h/ORElPDxB?=
 =?us-ascii?Q?V27qJx4VNccHjEI4NS5A08BhCWjYuCWpiLmlmLwq8HqB487N9MzjeJKPonFr?=
 =?us-ascii?Q?biuxmCnbxtix+yliPsaSXtGt4YoFYAYofGMkdTRU+ssGTIHxHbz0l7p9HpY6?=
 =?us-ascii?Q?58slRz2bDIKrSzEuQfZv8Ca4TS4KhAJVespHnTE9tzgfZcYYoaCWxc35mqim?=
 =?us-ascii?Q?XVHJBYw6Obdh6QjH53bnxUAYq0O9TisZOOi3J9MDg5C71SydCrHqPkljx2g1?=
 =?us-ascii?Q?sHM0Nq9kzfG9+tWdovf1KvpHqK8ofzyETHnU6FcqDxsA4IyM3IZIuVraKi7v?=
 =?us-ascii?Q?ox04xren1kc3fU9A8TTPRJF5yYngc7JyLRmtR6G07tPX7dBTml6Vd8kGE0go?=
 =?us-ascii?Q?8J/CRYBmoiZiLKqHBF4XbtXfn+uydTgjeROpTJlj8vBrLdExGEAEcYPNa4Z7?=
 =?us-ascii?Q?4FecOB9+AkkWAPIz3hu6GMujGTRTsLTSsOgn7TEfsqVRNLD6odywgPzKSNB7?=
 =?us-ascii?Q?FSWljD/VDRx5HhGvd2kIIIgmpHLykNO8kY9Fi9OzivLetM8yFMWZEkCKLCMK?=
 =?us-ascii?Q?6g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04863b86-9d9c-435f-0998-08db977dc488
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 19:37:42.8449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TDFosRaq86HeAlgadBmembILNk+XdIw4XGPOvFEAQ+AqQUQtkyRLXXETpy9hu6dh4UJMyH+xu5E87F41PWlnNA==
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

For offloaded tc-taprio testing with netdevsim, the mock-up PHC driver
is used.

Suggested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v3->v4: patch is new

 tools/testing/selftests/tc-testing/config | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/tc-testing/config b/tools/testing/selftests/tc-testing/config
index 71706197ba0f..5aa8705751f0 100644
--- a/tools/testing/selftests/tc-testing/config
+++ b/tools/testing/selftests/tc-testing/config
@@ -96,10 +96,11 @@ CONFIG_NET_SCH_FIFO=y
 CONFIG_NET_SCH_ETS=m
 CONFIG_NET_SCH_RED=m
 CONFIG_NET_SCH_FQ_PIE=m
-CONFIG_NETDEVSIM=m
 
 #
 ## Network testing
 #
 CONFIG_CAN=m
 CONFIG_ATM=y
+CONFIG_NETDEVSIM=m
+CONFIG_PTP_1588_CLOCK_MOCK=m
-- 
2.34.1

