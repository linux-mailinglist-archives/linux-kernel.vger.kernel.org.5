Return-Path: <linux-kernel+bounces-88669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B83486E50C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:11:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A431A1C209C8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 16:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E46270CC4;
	Fri,  1 Mar 2024 16:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BIU4xa9Q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20B047F51;
	Fri,  1 Mar 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709309461; cv=none; b=sP/rl/xaExZMYvQInJ/lgivkDeHVgl0XhwxlHVuHYb7V3ZCSLfD3KSgKNMPjwq/iODbvJEHggMitoyiJ9i3BPhAQCsM/W8ALDVv2jS7Bh5/IvTPJ5jALJ64TlpT/5Orv1HdYvoKGC7+6cq+VCv6SqYn7Y4Nt3fgy5uCrBWX+1mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709309461; c=relaxed/simple;
	bh=4UlzlQnuaUuNI0r77fMlqJ+SG0x9lL2jodQkvrashRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B4O/S0tu+HMA+ODEeIJK4+1uikWm6SqqWEUAFSQTk28U6jLu6Ow+0P0MPwUDgIKeRqnGOrdL736SKAzpKgR4Gj47Sn16xlPwtWFsaGuOEYsFh08bbUL9WxkX5zDNiNY1vu8lst46xK3QhVJU+efziX9LwOZCMb4fQtNCf2J8xG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BIU4xa9Q; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709309459; x=1740845459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4UlzlQnuaUuNI0r77fMlqJ+SG0x9lL2jodQkvrashRc=;
  b=BIU4xa9QokP5Guie1c+gOIS1kok6z5pk7aXktwO4R5MHi5HC58EyildU
   kUwMNsdM4mY1sOcnbp8MNtpiGgqxVq4DLqTi4GHdSGBr0iGw8IO36Jc1Y
   uo4xDed3Xuaz6hdwyS0Qn1Bo/OKRMkGjMc4by4Wy1zvmhQDNBAn4ZSbB4
   BNnsObU17qbQIQqBcdgXZMgeH+f/DIQTQrOoyUnvmDC5jJPbi2PW/Srcp
   AKYgHhQIFIoLX3M7VXGCgsKb8nX/QNcMQrSXP46r143bIffhQ8bKnKfM/
   7+K6ivl42tXbYQNxnaRTyopgM2t1nwB0tK63+HXUBzZ8gTDwYfMHR9gEr
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="15263476"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="15263476"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 08:10:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="914019332"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="914019332"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 08:10:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rg5TJ-0000000900U-2OVm;
	Fri, 01 Mar 2024 18:10:53 +0200
Date: Fri, 1 Mar 2024 18:10:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v1 1/1] lib/string_helpers: Add flags param to
 string_get_size()
Message-ID: <ZeH-DelIspVMWPv1@smile.fi.intel.com>
References: <20240229205345.93902-1-andriy.shevchenko@linux.intel.com>
 <170924355200.1509550.2313379734413200100.b4-ty@chromium.org>
 <sdjfagrzk5p736wzeqdfhzxkivtg3rnhhtt3rh672fbuzxc7ya@icgcqv2d3cr7>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sdjfagrzk5p736wzeqdfhzxkivtg3rnhhtt3rh672fbuzxc7ya@icgcqv2d3cr7>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 04:54:30PM -0500, Kent Overstreet wrote:
> On Thu, Feb 29, 2024 at 01:52:34PM -0800, Kees Cook wrote:
> > On Thu, 29 Feb 2024 22:52:30 +0200, Andy Shevchenko wrote:
> > > The new flags parameter allows controlling
> > >  - Whether or not the units suffix is separated by a space, for
> > >    compatibility with sort -h
> > >  - Whether or not to append a B suffix - we're not always printing
> > >    bytes.
> > 
> > I cleaned up the Co-developed-by/S-o-b and applied to for-next/hardening, thanks!
> 
> thanks Kees!

Thank you, folks, glad we close this.

-- 
With Best Regards,
Andy Shevchenko



