Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2294879D4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 17:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236370AbjILPbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjILPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 11:31:04 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5A110DE;
        Tue, 12 Sep 2023 08:31:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJBPR44aQIJncBAxJGZ9YGu0jwisUjST9D0IdK23bl7EuFSWYnXkJyZKwrKKamImPxPNuaYCRJycebqMBzBKqYo8YcVXoHKv8hUTsW6lmxtadGXkb55sizitbdLOWeJNDPLuqkGYd2gXd/+LOHocnbaZ6vcNJkYg1xIQ8jJmI90FV4iSCzWpYLMqE7MZ2R5X31yifSnaFSfDXLo9aVh1wFzCT3094fw5MCNQYSO+0KEieiFvW7ICdaxYDxcrL/qs11rVxYy/tyBpN2A2o7+fAlw/6tOovqyNRp+Rp92N2IXSp82w5nOwmyrRjg7TI/XB04k5fCN/eQEsufAy0wFoeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=ay5IdBjh0OYcuRk3t6NxvB7dF9YdBGDws1spEl0N4VwOkK0+spT1Nsd+k6n24kQB4/TSo4XNjrTCk4fxgbjVZ1yXfvvdk/zTFtcTpdfFKrwiUoWY4kL5qPuFresAmglUAST6aG8RoCFwUL+UXihhpWuSxCHmTwtOPCssa9gglDphDfLaV8fRuwQRhd+R/huRDYHE7hyuZjIDogwkVbbT4psXRPAlWjnb8OOtnPxgKOv144C0IFJWTLibdOW2PEFpbDl+UiAa2ECE/8fqtUeNtjbdGjWfBW0DELsy9huwIES9vc5rAw16TbhoIK2heYGaBOAE+eEeua6WinfBLOiqZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJfkSMvkEDwGsM2agRpaxrhLAMGHiw7/JkQhgPoDD2g=;
 b=LNKwXd1WvcTD2krstwpquBO5F7m4r+0uBMUiay+bTJk9+FEaWlq1sXswMnn+AAPqDsNhPMaIyVxsgu5QgD7YxTmPJPmcCeekjULHrY0T8deSxoOROkOyhjgio7/b+3rYrqp780ZyuuBh5HAX3AlwSg8Id/3z9Kg/qCzZiiAO/hI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by PA4PR04MB9415.eurprd04.prod.outlook.com (2603:10a6:102:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 15:30:55 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::ad2:49f8:14b:25c7%7]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 15:30:55 +0000
From:   "Iuliana Prodan (OSS)" <iuliana.prodan@oss.nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Shawn Guo <shawnguo@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "S.J. Wang" <shengjiu.wang@nxp.com>,
        Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mpuaudiosw <Mpuaudiosw@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     linux-imx <linux-imx@nxp.com>, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        LnxRevLi <LnxRevLi@nxp.com>
Subject: [PATCH v2 1/2] remoteproc: imx_dsp_rproc: add mandatory find_loaded_rsc_table op
Date:   Tue, 12 Sep 2023 18:30:20 +0300
Message-Id: <20230912153021.21786-2-iuliana.prodan@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230912153021.21786-1-iuliana.prodan@oss.nxp.com>
References: <20230912153021.21786-1-iuliana.prodan@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0006.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e2::11) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|PA4PR04MB9415:EE_
X-MS-Office365-Filtering-Correlation-Id: a8318147-755b-4997-3d67-08dbb3a541ba
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2LRd35filMUhCFzekjXwXjAz4eKtnqeZ8+PC6c7GMTsUs0I1wQIsyoU88c/96CuTzNSJyjF0tQY9ay30goowgtJaSNdaQ8fkQdLWv+ukiXJkjEwOJOwCVg2zqge1RQmuyZ0ASwBFAVbr/npNxdq19NDK7m4CeI9Eb/XPS5+tkVq8kn18sR0ke6WTMLx4Oi3QwFUbhjq6JeShZzZflBVrxoekML/AcxzkrmzvLCGNnP5vCajYhfoadEa67e5jP5xvfTKt1iXtYdCa9NFZ0wfEbSRoYetE9aBNuyjE533kY/LjESN00hd4b7gg2UiXN3hca0TVlwevukp9boOVEFBx0DU+AxSwwfUvi+tAbad34JUbdP7dFykEGqldDjz0ZL0HFvPPS78yRcx6MIrMPpnjB+h7JimA5jBP4AZ+SCNPH5QTCqaXPo3+n6XcHhUbdjBGO3uGIZ0teOPBU19iaZour5RillPcGUrP45UWu2eXE3OmcN5yAy/uCjc20JwM+ji0XvsBiSVTuPMtTOx6Y3YqwFXU5B0JfwLeg50ljNxAKI5r7ER979/UilM2zPKZiUQQOUc46m5wLgbO7ovh4fJxxDVT5IM/K2Fg5ov5L/je8fk6dW5B8egZQEntvbKEh9nG3jUNBY35tO5W2aJwGARLGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199024)(1800799009)(186009)(6512007)(38100700002)(921005)(38350700002)(86362001)(6666004)(7416002)(66556008)(6506007)(5660300002)(66946007)(316002)(110136005)(8676002)(2906002)(54906003)(478600001)(66476007)(8936002)(52116002)(41300700001)(6486002)(4326008)(2616005)(26005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xmJtstDeZAo6SAFxvLeKdB3gBevSfhOGIgJ8XrxxYouYADHce1AZCyp0DGUy?=
 =?us-ascii?Q?W9JDjBSG8g79hoIg/HMGKn6ItyIgZx/LqxCEPLj+HlyNYO4JugFXbkY/loDK?=
 =?us-ascii?Q?NY5nOJpuUMHRag778wx+rCSX83rsuYZxAbN1XLgkV8ZlG4d87eGbN5b5nYWr?=
 =?us-ascii?Q?hY3glSqwD4uDH/H0Sxd2fis2xZ7jRtupqeLUtUkT8EzYLBWhLV+VWEg4uAwA?=
 =?us-ascii?Q?J8r97PPQw6yHax2GHjymfP7+w8dQUzIsJvPm6OS5xjgHkzZREoL5oPddOrxl?=
 =?us-ascii?Q?/btt9DJN4St0LwgSHz8ImK5jgu30jrLM/yvMGg4qmTn8CRvozWUh1fY8LMwB?=
 =?us-ascii?Q?X2gzgEnKqzIPh/n+u1apBpw25+F34uS3vdkJb6TOySc5xkzQmEDiMfpRWYdd?=
 =?us-ascii?Q?52pU5J6MbySGeN8O8HpAmHaJNO2x7Q4DHFLtLNIxJbbE9fLbtUInEOLJ8WGx?=
 =?us-ascii?Q?zIdgNqGBwbtnKv0/JwMFuuVInSbYQEADM/VlFMkQKDrHEVODCfjPcbAQTMeA?=
 =?us-ascii?Q?3Hi7FNtw2bDBX8BUnNuEPt+3Mj/rhq92kl/R7ekz8S+P2Wo5HxLoZIvjnrF3?=
 =?us-ascii?Q?lazakDN1J6MUPlMr2PU+AMYcp5hrsl8NrRWckx4SJCFkJ8mLW+46b4hbRhg9?=
 =?us-ascii?Q?+ByUtpIzHu9KUi+Nrzqf6yhmD+DkYroNO5w3jS+htg1gJy0V6hd+j/DxjycZ?=
 =?us-ascii?Q?+eTjtyzej4Loipq+EM5ea7NNRidH4NbITP4tr/jUIsRKL5+uPGiZjvQXSucd?=
 =?us-ascii?Q?CCtK0YWUPXoZcc1pnswmgHL83ZS8MDWrmfxlC815xC0DXfonjF8qxoEDih6M?=
 =?us-ascii?Q?bTFiOiqV0VovzgXRnAU880verTtP+fuLEhX0XPDIxnVwPdo6sJBIsFMf6dlW?=
 =?us-ascii?Q?y7Jn5SJIKeWPE5yz2aEqeWqdBM/9JM8uwEqfc2D62w5VdTzo6/6HIA/NHTC7?=
 =?us-ascii?Q?+9shRcYN9tpvRUxRHsvjWxn5uC6UaTlb4ywtKffcNt6QzbWgDYH8Vzl6tIbt?=
 =?us-ascii?Q?vjadsLHT0wRcCiZTY4BXhiDLVr+FkOBaw8NeVL0fwuVD8KDKA6DlIS3wWuM8?=
 =?us-ascii?Q?vY3B76gkDEF3RHjMPX51CgPLDux83VfQZFyW8OZd2KnAhrwsvf8L9VJxTBq1?=
 =?us-ascii?Q?ozsJwNw9Anz/+5iYEx6WMLmuFSEtk+xiekqCleEBpoTfDoHwkx2Bex/dXmWS?=
 =?us-ascii?Q?HZkW8y8oXfB1TXDBpN4giwIfX/3q2+LcWum5NbfafMCmY1so38KU8xh+Cu8i?=
 =?us-ascii?Q?vRVoHPT3wbhkm/T+AMrpncFmLHTDvreRB8EFJBjEx5FXFoiq5VIgQm9tcjqt?=
 =?us-ascii?Q?NiyqmGXgsTmJtUh5prFLtf5WEtd3kxreFmunrLMO9MWEIr125P247oVo1vl8?=
 =?us-ascii?Q?0BYDr8Pa9vFNkHg7Hs0Zf5UmkMdZ99heNZ9tYgY9mr6fQlFI7gq1E4Y4KSjh?=
 =?us-ascii?Q?9XbT73tf5h3QVkfMCn6TXaGlmIxzmjXldvf/e5cwlOR8rvcwvSOIwYgeHNkm?=
 =?us-ascii?Q?jDLLWzBiJi0CMgm1ueL0zw9pTQlZqiA3nkfsgTLId+PflPsoUqUXpu+25Z+w?=
 =?us-ascii?Q?1TOl+hATKZ5Xb7nxZDEyzQ8VJYI+peiXB+dCuI760Xymu5s2H/L/B+imP3UU?=
 =?us-ascii?Q?2g=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8318147-755b-4997-3d67-08dbb3a541ba
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 15:30:55.8514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WCemdsj9Ee1Od3Us7f+ItUtEUXtq++UqUR26jm8A1M/6bIw3MNvxjBBQevt09yj2O930Gt48tFejqCrmv9B3CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9415
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
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/remoteproc/imx_dsp_rproc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/remoteproc/imx_dsp_rproc.c b/drivers/remoteproc/imx_dsp_rproc.c
index 8fcda9b74545..a1c62d15f16c 100644
--- a/drivers/remoteproc/imx_dsp_rproc.c
+++ b/drivers/remoteproc/imx_dsp_rproc.c
@@ -940,6 +940,7 @@ static const struct rproc_ops imx_dsp_rproc_ops = {
 	.kick		= imx_dsp_rproc_kick,
 	.load		= imx_dsp_rproc_elf_load_segments,
 	.parse_fw	= imx_dsp_rproc_parse_fw,
+	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
 	.sanity_check	= rproc_elf_sanity_check,
 	.get_boot_addr	= rproc_elf_get_boot_addr,
 };
-- 
2.17.1

