Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327367CC4D0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 15:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343660AbjJQNeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 09:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343642AbjJQNeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 09:34:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186D2ED
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 06:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697549662; x=1729085662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0Ff530asQwhzMuaCrXBgBn7hMKrFyVFKwARb+hoQLog=;
  b=iEYMvrwcdc/1QpGaoIE+denGMn68kZtRP+ORNjCpaVwnxvUU1WziEZnH
   UsFT5UvcY7HG/XqgscD5aQXo1lgIpKGkoylM6eAEBe77g8eTPKuE1sXbI
   ya3Duzj/KqTnQNJOk9PbfgsTo3kd1Mr+lp3hlk13PJD4Eyb9hNEL7nwp7
   lK84hfFS3M0uiKe2eaLd3jmP3q2cYrmWcyYBp33R1KtxBi8Gj0iWNELau
   Ku3ZtV6N7ikYafNbARoKxdVDX050WA6GLFIwARj9pax8u/eS+hDCPXVWn
   VOvc9jZXGuQo1fREmsm2OEFYllX8myRV9RpVBrD7+wPj21adqkAVX1hCD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="449999744"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="449999744"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 06:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="749697972"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="749697972"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Oct 2023 06:34:18 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qskD8-0009e1-1K;
        Tue, 17 Oct 2023 13:34:14 +0000
Date:   Tue, 17 Oct 2023 21:33:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, miquel.raynal@bootlin.com,
        conor.culhane@silvaco.com, alexandre.belloni@bootlin.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Cc:     oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/6] i3c: master: svc: fix race condition in ibi work
 thread
Message-ID: <202310172150.4GVdV44X-lkp@intel.com>
References: <20231016153232.2851095-2-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016153232.2851095-2-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc6 next-20231017]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-master-svc-fix-race-condition-in-ibi-work-thread/20231017-151123
base:   linus/master
patch link:    https://lore.kernel.org/r/20231016153232.2851095-2-Frank.Li%40nxp.com
patch subject: [PATCH 1/6] i3c: master: svc: fix race condition in ibi work thread
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231017/202310172150.4GVdV44X-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310172150.4GVdV44X-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310172150.4GVdV44X-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i3c/master/svc-i3c-master.c:207: warning: Function parameter or member 'lock' not described in 'svc_i3c_master'


vim +207 drivers/i3c/master/svc-i3c-master.c

1c5ee2a77b1bacd Clark Wang    2023-05-17  153  
dd3c52846d5954a Miquel Raynal 2021-01-21  154  /**
dd3c52846d5954a Miquel Raynal 2021-01-21  155   * struct svc_i3c_master - Silvaco I3C Master structure
dd3c52846d5954a Miquel Raynal 2021-01-21  156   * @base: I3C master controller
dd3c52846d5954a Miquel Raynal 2021-01-21  157   * @dev: Corresponding device
dd3c52846d5954a Miquel Raynal 2021-01-21  158   * @regs: Memory mapping
5496eac6ad7428f Miquel Raynal 2023-08-17  159   * @saved_regs: Volatile values for PM operations
dd3c52846d5954a Miquel Raynal 2021-01-21  160   * @free_slots: Bit array of available slots
dd3c52846d5954a Miquel Raynal 2021-01-21  161   * @addrs: Array containing the dynamic addresses of each attached device
dd3c52846d5954a Miquel Raynal 2021-01-21  162   * @descs: Array of descriptors, one per attached device
dd3c52846d5954a Miquel Raynal 2021-01-21  163   * @hj_work: Hot-join work
dd3c52846d5954a Miquel Raynal 2021-01-21  164   * @ibi_work: IBI work
dd3c52846d5954a Miquel Raynal 2021-01-21  165   * @irq: Main interrupt
dd3c52846d5954a Miquel Raynal 2021-01-21  166   * @pclk: System clock
dd3c52846d5954a Miquel Raynal 2021-01-21  167   * @fclk: Fast clock (bus)
dd3c52846d5954a Miquel Raynal 2021-01-21  168   * @sclk: Slow clock (other events)
dd3c52846d5954a Miquel Raynal 2021-01-21  169   * @xferqueue: Transfer queue structure
dd3c52846d5954a Miquel Raynal 2021-01-21  170   * @xferqueue.list: List member
dd3c52846d5954a Miquel Raynal 2021-01-21  171   * @xferqueue.cur: Current ongoing transfer
dd3c52846d5954a Miquel Raynal 2021-01-21  172   * @xferqueue.lock: Queue lock
dd3c52846d5954a Miquel Raynal 2021-01-21  173   * @ibi: IBI structure
dd3c52846d5954a Miquel Raynal 2021-01-21  174   * @ibi.num_slots: Number of slots available in @ibi.slots
dd3c52846d5954a Miquel Raynal 2021-01-21  175   * @ibi.slots: Available IBI slots
dd3c52846d5954a Miquel Raynal 2021-01-21  176   * @ibi.tbq_slot: To be queued IBI slot
dd3c52846d5954a Miquel Raynal 2021-01-21  177   * @ibi.lock: IBI lock
dd3c52846d5954a Miquel Raynal 2021-01-21  178   */
dd3c52846d5954a Miquel Raynal 2021-01-21  179  struct svc_i3c_master {
dd3c52846d5954a Miquel Raynal 2021-01-21  180  	struct i3c_master_controller base;
dd3c52846d5954a Miquel Raynal 2021-01-21  181  	struct device *dev;
dd3c52846d5954a Miquel Raynal 2021-01-21  182  	void __iomem *regs;
1c5ee2a77b1bacd Clark Wang    2023-05-17  183  	struct svc_i3c_regs_save saved_regs;
dd3c52846d5954a Miquel Raynal 2021-01-21  184  	u32 free_slots;
dd3c52846d5954a Miquel Raynal 2021-01-21  185  	u8 addrs[SVC_I3C_MAX_DEVS];
dd3c52846d5954a Miquel Raynal 2021-01-21  186  	struct i3c_dev_desc *descs[SVC_I3C_MAX_DEVS];
dd3c52846d5954a Miquel Raynal 2021-01-21  187  	struct work_struct hj_work;
dd3c52846d5954a Miquel Raynal 2021-01-21  188  	struct work_struct ibi_work;
dd3c52846d5954a Miquel Raynal 2021-01-21  189  	int irq;
dd3c52846d5954a Miquel Raynal 2021-01-21  190  	struct clk *pclk;
dd3c52846d5954a Miquel Raynal 2021-01-21  191  	struct clk *fclk;
dd3c52846d5954a Miquel Raynal 2021-01-21  192  	struct clk *sclk;
dd3c52846d5954a Miquel Raynal 2021-01-21  193  	struct {
dd3c52846d5954a Miquel Raynal 2021-01-21  194  		struct list_head list;
dd3c52846d5954a Miquel Raynal 2021-01-21  195  		struct svc_i3c_xfer *cur;
dd3c52846d5954a Miquel Raynal 2021-01-21  196  		/* Prevent races between transfers */
dd3c52846d5954a Miquel Raynal 2021-01-21  197  		spinlock_t lock;
dd3c52846d5954a Miquel Raynal 2021-01-21  198  	} xferqueue;
dd3c52846d5954a Miquel Raynal 2021-01-21  199  	struct {
dd3c52846d5954a Miquel Raynal 2021-01-21  200  		unsigned int num_slots;
dd3c52846d5954a Miquel Raynal 2021-01-21  201  		struct i3c_dev_desc **slots;
dd3c52846d5954a Miquel Raynal 2021-01-21  202  		struct i3c_ibi_slot *tbq_slot;
dd3c52846d5954a Miquel Raynal 2021-01-21  203  		/* Prevent races within IBI handlers */
dd3c52846d5954a Miquel Raynal 2021-01-21  204  		spinlock_t lock;
dd3c52846d5954a Miquel Raynal 2021-01-21  205  	} ibi;
f32ae0219a47f74 Frank Li      2023-10-16  206  	struct mutex lock;
dd3c52846d5954a Miquel Raynal 2021-01-21 @207  };
dd3c52846d5954a Miquel Raynal 2021-01-21  208  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
