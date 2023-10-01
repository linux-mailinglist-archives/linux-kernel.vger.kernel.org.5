Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38FE7B45C5
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 09:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbjJAHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 03:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234371AbjJAHT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 03:19:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF7FBE;
        Sun,  1 Oct 2023 00:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696144796; x=1727680796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+g5KE4gh1O3a8Y0AQj1BwOgU82tkX7gBe++A91tBvWI=;
  b=VFgqdVsjxT7inrnuc3ablRJbwRkCevTgstMhn/FDhfx4FJclgrDVrtmq
   2F6Pu5kH78LuYTcajzVflhIM9VKRFPj3hMWzAkMmE7kqE/zdbySe+08go
   ZOiVgzYGwYHwB1OxMS2IGmM0LFJoBb8N8MfqQKybxKFk7yReb40HsvVxc
   mKol7NEgKBS1000Uy0K4JbJRJ/8mU5BvJPMYfO/DMNj4buhQF4J47TP52
   TSqHthz+/baKeYG60sN46zyXfUJUQIKLuu0/eDk+/LEhSNcAdI5LFBOlz
   VXRpuGT1bPC8Vl8aYcy7GrqJECF6ffvAbVETnTUXwCg0HpmXmPS8ZHwES
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="413409366"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="413409366"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 00:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10849"; a="866181047"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="866181047"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 01 Oct 2023 00:19:52 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmqk1-0004sX-32;
        Sun, 01 Oct 2023 07:19:49 +0000
Date:   Sun, 1 Oct 2023 15:19:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     oe-kbuild-all@lists.linux.dev, stable@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Harry Morris <harrymorris12@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in
 ca8210_probe
Message-ID: <202310011548.qyQMuodI-lkp@intel.com>
References: <20231001054949.14624-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001054949.14624-1-dinghao.liu@zju.edu.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dinghao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dinghao-Liu/ieee802154-ca8210-Fix-a-potential-UAF-in-ca8210_probe/20231001-135130
base:   linus/master
patch link:    https://lore.kernel.org/r/20231001054949.14624-1-dinghao.liu%40zju.edu.cn
patch subject: [PATCH] [v3] ieee802154: ca8210: Fix a potential UAF in ca8210_probe
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231001/202310011548.qyQMuodI-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310011548.qyQMuodI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310011548.qyQMuodI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ieee802154/ca8210.c: In function 'ca8210_register_ext_clock':
>> drivers/net/ieee802154/ca8210.c:2743:13: warning: unused variable 'ret' [-Wunused-variable]
    2743 |         int ret = 0;
         |             ^~~


vim +/ret +2743 drivers/net/ieee802154/ca8210.c

ded845a781a578 Harry Morris 2017-03-28  2731  
ded845a781a578 Harry Morris 2017-03-28  2732  /**
ded845a781a578 Harry Morris 2017-03-28  2733   * ca8210_register_ext_clock() - Register ca8210's external clock with kernel
ded845a781a578 Harry Morris 2017-03-28  2734   * @spi:  Pointer to target ca8210 spi device
ded845a781a578 Harry Morris 2017-03-28  2735   *
ded845a781a578 Harry Morris 2017-03-28  2736   * Return: 0 or linux error code
ded845a781a578 Harry Morris 2017-03-28  2737   */
ded845a781a578 Harry Morris 2017-03-28  2738  static int ca8210_register_ext_clock(struct spi_device *spi)
ded845a781a578 Harry Morris 2017-03-28  2739  {
ded845a781a578 Harry Morris 2017-03-28  2740  	struct device_node *np = spi->dev.of_node;
ded845a781a578 Harry Morris 2017-03-28  2741  	struct ca8210_priv *priv = spi_get_drvdata(spi);
ded845a781a578 Harry Morris 2017-03-28  2742  	struct ca8210_platform_data *pdata = spi->dev.platform_data;
ded845a781a578 Harry Morris 2017-03-28 @2743  	int ret = 0;
ded845a781a578 Harry Morris 2017-03-28  2744  
ded845a781a578 Harry Morris 2017-03-28  2745  	if (!np)
ded845a781a578 Harry Morris 2017-03-28  2746  		return -EFAULT;
ded845a781a578 Harry Morris 2017-03-28  2747  
ded845a781a578 Harry Morris 2017-03-28  2748  	priv->clk = clk_register_fixed_rate(
ded845a781a578 Harry Morris 2017-03-28  2749  		&spi->dev,
ded845a781a578 Harry Morris 2017-03-28  2750  		np->name,
ded845a781a578 Harry Morris 2017-03-28  2751  		NULL,
ded845a781a578 Harry Morris 2017-03-28  2752  		0,
ded845a781a578 Harry Morris 2017-03-28  2753  		pdata->extclockfreq
ded845a781a578 Harry Morris 2017-03-28  2754  	);
ded845a781a578 Harry Morris 2017-03-28  2755  
ded845a781a578 Harry Morris 2017-03-28  2756  	if (IS_ERR(priv->clk)) {
ded845a781a578 Harry Morris 2017-03-28  2757  		dev_crit(&spi->dev, "Failed to register external clk\n");
ded845a781a578 Harry Morris 2017-03-28  2758  		return PTR_ERR(priv->clk);
ded845a781a578 Harry Morris 2017-03-28  2759  	}
ded845a781a578 Harry Morris 2017-03-28  2760  
d0603f3c78f0aa Dinghao Liu  2023-10-01  2761  	return of_clk_add_provider(np, of_clk_src_simple_get, priv->clk);
ded845a781a578 Harry Morris 2017-03-28  2762  }
ded845a781a578 Harry Morris 2017-03-28  2763  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
