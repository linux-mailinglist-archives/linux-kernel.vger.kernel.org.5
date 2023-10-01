Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30D37B4889
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 18:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235186AbjJAQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 12:08:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235093AbjJAQI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 12:08:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A950ED3;
        Sun,  1 Oct 2023 09:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696176504; x=1727712504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ttbpa5CPZtUl/EL5mFBC+uzL/iLNKmwUeDvQROsDv6k=;
  b=d0oDODo4nQa9xmI7lbTpV2a9K/7S3gcW5m+8+wrTic42ocMZNcjR5v1j
   2oyjqs9wpx6GaPTDiPhMqzRXu6blnWLQiUWUKRoEvb626uqkPY20N/AXR
   C4kbmHsypjGv7cPNFYeVrNxZia7fvqahvql+80SxAGFf4jDOWKPi24OI6
   RomTVlTAa1x0kXeOXruOgXVaC70AHC/zsCpC2Ql9P14VsYiJGyEKZJqcm
   OahpARJADkbJRX7qnF36sqlFKFuchhk8DxvePno8NRGVrxc1KbEcxC+ZJ
   Bl/Bwoo4eLzSBMD8GAcWTWF5xBzUUMfz/jF7jBR3BSR33wc1K2Q1UjTAO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="382445439"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="382445439"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2023 09:08:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="785576469"
X-IronPort-AV: E=Sophos;i="6.03,191,1694761200"; 
   d="scan'208";a="785576469"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 01 Oct 2023 09:08:17 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qmyzP-0005Cf-2Z;
        Sun, 01 Oct 2023 16:08:15 +0000
Date:   Mon, 2 Oct 2023 00:07:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sean Young <sean@mess.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     oe-kbuild-all@lists.linux.dev, Sean Young <sean@mess.org>,
        Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>,
        linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic
 context
Message-ID: <202310012348.puyNjoMk-lkp@intel.com>
References: <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean@mess.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

kernel test robot noticed the following build errors:

[auto build test ERROR on thierry-reding-pwm/for-next]
[also build test ERROR on shawnguo/for-next atorgue-stm32/stm32-next media-tree/master linus/master v6.6-rc3 next-20230929]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sean-Young/media-pwm-ir-tx-trigger-edges-from-hrtimer-interrupt-context/20231001-194056
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
patch link:    https://lore.kernel.org/r/1bd5241d584ceb4d6b731c4dc3203fb9686ee1d1.1696156485.git.sean%40mess.org
patch subject: [PATCH 1/2] pwm: make it possible to apply pwm changes in atomic context
config: i386-buildonly-randconfig-004-20231001 (https://download.01.org/0day-ci/archive/20231001/202310012348.puyNjoMk-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231001/202310012348.puyNjoMk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310012348.puyNjoMk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from arch/x86/include/asm/percpu.h:27:0,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/backlight.h:12,
                    from drivers/video/fbdev/ssd1307fb.c:8:
   include/linux/pwm.h: In function 'pwm_apply_state':
   include/linux/pwm.h:428:17: error: implicit declaration of function 'pwm_can_sleep'; did you mean 'gpiod_cansleep'? [-Werror=implicit-function-declaration]
     might_sleep_if(pwm_can_sleep(pwm));
                    ^
   include/linux/kernel.h:194:39: note: in definition of macro 'might_sleep_if'
    #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
                                          ^~~~
   In file included from drivers/video/fbdev/ssd1307fb.c:16:0:
   include/linux/pwm.h: At top level:
>> include/linux/pwm.h:455:20: error: conflicting types for 'pwm_can_sleep'
    static inline bool pwm_can_sleep(struct pwm_device *pwm)
                       ^~~~~~~~~~~~~
   In file included from arch/x86/include/asm/percpu.h:27:0,
                    from arch/x86/include/asm/current.h:10,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/backlight.h:12,
                    from drivers/video/fbdev/ssd1307fb.c:8:
   include/linux/pwm.h:428:17: note: previous implicit declaration of 'pwm_can_sleep' was here
     might_sleep_if(pwm_can_sleep(pwm));
                    ^
   include/linux/kernel.h:194:39: note: in definition of macro 'might_sleep_if'
    #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
                                          ^~~~
   cc1: some warnings being treated as errors
--
   In file included from arch/x86/include/asm/percpu.h:27:0,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/mfd/intel_soc_pmic_crc.c:11:
   include/linux/pwm.h: In function 'pwm_apply_state':
   include/linux/pwm.h:428:17: error: implicit declaration of function 'pwm_can_sleep'; did you mean 'cant_sleep'? [-Werror=implicit-function-declaration]
     might_sleep_if(pwm_can_sleep(pwm));
                    ^
   include/linux/kernel.h:194:39: note: in definition of macro 'might_sleep_if'
    #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
                                          ^~~~
   In file included from drivers/mfd/intel_soc_pmic_crc.c:18:0:
   include/linux/pwm.h: At top level:
>> include/linux/pwm.h:455:20: error: conflicting types for 'pwm_can_sleep'
    static inline bool pwm_can_sleep(struct pwm_device *pwm)
                       ^~~~~~~~~~~~~
   In file included from arch/x86/include/asm/percpu.h:27:0,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/slab.h:16,
                    from include/linux/resource_ext.h:11,
                    from include/linux/acpi.h:13,
                    from include/linux/i2c.h:13,
                    from drivers/mfd/intel_soc_pmic_crc.c:11:
   include/linux/pwm.h:428:17: note: previous implicit declaration of 'pwm_can_sleep' was here
     might_sleep_if(pwm_can_sleep(pwm));
                    ^
   include/linux/kernel.h:194:39: note: in definition of macro 'might_sleep_if'
    #define might_sleep_if(cond) do { if (cond) might_sleep(); } while (0)
                                          ^~~~
   cc1: some warnings being treated as errors


vim +/pwm_can_sleep +455 include/linux/pwm.h

   454	
 > 455	static inline bool pwm_can_sleep(struct pwm_device *pwm)
   456	{
   457		return true;
   458	}
   459	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
