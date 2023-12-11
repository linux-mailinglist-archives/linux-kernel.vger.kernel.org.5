Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9C80D4D8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 19:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345130AbjLKSAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 13:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345098AbjLKSA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 13:00:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E3195;
        Mon, 11 Dec 2023 10:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702317635; x=1733853635;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tMC8yRoYUTc9X1VBTaW/uBj01hskaQ3rsvTliVh20+g=;
  b=m/pa+GbCQP95W6kFjHy1RiZaP4oB1d+/UuNE7c4I589lyimQQMf/065U
   7KIolVfHhMaPPe4eNWMVWvXVQqLqeGomVQrOERZAOWrhALRcxqmjSylI+
   OGz4ewELd3mbEIwu8WAN+qt+JwV+xaj06UfG8tL7B1gNqDJk9CXnphjoe
   TNL3jCROBPl7IMqcXqEhN2hh1OmXHbBADt757voOkUkCofV0EGHcRE9MR
   CUrJjvw2CLovTk+aCs5DEIbrO/jfTbWFj8U29/Qa4zzOd+QSx3UoIAZPb
   bP9c08Hhlz0OC0G8nrIZhxbjx7v7bNQa9MiOcls9Fe8nOythWqXJA8DlK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1830846"
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="1830846"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 10:00:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,268,1695711600"; 
   d="scan'208";a="14578578"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 11 Dec 2023 10:00:30 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rCkZu-000IJl-31;
        Mon, 11 Dec 2023 18:00:27 +0000
Date:   Tue, 12 Dec 2023 02:00:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     linan666@huaweicloud.com, song@kernel.org, axboe@kernel.dk
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linan666@huaweicloud.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Subject: Re: [PATCH 2/2] md: don't account sync_io if iostats of the disk is
 disabled
Message-ID: <202312120159.I03ON8Ov-lkp@intel.com>
References: <20231211075614.1850003-3-linan666@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231211075614.1850003-3-linan666@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on song-md/md-next]
[also build test ERROR on axboe-block/for-next linus/master v6.7-rc5 next-20231211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/linan666-huaweicloud-com/md-Fix-overflow-in-is_mddev_idle/20231211-155833
base:   git://git.kernel.org/pub/scm/linux/kernel/git/song/md.git md-next
patch link:    https://lore.kernel.org/r/20231211075614.1850003-3-linan666%40huaweicloud.com
patch subject: [PATCH 2/2] md: don't account sync_io if iostats of the disk is disabled
config: i386-buildonly-randconfig-003-20231211 (https://download.01.org/0day-ci/archive/20231212/202312120159.I03ON8Ov-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231212/202312120159.I03ON8Ov-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312120159.I03ON8Ov-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from drivers/md/md-faulty.c:60:
>> drivers/md/md.h:587:28: error: character <U+2014> not allowed in an identifier
           if (blk_queue_io_stat(disk—>queue))
                                     ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
   11 errors generated.
--
   In file included from drivers/md/md-bitmap.c:32:
>> drivers/md/md.h:587:28: error: character <U+2014> not allowed in an identifier
           if (blk_queue_io_stat(disk—>queue))
                                     ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md-bitmap.c:2601:34: warning: result of comparison of constant 4294967296 with expression of type 'unsigned long' is always false [-Wtautological-constant-out-of-range-compare]
           if (BITS_PER_LONG > 32 && csize >= (1ULL << (BITS_PER_BYTE *
                                     ~~~~~ ^  ~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning and 11 errors generated.
--
   In file included from drivers/md/md.c:69:
>> drivers/md/md.h:587:28: error: character <U+2014> not allowed in an identifier
           if (blk_queue_io_stat(disk—>queue))
                                     ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.c:8517:29: error: character <U+2014> not allowed in an identifier
                   if (blk_queue_io_stat(disk—>queue))
                                             ^
>> drivers/md/md.c:8517:25: error: use of undeclared identifier 'disk—'
                   if (blk_queue_io_stat(disk—>queue))
                                         ^
>> drivers/md/md.c:8517:33: error: use of undeclared identifier 'queue'
                   if (blk_queue_io_stat(disk—>queue))
                                               ^
>> drivers/md/md.c:8517:25: error: use of undeclared identifier 'disk—'
                   if (blk_queue_io_stat(disk—>queue))
                                         ^
>> drivers/md/md.c:8517:33: error: use of undeclared identifier 'queue'
                   if (blk_queue_io_stat(disk—>queue))
                                               ^
>> drivers/md/md.c:8517:25: error: use of undeclared identifier 'disk—'
                   if (blk_queue_io_stat(disk—>queue))
                                         ^
>> drivers/md/md.c:8517:33: error: use of undeclared identifier 'queue'
                   if (blk_queue_io_stat(disk—>queue))
                                               ^
>> drivers/md/md.c:8517:25: error: use of undeclared identifier 'disk—'
                   if (blk_queue_io_stat(disk—>queue))
                                         ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.
--
   In file included from drivers/md/raid5.c:53:
>> drivers/md/md.h:587:28: error: character <U+2014> not allowed in an identifier
           if (blk_queue_io_stat(disk—>queue))
                                     ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
>> drivers/md/md.h:587:24: error: use of undeclared identifier 'disk—'
           if (blk_queue_io_stat(disk—>queue))
                                 ^
>> drivers/md/md.h:587:32: error: use of undeclared identifier 'queue'
           if (blk_queue_io_stat(disk—>queue))
                                       ^
   drivers/md/raid5.c:4265:7: warning: variable 'qread' set but not used [-Wunused-but-set-variable]
                   int qread =0;
                       ^
   1 warning and 11 errors generated.


vim +587 drivers/md/md.h

   584	
   585	static inline void md_sync_acct_bio(struct bio *bio, unsigned long nr_sectors)
   586	{
 > 587		if (blk_queue_io_stat(disk—>queue))
   588			md_sync_acct(bio->bi_bdev, nr_sectors);
   589	}
   590	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
