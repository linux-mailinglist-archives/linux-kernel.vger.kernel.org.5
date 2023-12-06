Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D1806AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377245AbjLFJd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:33:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377219AbjLFJdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:33:54 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984EAA4;
        Wed,  6 Dec 2023 01:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JHwqXr5lmTTFavjO2MRnjUVkAwGDsqxx6+HTWHYckfQ=;
  b=pTHTUN0XE8cdSBsBPYg5P1ZMrM1wFfMfZCra70OcnrxHCVCPq4MyzkTU
   f0GNd6iyKwZbTkIHBfc4UHlw34vYa3Qh5JJ0lD9dj16LuCo3Aagop7f+r
   H1V4W+H7qaRzUwcrLdTA93XOmqHh4gvtALQrBqTP89jmIUfRX6ikMh0JV
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,254,1695679200"; 
   d="scan'208";a="140569376"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:33:53 +0100
Date:   Wed, 6 Dec 2023 10:33:54 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dongyun Liu <dongyun.liu3@gmail.com>, minchan@kernel.org,
        senozhatsky@chromium.org, axboe@kernel.dk
cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        lincheng.yang@transsion.com, jiajun.ling@transsion.com,
        ldys2014@foxmail.com, Dongyun Liu <dongyun.liu@transsion.com>
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
 bitmap memory in backing_dev_store (fwd)
Message-ID: <8bb6e568-1c79-6410-5893-781621b71331@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

The warning is because kvfree is used to free memory that was allocated
using kmalloc; kfree would be fine.  But I think that the only way you can
get to out is with bitmap being NULL, so there is no need to free it at
all.

Furthermore, it could be safer in the long term to use different labels
for the different amounts of things that need to be freed, as done in most
other kernel code, rather than using a single label "out".

thanks,
julia

---------- Forwarded message ----------
Date: Wed, 6 Dec 2023 16:08:49 +0800
From: kernel test robot <lkp@intel.com>
To: oe-kbuild@lists.linux.dev
Cc: lkp@intel.com, Julia Lawall <julia.lawall@inria.fr>
Subject: Re: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate
    bitmap memory in backing_dev_store

BCC: lkp@intel.com
CC: oe-kbuild-all@lists.linux.dev
In-Reply-To: <20231130152047.200169-1-dongyun.liu@transsion.com>
References: <20231130152047.200169-1-dongyun.liu@transsion.com>
TO: Dongyun Liu <dongyun.liu3@gmail.com>
TO: minchan@kernel.org
TO: senozhatsky@chromium.org
TO: axboe@kernel.dk
CC: linux-kernel@vger.kernel.org
CC: linux-block@vger.kernel.org
CC: lincheng.yang@transsion.com
CC: jiajun.ling@transsion.com
CC: ldys2014@foxmail.com
CC: Dongyun Liu <dongyun.liu@transsion.com>

Hi Dongyun,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.7-rc4 next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dongyun-Liu/zram-Using-GFP_ATOMIC-instead-of-GFP_KERNEL-to-allocate-bitmap-memory-in-backing_dev_store/20231130-233042
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20231130152047.200169-1-dongyun.liu%40transsion.com
patch subject: [PATCH] zram: Using GFP_ATOMIC instead of GFP_KERNEL to allocate bitmap memory in backing_dev_store
:::::: branch date: 6 days ago
:::::: commit date: 6 days ago
config: i386-randconfig-051-20231201 (https://download.01.org/0day-ci/archive/20231206/202312061559.CDXHSGIQ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20231206/202312061559.CDXHSGIQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Julia Lawall <julia.lawall@inria.fr>
| Closes: https://lore.kernel.org/r/202312061559.CDXHSGIQ-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> drivers/block/zram/zram_drv.c:536:14-15: WARNING kmalloc is used to allocate this memory at line 517

vim +536 drivers/block/zram/zram_drv.c

013bf95a83ec76 Minchan Kim       2017-09-06  459
013bf95a83ec76 Minchan Kim       2017-09-06  460  static ssize_t backing_dev_store(struct device *dev,
013bf95a83ec76 Minchan Kim       2017-09-06  461  		struct device_attribute *attr, const char *buf, size_t len)
013bf95a83ec76 Minchan Kim       2017-09-06  462  {
013bf95a83ec76 Minchan Kim       2017-09-06  463  	char *file_name;
c8bd134a4bddaf Peter Kalauskas   2018-08-21  464  	size_t sz;
013bf95a83ec76 Minchan Kim       2017-09-06  465  	struct file *backing_dev = NULL;
013bf95a83ec76 Minchan Kim       2017-09-06  466  	struct inode *inode;
013bf95a83ec76 Minchan Kim       2017-09-06  467  	struct address_space *mapping;
ee763e2143e79f Christoph Hellwig 2020-11-16  468  	unsigned int bitmap_sz;
1363d4662a0d28 Minchan Kim       2017-09-06  469  	unsigned long nr_pages, *bitmap = NULL;
eed993a0910338 Jan Kara          2023-09-27  470  	struct bdev_handle *bdev_handle = NULL;
013bf95a83ec76 Minchan Kim       2017-09-06  471  	int err;
013bf95a83ec76 Minchan Kim       2017-09-06  472  	struct zram *zram = dev_to_zram(dev);
013bf95a83ec76 Minchan Kim       2017-09-06  473
013bf95a83ec76 Minchan Kim       2017-09-06  474  	file_name = kmalloc(PATH_MAX, GFP_KERNEL);
013bf95a83ec76 Minchan Kim       2017-09-06  475  	if (!file_name)
013bf95a83ec76 Minchan Kim       2017-09-06  476  		return -ENOMEM;
013bf95a83ec76 Minchan Kim       2017-09-06  477
013bf95a83ec76 Minchan Kim       2017-09-06  478  	down_write(&zram->init_lock);
013bf95a83ec76 Minchan Kim       2017-09-06  479  	if (init_done(zram)) {
013bf95a83ec76 Minchan Kim       2017-09-06  480  		pr_info("Can't setup backing device for initialized device\n");
013bf95a83ec76 Minchan Kim       2017-09-06  481  		err = -EBUSY;
013bf95a83ec76 Minchan Kim       2017-09-06  482  		goto out;
013bf95a83ec76 Minchan Kim       2017-09-06  483  	}
013bf95a83ec76 Minchan Kim       2017-09-06  484
e55e1b4831563e Wolfram Sang      2022-08-18  485  	strscpy(file_name, buf, PATH_MAX);
c8bd134a4bddaf Peter Kalauskas   2018-08-21  486  	/* ignore trailing newline */
c8bd134a4bddaf Peter Kalauskas   2018-08-21  487  	sz = strlen(file_name);
c8bd134a4bddaf Peter Kalauskas   2018-08-21  488  	if (sz > 0 && file_name[sz - 1] == '\n')
c8bd134a4bddaf Peter Kalauskas   2018-08-21  489  		file_name[sz - 1] = 0x00;
013bf95a83ec76 Minchan Kim       2017-09-06  490
013bf95a83ec76 Minchan Kim       2017-09-06  491  	backing_dev = filp_open(file_name, O_RDWR|O_LARGEFILE, 0);
013bf95a83ec76 Minchan Kim       2017-09-06  492  	if (IS_ERR(backing_dev)) {
013bf95a83ec76 Minchan Kim       2017-09-06  493  		err = PTR_ERR(backing_dev);
013bf95a83ec76 Minchan Kim       2017-09-06  494  		backing_dev = NULL;
013bf95a83ec76 Minchan Kim       2017-09-06  495  		goto out;
013bf95a83ec76 Minchan Kim       2017-09-06  496  	}
013bf95a83ec76 Minchan Kim       2017-09-06  497
013bf95a83ec76 Minchan Kim       2017-09-06  498  	mapping = backing_dev->f_mapping;
013bf95a83ec76 Minchan Kim       2017-09-06  499  	inode = mapping->host;
013bf95a83ec76 Minchan Kim       2017-09-06  500
013bf95a83ec76 Minchan Kim       2017-09-06  501  	/* Support only block device in this moment */
013bf95a83ec76 Minchan Kim       2017-09-06  502  	if (!S_ISBLK(inode->i_mode)) {
013bf95a83ec76 Minchan Kim       2017-09-06  503  		err = -ENOTBLK;
013bf95a83ec76 Minchan Kim       2017-09-06  504  		goto out;
013bf95a83ec76 Minchan Kim       2017-09-06  505  	}
013bf95a83ec76 Minchan Kim       2017-09-06  506
eed993a0910338 Jan Kara          2023-09-27  507  	bdev_handle = bdev_open_by_dev(inode->i_rdev,
eed993a0910338 Jan Kara          2023-09-27  508  				BLK_OPEN_READ | BLK_OPEN_WRITE, zram, NULL);
eed993a0910338 Jan Kara          2023-09-27  509  	if (IS_ERR(bdev_handle)) {
eed993a0910338 Jan Kara          2023-09-27  510  		err = PTR_ERR(bdev_handle);
eed993a0910338 Jan Kara          2023-09-27  511  		bdev_handle = NULL;
013bf95a83ec76 Minchan Kim       2017-09-06  512  		goto out;
5547932dc67a48 Minchan Kim       2018-12-28  513  	}
013bf95a83ec76 Minchan Kim       2017-09-06  514
1363d4662a0d28 Minchan Kim       2017-09-06  515  	nr_pages = i_size_read(inode) >> PAGE_SHIFT;
1363d4662a0d28 Minchan Kim       2017-09-06  516  	bitmap_sz = BITS_TO_LONGS(nr_pages) * sizeof(long);
e51f2361fc7fd9 Dongyun Liu       2023-11-30 @517  	bitmap = kmalloc(bitmap_sz, GFP_ATOMIC);
1363d4662a0d28 Minchan Kim       2017-09-06  518  	if (!bitmap) {
1363d4662a0d28 Minchan Kim       2017-09-06  519  		err = -ENOMEM;
1363d4662a0d28 Minchan Kim       2017-09-06  520  		goto out;
1363d4662a0d28 Minchan Kim       2017-09-06  521  	}
1363d4662a0d28 Minchan Kim       2017-09-06  522
013bf95a83ec76 Minchan Kim       2017-09-06  523  	reset_bdev(zram);
013bf95a83ec76 Minchan Kim       2017-09-06  524
eed993a0910338 Jan Kara          2023-09-27  525  	zram->bdev_handle = bdev_handle;
013bf95a83ec76 Minchan Kim       2017-09-06  526  	zram->backing_dev = backing_dev;
1363d4662a0d28 Minchan Kim       2017-09-06  527  	zram->bitmap = bitmap;
1363d4662a0d28 Minchan Kim       2017-09-06  528  	zram->nr_pages = nr_pages;
013bf95a83ec76 Minchan Kim       2017-09-06  529  	up_write(&zram->init_lock);
013bf95a83ec76 Minchan Kim       2017-09-06  530
013bf95a83ec76 Minchan Kim       2017-09-06  531  	pr_info("setup backing device %s\n", file_name);
013bf95a83ec76 Minchan Kim       2017-09-06  532  	kfree(file_name);
013bf95a83ec76 Minchan Kim       2017-09-06  533
013bf95a83ec76 Minchan Kim       2017-09-06  534  	return len;
013bf95a83ec76 Minchan Kim       2017-09-06  535  out:
1363d4662a0d28 Minchan Kim       2017-09-06 @536  	kvfree(bitmap);
1363d4662a0d28 Minchan Kim       2017-09-06  537
eed993a0910338 Jan Kara          2023-09-27  538  	if (bdev_handle)
eed993a0910338 Jan Kara          2023-09-27  539  		bdev_release(bdev_handle);
013bf95a83ec76 Minchan Kim       2017-09-06  540
013bf95a83ec76 Minchan Kim       2017-09-06  541  	if (backing_dev)
013bf95a83ec76 Minchan Kim       2017-09-06  542  		filp_close(backing_dev, NULL);
013bf95a83ec76 Minchan Kim       2017-09-06  543
013bf95a83ec76 Minchan Kim       2017-09-06  544  	up_write(&zram->init_lock);
013bf95a83ec76 Minchan Kim       2017-09-06  545
013bf95a83ec76 Minchan Kim       2017-09-06  546  	kfree(file_name);
013bf95a83ec76 Minchan Kim       2017-09-06  547
013bf95a83ec76 Minchan Kim       2017-09-06  548  	return err;
013bf95a83ec76 Minchan Kim       2017-09-06  549  }
013bf95a83ec76 Minchan Kim       2017-09-06  550

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
