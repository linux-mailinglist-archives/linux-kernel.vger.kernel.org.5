Return-Path: <linux-kernel+bounces-13352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06D98203E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 08:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1246F282384
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 07:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB9B20EA;
	Sat, 30 Dec 2023 07:27:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5B63D5;
	Sat, 30 Dec 2023 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 5CD412002DB;
	Sat, 30 Dec 2023 07:27:53 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id 1B011A0083; Sat, 30 Dec 2023 08:27:43 +0100 (CET)
Date: Sat, 30 Dec 2023 08:27:43 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Takashi Iwai <tiwai@suse.de>
Cc: peter.ujfalusi@linux.intel.com, lgirdwood@gmail.com, broonie@kernel.org,
	perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: Oops in hdac_hda_dev_probe (6.7-rc7)
Message-ID: <ZY_Gb8-rncuOjRq-@shine.dominikbrodowski.net>
References: <ZYvUIxtrqBQZbNlC@shine.dominikbrodowski.net>
 <87sf3lxiet.wl-tiwai@suse.de>
 <ZY7kosArPqhlCfOA@shine.dominikbrodowski.net>
 <874jg1x7ao.wl-tiwai@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874jg1x7ao.wl-tiwai@suse.de>

Am Fri, Dec 29, 2023 at 06:11:43PM +0100 schrieb Takashi Iwai:
> On Fri, 29 Dec 2023 16:24:18 +0100,
> Dominik Brodowski wrote:
> > 
> > Hi Takashi,
> > 
> > many thanks for your response. Your patch helps half-way: the oops goes
> > away, but so does the sound... With your patch, the decisive lines in dmesg
> > are:
> > 
> > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> > 	sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
> > 	sof_sdw sof_sdw: snd_soc_register_card failed -517
> > 	platform sof_sdw: deferred probe pending
> > 
> > With a revert of the a0575b4add21, it is:
> > 
> > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
> > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
> > 	sof-audio-pci-intel-tgl 0000:00:1f.3: Topology: ABI 3:22:1 Kernel ABI 3:23:0
> > 	sof_sdw sof_sdw: ASoC: Parent card not yet available, widget card binding deferred
> > 	sof_sdw sof_sdw: hda_dsp_hdmi_build_controls: no PCM in topology for HDMI converter 3
> > 	input: sof-soundwire HDMI/DP,pcm=5 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input14
> > 	input: sof-soundwire HDMI/DP,pcm=6 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input15
> > 	input: sof-soundwire HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sof_sdw/sound/card0/input16
> > 
> > Maybe this helps a bit further?
> 
> Thanks for quick testing.
> It shows at least that my guess wasn't wrong.
> 
> The problem could be the initialization order in the caller side.
> Can the patch below work instead?

Unfortunately, no:

sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware info: version 2:2:0-57864
sof-audio-pci-intel-tgl 0000:00:1f.3: Firmware: ABI 3:22:1 Kernel ABI 3:23:0
sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
sof_sdw sof_sdw: snd_soc_register_card failed -517
sof_sdw sof_sdw: ASoC: CODEC DAI intel-hdmi-hifi1 not registered
sof_sdw sof_sdw: snd_soc_register_card failed -517
platform sof_sdw: deferred probe pending

Thanks,	
	Dominik

