Return-Path: <linux-kernel+bounces-60400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C45785046A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:37:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2C41C20A71
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF43747F62;
	Sat, 10 Feb 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W0mMppck"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27523E46B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707568643; cv=none; b=X3ww6CIzXIaUlep7p3yDj27O4Pfrb47DPHeUKMnGBGK4nI0RUXvLvVKaKuTnPzy2bs0weB4VZ20bYhxcSvuDhEUJyL0GuG1jEI+7J71XFuCJfPzZS31uu9+oOPdsDasnaBL94SJoTEjY8/ii5+NIBTUiOV1QAYvY0mP2U22mXq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707568643; c=relaxed/simple;
	bh=UGfp+F2bKSDYXp+krPsfhfzmR33WWVKsJeUbL5k2tgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p58+EtbnOG/M3gLOHcejE0fuWDr0Akj5QYO6YAOmNooKBf6K8vC4k2h18hL+05K9PuWQUZPIXJ9eVuEyywLO7sUVWLv6KaFF+7BBdOSObtghQ3LAikzQR+SI92i6KcKOQNrhsvDUkdDuv7uQOUsMkn63t1oQCr3e1h0XXeUSJow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W0mMppck; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707568642; x=1739104642;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UGfp+F2bKSDYXp+krPsfhfzmR33WWVKsJeUbL5k2tgQ=;
  b=W0mMppckBBD4atDgZ4XA537DXNF4M/70OOaT9G22IKAFfAyV4oKsZwks
   dKVO8MCoGcMA1PGFz6u0Gk/Uv/Itx76X3+cBbwfpQJCSUPeHkZ6uAhJs6
   pGk4SeWaIc2C/tshci3bi0OG+WvZ5iX+FDXvzP7ljB2znWlC2/3os9Cm2
   eyHge7Nwxxv40nak3BbBq8zreILl8y5DonX8IravdpjTTnPJh1fihIwwn
   bukHJ4lw+c9aWiveFZi8TpDWWxx93PtF+VgqcrF4oTZQxPtnSE3eeIOeK
   faae5u5eCR1nFOPMupNVqepm7JhqHc6p6c/hODPNGB9Gwtg2wrOSo+gMO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1466860"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="1466860"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 04:37:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="32955486"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 10 Feb 2024 04:37:20 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYmbd-0005ek-0J;
	Sat, 10 Feb 2024 12:37:17 +0000
Date: Sat, 10 Feb 2024 20:36:44 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v2 02/35] include: remove unnecessary #include directives
Message-ID: <202402102049.pRU8DQFn-lkp@intel.com>
References: <20240209164027.2582906-3-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209164027.2582906-3-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc3 v6.8-rc2 v6.8-rc1 v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240210-005417
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240209164027.2582906-3-max.kellermann%40ionos.com
patch subject: [PATCH v2 02/35] include: remove unnecessary #include directives
config: csky-allnoconfig (https://download.01.org/0day-ci/archive/20240210/202402102049.pRU8DQFn-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402102049.pRU8DQFn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402102049.pRU8DQFn-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/csky/kernel/stacktrace.c: In function 'print_trace_address':
>> arch/csky/kernel/stacktrace.c:92:9: error: implicit declaration of function 'print_ip_sym' [-Werror=implicit-function-declaration]
      92 |         print_ip_sym((const char *)arg, pc);
         |         ^~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/print_ip_sym +92 arch/csky/kernel/stacktrace.c

18c07d23da5a48 Guo Ren        2020-05-13  89  
18c07d23da5a48 Guo Ren        2020-05-13  90  static bool print_trace_address(unsigned long pc, void *arg)
18c07d23da5a48 Guo Ren        2020-05-13  91  {
aeeb59d692c1ba Dmitry Safonov 2020-06-08 @92  	print_ip_sym((const char *)arg, pc);
18c07d23da5a48 Guo Ren        2020-05-13  93  	return false;
18c07d23da5a48 Guo Ren        2020-05-13  94  }
18c07d23da5a48 Guo Ren        2020-05-13  95  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

