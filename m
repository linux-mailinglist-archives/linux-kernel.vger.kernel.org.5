Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A09F27FCE8B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376968AbjK2Fyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2Fye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:54:34 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E110F4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701237281; x=1732773281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DbfyNV7Lodd8LPW5awsvVINXZlDDAEM+ob/HWAfB8+E=;
  b=k4VMUVdMvgmw6ti5a0quU2joQbaJr7Yjy00osp3R6yGpjaPrLnI1MYXh
   gMlFDdd1F5PTmYWOd0B/QUKFE/D0UYB6fP5qKOuBbLKGvOCzy1FwoNWbr
   ElA57g4c3p39bkheG8ByVlC0qNJCMX8m7zMq6wpuZWe4ZElHBtMPF4vIA
   Mk77ehj7cXC8sAUcdHiLNSSBj0hHAexB/y0fBUpyetn5eW6fbNWK1FMYk
   jM5qKYHwZobHE3Qlaow7byEzuUWSADnnpYU4B3cT+GsXC6ogN7Ka+MRTC
   wCnq+YWiQ3FsGa7H15kewV06oasvu3eeTWIWA0qllPMioJANVX6oOK6ln
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="391970113"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="391970113"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 21:54:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="859687442"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="859687442"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Nov 2023 21:54:37 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r8DWt-0008dI-1d;
        Wed, 29 Nov 2023 05:54:35 +0000
Date:   Wed, 29 Nov 2023 13:54:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Tanjore Suresh <tansuresh@google.com>,
        Martin Belanger <Martin.Belanger@dell.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Daniel Wagner <dwagner@suse.de>,
        Keith Busch <kbusch@kernel.org>, Lukas Wunner <lukas@wunner.de>
Cc:     oe-kbuild-all@lists.linux.dev,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH v5] driver core: shut down devices asynchronously
Message-ID: <202311291142.I8HCRjsP-lkp@intel.com>
References: <20231128210436.506510-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128210436.506510-1-stuart.w.hayes@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stuart,

kernel test robot noticed the following build warnings:

[auto build test WARNING on driver-core/driver-core-testing]
[also build test WARNING on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stuart-Hayes/driver-core-shut-down-devices-asynchronously/20231129-055044
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20231128210436.506510-1-stuart.w.hayes%40gmail.com
patch subject: [PATCH v5] driver core: shut down devices asynchronously
config: i386-randconfig-061-20231129 (https://download.01.org/0day-ci/archive/20231129/202311291142.I8HCRjsP-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311291142.I8HCRjsP-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311291142.I8HCRjsP-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/base/core.c:4782:1: sparse: sparse: symbol 'sd_domain' was not declared. Should it be static?
>> drivers/base/core.c:4783:16: sparse: sparse: symbol 'big_shutdown_cookie' was not declared. Should it be static?
   drivers/base/core.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/slab.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/sd_domain +4782 drivers/base/core.c

  4781	
> 4782	ASYNC_DOMAIN(sd_domain);
> 4783	async_cookie_t big_shutdown_cookie;
  4784	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
