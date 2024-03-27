Return-Path: <linux-kernel+bounces-121361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FBFA88E6BB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 922982C9CE1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B5E13B5AB;
	Wed, 27 Mar 2024 13:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vx8pGiyn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4190C13B5A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545903; cv=none; b=nEyqFSXlXpKVSzeUq/xRszeAu1oQDxKX6WtfGJg2xWWYmTSIwxM+6Yh11w+MXsKdjSzALFPVqGAMGZqLNYUxuubLTzwO5Iysok531OEOdDloe/J6J8cfo2oD78hU6RgPlqOG0yfI/T2CsYxJQ4GmogMIyBnqutyzbUoVJ2OlMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545903; c=relaxed/simple;
	bh=i9F5RVjjdXSXnNca9EoASKUAH+ZHNQI+HhjNJfYHmmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpEjd7Wb0d1UbEFH1MqgDTskT7OUQPoOdD0b+N/teb/ym/BT3VaJ0+7pd2H8GGJb/AVSANqe8OeQVTtmC6D790BG2c4twwKQMO3PGY1/aSrskX2o2ZzxsU/2nKitRV3h1cTVx17mgsPr8cTPw3Ah5L7ht+NOEhSrfIxpzbrzUaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vx8pGiyn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711545902; x=1743081902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i9F5RVjjdXSXnNca9EoASKUAH+ZHNQI+HhjNJfYHmmk=;
  b=Vx8pGiynyfInpT8VDE2dyWcfly7nxQWaX/G52yibvADrFBnuJIzdmLqJ
   uwAZ6tvQpKH2Bq61DbR153Bzz4+568orAk8LN2P+fqwltHrZzzcb1o0se
   zAsIj+Y12s9I83KWWN5JG5/ApRfzUHPrkUC0MvuQ/YcmFOtUbsdIyDItp
   Bo+gkNkJ2GDULFBOyfVWkGrnM4/z1M7jK5Jvre5/crN4Z57FRKz/IILi+
   xL0+Ig7KaRPXL9EcHjuOYdZuiWivvcUiyGnk8AxhMFCK61T/vN879yACf
   rhsjxa/RYIUeG1mTS8vZZtSmVMMqpIswCsiTX6+lvmw9/MGdhvIzwmz5l
   w==;
X-CSE-ConnectionGUID: Zz9sQcM2S6iNq5oOTZLWZw==
X-CSE-MsgGUID: kJdOSVcjSkG/lkGKCUnTEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6583521"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="6583521"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="914913226"
X-IronPort-AV: E=Sophos;i="6.07,158,1708416000"; 
   d="scan'208";a="914913226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 06:25:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rpTH0-0000000Gdvg-0K2t;
	Wed, 27 Mar 2024 15:24:58 +0200
Date: Wed, 27 Mar 2024 15:24:57 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Lee Jones <lee@kernel.org>
Cc: Mateusz K <mateusz.kaduk@gmail.com>, Bjorn Helgaas <helgaas@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch over to MSI interrupts
Message-ID: <ZgQeKfsFy9i0h4Kj@smile.fi.intel.com>
References: <20240312165905.1764507-1-andriy.shevchenko@linux.intel.com>
 <20240325211915.GA1449994@bhelgaas>
 <CAPf=4Rc2vQrWqcs=-ND3iOZFJyKE7FdPoqU9w6DKjoSaJo6KaQ@mail.gmail.com>
 <ZgLefFQanbq-ozKM@smile.fi.intel.com>
 <ZgLooJa1JVKEMOtf@smile.fi.intel.com>
 <20240327131711.GR13211@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327131711.GR13211@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 27, 2024 at 01:17:11PM +0000, Lee Jones wrote:
> On Tue, 26 Mar 2024, Andy Shevchenko wrote:
> > On Tue, Mar 26, 2024 at 04:41:01PM +0200, Andy Shevchenko wrote:

..

> > Hold on, but IIUC this is the report about new hardware that never had
> > a support by Linux before.
> 
> So a revert is no longer required?

No, it seems an old issue unrelated to this patch.


-- 
With Best Regards,
Andy Shevchenko



