Return-Path: <linux-kernel+bounces-90994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 718C387082E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:21:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA87B29AA0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1536160267;
	Mon,  4 Mar 2024 17:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="edpwkUbl"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895AC39AF1;
	Mon,  4 Mar 2024 17:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709572627; cv=none; b=M8tal5D01b0CFeofKkfMpXJpCvFDKZ0Y6Dx0SJZ6LX+n9aVYJgN5+SUeO+V511Yk9kxlxt6ol3LiW4uA5Yu5rcXA5UhpGvTSqC7RKEkZBkKEbFqFthizHEv50+10L+0te9A4SvwxjMGCd2xh6kwxeCQ5dAqAgoTUZo3zFrgEnqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709572627; c=relaxed/simple;
	bh=+WzA47WD/LE1C09eSq/iJjh2GEWjoxaXnLmrHQVH4ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4yQyzlVCqfe3hEWSNm9W8m4ARbPEALH6LJuCNe5dtYVZLfibguOk5OcDWXUGvUgoDnazGDtgry+mPiPpfdj+53TpZGng/jLbLeXxV3rkK6Ag/D97JJ+E3XuAZPil+8WYPNzNEuZM2vb/q8Q6C3H+as/jC5D3CtpN3aLP8gsIyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=edpwkUbl; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709572626; x=1741108626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=+WzA47WD/LE1C09eSq/iJjh2GEWjoxaXnLmrHQVH4ms=;
  b=edpwkUblNoAXP8o8klnZaFP6m6lzhrmny/JFBMqHkQDxIqUMVhxFXJAr
   2S/oE/iDFrMmHXSij4PvhliS5mvn7SaoAJtdrhpenzwFFfKWbDVEYmrj1
   suEUt0Oqki/fu4ypvDaqno+Pb3n+RtkGOeOPfDDI+diRzpxYkI4Dx4RbH
   knNFhhzyz1AkFq7OJnpfpzcEX4IBy0yZYwPJaw10Yy+a8F38X9a3mfFCX
   1pcU4O/bKImGPD2uUYffIXabcu3LmxYAOOojjXMBZyBuilQWefRLfVBHc
   seDArwhFLDuYnFz3vCHOVQDierYxp6O70HLQfKhJphhyV+EbqbMNCwhgA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3938354"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3938354"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914110748"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914110748"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 09:16:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhBvc-00000009lwg-1ABC;
	Mon, 04 Mar 2024 19:16:40 +0200
Date: Mon, 4 Mar 2024 19:16:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Deduplicate cleanup for-loop in
 gpiochip_add_data_with_key()
Message-ID: <ZeYB-LjF743UDJku@smile.fi.intel.com>
References: <20240221193647.13777-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=McECxKW+uS7fQyGtYVfcSZQaAJZFi+s+wNMoRiHxef0zw@mail.gmail.com>
 <ZddL7L24RXoqR7sN@smile.fi.intel.com>
 <CAMRc=Md6d19hhySFti+vSLV9pfyzuHNUDmHN_XYV73uCWDAY7w@mail.gmail.com>
 <ZddOcJrYEANc2B2Y@smile.fi.intel.com>
 <CAMRc=MdABvY8dC+UBpkoLiHc881UFKv0VAQsCUhqnxn3f5LKRQ@mail.gmail.com>
 <ZddPEHjLeiYUd6Tb@smile.fi.intel.com>
 <CAMRc=MdDDz1HHqB4pkHFv+_A4iVdh7m-R2B9BrmotRW3Pm2EEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MdDDz1HHqB4pkHFv+_A4iVdh7m-R2B9BrmotRW3Pm2EEA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 04:15:19PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 22, 2024 at 2:41 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 22, 2024 at 02:40:05PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Feb 22, 2024 at 2:39 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Feb 22, 2024 at 02:30:03PM +0100, Bartosz Golaszewski wrote:
> > > > > On Thu, Feb 22, 2024 at 2:28 PM Andy Shevchenko
> > > > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > > > On Thu, Feb 22, 2024 at 10:48:00AM +0100, Bartosz Golaszewski wrote:
> > > > > > > On Wed, Feb 21, 2024 at 8:36 PM Andy Shevchenko
> > > > > > > <andriy.shevchenko@linux.intel.com> wrote:

..

> > > > > > > > +       while (desc_index--)
> > > > > > >
> > > > > > > What about gdev->descs[0]?
> > > > > >
> > > > > > What about it? :-)
> > > > > >
> > > > > > for (i = i - 1; i >= 0; i--)
> > > > > > while (--i >= 0)
> > > > > > while (i--)
> > > > > >
> > > > > > are all equivalents.
> > > > > >
> > > > > > The difference is what the value will i get _after_ the loop.
> > > > >
> > > > > Ugh of course. But the first one is more readable given I got tricked
> > > > > by variant #3 at a quick glance but the for loop says out loud what it
> > > > > does.
> > > >
> > > > I disagree. `while (i--)` is very well known cleanup pattern.
> > > > Less letters to parse, easier to understand.
> > >
> > > Whatever, I don't have a strong opinion, just rebase it and resend.
> >
> > Sure (just will wait to the fix to be settled down first), thanks for review!
> 
> I realized you haven't resent it after all, do you still want to change this?

Yes. U can prepare a new version later today.

-- 
With Best Regards,
Andy Shevchenko



