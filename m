Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ECB57FC699
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346404AbjK1U6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 15:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346480AbjK1U6r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 15:58:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBED1BDD;
        Tue, 28 Nov 2023 12:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701205128; x=1732741128;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=svqXuknUfQN8QRePst9SzpFQ/sUKnYFfi2YT176P/kQ=;
  b=MEu5hjsVWGopMdpcKQoV2AdsPQin1kICqrjYH7oO/25q1woMjJpM9apz
   MXFdTXtbJ9DKeMGjJhGnIRIOZuhA64cwYChfPuPmlh3XA9hjBZnAh14vr
   IUF/5VZWsDEgvNy5hbEXCI76iYHSuQiZe2Rgs83qgcNLVfN27JyJ7CWbv
   ibxW8Gx9COPpExynNLI0F04/DROhZZW/veX7Y4gnEsE0CejTiW4QS6Dfo
   uL/PAxa+uRk5/XAt+uhdsdRxtjdgXVrbYh4HypVPgWgQpy4n05cOjbSPU
   ffcY8w+BI67gWSVh197xNcYSB5dIH8zEynMUUyCIixgQbvDHSWEQpMosj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="424174868"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="424174868"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 12:58:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="797697434"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="797697434"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Nov 2023 12:58:44 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r85AH-00084C-23;
        Tue, 28 Nov 2023 20:58:41 +0000
Date:   Wed, 29 Nov 2023 04:49:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Richard <thomas.richard@bootlin.com>, rafael@kernel.org,
        daniel.lezcano@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, rui.zhang@intel.com,
        lukasz.luba@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, theo.lebrun@bootlin.com,
        u-kumar1@ti.com, Thomas Richard <thomas.richard@bootlin.com>
Subject: Re: [PATCH] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
Message-ID: <202311290245.aUcGn8BT-lkp@intel.com>
References: <20231128130332.584127-1-thomas.richard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128130332.584127-1-thomas.richard@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rafael-pm/thermal]
[also build test WARNING on linus/master v6.7-rc3 next-20231128]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Richard/thermal-k3_j72xx_bandgap-implement-suspend-resume-support/20231128-211217
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git thermal
patch link:    https://lore.kernel.org/r/20231128130332.584127-1-thomas.richard%40bootlin.com
patch subject: [PATCH] thermal: k3_j72xx_bandgap: implement suspend/resume support
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231129/202311290245.aUcGn8BT-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231129/202311290245.aUcGn8BT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311290245.aUcGn8BT-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/thermal/k3_j72xx_bandgap.c:554:12: warning: 'k3_j72xx_bandgap_resume' defined but not used [-Wunused-function]
     554 | static int k3_j72xx_bandgap_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/thermal/k3_j72xx_bandgap.c:547:12: warning: 'k3_j72xx_bandgap_suspend' defined but not used [-Wunused-function]
     547 | static int k3_j72xx_bandgap_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/k3_j72xx_bandgap_resume +554 drivers/thermal/k3_j72xx_bandgap.c

   545	
   546	#ifdef CONFIG_PM
 > 547	static int k3_j72xx_bandgap_suspend(struct device *dev)
   548	{
   549		pm_runtime_put_sync(dev);
   550		pm_runtime_disable(dev);
   551		return 0;
   552	}
   553	
 > 554	static int k3_j72xx_bandgap_resume(struct device *dev)
   555	{
   556		struct k3_j72xx_bandgap *bgp = dev_get_drvdata(dev);
   557		int ret;
   558	
   559		pm_runtime_enable(dev);
   560		ret = pm_runtime_get_sync(dev);
   561		if (ret < 0) {
   562			pm_runtime_put_noidle(dev);
   563			pm_runtime_disable(dev);
   564			return ret;
   565		}
   566	
   567		k3_j72xx_bandgap_init_hw(bgp);
   568	
   569		return 0;
   570	}
   571	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
