Return-Path: <linux-kernel+bounces-38694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2363983C432
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89BEA1F2295A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FB6026A;
	Thu, 25 Jan 2024 13:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4nCIozA"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E660275;
	Thu, 25 Jan 2024 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706191017; cv=none; b=KgVMzoiUJyyFc8C7RrsQpn5U3Scg/u8U6slY+h3OeiLSzqP2WBc0qdUH1fRcvtkw6pXjNtsBGZEhupHbFuhJnSxbgDrJh3U/sLh0OBJLVW6FVevzs08e1seO5dwkIzeskzj8KcGLqVo80ZrHAJffDpr60BUzQQFIN9lTB/4aRn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706191017; c=relaxed/simple;
	bh=U4OzUPun/N8fn0WP6e9y9zJc9JiMcuGtvv6lUI/mDnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDhAsUs4IcnFCXmbvrdx7EJZRwlRJF6eXHaYoht+KmH9cjEUugiK8dcq0smKETyq38Xp5kVz0HVTpNzo9qfKL5I4hISXDjpWimeLTR5Sj0SCSx1mwwyILBO0Xkw1bFSiO8NoxGycR1fn4RixWPJ/msQJB3lXiizwDDkVAyUhvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4nCIozA; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706191015; x=1737727015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U4OzUPun/N8fn0WP6e9y9zJc9JiMcuGtvv6lUI/mDnY=;
  b=J4nCIozAqgWpm8XfQY6z3CSygAUI1dfSlb33hOvmALjPWK7mj6KInbqD
   dWkKSbjbko+sIVK4s5drk1e+jtuEdsPQcU2H86NC1UVofYajb1+gX51Ul
   IwXA1oJrjK8/E4o2zvxnY1oLVmzNl92WgJVDD1+vkGm5UYjQmBms2+XCW
   rlubZ8DxUaylgI9RqcGPLkDWY9pTQARclAKkkufHiHJP8Kh+QZ/yQ8nxZ
   ZO6DNv4xqWynq92ZRf74ksoe0SdJ9nJKyTpyBxf+Njqi5sYcB/jus1fOl
   39f5BugnzeXh0sLqRIkRn9+gPgQ7GZKJYdS2kqe0gerBtPZEvbW0sEXzN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="401815217"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="401815217"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 05:56:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2252814"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 25 Jan 2024 05:56:51 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rT0Do-00002q-2X;
	Thu, 25 Jan 2024 13:56:48 +0000
Date: Thu, 25 Jan 2024 21:56:18 +0800
From: kernel test robot <lkp@intel.com>
To: linan666@huaweicloud.com, song@kernel.org, neilb@suse.com, shli@fb.com,
	mariusz.tkaczyk@linux.intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	linan666@huaweicloud.com, yukuai3@huawei.com, yi.zhang@huawei.com,
	houtao1@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v3 3/4] md: sync blockdev before stopping raid or setting
 readonly
Message-ID: <202401252146.3yACLRcr-lkp@intel.com>
References: <20240125062841.1721193-4-linan666@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240125062841.1721193-4-linan666@huaweicloud.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.8-rc1 next-20240125]
[cannot apply to song-md/md-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-com/md-Don-t-clear-MD_CLOSING-when-the-raid-is-about-to-stop/20240125-144040
base:   linus/master
patch link:    https://lore.kernel.org/r/20240125062841.1721193-4-linan666%40huaweicloud.com
patch subject: [PATCH v3 3/4] md: sync blockdev before stopping raid or setting readonly
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240125/202401252146.3yACLRcr-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project a31a60074717fc40887cfe132b77eec93bedd307)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240125/202401252146.3yACLRcr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401252146.3yACLRcr-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/md/md.c:43:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/md/md.c:43:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/md/md.c:43:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/md/md.c:4521:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
    4521 |         default:
         |         ^
   drivers/md/md.c:4521:2: note: insert 'break;' to avoid fall-through
    4521 |         default:
         |         ^
         |         break; 
   7 warnings generated.


vim +4521 drivers/md/md.c

9e653b6342c940 NeilBrown        2006-06-26  4495  
9e653b6342c940 NeilBrown        2006-06-26  4496  static ssize_t
fd01b88c75a718 NeilBrown        2011-10-11  4497  array_state_store(struct mddev *mddev, const char *buf, size_t len)
9e653b6342c940 NeilBrown        2006-06-26  4498  {
6497709b5d1bcc NeilBrown        2017-03-15  4499  	int err = 0;
9e653b6342c940 NeilBrown        2006-06-26  4500  	enum array_state st = match_word(buf, array_states);
242b3580d1a1d0 Li Nan           2024-01-25  4501  	bool clear_md_closing = false;
6791875e2e5393 NeilBrown        2014-12-15  4502  
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4503  	/* No lock dependent actions */
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4504  	switch (st) {
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4505  	case suspended:		/* not supported yet */
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4506  	case write_pending:	/* cannot be set */
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4507  	case active_idle:	/* cannot be set */
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4508  	case broken:		/* cannot be set */
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4509  	case bad_word:
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4510  		return -EINVAL;
242b3580d1a1d0 Li Nan           2024-01-25  4511  	case clear:
242b3580d1a1d0 Li Nan           2024-01-25  4512  	case readonly:
242b3580d1a1d0 Li Nan           2024-01-25  4513  	case inactive:
242b3580d1a1d0 Li Nan           2024-01-25  4514  	case read_auto:
242b3580d1a1d0 Li Nan           2024-01-25  4515  		if (!mddev->pers || !md_is_rdwr(mddev))
242b3580d1a1d0 Li Nan           2024-01-25  4516  			break;
242b3580d1a1d0 Li Nan           2024-01-25  4517  		err = mddev_set_closing_and_sync_blockdev(mddev);
242b3580d1a1d0 Li Nan           2024-01-25  4518  		if (err)
242b3580d1a1d0 Li Nan           2024-01-25  4519  			return err;
242b3580d1a1d0 Li Nan           2024-01-25  4520  		clear_md_closing = true;
09f894affcf2da Mariusz Tkaczyk  2023-09-28 @4521  	default:
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4522  		break;
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4523  	}
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4524  
f97a5528b21eb1 Ye Bin           2022-09-20  4525  	if (mddev->pers && (st == active || st == clean) &&
f97a5528b21eb1 Ye Bin           2022-09-20  4526  	    mddev->ro != MD_RDONLY) {
6791875e2e5393 NeilBrown        2014-12-15  4527  		/* don't take reconfig_mutex when toggling between
6791875e2e5393 NeilBrown        2014-12-15  4528  		 * clean and active
6791875e2e5393 NeilBrown        2014-12-15  4529  		 */
6791875e2e5393 NeilBrown        2014-12-15  4530  		spin_lock(&mddev->lock);
6791875e2e5393 NeilBrown        2014-12-15  4531  		if (st == active) {
6791875e2e5393 NeilBrown        2014-12-15  4532  			restart_array(mddev);
2953079c692da0 Shaohua Li       2016-12-08  4533  			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
91a6c4aded58cb Tomasz Majchrzak 2016-10-25  4534  			md_wakeup_thread(mddev->thread);
6791875e2e5393 NeilBrown        2014-12-15  4535  			wake_up(&mddev->sb_wait);
6791875e2e5393 NeilBrown        2014-12-15  4536  		} else /* st == clean */ {
6791875e2e5393 NeilBrown        2014-12-15  4537  			restart_array(mddev);
6497709b5d1bcc NeilBrown        2017-03-15  4538  			if (!set_in_sync(mddev))
6791875e2e5393 NeilBrown        2014-12-15  4539  				err = -EBUSY;
6791875e2e5393 NeilBrown        2014-12-15  4540  		}
573275b58ee9e1 Tomasz Majchrzak 2016-06-30  4541  		if (!err)
573275b58ee9e1 Tomasz Majchrzak 2016-06-30  4542  			sysfs_notify_dirent_safe(mddev->sysfs_state);
6791875e2e5393 NeilBrown        2014-12-15  4543  		spin_unlock(&mddev->lock);
c008f1d356277a NeilBrown        2015-06-12  4544  		return err ?: len;
6791875e2e5393 NeilBrown        2014-12-15  4545  	}
242b3580d1a1d0 Li Nan           2024-01-25  4546  
6791875e2e5393 NeilBrown        2014-12-15  4547  	err = mddev_lock(mddev);
6791875e2e5393 NeilBrown        2014-12-15  4548  	if (err)
6791875e2e5393 NeilBrown        2014-12-15  4549  		return err;
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4550  
9e653b6342c940 NeilBrown        2006-06-26  4551  	switch (st) {
9e653b6342c940 NeilBrown        2006-06-26  4552  	case inactive:
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4553  		/* stop an active array, return 0 otherwise */
90cf195d9bcb4b NeilBrown        2012-07-31  4554  		if (mddev->pers)
a05b7ea03d72f3 NeilBrown        2012-07-19  4555  			err = do_md_stop(mddev, 2, NULL);
9e653b6342c940 NeilBrown        2006-06-26  4556  		break;
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4557  	case clear:
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4558  		err = do_md_stop(mddev, 0, NULL);
242b3580d1a1d0 Li Nan           2024-01-25  4559  		if (!err)
242b3580d1a1d0 Li Nan           2024-01-25  4560  			clear_md_closing = false;
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4561  		break;
9e653b6342c940 NeilBrown        2006-06-26  4562  	case readonly:
9e653b6342c940 NeilBrown        2006-06-26  4563  		if (mddev->pers)
a05b7ea03d72f3 NeilBrown        2012-07-19  4564  			err = md_set_readonly(mddev, NULL);
9e653b6342c940 NeilBrown        2006-06-26  4565  		else {
f97a5528b21eb1 Ye Bin           2022-09-20  4566  			mddev->ro = MD_RDONLY;
648b629ed40623 NeilBrown        2008-04-30  4567  			set_disk_ro(mddev->gendisk, 1);
9e653b6342c940 NeilBrown        2006-06-26  4568  			err = do_md_run(mddev);
9e653b6342c940 NeilBrown        2006-06-26  4569  		}
9e653b6342c940 NeilBrown        2006-06-26  4570  		break;
9e653b6342c940 NeilBrown        2006-06-26  4571  	case read_auto:
9e653b6342c940 NeilBrown        2006-06-26  4572  		if (mddev->pers) {
f97a5528b21eb1 Ye Bin           2022-09-20  4573  			if (md_is_rdwr(mddev))
a05b7ea03d72f3 NeilBrown        2012-07-19  4574  				err = md_set_readonly(mddev, NULL);
f97a5528b21eb1 Ye Bin           2022-09-20  4575  			else if (mddev->ro == MD_RDONLY)
648b629ed40623 NeilBrown        2008-04-30  4576  				err = restart_array(mddev);
648b629ed40623 NeilBrown        2008-04-30  4577  			if (err == 0) {
f97a5528b21eb1 Ye Bin           2022-09-20  4578  				mddev->ro = MD_AUTO_READ;
648b629ed40623 NeilBrown        2008-04-30  4579  				set_disk_ro(mddev->gendisk, 0);
648b629ed40623 NeilBrown        2008-04-30  4580  			}
9e653b6342c940 NeilBrown        2006-06-26  4581  		} else {
f97a5528b21eb1 Ye Bin           2022-09-20  4582  			mddev->ro = MD_AUTO_READ;
9e653b6342c940 NeilBrown        2006-06-26  4583  			err = do_md_run(mddev);
9e653b6342c940 NeilBrown        2006-06-26  4584  		}
9e653b6342c940 NeilBrown        2006-06-26  4585  		break;
9e653b6342c940 NeilBrown        2006-06-26  4586  	case clean:
9e653b6342c940 NeilBrown        2006-06-26  4587  		if (mddev->pers) {
339421def582ab Song Liu         2015-10-08  4588  			err = restart_array(mddev);
339421def582ab Song Liu         2015-10-08  4589  			if (err)
339421def582ab Song Liu         2015-10-08  4590  				break;
85572d7c75fd5b NeilBrown        2014-12-15  4591  			spin_lock(&mddev->lock);
6497709b5d1bcc NeilBrown        2017-03-15  4592  			if (!set_in_sync(mddev))
e691063a61f7f7 NeilBrown        2008-02-06  4593  				err = -EBUSY;
85572d7c75fd5b NeilBrown        2014-12-15  4594  			spin_unlock(&mddev->lock);
5bf295975416f8 NeilBrown        2009-05-07  4595  		} else
5bf295975416f8 NeilBrown        2009-05-07  4596  			err = -EINVAL;
9e653b6342c940 NeilBrown        2006-06-26  4597  		break;
9e653b6342c940 NeilBrown        2006-06-26  4598  	case active:
9e653b6342c940 NeilBrown        2006-06-26  4599  		if (mddev->pers) {
339421def582ab Song Liu         2015-10-08  4600  			err = restart_array(mddev);
339421def582ab Song Liu         2015-10-08  4601  			if (err)
339421def582ab Song Liu         2015-10-08  4602  				break;
2953079c692da0 Shaohua Li       2016-12-08  4603  			clear_bit(MD_SB_CHANGE_PENDING, &mddev->sb_flags);
9e653b6342c940 NeilBrown        2006-06-26  4604  			wake_up(&mddev->sb_wait);
9e653b6342c940 NeilBrown        2006-06-26  4605  			err = 0;
9e653b6342c940 NeilBrown        2006-06-26  4606  		} else {
f97a5528b21eb1 Ye Bin           2022-09-20  4607  			mddev->ro = MD_RDWR;
648b629ed40623 NeilBrown        2008-04-30  4608  			set_disk_ro(mddev->gendisk, 0);
9e653b6342c940 NeilBrown        2006-06-26  4609  			err = do_md_run(mddev);
9e653b6342c940 NeilBrown        2006-06-26  4610  		}
9e653b6342c940 NeilBrown        2006-06-26  4611  		break;
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4612  	default:
09f894affcf2da Mariusz Tkaczyk  2023-09-28  4613  		err = -EINVAL;
9e653b6342c940 NeilBrown        2006-06-26  4614  		break;
9e653b6342c940 NeilBrown        2006-06-26  4615  	}
6791875e2e5393 NeilBrown        2014-12-15  4616  
6791875e2e5393 NeilBrown        2014-12-15  4617  	if (!err) {
1d23f178d56ae1 NeilBrown        2011-12-08  4618  		if (mddev->hold_active == UNTIL_IOCTL)
1d23f178d56ae1 NeilBrown        2011-12-08  4619  			mddev->hold_active = 0;
00bcb4ac7ee7e5 NeilBrown        2010-06-01  4620  		sysfs_notify_dirent_safe(mddev->sysfs_state);
9e653b6342c940 NeilBrown        2006-06-26  4621  	}
6791875e2e5393 NeilBrown        2014-12-15  4622  	mddev_unlock(mddev);
242b3580d1a1d0 Li Nan           2024-01-25  4623  
242b3580d1a1d0 Li Nan           2024-01-25  4624  	if (clear_md_closing)
242b3580d1a1d0 Li Nan           2024-01-25  4625  		clear_bit(MD_CLOSING, &mddev->flags);
242b3580d1a1d0 Li Nan           2024-01-25  4626  
6791875e2e5393 NeilBrown        2014-12-15  4627  	return err ?: len;
0fd62b861eac7d Neil Brown       2008-06-28  4628  }
80ca3a44f563a7 NeilBrown        2006-07-10  4629  static struct md_sysfs_entry md_array_state =
750f199ee8b578 NeilBrown        2014-09-30  4630  __ATTR_PREALLOC(array_state, S_IRUGO|S_IWUSR, array_state_show, array_state_store);
9e653b6342c940 NeilBrown        2006-06-26  4631  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

