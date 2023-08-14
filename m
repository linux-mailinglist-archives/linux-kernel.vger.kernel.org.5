Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FB477B6D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 12:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbjHNKh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 06:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbjHNKg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 06:36:57 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884A10C;
        Mon, 14 Aug 2023 03:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VEic6aB/u1MOTzkjmRru108wDU026ATbTnv59IjvNN/Rpoyg1o7Lfd0EDqJeKjmU8CtX+Ap4Sd5LMNxOSYK1b6ZFej0ZRIikREWceelWURt1tjD+ALzEnaBntiibTYmRoQ8xmIa9YU/491+TBD0MwkeYnByF4AQ70Mlvn+IcbIYEoZH5W5C/8B99OvE3kNencn2qnfT6zZ1UwfVPQ1Q+tCy8E41uef14OEsS1pavyPzpl4hBAI3cMKiTPXYzfrOfBENhMh4JAu3Yyhb3WQXhUPUd58nL+M1vrIj8S1Tzoqtf5SPPHIWHKHuudHp9XLXMBh4nGOowAb45lzWCtdmWTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8j2x63NWMmoM433598UtKLRt7rCiJlI0Efc0kouIMD4=;
 b=ml9ezRZ6yEuk0T9tkkCMW7iMDBKyEYA0iYoyp5ldIqcMCC6m3L7De1veUlLe4qn2ZwBDZjU8buxUrROTsLowRNZckTCL0PRcqiF1MySWxbPywCxKFM7DxO2hs0ZjAkYxY3ZfZl4PgrNBF1rKsdGEqCfBfze32AhyzaE2blksRBTUgF5l18fXj2wBjziqAc20zsOtDPASAZxaD57Yvaa5D9giRmskVTtecMJ7AEC+oGC7wxwLBdHOPtDu3cvmJhrzMaQYilT5ZQh5HQWZUeOVVkFu5PHnk+R0tJAGp18wjO8yXF6tuuUQBW3QgKvBD9mIr1YNHtE58+zyvDGGg8z9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8j2x63NWMmoM433598UtKLRt7rCiJlI0Efc0kouIMD4=;
 b=TYMfGXwrbXxPw3/p79gYzfEwrTMSNXEuCkyghkvztxdpiQF4PqlfEVl7qL5ItZutbHxt5ywxmaW1yzKZTRM7/9s+PKGTM98N2Xj0LxhdVeH/P0di+KJMAMkjKkODL6Xc1nfyyfIS1U0+nAhtY8Gm84fqyH4f1XDuob5243FIlb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7216.eurprd04.prod.outlook.com (2603:10a6:800:1b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 10:36:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 10:36:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/8] genpd: imx: relocate scu-pd and misc update
Date:   Mon, 14 Aug 2023 18:41:19 +0800
Message-Id: <20230814104127.1929-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:3:17::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: a562d470-42b6-4d20-8c06-08db9cb25e14
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEjVk0CNcr6hwLBuMSO5vWhMCVeBnrJ/TvOv2pqvwvTzYG7dF8/BFtLEBF/YHeuugqG2B7fX5+tjVQEVfbc7MlrJumhw7RN9/nVUKhgMgvIgOdJzD+GVTb74iYJqvqcf+IaLViMbdnGCN+V9TllkSBfbU7iURLsNqXVVTRxqqdBW8y/O0vsXN7X7xyi4m0tO+r4bQ8fN7YPHj3eBtklmVuBZs5ApPyxFhS2nALsXhOm/zgnSIWTKhkg7f3IcfSuOLB3IhHkud526U74AmOX0gWFbuQTFWeK8BeFiXEGxbX61VkA1SFFT5d4oVpBDsIy0gOQ/JBfUkT7aINK8+kZjIfT7s5Ullch0LCQia06DcwI5y9W4MqpskcQLm/RXux1wCdwyeLoZwjleEtujosC51lt05yJWrZ7ZeYJ435VjcNznWreasxfdYeYc7D59pCtc+HfptUO8y2vKSWPsBbrK9s+kzDe8jQfFAYrBLXhSldbAD0v3GKSxwGNNDict1g3msoY0a4LKRVIKV3aMGOnK1VI+RpsVkdpr6oPDoWIzuS5fxQ6+hWgPDg1SHWrIv82N4Di5XMcQkGRKg2Y1QdLt6l80pE0FoUqkOz7lC0ghf007oBCmBbkb/XrO0WzG8Z7V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799006)(186006)(451199021)(478600001)(6486002)(6666004)(6506007)(26005)(1076003)(52116002)(6512007)(2616005)(66946007)(15650500001)(66556008)(66476007)(8676002)(316002)(4326008)(8936002)(41300700001)(5660300002)(38100700002)(38350700002)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nYXekkgBzqIYM7SrKODVUZ2rM+8ZsJA9BqkGQZcAKCFQ//xd0SwMgzCFMGj4?=
 =?us-ascii?Q?/Wzm/0b1nx+DcsqSEd/JBx19L4cwz11KsjqTxHdbYeYj9B4urOms1dkzfC5C?=
 =?us-ascii?Q?C+3FuODNAh7KeDkISg1eKlBH9zOZ2ymlyDbWExrxLIdFk4lZui7i7BHfwD1T?=
 =?us-ascii?Q?ABsccflA3S71VFeCLHW0oHW3tM2pv77kogP7BZSD44NhX1CnuvLFoHqbPyhn?=
 =?us-ascii?Q?Sl7vS7Bo1A+zwUgI7ME2mvm8AhsmflLlw3VnksPwzr9eBBaV8Vu7qOuMotRn?=
 =?us-ascii?Q?ZHcIQ7UEx0r8ZG9mJG8qOAjoWhD8ZAbTWgQ3+JEP9nCRItwPdH26FrL/jkhh?=
 =?us-ascii?Q?syYi+yipsFQLX/2glY8sQUnS2y6177OYfT28NrO3o7Rhqlz6Q3XAr85gamDF?=
 =?us-ascii?Q?w/hCCWMPRgaGpYUIsv25mDJj5vnHj1iNoyUdrf2Kkes8Uq1lFkv1rYY98XDq?=
 =?us-ascii?Q?hieOOHSiZJLfDDSfDdn2pSBOOJIhMLjSRXYlL8v19/UOqasH5ssjbBMuJmDr?=
 =?us-ascii?Q?kubNHBF2MQ4lNanUd+4e9T4KMzVpHygvJyjBhaZaVLgPgqBkpKz/PGNAQ5HK?=
 =?us-ascii?Q?A6g5Y8ZU/BpxcH/vBRW/tj/yROeHn8j2R8nsw5Ar0VZ+wr7k2Klk5DGpfBEH?=
 =?us-ascii?Q?28zcP7X2Gk7sui09lBWizCmsTmdd44DPaWKerGekHkW2uburJ3IVb9C2VVt9?=
 =?us-ascii?Q?VyucwLDBy0P7ZZTJg+4LL7AJgF8feydLvUQFMGd9+RCL3/2ATxwxaqpTbW+Z?=
 =?us-ascii?Q?gf+tgC03MNpnjEq2FNX/2ZLe8YgLyDGE21j3JqJVU3sUYPfwX1UZwuKdL3uB?=
 =?us-ascii?Q?6Vhr6aSSTTsQ1vMqn9IZ2V+FfzeuF+vDbLZ74hIdbLUfDnwCCj5gX+acSqXA?=
 =?us-ascii?Q?tX67mCNqPpj/6oXvKe+hA78n1WcI/AtKWW8DQXnm7l8xvThjQZ5DH/Xdqpy7?=
 =?us-ascii?Q?qM6ny+h+r3JBvPKgqBnzbH2d1bdo2IQHuQHgneI8zwzQZkuzVfM3tUkXM8GQ?=
 =?us-ascii?Q?9L0xcNEciS69Jk0aPNF8MtBc31dyoNyzRWhGMICneuepK+9zSePFvEnL6Cqd?=
 =?us-ascii?Q?t40W/24iRKrCjqdh/FFyowpY2/uio8t2vh8WJeHkhREXhHJAshsJG4FJricv?=
 =?us-ascii?Q?jeHOz5lyBIwNVCPhFKQ0WDLeVSLQR7+FaCd+v5qAh4q2AraJTv4U/UQ7+SPI?=
 =?us-ascii?Q?X8nuSTC6LA6AeaBaEpihNd02bhX6e3xgwpsHg4BJv1VS0uqO9KwBmE9cDfyp?=
 =?us-ascii?Q?tK+skaj5T+JPQNPz7n5qefJy1wW9sW08kTmXuHy3cstKpQ4vkC4zCCMknP3b?=
 =?us-ascii?Q?kJwi/5hFSRdSGxS/CyPv9GOGnuivZbf6l54ll497TCh/dGEKuotAv+FA6cZX?=
 =?us-ascii?Q?4i+yffVgMGYfSrbw3+s937WAA5Sl77UCGZn4CaXvggA3jWdHSs7zSK3pibxd?=
 =?us-ascii?Q?qPL1v8H/AqiIv75mlvt7JDOt/RehyL5wHv44WfWFWjFbwoWHOTb4tYV1cqB2?=
 =?us-ascii?Q?SxlvCsZJs6iXhihHcZ95t/IcZ4kmQ5Lj+2AdsZW2ewOciYrEEgxH6jx1JsbT?=
 =?us-ascii?Q?NvlQ0zBiNhyk4O4elVXQAnN9A2pAS9aScJ5VE4jO?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a562d470-42b6-4d20-8c06-08db9cb25e14
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 10:36:50.2415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n3r8tk8+rcM7a+5WEfjrywBAJKOganVA9wUvaAVPe6YCY6MVsqY72VJq0OS65KL8W81HIZuW2evwAkmCfLsVkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7216
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Update commit message in patch 4

V3:
 return -EBUSY instead of return 0 in patch 4

V2:
Move drivers/firmware/imx/scu-pd.c to drivers/genpd/imx

This patchset is to upstream NXP downstream scu-pd driver patches.
patch is to relocate scu-pd to genpd
patch 2,3 is to support more PDs
patch 4 is to not power off console when no console suspend
patch 5 is to suppress bind
patch 6 is to make genpd align with HW state
patch 7 is to support LP mode in runtime suspend, OFF mode in system suspend.
patch 8 is to change init level to avoid uneccessary defer probe

V1:
This patchset is to upstream NXP downstream scu-pd driver patches.
patch 1,2 is to support more PDs
patch 3 is to not power off console when no console suspend
patch 4 is to suppress bind
patch 5 is to make genpd align with HW state
patch 6 is to support LP mode in runtime suspend, OFF mode in system suspend.
patch 7 is to change init level to avoid uneccessary defer probe


Dong Aisheng (1):
  genpd: imx: scu-pd: change init level to subsys_initcall

Peng Fan (7):
  genpd: imx: relocate scu-pd under genpd
  genpd: imx: scu-pd: enlarge PD range
  genpd: imx: scu-pd: add more PDs
  genpd: imx: scu-pd: do not power off console if no_console_suspend
  genpd: imx: scu-pd: Suppress bind attrs
  genpd: imx: scu-pd: initialize is_off according to HW state
  genpd: imx: scu-pd: add multi states support

 drivers/firmware/imx/Makefile            |   1 -
 drivers/genpd/imx/Makefile               |   1 +
 drivers/{firmware => genpd}/imx/scu-pd.c | 193 +++++++++++++++++++++--
 3 files changed, 183 insertions(+), 12 deletions(-)
 rename drivers/{firmware => genpd}/imx/scu-pd.c (70%)

-- 
2.37.1

