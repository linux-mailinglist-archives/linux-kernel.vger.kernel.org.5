Return-Path: <linux-kernel+bounces-97099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EEF876585
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C90111C21825
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB61D38387;
	Fri,  8 Mar 2024 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ISO+WFMH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448238389;
	Fri,  8 Mar 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905404; cv=none; b=dD9B5LaC57leccY1X0zaAkx28+QHoOp11U2oyg6xRtUA0BAuhtn2I8ObZb1viQHXZ3fCmQG/iiwbZi1ReMk94hLl4RqGHRdodTnIZFSL5BDByB7xpovtkCrO5rFZlsWg+2eUR5GgO9R33Abh9qRaltr9jTHysd8PenNVs4Ym53U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905404; c=relaxed/simple;
	bh=SzLNVnFsiFEmEu5RPvzvTKKqcsB1lkgqALEjkxSE3lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3I6cL09l7KeAih3vcJsxYzOqnKbfxWER8652jNXs9p3XHUbhFe0RGjQVp+o17ER68iM7VYnZDQ05e7nq8vthwJ4HTdTa4UyXlRJAnIq6tQp7AaKTgLDk7seX92+br3W1bt/GqEllGXM+8W5P6Fkf+uat1lUhPsVZvlc7mnA/Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ISO+WFMH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709905402; x=1741441402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzLNVnFsiFEmEu5RPvzvTKKqcsB1lkgqALEjkxSE3lw=;
  b=ISO+WFMHegAEe+FpfktAu3jih1kYCH69NraaNa2vH/gy07/y8aX50xtX
   O+UUcaKp4rIwNCIdExuQjrn4Aef3Nw8QVBXW+DvICHC33SrvRaVph+vRw
   m6S6SFMKJweYMvnTFgqXWZ6LSP6JncZ5dUQSDAhu1sqjlMlPH8NZeauTS
   EZxrsPX+RxP45Fu8owRU1iM7AmvgA8XtaIYmZkJcpqgcXV1StQt3bnzuv
   am4XI/zTE3sqDSB/ZwBkXNu+MV6LYj4pqt+Y+se393TL6DonV0Sht0W2M
   bjze6txKw/yZrMqpOxqEj4QBl5S5qqokKxxVGed1x8rwOlRs9YCHdgh1J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="4494109"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="4494109"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:43:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914246903"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914246903"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 05:43:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riaVG-0000000Aqv2-4Ben;
	Fri, 08 Mar 2024 15:43:15 +0200
Date: Fri, 8 Mar 2024 15:43:14 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Howard Yen <howardyen@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, mathias.nyman@intel.com,
	hch@lst.de, m.szyprowski@samsung.com, robin.murphy@arm.com,
	petr.tesarik.ext@huawei.com, broonie@kernel.org, james@equiv.tech,
	james.clark@arm.com, masahiroy@kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	iommu@lists.linux.dev
Subject: Re: [PATCH v4 2/2] usb: host: xhci-plat: add support for multi
 memory regions
Message-ID: <ZesV8iKdf1tQQtXu@smile.fi.intel.com>
References: <20240308095320.1961469-1-howardyen@google.com>
 <20240308095320.1961469-3-howardyen@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308095320.1961469-3-howardyen@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 09:53:20AM +0000, Howard Yen wrote:
> The reason why it needs multiple regions is that in my system there is
> an always-on subsystem which includes a small size memory, and several
> functions need to run and occupy the memory from the small memory if
> they need to run on the always-on subsystem. These functions must
> allocate the memory from the small memory region, so that they can get
> benefit from the always-on subsystem. So the small memory is split for
> multiple functions which are satisfied with their generic use cases.
> But in specific use cases, like USB3 devices which support the stream
> trasnsfer or multiple devices connect to the host, they required more
> memory than their pre-allocated memory region, so I tried to propose
> this patch to give it the ability to get the memory from the other
> larger memory to solve the issue.

..

> +	count = of_property_count_elems_of_size(sysdev->of_node, "memory-region",
> +						sizeof(u32));

Open coded of_property_count_u32_elems().

-- 
With Best Regards,
Andy Shevchenko



