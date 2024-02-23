Return-Path: <linux-kernel+bounces-78551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F26F8614DF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82771F2521A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32CC680615;
	Fri, 23 Feb 2024 14:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qjq69VVG"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB7D2E412;
	Fri, 23 Feb 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700101; cv=none; b=XKdy50ZNyas/rMnfLDTrO/K+28GSdqWagYUKFT+/SM88VKZge3US1WM3CdT5bg9+cwc6zeIrFWZkNFtMuQbjl+cSrlN7tQpKQCrGL4jXxXuVYWJYWH9oR7i8XIZ8FrgjNWu9gYLRiIBmZooKjSQOXsPDREoL0dhQK2glBVw23gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700101; c=relaxed/simple;
	bh=016ptIL+36Fqn6wZg527d8XvKapiTDOVTK62tuSAE4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4m8VoVEZFeK2X01SnocDq+75dqCuWqEXOo69PIjQvwCYruxzMR7FEYh8Em84mQRPqvgClHGexeTlfhpLpLO8fbHV9lcWIsEw42GT4TpsUYVbOHRMhQ8OuvbpRHUHVY2e1DPZSAiOKTURSwDxRkYIbfGjVPvTqPW4uhMRYuJ8Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qjq69VVG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708700100; x=1740236100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=016ptIL+36Fqn6wZg527d8XvKapiTDOVTK62tuSAE4A=;
  b=Qjq69VVG1fF92RVCB2tBEbcu6H8ns9eWeyOOXp8d9LCHXBJ9yPHXVgME
   elBMhIrP/1mwfqFgKsQh4FD1wRfoBbS1uJ5Srbz4vzruWyQ5mQNb48s4O
   FTd9ZgDfA7/r5nWfCgpaNTQF3ABHTKkodVndXiNr96Wl2cPHt3KC33Jfm
   5ldBGIxdLwAwqMnmyKpJBCB8Drc0GobP63S0LYtGbxBPcYKRTN8kn10C/
   wguHCdhnD2+cPfJkxA8Yq2lLnjOF6cdhKxp6UPCsPfrtoRkuOq1Zsa0U1
   v3iy9E2DOYvTNevsEM3kp3QDCF9DMTg2qnrP2XRiPgpxr2CcElU6VCuc7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3524538"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3524538"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:54:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748193"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748193"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 06:54:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdWww-00000006vZO-1jiF;
	Fri, 23 Feb 2024 16:54:54 +0200
Date: Fri, 23 Feb 2024 16:54:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Saravana Kannan <saravanak@google.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH] gpio: sim: don't fiddle with GPIOLIB private members
Message-ID: <ZdixvgZaW0-95zc8@smile.fi.intel.com>
References: <ZPWcTMPiu4MSq+F7@smile.fi.intel.com>
 <CAMRc=MfZv70FXHyNw4yK90NL5-jjAJa6qbKc6SV2ZwbaJkKQqg@mail.gmail.com>
 <ZPWmDL6QJJMNi2qa@smile.fi.intel.com>
 <CAMRc=Mc0JgPUEpaes7WcbkMu5JyrpLW8N1+bM-+OJaB+pPX4ew@mail.gmail.com>
 <ZPWr3dRP5C1GSY9F@smile.fi.intel.com>
 <CAMRc=Mfae+=HPPWzsG8bgK2CGOGY9GPkS5VZcwLyr_yY8A_y2g@mail.gmail.com>
 <ZPWxbfHNOqAnkR09@smile.fi.intel.com>
 <CAGETcx9wERf-R4=r_jBYpYgGHSxS=-xx_ydeVWZdGUvEWTQwzg@mail.gmail.com>
 <ZdXzxY3-g7oY00Mq@smile.fi.intel.com>
 <CAGETcx92GgwBpd58dLgquLFxqXiHK5QHGK3Rhkd9pC_4p7Ra6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx92GgwBpd58dLgquLFxqXiHK5QHGK3Rhkd9pC_4p7Ra6w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 05:01:04PM -0800, Saravana Kannan wrote:
> On Wed, Feb 21, 2024 at 4:59 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 20, 2024 at 05:46:27PM -0800, Saravana Kannan wrote:

..

> > Is there any _good_ documentation for devlinks and all that fields in the
> > struct fwnode? Why should we use that without any understanding of the
> > purposes of that field. We, as device property developers, hadn't introduced
> > that field and never required it. It's an alien to device properties APIs.
> 
> If I add some inline documentation for these fields, will you be more
> open to letting people use this as a way to look up devices? I'm happy
> to do that for you.

I consider documentation patches to be always welcome. But it doesn't mean
we allow to use that fields in device property APIs without a very good
justification.

-- 
With Best Regards,
Andy Shevchenko



