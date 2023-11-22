Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A9827F54DC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344548AbjKVXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbjKVXdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:33:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F90710C1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700695958; x=1732231958;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9cJ1ng2mXXK5ewpNB6+ptRqyDKNDtSOkI0dhJ9ArZGk=;
  b=I/n4j+4XTXto0wbfoO+8YjKMVntVcRBuibpf/3wrqSB1C4YDvl4JD0YD
   BJ4gM6VJDjyiFzEebhPXmBZhY+fNNRQWnH4SjW4KInMfPIISIPx7i3YGH
   MZitEs1B8GlCQVM8MNwyFtZvu063KN7h3nbTL7WbNJLVACcgiJ7NCY4hB
   M5RTmTWWFZht5qSj444GfW/Sj9zr1aRMt8YWx/msAGS18Ddyt9gt7sk3e
   8HmD8gq4KeCVMA2YxKjA0IoJOG9bCOdMFG1cbqh8L5x1kizELaSP20pY7
   5+YJYIJDWPRhgWmotEUtmkY2qXzKd9uYSHQpJbh/8oAHlfyuJO5vXIJrN
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="391936056"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="391936056"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 15:32:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760510883"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="760510883"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 22 Nov 2023 15:32:34 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r5whs-0000zI-0s;
        Wed, 22 Nov 2023 23:32:32 +0000
Date:   Thu, 23 Nov 2023 07:32:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, richard@nod.at
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] um: Use swap() instead of open coding it
Message-ID: <202311230408.bRL1q7pc-lkp@intel.com>
References: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122032518.53305-1-jiapeng.chong@linux.alibaba.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

kernel test robot noticed the following build errors:

[auto build test ERROR on wireless-next/main]
[also build test ERROR on linus/master v6.7-rc2 next-20231122]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jiapeng-Chong/um-Use-swap-instead-of-open-coding-it/20231122-113031
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
patch link:    https://lore.kernel.org/r/20231122032518.53305-1-jiapeng.chong%40linux.alibaba.com
patch subject: [PATCH] um: Use swap() instead of open coding it
config: um-randconfig-002-20231122 (https://download.01.org/0day-ci/archive/20231123/202311230408.bRL1q7pc-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231123/202311230408.bRL1q7pc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311230408.bRL1q7pc-lkp@intel.com/

All errors (new ones prefixed by >>):

>> arch/um/os-Linux/sigio.c:80:5: error: call to undeclared function 'swap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      80 |                                 swap(current_poll, next_poll);
         |                                 ^
   arch/um/os-Linux/sigio.c:80:5: note: did you mean 'swab'?
   /usr/include/unistd.h:1168:13: note: 'swab' declared here
    1168 | extern void swab (const void *__restrict __from, void *__restrict __to,
         |             ^
   1 error generated.


vim +/swap +80 arch/um/os-Linux/sigio.c

    50	
    51	static int write_sigio_thread(void *unused)
    52	{
    53		struct pollfds *fds;
    54		struct pollfd *p;
    55		int i, n, respond_fd;
    56		char c;
    57	
    58		os_fix_helper_signals();
    59		fds = &current_poll;
    60		while (1) {
    61			n = poll(fds->poll, fds->used, -1);
    62			if (n < 0) {
    63				if (errno == EINTR)
    64					continue;
    65				printk(UM_KERN_ERR "write_sigio_thread : poll returned "
    66				       "%d, errno = %d\n", n, errno);
    67			}
    68			for (i = 0; i < fds->used; i++) {
    69				p = &fds->poll[i];
    70				if (p->revents == 0)
    71					continue;
    72				if (p->fd == sigio_private[1]) {
    73					CATCH_EINTR(n = read(sigio_private[1], &c,
    74							     sizeof(c)));
    75					if (n != sizeof(c))
    76						printk(UM_KERN_ERR
    77						       "write_sigio_thread : "
    78						       "read on socket failed, "
    79						       "err = %d\n", errno);
  > 80					swap(current_poll, next_poll);
    81					respond_fd = sigio_private[1];
    82				}
    83				else {
    84					respond_fd = write_sigio_fds[1];
    85					fds->used--;
    86					memmove(&fds->poll[i], &fds->poll[i + 1],
    87						(fds->used - i) * sizeof(*fds->poll));
    88				}
    89	
    90				CATCH_EINTR(n = write(respond_fd, &c, sizeof(c)));
    91				if (n != sizeof(c))
    92					printk(UM_KERN_ERR "write_sigio_thread : "
    93					       "write on socket failed, err = %d\n",
    94					       errno);
    95			}
    96		}
    97	
    98		return 0;
    99	}
   100	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
