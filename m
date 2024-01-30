Return-Path: <linux-kernel+bounces-45259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F1842DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABC71F26187
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7356B24214;
	Tue, 30 Jan 2024 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYnG2/su"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D7071B46;
	Tue, 30 Jan 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706646481; cv=none; b=up3+V6AHNuG8PxcdWQso8fZil4F0xkg7EPZRtDvyQQ6mL2WIyPjhCkyF4ZJW3hnD2UlPMeLYWcRqyvwVZcWlWi9jmj49P1xl8u2Zt0wPDrpiuEhsqzyxlFw511oLsAIWSj2kN3W09bMKtIIY5CHCjugU3sMraPQdRIM2NoFuYmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706646481; c=relaxed/simple;
	bh=f8ZYd/m4g8k5qSL4jcMpv2BFLuBv2/ih8nBsDbbrmcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8BwjY3dvAo9VKEb/tKiZ0YkL2yQaS/+djp23vkWxhLztzJ40/38HBVhZcmG02a6kETxeycrCATTYTPNJ1cQUJ/nBPGuFEto7k4XlKvrBoRtXTuAzztCeBxkdhwBtyIlU12GXpVb2CSTqUw6v5pX8elGUl+WFuLVihpnTo1+TRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYnG2/su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9175C433C7;
	Tue, 30 Jan 2024 20:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706646481;
	bh=f8ZYd/m4g8k5qSL4jcMpv2BFLuBv2/ih8nBsDbbrmcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYnG2/su8b0tWxPMCgTKFeab0yZ4Gv08nGflRtzlcX9Fe47LS+vYkAKmHACAHfqBY
	 cYIDpVXCO4L1PCd0TStF+aLdoXC4O1+g/7Dp4gzmxA4XWT0mM9YUumfAVwksJN6Qbi
	 YkPuu7x0Cq2xaG+ktiLImKtmAZ2D4Tm9EZYNzOefGcu3UxuAx9zF7NUah5pmaGj/+D
	 Wa2ns5MKD63QvR82EbBZ7rwu8aWJT5WwFoGb9b6PYxQyhCnyMcB6Ui0TkQhO3HNIqo
	 uswf0ZCCgt/2NIaJC0AqW2t1FD0ghEd+2ICBSKFRoUovNAEf4lJw7S/gb/KPX3lxVj
	 t42n071vwoNHw==
Date: Tue, 30 Jan 2024 14:27:58 -0600
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>, arnd@arndb.de,
	krzysztof.kozlowski+dt@linaro.org, linux@roeck-us.net,
	wim@linux-watchdog.org, conor+dt@kernel.org,
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com,
	chanho61.park@samsung.com, semen.protsenko@linaro.org,
	kernel-team@android.com, tudor.ambarus@linaro.org,
	andre.draszik@linaro.org, willmcvicker@google.com,
	linux-fsd@tesla.com, linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 3/9] watchdog: s3c2410_wdt: update to use new
 exynos_pmu_*() apis
Message-ID: <20240130202758.GA2237959-robh@kernel.org>
References: <20240122225710.1952066-1-peter.griffin@linaro.org>
 <20240122225710.1952066-4-peter.griffin@linaro.org>
 <da30a68a-e29f-45c8-aa73-02955255a457@linaro.org>
 <CADrjBPor5tMY4r0jOy7GH36auCU7dWn6Qn4ct89bsSMW4vAQOA@mail.gmail.com>
 <6c72a521-1048-42eb-ac74-d8f718a90723@linaro.org>
 <CAGETcx-CCpaV7R0O0HpDpoX6KxQBuJiMmKdWA8nDE-5Qj2Sa7g@mail.gmail.com>
 <f4d3aa5a-e01d-4ef3-8004-b6eac4461184@linaro.org>
 <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx_HGcuGQTO11tzX0EvnuLEaKYc4vBse1CRP0JwPqMJdQQ@mail.gmail.com>

On Wed, Jan 24, 2024 at 01:27:01PM -0800, Saravana Kannan wrote:
> On Tue, Jan 23, 2024 at 10:27 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 24/01/2024 04:37, Saravana Kannan wrote:
> > > On Tue, Jan 23, 2024 at 10:12 AM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 23/01/2024 18:30, Peter Griffin wrote:
> > >>>>>               dev_warn(wdt->dev, "Couldn't get RST_STAT register\n");
> > >>>>>       else if (rst_stat & BIT(wdt->drv_data->rst_stat_bit))
> > >>>>> @@ -698,14 +699,6 @@ static int s3c2410wdt_probe(struct platform_device *pdev)
> > >>>>>       if (ret)
> > >>>>>               return ret;
> > >>>>>
> > >>>>> -     if (wdt->drv_data->quirks & QUIRKS_HAVE_PMUREG) {
> > >>>>> -             wdt->pmureg = syscon_regmap_lookup_by_phandle(dev->of_node,
> > >>>>> -                                             "samsung,syscon-phandle");
> > >>>>> -             if (IS_ERR(wdt->pmureg))
> > >>>>> -                     return dev_err_probe(dev, PTR_ERR(wdt->pmureg),
> > >>>>> -                                          "syscon regmap lookup failed.\n");
> > >>>>
> > >>>>
> > >>>> Continuing topic from the binding: I don't see how you handle probe
> > >>>> deferral, suspend ordering.
> > >>>
> > >>> The current implementation is simply relying on exynos-pmu being
> > >>> postcore_initcall level.
> > >>>
> > >>> I was just looking around for any existing Linux APIs that could be a
> > >>> more robust solution. It looks like
> > >>>
> > >>> of_parse_phandle()
> > >>> and
> > >>> of_find_device_by_node();
> > >>>
> > >>> Are often used to solve this type of probe deferral issue between
> > >>> devices. Is that what you would recommend using? Or is there something
> > >>> even better?
> > >>
> > >> I think you should keep the phandle and then set device link based on
> > >> of_find_device_by_node(). This would actually improve the code, because
> > >> syscon_regmap_lookup_by_phandle() does not create device links.
> > >
> > > I kinda agree with this. Just because we no longer use a syscon API to
> > > find the PMU register address doesn't mean the WDT doesn't depend on
> > > the PMU.
> > >
> > > However, I think we should move to a generic "syscon" property. Then I
> > > can add support for "syscon" property to fw_devlink and then things
> > > will just work in terms of probe ordering, suspend/resume and also
> > > showing the dependency in DT even if you don't use the syscon APIs.
> > >
> > > Side note 1:
> > >
> > > I think we really should officially document a generic syscon DT
> > > property similar to how we have a generic "clocks" or "dmas" property.
> > > Then we can have a syscon_get_regmap() that's like so:

The difference is we know what to do with clocks, dma, etc. The only 
thing we know from "syscon" is it's random register bits.

> > >
> > > struct regmap *syscon_get_regmap(struct device *dev)
> > > {
> > >         return syscon_regmap_lookup_by_phandle(dev->of_node, "syscon");
> > > }
> > >
> > > Instead of every device defining its own bespoke DT property to do the
> > > exact same thing. I did a quick "back of the envelope" grep on this
> > > and I get about 143 unique properties just to get the syscon regmap.
> > > $ git grep -A1 syscon_regmap_lookup_by_phandle | grep '"' | sed -e
> > > 's/^[^"]*//' -e 's/"[^"]*$/"/' | sort | uniq | wc -l
> > > 143
> >
> > Sorry, generic "syscon" property won't fly with DT maintainers, because
> > there is no such thing as syscon in any of hardware.
> 
> Then why do we allow a "syscon" compatible string and nodes? If the
> "syscon" property isn't clear enough, we can make it something like
> gpios and have it be <whatever>-syscon or have syscon-names property
> if you want to give it a name.

I'm pretty hesistant to expand anything syscon related. Really, I'd like 
to get rid of "syscon" compatible. It's just a hint to create a regmap.

> 143 bespoke properties all to say "here are some registers I need to
> twiddle that's outside my regmap" doesn't seem great.

I wonder how many aren't outside of the node's main registers, but are 
the only registers. That's quite common, but that would have largely 
been before we started saying to make those a child node of the syscon.

Changing wouldn't do anything to get rid of the bespoke strings. It just 
shifts them from property names to property name prefix or -names 
string.

> 
> > >
> > > Side note 2:
> > >
> > > How are we making sure that it's the exynos-pmu driver that ends up
> > > probing the PMU and not the generic syscon driver? Both of these are
> > > platform drivers. And the exynos PMU device lists both the exynos
> > > compatible string and the syscon property. Is it purely a link order
> > > coincidence?
> >
> > initcall ordering
> 
> Both these drivers usr postcore_initcall(). So it's purely because
> soc/ is listed earlier in drivers/Makefile than mfd/. And as soon as
> drivers are made into modules this is going to break. This is
> terrible. If you want to have a modular system, this is going to throw
> in a wrench.

IMO, a "syscon" shouldn't be a module. It's just a regmap.

Rob

