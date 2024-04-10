Return-Path: <linux-kernel+bounces-138687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5493E89F90B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866341C27EA6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408CE15EFD0;
	Wed, 10 Apr 2024 13:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YKEhPDBS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D9E2AF16;
	Wed, 10 Apr 2024 13:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757361; cv=none; b=cTfZM38DQiEAadFyo1wC+VppRDiJ8KeB6IFnRf+OINc38/dGuEx9zKESrov4cw6rgioHGmq7yn0xXzQzDu/JbVdEhDeTIeJjQ2Y83Qyb+fGFwmk0QPlpm9+N3uEJA6gp0vZsWzwSVeSmbW2evf15oZVunD4Gg7fInP/0sCreiFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757361; c=relaxed/simple;
	bh=BY21WXTdgA7cn3s4Y4cI1FMn3JiwMTv1TQpfDpXed4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsXNlo5IE7oNvzwiiWeVJnKp9hxHof2FwXjszOH7AE/th8HHK4obrmUQyw4B6gbdvQgobv5vdNI0qrNIPp9rr7vCGxExUvMF74/JHONTqXqG6Nl2GH5KLbdnMqNOuzRHYwhPalJN0urTNSn8pwFb5V1S1CbCRGS4l7Jm+1pJOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YKEhPDBS; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712757360; x=1744293360;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BY21WXTdgA7cn3s4Y4cI1FMn3JiwMTv1TQpfDpXed4k=;
  b=YKEhPDBS57vgr1ELdBGUr2B+ArdkP8gNP9dap483vQZZdU+q9CGt4kKy
   lKDlyZsrpJFQQVFYsdCRcKNOQyENxsm4hF/9Nx1bw7MHD971CTWFaFDF7
   +EFcd53brb+eMqPEC/R5yGitb3Kjg1o0GXPY/CQI598yoO6JevwCm3Nvi
   PT+RzrSi1HEy9SxSGQBL5LHBEexheO927yaGQoMbKAdZVJp2e1+xTx7WK
   vywPhFpqdUlwOCch7FYwaaXtz/OPtPSP29S1D2kQXcxzhcB20Woy2o2Ky
   hB3voMN2q2SyqBE6ehnlO7eP0GxVKImN5rJywp018UNZKs+85dw5ALQZW
   A==;
X-CSE-ConnectionGUID: elmdEX65ThatW109Ulqi1A==
X-CSE-MsgGUID: MDdfDskNQyCw8TV6K7Z36Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="7992826"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="7992826"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:56:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915433640"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="915433640"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:55:57 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruYQd-000000035Ea-2Wj6;
	Wed, 10 Apr 2024 16:55:55 +0300
Date: Wed, 10 Apr 2024 16:55:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 7/8] serial: max3100: Extract to_max3100_port() helper
 macro
Message-ID: <Zhaaa1DBwVHf48oQ@smile.fi.intel.com>
References: <20240409144721.638326-1-andriy.shevchenko@linux.intel.com>
 <20240409144721.638326-8-andriy.shevchenko@linux.intel.com>
 <889be591-93cc-4e80-bebe-04a6f8f58c70@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <889be591-93cc-4e80-bebe-04a6f8f58c70@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 10, 2024 at 09:17:28AM +0200, Jiri Slaby wrote:
> On 09. 04. 24, 16:45, Andy Shevchenko wrote:
> > Instead of using container_of() explicitly, introduce a helper macro.
> > This saves a lot of lines of code.

..

> > +#define to_max3100_port(port)	container_of(port, struct max3100_port, port)
> 
> This is wrong. If you pass something other than "port" to to_max3100_port(),
> the third arg of container_of() will explode.

Then don't do that :-)

> Use an inline to avoid mistakes like this.

Sure, thanks for catching this. Should I send an update to prevent this from
happening?

-- 
With Best Regards,
Andy Shevchenko



