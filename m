Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B5D767C7D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 08:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbjG2GUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 02:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2GU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:20:28 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECFE49DE;
        Fri, 28 Jul 2023 23:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690611627; x=1722147627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KilZnKa8VA7Yx83gP8wJvBKtAicAoHdiDV19Vm1e/mA=;
  b=lEU1+e9q9JIST/5CkGx214EZgvYvqApR68kA7si3AkwJop8Gjgt1SG6P
   4cphpZJ5WsqLTVLN/Hh4ZtGBzY2DW2OISosEIbLyTOJB+y2MHsiN2q6RM
   9mjpiD4EWSeobnSRmfCezHeM23k34rP6fcKEnNUDojg1qVHCqB9O5bAQR
   TinrLMGnxNikCwaZ+081OBgPnsE5+0QGXG+U1NJk7W0bZte1d4pgiSHgd
   LjdQG8YNZNgYmkQrf8arfDe2ljKJDNB4mJ3rpPTXlmCgtHVy4/f4J6qz0
   8uV4NR0ErKHe084rt7PQguH59b1hKPBwI8KXWhV115/TcgQuWm6a+kZwx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358766504"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="358766504"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 23:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="704815769"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="704815769"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2023 23:20:23 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPdIt-0003sJ-1x;
        Sat, 29 Jul 2023 06:20:00 +0000
Date:   Sat, 29 Jul 2023 14:19:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] of: dynamic: Refactor action prints to not use "%pOF"
 inside devtree_lock
Message-ID: <202307291420.tIsNBqGH-lkp@intel.com>
References: <20230728231950.1619073-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728231950.1619073-1-robh@kernel.org>
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

Hi Rob,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master v6.5-rc3 next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Rob-Herring/of-dynamic-Refactor-action-prints-to-not-use-pOF-inside-devtree_lock/20230729-072155
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20230728231950.1619073-1-robh%40kernel.org
patch subject: [PATCH v3] of: dynamic: Refactor action prints to not use "%pOF" inside devtree_lock
config: powerpc-randconfig-r014-20230728 (https://download.01.org/0day-ci/archive/20230729/202307291420.tIsNBqGH-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307291420.tIsNBqGH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307291420.tIsNBqGH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/of/dynamic.c:74:6: warning: no previous prototype for function 'of_changeset_action_print' [-Wmissing-prototypes]
   void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
        ^
   drivers/of/dynamic.c:74:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
   ^
   static 
   1 warning generated.


vim +/of_changeset_action_print +74 drivers/of/dynamic.c

    73	
  > 74	void of_changeset_action_print(unsigned long action, struct device_node *np, const char *prop_name)
    75	{
    76		if (prop_name)
    77			pr_cont("%-15s %pOF:%s\n", action_names[action], np, prop_name);
    78		else
    79			pr_cont("%-15s %pOF\n", action_names[action], np);
    80	}
    81	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
