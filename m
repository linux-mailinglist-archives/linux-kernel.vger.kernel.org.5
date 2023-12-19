Return-Path: <linux-kernel+bounces-5444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024B0818ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63A12B227AE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CCAC1C296;
	Tue, 19 Dec 2023 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ab7e0gnE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF631C282
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702998196; x=1734534196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eeuvaI7PqKRcGy6DnfhPDe9faoaIogNRNFglMjWkyHI=;
  b=Ab7e0gnEtiK5ts8Vlik8J34GlZssIez8i6aIQ8RxTJsa5tdAuo6ur2ZX
   K/rQ+1fpykk2lggZAsmlzQMLE30kqXcuWWEDVYfX0f0PtXxHzi0o4qwPt
   /fL1x1KmvyeE/9748aNkX4+WY/UHPGmWk4hjAGrosus1GMujxpaLwUA3/
   XC5w5PyrGoFPE3PkEtQIcg8gVWWq0O5GaL5IkMnV5PFAS5gapKkTmGcFF
   lmGY+sSUNzYk4woPqv2d66eAXdgeNHP5CukxRaTMK6ZAjCW+0fFbqNTmD
   1Wvt/gLlIE0FOziZKSWSYqsrvwdayUQIGfcg2/ck/kllTKneet+uWR4ao
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="2765521"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="2765521"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:03:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="752184746"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="752184746"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 07:03:13 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rFbck-00000007I8S-3QZn;
	Tue, 19 Dec 2023 17:03:10 +0200
Date: Tue, 19 Dec 2023 17:03:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver core: bus: constantify subsys_register() calls
Message-ID: <ZYGwrrNH2EbB_mOM@smile.fi.intel.com>
References: <2023121908-grove-genetics-f8af@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023121908-grove-genetics-f8af@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Dec 19, 2023 at 02:15:09PM +0100, Greg Kroah-Hartman wrote:
> The functions subsys_register() and subsys_virtual_register() should be
> taking a constant pointer to a struct bus_type, as they do not actually
> modify anything in it, so fix up the function definitions to do so
> properly.
> 
> This also changes the pointer type in struct subsys_interface to be
> constant as well, as again, that's the proper signature of it.

And they don't return any pointers, so no room for a mistake, and
even less with this patch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



