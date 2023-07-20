Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F9F75AB19
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 11:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGTJlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 05:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjGTJkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 05:40:37 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7429935A1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 02:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLEXo2rlAfVhDEDRBp8/4srsWn+jpnPspzo0HHQ3Mqcciq6TqfXKlgBseJuKLB90uX3OOSdUTodaVz4WMC9IjpyZpv6EelzbO1GnxrDo+Bl2eJx86a3SPFVeEBGTef17n34A0jgyjRFsgPRgiOwI3TlrOXj/fEBD42H4iq6ERpTEDel81sCmqW71sIVpumOkGOuAlZvoiG95MfAzvviE6x9CmgqjW19yGwHuG9Gx/KTDDl7Z6q66MJ9oGH9kdZ0E7d4kvqXqnZ1oyvhBq/hzh05z1Q/MPw28Jf+KsCtzyA3A9moSQ3CQCbcgyKfWv92/XB4s4+8Jk0U2PltE4Pk8Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dgTte7GlTSbVWX7opDfOteIt1OFGfyhUTb9YdXOn4kE=;
 b=hkjLSD8TuZ70sciQ85izd5hUAsy4JO8Py2THzYILltM1frPvjKmNaIgE2R60aGS+XjjxjEXwIWmvmXSLJIFh+ZtxLJxc8dt0HZq258HLgBI+dGD3+1BmrDb1SNrM8c7kyMJyG7O9uAJOA/ipREjz8ZsDvugmup2yU57IFi3lzILgnccEb40WpL0V45wMiiJkvam4sA4ANPoKH+TVjT4DkjiQdEBxIaN9CjrFnkqkIimOO2gBejAdBJM2Q5j671UU1V7vQu8Q8bYGlAgwemtYikqOwF1MHScOXu6EKd/vTNH/KEvGLjfKWx2i/uTFNvPP0ELwYfVxiZ95NntjQals2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dgTte7GlTSbVWX7opDfOteIt1OFGfyhUTb9YdXOn4kE=;
 b=fECS3D6bdT7hP8OlKj30ygfmS71CeyMfmMN2l7kWsSSWXkcNVB9pGqnZ1/KRaJGIcVRb29QqgrMvK6GOTjUju6ucsEwzL4T534+m6P5271R0eccsM2LVSrzVRDsAY9XFVRtTPkO5C6W+1iafZTkWh1GmxLoFFIyJD9zjSFhdOTs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9367.eurprd04.prod.outlook.com (2603:10a6:102:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 09:36:48 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c874:7c87:c13b:64f8%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 09:36:48 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 1/8] firmware: imx: scu: change init level to subsys_initcall_sync
Date:   Thu, 20 Jul 2023 17:41:21 +0800
Message-Id: <20230720094128.536388-2-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2c61dd1c-ccda-4538-4525-08db8904d707
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sGTlBZ0+hyPsSh0DFGlm/8ebyTozm00UXu1Iypxd/zIKd/aIYMEXnsbDMc9YbOjPgk30x1y0tWO7IP7EhBcRLznXo5bm1FV1+q7ca0Tv7x+j5E9taWaINzBTCKiZtl0kTJuuEDcvBdslcKnSBh/mJr8LOWsw64NUaj/pHE6OmKvkCpPkgCj+PoaLYnKZFkMJOuB2Xtwa9VX4acxz3rzHTBUcgzzqoC55x2T0jVJ/dMVo8YgRY5PGlZXg5cWcOOCsefBWAH7Jl0iZbCOFeO0Eud66iF3dJ/I0OEG7QqPQ64Jd7ZPPUxGMjP/gYubc/Q21uAFQZfIYwWqnm4HthQZX7yWWwx0M+QQEFHC0biFTJD8QhnY3AS/uqC7EhvqcpJ2eFvRAUlDC0NUBGSLzD2fF4h0HeABfZrvDtuEnofxAJ64qxSKUSMCo/y9EiVfqqR+uWrvlzsGGU3PpvGr/lpnH7f2sHrt3VO+V8ZDhlKzkYIXN/1JtxEfek6zi2Nv7YKoW6t5PwW30d/RaAX98wvAbD/zcePpX0uc/bkAbQEguIWjb59YOvmIi7p0SGFFE+udwugWdVhezMfZmiGOidSrPdGfzNSVn8YazyObxU9hSWUq+om3e8e8or3yAV5T9f+9d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(26005)(83380400001)(6506007)(1076003)(316002)(41300700001)(6512007)(186003)(2616005)(478600001)(66476007)(6666004)(52116002)(6486002)(38350700002)(66946007)(66556008)(4326008)(38100700002)(86362001)(8936002)(4744005)(5660300002)(8676002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6jqPSgsCXgDFnh3mp5VVLerCGMX5Lxbi3H6teX3AtjCY4kTvRgNA1ALX+OW6?=
 =?us-ascii?Q?9FMSDggleijuP9rg1iTT/Tn8R7O0KSKYl1o9XkrH1XiP/J6kFJxawDAHZfKv?=
 =?us-ascii?Q?3PwU422jhHMQoCQkJ6yu7aKg4hrEscajMVhtlquIM2KpxgQNyZTWIupoQtP1?=
 =?us-ascii?Q?uIPKfTVMOrj/XQvnNldt1nG9A+4wqASPQkX1czFz1vXfM6Vlc30faj+l+AKC?=
 =?us-ascii?Q?OcUymP0sB/NVFZDlT8lAMHRJI8NSq/zlMX46UPhi9G/+k2hns2qSM2k54tJD?=
 =?us-ascii?Q?Ov7JfOP6N9eJX6i1dyLiQSa3IyIBRmFuTfdBgssh3mGirNqmIMWZ+uRva344?=
 =?us-ascii?Q?OlNUGrJBaHnEE5Ilo0vLlG/+j28SN5in5B6qT1Ux15EyUPLm4BT25qnX2PgS?=
 =?us-ascii?Q?ftW0W3A8mhWSLQE6cSAQgd3MpKAv48GwxADpLPThYeqB/DUBlx2MKXK/CaDn?=
 =?us-ascii?Q?tt9TF/aSS6nyIEORDYMo98uIWheahHqFwJjO6fNIKCl+GMbRx+MBL+jAXeKx?=
 =?us-ascii?Q?NWm6hOkaL+wSZGmJ9iGp/4bNARlgBSjEGVNT0Hi13xa7jPYfjU05dRKS+Ntg?=
 =?us-ascii?Q?6Y9q+6Hhxu5ZsvjUzQaO5Cf0m1tw4p5xyx7ecV+CLKENBC26Sgl5Fyd3GRzf?=
 =?us-ascii?Q?++GX+0aPngB+nWMviLbyQl0Hv7sz9AgZmlOSYScizAyQIu8s92ycUUrJiD/9?=
 =?us-ascii?Q?6CyLQmI5ZdymWkj16gaeRXs3C4fPkOVoVJtgO9aAH52JIA8JeDR9sr/HvhHU?=
 =?us-ascii?Q?M0/91HPAHMZ1mw8sjvWkbUrQgzPaTN79ntN8DHs9HM7/c7w+Q0llUgTWZZe5?=
 =?us-ascii?Q?GCr86PeOuShewhK6lWjdQT0BsEJqwg5gxuYZ2fWTsO66cy3Bgl/J5D1Kpyce?=
 =?us-ascii?Q?6Mf9lEdFybAmmgGxgsxwHyAo+iuRc39kBiUMWl+5ISNFbIw+qQUgusk4nTK/?=
 =?us-ascii?Q?uuw6oV9Ia5hjga80aJGVBqUBX1kSRJ+hOX8XkFKWb7yXeBwzjLZ3ouRz+Ft4?=
 =?us-ascii?Q?tZQa9SN93kwLfVpmEmOqaCIoogqbuIBzg7Rv/Mhiq/Mw60jdtH/YqiXT60i7?=
 =?us-ascii?Q?8+nmUlTIPzz+NhXAiyAHjP8EG2MUPDakMEVH+cLuPpUkOtUs4PY2B+Ahfhr9?=
 =?us-ascii?Q?zqWEctC3fbDAn+4VTtaYjjsN31satY967u7bHqo3t7bAcjulTCF2//POAOMJ?=
 =?us-ascii?Q?oEzZTqR41j7BVJaouY5yjJ/q3yo+ZgIhna3cB9vjpj+v/StZf8sXk/P2Uv3m?=
 =?us-ascii?Q?+au/YsPyuQdE7OQulcx7v6T6byA8CMGr5XhPsPgXyQ9lmbtUWTDByAxlOzni?=
 =?us-ascii?Q?hKldhJ1Ah2qs7Iy8AemSSBsf2h8ITRaFIChZzBpc5LwEtk5QNncyGhlYWJzk?=
 =?us-ascii?Q?H1UNG/5jLHvzErf0SjDcTW1iGi71Xv+L1RNSYjaiHfMQhZInQfVLW30lrDfJ?=
 =?us-ascii?Q?4l+Q+Yo8l0K+J2QPcH/arClS7nnnSD4YliGqT176/yor1OOF2en3IK70LVS3?=
 =?us-ascii?Q?vgYbvPKvKdNWS9/2kes58BErODY14WA2RzrP4MWEsVwfWgEV4NQHr6gmPShz?=
 =?us-ascii?Q?FMLvWf/MoxultSOJbBZBV0aFun4sgvktO1avBYAc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c61dd1c-ccda-4538-4525-08db8904d707
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 09:36:48.6358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEvEOlKLOY54GtlqabKTo4sE3vVkwzFbMhhLWedmZK4itfuBgsLO2h6JXEce1Q60Gia0fsAEDM0Sv7RdcTLgBA==
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

From: Dong Aisheng <aisheng.dong@nxp.com>

Change firmware init level to subsys_initcall_sync to ensure it's
probed before most devices to avoid unneccessary defer probe.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/firmware/imx/imx-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/imx-scu.c b/drivers/firmware/imx/imx-scu.c
index 47db49911e7b..2d24359420d8 100644
--- a/drivers/firmware/imx/imx-scu.c
+++ b/drivers/firmware/imx/imx-scu.c
@@ -353,7 +353,12 @@ static struct platform_driver imx_scu_driver = {
 	},
 	.probe = imx_scu_probe,
 };
-builtin_platform_driver(imx_scu_driver);
+
+static int __init imx_scu_driver_init(void)
+{
+	return platform_driver_register(&imx_scu_driver);
+}
+subsys_initcall_sync(imx_scu_driver_init);
 
 MODULE_AUTHOR("Dong Aisheng <aisheng.dong@nxp.com>");
 MODULE_DESCRIPTION("IMX SCU firmware protocol driver");
-- 
2.37.1

