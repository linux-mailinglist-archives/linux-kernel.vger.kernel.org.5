Return-Path: <linux-kernel+bounces-150742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB108AA3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8951C20FD1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7231836FD;
	Thu, 18 Apr 2024 20:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nHVRut7M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC7713D626;
	Thu, 18 Apr 2024 20:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713471762; cv=none; b=rARuJyKe1IQEfHkTxnoDNtStBJBj7TvOr679CGcRSNjAsVO45z7VahwDdBqX4sh1/q94AIxg+PFHy0uwUtrwogH2yWJXZClGUZpVynooFUYXoNMJLEa4Shjmbdh2kbndN7S+++qoGFQEJndhBYvjmbMINBJOeYTkjbqCgtWMYgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713471762; c=relaxed/simple;
	bh=40SDlxrTEy1tKYcd/loaYV6z14zKTw8+g0WRYTiJ/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hnHupSuURrIwTEo6wd+sdLD+j3SUJTCtI/FokMRRKvAPxuy8I7ddO7qPX1UaE1UxQrWYU8VPCP25PQ+11XV96Bpj7J4oxNnGp65Zcq6ZL6JVvkc2qMTXYZLj0qfM2QQ0ZWqsgTe0jBmxSULnjNaVFbHMmT8t4tUKQQI++ejuKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nHVRut7M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB98BC113CC;
	Thu, 18 Apr 2024 20:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713471761;
	bh=40SDlxrTEy1tKYcd/loaYV6z14zKTw8+g0WRYTiJ/ks=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nHVRut7MRgBEAkVf8AHawXLsTxYwcLi9zi/FHqkACKu0XmdEJZcwvxmO7Tg3l2hJc
	 kYOcW0eR7xm5UmiMUD0o3potGz1qT05c1CFdHQx1yTLCPFqp6HpAsmUtsmWNb8jabn
	 9iZ/6h9TPocn6hF5c5W/ErWDI0L4fM5Z6OUOp6THhRp4RyLBl6Vq+ZZwGiGMWF9Kyh
	 wW3N6GYbU9q8gfFi+GvW9zcvOy2m6dhqnEyanb1Pe93DwsbSBnc753somSKVUtX+dT
	 BcaA+Om88/hUx9bPbFY7SnIB/xQIrc6eqfFjmlKNT3a9n9O7ZwKJSnyXFwxufYSeSP
	 3UKuacSS4S/IQ==
Date: Thu, 18 Apr 2024 21:22:35 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?=
 <amadeuszx.slawinski@linux.intel.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bard Liao
 <yung-chuan.liao@linux.intel.com>, Brady Norander
 <bradynorander@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown
 <broonie@kernel.org>, Mark Hasemeyer <markhas@chromium.org>, Takashi Iwai
 <tiwai@suse.com>, linux-sound@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: intel-dsp-config: Fix Huawei Matebook D14
 NBLB-WAX9N quirk detection
Message-ID: <20240418212235.6548447d@sal.lan>
In-Reply-To: <848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
References: <5e6ba980c0738199589749b68b83f2d730512107.1713430105.git.mchehab@kernel.org>
	<20240418110453.10efcb60@sal.lan>
	<848bcc94-3a31-4fb4-81bc-bd3f138e12f6@linux.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 18 Apr 2024 08:24:10 -0500
Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com> escreveu:

> On 4/18/24 05:04, Mauro Carvalho Chehab wrote:
> > Em Thu, 18 Apr 2024 09:48:27 +0100
> > Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> >   
> >> Newer Matebook D14 model comes with essx8336 and supports SOF,
> >> but the initial models use the legacy driver, with a Realtek ALC 256
> >> AC97 chip on it.
> >>
> >> The BIOS seems to be prepared to be used by both models, so
> >> it contains an entry for ESSX8336 on its DSDT table.
> >>
> >> Add a quirk, as otherwise dspconfig driver will try to load
> >> SOF, causing audio probe to fail.
> >>
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>  
> > 
> > Worth to mention that I opened an issue on Github about that:
> > 
> > https://github.com/thesofproject/linux/issues/4934
> > 
> > I added there the ACPI DSDT table as a reference.  
> 
> This sounds like an 'easy enough' fix, but I don't have a burning desire
> to start adding quirks of this nature. To be clear, the entire support
> of the ES8336 is an absolute nightmare that I've stopped looking at
> completely given the lack of support of vendor/OEMs.

Heh, I know the pain, having working myself to have some support for audio
on two different notebooks with my siblings, both with es8336. On both 
cases, the BIOS info was not really useful, requiring quirks to make device
to work properly.

This is btw a common issue I'm aware for a long time: BIOS data is
not reliable, as vendors tend to re-use BIOS from one device on others,
without actually reflecting what it is on each device.

The EDAC subsystem never relies on DMI data for memory banks - as even
server BIOS from top tear manufacturers usually report wrong data for
motherboard's DIMM labels. Instead, an userspace application reads
DMI data and propose changes, but patches for rasdaemon are required
to add such labels to a database.

-

In any case, this specific device doesn't have es8336 ;-)

Also, I don't think this problem will remain confined to es8336: any
other SOF driver may have the same problem: a BIOS (or a BIOS update)
may add non-existent _HID devices to DSDT, causing the driver to
disable AC97 support, enabling SOF instead and causing regressions.

As I wrote at the Github issue, one solution would be to do an I2C
scan to detect if the SOF device(s) reported by BIOS are really
present. This would require that, before calling 
snd_intel_acpi_dsp_driver_probe():

	- the I2C bus to be created;
	- Runtime PM for the audio device needs to put resume the
	  device and I2C bus controller, if suspended;
	- the I2C address of the audio device needs to be known
	  by sound/hda/intel-dsp-config.c

With that, a zero-byte (or one-byte if zero-byte not support)
read or write could detect if the device is there, before
initializing it - or calling the device-specific driver.

Another solution would be to probe the SOF driver, falling back
to AC97 if SOF init fails.

> 
> In this case, the ACPI table is completely wrong, we should try to
> 'mark' the ES8336 device as 'not present' or detect the presence of HDaudio.
> 
> Andy, what do you think and what would be your recommendation?
> 
> >> ---
> >>  sound/hda/intel-dsp-config.c | 16 ++++++++++++++++
> >>  1 file changed, 16 insertions(+)
> >>
> >> diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
> >> index 6a384b922e4f..8e728f0585dd 100644
> >> --- a/sound/hda/intel-dsp-config.c
> >> +++ b/sound/hda/intel-dsp-config.c
> >> @@ -46,6 +46,22 @@ static const struct snd_soc_acpi_codecs __maybe_unused essx_83x6 = {
> >>   * - the first successful match will win
> >>   */
> >>  static const struct config_entry config_table[] = {
> >> +	/* Quirks */
> >> +	{
> >> +		.flags = 0,	/* Model uses AC97 with Realtek ALC 256 */
> >> +		.device = PCI_DEVICE_ID_INTEL_HDA_CML_LP,
> >> +		.dmi_table = (const struct dmi_system_id []) {
> >> +			{
> >> +				.ident = "Huawei NBLB-WAX9N",
> >> +				.matches = {
> >> +					DMI_MATCH(DMI_SYS_VENDOR, "HUAWEI"),
> >> +					DMI_MATCH(DMI_PRODUCT_NAME, "NBLB-WAX9N"),
> >> +				}
> >> +			},
> >> +			{}
> >> +		}
> >> +	},
> >> +
> >>  /* Merrifield */
> >>  #if IS_ENABLED(CONFIG_SND_SOC_SOF_MERRIFIELD)
> >>  	{  

