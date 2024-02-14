Return-Path: <linux-kernel+bounces-65788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C60855237
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABD70B2CF6B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153DB127B5D;
	Wed, 14 Feb 2024 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJHsvok0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6540126F3B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707934327; cv=none; b=VHzPDJbRN3JRWFHeGHZiBrwejDCxwYEIqg+D1xRJ4qvVz2Joh7QhNAPPHzSOwLEsuOa3AG7RcvzzMCu11hDcHCzsu4/qFrJvZmtonRZw4tW41uBJ7AafDnz33oJTICJS7zfxMY0PebESOfsmN25kzbMSjDgU9memfAi8GVZJm0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707934327; c=relaxed/simple;
	bh=xfTV4z5Yuw8uwhLsU40Y2J9aD+jsKa0viMSOmU44Hpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpVyXldWadgPpvFphskNDtt3wQY576Gn0fYaof3hG/rowf5HlU+53iyZO2jwXJ3WsqqRjEVyc9gE61boqAeTfTHOToI67uci9f91fRN7uBiA1QXfq2b1t3hNZTaRKFYcU5IzrJaP04MMXMUJJ9h2ErlXriRjJ0LdQKa8M+zd8Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJHsvok0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707934326; x=1739470326;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xfTV4z5Yuw8uwhLsU40Y2J9aD+jsKa0viMSOmU44Hpo=;
  b=UJHsvok0iiOQOvDdfZ+1fmeOndBOpJH7gH1dVNKBesixvJ6Oex9n7k9F
   XLeS3557MvHs4ioHS/0tlikX6J1zAfOmd7lGaeeKinKgPRXWSZTa41EeT
   YRl5mtR2tkzynxQNNEhzLtZF/GC8aSbnvYOmVmJgjfMz6jnQwg3ggIscp
   3Pt+xp6f0UPDjb3ah+wAU+1JlLfxIpCngjHOnSej03jYCA30ZqHPW2u/c
   m+7oLzuJqHyIUzkeeigvsnGEUvmNHnIPDE5PrUFQcNnMjfu6PBPfLyRDQ
   vClQAPfg5bOnxS5fe6IwM1SOwkconsigo3+byLC+/0UR02NlnotrqZHJ1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="12543711"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="12543711"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:12:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="912093344"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="912093344"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:12:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1raJjk-00000004Z0k-2VsO;
	Wed, 14 Feb 2024 20:12:00 +0200
Date: Wed, 14 Feb 2024 20:12:00 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>
Subject: Re: [PATCH v1 1/1] kernel.h: Move upper_*_bits() and lower_*_bits()
 to wordpath.h
Message-ID: <Zc0CcNbpFrkkqiow@smile.fi.intel.com>
References: <20240214172752.3605073-1-andriy.shevchenko@linux.intel.com>
 <9cba3b78-1020-4337-a1f9-5857a297aee4@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cba3b78-1020-4337-a1f9-5857a297aee4@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 14, 2024 at 10:09:10AM -0800, Randy Dunlap wrote:
> On 2/14/24 09:26, Andy Shevchenko wrote:
> > The wordpart.h header is collecting APIs related to the handling
> > parts of the word (usually in byte granularity). The upper_*_bits()
> > and lower_*_bits() are good candidates to be moved to there.
> > 
> > This helps to clean up header dependency hell with regard to kernel.h
> > as the latter gathers completely unrelated stuff together and slows
> > down compilation (especially when it's included into other header).
> > 
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> > 
> > Kees, since wordpart.h is now only in your tree, this is supposed
> > to go there as well.
> 
> after someone corrects the Subject (wordpath -> wordpart).

Oh, indeed. Thanks for spotting this!
Kees, should I send a v2 or you can amend when applying?

> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks!

-- 
With Best Regards,
Andy Shevchenko



