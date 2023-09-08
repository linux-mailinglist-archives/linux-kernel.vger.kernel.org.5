Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FACA7991A4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344635AbjIHVtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjIHVtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:49:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7D419B6;
        Fri,  8 Sep 2023 14:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694209775; x=1725745775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A3kcjKku3nLjouI93HaJUhtFFWzExoWvWEwvfEaE5Ns=;
  b=b+3e8lKvCV3CnKkuXXVdV8t5GfBEkmBOHQXDzJyUoE2UUmX93ziNIbbR
   4AdYDAKYn7nRrCkP6wKzvA+HcPwpDbeeKsIAImB4PQsZqqYujgh91qh+q
   GqS7y0Amv49RV5lm8+B2SO/KuejsHHdKdJ0wLlv5sIHRvRXJNcxyXBZVt
   Lt4FSWR901uqNjhZg/ixo+kgq3t4XlaB1S4WdVEk4d4/lQ+0/ZmOhSpEK
   4dgQWId3586nMdclhy/6O9Vrcn28y85Pbm28V7Ax6sgyKPgAUt2OaXWiW
   e1wz3iz0XKR7B72PXFOd/WkjALUFUI+620zCUvhu09i09iFqhblKW6WsQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="357219735"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="357219735"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 14:49:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10827"; a="885811726"
X-IronPort-AV: E=Sophos;i="6.02,238,1688454000"; 
   d="scan'208";a="885811726"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 08 Sep 2023 14:49:14 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qejM1-0002dk-1J;
        Fri, 08 Sep 2023 21:49:29 +0000
Date:   Sat, 9 Sep 2023 05:48:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Gatien Chevallier <gatien.chevallier@foss.st.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Lionel Debieve <lionel.debieve@foss.st.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Gatien Chevallier <gatien.chevallier@foss.st.com>
Subject: Re: [PATCH 05/10] hwrng: stm32 - rework error handling in
 stm32_rng_read()
Message-ID: <202309090508.CyBIfKeu-lkp@intel.com>
References: <20230908165120.730867-6-gatien.chevallier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908165120.730867-6-gatien.chevallier@foss.st.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gatien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on atorgue-stm32/stm32-next]
[also build test WARNING on robh/for-next herbert-crypto-2.6/master herbert-cryptodev-2.6/master linus/master v6.5 next-20230908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gatien-Chevallier/dt-bindings-rng-introduce-new-compatible-for-STM32MP13x/20230909-005611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/atorgue/stm32.git stm32-next
patch link:    https://lore.kernel.org/r/20230908165120.730867-6-gatien.chevallier%40foss.st.com
patch subject: [PATCH 05/10] hwrng: stm32 - rework error handling in stm32_rng_read()
config: hexagon-randconfig-002-20230909 (https://download.01.org/0day-ci/archive/20230909/202309090508.CyBIfKeu-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230909/202309090508.CyBIfKeu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309090508.CyBIfKeu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/char/hw_random/stm32-rng.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from drivers/char/hw_random/stm32-rng.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/char/hw_random/stm32-rng.c:9:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> drivers/char/hw_random/stm32-rng.c:210:35: warning: left operand of comma operator has no effect [-Wunused-value]
     210 |                         if (WARN_ON(sr & RNG_SR_CEIS), "RNG clock too slow - %x\n", sr)
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:57: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                                         ^~~~~~~~~~~
   include/linux/compiler.h:57:52: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                    ^~~~
>> drivers/char/hw_random/stm32-rng.c:210:35: warning: left operand of comma operator has no effect [-Wunused-value]
     210 |                         if (WARN_ON(sr & RNG_SR_CEIS), "RNG clock too slow - %x\n", sr)
         |                                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler.h:55:57: note: expanded from macro 'if'
      55 | #define if(cond, ...) if ( __trace_if_var( !!(cond , ## __VA_ARGS__) ) )
         |                                                         ^~~~~~~~~~~
   include/linux/compiler.h:57:86: note: expanded from macro '__trace_if_var'
      57 | #define __trace_if_var(cond) (__builtin_constant_p(cond) ? (cond) : __trace_if_value(cond))
         |                                                                                      ^~~~
   include/linux/compiler.h:68:3: note: expanded from macro '__trace_if_value'
      68 |         (cond) ?                                        \
         |          ^~~~
   8 warnings generated.


vim +210 drivers/char/hw_random/stm32-rng.c

   162	
   163	
   164	static int stm32_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
   165	{
   166		struct stm32_rng_private *priv = container_of(rng, struct stm32_rng_private, rng);
   167		unsigned int i = 0;
   168		int retval = 0, err = 0;
   169		u32 sr;
   170	
   171		pm_runtime_get_sync((struct device *) priv->rng.priv);
   172	
   173		if (readl_relaxed(priv->base + RNG_SR) & RNG_SR_SEIS)
   174			stm32_rng_conceal_seed_error(rng);
   175	
   176		while (max >= sizeof(u32)) {
   177			sr = readl_relaxed(priv->base + RNG_SR);
   178			/*
   179			 * Manage timeout which is based on timer and take
   180			 * care of initial delay time when enabling the RNG.
   181			 */
   182			if (!sr && wait) {
   183				err = readl_relaxed_poll_timeout_atomic(priv->base
   184									   + RNG_SR,
   185									   sr, sr,
   186									   10, 50000);
   187				if (err) {
   188					dev_err((struct device *)priv->rng.priv,
   189						"%s: timeout %x!\n", __func__, sr);
   190					break;
   191				}
   192			} else if (!sr) {
   193				/* The FIFO is being filled up */
   194				break;
   195			}
   196	
   197			if (sr != RNG_SR_DRDY) {
   198				if (sr & RNG_SR_SEIS) {
   199					err = stm32_rng_conceal_seed_error(rng);
   200					i++;
   201					if (err && i > RNG_NB_RECOVER_TRIES) {
   202						dev_err((struct device *)priv->rng.priv,
   203							"Couldn't recover from seed error\n");
   204						return -ENOTRECOVERABLE;
   205					}
   206	
   207					continue;
   208				}
   209	
 > 210				if (WARN_ON(sr & RNG_SR_CEIS), "RNG clock too slow - %x\n", sr)
   211					writel_relaxed(0, priv->base + RNG_SR);
   212			}
   213	
   214			/* Late seed error case: DR being 0 is an error status */
   215			*(u32 *)data = readl_relaxed(priv->base + RNG_DR);
   216			if (!*(u32 *)data) {
   217				err = stm32_rng_conceal_seed_error(rng);
   218				i++;
   219				if (err && i > RNG_NB_RECOVER_TRIES) {
   220					dev_err((struct device *)priv->rng.priv,
   221						"Couldn't recover from seed error");
   222					return -ENOTRECOVERABLE;
   223				}
   224	
   225				continue;
   226			}
   227	
   228			i = 0;
   229			retval += sizeof(u32);
   230			data += sizeof(u32);
   231			max -= sizeof(u32);
   232		}
   233	
   234		pm_runtime_mark_last_busy((struct device *) priv->rng.priv);
   235		pm_runtime_put_sync_autosuspend((struct device *) priv->rng.priv);
   236	
   237		return retval || !wait ? retval : -EIO;
   238	}
   239	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
