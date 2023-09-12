Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE8379CB48
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbjILJPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjILJOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:14:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5589710D1;
        Tue, 12 Sep 2023 02:14:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4x2MoRU6HtHZ0DhL8KleBqV2TuL9lFRFUX8ujAmCzIgUOGROh3KCXarBObRc1vZs2E+OkLKhhoStqogkLDRCLLVyC6YKs07d+AtakW8PlmoJsqKuWGs/F1u76Ycl+wUZk+ih091zTa54w3+5k5dnjGDUa0kE3IGVltMwVd6gI3HncWsGl81Fmmr3e+I4uBT5VGa3G8ttY70m3ILD+bfqCQORvo3muak4+PS7Z7oMUxNr/yEOITokp2d+0d/mUyDTdCCWQqxbvoVzF+jm3xYG4xL5TS4tCNYi+F/w7uzpV0O87EQtj3TQghknY7IxXvaNczCDX4R6uZxcDmxOUGHig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PcN82YdDCGeTPd+fXv83PAotSNIN2CZ60d4jwpWpeaM=;
 b=PPvmluVub/6ei10ctcTaZN8Q4aKf1o8uVhUMW0wH7fmG5Oy2aA9w8XqpeLowt+G27+hmBDq+xfyl7EHQC/kdd8HimxG1hCgmXNPdHLfr9AHDDqgH03diHJ/Jx39E5h086MbUzs0aiuanS3ivKWGg4pBdw7ZEMSiD7sVNBER6QnbS7OSmh9J4R+8YmVBvTyteQFWvgvq01MZ5j3K759jWrQJrjzrI0TJN1/gAPFSVEpsCEqvu/PmstLl1lNrg76w7AG7giY9Evvv/aTbpsXr34jwa4c+93fMPwiKiLthz0AFR+pLo0XJmejEqi7dnBGVMiiWmVwoszUul4Qo+G7PWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PcN82YdDCGeTPd+fXv83PAotSNIN2CZ60d4jwpWpeaM=;
 b=F14dW8qEo6Vd2x0EmIy7qzatEAAE5/wkUn6eNQfg2+UmJ4I54f4IStGkooYdwpW/XEc8dEoImYeZ8zFgBBhLOErwVt2gfQQcvBugW8lfrcZxJ9nbMI45CxfLSpsWTIrvNxp4JqKTKu7GCikf/MIcqX0zwNzlFv56i5LmzkIWhYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8036.eurprd04.prod.outlook.com (2603:10a6:20b:242::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Tue, 12 Sep
 2023 09:14:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 09:14:38 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Tue, 12 Sep 2023 17:18:59 +0800
Subject: [PATCH 1/7] clk: imx: imx8dxl-rsrc: keep sorted in the ascending
 order
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-imx8-clk-v1-v1-1-69a34bcfcae1@nxp.com>
References: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
In-Reply-To: <20230912-imx8-clk-v1-v1-0-69a34bcfcae1@nxp.com>
To:     Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Viorel Suman <viorel.suman@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694510362; l=862;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=f5k7a/5RBYMjQESO2snGHrTrX0QezNvh8x1DTDZ2TAE=;
 b=4iAHthzdzG+us7monfqTHfpzL8KSjp68GPnwWBqNp1nOyH4ts56bDYb3IN6j/Mpo5O5Ho01X9
 fw5RIvOyqZfCKiIA5mM3fJKiAv3KRNtyG+jkabov6DbWXnjoOFwfUdT
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: b9cdbf34-c397-42b4-21ce-08dbb370b069
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78nMtICriyMYC2SISY242cATujz0KjIabUNoOw/TtaSOrUus4OoDbWnpmL/c00VKFh+1rzIfGYyRmkq7slj2qjHFYHSyTNgoRvpv0omTb10jJ+NjjpOjI7pPH6bGN0q26keI7WiD1eL6Hj/zj1zFEc5eIPj5mK8Lrc2PtHfD4TLg3Q5wZDJD3TWDFruDo9VzT+iWK/ZSCg7CoHr0nhv6omNCdfCDr4YQChdEV0qyJPI3iHEIYtRn9bptzG7d0VavEYgx954BPpfF82AnLx+q9t8JiKhqpKXnENMbSvuXJaGaci7jO2Yc93shoQAXnwN4Lrp23spkE54MAwWPDMr+TKcOTfuyADX5Sj8WnouhVBvvFB7zdXZaG6xzysBhxeAaiFuPwzVfPmWAG7FFqTfNRZRPvC9699nmEA2I7Fb28ELiM11pnPxlfM6xV38AEy2DvmZnMzfiMPHGh7i0hcF+5+fmcxcTRNjRdfUbfW6UcaBGC25/we/1ScODnO/XjhiS6OtDeAPxYAhfJ+nOteJB9YZBdfuJet2pQZF9BXpW0On3FtdeiVqf6NLvqfKO4vKpA62HF2tt6496zPrK0pOGT61N2KeAgtaeqYq8Bwc9Y/oU30lr6QTO8lyNuVTOT4I/hcjVysjZosQXjfUs1o/AKswntvGGswlT3oKz09JKZQg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(2906002)(26005)(41300700001)(66946007)(316002)(110136005)(8676002)(66556008)(4744005)(7416002)(66476007)(478600001)(4326008)(5660300002)(8936002)(6666004)(6512007)(52116002)(6506007)(6486002)(9686003)(36756003)(83380400001)(38100700002)(86362001)(38350700002)(921005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUt2bzFoOXNzaVFQeFphcE9WaThlbFFTUUZmY0J1QWhzelpYUDNOVjZoMUR2?=
 =?utf-8?B?UE5vb05GV2I3c1dxS0E1ZStxczh1djdlMjNBdHQxRXAwbWVrdS9oYms0UnQ5?=
 =?utf-8?B?YlV5RzhhTmlRYVJwZURBK1RjMS94cnJIMkJQWWtTcnVEdndVQ2tEM1M2TWF4?=
 =?utf-8?B?UDVOam1lNjRvcTR3R1FDQ0VqL2NlVmVEMUtZMW40R28zMUhBdVl1L0ltbGpN?=
 =?utf-8?B?a0Q0MmtHVUZCT0Q2b1J4WERWMTY0cVZIRFJMbk5UbnVxanBIRWoySnMzMmNC?=
 =?utf-8?B?SmdrRU81dnNTQUpYVlF3T1pselB1NEN5WE0rZTZIZ3FXblhDTjlnVkJCcXl0?=
 =?utf-8?B?TUZqdEZlY1ZDbnhaWG5kT2xVVzcxT0tDUUpYaEQydjE3aERaVzBpUFROQzE0?=
 =?utf-8?B?WjFSRDlDcHVSNlh1UTNFNGhuZXdiRXJldjZENmdPclQ4cmpaNloxaE5YRm9v?=
 =?utf-8?B?V2dFYW81OU1UaWdhSEQ2bWJUR1ZCMjJHQzVaSHhXK1VoMGRmS0hDOURUSjdB?=
 =?utf-8?B?ZnNhbFBwL1liZkZOei9lVmtsMzRWVk1zRXVXV3hxU0ZXUW1NMy9VdGg3NmNF?=
 =?utf-8?B?NTY0dy9UdDE0aCtGVWh0SkNtb3E5VjhoOFRZem5aYm9NcGdXdVZlTU9tZWsv?=
 =?utf-8?B?bGFmS0pJWkY1N2tzOFVwU2h2MjcrS1BkTTROSlRVQWRJakF6bnZybEtNV1FI?=
 =?utf-8?B?Q0JQODEzbkJma3lxczZzZ1Znd2F0L0F4SWMzSnNvcWJJL0VRUVVWYkRBb0Zp?=
 =?utf-8?B?VmE1Ym5nVjlWeWt5aEY2eml4VmxFU1BPUjZzUFh5QkQ4RCtPK3kxd3NoSit1?=
 =?utf-8?B?dEduaUFzaW9hclVpaDg0NXdMV0lseEsybHI2Nk1yVWlYZUtTM0JuZEF2SEZ6?=
 =?utf-8?B?eERrek0vUFgxVjhvOUdhKzk4L251YUgwUDRoSkkzeFRRT3N4UmtobVRkbDd2?=
 =?utf-8?B?YWpzcHVUWWllNnlhN2p2bjBXeTBWMUdWcmRmK3RzZDlPK0JMZGd3V29NYm1y?=
 =?utf-8?B?UWpUcHRrQWFONEVQeWhKbW5rUGpwVkhQa054Rm8wNC9ocCtScWtiSzNSS2J3?=
 =?utf-8?B?M0Q3aW9NZlBDYmlXeTYvY3h1QmljZkExWnNKOWtmVWRPOEJLcWZ5d0pMVWEv?=
 =?utf-8?B?SXJpdWpkcTFVUjdmdEs4clUxTGlwamdJTm5TZlhySlNkZDJWOE04T0JvaHcy?=
 =?utf-8?B?Rkpwc29zMFA1dFBRaTVYK05PTXRUV25sbTcxWGs5VWdLcE1ISWdjRDRmaUFl?=
 =?utf-8?B?WUptaEJES2w4YW9nZHVDWDBtcUhXYjhvWjZwUWl6Mk1ZRkFqb0t0Z3dJcGli?=
 =?utf-8?B?T0ZPS0ZodU5HWUJjUUxQVTB4eUpkWVhQWWFrNVg0QU1KNEw4YXEyZ1NCSFFV?=
 =?utf-8?B?elozWXkwVjRwamRSQXBoVDRXLy94S3hrTFpjTVphSnBwWEFXMndGTXZ5TE03?=
 =?utf-8?B?MzlZVDB4N2lkVXltcXFWSUJHVHZqUVdxOE4vcXdXQ1M0aHlHZEowRzJzSmx4?=
 =?utf-8?B?QytxNHlvUjNsM3FMaVoxUUpDc0hzWnV6S2gxL0N0UE80UHQwaVFldmF0bGl2?=
 =?utf-8?B?V1NEbHRzY0VBbG44eW52S3FNeDZjOFRBZ2dhelNyT0ZuU3V0aUhXSU5YL2lZ?=
 =?utf-8?B?ejU2T0FHVUFSRmkxeVJpN3RUem5JL3Z6bENtaVBuUllyZStydUZxaHNjYTdo?=
 =?utf-8?B?eVppUEF3L3JHNXp3c2tuRC8vcytWdmEwNmlScmovTEtJcVlHY0ZpVDVOdGhE?=
 =?utf-8?B?QzBCVldhRlpvcVJRbzI5Z0V0M01neUtUZHJheWF2c0ZNeFRIMWkyWFNFdHh4?=
 =?utf-8?B?Q3d1bmM0OEorTm00Y2d5NjgvbmsxSmhRK0cxMndrSDZTdC8xd2tScVJXYnEw?=
 =?utf-8?B?R25mZ09jVWl6U1Vla29yTnIwbkNUdTJBMDRIZUIxK0JnTENtcHZQcXh6ZkEr?=
 =?utf-8?B?M0wxNGllOU55QWliRkVNV1d3SWhldWIyekFWb1U3T1NUN2dNb1l4Sys2ZHBr?=
 =?utf-8?B?byt2cmszQmZ4RktLa2J0NEl0aTIwbFo0YmJhNUh5ZkV1aGJTbkdxQ1Q2TDhL?=
 =?utf-8?B?VVozRHU3OVpuS01zb08wSnNtRVRsUkpFUjdQbFNvRllHUkNySFN5VTlndjYy?=
 =?utf-8?Q?73XQu4wjhTFrKiSCpu7KOaYhr?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9cdbf34-c397-42b4-21ce-08dbb370b069
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 09:14:38.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QcsVVM2qkw7pZlndRTsWBSoziCbQppumJVN5sCz+MGW+l90hBUWPF2+fdcY9B7s2jyRF5JGynE9ugLOALeobg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

Entries in imx8dxl_clk_scu_rsrc_table must be kept in the ascending
order, and IMX_SC_R_M4_0_UART < IMX_SC_R_M4_0_I2C.

Fixes: 036a4b4b4dfa ("clk: imx: Add imx8dxl clk driver")
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8dxl-rsrc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8dxl-rsrc.c b/drivers/clk/imx/clk-imx8dxl-rsrc.c
index 69b7aa34fff5..a36e821ba807 100644
--- a/drivers/clk/imx/clk-imx8dxl-rsrc.c
+++ b/drivers/clk/imx/clk-imx8dxl-rsrc.c
@@ -50,8 +50,8 @@ static u32 imx8dxl_clk_scu_rsrc_table[] = {
 	IMX_SC_R_MLB_0,
 	IMX_SC_R_USB_1,
 	IMX_SC_R_NAND,
-	IMX_SC_R_M4_0_I2C,
 	IMX_SC_R_M4_0_UART,
+	IMX_SC_R_M4_0_I2C,
 	IMX_SC_R_ELCDIF_PLL,
 	IMX_SC_R_AUDIO_PLL_0,
 	IMX_SC_R_AUDIO_PLL_1,

-- 
2.37.1

