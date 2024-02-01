Return-Path: <linux-kernel+bounces-48303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E9D8459E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E27D287D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E285D492;
	Thu,  1 Feb 2024 14:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="neRWrpBm"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2635D465;
	Thu,  1 Feb 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706797149; cv=none; b=LoYIdC1Vw+3KZCf0T8CNWI8Sst2gnjNV4kTmSs+O7HWHf1J8sGYErIZajBeuSTP23srtWeIYjd2AhUE7qUItUZqechtSOOZsYokhC1anUmP0Nsw5XSmBEp6R2C+/5ia3eHUOJOF7I0Oyw/qrrBymtxJX89SWwiFRzdUz8k819i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706797149; c=relaxed/simple;
	bh=vHCcKVvZrQL2QrV1hmgo04yutSPw1rOQhlupRpU5Ios=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Z3/QtFMLQsAkvXgaFcVZdc/GtjhHDA30qEjOjkcDYOJl6yqPGgktbMNvtmryxb+1VswF+IaQzdvquKYsY+pgqX84DCVegLWSNhO/4YZBnwFGfg+XqA9ykVys/I+RCkWyGFe1GaTYMlDJkwj+e9aTVR7NN6o/tCmIsnLtmhmyluc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=neRWrpBm; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706797139; bh=vHCcKVvZrQL2QrV1hmgo04yutSPw1rOQhlupRpU5Ios=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=neRWrpBmRqFUTHfKG9UtbcYAVngvJzpvVbfWu/Nx/5P2Q1rz7q/N9c1LogDsgIwed
	 NQanMQVAff9Put9IfFPMfz16iwaupS2CpKnXp6Oz2cnOEHSCdsYBakbxmn8JRy2dHe
	 EtSbNzZFnBj5xBviUzhq+GdJV0lcriqmEIVHFzDlQ7HpBhSklb8UfBe75U2hTOQLG+
	 Y37634Dmm/jEt4ysDBEwen0ucetQnBj5f3lZI6ObHLdgt/AVOD66qNQukPCc1o+VcB
	 qYGjntB+C2r2r2K3R36mK2cqxz5NTkC250pspFJBnMpKGumydx7T6YnYWnAQAXpf3b
	 pxMlvCb7jChqw==
To: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@kernel.org>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin
 <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>,
 Lee Jones <lee@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Srinivasan Raju <srini.raju@purelifi.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
In-Reply-To: <789b7ca0-80c5-449a-99eb-8c05b5380245@app.fastmail.com>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
 <613ae419-9a2c-477e-8b19-8a29d42a3164@app.fastmail.com>
 <ZbuZ_55a-qqDqkeN@smile.fi.intel.com>
 <789b7ca0-80c5-449a-99eb-8c05b5380245@app.fastmail.com>
Date: Thu, 01 Feb 2024 15:18:59 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <871q9wz2r0.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Thu, Feb 1, 2024, at 14:17, Andy Shevchenko wrote:
>> On Thu, Feb 01, 2024 at 01:20:16PM +0100, Arnd Bergmann wrote:
>>> On Wed, Jan 31, 2024, at 23:37, Linus Walleij wrote:
>>
>>> +	} else if (ah->led_pin < 0) {
>>
>> ...
>>
>>> +	if (sc->sc_ah->led_gpio)
>>
>> Dup check
>
> I don't know what you mean here. To explain what I'm
> trying to do: The idea is that the LED is always backed
> by either gpiolib or the internal gpio controller on
> the PCI device. This means every access to an LED must
> be guarded with 
>
>    if (gpiodesc)
>          gpio_*(gpiodesc);
>    else
>          internal(ah);
>
> We could probably go a little further in the cleanup and
> throw out the gpiolib path entirely, instead relying
> on the existing leds-gpio driver. Since there are currently
> no upstream users of the gpiolib path, that would likely
> lead to cleaner code but require more changes to any
> out-of-tree users that rely on the platform_data to
> pass the GPIOs today.

There being exactly one such out of tree user (per your up-thread
email) in OpenWrt? Or are you aware of others?

-Toke

