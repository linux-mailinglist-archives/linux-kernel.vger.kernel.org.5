Return-Path: <linux-kernel+bounces-13306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC54F820348
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 03:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74253282970
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 02:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912CBEDE;
	Sat, 30 Dec 2023 02:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIn4snje"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A02567;
	Sat, 30 Dec 2023 02:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703901782; x=1735437782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PjWOdBCh5ax+EUHVlpPRAdDsa+muedSFTVmblk+8jpo=;
  b=dIn4snjea44sCQFK1TUBgvKXcrj5qDUh+CD6x3KX7FV/ZkMmBNrA/YG5
   DNmqR9TuA1BWd/BWycrx7VOfy5Bi3u1i0EQOaMjwjn5zoii9qK1vF7dlf
   p9HkNgWH0GyEV+duBI4DA+FtoGMU503Wt5bxhfUvhnvbUZoAvGf3+A1dX
   Q1pSOX61U2KZlHFY5LbGXielXR6Xg56NKv7sU7cSPK7/OumKKW3eg0doy
   ceLJaqJeg4BfylC2zjYHBmAW7K8mdIJjElY/gSM6YjtzQWODLVFA9JRwG
   xa3q9bIL/PAhNrxJc0yJGAQefZkfYoR9XLtOuY5RIz9W8Q1/yLvmdiUeu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="10086255"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="10086255"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 18:03:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="807805725"
X-IronPort-AV: E=Sophos;i="6.04,316,1695711600"; 
   d="scan'208";a="807805725"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2023 18:02:57 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rJOgg-000HyT-2H;
	Sat, 30 Dec 2023 02:02:54 +0000
Date: Sat, 30 Dec 2023 10:01:55 +0800
From: kernel test robot <lkp@intel.com>
To: pratikmanvar09@gmail.com, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
	linux-imx@nxp.com, linux-pwm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Clark Wang <xiaoning.wang@nxp.com>,
	Jun Li <jun.li@nxp.com>, Pratik Manvar <pratik.manvar@ifm.com>
Subject: Re: [PATCH] pwm: imx27: workaround of the pwm output bug
Message-ID: <202312300907.RGtYsKxb-lkp@intel.com>
References: <20231229063013.1786-1-pratikmanvar09@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231229063013.1786-1-pratikmanvar09@gmail.com>

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on thierry-reding-pwm/for-next]
[also build test WARNING on linus/master v6.7-rc7 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/pratikmanvar09-gmail-com/pwm-imx27-workaround-of-the-pwm-output-bug/20231229-143435
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
patch link:    https://lore.kernel.org/r/20231229063013.1786-1-pratikmanvar09%40gmail.com
patch subject: [PATCH] pwm: imx27: workaround of the pwm output bug
config: arm-randconfig-r133-20231230 (https://download.01.org/0day-ci/archive/20231230/202312300907.RGtYsKxb-lkp@intel.com/config)
compiler: clang version 18.0.0git (https://github.com/llvm/llvm-project 8a4266a626914765c0c69839e8a51be383013c1a)
reproduce: (https://download.01.org/0day-ci/archive/20231230/202312300907.RGtYsKxb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312300907.RGtYsKxb-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pwm/pwm-imx27.c:303:26: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sar_last @@     got restricted __le32 [usertype] @@
   drivers/pwm/pwm-imx27.c:303:26: sparse:     expected unsigned int [usertype] sar_last
   drivers/pwm/pwm-imx27.c:303:26: sparse:     got restricted __le32 [usertype]
>> drivers/pwm/pwm-imx27.c:304:29: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sar_current @@     got restricted __le32 [usertype] @@
   drivers/pwm/pwm-imx27.c:304:29: sparse:     expected unsigned int [usertype] sar_current
   drivers/pwm/pwm-imx27.c:304:29: sparse:     got restricted __le32 [usertype]

vim +303 drivers/pwm/pwm-imx27.c

   219	
   220	static int pwm_imx27_apply(struct pwm_chip *chip, struct pwm_device *pwm,
   221				   const struct pwm_state *state)
   222	{
   223		unsigned long period_cycles, duty_cycles, prescale, counter_check, flags;
   224		struct pwm_imx27_chip *imx = to_pwm_imx27_chip(chip);
   225		void __iomem *reg_sar = imx->mmio_base + MX3_PWMSAR;
   226		__force u32 sar_last, sar_current;
   227		struct pwm_state cstate;
   228		unsigned long long c;
   229		unsigned long long clkrate;
   230		int ret;
   231		u32 cr, timeout = 1000;
   232	
   233		pwm_get_state(pwm, &cstate);
   234	
   235		clkrate = clk_get_rate(imx->clk_per);
   236		c = clkrate * state->period;
   237	
   238		do_div(c, NSEC_PER_SEC);
   239		period_cycles = c;
   240	
   241		prescale = period_cycles / 0x10000 + 1;
   242	
   243		period_cycles /= prescale;
   244		c = clkrate * state->duty_cycle;
   245		do_div(c, NSEC_PER_SEC);
   246		duty_cycles = c;
   247		duty_cycles /= prescale;
   248	
   249		/*
   250		 * according to imx pwm RM, the real period value should be PERIOD
   251		 * value in PWMPR plus 2.
   252		 */
   253		if (period_cycles > 2)
   254			period_cycles -= 2;
   255		else
   256			period_cycles = 0;
   257	
   258		/*
   259		 * Wait for a free FIFO slot if the PWM is already enabled, and flush
   260		 * the FIFO if the PWM was disabled and is about to be enabled.
   261		 */
   262		if (cstate.enabled) {
   263			pwm_imx27_wait_fifo_slot(chip, pwm);
   264		} else {
   265			ret = pwm_imx27_clk_prepare_enable(imx);
   266			if (ret)
   267				return ret;
   268	
   269			pwm_imx27_sw_reset(chip);
   270		}
   271	
   272		/*
   273		 * This is a limited workaround. When the SAR FIFO is empty, the new
   274		 * write value will be directly applied to SAR even the current period
   275		 * is not over.
   276		 * If the new SAR value is less than the old one, and the counter is
   277		 * greater than the new SAR value, the current period will not filp
   278		 * the level. This will result in a pulse with a duty cycle of 100%.
   279		 * So, writing the current value of the SAR to SAR here before updating
   280		 * the new SAR value can avoid this issue.
   281		 *
   282		 * Add a spin lock and turn off the interrupt to ensure that the
   283		 * real-time performance can be guaranteed as much as possible when
   284		 * operating the following operations.
   285		 *
   286		 * 1. Add a threshold of 1.5us. If the time T between the read current
   287		 * count value CNR and the end of the cycle is less than 1.5us, wait
   288		 * for T to be longer than 1.5us before updating the SAR register.
   289		 * This is to avoid the situation that when the first SAR is written,
   290		 * the current cycle just ends and the SAR FIFO that just be written
   291		 * is emptied again.
   292		 *
   293		 * 2. Use __raw_writel() to minimize the interval between two writes to
   294		 * the SAR register to increase the fastest pwm frequency supported.
   295		 *
   296		 * When the PWM period is longer than 2us(or <500KHz), this workaround
   297		 * can solve this problem.
   298		 */
   299		if (duty_cycles < imx->duty_cycle) {
   300			c = clkrate * 1500;
   301			do_div(c, NSEC_PER_SEC);
   302			counter_check = c;
 > 303			sar_last = cpu_to_le32(imx->duty_cycle);
 > 304			sar_current = cpu_to_le32(duty_cycles);
   305	
   306			spin_lock_irqsave(&imx->lock, flags);
   307			if (state->period >= 2000) {
   308				while ((period_cycles -
   309					readl_relaxed(imx->mmio_base + MX3_PWMCNR))
   310					< counter_check) {
   311					if (!--timeout)
   312						break;
   313				};
   314			}
   315			if (!(MX3_PWMSR_FIFOAV &
   316			      readl_relaxed(imx->mmio_base + MX3_PWMSR)))
   317				__raw_writel(sar_last, reg_sar);
   318			__raw_writel(sar_current, reg_sar);
   319			spin_unlock_irqrestore(&imx->lock, flags);
   320		} else
   321			writel(duty_cycles, imx->mmio_base + MX3_PWMSAR);
   322	
   323		writel(period_cycles, imx->mmio_base + MX3_PWMPR);
   324	
   325		/*
   326		 * Store the duty cycle for future reference in cases where the
   327		 * MX3_PWMSAR register can't be read (i.e. when the PWM is disabled).
   328		 */
   329		imx->duty_cycle = duty_cycles;
   330	
   331		cr = MX3_PWMCR_PRESCALER_SET(prescale) |
   332		     MX3_PWMCR_STOPEN | MX3_PWMCR_DOZEN | MX3_PWMCR_WAITEN |
   333		     FIELD_PREP(MX3_PWMCR_CLKSRC, MX3_PWMCR_CLKSRC_IPG_HIGH) |
   334		     MX3_PWMCR_DBGEN;
   335	
   336		if (state->polarity == PWM_POLARITY_INVERSED)
   337			cr |= FIELD_PREP(MX3_PWMCR_POUTC,
   338					MX3_PWMCR_POUTC_INVERTED);
   339	
   340		if (state->enabled)
   341			cr |= MX3_PWMCR_EN;
   342	
   343		writel(cr, imx->mmio_base + MX3_PWMCR);
   344	
   345		if (!state->enabled)
   346			pwm_imx27_clk_disable_unprepare(imx);
   347	
   348		return 0;
   349	}
   350	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

