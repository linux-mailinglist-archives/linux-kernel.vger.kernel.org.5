Return-Path: <linux-kernel+bounces-61707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D838851594
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2DA1F22D8C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032633E48E;
	Mon, 12 Feb 2024 13:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AT/bQ28F"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500113E483
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707745021; cv=none; b=UwOAIBGGxzzVXHr3BK2AeOcmy3SWKmH53o6QdZ742GXrRWg8GW+HX7AaN14TO1pwZNgP5x1ZHqkqlQeeGU1gY4VasKvX70ZokQbPGvyVOTBzkPPZswWrEb08rhzepJg+XwTVXukeQB3+UKduFWNo+KnwEoySJ3iynOtigIugYC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707745021; c=relaxed/simple;
	bh=/1gQpCmbof5JoYEDBIJ7R4EezJlCr0yE/wJqWblGEoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tla4fJnCQJYoJuWg6BVmyhLGy/XwQRopDlyvFIbet7iO5gOE2pLhhaAGyRx51XiUIdWrZtXXbIMo4gcKOPg/Njm8rTQ/O8XHA3vlWFe5eurFgRcaiQXJ32WuLNTKUbNPiFavZP3W9ZrmI4SM7kyW/4NTil36kFyD8hRN0U3FjEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AT/bQ28F; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707745020; x=1739281020;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/1gQpCmbof5JoYEDBIJ7R4EezJlCr0yE/wJqWblGEoc=;
  b=AT/bQ28FZMgiSS0JJde11ma488VtRJGE/zgGHc+buGXmCETOFWWFSqzk
   5ekfRLl0zqgHhSDhsw0rYIdT/54NZOb5tZOdFBJpYOj9lveXaqlmdo06h
   HSXmvcFQ4QwSep2A8cvH/YAG//oomWJcrMaZiHWUjVjX6vgIME71opk2T
   K5vJJtO6Q3ocMcYLBmx5cdhjOMzq0OYM6ba5Ly+T4HQgnrA6uIW/GcGxq
   c50ceNAWQrkoqhtoaecZ2JZ8s09jCJYnMFPV42F2rB88rM0PJbF2P2Xyi
   ykpNr6xPTsvZpoFpqlIZrv+9XmsIlUJt5ITJ7kpg3Lw1TUl9ittTsYdNO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="19226806"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="19226806"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:36:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911483801"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="911483801"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 05:36:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZWUP-00000003uL4-1uJR;
	Mon, 12 Feb 2024 15:36:53 +0200
Date: Mon, 12 Feb 2024 15:36:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/3] auxdisplay: Move cfag12864b.h to the subsystem
 folder
Message-ID: <Zcoe9axtLXxB7Jeo@smile.fi.intel.com>
References: <20240212132515.2660837-2-andriy.shevchenko@linux.intel.com>
 <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212132515.2660837-4-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 03:23:54PM +0200, Andy Shevchenko wrote:
> There is no users outside of auxdisplay subsystem for the cfag12864b.h.
> Move include/linux/cfag12864b.h to drivers/auxdisplay.

..

>  F:	drivers/auxdisplay/cfag12864b.c
> -F:	include/linux/cfag12864b.h
>  
>  CFAG12864BFB LCD FRAMEBUFFER DRIVER
>  M:	Miguel Ojeda <ojeda@kernel.org>
>  S:	Maintained
>  F:	drivers/auxdisplay/cfag12864bfb.c
> -F:	include/linux/cfag12864b.h

Should be replaced. Done locally.

-- 
With Best Regards,
Andy Shevchenko



