Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD517F74D6
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjKXNVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:21:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbjKXNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:21:22 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB11172D;
        Fri, 24 Nov 2023 05:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700832080; x=1732368080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oS8G9RbkHOAGAKexG7oDoBknf5c2EZYgB9loDAbntcE=;
  b=HYqx8wXcA92WquS+RiF+n51fUu4itig07M6YPyCGpUn1y+oBFQIkq5iC
   1JSRbRV927sfR1H3RNgDTdKt8S29gqI4ou4vhUAkA4khdQQHPLXtwIYBu
   P2rk4ZTjt9lFeZzdb7ziKoyFevMPJAQqpAD5XxckfDFUmLoUVRpBKnjhm
   Dpsw2xDSwi6ZPITjGjQQrGgRcHnirX0AltBVb1lGGptzyyj9BSpXB2Ng4
   6a6iZCyQ96Zfjho6hrGibL0xgIrjb+U6zFMWMxK0cnP4RRBnu+s407nt5
   m1ltDBvnw8mMmT1wLwDVNBhKbDAC52ZZIMx0cK92PO63WLWva+xLMYmGJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10904"; a="456765147"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="456765147"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2023 05:20:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="767477118"
X-IronPort-AV: E=Sophos;i="6.04,224,1695711600"; 
   d="scan'208";a="767477118"
Received: from lkp-server01.sh.intel.com (HELO d584ee6ebdcc) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 24 Nov 2023 05:20:25 -0800
Received: from kbuild by d584ee6ebdcc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r6W6Z-0002nt-14;
        Fri, 24 Nov 2023 13:20:23 +0000
Date:   Fri, 24 Nov 2023 21:19:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-mips@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>, Jacky Bai <ping.bai@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sean Wang <sean.wang@kernel.org>
Subject: Re: [PATCH v2 06/21] pinctrl: equilibrium: Convert to use struct
 pingroup
Message-ID: <202311241401.ZPILPdov-lkp@intel.com>
References: <20231123193355.3400852-7-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123193355.3400852-7-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linusw-pinctrl/for-next next-20231124]
[cannot apply to geert-renesas-drivers/renesas-pinctrl pinctrl-samsung/for-next linus/master v6.7-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/pinctrl-qcom-lpass-lpi-Remove-unused-member-in-struct-lpi_pingroup/20231124-043212
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
patch link:    https://lore.kernel.org/r/20231123193355.3400852-7-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 06/21] pinctrl: equilibrium: Convert to use struct pingroup
config: i386-randconfig-141-20231124 (https://download.01.org/0day-ci/archive/20231124/202311241401.ZPILPdov-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20231124/202311241401.ZPILPdov-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311241401.ZPILPdov-lkp@intel.com/

smatch warnings:
drivers/pinctrl/pinctrl-equilibrium.c:719 eqbr_build_groups() warn: unsigned 'grp->npins' is never less than zero.

vim +719 drivers/pinctrl/pinctrl-equilibrium.c

   702	
   703	static int eqbr_build_groups(struct eqbr_pinctrl_drv_data *drvdata)
   704	{
   705		struct device *dev = drvdata->dev;
   706		struct device_node *node = dev->of_node;
   707		unsigned int *pins, *pinmux, pin_id, pinmux_id;
   708		struct pingroup group, *grp = &group;
   709		struct device_node *np;
   710		struct property *prop;
   711		int j, err;
   712	
   713		for_each_child_of_node(node, np) {
   714			prop = of_find_property(np, "groups", NULL);
   715			if (!prop)
   716				continue;
   717	
   718			grp->npins = of_property_count_u32_elems(np, "pins");
 > 719			if (grp->npins < 0) {
   720				dev_err(dev, "No pins in the group: %s\n", prop->name);
   721				of_node_put(np);
   722				return -EINVAL;
   723			}
   724			grp->name = prop->value;
   725			pins = devm_kcalloc(dev, grp->npins, sizeof(*pins), GFP_KERNEL);
   726			if (!pins) {
   727				of_node_put(np);
   728				return -ENOMEM;
   729			}
   730			grp->pins = pins;
   731	
   732			pinmux = devm_kcalloc(dev, grp->npins, sizeof(*pinmux), GFP_KERNEL);
   733			if (!pinmux) {
   734				of_node_put(np);
   735				return -ENOMEM;
   736			}
   737	
   738			for (j = 0; j < grp->npins; j++) {
   739				if (of_property_read_u32_index(np, "pins", j, &pin_id)) {
   740					dev_err(dev, "Group %s: Read intel pins id failed\n",
   741						grp->name);
   742					of_node_put(np);
   743					return -EINVAL;
   744				}
   745				if (pin_id >= drvdata->pctl_desc.npins) {
   746					dev_err(dev, "Group %s: Invalid pin ID, idx: %d, pin %u\n",
   747						grp->name, j, pin_id);
   748					of_node_put(np);
   749					return -EINVAL;
   750				}
   751				pins[j] = pin_id;
   752				if (of_property_read_u32_index(np, "pinmux", j, &pinmux_id)) {
   753					dev_err(dev, "Group %s: Read intel pinmux id failed\n",
   754						grp->name);
   755					of_node_put(np);
   756					return -EINVAL;
   757				}
   758				pinmux[j] = pinmux_id;
   759			}
   760	
   761			err = pinctrl_generic_add_group(drvdata->pctl_dev,
   762							grp->name, grp->pins, grp->npins,
   763							pinmux);
   764			if (err < 0) {
   765				dev_err(dev, "Failed to register group %s\n", grp->name);
   766				of_node_put(np);
   767				return err;
   768			}
   769			memset(&group, 0, sizeof(group));
   770			pinmux = NULL;
   771		}
   772	
   773		return 0;
   774	}
   775	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
