Return-Path: <linux-kernel+bounces-61565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F11A8513B5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D21B91F2168A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5639FE9;
	Mon, 12 Feb 2024 12:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HP8cZpM9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5557F39FDD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741871; cv=none; b=QaN/AU3uAc3P1dy4gpE+X5km9/sLAONEGR7PNvoY/aE5H2RNyyIgM4/zzbbR+AyLK7fF0vjmuQ3fPY7W6ZvjNllSgMcix7Y7L3VIhx1rwq+wAILzrwvzmvNbH3ICKPm9P8tSrFizoj4lKRJRk/y6nME18jE/lkxVXSMwiSJkl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741871; c=relaxed/simple;
	bh=RP9tbVIsrNBdwL7W0c9E/2e7vDazACAROnrllFWau+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GITtQBiB6Qeltu1WGQpofBcCkmptv+mvgp1PDqrL9Ry2/5gGxRZN4yKH7drqKLrldZ1+ucwROK7s5+0s9WkbxXVd/0T81QzzATsOD1FD5oA86Bm4EUuytFZY5I2EIWGnBg7CPZN4+xD4eKwhVFDajmTfPTPm0IQ6F59sN9xniM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HP8cZpM9; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707741869; x=1739277869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RP9tbVIsrNBdwL7W0c9E/2e7vDazACAROnrllFWau+4=;
  b=HP8cZpM9v+nPZL9UUN5utowXs8c19tFW00p5bXjdVLGFioxjWpBm7Q5S
   r5vYmekqG4pAHYDSN/VAt/W/gtCnMpY8a4KfTUXniw2qvkUD6GblRCkCm
   p8kmNvb4z8+oo9H/dr2n4/dicptjCFylO2mNVOaGlSebZ9CV2Iv/j80dm
   Fdb+oOJu1ITBeBAktyPYHYXS2an9QxvlPdMiz+0hrIEb66sX31/N6ylnA
   dRvo6G7Ictu/KMZTAYPEwkrW3GF/U7Z5DqzmoPF/hse/09xJcgP0D0qwV
   Cze/m41wcSdJsMb5IBBtoBVlapre2dQGFgbJe/aWP/Ih+FlGbdnxGz+k3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="13097969"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="13097969"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:44:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="911472685"
X-IronPort-AV: E=Sophos;i="6.06,263,1705392000"; 
   d="scan'208";a="911472685"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 04:44:27 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rZVfd-00000003tcv-0BMu;
	Mon, 12 Feb 2024 14:44:25 +0200
Date: Mon, 12 Feb 2024 14:44:24 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: Re: [PATCH v1 1/1] auxdisplay: Take over maintainership, but in Odd
 Fixes mode
Message-ID: <ZcoSqHIknAvalzf4@smile.fi.intel.com>
References: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212113653.2625776-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 12, 2024 at 01:36:53PM +0200, Andy Shevchenko wrote:
> I have no time for this, but since it looks like I'm the main
> contributor for the last few years to the subsystem, I'll take
> it for now. Let's see how it will go...

Okay, Geert agreed to be a designated reviewer for this and I think I may
establish a separate kernel tree on git.kernel.org. I'll send an updated
version of this.

Miguel, would be nice to get your Ack.

-- 
With Best Regards,
Andy Shevchenko



