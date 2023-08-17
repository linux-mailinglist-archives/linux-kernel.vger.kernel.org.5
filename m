Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE62A77EEEC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 04:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347615AbjHQCGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 22:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347604AbjHQCF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 22:05:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F402D1FD0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 19:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692237955; x=1723773955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qS88+1x1dNYl+kZ3HVtR/OE/V3f4bomUd0O5kPlz9VE=;
  b=BVpRVVB0822CPiJN17TnpwPMGMO6qHJEfvarypsi+mpySL/RuM2mqBbg
   GUAFTi/keY3O8pZC3P93//+sE2/048QJKE7Jph2QgOyd6YM/vKLvq9a12
   UtR+b3FvG3ZkTZSJ1daamfNVVnJsDqxal4zCJnqQgQXVC1T1m0obuTj4c
   QvuKfck4imbYFuFnIrw2G2QXtov37p3mWztU+sxCSLeQwmNyKXl+IqRxw
   uXiJFng693ZYiuWKlT0uaLafqqPBkk+awWVjUWUJX+JvbUT76d5HQn3Bp
   x/PUVGMudwcogSivgcQgD8NR/4IMviqceQ88RW9sUFFHpsZor77TPrJCo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="370158835"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="370158835"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 19:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="858037664"
X-IronPort-AV: E=Sophos;i="6.01,178,1684825200"; 
   d="scan'208";a="858037664"
Received: from lkp-server02.sh.intel.com (HELO a9caf1a0cf30) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 16 Aug 2023 19:05:53 -0700
Received: from kbuild by a9caf1a0cf30 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qWSOW-0000iX-1B;
        Thu, 17 Aug 2023 02:05:52 +0000
Date:   Thu, 17 Aug 2023 10:05:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>, intel-xe@lists.freedesktop.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Matthew Brost <matthew.brost@intel.com>,
        Thomas =?iso-8859-1?Q?Hellstr=F6m?= 
        <thomas.hellstrom@linux.intel.com>,
        Francois Dugast <francois.dugast@intel.com>,
        linux-kernel@vger.kernel.org, Oak Zeng <oak.zeng@intel.com>,
        Danilo Krummrich <dakr@redhat.com>,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v2] Documentation/gpu: VM_BIND locking document
Message-ID: <202308170916.TGY7kBpM-lkp@intel.com>
References: <20230816091547.2982-1-thomas.hellstrom@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816091547.2982-1-thomas.hellstrom@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on drm-misc/drm-misc-next]
[also build test WARNING on drm/drm-next drm-tip/drm-tip linus/master v6.5-rc6 next-20230816]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Hellstr-m/Documentation-gpu-VM_BIND-locking-document/20230816-171911
base:   git://anongit.freedesktop.org/drm/drm-misc drm-misc-next
patch link:    https://lore.kernel.org/r/20230816091547.2982-1-thomas.hellstrom%40linux.intel.com
patch subject: [PATCH v2] Documentation/gpu: VM_BIND locking document
reproduce: (https://download.01.org/0day-ci/archive/20230817/202308170916.TGY7kBpM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308170916.TGY7kBpM-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Documentation/gpu/drm-vm-bind-locking.rst: WARNING: document isn't included in any toctree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
