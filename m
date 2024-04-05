Return-Path: <linux-kernel+bounces-133327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B8689A247
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190DE1F23E59
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31FD17108B;
	Fri,  5 Apr 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIyo7TLP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61F04689;
	Fri,  5 Apr 2024 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333823; cv=none; b=Y8RLeQXPb5BunLqN3HopR7+/eRIWTnLRJVyQFsrNDReGX2pxQlULV4hVqdzkjJwkmuFAiawdOH07ewjE/s2N6aR7VnTgeinR7lTpYFoBUmiqfvC6rbFe73kuHr4j41UEzUEJTfjln4ptW1s3i6383y3cREsmxFmwAEnW3wbUW8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333823; c=relaxed/simple;
	bh=AbSgU87f6pchFf1ewtkS0yMj1das2twYARNEOtZQbKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acdKUp+WYD6PRSYa0U73y25uXXDWdq2N6NjwNL1WLGgKC1FiOb+NKko3SU6hP9EfpanCvXlRPV7HY56izvrfXsXPs3joBtd9oyJf8FB8rvK2PIvbW5rzIhyS5Lyayr16kxV3ILEeNGdN8MZesFzCGcNAaWipOYPvo+IrP+oDG9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIyo7TLP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712333822; x=1743869822;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=AbSgU87f6pchFf1ewtkS0yMj1das2twYARNEOtZQbKk=;
  b=gIyo7TLPo39icuxbkFUWpxeQY76OVLYmDAXvmfUKdkZSIo8ZMgDfTpXx
   Q/q5p2e5ktKg9YGuVSPAgqNTssXJoQh3AGtzdxXyBYLtIZD5QG7nqM4O4
   hgxPkknquzwqPnIK7pg1qNJ/88zOh7NnC0PwlMVL771m7tlNJE8OoE/jK
   d85sQg6XBg6VuuMvxO+PBgZLoFgKI6g1Ir6/4MK/41+U4tmZhWR3COiUw
   dle+USYVPpn26uZ6ijhbU70EoXJzlBLXx6Vi/hgPM/p8eku7TSOir7DkA
   PXDZBbd+GApcjr53DW8TNBmUBW++P1N8rrI9fFKenErjbSyP1jD/5lfzG
   Q==;
X-CSE-ConnectionGUID: kNeKjkZ+TmWMQ1hZVFjPag==
X-CSE-MsgGUID: pPut8fWJRnmGpzWMb5+A9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7797213"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7797213"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:17:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915258228"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915258228"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:16:59 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rsmFM-00000001nUN-3T31;
	Fri, 05 Apr 2024 19:16:56 +0300
Date: Fri, 5 Apr 2024 19:16:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Peng Fan <peng.fan@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAj-LZWv4M3vS6F@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhAa3NPO19mINYJP@smile.fi.intel.com>
 <ZhAdB4T7sTa2Z7db@bogus>
 <ZhAhcI3g4xJ1ANzu@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAhcI3g4xJ1ANzu@pluto>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 05:06:08PM +0100, Cristian Marussi wrote:
> On Fri, Apr 05, 2024 at 04:47:19PM +0100, Sudeep Holla wrote:
> > On Fri, Apr 05, 2024 at 06:38:04PM +0300, Andy Shevchenko wrote:
> > > On Fri, Apr 05, 2024 at 02:13:28AM +0000, Peng Fan wrote:
> > > > > On Thu, Apr 04, 2024 at 01:44:50PM +0200, Linus Walleij wrote:
> > > > > > On Mon, Apr 1, 2024 at 4:02 PM Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > > > wrote:

..

> > > > > > >                         ret = pin_config_get_for_pin(pctldev, pin, &config);
> > > > > > >                 /* These are legal errors */
> > > > > > > -               if (ret == -EINVAL || ret == -ENOTSUPP)
> > > > > > > +               if (ret == -EINVAL || ret == -ENOTSUPP || ret ==
> > > > > > > + -EOPNOTSUPP)
> > > > > >
> > > > > > TBH it's a bit odd to call an in-kernel API such as
> > > > > > pin_config_get_for_pin() and get -EOPNOTSUPP back. But it's not like I care
> > > > > a lot, so patch applied.
> > > > >
> > > > > Hmm... I would like actually to get this being consistent. The documentation
> > > > > explicitly says that in-kernel APIs uses Linux error code and not POSIX one.
> > > >
> > > > Would you please share me the documentation?
> > >
> > > Sure.
> > > https://elixir.bootlin.com/linux/latest/source/include/linux/pinctrl/pinconf.h#L24
> > > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2825
> > > https://elixir.bootlin.com/linux/latest/source/drivers/gpio/gpiolib.c#L2845
> > >
> > > I admit that this is not the best documented, feel free to produce a proper
> > > documentation.
> > 
> > Ah OK, my bad. I assumed you were referring to the entire kernel tree and
> > not just GPIO/pinux. Sorry for that.
> 
> ... from this thread, my understanding too was that this forbidden usage of
> POSIX errors for in-kernel API was general to any subsystem...so the ask
> for docs about this...
> 
> > > > > This check opens a Pandora box.
> > > > >
> > > > > FWIW, it just like dozen or so drivers that needs to be fixed, I prefer to have
> > > > > them being moved to ENOTSUPP, rather this patch.
> > > >
> > > > I see many patches convert to use EOPNOTSUPP by checking git log.
> > >
> > > How is that related? You mean for GPIO/pin control drivers?
> > >
> > > > And checkpatch.pl reports warning for using ENOTSUPP.
> > >
> > > checkpatch has false-positives, this is just one of them.
> > 
> > Fair enough.
> >
> > > > BTW: is there any issue if using EOPNOTSUPP here?
> > >
> > > Yes. we don't want to be inconsistent. Using both in one subsystem is asking
> > > for troubles. If you want EOPNOTSUPP, please convert *all* users and drop
> > > ENOTSUPP completely (series out of ~100+ patches I believe :-), which probably
> > > will be not welcome).
> > 
> > Well, I don't agree with that 100% now since this is GPIO/pinmux sub-system
> > practice only. What if we change the source/root error cause(SCMI) in this
> > case and keep GPIO/pinmux happy today but tomorrow when this needs to be
> > used in some other subsystem which uses EOPNOTSUPP by default/consistently.
> > Now how do we address that then, hence I mentioned I am not 100% in agreement
> > now while I was before knowing that this is GPIO/pinmux strategy.
> > 
> > I don't know how to proceed now 🙁.
> 
> from checkpatch.pl:
> 
> # ENOTSUPP is not a standard error code and should be avoided in new patches.    
> # Folks usually mean EOPNOTSUPP (also called ENOTSUP), when they type ENOTSUPP.  
> # Similarly to ENOSYS warning a small number of false positives is expected.     
>  
> ...so it seems to me that the this is NOT a false positive BUT Pinctrl/GPIO
> subsystem is an exception in these regards, since this is what is explcitly
> state in checkpatch comments AND there is no generalized doc on this....

Checkpatch is false positive _in this case_.
And in practice it's not the first and not the last false positive by checkpatch.
Again, checkpatch is a recommendation, not a letter of law. Documentation is.

> ....but twe can happily oblige to Pinctrl expectations by remapping to ENOTSUPP
> in the pinctrl protocol layer or driver...just I won't certainly do that at the
> SCMI core layer at all at this point...as Sudeep said ...especially because there
> is NO generalized docs for the above ban of POSIX errors for in-Linux kernel API...

There is no ban, we use POSIX error codes heavily in kernel.

If you think GPIO/pin control has a flaw, send patches. I'm not a maintainer there,
perhaps conversion of all GPIO and pin control drivers to POSIX error code will be
warmly welcome, who knows.

But before that, we want to have ENOTSUPP from callbacks that are used in
GPIO/pin control drivers for the sake of consistency.

For that, I'm going to submit fixes to Intel PMIC GPIO drivers soon.

-- 
With Best Regards,
Andy Shevchenko



