Return-Path: <linux-kernel+bounces-82877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B842D868B09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95071C217A9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CD31350FB;
	Tue, 27 Feb 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="JG/j0ufq"
Received: from mail.thorsis.com (mail.thorsis.com [92.198.35.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4311130E5E;
	Tue, 27 Feb 2024 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.198.35.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023412; cv=none; b=QyK/RG7YQcbasJey3krQqw4TVFyKr+wf21VrFyGor9b0CvtcLRUcCUtl7D8xwba5OYzl+QB8qmwxrqRL31Iiv8rtc7qGFtCZ4x1nAqkJCdDQ9/Eaf+FNUfz1/XogjWk7EqCcFhRSkcS15pEglcW9yFUxg3A8i5lcyz/yk5Yt4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023412; c=relaxed/simple;
	bh=1/iQrDsBBDPO1b2f0P8e798iamlgABu/lKjolSbaom8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To; b=bv7ZDk0H4M2CWe0iX85ECFxlZV4ajNxrQvs0yaqJSM/ocv4CuwngoR7BOf7kVbhgzX3Hk5nwLV1/Q2jfgIQJgzzBK01qMb7g6U0uidq3B/rO0InJm5e3zwC6CHTyPHo7Yr2u1DgUSChUKZyACxgFhnhM0SU+3BKYXzgXtfeogV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=JG/j0ufq; arc=none smtp.client-ip=92.198.35.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Date: Tue, 27 Feb 2024 09:43:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=default;
	t=1709023406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
	 references:references; bh=7Uk/Em1Wy/YrWxfP2kn7d3C/wN3DVXEFAdRTzDjTwXc=;
	b=JG/j0ufqnHwU7/XALdJ3171jsbweSsWPBgCpD8kmJzNbwcvakttsjBBM1F3YYX+6kPeT1v
	iR+KPHfROPNRuszMhXYa5fWEuzcfziCVYAzH+sJOhKSaGiSR0zwrctBkdjbEZLgtaTHb0X
	DyYTwlB08s9bWoOosUnBD+RF6VWP8ok1FnAxwMieXrL9z1WAqq9OLL8nejg7WnQjJ/Op+B
	8OwaLeIuNI+Yplx5mw1VNXNYe70yUkCHIlx2pa9tJcePvBdbgJpP1rjMU6dnh6J3X/oR8A
	+L1I+5BnyZ9Sl7rm1uNl5KETeEFnys5kJf+z5D3WJArhPrRLgcS7NQK2cASBxQ==
From: Alexander Dahl <ada@thorsis.com>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: "ojeda@kernel.org" <ojeda@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
Subject: Re: [PATCH 0/3] auxdisplay: 7 segment LED display
Message-ID: <20240227-married-amulet-da532c0a70d3@thorsis.com>
Mail-Followup-To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
	"ojeda@kernel.org" <ojeda@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
	"sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
	"andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
	"geert@linux-m68k.org" <geert@linux-m68k.org>,
	"pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>
References: <20240225213423.690561-1-chris.packham@alliedtelesis.co.nz>
 <20240226-scabby-fiber-87d5d6e45028@thorsis.com>
 <fd1c8657-62e6-449c-b47f-a2c3223b405c@alliedtelesis.co.nz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd1c8657-62e6-449c-b47f-a2c3223b405c@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hello Chris,

Am Mon, Feb 26, 2024 at 08:10:07PM +0000 schrieb Chris Packham:
> Hi Alex,
> 
> On 27/02/24 05:04, Alexander Dahl wrote:
> > Hello Chris,
> >
> > Am Mon, Feb 26, 2024 at 10:34:20AM +1300 schrieb Chris Packham:
> >> This series adds a driver for a 7 segment LED display.
> >>
> >> I'd like to get some feedback on how this could be extended to support >1
> >> character. The driver as presented is sufficient for my hardware which only has
> >> a single character display but I can see that for this to be generically useful
> >> supporting more characters would be desireable.
> >>
> >> Earlier I posted an idea that the characters could be represended by
> >> sub-nodes[1] but there doesn't seem to be a way of having that and keeping the
> >> convenience of using devm_gpiod_get_array() (unless I've missed something).
> >>
> >> [1] - https://scanmail.trustwave.com/?c=20988&d=trbc5eARVo-5gepRnwbAKbQmiGk1bOSpqZDQx9bx7w&u=https%3a%2f%2flore%2ekernel%2eorg%2flkml%2f2a8d19ee-b18b-4b7c-869f-7d601cea30b6%40alliedtelesis%2eco%2enz%2f
> > Read that thread out of curiosity and I'm sorry if I'm late to the
> > party, but I wondered why this is limited to LEDs connected to GPIOs?
> >
> > Would it be possible to somehow stack this on top of some existing
> > LEDs?  I mean you could wire a 7 segment device to almost any LED
> > driver IC with enough channels, couldn't you?
> 
> Mainly because the GPIO version is the hardware I have. I do wonder how 
> this might work with something like the pca9551 which really is just a 
> fancy version of the pca9554 on my board. A naive implementation would 
> be to configure all the pca9551 pins as GPIOs and use what I have as-is. 

My idea was to do it on top of the LED abstraction, not on top of the
GPIO abstraction.  Currently you are using the GPIO consumer interface
and group 7 gpios which are supplied by that pca9554 in your case, but
could also be coming from a SoC or a 74hc595 etc.

Why not put it a level of abstraction higher, and let it consume LEDs
instead of GPIOs?  Your usecase would still be possible then.

As far as I could see the concept of a LED consumer can be done, the
leds-group-multicolor driver in
drivers/leds/rgb/leds-group-multicolor.c does that, introduced with
kernel v6.6 not so long ago.  It sets the sysfs entries of the LEDs
part of the group to readonly so they are not usable on their own
anymore and one would not disturb the grouped multicolor LED.

This would allow to use LEDs as a 7 segment group driven by any LED
driver including leds-gpio.

> Making a line display out of LED triggers might be another way of doing 
> it but not something I really want to pursue.

Fair enough.  I just wanted to share my idea.  Didn't want to pressure
you in any direction. :-)

Greets
Alex

> 
> >
> > Greets
> > Alex
> >
> >> Chris Packham (3):
> >>    auxdisplay: Add 7 segment LED display driver
> >>    dt-bindings: auxdisplay: Add bindings for generic 7 segment LED
> >>    ARM: dts: marvell: Add 7 segment LED display on x530
> >>
> >>   .../auxdisplay/generic,gpio-7seg.yaml         |  40 +++++
> >>   .../boot/dts/marvell/armada-385-atl-x530.dts  |  13 +-
> >>   drivers/auxdisplay/Kconfig                    |   7 +
> >>   drivers/auxdisplay/Makefile                   |   1 +
> >>   drivers/auxdisplay/seg-led.c                  | 152 ++++++++++++++++++
> >>   5 files changed, 212 insertions(+), 1 deletion(-)
> >>   create mode 100644 Documentation/devicetree/bindings/auxdisplay/generic,gpio-7seg.yaml
> >>   create mode 100644 drivers/auxdisplay/seg-led.c
> >>
> >> -- 
> >> 2.43.2
> >>
> >>

