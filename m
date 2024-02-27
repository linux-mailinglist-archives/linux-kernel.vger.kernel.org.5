Return-Path: <linux-kernel+bounces-84126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A0D86A26E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 832EC1C23596
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97D153509;
	Tue, 27 Feb 2024 22:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="mgdrnfev"
Received: from mail-4325.protonmail.ch (mail-4325.protonmail.ch [185.70.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162A1534EF
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072776; cv=none; b=raMux2mbeo8IkZkUG2dcsH6igEAg9YkjdXBCZfJdIZn7BHH2Y9eZav7ee6lJ7Dlk5RDUxpdX7YOiewkXGGGPr514glqW6Bv31BW54i1vsenEejH1oujAlJkIaww491gSjLWKkBinkV+6HsBe1bYDBZT3gNukj/pAGcpfofxbZYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072776; c=relaxed/simple;
	bh=A4nC+U6i2zuaNJHtf0qp+ny8dymIpEmyX/3aC8mVxDw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=TZA5oTJVrPjnxbsr9y3uc6zSh9EvPrkF0/AIOOM7j2mUTr1TvIpTPq9k5tVfnMPQ0Aij0SoZcosehk+xEjF2PYMrK9O3+6vZ9P++aRom6mok3hTXKq54iqQq7tv3Xp6l/5JvvMkVw9Ezp5Er0xLzy5/NZX8NT0WuZyJ/0LdFBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=mgdrnfev; arc=none smtp.client-ip=185.70.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1709072768; x=1709331968;
	bh=A4nC+U6i2zuaNJHtf0qp+ny8dymIpEmyX/3aC8mVxDw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=mgdrnfevA5ZJXhfb74NM50xQmPNFb3epDY3eBkAN1kNIS6tCkzmULxX/2Ob9PRvU8
	 lDmXA3RSF1FcUYViMjYKQd7FcSLGcuFMiMrnfAfev0sHnTGWLIWwFNLrhFDZm7K2hp
	 VQSf43vU4B7DHFGoB+VecLQ+S6i4aM+9j/o2PXQq/FwTqcwBTcOgATAWRSKZvw2Sfs
	 3rnvHM+Cb/31ZDUK2nbW/T4FAvSu7Fz8Ykke9c47axs7hmrffaIufyPtNi1wgzkwPV
	 h2Pf+OzNvk74AlosNxmzYM52yark9XoDQHFDwCM1Rs6ilkiIG47vNGaB749lwmX8p0
	 ILGvuYz1/foWg==
Date: Tue, 27 Feb 2024 22:25:59 +0000
To: cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?utf-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
Cc: =?utf-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>
Subject: [PATCH] ASoC: Intel: bytcr_rt5640: Add an extra entry for the Chuwi Vi8 tablet The bios version can differ depending if it is a dual-boot variant of the tablet. Therefore another DMI match is required
Message-ID: <20240227222540.11223-1-alban.boye@protonmail.com>
Feedback-ID: 10280386:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Alban Boy=C3=A9 <alban.boye@protonmail.com>
---
 sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards=
/bytcr_rt5640.c
index 03be5e26ec4a..05f38d1f7d82 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -685,6 +685,18 @@ static const struct dmi_system_id byt_rt5640_quirk_tab=
le[] =3D {
 =09=09=09=09=09BYT_RT5640_SSP0_AIF1 |
 =09=09=09=09=09BYT_RT5640_MCLK_EN),
 =09},
+=09{=09/* Chuwi Vi8 dual-boot (CWI506) */
+=09=09.matches =3D {
+=09=09=09DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
+=09=09=09DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
+=09=09=09/* The above are too generic, also match BIOS info */
+=09=09=09DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
+=09=09},
+=09=09.driver_data =3D (void *)(BYTCR_INPUT_DEFAULTS |
+=09=09=09=09=09BYT_RT5640_MONO_SPEAKER |
+=09=09=09=09=09BYT_RT5640_SSP0_AIF1 |
+=09=09=09=09=09BYT_RT5640_MCLK_EN),
+=09},
 =09{
 =09=09/* Chuwi Vi10 (CWI505) */
 =09=09.matches =3D {
--=20
2.43.1



