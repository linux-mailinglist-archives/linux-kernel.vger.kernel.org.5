Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC79B7AEA59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 12:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234286AbjIZK2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 06:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234200AbjIZK21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 06:28:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D86E5;
        Tue, 26 Sep 2023 03:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695724100; x=1727260100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xvco+exeZgwRDJrrqal2tUOI+h+5Ttj2/k49gkG3aJs=;
  b=XEVkWlXl8qRf/eqIGmLtozVqvCemowAgsQxtuhqDLlaHCGQcv9+d0TCh
   EKIU9j494ZRY0LNyTa7Tf2w9/iOXHLFbRopZvp/km6FxYHHCpidL+J7jP
   F/93iiojnzxw7Hg/x9L8EhgmlElRxune+BR2df7K/pn25LqAPTwox5FFR
   hB/rld3GxJp+L4Bty3VBBGVnPirJSXY92s07j9swKkPQ/EUYjrx368L2t
   wZk72gZg/ZhaabAN/i8Ejv4t4XgGq1n4MHHTcBd1zmqA1WUg5ikbFIohT
   z06GUf0WrDFBbJHViXGd3vVKFLoh6aSJGTzdRjUGmqhLVOY+baV6IEKe3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="448033233"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="448033233"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 03:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="752126418"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="752126418"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 26 Sep 2023 03:28:16 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ql5Ib-0002j5-2W;
        Tue, 26 Sep 2023 10:28:13 +0000
Date:   Tue, 26 Sep 2023 18:28:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rafael@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, lukasz.luba@arm.com,
        dietmar.eggemann@arm.com, rui.zhang@intel.com,
        amit.kucheria@verdurent.com, amit.kachhap@gmail.com,
        daniel.lezcano@linaro.org, viresh.kumar@linaro.org,
        len.brown@intel.com, pavel@ucw.cz, mhiramat@kernel.org,
        qyousef@layalina.io, wvw@google.com
Subject: Re: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans
 the old data
Message-ID: <202309261850.jrucSbN8-lkp@intel.com>
References: <20230925081139.1305766-11-lukasz.luba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925081139.1305766-11-lukasz.luba@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukasz,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on rafael-pm/thermal linus/master v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lukasz-Luba/PM-EM-Add-missing-newline-for-the-message-log/20230925-181243
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
patch link:    https://lore.kernel.org/r/20230925081139.1305766-11-lukasz.luba%40arm.com
patch subject: [PATCH v4 10/18] PM: EM: Add RCU mechanism which safely cleans the old data
config: i386-randconfig-063-20230926 (https://download.01.org/0day-ci/archive/20230926/202309261850.jrucSbN8-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230926/202309261850.jrucSbN8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309261850.jrucSbN8-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/power/energy_model.c:125:13: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct em_perf_table *tmp @@     got struct em_perf_table [noderef] __rcu *runtime_table @@
   kernel/power/energy_model.c:125:13: sparse:     expected struct em_perf_table *tmp
   kernel/power/energy_model.c:125:13: sparse:     got struct em_perf_table [noderef] __rcu *runtime_table

vim +125 kernel/power/energy_model.c

   118	
   119	static void em_perf_runtime_table_set(struct device *dev,
   120					      struct em_perf_table *runtime_table)
   121	{
   122		struct em_perf_domain *pd = dev->em_pd;
   123		struct em_perf_table *tmp;
   124	
 > 125		tmp = pd->runtime_table;
   126	
   127		rcu_assign_pointer(pd->runtime_table, runtime_table);
   128	
   129		em_cpufreq_update_efficiencies(dev, runtime_table->state);
   130	
   131		/* Don't free default table since it's used by other frameworks. */
   132		if (tmp != pd->default_table)
   133			call_rcu(&tmp->rcu, em_destroy_rt_table_rcu);
   134	}
   135	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
