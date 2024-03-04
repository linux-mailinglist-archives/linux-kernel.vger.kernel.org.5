Return-Path: <linux-kernel+bounces-90754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DD8870474
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38BCF1F23F5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163244654E;
	Mon,  4 Mar 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSAmHQc8"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFE13FB02;
	Mon,  4 Mar 2024 14:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709563406; cv=none; b=jRfEF3C61Dv0N+FwxHbZ9zNNByrYrBJIkqgZu+vNIj2r7/qQHiqzXvbj8YjeLuosWytYiSlxpGzh9rMq0c7QZcNgMkbKDwKVEVJDSndI68ap/K3884HWjjGYtNFkDtWiJi1z1WMbIEfQkukqNR5IpTY0bSpjgGBHm6XJ5i9dBS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709563406; c=relaxed/simple;
	bh=bmadvNIkZjUh3iwFVzrA9dPuYSeRK5os694MQH6jlWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rT0xvCcl0+eQOyrlFeCP/I9OiHZecvV1N7PH64C+JGR+duWW5E/LSVHPXlnH5rOgfYjs2fWAr6kJQQ9F3BjFFKqDQzOB7RdfgGWvq8Nqb0NPVycDTek4PDSBQAtI+lnUoiG8Smooy0mGnLrEUseCr2GhHUnkCCh8Vx1mOerUL6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSAmHQc8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709563405; x=1741099405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bmadvNIkZjUh3iwFVzrA9dPuYSeRK5os694MQH6jlWo=;
  b=SSAmHQc8vh1LinrgVWTq1n3FESm1RymWywg1qbCBrN0KUhw3mMRZMPUZ
   4BXYCUvXG7w7dZILZQTYyceIW/aF0yyQ1cK18OfZ4N6kYM30JFhJbgLgC
   jkeRyN7xBpJjfYXtSh3tcjCxOLblvfc0LWiiKM68obtidyJqCioV/oRRG
   1JZUejt0LVxD9Kkz1PUupkeK3Vc9aTZmLj7VGv5wqeKxYnN88kY9+Exc/
   0X31FZeN2O8jWyrD3ODE6PJV7k2c7BLViI3pkuZ7k1tp7A35rJTnk508N
   PM0HlF6eACKquo5n3cycvcix3xccOqrcWXUan8hRBYKjhYW48g95l1UUJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="3912312"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="3912312"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:43:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914107633"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914107633"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 06:43:21 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh9XD-00000009k9U-0Ek0;
	Mon, 04 Mar 2024 16:43:19 +0200
Date: Mon, 4 Mar 2024 16:43:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/cio: Use while (i--) pattern to clean up
Message-ID: <ZeXeBr5z8TrLbuCI@smile.fi.intel.com>
References: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 03:45:01PM +0200, Andy Shevchenko wrote:
> Use more natural while (i--) patter to clean up allocated resources.

Any comments?

-- 
With Best Regards,
Andy Shevchenko



