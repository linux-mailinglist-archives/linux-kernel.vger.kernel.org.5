Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DBD76BC5E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 20:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjHASZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 14:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjHASZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 14:25:11 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B912B2728;
        Tue,  1 Aug 2023 11:25:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ValAV+BmyovPeslh4uGeZuoPjNcR87+iPeOSfP1vLzN2cx1vPFd57Ut0DItkjOgC+IY7U/ljodOqRuroCyZxWFMKcudt8b7HJgECCqGWpa/NOQOLQ+s5U3PnKm8cooomw/hBj0oMd6SVcAZJ/SwfqGgXs+1hY2o3jcRrog3JCiqY4x82CXtLBC7sRumLiSwu8/wT0WTy60U9pFCHskJrd/nzgocxzj4DfD/VdFbRONBWJ89bgHty9yjBhF8+9FPM5QkTG6a21bF6zXqPrQ/5yK29cffMisSkmKblZHf+JW41QpSYMFGxqvYrcW9/eVQsv7M9zr1fymzwTFHVuyIMgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dQ1biz+GMDeevePHIYlGl98eWqf1lm3CJlwz5nPFALo=;
 b=nQ69he8G/dWANHCHbmwrFFMe7JYndovUA1HNlHVCgNJoF34b+Xd/9BHZy4T0xPQ6NiJAuGCuJMJ2RVCyYtW1jfuTE2vFxb4BamjGRJaTu2LAuccUiOfxn4oISq004Q/okwaxm0OEqhxkbCQzKCPkY3V7D6Cz7ThZs1R0XbINLdHZbjesRlLaIcxjaG/m2RWaIKhxHAn1Ua+StWDpvQW2y0+92uVU0pk9hSwdZ+z1coi1r/OlbFnZuEX/y3B3FXd48gzIsEk3aAtR0KkZEvrGUWHwP94vN8DGs0Qv5xW4/PgKqxfa4ONinjHJr6/DQ2Lx/WBjuaAHGFnv7Zc+XXAR6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQ1biz+GMDeevePHIYlGl98eWqf1lm3CJlwz5nPFALo=;
 b=GRPXsQfPew1vwJD0Kk2wCmfvXcm3ui4slyC0Q9XfjVumg11ZpGH8F7whrXuKtz2lwvniQm0luoIYf+0GhvFdfd31fmbgIJjCyHTXg67psF2r1SYf2ImDi9OIPKr7efDxlNkwP8is3MoRfY7NBuKknja9J/sDdwyYVeJ2vy80tUM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM9PR04MB8796.eurprd04.prod.outlook.com (2603:10a6:20b:40b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 18:24:53 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.045; Tue, 1 Aug 2023
 18:24:53 +0000
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
Subject: [PATCH v3 net-next 08/10] net: netdevsim: mimic tc-taprio offload
Date:   Tue,  1 Aug 2023 21:24:19 +0300
Message-Id: <20230801182421.1997560-9-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 55e73af8-532f-4bc8-2422-08db92bc99ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3QiaRFZjbFFx4CpEGKOEOoA6ASQTIFAOAMUWzX3W3yTJpmgS+ZgWYBmj8ItMCAoA+U2v99FJi1zK6wjVKOV6ZNZtSRZdKBtzHToOsYbyh4Pv3bqR/IN2QsOixWpyth778lAeeQ9sEnDlVqfIcabixgENoGzGFfwlp7OF8pbKrrKmRPuF1j29S6iBsvPnbmrekDffY+bVOtP08tI21vz0bT9a7aiyGC2UQjN5bq2bfzThJ/bS42p1B5W6t5yKm879//gS4WvjW40qfpZPJm33g51TMqEpnegADs6idKOIczDMT12AiJuHq6Ry74fP1j95Ks0x+7GDoCl4bGNX+zYr9Bef2DqNXaulCxxW7WbknRVnTWglZThyky1ES5PJv7eFe1a1DuZAJCZZOjvNr+I+7vzYz7nIOCsTjmTjGI9FcabQqe4EpXNvv8OgA9Np9T4DaCnaFZ2mBuzlH+8v7G+pPFLelssF4Xc7PsYcIKuc2PRvboCO6kVQceYL0TA9rWHascYaL307MD+eJrewo7rajQPh5uIiIf41kyMzHtg3CQZ3X2GP8gNMbGvFT1MtvjR6Mje4BBQDOGndc9qvxQbQlQFM53ZdlK7HCWsFL4mAKRYGDyQS10rczmtUjgUYXeG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(451199021)(38350700002)(2906002)(1076003)(6506007)(26005)(186003)(38100700002)(52116002)(316002)(83380400001)(2616005)(5660300002)(66946007)(44832011)(8676002)(36756003)(8936002)(6916009)(7416002)(54906003)(41300700001)(478600001)(6512007)(6666004)(6486002)(4326008)(66556008)(66476007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/wJYYtb1dzVRjZybq1pCqQqktCca0PEr8ciSlK9jJ8ef6a8cfa0mUXTXeDZ7?=
 =?us-ascii?Q?9sltutnWbVXza/A03cDCwXgvBo68C3Z31UE5AjXDvKzNE5SDV1HJa8rwt7Nd?=
 =?us-ascii?Q?tA5yzGGp0LmHWkzzVLCg/EXE83w/rhp6T7Tz3G4LzcGmsaGdrIIOhXpurNv3?=
 =?us-ascii?Q?WDB4i17Ld7hieTnvZsFtdgKRXBQ0bOnABjoOnjQWDJm67Ro8vbJ23gkd6pvn?=
 =?us-ascii?Q?qt0InIpsw87XR/LUxHLKmNs6LMHvk2ZI8zWZyn+BdLgL+BoeRbp95IgyVyQB?=
 =?us-ascii?Q?E/R+xU3UtucnY0xsBfJbYbGSm3p+YnC4FDwRtVUT92bZtMy/eAvR+xD4MFFM?=
 =?us-ascii?Q?vXdy8q5NYD60HfBYTEipm6zwo+Cnoycn81TXdEu+ujT03n8GtuKwKsalFE0Z?=
 =?us-ascii?Q?1RMFJMwMFCzV0mERPt5erJxbd6P/Di1u9HPmRnY7mNxcERwYV3DfY/yWX+4q?=
 =?us-ascii?Q?OTdwbvy47zB4CET6CsUn02pBtWAdkeNS7VtzRaJtJVeWKT+3jcRcgFQoeLI9?=
 =?us-ascii?Q?EDUm0ZaBs9+Qx9wUNcK4hq0Pw9XYLFMmChdLLq5pr3Bg60XBJM8adc0o6xZI?=
 =?us-ascii?Q?i52DL7VnDJ1CFh/+8WspDeiLijb7KRSvQKoivIL+cbLYRrH9hTYB0JqgsnHJ?=
 =?us-ascii?Q?YIcjGgMMGLlUXJOLkvqsBsyildfUu7GPpvR7cLArAefUQeDHuFEXMrRWwrcf?=
 =?us-ascii?Q?hG65BwlVJW/zIiwPg0va3+woH6+btku8Pe3mjHGzZLZh4bSqVD40myeIxq8/?=
 =?us-ascii?Q?OSyegJzAqCY0ps6hafqGo3vdSBWMXw5ZINzSR6nR3oZQczPYbaPAj6TbYGPp?=
 =?us-ascii?Q?8gYvdgzah61ZO8WyhCL0YuMSeh0/WcbmJbECbCmHUnyn26fml91lxSaVWjTs?=
 =?us-ascii?Q?NJUd+yM2xmzrZUiFiI+I82p/RCJKN3bCPMBd61EniJMdBeAcnYXDYNgYXCDF?=
 =?us-ascii?Q?EW+/CrsYpa1WuTnxJqyAhfNXK3vkBMVwLp0ow4VOFqR2YuI4UxqG4dyGJ4zF?=
 =?us-ascii?Q?3ZH0NItzktbfQg7xo5Bsdc2m7iIuvzEnHD4BSlpOixywghjfX0mZSHKSDOPn?=
 =?us-ascii?Q?t/WY/E6cgOd3qLMsmiInR6xXZ7bmfqn8TBIQN414AmtKmsRRf4o9aDYLveyK?=
 =?us-ascii?Q?96V3w6xS/1GBq/0TfE9v+Wwt1XKoK8zYzVE3eu+7JBWAgaqfXk77KKajCwch?=
 =?us-ascii?Q?D5LHudMyh9eDVyKEoOfy5CSPP3OgTarx3OMGEerBCyY7SOnWYxHXUxWi6Rih?=
 =?us-ascii?Q?hN3rcIrrxzL2/bqUfIxig9CxdRUMqonUF0dzl6gYlZkDvGk0He5/7BW14TX6?=
 =?us-ascii?Q?s6entBU8T2/aXSDPmTMSsl00mfwauUv3GjYiwfI6C6qprvT0rosy+RaacdE8?=
 =?us-ascii?Q?Cw3K27Hsh+uLNi/4Lc8YdybqP5qa14g+PxN6FO7Sc4iy67DpGsltcokF9sCt?=
 =?us-ascii?Q?IflOB/aLNoKzFqCAO3sJx5ecsLjDWMHeNqc9UbrtSpjPmRTWqczsyKd9fkmy?=
 =?us-ascii?Q?AOFGfMxwt7Z1G0MgSsUPHiIulqBFRYfP/Xxzs0NEdajKdSXeUiC9n4KRg0BP?=
 =?us-ascii?Q?EkU0AlWp779kIcaul+GP87RWE+ZVwP8kvBx9ihmihpGR8Jkm/B5/2PM76tzU?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e73af8-532f-4bc8-2422-08db92bc99ad
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 18:24:53.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5RfbXuPphe7RNyV3UVGUEfRxF63QsaE4X4nQeIU+lebZN0HWXNR+mUFuA3OQHol2VtfVUesA8Z7lx74X79EN0g==
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

To be able to use netdevsim for tc-testing with an offloaded tc-taprio
schedule, it needs to report a PTP clock (which it now does), and to
accept ndo_setup_tc(TC_SETUP_QDISC_TAPRIO) calls.

Since netdevsim has no packet I/O, this doesn't do anything intelligent,
it only allows taprio offload code paths to go through some level of
automated testing.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v2->v3: none
v1->v2: patch is new

 drivers/net/netdevsim/netdev.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index 2a4a0c4065cf..2eac92f49631 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -209,6 +209,31 @@ static int nsim_set_vf_link_state(struct net_device *dev, int vf, int state)
 	return 0;
 }
 
+static void nsim_taprio_stats(struct tc_taprio_qopt_stats *stats)
+{
+	stats->window_drops = 0;
+	stats->tx_overruns = 0;
+}
+
+static int nsim_setup_tc_taprio(struct net_device *dev,
+				struct tc_taprio_qopt_offload *offload)
+{
+	int err = 0;
+
+	switch (offload->cmd) {
+	case TAPRIO_CMD_REPLACE:
+	case TAPRIO_CMD_DESTROY:
+		break;
+	case TAPRIO_CMD_STATS:
+		nsim_taprio_stats(&offload->stats);
+		break;
+	default:
+		err = -EOPNOTSUPP;
+	}
+
+	return err;
+}
+
 static LIST_HEAD(nsim_block_cb_list);
 
 static int
@@ -217,6 +242,8 @@ nsim_setup_tc(struct net_device *dev, enum tc_setup_type type, void *type_data)
 	struct netdevsim *ns = netdev_priv(dev);
 
 	switch (type) {
+	case TC_SETUP_QDISC_TAPRIO:
+		return nsim_setup_tc_taprio(dev, type_data);
 	case TC_SETUP_BLOCK:
 		return flow_block_cb_setup_simple(type_data,
 						  &nsim_block_cb_list,
-- 
2.34.1

