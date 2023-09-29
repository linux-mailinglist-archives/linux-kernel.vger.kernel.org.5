Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60E37B2C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbjI2GI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbjI2GIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:08:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6986B1A2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695967703; x=1727503703;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=giAVI+01eW3Y1aSyfY09p6nVoX4nZ7ysOacYBgd2FVk=;
  b=leifIoGNBqoUcacVkGamriFFfb9HBuMaTrK7ELD4kYqAcaQ0Zw64/uAR
   vhCv0OAvBWUdwR/S9sOffgoW6wPjF1SvKgZ6uX7TBrSDrTkaCZkcqzsaJ
   k5BPjOHBzfIpN7GH5jtgbBDBfC25qxSdDBnzDIkiEJXps/ZFnooBWsw2E
   f1dMlHwNpKC1nFI4dUNNGfR5zExJIOMZtw6c3lZ+4e7qs7LWR8cwWfVZM
   YKS9rU4POR4ix3SL4D87CQECV7wuEUdb+QR2ib94JsePRQdfRn0UtOiqt
   NTDm8WFXSktM3IZHyqpj+NCH7vshlVPPnMZo+4jnzdiNCvDFTOJf1s+GW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="446401088"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="446401088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 23:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="779195222"
X-IronPort-AV: E=Sophos;i="6.03,186,1694761200"; 
   d="scan'208";a="779195222"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 28 Sep 2023 23:08:20 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qm6fi-0002XJ-1T;
        Fri, 29 Sep 2023 06:08:18 +0000
Date:   Fri, 29 Sep 2023 14:07:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Earl Chew <earl.chew@yahoo.ca>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, peter@hurleysoftware.com,
        earl.chew@yahoo.ca, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2 2/3] tty: Serialise racing tiocspgrp() callers
Message-ID: <202309291311.hbeO1nmm-lkp@intel.com>
References: <20230928130658.4045344-3-earl.chew@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928130658.4045344-3-earl.chew@yahoo.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Earl,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Earl-Chew/tty-Fix-__tty_check_change-and-tiocspgrp-race/20230929-010931
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230928130658.4045344-3-earl.chew%40yahoo.ca
patch subject: [PATCH v2 2/3] tty: Serialise racing tiocspgrp() callers
config: i386-randconfig-062-20230929 (https://download.01.org/0day-ci/archive/20230929/202309291311.hbeO1nmm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309291311.hbeO1nmm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309291311.hbeO1nmm-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/tty/tty_jobctrl.c:83:52: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/tty_jobctrl.c:88:45: sparse: sparse: Using plain integer as NULL pointer
   drivers/tty/tty_jobctrl.c:97:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:97:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:97:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:100:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:100:34: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:100:34: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:141:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:141:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:141:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:143:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:143:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:143:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:152:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:152:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:152:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:173:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:173:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:173:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:182:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:182:9: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:182:9: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:184:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:184:40: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:184:40: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:222:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:222:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:222:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:232:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:232:51: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:232:51: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:244:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:244:43: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:244:43: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:308:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:308:39: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:308:39: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:311:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:311:41: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:311:41: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:340:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:340:31: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:340:31: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:343:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct spinlock [usertype] *lock @@     got struct spinlock [noderef] __rcu * @@
   drivers/tty/tty_jobctrl.c:343:33: sparse:     expected struct spinlock [usertype] *lock
   drivers/tty/tty_jobctrl.c:343:33: sparse:     got struct spinlock [noderef] __rcu *
   drivers/tty/tty_jobctrl.c:19:41: sparse: sparse: dereference of noderef expression
   drivers/tty/tty_jobctrl.c: note: in included file (through include/linux/rculist.h, include/linux/sched/signal.h):
   include/linux/rcupdate.h:778:9: sparse: sparse: context imbalance in '__tty_check_change_locked' - different lock contexts for basic block

vim +83 drivers/tty/tty_jobctrl.c

    80	
    81	int __tty_check_change(struct tty_struct *tty, int sig)
    82	{
  > 83		return __tty_check_change_locked(tty, sig, 0);
    84	}
    85	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
