Return-Path: <linux-kernel+bounces-61511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6813A851311
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:09:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0792A1F2240A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D34E38DF7;
	Mon, 12 Feb 2024 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aPQv5pn2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D79839FDD;
	Mon, 12 Feb 2024 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739419; cv=none; b=TiFFd6msVUdiju9V6bvdA580wsY2o4YHDdWP9ai3ZspW4UDcjjKgw+dNOnO7mpRTQ1N+B0b3pWTjMyS6K7HShtt2IEAwwlr39dkd+M4T+p+EznfGkLjAYDZ9Kr+qbd2PXxAUffDjCeKDNPRlvS9AWzEmYPaSPyKEkRPrwQ4qwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739419; c=relaxed/simple;
	bh=/ArukyQ43nbAu5tdlP70gnYEQF8hurIKFzga3ib3UqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNkg/aHTRvAUJ1aJoqRzvZb8olKCA026ouUcNq9AgEK22exbokTOMl0mGN/OPxQVQ/evZf//S3N7Fif8p6GehYaADyyl4oPSKehV9/OP87FmY7GjSSWqym86fwa+m87igAaeDbkmrGipj/GiNELvkYchm9aU5iOuWBCXolPQSUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aPQv5pn2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707739417; x=1739275417;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ArukyQ43nbAu5tdlP70gnYEQF8hurIKFzga3ib3UqQ=;
  b=aPQv5pn2u8HLUD0iKexhf2GWPbWo0a2xOtaqSK3oWQ3iMzNqahCJJgzM
   TRDim3oCa5X7+eMNy/qmn16UfmjFyyYEFnLenD5spppU3wYH2GxWZrWIR
   ryjiO0oaThurPeTAYs6kUEJSZ8JqLpam6bWcnAoRr7zMCHWRR0KvMboUw
   fJpwuPUXID4605yyz31YxUzxb2Hn9WkoJYUMrF+pZSTrhH38mz83cfLSF
   wxdizPDmzDWZd4Uw0GH8XeTGbHEohCG0NZAwUUd494SNv61h2WMvjXpwM
   n8O3t5hv2Khl3e7BLIUiqTOko+bK+8dmH4O5gIBA/dzAee8dNzx9UeIyZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="2056423"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="2056423"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:03:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911463159"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911463159"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:03:32 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZV21-00000003t3w-3FM1;
	Mon, 12 Feb 2024 14:03:29 +0200
Date: Mon, 12 Feb 2024 14:03:29 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] of: automate of_node_put() - new approach to loops.
Message-ID: <ZcoJEUTdMAKdMHd1@smile.fi.intel.com>
References: <20240211174237.182947-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240211174237.182947-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Feb 11, 2024 at 05:42:28PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Since RFC:
> - Provide a for_each_available_child_of_node_scoped() variant and
>   use that whenever we aren't specifically trying to include disabled
>   nodes.
> - Fix the for_each_child_of_node_scoped() to not use a mix of
>   _available_ and other calls.
> - Include a few more examples.  The last one is there to show that
>   not all uses of the __free(device_node) call are due to the loops.

I'm a bit skeptical about need of this work. What I would prefer to see
is getting rid of OF-centric drivers in IIO. With that, we would need
only fwnode part to be properly implemented.

-- 
With Best Regards,
Andy Shevchenko



