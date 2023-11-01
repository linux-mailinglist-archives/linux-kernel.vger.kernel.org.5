Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE0C7DDAF5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 03:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343872AbjKACZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 22:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjKACZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 22:25:26 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5A3DA
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 19:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehr2fbPtwqiYIOZ0MA7Gnc4lVPxjGbYHoALvfbVxuP4W+1yskLXnzX2x7l3obRzz6rgSLAG1zcupmM/+v5rDzRRm/6l0M4WuulqQ2KWjqEoX7sUTYKoEXfksd/oH24ssV+kEYIh9TcuB4jcRbYGuSC5zLT3BMSyk4Iv6QjlCQ+KGks99vw9DUu7sRPOOYQUS4U5pXNkKWNztzWNov7Gzn4dyQVHJFe8kUOG0HQpvM0cPV04nqM+RhFzURh3i4OBaWOhZp74xV+/VVJ999dcJXDcqm5jpDCW7zFRlTGXMViO7caQd8k7f7QpieM+gsPY9oW25FcVooa/lblc+H3iZdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uzazwkcs/XZboL2eH0QdXRwHkUV04C+9y689HakhubI=;
 b=b4PfOah9MyETvMz8sQROImWT2mfPv95Q5d2PJMe3SGRrDfajvxM7ZElawOJVC6D+3ljIF0FnztX5s9oX2thGCDiSTRFh/rJxE2cIWgLiiORxOwGCwcrauWsDB0leCjmBcqlAQ9sJhguofKZUJ+YZYEOguE5erscqftCSCr+fkS14g78mcVTXv86UR4c9Yf3pBH42FHhzOIG95amsl47iGY5+RPFA3yoETcrofL2RQl6BOg20th/OArTE3evl2mQ3BV/SGcxam9NCYaGf0rYDC4EvvNwUttJDudH7m/jvK+nKmJAuhtbNvQ/j4chlFYYpsrzqw69W7Bpdxoxb3ta/WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dm.renesas.com; dmarc=pass action=none
 header.from=dm.renesas.com; dkim=pass header.d=dm.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dm.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uzazwkcs/XZboL2eH0QdXRwHkUV04C+9y689HakhubI=;
 b=U3NKxgcdR+TTFtLdS/w8OeTzv/RaaSyxWPnhaLIIwChHdikiwbI06iJca137X7F9KoOQCnQbZ1jRQNXf9qiksFdEv+7WwL2ldyZ4JnPK/G0x830EFgN5xZ1uNPn6DvFtmWrQYVPuxGQkpzyM5DkgUV2O4c0J1bQcRuqZaBTOgts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=dm.renesas.com;
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com (2603:1096:604:10b::11)
 by TYAPR01MB6105.jpnprd01.prod.outlook.com (2603:1096:402:37::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Wed, 1 Nov
 2023 02:25:15 +0000
Received: from OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9d30:9f0:11e7:48f7]) by OS3PR01MB6641.jpnprd01.prod.outlook.com
 ([fe80::9d30:9f0:11e7:48f7%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 02:25:15 +0000
From:   David Rau <David.Rau.opensource@dm.renesas.com>
To:     broonie@kernel.org
Cc:     support.opensource@diasemi.com, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, dmaluka@google.com,
        David Rau <David.Rau.opensource@dm.renesas.com>
Subject: [PATCH] ASoC: da7219: Improve system suspend and resume handling
Date:   Wed,  1 Nov 2023 10:25:07 +0800
Message-Id: <20231101022507.6226-1-David.Rau.opensource@dm.renesas.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TY2PR06CA0032.apcprd06.prod.outlook.com
 (2603:1096:404:2e::20) To OS3PR01MB6641.jpnprd01.prod.outlook.com
 (2603:1096:604:10b::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PR01MB6641:EE_|TYAPR01MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec749ba-2464-41f4-a72a-08dbda81c87f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sha1N3y0v3kSNzhj9VnWRt9zR2bYnnEjOBkCQCHFD90PU0VANXqwXAxT880YstPUDZpHmLxlwqM9qebtP+D3oK3HXOVpLnVqNzNBoEFkemZ4+Mq3Otu77Tg08cL6UTTgkN3QWdBjnveSgJEO8z36XhzvBoR4TNZN8PFvVPV5f7o45EWpUwm22Ki7tCpbvUoCjxI8cVvTvt+EWiNNkSSF6jGzzOhE5sp6iFNQ8XlcQ/VXG5ox4EGOUZCweGwNz+2jba5ukic4iqkROAl5F3/tf+MY5/Mfphr98eNwlaSTDQjmOb7B9opwJ4frYjMSUfpIKyiw+6dq9LWs1Sb8F8izXTXK0/v86OpIa7XnpQ/mzbFrtTaLolH4jsOrjCKXgxqyH7SLVCuo+ucX7l0pyPSwAG1of8uo3z8Qxu2XXL1laUY55KcT4Ydp3jsmN+ETPfU7IrlM+WrNtCx8uQW2uR3FAxe67rWdmOVwXpQfgNl/kxlJb/c3zarTio8CRebEuqXUpIaakkh1fqvgP1OnmH/iCmwVsLKGAMnwjgTdJnx4znOE7Ax1K7A9/ZWfdG+KFQ3OdS1BIWFgvuO6ERl+XC7RjTaJFKjjh8r4jG8AWc0UCuGIe2lIKs7d9fuoMcpA8a6Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6641.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(103116003)(86362001)(41300700001)(8676002)(5660300002)(2906002)(15650500001)(8936002)(4326008)(83380400001)(107886003)(2616005)(6512007)(6486002)(1076003)(6506007)(6666004)(52116002)(66556008)(478600001)(26005)(38350700005)(38100700002)(66476007)(66946007)(316002)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wE5DveJ8XyAHzh2ni5Ge7q11n45I9LcA1167ACxHdIOSyFKI8nMgaMgcJJMJ?=
 =?us-ascii?Q?3yMrQQp022t1PJO4DneuZOrqD8q7pqNBZALAgfsnzCSzuqEC/gYxD9ID7u2J?=
 =?us-ascii?Q?Wn8pwFmWk8qYztGIeiFRNue+17DEmzSSoc2SuhV8LXy5r8Vi/cqGM+FogNor?=
 =?us-ascii?Q?Ifsls87bEo5UXeU1oP78ClJRFbuVThH1/p49YjM6W0Qdd9ho1YpRPqpMHGKM?=
 =?us-ascii?Q?Zl32e+GGyC+QxoWanNFj9IymigvGu5n1uQUPuP4Nn+ULCJ408ZhiHCQwBab2?=
 =?us-ascii?Q?Qfixu1besnVX8Y66ui+AQbKRtuylkJ2HxVyBKvt3SeziZ3DG2L0NayB2olCl?=
 =?us-ascii?Q?zOO5dqbozZgL4Eg6j4LTzslJXzxWVxwpUsgJl89Ig/rJRLutmyDcQdM7AJq5?=
 =?us-ascii?Q?80eAJ0ZCHax5VC+FnzAhxMN5sGNNtVP9GrQqf1qyWmvedjmiME6LYM0RZQCB?=
 =?us-ascii?Q?DlXiqM9hpl1KJXJpG8VU20l/zX7lz0iIILg0XZxjdS51sXI5eqwrcQQlPFM7?=
 =?us-ascii?Q?ETyoB7XSprFHpeqcP4hRjuZRxrr3adbW1yLCxT1BCAENXSplxgW1y603X6PR?=
 =?us-ascii?Q?jANJAFNEmIh3DMy7IBhvKqrnWE/GZXPTgiDzRbkWNSYKhcAiIPVDyuYQtoDr?=
 =?us-ascii?Q?GhPz9TUo+YGz+CGzT6kCm7IwWcETRI5Kf/RmsK8EtJKfNhOjykc4BHwlfHxe?=
 =?us-ascii?Q?AlnUJViaiVnO6BgnlNVgnrYFZl2Ej5jnsSmCPcULuUtt36MdLJzPL6Pi5i6r?=
 =?us-ascii?Q?kxnSYmpTcytGaYaKK+qJE4YqSCm2g0FktQoFnd67io3IFrzi7qcdmQ2UnWki?=
 =?us-ascii?Q?xDBlj5PJbXLg4XD0YLa1NZ2i1HAHZ7CEWEIHsGaguB7xzxIDh95wMKllX1Nm?=
 =?us-ascii?Q?O+yzka78xvh6x2aGYg3SQeWj5DaKtb2C16St1uMZQXVptUsjKewB+FelJVhy?=
 =?us-ascii?Q?NIC3ir2td+Rc+fgo7xM/FUmh2e3WV1RsmQpnwZGYhR8DWHHxfVnqkLLCEvp2?=
 =?us-ascii?Q?6hKwEW1JuYEhsGvR1Z6ha1Merr+Ez78EFI1zQxNLQrPed3S+Lq2QUQpSfAIe?=
 =?us-ascii?Q?5PASnaYmnOdFETHdS3hrpEsPsg8KOAaL7hGbcz6bylktOFwsmBylc0mR2/8e?=
 =?us-ascii?Q?sk+154sK8nBpHSzbJlNYRCmwdU6mp/v949op7GVkTz2/F2a2s0m6i1H2NVO9?=
 =?us-ascii?Q?KSPzbkoY9bekJxdD7Jf8SHS7QRCrBOn7Cz4vxhc16l1tgK20q0TZNwOx20kB?=
 =?us-ascii?Q?LU0CVkt3313LnpqvD4dQ4rfAatneV4B6Al5692yz0t1HYuQG5XJ5NPasMx6F?=
 =?us-ascii?Q?fPVPIbdRpryJEmkCr3D39j6teHEpvYNS6PgZHSdolP8Fjw0TZNR9daLuuBc1?=
 =?us-ascii?Q?zFwm8zckiOucbGKJUjJOuOoCk2HIpA34zN57ewWGntfMM2BUxyXvPrRukZGX?=
 =?us-ascii?Q?p2bn4gTkSnEYkDvL6MKLswo3VSWxc0EKy1g+DC3224io325GFjaIncZnra8m?=
 =?us-ascii?Q?LVyIZEuUivPHJCoxwdxyB3dh2d+XLmTf67zNqj+R5r9JwE4GDHKUUEofJJVz?=
 =?us-ascii?Q?6gsrw9SWa6ryl7qzaRUcGZPYx0QtlLqSlHzXJy6t6TeGk8JHnb7TpT+KyQJq?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: dm.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec749ba-2464-41f4-a72a-08dbda81c87f
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6641.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 02:25:15.4960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DJgLjXtvnQHOdUEuWj0OsKg93PlYDdqLcZYty+ezMN4Zy6YmARaoTcEwGL+nymOAr3Qr0no8KmsWbL1Ck+Yh/bqFv9AjUERx72h4HMhcsXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6105
X-Spam-Status: No, score=1.0 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When DA7219 is suspended, prevent the AAD IRQ handler is unexpectedly
executed and cause the I2C driver "Transfer while suspended" failure.

Signed-off-by: David Rau <David.Rau.opensource@dm.renesas.com>
---
 sound/soc/codecs/da7219-aad.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
index 3bbe85091649..4c4405942779 100644
--- a/sound/soc/codecs/da7219-aad.c
+++ b/sound/soc/codecs/da7219-aad.c
@@ -927,10 +927,15 @@ void da7219_aad_suspend(struct snd_soc_component *component)
 	struct snd_soc_dapm_context *dapm = snd_soc_component_get_dapm(component);
 	u8 micbias_ctrl;
 
+	disable_irq(da7219_aad->irq);
+
 	if (da7219_aad->jack) {
 		/* Disable jack detection during suspend */
 		snd_soc_component_update_bits(component, DA7219_ACCDET_CONFIG_1,
 				    DA7219_ACCDET_EN_MASK, 0);
+		cancel_delayed_work_sync(&da7219_aad->jack_det_work);
+		/* Disable ground switch */
+		snd_soc_component_update_bits(component, 0xFB, 0x01, 0x00);
 
 		/*
 		 * If we have a 4-pole jack inserted, then micbias will be
@@ -947,8 +952,6 @@ void da7219_aad_suspend(struct snd_soc_component *component)
 			}
 		}
 	}
-
-	synchronize_irq(da7219_aad->irq);
 }
 
 void da7219_aad_resume(struct snd_soc_component *component)
@@ -971,6 +974,8 @@ void da7219_aad_resume(struct snd_soc_component *component)
 				    DA7219_ACCDET_EN_MASK,
 				    DA7219_ACCDET_EN_MASK);
 	}
+
+	enable_irq(da7219_aad->irq);
 }
 
 
-- 
2.17.1

