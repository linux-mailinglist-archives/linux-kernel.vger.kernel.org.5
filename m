Return-Path: <linux-kernel+bounces-92748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60924872573
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D1001C25C6C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9185714F64;
	Tue,  5 Mar 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TqFm1ymO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F4D14A9D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 17:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709658843; cv=none; b=baWTovx+8fV2hALNw294rSDdrsf68jfbwAOq+7R5JtxygF92HBRM74ebYrh+7lkiIECvUKx6oPmhoyLkhr8aYGXuxbjkLDNWSKhPyXM1ZnkEFyT7hw5+KjFgLUv0M3yTaEPjGAUCZ0IM5QgrxRxp+oyDdqWKzS9Oe/SlcF+rkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709658843; c=relaxed/simple;
	bh=i1rjIY6XPCzRwJsY3wJYbbVmJRi1zPCWMcW2neRxOVg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZbicVQnBzxCbXJEbBnsicLZR2zXnzxekZaFzeen2ex7QTSHM9SovYEfV81r1PVgbOuU5mSbWoMnnpk3QWiVbG0fXyydUXvBVgjKjyEfMAkdtHyeUtqK/QoPI+52/pZQYub76IH+5uHibk3uYo36dCEojtAys5LAVJ8Avtl1Qa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TqFm1ymO; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709658843; x=1741194843;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=i1rjIY6XPCzRwJsY3wJYbbVmJRi1zPCWMcW2neRxOVg=;
  b=TqFm1ymOm+pofhEKdpm6MqgWHiDstfJ5mnUkbwkbm3txzyoSWODHWtCO
   sTq9IEMdJQROhTKE5JzHxo7vT/bhQecKrcUauZDIHtqrxw/WXL//69eGE
   f00jAWscZaO9UFzVKU0D9DCHkV9Wa5oXuuqKDmEoLC1HCWyOyDDl6hNCZ
   u8VUp2f6/jsFHZYghifQ2RVOa/pNVXtPiFdi53A3G4abPrZeluotB6Zz1
   QKulDozZ+Y2uy+AOWlgJGxr276/utIdXrdaKf36EWerhS0PhCMhrX00vG
   eeKJFdQ5YMZ2dBGBqzAayeH2ZQBW9/gaVQVJNYuUyhrSUvYX4/A7y0jp7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4089068"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4089068"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:14:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914145609"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="914145609"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 09:13:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rhYMX-0000000A2iS-0AWb;
	Tue, 05 Mar 2024 19:13:57 +0200
Date: Tue, 5 Mar 2024 19:13:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Wentong Wu <wentong.wu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 3/3] mei: vsc: Assign pinfo fields in variable
 declaration
Message-ID: <ZedS1F3jHvrWISF_@smile.fi.intel.com>
References: <20240219195807.517742-1-sakari.ailus@linux.intel.com>
 <20240219195807.517742-4-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219195807.517742-4-sakari.ailus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 19, 2024 at 09:58:07PM +0200, Sakari Ailus wrote:
> Assign all possible fields of pinfo in variable declaration, instead of
> just zeroing it there.

..

Side note: Can we actually make acpi_dev_has_children() public and use here
instead of open coding?

-- 
With Best Regards,
Andy Shevchenko



