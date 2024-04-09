Return-Path: <linux-kernel+bounces-137057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAABD89DBBD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:07:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9641A2852CD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94EF312FB00;
	Tue,  9 Apr 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CECIG6Ph"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3407EEE0;
	Tue,  9 Apr 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671610; cv=none; b=p1oiaCLOvjjEf2mTLWvEJKV8he4tw3rv/XPO2UTFbrn5m3tmUbXZG6a2xyRW0R1A9hlUfvSzuiICWLpTz0GGRp5kt9X/pUFopTfIOP+WE9B+iW4waPAdIxvCKKApDGyKR1zmdSgunk0G2xmHJeEmMV88Kuz3wXuA4eWuNPDodd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671610; c=relaxed/simple;
	bh=P1gNeYkG5bwZnGH03ghwXER+cIJuJOAxd+xPMYGlaCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6F8LsTSHyx0RvBXAJB2yIrI+U2ZQVLc610o7F3SAjp3lN8wTzPAqwzagTFJLTxqyREn6KpjEsuRu7vH4EwJvX8Tg6Ie8OIi89tNwCaJYp2XGhD4wqOtmiBNBq7aERvnazGNRTxv3jGjk6qOBZg6kArgZXHxN4Ig8cHoli+0Q+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CECIG6Ph; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712671609; x=1744207609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=P1gNeYkG5bwZnGH03ghwXER+cIJuJOAxd+xPMYGlaCI=;
  b=CECIG6PhoJPLrdMzNAIV1vmPfiYCQtMiWvTM4ql0OtwlGymCTeAxjiGl
   6NkPEJukJMAqQ0XPJuNLBMFbRDtBlXdcYoLhQSMN96M8yVVXq+RSeN0Ye
   N3YcO4dt/o1y4GAN0vBC+BvWYOZA4DTSTSYmdbgAkTMpctR/LDQjF7sif
   Ex6XipHnLVCQam89eknrWefYdUUgO9+XQMjXJ9HAuF72uHCMmcWN7yFAB
   75l8MSk3O8dWYDo6LK0fRCn57/oxTADUveLQp2oOHOnE160bHYD6yH7AD
   M5iuaSQYCm49MCYBRWyTsOH2CRgfZyScy1Afl9jtmnKHVkUWdP/4EgACN
   g==;
X-CSE-ConnectionGUID: u1vYq9qwR2ajBKvYNeCxaw==
X-CSE-MsgGUID: +H+XGrLcRLqlpp9bUYyW9A==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11824762"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="11824762"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:06:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915400773"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915400773"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 07:06:44 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruC7V-00000002p7w-0HJf;
	Tue, 09 Apr 2024 17:06:41 +0300
Date: Tue, 9 Apr 2024 17:06:40 +0300
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
Message-ID: <ZhVLcNI3rRhWs9_D@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-3-andriy.shevchenko@linux.intel.com>
 <ZhU57jB_pVvDz0ZR@smile.fi.intel.com>
 <CAMRc=Mdzc2gSEX0h0Uwcxr2qMgwLLXfhJda=3AkNNYsDBQre7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mdzc2gSEX0h0Uwcxr2qMgwLLXfhJda=3AkNNYsDBQre7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 04:01:43PM +0200, Bartosz Golaszewski wrote:
> On Tue, Apr 9, 2024 at 2:52 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Apr 09, 2024 at 02:12:51AM +0300, Andy Shevchenko wrote:
> > > $ scripts/kernel-doc -v -none -Wall drivers/gpio/gpiolib* 2>&1 | grep -w warning | wc -l
> > > 67
> > >
> > > Fix these by adding Return sections. While at it, make sure all of
> > > Return sections use the same style.
> >
> > Since there shouldn't be hard dependency to the first one, can you consider
> > applying this one, so it unblocks me?
> 
> I'm not sure what the resolution is for % and HTML <font> tags in the end?

Most of the constants are without %, so less churn now is to drop %.
If you think otherwise, please, fix it and I will rebase my patches later.

-- 
With Best Regards,
Andy Shevchenko



