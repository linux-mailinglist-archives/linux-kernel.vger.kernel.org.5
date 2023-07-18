Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ED775787E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbjGRJvn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232321AbjGRJvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:51:11 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2056.outbound.protection.outlook.com [40.107.247.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB5128;
        Tue, 18 Jul 2023 02:51:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7rzXGHOoSg8J55eYkXRQyKKmYMHxKz+1CI/xzd0MFkQKy/VnEg9opRlVTHGxmoOuNgWM/YrzjtO7KzrcoUZU6D6L38DFyqB8qlgt26l2E7Vipvtlc4u+8vtSIyoqR26aSB98nfsUeVFldg0riBY3OIlewiLxqrakCUYow6xlmlVDWIoYDB+wZukIDUJzGCAjf8GHoZUGshVCth7dY07nRG43ey0UXNCpCn2rUsnhRtEis3yaeMqfg7R6BWXxS/XydWLunSy9fEuKHWcUar4/TnE+Xfe95NUvoxMzIE95n/WmVPeYbW7KxDbrGwx58VueGiN3R6F4LXGTpLM7SxjvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20G3mcqhQwbuDatCJ1tAgjhv5x52jZDh+tZLmUBxvg8=;
 b=D8N7TDRc6lpw+Iueycf5ymzgMlakhbWCFnGjdu85Xa/qhE/ZN2RB3xntLypMohkQes+zyBZvhDgUeXtmXd1xyS/ApRlpRlMsYflMcPeXDjKjdUkbP4a1Kzx1/1dRmQtmhf7G3WAzOqHSkMRxH+lLZBr05ARb2AxcX6eBMCityY7EPb6ZW1/nk1IyzfzxRa0UUrTw9NhQ9+hW/A2tyQvA/8Ofafmf6Mw8vUPVb6abUTv3Qg3OAPCiezrYRA2SXTtkbd5eXpLfDZAZRk2ZfPSGiSMmw3xt6yL//TMCSh4AsxtzFswTVNwRAv8yzVOp6kDasLi4MzzYzNnqK6bKbEGwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20G3mcqhQwbuDatCJ1tAgjhv5x52jZDh+tZLmUBxvg8=;
 b=SLYK/RG0N0+FwhR06ur0H9vcdhVCTj2jjQYwAS2XvngLJAn8J4trXqDmgUfcId9zsU0KUGQyl/gp6mQBAe93g2HbDxY70iygse+7huCGfoBLeljnXhSYMFot3JdC1zbhhULq5xEM4sSZYCtgmXYyX6qYUKWcjFnKCGQMN5u9GPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com (2603:10a6:20b:d8::14)
 by AS4PR04MB9243.eurprd04.prod.outlook.com (2603:10a6:20b:4e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 09:51:05 +0000
Received: from AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a]) by AM6PR04MB6341.eurprd04.prod.outlook.com
 ([fe80::613b:e94b:4ccd:f55a%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:51:04 +0000
From:   Ming Qian <ming.qian@nxp.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 5/5] media: amphion: ensure the bitops don't cross boundaries
Date:   Tue, 18 Jul 2023 17:50:13 +0800
Message-Id: <f2ae16159150707d350a495711f5767c29a911bf.1689673395.git.ming.qian@nxp.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1689673395.git.ming.qian@nxp.com>
References: <cover.1689673395.git.ming.qian@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0009.apcprd04.prod.outlook.com
 (2603:1096:4:197::8) To AM6PR04MB6341.eurprd04.prod.outlook.com
 (2603:10a6:20b:d8::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB6341:EE_|AS4PR04MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: 015a50e9-ba4e-4059-a296-08db87748034
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QC/lYW0mRy9Fb5j13gF30Vtvq3hQiWxPy1+Qg7Z0L5U99cAEJJmvDY20wQdrlon+RvPhiuuw7UUHd2YFum5HYtjVCOcYXYMF/1XMQvvZk76r/09MA5EbUOnyivJUzx66D9Dpvlmx7gzhWXlgoxXGfYJ9aDavkkeJqBpcL5aYrCFM9n2DY6Wmhz7r+zHCO6mPjvkvbM5xk6n6KmCKPIh1au7nSNfjBYcCAaRr0i8rQgOMGTJQxr+84RYX6s+6bxr5kHCzvVFslEfP2CBzf2ZlOowqiaktWPWN5+jLrwisC1zPnO66ol2rhw+M9CjiGLdJZY/4A3+/fTkXbzTQUxpARXrOQuf6pPMMU0nntTKqYifdU0Xs7tuRZhnDYEAqfHSwlgGyWafsiCC0ZknIuh5AtkMtxOWIdwaIl/t7SW5pokp04SS/EuAQQA1KUEpFfbiiLnJLW7ADWXE6KCEXxi/TVJREw30+IVmVFlNgyDeVQD2poYmHBgvCFfmB6sGC42u9lCEQD08evUb8QaAEbRLXPQxnjW7zJ/YjOjsvdKWWwOwOEPsAmQNcp1OsQjv9GCWqRHvBxmtyyzOUvGVHXECwKc6O2LmHujNiiLohS0MLN872lLkUhPYEMzXiZ0ZaZ0bX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6341.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(26005)(186003)(6506007)(36756003)(83380400001)(86362001)(38100700002)(38350700002)(2616005)(4326008)(66476007)(66946007)(66556008)(316002)(8936002)(8676002)(5660300002)(7416002)(41300700001)(44832011)(2906002)(6486002)(6666004)(6512007)(52116002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HoyTVk+/VVt2nI1mu4oDvGVAqEE1IQE9ZzVLjYemyIsh6V2cknsKlGPqxmi9?=
 =?us-ascii?Q?VPT5+ZeRf+hwhzw4KnttUX4NynRh5qELCZuvTDHiKjfryf6jc/XQVGdNmNnL?=
 =?us-ascii?Q?Cjoh1y5cuFGLOqgeBjimmjpnjPrIRNd89kPX487RA97bdVF6QG6DuefrwXLA?=
 =?us-ascii?Q?bTiBYzVsjCYQz/rIfKYz13SjdsQjOBrglusXQeg4HZ/pRgicNE2wDv7/sTO7?=
 =?us-ascii?Q?RO3QFyvrqyJeE4vRzxgFIS/JEyGP8SEEGycDUJ0foGpsqR9WIt6jfTFmr5cy?=
 =?us-ascii?Q?6/Q4JSj1pD42JX4bJUS/LjBLLD+7D42YNgZujjSfKU/DjU/DeHWAkl0/O3Jz?=
 =?us-ascii?Q?mgT9yOeTAxe4HTDElZWRoPFQV+Bin5m/fCLAWP6DILLldS+w1TqC1NmLIW5a?=
 =?us-ascii?Q?IDF145SJBWof7ycO8S5LrHgFZWoFq9LGd8Y7Ie02RmTUoHy5vyPKNA5vM0B8?=
 =?us-ascii?Q?YfIU4TfhM+qypjmLfHH2bzr1r2rcBS75GGF66+HPuyDnsqLXJUhX1buA4RKA?=
 =?us-ascii?Q?vaA0NFbdFlkgbcPOYLPSlxkFVKE0AJyR0Ivm3XLj3lnxq0/jvF0ZUK0h7Cv5?=
 =?us-ascii?Q?JlQXbpKvugV8m0J6tR3T0Epco78w6ou6NfuY8O8mc502+ji3kLE11TAwalb0?=
 =?us-ascii?Q?9IjC6ppfIAjrgDFiVKzAKaHy6NV1rEqTKY2huesWYx96vYETkXT+XQ8S0SQ0?=
 =?us-ascii?Q?5BYKC/Rw7L6TxS7NRWn3Phta+0sYHQlUQe8KtXcbzb0wMfkWAiNYaVzTHCI3?=
 =?us-ascii?Q?/zF5vz4MJ0kFFTmpNcGgXs06BoB7hNnMbV1jfT4iGVbxp6kMcYhNJ0XgpEQC?=
 =?us-ascii?Q?PZPrfVEPi6TLLb9mULs+tgouueL3yL78QVJDSvvEdfjqRAxZ+hYpVnWV4L1v?=
 =?us-ascii?Q?Z1fNYNZVHJhx7moJY4VDfz91hoQID9Iqo6vhTQKzvOeoZrI1sKBxN1SL3vSJ?=
 =?us-ascii?Q?73ct1Dr0K1MG/RDa7vif3inTqt07mSAS60fQ155ge1Wp/wpoj/1/YoRh9GFL?=
 =?us-ascii?Q?DzMdDaUnRZyX7hNNuHAZ4NPVTVjVTw9VpHcCYOYJfq8N2g8xhkJB92NwkAi8?=
 =?us-ascii?Q?8cyQFEirXhqb8enZ+Tq9isS8Z5mfbwqtbra41Ntoe3HeHDuAVsGiMoalXbJE?=
 =?us-ascii?Q?b71sHb+0M78FLKYvqo3HE+5rf71XDC8u9+/hAg1dxj4qg0JTwl2uX7XoOfnl?=
 =?us-ascii?Q?lUm3VCVDe3GuKPTAF+a6oulV4m6NVltCg4NB+rF0RUM6EGnwbwRy+J67gDPV?=
 =?us-ascii?Q?fvBU4auueL9iIn3JkQLD4Jrvak0vweIzKiB3ABpVqgfz1J3a0W5K/L0cRCRN?=
 =?us-ascii?Q?YrpredeDr2qgKgmFXKnhYZmAOI77XFJTbEayrLi+zyF/R9JXr/9nSaelKYzf?=
 =?us-ascii?Q?1Qeh6ptsWOAGnO+o/n8kvC9sveJJpJZlrEGSqmil7QQsJU5wkDXX/1JJp7ps?=
 =?us-ascii?Q?HTPRDsEvsvsFmHcKhkhTyrXA7VM+uziiGpdOgEXlPpydCFuEYoJ6S0A8uwjw?=
 =?us-ascii?Q?ced9WKK013f/sAakGUVvkwXJL+fWJnIoLTD+LKaxzswZjMaNzeBzM/w7lhpC?=
 =?us-ascii?Q?YuHUJBEVIrZi+tBG0oKpqAg2Fp5leSkoL7WGJCHO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 015a50e9-ba4e-4059-a296-08db87748034
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6341.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:51:04.9083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 16WIEUkQmofalwWZ+KlMUUXrfltmzo9z19AvRSoKkubKYxmzZnTe2LuoqnEJlFoAgq1lt/+A5tA+WJvW3YpTUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9243
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the supported_instance_count determine the instance index range,
it shouldn't exceed the bits number of instance_mask,
otherwise the bitops of instance_mask may cross boundaries

Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Signed-off-by: Ming Qian <ming.qian@nxp.com>
---
 drivers/media/platform/amphion/vpu_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_core.c b/drivers/media/platform/amphion/vpu_core.c
index 43d85a54268b..6f054700d5db 100644
--- a/drivers/media/platform/amphion/vpu_core.c
+++ b/drivers/media/platform/amphion/vpu_core.c
@@ -88,6 +88,8 @@ static int vpu_core_boot_done(struct vpu_core *core)
 
 		core->supported_instance_count = min(core->supported_instance_count, count);
 	}
+	if (core->supported_instance_count >= BITS_PER_TYPE(core->instance_mask))
+		core->supported_instance_count = BITS_PER_TYPE(core->instance_mask);
 	core->fw_version = fw_version;
 	vpu_core_set_state(core, VPU_CORE_ACTIVE);
 
-- 
2.38.1

