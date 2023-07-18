Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8746275779E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjGRJQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbjGRJQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:16:21 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2056.outbound.protection.outlook.com [40.107.20.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90A170C;
        Tue, 18 Jul 2023 02:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBr/io35PfK7YZQ6f61HbtOiYTt8Zp5W91jvDpNtZcT8Qzy8OYA1D0bLuh4CQrdFRBwrPCykhopbR4zhoFV9MzuV9vC2tYFbVEhTPlzt593ZWEtqLjfx8ovp2/bnvTX7RquVOIcTXE1vFlnJJHAWlXGf4mmFlETktNpCL5ZktQiVLDMpZ33eM0f7FQGSRYIFPdyO2WwaLlGuwIELvA13RrkBxO+tTh5F9r7ttDRbU7oMQhdkjYGKcXJrvMSP2E98yqb5H1Ik+/qnI8ZvYeTkSU/QekseD1W7LVelYca+UKhWnJVG3GHKaX+ld02k3XgrtndE2taN3Biua7tfdIrbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdjPvDmrrrkh8MKW8ljC8+6JLWdRtzFzvR8Gt8Tluho=;
 b=KUrQ6r3qC4YiJze/1+f25GZ8nR5XEm7K8dkYxPKaXKKdmPtqA4PEiY5/hhlf3UZq/+on5l0UfSAVTBgIvYVRKNsWMVPKP/K4wIackUYuZD9AOypb6KnxR7NZNPGX48qwtsmd05lIXmLOHSMrr5mK8qUcr9WkgNil1CVZbyoRwLNQH9vf1RyKi5Bbax5gnk2p3ulwxgshY1VNn1++m5pxAoJU0fyk4SEbJpmjNjpLVEK5ODg+V5xa4ERrDcJW85EbMCdZVt5mUqHp93hvH/s938jMVfPzaeI60aizl5RDVNVuOZiBnZ3e0PGy02dwLac6t6Lho1cBmJCd8HIPBOPUKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdjPvDmrrrkh8MKW8ljC8+6JLWdRtzFzvR8Gt8Tluho=;
 b=pCFLduPdnL4jS6ffHOuh9Y3LJBfSoKotyX9CLj0hZ3w9A5expV0DAQPIp7j4UcyFomRQAg5W2OFl+miX2D7Ngf4Vf0KTV4sA6if0/2urni9JnZbyBp8PRVONXekBnaiabQdPNJZAWigipvtdYP9PlNMGvPxPZz+/i0DBirSlxxo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com (2603:10a6:206:8::20)
 by AS8PR04MB7832.eurprd04.prod.outlook.com (2603:10a6:20b:2af::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Tue, 18 Jul
 2023 09:16:16 +0000
Received: from AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e]) by AM5PR04MB3139.eurprd04.prod.outlook.com
 ([fe80::2468:a15e:aa9b:7f8e%4]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 09:16:16 +0000
From:   Wei Fang <wei.fang@nxp.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, xiaoning.wang@nxp.com, shenwei.wang@nxp.com,
        netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH net-next 3/3] net: fec: remove unused members from struct fec_enet_private
Date:   Tue, 18 Jul 2023 17:09:28 +0800
Message-Id: <20230718090928.2654347-4-wei.fang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718090928.2654347-1-wei.fang@nxp.com>
References: <20230718090928.2654347-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To AM5PR04MB3139.eurprd04.prod.outlook.com
 (2603:10a6:206:8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM5PR04MB3139:EE_|AS8PR04MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: b74448e0-e995-46f2-947d-08db876fa3c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqQv/CxWRAdPaBzv7I0DkxWfaGvwVTyrJgD9gfOAduYkfRWYUdyoFuJhv93FdCECQCKAri0jDlLvw6QM4zHm4GHcBSvmOkX/7Qk1KxxGxMJdqESjZZVYRBek43q696X6EpzmnhYUMiRcSOfhTUnOgE/p+AAwrgnE7HG45xNpi103JCQumhf3OMrYL850F4yKdISJPQ6vktYzj/2Bx8dj3HrYOnryJJBRCwsFY8Bl72RCF5cYfCWNqBZBXmvwInmT45p5eKkufeJlVBX4k1NHHaTqBLysj0j5eGXqbadeO97yyY9e1VUfb1iiNP/2E936ZGF41/FAvf5e06nDp1rUeCBSSjOIEd3jlZPXxsHXZcUm7AX21JMX7Gq5KOurEnJq4m35lvQFJTVUspZ4dqxI2NbOMYTu2pFgrUj8/9bo0TS9ET0vuq17GklNoTpNs+fXzO/G54TbvVafmpEuh3yydvajduqltrUiI3bpzP1EbiEHf4sLP9HQjOEggUwYsD8y+V8e3oM3g5ngTmu3PT6SvwigRUlq0CjpvhDAi3CH+oER6HKotDMuSZ3Ge6y93Vg/m2PruuY/ePCJmhlkv5bRpOQ5fquX8njfnw7e3U8jJystDmU8bhhIiDhFBnJ8Zatj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM5PR04MB3139.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(451199021)(66556008)(83380400001)(2616005)(41300700001)(5660300002)(36756003)(86362001)(44832011)(8676002)(8936002)(38350700002)(38100700002)(6666004)(6512007)(316002)(52116002)(6486002)(66476007)(66946007)(4326008)(478600001)(2906002)(186003)(6506007)(1076003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nXJPgUiIJFgWWFMViML0brRE/9YmomNtwzdeckm0yISEUlTpRFLb9rEjgqXF?=
 =?us-ascii?Q?gO5wMAq4uscon6tesYO63lTLWINN5p3jj37AXGsD4UBegR90jU7yprla+1FZ?=
 =?us-ascii?Q?DehwwT/euhh5Ipp4L4/urdlLLCY632uJAsWm6tMLtu7Br+roJ2F5UAtofCHv?=
 =?us-ascii?Q?QI+ZzDbY8/277pvC6Ge+o048zwaaTd1RFMP2ONGr7L046pq0Lb670/xoNszy?=
 =?us-ascii?Q?NsJ2BE1Lw9iAsB8t4iZeEHsGr6+a1+X3DEKy7igBwZW1a0caWwrpszkzndMJ?=
 =?us-ascii?Q?YGaDr+1trhBmM+5zn2VZ6bnHDD41F87e5B1qVz7sM98LzSdbUod7Gcwt9AHb?=
 =?us-ascii?Q?YnYTLFUju5r+B+vN9hgFEAj2JZ8uSZmoZmt20Bc462o2u5/syjudx4KJDV1d?=
 =?us-ascii?Q?NLZq2dSKeF2eMiTibwezxqqymQovZsE6lk2dTlDjo57/5bT0DaUgGcpxavjk?=
 =?us-ascii?Q?Tt7uA0aHssaff5jKlVd6o/yu14vtYIYofGuV8YzLz63t7Db95roAnjpicYGk?=
 =?us-ascii?Q?BQUIls2XLGGA6FuoL3tOY5lXJ6bfJZXyZ9Yv1p+Oj6tVxtpOGkheRLI+owlY?=
 =?us-ascii?Q?TJT3Pu1cuv0yv5X4ndOXMhuF5hOXDjiEQug4HTE3GjgyiaNbhqDk/pXNgHEB?=
 =?us-ascii?Q?bopajyRIWQ3DOPs1eSZGuD7vEshqR7zCwLqE+qeDJ3Bf0LXCbGN3OIu0wPYX?=
 =?us-ascii?Q?o/lJ8e10ekkCg4PfuBDuCqm9/fj5Gv4T7ZsVpdFRfgDE5BCkopI6YDN4HaVV?=
 =?us-ascii?Q?Z8Euj1NJU1ohLzVcPbo88YWouuvTpYruGe6sI+8uhWX89AURwzPptkmWvZvA?=
 =?us-ascii?Q?TdSzBX50YrlKN/gBCMK3Iv+KUQBxMeI9kMP3SJf5gyti40E+ltB7a4EFRp0P?=
 =?us-ascii?Q?J5zespF9k4jk2WNnTohoRAJ+uFl5/4j1CQd4HW3VnHaetaO7Ck7XBLsrU0pr?=
 =?us-ascii?Q?b6Cw5uvetiy4lxN5EapfFeu343fGRduieHcccZngX09vkzjXLek3N9bYgjJN?=
 =?us-ascii?Q?6dg50SihGr1334P9d5CTQXM3ke+PdyZadN7En5meZXD7XamfMB0C/RugBzaT?=
 =?us-ascii?Q?60fLj6kDOUJAG9syRGnT7fm88O91sCz/Z+Ta5TOO7edn+Tbgyw90Sao9XnN2?=
 =?us-ascii?Q?5XlqTh3L4P3WDcLWK+EmryrMpsscJIelAx9s9cLRc/Vnzr3DOp/w4CHZBTwq?=
 =?us-ascii?Q?7Hz51iCIcylK/E4tlW+28DjKjv0V7V198k6XFv1M0lRISbYMwOXwbIlt03zw?=
 =?us-ascii?Q?78tnMViOBx9/nTvkMqGi1DC/RLWdE9YkjOSRWl3HEeF+DCvnuXUQuN/QH5H4?=
 =?us-ascii?Q?PwcRaH6wxI1SZBu3i7fQe8i7UbBnviyuNSDaHBe6INi/Rff4Pom6p9PsFlMU?=
 =?us-ascii?Q?Mn0CarwZBEZ2m4mwFyUVoaFeVDmzstg6aWZjjB4+9h5UNlQQKsB7BcLTNY5W?=
 =?us-ascii?Q?aS3253LYcQ7AUm56DuI3iP2tPWkxUocGpodbIPp1gYUTnzOydjtIvtKQP44I?=
 =?us-ascii?Q?V0lC+ewk1rr7TxOEtZmfC4Vs3AfvkmucVwZysCKa3IHneF7kDj1ZteXIlPqz?=
 =?us-ascii?Q?H5nlJI9NnvxGgOxc5u4Iu2HH51K5sglbnUTgB57P?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b74448e0-e995-46f2-947d-08db876fa3c1
X-MS-Exchange-CrossTenant-AuthSource: AM5PR04MB3139.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 09:16:16.4856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l7hWWCM9CCUGeEpXMI942ptTNy3Q9ecK2ji6K6pbxTin3cx86+BEOrT+rcTuvJBkJGRn13SkYx48xXrMzW3Bkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7832
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three members of struct fec_enet_private have not been used since
they were first introduced into the FEC driver (commit 6605b730c061
("FEC: Add time stamping code and a PTP hardware clock")). Namely,
last_overflow_check, rx_hwtstamp_filter and base_incval. These
unused members make the struct fec_enet_private a bit messy and
might confuse the readers. There is no reason to keep them in the
FEC driver any longer.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec.h b/drivers/net/ethernet/freescale/fec.h
index 90de14975837..f35445bddc7a 100644
--- a/drivers/net/ethernet/freescale/fec.h
+++ b/drivers/net/ethernet/freescale/fec.h
@@ -652,12 +652,9 @@ struct fec_enet_private {
 
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_caps;
-	unsigned long last_overflow_check;
 	spinlock_t tmreg_lock;
 	struct cyclecounter cc;
 	struct timecounter tc;
-	int rx_hwtstamp_filter;
-	u32 base_incval;
 	u32 cycle_speed;
 	int hwts_rx_en;
 	int hwts_tx_en;
-- 
2.25.1

