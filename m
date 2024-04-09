Return-Path: <linux-kernel+bounces-137093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D424B89DC50
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27DE6B28C14
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D497130A43;
	Tue,  9 Apr 2024 14:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8yN6uRp"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A3612FF65;
	Tue,  9 Apr 2024 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712672987; cv=none; b=ghdvR9p67ty3Pc7XsvT+9xOZPnhiKCjW3FTa3DL8FSEsdm8ZCOKbAjISCRb4u+E/9NoWpyCjqVk50CVYMIINPgrusI0car3qwhhaBipI7LO2D7cIQq5qVvCclFWwe9wRtDU6vKn3znfJtiGp0FKv1Q4LrnuttMgywDw03m8MFMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712672987; c=relaxed/simple;
	bh=Y8bgT3Mgnddc7ZwsZVd6eKFtCdR1CtVYYgKNg/kledY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tuX75BGY8AHMhLE2BUJYsx2ykucqJmBcwhy35XFGoptpMPy6qsFkx7UdMhEAz6v++5yUtffuvAuss6uXsrk4vUgS4PMtXWrKNNi9QI3StGSbAG5B00Si13WB8T4TcRuYhrvysSPEOviTzWQepE8L4R1Ku2rZVJq81xBHmhvqVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8yN6uRp; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712672986; x=1744208986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Y8bgT3Mgnddc7ZwsZVd6eKFtCdR1CtVYYgKNg/kledY=;
  b=d8yN6uRpFEDkGq0JdMKahnXynTjRli+mmmZ0+jZ57FVKyS+1tcGkYBwu
   jY2cUbDxGwYNjU7jJYv+651DUf2BIN8rMPZvi3jdFN/QTXqVM5WiUfYFg
   L+jmPZRo/XuXjWWdI5d4y8fxY41EvI5y++IoBrTZ9UsZJknwGqS1R3pK+
   k8p1zQhSxuqrcOwWRtB2wV0WhQSidum2+5F4FS0lgGo3t2MF+AVVUK/bN
   W4dXic8RFiXAHkC69ChwX30r5ypYixBxaixcOai0M6AXdEBBTPduWd5B/
   eY2fdNaSth+lR20Sv5scH56bhvAi4ZAOu3+3USEeM5n6YOmnIO3hlhpAA
   Q==;
X-CSE-ConnectionGUID: jVb3WtQsRyiS3CMtsjHopw==
X-CSE-MsgGUID: xKZBwl6LT0Gxggjfikaswg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11828767"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11828767"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:29:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915401236"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915401236"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:29:41 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruCTi-00000002pQ9-2wX7;
	Tue, 09 Apr 2024 17:29:38 +0300
Date: Tue, 9 Apr 2024 17:29:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/2] gpiolib: Update the kernel documentation - add
 Return sections
Message-ID: <ZhVQ0tmpmhFHNxqO@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-3-andriy.shevchenko@linux.intel.com>
 <ZhU57jB_pVvDz0ZR@smile.fi.intel.com>
 <CAMRc=Mdzc2gSEX0h0Uwcxr2qMgwLLXfhJda=3AkNNYsDBQre7A@mail.gmail.com>
 <ZhVLcNI3rRhWs9_D@smile.fi.intel.com>
 <CAMRc=Mf7aNuQfQtOEGO42jMNpCsLjetLYg5YwavLyDu2rz6X1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf7aNuQfQtOEGO42jMNpCsLjetLYg5YwavLyDu2rz6X1A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 04:18:46PM +0200, Bartosz Golaszewski wrote:
> On Tue, Apr 9, 2024 at 4:06 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Apr 09, 2024 at 04:01:43PM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Apr 9, 2024 at 2:52 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Apr 09, 2024 at 02:12:51AM +0300, Andy Shevchenko wrote:
> > > > > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> > > > > 67
> > > > >
> > > > > Fix these by adding Return sections. While at it, make sure all of
> > > > > Return sections use the same style.
> > > >
> > > > Since there shouldn't be hard dependency to the first one, can you consider
> > > > applying this one, so it unblocks me?
> > >
> > > I'm not sure what the resolution is for % and HTML <font> tags in the end?
> >
> > Most of the constants are without %, so less churn now is to drop %.
> > If you think otherwise, please, fix it and I will rebase my patches later.
> >
> 
> I'm not sure I get the logic of it. If the kernel-wide standard is to
> use %, then we should work towards using it across the GPIO code even
> if we do it a few lines at a time instead of going backwards just for
> consistency in drivers/gpio/, no? We don't need to fix everything now
> but if you're touching this code, then I'd go with %.
> 
> Also: what about the s/error-code/error code/g issue? While we should
> always say "active-low", I think error code looks better as two words.

I also have no much time for these details. :(
Let's drop this series then. Feel free to consider this as a problem report.

-- 
With Best Regards,
Andy Shevchenko



