Return-Path: <linux-kernel+bounces-108815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15161881063
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C08DD1F23561
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830723B785;
	Wed, 20 Mar 2024 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AzrlNqRv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2681DDD6;
	Wed, 20 Mar 2024 11:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932655; cv=none; b=FJzQxdpL6P763cAHuVFtBmdovePGHVQBdpQQ3fAqdQ882MQpCjqEG6G0M6kD7rToaBCuY6zSrtOwzWqGec1J9XPehAy0I9qRsD/gR4c6yc9N9ZZy9PcIGcSD8t/i6l+BGfbWWDMsqsXDdTQV3kBYn0YAMRk7CqNlzUvztWr04qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932655; c=relaxed/simple;
	bh=AEy77V2mGWIo+fuuC2A4nq0nYtIxhkMMJrARb6ySAwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReX3PHrF5wfQjnonTTPTQV+nlxQKVQigvaE0quEPzjKRAQmYvCJJTEqKpmtI1zG60mp8DshMuiQKMDsuZhtWkeH8jyPpCxcoOUSwaelbVDj6lAmvmOEfCklPS8sEUtVxThJb3roTe4j66cVg0n8/N00G3Cvx7atUSQCa5XULmqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AzrlNqRv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710932655; x=1742468655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AEy77V2mGWIo+fuuC2A4nq0nYtIxhkMMJrARb6ySAwM=;
  b=AzrlNqRvfuODqY28Gcyl5sAAagv3zDgDW8syDrtKMkmOpiBXJySrbGH+
   FBx/kYFhSAvaeZeueS4wEs/M7nzl7sRVMVafnhix2pLPQdW2GUHbr4jhs
   MJ+E+4kkLZNYgskdYfdRXwFuiFfcVMc0LT9tAJR1NEV27Mbp3rLkrDyYC
   cwaw9mOdlvErlqox3tj/P72KYqxO6QVEm/WhZtxNdqGUI6/VGp3Iacawy
   /4fmclV13wom4kzOPjFrT3USeXNKyvR075qvMxnnISRu7k2ezG0YJXiae
   ZEWFins+hhavBBIjeyNO/plk/1n1k1anVWhx94JYqUQNoHqBP2YD9+bUA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17295011"
X-IronPort-AV: E=Sophos;i="6.07,139,1708416000"; 
   d="scan'208";a="17295011"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914662914"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914662914"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:04:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtjs-0000000EY5E-0Cq0;
	Wed, 20 Mar 2024 13:04:08 +0200
Date: Wed, 20 Mar 2024 13:04:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: pressure: Generalize
 read_{temp/press/humid}() functions
Message-ID: <ZfrCp2gyVUW0LFg8@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240319002925.2121016-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 19, 2024 at 01:29:22AM +0100, Vasileios Amoiridis wrote:
> Add the coefficients for the IIO standard units and the return
> IIO value inside the chip_info structure.
> 
> Remove the calculations with the coefficients for the IIO unit
> compatibility from inside the read_{temp/press/humid}() functions

read_{temp,press,humid}()

> and move it to the general read_raw() function.
> 
> Execute the calculations with the coefficients inside the read_raw()
> oneshot capture function.
> 
> In this way, all the data for the calculation of the value are
> located in the chip_info structure of the respective sensor.

-- 
With Best Regards,
Andy Shevchenko



