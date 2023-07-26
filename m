Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD20876341C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjGZKna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjGZKn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:43:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1EC268C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690368204; x=1721904204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pbhy/2k+BPQgfb3Z7Fd2cA6VoZ2dLjcGgqZbxBMvl3I=;
  b=bPk2YE70tfyi3Bi9wtmSCFl9THl+WE4RbDAT7rh3IE4M2aNo6RPtxbGh
   dKg4lppalEazLO8ZGi5tP3jmYKxTwfszcEDe3XAW/FYIObhe3lGkNUyU3
   ijETYy+F/e4eJluQJSxVtWTvQ9LVOwS6nfxayFSlM+6WQxg69g4Cszi80
   BjiQo6eASPxngzK6wi25bqMWrcV/30EwAdFu79kmD1zaOnAs3+g4dLcgq
   HmdS1C9KqsUBoi/9+wmexkt4o/7xWWNAV28onWIngAfaZ+0FBgOvNm30L
   tsfH32W1D7etdxHcTCyz1CGusNYIJ/HkratPhCj4mxH0kWRoQ/4JcFF7r
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="365434157"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="365434157"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 03:43:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="1057162526"
X-IronPort-AV: E=Sophos;i="6.01,231,1684825200"; 
   d="scan'208";a="1057162526"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2023 03:43:18 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qObzC-0000tz-0r;
        Wed, 26 Jul 2023 10:43:18 +0000
Date:   Wed, 26 Jul 2023 18:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     oe-kbuild-all@lists.linux.dev, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        alexander.stein@ew.tq-group.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 8/8] firmware: imx: scu-irq: support identifying SCU
 wakeup source from sysfs
Message-ID: <202307261826.ApPjX4A0-lkp@intel.com>
References: <20230724063852.2666930-9-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724063852.2666930-9-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

kernel test robot noticed the following build warnings:

[auto build test WARNING on shawnguo/for-next]
[also build test WARNING on linus/master v6.5-rc3 next-20230726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/firmware-imx-scu-change-init-level-to-subsys_initcall_sync/20230724-143748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
patch link:    https://lore.kernel.org/r/20230724063852.2666930-9-peng.fan%40oss.nxp.com
patch subject: [PATCH V4 8/8] firmware: imx: scu-irq: support identifying SCU wakeup source from sysfs
config: um-randconfig-r073-20230725 (https://download.01.org/0day-ci/archive/20230726/202307261826.ApPjX4A0-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307261826.ApPjX4A0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307261826.ApPjX4A0-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/firmware/imx/imx-scu-irq.c:52:16: sparse: sparse: symbol 'wakeup_obj' was not declared. Should it be static?

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
