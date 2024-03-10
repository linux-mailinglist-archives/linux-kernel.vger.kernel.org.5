Return-Path: <linux-kernel+bounces-98181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2A6877620
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 11:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 193011C20D1D
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 10:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40601F170;
	Sun, 10 Mar 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bw/KztFx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E783D8E;
	Sun, 10 Mar 2024 10:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710067094; cv=none; b=S822KuWBpvYEND4UACqtxHNcPVQyjHW2uizh0A95vza3tfoLdRp9lVf9VedJ/Ure5i08FILblP2yD91zY/Qy+89gjha9q5ALooYu7RQwh40RZTj61nqFAbkud5hPHIbr/l/t3q8VriogykGDYbBFzcT4kaB8bNHtWILs5Ta/FUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710067094; c=relaxed/simple;
	bh=8/J5Jwa+0rLFUZyeqG/2hEgXFAgXb6jr08TRztCGnd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CwCu27Hj8ZieCBrfCGCFtM63fk7k28E7mui4EVgPHH+ACdmQIlagKv2VQ7LHaW7TdmyXT/XBo4PvloPpwgW86fH9fbXEDckJqo1NDlwEy9xn04WPBx6EdPlFwFBVa3q1kBPkktXc51ziteSWTQ2f9D8SBtWiKlRq6X1HvxcZXcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bw/KztFx; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710067092; x=1741603092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8/J5Jwa+0rLFUZyeqG/2hEgXFAgXb6jr08TRztCGnd4=;
  b=bw/KztFxr2RGA20RrmiEl8fvCxsf8uXqk06fmxN1bqJOKfdCJl4qV4ZN
   xiNZpSpdGtbhSRljEtcYZ5tG0uTNH2RUZ7Hyx6ncAJhkPV8MBFp5w4wH8
   EzuoJkS8H52fo+6+kyNpxH67sEukvGnQDUOOGkQgqRfAe2++7/Ejkefqr
   Fj8bUQzmixfS1vOhhO/GG4pofa0Ye9vbtWwIRc8FgsQwKsd6tcaz6X/14
   5qDSURKjuKVR9CGWk9jdNZZZLFLYQGLz7NZLWteq/QRR+Vl1b4JcG0TlX
   OFjDpsi2rIjKvDkDszlqLCYYrhYTG8mFWGYwoawo1/l1LJOiEZXzN08Yu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11008"; a="4868405"
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="4868405"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2024 03:38:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,114,1708416000"; 
   d="scan'208";a="10787715"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Mar 2024 03:38:05 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rjGZ9-0008BP-19;
	Sun, 10 Mar 2024 10:38:03 +0000
Date: Sun, 10 Mar 2024 18:37:53 +0800
From: kernel test robot <lkp@intel.com>
To: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Helge Deller <deller@gmx.de>, Randy Dunlap <rdunlap@infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Kjetil Oftedal <oftedal@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org,
	Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2 14/28] sparc32: Drop unused mmu models
Message-ID: <202403101854.Z94SAU13-lkp@intel.com>
References: <20240309-sunset-v2-14-f09912574d2c@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240309-sunset-v2-14-f09912574d2c@ravnborg.org>

Hi Sam,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 84b76d05828a1909e20d0f66553b876b801f98c8]

url:    https://github.com/intel-lab-lkp/linux/commits/Sam-Ravnborg-via-B4-Relay/sparc32-Update-defconfig-to-LEON-SMP/20240310-021717
base:   84b76d05828a1909e20d0f66553b876b801f98c8
patch link:    https://lore.kernel.org/r/20240309-sunset-v2-14-f09912574d2c%40ravnborg.org
patch subject: [PATCH v2 14/28] sparc32: Drop unused mmu models
config: sparc-randconfig-r113-20240310 (https://download.01.org/0day-ci/archive/20240310/202403101854.Z94SAU13-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240310/202403101854.Z94SAU13-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403101854.Z94SAU13-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> arch/sparc/mm/srmmu.c:49:5: sparse: sparse: symbol 'vac_line_size' was not declared. Should it be static?

vim +/vac_line_size +49 arch/sparc/mm/srmmu.c

accf032cfa582e Sam Ravnborg   2012-05-19  46  
^1da177e4c3f41 Linus Torvalds 2005-04-16  47  int vac_cache_size;
9d262d95114cf2 Guenter Roeck  2017-04-01  48  EXPORT_SYMBOL(vac_cache_size);
^1da177e4c3f41 Linus Torvalds 2005-04-16 @49  int vac_line_size;
^1da177e4c3f41 Linus Torvalds 2005-04-16  50  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

