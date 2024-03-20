Return-Path: <linux-kernel+bounces-108842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0738D8810C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06B01F2315D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706733D0A3;
	Wed, 20 Mar 2024 11:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FOfzyC0Y"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383C01171D;
	Wed, 20 Mar 2024 11:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933617; cv=none; b=fM4iJoByaqYd34ATfVJP3jYI8dIOlrkUNO4P77xuSla0FavxJ7bjUAnJEt9hTpkBgZ2ZuO8fiG8KBcZMtqLEZjIrrr0HAG/XMDrWv+hA7ZkajyhOvWYWtoLhDm0ntE+59Wyxwx+Pt4ub9Cb4uyHVZgiO+M7v19ZJ9Q/wRDoHgeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933617; c=relaxed/simple;
	bh=z9hg5EXdykW7ItUDyXwEvhhKYYeWiKG2rtC3DZQzepI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRNF/HMq9KroDT2x8g2Wb5BlNsEVDmaEVBEMYrf2Q4LE8uQziNGMv1Xgu+rNp2VS77SOaszCEXRFRqIvD9h/m4etmO56FWcVUm9wy3YR8zdKfrdgzH6gWniYj2JljqLgMFnu1cZonDJ8ZNFCbxWSiiPiR7cIfTWroKDCP1zV+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FOfzyC0Y; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710933617; x=1742469617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z9hg5EXdykW7ItUDyXwEvhhKYYeWiKG2rtC3DZQzepI=;
  b=FOfzyC0Y5MC+X3TdBKAgVTx9iX2gOzbfypmLu1hPyK5kWExyhRbtfD43
   qIP+dfxTul7sAZz9pkJRuLON0Uq9fTuvZ1N3K7w2/3YbxBO+VGAD5Dzp4
   SoJKOEztRRHGpLI8Cbt+RiYu9uHFcBFElYGXgD0uF/r+ShNcuzT9Agrr0
   usf8KXElO9/BBuQzs6LtXjo30g8dr1RZootUOCcptjOVUdPS4pYW77ncY
   0JkvE1WajGrVTmYRUZmx5v5pUxji/hTQpg/kn/tl/21GZDVkOaGUwEmZG
   fdMcvfm2WfJxrVfPvb1Y0pfGTciXebZKQpZudQSjEZb+xFsD4pbKlI2Xf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17296502"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17296502"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:20:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="914663552"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914663552"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:20:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmtzP-0000000EYLr-2d33;
	Wed, 20 Mar 2024 13:20:11 +0200
Date: Wed, 20 Mar 2024 13:20:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH net-next v1 1/1] nfc: st95hf: Switch to using gpiod API
Message-ID: <ZfrGa_uRhu8Ihskl@smile.fi.intel.com>
References: <20240318203923.183943-1-andriy.shevchenko@linux.intel.com>
 <ZfloHvWaTOQErWfU@nanopsycho>
 <Zfq6GYnPAn000my0@smile.fi.intel.com>
 <20240320111258.GP185808@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320111258.GP185808@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 20, 2024 at 11:12:58AM +0000, Simon Horman wrote:
> On Wed, Mar 20, 2024 at 12:27:37PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 19, 2024 at 11:25:34AM +0100, Jiri Pirko wrote:
> > > Mon, Mar 18, 2024 at 09:39:23PM CET, andriy.shevchenko@linux.intel.com wrote:
> > > >This updates the driver to gpiod API, and removes yet another use of
> > > >of_get_named_gpio().
> > > >
> > > net-next is closed, send again next week.
> > 
> > Same Q: Why to resend? Can't you utilise lore.kernel.org?
> 
> Because that is how Netdev development currently operates.
> A system which I believe emerged as a way to handle the
> enormous volume of patches involved. Maybe it could change,
> but that is a different conversation.
> 
> Other subsystems work differently, and that is fine too.
> 
> https://docs.kernel.org/process/maintainer-netdev.html#git-trees-and-patch-flow

I see that this is the limitation of patchwork and/or nobody wants to "reopen"
the patch based on Message-ID. Still I believe it's possible to make it smarter.

In any case, I'll resend the patch(es) and try to keep in mind, that during
merge window net is a black hole (astronomically speaking).

-- 
With Best Regards,
Andy Shevchenko



