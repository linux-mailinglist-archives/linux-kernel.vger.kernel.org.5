Return-Path: <linux-kernel+bounces-78644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB38861665
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 449A9B25253
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1785C76;
	Fri, 23 Feb 2024 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d88bnypk"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95D682C7E;
	Fri, 23 Feb 2024 15:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703574; cv=none; b=HOk3afdDiquZcIYsxOXpHp+TXxqpkSUdlsTglDEWDT6WSnlpM+hNnVV2XC/HL8t8wvrj5dZP9iZqdLP4EUj/vrqY9L/17eIBZHX56n3f7jqPjRKRjy0hWHkGtGawC2sVrXZ76x6dWexCoGCzG8ohM5ycORIvFF/KQZ1FqZhwX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703574; c=relaxed/simple;
	bh=6vqPUhZkl0WfTqOLmqR/FWKhYBKPjdvFKKD29rNeGoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GgErpaYXIXeb5ZMW2yrFy0no/oRCsNd6GMmu99EPSzsFj0FgSlwHchbOW9vWwQm5nXzrnQpcPRxAlgo9wmyYW8t6Ux8NkSfilLTHLYwok6ilRFFBQCqn+is3KYwQ2ufoiU2DSw3Bsd6/LdQxXwLU7i3YlGwbBxF+S6wchQdht8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d88bnypk; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703573; x=1740239573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6vqPUhZkl0WfTqOLmqR/FWKhYBKPjdvFKKD29rNeGoA=;
  b=d88bnypkjV7rdDuF9EEllR5CLp9Ohf/eUBBpdHSPTtJxT3UCFVIn32GS
   Eic/2hDTMsew8LSoEnh1itfnW4hx2WAfEttS1Z1L8lp/oSlL8+dHFKtta
   XTA6u+FbmfDTxxtg18y75oGS58UyQbApy26oavxlKUUh95bSdfV7st651
   gIkjGoDc3nZsR2W2V0xJOz8uIUASRylX0Lgd2T/bS1ggKa/EwNTt6S5bZ
   E95tSDDWWAivAuDMv7EBRnEDEvIElqGm1KGa9pSH/zlXVo5VfGX/dXNKE
   08/lVyHxc32aO1s0fxNWztUub8L6qtLbkWP55oZ5CFOWTKuJxLFwYx7Pd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20564410"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20564410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:52:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913749612"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913749612"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:52:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdXqw-00000006wMT-4AQU;
	Fri, 23 Feb 2024 17:52:46 +0200
Date: Fri, 23 Feb 2024 17:52:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	marek.vasut@gmail.com
Subject: Re: [PATCH v2 0/4] of: automate of_node_put() - new approach to
 loops.
Message-ID: <Zdi_ToUofu62s5zT@smile.fi.intel.com>
References: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 12:44:28PM +0000, Jonathan Cameron wrote:
> The equivalent device_for_each_child_node_scoped() series for
> fwnode will be queued up in IIO for the merge window shortly as
> it has gathered sufficient tags. Hopefully the precdent set there
> for the approach will reassure people that instantiating the
> child variable inside the macro definition is the best approach.
> https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/
> 
> v2: Andy suggested most of the original converted set should move to
>     generic fwnode / property.h handling.  Within IIO that was
>     a reasonable observation given we've been trying to move away from
>     firmware specific handling for some time. Patches making that change
>     to appropriate drivers posted.
>     As we discussed there are cases which are not suitable for such
>     conversion and this infrastructure still provides clear benefits
>     for them.

>   iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()

Is this the only one so far? Or do we have more outside of IIO?

I'm fine with the code if OF maintainers think it's useful.
My concern is to make as many as possible drivers to be converted to
use fwnode instead of OF one.

-- 
With Best Regards,
Andy Shevchenko



