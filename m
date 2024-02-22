Return-Path: <linux-kernel+bounces-76615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E031085FA0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 925801F27078
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F59134CDC;
	Thu, 22 Feb 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObirV3g/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DFD58ADF;
	Thu, 22 Feb 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609303; cv=none; b=tdb6Iw1tdzfDQ7UWd7Z8EmCDBZZ1dVGscTdyRsc+XGI4r6sXAks0TcOuoiQrEY8xF1eYF0xoGXinMkEorVCvm6uBUekY0SnzVeFzOePoJ6tjsRYYVumr6c7maQGG7pd7jj5gTMWJvqOE7LaCo3MHmvXHQTEypOLZeLVjV9q8FPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609303; c=relaxed/simple;
	bh=tOkvPNdIqc3u3fa13RwwepALtGZUPz0CgOR5F4c+IR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SniuWf41f8mV84Nm8bmdh4IkWZZYoMigl/HQkHPitwik8FKZtekEN8azC4BNGOo5OttLTXSsgZuo584v8E0+zuU1pc7YhZS8Unoojy8cMN3y8ML/GZ6jqDaWzlACIGTPwzXYAQCF6s2kJhLp80hTG7Da7YvaW576QiTaV+77kZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObirV3g/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609301; x=1740145301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tOkvPNdIqc3u3fa13RwwepALtGZUPz0CgOR5F4c+IR0=;
  b=ObirV3g/K5xBA+96EHjwzshn1YSl7tZ0TmfhnJSR9+PeNqW9o7oPuHWL
   Dj1kUuqhO+WD6PWBrW5VV4QG9PyRkStMlgxWSoPZFzLWCIx1F+LPxnIL9
   ohxZDPi/Cl8EHs2YbVxWBFmb0vjGosQgLfGX6H4Tr1dCDkVvcYwYPWcSp
   E/051JydOtKeI7nEvcSulm9fLhPOHMSxZb/RtMQWrvsL9SGhHGekKORc6
   zyo2K/YJFQnNaKqFhsIsXAThPSXwlaz+e64n4jwVPzv8nGIlRdqAe6X4L
   OCtcZEkHQ6CqBzrCmOhhORszt+Z+7RfzASwGFKUVXj5AXIQszT+FGcuUG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25295448"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25295448"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913528534"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913528534"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:41:38 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd9KS-00000006dle-1GT8;
	Thu, 22 Feb 2024 15:41:36 +0200
Date: Thu, 22 Feb 2024 15:41:36 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in
 gpiochip_add_data_with_key()
Message-ID: <ZddPEHjLeiYUd6Tb@smile.fi.intel.com>
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
 <ZddL7L24RXoqR7sN@smile.fi.intel.com>
 <CAMRc=Md6d19hhySFti+vSLV9pfyzuHNUDmHN_XYV73uCWDAY7w@mail.gmail.com>
 <ZddOcJrYEANc2B2Y@smile.fi.intel.com>
 <CAMRc=MdABvY8dC+UBpkoLiHc881UFKv0VAQsCUhqnxn3f5LKRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdABvY8dC+UBpkoLiHc881UFKv0VAQsCUhqnxn3f5LKRQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 02:40:05PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 22, 2024 at 2:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 22, 2024 at 02:30:03PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Feb 22, 2024 at 2:28 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Feb 22, 2024 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> > > > > On Wed, Feb 21, 2024 at 8:36 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > > > > +       while (desc_index--)
> > > > >
> > > > > What about gdev->descs[0]?
> > > >
> > > > What about it? :-)
> > > >
> > > > for (i = i - 1; i >= 0; i--)
> > > > while (--i >= 0)
> > > > while (i--)
> > > >
> > > > are all equivalents.
> > > >
> > > > The difference is what the value will i get _after_ the loop.
> > >
> > > Ugh of course. But the first one is more readable given I got tricked
> > > by variant #3 at a quick glance but the for loop says out loud what it
> > > does.
> >
> > I disagree. `while (i--)` is very well known cleanup pattern.
> > Less letters to parse, easier to understand.
> 
> Whatever, I don't have a strong opinion, just rebase it and resend.

Sure (just will wait to the fix to be settled down first), thanks for review!

-- 
With Best Regards,
Andy Shevchenko



