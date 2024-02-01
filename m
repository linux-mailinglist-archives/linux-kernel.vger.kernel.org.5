Return-Path: <linux-kernel+bounces-47981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 235068455A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF0041F21FD1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A584515CD4F;
	Thu,  1 Feb 2024 10:38:45 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D112BF2A;
	Thu,  1 Feb 2024 10:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783925; cv=none; b=lsvp6XpDux1FQLbAczl7vwogjNKLd9W7plNbM6hQSFr26IhzfucNt8uhBGUzCLfmhGKvHZMWntVyxRVPfyEet3qPVKGDLyJgEK7dqay/VA0hFZs6zPFx+Rjt7TSonuTbZonRADyK0KS5y4ARP6ZPdlhdX2eIxJYuck0oiE5ngEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783925; c=relaxed/simple;
	bh=Enaxd4sUSuDaik17Wd2LbaKPBEdbywYsGG9zjXDrseA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHqzNfW3wvcUiQIsm4xCvw8xCcQ2PqUTkUWitbMJesOh8deMRDBc0HFBQVEdvyTQXhU+Ol7ZS52UljsvfSvToEyk578QvDuJ221MbkZ2R9kiIzsgb20AWsrKtuh8B38dNpdwKZjNYGgZJPy6eMA4KwVZInzPpLLd4OONjUixLpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rVUSt-000667-8s; Thu, 01 Feb 2024 11:38:39 +0100
Message-ID: <07f1cb33-e908-48cb-85f9-83a040b2ca5a@leemhuis.info>
Date: Thu, 1 Feb 2024 11:38:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Platforms supporting SGX fail to kexec due to
 96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
Content-Language: en-US, de-DE
To: Mike Rapoport <rppt@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML Mailing List <linux-kernel@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@intel.com>, Ingo Molnar <mingo@kernel.org>,
 regressions@lists.linux.dev, Song Shuai <songshuaishuai@tinylab.org>
References: <ZY4T7YxrJZCxhMxx@a4bf019067fa.jf.intel.com>
 <ZZEXnl3w0K6avYR3@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZZEXnl3w0K6avYR3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1706783923;13f914b5;
X-HE-SMSGID: 1rVUSt-000667-8s

On 31.12.23 08:26, Mike Rapoport wrote:
> On Thu, Dec 28, 2023 at 04:33:49PM -0800, Ashok Raj wrote:
>> 96c6b8f212a ("memblock: report failures when memblock_can_resize is not set")
>>
>> Causes kexec failure. Backing out this change, kexec succeeds. Symptom is
>> it appears to hang, possibly hung at the panic. Although I have the
>> earlyprintk enabled, I don't see any console messages when new kernel
>> boots. 
>>
>> Also tested turning off CONFIG_X86_SGX, the kernel with this commit
>> included also kexec's fine.
>>
>> Booting from warm/cold reset has no issues. Only kexec to new kernel with
>> this change included and CONFIG_X86_SGX=y causes the kexec failure.
> 
> Can you add memblock=debug to the kernel command line and send logs for
> normal boot and kexec with CONFIG_X86_SGX=y and e96c6b8f212a reverted?

Ashok, you afaics never replied. Did you forget about it? Or was the
issue resolved later or never a regression in the first place? I for now
assume it's one of the latter and stop tracking this:

#regzbot inconclusive: radio silence from reporter
#regzbot ignore-activity

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr

