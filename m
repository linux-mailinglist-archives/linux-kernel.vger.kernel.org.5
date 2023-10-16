Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6EE7CB531
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 23:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbjJPVTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 17:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJPVTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 17:19:15 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2076.outbound.protection.outlook.com [40.107.21.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D74AB;
        Mon, 16 Oct 2023 14:19:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqLGBvK4OCFt3lLsYIgVuqGUgJTWIqweqf/AYmqWywz3lUY5tn60wHey1jpiucobRkaD0Y5GCCqx+Bb1I2tLWX8osDKHkhxE65TqRwWUEyN3/1nIf/cDG4pR/CMFMj2wKr60vv+4YBQtsmkweTfXCRB2TbFWbusr0jqemfIyrtgBj/amfBLY6YbRnrReVXUYrCdPQ6tX2WGJulQqfminZ0F2Bpvi3brocOdQdAy/CQVvRtp9nSn47hIJxyn5ebpBuXW/5GE/deh8Ug9yanku1Ek2rPJY5dC9o/mscn6c8SnVvviMcUIDqENkG+Z8r2ns56nAWE42wC2Wqhg3MC0Daw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGLg85lrmJAK1G9LTYz64lUcqVLxFXWlm5K8jHJaC6U=;
 b=EIuJbssJjg6NcfQ5jnwNPk51eREZxLFfpPkp59aTpmS1I0ZVb2LMt16RUH6slyLurjyNtIeQuJ0gNTirCkSHWdr2KlmRV/80QlxqmwYgQ1hzs/n0QtgdMDOqs1CAvuWYYZrPgSwJarBFZ8tlrKDBtTi25GUtuvlya5yTxEMm/jzcJzGtFDd74KvAl6bp/EE+1vPh/JuUrBu+Me81qlcyopN2E5N+MqsO2gGEBg4/vzS1wm2dZYJJVL7p+Jal65gV7lpDEg3UJLflZTkmWbzzrmc6zfeCcsKzip6pktZS0jcMSyjSQj82WS8Qh8+sAAqar3f2sKqCXeo7ID70/nM/8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGLg85lrmJAK1G9LTYz64lUcqVLxFXWlm5K8jHJaC6U=;
 b=MDmoDBuytY2pcdfr40uPEBciGyae7eDlZYrARZf2hob9T/LA5EGKF/Dbr4a3sDB/PpFjXdIT6yYQcGQw1lptp7jtmuTr2n/+8+GAFIXCUIEQjCIjJ+skJvjCRTIrMY+E4fqExToKQrRs6muUd9PuDGsUIerOE9OghHPbGNBvo5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PR3PR04MB7417.eurprd04.prod.outlook.com (2603:10a6:102:8e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Mon, 16 Oct
 2023 21:19:10 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6886.034; Mon, 16 Oct 2023
 21:19:09 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     Frank.li@nxp.com, alexander.stein@ew.tq-group.com,
        alexandre.belloni@bootlin.com, conor+dt@kernel.org,
        conor.culhane@silvaco.com, conor@kernel.org,
        devicetree@vger.kernel.org, festevam@gmail.com, haibo.chen@nxp.com,
        imx@lists.linux.dev, joe@perches.com, kernel@pengutronix.de,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-i3c@lists.infradead.org, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, miquel.raynal@bootlin.com,
        peng.fan@nxp.com, ping.bai@nxp.com, robh+dt@kernel.org,
        s.hauer@pengutronix.de, shawnguo@kernel.org, sherry.sun@nxp.com,
        xiaoning.wang@nxp.com
Subject: [PATCH 1/2] i3c: master: svc: fix compatibility string mismatch with binding doc
Date:   Mon, 16 Oct 2023 17:18:53 -0400
Message-Id: <20231016211854.2901427-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR20CA0019.namprd20.prod.outlook.com
 (2603:10b6:510:23c::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PR3PR04MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b74a61-a64f-4acb-1c2a-08dbce8d88b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgsnpfh1fQ+bo4fyS6SEMr+5aEhn0Tt4SVcySAkcpE7/lztbICLKkCKvtHkrNDEA6cqd+2D5xZLw2o/vc8OKV57fTtOBQ0XIIzI3bqKModzCcbzodc8WLqxPBxvn9zOona1t1/+lTMNSk/K5Segz7euHeJuND/eiF6a0g32CUm5LJ/pKQfcXwwF8XaivO9NSHPtmzYXCWHhH2dz9z1eMCuMA7cl0fj172LgEqrEj/8SZ+5RsOntndAzialI/JZIMqop+BTOC/VoNWQRi0K+05jUI5CHfGzRnGK+WKsJuXMdDmJAVoVnfEzjxXx4J7zu/MTOChIRlpgz2Ng+q2+joYKbRq2drKYYVtUSQPEmuaEFvIDHubKXf21NMeFErStINVHuHga1ERXNXycNmH+TbGf5Pk2Uelsva0xqmUgaYSby4V57fogEgta6jHMgID7z0pr+TMrK5tvjpjL/PKuwW8svZx/2c3N7LPRJWwpaiZhCQbzK1Cbv+8rk8mSxMfRlYkQL+o+ILyXhJFIXyJZTxcpQXz2AvCCovYiY3bYtWp6K+C4e/X8a9kgT3g05eqlFDlWv1sDrt95r91m4Lup7Brsnc8OTs5RxCbRHgX+cRVs8rm/aCryk50zDOEHnM83O2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(38350700005)(52116002)(26005)(2616005)(1076003)(86362001)(38100700002)(36756003)(83380400001)(7416002)(4326008)(2906002)(6512007)(6506007)(6666004)(478600001)(316002)(41300700001)(6916009)(5660300002)(8936002)(6486002)(8676002)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tbzV8AqaFpMiD7apdC1X2NDjuEX0F39Dpr+oVWSO2KkLtmewNMTT7jATnd+U?=
 =?us-ascii?Q?YT3ojqmZrCXo/bxRMOm/RzBY0Ph1pIqJ6GkFF91aHRWrM9DT8/pwy0JvCL0/?=
 =?us-ascii?Q?v+6Ee+i/7mpu/IU/mkkPMflRXVMeey3ULcXw5mR8lB9HquyA9xFAUmBFy9Xg?=
 =?us-ascii?Q?Iev3nwy2ZBF6xJXwXUKzmZIqjllgO4zgxuKie71e1z7zZbupmPXZE1/lL48b?=
 =?us-ascii?Q?Q2XooYe6KneyY8mRKDPheZ/NK8yam4uKK8oJ29Auhoi5kDsfEgmS4c7dezgG?=
 =?us-ascii?Q?TDJuEEZpI9Eq9NQaUP4QprnQISuw1nz/EvjKsyom46r7spWrDXLhgkIB/cbA?=
 =?us-ascii?Q?3D5ehauID/oJifb2Dp2eLI+oiTjW8fVMv5uyIRYIOcGPZgrnxZxyE0bcRofu?=
 =?us-ascii?Q?phyMv4HrHJCaL9V36hXWGrC9/VBQB5KOi4LHPRjNaqCdbLM9XDUcTqaSAA5i?=
 =?us-ascii?Q?9iqN+ltqFtWSL6fNNtyVOiaQCnTZz6ULZjbKgi/8dhgCyCmUPbtwxtKxev3R?=
 =?us-ascii?Q?JQvNDFxrrKmLHzpoF/y0Txoe3q+TKQEf5zOu659n5UEil6cL/74dRBCghsgk?=
 =?us-ascii?Q?SLyJXcC74wuxCstNGKZZ3u7rcBpT24K9f4Lth4njX2EGQPkbgV0fLPes457L?=
 =?us-ascii?Q?/IiGC1WmKF+x/4qHBZyUELXQ4MNkR4EgO4F6K7EgWP6oPM8vBVJSqRUVx/Fq?=
 =?us-ascii?Q?rJJmN+rSwuArl0j321fq5x8WierotfAeEd2+BtUhelZHI183/LQRRh4mH427?=
 =?us-ascii?Q?awqKlNA75p3pexFzkd7D7lZnxSK4KzcF/oafzS2GAmVC9hxtbUQktwavRrZ4?=
 =?us-ascii?Q?m80FSUNCnFMBwWBtVIZFviK3DJmb5HBCtrv+Uinz8ii9+1G8iI3fqJkCn3Fs?=
 =?us-ascii?Q?wrWqCg6JpMASsVt40nilGVo/pEL/u9LP4HbEQDDpDsnby7spvXeK/iDCLJoZ?=
 =?us-ascii?Q?TijAvc9l8XaIdJ4o0j97bHVqpVpP1diGSOOWUuNPp0pJIsljmPyty8KaAK/p?=
 =?us-ascii?Q?u7j9/P+EqzHdTk5ybquHSbTKJuNQzMLrAT67hYYBgsOLQV1pH+zlx8coOBqu?=
 =?us-ascii?Q?0NH8iSCLt9BFQY2uXg5yXqfRAL8FlSVc0/LLLPfywz/WJUYQV/qeFyvq4RKG?=
 =?us-ascii?Q?XQahGxpMTG/RR0cjDKjgZCdYSP2AvKrUl7l5Ql5cJWrSjeEs3voPW9RUln6k?=
 =?us-ascii?Q?9OsEI1EVDO9PU4kfThRrUli7kP9wBYOQg2BGl+0Dvf1HjqcLlELHjY5stZxE?=
 =?us-ascii?Q?JDk9s/1P9/Yevlkx5qyj/vEpvr7XW22hhs+AwXTGjwr2YAlbgJp48jxbAfpQ?=
 =?us-ascii?Q?49QsaD0w9TUX9/eCvB55JNV1NP0ubXIjLuproFjJYta6d5afaOmA0Ek/NuPF?=
 =?us-ascii?Q?m0xfwGuceJ+Pu8BvBRnf98PDlLyr+qnlOI3ZFwavMECDAFaAmdVzu8h2tQuW?=
 =?us-ascii?Q?5rY77nteHfDZ3pZj/ztC2fmd4rMCE6L4fvcFp1a3bl1hy1VJny9YNHM5HipD?=
 =?us-ascii?Q?+SaP57qZ4TzZrO6YsMFiZnXyIP7Xl8d0sxhKml3i9R/o2EKzJy/L86mRDY56?=
 =?us-ascii?Q?iWhpToPI3ea0NCPbkXJCWKgt1LpsfzgpE5sScl/v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b74a61-a64f-4acb-1c2a-08dbce8d88b0
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 21:19:09.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU4lZf2jOFYcq/Pr3iFgKxZJXZ+ulT+dVx8puJJmtdtteuM45gGNgk8ilm1lZizBgBDs39p7T06OaqCPjZLZMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7417
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the binding documentation, the compatible string is specified as
'silvaco,i3c-master-v1', but in the driver, it is defined as
'silvaco,i3c-master'.

Add 'silvaco,i3c-master-v1' to the driver and deprecates
'silvaco,i3c-master' to ensure compatibility with the documentation.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---

Notes:
    Change from v1 to v2
    - update driver by using compatible string silvaco,i3c-master-v1

 drivers/i3c/master/svc-i3c-master.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index cf932ee056ef..4c74b11b13c6 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1650,7 +1650,8 @@ static const struct dev_pm_ops svc_i3c_pm_ops = {
 };
 
 static const struct of_device_id svc_i3c_master_of_match_tbl[] = {
-	{ .compatible = "silvaco,i3c-master" },
+	{ .compatible = "silvaco,i3c-master" }, /* deprecated */
+	{ .compatible = "silvaco,i3c-master-v1"},
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, svc_i3c_master_of_match_tbl);
-- 
2.34.1

