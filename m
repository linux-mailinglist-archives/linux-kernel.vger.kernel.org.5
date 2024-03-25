Return-Path: <linux-kernel+bounces-116645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D79F88A1CB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDFB11C38503
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19619145354;
	Mon, 25 Mar 2024 09:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lW80a0Nu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F57158DA9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358423; cv=none; b=nJBxOse7uzy2mFJ2lRurvh8ahehPwAoII9upDk5jVTCu7nw6jSkmgw6S3f3mxZkkGVk0s6z7fa60EmOiLjM0Y8CFHkghqohKOC6bCCAN7kEKDUzr7tI0zuLFbLvhW/gT6IGV1zXqYjwVYvmqP+OxJhhXFnTC4JPA4UebQRBfEQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358423; c=relaxed/simple;
	bh=KRFUKWB3oSqUgHNFa1Hjw7+UHdiQcMzSoFOclAEk0Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Alws67flr9xhqHwQ6GaXKyyXbtTQ6oOWrYo6n9ebGDZzYFs22E2P2dC2TI5mtAShb/GCMSLSItHiFpl5d47gdfbcAsPQpYHmFdD7qk1tm33Wm/Z5mU5S6qF1GrQKmfNPBiM7o7y3EQKkWUvg6d7mBSi9SqwN69k9FaOoqpUrSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lW80a0Nu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711358421; x=1742894421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KRFUKWB3oSqUgHNFa1Hjw7+UHdiQcMzSoFOclAEk0Kc=;
  b=lW80a0NupQ2OKInIFCBF3W70izOG3Dbp26DuuhOLEFRnV4+eF040eiRd
   XXwZ1Ztisi5WgD2PQ6ZknH7bhxcHb0YmKe2KoZlZ26B9m0icuSCY9gucn
   km0bEmsRCrp9joulCt2iEBk9fKa+MyX3Szbo4zFhwvYRgebs0PEQXEaDR
   TO2UCcC8wDZQ7AEwBMC4/TUbUa9Up8HXXKWOgrLNpmNscxjqtZ6KpGicW
   qTQDDnehxJsT/9euLqinM25actdZbIs5maeJ/c8D9NvKrrz0frYP/TREq
   VrqlVIXn/0i0aze0u9uzxmwTuxa9lyOqzAsrqMajSbo8hx4s/ZE++ULC9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6532833"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="6532833"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:20:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914837406"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="914837406"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 02:20:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rogV6-0000000Fvdm-2sRS;
	Mon, 25 Mar 2024 11:20:16 +0200
Date: Mon, 25 Mar 2024 11:20:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Herve Codina <herve.codina@bootlin.com>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: include/linux/framer/framer.h:184:16: warning: no previous
 prototype for function 'framer_get'
Message-ID: <ZgFB0C5KilzltDKz@smile.fi.intel.com>
References: <202403241110.hfJqeJRu-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403241110.hfJqeJRu-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 24, 2024 at 11:19:28AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   70293240c5ce675a67bfc48f419b093023b862b3
> commit: 54762918ca856028d33d1d56d017a4d7706c6196 net: wan: fsl_qmc_hdlc: Add framer support
> date:   13 days ago
> config: powerpc-randconfig-003-20240324 (https://download.01.org/0day-ci/archive/20240324/202403241110.hfJqeJRu-lkp@intel.com/config)
> compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240324/202403241110.hfJqeJRu-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403241110.hfJqeJRu-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):

> 82c944d05b1a24 Herve Codina 2023-11-28  183  
> 82c944d05b1a24 Herve Codina 2023-11-28 @184  struct framer *framer_get(struct device *dev, const char *con_id)
> 82c944d05b1a24 Herve Codina 2023-11-28  185  {
> 82c944d05b1a24 Herve Codina 2023-11-28  186  	return ERR_PTR(-ENOSYS);
> 82c944d05b1a24 Herve Codina 2023-11-28  187  }
> 82c944d05b1a24 Herve Codina 2023-11-28  188  
> 82c944d05b1a24 Herve Codina 2023-11-28 @189  void framer_put(struct device *dev, struct framer *framer)
> 82c944d05b1a24 Herve Codina 2023-11-28  190  {
> 82c944d05b1a24 Herve Codina 2023-11-28  191  }
> 82c944d05b1a24 Herve Codina 2023-11-28  192  

Yeah, stubs in the headers should be static inline.

-- 
With Best Regards,
Andy Shevchenko



