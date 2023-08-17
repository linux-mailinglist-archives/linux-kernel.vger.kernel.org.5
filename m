Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2C6277F2EB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349375AbjHQJNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349365AbjHQJN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:13:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAFCB8;
        Thu, 17 Aug 2023 02:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692263605; x=1723799605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZINmkco5D4zvjnt45wlcOTjfWOWG/CABUQCqHmGR4Sg=;
  b=Py3kVMbLqXASVvbxqsGGBz1uwJ31WdlAcEkPcwK+cXftnt92qlS3pgF3
   fUgzYh/PevgqFsDsxLPf4NmBtjPoV0TlyWCy9dLwNFMdh/cWNWZHOSxZf
   N6CPFF28cEo6uVvPaYj2KkAgqelYdICn6uW6/UbuzasXk0gP59DqVds0H
   OLg3RTUxUID2kKaQYPiFBOW3jhjFsHBmd+NuMBznLuEIMEnfYTcBI68BP
   7Atp473w6YOGePWuPFg49fQq+akdjEfKK1Rzq0tLHqFZn8TyDy3v4f9fJ
   OiZOfD+tWEvMk8oPKXD/lPSg7UC36E16HidVP7tGOvGw3q8PGxoIOB9ha
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="375522891"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="375522891"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:13:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="763983672"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="763983672"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 17 Aug 2023 02:13:22 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWZ4D-0000ze-2R;
        Thu, 17 Aug 2023 09:13:21 +0000
Date:   Thu, 17 Aug 2023 17:12:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 5/5] gpio: cdev: wake up lineevent poll() on device unbind
Message-ID: <202308171736.864z7YNW-lkp@intel.com>
References: <20230816122032.15548-6-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816122032.15548-6-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.5-rc6 next-20230817]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bartosz-Golaszewski/gpio-cdev-ignore-notifications-other-than-line-status-changes/20230816-202408
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
patch link:    https://lore.kernel.org/r/20230816122032.15548-6-brgl%40bgdev.pl
patch subject: [PATCH 5/5] gpio: cdev: wake up lineevent poll() on device unbind
config: x86_64-randconfig-x016-20230817 (https://download.01.org/0day-ci/archive/20230817/202308171736.864z7YNW-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308171736.864z7YNW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308171736.864z7YNW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/gpio/gpiolib-cdev.c:1835: warning: Function parameter or member 'nb' not described in 'lineevent_state'


vim +1835 drivers/gpio/gpiolib-cdev.c

925ca36913fc7d Kent Gibson         2020-06-16  1807  
925ca36913fc7d Kent Gibson         2020-06-16  1808  /*
925ca36913fc7d Kent Gibson         2020-06-16  1809   * GPIO line event management
925ca36913fc7d Kent Gibson         2020-06-16  1810   */
925ca36913fc7d Kent Gibson         2020-06-16  1811  
925ca36913fc7d Kent Gibson         2020-06-16  1812  /**
925ca36913fc7d Kent Gibson         2020-06-16  1813   * struct lineevent_state - contains the state of a userspace event
925ca36913fc7d Kent Gibson         2020-06-16  1814   * @gdev: the GPIO device the event pertains to
925ca36913fc7d Kent Gibson         2020-06-16  1815   * @label: consumer label used to tag descriptors
925ca36913fc7d Kent Gibson         2020-06-16  1816   * @desc: the GPIO descriptor held by this event
925ca36913fc7d Kent Gibson         2020-06-16  1817   * @eflags: the event flags this line was requested with
925ca36913fc7d Kent Gibson         2020-06-16  1818   * @irq: the interrupt that trigger in response to events on this GPIO
925ca36913fc7d Kent Gibson         2020-06-16  1819   * @wait: wait queue that handles blocking reads of events
925ca36913fc7d Kent Gibson         2020-06-16  1820   * @events: KFIFO for the GPIO events
925ca36913fc7d Kent Gibson         2020-06-16  1821   * @timestamp: cache for the timestamp storing it between hardirq
925ca36913fc7d Kent Gibson         2020-06-16  1822   * and IRQ thread, used to bring the timestamp close to the actual
925ca36913fc7d Kent Gibson         2020-06-16  1823   * event
925ca36913fc7d Kent Gibson         2020-06-16  1824   */
925ca36913fc7d Kent Gibson         2020-06-16  1825  struct lineevent_state {
925ca36913fc7d Kent Gibson         2020-06-16  1826  	struct gpio_device *gdev;
925ca36913fc7d Kent Gibson         2020-06-16  1827  	const char *label;
925ca36913fc7d Kent Gibson         2020-06-16  1828  	struct gpio_desc *desc;
925ca36913fc7d Kent Gibson         2020-06-16  1829  	u32 eflags;
925ca36913fc7d Kent Gibson         2020-06-16  1830  	int irq;
925ca36913fc7d Kent Gibson         2020-06-16  1831  	wait_queue_head_t wait;
925ca36913fc7d Kent Gibson         2020-06-16  1832  	DECLARE_KFIFO(events, struct gpioevent_data, 16);
35c059f377b978 Bartosz Golaszewski 2023-08-16  1833  	struct notifier_block nb;
925ca36913fc7d Kent Gibson         2020-06-16  1834  	u64 timestamp;
925ca36913fc7d Kent Gibson         2020-06-16 @1835  };
925ca36913fc7d Kent Gibson         2020-06-16  1836  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
