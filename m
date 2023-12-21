Return-Path: <linux-kernel+bounces-8874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC70381BD8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA401F22CE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8716350F;
	Thu, 21 Dec 2023 17:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z4DkLeUF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7E562814
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 17:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703180753; x=1734716753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tFf9EJ5PzOxrBSz+mhHyS8wwHlo6vAQBCTWgJ7+dwIA=;
  b=Z4DkLeUF7aZyG/mVBJjHoAixg0nJUEiXpiUAjskt/FZt+4sFuRmhYW6z
   eKFkLaJ9egO701GWo2Q6yCQAto6zvyxcOstDgVYrWFmoWJQ3ppWcHXPLs
   VJiQk1tL/q+y5pAi7GXmxF4Kygjr3r7Fhu0xOLTIvoJgaZowH8Bp8WVG3
   xWNczGhSH048CmtHVPFJPHflvWoeG+BLAXnWsqMnZ2yHSru5QOpCd7lru
   g755uRhgP974GajI6h2Gr0p4VhdBNKpFw7Xad+LKO8rQp5UeTHmu+1Ht/
   MDV56MOg4IqTPYHYBvjgfLiEl1xm+2mPKzcIzQuwAD1k7NZR1A93zIk5a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="395737629"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="395737629"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 09:45:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="780266908"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="780266908"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 09:45:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGN7E-00000007ueD-1335;
	Thu, 21 Dec 2023 19:45:48 +0200
Date: Thu, 21 Dec 2023 19:45:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aleksandrs Vinarskis <alex.vinarskis@gmail.com>
Cc: Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mfd: intel-lpss: Switch to generalized quirk table
Message-ID: <ZYR5y4tLG9cXspvB@smile.fi.intel.com>
References: <20231221171113.35714-1-alex.vinarskis@gmail.com>
 <ZYR5bh596slWaqjF@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYR5bh596slWaqjF@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 07:44:14PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 21, 2023 at 06:11:13PM +0100, Aleksandrs Vinarskis wrote:

...

> > +static const struct pci_device_id quirk_ids[] = {
> >  	/* Microsoft Surface Go (version 1) I2C4 */
> > -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182), },
> > +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1182),
> > +		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS },
> >  	/* Microsoft Surface Go 2 I2C4 */
> > -	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237), },
> > +	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
> > +		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS },
> >  	{ }
> >  };
> 
> I would suggest to look at the existing style, as I also in doubts on the
> above. Perhaps the following is more common in MFD subsystem?
> 
> 	{
> 		PCI_DEVICE_SUB(PCI_VENDOR_ID_INTEL, 0x9d64, 0x152d, 0x1237),
> 		.driver_data = QUIRK_IGNORE_RESOURCE_CONFLICTS

Ah, and in this form we usually leave trailing comma as we don't know
the future (possible, but quite unlikely, new fields in the structure).

> 	},

-- 
With Best Regards,
Andy Shevchenko



