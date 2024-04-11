Return-Path: <linux-kernel+bounces-140261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C05A8A1085
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1161C21C4E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6070714B07B;
	Thu, 11 Apr 2024 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BABgEOv2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574614C591
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831652; cv=none; b=mDszBcht2BygvTqinVELQ1fQUl0Ox9RN7nl00/up/wdi+tMcooJ/Y0GVEPlAAQRBRXSkUO01AZ6AUsDEZely+b37yRHwVE8XbxIqfEvOHmIbOLo8SPH4rUtSF+GIiWTqjf13i3VuAu9bOV3eusL5DjMNNZw7iA2/6s1SsXCEjJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831652; c=relaxed/simple;
	bh=ebVF2ZciJkJmRePFWK6ngOAeaEJihaFUUs75GT3EkW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnQl2QLbE3CG4sgFv/oTqQiXA3/NdiBFkW9M5uOBTI5Xb4ArjVQQZ3aj7ED1le6qJc06QzBVCUJV+JzqUSvkbUcT8TM7wC5AeIZNj43Urpwpsl3bHLljdFILstkE0VY1n3nMXldZ0zpYJs9QbMkT5kjon+W7eQ5K8K/IrPc1v54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BABgEOv2; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712831651; x=1744367651;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ebVF2ZciJkJmRePFWK6ngOAeaEJihaFUUs75GT3EkW8=;
  b=BABgEOv2pSO+cxvUE0rOa1o8uqXEb4QAiVLYn6lxbSBnmrOsdTrC+Was
   uLsqYMZgZPXk2P6jj/ksRe7mcb8NJGWnKvudGZSPwjWRJ0qfIei70ZsB5
   K+YhqRoMx2L3qt03tSvQpijD5nWYPaWPMesqZpE4cwFlPXk11lP2AgBV7
   4VYoqTt4y2n9IyM1i5BwxjKJbVSQuUwluAuP5F9hpxbHtP+Nq33XtAhDt
   P7W0hd1DsJ21X15T5/JoHypAuodi++AFWQia8VEqThZKuMmWsNtVu5YXa
   FbsZyYnQ6Y1ZUoM5kwwpkR4kW8wy7FAdYYpEk/ZRPJSbPjVFa5e1ZnPBL
   w==;
X-CSE-ConnectionGUID: twOMlH6hSoymHgOnUmYFqw==
X-CSE-MsgGUID: aeMMv82PSkaI2E/4KRhqvQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8453597"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8453597"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:34:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915459789"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915459789"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 03:34:09 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rurkt-00000003K4C-36mp;
	Thu, 11 Apr 2024 13:34:07 +0300
Date: Thu, 11 Apr 2024 13:34:07 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] auxdisplay: charlcd: Don't rebuild when
 CONFIG_PANEL_BOOT_MESSAGE=y
Message-ID: <Zhe8n1VBRQ0wLMGT@smile.fi.intel.com>
References: <20240409173921.1080616-1-andriy.shevchenko@linux.intel.com>
 <CAMuHMdUm77VFSraw0KTKYoUknZ4Eyfgt9GeP9T-0_ET7L_zVsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdUm77VFSraw0KTKYoUknZ4Eyfgt9GeP9T-0_ET7L_zVsA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 09:43:48AM +0200, Geert Uytterhoeven wrote:
> On Tue, Apr 9, 2024 at 7:39 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > When CONFIG_PANEL_BOOT_MESSAGE=y the module still includes
> > the generated header and gets rebuilt even if it doesn't use
> > anything from that header.  Include generated header conditionally
> > to avoid unnecessary rebuilds.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thanks for your patch!
> 
> > --- a/drivers/auxdisplay/charlcd.c
> > +++ b/drivers/auxdisplay/charlcd.c
> > @@ -17,7 +17,9 @@
> >  #include <linux/uaccess.h>
> >  #include <linux/workqueue.h>
> >
> > +#ifndef CONFIG_PANEL_BOOT_MESSAGE
> >  #include <generated/utsrelease.h>
> > +#endif
> 
> Perhaps move the existing "#ifdef CONFIG_PANEL_BOOT_MESSAGE"-block
> up, and move the #include inside the #else branch?

I was thinking about it, but decided to group headers together.

> >  #include "charlcd.h"
> 
> Regardless
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko



