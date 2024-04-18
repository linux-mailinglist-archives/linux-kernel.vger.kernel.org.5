Return-Path: <linux-kernel+bounces-150153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B31AB8A9B0A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1741F21FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C13B15AAC1;
	Thu, 18 Apr 2024 13:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="OA5GoChd"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2023.outbound.protection.outlook.com [40.92.99.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E731E4AD;
	Thu, 18 Apr 2024 13:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446404; cv=fail; b=Fq16Mdro9sKi4un3MZJU79MeNgA3LNcNCTG0h2Zslzsp7pP3fXQFZJ6maite+CJoGvoYWp91pV/iaiapoU4hXq0MVPEF8p8V2TY2YH8JWftvP9ff5WBgcqzD0UVDef5+IjLL1+MgJRrWRVZidvrR1Ey+f/SiXPeLljeDUDAsSsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446404; c=relaxed/simple;
	bh=RXaVx98+HAPoB1YxNP+snq4RK/xKaTCR02jC/cZDWrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KAQ6b1nf4OZ6lJyIEU7wZX2rMjGcdNL1TeAyiTfNLecL1snNGZITmHFmB1Fr5WCEHfBjUwxrLj2zyV3/Qob/BAUWn8Jf31XyPJsbhrohIbc/0571ofuC5HYPigo3Mx1jdAzLdafDGblvZ+KPBqfyr1uwSBiYFXBG9MT06vOucBs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=OA5GoChd; arc=fail smtp.client-ip=40.92.99.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lEuiW0x8jq9IVwkFYJH8QjTe5OTQL7tgW3G92D6QjBkoxecgWj/Cr8FZc/kIKg2iZQ0vgy/Cryw1pFZ/sXqMeJpZ8pHy4NaI8NWE1dPlYCAIU7YXiUFJroqazOP0g7JjcGKar93Uwz7Q4uL//PF/QbalWoc85Hc5W9BoGZhJ8Cc+jPz1wkna2HJ7vhiF/YR23qQqWxAQzmzShJHW5OPzIl2g9UIeJgxfSan05bdgAqjjGHMtg3ZNFZXT/Hmg15lECC4fNnhEsAvBxHOrAbXgp5+01svulnyoGF6lH5fzbXNu4PV7la/oIQQsu8ZQ1ARz6s1GDfDGMFyCfTk17mch5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+/Hy7KFGw3BwOLFALtMC4ALkZp5ybscPilbgxF1hAE=;
 b=Xdd1cDP3QaDVFNGOeEs0B/EeHAxv3x0eHEMRhqSJf6rMTPElj/VZ1VdKlDcdF8yHyG7VOq2ANoneW4L2lmiW+WucMB845ZjVRPeY/EU1pU5Zl3CeaTLj8mWdgy8gcBAWaCk9qasBndQBRmKIHvhqWbtD8Wn25plBqxauLN3T3n3Q6hEw0pbNCPUQLtsgF4zWVX1gxsZtz5aqWHKbKia/rLPRK43kq5GXzf8PNhvOnoUPgkX5oqoqeBdNjayeRWA0fA7d2wvftpsSfZLE604CBC6XMYYUv2juH16o1j4YveOKux9hCpzdlXpyyfd0KnragC+TRNcm8P4INJ07YoaiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+/Hy7KFGw3BwOLFALtMC4ALkZp5ybscPilbgxF1hAE=;
 b=OA5GoChdbLpaggEegZHq1OxrARqRuRPrKB7K5Ya+Wnhx9yeNCHS0QymdNKzY2Ru/wTNYKZLczvv1k4YvSv2XwYrx19qnLzWW5CICH32oCNUh6v5dcmVh5pK1JZG/jDwbt+hAYuJOINXQcJpou9a6Q3WK9pk2xhKf1TD7fccO39yt3mUBEvtgsQvSlOXQGQsUsj4iM9wZhRV4/mm9LDbDwsG0RuiVvfnhWSei4fsxxLxD1VWDQAsHSy4u9pDrpJl/GY5hsiY1+SzmBGAmZRW3FIH3ilEWOJrBTWvJHaleN/sUXce2u/n0ASH+pbq7E9gsErt7b1uohjcCZfhm0hwp+g==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYWP286MB2794.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:19:59 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:19:59 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: sbinding@opensource.cirrus.com
Cc: david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	ArcticLampyrid <ArcticLampyrid@outlook.com>
Subject: [PATCH v3 1/2] ALSA: cs35l41: obey the trigger type from DSDT
Date: Thu, 18 Apr 2024 21:19:47 +0800
Message-ID:
 <TYCP286MB253538FE76C93C032DB55212C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [AYL1dpxLI1H90hbDQE2RRI/AwlK1vwxQkVy/njQxZnbIV1rQvPBbqA==]
X-ClientProxiedBy: TYCP286CA0071.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::15) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418131947.31747-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYWP286MB2794:EE_
X-MS-Office365-Filtering-Correlation-Id: 61a1b809-1019-4536-8682-08dc5faa3f6b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mee11nwGd6fX41BSepF9BJfr3qutTkb0J4bymvn0EGRnbtWTAd/txNOhciwjh4Vk6GIfyUQzITZSs8tqy7KUTbn0ISsBeslaYq8+yePSmaHANpRH0rC/vQx9TytA7HeIg0T/6lirh36+sy4Y6oiRf//UkRyB9V0dBtByDmw3mekH6l8BpbxW6q/9MOmbqIk/qvfM22vA9L0GpFkWZ8defoGGMtBW0swTzYt97b1Gw+EPsEtqT9j69XvMJwRsFGLmVYIGvQQhPshyE2w4Z7t780RdrXDzd8jQTDGC9Osm8t/uatnRPwRieoChnoFgdp0X6dYc3BjJ3jp7XA/Rv2nx9rjMb83YAHaaS9x59ZR3Lm0LlB7fFfes2Fqdp8nLPcPNUQxK69qH68l+/eSlr8nDFJgIqJt2zCSbLkwWHidcK6FGcORC2+6Ud2h4k/Uqvvs3ht0XZGSyWX1nhQY4SXvCgXuRePDPYAR6HC4EMxqr6YgbcQ/b+lMSkJTXDWqYrfWMPDfqG2tMNGdrypb2AGKbKU3VZQzg+Q/UbsJqOP/5hV6tqoYoOpGxdBDlzmrpykMxpHNslUTA0NDisCMeTGQ1hzCWbI+T20gKXDuDUV8zZa/gYPTLSSNAxG0CFnxL0kRa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qc/kArsR+Cp3CPgyo19ioBkLbjn0yKqY8B8aQ/JxJ1EoG/1kq8KRVOYLi+Nm?=
 =?us-ascii?Q?U4qG85CPEbE9EMLUB2Dmsfplt6harW2IWq1ul0ID1cPKnawru0Axm4YiOTu/?=
 =?us-ascii?Q?mnUkm1FyE4TPMGp3em75e6a1IyP/gK4CAAbhW4vTCTUG7jON6nj53DpT05sP?=
 =?us-ascii?Q?GPq2qaHCGn1Tn+BZT6Wep6kHjRxLi7xCskdGfJTDqHFSESfgBRPs/8yCOzgT?=
 =?us-ascii?Q?32NbMV2prZ/+9Qr4nse05RKz6cHhGDW8dOmGnKDFJ1Xq1Vy9fFIhzjuwJHOW?=
 =?us-ascii?Q?2Z6PNJwX362ZQxUyTIP7oKAvod+CS9XGnxLJJdXAb27bo1Cny7z3pEqy11eh?=
 =?us-ascii?Q?dxkpmBw0lVEuQZbCEmKNnGU4lTMTYTBqpwkt9aBYgrvW2i9pzVbTUorBrIUv?=
 =?us-ascii?Q?sX+T817IOs9dOYEc6lXB1wY7JBfR2OBmhJ6X3HGtj6Ml18bKCmGvJ9mxIYOM?=
 =?us-ascii?Q?nm/byCuBbBh7EGSppwklZDD36QWzA/0OTbF1hr6N3cCRkq69oMIRTZhTVNpX?=
 =?us-ascii?Q?kp7c1xHaemG7zyVJkzE2IK3e+zTLiLiqJTLAL9+SsXhhLAMzQ95gYKfAGrjq?=
 =?us-ascii?Q?j/384LC9hcjoli3X0CQ8Mie7bWNP5S1e0bn/JfJOM/C3CWhSTrOS+2lKYODN?=
 =?us-ascii?Q?5Gw15TgOFG9pFv75cZGmOPURVWunucsXC6zqnuSVHgZEPzTJx5tYsxs/uH4k?=
 =?us-ascii?Q?xT3bSNMiM/r8dPjfKBqnPxhTMc6qSLQDxUVeas6HfLaTt5MuH5KtqFtSiCyy?=
 =?us-ascii?Q?uK/ykWml4GPgpNgQ5QbCAbqJMzIdJ+iEyLsGqZjCayVURiC4wdF/LpH6fjVB?=
 =?us-ascii?Q?vGw52Y55i8eWeCStwgsYztvIuWAQJ9nInAT0hpXHc5OxoW4ivSvgbA1sPg77?=
 =?us-ascii?Q?Mel8nWDNAaBrCfuJSeYof7V8e1YYCdOEmiw+5OkhnB9vadmQYMzNuBNVr2Y9?=
 =?us-ascii?Q?+eK1IAkkqcJdqMEPFznV17WX7TaXbYMZ3ao/Me2/heLcO7AE9vVc3XQEXhEZ?=
 =?us-ascii?Q?nymI15byjUHvMn77WesGP1YaUCsV82yVV4aCgluMcHpELOBRqD+Ererpg8J0?=
 =?us-ascii?Q?VZoMzvhcoYj1nGjh1NnQH7mCjb5QtJljgFTt+GZemOFqclARhj4YElmdWQwz?=
 =?us-ascii?Q?MdhIPBtohzSkuhhGauvFhw/whubkJkkEE579Ei1xd4VSqxMkPe6rAf92WeAW?=
 =?us-ascii?Q?Yy4oRRuIqH99Zcbe2xddQXJmqnnuPnrBU7bvFXep2iAA6wY7KgEsgAopUh+P?=
 =?us-ascii?Q?vt7CBWYzWBcaxFjK46KqxxKyrBzMkJyI+WzK75oF7Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a1b809-1019-4536-8682-08dc5faa3f6b
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:19:59.5797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2794

On some models, CSC3551's interrupt pin connected to
APIC. We need to obey the trigger type from DSDT in this case.

Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
---
 sound/pci/hda/cs35l41_hda.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda.c b/sound/pci/hda/cs35l41_hda.c
index d3fa6e136744..d9c7b4034684 100644
--- a/sound/pci/hda/cs35l41_hda.c
+++ b/sound/pci/hda/cs35l41_hda.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <sound/hda_codec.h>
+#include <linux/irq.h>
 #include <sound/soc.h>
 #include <linux/pm_runtime.h>
 #include <linux/spi/spi.h>
@@ -1511,6 +1512,14 @@ static int cs35l41_hda_apply_properties(struct cs35l41_hda *cs35l41)
 	irq_pol = cs35l41_gpio_config(cs35l41->regmap, hw_cfg);
 
 	if (cs35l41->irq && using_irq) {
+		struct irq_data *irq_data;
+
+		irq_data = irq_get_irq_data(cs35l41->irq);
+		if (irq_data && irqd_trigger_type_was_set(irq_data)) {
+			irq_pol = irqd_get_trigger_type(irq_data);
+			dev_info(cs35l41->dev, "Using configured IRQ Polarity: %d\n", irq_pol);
+		}
+
 		ret = devm_regmap_add_irq_chip(cs35l41->dev, cs35l41->regmap, cs35l41->irq,
 					       IRQF_ONESHOT | IRQF_SHARED | irq_pol,
 					       0, &cs35l41_regmap_irq_chip, &cs35l41->irq_data);
-- 
2.44.0


