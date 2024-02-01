Return-Path: <linux-kernel+bounces-48058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60F08456C0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579D11F28312
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE7315D5D2;
	Thu,  1 Feb 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PnSlo+3r"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7715B984;
	Thu,  1 Feb 2024 12:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706788987; cv=none; b=GdhUk8m+cyqyYmk5EUcaRcWwwKc3OCpqJYPsBUTou3dzY2SZINsP6mr1F7dGsI/iJdenlmf6pXxX2nscup2QctILg/a3DaEiMOPW7GytmFuSTinsXU0OiF8PrxAkM9IIP05/X59b8IaIZbmIMmiwAyhYPqVCYpW4SHSP4jC+KRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706788987; c=relaxed/simple;
	bh=pJuSO9d6uzAqQ3VtPCr5pnKI1a/DU5bzRyIqtixtObA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j6Pd8+DKPLhE532e9iHEvB2YCEXH5I+5cbQcwissGkDsNGTq9EThZ+pdAyXV6aT5K/tGdflMsOLNP3/7EZ9M9IjuHWFWDbiheLVnfxVqBUD9TLR8kC4r71sv5yYgg+w36V7tflZV1ebAAzDXXUwffmXjQGd/SGZLyKFR6R3lJ8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PnSlo+3r; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706788986; x=1738324986;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pJuSO9d6uzAqQ3VtPCr5pnKI1a/DU5bzRyIqtixtObA=;
  b=PnSlo+3redwfuu//uLdEuT0r9vJ7dVxtOcOkcz6TzSjtqYR7+A542oEh
   xD5WbMPS2GWrAkLcMkr5O+l2a1K7F+tFpNHb8BnqjADDaF9MBWbKBiCsr
   KLvUki1YwdDufleyKhvIKQLBXHHQdPfbyTcYPkjLPlRVqRfTOR7M0Aby7
   EDGBQTQWIAi1szp7KJKFxh+FwN2EABNw1nRIiTZSKDuEMESgfNBOZ6xG0
   yV2pru2bXR1mtOAM34QDET8nh/oAYhBseMFBW9f2b3jAAOYQcpbGFAa3K
   14xJvwJ8GmWpaAUZqG2KMCTYou6FtwqMy8DsVoiyq0PNc7BxPd/j41val
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="17409704"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="17409704"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="961902005"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="961902005"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVV7Q-00000000ofZ-1VUT;
	Thu, 01 Feb 2024 13:20:32 +0200
Date: Thu, 1 Feb 2024 13:20:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
Message-ID: <Zbt-fw8eUrQzBjX9@smile.fi.intel.com>
References: <20240128160542.178315-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128160542.178315-1-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 28, 2024 at 04:05:37PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> +CC includes peopleinterested in property.h equivalents to minimize
> duplication of discussion.  Outcome of this discussion will affect:
> https://lore.kernel.org/all/20240114172009.179893-1-jic23@kernel.org/
> [PATCH 00/13] device property / IIO: Use cleanup.h magic for fwnode_handle_put() handling.
> 
> In discussion of previous approach with Rob Herring we talked about various
> ways to avoid a disconnect between the declaration of the __free(device_node)
> and the first non NULL assignment. Making this connection clear is useful for 2
> reasons:
> 1) Avoids out of order cleanup with respect to other cleanup.h usage.
> 2) Avoids disconnect between how cleanup is to be done and how the reference
>    was acquired in the first place.
> 
> https://lore.kernel.org/all/20240117194743.GA2888190-robh@kernel.org/
> 
> The options we discussed are:
> 
> 1) Ignore this issue and merge original set.
> 
> 2) Always put the declaration just before the for loop and don't set it NULL.
> 
> {
> 	int ret;
> 
> 	ret = ... and other fun code.
> 
> 	struct device_node *child __free(device_node);
> 	for_each_child_of_node(np, child) {
> 	}
> }
> 
> This works but careful review is needed to ensure that this unusual pattern is
> followed.  We don't set it to NULL as the loop will do that anyway if there are
> no child nodes, or the loop finishes without an early break or return.
> 
> 3) Introduced the pointer to auto put device_node only within the
>    for loop scope.
> 
> +#define for_each_child_of_node_scoped(parent, child) \
> +	for (struct device_node *child __free(device_node) =		\
> +	     of_get_next_child(parent, NULL);				\
> +	     child != NULL;						\

Just

	     child;							\

> +	     child = of_get_next_available_child(parent, child))
> +
> 
> This series is presenting option 3.  I only implemented this loop out of
> all the similar ones and it is only compile tested.
> 
> Disadvantage Rob raised is that it isn't obvious this macro will instantiate
> a struct device_node *child.  I can't see a way around that other than option 2
> above, but all suggestions welcome.  Note that if a conversion leaves an
> 'external' struct device_node *child variable, in many cases the compiler
> will catch that as an unused variable. We don't currently run shaddow
> variable detection in normal kernel builds, but that could also be used
> to catch such bugs.

-- 
With Best Regards,
Andy Shevchenko



