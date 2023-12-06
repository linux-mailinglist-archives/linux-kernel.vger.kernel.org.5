Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC77880797D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379559AbjLFUg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjLFUgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:36:55 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5FC193;
        Wed,  6 Dec 2023 12:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701895021; x=1733431021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TwXpWojOhICMzsUQAhDkNa70jLFpVVHewOVhowSZa7o=;
  b=aZHdcJstS5XRUr+IikgFDSUwjjW7Fi8VSs9g2Ac+OUv52c2dRkCPLQDq
   ANb6o4L3cjWe7XUFVnB0R0YboR/5JNtC9efwtmYAfLsYCx5zQ07K9hKVO
   DtUv8E+H9b0SO5VtcNVbTfkJmarOfVkxNnw2dQwk7dASje4dX24NruwCx
   kuXWSBs+ENrIcWUKQEqyC0bL9HeCnJ3GsLfWS7QcwYkZeTZxHASfaIaTc
   dsZyPR75vWaEETvsh58mTCsVh2mWyvZsVx2GxvKUkhLyCeOdgbouPbO7a
   3k3VqcqGEQqyh2ap4sPySNiz5Oun5F5xN9sQPAlcRONpZM5alwMKSB+kY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1192491"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1192491"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:37:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="12844066"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 06 Dec 2023 12:36:58 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAydb-000BOg-0V;
        Wed, 06 Dec 2023 20:36:55 +0000
Date:   Thu, 7 Dec 2023 04:36:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jensen Huang <jensenhuang@friendlyarm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andi Shyti <andi.shyti@kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i2c: rk3x: fix potential spinlock recursion on poll
Message-ID: <202312070421.Lccd0PSI-lkp@intel.com>
References: <20231206090641.18849-1-jensenhuang@friendlyarm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206090641.18849-1-jensenhuang@friendlyarm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jensen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linus/master v6.7-rc4 next-20231206]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jensen-Huang/i2c-rk3x-fix-potential-spinlock-recursion-on-poll/20231206-170807
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20231206090641.18849-1-jensenhuang%40friendlyarm.com
patch subject: [PATCH] i2c: rk3x: fix potential spinlock recursion on poll
config: arc-randconfig-r081-20231206 (https://download.01.org/0day-ci/archive/20231207/202312070421.Lccd0PSI-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231207/202312070421.Lccd0PSI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312070421.Lccd0PSI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-rk3x.c:223: warning: Function parameter or member 'irq' not described in 'rk3x_i2c'


vim +223 drivers/i2c/busses/i2c-rk3x.c

c41aa3ce938b68 Max Schwarz  2014-06-11  171  
0a6ad2f95f36bf David Wu     2016-05-16  172  /**
0a6ad2f95f36bf David Wu     2016-05-16  173   * struct rk3x_i2c - private data of the controller
0a6ad2f95f36bf David Wu     2016-05-16  174   * @adap: corresponding I2C adapter
0a6ad2f95f36bf David Wu     2016-05-16  175   * @dev: device for this controller
0a6ad2f95f36bf David Wu     2016-05-16  176   * @soc_data: related soc data struct
0a6ad2f95f36bf David Wu     2016-05-16  177   * @regs: virtual memory area
7e086c3fc2df09 David Wu     2016-05-16  178   * @clk: function clk for rk3399 or function & Bus clks for others
7e086c3fc2df09 David Wu     2016-05-16  179   * @pclk: Bus clk for rk3399
0a6ad2f95f36bf David Wu     2016-05-16  180   * @clk_rate_nb: i2c clk rate change notify
0a6ad2f95f36bf David Wu     2016-05-16  181   * @t: I2C known timing information
0a6ad2f95f36bf David Wu     2016-05-16  182   * @lock: spinlock for the i2c bus
0a6ad2f95f36bf David Wu     2016-05-16  183   * @wait: the waitqueue to wait for i2c transfer
0a6ad2f95f36bf David Wu     2016-05-16  184   * @busy: the condition for the event to wait for
0a6ad2f95f36bf David Wu     2016-05-16  185   * @msg: current i2c message
0a6ad2f95f36bf David Wu     2016-05-16  186   * @addr: addr of i2c slave device
0a6ad2f95f36bf David Wu     2016-05-16  187   * @mode: mode of i2c transfer
0a6ad2f95f36bf David Wu     2016-05-16  188   * @is_last_msg: flag determines whether it is the last msg in this transfer
0a6ad2f95f36bf David Wu     2016-05-16  189   * @state: state of i2c transfer
0a6ad2f95f36bf David Wu     2016-05-16  190   * @processed: byte length which has been send or received
0a6ad2f95f36bf David Wu     2016-05-16  191   * @error: error code for i2c transfer
0a6ad2f95f36bf David Wu     2016-05-16  192   */
c41aa3ce938b68 Max Schwarz  2014-06-11  193  struct rk3x_i2c {
c41aa3ce938b68 Max Schwarz  2014-06-11  194  	struct i2c_adapter adap;
c41aa3ce938b68 Max Schwarz  2014-06-11  195  	struct device *dev;
d032a2eb2e3b9f Julia Lawall 2018-01-02  196  	const struct rk3x_i2c_soc_data *soc_data;
c41aa3ce938b68 Max Schwarz  2014-06-11  197  
c41aa3ce938b68 Max Schwarz  2014-06-11  198  	/* Hardware resources */
c41aa3ce938b68 Max Schwarz  2014-06-11  199  	void __iomem *regs;
c41aa3ce938b68 Max Schwarz  2014-06-11  200  	struct clk *clk;
7e086c3fc2df09 David Wu     2016-05-16  201  	struct clk *pclk;
249051f49907e7 Max Schwarz  2014-11-20  202  	struct notifier_block clk_rate_nb;
58bb392dd4c7fc Jensen Huang 2023-12-06  203  	int irq;
c41aa3ce938b68 Max Schwarz  2014-06-11  204  
c41aa3ce938b68 Max Schwarz  2014-06-11  205  	/* Settings */
1ab92956d4aac5 David Wu     2016-03-17  206  	struct i2c_timings t;
c41aa3ce938b68 Max Schwarz  2014-06-11  207  
c41aa3ce938b68 Max Schwarz  2014-06-11  208  	/* Synchronization & notification */
c41aa3ce938b68 Max Schwarz  2014-06-11  209  	spinlock_t lock;
c41aa3ce938b68 Max Schwarz  2014-06-11  210  	wait_queue_head_t wait;
c41aa3ce938b68 Max Schwarz  2014-06-11  211  	bool busy;
c41aa3ce938b68 Max Schwarz  2014-06-11  212  
c41aa3ce938b68 Max Schwarz  2014-06-11  213  	/* Current message */
c41aa3ce938b68 Max Schwarz  2014-06-11  214  	struct i2c_msg *msg;
c41aa3ce938b68 Max Schwarz  2014-06-11  215  	u8 addr;
c41aa3ce938b68 Max Schwarz  2014-06-11  216  	unsigned int mode;
c41aa3ce938b68 Max Schwarz  2014-06-11  217  	bool is_last_msg;
c41aa3ce938b68 Max Schwarz  2014-06-11  218  
c41aa3ce938b68 Max Schwarz  2014-06-11  219  	/* I2C state machine */
c41aa3ce938b68 Max Schwarz  2014-06-11  220  	enum rk3x_i2c_state state;
0a6ad2f95f36bf David Wu     2016-05-16  221  	unsigned int processed;
c41aa3ce938b68 Max Schwarz  2014-06-11  222  	int error;
c41aa3ce938b68 Max Schwarz  2014-06-11 @223  };
c41aa3ce938b68 Max Schwarz  2014-06-11  224  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
