Return-Path: <linux-kernel+bounces-49668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074E7846DD3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A78B1F21A25
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E737C0AC;
	Fri,  2 Feb 2024 10:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="AjIhSaVq"
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2879F7C084;
	Fri,  2 Feb 2024 10:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706869395; cv=none; b=FGssm4RzzZGaoYo/lhlecokqyew6jRO2si5FOCXU4yECLSes1py/Y0Fossm5giCjQ0o38J02FPdPUljxPQi9njt/cP25CvVqvSIFyoXaIxe4DAAzq4CHxSBl7EDKokTzTVF64NpaWKCWRmlFu8Idz3m0njQ0sSTPRVQOUfru/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706869395; c=relaxed/simple;
	bh=hiC1Ur9jHiRNpct6U6sroqQWDjCDaFKufzfpTuJBcjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rRDf9ApoczicXmoRyoIMnsTunPkXFoHrYRU1EDNd6rRWWHy/wWZ9nXf239ZBFAU2TV1O7DOumIhVWyQkOwcesDG8I09THEDcB/q3JxeZ8+5c3wZojfqw6+4puvzh4ni9MKcX42ztugdpSEc1EIDWFKrvUURE9Q/+NSJqiBu/tY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=AjIhSaVq; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706869386; bh=hiC1Ur9jHiRNpct6U6sroqQWDjCDaFKufzfpTuJBcjI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AjIhSaVqGzzegmBVE/AmTUaQ3GuC2L/hctoxnIkMzphqtzLt64sn8wIhhN8ocVxSO
	 hpMSRYRJWmjnZW+a8rVxi/OkfHWzckgI1AZbHKg3Ff2ER07SkjHQtmmg5QAN8VNVwA
	 fCbT5rdqR9Q6zpk8FpWnzM6moPVOy2hlTiDBwFDkJCWJEcapfyuBmm6c8EMywO5I9t
	 c30EYxmn0jN6Lx6g/YpgDwCmYNzIcX9B0QE0/qIRABVR3HKXX0iP33Yd1CVUL6L7YT
	 O85i0lHptbH53bqmzn/bE0q5JTRZGgtL/4j9FC/4TtkRRb09Pw1FmxwKnErMJdxuLd
	 WM/Om6VB6qTCA==
To: Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Kalle Valo <kvalo@kernel.org>,
 Arend van Spriel <aspriel@gmail.com>, Franky Lin
 <franky.lin@broadcom.com>, Hante Meuleman <hante.meuleman@broadcom.com>,
 Lee Jones <lee@kernel.org>, Brian Norris <briannorris@chromium.org>,
 Srinivasan Raju <srini.raju@purelifi.com>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org, brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH 1/6] wifi: ath9k: Obtain system GPIOS from descriptors
In-Reply-To: <d656a2af-6b74-465d-90a6-b79ba6c25088@app.fastmail.com>
References: <20240131-descriptors-wireless-v1-0-e1c7c5d68746@linaro.org>
 <20240131-descriptors-wireless-v1-1-e1c7c5d68746@linaro.org>
 <613ae419-9a2c-477e-8b19-8a29d42a3164@app.fastmail.com>
 <ZbuZ_55a-qqDqkeN@smile.fi.intel.com>
 <789b7ca0-80c5-449a-99eb-8c05b5380245@app.fastmail.com>
 <871q9wz2r0.fsf@toke.dk>
 <d656a2af-6b74-465d-90a6-b79ba6c25088@app.fastmail.com>
Date: Fri, 02 Feb 2024 11:23:06 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87y1c3xj05.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Thu, Feb 1, 2024, at 15:18, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> "Arnd Bergmann" <arnd@arndb.de> writes:
>>
>>> We could probably go a little further in the cleanup and
>>> throw out the gpiolib path entirely, instead relying
>>> on the existing leds-gpio driver. Since there are currently
>>> no upstream users of the gpiolib path, that would likely
>>> lead to cleaner code but require more changes to any
>>> out-of-tree users that rely on the platform_data to
>>> pass the GPIOs today.
>>
>> There being exactly one such out of tree user (per your up-thread
>> email) in OpenWrt? Or are you aware of others?
>
> Actually, on a closer look not even that: the ath9k LED support
> in openwrt is quite different from upstream, and it just uses
> gpio-led there, with a gpio provider in the driver for the
> internal gpios.
>
> We can probably just remove the gpiolib consumer side from
> ath9k entirely then: it's not needed for the PCI devices
> at all, and the SoC devices no longer use it upstream or
> in openwrt.

Alright cool, in that case I am OK with just ripping it out entirely :)

-Toke

