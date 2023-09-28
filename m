Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF7A7B26F2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 23:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjI1VAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 17:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232355AbjI1VAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 17:00:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8A21BE
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 14:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695934847; x=1727470847;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RNNJTecZe3lDDdVUo90WNnnwhRxRi0q1fo0uq18yMDg=;
  b=KSHNBqSgOcPlmyLpj1fR47IABofOWBGQWcIiGQHqYADFMg8c5iUxxXiT
   3soXryCyxFdlZ5WKMKDYUnnVJo+lMAYwc/Qnq1LpG8BoYzTJJn8L/ZBbD
   EiNAKbfePDOKjON6ZExNYh2uGDAJCl1ZB4aO1kLm70jdx9Mhduv0Vwie2
   Ty5RcixshIOxityC79SnCKB1TefotxNsg8IsDozYnxMBd4V9B3SaoTQhV
   2Q4KhdFOXc3icZ57gH5OLzG+HwD+IErxm1k55Qwu/nWUlPiAFhXvFM7o6
   tdbGtWQQluZdnx3LQFJLvBhhxi5VpE8PAIQNWDBHMDPB4pXZWAMmbHba1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="782270"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="782270"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 14:00:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="699431537"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="699431537"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Sep 2023 14:00:30 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qly7Y-0001xL-04;
        Thu, 28 Sep 2023 21:00:28 +0000
Date:   Fri, 29 Sep 2023 05:00:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Earl Chew <earl.chew@yahoo.ca>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, peter@hurleysoftware.com,
        earl.chew@yahoo.ca
Subject: Re: [PATCH 2/3] tty: Serialise racing tiocspgrp() callers
Message-ID: <202309290422.8TLHGj3t-lkp@intel.com>
References: <20230901015030.2469062-3-earl.chew@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901015030.2469062-3-earl.chew@yahoo.ca>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Earl-Chew/tty-Serialise-racing-tiocspgrp-callers/20230929-010844
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230901015030.2469062-3-earl.chew%40yahoo.ca
patch subject: [PATCH 2/3] tty: Serialise racing tiocspgrp() callers
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230929/202309290422.8TLHGj3t-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290422.8TLHGj3t-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290422.8TLHGj3t-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/tty_jobctrl.c:35: warning: Function parameter or member 'ctrl_lock' not described in '__tty_check_change_locked'
>> drivers/tty/tty_jobctrl.c:35: warning: expecting prototype for __tty_check_change(). Prototype was for __tty_check_change_locked() instead


vim +35 drivers/tty/tty_jobctrl.c

a1235b3eb10086 Nicolas Pitre 2017-04-12  21  
a1235b3eb10086 Nicolas Pitre 2017-04-12  22  /**
6ef6785d781e9c Lee Jones     2021-05-20  23   *	__tty_check_change	-	check for POSIX terminal changes
a1235b3eb10086 Nicolas Pitre 2017-04-12  24   *	@tty: tty to check
bc38fe241bc320 Lee Jones     2020-11-04  25   *	@sig: signal to send
a1235b3eb10086 Nicolas Pitre 2017-04-12  26   *
a1235b3eb10086 Nicolas Pitre 2017-04-12  27   *	If we try to write to, or set the state of, a terminal and we're
a1235b3eb10086 Nicolas Pitre 2017-04-12  28   *	not in the foreground, send a SIGTTOU.  If the signal is blocked or
a1235b3eb10086 Nicolas Pitre 2017-04-12  29   *	ignored, go ahead and perform the operation.  (POSIX 7.2)
a1235b3eb10086 Nicolas Pitre 2017-04-12  30   *
64d608db38ffc0 Jiri Slaby    2021-05-05  31   *	Locking: ctrl.lock
a1235b3eb10086 Nicolas Pitre 2017-04-12  32   */
99d6f12e388e7a Earl Chew     2023-08-31  33  static int __tty_check_change_locked(struct tty_struct *tty, int sig,
99d6f12e388e7a Earl Chew     2023-08-31  34  				     spinlock_t *ctrl_lock)
a1235b3eb10086 Nicolas Pitre 2017-04-12 @35  {
a1235b3eb10086 Nicolas Pitre 2017-04-12  36  	unsigned long flags;
a1235b3eb10086 Nicolas Pitre 2017-04-12  37  	struct pid *pgrp, *tty_pgrp;
a1235b3eb10086 Nicolas Pitre 2017-04-12  38  	int ret = 0;
a1235b3eb10086 Nicolas Pitre 2017-04-12  39  
99d6f12e388e7a Earl Chew     2023-08-31  40  	BUG_ON(ctrl_lock && (
99d6f12e388e7a Earl Chew     2023-08-31  41  	       ctrl_lock != &tty->ctrl.lock || !spin_is_locked(ctrl_lock)));
99d6f12e388e7a Earl Chew     2023-08-31  42  
a1235b3eb10086 Nicolas Pitre 2017-04-12  43  	if (current->signal->tty != tty)
a1235b3eb10086 Nicolas Pitre 2017-04-12  44  		return 0;
a1235b3eb10086 Nicolas Pitre 2017-04-12  45  
a1235b3eb10086 Nicolas Pitre 2017-04-12  46  	rcu_read_lock();
a1235b3eb10086 Nicolas Pitre 2017-04-12  47  	pgrp = task_pgrp(current);
a1235b3eb10086 Nicolas Pitre 2017-04-12  48  
99d6f12e388e7a Earl Chew     2023-08-31  49  	if (!ctrl_lock)
64d608db38ffc0 Jiri Slaby    2021-05-05  50  		spin_lock_irqsave(&tty->ctrl.lock, flags);
64d608db38ffc0 Jiri Slaby    2021-05-05  51  	tty_pgrp = tty->ctrl.pgrp;
a1235b3eb10086 Nicolas Pitre 2017-04-12  52  
cf90c06f811501 David Emett   2019-03-10  53  	if (tty_pgrp && pgrp != tty_pgrp) {
a1235b3eb10086 Nicolas Pitre 2017-04-12  54  		if (is_ignored(sig)) {
a1235b3eb10086 Nicolas Pitre 2017-04-12  55  			if (sig == SIGTTIN)
a1235b3eb10086 Nicolas Pitre 2017-04-12  56  				ret = -EIO;
a1235b3eb10086 Nicolas Pitre 2017-04-12  57  		} else if (is_current_pgrp_orphaned())
a1235b3eb10086 Nicolas Pitre 2017-04-12  58  			ret = -EIO;
a1235b3eb10086 Nicolas Pitre 2017-04-12  59  		else {
a1235b3eb10086 Nicolas Pitre 2017-04-12  60  			kill_pgrp(pgrp, sig, 1);
a1235b3eb10086 Nicolas Pitre 2017-04-12  61  			set_thread_flag(TIF_SIGPENDING);
a1235b3eb10086 Nicolas Pitre 2017-04-12  62  			ret = -ERESTARTSYS;
a1235b3eb10086 Nicolas Pitre 2017-04-12  63  		}
a1235b3eb10086 Nicolas Pitre 2017-04-12  64  	}
99d6f12e388e7a Earl Chew     2023-08-31  65  	if (!ctrl_lock)
95d3590fbe7aed Earl Chew     2023-08-31  66  		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
a1235b3eb10086 Nicolas Pitre 2017-04-12  67  	rcu_read_unlock();
a1235b3eb10086 Nicolas Pitre 2017-04-12  68  
a1235b3eb10086 Nicolas Pitre 2017-04-12  69  	if (!tty_pgrp)
a1235b3eb10086 Nicolas Pitre 2017-04-12  70  		tty_warn(tty, "sig=%d, tty->pgrp == NULL!\n", sig);
a1235b3eb10086 Nicolas Pitre 2017-04-12  71  
a1235b3eb10086 Nicolas Pitre 2017-04-12  72  	return ret;
a1235b3eb10086 Nicolas Pitre 2017-04-12  73  }
a1235b3eb10086 Nicolas Pitre 2017-04-12  74  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
