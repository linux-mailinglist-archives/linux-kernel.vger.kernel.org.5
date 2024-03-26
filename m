Return-Path: <linux-kernel+bounces-119870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 047CB88CDED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4A221F2580C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C713813D514;
	Tue, 26 Mar 2024 20:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R8Q5y92f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892AF13D2B8;
	Tue, 26 Mar 2024 20:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483940; cv=none; b=k7NFejE9a7HvirPvuEPJnqfdAaelvrgI7yGhOSn1Csvw10sc5hvQt7DjNYMtlYzfjGMd4zRJ/MLx3i0AnhJwWKjEmR8QNax2T3reN3jT2wsoorLyO1HpZMVC5BVnAhME50g4Ed63WG51GqoBLZvd5NLj+otaeIOsM7kEhJWKxDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483940; c=relaxed/simple;
	bh=kWrtyN8+K6oqIb/OH7qLgzPz0AsAoTRbNpEkIIo9gY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ITO1/0CMKyymcWlz95V7SfK0T8pHk1e9ZuSGaAFH6T6S8ICcw7wEioOVfKxGyxXcnCJUD0b7WubwDJ7vz8j4SOrqrJJiWpuQaWjyknOGZwA/Nj8v5KEmyvP47nWtMN0T0Hab9keiIYJ7cZhDQe+xMMF+992IuUIRne0RDCgnWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R8Q5y92f; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711483938; x=1743019938;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kWrtyN8+K6oqIb/OH7qLgzPz0AsAoTRbNpEkIIo9gY8=;
  b=R8Q5y92fXGp7ESbRagq+iJa7R91qt017XuRl2Xng0ZUNzoBZ0Bd7X5jz
   YwuvNV+clqRbLve2oos7eBniNdyMHz6AVDSKN0YRqRL5eZyRm724lGWCS
   ethPMIluanXZklw6nZb58GF9c5JMm19UL/s6jFlXcsjMdG9H1CO8O0Yb7
   YGLu+m/c60Wzh2u3GFkw39LK2678+ipHF4PX1E/ztrpq1pWES0a1x1ZsG
   B47d7J8BMjGYGH1VNK3OvwF9OMZ2BIlt4uRnvThn9VAMMURMVqhQ5fj2C
   Es2hbfQFVB/EK186wY2s2sWOxH5X+c1Cm8TfP+1lo81OYSyU9iB0Um7YX
   g==;
X-CSE-ConnectionGUID: Uz1oiRcfQhG0EssGZX3MOw==
X-CSE-MsgGUID: jF29fY2IR6yJMVmTfZQv4Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6769687"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6769687"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914889647"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="914889647"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 13:12:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpD9Y-0000000GRYp-2qCn;
	Tue, 26 Mar 2024 22:12:12 +0200
Date: Tue, 26 Mar 2024 22:12:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
Message-ID: <ZgMsHFJObZ48Erzt@smile.fi.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
 <dcdf8c46-acdc-466d-afc6-caf0e0fa39e8@sirena.org.uk>
 <ZgMY3AeC1Jnh1Oru@smile.fi.intel.com>
 <c18186c0-63d8-4406-add0-980f723e3528@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c18186c0-63d8-4406-add0-980f723e3528@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 08:02:57PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 08:50:04PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 06:21:48PM +0000, Mark Brown wrote:
> > > On Tue, Mar 26, 2024 at 08:07:57PM +0200, Andy Shevchenko wrote:
> 
> > > > Since driver can parse num-cs device property, replace platform data
> > > > with this new approach.
> 
> > > But why?
> 
> > To be able to hide the header's contents from public.
> > Should I update the commit message?
> 
> That would definitely help, but it's hard to see what the actual benefit
> is here.  It's removing platform data without doing the more difficult
> bit where the platform gets converted to DT.

Will do in v2.

> > > > +static const struct property_entry spitz_spi_properties[] = {
> > > > +	PROPERTY_ENTRY_U32("num-cs", 3),
> > > > +	{ }
> > > > +};
> 
> > > This is just platform data with less validation AFAICT.
> 
> > I'm not sure what validation you are expecting here. It should be done via
> 
> Well, the problem with swnode is that there's no validation to expect -
> it's an inherent problem with swnode.

I do not object this.

> > DT schema ideally when the platform gets converted to DT. This change is
> > an interim to that (at least it makes kernel side better). After the platform
> > code may be gone completely or converted. If the latter happens, we got
> > the validation back.
> 
> It is not clear to me that this makes the kernel side better, it just
> seems to be rewriting the platform data for the sake of it.  If it was
> converting to DT there'd be some stuff from it being DT but this keeps
> everything as in kernel as board files, just in a more complex form.

Not really. The benefits with swnode conversion are the following:

- reducing custom APIs / data types between _shared_ (in a sense of
  supporting zillion different platforms) driver and a certain board
  file

- as an effect of the above, reducing kernel code base, and as the result
  make maintenance easier and bug-free for that parts

- preparing a driver to be ready for any old board file conversion to DT
  as it reduces that churn (you won't need to touch the driver code)

- ...anything else I forgot to mention...

> > In any case it's not worse than plain DT property handling in the kernel.
> > The validation in that case is done elsewhere. Since the property is defined
> > in board files the assumed validation is done during development/review
> > stages. But OTOH for the legacy code we need not to touch the property
> > provider more than once. We are _not_ expecting this to be spread.
> 
> I'm guessing you're just checking this by inspection though...

Yes, we seems do not have any tool to perform a such against software nodes.

-- 
With Best Regards,
Andy Shevchenko



