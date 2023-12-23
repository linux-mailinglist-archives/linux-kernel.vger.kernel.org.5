Return-Path: <linux-kernel+bounces-10152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D528281D0CF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053151C216F5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBCD9441;
	Sat, 23 Dec 2023 00:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AezgKzWM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD59A8F53;
	Sat, 23 Dec 2023 00:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703291232; x=1734827232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h0y55a7+iOhVMcD80eVvyQJa1+yhwkuGgV5FCtXt6AE=;
  b=AezgKzWMpkkpcRjtpGQ+xckukVWZlBRbY1OqwMPtnHKR9ShDyDX40lGs
   W465KfDHk05JidaQ9TgEudw2lTN2ZKAVDJs84ZK5/ZdMtAm/CR+OaOkEX
   5gctlJHEuXwKJVsJ/1X2jZ1VZh8710SeSrvdCaqIt+RaeO+WroEJEmo3g
   zeziOr6oaaTH1supTMlmc29HA+YoFg0E3vX0ZsIMKvcKnj17lFjVX92iT
   V2jnZBl7QvnbQfw5B36/oL4LWor6Kc5M6owRRUsNfC6wqbgDEi96ToeLH
   8KQTEBDqj5xCBvd+0UYAH4XsJUTJMCXSowlNdhLOt/Amk1I79ayMXW82S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="427334210"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="427334210"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 16:27:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="1108631558"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="1108631558"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 22 Dec 2023 16:27:07 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rGpr7-000A2f-0k;
	Sat, 23 Dec 2023 00:27:05 +0000
Date: Sat, 23 Dec 2023 08:21:48 +0800
From: kernel test robot <lkp@intel.com>
To: LeoLiu-oc <LeoLiu-oc@zhaoxin.com>, olivia@selenic.com,
	herbert@gondor.apana.org.au, jiajie.ho@starfivetech.com,
	conor.dooley@microchip.com, martin@kaiser.cx, mmyangfl@gmail.com,
	jenny.zhang@starfivetech.com, robh@kernel.org,
	l.stelmach@samsung.com, ardb@kernel.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com,
	TonyWWang@zhaoxin.com, YunShen@zhaoxin.com, LeoLiu@zhaoxin.com,
	LeoLiuoc <LeoLiu-oc@zhaoxin.com>
Subject: Re: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore
 instruction
Message-ID: <202312230810.DYjUPqx4-lkp@intel.com>
References: <20231221062602.799432-1-LeoLiu-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221062602.799432-1-LeoLiu-oc@zhaoxin.com>

Hi LeoLiu-oc,

kernel test robot noticed the following build warnings:

[auto build test WARNING on char-misc/char-misc-testing]
[also build test WARNING on char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master linus/master v6.7-rc6 next-20231222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/LeoLiu-oc/hwrng-add-Zhaoxin-rng-driver-base-on-rep_xstore-instruction/20231222-174625
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20231221062602.799432-1-LeoLiu-oc%40zhaoxin.com
patch subject: [PATCH v3] hwrng: add Zhaoxin rng driver base on rep_xstore instruction
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231223/202312230810.DYjUPqx4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231223/202312230810.DYjUPqx4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312230810.DYjUPqx4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/char/hw_random/via-rng.c:38:32: warning: array 'via_rng_cpu_ids' assumed to have one element
      38 | static const struct x86_cpu_id via_rng_cpu_ids[];
         |                                ^~~~~~~~~~~~~~~
>> drivers/char/hw_random/via-rng.c:220:26: warning: 'via_rng_cpu_id' defined but not used [-Wunused-variable]
     220 | static struct x86_cpu_id via_rng_cpu_id[] = {
         |                          ^~~~~~~~~~~~~~


vim +/via_rng_cpu_ids +38 drivers/char/hw_random/via-rng.c

    37	
  > 38	static const struct x86_cpu_id via_rng_cpu_ids[];
    39	
    40	
    41	enum {
    42		VIA_STRFILT_CNT_SHIFT	= 16,
    43		VIA_STRFILT_FAIL	= (1 << 15),
    44		VIA_STRFILT_ENABLE	= (1 << 14),
    45		VIA_RAWBITS_ENABLE	= (1 << 13),
    46		VIA_RNG_ENABLE		= (1 << 6),
    47		VIA_NOISESRC1		= (1 << 8),
    48		VIA_NOISESRC2		= (1 << 9),
    49		VIA_XSTORE_CNT_MASK	= 0x0F,
    50	
    51		VIA_RNG_CHUNK_8		= 0x00,	/* 64 rand bits, 64 stored bits */
    52		VIA_RNG_CHUNK_4		= 0x01,	/* 32 rand bits, 32 stored bits */
    53		VIA_RNG_CHUNK_4_MASK	= 0xFFFFFFFF,
    54		VIA_RNG_CHUNK_2		= 0x02,	/* 16 rand bits, 32 stored bits */
    55		VIA_RNG_CHUNK_2_MASK	= 0xFFFF,
    56		VIA_RNG_CHUNK_1		= 0x03,	/* 8 rand bits, 32 stored bits */
    57		VIA_RNG_CHUNK_1_MASK	= 0xFF,
    58	};
    59	
    60	/*
    61	 * Investigate using the 'rep' prefix to obtain 32 bits of random data
    62	 * in one insn.  The upside is potentially better performance.  The
    63	 * downside is that the instruction becomes no longer atomic.  Due to
    64	 * this, just like familiar issues with /dev/random itself, the worst
    65	 * case of a 'rep xstore' could potentially pause a cpu for an
    66	 * unreasonably long time.  In practice, this condition would likely
    67	 * only occur when the hardware is failing.  (or so we hope :))
    68	 *
    69	 * Another possible performance boost may come from simply buffering
    70	 * until we have 4 bytes, thus returning a u32 at a time,
    71	 * instead of the current u8-at-a-time.
    72	 *
    73	 * Padlock instructions can generate a spurious DNA fault, but the
    74	 * kernel doesn't use CR0.TS, so this doesn't matter.
    75	 */
    76	
    77	static inline u32 xstore(u32 *addr, u32 edx_in)
    78	{
    79		u32 eax_out;
    80	
    81		asm(".byte 0x0F,0xA7,0xC0 /* xstore %%edi (addr=%0) */"
    82			: "=m" (*addr), "=a" (eax_out), "+d" (edx_in), "+D" (addr));
    83	
    84		return eax_out;
    85	}
    86	
    87	static int via_rng_data_present(struct hwrng *rng, int wait)
    88	{
    89		char buf[16 + PADLOCK_ALIGNMENT - STACK_ALIGN] __attribute__
    90			((aligned(STACK_ALIGN)));
    91		u32 *via_rng_datum = (u32 *)PTR_ALIGN(&buf[0], PADLOCK_ALIGNMENT);
    92		u32 bytes_out;
    93		int i;
    94	
    95		/* We choose the recommended 1-byte-per-instruction RNG rate,
    96		 * for greater randomness at the expense of speed.  Larger
    97		 * values 2, 4, or 8 bytes-per-instruction yield greater
    98		 * speed at lesser randomness.
    99		 *
   100		 * If you change this to another VIA_CHUNK_n, you must also
   101		 * change the ->n_bytes values in rng_vendor_ops[] tables.
   102		 * VIA_CHUNK_8 requires further code changes.
   103		 *
   104		 * A copy of MSR_VIA_RNG is placed in eax_out when xstore
   105		 * completes.
   106		 */
   107	
   108		for (i = 0; i < 20; i++) {
   109			*via_rng_datum = 0; /* paranoia, not really necessary */
   110			bytes_out = xstore(via_rng_datum, VIA_RNG_CHUNK_1);
   111			bytes_out &= VIA_XSTORE_CNT_MASK;
   112			if (bytes_out || !wait)
   113				break;
   114			udelay(10);
   115		}
   116		rng->priv = *via_rng_datum;
   117		return bytes_out ? 1 : 0;
   118	}
   119	
   120	static int via_rng_data_read(struct hwrng *rng, u32 *data)
   121	{
   122		u32 via_rng_datum = (u32)rng->priv;
   123	
   124		*data = via_rng_datum;
   125	
   126		return 1;
   127	}
   128	
   129	static int via_rng_init(struct hwrng *rng)
   130	{
   131		struct cpuinfo_x86 *c = &cpu_data(0);
   132		u32 lo, hi, old_lo;
   133	
   134		/* VIA Nano CPUs don't have the MSR_VIA_RNG anymore.  The RNG
   135		 * is always enabled if CPUID rng_en is set.  There is no
   136		 * RNG configuration like it used to be the case in this
   137		 * register */
   138		if ((c->x86 == 6) && (c->x86_model >= 0x0f)) {
   139			if (!boot_cpu_has(X86_FEATURE_XSTORE_EN)) {
   140				pr_err(PFX "can't enable hardware RNG "
   141					"if XSTORE is not enabled\n");
   142				return -ENODEV;
   143			}
   144			return 0;
   145		}
   146	
   147		/* Control the RNG via MSR.  Tread lightly and pay very close
   148		 * attention to values written, as the reserved fields
   149		 * are documented to be "undefined and unpredictable"; but it
   150		 * does not say to write them as zero, so I make a guess that
   151		 * we restore the values we find in the register.
   152		 */
   153		rdmsr(MSR_VIA_RNG, lo, hi);
   154	
   155		old_lo = lo;
   156		lo &= ~(0x7f << VIA_STRFILT_CNT_SHIFT);
   157		lo &= ~VIA_XSTORE_CNT_MASK;
   158		lo &= ~(VIA_STRFILT_ENABLE | VIA_STRFILT_FAIL | VIA_RAWBITS_ENABLE);
   159		lo |= VIA_RNG_ENABLE;
   160		lo |= VIA_NOISESRC1;
   161	
   162		/* Enable secondary noise source on CPUs where it is present. */
   163	
   164		/* Nehemiah stepping 8 and higher */
   165		if ((c->x86_model == 9) && (c->x86_stepping > 7))
   166			lo |= VIA_NOISESRC2;
   167	
   168		/* Esther */
   169		if (c->x86_model >= 10)
   170			lo |= VIA_NOISESRC2;
   171	
   172		if (lo != old_lo)
   173			wrmsr(MSR_VIA_RNG, lo, hi);
   174	
   175		/* perhaps-unnecessary sanity check; remove after testing if
   176		   unneeded */
   177		rdmsr(MSR_VIA_RNG, lo, hi);
   178		if ((lo & VIA_RNG_ENABLE) == 0) {
   179			pr_err(PFX "cannot enable VIA C3 RNG, aborting\n");
   180			return -ENODEV;
   181		}
   182	
   183		return 0;
   184	}
   185	
   186	
   187	static struct hwrng via_rng = {
   188		.name		= "via",
   189		.init		= via_rng_init,
   190		.data_present	= via_rng_data_present,
   191		.data_read	= via_rng_data_read,
   192	};
   193	
   194	
   195	static int __init via_rng_mod_init(void)
   196	{
   197		int err;
   198	
   199		if (!x86_match_cpu(via_rng_cpu_ids))
   200			return -ENODEV;
   201	
   202		pr_info("VIA RNG detected\n");
   203		err = hwrng_register(&via_rng);
   204		if (err) {
   205			pr_err(PFX "RNG registering failed (%d)\n",
   206			       err);
   207			goto out;
   208		}
   209	out:
   210		return err;
   211	}
   212	module_init(via_rng_mod_init);
   213	
   214	static void __exit via_rng_mod_exit(void)
   215	{
   216		hwrng_unregister(&via_rng);
   217	}
   218	module_exit(via_rng_mod_exit);
   219	
 > 220	static struct x86_cpu_id via_rng_cpu_id[] = {
   221		X86_MATCH_VENDOR_FAM_FEATURE(CENTAUR, 6, X86_FEATURE_XSTORE, NULL),
   222		{}
   223	};
   224	MODULE_DEVICE_TABLE(x86cpu, via_rng_cpu_id);
   225	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

