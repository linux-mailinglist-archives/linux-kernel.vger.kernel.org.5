Return-Path: <linux-kernel+bounces-60712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A37008508C7
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DF01C21390
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA945A4DE;
	Sun, 11 Feb 2024 11:17:47 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB0F2AF08;
	Sun, 11 Feb 2024 11:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707650267; cv=none; b=nuhVO9AlNjCvu8CLoZjLpWdxENNYHvRtKmti2lFbH9RTvWC6vfYn59VtIxaZ9gwUSa+jns5YTAhafaQdmwvwPerju6102MLk/ZbIyAW4L9766i1Zz8AdU+BDF5kLwQBhRqyeTNjZ8m7BvUx2Xjiktepn26yjvLbJNfd1vrMPJko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707650267; c=relaxed/simple;
	bh=Xz4zRgjnX5q9xaB3mTWEuD8RUIvC0uEA2UD64kmLUwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xo/7mZ95HDoCPzckObj6HrSURtYk9qbc/sPjkJOXjNenEwuUQFSc5Zq5HuzW92XbBgo6TBdvlgyqkqDrIajzL1jEVrC4sSGYkZ5zRcDKf6zWp6TjyF6bspAhlJpBTYcEz4VT8Bi18L/wZg6kUoAFLnOpYC77GoeI5Nl4xYIhXAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41BBHeOX022583;
	Sun, 11 Feb 2024 12:17:40 +0100
Date: Sun, 11 Feb 2024 12:17:40 +0100
From: Willy Tarreau <w@1wt.eu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] lib: add CPU MHz benchmark test
Message-ID: <20240211111740.GA22575@1wt.eu>
References: <a2396ae072d6f9e009b5de558efe166b844a1397.1706718625.git.geert+renesas@glider.be>
 <ZbqFsroYDjSoYEps@1wt.eu>
 <CAMuHMdWrjag3icVi2mJbtEftwz_jH51Ov4-FAV67Mdz7UvxQXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWrjag3icVi2mJbtEftwz_jH51Ov4-FAV67Mdz7UvxQXw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Geert!

On Thu, Feb 01, 2024 at 09:49:33AM +0100, Geert Uytterhoeven wrote:
> > > Parallel runs (run on multiple CPU cores) are supported, just kick the
> > > "run" file multiple times.
> >
> > Hmmm does it mean it will run on the CPU that writes this "run" ?
> > Because this could allow one to start tests using e.g.:
> >
> >     taskset -c $CPU tee /sys/.../run <<< y
> 
> That does indeed work.

OK!

> > But we could also wonder if it wouldn't be easier to either send "y"
> > to /sys/.../cpu0/run or may just send the CPU number to "run" instead
> > of "y".
> 
> That would complicate the code a lot.

OK I trust you, I was merely asking just in case.

> > In my experience with this tool, you most always want to easily
> > control the CPU number because SoCs these days are not symmetrical at
> > all.
> 
> That's why it prints the CPU number ;-)
> 
> On multi-core systems, you can also do e.g.
> 
>     for i in $(seq $(nproc)); do echo yes >
> /sys/module/test_mhz/parameters/run & done
> 
> and collect the results for all CPU cores.

OK!

> BTW, this is the same for test_dhry.

I didn't know, that's an even better reason for not changing any of this!

> > Another point is that it would be nice if there was a way to present
> > the result in a form that a script can retrieve from the directory,
> > maybe the last measurement or something like this. I know that scripts
> > are commonly used to check for a machine's correct behavior, and I try
> > to encourage users to verify that it's working well, so anything we can
> > do that makes it easier to use would be welcome.
> 
> I'll give that a try...

Thanks.

> > Hmmm I don't know if this is intended, the SPDX tag says MIT but the
> > MODULE_LICENSE at the top says MIT/GPL. I can't say I care that much but
> > I preferred to report it in case it's an accident ;-)
> 
> That must be an oversight.  I'll change the SPDX-License-Identifier to
> "GPL-2.0 OR MIT".

OK no problem!

Thanks,
Willy

