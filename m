Return-Path: <linux-kernel+bounces-136478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8617789D47C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 397401F27610
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E79D57FBC1;
	Tue,  9 Apr 2024 08:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cFSU5Z2q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090D07EEF0;
	Tue,  9 Apr 2024 08:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651287; cv=none; b=bnDRijvZbzsxLS2t9wjHSYlk2lRd24FadDdatAnOYwdyBn80z4yErdDAAoVhfZgwIRtahCc0SiC0yKXDPa/lLLKqFc6YB8BJ4Ie5jikjZOVScx2M4YLuWKSPEIFHPG3BerrHWKK0Lwkh17c/h0XaGcqjHR5JXf5FdagusA4OtLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651287; c=relaxed/simple;
	bh=vXLhv3zRRAGARN7FCvEx72w/juFJMhiiJABz8Y2uhpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HATGumx1f/4lsPe/mBhWD/cCwpFUgaLfyZBkOTsO38vLc4/BwE2AA50jzzvZoTvQwTGBcKxEK04LsShxwvzQDV03I+sq86y5bX0QzfVclNfQflyhqE6tHcdDG0fR5kavZLgi/GLvjh+X1m18XeWsZ8KlKJxManLCK5l2o+tlaDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cFSU5Z2q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122C0C433C7;
	Tue,  9 Apr 2024 08:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712651286;
	bh=vXLhv3zRRAGARN7FCvEx72w/juFJMhiiJABz8Y2uhpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cFSU5Z2qfdVdK0o/GuxUXrBP2h/PUY8ju+Skd8KKXKk/0KrzHj3fVi3su+QG2p9xx
	 aznJ/3k9pcJsMJe6HfAePAFoc9RNRMLLMcm2hgp4wJUHRMvWajD9yvztKTRpDHiV8W
	 ne9M/bKIWuVmvm1hUCJg3x2/Hmq3WvbASQdCwzns=
Date: Mon, 8 Apr 2024 16:51:57 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <groeck@google.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Pavan Holla <pholla@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 2/2] usb: typec: ucsi: Implement ChromeOS UCSI driver
Message-ID: <2024040837-negligee-expert-bc37@gregkh>
References: <20240403-public-ucsi-h-v3-0-f848e18c8ed2@chromium.org>
 <20240403-public-ucsi-h-v3-2-f848e18c8ed2@chromium.org>
 <3ezjocthsigo3t746slmgzffnmpxw7wwf3s535basiaf2qy6io@7ocxva6ndsbt>
 <2024040449-average-foyer-defa@gregkh>
 <oi3bwdyvyaezpmyxfdtsbiwwprxi2ufc3hlzoz23d5rxdkperl@cxpd7enatg7h>
 <2024040422-ripcord-bladder-bdda@gregkh>
 <CABXOdTeqz5Kza5tYXbCdTyPT66xtezai4C5TFkqmOpQc+1r8Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABXOdTeqz5Kza5tYXbCdTyPT66xtezai4C5TFkqmOpQc+1r8Xg@mail.gmail.com>

On Mon, Apr 08, 2024 at 06:04:22AM -0700, Guenter Roeck wrote:
> On Thu, Apr 4, 2024 at 6:30 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> [ ... ]
> 
> > > > > if (WARN_ON_ONCE(val_len > MAX_EC_DATA_SIZE))
> > > > >   return -EINVAL;
> > > >
> > > > So if you trigger this, you just rebooted all boxes that have
> > > > panic-on-warn enabled (hint, the HUGE majority in quantity of Linux
> > > > systems out there.)
> > > >
> > > > So don't do that, just handle it like this.
> > >
> > > Does that mean that we should not use WARN at all? What is the best
> > > current practice for WARN usage?
> >
> > To never use it.  Handle the issue and recover properly.
> >
> > > I'm asking because for me this looks like a perfect usecase. If I were
> > > at the positiion of the driver developer, I'd like to know the whole
> > > path leading to the bad call, not just the fact that the function was
> > > called with the buffer being too big.
> >
> > Then use ftrace if you are a driver developer, don't crash users boxes
> > please.
> >
> > If you REALLY need a traceback, then provide that, but do NOT use WARN()
> > for just normal debugging calls that you want to leave around in the
> > system for users to trip over.
> >
> 
> That is not common practice.
> 
> $ git grep WARN_ON drivers/gpu | wc
>    3004   11999  246545
> $ git grep WARN_ON drivers/net/ | wc
>    3679   14564  308230
> $ git grep WARN_ON drivers/net/wireless | wc
>    1985    8112  166081
> 
> We get hundreds of thousands of reports with warning backtraces from
> Chromebooks in the field _every single day_. Most of those are from
> drm and wireless subsystems. We even had to scale back the percentage
> of reported warning backtraces because the large volume overwhelmed
> the reporting system. When approached about it, developers usually
> respond with "this backtrace is absolutely necessary", but nothing
> ever happens to fix the reported problems. In practice, they are just
> ignored.

Then push back on the developers please, this isn't ok.  WARN_ON
triggers so many automated systems it's not funny.  And if a trace back
is really needed, there is a function for that, but really, just fix the
issue and handle it properly.

> This means that any system using drm or wireless interfaces just can
> not really enable panic-on-warn because that would crash the system
> all the time.

I guess Android doesn't use wireless or drm :)

Again, billions of systems in the world has this enabled, let's learn to
live with it and fix up our coding practices to not be lazy.

thanks,

greg k-h

