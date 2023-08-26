Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 256E678941A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 08:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjHZGvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 02:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjHZGvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 02:51:38 -0400
Received: from DM4PR02CU001.outbound.protection.outlook.com (mail-centralusazon11012005.outbound.protection.outlook.com [52.101.63.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5516E2682;
        Fri, 25 Aug 2023 23:51:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDUEcgESG+DIN09/gFnWTvsp0qmM/r8JfPinHSGI5Xh92IcJ0t8ar+B/pypXYtHanSqjHxRYfq08gaBYgxWigyWbLncTqj/0eFI9zDF6TwtdJEC5TizYtDic1DIVfTv/qySi5pc5cl16V4jsKW/NLvTv7IdHRLkhGUXFtV8LUCR61KPC0MZP31cK6PdbFESJbbSFW1AMNT+f3pZVZw+56XWIDws/nBKH2gxbj1hLN6molI1uZ7Jvwy9nZf9rQRvhFhEhQL2QsNQi8xaadrbdTIqcPJmRxET8KjYsrVS5gzClki+0GwrBquS64NySUQ4o1jPqoDO9XqIaPVJqvAhVDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WfokacAEfpnHRZAMyUlc9EptW1OcI5/DsUYAgXeXlc=;
 b=bVMH8GuLbC0AxMsHGj4PoEv4PEmvuinFE1N521RoO7XEpJ3NvTUThbT5fNRAr6LCXS4N6ostfkfm8byO4wqBJAK/DezT6UeiPncTW/2vHCMtXhm+cGPMTwljFgHlotBgzyFlsL7r8BQjTYGcY0ihkjtsAbmr+7Tt14XIYYEmhWIwKPMt9X9aaZZZGHY7LS12PeaOVqm/n4dpkETPIk5m0/0/py3ehA6aPhww7RGirJZtm+gPqvMVLe6vhlrTeHwzrEkX1Fjd7rIJ0cfR0JcoYezfGbpIOnqhe5e6667aVSmUXCuwgxGXCynkIesHOOKRhywZEaLXRWWu1c/KjcHVew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WfokacAEfpnHRZAMyUlc9EptW1OcI5/DsUYAgXeXlc=;
 b=SK1I2wLtspvtylgJ0kz8pnEwfTzKQ0gGbCyNTZYjX7C5lEa+mNKUP1qaSucrKx6sAeas3uJq2oQ/x0jMb98CIAoLd6kD2bnYW67naCj3zhhkhG99yNog9/lrSCzox1vzjXWz7ZUomX7CJG+dFkahBoBzNTwd8cFUHOb2im15AmA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from CO6PR05MB7796.namprd05.prod.outlook.com (2603:10b6:5:340::19)
 by DM4PR05MB9512.namprd05.prod.outlook.com (2603:10b6:8:108::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sat, 26 Aug
 2023 06:51:31 +0000
Received: from CO6PR05MB7796.namprd05.prod.outlook.com
 ([fe80::3299:1bf1:faa7:8a02]) by CO6PR05MB7796.namprd05.prod.outlook.com
 ([fe80::3299:1bf1:faa7:8a02%7]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 06:51:31 +0000
From:   Vamsi Krishna Brahmajosyula <vbrahmajosyula@vmware.com>
To:     stable@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, patches@lists.linux.dev,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, amakhalov@vmware.com,
        srinidhir@vmware.com, vsirnapalli@vmware.com, akaher@vmware.com,
        tkundu@vmware.com, keerthanak@vmware.com, psinghchauha@vmware.com,
        Vimal Agrawal <vimal.agrawal@sophos.com>
Subject: [PATCH v4.19.y] netfilter: nf_queue: fix socket leak
Date:   Sat, 26 Aug 2023 06:50:56 +0000
Message-Id: <20230826065055.4691-1-vbrahmajosyula@vmware.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:254::14) To CO6PR05MB7796.namprd05.prod.outlook.com
 (2603:10b6:5:340::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR05MB7796:EE_|DM4PR05MB9512:EE_
X-MS-Office365-Filtering-Correlation-Id: 2954ab88-62d2-448e-e7cf-08dba600e129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8M2KQdFriL0r2uiD+MelKWTxy4rBlHC8beJKcO4xTmn+OHfbTCWjytMs6xBvaweRV1KxYYsLN7kIx0Gq4ZZvP4h1qul9odcace3cK9l1SZQBa8KqPY7gpWGfNpK0H0+7NJp4pKfkBHXbV1RpCjLSBAMJcx+jdW/w50HQ5hGssUgrxbbxQbYKjymq/LQ1vR2G9Abszi001cl3RxEkoQFeffFlg6dNjOrrtRlFe3gISC3CTny1xzweXx8GbgKZ92qPBzCz3BQU+LjRBF7TBfKjShyb9U2pMVYp7rG8sz63NEr7hTbZiwvyAhs1Wxx4CLlcshIR4XTp9GTcUZnB7sYJ9unabMSRCZmWm/WnYz4sk5tY1+98dyEboehx5h4hGq7dBQvxangk97hU81Y8gE+8xqHRCUFKzwUE0ibVHxYdQvc+LPKJJ816x+oUjJMtqvjyM4/zh570/krnTAITkNoUh6xJ8lfD9ZM8MKMu2uIa35m6xgIV701ekkpnnN9+L+Toa0BhrU/2TscxQMs18E/8gHykSdwOapmrhCJhetGAfR8VL69oWwMbfnRQXWRzM6ezK6UrwjLzi4dsMeoekiOFAyeD6gPl/N8vD6XqRkSBlXwsuoYtGB68zTCXqCIvMwFpsd6177dhea4gry2Xv2qonmKlFv/4IVImR4WTDeofuqh0R67gGUThxfXqNSalmxT3nRej8Bx0FXokhZKx6SmHKNM05ENUWXnap75sEL1H+wI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR05MB7796.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(1800799009)(186009)(451199024)(66946007)(66556008)(66476007)(6916009)(316002)(38350700002)(966005)(478600001)(38100700002)(41300700001)(7416002)(2906002)(36756003)(86362001)(5660300002)(8936002)(8676002)(4326008)(1076003)(26005)(2616005)(83380400001)(52116002)(6486002)(6506007)(12101799020)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zcbNjPnoqbk9Ur74q9hxnbZFfYfl97iOhFq5aPK+ouGtTZoMy3qo9eZBk5uJ?=
 =?us-ascii?Q?URBkYO8+aSUXFtBatt9eTOcSRBVPrgwn3XxBGBxiYUnfKSXR+0NjGnerS7PR?=
 =?us-ascii?Q?CSD/bYP6lexpib+Itv6XT2NLpmOfAEA57br6C+Pwj0HwqYRSZniRDbQT9KsV?=
 =?us-ascii?Q?xova7pIO6yN7EAs1p1eEZYU7irazl5JrOg2AayCewSDAVOMycaVE2eStqBDL?=
 =?us-ascii?Q?1I4Jfk9REeWe6iSitv5ypJADpo4hpDpyyzdz/+4n6jHyM3bZQ33dX/tBitaI?=
 =?us-ascii?Q?fSmoEhDo1eGM9aub0wVSem7rgfUnzS9KlY0l/a+1EqYBORAGUbxM58qoal2p?=
 =?us-ascii?Q?6pGt84IUcuqhC7w7aqiT6IuJnsv3jKjJDtRmpsYEiLSsFCp2WdiGKknyXqeH?=
 =?us-ascii?Q?ZsTCWzeG3DeDq03NuE69Z3OYMct4Kn7ls+m8zOZX8DVRIt94CjwvUaykd8PH?=
 =?us-ascii?Q?fJVtfz5btBl4wzRH86Ojou/MXCIQpiKJUyX6V8PqMhY3q1aG1xgJoRNe0RrB?=
 =?us-ascii?Q?S8zh04bxwfFfDwHNqtK9dKN7fWT+uYZdp/CsDa3n+y9UF6Jynf4jr9bPtdZr?=
 =?us-ascii?Q?umEJAcRjuWoqrEuIUvXzVPj3WI2t+mvgsc2xxfISUICfbseZNgfhegPoQvy7?=
 =?us-ascii?Q?WcGK+XmYkln1U/sNeP3Yc5b98fYuu2ZOrdMAFa6Qq8EP06jrlorJkPEmuPy5?=
 =?us-ascii?Q?IA0rbV/R8/+KTiYythO3TTOSpgQ/1UsngNur+FgrYKpSM2JtO7IbpWJqaE4B?=
 =?us-ascii?Q?f/PX+Ew45nQHFSeO8JNkOd1K8mCv3cpOTwr7u49jizd7idFX5fCl0sZGUM98?=
 =?us-ascii?Q?ORNf/1DGClcR2sLIIoEiSYQ3YtCkBFT8iuL1e0nrU7kb34uDZctO9Gj3DJ+P?=
 =?us-ascii?Q?hbmg0ZxHkHZhkoAtCJFB7aTZPrBtb9LbYrKFm//GWPy5lwzBjwMk2pLP0mzw?=
 =?us-ascii?Q?VqWzhk/eo6vh55h2s4hK5ZMMcsjVYjphV/mz7IfLrtT0nUq9/ZfUmuPHVroI?=
 =?us-ascii?Q?A+33zyRMf1XzDufmXgTI5Ce7lI+spsB1rh4xvFloOlcmU3wS314UTnCixSJO?=
 =?us-ascii?Q?qkiQR0Mh+vRJ4mISPhtxn8m+gIMDcG4+vlvSNkOO/TFADuGvnlQ+ekvQR+Q1?=
 =?us-ascii?Q?2PW1LZKnvFkt5hhUb9Gy6DO6CC49kYqBI32yC6gIbGxb12y7El/1O88lk3DJ?=
 =?us-ascii?Q?8k8NxSdk3Fh2ky9VNFCMic84RM0AhvbP/R27QTPKL9G7LDr7jyuelHVwSkEi?=
 =?us-ascii?Q?ih4yjOZVrGfFbqPkRH6eHDGJkLFWxmsnE6oBfRhXO7dgrPSLoTWkxAIKZiA7?=
 =?us-ascii?Q?SlbYgiDTJ7ikJrFjDUl7FHQB78aSqW6E6TAYU6+QrdsQaDSWKqwaUJIfSQiP?=
 =?us-ascii?Q?QSx5zFciNWBF1kEhLP/AvO853Lfp+CnyoEt+oGL76PQf/MSss7kYI5MJ4X4z?=
 =?us-ascii?Q?SttYghraumJIs0Ud+z0UfTFHX+RyDK9MR2mK0Gl+jupqPgqe0+hYFKD8JNJR?=
 =?us-ascii?Q?L+Ajdktw9PfRtRiQZUdedU/DHP46E1t0ugz7RUvEL/AYR9zkO+OoSjAp8Hfy?=
 =?us-ascii?Q?VTxipaJzTX5tT1mrGt0V8tXEYCWXgoXKEAn4niuCem1gJ42SEwP2bKD5JlCL?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2954ab88-62d2-448e-e7cf-08dba600e129
X-MS-Exchange-CrossTenant-AuthSource: CO6PR05MB7796.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 06:51:31.3135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plpO+WYkOJDwfcF5sMlwkJDIC29EbaqUlAp8psfddTVVzRUxYOftZQxEg6taL9CWCmLKVV9deFHCCsZisASz92W3JB9LrA0XNKXK89UYO6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR05MB9512
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removal of the sock_hold got lost when backporting commit c3873070247d
("netfilter: nf_queue: fix possible use-after-free") to 4.19

Fixes: 34dc4a6a7f26 ("netfilter: nf_queue: fix possible use-after-free") in 4.19

Fixed in 4.14 with
https://lore.kernel.org/all/20221024112958.115275475@linuxfoundation.org/

Signed-off-by: Vimal Agrawal <vimal.agrawal@sophos.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
[vbrahmajosyula: The fix to the backport was missed in 4.19]
Signed-off-by: Vamsi Krishna Brahmajosyula <vbrahmajosyula@vmware.com>
---
 net/netfilter/nf_queue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
index 84c59de27882..b3a0385290a1 100644
--- a/net/netfilter/nf_queue.c
+++ b/net/netfilter/nf_queue.c
@@ -93,8 +93,6 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
 		dev_hold(state->in);
 	if (state->out)
 		dev_hold(state->out);
-	if (state->sk)
-		sock_hold(state->sk);
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	if (entry->skb->nf_bridge) {
 		struct net_device *physdev;
-- 
2.39.2

