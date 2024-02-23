Return-Path: <linux-kernel+bounces-78187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C950D860FF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 846A2285DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E96350B;
	Fri, 23 Feb 2024 10:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ii7AfXXi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75426405F2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708685858; cv=none; b=JbXnUUQKshjKP6xbMnZWDeOOXQePG5+8/IEG5iIRDVtsDc4Jdm50xHL/nx4hdq7tr7bpSxybo0+bgd3h0qtWaidlynYbL2m2DC7+SFXAuyaS5Ui6lcjmj62wcK3L+mwCfFENlImrVdZfhgVGsjw1WTht67ZycGIJkZBdYEDkfJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708685858; c=relaxed/simple;
	bh=gVeS+e41svOWH+sCq6XotOZ0nJF2LgZImj6VEqx+JvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEL4yTYCvwqF8kIbrohKeElyfSh0c3U3uYLaIBMWM6h78d9huYiboWQ45Ua5M/Q4PCjDBRr++FNN/CZeW2m4ou22UG2fVNnmA4QaMebL0Qv3RsKworTLHo0DkwBeeEFr7UCvTgGad2wmypAYj1MDx6zKiYa83jzg9k7R1jCXppg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ii7AfXXi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708685857; x=1740221857;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gVeS+e41svOWH+sCq6XotOZ0nJF2LgZImj6VEqx+JvQ=;
  b=ii7AfXXiRaar7Ft2CLrplbOxDP7U99PEIFGu+MrNJGOeLSKZOni5NlTa
   sjOIoV4GcsWzwHB6nr1Qr3OwDxfzXaIiJIhsYOW481bSonOA3FkNz5GDe
   Q0mSvAgZMyTjklvLHh9JdvtDQ0N7An4mDQ+pGLolpJpDD1fDZIt8RrSv+
   VQl+2tyZ9fij2qMSwbBEFfouCHg8kalwkSEnrzyno/gaF0Z266i5LdeRN
   rffVb6LnTqoZZjP1p6JNs9Ru3vrjnysC82fkn0wdNZ0g5IvahmAyMOu5K
   RniPX5dqmONhMtyVVkHskCKdapPCXQUEfD+cF0gXzFE1ACx9XbZ/WohJz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="6807231"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="6807231"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 02:57:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="937024610"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="937024610"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 02:57:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id B30631FD; Fri, 23 Feb 2024 12:57:31 +0200 (EET)
Date: Fri, 23 Feb 2024 12:57:31 +0200
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, Kai Huang <kai.huang@intel.com>, 
	Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCHv4] x86/trampoline: Bypass compat mode in
 trampoline_start64() if not needed
Message-ID: <yrpbogafgrmief5j7qtyblsndh3hdozh7keealeggcwwwqx7ou@pcmlayfyeqf5>
References: <20240126100101.689090-1-kirill.shutemov@linux.intel.com>
 <2qfzbafedurgpsnlbrrfcwed4kij5kbz6txaacp3fy73anfk3g@r75kdg6byw4b>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2qfzbafedurgpsnlbrrfcwed4kij5kbz6txaacp3fy73anfk3g@r75kdg6byw4b>

On Wed, Jan 31, 2024 at 03:04:03PM +0200, Kirill A. Shutemov wrote:
> On Fri, Jan 26, 2024 at 12:01:01PM +0200, Kirill A. Shutemov wrote:
> > The trampoline_start64() vector is used when a secondary CPU starts in
> > 64-bit mode. The current implementation directly enters compatibility
> > mode. It is necessary to disable paging and re-enable it in the correct
> > paging mode: either 4- or 5-level, depending on the configuration.
> > 
> > The X86S[1] ISA does not support compatibility mode in ring 0, and
> > paging cannot be disabled.
> > 
> > The trampoline_start64() function is reworked to only enter compatibility
> > mode if it is necessary to change the paging mode. If the CPU is already
> > in the desired paging mode, it will proceed in long mode.
> > 
> > This change will allow a secondary CPU to boot on an X86S machine as
> > long as the CPU is already in the correct paging mode.
> > 
> > In the future, there will be a mechanism to switch between paging modes
> > without disabling paging.
> > 
> > [1] https://www.intel.com/content/www/us/en/developer/articles/technical/envisioning-future-simplified-architecture.html
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Reviewed-by: Andi Kleen <ak@linux.intel.com>
> > Reviewed-by: Kai Huang <kai.huang@intel.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> 
> Any feedback?

Anybody?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

