Return-Path: <linux-kernel+bounces-68748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D9979857F79
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:39:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8EA61C238BB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A8D12EBD9;
	Fri, 16 Feb 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iHuDzO2M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935F12C804;
	Fri, 16 Feb 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094393; cv=none; b=L7fnRkJcuKIlZSNqQJxNPPZtIeGfhCgaXN4AUhfRUdM0YEtebEVbVNZyNFixutfKa3+B0CSNckULG91aL74tVBhffSCJ97RNE4dv2MTFPl6mqM03CRJ8LPV1J/nUFOb0E90vjVxuPZ+UJUmopN+OWXHxNTvRLLKQ4RpwNGADVIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094393; c=relaxed/simple;
	bh=9lHEVTo8mPJiu0T+0ledqPwSvY4qVWHGVchkSR9EwLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAr6X75bJoiy7a2bMFBmROMXqSajZLe881E7OJCJfkorIl+Yov//z8kzc32hdyKIfb9BLgFxET5qh7cbil58cVYJ61xku+uP2GYj9Mdh1zWXLdfwet383aM7ZYHC1KeahU2tLxxBvvDGJbArZsmlxI1SnzrY3IN8P29FIFcLuNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iHuDzO2M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708094392; x=1739630392;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=9lHEVTo8mPJiu0T+0ledqPwSvY4qVWHGVchkSR9EwLM=;
  b=iHuDzO2Me3ja8Hribf+y5FGfhiyiJyExXYVIwEDEaeJrpCrml/c6oadz
   IC5PbHCAxUlBveCCj54zS2GEuDlNCyG5zqyApQeMVLvpoDxs1d9gh7D39
   S9AqoGAnDsNp5/pA4y1D+NcCP/mrKbKSpvOpDD4vKiUZhoub/rVRm7OBK
   PvJn90wymCz7bXCDae9uA4yd4N+eQrjPyWuM26A9tTWGLgCJcsuHlCxC2
   u+W0M5jDzz7DuTQugvnYE4I6ZDTgjy5VcIXpIH687teJh7yjDtFqOmYxT
   58xR5cBZze70fcfg+injkmUU0sH8+/uvxh8FuqbaXhIN/72CYSDauGX8I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="19745254"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="19745254"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912370791"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="912370791"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 06:39:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1razNS-000000054Vl-2n7o;
	Fri, 16 Feb 2024 16:39:46 +0200
Date: Fri, 16 Feb 2024 16:39:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v2 1/1] serial: 8250_of: Drop quirk fot NPCM from
 8250_port
Message-ID: <Zc9zsrp5KeSRoqxP@smile.fi.intel.com>
References: <20240215145029.581389-1-andriy.shevchenko@linux.intel.com>
 <835925e0-0df0-fed6-6b29-0cf4a9f811b0@linux.intel.com>
 <Zc4_IHMQWSGtCCC2@smile.fi.intel.com>
 <cfbd1259-918b-d6c6-6018-70742c8b598c@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cfbd1259-918b-d6c6-6018-70742c8b598c@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 16, 2024 at 11:31:01AM +0200, Ilpo Järvinen wrote:
> On Thu, 15 Feb 2024, Andy Shevchenko wrote:
> > On Thu, Feb 15, 2024 at 06:40:15PM +0200, Ilpo Järvinen wrote:
> > > On Thu, 15 Feb 2024, Andy Shevchenko wrote:

..

> > > > +	/*
> > > > +	 * Nuvoton calls the scratch register 'UART_TOR' (timeout
> > > > +	 * register). Enable it, and set TIOC (timeout interrupt
> > > > +	 * comparator) to be 0x20 for correct operation.
> > > > +	 */
> > > > +	serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
> > > > +
> > > > +	return serial8250_do_startup(port);
> > > 
> > > I know this matches how it is currently done\
> > 
> > Exactly, I haven't changed the workflow.
> > Does it mean you are okay with the change?
> 
> Mostly. Another thing I was let bit unsure if it's okay to move that 
> serial_port_out() outside of RPM get/put that is inside 
> serial8250_do_startup().

We have other (actively used AFAIK) drivers which do the same.
In any case this driver does not use RPM anyway, and in the future,
when Tony finalizes his RPM work those 8250 RPM wrappers should gone.
If somebody implements RPM in this driver, it may be done via standard
RPM calls.

TL;DR: for now it's okay, I am sure.

> > > but I wonder if TOIE should not be enabled until ->setup_irq()
> > > has been called.


-- 
With Best Regards,
Andy Shevchenko



