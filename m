Return-Path: <linux-kernel+bounces-49146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8301F846682
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 144FB1F2557E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230FCD27F;
	Fri,  2 Feb 2024 03:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=135e2.dev header.i=@135e2.dev header.b="BxlicnwD"
Received: from mx1.135e2.dev (unknown [192.227.193.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673728479;
	Fri,  2 Feb 2024 03:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.227.193.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706844472; cv=none; b=WBKHLo54IhCsOISgqo5qr6USpVQuSsWxDR0jJ5zIV7cdEVNtCqdEHRKy4n5VCDfbInDMKQTuQ++AkrSfHzmmXhnW4r+6zpdPbO22ww9300cypTxDXF7BhBRLEnwwQCovWfc0lb8csxUJdbNXJZA/uOZM0ThQ4TrdW36J0PwGb40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706844472; c=relaxed/simple;
	bh=Si4Fpi4Zt3/wkiQXc7LEba2uEw20yGovMPeMTq4B4jc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Idu4JczeFr+PpT1ykk24Fxj8YGtNNFhhaAvVlHbkN+VFb8hB2DNXkLeMbmtLZzI14a/bJTitlyLuB2t5cZ8MMR7vN4mCNJSX9lrkEsdiDwFqpwItsYwvs7zChmDrCqyS9vjaYiTxC58yK8typR1DuZaoQ10GJeGu8+wtln7/al8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=135e2.dev; spf=pass smtp.mailfrom=135e2.dev; dkim=pass (2048-bit key) header.d=135e2.dev header.i=@135e2.dev header.b=BxlicnwD; arc=none smtp.client-ip=192.227.193.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=135e2.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=135e2.dev
DKIM-Signature: a=rsa-sha256; bh=iK915+z9S4n8pu5RcTV8cEzXvYlmbw06d1vH3FCQZbQ=;
 c=relaxed/relaxed; d=135e2.dev;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:Message-Id:Message-Id:References:Autocrypt:Openpgp;
 i=@135e2.dev; s=default; t=1706843543; v=1; x=1707275543;
 b=BxlicnwDy8+jnrrSQIEg6N98s+HdFzwAF4G5/OxrDhQAgCoIojy8GmPLzEo1O836zunQfqjD
 ddOu3etzgisZ9PoUxwgAZZt18/th19+Nclxp6a6y6Sw+axonhzb9q6A+/gaBAH2z1bE6AWGWjdL
 uCAP//VRJTVIQWqHnetcbdDVmcRtV6Xm5jHFPJzK8QjJfkIDeHdGVqSptH71FWAvpv9DLskUBYe
 odFEwSF4GeBGbXmrfBSuKcI2hcYmKFP7lhp46EZ2svwjbxG3I2kvvTdXOiRY4NIMoStfjUMpfGx
 XMFu9MFUUs2ES7c+m7fSwcJD5QIZtnoevacwiVxlpnLRA==
Received: by mx1.135e2.dev (envelope-sender <135e2@135e2.dev>) with ESMTPS
 id bbaa66b6; Fri, 02 Feb 2024 11:12:23 +0800
From: Mole Shang <135e2@135e2.dev>
To: stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, peter.ujfalusi@linux.intel.com,
 ranjani.sridharan@linux.intel.com, sound-open-firmware@alsa-project.org
Subject:
 [REGRESSION] 6.7.0: ASoC: SOF: refactoring breaks sof-rt5682 audio on
 chromebook; successfully bisected
Date: Fri, 02 Feb 2024 11:12:18 +0800
Message-ID: <6013930.lOV4Wx5bFT@ayana>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

I'm relatively new here, first time reporting a regression, so apologies in 
advance if I'm doing something wrong.

I'm using Arch Linux (linux-mainline kernel) on my chromebook Acer Spin 713-2W 
(Voxel), and after upgrading linux-mainline from 6.7-rc4 to 6.7-rc5 the audio 
setup isn't working anymore. Firstly I suspected its some changes in the sof-
firmware, yet got no luck in upgrading sof-firmware (2023.09.2 -> 2023.12). 

On certain chromebooks, audio setup needs custom ALSA ucm confs [1], but after 
contacting the chromebook-linux-audio developer [2], I think it's not a conf 
problem, but rather a kernel regression.

After hours of bisecting, the first bad commit 31ed8da (ASoC: SOF: sof-audio: 
Modify logic for enabling/disabling topology cores) ensures the regression. 
demsg log pasted below:

// before 31ed8da, working
[   61.572587] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 
0x60010000 (msg/reply size: 108/20): -22
[   61.572593] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for 
stream 1
[   61.572594] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_hw_params on 0000:00:1f.3: -22
[   61.573247] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 
0x60010000 (msg/reply size: 108/20): -22
[   61.573250] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for 
stream 1
[   61.573251] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_hw_params on 0000:00:1f.3: -22
[   61.573888] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 
0x60010000 (msg/reply size: 108/20): -22
[   61.573892] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for 
stream 1
[   61.573893] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_hw_params on 0000:00:1f.3: -22
[   61.574570] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 
0x60010000 (msg/reply size: 108/20): -22
[   61.574572] sof-audio-pci-intel-tgl 0000:00:1f.3: HW params ipc failed for 
stream 1
[   61.574573] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_hw_params on 0000:00:1f.3: -22


// after 31ed8da, broken
[   48.930740] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 
0x30020000 (msg/reply size: 12/0): -13
[   48.930762] sof-audio-pci-intel-tgl 0000:00:1f.3: failed to free widget 
DMIC0.IN
[   57.235697] sof-audio-pci-intel-tgl 0000:00:1f.3: ipc tx error for 
0x30030000 (msg/reply size: 16/0): -22
[   57.235701] sof-audio-pci-intel-tgl 0000:00:1f.3: sof_ipc3_route_setup: 
route DMIC0.IN -> BUF4.0 failed
[   57.235703] sof-audio-pci-intel-tgl 0000:00:1f.3: 
sof_ipc3_set_up_all_pipelines: route set up failed
[   57.235704] sof-audio-pci-intel-tgl 0000:00:1f.3: Failed to restore 
pipeline after resume -22
[   57.235706] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.235926] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.235966] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236006] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236041] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236074] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236107] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236141] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236173] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236205] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22
[   57.236239] sof-audio-pci-intel-tgl 0000:00:1f.3: ASoC: error at 
snd_soc_pcm_component_pm_runtime_get on 0000:00:1f.3: -22

Steps to reproduce:

- Run chromebook-linux-audio script [2] (this would install custom sof-rt5682 
ucm confs [1] into /usr/share/alsa/ucm2/conf.d/sof-rt5682 and write a line 
`options snd-intel-dspcfg dsp_driver=3` to /etc/modprobe.d/snd-sof.conf)
- Reboot, gets audio working on kernels before 31ed8da
- Install latest stable kernel (6.7.3), audio broken
- Install latest git kernel (6.8-rc2), audio broken
- Revert 31ed8da, build upon latest linux-git (6.8-rc2), audio working

Apologies for my busyiness that I should have reported it long before the 
regression enters stable and lts, but sadly linux-lts (6.6.13) seems to be 
affected too [3].

Please let me know if there's any other thing that I can help debugging.

-- Mole Shang

[1]: https://github.com/WeirdTreeThing/chromebook-ucm-conf/tree/main/sof-rt5682
[2]: https://github.com/WeirdTreeThing/chromebook-linux-audio/issues/70
[3]: https://github.com/WeirdTreeThing/chromebook-linux-audio/issues/
70#issuecomment-1911048309


#regzbot introduced: 31ed8da1c8e5e504710bb36863700e3389f8fc81



