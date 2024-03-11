Return-Path: <linux-kernel+bounces-98702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C49A877E21
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFD9BB2186A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0E38DDB;
	Mon, 11 Mar 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gLy0KsR0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FF12EB08;
	Mon, 11 Mar 2024 10:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153184; cv=none; b=QixV/se/3qVuXAksQDAM18o66+ZF2wr/6ENMaUenOkLBsBlpy2KoJbXbpTOG05gJPXVj77lUlzuZal4xaG3Cs5odbSAX01BvzHxXAcvDKBh30O3LdpG9Q962p04gKR5Ukh1vB/MHFt/s6oZJRZgJyIzl7kpXbIQNRajywWhWOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153184; c=relaxed/simple;
	bh=O/SXrdBYopt5uhXN1mub/4HnPPm5R0L/KVrThZ1ABas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P4thNpTPKxoM0HMLllH04sTvO7nU1JqxMs1X/9JXaKlU5lILYSN4KqWzghr0AZqivNpO/O4p1wjEXzIwh4irdbtlSRnUelmczbRwf9aWTdCfB7K0ktZjFRxloSZ6dzU/loDLdDNE1N5S1buNXhYSR+026GozIQ71U78AEoAskiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gLy0KsR0; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710153183; x=1741689183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O/SXrdBYopt5uhXN1mub/4HnPPm5R0L/KVrThZ1ABas=;
  b=gLy0KsR0w5lVB+v7AT8XrudBDz4KCPFVRi4gMkqO7zyqN5b3MWwLy+FM
   wDyqRvMAxjxzDhP227cc1SFLa0WA3gHfrFN+I7YyJTJR1iY20zVITTcT7
   hU6HQLfyM9eN1SmkSK6deR/OJvfel6e18Y+bmEIxGJBXKRli0KPgmLut2
   mo3vlObPHHr/Er2ci0pC7xmdzjel/iNKggCMS9Zh4YEHrkOsfCzShoidE
   XJ22G/TPIFx7qE6lhe0/hragk3Z//4yzG1iWivxpEyBgLOS2l9jF7DfTN
   Cl1aDgY9CnujkQdHmFKlQfI033f7es9fJw15baixMbZAtWGgPQwCprrDR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="7752795"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="7752795"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11009"; a="914355119"
X-IronPort-AV: E=Sophos;i="6.07,116,1708416000"; 
   d="scan'208";a="914355119"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 03:32:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rjcxi-0000000Batb-28H2;
	Mon, 11 Mar 2024 12:32:54 +0200
Date: Mon, 11 Mar 2024 12:32:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v5 0/2] Add support for multiple coherent memory regions
Message-ID: <Ze7d1rrZsQZdDVQH@smile.fi.intel.com>
References: <20240311094947.3738200-1-howardyen@google.com>
 <Ze7W3o67JLTKlLzR@smile.fi.intel.com>
 <CAJDAHvbRSm_UYgx0fE7o2dJqcBfBbcFR4DrnVydkwfxGo0O4Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJDAHvbRSm_UYgx0fE7o2dJqcBfBbcFR4DrnVydkwfxGo0O4Rg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 11, 2024 at 06:10:47PM +0800, Howard Yen wrote:
> On Mon, Mar 11, 2024 at 6:03 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Mar 11, 2024 at 09:49:45AM +0000, Howard Yen wrote:

..

> > > Changes in v5:
> > > - Fix build break.
> > > - Use of_property_count_u32_elems() instead of
> > >   of_property_count_elems_of_size().
> >
> > Have you tried to use --histogram diff algo?
> 
> Yes, I used the below command to create the patch v5.
> `git format-patch --cover-letter --histogram -v5 51b70ff55`

Thank you for confirming!

-- 
With Best Regards,
Andy Shevchenko



