Return-Path: <linux-kernel+bounces-133285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A5389A1BA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E727281A83
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 15:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B191816FF44;
	Fri,  5 Apr 2024 15:47:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1622516FF38;
	Fri,  5 Apr 2024 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712332046; cv=none; b=S7oOskpisSIMlNGGNidFZsR0eeJg0Zt5RPu96zUAT7+Zvfuqen0cFOnWAS58Cbk34f5ULOxeJaJxthUP7/IOq437PAit9/sHyrsU3aNWB07klkDppdk6P+xUxE/cUWoRbskraH731MT+oZ5VeHe2AvGhJwknzoj9+kIkqrjOTM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712332046; c=relaxed/simple;
	bh=QOPo52fRuvQqcTrD1klKb5S8Y6y2nkTuw3B0REf1mV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNLV9/DPZwbfPt1xqSgBmLBMqLWP2qi5jUZiNgLA4tQZmoexc3hCOfE5rDn0ZcY/t+3hp73sqml2F3WvqEn78gttrxg7ZYb2KA6X1v19gH4N8SvktMDkiO1i2qDm29rvyW5bc6bYiL7/OU7+u9vc2OoM3SIsQQu1LsTvKvO68So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD4DCFEC;
	Fri,  5 Apr 2024 08:47:53 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89113F64C;
	Fri,  5 Apr 2024 08:47:21 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:47:19 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Peng Fan <peng.fan@nxp.com>, Linus Walleij <linus.walleij@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAdB4T7sTa2Z7db@bogus>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhAa3NPO19mINYJP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAa3NPO19mINYJP@smile.fi.intel.com>

On Fri, Apr 05, 2024 at 06:38:04PM +0300, Andy Shevchenko wrote:
> On Fri, Apr 05, 2024 at 02:13:28AM +0000, Peng Fan wrote:
> > > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > wrote:
>
> ...
>
> > > > >                         ret = pin_config_get_for_pin(pctldev, pin, &config);
> > > > >                 /* These are legal errors */
> > > > > -               if (ret == -EINVAL || ret == -ENOTSUPP)
> > > > > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret ==
> > > > > + -EOPNOTSUPP)
> > > >
> > > > TBH it's a bit odd to call an in-kernel API such as
> > > > pin_config_get_for_pin() and get -EOPNOTSUPP back. But it's not like I care
> > > a lot, so patch applied.
> > >
> > > Hmm... I would like actually to get this being consistent. The documentation
> > > explicitly says that in-kernel APIs uses Linux error code and not POSIX one.
> >
> > Would you please share me the documentation?
>
> Sure.
> https://elixir.bootlin.com/linux/latest/source/include/linux/pinctrl/pinconf.h#L24
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2825
> https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2845
>
> I admit that this is not the best documented, feel free to produce a proper
> documentation.
>

Ah OK, my bad. I assumed you were referring to the entire kernel tree and
not just GPIO/pinux. Sorry for that.

> > > This check opens a Pandora box.
> > >
> > > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to have
> > > them being moved to ENOTSUPP, rather this patch.
> >
> > I see many patches convert to use EOPNOTSUPP by checking git log.
>
> How is that related? You mean for GPIO/pin control drivers?
>
> > And checkpatch.pl reports warning for using ENOTSUPP.
>
> checkpatch has false-positives, this is just one of them.
>

Fair enough.

> > BTW: is there any issue if using EOPNOTSUPP here?
>
> Yes. we don't want to be inconsistent. Using both in one subsystem is asking
> for troubles. If you want EOPNOTSUPP, please convert *all* users and drop
> ENOTSUPP completely (series out of ~100+ patches I believe :-), which probably
> will be not welcome).
>

Well, I don't agree with that 100% now since this is GPIO/pinmux sub-system
practice only. What if we change the source/root error cause(SCMI) in this
case and keep GPIO/pinmux happy today but tomorrow when this needs to be
used in some other subsystem which uses EOPNOTSUPP by default/consistently.
Now how do we address that then, hence I mentioned I am not 100% in agreement
now while I was before knowing that this is GPIO/pinmux strategy.

I don't know how to proceed now 🙁.

--
Regards,
Sudeep

