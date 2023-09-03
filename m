Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76D4790CEC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245314AbjICQoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 12:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjICQoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 12:44:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72363106
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 09:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693759442; x=1725295442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pmZUF2QTMThaXsXclVpgZx2pLeAxvD/fq6Et1uDsR7g=;
  b=OlQN7uCPnJeXhn0Ry4qlCRXNhIWu3c5Ru1+dFAy7QDoExc+T+jR0AyHX
   XazXQl2bKUzMMHcwMpBKU80tY27PW3jm/X36pjVbdzJeKj9Vb0QLHOaoE
   FU/oLBBqxZWyWvyCirqrl+Emsz4hOslFePRVctgML703BYYOxh3lFgYnU
   qO6BSSuD75LwQ9nrdo8bG1+037cOgBHHte8fxPxqPv8qdC/45QOJPxWGc
   7PYq8fQ7KPn77l40FBCK+caYXZnHtFyuPcXhw0uNdXjlYwD/siXUIS/GJ
   0iofhYtyF+6B1RPgnlFR17AHPPfaAPh7Az0WrHJfIndQI6WuWj5w7Bpz3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="380252280"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="380252280"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2023 09:44:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="1071325093"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="1071325093"
Received: from lkp-server01.sh.intel.com (HELO 5d8055a4f6aa) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 03 Sep 2023 09:43:59 -0700
Received: from kbuild by 5d8055a4f6aa with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qcqCb-0003Hz-1S;
        Sun, 03 Sep 2023 16:43:57 +0000
Date:   Mon, 4 Sep 2023 00:43:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 2/7] printk: nbcon: Add acquire/release logic
Message-ID: <202309040026.yyn4RCk1-lkp@intel.com>
References: <20230903150539.245076-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cb65d08d735e00cc55ad7700a82a453bb88c93a3]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-Add-non-BKL-nbcon-console-basic-infrastructure/20230903-230708
base:   cb65d08d735e00cc55ad7700a82a453bb88c93a3
patch link:    https://lore.kernel.org/r/20230903150539.245076-3-john.ogness%40linutronix.de
patch subject: [PATCH printk v3 2/7] printk: nbcon: Add acquire/release logic
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20230904/202309040026.yyn4RCk1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230904/202309040026.yyn4RCk1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309040026.yyn4RCk1-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/printk/nbcon.c:392: warning: expecting prototype for nbcon_context_try_acquire_hostile(). Prototype was for nbcon_context_acquire_hostile() instead


vim +392 kernel/printk/nbcon.c

   379	
   380	/**
   381	 * nbcon_context_try_acquire_hostile - Acquire via unsafe hostile takeover
   382	 * @ctxt:	The context of the caller
   383	 * @cur:	The current console state
   384	 *
   385	 * @cur is updated to the new console state.
   386	 *
   387	 * The general procedure is to set @prio (forcing ownership). This method
   388	 * must only be used as a final attempt during panic.
   389	 */
   390	static void nbcon_context_acquire_hostile(struct nbcon_context *ctxt,
   391						  struct nbcon_state *cur)
 > 392	{
   393		unsigned int cpu = smp_processor_id();
   394		struct console *con = ctxt->console;
   395		struct nbcon_state new;
   396	
   397		do {
   398			new.atom = cur->atom;
   399			new.cpu			= cpu;
   400			new.prio		= ctxt->prio;
   401			new.unsafe		|= cur->unsafe_takeover;
   402			new.unsafe_takeover	|= cur->unsafe;
   403	
   404		} while (!nbcon_state_try_cmpxchg(con, cur, &new));
   405	
   406		cur->atom = new.atom;
   407	}
   408	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
