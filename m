Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A496797F2C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbjIGXUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjIGXUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:20:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4122BD;
        Thu,  7 Sep 2023 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694128842; x=1725664842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ggY/GKEgTVUk5ouzhz7rkBEZ4EGqRqpIw6ao6M925ew=;
  b=IEeq6CAgg6hfote1py/xVUvVmVLDpBuZFyHPK8+lj869mN8GTeCE6P/B
   +2fULnUcd90ekibjrQMfB1ABGJFN2LVWHGumXyTIe5aEv2IJ2nHYUsCRl
   mrOQ/X9Pw+qYRIF1YSq2mebL8rGQLRQI/jQ60lezwKarc2VNBHp44Zx6Q
   Z9cst//ZMSyDOZMFGVlL7V9UHsftt9xSnRsPrzeR9DJu9qIC8E0FZpcWk
   caXwFVrsmLpoail3OjT+u6AGXKzpHGZSvNrbJbWAKfOQDewNLZdY52XEb
   hnLqoL7ZEKungPs8CC/lzbcHf+3T+3z808doPlbra9xbdZGfBTM3UdGlK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="362570430"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="362570430"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2023 16:20:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="718909750"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="718909750"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Sep 2023 16:20:37 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qeOId-0001hP-1n;
        Thu, 07 Sep 2023 23:20:35 +0000
Date:   Fri, 8 Sep 2023 07:20:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lu Hongfei <luhongfei@vivo.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bean Huo <beanhuo@micron.com>,
        Asutosh Das <quic_asutoshd@quicinc.com>,
        "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, opensource.kernel@vivo.com,
        luhongfei@vivo.com
Subject: Re: [PATCH 3/3] scsi: ufs: core: Add exception event handler to
 implicitly handle WB buffer resize event
Message-ID: <202309080739.i8Muq8IT-lkp@intel.com>
References: <20230907094517.1961-1-luhongfei@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907094517.1961-1-luhongfei@vivo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lu,

kernel test robot noticed the following build errors:

[auto build test ERROR on mkp-scsi/for-next]
[also build test ERROR on jejb-scsi/for-next linus/master v6.5 next-20230907]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lu-Hongfei/scsi-ufs-core-allow-host-driver-to-enable-wb-buffer-resize-function/20230907-234105
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20230907094517.1961-1-luhongfei%40vivo.com
patch subject: [PATCH 3/3] scsi: ufs: core: Add exception event handler to implicitly handle WB buffer resize event
config: x86_64-randconfig-r036-20230908 (https://download.01.org/0day-ci/archive/20230908/202309080739.i8Muq8IT-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230908/202309080739.i8Muq8IT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309080739.i8Muq8IT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ufs/core/ufshcd.c: In function 'ufshcd_configure_wb':
   drivers/ufs/core/ufshcd.c:322:19: error: invalid type argument of '->' (have 'struct ufs_dev_info')
     if (hba->dev_info->wspecversion >= 0x410
                      ^~
   drivers/ufs/core/ufshcd.c:323:22: error: invalid type argument of '->' (have 'struct ufs_dev_info')
         && hba->dev_info->b_presrv_uspc_en
                         ^~
   drivers/ufs/core/ufshcd.c:326:3: error: implicit declaration of function 'ufshcd_enable_ee'; did you mean 'ufshcd_enable_irq'? [-Werror=implicit-function-declaration]
      ufshcd_enable_ee(hba, mask);
      ^~~~~~~~~~~~~~~~
      ufshcd_enable_irq
   drivers/ufs/core/ufshcd.c: At top level:
>> drivers/ufs/core/ufshcd.c:5642:19: error: conflicting types for 'ufshcd_enable_ee'
    static inline int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
                      ^~~~~~~~~~~~~~~~
   drivers/ufs/core/ufshcd.c:5643:1: note: an argument type that has a default promotion can't match an empty parameter name list declaration
    {
    ^
   drivers/ufs/core/ufshcd.c:326:3: note: previous implicit declaration of 'ufshcd_enable_ee' was here
      ufshcd_enable_ee(hba, mask);
      ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ufshcd_enable_ee +5642 drivers/ufs/core/ufshcd.c

66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5631  
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5632  /**
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5633   * ufshcd_enable_ee - enable exception event
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5634   * @hba: per-adapter instance
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5635   * @mask: exception event to enable
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5636   *
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5637   * Enable corresponding exception event in the device to allow
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5638   * device to alert host in critical scenarios.
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5639   *
3a17fefe0f1960 drivers/ufs/core/ufshcd.c Bart Van Assche    2023-07-27  5640   * Return: zero on success, non-zero error value on failure.
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5641   */
cd4694756188dc drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-02-09 @5642  static inline int ufshcd_enable_ee(struct ufs_hba *hba, u16 mask)
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5643  {
cd4694756188dc drivers/scsi/ufs/ufshcd.c Adrian Hunter      2021-02-09  5644  	return ufshcd_update_ee_drv_mask(hba, mask, 0);
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5645  }
66ec6d59407baf drivers/scsi/ufs/ufshcd.c Sujit Reddy Thumma 2013-07-30  5646  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
