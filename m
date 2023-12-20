Return-Path: <linux-kernel+bounces-6350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C895D819799
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECBCE1C252DE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 04:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E2DC121;
	Wed, 20 Dec 2023 04:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="zOH3w1TV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A788F7D;
	Wed, 20 Dec 2023 04:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id BE74847314;
	Wed, 20 Dec 2023 04:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703045788; bh=BrnxJH9/C3KSa/UBf7qYkK+w34sJ9NZAo3NodYr1qto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=zOH3w1TVBh+i+6a/usCFyjujtAnNWAyjCPfbnTPgGba9+a2RTtOLNJ5RXQ3sKKuzJ
	 mkWBbMwCznIpfW+7oSNnlRjzqYR90E9e4Y4GYJVYq0MSZg9e1CFYU+BoKlnBLJIa05
	 y1+iqFQAE46mFpUa8AuABef7C9Av0w2RhCiZZxiDfvJDJ0QOEafqKSiOtE68eHSqAJ
	 EUEnqR7tpsFbi0CNKgQyTDhF+u9xnvutKjpd6DViTEYDH0dDuEq7B7lfkmOB7YlRqG
	 GCqt934fiGbq1oGrEbYt0YkCT5/VOhZMBHkQGx5FIJBrEE++QUlgD4SHVJN94T7cZn
	 0D1qB8k2OjpIg==
Message-ID: <6e330280-0b0a-4483-ac09-cd974d87a7ae@marcan.st>
Date: Wed, 20 Dec 2023 13:16:20 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kalle Valo <kvalo@kernel.org>, Daniel Berlin <dberlin@dberlin.org>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin <franky.lin@broadcom.com>,
 Hante Meuleman <hante.meuleman@broadcom.com>,
 SHA-cyfmac-dev-list@infineon.com, asahi@lists.linux.dev,
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
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <CAHk-=whDLKZZEuxU_jEhZRdeWjXAkL8=J_JRk2Ar6wp9UK3h2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2023/12/20 10:44, Linus Torvalds wrote:
> On Tue, 19 Dec 2023 at 16:06, Hector Martin <marcan@marcan.st> wrote:
>>
>> On 2023/12/19 23:42, Kalle Valo wrote:
>>>
>>> Why is it that every patch Hector submits seems to end up with flame
>>> wars?
> 
> Well, I do think some of it is Hector's personality and forceful
> approaches, but I do think part of it is also the area in question.
> 
> Because I do agree with Hector that..
> 
>> Just recently a patch was posted to remove the Infineon list from
>> MAINTAINERS because that company cares so little they have literally
>> stopped accepting emails from us. Meanwhile they are telling their
>> customers that they do not recommend upstream brcmfmac and they should
>> use their downstream driver [1].
> 
> Unquestionably broadcom is not helping maintain things, and I think it
> should matter.
> 
> As Hector says, they point to their random driver dumps on their site
> that you can't even download unless you are a "Broadcom community
> member" or whatever, and hey - any company that works that way should
> be seen as pretty much hostile to any actual maintenance and proper
> development.
> 
> If Daniel and Hector are responsive to actual problem reports for the
> changes they cause, I do think that should count a lot.

Of course we're happy to do that. If this change goes in and we get an
actual report of breakage from someone, we'll have learned some very
valuable information: That there is, in fact, an end-user use case
(hardware/firmware/AP setting combination) where this code functions and
matters, and perhaps we'll have found someone willing to test things in
the future. Then we revert and rework the patch to keep the old code
path alive in that case.

The report will also give us valuable information about how to condition
it, because e.g. right now we don't even know if the sae_password code
works on any Cypress chips/firmwares at all, or conversely whether the
new WSEC code rather makes things work on some subset of Cypress
chips/firmwares instead. It is largely a mystery to everyone outside of
Broadcom and Cypress how that whole corporate division fork worked and
when and how the firmwares started diverging (never mind how Apple's
Broadcom firmwares may themselves differ).

It's the "don't touch it just in case" approach that is not sustainable,
because then we'll just be accumulating technical debt without the
slightest clue whether it even does anything useful or not, and
needlessly setting back development on the other and newer chips.

All this would, of course, be much easier if the vendor actually replied
to our emails, since evidently they know what chips/firmware branches
might have support for this, but even before Cypress names got removed
from MAINTAINERS I was already getting radio silence from them when I
asked questions like this, and even on the Broadcom side I had trouble
getting Arend to answer simple questions. Ultimately, with minimal to no
vendor cooperation, this driver becomes a reverse engineered, community
supported driver, with the inevitable gaps in testing and support that
entails when we don't have the information the manufacturers do, and
people need to understand the consequences of that. If the manufacturers
aren't stepping up to do their job, other members of the community (or
customers of those vendors) need to do so if there are hardware
configurations they rely on, because Daniel and I can't sign up to
proactively maintain and test every single Broadcom and Cypress/Infineon
chip out there. We don't have the hardware, nor do we have that kind of
bandwidth/time. Support for hardware that no maintainer/developer is
proactively testing will necessarily fall back to being reactive to
regression reports.

> I don't think Cypress support should necessarily be removed (or marked
> broken), but if the sae_password code already doesn't work, _that_
> part certainly shouldn't hold things up?
> 
> Put another way: if we effectively don't have a driver maintainer that
> can test things, and somebody is willing to step up, shouldn't we take
> that person up on it?

Personally, I do think the rPi folks themselves should step up for
*testing* at the very least. I did point them at our downstream WiFi
branch at one point during a previous discussion and haven't heard back,
so either they never tested it, or they did and it didn't break
anything. If they're shipping popular Linux hardware where the WiFi
chipset vendor has fully and completely checked out of any upstream
support, they need to either accept that upstream support will likely
break at some point (because that's just what happens when nobody cares
about a given piece of hardware, especially with drivers shared across
others like this one) or they need to proactively step up and take on,
minimally, an early testing role themselves.

- Hector

