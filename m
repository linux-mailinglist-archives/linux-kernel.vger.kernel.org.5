Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774647513BD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjGLWnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:43:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbjGLWnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:43:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915901720;
        Wed, 12 Jul 2023 15:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMUH4u81cKoSYGpbS4HRW2TpTtweQW42ClgRhK/c7X49m5U6cENPi78z4cK7RRhV/sJ4KW2tExmcUmULux5h59xfRet/E6u6Y7SE6Z4P8npExiEnGeaXV/j9pOrDJprCBHbU5kgZPLNvRPuvDozu777HjB2oXxHhhgTLs/tDVsEGCde5R5rAHlj8DV5z0oNpvOGR4aMwtrRQPVJ41Ot8PoEHlVN6m0p3R9THYk70on81h8/Cep8jPoomnC9TT27nwLt66xW4rkEX3aurLBZEFsmvPCJmL19xzJ3j46JtHKZ/kLKyOykOXsJ4ax7ICl9zG4g4C5XFazZMnvhZAn6RJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fe7xGkuFhcHKkTA+9v652itScjQ3pIyJtN+61CmRkvM=;
 b=VH7VSFaQOo2n3xNUQJfalCx1pmAbZiAncaby+o5QUOiTcKtchywrkqGEiJwaJ6yt5oUtgzIzpE1CKOXq15/5bIgvpu8bKqOVCcfXepEwkLqvpbM8NN2lYOZPMi8kqi4FP0c+p4OWoaogmgYV+TXmGKhMMbdhzIDI4+d5I1f7t9blhnUezZi0Ty/XJx7ASI70k0XQ7HpQ0ETx2pZB923xYAESJkXpjqQm/SR3oukoZ29eyI0h/Forw7jaHtUS9v6Qw2z2cEuLXwXuPnpkhN+8XQS/0xwNUnBgrjsXyWFRDluC4EN1dQGr3x4dUbDJIst5LebK3JCgw+H8wAgv0tws7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fe7xGkuFhcHKkTA+9v652itScjQ3pIyJtN+61CmRkvM=;
 b=kQpD+xEe224UBX8K2zBMiMv0VxhVGFiVjyHgHriwjntABKNfoQJZSwOQDUjkMv3HhtJHOEZJe/DUyS/tL+ORw3ee2QqmqJS1/+LwF+Ug2YDnP7K4BBhDn2UeUu5BUZbRRspOnfQcovdUW63XvvkeK60w3gKC0pDuFhuXU3cHKG4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22)
 by AS8PR04MB8545.eurprd04.prod.outlook.com (2603:10a6:20b:420::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 12 Jul
 2023 22:43:11 +0000
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::a576:5bda:df13:4246]) by PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::a576:5bda:df13:4246%6]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 22:43:11 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH 2/2] remoteproc: imx_dsp_rproc: add module parameter to ignore ready flag from remote processor
Date:   Thu, 13 Jul 2023 01:42:51 +0300
Message-Id: <20230712224251.26482-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0002.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::7) To PAXPR04MB8781.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8781:EE_|AS8PR04MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 939865bd-23bf-4a42-e573-08db83295eae
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rt+qCRdXdQx4jQmeOHbYSlyVHyC4hWDN7oPz/w+XBM2Az4PC0Od+Tvi/2w/Ew03GZZyMQ+EGVpM1d6npkXUHzbvcQR/iNRj6yIROJj/prGFMIqf2cCLmmG5hxziCDa680pYO0lfg+PG+Ge6F2nsDqskjDcPgFnEllXNgPxvaUc9o0zCtdCespMOjrGRFkIExvoysZq/a9gU/5k83CJdD2lO/+oSMi/mJLYvgaG2uQAH5B8HEiIvnRksPon0LvX6gEMSEzdYev33H8ixN/zWTaPBIdAE6bCCeo4m5dEapZKQD8KcsiFCAa04PicM1C/wsD56N73ZEB2ZmF8HFtAckIo770HWYXBC7yrBzk8vwJ7uhOYIKE2RtOYwSAuHJDMsXwAzF+tUlF20zLmwaxEFBUtFe+TYlH/zDk0OFnFys0+ITa6dm3DyvfKPcRJAK1da+neEwucUShId2TbkjgMnbbziuicfgCR2afs4CGnMRXtP+7cmY609vAOtcnt3dhtewx4snSeZiyaDCzKcjRzUlmuHmxhX/FkWME8aQP7GjwE3IXcD3GYli3mzqykgw+kfkLtrn3GMPns1L3bCMNTnGNLS3A9cy7ldPwIIKB4wqEpc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8781.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(66476007)(66556008)(4326008)(6506007)(66946007)(1076003)(38100700002)(186003)(38350700002)(26005)(86362001)(478600001)(83380400001)(52116002)(6666004)(6512007)(2906002)(54906003)(6486002)(110136005)(8676002)(2616005)(8936002)(41300700001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKcM7ia/pZ5ENW3knYE7Fnii7UPYUc4wB7bTZQ+YVVNcBw9WceFTDveA3EjF?=
 =?us-ascii?Q?orog7tZ0fyM9jaCEW6yt1zX1f2gsp0saoqICYPHHoewEMLjE1fSPvBI0zR4I?=
 =?us-ascii?Q?o9ZmNR8MP66s8X/M1HBirfBLuCxYFAFOg9idO9UEvkhKBOEiu+CNHSFAC7gm?=
 =?us-ascii?Q?c+bRN8wEeCiVbJCqlY7OYD0AlT6atudvmZC3+pvuZUrjsdCqE9cpuFpiObEa?=
 =?us-ascii?Q?21BGIsOHJgeUiBjjJTNiOp2Xg65X4YOEHTOdBcbYQOZzB+Rmc2gyazRWwg/T?=
 =?us-ascii?Q?QwxCxnkyPcLUWmPzdhzekZdvEcxnqE4ZuEhDW7HXo8OssbnXoejIsNOChtZp?=
 =?us-ascii?Q?b5hSjIdyOHggzNK585YPN2iX5Ut2HjBe1k0wpEHKDDaRn7gtWQdS1aZaIUh5?=
 =?us-ascii?Q?OsTDh0R2cx2BQ0nmBLp/jMxpuoglV40g8WR+Q86wry1nHAz2JluWLVIapjmv?=
 =?us-ascii?Q?om+0TRz4NTKEdTuikhDb6jw465S4ukd1zoqdS5TM4YncGLHL564zqZTZwRvM?=
 =?us-ascii?Q?uSUe4KEjsenpzU+xjShDRzJ35D4tBRqxND+ZzdPm9CqAFQi0dpRnDszd4Eoq?=
 =?us-ascii?Q?Ay6aHesAgGCWdk/JHkceleWPBQSACMZHjgGeR0uwAzfrOqBuB9pVsSdr9mxd?=
 =?us-ascii?Q?SW2L/+2Le/9HsbMtas5BkEWGX9iZJ2YOE9c2BmA4Orw8ug/Oekd8Jh7iDDKM?=
 =?us-ascii?Q?6ohJWVRflZcfpO+beK+vhKzoLE7m8ijYYmD+u11Ngv+y8vBuh8Dzi9lbdbsr?=
 =?us-ascii?Q?eK8fC1RkvWQpVDD7NxIkhJPWrSUd5ny5MOzWMOg17axUIxO4ghJDFJxb5KIZ?=
 =?us-ascii?Q?yQqhHZeP8L5cBLlSMiVJCjwCstxNTdlVFYEHqzSvVs8CqmmhljFQDir809ud?=
 =?us-ascii?Q?A9HGLuT2g/LhInBmnkGCZZsLgIiG66GwHGT+ajg5L8eDsspSXPIxXGwQArJw?=
 =?us-ascii?Q?/0P/9kWc0Y7C8iC5NHmn/EO8lggKUJdVFPyQ9EwrxGokBa6v+ZuL3gKE081g?=
 =?us-ascii?Q?XHf3/K1jSoBNJCcwVGRAQZcaHShNV18Swnlc0t/SGuk2Bc0ryKFxhTEqNTCc?=
 =?us-ascii?Q?DQ8zqCyR+VeK4iIVkj4C/ZBVPPOaR9sALTj4srMja9dJFZ7EdcsesxsKj/G/?=
 =?us-ascii?Q?JBCFx5/TfUf4QrVT7ABWpCAGDcgoVxQD/4mJ/1EKtAj4/yNCRYQJnf76cA8X?=
 =?us-ascii?Q?CnTi/L+twJIxVkt4WV/nK5utV9IlaCyho9GzvNrkanIvUHJB0QwNWF6DZoZo?=
 =?us-ascii?Q?UufeZPAywwmB0Em5tX0lF03niiSkk6PbMz0PoCKlbfGPScoMxNKWUdhCSwDD?=
 =?us-ascii?Q?PRCtcbiJGIjPeMQrkl0uFN4o1qTu1D4IGYX0tuoAfxsBlWRAx+Ky8ytB08gQ?=
 =?us-ascii?Q?1YZsoeGuWRkfzP8Uwjzd+NZj9odCUW6ZuKidIL0egj8FLU27EBlbhhF0db/G?=
 =?us-ascii?Q?SqOb1jQLTDGAUX7QCIqktlIpx9LdKFUxbJ5SGOl8c5lPcZl44aVS5sQBXENy?=
 =?us-ascii?Q?rqRu//Z6J105XyCNqOdwYG2Goew9MdtEIpuZ+iA0HGy4s6fUcUoi0/kaqjKL?=
 =?us-ascii?Q?jwzLbKxd7Nw+XNYC1Sf8KlhxEMjHhm3gAWOBwnLL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 939865bd-23bf-4a42-e573-08db83295eae
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8781.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:43:11.0056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bhqjP8/LgE5j7VWpfUrsyXIK0Hp2BHPOzasWaBmjvh5fuPtpwBRgXi9MsopWaryNgm9IZjSrPd+yDQIjMzvEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8545
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

There are cases when we want to test samples that do not
reply with FW READY message, after fw is loaded and the
remote processor started.
In these cases, do not wait for a confirmation from the remote processor
at start.

Added "ignore_dsp_ready" flag while inserting the module to ignore
remote processor reply after start.
By default, this is off - do not ignore reply from rproc.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>

---
This was discovered while testing openamp_rsc_table sample from Zephyr
repo (https://github.com/zephyrproject-rtos/zephyr/tree/main/samples/subsys/ipc/openamp_rsc_table).

We have IPC, but the remote proc doesn't send a FW_READY reply.
---
 drivers/remoteproc/imx_dsp_rproc.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index b5634507d953..ed89de2f3b98 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -36,7 +36,13 @@ module_param_named(no_mailboxes, no_mailboxes, int, 0644);
 MODULE_PARM_DESC(no_mailboxes,
 		 "There is no mailbox between cores, so ignore remote proc reply after start, default is 0 (off).");
 
+static unsigned int imx_dsp_rproc_ignore_ready;
+module_param_named(ignore_dsp_ready, imx_dsp_rproc_ignore_ready, int, 0644);
+MODULE_PARM_DESC(ignore_dsp_ready,
+		 "Ignore remote proc reply after start, default is 0 (off).");
+
 #define REMOTE_IS_READY				BIT(0)
+#define REMOTE_IGNORE_READY_REPLY	BIT(1)
 #define REMOTE_READY_WAIT_MAX_RETRIES		500
 
 /* att flags */
@@ -296,6 +302,12 @@ static int imx_dsp_rproc_ready(struct rproc *rproc)
 	if (!priv->rxdb_ch)
 		return 0;
 
+	/*
+	 * FW_READY reply is optional/ignored, so don't wait for it.
+	 */
+	if (priv->flags & REMOTE_IGNORE_READY_REPLY)
+		return 0;
+
 	for (i = 0; i < REMOTE_READY_WAIT_MAX_RETRIES; i++) {
 		if (priv->flags & REMOTE_IS_READY)
 			return 0;
@@ -1119,6 +1131,9 @@ static int imx_dsp_rproc_probe(struct platform_device *pdev)
 	else
 		imx_dsp_rproc_mbox_init = imx_dsp_rproc_mbox_alloc;
 
+	if (imx_dsp_rproc_ignore_ready)
+		priv->flags |= REMOTE_IGNORE_READY_REPLY;
+
 	dev_set_drvdata(dev, rproc);
 
 	INIT_WORK(&priv->rproc_work, imx_dsp_rproc_vq_work);
-- 
2.17.1

