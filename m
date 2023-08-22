Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E508784D85
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 01:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjHVXxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 19:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHVXxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 19:53:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF79CFE;
        Tue, 22 Aug 2023 16:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692748433; x=1724284433;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S6aNe+EVKfavzRzFWZfuxF/UFuLG6/wm1koeauKhU4k=;
  b=Ss5CMgSNpoH3K26j02US6iChobLOoQgf+4XxeLr8O9ECCYiKl7VKqjHj
   5W10rWN20Zjm9zjLJZSPGqaqTOaSlg1zfB/9Mu8IEHRa9oLGkTckM0wau
   d+cd8hFMYt5+e5+iTdSfl/jnqAwpeN9hsVeXShW0JySmw9TTy4TZGYkg0
   oKxrk5pczfYlu37LbxbVqlHYpTTNr1f6s02Wbb1BSAUwZ8imhiCzaFg4w
   UbhG/jky3ylRYUqgziJTtRhrr8a5IRuiKaCI9+ERV3bZpEuv6A4g2CKNU
   oSqLW3XsvldGpNx0beM+EtlfpLm1xPd82gbSb55mwaeWeFOabRCuvc0AB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="372909075"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="372909075"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 16:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10810"; a="801884468"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="801884468"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 22 Aug 2023 16:53:50 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qYbC1-0000dE-2w;
        Tue, 22 Aug 2023 23:53:49 +0000
Date:   Wed, 23 Aug 2023 07:53:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        Zhu Wang <wangzhu9@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, dan.carpenter@linaro.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: Re: [PATCH -next] scsi: core: fix double free in
 raid_component_add()
Message-ID: <202308230741.jbMc6KYG-lkp@intel.com>
References: <baecaad7-7124-b9ae-ab79-1b7c6fa95c98@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baecaad7-7124-b9ae-ab79-1b7c6fa95c98@acm.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bart,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[cannot apply to next-20230821 jejb-scsi/for-next linus/master v6.5-rc7 next-20230822]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Bart-Van-Assche/Re-PATCH-next-scsi-core-fix-double-free-in-raid_component_add/20230822-035432
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/baecaad7-7124-b9ae-ab79-1b7c6fa95c98%40acm.org
patch subject: Re: [PATCH -next] scsi: core: fix double free in raid_component_add()
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20230823/202308230741.jbMc6KYG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230823/202308230741.jbMc6KYG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308230741.jbMc6KYG-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/raid_class.c:212:13: warning: 'raid_component_release' defined but not used [-Wunused-function]
     212 | static void raid_component_release(struct device *dev)
         |             ^~~~~~~~~~~~~~~~~~~~~~


vim +/raid_component_release +212 drivers/scsi/raid_class.c

b1081ea6f000de James Bottomley 2005-11-06  211  
ee959b00c335d7 Tony Jones      2008-02-22 @212  static void raid_component_release(struct device *dev)
b1081ea6f000de James Bottomley 2005-11-06  213  {
ee959b00c335d7 Tony Jones      2008-02-22  214  	struct raid_component *rc =
ee959b00c335d7 Tony Jones      2008-02-22  215  		container_of(dev, struct raid_component, dev);
ee959b00c335d7 Tony Jones      2008-02-22  216  	dev_printk(KERN_ERR, rc->dev.parent, "COMPONENT RELEASE\n");
ee959b00c335d7 Tony Jones      2008-02-22  217  	put_device(rc->dev.parent);
b1081ea6f000de James Bottomley 2005-11-06  218  	kfree(rc);
b1081ea6f000de James Bottomley 2005-11-06  219  }
61a7afa2c476a3 James Bottomley 2005-08-16  220  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
