Return-Path: <linux-kernel+bounces-40220-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F27983DCAB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 153341F2BC65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662321CA95;
	Fri, 26 Jan 2024 14:44:56 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08C11CF8C;
	Fri, 26 Jan 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280296; cv=none; b=Cz2vwnMP9Jsg7RVckT78ohsgw0e0AOvWRx16WHNzm9SOQxK7MF5oqVKBZzGwqCw9LeSj7BWOHtu2EZFllRRpAbNquJfTZWWQnqhmH+43MNncw3sxUpNFB6ZX0yOBu02NXU6nhKbD2YIZ5Wo2MODG49h5qXCwP4pw16x9cV2oBpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280296; c=relaxed/simple;
	bh=iKxKrZZumUw2D7E2QfLQOfnXzkK3E1UwnLFnz3pjiZU=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=K4CZfpcnset1Zlt5FllUb7Ty69xxMPozQ9xQvT/zlPyeozEd9AtzElPumEmNH67nTssumxf0+oxu21SgXH+/Z/TvL4CJXteyrBDne8dMR8Knv5rxmPMBUYIU5KDrE5Ylpsa6PcN8PHbRlOiJPYtel1nGtxHW2CjAwlLc6po2XLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rTNRl-0004oQ-P8; Fri, 26 Jan 2024 15:44:45 +0100
Message-ID: <41fd54bd-aebd-43e6-841a-6d8fa9672ab8@leemhuis.info>
Date: Fri, 26 Jan 2024 15:44:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, de-DE
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: Takashi Iwai <tiwai@suse.com>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: [regression] [Realtek ALC 1220] No sound from internal speakers on
 Kernel 6.7.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706280293;9b5aae8d;
X-HE-SMSGID: 1rTNRl-0004oQ-P8

Hi! Bagas (many thx!) pointed me to a report about a sound regression
with 6.7: https://bugzilla.kernel.org/show_bug.cgi?id=218409

The reporter did not bisect the issue and is unlikely to do that any
time soon. But maybe you folks might nevertheless be interested in this
or even some idea what might be wrong. That's why I decided to forward
this issue by mail, as quite a few kernel developer miss if a report for
their subsystem is submitted to bugzilla.kernel.org.

To quote from the comment with the initial report:

> When I got this laptop, I had to run a modprobe: ``` options
> snd-hda-intel model=clevo-p950 ``` to get sound from the internal
> speakers. This worked fine up until Linux kernel version 6.6.10. When
> I upgraded to Linux kernel version 6.7.0, the sound from the speakers
> stopped working.
> 
> With a little detective work, we could see that the cards detected
> have now changed order, where card0 used to the the Realteck one, on
> kernel 6.7 if was the nvidia HDMI one.
> 
> I was finally able to get the card order right, and can see that the
> clevo-p950 codec is loaded with the following modprobe line: ``` 
> options snd-hda-intel index=1,0 model=clevo-p950 ```
> 
> Unfortunately, this still did not resolve the no sound from the
> internal speakers. About the only thing I can see different on the
> alsa-info outputs is that the IRQ has changed for the sound card. I
> will of course attach all the logs I have.
> 
> Any help in resolving this issue would be highly appreciated.

For other comment please see the bugzilla ticket.

Ciao, Thorsten

