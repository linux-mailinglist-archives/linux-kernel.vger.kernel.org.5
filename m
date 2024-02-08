Return-Path: <linux-kernel+bounces-57385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7276B84D7BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 03:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96A531C21CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA9C1D68F;
	Thu,  8 Feb 2024 02:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BV2OT+SF"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078501C6A8;
	Thu,  8 Feb 2024 02:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707358889; cv=none; b=SejUWvhPFvJXaNkeqJZ6OCwZIB0SJMN/yt/4GSe8y9ypNZh8kNRhQWOWokF8/08xtWg/WLm1Bb8/5cH/7dcIZazOH4+gzprelptMtZoZkUaAVU/s0wnKbHQmx/gMbTHttUHJ0FEJgUxKQerF4hAisLiwGTIFRd8OusYILIVPCSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707358889; c=relaxed/simple;
	bh=UKmPL5Zx+C+SOFiu/lgbITC5x7HQmDloUJhMi2ef6a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUw8tyaXNroeNV+uknpquteaX/tKhAX5SiUY6ISqag6vqCMHkvXGAyRydyIedDtUQIzT4cNJy4kHY1qQJWH+0mg8VtK1h8o7FJl4Ynfh1s/zXlCq6fdD9H1ZfiSy1EWyxOVSz6GuV9/bl75fBBDqSJf0iJfyRpivtH4ByujPtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BV2OT+SF; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707358887; x=1738894887;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UKmPL5Zx+C+SOFiu/lgbITC5x7HQmDloUJhMi2ef6a4=;
  b=BV2OT+SFp3wGr/d2tOFar6nhEWPjmT2vzPOxKBuAqeMajNKfiUpTx3qo
   /r6d4ZjX5y9om0LDwZv+VETk3oCvvMP1HfF1xPDBm+VLIJQhTsBA4NVNU
   g1/q7gcAO1PMZ5JMBO2y+e/eKTvNewyrx9kccwmxmcrlh+3v85LBRGP6F
   ntQc4JmhbilRa6AYOexzcLCcnarL4S3eVfVZOIqJbngPxDKceiac/hhsQ
   K/GFmI+k6OZ+kY9jF2y4lbGYPgeTcjytageNDqZmacMJ4V+/LDi9EUIS8
   zjGLuARLadSaHcz8k3Jcb9pFO5f7H/SMb4CzahotC6L1R/vqwmgiNN6NB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="436266519"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="436266519"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 18:21:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="1837261"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 07 Feb 2024 18:21:21 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXu2Q-0003Fi-2L;
	Thu, 08 Feb 2024 02:21:18 +0000
Date: Thu, 8 Feb 2024 10:20:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, u.kleine-koenig@pengutronix.de,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	dlan@gentoo.org, inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: Re: [PATCH v1 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
Message-ID: <202402081005.iOYVJ6KI-lkp@intel.com>
References: <20240207060913.672554-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207060913.672554-1-qiujingbao.dlmu@gmail.com>

Hi Jingbao,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 7afc0e7f681e6efd6b826f003fc14c17b5093643]

url:    https://github.com/intel-lab-lkp/linux/commits/Jingbao-Qiu/dt-bindings-pwm-sophgo-add-pwm-for-Sophgo-CV1800-series-SoC/20240207-141135
base:   7afc0e7f681e6efd6b826f003fc14c17b5093643
patch link:    https://lore.kernel.org/r/20240207060913.672554-1-qiujingbao.dlmu%40gmail.com
patch subject: [PATCH v1 2/2] pwm: sophgo: add pwm support for Sophgo CV1800 SoC
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20240208/202402081005.iOYVJ6KI-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402081005.iOYVJ6KI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402081005.iOYVJ6KI-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/pwm/pwm-cv1800.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-cv1800.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/pwm/pwm-cv1800.c:14:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/pwm/pwm-cv1800.c:131:3: warning: comparison of distinct pointer types ('typeof ((tem)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     131 |                 do_div(tem, rate);
         |                 ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
   drivers/pwm/pwm-cv1800.c:131:3: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     131 |                 do_div(tem, rate);
         |                 ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
   drivers/pwm/pwm-cv1800.c:135:3: warning: comparison of distinct pointer types ('typeof ((tem)) *' (aka 'unsigned int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     135 |                 do_div(tem, hlperiod_val);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
   drivers/pwm/pwm-cv1800.c:135:3: error: incompatible pointer types passing 'u32 *' (aka 'unsigned int *') to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     135 |                 do_div(tem, hlperiod_val);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
>> drivers/pwm/pwm-cv1800.c:131:3: warning: shift count >= width of type [-Wshift-count-overflow]
     131 |                 do_div(tem, rate);
         |                 ^~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   drivers/pwm/pwm-cv1800.c:135:3: warning: shift count >= width of type [-Wshift-count-overflow]
     135 |                 do_div(tem, hlperiod_val);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   10 warnings and 2 errors generated.


vim +131 drivers/pwm/pwm-cv1800.c

   113	
   114	static int cv1800_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
   115					 struct pwm_state *state)
   116	{
   117		struct cv1800_pwm *priv = to_cv1800_pwm_dev(chip);
   118		u32 period_val, hlperiod_val, tem;
   119		u64 rate;
   120		u64 period_ns = 0;
   121		u64 duty_ns = 0;
   122		u32 enable = 0;
   123	
   124		regmap_read(priv->map, PERIOD(pwm->hwpwm), &period_val);
   125		regmap_read(priv->map, HLPERIOD(pwm->hwpwm), &hlperiod_val);
   126	
   127		if (period_val != PERIOD_RESET || hlperiod_val != HLPERIOD_RESET) {
   128			rate = (u64)clk_get_rate(priv->clk);
   129	
   130			tem = NSEC_PER_SEC * period_val;
 > 131			do_div(tem, rate);
   132			period_ns = tem;
   133	
   134			tem = period_val * period_ns;
   135			do_div(tem, hlperiod_val);
   136			duty_ns = tem;
   137	
   138			regmap_read(priv->map, PWMSTART, &enable);
   139			enable >>= pwm->hwpwm;
   140		}
   141	
   142		state->period = period_ns;
   143		state->duty_cycle = duty_ns;
   144		state->enabled = enable;
   145	
   146		return 0;
   147	}
   148	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

