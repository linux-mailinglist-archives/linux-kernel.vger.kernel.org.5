Return-Path: <linux-kernel+bounces-34037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A41837237
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E21C32908F8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E410F4A9B3;
	Mon, 22 Jan 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AKP4JZKE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044044A9A3;
	Mon, 22 Jan 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950383; cv=none; b=qLPHOh2KdPbLYBiCyrfKR+mqTiXoEpNIlWJgQwyBs4Da1BtQUlwp00Cjn6FpUTn10CPSwpdXDZwEB/ybPPanlT6Zpp2f2Y0lyjzjcZ5TU6Q9STCyyTFxMt7rxVltqLg0/T3EKXMoZROfKs885jzSFuj4pOe/IC+owTcCMfp8q6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950383; c=relaxed/simple;
	bh=3Zxrw5yAUlUVp3ob/vJEIsDQ5grjL/Vrq9t/P3JVT5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV1d04stwudaVjDkLT7b1qeRDdeYHMYb6sMN0gpWkatgAq4XfiPchcStlBPajthOCgvumSLtLEImuy1RXooi5K5jtZ2A2c7uVG4u5fg0yhK2BVpemkgSrKcu+MUAdudfnL7qGRqqk7YyXspm/qLadu79Kx0IEfINqrog2EKMUng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AKP4JZKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A8BC43390;
	Mon, 22 Jan 2024 19:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705950382;
	bh=3Zxrw5yAUlUVp3ob/vJEIsDQ5grjL/Vrq9t/P3JVT5I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AKP4JZKEui5YZol6k/ks0JQoanuucUUUmuq8PAiVcbBCwppxSBtdYQmtUwDMW6d6N
	 reIq6VAK3Aaf5nhBW3Fsua19euuoGsw5pDRJbsj5mYCz2OGUUHty1oRUynr74Ccgi5
	 2SuP4gs/1BAnUp5MIyWSB6HWwrpeq5yVCXdlM4k4Kg4lyQyU7T97R7LwidXQKMm83E
	 n5ea95rp+j9LlvgRj1XDBptVgEd0aQES8h+nX9Kd/omgd1B5e9EsboyWTwlD1DFIA2
	 Qj/lnuuPzSUooQKwHck1uw1obSFEUNdYYuYO98msNqGCavqVw/QqdEXYHPtTLhz3Jf
	 uZmdRrpqYKFPg==
Message-ID: <43412916-a567-4318-85e4-d5a12bf7624f@kernel.org>
Date: Mon, 22 Jan 2024 20:06:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel panic in netif_rx_internal after v6 pings between netns
Content-Language: en-GB, fr-BE
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Netdev <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <98724dcd-ddf3-4f78-a386-f966ffbc9528@kernel.org>
 <CANn89iLAYXpRiGaGi+rvOZyxMfpUmW2cOg6hLhqE=+2JJS8rkw@mail.gmail.com>
 <65c4f6a2-207f-45e0-9ec3-bad81a05b196@kernel.org>
 <5340b60d-a09a-4865-a648-d1a45e9e6d5f@kernel.org>
 <20240122092804.3535b652@kernel.org>
 <f96b33ab-56d5-4a43-a1ff-2e68e2c55ac2@kernel.org>
 <20240122103658.592962d1@kernel.org>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20240122103658.592962d1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 22/01/2024 19:36, Jakub Kicinski wrote:
> On Mon, 22 Jan 2024 19:22:42 +0100 Matthieu Baerts wrote:
>>> Somewhat related. What do you do currently to ignore crashes?  
>>
>> I was wondering why you wanted to ignore crashes :) ... but then I saw
>> the new "Test ignored" and "Crashes ignored" sections on the status
>> page. Just to be sure: you don't want to report issues that have not
>> been introduced by the new patches, right?
> 
> Initially, yes, but going forward I bet we'll always see crashes and
> breakage introduced downstream. So we need some knobs to selectively
> silence failing things.

Even if I guess it will mainly be around the merge window, I understand
it will be annoying to have issues for at least one week, until the next
sync with Linus' tree.

> In an ideal world we'd also have some form of "last seen" stat
> displayed to know when to retire these entries..

Good idea!

>> We don't need to do that on MPTCP side:
>> - either it is a new crash with patches that are in reviewed and that's
>> not impacting others → we test each series individually, not a batch of
>> series.
>> - or there are issues with recent patches, not in netdev yet → we fix,
>> or revert.
>> - or there is an issue elsewhere, like the kernel panic we reported
>> here: usually I try to quickly apply a workaround, e.g. applying a fix,
>> or a revert. I don't think we ever had an issue really impacting us
>> where we couldn't find a quick solution in one or two days. With the
>> panic we reported here, ~15% of the tests had an issue, that's "OK" to
>> have that for a few days/weeks
>>
>> With fewer tests and a smaller community, it is easier for us to just
>> say on the ML and weekly meetings: "this is a known issue, please ignore
>> for the moment". But if possible, I try to add a workaround/fix in our
>> repo used by the CI and devs (not upstreamed).
>>
>> For NIPA CI, do you want to do like with the build and compare with a
>> reference? Or multiple ones to take into account unstable tests? Or
>> maintain a list of known issues (I think you started to do that,
>> probably safer/easier for the moment)?
> 
> Exactly - where we can a before/after diff is the best. We do that for
> all static checker / building kind of tests. But for selftests I'm not
> sure how effective and applicable that is. Even the stack trace I
> posted here happens somewhat unreliably :( We can try to develop more
> intelligent ways going forward, obviously :)

Maybe just by checking the last X rans, instead of the last one?

Maybe also enough to just mark the tests as WARN with "was failing
before" text (+ a percentage)?

>>> I was seeing a lot of:
>>> https://netdev-2.bots.linux.dev/vmksft-net-mp/results/431181/vm-crash-thr0-2
>>>
>>> So I hacked up this function to filter the crash from NIPA CI:
>>> https://github.com/kuba-moo/nipa/blob/master/contest/remote/lib/vm.py#L50
>>> It tries to get first 5 function names from the stack, to form 
>>> a "fingerprint". But I seem to recall a discussion at LPC's testing
>>> track that there are existing solutions for generating fingerprints.
>>> Are you aware of any?  
>>
>> No, sorry. But I guess they are using that with syzkaller, no?
>>
>> I have to admit that crashes (or warnings) are quite rare, so there was
>> no need to have an automation there. But if it is easy to have a
>> fingerprint, I will be interested as well, it can help for the tracking:
>> to find occurrences of crashes/warnings that are very hard to reproduce.
> 
> Indeed, I'll keep my ear to the ground. I believe it was discussed in
> relation to KCIDB.

Maybe good to ask people behind Syzkaller, they must have something in
place :)

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

