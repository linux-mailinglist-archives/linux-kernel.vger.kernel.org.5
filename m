Return-Path: <linux-kernel+bounces-140231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D6D8A0F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8EB5281F83
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5304146A64;
	Thu, 11 Apr 2024 10:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ctVdSpa3"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13701140E3D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830822; cv=none; b=hbOcdwRggE9ADIMylP3ua/zl04zaEgwpX7zBvMtrLbmYMjhlWYZ0VUeZpxu7vwctWvYc3pv9NcODyumxHWEbkbQWTKs0ChnxzQ79TLXOGQRWIEiUBUW4bEnnQVCcHipzMpdS+nhQAot2P9MmaA+N0XW0WJmRCEmUjsc2b3XSDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830822; c=relaxed/simple;
	bh=tP8wCrzup+KrMyvYf4tPbhaVY57vbLjbMm440yezicg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYqmSihHoz/FEcZ9MCLSBJxMJp/ri4+7wcKLVvf9RIPgar3Z3rFj2Nn9j4Fys8qIvJs+ABrjn7/HrAQSadDa9zRyF7ZO0VkfWH6hArXQVIABpEsKTpfzPVPbQj3HeYfUYq234aBNniEz6D7Fb2iCztU7kc5qZXjtQ9l88qXTTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ctVdSpa3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712830820; x=1744366820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tP8wCrzup+KrMyvYf4tPbhaVY57vbLjbMm440yezicg=;
  b=ctVdSpa3SRA404VoddaUzK8D14LKPl62jqNZwr0qfD1ifaXM/TZS9xgl
   gZYoEN0t20e1Mg7hhF3mz0XsLQuKlsY/TooWnCd2+mZWWL0LV7u1dAMXo
   ERKNoSnTNU1OKpf5HItg0xU0RRjcUzi+zc1WqnUrNyUnVJEi7LMUzVviW
   yorCi3Oqley5Qk7yLe3d/+DorvDNryhXbpz7YF1kFO8BF9iEcO8qQv+vu
   tdoE4SUMTv9FqTlMvcEstLIS6otiaOA1fcOkbE88ok7UAb3qpWTlQlJPD
   HsGOKbU6lgZP69zdS0UzsK9pblHTGU3kjHM5UA1MptNBzm5e2RJ23CU2i
   A==;
X-CSE-ConnectionGUID: PnEHE8ZIQfS3m5QvY3bu6A==
X-CSE-MsgGUID: nzDcAVizRPe9G0Z3cIlnvw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18941068"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="18941068"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:20:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915459507"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915459507"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:20:18 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rurXU-00000003Ju8-1CZ9;
	Thu, 11 Apr 2024 13:20:16 +0300
Date: Thu, 11 Apr 2024 13:20:16 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/6] mfd: kempld: A few cleanups
Message-ID: <Zhe5YPsvEp1rzsTp@smile.fi.intel.com>
References: <20240223195113.880121-1-andriy.shevchenko@linux.intel.com>
 <Zgwk1tr7x4HnnlD9@smile.fi.intel.com>
 <20240411092928.GB1980182@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411092928.GB1980182@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 10:29:28AM +0100, Lee Jones wrote:
> On Tue, 02 Apr 2024, Andy Shevchenko wrote:
> > On Fri, Feb 23, 2024 at 09:49:49PM +0200, Andy Shevchenko wrote:
> > > Just a set of ad-hoc cleanups. No functional change intended.
> > 
> > Any comments?
> > 
> > (I assume the 6+ weeks in the mailing list is enough for all kind of CIs
> >  to complain. But they hadn't AFAICS.)
> 
> Not sure why these were dropped from my queue.
> 
> Likely another Mutt "feature".

Hmm... Using mutt as well, but probably not in advanced way.

> Back in the queue.

Thanks!

-- 
With Best Regards,
Andy Shevchenko



