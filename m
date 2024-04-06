Return-Path: <linux-kernel+bounces-134058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D12C89ACA6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 20:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249DF281ED2
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797864BA94;
	Sat,  6 Apr 2024 18:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDLFx+PZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B492C481D8;
	Sat,  6 Apr 2024 18:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712428737; cv=none; b=FcYXGa+HvPJc1WBQ7yafodpohGFUyRCyNLK0WUmLCDwX0IeFYwZPKiW5496IWIIxV4RtpDkjb7N9wGhUPTQco9g5XpBC4JWae1+rJUNEPBTD41flo7U79dY/4BjlrpZK0woOQfmlION/m2z8B9KQjqkLvThEQ7PECgvXGPKTJ9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712428737; c=relaxed/simple;
	bh=TuoUC/0m7+TeGvfQNlRpsuNx3/gbAWSHJo6wQrfPNbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr7oQRAu3E3eV0pM2SYktZ0R+5hCipYiEBdM5xYG4aY7GDBMFoChCBV8o70BeSxkRMFTSUqo29JOHpy+xPO8BsqpR22FcFnttM3jroI/EqpUrfKWIprg0yOz6c3gBgT8iBFqT0D87wCWo/hcCeWlY4r8dWHdoCBvsI3qIYo2IIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDLFx+PZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A0FC433C7;
	Sat,  6 Apr 2024 18:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712428737;
	bh=TuoUC/0m7+TeGvfQNlRpsuNx3/gbAWSHJo6wQrfPNbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WDLFx+PZ4duBMZiYqt7ss1sn4Y99Mw61ZomYHsSe4BaW4nGEdd8hwPrWkZ+eugfu4
	 5Wy2qILAFzJ7Yw7IBIbDL0rbeXsdxvE/fasGoxkNn2akY+HSmZDWnljxjJAcDnoWUt
	 ClS5BovFN5BVz5Ba10iDLJT6g7JgqabiP+QA8DF2KThBRU7bT5le2XVZLpgxvwstmV
	 V25e2is0xJjbPwya4m0d71vIAhuXGSNzkztt7DL/4OW/saZvdvDAVe0bNpqHQeiv4+
	 PcnGQ5r3vhZwmD3NFzMc/BkpKA5XTIXjiM1f/HLb7oJKgQqBSUO+e0x8U0z480ovdO
	 vufyoq8GLwIrw==
Date: Sat, 6 Apr 2024 20:38:50 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Petr Mladek <pmladek@suse.com>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jyoti Bhayana <jbhayana@google.com>, 
	Chris Down <chris@chrisdown.name>, John Ogness <john.ogness@linutronix.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: temperature: ltc2983: convert to dev_err_probe()
Message-ID: <xsbimlqvca7bw3ftithqxknvnvqc7ls4llex4vmthl5nag2xmd@oslabr4ecqnm>
References: <20240404-dev-add_dev_errp_probe-v1-0-d18e3eb7ec3f@analog.com>
 <20240404-dev-add_dev_errp_probe-v1-2-d18e3eb7ec3f@analog.com>
 <Zg6afQe43zlYFC8m@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg6afQe43zlYFC8m@smile.fi.intel.com>

Hi Andy,

On Thu, Apr 04, 2024 at 03:18:05PM +0300, Andy Shevchenko wrote:
> On Thu, Apr 04, 2024 at 01:06:24PM +0200, Nuno Sa wrote:
> > Use dev_err_probe() in the probe() path. While at it, made some simple
> > improvements:
> >  * Declare a struct device *dev helper. This also makes the style more
> >    consistent (some places the helper was used and not in other places);
> >  * Explicitly included the err.h and errno.h headers;
> >  * Removed an useless else if();
> >  * Removed some unnecessary line breaks.
> 
> ...
> 
> >  	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
> > -	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
> 
> It's better if you leave {} when the body goes after a single line.
> This applies to your entire series.

I think checkpatch complains if you leave the {...} and,
honestly, I'm not a big fan of the {...}. Unless there is a last
minute rule I missed.

If checkpatch doesn't complain, I'm OK with both ways, though.

Andi

