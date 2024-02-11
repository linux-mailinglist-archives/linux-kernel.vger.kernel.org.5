Return-Path: <linux-kernel+bounces-60629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC79A85079C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 03:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAEB1F23CED
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 02:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2096617CF;
	Sun, 11 Feb 2024 02:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TUHxBqSp"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BE1185A
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707617028; cv=none; b=YC40GkKYwFGv18A96W3zlb8r68rDQHBePxRUQatCCP/rDwseQbceo+xc0nCRzRFnqsfC/+Czdz2v1uM7vKy/+MnxPQ3c/9Ywz6SfMaSVe3xmQeeL57GGjuiYTvjLA+UNX0roSP2SLjP2E9k1QoVbI5ex/iF6GDDsqZLcOM9SF80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707617028; c=relaxed/simple;
	bh=0KHNYYwZuWk92VhOm7k0q95ijj5D9AyzjBI7oeZefxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I0LsqjtEZbr9DUDRDhI3JOizeTb3plANjLehC6Yf9BGIQ68L5skThD6Fsxu30FtSxtX5r79yuiHrX8jFSamKQEGVaxzbu7SIevIs48tgZRaLCjwnU4sbZTOny5nzJ6jQ19c1GNDp/dyLZ/obBMhlZYQ3QO4etvmhsW53YgEpBU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TUHxBqSp; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707617027; x=1739153027;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0KHNYYwZuWk92VhOm7k0q95ijj5D9AyzjBI7oeZefxQ=;
  b=TUHxBqSpqydFtAqY+IbsmOa76vz468BARGe3Op0Zs2ewpRrhLW/w7hWv
   XU4Taaiw4Zr/p0nMB5ht3h/bxTp9HDV5F6cY9EJZNKnBZBt8BHcKbwlEH
   lYlszdgs9grZ+PbYsFCllwU18et7OmqcsPq82W+qHfjKcrqsbMnPcY1tg
   SUGj14pPHb55UYSieLzPosBm0itJ79U7OaXMForthUNSozq7FdsAc7q8W
   XRh2aTJTPN8vkUgQIu1LgcBOy5guk73Peu4Nv996oY81T1gtxjdfIO1b1
   9UgN3nZl/uZYvJeFLIfjnPeEvuNB1nu4WXJLfCprAQvymHhSl+SN6V6Ly
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10980"; a="1490725"
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="1490725"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 18:03:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,260,1701158400"; 
   d="scan'208";a="39713940"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 10 Feb 2024 18:03:44 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYzC2-0006Fs-0L;
	Sun, 11 Feb 2024 02:03:42 +0000
Date: Sun, 11 Feb 2024 10:03:12 +0800
From: kernel test robot <lkp@intel.com>
To: Hamish Martin <hamish.martin@alliedtelesis.co.nz>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: drivers/uio/uio.c:520:21: sparse: sparse: incorrect type in
 assignment (different base types)
Message-ID: <202402111048.4XHz0rkp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a5b6244cf87c50358f5562b8f07f7ac35fc7f6b0
commit: a93e7b331568227500186a465fee3c2cb5dffd1f uio: Prevent device destruction while fds are open
date:   6 years ago
config: x86_64-randconfig-x051-20230705 (https://download.01.org/0day-ci/archive/20240211/202402111048.4XHz0rkp-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240211/202402111048.4XHz0rkp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402111048.4XHz0rkp-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/uio/uio.c:520:21: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __poll_t [usertype] ret @@     got int @@
   drivers/uio/uio.c:520:21: sparse:     expected restricted __poll_t [usertype] ret
   drivers/uio/uio.c:520:21: sparse:     got int
   drivers/uio/uio.c:852: warning: expecting prototype for uio_register_device(). Prototype was for __uio_register_device() instead

vim +520 drivers/uio/uio.c

   510	
   511	static __poll_t uio_poll(struct file *filep, poll_table *wait)
   512	{
   513		struct uio_listener *listener = filep->private_data;
   514		struct uio_device *idev = listener->dev;
   515		__poll_t ret = 0;
   516		unsigned long flags;
   517	
   518		spin_lock_irqsave(&idev->info_lock, flags);
   519		if (!idev->info || !idev->info->irq)
 > 520			ret = -EIO;
   521		spin_unlock_irqrestore(&idev->info_lock, flags);
   522	
   523		if (ret)
   524			return ret;
   525	
   526		poll_wait(filep, &idev->wait, wait);
   527		if (listener->event_count != atomic_read(&idev->event))
   528			return EPOLLIN | EPOLLRDNORM;
   529		return 0;
   530	}
   531	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

