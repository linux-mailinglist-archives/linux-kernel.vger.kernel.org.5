Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1E67B3203
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbjI2MFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjI2MFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:05:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100721AB;
        Fri, 29 Sep 2023 05:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695989109; x=1727525109;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=V/0cumfX+OsAaqnPW83yEGa05+77v8m/4LPYjgKg3a4=;
  b=Q66q8AFyGCMy1cERDvPkbtNlUcsNKQq/74FEW6fEtJARNzQS7iGB0OTp
   VsgI09qEJIPNDfeMmVOzYuy/t6OQr0i09SpenULecFwPeSu3HQvp8JMa1
   Fn1LxOuya3g1oIfHNLedfHz3jEAoO1EAeVkyvysQLTABWVC17EKV7pEKq
   rxfhe7ir90ungwTD/hIU8HGvDnJjrrD+dXqt4L5FdyTWUkTotQup6z85y
   ONuN9WNk6YLAAxLcnNp7AnQ2qsbEZu3f9sd3U6htQShnkvksZw99hcd+w
   zp0+C8kfxY4kppOQCpLOGjRGq8nvwITSGShpkorNDUwM0d8FkCn19RmRL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="385099112"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="385099112"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 05:05:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="820192780"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="820192780"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 29 Sep 2023 05:05:05 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmCEx-0002px-0W;
        Fri, 29 Sep 2023 12:05:03 +0000
Date:   Fri, 29 Sep 2023 20:04:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc:     oe-kbuild-all@lists.linux.dev,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars@linbit.com>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>,
        Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: Re: [PATCH 1/5] drbd: Rename per-connection "worker" thread to
 "sender"
Message-ID: <202309291915.sFSScoxj-lkp@intel.com>
References: <20230928093852.676786-2-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230928093852.676786-2-christoph.boehmwalder@linbit.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

kernel test robot noticed the following build warnings:

[auto build test WARNING on aa511ff8218b3fb328181fbaac48aa5e9c5c6d93]

url:    https://github.com/intel-lab-lkp/linux/commits/Christoph-B-hmwalder/drbd-Rename-per-connection-worker-thread-to-sender/20230928-174054
base:   aa511ff8218b3fb328181fbaac48aa5e9c5c6d93
patch link:    https://lore.kernel.org/r/20230928093852.676786-2-christoph.boehmwalder%40linbit.com
patch subject: [PATCH 1/5] drbd: Rename per-connection "worker" thread to "sender"
config: i386-randconfig-061-20230929 (https://download.01.org/0day-ci/archive/20230929/202309291915.sFSScoxj-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309291915.sFSScoxj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291915.sFSScoxj-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/block/drbd/drbd_sender.c:618:39: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_sender.c:618:39: sparse:    struct disk_conf [noderef] __rcu *
>> drivers/block/drbd/drbd_sender.c:618:39: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_sender.c:509:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:509:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:509:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_sender.c:510:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_sender.c:510:16: sparse:    struct fifo_buffer [noderef] __rcu *
>> drivers/block/drbd/drbd_sender.c:510:16: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_sender.c:560:13: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:560:13: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:560:13: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_sender.c:564:39: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:564:39: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:564:39: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_sender.c:999:22: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:999:22: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:999:22: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_sender.c:1545:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:1545:32: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:1545:32: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_sender.c:1654:32: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:1654:32: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:1654:32: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_sender.c:1693:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:1693:16: sparse:    struct fifo_buffer [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:1693:16: sparse:    struct fifo_buffer *
   drivers/block/drbd/drbd_sender.c:1722:34: sparse: sparse: incompatible types in comparison expression (different address spaces):
>> drivers/block/drbd/drbd_sender.c:1722:34: sparse:    struct net_conf [noderef] __rcu *
>> drivers/block/drbd/drbd_sender.c:1722:34: sparse:    struct net_conf *
   drivers/block/drbd/drbd_sender.c:1895:38: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:1895:38: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:1895:38: sparse:    struct net_conf *
   drivers/block/drbd/drbd_sender.c:2102:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:2102:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:2102:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_sender.c:2157:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_sender.c:2157:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_sender.c:2157:14: sparse:    struct net_conf *
   drivers/block/drbd/drbd_sender.c:59:25: sparse: sparse: context imbalance in 'drbd_md_endio' - unexpected unlock
   drivers/block/drbd/drbd_sender.c: note: in included file:
   drivers/block/drbd/drbd_int.h:1661:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:1661:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1661:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:1661:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:1661:14: sparse:    struct disk_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:1661:14: sparse:    struct disk_conf *
   drivers/block/drbd/drbd_int.h:2073:14: sparse: sparse: incompatible types in comparison expression (different address spaces):
   drivers/block/drbd/drbd_int.h:2073:14: sparse:    struct net_conf [noderef] __rcu *
   drivers/block/drbd/drbd_int.h:2073:14: sparse:    struct net_conf *

vim +618 drivers/block/drbd/drbd_sender.c

9958c857c760eec drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  495  
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  496  static int drbd_rs_controller(struct drbd_peer_device *peer_device, unsigned int sect_in)
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  497  {
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  498  	struct drbd_device *device = peer_device->device;
daeda1cca91d58b drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  499  	struct disk_conf *dc;
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  500  	unsigned int want;     /* The number of sectors we want in-flight */
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  501  	int req_sect; /* Number of sectors to request in this turn */
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  502  	int correction; /* Number of sectors more we need in-flight */
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  503  	int cps; /* correction per invocation of drbd_rs_controller() */
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  504  	int steps; /* Number of time steps to plan ahead */
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  505  	int curr_corr;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  506  	int max_sect;
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  507  	struct fifo_buffer *plan;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  508  
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  509  	dc = rcu_dereference(device->ldev->disk_conf);
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03 @510  	plan = rcu_dereference(device->rs_plan_s);
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  511  
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  512  	steps = plan->size; /* (dc->c_plan_ahead * 10 * SLEEP_TIME) / HZ; */
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  513  
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  514  	if (device->rs_in_flight + sect_in == 0) { /* At start of resync */
daeda1cca91d58b drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  515  		want = ((dc->resync_rate * 2 * SLEEP_TIME) / HZ) * steps;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  516  	} else { /* normal path */
daeda1cca91d58b drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  517  		want = dc->c_fill_target ? dc->c_fill_target :
daeda1cca91d58b drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  518  			sect_in * dc->c_delay_target * HZ / (SLEEP_TIME * 10);
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  519  	}
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  520  
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  521  	correction = want - device->rs_in_flight - plan->total;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  522  
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  523  	/* Plan ahead */
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  524  	cps = correction / steps;
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  525  	fifo_add_val(plan, cps);
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  526  	plan->total += cps * steps;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  527  
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  528  	/* What we do in this step */
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  529  	curr_corr = fifo_push(plan, 0);
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  530  	plan->total -= curr_corr;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  531  
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  532  	req_sect = sect_in + curr_corr;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  533  	if (req_sect < 0)
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  534  		req_sect = 0;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  535  
daeda1cca91d58b drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  536  	max_sect = (dc->c_max_rate * 2 * SLEEP_TIME) / HZ;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  537  	if (req_sect > max_sect)
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  538  		req_sect = max_sect;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  539  
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  540  	/*
d01801710265cfb drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  541  	drbd_warn(device, "si=%u if=%d wa=%u co=%d st=%d cps=%d pl=%d cc=%d rs=%d\n",
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  542  		 sect_in, device->rs_in_flight, want, correction,
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  543  		 steps, cps, device->rs_planed, curr_corr, req_sect);
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  544  	*/
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  545  
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  546  	return req_sect;
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  547  }
778f271dfe7a717 drivers/block/drbd/drbd_worker.c Philipp Reisner      2010-07-06  548  
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  549  static int drbd_rs_number_requests(struct drbd_peer_device *peer_device)
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  550  {
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  551  	struct drbd_device *device = peer_device->device;
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  552  	unsigned int sect_in;  /* Number of sectors that came in since the last turn */
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  553  	int number, mxb;
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  554  
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  555  	sect_in = atomic_xchg(&device->rs_sect_in, 0);
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  556  	device->rs_in_flight -= sect_in;
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  557  
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  558  	rcu_read_lock();
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  559  	mxb = drbd_get_max_buffers(device) / 2;
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  560  	if (rcu_dereference(device->rs_plan_s)->size) {
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  561  		number = drbd_rs_controller(peer_device, sect_in) >> (BM_BLOCK_SHIFT - 9);
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  562  		device->c_sync_rate = number * HZ * (BM_BLOCK_SIZE / 1024) / SLEEP_TIME;
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  563  	} else {
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  564  		device->c_sync_rate = rcu_dereference(device->ldev->disk_conf)->resync_rate;
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  565  		number = SLEEP_TIME * device->c_sync_rate  / ((BM_BLOCK_SIZE / 1024) * HZ);
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  566  	}
813472ced7fac73 drivers/block/drbd/drbd_worker.c Philipp Reisner      2011-05-03  567  	rcu_read_unlock();
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  568  
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  569  	/* Don't have more than "max-buffers"/2 in-flight.
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  570  	 * Otherwise we may cause the remote site to stall on drbd_alloc_pages(),
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  571  	 * potentially causing a distributed deadlock on congestion during
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  572  	 * online-verify or (checksum-based) resync, if max-buffers,
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  573  	 * socket buffer sizes and resync rate settings are mis-configured. */
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  574  
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  575  	/* note that "number" is in units of "BM_BLOCK_SIZE" (which is 4k),
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  576  	 * mxb (as used here, and in drbd_alloc_pages on the peer) is
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  577  	 * "number of pages" (typically also 4k),
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  578  	 * but "rs_in_flight" is in "sectors" (512 Byte). */
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  579  	if (mxb - device->rs_in_flight/8 < number)
7f34f61490ee87a drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-22  580  		number = mxb - device->rs_in_flight/8;
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  581  
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  582  	return number;
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  583  }
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  584  
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  585  static int make_resync_request(struct drbd_peer_device *const peer_device, int cancel)
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  586  {
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  587  	struct drbd_device *const device = peer_device->device;
44a4d551846b8c6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2013-11-22  588  	struct drbd_connection *const connection = peer_device ? peer_device->connection : NULL;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  589  	unsigned long bit;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  590  	sector_t sector;
155bd9d1abd6049 drivers/block/drbd/drbd_worker.c Christoph Hellwig    2020-09-25  591  	const sector_t capacity = get_capacity(device->vdisk);
1816a2b47afae83 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-11  592  	int max_bio_size;
e65f440d474d7d6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-11-05  593  	int number, rollback_i, size;
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  594  	int align, requeue = 0;
0f0601f4ea2f53c drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-08-11  595  	int i = 0;
92d94ae66aebda5 drivers/block/drbd/drbd_worker.c Philipp Reisner      2016-06-14  596  	int discard_granularity = 0;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  597  
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  598  	if (unlikely(cancel))
99920dc5c5fe521 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-03-16  599  		return 0;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  600  
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  601  	if (device->rs_total == 0) {
af85e8e83d160f7 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-10-07  602  		/* empty resync? */
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  603  		drbd_resync_finished(peer_device);
99920dc5c5fe521 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-03-16  604  		return 0;
af85e8e83d160f7 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-10-07  605  	}
af85e8e83d160f7 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-10-07  606  
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  607  	if (!get_ldev(device)) {
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  608  		/* Since we only need to access device->rsync a
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  609  		   get_ldev_if_state(device,D_FAILED) would be sufficient, but
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  610  		   to continue resync with a broken disk makes no sense at
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  611  		   all */
d01801710265cfb drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  612  		drbd_err(device, "Disk broke down during resync!\n");
99920dc5c5fe521 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-03-16  613  		return 0;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  614  	}
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  615  
9104d31a759fbad drivers/block/drbd/drbd_worker.c Lars Ellenberg       2016-06-14  616  	if (connection->agreed_features & DRBD_FF_THIN_RESYNC) {
92d94ae66aebda5 drivers/block/drbd/drbd_worker.c Philipp Reisner      2016-06-14  617  		rcu_read_lock();
92d94ae66aebda5 drivers/block/drbd/drbd_worker.c Philipp Reisner      2016-06-14 @618  		discard_granularity = rcu_dereference(device->ldev->disk_conf)->rs_discard_granularity;
92d94ae66aebda5 drivers/block/drbd/drbd_worker.c Philipp Reisner      2016-06-14  619  		rcu_read_unlock();
92d94ae66aebda5 drivers/block/drbd/drbd_worker.c Philipp Reisner      2016-06-14  620  	}
92d94ae66aebda5 drivers/block/drbd/drbd_worker.c Philipp Reisner      2016-06-14  621  
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  622  	max_bio_size = queue_max_hw_sectors(device->rq_queue) << 9;
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  623  	number = drbd_rs_number_requests(peer_device);
0e49d7b014c5d59 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-04-28  624  	if (number <= 0)
0f0601f4ea2f53c drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-08-11  625  		goto requeue;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  626  
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  627  	for (i = 0; i < number; i++) {
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  628  		/* Stop generating RS requests when half of the send buffer is filled,
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  629  		 * but notify TCP that we'd like to have more space. */
44a4d551846b8c6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2013-11-22  630  		mutex_lock(&connection->data.mutex);
44a4d551846b8c6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2013-11-22  631  		if (connection->data.socket) {
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  632  			struct sock *sk = connection->data.socket->sk;
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  633  			int queued = sk->sk_wmem_queued;
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  634  			int sndbuf = sk->sk_sndbuf;
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  635  			if (queued > sndbuf / 2) {
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  636  				requeue = 1;
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  637  				if (sk->sk_socket)
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  638  					set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  639  			}
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  640  		} else
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  641  			requeue = 1;
44a4d551846b8c6 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2013-11-22  642  		mutex_unlock(&connection->data.mutex);
506afb6248af577 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2014-01-31  643  		if (requeue)
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  644  			goto requeue;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  645  
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  646  next_sector:
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  647  		size = BM_BLOCK_SIZE;
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  648  		bit  = drbd_bm_find_next(device, device->bm_resync_fo);
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  649  
4b0715f09655e76 drivers/block/drbd/drbd_worker.c Lars Ellenberg       2010-12-14  650  		if (bit == DRBD_END_OF_BITMAP) {
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  651  			device->bm_resync_fo = drbd_bm_bits(device);
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  652  			put_ldev(device);
99920dc5c5fe521 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-03-16  653  			return 0;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  654  		}
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  655  
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  656  		sector = BM_BIT_TO_SECT(bit);
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  657  
0d11f3cf279c5ad drivers/block/drbd/drbd_worker.c Christoph Böhmwalder 2023-03-30  658  		if (drbd_try_rs_begin_io(peer_device, sector)) {
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  659  			device->bm_resync_fo = bit;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  660  			goto requeue;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  661  		}
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  662  		device->bm_resync_fo = bit + 1;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  663  
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  664  		if (unlikely(drbd_bm_test_bit(device, bit) == 0)) {
b30ab7913b0a7b1 drivers/block/drbd/drbd_worker.c Andreas Gruenbacher  2011-07-03  665  			drbd_rs_complete_io(device, sector);
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  666  			goto next_sector;
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  667  		}
b411b3637fa71fc drivers/block/drbd/drbd_worker.c Philipp Reisner      2009-09-25  668  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
