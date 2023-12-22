Return-Path: <linux-kernel+bounces-9361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32AD281C497
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE83B281610
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 05:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202B2611B;
	Fri, 22 Dec 2023 05:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="fdxdE6Va"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E824680;
	Fri, 22 Dec 2023 05:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id AC0BE42529;
	Fri, 22 Dec 2023 05:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703221836; bh=isW7kSOvN8g1kwYojvPPUbUdI9KkQjc87f5qybjzZrQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fdxdE6VaEoXh5IIbZ5sgkVHKwYEfchv3k/qs8V9tKDp/81Yoj0+U0xpRAMu5WWh/n
	 s6WyoPBCaw+AJ0J30O5qBUmwPVy6qlbgmWsBBNd4GppQUYKpxDm/d+G6K2Ew13XQ3K
	 XBSW+k5N1o4VpHTQIE6uf2Ih7YEMqUqm9VnDGNpiBPh9YjDbs77SVpl0xaWc+CEBkC
	 DGp7tq9qvfP2H951Y4ZGVTwSJa2K+/x2WG9IcLYz/lRce8MUJ9eze+DyeA1+YmQQ4S
	 Tf8gA7bWhsjtjOAVrphvUwfraEKinVfWelBXkGVUWAXS35cy4npFCwrVXRppaiQGcu
	 vGMQFNY1d1Ciw==
Message-ID: <37bd3f8a-1000-4d74-8909-5e821cb5c1dc@marcan.st>
Date: Fri, 22 Dec 2023 14:10:28 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Content-Language: en-US
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
 Kalle Valo <kvalo@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Berlin <dberlin@dberlin.org>, Arend van Spriel
 <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>, asahi@lists.linux.dev,
 brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, David Airlie <airlied@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>
References: <20231107-brcmfmac-wpa3-v1-1-4c7db8636680@marcan.st>
 <170281231651.2255653.7498073085103487666.kvalo@kernel.org>
 <18c80d15e30.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <1b51997f-2994-46e8-ac58-90106d1c486d@marcan.st>
 <c392f901-789a-42e2-8cf7-5e246365a1ca@broadcom.com>
 <CAF4BwTXNtu30DAgBXo4auDaDK0iWc9Ch8f=EH+facQ-_F-oMUQ@mail.gmail.com>
 <87r0jiqmnx.fsf@kernel.org> <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
 <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
 <871qbhqio8.fsf@kernel.org> <4c89b71e-8667-40fe-add0-205748de51ef@marcan.st>
 <bdb078c0-2f45-485a-86a0-bb7d0b5e3516@broadcom.com>
 <d5e26dd4-483d-4662-ba83-5cb19187b24a@marcan.st>
 <31292508-f881-4457-a4bf-2ca0b8e8f435@broadcom.com>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <31292508-f881-4457-a4bf-2ca0b8e8f435@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/12/21 18:57, Arend van Spriel wrote:
> - SHA-cyfmac-dev-list@infineon.com
> 
> On 12/21/2023 1:49 AM, Hector Martin wrote:
>>
>>
>> On 2023/12/21 4:36, Arend van Spriel wrote:
>>> On 12/20/2023 7:14 PM, Hector Martin wrote:
>>>>
>>>>
>>>> On 2023/12/20 19:20, Kalle Valo wrote:
>>>>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>>>>>
>>>>>>> Just recently a patch was posted to remove the Infineon list from
>>>>>>> MAINTAINERS because that company cares so little they have literally
>>>>>>> stopped accepting emails from us. Meanwhile they are telling their
>>>>>>> customers that they do not recommend upstream brcmfmac and they should
>>>>>>> use their downstream driver [1].
>>>>>>
>>>>>> Unquestionably broadcom is not helping maintain things, and I think it
>>>>>> should matter.
>>>>>>
>>>>>> As Hector says, they point to their random driver dumps on their site
>>>>>> that you can't even download unless you are a "Broadcom community
>>>>>> member" or whatever, and hey - any company that works that way should
>>>>>> be seen as pretty much hostile to any actual maintenance and proper
>>>>>> development.
>>>>>
>>>>> Sadly this is the normal in the wireless world. All vendors focus on the
>>>>> latest generation, currently it's Wi-Fi 7, and lose interest on older
>>>>> generations. And vendors lose focus on the upstream drivers even faster,
>>>>> usually after a customer project ends.
>>>>>
>>>>> So in practise what we try to do is keep the drivers working somehow on
>>>>> our own, even after the vendors are long gone. If we would deliberately
>>>>> allow breaking drivers because vendor/corporations don't support us, I
>>>>> suspect we would have sevaral broken drivers in upstream.
>>>>>
>>>>>> If Daniel and Hector are responsive to actual problem reports for the
>>>>>> changes they cause, I do think that should count a lot.
>>>>>
>>>>> Sure, but they could also respect to the review comments. I find Arend's
>>>>> proposal is reasonable and that's what I would implement in v2. We
>>>>> (linux-wireless) make abstractions to workaround firmware problems or
>>>>> interface conflicts all the time, just look at ath10k for example. I
>>>>> would not be surprised if we need to add even more abstractions to
>>>>> brcmfmac in the future. And Arend is the expert here, he has best
>>>>> knowledge of Broadcom devices and I trust him.
>>>>>
>>>>> Has anyone even investigated what it would need to implement Arend's
>>>>> proposal? At least I don't see any indication of that.
>>>>
>>>> Of course we can implement it (and we will as we actually got a report
>>>> of this patch breaking Cypress now, finally).
>>>>
>>>> The question was never whether it could be done, we're already doing a
>>>> bunch of abstractions to deal with just the Broadcom-only side of things
>>>> too. The point I was trying to make is that we need to *know* what
>>>> firmware abstractions we need and *why* they are needed. We can't just
>>>> say, for every change, "well, nobody knows if the existing code works or
>>>> not, so let's just add an abstraction just in case the change breaks
>>>> something". As far as anyone involved in the discussions until now could
>>>> tell, this code was just something some Cypress person dumped upstream,
>>>> and nobody involved was being responsive to any of our inquiries, so
>>>> there was no way to be certain it worked at all, whether it was
>>>> supported in public firmware, or anything else.
>>>>
>>>> *Now* that we know the existing code is actually functional and not just
>>>> dead/broken, and that the WSEC approach is conversely not functional on
>>>> the Cypress firmwares, it makes sense to introduce an abstraction.
>>>
>>> Just a quick look in the git history could have told you that it was not
>>> just dumped upstream and at least one person was using it and extended
>>> it for 802.11r support (fast-roaming):
>>>
>>>
>>> author	Paweł Drewniak <czajernia@gmail.com>	2021-08-24 23:13:30 +0100
>>> committer	Kalle Valo <kvalo@codeaurora.org>	2021-08-29 11:33:07 +0300
>>> commit	4b51de063d5310f1fb297388b7955926e63e45c9 (patch)
>>> tree	ba2ccb5cbd055d482a8daa263f5e53531c07667f
>>> /drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
>>> parent	81f9ebd43659320a88cae8ed5124c50b4d47ab66 (diff)
>>> download	wireless-4b51de063d5310f1fb297388b7955926e63e45c9.tar.gz
>>> brcmfmac: Add WPA3 Personal with FT to supported cipher suites
>>> This allows the driver to connect to BSSIDs supporting SAE with 802.11r.
>>> Tested on Raspberry Pi 4 Model B (STA) and UniFi 6LR/OpenWRT 21.02.0-rc2.
>>> AP was set to 'sae-mixed' (WPA2/3 Personal).
>>>
>>> Signed-off-by: Paweł Drewniak <czajernia@gmail.com>
>>> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>>> Link: https://lore.kernel.org/r/20210824221330.3847139-1-czajernia@gmail.com
>>
>> Sure, but we also had user reports of it *not* actually working (maybe
>> it regressed?). We didn't know whether it was functional with the
>> linux-firmware blobs in any way, I wanted confirmation of that. And we
>> also didn't know that the patch *would* break it at all; perhaps the
>> Cypress firmware had also grown support for the WSEC mechanism.
>>
>> That's why I wanted someone to actually confirm the code worked (in some
>> subset of cases) and the patch didn't, before starting to introduce
>> conditionals. There is, of course, also the element that the Cypress
>> side has been long unmaintained, and if nobody is testing/giving
>> feedback/complaining, perhaps it's better to err on the side of maybe
>> breaking something and see if that gets someone to come out of the
>> woodwork if it really breaks, rather than tiptoeing around the code
>> without knowing what's going on and without anyone actually testing things.
> 
> That is because you distrust the intent that Cypress was really 
> contributing. They were and I trusted them to not just throw in a 
> feature like WPA3. When Infineon took over they went mute. Upon 
> reviewing your patch (again) I also sent an email to them asking 
> specifically about the status of the sae_password interface. I did not 
> use the mailing list which indeed bounces these days (hence removed 
> them) but the last living soul that I had contact with about a year ago 
> whether they were still comitted to be involved. I guess out of 
> politeness or embarrassment I got confirmation they were and never heard 
> from him again. The query about the sae_password interface is still pending.

If only corporate acquisition politics didn't repeatedly throw a wrench
into this one... :/

This is where we are though, Infineon clearly doesn't care, so it's time
to move on.

>> It's not about this *specific* patch, it's about the general situation
>> of not being able to touch firmware interfaces "just in case Cypress
>> breaks" being unsustainable in the long term. I wasn't pushing back
>> because I think this particular one will be hard, I was pushing back
>> because I can read the tea leaves and see this is not going to end well
>> if it's the approach we start taking for everything. We *need* someone
>> to be testing patches on Cypress, we can't just "try not to touch it"
>> and cross our fingers. That just ends in disaster, we are not going to
>> succeed in not breaking it either way and it's going to make the driver
>> worse.
> 
> I admire you ability of reading tea leaves. You saw the Grim I reckon. 
> Admittedly your responses on every comment from my side (or Kalle for 
> that matter) was polarizing every discussion. That is common way people 
> treat each other nowadays especially online where a conversation is just 
> a pile of text going shit. It does not bring out the best in me either, 
> but it was draining every ounce of energy from me so better end it by 
> stepping out.

The hilariously outdated kernel development model surely doesn't help
either (I've stated my opinion on this quite a few times if you've
followed around) ;)

This stuff gets *really* frustrating when you're trying to improve what
is, I hope we can all admit, an undermaintained driver (that is not to
say it's anyone's fault personally), and end up getting held back due to
everything from coding style nitpicks to people not having the time to
be responsive. It's just not helpful. It's important to know when to
step aside and let people actually get stuff done.

When Daniel started sending me brcmfmac patches downstream, I took a
look at a few of them, decided he knew what he was doing, and just
started pulling in his branches wholesale. Was it perfect? No, I had to
debug at least one regression at one point. But it took me less time to
do that than it would've to go through the commits with a fine toothed
comb, so it was clearly the right decision.

That is not to say that should be the standard upstream (we make a point
of moving fast and breaking things more downstream, since it's a proving
ground for what eventually will be upstreamed), but I think it does
demonstrate the kind of delegation ability that is sorely lacking in
many drivers and subsystems in the kernel these days. Maintainers become
entrenched in their position, long beyond the point where they have the
time/motivation/ability to drive the code forward, and end up in the way
of new people who are trying to make a difference. I think Linus knows
full well the kernel maintainer community is stagnating.

That doesn't mean people should step down entirely. But it does mean
they need to recognize when this is happening and, at least, proactively
try to bring new people in, instead of just continuing to play a
gatekeeping role. The role of maintainers should not be that of a wall
people have to climb over to get their changes in, it should be to guide
new contributors and help onboard people who can contribute, as peers
and eventually as future maintainers.

Kalle, in the other thread you said "this is not fun anymore, this is
more like a business with requirements and demands coming from
everywhere.". That's what it feels like to us when our changes get
rejected because the local vars aren't in reverse Christmas tree order,
or because our commit messages have "v2:" in them. It feels like some
manager is trying to justify their position by creating busywork for
everyone else. Nobody should actually care about any of those things,
and if they do, they need to step back and really ask themselves how
they ended up believing that. If the goal is to enforce a reasonable
shared coding style so things don't spiral into chaos, FFS, let's just
do what every other project does these days and adopt clang-format. Then
*all* of us can stop wasting time on these trivialities and go back to
getting stuff done. And really, nobody cares about commit messages as
long as the tags are right, the subject line is succinct, and the
important information is in there. Extra stuff never hurt anyone.

> I added the ground work for multi-vendor support, but have not decided 
> on the approach to take. Abstract per firmware interface primitive or 
> simply have a cfg80211.c and fwil_types.h per vendor OR implement a 
> vendor-specific cfg80211 callback and override the default callback 
> during the driver attach, ie. in brcmf_fwvid_wcc_attach(). The latter 
> duplicates things, but lean towards that as it may be easier on the 
> long-term. What do your tea leaves tell you ;-)

FWIW, I was hoping you'd stay on at least as a reviewer. Your
contributions are valuable. You obviously know the driver and hardware
much better than most people. I encourage you to, at least, post a v2 of
the MAINTAINERS patch with yourself as an R: line.

As far as the actual driver abstraction architecture, I'm going to leave
it to Daniel to decide what makes the most sense, since he's the one
introducing new mechanisms for that already. There's always room for
refactoring later though, depending on the direction things take with
the vendor split. BTW, clang-format also makes refactoring a lot less
painful ;)

- Hector

