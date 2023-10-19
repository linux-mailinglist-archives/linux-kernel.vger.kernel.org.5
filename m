Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F007CF7F8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbjJSMD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345626AbjJSMDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:03:01 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7401D7E;
        Thu, 19 Oct 2023 05:02:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeSCWbi0Vyv9qvv7nmGDL4bu3vg2HUdNpWj8cC5vyHBjH1tNz2c5w3cu3b2UMEMZ8OfLUtXjRKJvp1MKNeYopl/SC9/EYbpbMGOHrPb112/TGmtAtlKflLgOW3/xdsNQagF8o7sqh9H57Vv1dA886sOaaZGMsNE+SixrlSJVVtimKinwCRKk4+DKiNNFo51l940L21624H+T582ALRKh+ehEJ86+d/kAttJQoBw2qXdwa7plZZ6CERGF0d+/pvgg8PHXcKxa49Eg1MaU5B01O76vztklFkZ/iN2+GyyPIJEY494tsRdNPz1daFombjc5CCzSCMpXFHNerFuyNwLQ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVTjvywGyE+WahoRPuXm2GE9qSgNqGXev8RZwK3DWtw=;
 b=cS+2qBz2Wp0pqQmOzpkrIgqoo+VF8cvHIV0dwACuKleTjTguArqFto0l2zfIAppQKdPChaViGJgf1zuPyMjVsjT6hrEdrOfZ4A2VROX0HhOjqWDqZwCojwhzmcOINW9ysNLLtPFhipwknP/nQkNYwnylHJa7ZVeDvMVO1KdsYrsdq2sjPjvAn6OewDsylnrwAFzmaI+hmC5MYdnUA4a46zEXiZxjMyPCCVXdlxqnswDWmG0ghLuq4SawDBx2kHn1a7wk3Rwh86LoNBCm7BirzMdp8zrboIhYeeWaUK0z43ZodcbyZHJ6Wj9HoJkwb5U9s0CbskOtWWZqTwjYFWEKvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVTjvywGyE+WahoRPuXm2GE9qSgNqGXev8RZwK3DWtw=;
 b=R51RL0THC2UrIvM2rmc4enZE3shGVSLUaOh9j4Zn5gnB26y/BYVRGCs1AoJPqNhde6tadfpr5htX3VZIYK0wMFaAGs3e2jjfsL5N/dzfBRhIqv4wL71LhZhvyufjfAy6HFjlQy1tOHidoYCkueKF65IACD56kgBk/8W+pFdzhZo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 12:02:53 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 12:02:53 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v7 1/7] net: macsec: move sci_to_cpu to macsec header
Date:   Thu, 19 Oct 2023 15:02:03 +0300
Message-Id: <20231019120209.290480-2-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
References: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: d60bfeff-ce7e-402f-9ea6-08dbd09b530e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wzwu0iujySulF5dAvd79EIGooPsfOMwGJUnfrB12Sj/ab4viLPNRxGZLOwlP2Xs8vBvVvFbuhnljtU++knabQIW14Y4niU6qnFrJQ5wUhMr8kFE5bPZnpAXtH3v35rQFDkgWTF/Uyph8R71ltgt45iz552/tR2h/1P/siIMcW68uP8PrNq0S08DM+rEaQlNsw4SE8UKu528wv3mVz1lwzeFixT5o405QBQ1YEQjHPUVO+Q1w6SUj1F579E12hM+V6QItGj56MCP3A1gVOgcSZp7CgY2hrLcldF9FOaveubVgY4Uq8gn6aA/KJjhdAdYAt9Pn8ET9s0LBhXZygFqBBhBu62fSB/A0gef2oXElOWLkA94hLOc18EvgIYDRHLYKzE2TPlFic3vaQeBENVF7tgAZbtjfjCAEo++St94Vy2gQV7OEN5DNe9Jb0bDSUSNKLDys++QIwBwYoAOCLpqs1OqdeYlvh1/N8ZjTlGhG1am6tSi9GRTFWQGwgbMcpCLItqFA42MHyK/gBuZkHBBM2qF16RMfpz0i8qIrGv01Ojp8eKIe/dHSPHEcz3P+JTNCrJImN3rn6F3Pb/8oN2hMZsm22OZ9ZlzrHwUpxUsVnwRIxU1z2hQYWJHNKNhX32b5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38350700005)(41300700001)(6506007)(38100700002)(4326008)(8676002)(2906002)(7416002)(86362001)(83380400001)(1076003)(26005)(6512007)(2616005)(52116002)(5660300002)(6486002)(6666004)(478600001)(8936002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z5alaXonu19BknTzB+Kzp2OAuqLgsN83InRON7eKG57Lr7TVqBEUgUBFexVZ?=
 =?us-ascii?Q?05/wohG1HcNdMjaOqRrz7PRc6m70TZX6iWTFh9ASsplC2bczXUppAwckyzTz?=
 =?us-ascii?Q?XkcO5OAN6xE4HpVLW3JtMnarCL6uTvlMlFFG1e5tseLxTuu7/coK8/piogpu?=
 =?us-ascii?Q?xxO8c8syy83zMNj2fEkBMqGQdldOiHNhLjRHMvyHOIm6BoX8q4xjYWFO/y45?=
 =?us-ascii?Q?CqAlTIu0uYASFR/JhVm7vTZcCKqD9QE9/Fta5OIvJIZSQJMik2qWZtphj2Ae?=
 =?us-ascii?Q?SIY+wkd100R7Crh0luEmX3PbGlIxNifkK2Xa4RHYhcdtam+JolQKbu7fPSzl?=
 =?us-ascii?Q?cBMFFNN1nWmD5Pj62Wb2VovttZAx+INuPBcn8JGArX1MMNd/ZAuaeZdHOE3N?=
 =?us-ascii?Q?qOiYJhij37h60MbCXCdB7DQdW3PbEzC4F388aGoPTqdYAHcuFhncLPUVkTbO?=
 =?us-ascii?Q?uxaGes7bczRmbzyn2EWylMb+UO98C4S2es060edGugcL8pXiD4ZZDTYjtzJ1?=
 =?us-ascii?Q?HzJOl1sglGa4/6UD0RcKlzaVfSWE2O5avJ+jjow1EwcMvqaHBKOhFLPLzOSE?=
 =?us-ascii?Q?8LgDqdELhEBseFR1gYuM9ESqRBFe1opgXENuervCPSQK99riztdbB5RscxdV?=
 =?us-ascii?Q?/5N+/8g2ba0X7DvGP51I7P4uU6cW88XjqWEWzCwSYO6qq8A5C56s4uil7qv2?=
 =?us-ascii?Q?jCsIv2OBI/4NuWPoS3h+fib0F8CKE6lT5T6zw4yndtl2iE1BcPHfrPL1M4F2?=
 =?us-ascii?Q?qw+vC3PQPskrSUOL85an24aKd5GxBOLD0enOAptn6tvR/l/XNE1att/jIFt+?=
 =?us-ascii?Q?8LUNSPLIVZ5fwGmW4jvMSlPke0n8/Doo5immb6Zf32+P3S50YR67DqX0+S6b?=
 =?us-ascii?Q?ea9Wvu7iQQBUCYK3Hoo9cO43bBoTXDGlWJHcH5Rc3oy+lYh7+0TJMXquKkGe?=
 =?us-ascii?Q?QrEh/+y/jWWXMkLtP5uoF3Vh9tmbdVcVxn0NLadS4SnJALC/TtvBEAFmz1eb?=
 =?us-ascii?Q?t4XjEdZSNQzsGIgarxutv+Qs4E0AbZlkiwLYFJBfi4xlY4eaTHqBToOLqhsF?=
 =?us-ascii?Q?d1ZP8E7f8ttiT42HWKtkGufukgRAD0sc4TCT2Cx9l31tb3aYdpQintl7lPnX?=
 =?us-ascii?Q?tF6Lh7U3PueZlGpSPmiVbYd274IU/sultHMg56IZzkXc3jEy5Nny7yIMM5Vr?=
 =?us-ascii?Q?W/D5gdHfq4R3j5BESHMgXfNmywCUbkWJam4xs4tRatme9d83uc+ZsGf+I+EY?=
 =?us-ascii?Q?TetsEt1sTZfl6P+rdms2Qdw5TRVEtyVCcxTR73Cv13YSnZhfnCprpoWOeiB6?=
 =?us-ascii?Q?4tSo68WcNja3PfrfNg4yhpl5fYoM3tDSfKgbORbcROTimowiK/ZksSPBWyHP?=
 =?us-ascii?Q?cpvmmW9CmseIKqpRsXes0BOyLrxwtQ5F7cS7uFZ51laYWYFMOIx1CTzm+OtT?=
 =?us-ascii?Q?b09ghIAU4mQd3eID2GiuEEKI3HRTXgDGSfOxF/XUn7B59CA6WpE8xBWzAhdJ?=
 =?us-ascii?Q?KPV5K+cOjTOx0VrHUqHrMVS6PL0xhtHxar4nU6ablLpolmH4xJJdQuY7vWzz?=
 =?us-ascii?Q?ezjv2ephu2Wo75auXWCjub/rv8Bjv/yzLjsoxk1k6dDRfTMiSHXUy1eNH48P?=
 =?us-ascii?Q?3A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60bfeff-ce7e-402f-9ea6-08dbd09b530e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:02:53.6818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/MERyQpUjbQDVfnwvJmiwZNiEa/H1GviJPTUvynd4L1N9nOGzhjzZeWVBO3386WhNVA48OG/4/N0AW1ap6wsKReXH9f79vlWCCusdvygD8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move sci_to_cpu to the MACsec header to use it in drivers.

Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
---
Changes in v4-v7:
- none

Changes in v3:
- patch added in v3

 drivers/net/netdevsim/macsec.c | 5 -----
 include/net/macsec.h           | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netdevsim/macsec.c b/drivers/net/netdevsim/macsec.c
index 0d5f50430dd3..aa007b1e4b78 100644
--- a/drivers/net/netdevsim/macsec.c
+++ b/drivers/net/netdevsim/macsec.c
@@ -3,11 +3,6 @@
 #include <net/macsec.h>
 #include "netdevsim.h"
 
-static inline u64 sci_to_cpu(sci_t sci)
-{
-	return be64_to_cpu((__force __be64)sci);
-}
-
 static int nsim_macsec_find_secy(struct netdevsim *ns, sci_t sci)
 {
 	int i;
diff --git a/include/net/macsec.h b/include/net/macsec.h
index ebf9bc54036a..a5665e9623f2 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -325,4 +325,9 @@ static inline void *macsec_netdev_priv(const struct net_device *dev)
 	return netdev_priv(dev);
 }
 
+static inline u64 sci_to_cpu(sci_t sci)
+{
+	return be64_to_cpu((__force __be64)sci);
+}
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.34.1

