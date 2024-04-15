Return-Path: <linux-kernel+bounces-145587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF128A5823
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935B61C22243
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1167B8249B;
	Mon, 15 Apr 2024 16:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="erkeF3hM"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2050.outbound.protection.outlook.com [40.92.98.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D80882481;
	Mon, 15 Apr 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713199823; cv=fail; b=OJN0u1Amp5TGONJikYRRpct0SFOfJfFmoOAY/fX1FH2F0GfU6mHmANIZ3jq7z7qwJTIHDHMJZ2thWpTicOACm3kWjD6+AAKLEQf+k9BwXt/w/maNRGwBdZYV4XroTzaMZFCzv52CypBBw9YnzgIBf4+x5kAHvp1x0gzN2sTgzo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713199823; c=relaxed/simple;
	bh=mMZOnY0K4Fc3QzGHB5j6ckXrw+Taw1W8YRIGT+9ev70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oKFtS4seubsWxyatnhE9548b77YEk8TdP822pVgw0jkR9A6MRH5BSLtYeM0NroTxK/UkaUXpbnLWt0a6O154OKS6e7l/ZB2J75afYoVQgzSfRuyowTX7XSYrYSNwYZ/MWwTGmJYVdbUtUf0FFQWS3jT8aaj7CwnRyTiylHirs28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=erkeF3hM; arc=fail smtp.client-ip=40.92.98.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu+ElTKf4s2UK4YzeEZtdY3bAjoODbCgD+059dYjKPS7ymDoBtEAkHTH7B64F/hcoJRd2SmldDxo3j6OUr7GzPaqPc+3bmnL+OlC95NB/+811uTlnzNkmhx6an8hcxLPAmkFBhUXv1oJlDV3AUj7x1ZlN88lJy/Z2ScSKMmK7k9OKdHlhCSUbj1KgKd8yeSnXEYnJCxah0WIn6vLqn2NwTyby0VxiTZPIzjaHvSSBUrGY68Y8TP5peyEATiA2dBcv1u0HAh/DsUDxiGaE80/LTULExEJS5x9jeJ3PYcFQrEoiF+u2FgVO/I2RYU44MTt647HIY44w0ucDKjeK2U9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3xYj8C1JvpAs44JwAbQCPXmejjJKzZaQCp4yX0XBNyg=;
 b=hxtAR2SCdTAf1o0uOZZjvm5X4foQA8eUFY/6QSFj1lER9H6Jpwr6zCxS0/vriZmygmf2XxfRpGPHXD5OAUPyZI7ItvXsnVe8Gf5oLw0TgcFbbdYPOPUDIF+Zw7MwwLNVVwjO1WrEdis7KR5r2UT7DUXsMAUN7ihSOE6papC4UxuYNJ8rhQ1bRqcAITB0XK/ptBPDwIhSwnHjKVnMq92iBuF2vgUVrflyMCnq4NnoL90o5xt+jd4eqlWPEvU1o5lpkgWY2YFae+rv5vhX4wr3ES2uk5e4sfvStdCGUPqKnkFduJKkdykHX8VBUHz0CV1zp2mcEm1invToXvViDPACwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3xYj8C1JvpAs44JwAbQCPXmejjJKzZaQCp4yX0XBNyg=;
 b=erkeF3hMOUnOdgZO80px60OPD6byt271EVvXDlHYt1vDwtblIi8tdC/Iut1h9FfUqAxdbcrGDg9K0r/1yxBlFjs6HTju1B4gs/v6eItVOBQdlUFa/S49Z3/SNOTjTfWfCegqaGv65bb+O0jVbmI+PuCuOWNlenk4Atq3k14n1b0fpNntoDgIFX9Bh1577D2wK53qWxae2VxNO4o5ZS28OWDqOmTQwdXl0RElyu+EtYyVzcRrH0tQEv8huPitrRVLYSfLN4h/xng1PcjbqixBt1FcdlgY7XzJvfcQ0JXW988nT2nfZ+cNvQnw6sj0OqJ9pnJj0PkuHHmvBB050gJvzg==
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:209::11)
 by OSOP286MB3906.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 16:50:18 +0000
Received: from TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8]) by TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f2c3:e53f:2ea9:55c8%4]) with mapi id 15.20.7452.049; Mon, 15 Apr 2024
 16:50:18 +0000
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
Subject: Re: Re: [PATCH] ALSA: hda/realtek: Fix internal speakers for Legion Y9000X 2022 IAH7
Date: Tue, 16 Apr 2024 00:49:41 +0800
Message-ID:
 <TYCP286MB25356BFBD3D67D4E1FD09732C4092@TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <335eb6d4-424e-43e5-8990-3d87ad579e7c@opensource.cirrus.com>
References: <335eb6d4-424e-43e5-8990-3d87ad579e7c@opensource.cirrus.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [9y4zhtIbIlhqlJ8QCKEJLAi+q3WZ5GNnPnaZDr5I4fXnlbYqNVR74g==]
X-ClientProxiedBy: TYXPR01CA0057.jpnprd01.prod.outlook.com
 (2603:1096:403:a::27) To TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:209::11)
X-Microsoft-Original-Message-ID:
 <20240415164941.4495-1-ArcticLampyrid@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB2535:EE_|OSOP286MB3906:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc8a9c9-86ed-4b81-41eb-08dc5d6c215c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cNE9zPy3aMjas//GQm7rgGr0WfEORC8dN/6FZJlwyVtBnkAI2W3xzwyz7lEGa/vWBBW82fxTLp6OZFLQ3gr8OikfryFsOkC+elM2uZmfM0IsH/AYfLDvdTc73mF4yPNC85J4Eo9fBSsvJEDQMfmknYVLc45+x6/U30RCNoip4RQtUNOJm5WrxFlLnIW2G6mtdKBXMZEn9vQIjrbh4Q1tM73dOBCb4x1a3cfBHep/76mvg3WVARR5aImu6YKBlK+pU08Jikd8IqBQLK6rA/nzmLPIlrxI+DN3eoMdItzzZRC0H51/7NFhG1x67V6IoLk5ESHKYJJBQjX0DwOIVeyMLDpGNKEHnFkO/86CfHdhHZ0pdqKaU967OzRUVwmgVT1iCyrUL/4lE2yZa+EFoJDPg5CT4flwT8w2JRSiMoBNvHGi+iR12IAAhDClh0N5zrMeSw8npUZ/fSSoL9LwKAxn6Gi5RpOf7kGisy+DxqJ1oPxeiYf3ws9DdN69uxeIfNWZDKfc7Q5s3OZ1mYT9qJgUTB47uWi2y5c7/eG8ez2BWvfntwRo2bneMNeNWCvR1ndFbPXvqO7rhT16VT5ZHzUgEOfNE0vAjlKj0/yuua+NZOLVcL645qn5tJ1anCdeJOCM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cATY71u9wXt/znaETbL0UDKvWqQrxumO+a896XpjbP+1y0oJWcwKneymWLez?=
 =?us-ascii?Q?Rsn+4i5PkORrwevLH4+svDwkBBWshTqtDF4/X06enUGo/hgXLRbmgbuvv6es?=
 =?us-ascii?Q?pJegqNVwn146AADws1V17BkOJCBVamunQ+xVHZNMpckr4BaHclrutT11Kpbj?=
 =?us-ascii?Q?UKDgSJoVMyzttXUC717qVLCGxBqG43G/R4zSxJz7j8x6QjfFyNAuODMyQzzB?=
 =?us-ascii?Q?XcCP5DuOfcf8B51wBZqBS3oQsTpk9YES0vme5iyNSAQCdIvvi5KnyvaD0L0V?=
 =?us-ascii?Q?mQAHvpE54Rz7GPriw/KFHGu/6UoKx8WoELbAdMN411oMVKRbPh0K3MBe/irh?=
 =?us-ascii?Q?8UuK8T2ATjRysXtjYKCstD/tmS3FySItRXGCSs03hUau9PHaT1kDcKj4gTNe?=
 =?us-ascii?Q?bXISW/t2acmLfpdlJGsPM3rW8APHbVkx924jYFsfGL1f/PcCWOblVXu9Bk+z?=
 =?us-ascii?Q?9TV7BhGi967BrqdDF/uOewj+RymL+qU0r5kfeflocZY2FSJhCq9PLmObN1HU?=
 =?us-ascii?Q?kAjiiiUANp9DoK0lZXfgCz8UXtoUjpcbZrKaDdUSreNk3p5+XGdqlwW1kURe?=
 =?us-ascii?Q?wtcqVrcLqnvAQUjXAXdR+5p5dB0AyCweZ1tm9xWTSsfjS03as7PlkQ9oOFoP?=
 =?us-ascii?Q?jaoH/OSyM7mbSWYcYZbTBIrBuQkYhTN7O/OYd3+tB5Fax3ZOC+ysfF4try0+?=
 =?us-ascii?Q?V5NKjvuk/DFsRDp1/ybLtHXLMOEa/reZX8tm1QUVjlVRI0x/2geXA0A19pJp?=
 =?us-ascii?Q?rIB8I1yaSF49+u2uLc+dkushlCaq3GsR7piYSPYc67Minkz7zPPehFRxm6j3?=
 =?us-ascii?Q?1ZLpzLMzv/0JH5BS32UTvGYGGGoXKk+rD0Mjcn+R+Li6LVikIIPw4ECwlWLF?=
 =?us-ascii?Q?oAgMoZktOPCPeKVF0Aqz7U6CMl9qttlRE/MVdYC1VLyLRe7UJ4C2Uu5Q9ax5?=
 =?us-ascii?Q?J1UJTRfe/+Nd8mE4CTXwzmGNGK7GvS2INK5276ZndTzvSYY9dFspZiXRjZU9?=
 =?us-ascii?Q?ccykhlJEFQBt5kt6wHj+EW3caSYLcLyQsHBoc25bRyqDPTH0Lg3H75hfgbjo?=
 =?us-ascii?Q?ydUP+afiHIAVMbpHWnPDYA5Jswroz1QCiEXn2M2/RbgmPwC1jKmYmvHRRJxH?=
 =?us-ascii?Q?enVWnLh0GTaihgd/sFwoImmcf9K24j6FbGUmvYEWYfld0vmQtlNqC53LagHC?=
 =?us-ascii?Q?7BRXVf8gIMr9TTf/F+EvlM6IXyMyjgfbFURyMr5yE6gFz0k5W9Syh45YoxQK?=
 =?us-ascii?Q?/rj10bvW1uC7j1nUp+07j/+0VJ230B2x6tah0wyyi+orRBiVkKVGVWMA8Brj?=
 =?us-ascii?Q?HIM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc8a9c9-86ed-4b81-41eb-08dc5d6c215c
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB2535.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 16:50:18.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB3906

> According to the ACPI that I have access to, this is not correct - the
> Speaker ID is on index 2 not index 1.
> Index 1 has a reference to the interrupt line. Therefore this should be:
>
> 	{ "17AA386E", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 2, -1, 0, 0, 0 },

Sorry, but I'm unable to retrieve the speaker ID index from my BIOS.
Please tell me how to check it, thanks.

I've tried using `spkid_gpio_index = 2`, but haven't noticed any changes.

> The reason for any issue you see may be
> because you have assigned the speaker id for the interrupt gpio in ACPI
> as mentioned above.

Despite changing `spkid_gpio_index` to 2, it hasn't worked with `generic_dsd_config`.

The journal logs show:
```log
kernel: Serial bus multi instantiate pseudo device driver CSC3551:00: Instantiated 2 I2C devices.
kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Adding DSD properties for 17AA386E
kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Using extra _DSD properties, bypassing _DSD in ACPI
kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.0: Cirrus Logic CS35L41 (35a40), Revision: B2
kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Adding DSD properties for 17AA386E
kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Using extra _DSD properties, bypassing _DSD in ACPI
kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Reset line busy, assuming shared reset
kernel: genirq: Flags mismatch irq 58. 00002088 (cs35l41 IRQ1 Controller) vs. 00002088 (cs35l41 IRQ1 Controller)
kernel:  cs35l41_hda_probe+0x94b/0x9d0 [snd_hda_scodec_cs35l41 5706d5af6d4d4abb9d294b49d5cd4cc8a51aad9d]
kernel:  ? __pfx_cs35l41_i2c_driver_init+0x10/0x10 [snd_hda_scodec_cs35l41_i2c 8858b01ad506c8ac36ad9a656c7cb71d39d6ec09]
kernel: cs35l41-hda i2c-CSC3551:00-cs35l41-hda.1: Failed to request IRQ 58 for cs35l41 IRQ1 Controller: -16
kernel: cs35l41-hda: probe of i2c-CSC3551:00-cs35l41-hda.1 failed with error -16
```

I believe this error might be caused by the configuration of the same IRQ multiple times.

Additionally, I checked the Cirrus SmartAMP driver on Windows, which appears to use only one IRQ (ID 58) on my device.
Therefore, I don't believe there is a need to configure two IRQs on my device.

The message `Flags mismatch 00002088 vs. 00002088` is confusing.
Further investigation reveals that the following check in `__setup_irq` failed:
```c
if (irqd_trigger_type_was_set(&desc->irq_data)) {
    oldtype = irqd_get_trigger_type(&desc->irq_data);
} else {
    oldtype = new->flags & IRQF_TRIGGER_MASK;
    irqd_set_trigger_type(&desc->irq_data, oldtype);
}

if (!((old->flags & new->flags) & IRQF_SHARED) ||
    (oldtype != (new->flags & IRQF_TRIGGER_MASK)))
    goto mismatch;
```

While the previous request used flags `0x00002088 = IRQF_ONESHOT | IRQF_SHARED | IRQF_TRIGGER_LOW`,
the `oldtype` was actually `IRQF_TRIGGER_RISING` (0x1) rather than `IRQF_TRIGGER_LOW` (0x8), leading to the mismatch.

I am new to Linux Kernel, not sure if this is expected behavior or a bug for `IRQF_SHARED`.
Ideally, a clearer message may be provided to facilitate understanding.

Sorry to bother you if I make some foolish mistakes.

