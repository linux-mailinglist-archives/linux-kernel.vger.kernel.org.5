Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C4975AAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbjGTJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjGTJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:27:37 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2062c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe12::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DD549D5;
        Thu, 20 Jul 2023 02:12:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lWc829yPOxnvTtzVOtZDirdsjYcnfx5CoZ8A3aFtg6sdwpT2jjiy2rhBhvYB0P1mJUaOPPx8eKjh2uchTM2AnfQQqIG/WRuc0GXxmZge9XzKAOxKzvlo6FWLqSFEfMIARbRDyezzxG45d0igt6gIElh4ZaQNFUt42RhqdD1BpunZqyblWI3WggfsFhb+AEZlAiXDqV9rBEfUXnIw6/qhhN50reBeYOx2OoRcJSFxqodDDKTHgSpqLbhoL3+Bh3f/kCFncfpwb4vOx9zxB7hvs6pqkok8G7khaFAbAlBrgweBG9pbpGcJxY9trI1FOwq9xZ1tDPl64b/bDEQ6w9BBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WE3U8Scc6hQnEJMsJ6Nzfn/+ggseUccPigP3qgNbytw=;
 b=i9mz+IAJ71D+8LuUJhuaJMRGyVXbgeC6k2VXLNVIVsJOk5vocIN1PUOB6ZB9f17jGhbn3hkMwLfRraDkK6OJ5W/0+eNKKFrpWRAZLzlK0gl0kAUIxYKv2NOIhv2MOZqs/h1ulabe44MAnH7u6SUhn3U1SvB0uwcHyBW7Bc7dwvETHPxY+ZUxDWRjtPXHMHQEGa3MMB8pluNY40C0m7Mcbqm/WX/wQ0xI5MEMpWHTKG5/Fx4O4rcZ7LYysVGXA6FCVm9sHT1Z0KlE9/jLhLlsNg8jxKxrfoTBcGp/jiJlKCGyiTEJZZQP+suod6196q4/JXzOAI2tupt/l/KnCj1thQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WE3U8Scc6hQnEJMsJ6Nzfn/+ggseUccPigP3qgNbytw=;
 b=F9ca0r9T63c5A3ngK6eodcR+A3egYl/9nKmtL9FrJogmobIXSni7F6h5Q+KqlW7QGkeuJhph8PA3KI9ZfuLLNxuD+z3wCmrbCdOl4jrJJX+5WqK5MY+6GIsX9ocwPpu765UkuhqzbSH/PJ4OhIHnZOalck3kRZv8dWQQKOtnDq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10015.eurprd04.prod.outlook.com (2603:10a6:10:4d9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Thu, 20 Jul
 2023 09:12:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:12:15 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     ulf.hansson@linaro.org, shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/8] genpd: imx: relocate scu-pd and misc update
Date:   Thu, 20 Jul 2023 17:16:53 +0800
Message-Id: <20230720091701.517197-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10015:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b8de9d-aab2-4411-531f-08db89016903
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0c1ANmMmTC9LCmKrnkdjarnydPXoFPX3oDmxRE56bE++W9Zic+ya5i9pVEOzQVZioav1w42nImZiW3qAk/PeZhNFeyujtOdCLDdaqEAdrwd7bUTaCscjCB/UhN9jufH5zJGOfpBiA38KtutCFEfbdIF0pyaBWt1V9GhMcVdJgLgxp26b2yX6V5a0pmvDaoT3z7kG0q8c0KvHy+MYXARzOYia9Ud3cfIkKpLDHI2sFqrvEVDXq8ece9rgFru7DQohRE+2k4ULDbL2OQdly+ksX1RoU8FrYH/qMwVcZCFqkV9r18W+GO2LyUuKhxn9qnR8bhhrh2QK643NeyhidvylDVmdKMX3lV85HTJbQS4T4ayYKUu9vDTLWBaWXS01yPOa+1Gme67FTb7VS6IAhy2JH1x9Dp/7LtGOEe3CZQOp/f3/UpQvoVq/LFPwdulZB/9elWZOgk352TAtiMVepHWsOr8JhqSFoWL9X8Jqq7G2BcO4+3JVyuAjB5HXInzOFkYK3wczrSPHYrqFt/8KCqaEwr7fo5cFTGhRiKpomaswaYNJRRIJb+EWn5+fAzcNpq3PiZJ1pv0JC49/3s5sPE3VUjTvdQLjBYOW71/E+xHwp14hETCedTMbyHvkFqXZmH4F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(6666004)(6512007)(26005)(186003)(66556008)(66476007)(66946007)(316002)(4326008)(52116002)(6486002)(41300700001)(1076003)(6506007)(5660300002)(478600001)(8936002)(8676002)(2616005)(15650500001)(83380400001)(2906002)(38350700002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?g1cGw73Kl7HZAvefNtgu3H3qSn3Qx+YkCt7kCg5tWvdrS3DX35TNFtSK9kM0?=
 =?us-ascii?Q?1oJUbNWCMpjPkEfJibgYWvs1MMz6ZOb14f+Z5/dsm5RcCm3zWQaxoWexVuOX?=
 =?us-ascii?Q?JkcSrHmjzXxYTvunAW7TNglHTvmH8FgxLNMR0f0yKzqsND4oFL6jX6sEr4wq?=
 =?us-ascii?Q?JmGuXOfbR3renu2Tyl1vL557axxQ+4WVY15dzH/RpRtVRswCtAVasjmDP0JC?=
 =?us-ascii?Q?+p5SaAFcnzUahwmphZyFxxZbcdjPpm2fqiGv/kfgg3zfDAo7PRk6Dbfzj6Ef?=
 =?us-ascii?Q?PYFkh3mE9NUyoTcamXoLJzbfXpv8WrctzsjsxuFUKMzCdVnlTewXTqHSnC6d?=
 =?us-ascii?Q?fSWphY8CMu6v65I7kzlfNmqk7Ab0SjtDL0SiHFS4ajt1+2mEZWXZFFYaMY+X?=
 =?us-ascii?Q?pJU3stKALJ+N65dkpQ/tqK+eWgREvABjScnD+JNSGUeuSghTaKrNwPFe2kTK?=
 =?us-ascii?Q?HUXK4DcR5Q23MITUG0UOIxlG5SkqtkT6yxHm/zvrANR6SxYClSZEyG+1iVfH?=
 =?us-ascii?Q?J93stA9Ih5k2vfrmeJlLkNb4wmhpZOfVb85nq8wT3CPpqKmnVPqmuIgKbCrT?=
 =?us-ascii?Q?YfJukjgrZbIJlVpfjnQdFdp4WyrhKRj5IPX/Dcf/t490MyFSO8lpq1NBJ86l?=
 =?us-ascii?Q?zMrZ3t7Ve70Wb9b7jaiBpiMTlplz9LHcrDEeQjUxe/OnVqplrLW/3hsfAwkS?=
 =?us-ascii?Q?0ywLr1OoYu9hVIZwqmeKoBw+8lsIYJoSectsQvLnzsMIjDS4+rBBT7vdcTT7?=
 =?us-ascii?Q?knDKuqD8mxpcqRQmNJt5ActNrD5aeuIA5uU4J65uF0gLin+WJM2Bhn8WX8Mi?=
 =?us-ascii?Q?Q62lTRlmz8nc4CrhLvHYEPDqaK3fuommVMLOEq6+uKCjiUG3lnLD+G5tRLrP?=
 =?us-ascii?Q?VykSpRvyd0Q0VbwRUedga6kRBqsgslMU7hDX2IWK/Y8qb9k8ibZc9Gj3LbaD?=
 =?us-ascii?Q?Sw/hUK9tSVQIgXVp/CcNrO+Fv9/rNshUA1df3/LokzzJqTsfR0BOGwueagkq?=
 =?us-ascii?Q?dVvbWrxGR5rLCHN5VARfbT9tvU2XyCtGvS4AiJdBYWcexs+7QZaJCKzwbSUM?=
 =?us-ascii?Q?MoApaIMeDuUUnACaE6wmvfrkc+EnqLrTcrs9wtnhBTQt+CZgsUcT+82auJeJ?=
 =?us-ascii?Q?qivqQu4bCahQQiwHMevvJeFZPTi9dj6hAuy8qxR5Bow7OW+fvxEp5QDbtmyQ?=
 =?us-ascii?Q?ke8jWiQuroY+qdaVdF1sgY1eqDUe92pFvG4DMNN8NqocF6PVIzG7AlaTQrau?=
 =?us-ascii?Q?MBHsDaH/sO7l1xCnnqXetVrCcXpbRzU0Qrta+RX+AZmSwA/+wGWawyg/tc/K?=
 =?us-ascii?Q?KldCbGBuR1bXw/UbWHiqBaGZb9S+HjTNJYJKOfFNwUlzwz+Y+En62PnYGKkK?=
 =?us-ascii?Q?dfKwH5UNEDK8FKfXcBlNGgPAsY2TT5ladCYUwE930WsP24Xdn+nwuw3nKrls?=
 =?us-ascii?Q?XLEYY3v0tugu/eb3Auluan3ez6nbAOIc+lM9ntl8aQF+kNxJnN8xvgeUZKYE?=
 =?us-ascii?Q?L3MYiXaWd8kPnNMwHDHvS3HcQCIxmw64vV3JH5xa5AVP7P4r/kvhXFvoiufN?=
 =?us-ascii?Q?MUilMZhN+apZK2kTRdIi9KZFo0vCp9RXJMnyShSN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b8de9d-aab2-4411-531f-08db89016903
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:12:15.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Moux035ddorDRMBgtDbGbzuEbXu1XR2CZjC1W2owmNrGQVhc3HSRx+kU+F5tDVseFPLSQhmEMgmV1OiC4pUOPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10015
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
Move drivers/firmware/imx/scu-pd.c to drivers/genpd/imx

This patchset is to upstream NXP downstream scu-pd driver patches.
patch is is relocate scu-pd to genpd
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

Dong Aisheng (2):
  genpd: imx: scu-pd: do not power off console if no_console_suspend
  genpd: imx: scu-pd: change init level to subsys_initcall

Peng Fan (6):
  genpd: imx: relocate scu-pd under genpd
  genpd: imx: scu-pd: enlarge PD range
  genpd: imx: scu-pd: add more PDs
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

