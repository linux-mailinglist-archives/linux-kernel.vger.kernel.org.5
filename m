Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8047AF7B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 03:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjI0BiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 21:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233614AbjI0BgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 21:36:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2E93C0B;
        Tue, 26 Sep 2023 17:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695775371; x=1727311371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F6Bz04HLwZKmU4V8T935YAaMvZWHmnq0XOLucZBerfg=;
  b=hc3ydvzwzOlirctt9MDlS7J1Z1rXAkU2bz7LLcfDcHV6OVfCOarv+cbm
   qNg8NJ/T09jD9hn4kuzb0cSNtKECribCOjdW6CP7eNwLQTey+5Gza/TFd
   Sh1FjHak7bRx9IYbH7ztKkxpVcCPvqpLXfvINmNREsFuJ8x9gwCy1E/25
   hEvKUkf76jcT1Nx1HCAY2s/mHdDEIAfFD0nwb07mDmvMXyQ5yf+bh20mZ
   fPD6MMZ7VzdIRLd5XHvXVKHY63m6NTgMoYyaMv+4OwdsvQxKhMWe45hrH
   vKgiG/k2XZZaW3MONuEPSh0xfNvh8ok7iovzXeTUgcAOlpz+XenlDXpbD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361081154"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361081154"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 17:42:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="346492"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 26 Sep 2023 17:42:49 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlIda-0003Xj-23;
        Wed, 27 Sep 2023 00:42:46 +0000
Date:   Wed, 27 Sep 2023 08:42:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wang Jinchao <wangjinchao@xfusion.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, stone.xulei@xfusion.com
Subject: Re: [PATCH] padata: Fix the UAF issue related to parallel_data
Message-ID: <202309270829.xHgTOMKw-lkp@intel.com>
References: <ZRE4XvOOhz4HSOgR@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRE4XvOOhz4HSOgR@fedora>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wang,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wang-Jinchao/padata-Fix-the-UAF-issue-related-to-parallel_data/20230925-153852
base:   linus/master
patch link:    https://lore.kernel.org/r/ZRE4XvOOhz4HSOgR%40fedora
patch subject: [PATCH] padata: Fix the UAF issue related to parallel_data
config: i386-randconfig-062-20230925 (https://download.01.org/0day-ci/archive/20230927/202309270829.xHgTOMKw-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270829.xHgTOMKw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270829.xHgTOMKw-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/padata.c:1110:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct refcount_struct [usertype] *r @@     got struct refcount_struct [noderef] __rcu * @@
   kernel/padata.c:1110:38: sparse:     expected struct refcount_struct [usertype] *r
   kernel/padata.c:1110:38: sparse:     got struct refcount_struct [noderef] __rcu *

vim +1110 kernel/padata.c

  1097	
  1098	/**
  1099	 * padata_free_shell - free a padata shell
  1100	 *
  1101	 * @ps: padata shell to free
  1102	 */
  1103	void padata_free_shell(struct padata_shell *ps)
  1104	{
  1105		if (!ps)
  1106			return;
  1107	
  1108		mutex_lock(&ps->pinst->lock);
  1109		list_del(&ps->list);
> 1110		if (refcount_dec_and_test(&ps->pd->refcnt))
  1111			padata_free_pd(rcu_dereference_protected(ps->pd, 1));
  1112		mutex_unlock(&ps->pinst->lock);
  1113	
  1114		kfree(ps);
  1115	}
  1116	EXPORT_SYMBOL(padata_free_shell);
  1117	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
