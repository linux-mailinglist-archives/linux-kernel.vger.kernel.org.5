Return-Path: <linux-kernel+bounces-129899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD158971D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27761F23081
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94D5148FEB;
	Wed,  3 Apr 2024 14:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VCEL4asg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B778F1487E2;
	Wed,  3 Apr 2024 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152853; cv=none; b=R2PtIzjrE2LYgtYgjWdzyQdcNW05umNiycswQ5Euoj0xTe8o5JuahhcUch5ubL99bbEhUNwb/dNECzJYTF155TY88im+vIuwFqMG7hEioaa6jhc3qJcQ3VCwPJA6lJGpTHbr0MsZ5EhVOSddkHTMo6qn053/Tji8GVajdtPSGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152853; c=relaxed/simple;
	bh=BjYkvF7LXg6vWD752aMFoRkrW/2JqvZ+/duQLEBk55o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKPUot5/gg+CLMHX1yK3sI/IPTgBOEY3Y3lb/lcT4PHpNBO5I5aMW4Sn45AaBWklcZh1uAqyAEQAAlZ8pLmSQ0KfUne8OqZsr7iuPQtWLKCzS6MDT2ubMTKjjRioz71aU9awhaChEmAMfZkh6rEOwuQA9SoYLOxPzH0ul5FsEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VCEL4asg; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712152851; x=1743688851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BjYkvF7LXg6vWD752aMFoRkrW/2JqvZ+/duQLEBk55o=;
  b=VCEL4asgnnEEOD95ZuKkjN2TPMOp2R0+GLPXdnm8xZyOeP26QhW6bvqR
   2BPJatt/SC+5AZel+iRBBCdjSruglfv8nqUJSfZrK2Ncr4a5E7NyWS2s4
   CDnVzYJ77HwqngGpHNJeDimNPyoDgV90rfq4b2paPGbB+1OwIwraezZkC
   2jbGO3VWioD0k006yWmO7O7IsjdcDwis+RLlWUhd/AmgOynHPo0IMbfGy
   fDn7gAofd3BfsjS8DJnQX6Nl5+6bUvtUY22KxV163mBag3LsxNGPb9Fyw
   uZYfhPsc8wJcNrQ9qGBwSpezI8ue5+tLPNXIljjumzdEOJ/LJQJyZCLg8
   w==;
X-CSE-ConnectionGUID: sKyOhLmhT1iJfWqZT/MWaA==
X-CSE-MsgGUID: 1nMGWMucTTyxJrQUT6tnSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="11210598"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="11210598"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:00:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11033"; a="915184273"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915184273"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 07:00:42 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rs1AN-000000018aI-09zF;
	Wed, 03 Apr 2024 17:00:39 +0300
Date: Wed, 3 Apr 2024 17:00:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <oliver.sang@intel.com>
Cc: Yicong Yang <yangyicong@hisilicon.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable <stable@kernel.org>, Tony Lindgren <tony@atomide.com>,
	linux-serial@vger.kernel.org
Subject: Re: [linus:master] [serial]  43066e3222:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <Zg1hBvRAxifo50sf@smile.fi.intel.com>
References: <202404031607.2e92eebe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202404031607.2e92eebe-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 09:43:28PM +0800, kernel test robot wrote:

> kernel test robot noticed "BUG:kernel_NULL_pointer_dereference,address" on:
> 
> commit: 43066e32227ecde674e8ae1fcdd4a1ede67680c2 ("serial: port: Don't suspend if the port is still busy")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Ja-ja, I am investigating this issue for a while (not that I spend all my time
on it, though) on max3100.

The problem seems that we enable PM runtime on all serial ports
(even if they have no RPM support), but at the same time we enforce
the common serial_port PM callbacks and that change misses a detail
on how to check the port status as the real callback may happen
quite after the port being closed (/dev/ttySx).

Probably we need to check if the port is still open...

P.S. AFAIU the state / xmit is invalid pointer or so.

Culprit line:	serial_out(up, UART_TX, xmit->buf[xmit->tail]);

-- 
With Best Regards,
Andy Shevchenko



