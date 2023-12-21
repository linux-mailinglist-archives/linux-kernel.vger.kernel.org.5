Return-Path: <linux-kernel+bounces-7967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D849581AFE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08F701C23A09
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A4C156DD;
	Thu, 21 Dec 2023 07:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QSZcROZe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDAA156CB;
	Thu, 21 Dec 2023 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E9FB6C0005;
	Thu, 21 Dec 2023 07:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703145476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Eu7zR58/A5+I3jTzwSMEK0TkRVpJ1QTPYfi7nQg/PvU=;
	b=QSZcROZeH5xz0kU7AXaeCSVNQDDY/yRKDMO84ECGwrv+GFwT6JcSGyk+j+ExUYYE45UKcO
	+m9M0bV36VLrUKgJwml5glXA4QQlpdMac06dm5t9dzyb2BU6Kw55z9Rvi+CCCrDtYIdePU
	ti2HesGllHP9yUVabUVkyWttW2BJD9QFGPcHiJJ+n4Aup2MotqcmgytldZs98Ms6+oayGR
	ZskP6bsS9dQm5lZez74JW5VcsigxhcHKVwMDN8YJxdsTuTsAkrh1B8vOvdNLX3yOShaVqR
	HOxjkFHq0TnHUzv1DmVEea9IPpBZxRl7k+Gg6qQ+M/IxVAUc/jmfSFVMFz67FA==
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Paul Burton <paulburton@kernel.org>, linux-mips@vger.kernel.org, Jiaxun
 Yang <jiaxun.yang@flygoat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir
 Kondratiev <vladimir.kondratiev@mobileye.com>, Tawfik Bayouk
 <tawfik.bayouk@mobileye.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, =?utf-8?Q?Th=C3=A9o?= Lebrun
 <theo.lebrun@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 00/22] Add support for the Mobileye EyeQ5 SoC
In-Reply-To: <ZYNhbQjMbAH6I0kI@alpha.franken.de>
References: <20231212163459.1923041-1-gregory.clement@bootlin.com>
 <878r5vctdg.fsf@BL-laptop> <ZYNhbQjMbAH6I0kI@alpha.franken.de>
Date: Thu, 21 Dec 2023 08:57:55 +0100
Message-ID: <87frzwasxo.fsf@BL-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-GND-Sasl: gregory.clement@bootlin.com

Hello Thomas,

Thanks for your fedback

> On Fri, Dec 15, 2023 at 05:39:39PM +0100, Gregory CLEMENT wrote:
>> Hello Thomas,
>> 
>> > Hello,
>> >
>> > The EyeQ5 SoC from Mobileye is based on the MIPS I6500 architecture
>> > and features multiple controllers such as the classic UART, I2C, SPI,
>> > as well as CAN-FD, PCIe, Octal/Quad SPI Flash interface, Gigabit
>> > Ethernet, MIPI CSI-2, and eMMC 5.1. It also includes a Hardware
>> > Security Module, Functional Safety Hardware, and MJPEG encoder.
>> >
>> > One peculiarity of this SoC is that the physical address of the DDDR
>> > exceeds 32 bits. Given that the architecture is 64 bits, this is not
>> > an issue, but it requires some changes in how the mips64 is currently
>> > managed during boot.
>> >
>> > In this fifth version, there aren't many changes, mostly just tweaking
>> > commit messages based on Sergey's feedback and fixing up the code
>> > style. But, the real reason for this series is a bit of a whoopsie on
>> > my end. It turns out, despite what I confidently claimed in the last
>> > round, some configuration tweaks were missing. All sorted now, though!
>> >
>> 
>> A few weeks ago, you were concerned about the introduction of the
>> specific kconfig CONFIG_USE_XKPHYS to support EyeQ5, and you wanted us
>> to set up a new platform instead. Since then, Jiaxun proposed a series
>> that was merged here to provide more generic support.
>
> well, there is more to improve and stuff I don't like in Jaixun series.
> For example misusing CONFIG_PHYSICAL_START to force a load address via config
> (IMHO it's already a hack for CRASH_DUMP).
>
> As there is your series and Jiaxun series, where should I comment more
> detailed ?

I think you could start on Jiaxun series but the one merged in my
series, because I already had a few fixes for it.

>
>> I had other issues in the initial series, and I think that now I've
>> fixed all of them. So, I would like to know what your opinion is now
>> about this series.
>> 
>> Will you accept it, or do you still think that a new platform has to be
>> set up?
>
> things have improved, but I'm still in favor to use a new platform.
> And my main point stays. A "generic" kernel compiled for EyeQ5 will
> just run on that platform, which doesn't sound generic to me.

I do not oppose the addition of a new platform, even though, like
Jiaxun, I would prefer to avoid duplicating code. The only thing
preventing the use of the same kernel for EyeQ5 and other platforms is
the starting address. Therefore, if it were possible to have a
relocatable kernel, this issue would disappear.

However, while waiting for your feedback on Jiaxun's part, I will
attempt to add a new platform to assess exactly what the implications
are.

Gregory

>
> Thomas.
>
> -- 
> Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
> good idea.                                                [ RFC1925, 2.3 ]

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com

