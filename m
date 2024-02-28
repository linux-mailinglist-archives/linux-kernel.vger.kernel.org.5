Return-Path: <linux-kernel+bounces-85456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF086B643
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:43:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22700289FDE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93BD15DBA8;
	Wed, 28 Feb 2024 17:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VNjCHRGD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACA13BBC5;
	Wed, 28 Feb 2024 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142173; cv=none; b=mSsmwg6KUehYHbmPh7wiR+n0d1SvC8N2Zwjkfkjaz4iXXkU94rEw3KtDKzzOl44RTpZg5sxRxKpdc6VTCjzaIqpf4NX2xtrseomyn5hy1v4wp2z2IqyQccPbxjfaTHAfcuIogKcGpNcn6PMdrmCrtorVlNY3wx9xhjwNeRJhDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142173; c=relaxed/simple;
	bh=i2t4kMaMKByXwVl0t0eWI2qXBkFQ2XAPFbW4+l9ofmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddhKZ2WpJ69XnShAQQwS0FCRMhW5aVIYIhjw/mqFPIwMh2x4OFO3xcy14zILmveip31T05Ad7xTZv/SGKGx7rGoOlhAbYwImp2ExOB17QtW/76bErWkZJKvjMU18tl6UuyP/nDV1GVdx9sR/A9WbUI4feochro0gardvpwVBNss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VNjCHRGD; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709142171; x=1740678171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i2t4kMaMKByXwVl0t0eWI2qXBkFQ2XAPFbW4+l9ofmY=;
  b=VNjCHRGDTI9JVSVxayvzX5vjp7ZGKdf4EQ9iGXFeVnKY4oCBUFgmM+Pc
   suQJUa4QdjqswzFssEYiKbJFddXiRpDFbP6WnKF04mKYaf6PDqIKJPYtr
   UIdohb9RRGsooQj8VKoMFZ2hyoj9CBisFVzLrbwWgrR0PIhcNbL6gq+fS
   WKx9bvgv2KPav1VDi+baqjZXoLK1DtKk+a2+0R211R0+oXiCsnsdFip7Q
   9AkQdKpGOqdnC0n2ETdxqobW9+pGn/E3QG4jleRFsI2LqgPu1yu7NSJdA
   hxtXIMtkbgH7yKyd2cPDqMTKXsrC/TfIj1I2OyxFmjXZoccSwUidiT9ZL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14998262"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14998262"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:42:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913956634"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="913956634"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:42:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfNx5-00000008Hqs-48dS;
	Wed, 28 Feb 2024 19:42:43 +0200
Date: Wed, 28 Feb 2024 19:42:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Chris Down <chris@chrisdown.name>, Petr Mladek <pmladek@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jessica Yu <jeyu@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jason Baron <jbaron@akamai.com>, Jim Cromie <jim.cromie@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
	Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: Re: [PATCH net-next] Simplify net_dbg_ratelimited() dummy
Message-ID: <Zd9wkwdcftftIIK5@smile.fi.intel.com>
References: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d75ce122b5cbfe62b018a7719960e34cfcbb1f2.1709128975.git.geert+renesas@glider.be>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 03:05:02PM +0100, Geert Uytterhoeven wrote:
> There is no need to wrap calls to the no_printk() helper inside an
> always-false check, as no_printk() already does that internally.

This also makes sense.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



