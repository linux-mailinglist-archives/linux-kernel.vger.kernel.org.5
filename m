Return-Path: <linux-kernel+bounces-150148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABAD8A9B01
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44212845AE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB0215D5AE;
	Thu, 18 Apr 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="DSVapmJm"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2086.outbound.protection.outlook.com [40.92.99.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB78BFA;
	Thu, 18 Apr 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446281; cv=fail; b=erPWBxGA7s04P6ViOJ6Bey8BKLV8y5DeQyuT9nAnBrl49xW827YJK0+WFc2czlkDL5/yY1/DlutvJoHJVxh6xgfcblrLm9MI4iyS7ARYngLYWAlVHlX6TemWbU0zxhLkFadUUHXQdaZdmtIWNxjgvRu79t2saNtO4+7VoE5tTsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446281; c=relaxed/simple;
	bh=WmMBL740Kk82hhBqCL/pL7yLgmPweVZH2qCWFmFT7gU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=U0xjlX5nEYJEn5xE4iYIhwlrq92qb6Zh/AKRYOpue9PoEoavWdeD/nPQ6KgxmLMZ0aYvX/o3zL8Jxulpk5M16qa2RMxjlYxd3vAHrZ+ArdgOz1gettBgAtWNJieOQj1NUlADno07LFkCN764SgaJrnGCjOdI0CJ8xl4tIy9YBRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=DSVapmJm; arc=fail smtp.client-ip=40.92.99.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TehIuCPFGaOIquQMPutvbj0Saf3RL6JCN3ZMMXoM05XMmHe+1Dlwlrx1IAE+YlkIunWJJ3BMfP1LVq9Je8S1zZAvSuUSD9SmissvoWeoZpdAycWrpS3TaHvzJangnG5AS1Uy1bNDeYWWjB02hrAMf7G8HCwbSSNfWs0wBGPhcu8GV6x2bg6ToKVBLUVHE8QaSkKA86iIsCZvXMM4gwX/t2Cdtf28SSy6NiRCNzigKiSmR1U6/h0S77smrh3mKWUwiYk3cXyf1ZPn4xhEIRHUqqo1S3oQQIRf9pB/diSXypKwgl8I6gvZcx9JFY3825VxGCS1MT92JSOhRRWYsP23Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RRQNjA2yUi/ykrEJkfvRH7/e1C60cBn3WQodco5TWnM=;
 b=AgsrB6xFwbDUtby+0dlPSJ332n/RBOD9mmp5k9KTTdjWtf3ZVMDzWpcyobIgKthT2pYBRPqf9SsNEmwJhH1ShP+bNwhEJMCpEXIN3hVLvnFlpadEBWlK21kUfVSnDTQpnx/IKUkrBS3hU3ZrQlj+0dxtQfAheNfbG8PWJ/T6iPMuA++nFW8h6dRMHuBw/NC9EH41Rk43eEkbacyErtAxBqIHmqlp9lMknpNr3/VbKczgNzGzKskdiZ+jT1erUF2bPQPNEqZ4mdVOU52jSVYJz6K6OVJ8cPyJyGSI8AyL/Jke1qfOUL+YcqWRhe/gbIwkF5gVHmJ0YMeHLWC6N8BqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRQNjA2yUi/ykrEJkfvRH7/e1C60cBn3WQodco5TWnM=;
 b=DSVapmJmvVaOoFm0Xt7vQzZ/7mRh/XxDiC092tkRddsoPMTYV4XtIKqZ1KhIuEENBzuyOJHfog8RvWUTUiKGkWy3tyVKlbAzU/6Zm4aoqDHVUHsLInwgidxWUX7LKEoKsO72pYjggZ7yq8rhbgLeeBlqazDgUFi5mBsQxSaY7TrXv8wIOAJc6IS1S/ulQrElfEH0RdQMrfzh+vcbRqiF0xCUCxFSF9M7Bv5N6TBuySg80/7jgDy2K+uzfVhlgjvW7KCSNb0YYP2JUhR+Gi+AIQyWV84NbtL+3aUGsr3plAEM1xlyL2aZ1BeiqaVpWayTbb3ueX6np+c9Y8A9oO3C1w==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by TYWP286MB2794.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 13:17:57 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7472.037; Thu, 18 Apr 2024
 13:17:57 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: sbinding@opensource.cirrus.com
Cc: david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	ArcticLampyrid <ArcticLampyrid@outlook.com>
Subject: [PATCH v3 0/2] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 21:17:46 +0800
Message-ID:
 <TYCP286MB25357A4599E935F26A8AAB24C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Y8W3xzF5MbNfuG1QdkoZuhQKpCIP+IelmmyeBvUoaSmIgjhpdBZ/pA==]
X-ClientProxiedBy: TYCPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:3::25) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418131746.30298-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|TYWP286MB2794:EE_
X-MS-Office365-Filtering-Correlation-Id: e05e4004-09ca-4462-f466-08dc5fa9f674
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wZ03doDF5iflzuMwyk/H1poA13OSMCwjDtNKyHzxSTmhIg1woYKMzJfO7z/rLCBaRx6WeEMF/Q0iZNgvrqPXtG2FUM2JS9ZBZE5mFQPOEyswiyd4T9Bet+OWZU8cDgBJGEJKnlsfokzmPSIgvbiluX9Z3fzD27u2KalNz6SUf0vFHg6anN7d/+je+LLiz7eBwJKf91OSI4heuXm+ProWUVAwIUgFkrbY4muaUenJ3TZv+JMuEcBihUKhR6OlMGe4eUkDWaqS7B0Zsti6IJEiJd32OTVXfYuNBywej4RI/BZM3YYHOaM8PEmJZOlUhnzByRsjKKyz4ZAAiFUnrwMcyPe8asDOcYIrYAxp2i9FQ2RdAS6Q6ddikVI36H2FNiBeldE4giNKTHvWVv5hfJ02btwR3Cew+emmYrigcoMxP8rhqj+1t4gPYrrEWETVHJVU1Co5uIkz5vDMf42p5kHHtzbMHkMJNFAZR11oQpSJrnW9KdZcJhauQDej/PpS7FxJaQx48LCbVwYMcYhsQDIPipzk9HiVyGi2FRt/SEN0cySfNOQjPvGXvOPf5ETKU0FgGTsOTpsj0C+plq6NnyYfDwXFViF7ER1rdbvrAc5aGhZThe7hG/dczi5x1QBehIXC/seu5o5mCT//9EZTAMaA4xJMsaLLspB6gvuuVbQLvS/aJQFRel1oevWZtcE8M3kLFhr1wu5gYbyXketbBATTHqdzHavZKqyJCxTNOks0U/Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2QalICdqaVDEj7amimYvP0gQrGCZ/tXUjvFOaPZmfhpdNvmWO1pGmsU0pxPr?=
 =?us-ascii?Q?2r0pzdQk7Rkn3s+NcTL5Q+83wbp64Zq4RVRcSq54tNG3i05j759bqTTmjfKv?=
 =?us-ascii?Q?z6zOXpqZEiEx7jFXUnTqMQpPX6Y9OLxP7KTEPUMgzk33WO9PJZC2zH/g2+5g?=
 =?us-ascii?Q?c8A74INfsGymTUlXlFeR5zBsJhULM6TMJ562Uexrm56TXF7vBrA/A5Jbni30?=
 =?us-ascii?Q?DsP/Wn+3M5n76Sqv4YlIb449jRplRlcdlHN6z0I6dfGOAb/b6uWCplJxPAWM?=
 =?us-ascii?Q?gpJHGcQIaG1hngHHlZqWPLz/uY4qPwBP785HePRFiRUzBi7RIrnmZHaDVXVw?=
 =?us-ascii?Q?FBNpw3XM8FFggBJqos15bExGLLvpi/a1/Mv5ZT4yzVBdsYOZ2I5Q1sp8frEZ?=
 =?us-ascii?Q?iFTU94XRe5IyyXZ6Jnpl3ZcqEAF4RIfAxs82xoifPE+Uwlm1B8iN+pcsJV6g?=
 =?us-ascii?Q?Kvlq16N+y0cK/zxcNf098Kvp0MqTBsyqeWG21raZk7MoD9jQFx3lYqV54fUz?=
 =?us-ascii?Q?o77AxZsfzx97PbtLvi74B/M6m+DnCJXFhuQ5A5Pv6NX9Oc7VkK1v1nwJ4TOD?=
 =?us-ascii?Q?Vn171BH/02sVFPgI+oKrL4L+1EHrSITIQ1FaVbV3240kncZTwqLvhG1YOKf7?=
 =?us-ascii?Q?6TAIlM6KAKuT6SV8i0g091yhdT2GHv53ZUmInvXj6BhcPx6c0yA2Wvm/L/0d?=
 =?us-ascii?Q?roWjzURnhMsdz7EZAMCJGKmb6ros7dDk89rG5fIu+FGrPwVUvbmDEhrYuTLq?=
 =?us-ascii?Q?0XkWyaSE9g3CmN70x2eigwrgaBuNWjEcsxWCUok4w4ZxL9KhrZPO3hS0p1n+?=
 =?us-ascii?Q?42PGjY2OLf4Z/1rd5CZM9QD4NCqM4NqUdbVWlMLTC903Na4G3kFrSfdKDtqA?=
 =?us-ascii?Q?eHdtZHZdf6Kf5/tJWR/B6FRABQGFO2aRiVwL5uFqzg/a9Yicp4ZyaCFyhSY5?=
 =?us-ascii?Q?5FkVelxysNaK/Fb7yJMaQWCbcMRodvOnqtA9K0hZgaWFaeFc/5+os+OBAuGK?=
 =?us-ascii?Q?+i2kPw3Hlx3OqVKMJwql+dpMhHCBzGlbm/loCL6fA8FPUdmfx+wq0QD4vBPH?=
 =?us-ascii?Q?cNni57hETNX3OPl1+4GktludL8cjhFpRUFF1mcowPdal3ROgJVTzrfQ5wjI9?=
 =?us-ascii?Q?3oyV964ciJzL51IE14rkCwYisCBzob/wdr1vy7mg1AVJzhxfSTk/JrybUkVT?=
 =?us-ascii?Q?X/DO1JRtrzxHXAZFCfbelqukeu+d5C8phxH0PczZkE6GIq21kUJjBjnV5JRX?=
 =?us-ascii?Q?C5XgM1uNYcKGNf9FvW10m/BMbK06J+3ORQV2xF9NAQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05e4004-09ca-4462-f466-08dc5fa9f674
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 13:17:57.2960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2794

This fixes the sound not working from internal speakers on
Lenovo Legion Y9000X 2022 IAH7 models.

Change from v2 ( https://lore.kernel.org/lkml/TYCP286MB253523D85F6E0ECAA3E03D58C40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/ ):
- Correct spkid gpio index

Change from v1 ( https://lore.kernel.org/lkml/TYCP286MB25352F3E995FED9CCE90F1F6C40B2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM/T/ ):
- Add a patch for cs35l41 to obey the trigger type from DSDT
- Avoid disabling interupts for second amps


ArcticLampyrid (2):
  ALSA: cs35l41: obey the trigger type from DSDT
  ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7

 sound/pci/hda/cs35l41_hda.c          | 9 +++++++++
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 sound/pci/hda/patch_realtek.c        | 1 +
 3 files changed, 12 insertions(+)

-- 
2.44.0


