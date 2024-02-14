Return-Path: <linux-kernel+bounces-65850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E40998552CA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95EF41F2A8C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBCF13A880;
	Wed, 14 Feb 2024 18:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpJbWs8j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E76133438
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937036; cv=none; b=V1Pc6FAx+4zegarzzyuPchLRP+Smj41c+q4n68AppUyM9jOhzNJpcGZ6eUNB5r4gOlnXTfV9PbVMOmcNUq6FdL2lry4SJCWc0hympgmeHJztFmefsqCBlQsSUojycZjkLNM7sXF2e3VqG7t5NQEcXa/qpjhZMQPBYrXfK1l2eds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937036; c=relaxed/simple;
	bh=pW32P6LpHOLEugg6QuLJO9UuoF6gfVeJgjMbxEuiqts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dejo9vvqjTs+AnedxozYXUZHEF7VxeW2QHALKUWW8M1yz6ERPLxGJQlUB36RMbwE+BYtcoA8b3/rF/FWD31JDrottJroNFitWSRLnvptAF6tWK08ch3zmCihaAXvOc3mJJJboT/cI8+iuFCRrJTuf1yPGvprByoy6m8p6VRsuzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpJbWs8j; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707937035; x=1739473035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pW32P6LpHOLEugg6QuLJO9UuoF6gfVeJgjMbxEuiqts=;
  b=VpJbWs8j4sP+x4N+3VOMzN2X9K6NgpThRG5UixZFlkWqqSWlBUM2xRX6
   TCfzBZo7W1WpcyntKCOkRiN9z7yiWd8SG8iqTR2QMo37SAWIr2eQYUipS
   xtTET3rwZAuc+Kx5V2QI26Nel/rh9IwLa74OR/It99JmFBKNgGJA5XKL9
   XKBdpI6VpkpwTpIx+4+cOy5v+FuzYDqugKmJB0x8FPyGwHzlvkV9rEVRa
   O4pxLpBd1h7amAhAsRkQnHLrqxs+tG3iB2gWBcDqlHoA8n7sn8xUhkKaO
   pkjksE6sAJwnJDxIhs9BQxHNSbg1MzjPUY+tbkeCz5AxUxa8r2vDGFkrF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="1870300"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="1870300"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:57:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912094308"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912094308"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:57:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raKRS-00000004a0L-1ihD;
	Wed, 14 Feb 2024 20:57:10 +0200
Date: Wed, 14 Feb 2024 20:57:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem
 folder
Message-ID: <Zc0NBo2HDCsAQjn8@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
 <Zcoe9axtLXxB7Jeo@smile.fi.intel.com>
 <CAMuHMdUJ4gSGo4A0BVGkieWvNyqa9Dv_rQVMFj9N8GWYoKCZVg@mail.gmail.com>
 <CANiq72muoZHzX+qNKabYWnH738okKqrfAruUOpY-4WUJBLP=Yw@mail.gmail.com>
 <Zcz7Cfc5XSM2MtKV@smile.fi.intel.com>
 <CANiq72ntYrPyybUDavPuT+anrwfjPb27P8VbL+toMvyp8K293w@mail.gmail.com>
 <Zcz9WNXpRzv8THKW@smile.fi.intel.com>
 <CANiq72mYMztZG5Y5v6m+h2xroDFyyf0Kn7aZ2D7p6p4k_YtTcw@mail.gmail.com>
 <Zc0MShdvTsjrGGjl@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zc0MShdvTsjrGGjl@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 08:54:02PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 14, 2024 at 07:48:31PM +0100, Miguel Ojeda wrote:
> > On Wed, Feb 14, 2024 at 6:50 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > It's a standard practice in the Linux kernel development.
> > > If it's not a so critical issue, why should we rebase?
> > >
> > > rebasing will break SHA sums and it's not appreciated especially at the late
> > > rcX weeks. Linus can even refuse to accept a PR based on this fact.
> > 
> > I am well aware of what rebasing does and the rules for PRs to Linus, thank you.
> > 
> > First of all, you should have not applied the patch this quickly.
> > Nobody gave a tag for it and you yourself are the author. Even if
> > someone gave you a tag, 2 days is way too little time for something
> > like auxdisplay. 2 weeks would be a more reasonable time frame.
> > 
> > The point is: you seem to be rejecting feedback on the basis that you
> > already applied a patch that you yourself authored 2 days ago. Not
> > good.
> > 
> > Now, for branches in linux-next, what you should avoid is rebasing
> > wildly, but you can still do so if needed. If you are uncomfortable
> > with that, then you should avoid rushing patches to begin with so that
> > you don't have to do that.
> > 
> > Regarding PRs to Linus, we are still in -rc4. There is plenty of time
> > to bake things in `linux-next`. Unless you meant to sent this to a -rc
> > release. But in that case: 1) there is no rush, 2) please see the
> > first point again.
> 
> Okay, I dropped that patch from the queue.

To be clear why:
- I don't see how to use pattern that won't collide with the other record
- reducing churn in case you want to move this to staging

-- 
With Best Regards,
Andy Shevchenko



