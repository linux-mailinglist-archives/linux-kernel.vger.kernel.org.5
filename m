Return-Path: <linux-kernel+bounces-150155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA28A9B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA3231F22273
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A331215FA94;
	Thu, 18 Apr 2024 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C1QKe2CD"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2011.outbound.protection.outlook.com [40.92.99.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B3A15F322;
	Thu, 18 Apr 2024 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446421; cv=fail; b=CQgmLM6/U8N06ujmArpjaNwrWTJPGG1MdvGRDdxkjVJ5BD1Jd1pemjvXcgIqjDh5uq7aqf8NiDTtOD94VdEqeI4XDq4eGWp4DEV832czSfsZw0PfWgI5BoSeNb70Xopng8RLuHevagjEwWw+6/FkcfkX3xfVR+QYxJhixX7KKlI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446421; c=relaxed/simple;
	bh=WhODe3gufWWOOpfzoyXcjR7gT/5DIFACrmbIGE3uSU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZIIj0SJsXIkH6fTgMGwY3JoGt5b0NmRaeypfY2xFSJKX8yI/EGDLNF6l5EVyyu+DTjcNW4JMXXQ/fAG3OX/rndzrDfJxcyi7QvGXtyfWCSqaKxSKUAyh0b9GSHLYB2Zk5S+ZrzGJTpvzZ8JfhLIMugBsk9j1m+P9ZyW036T0wqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C1QKe2CD; arc=fail smtp.client-ip=40.92.99.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFYNeLxUFKhvHsA6tW8NDS3s3IKD38SwH9/gSeOqAkrHotz0iQ0B8slLAUByZTbU2+Xvp672MYree1wsJ3C8hqQjHJMJxLfGoiF0Aj5nFzmYg5aDXL+Mz2lUjYEULfEuN0HMXInT01sQSCt4JrhDsk2Ev8Nq69/uiGRhIPWyk6QELeP0F6VZFuO/QQukYCEuaSf8Xza8DZ+Y0Mp45LTnStv6YRzE5QvPSynbvlyHd+b+Vv67eGGrpCQPoFqaCtOVRIAeGtEbZXyh1N84kX9nZe2Qy9tTJ1cY2KjcQz6sRtHGrauERnDEuchICa2L1MctT/w3lO8xBSxQbq3A0/yNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJRnX7h9ubQ22I7OrKHbSgjtvd/KLvo7Ahw2L6hSxl0=;
 b=edF+ayNPzBVpzInHtm9E79II349xEw57GYbgpzhbHQyXCfZrnJiS7sK9ayY7EP5+lyRCdh2EmAaYq2XUuBeerHyx0WeE7yxbNFmI+MZiUzlhZjMMtND7JCpmq6c5l33d1DjbCokBK0qUzvuZBpNZmEhF7asO7PneIPoGN/kCP+QsIzWwYQ72nvZ6mqt7Chr34oZo9ByXwKxGcnEMsVFtOqU5ssFp5obE2PwevsIlFfISaffSteI8wnux3QwH1q3nmbi9rkBBkWgTCpPBMGbB5l/tQan/GNv4zXLmg9P3/Ue6gSXNT6GAcmSaMWJ5WTwGKZ6Y023w/L0qcINGILEbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJRnX7h9ubQ22I7OrKHbSgjtvd/KLvo7Ahw2L6hSxl0=;
 b=C1QKe2CDXEbQIGoSHrjBjwC76eU1M6kKRKK9+3vEY25BkEhji6Rb8L9gHF8T/YMzhGgBBhn5wrYu+UyxrXM6eHdEykCpnXV01D7JTIEEv/ygaKpHXGRvuwSz4zFvdKsrph+ufFQ11PgDRXct4vFoG7fEG56veBbZGqxmIlhLWIRJvjginwP0F6UeeY1Hu3z4GvkAAYzcwEQjjOtzVUZzLBtp4XhBuWu8hhx9am+kMgRP5pRZ4zB3kVG59q5OjKQR0b5VMe8ss03j7kZBrjYRdr3Sl6R7g+XwR4gJeiCdcL7t1pwHAUdUxcf+FENKL6GlHfZONNMd6wbj1M31h5kLmg==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYWP286MB2794.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:20:17 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:20:17 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: sbinding@opensource.cirrus.com
Cc: david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	ArcticLampyrid <ArcticLampyrid@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 21:20:06 +0800
Message-ID:
 <TYCP286MB25359B61BB685A4B3110BB44C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
References: <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [l0sJwAMOLHFq6BML0NSJEaIBTgXAVtynt8Dodmh2D5Wv5Sk4yCKIEg==]
X-ClientProxiedBy: TYCP286CA0065.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::6) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418132006.32013-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYWP286MB2794:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb2a7dd-a04b-4c29-272a-08dc5faa49d5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N70CgTSviV9WdkHcMTeSzzKK1N1LBiE/yAk+CdSC9I6xPdyFrxbZaUodIov2wqI0tfHRrFbGm60u3H57gHsg4HO9g8PAdJ3lIAYC0NBg2eDXmeJ2kAG2MZ7FtvblgX0fBiPbzX5687ct0cUs57olXTQPhx5u/O3g3ppDSi9xnonHyoVccJDZKBYFEO5tqDgdNj5sFsWfQ2jZEMs+7mwOWKJ5PTuACxDU6KSAYn4zOLCeNLH4ereTCsrwNGbkGSKPxCJA4La9i/IYJ713sRUD3fDfqlBgE96p0BIrh0QKRvgYLx0IlGxxawKkaavj/kHb7BD3gBT1dPMlad3CJj44cELhRoa9wzfjs4YK+fGUbnjlYlEvcoaRWlH8YJgQnSy4IhaJBU1MT60yODYg+zZuee9XBJ0b2SdGSbtUyzWNnqbU1Gn5juSVf4DJBJTptnQI0MFdoBqgGYsj7XUNPoTFXQf8kAh0ANthdfWYicAQGQoZgspqnMmeUQEEVtzoF4haoyQZWFOMk6fSXP0B9erzdM4WTetoEiU0dHBpKEm+2BRFNo2GrOEVWbEeG0tqCk8wlwQ4MGwBWUYpnuCsQxwNRAcmv6N03fR19TnrqTxCp9U=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aAsa638dkhHrUlgZM8+YrYIKK2+QlOV8RG0KnrJH7NAKk8h2mdiP8U/d7E3U?=
 =?us-ascii?Q?tISfsDR6N8uQdYr1zu1op0fn8i1SKLWdStG6glx5vszCvk/KCSOQe6uYJCjX?=
 =?us-ascii?Q?P6F+w6oEe/agdxOhULXqhblsBjThTbnX3/Rz/mfsUs1fajyBWdhVZm/ieEx3?=
 =?us-ascii?Q?3y47C8w/IYS6bvFRbzuwt8y+kbtsliSdOkERv+eWRqxRfJtM/A2wyJPd9Ol9?=
 =?us-ascii?Q?DA5pxgpAzS1MWwC6XRMP8fBkNoIcHz+Q1YTZhjV8Jka6wFYF0XhbZumKhisD?=
 =?us-ascii?Q?7cTsHGR0yQMeneeGRVeapEyduIGjHtW+ZE4sOQDGudYmRmw6t8xnvhye6CJ1?=
 =?us-ascii?Q?6UabspU+3z6QfGfI7Gsbe840ZOgr2kZv2iOwxtuSvuzbFngY8v1LiOE3emSL?=
 =?us-ascii?Q?If27LIxOtcueHvq5Dd9tntBRuVD0Ya88ukj7ifoIpXdzNLM65pwg+1sVFEYp?=
 =?us-ascii?Q?1LzCeZaXVkmU6mwkjvbRaNNrU9L59u8lxXTwqohljUBAq9umoCwAJoRucw2l?=
 =?us-ascii?Q?RJiHU8wO07XGEqJZ/7pecZXQuUvOXDZhXmZY9mfTDBj7CNZd2OjEPRNeAAoU?=
 =?us-ascii?Q?NCxTDytUNBs/weoVrdufQ5vPw4Kt3l62copnuxrD51ernRX39lLE6KHnR9El?=
 =?us-ascii?Q?hFUasVVCX7YqgbDgB9ffbnnuvYZQuiTtqLNuRVKVfZnW3/QDid8mzIiWI6OQ?=
 =?us-ascii?Q?gA1KR663s8A9nnZ4GA7LSFqqKvM4BTXmgdKT0S1e8/LuNV5yV2ZfUJX8UFMC?=
 =?us-ascii?Q?3JC9uEm104Yzw0HyXTy8ogbIZUz5FR9BmuxSW6DqaPd1pStAZw9cb3mna6ho?=
 =?us-ascii?Q?MATA9fPVI5zwdnI7Rcl4jJ6/hKBcsMRL/OSeGm2E4MQqewwHZLL02iAwbUTm?=
 =?us-ascii?Q?5IhsGUk3S1zh4uSs4JNrzPRqqSJCPgneiOXcofm2W/Fva5GZwNPUFeNYQLyt?=
 =?us-ascii?Q?x1+9uCa+AioA0A5aAWdLaLar0UlSM/vjJQxY74xPcfSK/F1iaUj3kmxgy3C9?=
 =?us-ascii?Q?3sYiPCiZ8VQmm/3VZ2vYx0FwcJFmJCYUyxOF1fnSSMPlfdRfur/3FK8Mbjos?=
 =?us-ascii?Q?2UkI75J+4QaiGc7+lxfsZyHLS5TPIwX1K3rAdRLFQ+wHEdtF7oqzLumDLSEa?=
 =?us-ascii?Q?RHzRG65hKoAm96Hwx/N7Wibvy5OrP+fxRqI7hwruqbsPo+usTZw9p0ogQs3q?=
 =?us-ascii?Q?6bxwtRTczAj3DxO5He1par1ndv2ZKx1m7wdameO1wgtkKCYioCPuGoyoQjBM?=
 =?us-ascii?Q?DyxbA44ect51NwN9PTjpqZMpTboPu5CnOPmO3qc8iw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb2a7dd-a04b-4c29-272a-08dc5faa49d5
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:20:17.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2794

This fixes the sound not working from internal speakers on
Lenovo Legion Y9000X 2022 IAH7 models.

Signed-off-by: ArcticLampyrid <ArcticLampyrid@outlook.com>
Cc: <stable@vger.kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 2 files changed, 3 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 8fb688e41414..ee195737d388 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -109,6 +109,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431F1F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 0, 0, 0 },
 	{ "10431F62", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "10433A60", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
+	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },
 	{ "17AA386F", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, -1, -1, 0, 0, 0 },
 	{ "17AA3877", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
 	{ "17AA3878", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 0, 0, 0 },
@@ -500,6 +501,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431F1F", generic_dsd_config },
 	{ "CSC3551", "10431F62", generic_dsd_config },
 	{ "CSC3551", "10433A60", generic_dsd_config },
+	{ "CSC3551", "17AA386E", generic_dsd_config },
 	{ "CSC3551", "17AA386F", generic_dsd_config },
 	{ "CSC3551", "17AA3877", generic_dsd_config },
 	{ "CSC3551", "17AA3878", generic_dsd_config },
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdcb28aa9d7b..ac729187f6a7 100644
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


