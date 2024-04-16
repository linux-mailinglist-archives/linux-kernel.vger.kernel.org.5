Return-Path: <linux-kernel+bounces-147431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 282BB8A73F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89EB282ACA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F25137910;
	Tue, 16 Apr 2024 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EQZJ2dNB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A2310A14;
	Tue, 16 Apr 2024 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713293866; cv=none; b=HA1AAc7bykwOZKuhmWApxTEiwNDaB8spXErWNUNV9zGXMgg/w0qG04DJ8ji2mQMyyog5+ySPl2cbLV67PSYD1kFgzjo6dQUPOvE/GI3OJyDyjxuW+hUr0ubmP/xBMgZcjRylOL/TxSjK5VQoN0V9V9CbRqil60dYiD1pi66oNQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713293866; c=relaxed/simple;
	bh=iqWTM4m1SZfuEXNpu6MktnRv449AkdFasYLnu+F5Mus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LgZQ6tonQavqWd+IjN+HVOgxzpsHQDorWuBDbZm0XztA418BDQDXee7SC+y0iVPBNRrr/39t0J2KjXNB9m26bsHQFC6tqF1IKV9owFvg0xwRHDMoo4muQxxhTCWAH5wuh2WOI5AEXki2nSOClH7D8dvgIDEUrCrCLpvwfE4YzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EQZJ2dNB; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713293865; x=1744829865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iqWTM4m1SZfuEXNpu6MktnRv449AkdFasYLnu+F5Mus=;
  b=EQZJ2dNBefeecUCn/K7pFNonPtqXWpPNOOEJVq+f/BYNdWWwhHOlz9nD
   OSbcmijtuJCJoVjt4OoP2ucURp96dtL8XFcohuCAY+k30m/Cv2AGHOl5J
   IMPq0dt0jnL5APwplCpcwedTkWIRlg3SQnfnn1522c4RZp7UST9+Ef8K8
   mc5qmBIbpjU6fdgxAry4D/R/IHBweRhKoUjSuetVWU7rETGhSLjZfc2cp
   bcfEmRg7m1Dmd6TYr5YlXEhSSg61GsuEPKQH4KsfjWgCUNbp4aEn4gT7h
   L0ODb353vWot2QQhapTt5uJ1zIHt/92YFvjosbiwNFe7AbsQaixctViJw
   A==;
X-CSE-ConnectionGUID: JDZ7zOT2R6CIHoEqT2TAfg==
X-CSE-MsgGUID: KGSOp44aRtq9gWg9IThyTA==
X-IronPort-AV: E=McAfee;i="6600,9927,11046"; a="34143239"
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="34143239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:57:44 -0700
X-CSE-ConnectionGUID: 34Sc7N8KSU+Wghh0vgQByA==
X-CSE-MsgGUID: VG89AKF3SBK5sEueotzDMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,206,1708416000"; 
   d="scan'208";a="22418503"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 11:57:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwnzv-00000004nUO-38pj;
	Tue, 16 Apr 2024 21:57:39 +0300
Date: Tue, 16 Apr 2024 21:57:39 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Pratt <mcpratt@pm.me>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Wander Lairson Costa <wander@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Vamshi Gajjela <vamshigajjela@google.com>
Subject: Re: [PATCH v2 3/3] serial: 8250: Set fifo timeout using
 uart_fifo_timeout()
Message-ID: <Zh7KIz1AGyyS3zLT@smile.fi.intel.com>
References: <20240416182741.22514-1-mcpratt@pm.me>
 <20240416182741.22514-4-mcpratt@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416182741.22514-4-mcpratt@pm.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 16, 2024 at 06:34:10PM +0000, Michael Pratt wrote:
> Commit 8f3631f0f6eb ("serial/8250: Use fifo in 8250 console driver")
> reworked functions for basic 8250 and 16550 type serial devices
> in order to enable and use the internal fifo device for buffering,
> however the default timeout of 10 ms remained, which is proving
> to be insufficient for low baud rates like 9600, causing data overrun.
> 
> Unforunately, that commit was written and accepted just before commit
> 31f6bd7fad3b ("serial: Store character timing information to uart_port")
> which introduced the frame_time member of the uart_port struct
> in order to store the amount of time it takes to send one uart frame
> relative to the baud rate and other serial port configuration,
> and commit f9008285bb69 ("serial: Drop timeout from uart_port")
> which established function uart_fifo_timeout() in order to
> calculate a reasonable timeout to wait until flushing
> the fifo device before writing data again when partially filled,
> using the now stored frame_time value and size of the buffer.
> 
> Fix this by using the stored timeout value made with this new function
> to calculate the timeout for the fifo device, when enabled, and when
> the buffer is larger than 1 byte (unknown port default).
> 
> The previous 2 commits add the struct members used here
> in order to store the values, so that the calculations
> are offloaded from the functions that are called
> during a write operation for better performance.
> 
> Tested on a MIPS device (ar934x) at baud rates 625, 9600, 115200.

..

>  	unsigned int status, tmout = 10000;
>  
> -	/* Wait up to 10ms for the character(s) to be sent. */
> +	/* Wait for a time relative to buffer size and baud */
> +	if (up->fifo_enable && up->port.timeout)
> +		tmout = jiffies_to_usecs(up->port.timeout);

Why do we still use that default? Can't we calculate timeout even for\
FIFO-less / FIFO-disabled devices?

-- 
With Best Regards,
Andy Shevchenko



