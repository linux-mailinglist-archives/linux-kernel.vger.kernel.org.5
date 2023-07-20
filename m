Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33EE75AB1C
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjGTJl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjGTJlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:41:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4493A86
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:37:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TY/pFGWPci5UFTYxovm/UXete/SIkeyRi71mo8ml/KO74zodatWfYgFNsr8zt6Sw5FEqD8dAW66S1VeppZUpfOAi1daPSFI/IceVO4Gbhc0NJpEDfaWpaSpo8Ovlu24cXsPKXX0SCJGPORTKmxoS2hPKYKvdQsYMijikwhHWK1xu7LWusCAFY6wgKONE45/vXxRwQDzlZdi1UuATAPcWqsgf859KBdcEOBBj6o9eIAINFzUk/PzLIomSFhx84b6FnA2BaXNJAfNoKxap9n8ERQGvFjQYmEEx0Hsx+uTn/bag+mKX5ubRZFTcEI54B1RiX86n0R/W98D9oCMzwMlO/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=ll+MJ7XzoJla4hZbMs6oOiJe7AwqFQFRpVPlaQeZO9WhN7xJQnAICHahGEz1bdKY5Pd+QNR1PWCxw2WJblDSt2YJWJyTYfhGsrKWVd61lImQWwY9mqkHscewzq+twHW2qg1JYNfzp3POai2OA90WVdxd83jc8q/zjGoHtsDdByda279t+0ukqWKmvLnL5Q87C64IwihGpp5qqbkswk5b83KLN+nXhMV4za3NroiwMtIk4mzcRGS5ju9VYsm31aip1KAHRtWJEOWZ/QB3cuzbjBLhpM6w17aJFnWALgfqvuk2BuBrAUm9sA3qdFpbNNJoh82DQr5shT8qZJSyMZaeKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1EaanuMVw3yN21IXzDoO2thxcz5R4f6468cftBXaho=;
 b=N1/qKbLgg5z6wTRxCSwxwXGj5Oku3JWU9w0+4kCtWkYjmni31G9zalt0dTnT7Mu4+2sYWkfRyIugjrwIyYmGPAgplHOjUbefpGUV3NC8Y7hIj2dasbo5NDF1AKidHk0b6q/PRsu+/CGj902QeNEQ4J699OZGIUjMhbwafntLbkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 09:36:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:36:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/8] firmware: imx: scu: drop return value check
Date:   Thu, 20 Jul 2023 17:41:23 +0800
Message-Id: <20230720094128.536388-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230720094128.536388-1-peng.fan@oss.nxp.com>
References: <20230720094128.536388-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0110.apcprd03.prod.outlook.com
 (2603:1096:4:91::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9367:EE_
X-MS-Office365-Filtering-Correlation-Id: b70c46eb-867c-4933-20ac-08db8904db20
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Y5767zb8P6yZvh00S05W7ustE9Ua6tyCVInvq/vnrsZ+J/ksae/NS38vyJzmrNUFsiFRZyAnAjQ81MaHI1S26lhGaxV0ZfTxsuCFuJar/nVY3kszFc+yhRAs2ZgQD2L8oXp78Qt2GJ+Yjr1YIRqSk+BoHy/cqvpgpdPvHQV0bkUpWbzVmK7r9kkQ8QxTrXwiSCkpirvDRkRiGv0L44x1Ti5SstGbcjrDzGpUzSFa0pHkib43FmIpdKVdlh6UrS0gqHUWcW1O1xdVUVAq8Pgo6pnw3/aTDKpfxGGE+wvFBO3jwDiGq5LM/SxxwysUUmSYBwPHmrR9ahlHKgdtMFiZpX8PhHBqB618ol3nuSiOI2tTA+AZRN+06a8ae4TeIrcat+b9eRT7F0rXjGaryEkjQO5yLORZBvGZGo36XJzeH3XJhSVcR6d4wdxHsZ3AK63pAoD5SGwNkCTHihrSLLShgs7GafqyMmSWziBYy6EiOQzjugj19dzLKaMGxgyiW+FWHpzeCAXcN+DffhN1lWCZAV+oifBUVu1115w2UyaTrZTp3Q+DIlXHR8osQi+Bog2g1hnvWtjympNSNoBTGwVFuIiyCDc8jEUeM67iPIG4zdPQzS2grtuhxkVekfFd2Eg
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(26005)(83380400001)(6506007)(1076003)(316002)(41300700001)(6512007)(186003)(2616005)(478600001)(66476007)(6666004)(52116002)(6486002)(38350700002)(66946007)(66556008)(4326008)(38100700002)(86362001)(8936002)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?niJoTVWaNuVmqIgDsbilQAvAG2Un3uU3wfoa0HD7jG/45tozxL9TxndSczly?=
 =?us-ascii?Q?zkyVLDe1OdFljb3FptFdn20VoUdcbbEfkB+Q+v3vcE3LRwuimd7w3GfgI1nk?=
 =?us-ascii?Q?WyjhVpDzR9up94qvA7k1bu4l0X7DrzlLUT/GJJnSYx60puAbdgZTWUkp5f+a?=
 =?us-ascii?Q?tC/Gr5BDKoEP97J7cIsv+DX8dJ+V3DgeWnzazY7Gemvb4hHowm421Uc2nBmQ?=
 =?us-ascii?Q?PmnUW04A6bz0QWuZqUANsM800mnajZ/MM7AOmcYlDHVoCzeBW6QIbR3D/ZmK?=
 =?us-ascii?Q?ZSmFgynNdSszMqTveP1KuZ5ARqqtYL1GxO8OHJ4ixt3DdjaYpI8vK6KBD3Ys?=
 =?us-ascii?Q?JQVnBIAKU52IwwSC+P2WQ3hBEgyQadJmVBe1t0hKv+Mywl+tfffTAYxv83HT?=
 =?us-ascii?Q?atYF0UZVQgGbVmoh1hcu7/4vAjGCObdWO/OsywEDAhmMj3pvFA3K9e829SPz?=
 =?us-ascii?Q?DAUkgKjZOLQ5sJHdA21WLH7abOd1Yt8f8Wtiw3jDYzbxOwVaLWBNxQje/Xdt?=
 =?us-ascii?Q?JGaF4r/yegdgogr/20zfBIBpmG4cHR4q2OibTtmI2Fm84Jt5SGWM781t7Oeb?=
 =?us-ascii?Q?SVOS4FOe9crY5klCquM4clA5qkEYPhOqL10sW4Bne5tukdhpEdjK29qRToMd?=
 =?us-ascii?Q?v/Z7azliQBIciGZlg//tqlF3zutLqjFWVdLfO8GhHb3XknRuoeJZLsQ+M+4A?=
 =?us-ascii?Q?DgpHdi4nM6IGEnegcB+xOpajELgTQZ6P3kxIXW5wkSbYB5bQgUJYkKlRnKXm?=
 =?us-ascii?Q?1WFp6aCyVLZwvGQHCHZTZVSgLAn4Lim7TrGHzDKIQP6gJVjtuDgj4n1KPlwS?=
 =?us-ascii?Q?najPXM16E4XwFKfwDVvsgpo69ZT7o3zNq4HLl63uCEKovUG2n7WX5ywp9tvh?=
 =?us-ascii?Q?cFlediBZ+01uL1kxcnP7NXyPIvWkPoFeZFXrSwDzKlRq7wSO6PSXAHA7IB+u?=
 =?us-ascii?Q?BE95R92KrGiYOFIbrvijYuQuZNC6zy10CSN8uSx2+jF0iR77eHD2nWzlFlEm?=
 =?us-ascii?Q?pAo0GgIQoXXucWN+1b/0dkXdVR+6LmXfMkL2NIYAqYSlEx9/0N03nuoBbaY2?=
 =?us-ascii?Q?i1CqmzOGiFGcdjXjpTMnwHNKo66WTdlHjKfyFg0rOL+NDiuMOMOYyHAIMHtk?=
 =?us-ascii?Q?M4AfDNlHRp7JckgG5EPY4412pL5iHSFJCGHFjej3Aks7sLVBYf32iG4CJEP+?=
 =?us-ascii?Q?w99ZO19tDjmNB7tXjQKv1MpaYUxhKvDJPmSMrAl/CanlmCInNG6mvd0PwkWO?=
 =?us-ascii?Q?14r+6s7Ml7rjuIcoDyB7lJH/Syil5pbvtgpW57KcyoYQnIiEzvJkc1RR+i0K?=
 =?us-ascii?Q?nw17nxv0CpqZ3K6LFk+3EBhUvkkvJ71Wl8PNHUIAkeAZd5t/JhsWN6rd1YmT?=
 =?us-ascii?Q?i4akFsWAq3V53alSgZh93WPMrA8JhIw/lCdZOX04wbkIWzdp07M/X0SbYzO0?=
 =?us-ascii?Q?QwG6rpxOuHNoh7Y5Y40PvuOAw9R4KIV08SFffG75/drGO2ucp1opYvz1Z2LC?=
 =?us-ascii?Q?cDPlUk1IYezTh1wvz6eadvXjHUlEY8+Bi80PZpMWe4r0uBNZGyM3gVwW3Ewz?=
 =?us-ascii?Q?XhWdFzApiD1u5tzl6blPJfBJDr6EgYmgWUrFkh6h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70c46eb-867c-4933-20ac-08db8904db20
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:36:55.5028
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzY3NDG6Givv+RtVNQe1FeEGfs7LvQQXQu8dQK8ULVtB/sMxg7LQ4EfiyaSDg2jyIKGf2PHPs/IIPSce/JCRzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9367
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For IMX_SC_MISC_FUNC_UNIQUE_ID, the scfw has a return value,
and the imx-scu always return 0. So drop the return value check.

BTW, also initialize msg to 0.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu-soc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/imx/imx-scu-soc.c b/drivers/firmware/imx/imx-scu-soc.c
index 2f32353de2c9..ef9103987e76 100644
--- a/drivers/firmware/imx/imx-scu-soc.c
+++ b/drivers/firmware/imx/imx-scu-soc.c
@@ -33,20 +33,15 @@ struct imx_sc_msg_misc_get_soc_uid {
 
 static int imx_scu_soc_uid(u64 *soc_uid)
 {
-	struct imx_sc_msg_misc_get_soc_uid msg;
+	struct imx_sc_msg_misc_get_soc_uid msg = { 0 };
 	struct imx_sc_rpc_msg *hdr = &msg.hdr;
-	int ret;
 
 	hdr->ver = IMX_SC_RPC_VERSION;
 	hdr->svc = IMX_SC_RPC_SVC_MISC;
 	hdr->func = IMX_SC_MISC_FUNC_UNIQUE_ID;
 	hdr->size = 1;
 
-	ret = imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
-	if (ret) {
-		pr_err("%s: get soc uid failed, ret %d\n", __func__, ret);
-		return ret;
-	}
+	imx_scu_call_rpc(imx_sc_soc_ipc_handle, &msg, true);
 
 	*soc_uid = msg.uid_high;
 	*soc_uid <<= 32;
-- 
2.37.1

