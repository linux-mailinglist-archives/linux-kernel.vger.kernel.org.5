Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E121C76109D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjGYKY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjGYKYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:24:19 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2085.outbound.protection.outlook.com [40.107.20.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E5D3;
        Tue, 25 Jul 2023 03:24:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1urEWJiaFGhfUhjO8w5wAYeuN+MFd7PnC9ZSf21tQQ4j0dcvkZ+ODYqVbJiH6d7cmtsTiuWP6Witwdq96zkVyOpTiX7F6HCNdmmh80j6MkaIuapIRYtOkHpJCHrd8Fgwx4Pu/Or6L8ExvvaN0XN8nFgzj71aK6wQ1QC/WYcbxpuIghya1sISshM2JXOedQz44I0C+60vD4GFxjs3FUg4FzvtOympfINFA/A3NS/UOzRfJYeq8tFDKzdFtnA5WUHP8b8sCNeXmRvD8rl0O+rBtRKbHaC/cBlzWYLx18rCs6noc8scCz+czqT0EdtUS1XESqJfLxe3tuNtYjZ4+h9Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTFYlVGy7vXRU0FQvlFcfoX/HPThOETjXSPAf87koXE=;
 b=dtIJMpC299zDbDp9OhiVDSi1+YiHEriw17E1XHKuh/7gFm3msH1c/l/PHNgdGoLFKoizLfROlWP36lhHi8zEfGD3JiRMRNA4ibdTAWVaFIHm4GZ+rC/QypX0Jw9nGYSqdggdOQz1QFXywTsDg+eGtU0b3I34+qLTb6vJ//enzJPnsUhkB1kaBObnAVuZYvtTgIrEu9tN1t3CdlzTH5vfXl6hCbfOxjIUhaAFflfhhKkVZHVW0MTSDNau7EGTulhD+PRMut6a1XaZLLOV5JVm6u/SIl79pdmI1vicaHJUfPIRXZccXTHqupRDjLfKQ89bIg224OSyCdspJAWidfdbbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTFYlVGy7vXRU0FQvlFcfoX/HPThOETjXSPAf87koXE=;
 b=bPaiBUNIvBbE7pPceemvJOT2gyhqEFIeIXFyhOGwqybC7/m+hoclcKINFkdlVOcjwFLqy8F3aA8CFBgUwO0J+e/w5MdzQ4VIWuYCsFdAGwHNTiQzdK/UdJZ8lWGcqxyqRlfHlczp0QyhoHTPMVmasGdePOAH4F67wLjEyx475WE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB9780.eurprd04.prod.outlook.com (2603:10a6:150:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 10:24:15 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:24:14 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, ulf.hansson@linaro.org, shawnguo@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: power: fsl,scu-pd: separate out fsl,scu-pd
Date:   Tue, 25 Jul 2023 18:29:00 +0800
Message-Id: <20230725102900.225262-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0180.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::36) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|GVXPR04MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: a00a08f9-b08f-4017-7f20-08db8cf94b45
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsUyKabwjTP9QgblW1yonolm+1+f+ljmuCjdv18Sh8xkt+tMGvAvhzST4cHYinDpaLbg9dlgj5e6+6M+GfoN8zt8loxpNcd4NDs1HD2IHGwv+SVrE91vRMuapT7NlT9xrg/28qiMZ0oNQPHB1XQvgy3c6m+Tv1wrcYvEgCxqeDuCaq/4CxNVS3vt6EH9TTyTGzICop/fLyGnLAlo76ae9S3OWuyFFJmw11ZZKkuyNFuWkKiBSCWFAlurJUlkkRDyCSab5gdYSaAvLsPi+Ji24kMTwLblu2u0b7jNfi1x0s8du9a5rq1WMFhsZWVDcrZlrvfCLlPjN4jLm4mI57m4gFc/mhLxaSoTAFIfUVEug+xNn+hd4Nk/eKm+GrF4GGycpvy8NuxhvOcQ/EM+eOdS5O8KJ5IQMHfqwXvWFJAmBqFM1Uf/+cRzR/iin65udB6u4d3dHZmYTTL1Azh0SVOoi/uOTm6a+0aqF/nc3BykISrQgozzOY+zJCfh1+ro/msrOxv9lMDzp3GBeGS1cYVbVYzPIqXTqhpNrYPteyw3CNqyN89R/agqjfrlU4L3MKjOygGT2uXQFm+D5XAjZiUxLroldyioi87fBM+Ve6OtMQzxKg2efrHLk2PsuXe5198J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(366004)(136003)(396003)(451199021)(66946007)(66556008)(66476007)(2616005)(83380400001)(86362001)(38100700002)(38350700002)(478600001)(6486002)(6666004)(26005)(6506007)(186003)(1076003)(52116002)(6512007)(41300700001)(5660300002)(316002)(4744005)(4326008)(2906002)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/1RKFMtf/0RaQNwiYKrIIegSFPnWJHIPx5T9KcfzgIL21Ni0GEHQidFmreNK?=
 =?us-ascii?Q?9OV+Xmx2ZZ5tLqrlOMsCkl4CDfauwfZnvZ1orculufmThAvTvSGHr4g6DTei?=
 =?us-ascii?Q?+F2/kL3F3hC2YMUrMkSih32Ci8Wt69SGz6XFo5st/fZy2FSGJF8EJ/TnCWt5?=
 =?us-ascii?Q?zeznKLp1BHHwvjK6SBTEYGsy2DLCHKbpR+JhFoGjsoH+83LTupVefRY9fZds?=
 =?us-ascii?Q?k+xrxLjuMLkYNkREYMpcfgfwMny+HKzolpGgz7+fc9NYyY48GMg9jdiSK47P?=
 =?us-ascii?Q?e4PkboImIvZqpuuA2ijN4jlavIVZKEP7Tket/x56PSMGDnZUq6KMsgBqx5tY?=
 =?us-ascii?Q?e9XNWjTsp2gHqv3y46NSVJOqKGygLEW0Zoav5vF4AhA+Dpms96l3NMgPi+75?=
 =?us-ascii?Q?Balk+LmXAcTmV20uxwGX9dimprZuYYzJD0Pn6fGP5inRHe+QOVpyiOlMd/Qs?=
 =?us-ascii?Q?NkmzyMnqT3FQmX/0Gz96yxhOYKvzUqklZwf/AP/Kj6L3LtcTQ5TvcC0uWDvs?=
 =?us-ascii?Q?da3qidTJ2obxZfIVeM+eKFGPa57+Qzw1XlejyKrFvOKyVRGgq/gUZYzovzSH?=
 =?us-ascii?Q?bYsiONbXC48tJLpc4/+j4sa7LMIw+9QREJMHC2GpTnaFgmyDtBYOCmqN4SB0?=
 =?us-ascii?Q?60H7T1I+oYIqaCo3VxqVLKJgAOPRwgoNEhAZoVl7y6XE582o6C4VVAP2WfD5?=
 =?us-ascii?Q?ARnpjMrU4lHQ8mmPU1OW7zrg6r6h41C95p6vyycU8s3p5K2/LRsmGQQm9F0j?=
 =?us-ascii?Q?RfkMp6MY4kuAXhqHfdWQX9BpU55W4924hITUDjGYFO35Z+JBe1en/rg501wX?=
 =?us-ascii?Q?ZpX0qb1KkPG8tvEI+trIigwccGqivH+7kDywOs444reuzUdNAvqbvuD8OXfj?=
 =?us-ascii?Q?MgZF57gON6EndlZKxlgK4rRMqqUoGUnYZti8YhXg0AOAAvz7T79UCnigDXsf?=
 =?us-ascii?Q?uXwuOLfcxPNGBycDXoqXPXr9B6KgsXj/Rbbz0Q8qBbdjpWkfIxrkmVgy4ghq?=
 =?us-ascii?Q?7PYZsJ/BwKFngUSbCSdn9evlB202e1eULCz8jJScIR04j2OWk3h2y3u3owWK?=
 =?us-ascii?Q?0w94qAJpmUzJzfqaQ41xiEl5Nm0YjIc5GCAe4V1PC8pymFofSIhXiD9sXPlC?=
 =?us-ascii?Q?2973H56hBNEQaAyCIzIGGBdvrkY34cW04ye/2+ygIZuxdwatnUeIoqnypLhH?=
 =?us-ascii?Q?9A04VOmKCJM+RaMMtUCokaUooWUuEBNLUpyt9rmLlmBKaPr2Qs1knJkLaWYn?=
 =?us-ascii?Q?fi1tOH1KMiU7CoOHYQiA0GO8X+kQPPgGTxzK3fiwUlV64HlQMhQK39ET9aZR?=
 =?us-ascii?Q?F4G5tDn3/AkIivtBH09TiCDJpC6Bpk8kdkmYUt3JB6DWPuSMeR+N/WsgNz0/?=
 =?us-ascii?Q?nqKwBw12wjOBSHCXF/Bm6fCxkSYB3KvYTL5jIPwX4ME5NBrUPxClLvhortfb?=
 =?us-ascii?Q?jmirkRTXgdLYW4w/Gi0s1ahqHenttMU+LMNEVqkIV+fNG4T2Zgs6ohxl7wUG?=
 =?us-ascii?Q?q4IvhAzE5cm2fkmLtiVPp+/Xqz+3q7Y1E7632ogwKfllTqiMQYvHfHUTIoM9?=
 =?us-ascii?Q?UIjtDpsxJzj9i3rR6zqTTs8IayOXZ+DwsSja0H1F?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a00a08f9-b08f-4017-7f20-08db8cf94b45
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 10:24:14.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7ViLCcdjUBJCLsOvyBi+EqBSUdvZON7g/M2CUl6Azi72dh51XJ161+uI6qJz6T4oN4kdrtHl4GLpwf506UjMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9780
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add an entry dedicated for fsl,scu-pd which could serve i.MX8DXL

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/power/fsl,scu-pd.yaml         | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
index 407b7cfec783..3a92e4fef7ae 100644
--- a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
+++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
@@ -18,11 +18,14 @@ allOf:
 
 properties:
   compatible:
-    items:
+    oneOf:
       - enum:
-          - fsl,imx8qm-scu-pd
-          - fsl,imx8qxp-scu-pd
-      - const: fsl,scu-pd
+          - fsl,scu-pd
+      - items:
+          - enum:
+              - fsl,imx8qm-scu-pd
+              - fsl,imx8qxp-scu-pd
+          - const: fsl,scu-pd
 
   '#power-domain-cells':
     const: 1
-- 
2.37.1

