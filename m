Return-Path: <linux-kernel+bounces-149487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2628A91BA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 06:03:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C513CB22330
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 04:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A53535A2;
	Thu, 18 Apr 2024 04:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fvAJJSoh"
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazolkn19011003.outbound.protection.outlook.com [52.103.66.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB1C537FC;
	Thu, 18 Apr 2024 04:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.66.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713413014; cv=fail; b=jxyLCxefJGQwwWrACMlm0Bfz0YffKDclhjpVqIixGJi9j0x9Rn02V7xEXp/bZZFP0wHzVjUkqXwxvHY3KNQAsp/FFnbLLdJ40TFLqYCsWh3nqogDEKUgkQIS7nx2MrogzjeAD2mL2P3+SiWtfHy1ATZmXZaNOvDwIt+09pqJxGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713413014; c=relaxed/simple;
	bh=t8xp5apU8X+UApxP15kool4VAvFOg7C65GvCLLq0H00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McyUeQ/9Ur8zA9gofV/xmcAXqdjuTAP33pOTkJg0we3XjKyI0qjdxgBJ2Npx5mcZpqdtA5q1vEiIgJFfsDhWfThj0Zo3PauEW33aLYMSOI/YdLGH/YkwsHlVF1O6bPtGKg4WBDBt02NegTQhLOXRvRPUGzqElEG/7k3qXBEeRBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fvAJJSoh; arc=fail smtp.client-ip=52.103.66.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VOHzD2MARJyal1IwSt/td+FoSe1irbhwixj9iQ8ww2eoWV/DXtyMUwlQ5+9DgEGvwbkkngd3E0eRBTm3+id0aefUKed+9lnIXEUzNKzA1PPzV+B9Cw/oCuydhkBp78ccQOCVGU9GokTyiYZY0JAiKWr14sDGbQBXPa2U17fSRn1svzId/90SQ2b8N9SaC/a12677uyx2MzB2ROp7G+G1vnPoCTIRhB/yfDRsaBrOzaJeo4toF+/2VcZgRxxfzVObmg7A/qIW9l2vuRxhys0OguPxt9Y52bpB8mduqaX0iRErxVqDbIWQ8NLrc/KN4Py3tToPTYSEz7pWAe2pBretdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KuAVI16s5BB5VXUboJtA1/dc+fRBFo96cINyvpMMu7k=;
 b=h28GEePOqllhIAV1J5Up/Db9w4bZbaWoWaITKXDbKx3I9GoqYi8ArwMTh0Uaj86qf1P6yR7HD8DMFNtsNqZY9q9lqsgZNAcyfoIExONv/yJ+3moSJlgZmOu/0+3Oy1J6GHpo5TuFCrhN+xCwCfpGvW9bhpVGreD/ni9DF+Ez0cPnHKC5ak2OT68eI40vca0EzbipNUBkOLMJA30ywFbL1Ppz6I1ynsxYzXPAjeZORqvDrGE0dcDGDKLzzZ3q+rr1D2RcyoaNBCfwpPDDIl3fZfKjUTYRZnIQyIpQF0mfab9hcokkMa4GxAD0VNTt0ICxaP2FLf0jDk4MqbmelD3fmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuAVI16s5BB5VXUboJtA1/dc+fRBFo96cINyvpMMu7k=;
 b=fvAJJSohAbpKnwXhsnC8YGOoyjL1dYPEXCYgw4L98Hoe/sNWmZ7LHLl6A2y+enJbva/ew9xmxsPL2X638RV2iap7CpPOX8x3e8HT9lYzPCEdvFHv2iephblKdvBPVKjFWSPV6SG6zpfUAQ61tNq6Ew/X+BuVR9aR0KgyRCbsMKThSW1orjly/QyPrEw0vBw92FSjNEHmeVKrcbKu4bbzMRjCnDHsThJel3H9t/sc5UEAi2aCwoivRVMPH44lx+1ZPyZQ1INOzWPgBRU9+gJumhECudbisrERASYS5mal3nx8qF3ejMuue0D5tlqmnr9SSLlxwwbLi5mJqSjSol3lcg==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by OS9P286MB3909.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2ce::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 04:03:29 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7452.050; Thu, 18 Apr 2024
 04:03:29 +0000
From: ArcticLampyrid <ArcticLampyrid@outlook.com>
To: sbinding@opensource.cirrus.com
Cc: ArcticLampyrid@outlook.com,
	david.rhodes@cirrus.com,
	james.schulman@cirrus.com,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	rf@opensource.cirrus.com,
	stable@vger.kernel.org
Subject: Re: RE: Re: [PATCH] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Thu, 18 Apr 2024 12:03:17 +0800
Message-ID:
 <TYCP286MB253572FE78870D62C35E6CACC40E2@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <003501da90da$7495b710$5dc12530$@opensource.cirrus.com>
References: <003501da90da$7495b710$5dc12530$@opensource.cirrus.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [MVByz4WUmy8Cw7nATttwZWtAGhEdLr1Lz93J//y3ho+NIxt+EJdxIw==]
X-ClientProxiedBy: TYCP301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::12) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240418040317.7779-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|OS9P286MB3909:EE_
X-MS-Office365-Filtering-Correlation-Id: 73b8acf3-0892-4a0c-f06d-08dc5f5c8158
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+ifJSmX7MholYPde9ciazxGj1u2jDuf5tkoxoEE+ED46sP1HXboucmOVK1VauxujJTlIBkjcg0NtIgLoPsZ6154YqFNfH3e2HlpMgGcqH4806AHqVhUBtn1JCjHuFzym+mcPiVDRnfytxaMMjkHjyA8XGMcmolh0B4ErpELYZVuraL6SzsfMSkdRMQvyPTislIm8a4Bq8rcrbqW+7v//8BU3ttvOLqNYiRjlCRy26/gRA5UZwsE6YJHSRjTseZ9rjUuWeUlm0dV9fsZ9FKey18AGFqqfD0zmC1gw1QRqEWHdSy3FApUk5wTcFNiVHF32djW/vHVxFpzq3Z4N5GtcOU3bxtv0qz00VLtKeFXIuwvNs0urKZOalUFkrJvY4PyZfiZ/wjoVjajT/65IkxE9TTgXoLJKo/Sb/bapkcYzGtZEod6O53Qs8je8mpyMBT89f/7FV3B/Z/6c2S3LAKfaey1YwSelIIOKRepEgTebsK5rCYvfb+1L1GZbPVoBXVC/lgeETl55YqlONLcyAa/088a647m6Fy/wluUHZj/YamH7wD2jQyaAm3vaUg5AVGJmamNyVHd26mHbSkJbtcu4eORb3QZ8OJ9IqAWyNofxpniM4aFVNVlLCAn12HlDYjbfNE+9d/AyZPIiLmEAxedBQ43lbqHss/cjf2mX3PgjyMXFxPFc8/df2ud/RquApxfuEIWBYiH5sCnG2YixQFtNLWIxGoAiRIit4u3Q42SCoD3todBzwXE/uoPxXos/Tzod
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3nD+KQBqHQ4LLuTk/JIqFPTP388hgWuM799nakTrjwDiHr63Ic9vSlE7klTt?=
 =?us-ascii?Q?Wmnsfhx7YXWH9WLtF1+upfs1GVPOqRu+rbEXt48Lk5xL3KhCdjzGXUwKz2Rk?=
 =?us-ascii?Q?iUxIKkSu9LuTohvsrBvI2bOX1HcypXLDJzaPh0fTeu+FQiHBcm+b6+tjUz8M?=
 =?us-ascii?Q?vvvchuM2nS9o7uogucFw/qwSFYrDjjncM+V5zOd56nSe4OqbVv0qKoMNPY6e?=
 =?us-ascii?Q?JBenV1Tyzns2cqWiJ8PSPHEhuNhLML9r6p4NQlK5pqlMHPRIHWKId4eevWcE?=
 =?us-ascii?Q?LVW9BasqQHp/uDdy/pIe9fVC7kKa5+vFZntNsKXkBZlhsdnQS7Ct0iVUEFMo?=
 =?us-ascii?Q?yZEh8QQg/sG/8n/QD2DNmhUvSOEMhOodd4Alp4ROXzKxwiI05HiLEM9RNVMi?=
 =?us-ascii?Q?uPfIquy9JlesDUV0gcZoZdjKf09P5xCnBtKqyuFY9HnCFZ7D/hOxQk1nShQs?=
 =?us-ascii?Q?qH7zFgutmRzHc1fYg5DuzmBGZK2Sj3QxVyFaPnPpprUSTVOqoQsvd7lbIcc3?=
 =?us-ascii?Q?Rct/qLDgSKT8tDJZ2oZ1lS2g+d+Hyx94leXSLCSKkSsZXTkwA+2VWycOj1NN?=
 =?us-ascii?Q?82JxTQmg6qN4bhMKvFKlGo7gdMJwRkvMwtLKiprZ7GHCxxgGbuUdYwca6sbE?=
 =?us-ascii?Q?s/vnhsGN5OuLRk9pNP3SWUww8Ks09fuvNiDZlqd9pCWzQJFrFg84/hs/VtkO?=
 =?us-ascii?Q?RRlQmWTwQe34glLpK4xxdjae7f96Vr+8N09GCt0hLedn3HTiRPmGJJZmbqsv?=
 =?us-ascii?Q?aeWT+eHIOqoaQQS/+r7Wq+DQJ5YLwMKj5q3AgOz5MI0mxHP7sUNRU/8uqgtW?=
 =?us-ascii?Q?ZfhkIt/MRsz+IEOYEAVSWSoDmuU0g2kL18uUIKJMEs+FTQvkY3e9nG5ZFMQ2?=
 =?us-ascii?Q?oJlQcWPiEd8/JngZk1xU7wDTqX2+kfm4X5EZ292N0/l2FU5rCQBz1RzA9UVG?=
 =?us-ascii?Q?aUILKYjw6pm2yTRYQnSb2zXqhjiAys2dc4hL4HYO9SfK2xLu7JJsthRFMK7X?=
 =?us-ascii?Q?dYB2Qig8A/oKWFwfhgGDtWP34Ww/jHQ2pPzkwXWj6ft4f3XWk16DkwLBNNLJ?=
 =?us-ascii?Q?g1HwnjrSKooiTwdDH2aEfo+pHU4MsayS/b1YUfeYmhj0NcPlCMlYSFHDGlo1?=
 =?us-ascii?Q?vxMSNM4zWrp46j+z9Fkd9sv25eZTn1sIkFRYzKT5KfLzIU3uBS511CcR0t+l?=
 =?us-ascii?Q?wWmBR9Zrg45bM3utsV4C9Lm3nbtHmWtDGiKrKJ7uvWsKEUwlsJ7UPTVFu/61?=
 =?us-ascii?Q?Wj07bfR0h3F/7uzLZW1ifJzu9BKGg4RdXNvPqjQ6cw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73b8acf3-0892-4a0c-f06d-08dc5f5c8158
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 04:03:29.6800
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB3909

> To clarify, was the log you attached here using:
>   { "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0}, 0, 2, -1, 0, 0, 0 },
> Or was it using your original value (index 1)?

Both get the same log.

> For further investigation, can you create a bugzilla ticket at the
> below address and CC Cirrus Patches (patches@opensource.cirrus.com) to
> it.

OK. https://bugzilla.kernel.org/show_bug.cgi?id=218744

> Can you also mention which distro you are using, as well which Kernel you are using.

I'm using Arch Linux, the kernel is v6.8.5-arch1.

> Both amps use the same GPIO for the interrupt line, thus the interrupt is shared, and there is only a single interrupt line.

BTW, it's connected to APIC.

> Also, can you please attach a dmesg of the error

Without any patches, I got
```log
    Serial bus multi instantiate pseudo device driver CSC3551:00: Instantiated 2 I2C devices.
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Failed property cirrus,dev-index: -22
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: error -EINVAL: Platform not supported
    cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.0 failed with error -22
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Failed property cirrus,dev-index: -22
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: error -EINVAL: Platform not supported
    cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.1 failed with error -22
```

With `generic_dsd_config` I got
```log
    kernel: genirq: Flags mismatch irq 58. 00002088 (cs35l41 IRQ1 Controller) vs. 00002088 (cs35l41 IRQ1 Controller)
```
as memtioned in the previous email.

With my initial patch:
```log
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Adding DSD properties for 17AA386E
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Using extra _DSD properties, bypassing _DSD in ACPI
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cirrus Logic CS35L41 (35a40), Revision: B2
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Adding DSD properties for 17AA386E
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Using extra _DSD properties, bypassing _DSD in ACPI
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Reset line busy, assuming shared reset
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Cirrus Logic CS35L41 (35a40), Revision: B2
    Serial bus multi instantiate pseudo device driver CSC3551:00: Instantiated 2 I2C devices.
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Falling back to default firmware.
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware version: 3
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot.wmfw: Fri 24 Jun 2022 14:55:56 GMT Daylight Time
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: Firmware: 400a4 vendor: 0x2 v0.58.0, 2 algorithms
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: cirrus/cs35l41-dsp1-spk-prot.bin: v0.58.0
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: DSP1: spk-prot: e:\workspace\workspace\tibranch_release_playback_6.76_2\ormis\staging\default_tunings\internal\CS35L53\Fixed_Attenuation_Mono_48000_29.78.0\full\Fixed_Attenuation_Mono_48000_29.78.0_full.bin
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: CS35L41 Bound - SSID: 17AA386E, BST: 1, VSPK: 1, CH: L, FW EN: 1, SPKID: 1
    snd_hda_codec_realtek ehdaudio0D0: bound i2c-CSC3551:00-cs35l41-hda.0 (ops cs35l41_hda_comp_ops [snd_hda_scodec_cs35l41])
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Falling back to default firmware.
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware version: 3
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot.wmfw: Fri 24 Jun 2022 14:55:56 GMT Daylight Time
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: Firmware: 400a4 vendor: 0x2 v0.58.0, 2 algorithms
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: cirrus/cs35l41-dsp1-spk-prot.bin: v0.58.0
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: DSP1: spk-prot: e:\workspace\workspace\tibranch_release_playback_6.76_2\ormis\staging\default_tunings\internal\CS35L53\Fixed_Attenuation_Mono_48000_29.78.0\full\Fixed_Attenuation_Mono_48000_29.78.0_full.bin
    cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: CS35L41 Bound - SSID: 17AA386E, BST: 1, VSPK: 1, CH: R, FW EN: 1, SPKID: 1
    snd_hda_codec_realtek ehdaudio0D0: bound i2c-CSC3551:00-cs35l41-hda.1 (ops cs35l41_hda_comp_ops [snd_hda_scodec_cs35l41])
```

> as well as the acpidump of your laptop.

The full acpi dump is shared via
https://bugzilla.kernel.org/show_bug.cgi?id=218744

The related item I think in DSDT table may be:
```
    Device (SPKR)
    {
        Name (_HID, "CSC3551")  // _HID: Hardware ID
        Name (_SUB, "17AA386E")  // _SUB: Subsystem ID
        Name (_UID, One)  // _UID: Unique ID
        Name (SRS0, 0x09060000)
        Name (SIN0, 0x0908000E)
        Name (SID0, 0x09060001)
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (RBUF, ResourceTemplate ()
            {
                I2cSerialBusV2 (0x0040, ControllerInitiated, 0x000F4240,
                    AddressingMode7Bit, "\\_SB.PC00.I2C3",
                    0x00, ResourceConsumer, , Exclusive,
                    )
                I2cSerialBusV2 (0x0041, ControllerInitiated, 0x000F4240,
                    AddressingMode7Bit, "\\_SB.PC00.I2C3",
                    0x00, ResourceConsumer, , Exclusive,
                    )
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
                GpioIo (Shared, PullNone, 0x0064, 0x0000, IoRestrictionInputOnly,
                    "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
                GpioIo (Exclusive, PullNone, 0x0000, 0x0000, IoRestrictionInputOnly,
                    "\\_SB.GPI0", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0000
                    }
                Interrupt (ResourceConsumer, Edge, ActiveHigh, SharedAndWake, ,, _Y58)
                {
                    0x00000000,
                }
            })
            CreateWordField (RBUF, 0x59, RST0)
            CreateWordField (RBUF, 0x7C, INT0)
            CreateWordField (RBUF, 0x9F, PID0)
            CreateDWordField (RBUF, \_SB.PC00.I2C3.SPKR._CRS._Y58._INT, INT1)  // _INT: Interrupts
            RST0 = GNUM (SRS0)
            INT0 = GNUM (SIN0)
            PID0 = GNUM (SID0)
            INT1 = INUM (SIN0)
            Return (RBUF) /* \_SB_.PC00.I2C3.SPKR._CRS.RBUF */
        }

        Method (_INI, 0, NotSerialized)  // _INI: Initialize
        {
            SGRA (0x0908000E, One)
            SGII (0x0908000E, Zero)
            GRXE (0x0908000E, 0x03)
        }

        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }

        Method (_DIS, 0, NotSerialized)  // _DIS: Disable Device
        {
        }

        Method (_PS0, 0, Serialized)  // _PS0: Power State 0
        {
            ^^^LPCB.H_EC.ECWT (Zero, RefOf (^^^LPCB.H_EC.AM12))
        }

        Method (_PS2, 0, Serialized)  // _PS2: Power State 2
        {
            ^^^LPCB.H_EC.ECWT (One, RefOf (^^^LPCB.H_EC.AM12))
        }

        Method (_PS3, 0, Serialized)  // _PS3: Power State 3
        {
        }
    }
```

