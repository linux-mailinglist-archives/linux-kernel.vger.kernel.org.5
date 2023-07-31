Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C91768C27
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 08:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjGaGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 02:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjGaGnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 02:43:06 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2085.outbound.protection.outlook.com [40.107.104.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBEFC7;
        Sun, 30 Jul 2023 23:43:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pk+wXiFVu89FPXpJ/GC1Ham9ME+NQjwqb/2dG7+vCoqBQyJK2iE50Z1wsLPn6ENRpBpqAvjLJeMDf0B94wN8tQNouu7ZQfQqC99PJNtltgfmriF02bQtpgt4eQ2VoI2lQJtoLFIruCmJkRDiEDC54ZqkO2oA+fMO6dGmj2Kncwyle9JUKRI84TEVisSuuBARAphNcNz0DxT5g5l6CDVOqTuwtW/f4+t9blSvraCHSY9yZkY3eVg46VqKauYRUTiijO4gGo5JmJmmj6xFYnimVeV/Uat5QOYfQlGE1UIgTMmE7uD2Li7AB1VD2H/HXLjJbv9I8zMWVwSqf2/rkjpjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8qCAT+bk/uo+L87OpkKCwpf0m8+uheASAZ1Gm9UnUtk=;
 b=hFpXREI5vuQieGoCtJSRwxo3WyPHxD8opatkcAOSq8aIp7yuo2WGKzq+QUw6SH43ueZLZI8TpDOwWZ9re7/lGJgesQu93vBi1E5G0b7TJdszFn1HoTs+2eOa5joDdIjXazWgmfXpU4kTn96m7VAMI7iiJ4dn/b68EncZkrqwUOV6nNF7s9vBNPl+atM4/WZKXeZEmeVOEC6pc6CO1BoRJW3Dbr/fSn6Fmy4SCFDS13Orps1ZVTCURgARDY53MRgHKorMQheI9EJWrg26TDPWNnPAWp410cWsBTVz2yUzHEa4q+Lqe6cMSDpU6TebIWeU6mkoWT6c6h3LdMgoImi3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8qCAT+bk/uo+L87OpkKCwpf0m8+uheASAZ1Gm9UnUtk=;
 b=PynLS/Q5a5Zl/eb1r1iLRlzrlr88qy6gYakOeqKudyz6l9DqPNGj9CUrole5/ugBfbKIYoBqtnCM4dRISleWQhMPW6Su1CgtOhUVFB66dfJkdNjfADVS0GgDtBOiKpJ3cYhU9lvn5l0csNFXlG8bpdi2EOhSrvorwUMQ5BkKpWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB6834.eurprd04.prod.outlook.com (2603:10a6:208:17e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 06:43:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 06:43:02 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3 0/8] genpd: imx: relocate scu-pd and misc update
Date:   Mon, 31 Jul 2023 14:47:38 +0800
Message-Id: <20230731064746.2717684-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0133.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::13) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM0PR04MB6834:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e648da4-ad98-4b34-6b9d-08db91916305
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YaPqBwhVeinD5krplP68qFVFGy1EEmH4UfpuaJaboeERY4MDHnGtgP+PSm/m7MiHNIBWNB/FIpQbwcvl+drDkjzwsiV4fT8r8WYwhb2GpzuPBNa8SkrNDq6SpHLkBmOfHXNV2h3lrco7fGMCiUzZs2PrdeMw9zsRjYcD6mRRPCDctuAanTrk0qNpTcTvVOHYesNh7A7ukI5BePu84y+WiP7WZGVPR1fammd/3knJsZtIqpiVSfqFdEp1K1pCH++t/HwBDyAgCc2r6ypa98xq1v2XZMrvGdr2fdY7eJiGv5/x61/mV0FfOKkqNC/ZPfdjupsJIjWw/6flj36pU+PIhQQVL1WRXRBJlzOdVr4ERWiABcd1K6OdR/db50MrRScVKsk2uO/XrpJICEvPceRPpj07fp9FAgBMLj+tCtb3BM6Z7tA+xjfNaxofUTPpjqYNYgl0VYQjwSenipC4OlAGIUPN6YthIVv3ppxzCmmFaLfUe8y3hwS8Q++d5KtxCjXJKCmJiWWiHiNB83GYbTIYBNjuCTKsP6a4LmYfHjz68/EX4xrhvLUSYGiWpMcxlD1YYcloAyqKFcJPff1TAk/okvZSz+3yr/GvhJtgFy0nwCvj1n5g8BugJhii/mRNFaM2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(39860400002)(346002)(366004)(451199021)(6512007)(52116002)(6666004)(6486002)(186003)(83380400001)(2616005)(86362001)(38350700002)(38100700002)(26005)(6506007)(1076003)(5660300002)(15650500001)(41300700001)(8936002)(8676002)(66946007)(66556008)(66476007)(2906002)(316002)(478600001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPh+hMZhfCi/01T7m9SATkQx5vl+O7X2QzpCHEStBBB2bjFRfNMTYB8gZ86c?=
 =?us-ascii?Q?f60bgd/xWzm1BJqg/MIIqRat4HhXl4DO7i0qOnca/pq0KHcHOczWXhfVgkjW?=
 =?us-ascii?Q?q7YfdwLUQiWk79vXy2+Lh7JSU2yCWVG4LXX1uV0Qs8LOa+qo1Xr/5UsEO81r?=
 =?us-ascii?Q?5IkmleCd4oC08GYnoRi2J6ezi13Rhy0kC2tx2bPMfyBROFmrJb3L5OCfxwwv?=
 =?us-ascii?Q?mCR8s6RjS8AYpOrtvwwXFTsBxzqUoOyDnZD5m9x4rV+DllZzPwv10MwacRB0?=
 =?us-ascii?Q?LVkQjtSq5qhuEVGshDWvMFcfVKDqVXxN7DH/hkrjwX1edo0cNIE2c4NPDytU?=
 =?us-ascii?Q?cCI9+cNV4+fjF70dWNVsGF6JJM8hdnRM8lxBlJulHjCdhvMe0511hfaWsLYt?=
 =?us-ascii?Q?ZzTYf62yY02zam7xKAz+rPkw49NeG+5ao2LFrrJphXivMcSxO22DUkZbttl2?=
 =?us-ascii?Q?fdLZ9awgAEy9mBzoMsdB3MHtH1zmfKifiygudvvBBELyhprZpF/Y4r0NiyJp?=
 =?us-ascii?Q?lDcY6yDofuaUDfDs0247NabB+u8eSIXfAkskwIMLyxkP8UfqTxofgjhW593x?=
 =?us-ascii?Q?qA4bauO7tv2/HJiTvmstx/EEOpBMaDdZ6v9c7QxDDy6ysoOtkOzV3dDyvSw1?=
 =?us-ascii?Q?Ot7vJDXUlku1hrlFSI4Id8heSGBrkap1YssJpS1Ih8PDkOfuE44TjQYjqT51?=
 =?us-ascii?Q?H/AXTqzVsQCvSTdxz5TbOBA0ol+6mOQHCX8e0+zeK+pWqMptg3pxV4diiVAe?=
 =?us-ascii?Q?fbhSJ78rr4Sx44GKl15lRS23K2f2HMt+CsNpsYVGZ4r9BBobFgCntyZZCG5a?=
 =?us-ascii?Q?dETj5Oss9ZTTTNh2phhyG0Kn29jujgGebg7e+KnWNAnSoL2FTRTUvG7ttwXF?=
 =?us-ascii?Q?GcxETpK6Fzeo45Ydn6CVa7+sRo9lx+NzA+udnUimm2aa68jQxY3fvXwGeb4b?=
 =?us-ascii?Q?5YYqhZ+AkAmf973xqZ25PSaeAF3Z2Xv8bQy4/ViOD/0UCsPATfufmQ8GPuMK?=
 =?us-ascii?Q?RSFYsxtsxxL8Eov5YEYk9VajSs+Z5EtzV50NFoGHBB2bZGmLAsWHL+xs2F3f?=
 =?us-ascii?Q?uMXG/UsLxx3115in74w6a3mjfOxOguRaeS361WeznIZidBx+duVhcqN52WkR?=
 =?us-ascii?Q?ciGNpNEoMzNNZo3aFoeqkbkV/QHy7nkoY81EY1XlQ5vt1GuIXl2Z3dK5A/O9?=
 =?us-ascii?Q?+I5RS50WXXbMRw0cxmnRFavTmf2FeqOFZg3yLheFeEFOzYxeSF9N2zDOrtXE?=
 =?us-ascii?Q?F2lJ+pc062Nl8doJSOwZJDdh4GFnqC1kASCTTRIQzMaStoqCi9M38+Glpb94?=
 =?us-ascii?Q?4bkPfOEtDo9bGrsyYJsnMTzTYHMhkU/G3cacG5SspZYVvsD+YJimNuk11S5V?=
 =?us-ascii?Q?IA3t4U9MuOgajW1uzX/QV023LXp9ED4G4aEssc2gm5DK+bp2fDMKF0jzhGNq?=
 =?us-ascii?Q?K5chzEuStohAPzpxd0OOH7F99kZ52drsSAfxMmzE19h0BLckzwZYzCkeGPo+?=
 =?us-ascii?Q?i2ZzHYLPBKmeSp4U2KKDdRyH39KOkWlcfPejNoVyn2Vb0C4M8ri1JS07hxDD?=
 =?us-ascii?Q?CoE5Dw8yLUkzQ+am20R1908iHgM3ZE8jnSnMLU0G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e648da4-ad98-4b34-6b9d-08db91916305
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 06:43:02.2799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlawkfH8thtrhLSvmj+7MTDG1RYFI9Wtb3fI8E0qSr3Lo22pZ3zZ+1fF7CCT/no1SDR1BqX8hW3n2WXYqBKq1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6834
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

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

