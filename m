Return-Path: <linux-kernel+bounces-40166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0A3083DB78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB601F22E5D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1721C2A5;
	Fri, 26 Jan 2024 14:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Om0oRCQL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB98F1B968;
	Fri, 26 Jan 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278184; cv=none; b=JEIcJ1QzvUj7UZoLmmv3C4g4YEZdmYzeioDDZo/4q+UTvzbGNG/d84wiBIFSIDo7wRLdJ82qtGloszZWM4i/J9J8tguIIBwFc6SzsiY/sEhx6VvCB1L3ku7PpxWhOtVl2YvwF3uxSkxQ4CsY4owUapbPB44O6/EAP+k2KipcFNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278184; c=relaxed/simple;
	bh=xjvX9s++LnaIDJF1MIrJOTUIqtJkbD9k/galL79P1/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LRDnQS+ZdwA7/ryDK3rogtHg9yJsiZbjoqluZ32FuVT5xWoPPP0dEqK0M+LVKk+yU+tG5micA91OQqxhL07iHw9zKUuD8TeA2KczVe5bf2Vco2QA27hkYBYh3WJiT8K/L1Bvcy2Lf9u9ogZ691o1bqQX3iNIspczYN3z/w/qHGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Om0oRCQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7925CC433F1;
	Fri, 26 Jan 2024 14:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706278183;
	bh=xjvX9s++LnaIDJF1MIrJOTUIqtJkbD9k/galL79P1/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Om0oRCQLE33QaRKTiCyE98xgjfypLUnmyl9oOTDHkGom3awMfABwalVJierUdet6n
	 61aTf6G9NUb+fy39AwAoB6dhvGs5Z17zhtkm4ayf2o/PFGDFvegIzFEZZ/kzTnDCXB
	 11ByiXsVKspS1PIohSy4Ew8gI8s+KwEM0I0P4fYM=
Date: Fri, 26 Jan 2024 06:09:43 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc: Lee Jones <lee@kernel.org>,
	Martin Kurbanov <mmkurbanov@salutedevices.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	kernel@salutedevices.com
Subject: Re: [PATCH v1 1/2] leds: aw200xx: support for hw pattern controllers
Message-ID: <2024012643-safeness-stipulate-153f@gregkh>
References: <20231207125938.175119-1-mmkurbanov@salutedevices.com>
 <20231207125938.175119-2-mmkurbanov@salutedevices.com>
 <20231221161011.GO10102@google.com>
 <85c89859-ae03-4692-9c09-5779e4c40eae@salutedevices.com>
 <20240125130049.GF74950@google.com>
 <20240126122310.hrs37vybo2wnxto3@CAB-WSD-L081021>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126122310.hrs37vybo2wnxto3@CAB-WSD-L081021>

On Fri, Jan 26, 2024 at 03:23:10PM +0300, Dmitry Rokosov wrote:
> Hello Lee,
> 
> On Thu, Jan 25, 2024 at 01:00:49PM +0000, Lee Jones wrote:
> > Looping in Jacek (LEDS) and Greg (SYFS) for some knowledgable input.
> > 
> > On Fri, 12 Jan 2024, Martin Kurbanov wrote:
> > > On 21.12.2023 19:10, Lee Jones wrote:
> > > > On Thu, 07 Dec 2023, Martin Kurbanov wrote:
> > > > 
> > > >> This led-controller supports 3 pattern controllers for auto breathing or
> > > >> group dimming control. Each pattern controller can work in auto
> > > >> breathing or manual control mode. All breathing parameters including
> > > >> rising/falling slope, on/off time, repeat times, min/max brightness
> > > >> and so on are configurable.
> > > >>
> > > >> Signed-off-by: Martin Kurbanov <mmkurbanov@salutedevices.com>
> > > >> ---
> > > >>  .../testing/sysfs-class-led-driver-aw200xx    | 108 +++
> > > >>  Documentation/leds/leds-aw200xx.rst           | 274 ++++++++
> > > >>  drivers/leds/leds-aw200xx.c                   | 649 ++++++++++++++++++
> > > >>  3 files changed, 1031 insertions(+)
> > > >>  create mode 100644 Documentation/leds/leds-aw200xx.rst
> > > > 
> > > > This interface is bananas.  Exposing an entire register interface to
> > > > sysfs does not sit will with me at all.  When we add support to a sysfs
> > > > class, we usually require it to be generic and work across all devices.
> > > > Adding device specific interfaces is generally decried and to be
> > > > avoided.  Don't forget, once we commit something to sysfs, it becomes
> > > > ABI and we have to support it forever.
> > > > 
> > > > A far better approach would be to add support for this in userspace
> > > > instead  You can use the standard I2C character device API to achieve
> > > > the same result.  That way we don't have the same level of commitment
> > > > and is generally a much more flexible/future-proof.
> > > > 
> > > 
> > > I used sysfs similarly to other LED drivers (for example, leds-lm3533).
> > > Additionally, the controller has interrupts about the completion of the pattern,
> > > which is best to handle in the kernel. In the case of implementation in user
> > > mode, there may be synchronization problems, as the controller has several
> > > memory pages that can be switched by writing the page number to register 0xF0.
> > 
> > leds-lm3533 is a 12 year old legacy exception AND has less than half of
> > the sysfs exports proposed here.  What makes aw200xx so different it
> > needs to an incomparable interface to any other that we currently
> > support?
> 
> >From my point of view, direct I2C raw requests from userspace are not a
> good solution as well due to synchronization problems, as Martin
> mentioned in the previous message.

Sorry, I missed this, what is the synchronization problem?  This is an
led, shouldn't have any real specific performance issues.

> We have honestly been attempting to integrate this functionality into
> the official LED pattern interface, but it cannot be achieved due to the
> absence of this interface's functionality:
> 1) Page-based access
> 2) Interrupts

I don't understand this, sorry.

> HW patterns are very useful mechanism to draw animation faster without
> any interactions with CPU, so I think we need to find the best architect
> approach for its integration.

The CPU is totally involved here, that should be identical.

> What is an alternative way to access such a hardware pattern interface?
> Debugfs? Or perhaps we should consider extending the LED pattern
> interface?

Or again, userspace.

debugfs is for debugging.

thanks,

greg k-h

