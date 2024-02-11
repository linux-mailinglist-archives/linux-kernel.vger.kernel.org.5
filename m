Return-Path: <linux-kernel+bounces-60774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E429850946
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BABFB21FE3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E435A108;
	Sun, 11 Feb 2024 12:47:02 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F392E851;
	Sun, 11 Feb 2024 12:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655622; cv=none; b=Ijo8pOaV1WvVpli0ycqSU1/XfcVevzYUVZvXS66rS2udR+6NEt1Tqnx1FPfMIhdJsJ2JzKZ4P6+9JyyCXqxubYMW2WTY7P2LPvr97KCV3mfEq/pNtLZkFr+fHdifh2HR/rHl0tNNA4nyxB8MKqjW35xJvu+i2iK3emulWISlQm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655622; c=relaxed/simple;
	bh=g01oYKENux7WU+WmZJ3B6XY2TJekh2CQzkEEp1gxiqo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HULrNf/RfdIgFJVw6aIYHWM3MiZuYhYgkipwHECPcRk41pzWqZEmLiUNH5ocwRy5NaON6dfhZroIrofuM2BAGWgyTZ74FG5m2s5R1GcJwKq6PV/RySnIhzByB0w/qwoBwbHcS6T5eBUvlsdIDwKU44/bNdTCD7rkuxO2lgMcVcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rZ9EW-0005Hj-Sy; Sun, 11 Feb 2024 13:46:56 +0100
Message-ID: <afb2124c-84dd-4273-8a91-ca0e16f417d1@leemhuis.info>
Date: Sun, 11 Feb 2024 13:46:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 6.7.0: ASoC: SOF: refactoring breaks sof-rt5682
 audio on chromebook; successfully bisected
Content-Language: en-US, de-DE
To: Mole Shang <135e2@135e2.dev>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 pierre-louis.bossart@linux.intel.com, peter.ujfalusi@linux.intel.com,
 ranjani.sridharan@linux.intel.com, sound-open-firmware@alsa-project.org
References: <6013930.lOV4Wx5bFT@ayana>
From: "Linux regression tracking #update (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <6013930.lOV4Wx5bFT@ayana>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707655620;fe1cf99f;
X-HE-SMSGID: 1rZ9EW-0005Hj-Sy

On 02.02.24 04:12, Mole Shang wrote:
> I'm relatively new here, first time reporting a regression, so apologies in 
> advance if I'm doing something wrong.
> 
> I'm using Arch Linux (linux-mainline kernel) on my chromebook Acer Spin 713-2W 
> (Voxel), and after upgrading linux-mainline from 6.7-rc4 to 6.7-rc5 the audio 
> setup isn't working anymore. Firstly I suspected its some changes in the sof-
> firmware, yet got no luck in upgrading sof-firmware (2023.09.2 -> 2023.12). 
> 
> On certain chromebooks, audio setup needs custom ALSA ucm confs [1], but after 
> contacting the chromebook-linux-audio developer [2], I think it's not a conf 
> problem, but rather a kernel regression.
> 
> After hours of bisecting, the first bad commit 31ed8da (ASoC: SOF: sof-audio: 
> Modify logic for enabling/disabling topology cores) ensures the regression. 
> demsg log pasted below:

Thx for reporting this.

For the record, in case anyone lands here and wonders if nothing
happened. The discussion moved elsewhere and a fix is heading towards
mainline currently:

#regzbot link: https://github.com/thesofproject/linux/issues/4807
#regzbot monitor:
https://lore.kernel.org/all/20240208133432.1688-1-peter.ujfalusi@linux.intel.com/
#regzbot fix: ASoC: SOF: ipc3-topology: Fix pipeline tear down logic
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

