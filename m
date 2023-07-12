Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E1B7513BB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjGLWmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGLWmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:42:49 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2043.outbound.protection.outlook.com [40.107.15.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49F51BF0;
        Wed, 12 Jul 2023 15:42:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RacgKPtJc84Azu+wLEg5AkKjT6nW9LcBRAPCORUlz/1wzX+V/m+mYpMFd/f8auwBx0LjMnLTMWU8doJ0Rs0NGQF3RWzHqg9/yAePyl9mhO5p3FeG3MTI5T2cEwhifecePJW+/3zQb6zF6mrr/bcZ+Sc/3hLfqu1gLAeMvMG4iAYFilE+Gpyp+vFIJ4S+eKrKO74aKBTDOv4/J9iVaxXDa3GFOvgmmNA/kZYfSG2bqZSpwZhZhmdyVdMhgYg/HpIAzTq6cOiyGBfJ4qLdytbDXmpfIb/OLuxY33IvW21XIS5mdElfw43PW21uXmbpiJWLK7rWWvcl2wgeaVWCxtHAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBnmfxiM/+44Im5++FVwTIAmNUtOAjpYqsKqGEDFS5M=;
 b=mjyK0x5ZXFMNIimsBhBOt++W58brPGvN7q+fpY2o0Oq52gUVLM9r/EFFhH9jtIdw5sCY/c83hkxC90UeOy0k2fTHl7+55UZ4mbIbm7iJZI9Nlg8AnNdkB0CvCxEdJl2FcrdXXzTni7XlcTa7MtccfAi0ygf52pW3nVKPE4xM54pp+UVTFrB5zGnbE+4w0h/JcX8KU3a5+KuArg0IdTJgJAt4YhG4SyQKEK4DBRFErG0P/B48uY+/4uEBNaGjejxK7UXcZksu6UQYFd5Kr0lSnhzggkxtrQKfmmB6l1h/DOKE624dRjNNPo26+JvjDu5PaS56cwybbr9cFXEW1eQ9JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBnmfxiM/+44Im5++FVwTIAmNUtOAjpYqsKqGEDFS5M=;
 b=NajU2ZjfEYwgAfLO8/hnPn+gy9cTs4sOlWmmbhfRWwiTkBHQFIrRnxaF2UgL8J4lJOkx7jgw147yoIJFmq3Ze5nA820dbnF7YRjeXhVmq9vZHPuuHgv6nB+O09TspapcmEPxozEQUMPS44waGfjvTefhSLfZN1j0LF2+TkFR8Ew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com (2603:10a6:102:20c::22)
 by AS8PR04MB8545.eurprd04.prod.outlook.com (2603:10a6:20b:420::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 12 Jul
 2023 22:42:44 +0000
Received: from PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::a576:5bda:df13:4246]) by PAXPR04MB8781.eurprd04.prod.outlook.com
 ([fe80::a576:5bda:df13:4246%6]) with mapi id 15.20.6544.024; Wed, 12 Jul 2023
 22:42:44 +0000
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
Subject: [PATCH 1/2] remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
Date:   Thu, 13 Jul 2023 01:42:20 +0300
Message-Id: <20230712224220.26430-1-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::7) To PAXPR04MB8781.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8781:EE_|AS8PR04MB8545:EE_
X-MS-Office365-Filtering-Correlation-Id: 6087fa1c-1d14-4859-eaf3-08db83294edc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VWPFA6ysn1XkbXyFE0P4cpFHFWBhsrUZ3p1f/lnfeXGEj5uHbPo7b6HvMA4N4o2zM/xBEIw9WhoGNgvcYxVRDDEmx0CcfwQ2W5eS9dxs0tkSMA/VXU4HZrTyALU+fJVmzygM0awMHS5U2O89srhzeA4d3uYSiie2vD8haJkX7i9GmbzkDcKr95RRAPfn9T1VQFDHW/v6ZVC2c8btn1hNpjR53ctgNG6ziz0UMlyc6fi4HBbvMdhP0h44amFDMdJ2vuxdL3lWOivysR7ZZXG+sfU5uJ91D/pnAI5Bw42ti3PmuaYGKAomat35r7hlZpmLuRgb/tKLV4aidpKfXEq5CmQziYbal1EFe5lMA3tMhd9HVZ+j97ffQ5vwsxP7FfrkFDS4DCQkDdp6tj5FGur9zXRIwYfu4Ty6yYDCv56KUwup2HJoFsKacrCErJYGvwdv7nNXwLf84CtA/v35v5+ELr1j2ifdLg9Eaqzv7hM56cWLK23lwhXn/HGjvWH+Xzo19Io1DFL3rN6CPDxwHlxJLeqWDmxNQYBS+C1/vMKNHO+GzHW3I7HISgdxJgqV6jKZ83T8+xGjEmM1bnHnLhjlPTYEfs35jDQwfjfh9xyR6GrSofM287vcd/IGOyzc/qS4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8781.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(66476007)(66556008)(4326008)(6506007)(66946007)(1076003)(38100700002)(186003)(38350700002)(26005)(86362001)(478600001)(52116002)(6666004)(6512007)(2906002)(54906003)(6486002)(110136005)(8676002)(2616005)(8936002)(41300700001)(5660300002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/M5akNiFzLe6HNqTOWiWj0vZbHldu910gd7lzf7IFg4r9deFjJ40XS+PTVyj?=
 =?us-ascii?Q?cvSaHt2e/ajPuS9+1+PoOHzBlJ6JlTPiB2JzHNM94sNRiW7FIFpLJ8lPyZik?=
 =?us-ascii?Q?fzlp8XUn2wxEILFjB0nOQ2hgr4J5pLh6BDayc7bS3mI7cAsxOGCRMRq8dqqW?=
 =?us-ascii?Q?ZlRBIJ+Ieg8q++Y8jc0jHrUc6hBpnw8Mhuv4NTiSIboWLMucH7RWRIsv13as?=
 =?us-ascii?Q?SIsEo8mWU5KM33hnn3/dlOLZyHLViOBWVL42ToKdfrglvIGYdGM1x6SStVio?=
 =?us-ascii?Q?xMqep+7JAwh3Pl4XZ3JcftSfHgCCZoZ2GmuVgN6J/+KR09dsYHmSZLaQbmuK?=
 =?us-ascii?Q?V9PGuuSSrGDn4WDoBLFPFCh+NnZzwDZc2pGWW5KwiG+0Iwvnnnw0ebptsjZx?=
 =?us-ascii?Q?zuX6DpB1Dw99xbLpZRKuj0egCB2eu3PZ+kHXErtMkl1pZMG1MS4IeMyLGrHw?=
 =?us-ascii?Q?fkvlQpxpXXH/SVBlOfD+m++MstqlCYqulHhsGzBSeSglXSKro6swSCRKomgZ?=
 =?us-ascii?Q?prOecvLcKR+8xcdJZ/rGibZfK4MatWQbmjWmVPQmfEXB7saXw8myJOWstbyU?=
 =?us-ascii?Q?dGizAmRgyDBREkLU+bJVGd8e2lZZztrUMdTnRFjZSqvH9MDSWcxcr0pa1MJ4?=
 =?us-ascii?Q?1Q3wUsLsnzRMalitQmz4DoHfj8JaIcXBmalwQUHjOyG5a5N1dgvUVKCt0KDk?=
 =?us-ascii?Q?lWGUnCMt+eLO5BQIVm3P0UYY8D+1I9ZwGP+eDJZB47DE/SHRhaKfbx3ppyzM?=
 =?us-ascii?Q?UwrM85vmVh7LgREPuw4YzZP0U8vA5ld4SjnW/wVwylwqVU9wXDln03R7UxNd?=
 =?us-ascii?Q?v3nV+SlD9pDXtebBI5UJ9DWJFcGKg6g85MtSPDdK2d8q9pDuGIRZvZtxZOct?=
 =?us-ascii?Q?At1KYDfcZMdC0wQIbOFCvL1+ug+4rpYc8wPCHPhBQ911bwPtGqLJcA8jVJbI?=
 =?us-ascii?Q?5LITSrZw1mQB7l/dBg8mVv4FlS7NdTxBI2GDf7ZHNBmCOBK9yocVHgElkpfJ?=
 =?us-ascii?Q?2JDRNj24ycq1Jp2dToROo4TeVWYpWVBqNAGnLlPNzQpWR6LQ6K1M5kZLtVVg?=
 =?us-ascii?Q?riKdB4vMjhg3kb8fpiSEi2XuxXfd9vuKFfOW0G/G8Bic27kfPuwUYARhHx0o?=
 =?us-ascii?Q?ymDwa+4hzl7wWey7RwGRXZf1lmQ+Yo4oagyzbIBO+Jb8o4CR870ZjYawCAzS?=
 =?us-ascii?Q?2kd/2qOZurIHfSkURPvHwN2OwRmlnaV6YhJGaffw4FxmW2pH5PSKnHdjvVvp?=
 =?us-ascii?Q?+mPSEGtjvxBUuenhheDxpBb9GscOMFqdutcTLhcdl8p72BY87ss2Cv17O6pc?=
 =?us-ascii?Q?e3T4OPzxsH5wVMB/ANJH1lsIQmmuSPyILUHMEp6yHIidURs4bBVLdPsB3+K2?=
 =?us-ascii?Q?Kz+u3RqsgF9a8JTtFu0iGx+qHOntXEZib8RSHqfHc+NMaxSGOz8J2EErfg8n?=
 =?us-ascii?Q?c5MpJ3A79CiqX/gLGTNZk6094QZSOUUtfkyfcncI7fkwqhIzrpLNd4sU44Ri?=
 =?us-ascii?Q?TH22Dq/aCEKSf3Q6rJj3s2c0EJtpcFQaUREf5einMDfXkBCy5dAPaypYOzzv?=
 =?us-ascii?Q?c0+mAOcd9y4CmRHlELKJq7eTX4kYnpGxE77jBQHc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6087fa1c-1d14-4859-eaf3-08db83294edc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8781.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 22:42:44.5187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KKSkNocAAb/PRfX7DOSxzqwTn9XAo6kwGpsrHeH/Fa5XXFPbPulkDRbuYDT3E2kzZoUhFXwpK0aVJ4KZ3YKnYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8545
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Iuliana Prodan <iuliana.prodan@nxp.com>

Add the .find_loaded_rsc_table operation for i.MX DSP.
We need it for inter-process communication between DSP
and main core.

This callback is used to find the resource table (defined
in remote processor linker script) where the address of the
vrings along with the other allocated resources (carveouts etc)
are stored.
If this is not found, the vrings are not allocated and
the IPC between cores will not work.

Signed-off-by: Iuliana Prodan <iuliana.prodan@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index d95fa5586189..b5634507d953 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -941,6 +941,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.kick		= imx_dsp_rproc_kick,
 	.load		= imx_dsp_rproc_elf_load_segments,
 	.parse_fw	= imx_dsp_rproc_parse_fw,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
-- 
2.17.1

