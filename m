Return-Path: <linux-kernel+bounces-78589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 742CB86156F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A2AB284000
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBEA82868;
	Fri, 23 Feb 2024 15:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OMWOHYEF"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B5182866;
	Fri, 23 Feb 2024 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708701765; cv=none; b=IYdarCB8Dnk00cnlokk8CgdRFNsSAofgB/NFihepOmDQT7VZ5ZRX28dIgu0swN7JBquZelcxcuidm//NoXtEL7T09b1Ggw3xnkTtG6vqVtSYRBgKUuP0R3A5RwnedVt3Pjwh2C1qlUch2psQ4DcCzgNffxN2kbCNZZe+RXqU4rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708701765; c=relaxed/simple;
	bh=+vEja7fkd2ePerHSh4nIvBRBa2xYfgAtNc0j/2BupJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBxYDIlNvyhOTCNoshuymv/LNdRJNVzkD+Uqydjmgg6YekaMSEWVmW6J4yJhKJNv7035zpL95glqhTN9Ov0CChtJ4MDAi967dyjyPjGAXFEBN6ToxzvKRd7S2gVTAZxXwmZwKTESDS5mobUAr0IEJyIog3ZY/5oHnTij2EpE0zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OMWOHYEF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708701748; x=1740237748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+vEja7fkd2ePerHSh4nIvBRBa2xYfgAtNc0j/2BupJM=;
  b=OMWOHYEFLuiztdxAzzndo3MYSzjv1AOfeS0zYVp9jmJ6zD2Jo45Be3zR
   naV2v/J8TAjip/bOv4wBBgbWdNeaOObYYnDGK/eEneQlBEsIz21SsAIYD
   MSkTG9i5Q35h5GGUFRAXqCZI3hUZ6RBeDSV3bHr+K0ajpai+QxMGcbAFi
   2Wc736l/F9WA79lweBOIe9MHbcrSlES5PJIjUaCrucWdgccjDpkBARfCz
   Bi43y0yQres7pU90RT+xVU+FiPKhXvzUO5eESsz0jN/W9FdEYew2SX8/B
   +QguQdQ1AGSHjJOl60ILPUL6IiLqa5r5fs3TMBtPp/HxXqgHADqRXz/wg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6837700"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6837700"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:22:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913748909"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913748909"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:22:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdXNU-00000006vyb-3xlJ;
	Fri, 23 Feb 2024 17:22:20 +0200
Date: Fri, 23 Feb 2024 17:22:20 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v1 1/1] device property: Move enum dev_dma_attr to
 fwnode.h
Message-ID: <Zdi4LEUvQOVMZRFZ@smile.fi.intel.com>
References: <20240220144105.2316632-1-andriy.shevchenko@linux.intel.com>
 <ZdWqEnxlfy_SbE40@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdWqEnxlfy_SbE40@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 07:45:22AM +0000, Sakari Ailus wrote:
> On Tue, Feb 20, 2024 at 04:41:05PM +0200, Andy Shevchenko wrote:
> > The struct fwnode_operations defines one of the callback to return
> > enum dev_dma_attr. But this currently is defined in property.h.
> > Move it to the correct location.
> > 
> > Fixes: 8c756a0a2de1 ("device property: Convert device_{dma_supported,get_dma_attr} to fwnode")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you, I will send it as a part of the series (v2).

-- 
With Best Regards,
Andy Shevchenko



