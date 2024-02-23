Return-Path: <linux-kernel+bounces-78609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76EAE8615D0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2A081C23B00
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBAF82864;
	Fri, 23 Feb 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WPj1TH/Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC894C79;
	Fri, 23 Feb 2024 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702236; cv=none; b=gAvuW4lZZAKbgP9i0sj1tl5sKci3O95mzCF6HzhnWeSBZc4MXeLbWwO7VZc8VvWmCKGpnh3G8dSm7V77kpzvcnamhgS+lon/WZ2UOBaB9DukYN2/yHkOxrbw8KbWbxHW+7plAqB8HLx35+8GmQ+0eWA33buYzX5ec/CZh0f1FdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702236; c=relaxed/simple;
	bh=SscjDKDY1ImQ7OQWqm3w1O3XyUw8ttkCiSdhPzJYFUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eyZa4S+WrE/p+3PICPGiN3BigrElz/mCntYrxuvu+A1eyYtjZW9xLT7TnxwaQe3RuDRWIXeOw3+ikJY9VnI6zGdZKCrPHM/H2MOaCnO150hY1Gn91SZRSRhLGxdCzqX3HDS3+UWlxerSo0YM3RMIF4H71MrZf8f6kqafnIjMlsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WPj1TH/Q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708702235; x=1740238235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SscjDKDY1ImQ7OQWqm3w1O3XyUw8ttkCiSdhPzJYFUA=;
  b=WPj1TH/QwCIpHQxiP+mp5U/BrOfzJvqNc02fFRWvyVq5v8/9KShXZEhp
   0QDi49ZBsTDRHiCQ5Hxy0ZCyv00TyyU0Gdfu6F2NxLKoIEqe/XKbQvFHR
   EmZVZo9a44S67h65U0Js3xrmCCeLNEjVgojHRiEXOu9xvndoVn3Ltn7Jz
   NuFnKiH4fMOZntKyPz7NbFND98D3dP3YDg1bGdRlsfq3a9XkrEcBLiZin
   +qZXueMSh2YhPv/ohioKTssbTCzwVfGQ1QKrRdMTj/JIRLGo4siy2CrLJ
   UcIuf6+MW/x8LAlZVoawCwkIJOnN6iOBvGJMB1DNjHu80J07PXpGUuiDy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20562487"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20562487"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:30:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913749090"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913749090"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:30:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdXVN-00000006w5C-0cpj;
	Fri, 23 Feb 2024 17:30:29 +0200
Date: Fri, 23 Feb 2024 17:30:28 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH v1 1/1] device property: Don't use "proxy" headers
Message-ID: <Zdi6FE1ebYT0stma@smile.fi.intel.com>
References: <20240220161931.3091680-1-andriy.shevchenko@linux.intel.com>
 <ZdWq5vA29iB8MzNy@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdWq5vA29iB8MzNy@kekkonen.localdomain>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 21, 2024 at 07:48:54AM +0000, Sakari Ailus wrote:
> On Tue, Feb 20, 2024 at 06:18:50PM +0200, Andy Shevchenko wrote:
> > Update header inclusions to follow IWYU (Include What You Use)
> > principle.
> 
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Thank you, I will send it as a part of the series (v2).

-- 
With Best Regards,
Andy Shevchenko



