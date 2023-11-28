Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D77FB3AC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343999AbjK1ILn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:11:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjK1ILl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:11:41 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D86E98;
        Tue, 28 Nov 2023 00:11:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TCkcjKPev4BW8CJoKaOvnH4dqWVUD26hHd655VtHBC2dO/t2/Pyv0Kdmqv0KPMNZZ8ueG8Q4ZzASHkzyw8qcqSz7AzNu8HpCefiNLPXdWvKl56SUHnINi16TXoFrMeI8rcrOJH2gXA0xz0IkqYfjMlggcafB5eRWukiW03U4kP5rtHzG6gvxYvVQoqoo5kXYvmQEqX6pTf0ut7R+qm4CMbI7nQhw8Apas/PnICqYQbygfNOHuL66qFC8Q0U4Qce41MyRzVJJMZyMYAe3WLNvNu8tdYWgwothGNNd+OnK1tu81w69bB8qTRpsKi+WcmgzmGf41NOwFxwhpME94AgL8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm2FDg0t+Tna5IV6r/T026XdzCOt13LyOTVstv9GeGg=;
 b=aeha1ORHOkR08YU+dXnmf4WMqjuqPMfpbCuREzXKmH7xPCVPhdUkSjSukMwDwcA6ahn7plpIhijgFOXiP1ERTW/2U1VnHumoJtPl/tv4fpYC9JFEiCWNSvoBoGaWb+dOvIY5Pt/jKKsQKE2MkBFNCAPQC3NPLN0jwVBZ6JQ/unHXFI5xQA8tgkhVTFcMmSBeb2Q6S3xxwxOal54S7BRh9nbFB4zf/JyBv7vikfj3p6XvtVnKBTy28LNq6ggOB2Ev60lzUjtfKYMrTfRTFi9JD/kCp7XMRAoMgrn/toRbWRtTUhb3LDZdZR+KckVnCkiFx5u8CIn7igRugkg0tTLjeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm2FDg0t+Tna5IV6r/T026XdzCOt13LyOTVstv9GeGg=;
 b=A20XC7FZ3IWsIDZA5F3eJrPpInlDixoZ/EECASiQLmaLVnJttNvhLld5SymXJuHRQSVxtkMK+qmFvxyoOpMWOeixEVRGhOxAEQrCs1qQFNmnPSyrzC64qCDRfAycA/M54GMBxbfN1wUNmf/ph/eF3r/QVwD7C1wiI9JyLjQNgbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by PAXPR04MB9445.eurprd04.prod.outlook.com (2603:10a6:102:2b4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.19; Tue, 28 Nov
 2023 08:11:44 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::c688:1f14:2ab1:c78a%4]) with mapi id 15.20.7046.015; Tue, 28 Nov 2023
 08:11:44 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org, robh+dt@kernel.org
Cc:     kuninori.morimoto.gx@renesas.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        daniel.baluta@gmail.com, alsa-devel@alsa-project.org,
        iuliana.prodan@nxp.com, shengjiu.wang@nxp.com
Subject: [PATCH v4 2/2] ASoC: dt-bindings: audio-graph-port: Document new DAI link flags playback-only/capture-only
Date:   Tue, 28 Nov 2023 10:11:19 +0200
Message-Id: <20231128081119.106360-3-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
References: <20231128081119.106360-1-daniel.baluta@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0084.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:78::11) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5151:EE_|PAXPR04MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: 0355fa44-7b9b-4593-13e7-08dbefe9a5de
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GO/uLctfVmBsBXnSk//dOglC0wGJtb4LY7MZYjqeWMOagaxZllqsoKq55sXgpPaeRrAJ226T875FNOQXc4h0Edc8d8aA7lhh8Cz4gCebMTma2L229TNV1qLL6LKrMo3PdxK2GPZuJ+ZMHgNEcRVodNPHx2hXA/pi8eF5yuhwIFgLnDkcbRXk0kSrDsgb7fPaCzEs+MuWaJP+XqWGUvY4YAF7O8WrT22b5AOYu+OONZiyCobP9cNIJnCOlBcdqIehkQfskIqUgV5wqWSjSzOTDeKcghqm3xF6r5c4yvEea9UrSzHd13ot7/VQpE0pE+erVwGwYfIH6/DjWoHwDb6nP/6/pFvb75m7LCK2ZnU3vQSy9/zT1wWSX2nZe+Nzv/QX7nTgvv0nioO+CL2CP85bIIx0bE7i2vtjF3nxOi1hRKd3DtS1TvcSluguxgmjJaf4WW7VFKpOg+Eyo308TvId/rClSFH2gl5v0KtElZE00o2/h0v3di4Q/sWgLrVJbhd7KLpZ/wrkLPHzN1sUlNbWT9ocKP1vHtIkOWUa9uwf/rGwqJyDOeL25oLFV4z402ayna+pAS2iXG6Okhp5YTfV5QlF0wbykOxJrfPPtaXXrJLtvK+l8o1o3kWw1zJTiXD2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38100700002)(2013699003)(86362001)(316002)(66946007)(66476007)(6486002)(66556008)(478600001)(41300700001)(4326008)(5660300002)(44832011)(8676002)(8936002)(2906002)(1076003)(2616005)(6666004)(6506007)(52116002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OvsJ/77dhZtYbGVk7S+kvMLpjAafmz4gH3bmbUJ3NWLPjMP3B/90nh+bYQql?=
 =?us-ascii?Q?bxiOxC3QOs6LwR1yJUma3lMXf7uDbyG+e5KD5n0+KzC8mCfw6DdCBtDN6g+A?=
 =?us-ascii?Q?DIVzx7E6j67rQna/dZujyHDl6Sdo9Rwfv1dOFDGCC7WtFMTgmkSlPieDDxJR?=
 =?us-ascii?Q?WDcTdzGnr9XhibVrSpHVxomWMsVvaxFtiugV68kWDNLrj6gZMyuzwN1zEu4G?=
 =?us-ascii?Q?R+DzJX6cOVx4udNcdTHmLVcGOxKcZdDen4BDsBzRlGXJKLR3QA44sPV7jX8s?=
 =?us-ascii?Q?VHo7JGca9Y+MxKgs2NwPvjEtVGxZ6wMCtlZ9DODHNUIORzat4dkUOM/IKiwN?=
 =?us-ascii?Q?HZxSPMfJ7r0rhphKM5hEO3fOHMC+DKcciUzcNi+RcaAht2V+dxhaUEU/98my?=
 =?us-ascii?Q?mXAkEjotsxYkEfHs7MfAXZwQufw17yBFaT3k24QNkjwsUI/rHPAuSWGmIQ0y?=
 =?us-ascii?Q?Yukg2C1kA67Wc0oSoWBsJKmEDXM1caNqGS+AontJV49MFg66pGuVy3FrH0tt?=
 =?us-ascii?Q?LxdVUdSxZl2Rzp7M5e/VYt/aOYEYnVzOYTTePYsT06dxFx70dpgRJ9Si5jeb?=
 =?us-ascii?Q?SvboxwvF3zoRR4rSAPpZKUzYb4TO4O9MhrzYMGNIvCB6u+F3Ss3XurJXf65F?=
 =?us-ascii?Q?qV0frxEsKYPyS/w4vYpKH0MivQF7/lmCMQS2QcxrS+X58fdSq27u7mwrMHe0?=
 =?us-ascii?Q?OhqkI6FqOxSLFpgblMsk//UD3V8bIVLvrTbZyiXI6UkutkVhcE6eh/b/Jnun?=
 =?us-ascii?Q?YON4UiWlKYzYim2XTWfBhx+KgTNHURiRGY/xrcE2KtZ/bgpCrRQq4DfGcLkN?=
 =?us-ascii?Q?a9CCw6JbO7+mWxR8ZhxwflaZUuda3S+0ilYGXjcIoIYWm8ghtbsIjarcL8Jt?=
 =?us-ascii?Q?kstwa5pxiIivTw9M+tXi9RNxZQA/Kj2Ks48gUMq+7XwZ0I4MnzJdlJ5a6fPY?=
 =?us-ascii?Q?VT7TWqNXi/XUo/uG75O1mJh5OMQdrorBv2WxyV20wlSxGbcs8zF2mJ1pH5wR?=
 =?us-ascii?Q?pNmKI4ZbdXlH6vjUvPF7Yv6CYaI2n7j0lsRU1ugzFCqbtf8nIb5tpP8tMAb6?=
 =?us-ascii?Q?bLg7xbBZFL/PEA3vJPGa7XLnNzD+2ZibQi3akaWnJ12yDSETy+1m0jPRCqYi?=
 =?us-ascii?Q?gofxeE0Vqxa4+sTHNeOllytvfcR0szt47VKJ4zvpipjF4bZ7IZ1cw3pZzRwe?=
 =?us-ascii?Q?kuMK7jjjDS5vOinyxTzswXd8NqB27tFijd5glqqAqvcNTPpmKzmCN+JRpYf6?=
 =?us-ascii?Q?lt5Nx17rHVzLvCr8MumbPb6w6RsUiFscIC64i0AA+IFx5muI1R5eQa3uEeLr?=
 =?us-ascii?Q?V43sVKwP3wLDonCTZRRLDqrdLn8u6t18MRQjzLhsa7QZFxEMNCpznoheUrrf?=
 =?us-ascii?Q?CErcKuq+/rRXTV8dhWWLPQM4rB3d+ATy7d+xaZejuoTsayk0fNA2rXCltsnU?=
 =?us-ascii?Q?uMTsU51Ry7egT3QpKycDYBKusEefCCI6khgpT9USCrosqLNOr8Fp9+l5akKS?=
 =?us-ascii?Q?jR91S+3u/MwRiS1B9tTyIyaqvBoipP7vxYtM9ZUeHx7Qa0H8JmutmpZOFw50?=
 =?us-ascii?Q?nGbWUEo89+XQRuennCMFAFteRoR0MNZEqVoxwJlONaNK6D//nInQrJ7Sf2KQ?=
 =?us-ascii?Q?ccQhogZFDWSftWACaMa5ffwrRA2+ihC6YAbwCqNLSSGII0RtkhkeJoG21Vis?=
 =?us-ascii?Q?yJA+aw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0355fa44-7b9b-4593-13e7-08dbefe9a5de
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 08:11:39.5102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71OWlyU62xDp7gJDlfzUdnhgqE861WQoq8WpTC0DfMfl/kPQcEKgizbPY9VA3RorxUkOlcGV8USe5icO9gVKiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9445
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

