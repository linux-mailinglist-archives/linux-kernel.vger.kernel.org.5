Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA8790141
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 19:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbjIARPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 13:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232606AbjIARPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 13:15:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E063A10E4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 10:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693588526; x=1725124526;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6kECMR3TsoTyX6e3AyBY/WAprVQoVnA4ZZcOQNyGCpQ=;
  b=minA6nIixmSkPjkIIbMdX74WMFGbn+TuOhijQPN4MDzzuOukT3sBdhot
   t70Rmijp+zOfPlIcSp+WZsYHMGcm8BakFcSVMXPKNA0OAn0h9CiNk1DMg
   vGsKpqe89fySJ/sw93+ZzDHpQr9ErgYU4QtoUDAzc1UZ8VtwRTnMgXyOF
   TZsWwNu6JxCRI7TNbXmFy2TOOY0TlpeVug17cZQoZRzebRn4Cs6yNOe6V
   QhZmhjvRSoZNAvbRfv1CVDB5/+/N7OvznwIII2ozcfCz9yRYNwnt7atfT
   rZxqnwMLo4TYg9N7oVt8Ryz03Ygm40bsrQgii1FCavmWEAq/NSgb57cUT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="361290934"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="361290934"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 10:14:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883251213"
X-IronPort-AV: E=Sophos;i="6.02,220,1688454000"; 
   d="scan'208";a="883251213"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 01 Sep 2023 10:14:50 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qc7jK-0001VW-22;
        Fri, 01 Sep 2023 17:14:46 +0000
Date:   Sat, 2 Sep 2023 01:14:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Earl Chew <earl.chew@yahoo.ca>, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        peter@hurleysoftware.com, earl.chew@yahoo.ca
Subject: Re: [PATCH 2/3] tty: Serialise racing tiocspgrp() callers
Message-ID: <202309020016.GL35iYlP-lkp@intel.com>
References: <20230901015030.2469062-3-earl.chew@yahoo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901015030.2469062-3-earl.chew@yahoo.ca>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Earl,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus linus/master v6.5 next-20230831]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Earl-Chew/tty-Serialise-racing-tiocspgrp-callers/20230901-095411
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20230901015030.2469062-3-earl.chew%40yahoo.ca
patch subject: [PATCH 2/3] tty: Serialise racing tiocspgrp() callers
config: mips-randconfig-r025-20230901 (https://download.01.org/0day-ci/archive/20230902/202309020016.GL35iYlP-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230902/202309020016.GL35iYlP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309020016.GL35iYlP-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/tty/tty_jobctrl.c:35: warning: Function parameter or member 'ctrl_lock' not described in '__tty_check_change_locked'
>> drivers/tty/tty_jobctrl.c:35: warning: expecting prototype for __tty_check_change(). Prototype was for __tty_check_change_locked() instead


vim +35 drivers/tty/tty_jobctrl.c

a1235b3eb10086b Nicolas Pitre 2017-04-12  21  
a1235b3eb10086b Nicolas Pitre 2017-04-12  22  /**
6ef6785d781e9ce Lee Jones     2021-05-20  23   *	__tty_check_change	-	check for POSIX terminal changes
a1235b3eb10086b Nicolas Pitre 2017-04-12  24   *	@tty: tty to check
bc38fe241bc320f Lee Jones     2020-11-04  25   *	@sig: signal to send
a1235b3eb10086b Nicolas Pitre 2017-04-12  26   *
a1235b3eb10086b Nicolas Pitre 2017-04-12  27   *	If we try to write to, or set the state of, a terminal and we're
a1235b3eb10086b Nicolas Pitre 2017-04-12  28   *	not in the foreground, send a SIGTTOU.  If the signal is blocked or
a1235b3eb10086b Nicolas Pitre 2017-04-12  29   *	ignored, go ahead and perform the operation.  (POSIX 7.2)
a1235b3eb10086b Nicolas Pitre 2017-04-12  30   *
64d608db38ffc0c Jiri Slaby    2021-05-05  31   *	Locking: ctrl.lock
a1235b3eb10086b Nicolas Pitre 2017-04-12  32   */
9aa37b12858f4bd Earl Chew     2023-08-31  33  static int __tty_check_change_locked(struct tty_struct *tty, int sig,
9aa37b12858f4bd Earl Chew     2023-08-31  34  				     spinlock_t *ctrl_lock)
a1235b3eb10086b Nicolas Pitre 2017-04-12 @35  {
a1235b3eb10086b Nicolas Pitre 2017-04-12  36  	unsigned long flags;
a1235b3eb10086b Nicolas Pitre 2017-04-12  37  	struct pid *pgrp, *tty_pgrp;
a1235b3eb10086b Nicolas Pitre 2017-04-12  38  	int ret = 0;
a1235b3eb10086b Nicolas Pitre 2017-04-12  39  
9aa37b12858f4bd Earl Chew     2023-08-31  40  	BUG_ON(ctrl_lock && (
9aa37b12858f4bd Earl Chew     2023-08-31  41  	       ctrl_lock != &tty->ctrl.lock || !spin_is_locked(ctrl_lock)));
9aa37b12858f4bd Earl Chew     2023-08-31  42  
a1235b3eb10086b Nicolas Pitre 2017-04-12  43  	if (current->signal->tty != tty)
a1235b3eb10086b Nicolas Pitre 2017-04-12  44  		return 0;
a1235b3eb10086b Nicolas Pitre 2017-04-12  45  
a1235b3eb10086b Nicolas Pitre 2017-04-12  46  	rcu_read_lock();
a1235b3eb10086b Nicolas Pitre 2017-04-12  47  	pgrp = task_pgrp(current);
a1235b3eb10086b Nicolas Pitre 2017-04-12  48  
9aa37b12858f4bd Earl Chew     2023-08-31  49  	if (!ctrl_lock)
64d608db38ffc0c Jiri Slaby    2021-05-05  50  		spin_lock_irqsave(&tty->ctrl.lock, flags);
64d608db38ffc0c Jiri Slaby    2021-05-05  51  	tty_pgrp = tty->ctrl.pgrp;
a1235b3eb10086b Nicolas Pitre 2017-04-12  52  
cf90c06f8115016 David Emett   2019-03-10  53  	if (tty_pgrp && pgrp != tty_pgrp) {
a1235b3eb10086b Nicolas Pitre 2017-04-12  54  		if (is_ignored(sig)) {
a1235b3eb10086b Nicolas Pitre 2017-04-12  55  			if (sig == SIGTTIN)
a1235b3eb10086b Nicolas Pitre 2017-04-12  56  				ret = -EIO;
a1235b3eb10086b Nicolas Pitre 2017-04-12  57  		} else if (is_current_pgrp_orphaned())
a1235b3eb10086b Nicolas Pitre 2017-04-12  58  			ret = -EIO;
a1235b3eb10086b Nicolas Pitre 2017-04-12  59  		else {
a1235b3eb10086b Nicolas Pitre 2017-04-12  60  			kill_pgrp(pgrp, sig, 1);
a1235b3eb10086b Nicolas Pitre 2017-04-12  61  			set_thread_flag(TIF_SIGPENDING);
a1235b3eb10086b Nicolas Pitre 2017-04-12  62  			ret = -ERESTARTSYS;
a1235b3eb10086b Nicolas Pitre 2017-04-12  63  		}
a1235b3eb10086b Nicolas Pitre 2017-04-12  64  	}
9aa37b12858f4bd Earl Chew     2023-08-31  65  	if (!ctrl_lock)
03beb0c7227a52e Earl Chew     2023-08-31  66  		spin_unlock_irqrestore(&tty->ctrl.lock, flags);
a1235b3eb10086b Nicolas Pitre 2017-04-12  67  	rcu_read_unlock();
a1235b3eb10086b Nicolas Pitre 2017-04-12  68  
a1235b3eb10086b Nicolas Pitre 2017-04-12  69  	if (!tty_pgrp)
a1235b3eb10086b Nicolas Pitre 2017-04-12  70  		tty_warn(tty, "sig=%d, tty->pgrp == NULL!\n", sig);
a1235b3eb10086b Nicolas Pitre 2017-04-12  71  
a1235b3eb10086b Nicolas Pitre 2017-04-12  72  	return ret;
a1235b3eb10086b Nicolas Pitre 2017-04-12  73  }
a1235b3eb10086b Nicolas Pitre 2017-04-12  74  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
