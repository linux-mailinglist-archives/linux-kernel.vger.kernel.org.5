Return-Path: <linux-kernel+bounces-51136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 910A08486F2
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3411B24C4F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 15:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C8C5F547;
	Sat,  3 Feb 2024 15:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yjg+4kYz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52AB5EE64;
	Sat,  3 Feb 2024 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706972757; cv=none; b=N+edxHYjAdnWId5t9aMTOkDyEsPkEntXx9twbE5Cispou2FZ4yScrfijBjhFHIUH7NhLJCpK0U8RTDGK8+ztOH+EjsDFE/aTOtq7N5fvhBAHAC0/E2F2j2NNwlwZt009wHCdKYQ3BgG/7daMjvRAIZBJJVMFDByhXKw2WTAIfU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706972757; c=relaxed/simple;
	bh=ELEZEWWk9NQcZeuQTjNOf8Xawd967PBWJKiK7K14SIs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8wrQeAJQKyhumsfjmfrmKzs0TdB61NZZdzPDKoJHHdMK5BV6pHCjefFPtW2ySy0E3vNWO6pX4eAFD9K8vIvdQtm+/+N0bre2Feb7Th9miO/Vvz3XJRk7FYRLicts89gUMwcbFQ7Fl2gdoYtV158gPhVh6V9PBi+Fa+1wuYJhDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yjg+4kYz; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706972756; x=1738508756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ELEZEWWk9NQcZeuQTjNOf8Xawd967PBWJKiK7K14SIs=;
  b=Yjg+4kYzLsfG50Rw8QHWAZ/+qtKuOQdyrYDzb9hgERXpaud3OCJk/ijl
   7IjI5BVb90e41xIUI1zpF1R23atfv0Fx4OMRmObArVNVyu7EduqW+5WD6
   smrYrn6McwoUXV14/zN2xKpxcz/iMyzLcJK56ji9HhW26hoskb7JaoBZf
   5UtRdTOVE78sFpimli9gfrfZhXWWLqPf3hlqKJMr8114+bxohv0TkAeIy
   OG7wuR0HY/vW4OSyILh5nCnGf8EnzDRFJ/N+ou455WuIbVhjuBTFwjfeR
   fAvFJbAXe+mWRXTbpIwEYykc6DyQQ8u0Rcm2eizEk+yj/NwpaVEhxjfkf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="555422"
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="555422"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 07:05:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,240,1701158400"; 
   d="scan'208";a="23607836"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 03 Feb 2024 07:05:47 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWHaS-0005DA-0N;
	Sat, 03 Feb 2024 15:05:44 +0000
Date: Sat, 3 Feb 2024 23:04:47 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Shubin <privatesub2@gmail.com>, linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aleksandr Shubin <privatesub2@gmail.com>,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	John Watts <contact@jookia.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>, linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM
 support
Message-ID: <202402032222.BiIrD3g4-lkp@intel.com>
References: <20240131125920.2879433-3-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240131125920.2879433-3-privatesub2@gmail.com>

Hi Aleksandr,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on sunxi/sunxi/for-next linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksandr-Shubin/dt-bindings-pwm-Add-binding-for-Allwinner-D1-T113-S3-R329-PWM-controller/20240131-210313
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240131125920.2879433-3-privatesub2%40gmail.com
patch subject: [PATCH v8 2/3] pwm: Add Allwinner's D1/T113-S3/R329 SoCs PWM support
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20240203/202402032222.BiIrD3g4-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240203/202402032222.BiIrD3g4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402032222.BiIrD3g4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pwm/pwm-sun20i.c:47: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock dividers


vim +47 drivers/pwm/pwm-sun20i.c

    45	
    46	/**
  > 47	 * SUN20I_PWM_MAGIC is used to quickly compute the values of the clock dividers
    48	 * div_m (SUN20I_PWM_CLK_CFG_DIV_M) & prescale_k (SUN20I_PWM_CTL_PRESCAL_K)
    49	 * without using a loop. These dividers limit the # of cycles in a period
    50	 * to SUN20I_PWM_PCNTR_SIZE by applying a scaling factor of
    51	 * 1/(div_m * (prescale_k + 1)) to the clock source.
    52	 *
    53	 * SUN20I_PWM_MAGIC is derived by solving for div_m and prescale_k
    54	 * such that for a given requested period,
    55	 *
    56	 * i) div_m is minimized for any prescale_k ≤ SUN20I_PWM_CTL_PRESCAL_K_MAX,
    57	 * ii) prescale_k is minimized.
    58	 *
    59	 * The derivation proceeds as follows, with val = # of cycles for reqested
    60	 * period:
    61	 *
    62	 * for a given value of div_m we want the smallest prescale_k such that
    63	 *
    64	 * (val >> div_m) // (prescale_k + 1) ≤ 65536 (SUN20I_PWM_PCNTR_SIZE)
    65	 *
    66	 * This is equivalent to:
    67	 *
    68	 * (val >> div_m) ≤ 65536 * (prescale_k + 1) + prescale_k
    69	 * ⟺ (val >> div_m) ≤ 65537 * prescale_k + 65536
    70	 * ⟺ (val >> div_m) - 65536 ≤ 65537 * prescale_k
    71	 * ⟺ ((val >> div_m) - 65536) / 65537 ≤ prescale_k
    72	 *
    73	 * As prescale_k is integer, this becomes
    74	 *
    75	 * ((val >> div_m) - 65536) // 65537 ≤ prescale_k
    76	 *
    77	 * And is minimized at
    78	 *
    79	 * ((val >> div_m) - 65536) // 65537
    80	 *
    81	 * Now we pick the smallest div_m that satifies prescale_k ≤ 255
    82	 * (i.e SUN20I_PWM_CTL_PRESCAL_K_MAX),
    83	 *
    84	 * ((val >> div_m) - 65536) // 65537 ≤ 255
    85	 * ⟺ (val >> div_m) - 65536 ≤ 255 * 65537 + 65536
    86	 * ⟺ val >> div_m ≤ 255 * 65537 + 2 * 65536
    87	 * ⟺ val >> div_m < (255 * 65537 + 2 * 65536 + 1)
    88	 * ⟺ div_m = fls((val) / (255 * 65537 + 2 * 65536 + 1))
    89	 *
    90	 * Suggested by Uwe Kleine-König
    91	 */
    92	#define SUN20I_PWM_MAGIC			(255 * 65537 + 2 * 65536 + 1)
    93	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

