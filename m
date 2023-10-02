Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C6D7B5AFE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238513AbjJBTJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjJBTJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:09:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B8AC;
        Mon,  2 Oct 2023 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696273791; x=1727809791;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kiLGI+5TqDC7P7rNtPOhB6kiPKfw3a05asdwO3hr3oc=;
  b=jfozkfJuIMjfdryRXT7HFZF9MeJZlmGxIuH5u8rLrDLjyVbZ7hni3H7+
   CNKNdWlQb5aASRH+cETBFJK8uxIR+BNsxDPYm+Loydl3+m4Kn3cAOq+PK
   088gh59fZcKEd5aTNdOrgRYM1Z35B5fGAT3FhYroZ7ee5CxA+dyVIm1d4
   onvshy/IOKxD53eN31SvRxe3z+4Q+/eD/iih3QMR/+lg4n1Rqxrfvk9x0
   OcHvwzQnSmzMmBDd9Fk1V/GLzWigd2L+34CjHxS+JuipHQOAeTSi9rueR
   znS9fS5lzGtF0Uw2vMFhUZj5rOM+FB9V0PVV3Mv95FVZcvDbUnL7mEbzH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="381585036"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="381585036"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 11:04:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="744186907"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="744186907"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Oct 2023 11:04:20 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qnNHF-0006GF-2W;
        Mon, 02 Oct 2023 18:04:17 +0000
Date:   Tue, 3 Oct 2023 02:03:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v1 03/10] xhci: dbc: Use sysfs_emit() to instead of
 scnprintf()
Message-ID: <202310030150.M1SfrYmG-lkp@intel.com>
References: <20231002161610.2648818-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002161610.2648818-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on usb/usb-testing]
[also build test WARNING on usb/usb-next usb/usb-linus linus/master v6.6-rc4 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/xhci-dbc-Convert-to-use-sysfs_streq/20231003-002032
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
patch link:    https://lore.kernel.org/r/20231002161610.2648818-3-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 03/10] xhci: dbc: Use sysfs_emit() to instead of scnprintf()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231003/202310030150.M1SfrYmG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231003/202310030150.M1SfrYmG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310030150.M1SfrYmG-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/usb/host/xhci-dbgcap.c: In function 'dbc_show':
>> drivers/usb/host/xhci-dbgcap.c:926:34: warning: unused variable 'p' [-Wunused-variable]
     926 |         const char              *p;
         |                                  ^


vim +/p +926 drivers/usb/host/xhci-dbgcap.c

60f4451ef37351 Andy Shevchenko 2023-10-02  921  
dfba2174dc421e Lu Baolu        2017-12-08  922  static ssize_t dbc_show(struct device *dev,
dfba2174dc421e Lu Baolu        2017-12-08  923  			struct device_attribute *attr,
dfba2174dc421e Lu Baolu        2017-12-08  924  			char *buf)
dfba2174dc421e Lu Baolu        2017-12-08  925  {
dfba2174dc421e Lu Baolu        2017-12-08 @926  	const char		*p;
dfba2174dc421e Lu Baolu        2017-12-08  927  	struct xhci_dbc		*dbc;
dfba2174dc421e Lu Baolu        2017-12-08  928  	struct xhci_hcd		*xhci;
dfba2174dc421e Lu Baolu        2017-12-08  929  
dfba2174dc421e Lu Baolu        2017-12-08  930  	xhci = hcd_to_xhci(dev_get_drvdata(dev));
dfba2174dc421e Lu Baolu        2017-12-08  931  	dbc = xhci->dbc;
dfba2174dc421e Lu Baolu        2017-12-08  932  
60f4451ef37351 Andy Shevchenko 2023-10-02  933  	if (dbc->state >= ARRAY_SIZE(dbc_state_strings))
60f4451ef37351 Andy Shevchenko 2023-10-02  934  		return sysfs_emit(buf, "unknown\n");
dfba2174dc421e Lu Baolu        2017-12-08  935  
60f4451ef37351 Andy Shevchenko 2023-10-02  936  	return sysfs_emit(buf, "%s\n", dbc_state_strings[dbc->state]);
dfba2174dc421e Lu Baolu        2017-12-08  937  }
dfba2174dc421e Lu Baolu        2017-12-08  938  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
