Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096477F6396
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbjKWQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbjKWQHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:07:12 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970EC10C2;
        Thu, 23 Nov 2023 08:07:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rq8x+Unnp0IYi15mT9qwLPcVQgEU6Td9SJWyoauqOZUqKcp8U8HhUzmYO17ZV0hbMxFbpIoUM78nmBF4/tRn4lOgsJcxmvuRyVnPBtE2UyVU9ocGT+mzb/dN4WY/hSoJrqJ10Ngar1i9+jghOxcr4bQBLrO8S1GIXkA0GEtfbeTSzh3ExcXyskyHQvJgvLGP31Z6Ux58oAgLBSLPsiU3qx4d26oz3Lnk/FyOEIAYCUSl2GD3qhpKJRW+LGlNA7ePFoDJXFWxvH5LEehcmcgFUWoM+bMTaJvJqxyGlH0aghPQ68ptIAswmhtVG9nRW5bqxaMX+R2hDT2A+qYHV8L9qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm2FDg0t+Tna5IV6r/T026XdzCOt13LyOTVstv9GeGg=;
 b=PfPdUsn3h5HsF0VbBxiBCt9vzlzn89M3XgySCa1VM8edKuKEGvCtnux+eIXaN+APVvbUKDauCKhCCZjomHGML2PC97orOkV3DLaUSl7psodBPJHNzoNbJP4pwKeO2Y1YBkd+cyqNQdbLPmOoN504bH+stzG3PUtMOgXalp2GCKBZecg4+fqzRUnVIZxmOPXxUGa68VEpV/Q5Jft29AjQoJRhWJ2QU7Sj7ERuQ83xIHeS4EhKHGAHBFR6B3Xvv12dHFaAMVOnizgssKJQXXsvPprf59lk/H7BY2edzuCsByg3fZp1eEsPpYK9ZrmrlIY9ukjdvSgtXt8oXghDRZ4zTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm2FDg0t+Tna5IV6r/T026XdzCOt13LyOTVstv9GeGg=;
 b=YGLyWM1FfwH6B35G6Z0pqPuWV33s4RotuUPXuj+o1BCSHOBdoemhGHbYUVeYT6JQp1Hz2nVACoroqfF3YYDazzrnOVRuGZQbOJVrSZbbIob1PMkSBsH9VY8E3wYlusfOFcMQOSxr2HT+jqgwFPkfoVJCEUeWf/pQYEs1eUW68Lg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.12; Thu, 23 Nov
 2023 16:07:16 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7025.019; Thu, 23 Nov 2023
 16:07:15 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Cc:     linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        kuninori.morimoto.gx@renesas.com, daniel.baluta@gmail.com,
        robh+dt@kernel.org, iuliana.prodan@nxp.com, shengjiu.wang@nxp.com,
        linux-imx@nxp.com
Subject: [PATCH v3 2/2] ASoC: dt-bindings: audio-graph-port: Document new DAI link flags playback-only/capture-only
Date:   Thu, 23 Nov 2023 18:06:55 +0200
Message-Id: <20231123160655.188428-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231123160655.188428-1-daniel.baluta@oss.nxp.com>
References: <20231123160655.188428-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0146.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::7) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: ab27261a-3d8c-431c-80b7-08dbec3e42d8
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nSmR/Np0XEuhSUssyP2BekUNLGFXwrKeQDkWa+54cbiTdnFoGbV2CA+M1Jpzd2VCo1O5spcP1gT/Abw4uMfE+oEINCM5z8N7i57v7ZorW3kGsros4KmQnslzHfyJxZXHg4w5sYTydh9Fg99r7Xc06XNMuoM20UAyas4PCC6j3MscyfmlTwN3YQ969t1nBvGjzjXSz70UW7ABNMLtZAge0tKERrdCrhv9vy8c6TYhNr+gcvqaO51IGxAJ8rHA74H0tJBMs4Wo91BemVrlozeRB0gawH3YvPvQK+dX83d3Vq81YPe2lslqXtK2AhVkk6QngEYFKit4DGc+htK7VK/UC+Wl/dyVzQ5g7ElUvtiDZizmLKZqXb0BhHJMWQx+SA218WNj15gm4bhiGEqtrkfve3qOlitoXCtQaV6obEvOhV+asBA97HNxchuGmL5MxBgU6IKksAHIRqf5Bx4P1AhX42pTJLlvEYmd+fqcM0wMHr9YRrKDNxgpgDm1TbSYzBo+YBqVv+0PPDdUoCh/NHKhX39ZXNRHkP7mm4OgyVs/Jhsw5FvERgFxpYNi36C4qxtqfH8VsTjzHMaOTAR2kmPjjp9y3i611RMXQi8C6QE+ZHBC04fkC1VU5Ltie0SyY3/WzqDL+5YyY9OoPriNXH3qJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(44832011)(5660300002)(38100700002)(1076003)(26005)(6666004)(6506007)(316002)(52116002)(6512007)(2616005)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(38350700005)(41300700001)(2013699003)(6486002)(478600001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3g5oI7KdzI8xW/bxkkYUuUqP3HMJ2lj/W7bkvjBQRIC96fC4Ym01USr44eoZ?=
 =?us-ascii?Q?r8sVdScE19dO/OoAOYgASUskYEolu9xSrVVcOMubUS3dhdhINsOyrVkaSAGm?=
 =?us-ascii?Q?Vq6Da2+wSZP9D49vrxuPGCSsU+sRe1V/TylRwqZAZjyb2IgrEk+2ayKGrRO2?=
 =?us-ascii?Q?vGJutLugge27DTKPRY7U3zJ4SnFTQk0BnJ6Tog/vyvBnFxiQ4t1eYxUXUBpe?=
 =?us-ascii?Q?KBEBBbtlqTw+4Z5A3Z9h5JGhNKwyybzn3cCjvd/lzgf0BwhUyJaK/pLkHBR3?=
 =?us-ascii?Q?v73OaQJm4DYudNpWd66HREKdThHSRaxvcDAY2WJBg4bNyF9OnRrEgWsY4s5i?=
 =?us-ascii?Q?BWlHeH1hZLm5cQsJQmfnBstIGRlUSjPzsFZpINMOZVPAbeT9EBHMrXC49wJT?=
 =?us-ascii?Q?rb33V+HZGlI64uEgvylh/C2QX7xheMpBsLVGmWpA1cWZPVi1KjZL8MbI750y?=
 =?us-ascii?Q?GiW9loTHQ8Ri/dFpCfvgN94hzhkIcIIRrwlRPDDy0GaXEtSnxjkbRPijjAXa?=
 =?us-ascii?Q?JSNnZ1Nzkx555TEARgsf7fXt9A52r0NMzTwcu47EWbKt4DnuCppu2cAZTkln?=
 =?us-ascii?Q?ow7ePk91p6WHH0Wuk20L8IEX6xqJBu2Ou0YEbkI15dO9OCAFwJYtpEJslrda?=
 =?us-ascii?Q?vTZo79VK7OEzNfik0wBPJHumqbqMOwfsmrAB/+/X/nwgLTrY74L7fW3RQrM9?=
 =?us-ascii?Q?Gq6o597D6pFKWMiPKkQTQyipSRM1N3L4Ku9ivFRQNPXhx4jqISfqT21oezr3?=
 =?us-ascii?Q?9IwGK8fzlkf4JqKeGeh1rwlh0x6a+CE5KfXaOH4ZKMDsRDE4TLWC5Faz1WW4?=
 =?us-ascii?Q?x8kUuB8Zo6kd4xSTYaZDEwa1Sasiy0PLp9v+2Y2zp/Mu6BzTMzqD2zJhcLHY?=
 =?us-ascii?Q?z+XSiTTSxIQGms8Lu28RbVme19WqwSpkIZ+0c/5u9wStd3bWo+0PjSd3bbH8?=
 =?us-ascii?Q?LD5YOKlV0tFSd07JMV4IAnC9TMqqZ2Q40RXB0M9pZD7a+wYtyVDz5rWBrHXw?=
 =?us-ascii?Q?q0rRrlhqvDhnx6ZBzYk5v5NkLsv5MHb6p/NVbUzxyf4TMjsY6odmtbJmYGQV?=
 =?us-ascii?Q?zn5bRJT5RKFnAajqE1ocvbZLewdagZGiu2Zg/+CEld0zqu2YDbki0f8/4KuZ?=
 =?us-ascii?Q?zJzFDtAoanbOVgYLl1RCvKZJOjwRLiWArrkEgHEdiDnTcMWTttCgwNGt89fB?=
 =?us-ascii?Q?LfpiGM9Lv1W22XYPIePtabXQD9D61gUo8FiIswV4XgVHAuN1Xhtopv6scXZM?=
 =?us-ascii?Q?LAOhhGs5pchLF/48Fh/MUkDhUmSpFiC693TBesh5HUf0FK6y1sJbz0ENF20D?=
 =?us-ascii?Q?NxrxxAc8RQEMxJ2Yla+2B93QbjRO3p1y3uGSn/xLpcHqf9j8EQpya1lvVz+R?=
 =?us-ascii?Q?7vCd8lT3tGBO+7qMe/rDUdMAEU41aWiTVdx8Q7CfishKGBVTldShBSb/2zP4?=
 =?us-ascii?Q?irP9QLZnHUZ0po3SW1qqq6YOuTPVnvQlEPnGebo1pHp7ry1FsYw2lc3cjiaX?=
 =?us-ascii?Q?w8wJqwnYHzyJsNo14B7dCxRSGqls8t7AIeWwYYjl15SdwU8mtHEUHm2k2pSu?=
 =?us-ascii?Q?wk+iIJj1hBB80aSSd2dt/ov0m231chj4/lTUFkp7?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab27261a-3d8c-431c-80b7-08dbec3e42d8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 16:07:15.9216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPpmTALa1bryTHXdj1rcazCFLwZ1iBTth8tbvPCGCxlByXm5v1MEKr/yqDMI9r8i5ToucLvd7J/T+3XbkMAKZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

Document new playback-only and capture-only flags which can be used
when dai link can only support just one direction: playback or capture
but not both.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 .../devicetree/bindings/sound/audio-graph-port.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 60b5e3fd1115..b13c08de505e 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -19,6 +19,12 @@ definitions:
     properties:
       mclk-fs:
         $ref: simple-card.yaml#/definitions/mclk-fs
+      playback-only:
+        description: port connection used only for playback
+        $ref: /schemas/types.yaml#/definitions/flag
+      capture-only:
+        description: port connection used only for capture
+        $ref: /schemas/types.yaml#/definitions/flag
 
   endpoint-base:
     allOf:
-- 
2.25.1

