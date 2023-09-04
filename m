Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079E791AD2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 17:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348444AbjIDPpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 11:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjIDPpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 11:45:18 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013001.outbound.protection.outlook.com [52.101.64.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABBB1AD;
        Mon,  4 Sep 2023 08:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioZQSuuvHKdZGV6mZU+qUu/5GPRuAF03S+oFjqrL6vNms4thZZWsDhwTOII9ha1izyA1UqH46OooynrdbYQ18w0MsjNLfFgHRhociUPCAcoclTyUfL1bRLewGENOj65wJcvv73R3oAuxtz8L2wQiRK0nel1vt3krF/lBBIkR548AcZ8oj7vhdAlgmBey/5RRKFYzJ9RRTjCaotrCwfhBMIH66GL3VgVtKpSMP5C2TTgAaEnF8J7n9Ekil/hFR22SM/zQK5GEpiSqeveL/Wqs40TPCBF8OkacDMqanN1OpjM61+NQC4Zv+v2UjpAdiJk/CjGdDT0eePe6ynLZyXEThQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eP5ePXCglkNzisg4Uv/IPBO+diD/eGGjLHB6EODUOvo=;
 b=KPyqWR567SMtfuXH0qWX1lj3Yc2XpOeLJ5IhsqYT8SQJC3ATbwe3vH9nY81BD2HUQOCACE9+QIt7b0juSI5cLt3Fbmi4EVn9qfayJuQEqhZ+okEYGclwf9wqvH3gajCRv9tRQFJOKFIbY/Sn21FcnZztoN7edmOx5/JIYkgplXfIW/WNHkP9ec3a/O8lEnN0G8XZj/WN1vKVh+sN3WOrSU+9O/u47f8/0aTxMRRaxBK7GRU2c4jlKkHOE6EVU3KNjZHW0BuM1ErogJbtPN752v/Mk6ehsUGz3MEETBorWMIT+U6sj4IY0A5Rtdi6GJPeB6AVLiQa9fdyRMjI3swESg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eP5ePXCglkNzisg4Uv/IPBO+diD/eGGjLHB6EODUOvo=;
 b=ZL+begUGG/e82pHWUg5gfaG3qpD+phziv7FWwWKbTwvd/LyRBkFHpHufShQ5b1i94g6tp9l9lJxAH015A0ZNg9iFdnJokmDeY6u49IZ91fsGUi9mvBPm4HCP7sKIMf/AQZoWFUL4XCY5P/RDYLUe8UI4y/nvtTYX9BbI/u5Mg8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BL0PR05MB4980.namprd05.prod.outlook.com (2603:10b6:208:81::31)
 by SN7PR05MB7552.namprd05.prod.outlook.com (2603:10b6:806:108::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Mon, 4 Sep
 2023 15:45:12 +0000
Received: from BL0PR05MB4980.namprd05.prod.outlook.com
 ([fe80::e67c:9c26:941e:8474]) by BL0PR05MB4980.namprd05.prod.outlook.com
 ([fe80::e67c:9c26:941e:8474%6]) with mapi id 15.20.6745.030; Mon, 4 Sep 2023
 15:45:12 +0000
From:   Quan Tian <qtian@vmware.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Quan Tian <qtian@vmware.com>, Lars Ekman <uablrek@gmail.com>
Subject: [PATCH net] net/ipv6: SKB symmetric hash should incorporate transport ports
Date:   Mon,  4 Sep 2023 15:40:41 +0000
Message-ID: <20230904154042.3081190-1-qtian@vmware.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0027.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::32) To BL0PR05MB4980.namprd05.prod.outlook.com
 (2603:10b6:208:81::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR05MB4980:EE_|SN7PR05MB7552:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b1826e9-b128-4881-3b73-08dbad5ded08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TgX6AMpoe97Dujg6w3n/txtguRfrTSlhYSPuWaUYZPNSAmSdRHLP8XNtARpZLA5tZ3W0sPWICkIx4/qwChqYiQ6zDlqal6VnyWZM/MEgDU0ksoOtSIqmA0ssy2LYk4v7FCrA7euEG/WxqF88QDLvzvBkoTu2N25DslAtItjkhvF2Bg91E9LXqUClF1GDQagNyNPPnpUoFpsdV/9fSPHF+KK+V3wNwHqGcEoAl9tCggy4GzG++HAz6wJYGWEdQzjXtOM1B47amaUNRMoy1MnlBJhCmC8/VYqitFnKbRcxR//QqGcwEAWst+cXGf1wm8kY3czdMzGgNV0URNeMPbFa87PUfahZMxjcO46R+3CTtQPkoeARbcyXfR2KCmpLiRRWUrCHuYO+fbFLeSqsGMz1ty0ZTEFa8qo+H+Ggp+ThSizIkksaj+YOa5sl+zgH1/VnXKzJAsyUVT4HXco9VWf/ej/BFLuwdchUZuv/EJKr65Q0+oVpd1e/+D15Tymquh6zfkI65GkkNBexNA8Pz38bMtsFjrS2BLeuam1RpVN5s6yEL7oUIyx96m8/o6XZUfh5LzDDP2tFaqzkuNIjkV2nbMYwVVpJQQa+KnVVGtGJDXyY+SXG75iLCMeyUMm44TzreDgX0+ymhDOB8nHOeE+TM6jQkGLJJDCBF0WBFCMrAZSrdCcgc7YMGcqV+R9lG63gMzy4jhnnmvFZh29/C66JNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB4980.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199024)(1800799009)(186009)(966005)(8936002)(41300700001)(83380400001)(478600001)(2906002)(6666004)(66946007)(5660300002)(4326008)(8676002)(54906003)(66556008)(66476007)(316002)(6512007)(52116002)(2616005)(1076003)(6506007)(26005)(6486002)(36756003)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZmxWhQmfXkGpY/fZ80JQNDTj6CZjrkbY0CH64TbSh6PQMYVUZbx5Wr1H8qAh?=
 =?us-ascii?Q?PTCtYcZ+1OsfVsCR1OcAxf2Be7CVO7y7LI3mXszMF/UuMEoLRLGXLcxncr2O?=
 =?us-ascii?Q?2mIu625RMXgBmELbCalq8scmN4gnvI5sPvQyn3bA0SFbpV+/D5ivqNbrWsI+?=
 =?us-ascii?Q?dQDsd7Iyz52h6SBe+3W/r3RPTSDopetHYnOyLbbTWA9kpTuKQx2RJtFCkcdZ?=
 =?us-ascii?Q?rU1tanPxDWmQ+ZuJqsIW7G7vVhiLGNPG2b+lVUE5oAbsX173rcHBlHvcv3N+?=
 =?us-ascii?Q?V59vWzH9PDRIwLm1v0Tb33l7L8WQq76Xxv9PXL8QotI93rPsGwyu/WZAf9bM?=
 =?us-ascii?Q?7ljUJzpWPdOnPa5J0m2Hd34k228AsTj03ZMIC4q6XWJMTPWBrogSv1re9Jul?=
 =?us-ascii?Q?YUuHpkDiBe31+9IkJJWCCCA3ev1KqwgHpYvub9N5SClvFjVGykzXYhKYyIgd?=
 =?us-ascii?Q?eG3BdEiKenQfRRTCkaQbeAC2ZbdP1KxtcfwBAncJu46jfDQoI5GunevVgUhv?=
 =?us-ascii?Q?bRDF443eE5Q1rd7313L2kmLgnNrK48VAcsiem1MOc5CQvv0p1uRgYpyT190s?=
 =?us-ascii?Q?rfh3CVuOGB3beesDvu30/DPWw5m8FG21MSby4DpSyycPPL9UKRviPAU+dond?=
 =?us-ascii?Q?TOP/p1H6SYnl8xdtwRWlQMLOG7lJsYUBgWmhercpO0Mk3GwCZKLsFpGfxeux?=
 =?us-ascii?Q?DL5g60AQo+CNOC1vO9JZOj44BxfxPWHqiS4DBzLjbawhKCM2Tdev6DEEpj08?=
 =?us-ascii?Q?KL8BpXt8Hjojj//73ojpw3Z0gGFIeGO3Lt8U+jNNsUKPm/lKi75v2DJ4SVfo?=
 =?us-ascii?Q?UMvG/MhpQSDsrewhv2bnXeqsXjMAiR28VWiOCjUNm3K0HLcrguvl4apQD6nk?=
 =?us-ascii?Q?ifVtGZr7dtLagbJhU4L4TdbunOfQ2ywlXrWADBrED8Dz00hJG6m+rx5MgbD4?=
 =?us-ascii?Q?ZPzoGrpTP6TbrhQ78Qhdj+UwLB8CEVUUQCWFGCBZwloZiIvK61pvL9dGTaAm?=
 =?us-ascii?Q?lGt9xGCuLcrB6C1T5cJ2wSkTJzm/2j7O4iQ1eqvGuWjXyNUREYTw9AE/PIal?=
 =?us-ascii?Q?kzucCj/TelEY210fvcVQKQ4KJCnRr3VblJV4/HaNHRVcSmyiBzdThlznJdAm?=
 =?us-ascii?Q?tiCkpIRQQjzW6T4XxExKK2no69TNHeQ2vMU/zohOIl5+LE+hsi789TDJJWfZ?=
 =?us-ascii?Q?efNYarIDMdQyaBctJtoI/yRX2litLkZFRp4cAKn0cISxNJC5+kMpe0qe5YP/?=
 =?us-ascii?Q?t1cmPDYNLuKw4fpZGJqgEP4wdG2QpaaQEIZo8wCunzZXfU7TxvoqIQR0vEUo?=
 =?us-ascii?Q?kRM2z1N/9xOOLc1oSgmL4jhG1Vg8oRUKkTauMZmq+t+PMaeTo8Pd93WO/AFx?=
 =?us-ascii?Q?FnkL7wnunKf8OIim7fJfs3dHBxWQuzrB7jpFdZvYiaUlN1MvVkYdbR7GgE2y?=
 =?us-ascii?Q?EKwS2tjhAhh9xBvKlIAvwZBuE2k7ChTmF+qSSwAUeFKj0SKdCrWaSLspDRVT?=
 =?us-ascii?Q?Dm6xTh7CZL+r01uxaZo5lD2jy/M3U7WSe+TPsr1mVQYTsejuCWxmkxj9DVcT?=
 =?us-ascii?Q?WEueh1/pqrI0aXbqNywraTiwKm43h+3QWuz7Ig56?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b1826e9-b128-4881-3b73-08dbad5ded08
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB4980.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2023 15:45:12.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: txdG6oOookDKhidglyb1GO4PqXJXPCmtEtoFZ+VvRZuQzqEAckr3UmxvkAny4x1cP73SWZRF8eWNywA/WP1XGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR05MB7552
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__skb_get_hash_symmetric() was added to compute a symmetric hash over
the protocol, addresses and transport ports, by commit eb70db875671
("packet: Use symmetric hash for PACKET_FANOUT_HASH."). It uses
flow_keys_dissector_symmetric_keys as the flow_dissector to incorporate
IPv4 addresses, IPv6 addresses and ports. However, it should not specify
the flag as FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL, which stops further
dissection when an IPv6 flow label is encountered, making transport
ports not being incorporated in such case.

As a consequence, the symmetric hash is based on 5-tuple for IPv4 but
3-tuple for IPv6 when flow label is present. It caused a few problems,
e.g. when nft symhash and openvswitch l4_sym rely on the symmetric hash
to perform load balancing as different L4 flows between two given IPv6
addresses would always get the same symmetric hash, leading to uneven
traffic distribution.

Removing the use of FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL makes sure the
symmetric hash is based on 5-tuple for both IPv4 and IPv6 consistently.

Reported-by: Lars Ekman <uablrek@gmail.com>
Closes: https://github.com/antrea-io/antrea/issues/5457
Signed-off-by: Quan Tian <qtian@vmware.com>
---
 net/core/flow_dissector.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 89d15ceaf9af..b3b3af0e7844 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -1831,8 +1831,7 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
 
 	memset(&keys, 0, sizeof(keys));
 	__skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
-			   &keys, NULL, 0, 0, 0,
-			   FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
+			   &keys, NULL, 0, 0, 0, 0);
 
 	return __flow_hash_from_keys(&keys, &hashrnd);
 }
-- 
2.42.0

