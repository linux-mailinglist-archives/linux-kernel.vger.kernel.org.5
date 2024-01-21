Return-Path: <linux-kernel+bounces-32102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A91A83567B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 16:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDA11C214B2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 15:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22613381A0;
	Sun, 21 Jan 2024 15:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA0tpgjL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AE938391;
	Sun, 21 Jan 2024 15:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705851694; cv=none; b=MlxTvYC8IqHVQiqRvNDpwB873vZSMC+FpK+rqKp0sEdA+ulH+TbYQZo/vaeTSEtnO0pAVbfQtsL89Nk+hk/O7Bsx4eiZZxU2BWhN4MfYVkzR5MJfvYEcXsWsRsWEXzBPCsxIk/NFKXwBPWQ7in/WQN0k+n+oGzQaQki4avOKR1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705851694; c=relaxed/simple;
	bh=j+llwv0+BWawFUWk0sHZ0w+WckOFi7ovlWd7fHU8QTs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bJjtFeUEP38ZCyCP68ASNTX89MqLKWps3JqRTtt9cScpioAre64MNx5KWxyaNil8oWG71KInmg7Q4nXDUirLxAuUId9a0cMuCvl+hVIywGMdmZwKjWJLFGW4neMtRbO1iWSMrIJwvBVUboW5hcV72joivFZ8goclXW9VVRXeLxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA0tpgjL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2BDC433C7;
	Sun, 21 Jan 2024 15:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705851693;
	bh=j+llwv0+BWawFUWk0sHZ0w+WckOFi7ovlWd7fHU8QTs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SA0tpgjL4kc2w/jC5DjEML6+dvuDSvPa3zcUrtzFkLl4H+0QQrkqiyHmYJU1OmJUT
	 wmKLe8nSbbpHPCam9zg0Hw98jz/FRPYUyE8IDXcDq3TQlAt8A+F7GfhBkRdJkLknUR
	 lPdcUApZ6d1yNWekeCpWJqlta0Q2QcODt7U0eslBjnjgygCQijamRpfECXKdHpt8h8
	 yBGqhC9qz1kEEf5mxfaO99EknfarKa7f9qyFSrzg4Pi/YS/OCRrT9IMTRt8Nf43Nve
	 nA3q1U53YWyqoCUKcTaku5kks3LLYVR+PxKfGxT0rk1bmXbZSnB8QziSMmfoO2ND32
	 TF0/n/YaenTtg==
Date: Sun, 21 Jan 2024 15:41:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Ceclan Dumitru <mitrutzceclan@gmail.com>, linus.walleij@linaro.org,
 brgl@bgdev.pl, andy@kernel.org, linux-gpio@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Walle <michael@walle.cc>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu
 <chiaen_wu@richtek.com>, Niklas Schnelle <schnelle@linux.ibm.com>, Leonard
 =?UTF-8?B?R8O2aHJz?= <l.goehrs@pengutronix.de>, Mike Looijmans
 <mike.looijmans@topic.nl>, Haibo Chen <haibo.chen@nxp.com>, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, David Lechner <dlechner@baylibre.com>, Ceclan
 Dumitru <dumitru.ceclan@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/2] dt-bindings: adc: add AD7173
Message-ID: <20240121154118.389e4e87@jic23-huawei>
In-Reply-To: <20240118-freebase-uptake-ec5fdf786d20@spud>
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
	<20240118-lunar-anthem-31bf3b9b351d@spud>
	<b96d5bfc-cc38-44c7-a88f-e7ac5e4eb71d@gmail.com>
	<20240118-freebase-uptake-ec5fdf786d20@spud>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 16:06:29 +0000
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jan 18, 2024 at 05:51:20PM +0200, Ceclan Dumitru wrote:
> > 
> > 
> > On 1/18/24 17:23, Conor Dooley wrote:  
> > > On Thu, Jan 18, 2024 at 02:49:22PM +0200, Dumitru Ceclan wrote:  
> > 
> > ...
> >   
> > >> +  adi,clock-select:
> > >> +    description: |
> > >> +      Select the ADC clock source. Valid values are:
> > >> +      int         : Internal oscillator
> > >> +      int-out     : Internal oscillator with output on XTAL2 pin
> > >> +      ext-clk     : External clock input on XTAL2 pin
> > >> +      xtal        : External crystal on XTAL1 and XTAL2 pins
> > >> +
> > >> +    $ref: /schemas/types.yaml#/definitions/string
> > >> +    enum:
> > >> +      - int
> > >> +      - int-out
> > >> +      - ext-clk
> > >> +      - xtal
> > >> +    default: int  
> > > I am not a fan of properties like this one, that in my view reimplement
> > > things that are supported by the regular clocks properties. I've got
> > > some questions for you so I can understand whether or not this custom
> > > property is required.
> > > 
> > > Whether or not the ext-clk or xtal is used is known based on
> > > clock-names - why is the custom property required to determine that?  
> 
> > > If neither of those clocks are present, then the internal clock would be
> > > used. Choosing to use the internal clock if an external one is provided
> > > sounds to me like a software policy decision made by the operating
> > > system.  
> > 
> > If there was no int-out, sure. I considered that the choice between int
> > and int-out could be made here. So better for driver to choose int/int-out?  
> 
> This part of my comments was specifically about choosing between use of
> the internal clock when ext-clk or xtal are provided, which I think
> excludes the possibility of using int-out, since the XTAL2 pin is an
> input.
> 
> There's 3 situations:
> - no external clock provided
> - ext-clk provided
> - xtal provided
> 
> For the former, you know you're in that state when no "clocks" property
> is present. The latter two you can differentiate based on "clock-names".
> 
> Choosing to use the internal clock if an external clock is provided
> seems to be a software policy decision, unless I am mistaken.

Agreed, though it rarely makes sense as if someone put down a precision
clock they normally wanted you to use it!

So as a general rule we don't both providing policy controls beyond if
there is extra hardware (external clock source) then use that.

If someone has a good reason to want to do something else then we can
probably figure out a reasonable way to control it.


> 
> > > 
> > > Finally, if the ADC has a clock output, why can that not be represented
> > > by making the ADC a clock-controller?
> > >   
> > 
> > Was not familiar with this/did not cross my mind. So if xtal/ext-clk is
> > present, the driver should detect it and disable the option for clock
> > output? (Common pin XTAL2)  
> 
> Yeah, if those clocks are provided you would not register as a clock
> controller. If there is a user of the output clock, it should have its
> own "clocks" property that references the ADC's output.
> 
> Your dt-binding could also make clocks/clock-names & clock-controller
> mutually exclusive.

That would indeed be the nicest solution.  How this has been done
in drivers has somewhat 'evolved' over time, but this is the nicest
option from point of view of standard bindings and clarity over what
is going on.

> 
> Cheers,
> Conor.


