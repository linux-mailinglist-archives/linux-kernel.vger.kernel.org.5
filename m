Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359D7FB09A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 04:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjK1DCJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 22:02:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1DCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 22:02:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92601E6;
        Mon, 27 Nov 2023 19:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701140533; x=1732676533;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHfgwWLsu9jzuKtJnQ3BCNFmuSuFaxa27DukiFUuftg=;
  b=L89B5vte26YSR3O+wlziguUYlBrUE0Cru0rGnc5X/J09a3fR1RfXFRw5
   DlAdgz7lUbRivW7XPFVKARXsSDA/d3uzBHfX/rb8KZJLolrC80+gRU8Hp
   cdVK9fy/50J1PfawD1PxRa0wDrva088lDQkhwIZUHe+28Eu8UN54+DScr
   HQyQ6oLdHfWaKqKB16AsdQYvTlNfceyFNQizYjP4p+Tgy/EK3FJ8ZrN9m
   hJ5NASj/PwbRkIn28V7mz9/rGxImxYxNNEwwUARKzQsjPYhfaTSvTwTbm
   /S4jnggwiGkRg2ZU7yws+ytU9mMLSylnbpT/cz21rdDkEfUck8soZSCdd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="457170208"
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="457170208"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 19:02:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,232,1695711600"; 
   d="scan'208";a="16482931"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Nov 2023 19:02:07 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r7oMP-0006v8-1E;
        Tue, 28 Nov 2023 03:02:05 +0000
Date:   Tue, 28 Nov 2023 11:01:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM" 
        <linux-rtc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org, tobrohl@gmail.com, aalsing@gmail.com,
        Dhaval.Giani@amd.com, xmb8dsv4@gmail.com, x86@kernel.org,
        dhaval.giani@gmail.com, Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v3 3/4] rtc: Add support for configuring the UIP timeout
 for RTC reads
Message-ID: <202311280845.YrtuJ0eq-lkp@intel.com>
References: <20231127192553.9734-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127192553.9734-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/rtc-mc146818-lib-Adjust-failure-return-code-for-mc146818_get_time/20231128-032825
base:   2cc14f52aeb78ce3f29677c2de1f06c0e91471ab
patch link:    https://lore.kernel.org/r/20231127192553.9734-4-mario.limonciello%40amd.com
patch subject: [PATCH v3 3/4] rtc: Add support for configuring the UIP timeout for RTC reads
config: i386-randconfig-141-20231128 (https://download.01.org/0day-ci/archive/20231128/202311280845.YrtuJ0eq-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231128/202311280845.YrtuJ0eq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311280845.YrtuJ0eq-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/rtc/rtc-mc146818-lib.c:82:5: warning: format specifies type 'int' but the argument has type 'long' [-Wformat]
                                   UIP_RECHECK_TIMEOUT_MS(i));
                                   ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/printk.h:508:37: note: expanded from macro 'pr_warn'
           printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
                                      ~~~     ^~~~~~~~~~~
   include/linux/printk.h:455:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:427:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   drivers/rtc/rtc-mc146818-lib.c:13:35: note: expanded from macro 'UIP_RECHECK_TIMEOUT_MS'
   #define UIP_RECHECK_TIMEOUT_MS(x)       (x / UIP_RECHECK_DELAY_MS)
                                           ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +82 drivers/rtc/rtc-mc146818-lib.c

    14	
    15	/*
    16	 * Execute a function while the UIP (Update-in-progress) bit of the RTC is
    17	 * unset. The timeout is configurable by the caller in ms.
    18	 *
    19	 * Warning: callback may be executed more then once.
    20	 */
    21	bool mc146818_avoid_UIP(void (*callback)(unsigned char seconds, void *param),
    22				int timeout,
    23				void *param)
    24	{
    25		int i;
    26		unsigned long flags;
    27		unsigned char seconds;
    28	
    29		for (i = 0; i < UIP_RECHECK_TIMEOUT_MS(timeout); i++) {
    30			spin_lock_irqsave(&rtc_lock, flags);
    31	
    32			/*
    33			 * Check whether there is an update in progress during which the
    34			 * readout is unspecified. The maximum update time is ~2ms. Poll
    35			 * for completion.
    36			 *
    37			 * Store the second value before checking UIP so a long lasting
    38			 * NMI which happens to hit after the UIP check cannot make
    39			 * an update cycle invisible.
    40			 */
    41			seconds = CMOS_READ(RTC_SECONDS);
    42	
    43			if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
    44				spin_unlock_irqrestore(&rtc_lock, flags);
    45				udelay(UIP_RECHECK_DELAY);
    46				continue;
    47			}
    48	
    49			/* Revalidate the above readout */
    50			if (seconds != CMOS_READ(RTC_SECONDS)) {
    51				spin_unlock_irqrestore(&rtc_lock, flags);
    52				continue;
    53			}
    54	
    55			if (callback)
    56				callback(seconds, param);
    57	
    58			/*
    59			 * Check for the UIP bit again. If it is set now then
    60			 * the above values may contain garbage.
    61			 */
    62			if (CMOS_READ(RTC_FREQ_SELECT) & RTC_UIP) {
    63				spin_unlock_irqrestore(&rtc_lock, flags);
    64				udelay(UIP_RECHECK_DELAY);
    65				continue;
    66			}
    67	
    68			/*
    69			 * A NMI might have interrupted the above sequence so check
    70			 * whether the seconds value has changed which indicates that
    71			 * the NMI took longer than the UIP bit was set. Unlikely, but
    72			 * possible and there is also virt...
    73			 */
    74			if (seconds != CMOS_READ(RTC_SECONDS)) {
    75				spin_unlock_irqrestore(&rtc_lock, flags);
    76				continue;
    77			}
    78			spin_unlock_irqrestore(&rtc_lock, flags);
    79	
    80			if (i >= UIP_RECHECK_TIMEOUT_MS(100))
    81				pr_warn("Reading current time from RTC took around %d ms\n",
  > 82					UIP_RECHECK_TIMEOUT_MS(i));
    83	
    84			return true;
    85		}
    86		return false;
    87	}
    88	EXPORT_SYMBOL_GPL(mc146818_avoid_UIP);
    89	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
