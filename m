Return-Path: <linux-kernel+bounces-89945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD486F7E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 00:40:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2A11B20AA5
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 23:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81447AE72;
	Sun,  3 Mar 2024 23:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuFc6xfb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B97AE4F
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709509234; cv=none; b=BI+4Vax+26g5BH7IRsodL4K0sCSPxS44iO0MwHB0YKT6R+hbYP/BoKXbMk0EP3LOhJsr/7MGTUMvL1dNM0rEjIBA8ZFQLfKYF3aTFa1ETCr7bTuwJBA8U4g49UfkFsniBVZGqIPWNHwGu6LrtIoJkF5yPn/i/raHS2IZicf2bZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709509234; c=relaxed/simple;
	bh=7tve0kpBJ+naqulnh63PEkBZkSUf/HWjpqhRAzMG9Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aMusPj69i3tvwfCoblfbMAISOQ9z4HTOFOnszZwowd/642dMrG2W8WE2cvJldwH9rZErxcofO76Jdwu9PF4if2jbOEEHh4D0S5n4a0Ce562sb8p9ViiTUorYktnmlUD+qnzBc6pb0L3nbpYTI5Btdj6P/eU/IdTgyuwFM5TG9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuFc6xfb; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709509232; x=1741045232;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7tve0kpBJ+naqulnh63PEkBZkSUf/HWjpqhRAzMG9Wk=;
  b=ZuFc6xfbvxilfBzU0tWPzWyTV6u2OjBfo6stjIZ+73vkXUU0H+HDvzjN
   ZSiZJFKtN0CD9smh2U35AR4DtFwM4SBeZcFD0awGmLRaZ12pRsx4kDaNL
   gPMDYMY50Gkjy0N25e7/LbUgcA0a6T+y80Z8io+lPcF/onIW2oQ1fpIAS
   wesD5Kv2GttGMRPDoiqnDQFzwN8WsUxUpTdA8/4yuCJQw5boG8bfvL9+b
   jUZ104cCeXTHU16MOK8nbjH6meLPJVbFUwlv8Mw+TGDsQGYpVqOskOiQa
   dXnExvoDG1JSmRhFrt2cVvOuny5qKQ5ZP5gYPCNDaAjmXvge+/htmWmfT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="26451746"
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="26451746"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2024 15:40:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,201,1705392000"; 
   d="scan'208";a="13501308"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 03 Mar 2024 15:40:30 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rgvRT-0002B0-1G;
	Sun, 03 Mar 2024 23:40:27 +0000
Date: Mon, 4 Mar 2024 07:39:41 +0800
From: kernel test robot <lkp@intel.com>
To: Patricia Alfonso <trishalfonso@google.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	David Gow <davidgow@google.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>
Subject: mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works
 in KASAN generic outline mode!
Message-ID: <202403040748.giLq1yf5-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Patricia,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   58c806d867bf265c6fd16fc3bc62e2d3c156b5c9
commit: 5b301409e8bc5d7fad2ee138be44c5c529dd0874 UML: add support for KASAN under x86_64
date:   1 year, 8 months ago
config: um-randconfig-r133-20240225 (https://download.01.org/0day-ci/archive/20240304/202403040748.giLq1yf5-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240304/202403040748.giLq1yf5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403040748.giLq1yf5-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/test_kasan_module.c:16:
>> lib/../mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
     485 | #error kasan_arch_is_ready only works in KASAN generic outline mode!
         |  ^~~~~
--
   In file included from mm/kasan/report_generic.c:30:
>> mm/kasan/kasan.h:485:2: error: #error kasan_arch_is_ready only works in KASAN generic outline mode!
     485 | #error kasan_arch_is_ready only works in KASAN generic outline mode!
         |  ^~~~~


vim +485 mm/kasan/kasan.h

e2db1a9aa38149 Andrey Konovalov 2021-02-25  481  
af3751f3c2b628 Daniel Axtens    2021-06-28  482  #ifndef kasan_arch_is_ready
af3751f3c2b628 Daniel Axtens    2021-06-28  483  static inline bool kasan_arch_is_ready(void)	{ return true; }
af3751f3c2b628 Daniel Axtens    2021-06-28  484  #elif !defined(CONFIG_KASAN_GENERIC) || !defined(CONFIG_KASAN_OUTLINE)
af3751f3c2b628 Daniel Axtens    2021-06-28 @485  #error kasan_arch_is_ready only works in KASAN generic outline mode!
af3751f3c2b628 Daniel Axtens    2021-06-28  486  #endif
af3751f3c2b628 Daniel Axtens    2021-06-28  487  

:::::: The code at line 485 was first introduced by commit
:::::: af3751f3c2b6282bebcb56c35bbe4c8b671f80aa kasan: allow architectures to provide an outline readiness check

:::::: TO: Daniel Axtens <dja@axtens.net>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

