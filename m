Return-Path: <linux-kernel+bounces-6127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7DD8194EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F2EB23A46
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 00:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818B1C05;
	Wed, 20 Dec 2023 00:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="R0OKX7ZX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4851385;
	Wed, 20 Dec 2023 00:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 5F99D4734A;
	Wed, 20 Dec 2023 00:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1703030793; bh=nE9Xj5iUYjbSXep5BSuQ2O+HaN61DMYEhOgnvLQnj9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R0OKX7ZX4vILx92ac3G70gtFklKUdka8R2VQICgCHPMk+jl9B0WHSkIuW2s592zV2
	 +HMW/0EjPbWhz+9JaZycFO/CZuF4EzY8TLOP7hPq8iilO9WMdjxjp++QVaTyUvFIJI
	 4noG7WApyqcYdOq06oglsBJQtPZtEkOYlGkYoCVXef4rfJMAsMHTQnhO3OPZaexc8/
	 XipDAa0QKhk99j+dMfc4fB//4jJ6Brgne4KxRa7vSmwniFDD+QdQ2CY0fQThCo+ZG3
	 0tKjKE5F/GBf0OOz2TFWx+/n4LsjggxXrK9t4ny8XT9Si/d1wLICBuAB4Cxsb8KlIp
	 17eOSQIFa+iPw==
Message-ID: <01bd8c68-1b9c-49b2-8ace-1c7d1b5192ad@marcan.st>
Date: Wed, 20 Dec 2023 09:06:25 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Use WSEC to set SAE password
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Daniel Berlin <dberlin@dberlin.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
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
 <87r0jiqmnx.fsf@kernel.org>
From: Hector Martin <marcan@marcan.st>
In-Reply-To: <87r0jiqmnx.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2023/12/19 23:42, Kalle Valo wrote:
> Daniel Berlin <dberlin@dberlin.org> writes:
> 
>> On Tue, Dec 19, 2023 at 7:46 AM Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
>>
>>  On 12/19/2023 12:01 PM, Hector Martin wrote:
>>  > 
>>  > 
>>  > On 2023/12/19 17:52, Arend Van Spriel wrote:
>>  >> On December 17, 2023 12:25:23 PM Kalle Valo <kvalo@kernel.org> wrote:
>>  >>
>>  >>> Hector Martin <marcan@marcan.st> wrote:
>>  >>>
>>  >>>> Using the WSEC command instead of sae_password seems to be the supported
>>  >>>> mechanism on newer firmware, and also how the brcmdhd driver does it.
>>  >>>>
>>  >>>> According to user reports [1], the sae_password codepath doesn't actually
>>  >>>> work on machines with Cypress chips anyway, so no harm in removing it.
>>  >>>>
>>  >>>> This makes WPA3 work with iwd, or with wpa_supplicant pending a support
>>  >>>> patchset [2].
>>  >>>>
>>  >>>> [1] https://rachelbythebay.com/w/2023/11/06/wpa3/
>>  >>>> [2] http://lists.infradead.org/pipermail/hostap/2023-July/041653.html
>>  >>>>
>>  >>>> Signed-off-by: Hector Martin <marcan@marcan.st>
>>  >>>> Reviewed-by: Neal Gompa <neal@gompa.dev>
>>  >>>
>>  >>> Arend, what do you think?
>>  >>>
>>  >>> We recently talked about people testing brcmfmac patches, has anyone else
>>  >>> tested this?
>>  >>
>>  >> Not sure I already replied so maybe I am repeating myself. I would prefer
>>  >> to keep the Cypress sae_password path as well although it reportedly does
>>  >> not work. The vendor support in the driver can be used to accommodate for
>>  >> that. The other option would be to have people with Cypress chipset test
>>  >> this patch. If that works for both we can consider dropping the
>>  >> sae_password path.
>>  >>
>>  >> Regards,
>>  >> Arend
>>  > 
>>  > So, if nobody from Cypress chimes in ever, and nobody cares nor tests
>>  > Cypress chipsets, are we keeping any and all existing Cypress code-paths
>>  > as bitrotting code forever and adding gratuitous conditionals every time
>>  > any functionality needs to change "just in case it breaks Cypress" even
>>  > though it has been tested compatible on Broadcom chipsets/firmware?
>>  > 
>>  > Because that's not sustainable long term.
>>
>>  You should look into WEXT just for the fun of it. If it were up to me 
>>  and a bunch of other people that would have been gone decades ago. Maybe 
>>  a bad example if the sae_password is indeed not working, but the Cypress 
>>  chipset is used in RPi3 and RPi4 so there must be a couple of users.
>>
>> None of this refutes what he said
>>
>> We already know it doesn't work for the rpi3/4 users because they are
>> blogging about it. The fact that you (not personally but as a
>> maintainer) don't know what works for who or doesn't is part of the
>> issue. Who are the users who this is for, how are you getting feedback
>> on what is working or not, how are you testing that it stays working?
>>
>> I'm with Hector - this approach has mainly resulted in a driver that
>> kind of works for some people with no rhyme or reason - but nobody
>> knows who and what works for them. This isn't sustainable. You need
>> testing and feedback loops from some defined populations.
>>
>> Of course, This will all become moot as we argue about it - more and
>> more is breaking for more and more people (for example, management
>> frames are totally broken on newer chips because we silently assume
>> version 1).
>>
>> The driver is about one real upgrade cycle away from not working, in
>> current form, for the vast majority of its users.
>>
>> One would hope we don't sit and argue about how to support the future
>> while waiting for that to happen, instead we should be moving the
>> driver forward. If we need to worry about specific older chip users,
>> we should name who they are, how many there are, and what the limits
>> of support are. We should then talk about the best way to support them
>> while still moving the world forward.
> 
> Why is it that every patch Hector submits seems to end up with flame
> wars?

Perhaps because this driver has approximately 0.1 direct maintainers
right now whose contributions are largely hem and hawing about things
without providing any real sustainable solutions, and your amazing
additions as the Wireless upstream maintainer have been things like
nitpicking whether or not I should use "v2:" in commit messages.

Just recently a patch was posted to remove the Infineon list from
MAINTAINERS because that company cares so little they have literally
stopped accepting emails from us. Meanwhile they are telling their
customers that they do not recommend upstream brcmfmac and they should
use their downstream driver [1].

As a reminder, the last patch authored by the sole (barely) active
maintainer of this driver was almost a year ago. The other two Broadcom
folks in MAINTAINERS haven't done anything in years. Arend himself has
admitted he only gets 20% time to work on this and it never actually
reaches anywhere near 20%.

Meanwhile Daniel here has been revamping large chunks of the driver
downstream, and fixing major longstanding issues with an intent to
upstream. But apparently his opinion doesn't matter.

Hey Linus, you have an M2 MacBook Air, right? I assume you want WiFi to
work on it properly upstream some day. With the dismal state of brcmfmac
maintainership, and with the disdain the people involved have for the
people *actually* doing the work on the driver and trying to get
everything upstream, that is never going to happen at this rate. Care to
chime in?

As far as I'm concerned, Cypress support should be ifdeffed out behind a
Kconfig flag marked BROKEN. If someone cares about it, they better step
up to maintain it and actually test things. We can't have companies
submitting device support patches and then checking out and abandoning
them and expect the remaining people actually working on the driver to
tiptoe around their code "just in case we break them" with no way to
actually test anything or properly support those chips. Even the
Raspberry Pi folks have been silent other than some empty words and no
actual action, so far. You'd think they'd care a bit more about shipping
hardware with zero actual upstream maintainer support, but apparently
they don't.

[1]
https://community.infineon.com/t5/AIROC-Wi-Fi-and-Wi-Fi-Bluetooth/Queries-re-linux-in-tree-driver-for-Infineon-Wifi-BT-controllers/td-p/354857

- Hector

