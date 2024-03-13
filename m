Return-Path: <linux-kernel+bounces-102420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33D587B1C9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9B028D30B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936CC5A4CB;
	Wed, 13 Mar 2024 19:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpi7eKRK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB733996
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357803; cv=none; b=a/dJOC/9ccnZ4M+CJBmyf5v+8CWAMIWIVDT7dx+Z+JKkoc6MZn5I7TRnXyBHjl5IufL45xiQTmCDsdzG+diP8Yeps4xywCR6sCaE6MTzW5W7r1qWDWA3WYxTXgZionDI8byjBFfWGXTyCmd8FpZazLFAda7oAP3IWNid6re9OU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357803; c=relaxed/simple;
	bh=rh5oG6orM3fTGSHdWpi42vJeHhKgSthJIn2wdziMOis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qECmJSZC4Ai9e1IMeGckHRjMnyCHAaL8Keb3h6WsHWbT78NC22wpGXG77I1hrhutApv9DVci+L7Y/PNsd8cYNjjfJEj2/MrTIrDlhvn5+IIoeDcZMlo1aeRWyLrpEkoo9ZVlzKc5TTlWJf15ZQpLnnLTZQNu2euMOUCPnrTAA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpi7eKRK; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710357802; x=1741893802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rh5oG6orM3fTGSHdWpi42vJeHhKgSthJIn2wdziMOis=;
  b=fpi7eKRKgdqiY/MSjuDKiXRmXi+RvN4/SR6taXJMtxd6wwjSI3gqpC+R
   daLiJfTnNqaGj5Lx6NSYB13rs/dA3wS29oluhK10b3UN8amxRpf76eeAV
   Ddi7nn5S+U1O1tEfOhTqtkawAkdrj5tZ1/bPNmhZ3wSLJoKFuiuNtyNQ9
   UP1s13Wtnj6NpFhl5ufP/TBXWkULdgvFa1VsJr3MjLxr+0BAKQW/W2dgV
   rXMWlcyNAUtrzN/H4LBKq/NNJ4iHp/FqfUFYlizDWed0X01HubOEFC03h
   50Q5Gydb5InavV4mMcYiBSPSfcbOPnvgrQT1a26ZyXJN5KB16M3fgXdNi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="15875886"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="15875886"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:23:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439688"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439688"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:23:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkUC6-0000000CJ7R-0aOr;
	Wed, 13 Mar 2024 21:23:18 +0200
Date: Wed, 13 Mar 2024 21:23:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: Re: WARNING: modpost: vmlinux: section mismatch in reference:
 find_next_bit+0x14 (section: .text.unlikely) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <ZfH9JVK1wak2nJmN@smile.fi.intel.com>
References: <202403140236.HDGbPm2J-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202403140236.HDGbPm2J-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 14, 2024 at 02:45:30AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b0546776ad3f332e215cebc0b063ba4351971cca
> commit: de5f84338970815b9fdd3497a975fb572d11e0b5 lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> date:   2 days ago
> config: xtensa-randconfig-s031-20211010 (https://download.01.org/0day-ci/archive/20240314/202403140236.HDGbPm2J-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240314/202403140236.HDGbPm2J-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202403140236.HDGbPm2J-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> >> WARNING: modpost: vmlinux: section mismatch in reference: find_next_bit+0x14 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)

Dup of https://lore.kernel.org/oe-kbuild-all/202403121032.WDY8ftKq-lkp@intel.com/ ?

-- 
With Best Regards,
Andy Shevchenko



