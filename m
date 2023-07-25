Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A91761082
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 12:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233156AbjGYKVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 06:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjGYKVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 06:21:05 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2063.outbound.protection.outlook.com [40.107.241.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFEAD3;
        Tue, 25 Jul 2023 03:21:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gGOwES4aoogS4+kflzWgmlQZjZMRuhoZdIFHYom49dg53aWiALwegRdI8J45qcsaDr1Vd82yjQZEG0FlJARFzTyDtQ075/zZH7OGyuI0wi1Jv4H5TIi6zRApFAuE3JTteFv35mao7/o6vGq0mvv4EmUcCgkFYP9NkUfkJcKF1jhC1UqzxDM/FaXv0JfGk8Ae7Ds09v8MNwYhM9SB4qZZNGu5hp/zexIqcWr7c6AxEK6CzB7wttSHCqIjWmTCpt8t7lVVzJOy86AkfaCmpz8AHm7KDF2Rmz7GvB/y6u1KnNf6V47e1s2PZL5NCrzmfoYV9r4+UESMeGrr17cVYL2/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=203aJNoSwGR31RLP+pDLUR5267/mAP/26c7qBUsdmYo=;
 b=bsDhuK+ygTxMnCkPCRp0T1v2tMs6rpq8bVqHTtJ3HkmltHQKPuE412IkqWDiKZgYUk0i7GhyBk3zen9SdUPip6eFWLdgkPsy9kveD3CO1s+bGICVmShuNwi5BrqaNHuBXUobPgo3rXNr2sfcLzxw9ld9e6jTQrr7NGdxgE0TdewcAX7rYzCkRtiJ2LO7ex4XmziWbU2UOR9TcC9XZH9lgVR84BGCrnJWw7WGITxWcX1CH9eA/8vQBEwKywZkWktd75nYaF8H2Cr2469/YopgkwA4rzJUBIkzZV7ivW/X/pCzV768qpQhxYEduoaV8jfOl/25vT2MnvVgdmigjMJL9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=203aJNoSwGR31RLP+pDLUR5267/mAP/26c7qBUsdmYo=;
 b=DcPjyBkot6V7O9fWeGl+kFuiKXJRHJ5lXKt+KMW1sUAxJ7YBaQmxo64Ts5qIiNVamBG/HDyjVdozyHBJzZjEEI35Fbb0+BInfD9VKsgLERP/8meYAiEmPaTdfL9qQ1sDo4Svsl3SVilgPz40KuXSarLQBfM7b6VZLpH0INUpddQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7534.eurprd04.prod.outlook.com (2603:10a6:102:ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 10:21:00 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5d6a:ec53:f2a8:5b97%6]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 10:21:00 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        mchehab@kernel.org, ming.qian@nxp.com
Cc:     linux-imx@nxp.com, devicetree@vger.kernel.org, conor+dt@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] dt-bindings: media: amphion,vpu: correct node name
Date:   Tue, 25 Jul 2023 18:25:45 +0800
Message-Id: <20230725102545.184916-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB7534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c4824c9-f004-4944-64fa-08db8cf8d77b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FX8ubkcQEluxAi9TjljtIiNvBmFxUJcAlTnZaAjTUme6U+gpTLEec3yFlEgfhd2hifrbemMTY6KRpZZyTvyl00XkSTLO+hYBqqcJS9eCdg8VTvhL2neyYAxv8ukiKnGL4ejH0ohlJEv0dsXtEbotKJERBkQt0hDKSUJij8PDZPXgeBhMm4K8aSyM4Gwc0h6One1e4ROCT7GPCRt774FCw0R2NAFcmHieEm2nD6NebEw+pAzKEJGg6TpZn/HBLqi4/GYE/IjhU2WqHCuChwk4k9wdn+wWo+FcL1C0a/+PUrlIJFKw5Yt5zpCtySWGmeCHlZamYiKKki/AO+jBIOJ0VPRN0cn6cRQJrhAEyo8i1oR8qrb+OCcY1M4YALkS59kSlmLtdhAN5LhUUdGbZpiJqJlnBMfrB03Tlx7Lvwmz60Y06nYUki9iFSistuI7guE4wLeMFlQcBzaEiXScOGu+dPqcWw0q7BY65JuufEdHNHcMj0tZCgUc537p8VZNUQ4BsI+i7MlVBX0pAgcBZlzbhzBRSaBsTcn7UnvQh/OQmx/oDi8N4EX3r4AZXSVg36s34Cc3OFYqp24+9BTAcgzt1ZsvShuI8f0vRppmCQAun0Ug/MjkqeA2V/QvCNguM3Iy
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(66946007)(66476007)(66556008)(6486002)(2616005)(83380400001)(86362001)(38100700002)(38350700002)(478600001)(52116002)(6512007)(26005)(186003)(1076003)(6506007)(6666004)(41300700001)(316002)(5660300002)(2906002)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H6MXP4Xy0LS7IiMBofIiprS+FIWY4R+w0g220gNz/CtqXVBFQSvSyumyNpLG?=
 =?us-ascii?Q?W6QYq867SiottW+GTg9g6vIN23upxMdrClyiVOTHRD0qibrOc2SeX4/TD5Jt?=
 =?us-ascii?Q?ZSCO6eP8SqAEYy7Xi4Bb+1gZDbj0UdizLO5oXF6c0ywOCR7bB9UO2xYQ4WHZ?=
 =?us-ascii?Q?cIxHYb4ogsnid/5wTEVltmDcTl4KlXdLB7klBtCr1omnr2fTzE/BP77OpgFp?=
 =?us-ascii?Q?LIC6UMN6gye5AywSueB2oRFsMbmfNkndliILPHvUGuToidlF4ULv/s+I5O6g?=
 =?us-ascii?Q?ptsgFq3Hkzg+BcedE/1X6viPOyOKUUYAWZ2FxVwTrhV+/UeRsz+PQ9vtdKz9?=
 =?us-ascii?Q?NTlPzMa1lMNpUL/UuzTyOJH6tzWxoMLJCmlp2G7o9MLIpA7qQ+ndn+M+2jzh?=
 =?us-ascii?Q?UQTz7p4A+eMgulFVfSEtxH2+HPdqamHhSkTKI/DDvmeKob52Anja4mWVPB40?=
 =?us-ascii?Q?uj+sJ/Apa7yJbtrdaZIygrGXo8wKaJeK8PEa2N+z6ylAlLztn7Z62xp1YGym?=
 =?us-ascii?Q?/eNJc/+hl0Lknjqxuhvx4VV2xLZ5blq2/B3+hsKoWMkgpU1FHnp8JwgT8GhY?=
 =?us-ascii?Q?3BFPHh4/7bs7mboy0dz0296uIItkXt+GH6x9w9JYq+xDqEZNQH898FJ0EcQX?=
 =?us-ascii?Q?QZ+kY25Mke5uwetQMixjbiPDevtPZhfMW3T3ZNb2Nb/6cla5tYgexLHnfRmj?=
 =?us-ascii?Q?4FCnXvS+qdsp1c4j/gpg+ychmZ8kbz4iuELfqqlqrgs0GqLhNUYEe99VGCzY?=
 =?us-ascii?Q?L8ZkTG1L0IJqw9k19UK2u7fKkYZ/yOznuvSGC+onfVik2dUbdvdQsgieoXG3?=
 =?us-ascii?Q?KFpeHpTDmsSGrp7CTyZMRh7EKu6GqEfCPBAiJe1CC5hVXOpJwzF99RajLIcw?=
 =?us-ascii?Q?5e11wQBOqumlzguRQ0eFM3SkNTVMlZQ3PGfLceekHzlGvq2ZQ9DuA1QIPua9?=
 =?us-ascii?Q?wRgqUTjIgw0tSqh1+32fZLz98iqc8678tsCJn8JYMV+6Vyt7BK09lTQNpDix?=
 =?us-ascii?Q?UooDVq6gmsiMnmv1sNFVClhxitt7LXzKvbuWrc54IgMkirpQxp8j8WCIH+Xm?=
 =?us-ascii?Q?w4wltpeUO7svaj6XX7lhiAJJkOQazt49a8UvM4Kmueaw6y+3jNi3V82Ga5aW?=
 =?us-ascii?Q?zlmwu0HAIvdpPZPSOe/luJr+uXuaQSuZA/oUxxoDoAX/+8YNzde3AO24acYy?=
 =?us-ascii?Q?06kiXqhRQ4W3wgCJg9rptvwmksOCTaz6Mz3rj88o4hBs5kxK2aGmGlVDrvfC?=
 =?us-ascii?Q?2WAhYSaXpX5MRsz6Ibqg21Jg8zPVZaxOG55Fhe/oUfEOMX+bT88x525N1Mig?=
 =?us-ascii?Q?zVEMqP1DSmX7dhYDp6CGljrb9sGz/AsDv3N8tJWYQZYYoiKMiJsIpRHU4hDY?=
 =?us-ascii?Q?RUejtRor2nYQY13hYuyjciNTw76BNTPNrm5T6ynGrAC9V4/KeuK+UgiM4Ymi?=
 =?us-ascii?Q?t8IiDHdNeLok1JFSih3gYl0NDWxkl6uHCoTVJs1Gwg8cO588OswnpQBuUvKX?=
 =?us-ascii?Q?GmQEkn5PKKzDqwIgtpDfLN1URM9NMVQw30EfZ6hrCg+U/8VMzEIYTAnQP2yT?=
 =?us-ascii?Q?zBirU5Wu+wHW6p42Fxd2Ap3z/vRbRjCbwIYwf6Ac?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c4824c9-f004-4944-64fa-08db8cf8d77b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 10:21:00.0863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f6fOWolesNwOyqvFtuQWaGZ2GjpmrT0Gg0xzx/4shdyxXwTMlyiuBXI227ID3tcI6pZssKztkjtMrz3PoAC0SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7534
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

The node name should use hyphen(-), not underscore(_).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 Documentation/devicetree/bindings/media/amphion,vpu.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/media/amphion,vpu.yaml b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
index a9d80eaeeeb6..c0d83d755239 100644
--- a/Documentation/devicetree/bindings/media/amphion,vpu.yaml
+++ b/Documentation/devicetree/bindings/media/amphion,vpu.yaml
@@ -47,7 +47,7 @@ patternProperties:
     $ref: ../mailbox/fsl,mu.yaml#
 
 
-  "^vpu_core@[0-9a-f]+$":
+  "^vpu-core@[0-9a-f]+$":
     description:
       Each core correspond a decoder or encoder, need to configure them
       separately. NXP i.MX8QM SoC has one decoder and two encoder, i.MX8QXP SoC
@@ -143,7 +143,7 @@ examples:
         power-domains = <&pd IMX_SC_R_VPU_MU_2>;
       };
 
-      vpu_core0: vpu_core@2d080000 {
+      vpu_core0: vpu-core@2d080000 {
         compatible = "nxp,imx8q-vpu-decoder";
         reg = <0x2d080000 0x10000>;
         power-domains = <&pd IMX_SC_R_VPU_DEC_0>;
@@ -154,7 +154,7 @@ examples:
         memory-region = <&decoder_boot>, <&decoder_rpc>;
       };
 
-      vpu_core1: vpu_core@2d090000 {
+      vpu_core1: vpu-core@2d090000 {
         compatible = "nxp,imx8q-vpu-encoder";
         reg = <0x2d090000 0x10000>;
         power-domains = <&pd IMX_SC_R_VPU_ENC_0>;
@@ -165,7 +165,7 @@ examples:
         memory-region = <&encoder1_boot>, <&encoder1_rpc>;
       };
 
-      vpu_core2: vpu_core@2d0a0000 {
+      vpu_core2: vpu-core@2d0a0000 {
         reg = <0x2d0a0000 0x10000>;
         compatible = "nxp,imx8q-vpu-encoder";
         power-domains = <&pd IMX_SC_R_VPU_ENC_1>;
-- 
2.37.1

