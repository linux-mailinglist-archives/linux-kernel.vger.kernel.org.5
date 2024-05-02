Return-Path: <linux-kernel+bounces-166159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DEE8B96E9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 354FD2818F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C74B47A57;
	Thu,  2 May 2024 08:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WbFo1kEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6AD22F00;
	Thu,  2 May 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640103; cv=none; b=gZOHuz3qafMO4+yTKnLAtCy9tLNehn4lD0hat2JkFKqDolU/XUJjJ5679GaneVaOtKrh4q4YgIDpeUymkrVIi+2ejoodZ0TKGiInR/MRuV0xwZQXYE8TOZaR42Gh+15EgOjnV9RiPYTlLfzqGAgEOWfsN4IRMpKFvt9joWhkmMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640103; c=relaxed/simple;
	bh=vnXVC6Kf8epv7ASZX8DY9VCJSTt9HM5ceyAQKMp9tvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HMBeAvJo2ZbhbkVJ6MLRBV5b1zWpm/qwM8BhbRVTnHZ8mGowQFdwaAj4XrZ7l0Et749wyBoD9ZlAx+dOc/Jf3ilE9T7opy8pXB7+p4gJfxs95aV6tZhc0GFvYswyiEalCHKkdK0bN28dI5in1pfLuWiqslCm2bAJJxiunVEE3CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WbFo1kEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6060C113CC;
	Thu,  2 May 2024 08:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1714640102;
	bh=vnXVC6Kf8epv7ASZX8DY9VCJSTt9HM5ceyAQKMp9tvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WbFo1kEPVZa9bGX8IcbyRTGRoHKpjjVVZYdL+zmDwAhPKa9gTvNSejgWEmWYSSGIB
	 nOJc5VEmoxh8f8EZF9mn+GF/SAgEROR49CaNr6tO6l4jH6rFXANEkls7d0Ja4ff4BF
	 AOnkOqLfvOmGTtVS4eYGt4ojXEopX4byW0dsEHco=
Date: Thu, 2 May 2024 10:54:59 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Shahar Avidar <ikobh7@gmail.com>
Cc: hverkuil-cisco@xs4all.nl, andriy.shevchenko@linux.intel.com,
	robh@kernel.org, felixkimbu1@gmail.com, dan.carpenter@linaro.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] staging: pi433: Use class_create instead of
 class_register.
Message-ID: <2024050257-gong-issue-ec40@gregkh>
References: <20240501055820.603272-1-ikobh7@gmail.com>
 <20240501055820.603272-2-ikobh7@gmail.com>
 <2024050109-reward-vision-58e9@gregkh>
 <fede8589-dd11-4b0c-aa70-7ec23aed64b1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fede8589-dd11-4b0c-aa70-7ec23aed64b1@gmail.com>

On Thu, May 02, 2024 at 11:40:44AM +0300, Shahar Avidar wrote:
> On 01/05/2024 17:12, Greg KH wrote:
> > On Wed, May 01, 2024 at 08:58:19AM +0300, Shahar Avidar wrote:
> > > Make use of a higher level API.
> > 
> > What does this mean?
> > 
> By "higher level" I meant a wrapper function that includes the
> "class_register" call.
> 
> > > Reduce global memory allocation from struct class to pointer size.
> > 
> > No, you increased memory allocation here, why do you think you reduced
> > it?
> > 
> Reducing *global* memory allocation.

And again, you *increased* memory allocation by making this be
dynamically created instead of the current code which is a static and
can be placed into read-only memory with no padding required unlike a
dynamic memory chunk is.  You also removed the read-only markings of the
structure for no reason, in a way, making the code a tad be more
insecure as well as increasing memory usage.

So be careful please.

> I understand the tradeoff would be allocating in run time the class struct
> anyway, but than, it could also be freed.

When is it freed that the current code is not also freed?

> Since the Pi433 is a RasPi expansion board and can be attached\removed in an
> asynchronous matter by the user, and only one can be attached at a time, I
> thought it is best not to statically allocate memory which won't be freed
> even if the hat is removed.

Is that what happens in the code?

> By using the class_create & class_destroy I thought of reducing memory
> allocated by the RasPi if the pi433 is removed.

Try it and see :)

> But following your response I now actually see that the class struct will
> have the same lifespan anyway if allocated statically or dynamically if its
> alive between the init\exit calls.

Yes.

> > Also, this looks like a revert of commit f267da65bb6b ("staging: pi433:
> > make pi433_class constant"), accepted a few months ago, why not just
> > call it out as an explicit revert if that's what you want to do?
> > 
> I actually saw this commit, but for some reason did not connect the dots
> when I wrote this patch. My bad.
> 
> > class_create is going away "soon", why add this back when people are
> > working so hard to remove its usage?  What tutorial did you read that
> > made you want to make this change?
> > 
> It's true, I got it the wrong way I guess. I thought class_create is the
> preferred API (but now that you mentioned commit f267da65bb6b, I see it's
> not). I did notice it in many other drivers though, and took them as an
> example (e.g. gnss).

There are patches out that replace almost all users of class_create()
such that it should be almost gone from the tree.

> > thanks,
> > 
> > greg k-h
> 
> I actually initially thought that the pi433 class should be removed since it
> doesn't bring any new attributes with it, and that spi_slave_class is more
> appropriate, but then I saw no other driver using it. Any thoughts about
> that?

The whole driver is going to be removed soon, please see the mailing
list archives for the details.

thanks,

greg k-h

