Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118CE7BD4B1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 09:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345446AbjJIHxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 03:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345440AbjJIHxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 03:53:01 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C979F;
        Mon,  9 Oct 2023 00:52:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWsLDAMXdWVAj0TPhBxHPkppPIwdyrhBRSJbv5xh4y8l9cZQ32lsWuxh8wAXd2NAbK99gKkMGq/P/eg3Rh2xdaNhyUe3qrp9B0TSpdFj1F1iT8zOTlG9k8Psq3NrhA+kK7eBXpmFeKTDO2dToaDbipvxOhn6h5Icm7WR/hs0vPcv3mvzI2hemyAi/KBfHc9FAEAS1GAEGMTcd2kj0FG24QQqpx6RHiK2Ek4wR8dLVdja6JLd3RuBB74C72qqxZTflRB/zuFB87Irt95rl7VPUIoJRTGPfxJRySaHnnNQplGwjcElAdHbh2N5nbKf18t58NKrk4GBpaTKIq0LwHAxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+UC+vUgtqgqmkY+4xTj8qNIr4pmDbisc7l/ajmqNiM=;
 b=bh97BmgWUyn0f93sfAM3uNHNIC0GrgAIusfB6dLr2QYwUqgYp8yEVXs5tWIGa5ePZVsqhe7gCieyCqvE06x+RvNqLoL2C78PTNph0DCqA72SZFZ5laGTGI/ru9ThB1s5pv4BWXl4Y1bKoiXYu243g59iOeFG6o9Mj3G8bsPkTZNP1ha3IsFfCzms3PjE0BvYKCdbG6d5i7Lucb1kRg2fl6896JwYk6YDr2+lXwT1HtXhKPmeLCICpsm/nr0wmKqwuYCsprpWSPufjyNmA53IF+VUosEDB+9Wit5KfMnhKvnkNuSBIOgSMqo6yjnbbqB7SaQ6NYBowvLahmDpGrB0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+UC+vUgtqgqmkY+4xTj8qNIr4pmDbisc7l/ajmqNiM=;
 b=bapkyQyykK3MjB1aPPAx0iwhjtsGTOrpyXo1W+gWCxxLECelfsRQqNyS2LGp5cSS8tqKBhoaETSjmjoJTHglsTlHC6Vr83TbxSOkfrDdHdSJExuPNKhlcgRzbU/3WJJUIOFwap1+mnwFLkSALhZwNjqx/MkMJ1VKhys7m1reNmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB10064.eurprd04.prod.outlook.com (2603:10a6:10:4d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 07:52:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2b3:d8de:95c8:b28b%3]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 07:52:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date:   Mon, 09 Oct 2023 15:57:27 +0800
Subject: [PATCH v2 1/3] nvmem: imx: correct nregs for i.MX6SLL
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231009-nvmem-imx-v2-1-86cb135c20a4@nxp.com>
References: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
In-Reply-To: <20231009-nvmem-imx-v2-0-86cb135c20a4@nxp.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696838258; l=763;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=Vqnj10YVg2R/Z2rEFp8c+MacMvRl+2A6n27b7whpSYc=;
 b=NBKppCT8VZIeRGRJTbn+JjHj8fkNU1bb0xhGfcWA6RZFr5lw3xvaY1zJi12dGJNigqngUF7H5
 sA8J2x+cis9CMoWBF1t1sugIPr3qWAPfVR6d+EMC4XmWn997j88X2fs
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB10064:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c1078c0-045a-41f6-d27a-08dbc89cbf4a
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Odmx8FDcxUY7+iltD9r8o1kBnJXr+eL6M399kfCDHTOedSVguzG5HjF+0wcMWkQh7mFhPYQ6F3RxkE0bKaSrnzQEP1KADL7MNob87kVnGViQuQqK520hC2aOyyqkh/u/UBkssi8eQu5NF5QKo3NXUhQ9+IZsCid4iojKbV8+ZVGCSzeWUI0E2JCKuL1QjnRVQVZtout5/X+PpBQXzjMznm/IpScDuqg1rYkAPo9+5N/rLx7SEo7gZ1pVAA8tHvL9K3zFlwwyA+sgnsO9ZMv7DxjBMgSGlxDZz7oiFXQyn7fwxqP6o1wpZGEIuYweIeVnE+9XveVXEo04kufZTCdNYVEsLHWU0g9t9BeGSuk7jZKDX1ufA4CTWFnIr3BO3YtMH/Q8x7rQgi6ymRVOykPHBrpbscRF1ln15gcNFtvmbjdr2qt3E6j0pHneze21ke18MlsTq01iu/TyiQRhIJS/eqw4wfUYklK0XC6UKgELuRnycRX99deVMwdS7u8TDEM+46Tpp3THz7LTPxwMgS39hBdDOyvZcI9Q3rzi0R7N+0ZaCtzIULN1KBWWOqWFxWwjSyMuEJFMkHOadQx65ieO/F9ZGzMKJ0FOUYU3MVa8PNtuwnQ3QVK7SoHfPfd+k4LA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(52116002)(9686003)(6512007)(36756003)(38100700002)(86362001)(38350700002)(26005)(4744005)(7416002)(2906002)(83380400001)(6486002)(6666004)(478600001)(6506007)(4326008)(8676002)(8936002)(66476007)(41300700001)(66946007)(316002)(5660300002)(66556008)(110136005)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWJQRnh4MEdXV1poTkVnSjFGMUNMOHp6VWJiSmlDUWFMM3BhYXYvVkljRHNi?=
 =?utf-8?B?UmQ2bVA0QXEwMWsxa3cwcHpTaEIzUzgwNnBsT2diNmdVQlJlRzE2YzZBdmJ4?=
 =?utf-8?B?eUdFejBLZWZLY21PMzhld2ptVkExNzc4S2NsU1RMdDV2QWR0ejF5MTU5Y0l2?=
 =?utf-8?B?S1dQRjM1cmloMXFTamFadUpqTVFmQWIxZVdsYncyT3ozdnpFT25pNlJxSGU4?=
 =?utf-8?B?UzVhZzJLRE9wbk1ESTBvVWoxdUNRVUNCWUhFNHlqbG1FRkwydE5jQmtTZ2hj?=
 =?utf-8?B?N3AzdktvTVVUQm9lcG4rdzdCcWlyNm02UnVrQ2ZBNG92bng5STNtMXNFQjht?=
 =?utf-8?B?cmNvSHFWd1VZWHpvZUYwc1hiVVlZSXJPaTV1Qkx3VTZoV2pobHlUMUwwMVM2?=
 =?utf-8?B?RWE4U2p2Sk82MlJtRnJ0cyt6bWIrSTR3N0Z5YUNQNFRRZ1NXUGhGbnFtdDhY?=
 =?utf-8?B?Y1FPMkRxdkU2UXpyVWZuaXJGdXhqZ3lWT2I2UnExQytBVVpiQmUrd2NsanFa?=
 =?utf-8?B?T01Jb2tUY1VzTE1mV01ZRFBKNkdUWnM3VjE0NUlBYkRDQlJlUEJac1NRQ1B0?=
 =?utf-8?B?dmlPY1VuWEhRcnU1UmNMSmw3ZXNYWDhNZVJzMnVUWjQ1Tks3dUVVVStmMWlr?=
 =?utf-8?B?eWxnYU1GeG9meUg0Nm5pcWNGbTQ0SGU2V3BvVUtaT2FOeGwwQzBiVHR5TUl3?=
 =?utf-8?B?bDJBdVlKcFFzazZRL1lZa2twb3JyMVVCVXpYamtTMjRsZ2JWK0FIdS9Dd0xj?=
 =?utf-8?B?dFhHT1d2bzE0N1RvWktsYzFZbEtVbFdEd1o5ZjY0Mk4zME1hcVdOa1c3dkV3?=
 =?utf-8?B?eDM2VDc0OTltejFRTHVIc0lCOWFRaWZiclV2WVY0dlU4RHA1SlFralFCT0Nw?=
 =?utf-8?B?ZG5vQmNJOTRDYUNMSWlBMndNWVcxODJVd3RhQVlMR25kRTRmSHBaRS82TG0x?=
 =?utf-8?B?ZXh5cmFMc3RrZk05ZFVkdnhpbTVCaXY1YjZyR3J5QytlNFVDcG9wYXlMTXYv?=
 =?utf-8?B?bE5ITGxSa3lIOXJxWmxBZ0xJWlYvOTFiRGo0ekd6VmxaUllVR2RaRU9KSkI2?=
 =?utf-8?B?Wi81ODA5c04yZk91V3duNjMvb3JQakhFdzIvcWFGMzlHb2RONUhxMHZuN2c0?=
 =?utf-8?B?SUFuTlIvN1Rqb2JCaUdIdk5GZHRtMGNLK3Q3OVM2bDJnVm4wMlp2U2htbjFu?=
 =?utf-8?B?YkpwY1NvdWdYL2J2cjZCR01laVltU1oralJYYXVLK3ZSc09aN3UzdW1lSHho?=
 =?utf-8?B?NHY1blhSMDExSEVnY3BpZ0JGUVgyUnUrYXZFcFZucU5UbSt3UlpKZDR0Z2dH?=
 =?utf-8?B?cSs1aVUvVFFvUkJrSWdhVHIzT0VVOEhRV0M5UFBvUCt6bjhCRFQrSXYyZEkz?=
 =?utf-8?B?VkxFdWtUNHpLblBncEtHVXh3UkFlWW1hQThWMGlZUzZnUVFNeXRmMDBwcDdS?=
 =?utf-8?B?eTEzWWppaVMvTEN6ak5ZQ2VQSVB4bHVUclF1UkU3V1dKMjZ0bXljdXg2cm9r?=
 =?utf-8?B?TmVvcDZnMWFWRzg4NFFOTVlsUUgzK2VpMFdnZlVOV1l2NUwwVmRPZy80TDdm?=
 =?utf-8?B?RU9acE5vTnhidHR5K0RvcUVhdHBiN3UrSzc2aU5sbWFCUGpyZkJIRm9Ma0Yv?=
 =?utf-8?B?UTRGTDBCditOTDJaa3RJOWk5OVR1WURXWUU1K3p2REtwbUhHQk90b3JNbTg3?=
 =?utf-8?B?UkdyU0pXOWR1d01NUW4vbDRPZXV6bk5rc2w2UjE2RW9ycXljMHlacUV6emt0?=
 =?utf-8?B?dnI1cG81VWRWb3c5QVdzUyt5alArSnVmVVc0WmhZQlFjMDY2d3kxWHNyNWtz?=
 =?utf-8?B?TXNmRHNDajJKeFdrQXVJckZpakJ6dFg2eFBXSlpoSVM4SnFpUXlxMGdaRjN2?=
 =?utf-8?B?N2RiZW42bXBRaW9PbU1yQmlFNG5NWkV6dVNDUGNTeUxPYUZHTmppZHJkQjF3?=
 =?utf-8?B?NE82YktoQ09rNXJMV2pYSWdWR1pVd095eDFnNmhtVndGWlNxWE1jc3hLaDhr?=
 =?utf-8?B?L09lNHBqMEFyTnVndWRjWHRUWkNBK2NweXpZWVlJOE9zR1NUVVVvR2d4ejdr?=
 =?utf-8?B?THlSRGlhK3dSbFkvMXdzMDlIUC8zWW1rQ2ZjdlVMeG1BOUV1TjA4NFZBd1JW?=
 =?utf-8?Q?7LhR0Jj3ZvWDI5DjnnOlF9H1p?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c1078c0-045a-41f6-d27a-08dbc89cbf4a
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 07:52:55.5075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U/4PZlv2so9h4lhbE3KTok6BVaTPMYa8OJQNRK6oIU4PVrBgFpsJ0d007QEWazmgBff/HdWSHMHWq8DjIpuj6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB10064
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The nregs for i.MX6SLL should be 80 per fuse map, correct it.

Fixes: 6da27821a6f5 ("nvmem: imx-ocotp: add support for imx6sll")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/nvmem/imx-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 434f197e27bf..c59cfe13a5f8 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -498,7 +498,7 @@ static const struct ocotp_params imx6sl_params = {
 };
 
 static const struct ocotp_params imx6sll_params = {
-	.nregs = 128,
+	.nregs = 80,
 	.bank_address_words = 0,
 	.set_timing = imx_ocotp_set_imx6_timing,
 	.ctrl = IMX_OCOTP_BM_CTRL_DEFAULT,

-- 
2.37.1

