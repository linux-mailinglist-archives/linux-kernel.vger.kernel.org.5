Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB91779FEF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 14:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233016AbjHLMT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 08:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjHLMT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:19:27 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2081.outbound.protection.outlook.com [40.107.104.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27FB3130;
        Sat, 12 Aug 2023 05:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9l4tWil7ykJlumI4Cu1pAqojwFVtxf9b0HALqPeFWX3aUlO5b5j36GuIlELJt55kilUHsV0dVAE2prrCxkUW+K8boLzvKuD1iH/9HMniGOpj2GUbwaovD8UdiyUaato0eRLeEtsaIg3EgiRzqMxzy1iiGbfPM9BhtMqrr+fmx/aaphQ1kaKjKePQRusV57KuvSboggAnR5slTr+Q8A79CzYUdGWcmuGpj3skjqQwHrGo6pKYn7P1CnGdKLRGbGensGmUmk+JTYqcWM2P83lBaBHmnMwcwweFUZsCAMQvf1XCQc41ijcBleOVcPRzVelkyYuO/DzNF2TBrBzajaNNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZhLgDWLm3HDYaFSSecNn6WyNKePkx9aonM2VRAezEk=;
 b=IUHLksR4qNAEiE6MoY9RU8QtZ7PRmpBF/9oeMx94wgFeCd4DF2iShQgGvfR14+53S4UqMdeFng5y4O2eH4JP4Ycq7SEAlj3RDUFt+CQUBTc6+6jXkFYDQh6GH3c1ifLh0PpodhIkcJNluWwsaunE7bAwYu5+OizJMZuJMYxgiw5EJ2rx2ScrtlRd2xLjpPr3WYF3NuT83Q2q/xLjD+SHopTbi4yivoAJgGdBEU5BMHLfPj1XUfW1fztaRDoisoAFpXktyU/LnrRj3OF2c92/U0Bnfx4Z4A1ByRGEOva9XrpNzJx0bll76RLx+JGiKRBwJsGnNvWaY6f3YOPebmaLeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZhLgDWLm3HDYaFSSecNn6WyNKePkx9aonM2VRAezEk=;
 b=lLrHrK5Hvjo4uht1i+cSeCpg7o6hN+/8UJtdQPI9clvQvyRrBL0+jVcmrFPmhauP/eIf/kbh2p/NDsz8gdOMICmQId0lmpYWy3O67kNh6QvfFO9DKS64RKdrcel/hxL0Ac3Yi8ZBCSNjSl4cX+MPCih7vWNAL8kzB89AkEg/Bz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DUZPR04MB9846.eurprd04.prod.outlook.com (2603:10a6:10:4db::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Sat, 12 Aug
 2023 12:19:27 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6652.025; Sat, 12 Aug 2023
 12:19:27 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, frowand.list@gmail.com,
        andriy.shevchenko@linux.intel.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] of/platform: increase refcount of fwnode
Date:   Sat, 12 Aug 2023 20:24:11 +0800
Message-Id: <20230812122411.3410399-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0179.apcprd04.prod.outlook.com
 (2603:1096:4:14::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DUZPR04MB9846:EE_
X-MS-Office365-Filtering-Correlation-Id: f1170313-a393-4404-cd01-08db9b2e5f34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 87/yi7+h5MO1ZlPt9+wUh4O4MuthfBb94v289LGMY8JSfjOrVcaYVzfgvESy8K/N48vO38CszOroaNYV4VJqULGC+Tp0HoxMHGnth5FJntc/fllZ5YNYkpPB7DhM0PvSoKQ64tVVJQth8TBGEFFzXEzj7CQkVjhq5twr2QYkiGJCSTzItgbUYd1Cj2pGPvTFIVzxbfYlhK73HGmy4FR356gH4IhUp0ZQxTAGJiBXoFwgJutBcd4IkCPPDrZxHxWxpwGlmc3vbLNb6dbLW8AABokIXMLPzYyH1JD+6MRzJFllQTMQEQIGZEUNBKMx+iikNQJceK3DKG1UviBbTQYCUQP97jZNGW1BR8LqGm2Yu5kCMT7DMKibhEapM1DRtK9RsIqYooBm4HCdrofqf8Q24wLp5ST9hWmS9LUp2Yhyy7mfwzCyqo6YQGuIjNNMCfd2/uuWeWfjjLRGPVvJ+/olbrq2jcrnYwOYDwg33dGmGMgePKPioYRRES3nrybfHuGkubtpaT/FAYa2fMG/JKoj/yLL/4CISUJl6vECZBbEcbrjITdPNpIJw/tPdSeVFrnM6JKuU+jvDk7G3piA4X9b8gsgNdV7D+npYZbuC0L4049ZPPEQDIsbdmvfAQHS05er
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199021)(1800799006)(186006)(4326008)(41300700001)(8936002)(8676002)(316002)(5660300002)(83380400001)(86362001)(2906002)(6486002)(2616005)(1076003)(6506007)(26005)(52116002)(6666004)(6512007)(66476007)(66556008)(66946007)(38100700002)(478600001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4XFz+XRS4B8Q/hV2mmib7nbssOSYQnBgn+Vweju0wFHzNKKdkW/KeEWcCUoi?=
 =?us-ascii?Q?r9c5+tLoYy3LTAGBs7xyNCkZek2ous4InQCcLeYM4/1BsAI+BEqHB1GgxF8s?=
 =?us-ascii?Q?TaSFwOXVJd8I1D9u8eDhKfdhhKHe7dhUV4/raVI7mU2Xs3fmJROMwhIYwfn+?=
 =?us-ascii?Q?yC8RbfuuFB4YCsbiy5Vjq68PxiBxbFmgRu9azwgBW+LJz41oPjrac6OUUZYG?=
 =?us-ascii?Q?6cOQNSKc7xU0JMdkO5MMhmXbJqODDZ5X7eH7oRZvRoV5dkwZZgyvb9qF3wFI?=
 =?us-ascii?Q?z29KkmOeDE0+1SNPUTcGqtcRVG+U86ki+vcoBzuGjMlCMxAg7Ufl0BldujMs?=
 =?us-ascii?Q?yfjNAxo1+cHvQ6VBABYSisS7VVkkzRLLUfRo/m2TqKzDl17UNUg2fxoxmCXj?=
 =?us-ascii?Q?vMgHwm0jlWR+EwflfnurvlUPIFyxQt9cHOZ9aQE+LMAkF3YZdcpGUkhpDBni?=
 =?us-ascii?Q?gtr+UOIkiu7hGSwqHarzo5y3EvRnv2BDFxXj172ICFApG7Fwm6M+MU0A/RO3?=
 =?us-ascii?Q?7G/K966VRZiCifGUPiKhMHrSOapZyhb5NgQYwt/dwEEAwkrYYrtQRCEABFrT?=
 =?us-ascii?Q?gJpdSopRvaNAIE3adXKQ8ucaIWdFK58POoMug76UwIODKOLjb5RZdM+nJRxe?=
 =?us-ascii?Q?U7VR9YgQ26TeBrQrpravGkxuAF0xU6YOQDHkyhczzfmSLmatmWF+pH0fGvAj?=
 =?us-ascii?Q?IjsWRfuB6R77oaMBsPMTYzdML6XD+9gEH7S257il9n3sz1FBu7eCmrwkZjo5?=
 =?us-ascii?Q?VxS/J359JT4sAOSOaV9dcQyYNLYpAUyxIkaN8Cl86Z40Pi+oe4Ec+F+GUVxj?=
 =?us-ascii?Q?XHKL3dn3dW8ubucYoA2t+LlgbJ9EfGlLrHGaIvG4N9+Ex0INvUngT0a1wd4h?=
 =?us-ascii?Q?QHfRk4oPrPQQbzWPTTNajqUws54QpXUoxCDWFgZnQVo2mkZXKOvd08vou09n?=
 =?us-ascii?Q?Ka0busZ/ZALtgxVVT6guTeWUBj1KLYsXSI09wyb5w0nL2ZxORBuzpBtZ3T+c?=
 =?us-ascii?Q?PGbXV4Y4xVfLZJOlpRNXbKeLs9kxPh4ZWdZ6pcC91xg6tgNZZY4PVls2/g7j?=
 =?us-ascii?Q?Utq2AKGMHVt8o63hkd4LWXb2baY2B151IBGoPQJ7wK7ZRwJEGI8ubASCsBkv?=
 =?us-ascii?Q?BGcKkcyw4iofvU2uSDYebITNkTBn4736c8U5DlNPb2m0R8ddLhxdgFGCOkhf?=
 =?us-ascii?Q?GnOHktz/yUlV/ELV9a/Kq2BlAQ29pTs1O3PCViUlnNpBwGlm9GjsiKtEZNw7?=
 =?us-ascii?Q?3Jz0AniloPG8KDr1nc0YycIBldfgUv5/kyTS/y+3EDrJahmnVI/xkh+7eUfq?=
 =?us-ascii?Q?jXnYMyrnYN5Arqnq4KiieR4/Fou5avsXHdukeqOQ/8+csLtSiLRETOmV01JR?=
 =?us-ascii?Q?zv3GJ4ez4QQbN/+AN1ssPuqfsWabcf8gPUXyNQwOjY5WuOR/+IFMXMf2/pV4?=
 =?us-ascii?Q?RbT3bOVFBCBpHHVArO00DZjt3GifUIeQ5vha0xH9uhm2hUILnjDYthpOBO2u?=
 =?us-ascii?Q?BJjA2ocIc92FNGYcS4ncEUJQrOYjTnvIuW7fgb4o3gafR5/Efkg7TX5bg5tF?=
 =?us-ascii?Q?ahp68MPMgYEq83lBOlmObpNIJaGAb99U9iAK4A47?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1170313-a393-4404-cd01-08db9b2e5f34
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 12:19:27.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JXZqIzxifcnWUVRpnrfGVjbfF6+8yU519HEzR2jDphsvm+xVyGVi9S7HCBgPGI31tcWcMo+gHgjr7cY9zgJfqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9846
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

commit 0f8e5651095b
("of/platform: Propagate firmware node by calling device_set_node()")
use of_fwnode_handle to replace of_node_get, which introduces a side
effect that the refcount is not increased. Then the out of tree
jailhouse hypervisor enable/disable test will trigger kernel dump in
of_overlay_remove, with the following sequence
"
   of_changeset_revert(&overlay_changeset);
   of_changeset_destroy(&overlay_changeset);
   of_overlay_remove(&overlay_id);
"

So increase the refcount to avoid issues.

Fixes: 0f8e5651095b ("of/platform: Propagate firmware node by calling device_set_node()")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/of/platform.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 0c3475e7d2ff..4659ff5a79c8 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -113,6 +113,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 				  const char *bus_id,
 				  struct device *parent)
 {
+	struct fwnode_handle *fwnode = of_fwnode_handle(np);
 	struct platform_device *dev;
 	int rc, i, num_reg = 0;
 	struct resource *res;
@@ -141,7 +142,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(np));
+	device_set_node(&dev->dev, fwnode_handle_get(fwnode));
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
@@ -221,6 +222,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 						 void *platform_data,
 						 struct device *parent)
 {
+	struct fwnode_handle *fwnode = of_fwnode_handle(node);
 	struct amba_device *dev;
 	int ret;
 
@@ -239,7 +241,7 @@ static struct amba_device *of_amba_device_create(struct device_node *node,
 	dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
 
 	/* setup generic device info */
-	device_set_node(&dev->dev, of_fwnode_handle(node));
+	device_set_node(&dev->dev, fwnode_handle_get(fwnode));
 	dev->dev.parent = parent ? : &platform_bus;
 	dev->dev.platform_data = platform_data;
 	if (bus_id)
-- 
2.37.1

