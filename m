Return-Path: <linux-kernel+bounces-52762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7955B849C69
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA4391C2323D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24BA22EE0;
	Mon,  5 Feb 2024 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nlky1Mnz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FCB22EED;
	Mon,  5 Feb 2024 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707141475; cv=none; b=H033hRgWIZvQbagPULw0kf4eOGzTYB8hkjgB6ro5x3sj7KNJ7+Ak5GK0XkRQ2bQBGBZMv/ZTvQpf+VDanxLit7gdrjo5JG6lW+NYOG6zkj6TMZR+XLX81i2QSEmgGGl6t/oPcluyONRoYqPo4Nffw0lS5/Wa0hIf7Ud5MNzvoxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707141475; c=relaxed/simple;
	bh=ZM3+zW05SrsrlyVmd5gMKWjkps4zlzbvlNsuTpZ3HaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cM2H/TYP+m7TAIyGVCT7+xFLqgTfrb6gDlIzPwoFZlXRgjB7WUNy8x7EF/X/vhuIiTd4tBkVaWbuBB9zJPJsplHTYVSk5JVqhGYhTmmj4A5JcHybIAH/KLErM0n6XiWeObQe3pLRdf0tkxpWwcj8IYtQsipjX0Efryxy3ljNkZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nlky1Mnz; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707141473; x=1738677473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ZM3+zW05SrsrlyVmd5gMKWjkps4zlzbvlNsuTpZ3HaA=;
  b=Nlky1Mnz2i2qpyZNYri3V8r8tmmE11ux5QSnTWfAJFTWxr7AtPYVJSu/
   dFCgcwej7QFLBEYJt8XR5xVXtxQfA+cLojB6qscnnqrDvwjzoXpFHOkB3
   qDqb8h8FYYDFN7/qZ6yhE9QfTIBAhr1bxwE3o9KgSy1LFHa/f3AkZU8KL
   xWahGQQCMFXjVb5Zb6svaBo/tFDqJNh1QDymiHRpn1rOmGKMwoBrxLIoM
   UVq4qbW1R7+xzQ+cTpOiWODc99QbRPUk/S5ky+Ox0jmWMsxNRlcC00d1+
   GNanDjXl+69ucVAw7lZ8zW2bng8xmZxojRJkivRSzSasUdLKjy9DiDFZV
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="432250"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="432250"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:57:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909301405"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909301405"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:57:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzTm-000000025yW-19ng;
	Mon, 05 Feb 2024 15:57:46 +0200
Date: Mon, 5 Feb 2024 15:57:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 06/23] gpio: add SRCU infrastructure to struct
 gpio_desc
Message-ID: <ZcDpWf7u3bW34Y8s@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-7-brgl@bgdev.pl>
 <ZcDRuRCT9xE48cYi@smile.fi.intel.com>
 <CAMRc=Mc5=p7tp0r8-MYiHRJ1yXDJLW2Uvm5C1CyoGBAcesdZug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc5=p7tp0r8-MYiHRJ1yXDJLW2Uvm5C1CyoGBAcesdZug@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 02:54:08PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 5, 2024 at 2:48 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 05, 2024 at 10:34:01AM +0100, Bartosz Golaszewski wrote:

..

> > > +                     for (j = 0; j < i; j++)
> > > +                             cleanup_srcu_struct(&desc->srcu);
> >
> > What does this loop mean?
> 
> I open-coded it because I want to store the value of i to go back and
> destroy the SRCU structs on failure.

Where/how is j being used?

> > > +                     goto err_remove_of_chip;
> > > +             }

-- 
With Best Regards,
Andy Shevchenko



