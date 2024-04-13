Return-Path: <linux-kernel+bounces-143735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880918A3CC7
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 15:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96F51F21963
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 13:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B754A3FB1C;
	Sat, 13 Apr 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="QPKBP7uY"
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazolkn19010000.outbound.protection.outlook.com [52.103.66.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E8383AA;
	Sat, 13 Apr 2024 13:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713013693; cv=fail; b=JoAr5ZUoiM4t969gJWHfDCKFSTeLf69jPStCo9PL750uIfOfeaXCorwZ16uufYVn6QGn/yf0yLBzvi882IeGkqY7E5RJJKvAjQweSp+UFhKij5bVuGDHsEg2Iql2ExM9pomRZhEJkan4Ou7tAPzksaMexCt+VhR9jY7GTvj8N80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713013693; c=relaxed/simple;
	bh=8F88CRpBpIG2rG310LnuwRJx1z4NVc6qPB8zsZ56rrc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PLxANDMq3XGSd5Zj0ZlFiRmTu1Avysxqc4yLrcLblitkQ65iLF0u1dwAN5/Q2qrZBhWAMuUViTU3WZ2aHCTpxz0w/D7hToBq2QL8RgGFftusXuevhL2pUlaa0T9gwYTL9LUZ3nc7z34NTSegSVt2XLb2S91TNahwhz+KODClckg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=QPKBP7uY; arc=fail smtp.client-ip=52.103.66.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FayIaH4d0BxcX0I0D0s1G1okxVdRhVweix4/avPVRRAFvSoHDZusfHrM/dPST4L/0+anLxmeFE/ZGIwGvWT6YI1D7nh6DnUl5dyMVlBs3F4pA1DGeMsDrWde5F9FHHa+iMhFhiMillG2HuSzzT1hG0oMbyfsn7Kfy6vCUdSIr4JuAFUjP63LG9C54ZefWOndXxH7yiaodLjZV4tGP2rJdYnrWs8TYekZezw+yiWA42+0nyPI5cOt42viX0+10E1mSxA4GNUUExr1QI04L6Uf1xEba6oRcCfsh02stiU6qKQK/BkFoV8mVJQCLLlDY+ThZD96XClo1vwwjr9uBh5i9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTM8PY7dyx3dKoUCEjXNYOvEJDZzx52EX7IRsxXtbQs=;
 b=mRO+E/JD6MiZ1EQEIFgjufX7WhgGt1dBRx0bX+H0wUGEzEsSSMmbxJHzvZwQFPH1v4173IPY5+ajJjAGupNdYQlmy1ZfLEm4WoPZIl9lz9S25+SnMHOnFB8XkpRxCo8V8gighZkvkUamiDQd4qq63jOQ6dWGK52q6Ef9E1E30fDFU4HgK+5A8IUgZ1xQJEVdHGcCoGdDTh8dGa4Q0twmyoGLX4cM/WaHF5vHI2y2NPuKIOIrzVdLz/eWWJd4WsJLy6ahy7ehfpulc59Dm6IaEfDPLjsf1iwMWYJuDxcbfixoZxqGQObCmFMvKlzopRTQq4LwpVzeaLId9RTlkKASwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTM8PY7dyx3dKoUCEjXNYOvEJDZzx52EX7IRsxXtbQs=;
 b=QPKBP7uYlm0Tm3yQ5XZCewAdAQSdTSFzeVG/Gj+9LFg9TgVyfsgJgffxHE7fTcuTnfh+3xfRpz2XaNAuyck5qJTNEzgiwbVlJQEKzDVuSsA42P4N0jYxQpOzMaG6W+k3hKUtIPlZWBJLxRdP2cX4q28X9BVGqvemqEF64cJff44pvcI9eXYN+C/n2qBjChGZ5RsBy07RJ0g75YeN9L2/hikImRvAaV9wJRz3WdFBz9U6Y65OPl9ilv17atlUJCpOx0DoWiGWCFMxQ2/y0Noq5IONDDf2xXXh9271j6ifue+IAYcCai6pxZZ3dcwlT91MKu4C0b4fnlPArcBUoNX7Ag==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by OSZP286MB1797.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1ba::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Sat, 13 Apr
 2024 13:08:06 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7409.053; Sat, 13 Apr 2024
 13:08:06 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com
Cc: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ArcticLampyrid <ArcticLampyrid@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Sat, 13 Apr 2024 21:07:55 +0800
Message-ID:
 <TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [VPB2WDdPzJP7XoxMsZPzvytTXemr8Ed2fcOMMo3vu9jWTfTgVM0yaQ==]
X-ClientProxiedBy: TY2PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:404:a6::35) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240413130755.57218-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|OSZP286MB1797:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa911bb-756e-4136-7a26-08dc5bbac21b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zlgmQt56CYYyrVJVcFGrTpt5J09ebkl74RY9WlNg4p9ah2Um0tDMaIZqYgoPsHu66zhm/okT6hpPvyFprfyH/EV3thCzfrd8PW9VYr7SkYo4DJyTN+XQH9t8l1zTtzjr+kzW3h5GAS4KoqcmPu/8ErGh0rmbkGZuj7vTryGeS1wTs4yeQy9c6YwY0gmSz6GADWNBqC067j68adDMjEhY8abYcjivTis8SoqkCTTq5h1JLiMLRIQ7psgrU8mGTt6axr/9GK5IRsmcrgh4ITeaC4kNpfh1o4I5Ogw4EiNifkrM/wanYArEeUh9YK4KI/X90cnakGTtZCUCya6uml8OkJcbsDbluPW9x5KhyLb0/U4vg9o+oJvHdOSeA7vMe7Jin09Vd3vRU+hvT4/oLiPVj9eBMeRIs9a8MLX/s4qSnwVyIk5wABloOSdtfvKSnHkPh5abJz0eQgiVz310kQylMd99Jb1lM+FZ7EeJhFMbMeN5FR8tnpnOL8xIxzG0p/x5dNKW2cogD7nOGfHGIVvT2HaY7SQukclnCHrTmTbs6gZtcngibtlzM0ExUkMDW6OXZTjAzbW12pUHdjMtKzbL2YTO0yCIbjn5q6MampxKoIjI47nGAJ602B+wYsgbm7du
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sb5ZwyMkc3S+WrPkYwK3DRfO587HCo3YajX0JPDJA2JQAGtNqLqjcCAYp/Ol?=
 =?us-ascii?Q?o5a41xfOGq54fL6QGpPh/fk9EYkIiYIZAmimRKuLvhXyBco9deNRJqEJGWls?=
 =?us-ascii?Q?EJSB9V3AfnHA4giiXDxpjfcaDmh5HuWi/Ay2kdLYBa+FkfJnaoaieDGgN2Ak?=
 =?us-ascii?Q?Urr3b5u9u6UgI/hmjb2j7iJ/HEfG8orh/0YdyyUSEFVlZIdeYW4I6zkVWbiv?=
 =?us-ascii?Q?RpPpAsOlFZnfjiuoH/1mJVtkqtwXRQBTvb2jE165O4YonyuE/llTwShLp4kf?=
 =?us-ascii?Q?f96vcI+h1PAAML52tjuy9artVH8QRUgD1O8FiNCLBv+RhzUHHgmPsK28vlpt?=
 =?us-ascii?Q?5xpvenCamTfBdpNa2tJn/T+qEwmlZRWaW+PLMfcc3blSZc7Lu/gKaK8KQeCj?=
 =?us-ascii?Q?gvfNB0THZF4j1WSxeVYKdvbKH7muGCs7RY5q082Cmgx00ZJ25nPiFuHftN9Y?=
 =?us-ascii?Q?lOJuP7Aa/y1gLLD9VQiUiH6w0Kh2Dm4rH3KoQXEkW/1uLjX0uVnOk3ilx0L2?=
 =?us-ascii?Q?2vCHOSBOsOEfqvJfoTf589jheGBIC18HVcggQYYS+ZYFS073/1rZG+H0JmrW?=
 =?us-ascii?Q?2tH04oXtHNBpU0RTzL31UAVEbP7yb5+DxjlU4fxm26Dygu7jFgr/OmxuOsrC?=
 =?us-ascii?Q?hhQOd5ZBKiXpUeCjrDM5mi4QdeKaHOq/UA3m+6Xf2/DVpXmHl17hFJYOtiN6?=
 =?us-ascii?Q?GCV+juW4PglPRdkGbAlra8UFoTYZMX6Hz5oNigfS1la0DgJLAV2D00e9F7iL?=
 =?us-ascii?Q?QU6Vg1NXhvzdWm4wg2IV93kqevOrPG/d+Z7NrtWsilTaKVHHFmh9EbW15xDZ?=
 =?us-ascii?Q?7sapZ1mg2SWFMZCFKtnZi2njAPj4ewz+38OBK+L4J5LCBsqUne1dCg3WwPKg?=
 =?us-ascii?Q?SgU8+i4lACYjKqm93KafffGKvHSeSAFTAPt2eImHWAFgBDatiC5T2KFxznqL?=
 =?us-ascii?Q?zM/0oi+sZk0+pMj2IeOOCDPK8+IcpDlAEnZxmuWcLhXSWhqudNxTsV0wmqUq?=
 =?us-ascii?Q?YvPPNtCz4z9Sfc7bbCpOMovGMKXSY5wtFeKMZDASKENnCPnPD2E2vihPvAFa?=
 =?us-ascii?Q?x69YoQ9xq/WOx4vF7TaqeZt4h6TkCq6CKnIXi5CwuUOwQ5zhfjuGOtLyzD/J?=
 =?us-ascii?Q?CC7PVD63tL96Q7G4GjDsTLAKScdMd2c9Jq971zZ/zn7EhVPRCNCk3IeL2ez0?=
 =?us-ascii?Q?p8oq3tuD0zDv8YJ2/NUL2rdxAugo4LRLc4MKR5/ILB2HjM5dj2ZrLBAw/Nvr?=
 =?us-ascii?Q?JgYlUfv58JAHRD7ePrPl04NN1XKdO8GGDaijSafHTQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa911bb-756e-4136-7a26-08dc5bbac21b
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 13:08:06.2003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB1797

This fixes the sound not working from internal speakers on
Lenovo Legion Y9000X 2022 IAH7 models.

Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 17 +++++++++++++++++
 sound/pci/hda/patch_realtek.c        |  1 +
 2 files changed, 18 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 8fb688e41..244e41d51 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -109,6 +109,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -414,6 +415,21 @@ static int lenovo_legion_no_acpi(struct cs35l41_hda *cs35l41, struct device *phy
 	return 0;
 }
 
+/*
+ * Some devices just have a single interrupt line for multiple amps, for which we
+ * should just register the interrupt for the first amp. Otherwise, we would meet EBUSY
+ * when registering the interrupt for the second amp.
+ */
+static int single_interrupt_dsd_config(struct cs35l41_hda *cs35l41, struct device *physdev, int id,
+			       const char *hid)
+{
+	generic_dsd_config(cs35l41, physdev, id, hid);
+	if (id != 0x40) {
+		cs35l41->hw_cfg.gpio2.func = CS35L41_NOT_USED;
+	}
+	return 0;
+}
+
 struct cs35l41_prop_model {
 	const char *hid;
 	const char *ssid;
@@ -500,6 +516,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
 	{ "CSC3551", "10433A60", generic_dsd_config },
+	{ "CSC3551", "17AA386E", single_interrupt_dsd_config },
 	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA3877", generic_dsd_config },
 	{ "CSC3551", "17AA3878", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdcb28aa9..ac729187f 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10382,6 +10382,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3853, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3855, "Legion 7 16ITHG6", ALC287_FIXUP_LEGION_16ITHG6),
 	SND_PCI_QUIRK(0x17aa, 0x3869, "Lenovo Yoga7 14IAL7", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x386e, "Legion Y9000X 2022 IAH7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x386f, "Legion 7i 16IAX7", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x3870, "Lenovo Yoga 7 14ARB7", ALC287_FIXUP_YOGA7_14ARB7_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3877, "Lenovo Legion 7 Slim 16ARHA7", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.44.0


