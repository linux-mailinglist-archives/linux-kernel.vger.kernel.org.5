Return-Path: <linux-kernel+bounces-51588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD845848CDB
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 11:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05921C20CB4
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649DB1C29F;
	Sun,  4 Feb 2024 10:30:37 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E0A1BDCE;
	Sun,  4 Feb 2024 10:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707042637; cv=none; b=sTiz+F+EgMbEP1smL6rtEAKmVfSthVFSzFUW0mjqlCYnm2xRFgs7eQVFRg19Uw4pkCWMQFAIaLYLuLhFOwjd/h7se52cQUT1KrHch9vDZvogAv2FhJ7nkfpSAxbUl7+F3RfZaXcp2Exj/Dzu+xFBVNZBGytfjtxlzpYrzticXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707042637; c=relaxed/simple;
	bh=WSt0ugTObffRIZxYeEJE8GCvAYp/dWhBtbXraMzfmZ8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=tV8llCWC/z6WX892bJrM0NCZM8kmbx8gyF9pHHsCUQOzt1z5lDUKKXxeuS+MtbPmnAiwQQAHjCwPaHgYABD7aqQJHogozGTJ92pLAkaVzumrfmMNmHLI6vQwhHCmP2p25PrCqFsgusFbGmFCfgp462hZdg3YUM2a4GZ2IqkEotk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rWZlb-0004gP-2L; Sun, 04 Feb 2024 11:30:27 +0100
Message-ID: <c5d7aa0c-de4b-4409-a3cb-63771f91dd6b@leemhuis.info>
Date: Sun, 4 Feb 2024 11:30:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [regression] ASUS G712LV audio apparently never worked OOTB and since
 6.7 not at all anymore
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
To: Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Cc: linux-sound@vger.kernel.org,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Content-Language: en-US, de-DE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707042635;1b2349a9;
X-HE-SMSGID: 1rWZlb-0004gP-2L

Hi! Bagas (many thx!) pointed me to a report about a sound regression
with 6.7: https://bugzilla.kernel.org/show_bug.cgi?id=218429

The reporter did not bisect the issue. But maybe you folks might
nevertheless be interested in this or even have some idea what might be
wrong. That's why I decided to write this mail, as quite a few kernel
developer miss if a report for their subsystem is submitted to
bugzilla.kernel.org.

To quote from the comment with the initial report:

> 2020 Asus ROG Strix G17 Laptop - Model: G712LV
> Intel i7 10750H Comet Lake CPU
> 16GB DDR4 RAM
> 
> Issues with Intel HD Audio controller
> Fresh install of any Linux distro leaves no audio from Intel HD Audio controller.
> Controller is detected and Linux thinks audio is playing, but nothing comes out of speakers.
> 
> Custom modprobe needs to be created to restore basic sound output functionality.
> Add "options snd-hda-intel model=asus-zenbook" to /etc/modprobe.d/alsa-base.conf
> This allows for audio output, but volume is either 100% or 0%.  There is no volume control.
> 
> The above setting worked fine with both pulseaudio and pipewire under kernels from 5.14-6.6.  This no longer works under kernel 6.7

For other comment please see the bugzilla ticket.

Ciao, Thorsten

