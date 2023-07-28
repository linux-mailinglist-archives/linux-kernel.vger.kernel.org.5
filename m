Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D44766155
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 03:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjG1Bec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 21:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjG1Bea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 21:34:30 -0400
Received: from mgamail.intel.com (unknown [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F355A3582
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 18:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690508069; x=1722044069;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6wlLj8BFvHmDQR+TDTcQECjekVj2ofKEnS1/o1aya9U=;
  b=C8NIq+mVCo4jdWQZDP8jpjfkk4rk4QK+3UVvFa9Xx+6K/5ngkRE4MpSO
   eywgOPloI2M1NXZya7tCf00lVsukIyTc2p0GEbR7yDrDq6cj+33d3mCoW
   xmiboNrjaa8S+45uV+mToj7zmNsN3IOYkdqo5uS7aDXVR9PINNbt2HaoH
   nhGcve9IEMunbJP/TFUVu0Q8A0fqy+uHQ6uLaDjYYFDOumIS9+TgB1EyZ
   8t8Q4dIlgQ/T62JyXk39m/CphPWKHntJaOxl3rdT7BTk9oqJA9Jw4hDrh
   l81TDPoYGixDtQ3VH/uNZdk+PxeIiGz+TBsp7HxlcE439l9hGwcuf75vE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="399417270"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="399417270"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 18:34:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="901043596"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="901043596"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 18:34:24 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPCN4-0002l7-19;
        Fri, 28 Jul 2023 01:34:22 +0000
Date:   Fri, 28 Jul 2023 09:33:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 5/8] printk: nbcon: Add sequence handling
Message-ID: <202307280939.4IPb76dh-lkp@intel.com>
References: <20230728000233.50887-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 132a90d1527fedba2d95085c951ccf00dbbebe41]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ogness/printk-Add-non-BKL-nbcon-console-basic-infrastructure/20230728-080545
base:   132a90d1527fedba2d95085c951ccf00dbbebe41
patch link:    https://lore.kernel.org/r/20230728000233.50887-6-john.ogness%40linutronix.de
patch subject: [PATCH printk v2 5/8] printk: nbcon: Add sequence handling
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230728/202307280939.4IPb76dh-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307280939.4IPb76dh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307280939.4IPb76dh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> kernel/printk/printk_nbcon.c:168: warning: expecting prototype for nbcon_read_seq(). Prototype was for nbcon_seq_read() instead
   kernel/printk/printk_nbcon.c:182: warning: Function parameter or member 'seq' not described in 'nbcon_seq_force'


vim +168 kernel/printk/printk_nbcon.c

   160	
   161	/**
   162	 * nbcon_read_seq - Read the current console sequence
   163	 * @con:	Console to read the sequence of
   164	 *
   165	 * Return:	Sequence number of the next record to print on @con.
   166	 */
   167	u64 nbcon_seq_read(struct console *con)
 > 168	{
   169		unsigned long seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
   170	
   171		return __nbcon_seq_to_full(seq);
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
