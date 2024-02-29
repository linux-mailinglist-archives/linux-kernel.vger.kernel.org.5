Return-Path: <linux-kernel+bounces-87271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CEA86D1FA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48154285742
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB7C7A139;
	Thu, 29 Feb 2024 18:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ALZ6aQO8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F364878284;
	Thu, 29 Feb 2024 18:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230900; cv=none; b=B6zweg2lqnhyWeyMhjMqp4T8mWod/3Ujxuotfc+3kehDcRktYTbtzL6WVkdUlwyaewQdyGG7lA692yXb1osxbjYmEkHAsmYEPLKwC20688bMJBbEH5hV9QM7qtQVaApafAWB3+QR9binqEnuMwisRDlweV4zZxnED6AtQMRQXBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230900; c=relaxed/simple;
	bh=FrgFr1PwHdvjBc7xr5zlxE5I160oyk5MyG0mCo/awmw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MG7qc1pDvuFJAN6myndYlBA8YJQ9QeBC/PHKosk2SGpswoYHyv8g16LJRpwLonke5DYVZfDUf1OGr5eT6crfS9liMAEvLW/ikEZMQ0Ajr66TZYPxcAcDEO911f1E6rvgx/Qz4UJRAXkgXheclzQi4T0uzLTozAqQDPbNOFaUVLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ALZ6aQO8; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709230899; x=1740766899;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=FrgFr1PwHdvjBc7xr5zlxE5I160oyk5MyG0mCo/awmw=;
  b=ALZ6aQO8ksqaVn4sdzlUgnJrHeOTKUQGK9W2N8FNXGaV9etnrJ9RSwbo
   dIy3eghp+kJd/IxRsrO4UOAkXR4YkAou4MI3I5gaSBNFqzlubck7gE86q
   BS6i6kfI+E6myCFaExvMCT0IEmhN8KwXXdDpOpLeom5LU3TT+UB4JOpCN
   7JMZ4E0T1jqvgac/U+sADHDuqS/qsnOlHzLQZzBbV6MeTe9hLRx5+Wa9M
   P+HQDulbKiGzhPPcQaAVhzZ+j/rdIhawZuOZf1M/0Lobidcg3oy1OWNyr
   e9IHm/250L3DIMHWIydw/673BhXCafi6hrmwIYvSgC81WrkzI/IMYojF3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3898447"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3898447"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:21:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913988731"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913988731"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:21:36 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfl2E-00000008k9h-0f0o;
	Thu, 29 Feb 2024 20:21:34 +0200
Date: Thu, 29 Feb 2024 20:21:33 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in
 gpiochip_add_data_with_key()
Message-ID: <ZeDLLfQOrPLUzyGt@smile.fi.intel.com>
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
 <ZddLRAqxFr7v3Zqs@smile.fi.intel.com>
 <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
 <ZddOKTP73ja6ejTc@smile.fi.intel.com>
 <CAMRc=Mf_w_E4B7c_Uj1WV3zv9DbmJ22oFvJJwtd-+3oUDVcvXA@mail.gmail.com>
 <ZeCw3pzHdrXw46of@smile.fi.intel.com>
 <CAMRc=MdKFvAefKxLnovxnQt_tpiW+dCviWXKuHqg3vqHhEtPNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdKFvAefKxLnovxnQt_tpiW+dCviWXKuHqg3vqHhEtPNA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 06:26:29PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 29, 2024 at 5:29 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > > > I'm sorry I really need more (morning) coffee, maybe you can simply update
> > > > yourself or submit a correct fix?
> > >
> > > Ok, I'll apply this and send a fix on top of it.
> >
> > I don't see any progress with this. Do I need to do something?
> 
> No, it just fell through the cracks. I applied this now and sent my
> own fix on top.

Thank you!

-- 
With Best Regards,
Andy Shevchenko



