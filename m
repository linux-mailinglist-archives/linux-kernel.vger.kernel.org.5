Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E041C772371
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233240AbjHGMJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 08:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHGMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 08:09:55 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2077.outbound.protection.outlook.com [40.107.13.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B242295
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 05:09:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiRvBT1uSDm703X4K2Y/j+2dE/2DHRqIOq+kDBjMFz/yTWywYSznd2cYpk+YwOtmtZ0BEFmb+R9ztYaa6vqNgPrSDIfh+sglZxFTnZwyU09uEXAx9i+yc+pW/3DszdEHDwEflZWVXwLBuzfEWhpGttFaC11f2noZU+QjnWZFK1sBPKCn4HhMgBOaqfmwu5g/VbkI9cVQM3jGoIEanYFSo+0Mo/Ntx91wpUQ+ryZGe6/zmb5a3vSaCV2gSQWKeeP8kUoKalcjoUZWQ/ykfbfnkQv4btLdrNBSRLX8uMuGgP6+UdqpGWdReyf8cowT6IetGly+n5tX8J1AM5ql0oMdUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpGi9vdUc7zB+lZVgEPLXk1kViQB4sGv8Yc/WJJ8XuU=;
 b=ZkeT5h55pym/tLy25RJH+ab4nlf+yhwX1NMVqWinEkvKBwDf0J+XsVBZGt+IfB8ZwPCaJ9j/P6W9N9TQu3DLeH5UcWooan50FHHjwu4OoWMLhAbHmsvMMSKAhKZ8wRCNa5qFDw7DSsCvFtDkkLTOmEjJOcX3893QJL+uD2+Z7R092+gGYhiW8b3Xk/ZaDGG4K5GqL/qb2G/VG8QmFWEuH//3/VmqqF+qpH0kV0V2Sy5ccqbSf80j/CrQnBRKk7C7R/9U87aUP/6HCOTRwqsSOoeEutO5it76iIEz6pmirauu1kKEn1FKWkqTM9QbBY8lrcIA7LogZtnbaB4RBCtEew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpGi9vdUc7zB+lZVgEPLXk1kViQB4sGv8Yc/WJJ8XuU=;
 b=OyHZopVoH12G7D/1pkr/1F0mWWyCr3qu8ko1E2L0A17+9cxl2AYpMqMCfNj5oVWqQPvPqF/Ie4f1ffbO6X4xn8YTqFy76X3UgxK/HJd+JVSR4FV9jj+3+bv4xjQ2vV6Dmo4kQnkoFobYE9hOCBRkOpaE8FBcPmEufKpTLJf0w6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7261.eurprd04.prod.outlook.com (2603:10a6:800:1a3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 12:09:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Mon, 7 Aug 2023
 12:09:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/8] firmware: imx: scu/scu-irq: misc update
Date:   Mon,  7 Aug 2023 20:14:24 +0800
Message-Id: <20230807121432.3970610-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0158.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|VE1PR04MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: f893f987-849a-47f3-c500-08db973f334d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0SyEJxJDkvE2A3xqwnFKwqUt51yPTyQOH36l+g5rp28NuhhkQJxZXr3aD/jo+a4EWn+xL4qEHG2WjggjjEFgHlBL9idh0FNoJ8ra14r77hPCvrNcKsqlkATIFfNfMGdzYwvSEypnqE5oXU+kyYpbkWOq34UVM3YE/sOCDLcIoHaQV3RTjAnSa5UfL3WYaE7ZVX2mdUwM1k9xI1TtydjezDXU//9k0APbj26Fog/omwp9MoYfMqsA1SRByjz0Q9OpVGe1bYDQnVokZkR79Hk1hVDPSvYUAs17rOUVn7Hvl5ut/45gTC5cTMPoIw0UL8r1H8aTfdrk5luGj44Qlv2eEGHsnaMbbGnBm5aN+n4DtyuEcPeYFLEucw9ruVF4+Vc9YD7EQp493euWvjMXX3J7JFV3JdmTrPQMBJDJMvIG2AGAbUbZGqW/D/1VmLedXNzUveIfRWDaCGdakCBILCtOaxXx6qzG9KEZdy9+/BZseNiYsoboBUk7UPGltn/FIMd/MsTG1tBWAEgzuP9EsN9AAEzeb685a1Ybd+3ISyjqGV/UNMMmdvPUwo+Xkt2W4LpE4wxD+NJq4GLV8psERopdSC4q2m7pcjw9gzu8mVaA/V5sPOeerkk2YclOEgdqwCyK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(366004)(39860400002)(376002)(136003)(451199021)(1800799003)(186006)(6512007)(26005)(6506007)(1076003)(38350700002)(38100700002)(5660300002)(86362001)(15650500001)(4326008)(2906002)(66476007)(66556008)(66946007)(41300700001)(316002)(8936002)(8676002)(6666004)(52116002)(478600001)(2616005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?neFFP4V5hBSlY73kHpBRFNcKsr4ogsqfKw4it+Mcsz21zCz64CIqzEUq7/Rt?=
 =?us-ascii?Q?Jk0asNytPkc1q22nHqd2DGSXG8dd+iuDKW1mAOn0XYqkujOAfLFRBg8m6Bos?=
 =?us-ascii?Q?/6GROqqWF+avyTFYwONhcHIPUCF1US1976UjcVAbkVDGxN30zdWdzJFmq0eD?=
 =?us-ascii?Q?c961MzYPTXE2hI6t/sOMofkIb8S8y7yXYdvCgJHUwUfPQv2LSYgfMPHk7dUV?=
 =?us-ascii?Q?LhfyYktQuNGR0CaPURyQONBRprs0Wodm3Igf8PiRLBVu8vtApf0KNWSlmB2V?=
 =?us-ascii?Q?3aWRFBYopUHzvSIdvNWXktRkfdeGuPqaY3S7qqKeTgPhNTh9HePAmUbIBoPW?=
 =?us-ascii?Q?PYxCQeJgUzhAJn1mVKX7uBaGK5s89m6Vhzx8YyI5cWOW2WZeIHjjqukWbf50?=
 =?us-ascii?Q?y5PAa+hizRuM1aPutR3Rn1Ku5a9eh1MCoXP4UKaFRSN71DoVoEcylKGuYgmJ?=
 =?us-ascii?Q?6kLX9v3tDvuvrXC3XERNXJZxQHdcTJdxoa7rkhVrQqZ4S6UCGFw9EBKUoTJ1?=
 =?us-ascii?Q?yzcNZ6nfxKMkzNCtZfzG5a5c8ixQEgzPT+f+3xH9nq+IyxkKUy0klJH29/Xg?=
 =?us-ascii?Q?/GF4cmr/57HLyFCkkZyjxOY/ktQovMA8eo5U+e79/0xT7gFkRLZd6mPCeswS?=
 =?us-ascii?Q?bsEwVOCiLNGJLZTMmrupHWNYOXrzJRTKfxUTQK4E10/Iz8adL2kb+rSy9qOU?=
 =?us-ascii?Q?R4tb01668BapfkMSQvvuPAceYFjBnvSBTWVAsntp7ogITOlJuNWl8GxWFkYu?=
 =?us-ascii?Q?DrvBTDldmiv6tADzSEjwXPtSvrTvMmeC/FVNgiznNsR1jMREe1T5RgQpe1eh?=
 =?us-ascii?Q?MryERyOeEevm6FgXT2VmJpt0dLjxR3BmoteiDNuTLX1iBvj/37HW5MJ0bzQ+?=
 =?us-ascii?Q?9bP2a9PSmdnWQlacoJVZ8mfQIq4KHs61PyFcDslHS624eYDAPcOPs2shFFej?=
 =?us-ascii?Q?F7x54+cvUwq9Gkl/RyqKzokM5YqIuVJxoXVxAJzPVkGlpJyv2p7q7bAPH4mG?=
 =?us-ascii?Q?tlMW8qqwoMjbHn/jFWo3ipSCfowFtUZiMfgs+elWMv53hRKVl9lRQIdgJT2L?=
 =?us-ascii?Q?XQSA5JOPD7Gd0qbEtlxkf9ijerUM7FTC9b2yynS9khYoHp6GD0f2kUYil+sZ?=
 =?us-ascii?Q?EqaADjt0aB8TnGntXuFeuq40LAUEG+P1Z22f9bk6ZZfjJQQutRY0Et4WRH5Y?=
 =?us-ascii?Q?+Ru0r4fmcexWoBhXlXlvxoiyDNtQpxRRVoPl0D9F9uajxz73XK7HI50mllv9?=
 =?us-ascii?Q?XJD2EtPFLjyHFo+/TrBiYwB6ithBXKSCMDAAGOuL2r3VBGq2TzD2gANIgrLE?=
 =?us-ascii?Q?sU1N39JFVewHxcZ333rgBMxoFPAcjnUqhEBSJQsFmmtT4y7Ga5FuTbXcqMow?=
 =?us-ascii?Q?NbxZYP7fgXQiZ1lSyhzj5nBKUeXq0uLQBGqn59mH9NKGKk7r1NZa8XmnLqbt?=
 =?us-ascii?Q?OUkwi6s9qijmGOHWgAR+ZZ404erKr1x0fKbDT82bk1DBzzXMTabdXqApIdVl?=
 =?us-ascii?Q?CqK9AEIjNoFD256ULQ4DcigHfqv8iha35nik1wrSsGAIgU4SukSKQNJYUxmq?=
 =?us-ascii?Q?bzIp7HA+h+48A5+TGLA63nGZa9HxswIiozpjqNkW?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f893f987-849a-47f3-c500-08db973f334d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 12:09:50.7387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUz0J7OjdUhbAA9uOWLkcxg3jCJAPWZC9hfb8vv3etZIzSXakZcxt2izLHOW9TQKwoit0CEj8BHDSRnSG4fvRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7261
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V6:
 Typo fix
 Update commit message
 Drop Patch v5 3/9
 code style and error path check in patch 8

V5:
 Address sparse checking in patch 9
 Add a new patch 5

V4:
 Add static inline for irq get status when SCU not defined
 Drop two patches wrongly included

V3:
 Fix build error reported by kernel robot
 Add patch subject-prefix

V2:
 Fix build warning

Dong Aisheng (2):
  firmware: imx: scu: change init level to subsys_initcall_sync
  firmware: imx: scu: increase RPC timeout

Peng Fan (4):
  firmware: imx: scu: use soc name for soc_id
  firmware: imx: scu: use EOPNOTSUPP
  firmware: imx: scu-irq: add imx_scu_irq_get_status
  firmware: imx: scu-irq: enlarge the IMX_SC_IRQ_NUM_GROUP

Ranjani Vaidyanathan (1):
  firmware: imx: scu-irq: support identifying SCU wakeup source from
    sysfs

Robin Gong (1):
  firmware: imx: scu-irq: fix RCU complaint after M4 partition reset

 drivers/firmware/imx/imx-scu-irq.c | 118 ++++++++++++++++++++++++-----
 drivers/firmware/imx/imx-scu-soc.c |  20 ++++-
 drivers/firmware/imx/imx-scu.c     |   9 ++-
 include/linux/firmware/imx/sci.h   |  16 ++--
 4 files changed, 136 insertions(+), 27 deletions(-)

-- 
2.37.1

