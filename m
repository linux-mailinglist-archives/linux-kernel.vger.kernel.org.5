Return-Path: <linux-kernel+bounces-38620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182F83C34B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89104B257A6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E02F2C69C;
	Thu, 25 Jan 2024 13:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jKf/t//U"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5821F59B49
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188018; cv=none; b=i/rp3ts9+ZzLTAedaal4O+0y0BR1n8O8IygT+RbPz88uMmrUrmifOsvZ4cn3YLoyhYhtQE0WKNx731TjNlfA+MbLSeaCzNLgb+e9v/FsSQ1cUUOfNgG3Onm8o2DWyuG4de3aaBMqrw8MPNAlL6jAB1xB27kTPHONycv5hyEEa7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188018; c=relaxed/simple;
	bh=4tD1G/Ca5v+ls1TNb0SRTW2WCwsF3A3UVdT684WBzZU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XEjp8baC/kCHG27hpbyVnUOk9w3auJ2eTUwiqeUSXxj8OfIrFIRFIMPAgVolrC+1tUyEroo3a5MYtopym4hthZuhNXivSu7cxbGvOTwaMJjFhki9qa9lbOevqGZM2hqrysmUTIn8LkBykngSRnNp3S+VkeyNhi8fFoQwNgVolAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jKf/t//U; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46857FF813;
	Thu, 25 Jan 2024 13:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1706188007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n7Q6OTUTtuT1kEA4hYWIhFboomzzNbDeo6fWM/l/3aI=;
	b=jKf/t//UerWLWfg6Vqq9e7kwmRYFXkYJBpEsiTgHZmzXhw24mrMg5Aa5YJfaDnhi8hlkrU
	jhu9eg+TpTjcmZ9EKC+1PRQ1GYPe3YaiciZL32VWZdR8oiJsxtZuZ+HDns9hVOTyFPgOLV
	/fAQU9pduD1N+cx4qSqqUBauxTZ4X8/PC7gRhIpvJOc2jaKpiPnXmVWwRtzuphh/mNMkYD
	3IfC2c0rSGfThTdzgO3mx5SIFEREsrn4APlNVgSPSwsDS+ypBVYcY1Uf3JXBZjm5yCWHmS
	7fjVNPNXUlFy3NCUolyyu+QkMfM/dJKcl1wYAbFynMKewrbKX614h517YPDulg==
Date: Thu, 25 Jan 2024 14:06:45 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: "Arnd Bergmann" <arnd@arndb.de>
Cc: "Arnd Bergmann" <arnd@kernel.org>, "Srinivas Kandagatla"
 <srinivas.kandagatla@linaro.org>, regressions@lists.linux.dev,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, "Chen-Yu Tsai"
 <wenst@chromium.org>, "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 asahi@lists.linux.dev, "Sven Peter" <sven@svenpeter.dev>, "Michael Walle"
 <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvmem: include bit index in cell sysfs file name
Message-ID: <20240125140645.0c629760@xps-13>
In-Reply-To: <911c4a6b-83af-46a8-8f7e-250da4f0f1ad@app.fastmail.com>
References: <20240122153442.7250-1-arnd@kernel.org>
	<20240124182256.776c164b@xps-13>
	<1d13250c-e48b-4e31-b449-5b54837a0d40@app.fastmail.com>
	<20240124231120.562f06f3@xps-13>
	<911c4a6b-83af-46a8-8f7e-250da4f0f1ad@app.fastmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Arnd,

arnd@arndb.de wrote on Thu, 25 Jan 2024 13:15:26 +0100:

> On Wed, Jan 24, 2024, at 23:11, Miquel Raynal wrote:
> > Hi Arnd,
> >
> > arnd@arndb.de wrote on Wed, 24 Jan 2024 20:49:53 +0100:
> > =20
> >> On Wed, Jan 24, 2024, at 18:22, Miquel Raynal wrote: =20
> >> > arnd@kernel.org wrote on Mon, 22 Jan 2024 16:34:10 +0100:
> >> >   =20
> >> >> From: Arnd Bergmann <arnd@arndb.de>
> >> >>=20
> >> >>=20
> >> >> As far as I can tell, this is a problem for any device with multipl=
e cells on
> >> >> different bits of the same address. Avoid the issue by changing the=
 file name
> >> >> to include the first bit number.   =20
> >> >
> >> > There is only one bit number right? We are talking about byte offsets
> >> > so this value can only range from 0 to 7? If we understand each other
> >> > correctly then why not, I'm fine with the extra ",0" thing.   =20
> >>=20
> >> On the Apple M1, the nvmem registers are 32 bit wide, so the
> >> bit numbers can go up to 31. I can imagine some system using
> >> 64-bit registers, but it's unlikely to be higher than that. =20
> >
> > In this case we will soon or later have a problem again. Can we include
> > the full offset of the bit and not just the first digit? =20
>=20
> I thought that is what my patch does, maybe I don't
> undestand the problem you are referring to. This is what
> I see on my system with the patch applied:
>=20
> $ cd /sys/devices/platform/soc@200000000/2922bc000.efuse
> $ find . -name efuse\*
> ./apple_efuses_nvmem0/cells/efuse@a24,11

Sorry for the misunderstanding, I thought the above situation would
be:

  ./apple_efuses_nvmem0/cells/efuse@a24,1

But the below output is actually fine.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ./apple_efuses_nvmem0/cells/efuse@a24,9
> ./apple_efuses_nvmem0/cells/efuse@a1c,f
> ./apple_efuses_nvmem0/cells/efuse@a20,17
> ./apple_efuses_nvmem0/cells/efuse@a20,1e
> ./apple_efuses_nvmem0/cells/efuse@a18,0
> ./apple_efuses_nvmem0/cells/efuse@a14,b
> ./apple_efuses_nvmem0/cells/efuse@a1c,1f
> ./apple_efuses_nvmem0/cells/efuse@a1c,d
> ./apple_efuses_nvmem0/cells/efuse@a20,1c
> ./apple_efuses_nvmem0/cells/efuse@a18,15
> ./apple_efuses_nvmem0/cells/efuse@a14,0
> ./apple_efuses_nvmem0/cells/efuse@a1c,14
> ./apple_efuses_nvmem0/cells/efuse@a24,3
> ./apple_efuses_nvmem0/cells/efuse@a20,7
> ./apple_efuses_nvmem0/cells/efuse@a18,5
> ./apple_efuses_nvmem0/cells/efuse@a10,16
> ./apple_efuses_nvmem0/cells/efuse@a1c,12
> ./apple_efuses_nvmem0/cells/efuse@a20,5
> ./apple_efuses_nvmem0/cells/efuse@a18,3
> ./apple_efuses_nvmem0/cells/efuse@a18,a
> ./apple_efuses_nvmem0/cells/efuse@a10,1b
> ./apple_efuses_nvmem0/cells/efuse@a14,5
> ./apple_efuses_nvmem0/cells/efuse@a1c,19
> ./apple_efuses_nvmem0/cells/efuse@a24,f
> ./apple_efuses_nvmem0/cells/efuse@a18,1d
> ./apple_efuses_nvmem0/cells/efuse@a14,13
> ./apple_efuses_nvmem0/cells/efuse@a18,8
> ./apple_efuses_nvmem0/cells/efuse@a18,f
> ./apple_efuses_nvmem0/cells/efuse@a20,14
> ./apple_efuses_nvmem0/cells/efuse@a10,19
> ./apple_efuses_nvmem0/cells/efuse@a18,1b
> ./apple_efuses_nvmem0/cells/efuse@a14,11
> ./apple_efuses_nvmem0/cells/efuse@a1c,a
> ./apple_efuses_nvmem0/cells/efuse@a10,1e
> ./apple_efuses_nvmem0/cells/efuse@a20,19
>=20
>       Arnd


Thanks,
Miqu=C3=A8l

