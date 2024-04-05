Return-Path: <linux-kernel+bounces-133331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF19289A25C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18261282486
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE9817108C;
	Fri,  5 Apr 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PNfhUFPP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E71916D326;
	Fri,  5 Apr 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712334057; cv=none; b=OwzVXLqqg2xVM/YLfYzu2+fvGUNOW/DCVHHEhb/6ShgUcUUdP7uWwFk/dujCh21zL/mo7fWLLf2eK6efP5t8zqORu/qn0TslrtonUlxb3YcGfQf0VwvVOuc08qRKltXDfIqAIH9xJ7A0QNb4ieQ9gyNxY5J55/JjhJzyq7zPcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712334057; c=relaxed/simple;
	bh=KBr6g4Y6wmd++l/Zig57K0LQgIkpsQYiWwu3wjP3HWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjytZQNwEozVE9zJClA11u+S2iL6F3dYatHbbN4RW6rjkTP3GQcLXO7/RSAzOGW/CnKbhkd28b700N7yNmKQwHV6Peu2pVP1l+aRchk/L3320qxcZxilahT8nkhU9FuuFpukzJO4OsqVtnU5/2oX2tAmRBZY2L80Rz6r3V9RTiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PNfhUFPP; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712334056; x=1743870056;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=KBr6g4Y6wmd++l/Zig57K0LQgIkpsQYiWwu3wjP3HWM=;
  b=PNfhUFPPEZYO6mEQ11AfQDspQD3E2oERN0tZDuKgrgokMPdUQm5y3qwl
   bps4R90AHd2pTFF2l8rOzwU8XX5bhz/c6gN9LUfad05EX0U7yEsjbBMEH
   sqYu6ixhB00vrXFGiTATreZWSt8ZFM5Le+wWzQtNU6I83CwItZrGNugwP
   gMkSESza8kzI/TdzAu0NhyHswVD7mUYYGCuzPw0CLEzEFkEPh1Sf5MFNo
   9uaSt0tNcA9K7kXG0j0YnJl+K2Wi/9BGkow8W9CPxjKXq6H2vo3t9QJQZ
   SGdr0jj5c6SRAGRL79+H4JQ+UjFvfws1YVo+5GNYlvEMaRfoIAO1dUzo7
   g==;
X-CSE-ConnectionGUID: NObXz9d6QyavH2zRAjft9w==
X-CSE-MsgGUID: pvuKHHbVRNuieh6xciU9sQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7797632"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="7797632"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:20:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="915258317"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="915258317"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 09:20:31 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rsmIm-00000001nXB-3Qym;
	Fri, 05 Apr 2024 19:20:28 +0300
Date: Fri, 5 Apr 2024 19:20:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, Linus Walleij <linus.walleij@linaro.org>,
	"Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>
Subject: Re: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Message-ID: <ZhAkzFIv9fx-DQN3@smile.fi.intel.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZhAa3NPO19mINYJP@smile.fi.intel.com>
 <ZhAdB4T7sTa2Z7db@bogus>
 <ZhAe9oFz9wLQi4de@smile.fi.intel.com>
 <ZhAhpMNv8Agl4vCZ@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhAhpMNv8Agl4vCZ@bogus>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 05, 2024 at 05:07:00PM +0100, Sudeep Holla wrote:
> On Fri, Apr 05, 2024 at 06:55:34PM +0300, Andy Shevchenko wrote:
> > On Fri, Apr 05, 2024 at 04:47:19PM +0100, Sudeep Holla wrote:

..

> > > Well, I don't agree with that 100% now since this is GPIO/pinmux sub-system
> > > practice only.
> >
> > 	git grep -lw ENOTSUPP
> >
> > utterly disagrees with you.
> >
> 
> /me more confused. Though I haven't dig deeper to chech how many of these
> EOPNOTSUPP uses are intended for userspace.
> 
> $git grep -lw ENOTSUPP | wc -l
> 713
> git grep -lw EOPNOTSUPP | wc -l
> 2946

I (mis?) interpret your words that only GPIO/pin control uses ENOTSUPP internally.

> > > What if we change the source/root error cause(SCMI) in this
> > > case and keep GPIO/pinmux happy today but tomorrow when this needs to be
> > > used in some other subsystem which uses EOPNOTSUPP by default/consistently.
> >
> > This is different case. For that we may shadow error codes with explicit
> > comments.
> 
> Sure as along as that is acceptable.
> 
> > > Now how do we address that then, hence I mentioned I am not 100% in agreement
> > > now while I was before knowing that this is GPIO/pinmux strategy.
> > >
> > > I don't know how to proceed now 🙁.
> >
> > KISS principle? There are only 10+ drivers to fix (I showed a rough list)
> > to use ENOTSUPP instead of 100s+ otherwise.
> 
> Again I assume you are referring to just GPIO/pinmux subsystem right.

Yes, I am.

> As the number of occurrence of EOPNOTSUPP in the kernel overall is quite
> large.

Of course that is out of scope of GPIO/pin control design.

> I was thinking of changing the SCMI error map from EOPNOTSUPP to ENOTSUPP,
> but for now I think it is better to just handle the mapping in the pinmux
> part of SCMI that pinmux subsystem interacts with.

Sure. Wherever you prefer, the only expectation that GPIO / pin control callbacks
will return into GPIO / pin control _core_ ENOTSUPP.

> In future if more
> subsystem expect ENOTSUPP, then we can change it. I hope this aligns with
> KISS principle as we are just fixing for the case that is know to cause
> issue rather than changing all probably regressing and then having to
> fix them all.

Exactly!

> Thanks for the time and explanation.

Thanks for discussion!

-- 
With Best Regards,
Andy Shevchenko



