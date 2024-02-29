Return-Path: <linux-kernel+bounces-86563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C92D86C71A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE7B61F284B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8BAA79DB7;
	Thu, 29 Feb 2024 10:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mMvRBHgu"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E16D651A1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709203202; cv=none; b=JpgWm0cKuMIvjBNxTmhj7KRjIgeyK62TyekhZhFkFnSofESbfvL4Zm+FZhpPEWk74ZrF7G6r5IWy0mthicvruNm6nXSUVAqrgygrqyudylESzzjDOOr0FUXfFppvc5s2NB3vrzD5I3TYqApya2Ckn2dHHKCtc12OJVdCZhi55o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709203202; c=relaxed/simple;
	bh=Wct1JJsk6uiIUyRlJJIWEhZ3As3xOCXrjatqb/emqgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=STsYUFe8hge2oAoda1DSU12mT8JBtKNzaeHS1Yp4BpoPzEvUWmry1KURLOK9F6WoypWbjcFwdlq4+oFeFrBCUkSHoD7bm6n9KyYtZV11v+av6w/shlBeqqN5zeRXuncTkQTYo60JeuweQcZFR5o80gHJuZpfE3q2gdB5mPjFUPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mMvRBHgu; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709203201; x=1740739201;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wct1JJsk6uiIUyRlJJIWEhZ3As3xOCXrjatqb/emqgk=;
  b=mMvRBHguCZ4wEUP+rYuk6vinu9KPOBZbAEsSqV74F3V8yqt9ZSc6lgyS
   O8mJFpvx8n90/Lh/slzWRylDWisTCHNskjKQn4Q51LyoNp1AXUQvncUED
   mlm1ZEHTspJZQeo0TYqbqacJNWSYiCv33M0TjLyrtUDxvh42qCJmhIUam
   X/Q+erpmxHEO350OE4bNUUNtNIMZcG5uw2zTfr1t1WaJXLBwi+Y6m2h7H
   zJcH9Bm2lzDw9hEHDrkVwfmKMS0Gc6F6Gh5QdyVsnnRyRHLoAAM+OiC0K
   sOLwCQhIjaJ2HjeQ5VoyVyo879N5wHODnqe2nlXCQgIWsZgb9gXF429nr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21120895"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="21120895"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913978591"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913978591"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:39:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfdpT-00000008dwx-16Iz;
	Thu, 29 Feb 2024 12:39:55 +0200
Date: Thu, 29 Feb 2024 12:39:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v1 1/2] devres: Switch to use dev_err_probe() for
 unification
Message-ID: <ZeBe-ubcNvtDdAG6@smile.fi.intel.com>
References: <20240227175910.3031342-1-andriy.shevchenko@linux.intel.com>
 <20240227175910.3031342-2-andriy.shevchenko@linux.intel.com>
 <e2f49a1f1877550c4ca733bbca26949836d4fef1.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2f49a1f1877550c4ca733bbca26949836d4fef1.camel@redhat.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 09:52:34AM +0100, Philipp Stanner wrote:
> On Tue, 2024-02-27 at 19:58 +0200, Andy Shevchenko wrote:
> > The devm_*() APIs are supposed to be called during the ->probe()
> > stage.
> > Many drivers (especially new ones) has switched to use
> 
> has -> have

Thanks, will fix.

> > dev_err_probe()
> > for error messaging for the sake of unification. Let's do the same in
> > the devres APIs.
> 
> No objections on principle. Just one thing about the implementation:

..

> > +               ret = dev_err_probe(dev, -EINVAL, "invalid resource
> > %pR\n", res);
> > +               return IOMEM_ERR_PTR(ret);
> 
> So as I see it -EINVAL is just piped through dev_err_probe() and is
> never changed.
> Don't you think it would be better to drop variable 'ret' and just do
> return IOMEM_ERR_PTR(-EINVAL);
> as before?

dev_err_probe() requires error code as a parameter. Are you suggesting to have
a duplication?

	dev_err_probe(-EINVAL);
	return -EINVAL;

I don't think it's a good suggestion, so the answer is "No, I don't think it
would be better."

> That way it would be obvious that the error code is never changed and
> it will always return -EINVAL. Otherwise you have to look up the
> function definition of dev_err_probe().

..

> The same would apply below.

Same answer.

-- 
With Best Regards,
Andy Shevchenko



