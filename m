Return-Path: <linux-kernel+bounces-119719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0088CC62
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76BF429E985
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B522813C696;
	Tue, 26 Mar 2024 18:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="loG0NN9J"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDE127B62;
	Tue, 26 Mar 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711479181; cv=none; b=BR36kfrQq1A2IkJpwhJWjCkjIGwt3kiP9k+0/z4rSE/Hc88talGxc1hUXtoDc/t4MMzO+3xfJ1VNiBUranQR//ZLTnl9fsnkLQ1MgnwdEqMM7n8ICT2rPUKhIUZJrUM3xmQFODK8OoNMYHCs5tWHQSCpAxniJ+SGc2Mu3MMbUZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711479181; c=relaxed/simple;
	bh=WkO1S1jkVN0c59mKkx+iQ2KhnnFXr9F4gvElge+NkOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC8BePv2g3Qsv8giha6NXR46QxruV62zAFnkgR8e2mhmDbVPQzJ1ePKrUe7u9pBEQsKEEyxWokRVtlDNUhuIrZXM1UrtOJjdvo399J8Gdacpe9KZZzlSLpDO97AWg08Roz12PgjeX/UoTXHLXAA1rXjyi5i3bLYQQtJjw5uKzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=loG0NN9J; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711479179; x=1743015179;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WkO1S1jkVN0c59mKkx+iQ2KhnnFXr9F4gvElge+NkOc=;
  b=loG0NN9JMsnLx+bwo2Ee+v2Fnb5RNp267GMG6uif8f4CAW44xo/VcRSY
   gZeO3GgYlZlrCyQm7sLo63RUfZMz2LhhLupNGPWDzq3WHJsN1//KpvfQd
   eeSvstgC/B+BMn0WysNc/Cv6AjjP7U+qkj6LxNcOgU7o2t2O95LNFSipM
   +CxlapdAqNvKXdxhsctH9Ycz52XXG4Z5aw362en298SPXoOlB9CElHS4z
   RfC6qp3HaIib1Cu+RaCqQn3rNWQzjWpkce6zwGYzVfxccfzu1cw+jtWCv
   OErhJzBTDnyfWGEw2qeb0rP49ld0QidM0qQTh99cHtWPJBky5GkaaS3tL
   A==;
X-CSE-ConnectionGUID: nQ0lq877SJGU5L0wSrrtyg==
X-CSE-MsgGUID: mN/t9eM6QvWzN0TvynwmlQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="23993372"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="23993372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:52:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914887918"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="914887918"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 11:52:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpBun-0000000GQWD-2zuz;
	Tue, 26 Mar 2024 20:52:53 +0200
Date: Tue, 26 Mar 2024 20:52:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 01/10] spi: pxa2xx: Drop ACPI_PTR() and of_match_ptr()
Message-ID: <ZgMZhdsDc-bzWa6P@smile.fi.intel.com>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-2-andriy.shevchenko@linux.intel.com>
 <14f08a50-edef-4b36-891e-2b4b2283f40c@sirena.org.uk>
 <ZgMSg5Tr97mWgPW4@smile.fi.intel.com>
 <424de3ed-f0ea-4fc1-80f5-3ab1d23cf1e1@sirena.org.uk>
 <ZgMXe4EMbJ44W1tr@smile.fi.intel.com>
 <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3066481-bac6-48fd-8b38-6797975d83c2@sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 26, 2024 at 06:49:58PM +0000, Mark Brown wrote:
> On Tue, Mar 26, 2024 at 08:44:11PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 06:25:16PM +0000, Mark Brown wrote:
> > > On Tue, Mar 26, 2024 at 08:22:59PM +0200, Andy Shevchenko wrote:
> > > > On Tue, Mar 26, 2024 at 06:16:28PM +0000, Mark Brown wrote:
> 
> > > > > I think the ACPI dependency there is as much about hiding the device on
> > > > > irrelevant platforms as anything else, might be better replaced with an
> > > > > x86 dependency though.

..

> > > That's nice but I'm not sure what that has to do with the dependency on
> > > ACPI?
> 
> > ACPI_PTR() makes ID no-op only if ACPI is defined. That also satisfies
> > the ugly ifdeffery that is removed by this patch as well. If there is
> > no dependency we will have compiler warning for defined but not used
> > variable.
> 
> Again I don't think that's the main purpose of the dependency here.

Oh, oh, my bad I missed acpi_dev_uid_to_integer() call.
Okay, with that in mind it's functional dependency for the ACPI-based
platforms. Do you want to keep it untouched?

-- 
With Best Regards,
Andy Shevchenko



