Return-Path: <linux-kernel+bounces-149610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F4478A9370
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 08:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D5FB22110
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C159A381CC;
	Thu, 18 Apr 2024 06:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="k3Q2d9/q"
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazolkn19010001.outbound.protection.outlook.com [52.103.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECC936AF2;
	Thu, 18 Apr 2024 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713422748; cv=fail; b=NadpSlKwxoser2TNa4Ws5eIAsyF7kU8frgHdYZSr3d1f0WVAgqGBcHAhgzgO/6csnm48lp8MYcIJbsWfsXKOuW/UthCtuJhCoXx2/nVs5eAK4dYZxQOr/ecmVPS0JYuVlJdFNLQdlMigOfIeNAPrW6yL3I3w7kyPJHi+f1t+mB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713422748; c=relaxed/simple;
	bh=RXaVx98+HAPoB1YxNP+snq4RK/xKaTCR02jC/cZDWrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uWC3yR0eR03RHPRmZJRINDYcy7RSlklY2GbJEh23AG8VLS1B7ceE7bS8aH8HFIf+UQ+KcaUKmOTZItxuZ5LjSx4bSQaqk3D0RwvnWoWmTblmVo8fMsyIv+8AMt994q1ahVSNB8re8mIwAJwHWNBM3/3PAMB0BTfpCUSsB1P/ktw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=k3Q2d9/q; arc=fail smtp.client-ip=52.103.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIxy14Zp0mSNHZ32V3Ci1JQsWF71tLfZNDO8enZkbDkCdUQhrceBrkflnB8cD3oVjekbsyTTqKPuRkaQrB3oqfDx1tJ3TZc6Iz3P1Uxk0GV3B8/0u9HN8YrAQqzUjZm8qZS/pctMrDIUUAkjThIOyhGoOc6OPxK+Y1Qe65RTjUlZNxDZHrFpoe3XliBmT3JxTAV3MdrEN97lNkrR7Gn2K5st4Vfpu4Sbgt5c+39vWviAiUxNi1ARBjJXDkqOCNWLfWKcWgPbELUroLOKY4594NuYC23kyQuR7NEY80t8M4XZE8YdHxel7w/CF4Wxf28shK8Xy5x/vk1L8WLWNivbfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+/Hy7KFGw3BwOLFALtMC4ALkZp5ybscPilbgxF1hAE=;
 b=ZBSB5cFxHmSGXmc8Qv03edwfTWuc/DfJlnCtKHdNuTpTwssNAIwDzHhwnwa2/HfMkjCcskjraKW34KvAny96q6U0+xnhw4R9SpEE1EI7QVIGRTkrgxHoZceJvcga+20xaFAI1Q1TmnS+SsRYC4g6J2bb5aS1JYUvTTwcowrelqAJLZqz8iT9ZrGP/1/UEUsQX3tJCXyJPF1fQKFGDnijplfQc+QdSorFCfHiltELecg+NtnvATeF6X2ujIoEp7+VaasFUZVJOTLsx0+NnFF8VByQc1RBPnpWUgIscRkjHY0Rn1xBjfF47vokgnW3Iyj4gcUT7t53q0FxhNKGrILnZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e+/Hy7KFGw3BwOLFALtMC4ALkZp5ybscPilbgxF1hAE=;
 b=k3Q2d9/qnVldXJ93dhwvfWf5/m0VeZqqS9bskhoTIBHWvUZk9p6OOshUCLHknhEq9G4AGgIc/HgDTkRgTgyUqFq854AqaOSS5OHqfyeAoK5ZPr03fggashiPpcDab77/v7B4EZAfb+Ofb2FOQrfDbv8MC1rfakTjrwkj/FM8RM6B+huaIBKGW4Zug9YF0lKUfzQ6IlYcQbYDyZ7bjOZr0k55iBw6E82x9j1XNEQ0D1mDbMxcSz7q+E9SyD1VcSdzkJpHR9p7dr/d+rJG9CyWhpfCyasNg+cXVGF3H2SWwGwrgRHo2KBCn9kZ7p6Qd5VBE0akeoNToy3PgO99qzug1A==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by OS3P286MB3372.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Thu, 18 Apr
 2024 06:45:43 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7452.050; Thu, 18 Apr 2024
 06:45:43 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com
Cc: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ArcticLampyrid <ArcticLampyrid@outlook.com>
Subject: [PATCH v2 1/2] ALSA: cs35l41: obey the trigger type from DSDT
Date: Thu, 18 Apr 2024 14:45:33 +0800
Message-ID:
 <TYCP286MB253551BDCC83320C246BD494C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [YLZBOU1DJ977aCWTNLF4FTvGy6BASgTfa2mhcyO297mzNgOEV2dJ8A==]
X-ClientProxiedBy: PS2PR02CA0076.apcprd02.prod.outlook.com
 (2603:1096:300:5c::16) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418064533.13727-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|OS3P286MB3372:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c66463-4b4f-4a32-18dd-08dc5f732b29
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	U2mp0XpExiWgPnuRP/RDtivRI5UzHjGCzEJK9MwY9Qeyv2mLPPbqXnBCy5Cjw6QHD3rmIO44BuLPjGrLSdDb5VVVvFpS5KsvvncEdExGql5EXWG2UPk5OYQRlmtFnENYWyVutkqz8R9V5499A8SmUkLtsGUUph4Gsq+F0k6Q0WcRfR69m+PWAn1Ut/4zUYnylDvtodSHx7WrB6T7OqPcVi8nWL9CugHddK7hHDnhKJTx5X/d97ymxMSyCNF7FX7bRM5aSLVeL5/PjLFF32JqEKqWYKx6gvcqI/bqW4F4hjf0kwHu3J/Judn8oVkfpsViDLORF8qQUbMQff6oJq4L7mwgXCSCVjVwzFUrf5M7PPhLsnpKAHjGLsuQhZzzgijrfX/TeMckETx3E6cadVnc3oCglegJsj0RUCjbzdSqajznb6Y0hk2/VsWYPM3CGUaLmw/pmF+tWTWG2pC84VchzvzatvenkGy5xDH/vBJ0AHFz2Ep7Z80yV63XuuYelTk611cUudqBRT6W1iTDAiTAuEUe7rClO70qf/mKZ8+1JA+hYdNXJRHU18Db950D66sxiZHmssj6YRMEUUc2C8sKPL302nuKbfR7dLKKk4ZosQnu/zpLpJuguA4/dZgT0T6L
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?siYr4BayCr0NE5Vx4jsa0RCl6XA5Jkk0HPus6S+ZrOf/yh5A/NFZ6POjFFvq?=
 =?us-ascii?Q?nzd3vPLmny0r5DsBZgbcq5eo12RiYQ/smTYHsw8f9+tsKi/GhVSD3aKKQBTL?=
 =?us-ascii?Q?h555Oiz63VKpy/klG3Fp7G16JjzMwwxp2vigIXMEzYx/g5DcJo3S0lxhZafz?=
 =?us-ascii?Q?nyGGMuEtJwRUbQHbdwxoKZpiOPwFLLYVL8p7mcH8MRFCn2MxyqrN/OnzBwM8?=
 =?us-ascii?Q?TzsojTJ/SM22PlS8RCztEEPgKGu5g5IDq6J6zVYkGdFUFYF5aqpPa1Hv0IDy?=
 =?us-ascii?Q?Qanj9DySk4iilG7TYXhKhokKYL0mMavOEQGHorRqGytK7Vtcx0nWYy0rpKW4?=
 =?us-ascii?Q?LpTup6Txh768JgP4MBlks61MRA6tSppi8pUdyNuen5HrSz8YomKjP67KAN8F?=
 =?us-ascii?Q?SM7Sin00VZVy1GLNepiaTGkixYoS/nIOlpqVhhuqB4D36VUtqT2/+GEtb1jJ?=
 =?us-ascii?Q?TLrRxHgdZeqyt+BcnCClgDcuMd1fcnKCOCznsIRDazQBBu5EbxjfPgJnCjGz?=
 =?us-ascii?Q?AciEZXMCa8yPuZDnYmzPsjWFEWU7lm5kbq6hNtLFQwu9g7Y7LJX4/rWIc/94?=
 =?us-ascii?Q?nQ0q1mlyVMPND0FvcrhazY7+fHfxk75Q/ECWvewELQtwifOLonXqKAI4+6r2?=
 =?us-ascii?Q?45IPp/aJdzz0Ph+bndWpBvlESB3QGcL7DywtqN8Zz8WBzHWzIJNOQso7ifTs?=
 =?us-ascii?Q?MBnRxJ+QEHXnvWGrjoaeIA7XC9eEJmFfPmUJKrj12LC99y+mtXIQ8lw2z90n?=
 =?us-ascii?Q?ZnXJxPY3Df2k490WNUXpgZjoXVIG/stDI8uLl59c41h3k0rHCVtg/g5XN04B?=
 =?us-ascii?Q?09//ip5+5lHBSJ+L6ODLZb7oP/7mKTcuDoxdQz7SOmb6cVyIau91FChqw6HY?=
 =?us-ascii?Q?XTcONpZkWKy+ALr7xXbQWjE0lN6LBUJ6FUhlYRyl49wBdbQ+9Wm2f8yggzrw?=
 =?us-ascii?Q?CgKMCFU4btiEIwZa3hyL/HXU37P4ozck4EE4sO+JtN2e4OgOmXkRhJlbJrBH?=
 =?us-ascii?Q?JPWK1HgO2qSpMaD/IQMh/y1OqMywZ2WNdj3nAuArYi6P0/5UsBhXV90AKYxA?=
 =?us-ascii?Q?j9zU/HQCqSeELARCTwpcjony3ybToixtIgudy89+JvULdITQBzo7r7+gRCkG?=
 =?us-ascii?Q?CRqQVYLI7QaWfL4wnKTgwlF+rSEUZ4IJ702itbF18LufbuHpAzvFI6c55NFk?=
 =?us-ascii?Q?+18JWCVwVfFQ5TLen2GTscThscGZ7v7ydO3e1V0K8hl8yi3Gfdo0AlXV13l3?=
 =?us-ascii?Q?7TCVwPyhDtzWjw+JqIpR44DesinGKSMcRfpFaIGodw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c66463-4b4f-4a32-18dd-08dc5f732b29
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 06:45:43.3036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3372

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


