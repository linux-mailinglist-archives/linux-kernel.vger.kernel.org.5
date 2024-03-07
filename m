Return-Path: <linux-kernel+bounces-95670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3241C875113
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E06D628628D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFED12D754;
	Thu,  7 Mar 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7ElYfZj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B611B128821;
	Thu,  7 Mar 2024 13:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709819891; cv=none; b=ds2fMP4p7z72lfZglrNhaGC0nEmDVL61jEeCwfbQEzXC3ipOB6hW3+5rDzaAOCit5CyVSTf9+4wUm+xxO5Tnr0L2KL4HNFvHr6pfu0lHkZxX2oV9v7FNeFkR23aT2V5wZMzK+E1JYeQn3GoLvg2fJbqBumqNhI8OSoK7Ws7GSSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709819891; c=relaxed/simple;
	bh=eMTx+DDTs5BMDq8+Z375eLVfCAt94mgr69f3RfsGG5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQHECgomra34Owt3YrX6oKKynp5RIzJGjzBWvKR/rqvdVZVGDsp4EydM70d/fACU3I456mW4gzAzQAJ91+O7kUigmXFKF8hGaeCZ3iJzU3UOnYvcdM8LYGH8IY0eT+wy8sW3BfBJHZbhFbHLXaf6cqnaQLungTG0+TULNCp0p74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7ElYfZj; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709819890; x=1741355890;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eMTx+DDTs5BMDq8+Z375eLVfCAt94mgr69f3RfsGG5g=;
  b=l7ElYfZjmdBjJryItd5wuriNFPEp5xZ2C+38IKSLwW0jyTtc3QQxPG5X
   6ZZESYkRFTSCeEqnAmAROuZKkNRhcpsYgFxdHIgtbwBn5K1Ie0GO7WIZq
   hrNSX/YhZo/vzj8shXbfnM+/sDV7I84RVkjB5PG/rbKVzsgVvA/iCvRXc
   C9oDn/6FhWUZgvbB7TC9H+2ujl1TDuGU46iw/A5d4Rx620T+PR9Vkw97B
   9xooikDWRfFI51HxIQsXHhIq0HMChTmjS0XJj2+7wCfMWpOWLt6quFROH
   JY5d8KX+spHJJ4ivXj9e0ijT3szepY6xcEllc6TYAjkzwkfGzpyCiv4J7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="15058410"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15058410"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:58:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="914214808"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="914214808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 05:58:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riEG4-0000000AZy9-1xIO;
	Thu, 07 Mar 2024 15:58:04 +0200
Date: Thu, 7 Mar 2024 15:58:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v1 1/1] s390/cio: Use while (i--) pattern to clean up
Message-ID: <ZenH7IojjFOtIMwX@smile.fi.intel.com>
References: <20240222134501.236871-1-andriy.shevchenko@linux.intel.com>
 <ZeXeBr5z8TrLbuCI@smile.fi.intel.com>
 <20240307135442.33873-B-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307135442.33873-B-hca@linux.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 02:54:42PM +0100, Heiko Carstens wrote:
> On Mon, Mar 04, 2024 at 04:43:18PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 22, 2024 at 03:45:01PM +0200, Andy Shevchenko wrote:
> > > Use more natural while (i--) patter to clean up allocated resources.
> > 
> > Any comments?
> 
> It is up to Vineeth and Peter to decide what to do with this.
> 
> But in general I'm not a fan of such patches. It depends on what people
> prefer, and you can send literally thousands of similar patches where the
> code looks "more natural" afterwards.

I understand your point, however, the lesser characters to parse, the better
readability is (usually). At least the proposed pattern is mainly used in
the kernel (you may grep for different patterns). It also has an educational
effect in case somebody takes this code as an example (for whatever reason).
With this we will show that *in practice* kernel prefers this style over
others.

-- 
With Best Regards,
Andy Shevchenko



