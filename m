Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BAD875122B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjGLVFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjGLVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:05:30 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F781FC9;
        Wed, 12 Jul 2023 14:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aHfrqPhw22ODSh1hDQ7DaiDipalPF9JhfKp18fciYicNY6Zod+W9sEfhg/rGGLzd04kjP8ZCXAeyaDnl5MEVrKGILPInDwkUgKy3JD+uDt552ad0SWu8HAVRoj3XVACF0krzPXKzbjCBUbOQ9AZ/N9D8Mrc80VDl6s5M7HM+NDJADDyJ98p+yWBPlBpqg/Q8qI3RTjW7q8gma4dGGiAQhnO5U/ZGGt9kUxIUw0kVHkH/eD9z/xTUjU16fpqQYVW5UXAje5PhrlDj3nVl2YXI5ES5Bep0FsOf+0BPq+mktyTA/bONWFK3FmA8Nvvyh/ZsK4gRInkqNzIf5ntcLEocBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8bBiXDiBiIzLcqnVSCpmwDRzSHyjtEbEOS/qp8nXds=;
 b=VuMxPYCqQsm5fmu/3R59X9WRtm2HM6CbjwwmNvskDIUz2qJtnYWMDPafOT390AoafcKKP4QxN3+OIIhk0+Aq5BqDCDqgbSePamcPTPhlTOSnSLiAvIAZ8BSQZuqZNAwMQOd9x+JKElMO+JNdOtrkke6cs7MKZ8psJ7IPadLeb/FDT2r4OmwOFbA1QJnfPsBv/UtP3iez5RGH87WGT7wcjTEPOWhFJdG1gX4ieYgFmrlaQZGYRAGsFHFcqrsPJPXyFLRRIjrjL4oaAk9t2AVWnSatfTJyP5dvhhVGFEqNYt6oPwXw3JsupH3ISdPhuQKyfLaoj/J65Wj9oK3iQWsOWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8bBiXDiBiIzLcqnVSCpmwDRzSHyjtEbEOS/qp8nXds=;
 b=JBoRT1gekXFOL4dNLJu7dilnXIIiN+QwmWUenJFcGic7B/IZK6OZE7Epi4ucjhksqYdhruwPJwBcYHylF/uRcm/V89vgYyNkC7df3sW/GJhgUdCHfMwhVyZWC3H4AfzSEhsS4BCZiOGxXyltIhJtmBhgEVESoVtbC0SI+Io4IcQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9627.eurprd04.prod.outlook.com (2603:10a6:10:30a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32; Wed, 12 Jul
 2023 21:05:26 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c479:12c5:ce68:5e45%3]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 21:05:26 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pm@vger.kernel.org (open list:THERMAL),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX
        / MXC ARM ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Cc:     imx@lists.linux.dev
Subject: [PATCH 1/1] thermal/drivers/imx_sc_thermal: return -EAGAIN when SCFW turn off resource
Date:   Wed, 12 Jul 2023 17:05:04 -0400
Message-Id: <20230712210505.1536416-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9627:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9578e8-6b65-4031-2d34-08db831bb6d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o2Qf024yhHKurzQ3pZ2GpoXDBUDFAeDrDdRmzUDBJHIpRLwZ+ynvVlBfQ6jvqu47+tBtGoDMIJY3SYDsBdRRsfQ/dp/0wkHVfXQSo7bA16eBb/gTmFOdc/jffgGO4m/eauLJLpB/FlWFAEbLTgF+o/ErUnNe2cTus8hvDdYal0Y6+s3x14iPOOfNxpo1hRHr6J9vimaV7eXTyVnlZKsxoPs0z08lPwUBQTinxhe0L86C2MngbPxxwuln0nX3W48hbN8q4m7rH3+iPwKnFBpklbMOTn9hk1vfi6rUpWyKWrYTsg7tr7mCFVS8l3Z1fyiRcVFKjWOOKE3n+7HgoMo90CLSKTlMADr7B4zdvbfyY9PsV2bUvrQP63GNY9Z/fejOdcc63PoTJvADnuVMZ2LPcqGLjQw60naNvYvH3OL5GaVHWfxam/VGy8ZYTueVCbWssNSCOZ7dyuiS4wSn1GbRDW81Z92PWlzFIMzh4xOiXAkn9t7P39mi9bk7v6RP/LFICQif4oN+Mbx04bnmFRHGFZP+GorW0zJ4+tTPwn/QyH4SQDvJWG8mDenP08xJa1yDY/Lpyl++1DYsk5fkBxnte3+aYOXe+RxVAvcAOfAY/rB8Yr1Spl4cwnPvalVBJ4w3DMtc8Ywxz13abcMRz0FoHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(451199021)(83380400001)(86362001)(8676002)(8936002)(186003)(4744005)(2616005)(2906002)(36756003)(5660300002)(7416002)(26005)(6506007)(921005)(110136005)(38100700002)(38350700002)(52116002)(6666004)(66946007)(66556008)(6486002)(4326008)(66476007)(478600001)(1076003)(41300700001)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?plCW3g5x2irvAw7PQ8M5PEWy9ozPK4btFgF6Pr/3YTQ7w0obmsW5HXXaHGUX?=
 =?us-ascii?Q?Th0suevRiWNO14jlolikhXTacdWppuy1DPkH/0v4Ohs3MohQAuYQvF4wzctv?=
 =?us-ascii?Q?ZCAK8rXShGMblTzYPrQh8Berio+MvCTzGkamv3OxciEnq1WzGuzZASWIzjbk?=
 =?us-ascii?Q?cYnKGVusc94huwMwF0QNtVu6LpwW4S/sWfjdZVwX34Dbq2E5g0t4/iJ3sqMl?=
 =?us-ascii?Q?djqiwWbhV3VclEggDLlfYysvLu2H+uvWITXW7ecd18Zod9+F+MCfm8uv8L3O?=
 =?us-ascii?Q?3PGSqvITg9tPAKg1aefGqI2td/q232eD39BlgjYkSkdTuccJ8V1Jbda5x5d1?=
 =?us-ascii?Q?WChPQL+eZjK/v4w+vVPJjzaxRXmqkUX039d350dMEN674WkSwdpVA+qqF7Ff?=
 =?us-ascii?Q?jDhgH7lr04mo3Tyb0d0TV2EAPndM4V9cWB7dzaQ6/RMttABU6rBaebldU6ua?=
 =?us-ascii?Q?P9h7CsHkU4z8VMgSGc2tuxZG15WJS7c8+qYn85Kv2A9JpGaSdPxUezdIZaBv?=
 =?us-ascii?Q?nVfJzdlK34RZmLiBfhyTZw242H0Tc0oC3ENu1EZNv2QzQ2ht2FACqkBZR72U?=
 =?us-ascii?Q?4VlXnv9+mAMY4jAs1sjAIBhl+SY6OmGfFHGqmqoZINsa87217h3OyQqQwc6X?=
 =?us-ascii?Q?TAWrWiV7roqPv9/Tted+xG4TB8CCSlHXp2acXm2/w5dzH/pJDFy/dUnHcItU?=
 =?us-ascii?Q?cmbAnx7HIbnfIZq6fAy2GeTDCn7w8D8VaVXgUDj2S9rB9k4t2R3Wejk8rJAA?=
 =?us-ascii?Q?IzdSKELQUboXRrshCd+XAEfzr1+iE4cZpFbMgYpsmf/WL+s9GRYapUKJDpLj?=
 =?us-ascii?Q?it/4E7f41DI3E+G7rBO0YeM9CSdXj8bA5X36MnVmnTqTgJ6XwzKWc13yrhVR?=
 =?us-ascii?Q?vc+enjI5nzkbezQR//zul8MuDulgPseKVmGgw/+kunehLn2uTEFrgm5CyTty?=
 =?us-ascii?Q?IylqM0vyyWhILPA/wNpLxBMuOY9/YFNcnF9szBz/wFpokqssaxZp2zelPlGe?=
 =?us-ascii?Q?ffko/f3fkm3vkY+PS1a/3mhLlqeLsI6zh8teu/x5g8oR9dwnNyW60KiW/1Nx?=
 =?us-ascii?Q?d2Jt4BG9F8I08gglDFW5LVhuyPlma9J5vJN+MAQRYEURw+4H+ghO4/LJY1To?=
 =?us-ascii?Q?e6TJ9AMqoz9t22X9PPN9fnQASjSjM20y4kYK5ys60+2H5qOsDE0eCt4L0HhP?=
 =?us-ascii?Q?wVdf9PZ5cAUFssNtRWTVOThny4n0D0bTn28G3CMoYkWOS4VAxuEyC9XES54h?=
 =?us-ascii?Q?m70tfs4OyiuIJULJlNvDNUPzRm+RFX9ovZoMqJjCZ3NTQhpCIYUzyigZhZXx?=
 =?us-ascii?Q?H3T6Rdj/SLmattpz+uojaoJgVBtrpGHxoh0uDTODZ/bo5FV2BJv1DbNh+v2e?=
 =?us-ascii?Q?Wq3/vd/t0wH++ul/B0iIySbqFlVX42XroMfPCaCevcvJIk3UIBazCMQ45sUx?=
 =?us-ascii?Q?AzIyk/EBQha/ijw8ZY3eCOYOU+fqaiia3OLSBfhSNkcakWr+XxyLR3B9MMt4?=
 =?us-ascii?Q?u5tmKuRccXjUCYznnvvZPSgmudp6TNKBsWogDW01gICGZjGDAr1SgOf8NMQE?=
 =?us-ascii?Q?wcg3Q0O4/LxEYryFBNQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9578e8-6b65-4031-2d34-08db831bb6d1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 21:05:26.0513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Ptjuh2wLC5l1oK/VX4hagkQd056D46tSdhCc9snO+3oOIUZjshwkby8Ux8reSspqWTp8yjnnQKH74Fj+BWq1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9627
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid endless print following message when SCFW turns off resource.
 [ 1818.342337] thermal thermal_zone0: failed to read out thermal zone (-1)

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/thermal/imx_sc_thermal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_sc_thermal.c b/drivers/thermal/imx_sc_thermal.c
index 8d6b4ef23746..0533d58f199f 100644
--- a/drivers/thermal/imx_sc_thermal.c
+++ b/drivers/thermal/imx_sc_thermal.c
@@ -58,7 +58,9 @@ static int imx_sc_thermal_get_temp(struct thermal_zone_device *tz, int *temp)
 	hdr->size = 2;
 
 	ret = imx_scu_call_rpc(thermal_ipc_handle, &msg, true);
-	if (ret)
+	if (ret == -EPERM) /* NO POWER */
+		return -EAGAIN;
+	else if (ret)
 		return ret;
 
 	*temp = msg.data.resp.celsius * 1000 + msg.data.resp.tenths * 100;
-- 
2.34.1

