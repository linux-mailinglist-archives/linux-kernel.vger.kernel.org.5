Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B289767B6D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 04:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjG2CBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 22:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjG2CBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 22:01:51 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647903C2F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 19:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690596108; x=1722132108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=30ECnqTGqwdwC8QWUHWUCPAaTaGgM9hd93wHOY9BJt0=;
  b=jVhLUPADCUZOsFKBtgrEg3iuNPVGBLkkRBmw5ckRjuu8BZRJ4SnNnwNU
   aH0U8VpmAOQ7FOQ9c4y087RfDrhWu1dnniD4P2jSos0uLM2JeYPT9MoNE
   E9telRhbYqfEV400UzhkMGsHeSvVIw7N2psv17wLnw14Muhn1E/JtPTtF
   v6/BCU7kr7nyvAqCQvpDDWFkCaHYbLIYbKBMozR4AUcUkKzDFLpY3cX8v
   zaNHdmOAdRiUUGzZ3z3pJXnVKo3G/WawEYTMDo4Uec8q0a3yEbk5ocfGF
   imHq8+HsOtaEC6y0298ZURXc9Xc0I8LlaFte05HJP6x0oUb+XwfHxcbUu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="358750818"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="358750818"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 19:01:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="677687687"
X-IronPort-AV: E=Sophos;i="6.01,239,1684825200"; 
   d="scan'208";a="677687687"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2023 19:01:44 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPZH6-0003kb-0L;
        Sat, 29 Jul 2023 02:01:44 +0000
Date:   Sat, 29 Jul 2023 10:00:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next v2 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <202307290943.ODVeyeK6-lkp@intel.com>
References: <bf92800b0c5445e2b2ca8c88e1f5e90f@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf92800b0c5445e2b2ca8c88e1f5e90f@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master crng-random/master v6.5-rc3 next-20230728]
[cannot apply to next-20230728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Add-min_unsigned-a-b-and-max_unsigned-a-b/20230728-225439
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/bf92800b0c5445e2b2ca8c88e1f5e90f%40AcuMS.aculab.com
patch subject: [PATCH next v2 2/5] minmax: Allow min()/max()/clamp() if the arguments have the same signedness.
config: s390-randconfig-r044-20230728 (https://download.01.org/0day-ci/archive/20230729/202307290943.ODVeyeK6-lkp@intel.com/config)
compiler: clang version 15.0.7 (https://github.com/llvm/llvm-project.git 8dfdcc7b7bf66834a761bd8de445840ef68e4d1a)
reproduce: (https://download.01.org/0day-ci/archive/20230729/202307290943.ODVeyeK6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307290943.ODVeyeK6-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from mm/percpu.c:73:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from mm/percpu.c:73:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from mm/percpu.c:73:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> mm/percpu.c:3102:10: error: static assertion expression is not an integral constant expression
                   base = min(ptr, base);
                          ^~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                   ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:23:2: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
           ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   mm/percpu.c:3102:10: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                                 ^
   include/linux/minmax.h:23:3: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
            ^
   include/linux/compiler.h:237:32: note: expanded from macro 'is_signed_type'
   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
                                  ^
   12 warnings and 1 error generated.
--
   In file included from mm/kmemleak.c:86:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from mm/kmemleak.c:86:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from mm/kmemleak.c:86:
   In file included from include/linux/memblock.h:13:
   In file included from arch/s390/include/asm/dma.h:5:
   In file included from include/linux/io.h:13:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> mm/kmemleak.c:1389:10: error: static assertion expression is not an integral constant expression
                   next = min(start + MAX_SCAN_SIZE, end);
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                   ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:23:2: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
           ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   mm/kmemleak.c:1389:10: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                                 ^
   include/linux/minmax.h:23:3: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
            ^
   include/linux/compiler.h:237:32: note: expanded from macro 'is_signed_type'
   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
                                  ^
   mm/kmemleak.c:1429:11: error: static assertion expression is not an integral constant expression
                           next = min(start + MAX_SCAN_SIZE, end);
                                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                   ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:23:2: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
           ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   mm/kmemleak.c:1429:11: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
   include/linux/minmax.h:67:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(min, x, y)
                           ^
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                                 ^
   include/linux/minmax.h:23:3: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
            ^
   include/linux/compiler.h:237:32: note: expanded from macro 'is_signed_type'
   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
                                  ^
   12 warnings and 2 errors generated.
--
   In file included from crypto/skcipher.c:15:
   In file included from include/crypto/scatterwalk.h:18:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from crypto/skcipher.c:15:
   In file included from include/crypto/scatterwalk.h:18:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from crypto/skcipher.c:15:
   In file included from include/crypto/scatterwalk.h:18:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:78:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> crypto/skcipher.c:80:9: error: static assertion expression is not an integral constant expression
           return max(start, end_page);
                  ^~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:74:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(max, x, y)
                           ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                   ~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:23:2: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
           ^
   include/linux/build_bug.h:77:50: note: expanded from macro 'static_assert'
   #define static_assert(expr, ...) __static_assert(expr, ##__VA_ARGS__, #expr)
                                    ~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: expanded from macro '__static_assert'
   #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
                                                          ^~~~
   crypto/skcipher.c:80:9: note: cast that performs the conversions of a reinterpret_cast is not allowed in a constant expression
   include/linux/minmax.h:74:19: note: expanded from macro 'max'
   #define max(x, y)       __careful_cmp(max, x, y)
                           ^
   include/linux/minmax.h:40:3: note: expanded from macro '__careful_cmp'
                   __cmp_once(op, x, y, __UNIQUE_ID(__x), __UNIQUE_ID(__y)))
                   ^
   include/linux/minmax.h:33:17: note: expanded from macro '__cmp_once'
                   static_assert(__types_ok(x, y),         \
                                 ^
   include/linux/minmax.h:23:3: note: expanded from macro '__types_ok'
           (is_signed_type(typeof(x)) == is_signed_type(typeof(y)))
            ^
   include/linux/compiler.h:237:32: note: expanded from macro 'is_signed_type'
   #define is_signed_type(type) (((type)(-1)) < (__force type)1)
                                  ^
   12 warnings and 1 error generated.
..


vim +3102 mm/percpu.c

3c9a024fde58b08 Tejun Heo       2010-09-09  3022  
3c9a024fde58b08 Tejun Heo       2010-09-09  3023  #if defined(BUILD_EMBED_FIRST_CHUNK)
66c3a75772247c3 Tejun Heo       2009-03-10  3024  /**
66c3a75772247c3 Tejun Heo       2009-03-10  3025   * pcpu_embed_first_chunk - embed the first percpu chunk into bootmem
66c3a75772247c3 Tejun Heo       2009-03-10  3026   * @reserved_size: the size of reserved percpu area in bytes
4ba6ce250e406b2 Tejun Heo       2010-06-27  3027   * @dyn_size: minimum free size for dynamic allocation in bytes
c8826dd538602d7 Tejun Heo       2009-08-14  3028   * @atom_size: allocation atom size
c8826dd538602d7 Tejun Heo       2009-08-14  3029   * @cpu_distance_fn: callback to determine distance between cpus, optional
1ca3fb3abd2b615 Kefeng Wang     2022-01-19  3030   * @cpu_to_nd_fn: callback to convert cpu to it's node, optional
66c3a75772247c3 Tejun Heo       2009-03-10  3031   *
66c3a75772247c3 Tejun Heo       2009-03-10  3032   * This is a helper to ease setting up embedded first percpu chunk and
66c3a75772247c3 Tejun Heo       2009-03-10  3033   * can be called where pcpu_setup_first_chunk() is expected.
66c3a75772247c3 Tejun Heo       2009-03-10  3034   *
66c3a75772247c3 Tejun Heo       2009-03-10  3035   * If this function is used to setup the first chunk, it is allocated
23f917169ef157a Kefeng Wang     2022-01-19  3036   * by calling pcpu_fc_alloc and used as-is without being mapped into
c8826dd538602d7 Tejun Heo       2009-08-14  3037   * vmalloc area.  Allocations are always whole multiples of @atom_size
c8826dd538602d7 Tejun Heo       2009-08-14  3038   * aligned to @atom_size.
c8826dd538602d7 Tejun Heo       2009-08-14  3039   *
c8826dd538602d7 Tejun Heo       2009-08-14  3040   * This enables the first chunk to piggy back on the linear physical
c8826dd538602d7 Tejun Heo       2009-08-14  3041   * mapping which often uses larger page size.  Please note that this
c8826dd538602d7 Tejun Heo       2009-08-14  3042   * can result in very sparse cpu->unit mapping on NUMA machines thus
c8826dd538602d7 Tejun Heo       2009-08-14  3043   * requiring large vmalloc address space.  Don't use this allocator if
c8826dd538602d7 Tejun Heo       2009-08-14  3044   * vmalloc space is not orders of magnitude larger than distances
c8826dd538602d7 Tejun Heo       2009-08-14  3045   * between node memory addresses (ie. 32bit NUMA machines).
66c3a75772247c3 Tejun Heo       2009-03-10  3046   *
4ba6ce250e406b2 Tejun Heo       2010-06-27  3047   * @dyn_size specifies the minimum dynamic area size.
66c3a75772247c3 Tejun Heo       2009-03-10  3048   *
66c3a75772247c3 Tejun Heo       2009-03-10  3049   * If the needed size is smaller than the minimum or specified unit
23f917169ef157a Kefeng Wang     2022-01-19  3050   * size, the leftover is returned using pcpu_fc_free.
66c3a75772247c3 Tejun Heo       2009-03-10  3051   *
66c3a75772247c3 Tejun Heo       2009-03-10  3052   * RETURNS:
fb435d5233f8b6f Tejun Heo       2009-08-14  3053   * 0 on success, -errno on failure.
66c3a75772247c3 Tejun Heo       2009-03-10  3054   */
4ba6ce250e406b2 Tejun Heo       2010-06-27  3055  int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
c8826dd538602d7 Tejun Heo       2009-08-14  3056  				  size_t atom_size,
c8826dd538602d7 Tejun Heo       2009-08-14  3057  				  pcpu_fc_cpu_distance_fn_t cpu_distance_fn,
23f917169ef157a Kefeng Wang     2022-01-19  3058  				  pcpu_fc_cpu_to_node_fn_t cpu_to_nd_fn)
66c3a75772247c3 Tejun Heo       2009-03-10  3059  {
c8826dd538602d7 Tejun Heo       2009-08-14  3060  	void *base = (void *)ULONG_MAX;
c8826dd538602d7 Tejun Heo       2009-08-14  3061  	void **areas = NULL;
fd1e8a1fe2b54df Tejun Heo       2009-08-14  3062  	struct pcpu_alloc_info *ai;
93c76b6b2faaad7 zijun_hu        2016-10-05  3063  	size_t size_sum, areas_size;
93c76b6b2faaad7 zijun_hu        2016-10-05  3064  	unsigned long max_distance;
163fa23435cc9c7 Kefeng Wang     2019-07-03  3065  	int group, i, highest_group, rc = 0;
66c3a75772247c3 Tejun Heo       2009-03-10  3066  
c8826dd538602d7 Tejun Heo       2009-08-14  3067  	ai = pcpu_build_alloc_info(reserved_size, dyn_size, atom_size,
c8826dd538602d7 Tejun Heo       2009-08-14  3068  				   cpu_distance_fn);
fd1e8a1fe2b54df Tejun Heo       2009-08-14  3069  	if (IS_ERR(ai))
fd1e8a1fe2b54df Tejun Heo       2009-08-14  3070  		return PTR_ERR(ai);
66c3a75772247c3 Tejun Heo       2009-03-10  3071  
fd1e8a1fe2b54df Tejun Heo       2009-08-14  3072  	size_sum = ai->static_size + ai->reserved_size + ai->dyn_size;
c8826dd538602d7 Tejun Heo       2009-08-14  3073  	areas_size = PFN_ALIGN(ai->nr_groups * sizeof(void *));
fa8a7094ba1679b Tejun Heo       2009-06-22  3074  
26fb3dae0a1ec78 Mike Rapoport   2019-03-11  3075  	areas = memblock_alloc(areas_size, SMP_CACHE_BYTES);
c8826dd538602d7 Tejun Heo       2009-08-14  3076  	if (!areas) {
fb435d5233f8b6f Tejun Heo       2009-08-14  3077  		rc = -ENOMEM;
c8826dd538602d7 Tejun Heo       2009-08-14  3078  		goto out_free;
fa8a7094ba1679b Tejun Heo       2009-06-22  3079  	}
66c3a75772247c3 Tejun Heo       2009-03-10  3080  
9b7396624a7b503 zijun_hu        2016-10-05  3081  	/* allocate, copy and determine base address & max_distance */
9b7396624a7b503 zijun_hu        2016-10-05  3082  	highest_group = 0;
c8826dd538602d7 Tejun Heo       2009-08-14  3083  	for (group = 0; group < ai->nr_groups; group++) {
c8826dd538602d7 Tejun Heo       2009-08-14  3084  		struct pcpu_group_info *gi = &ai->groups[group];
c8826dd538602d7 Tejun Heo       2009-08-14  3085  		unsigned int cpu = NR_CPUS;
c8826dd538602d7 Tejun Heo       2009-08-14  3086  		void *ptr;
c8826dd538602d7 Tejun Heo       2009-08-14  3087  
c8826dd538602d7 Tejun Heo       2009-08-14  3088  		for (i = 0; i < gi->nr_units && cpu == NR_CPUS; i++)
c8826dd538602d7 Tejun Heo       2009-08-14  3089  			cpu = gi->cpu_map[i];
c8826dd538602d7 Tejun Heo       2009-08-14  3090  		BUG_ON(cpu == NR_CPUS);
c8826dd538602d7 Tejun Heo       2009-08-14  3091  
c8826dd538602d7 Tejun Heo       2009-08-14  3092  		/* allocate space for the whole group */
23f917169ef157a Kefeng Wang     2022-01-19  3093  		ptr = pcpu_fc_alloc(cpu, gi->nr_units * ai->unit_size, atom_size, cpu_to_nd_fn);
c8826dd538602d7 Tejun Heo       2009-08-14  3094  		if (!ptr) {
c8826dd538602d7 Tejun Heo       2009-08-14  3095  			rc = -ENOMEM;
c8826dd538602d7 Tejun Heo       2009-08-14  3096  			goto out_free_areas;
c8826dd538602d7 Tejun Heo       2009-08-14  3097  		}
f528f0b8e53d73b Catalin Marinas 2011-09-26  3098  		/* kmemleak tracks the percpu allocations separately */
a317ebccaa36099 Patrick Wang    2022-07-05  3099  		kmemleak_ignore_phys(__pa(ptr));
c8826dd538602d7 Tejun Heo       2009-08-14  3100  		areas[group] = ptr;
c8826dd538602d7 Tejun Heo       2009-08-14  3101  
c8826dd538602d7 Tejun Heo       2009-08-14 @3102  		base = min(ptr, base);
9b7396624a7b503 zijun_hu        2016-10-05  3103  		if (ptr > areas[highest_group])
9b7396624a7b503 zijun_hu        2016-10-05  3104  			highest_group = group;
9b7396624a7b503 zijun_hu        2016-10-05  3105  	}
9b7396624a7b503 zijun_hu        2016-10-05  3106  	max_distance = areas[highest_group] - base;
9b7396624a7b503 zijun_hu        2016-10-05  3107  	max_distance += ai->unit_size * ai->groups[highest_group].nr_units;
9b7396624a7b503 zijun_hu        2016-10-05  3108  
9b7396624a7b503 zijun_hu        2016-10-05  3109  	/* warn if maximum distance is further than 75% of vmalloc space */
9b7396624a7b503 zijun_hu        2016-10-05  3110  	if (max_distance > VMALLOC_TOTAL * 3 / 4) {
9b7396624a7b503 zijun_hu        2016-10-05  3111  		pr_warn("max_distance=0x%lx too large for vmalloc space 0x%lx\n",
9b7396624a7b503 zijun_hu        2016-10-05  3112  				max_distance, VMALLOC_TOTAL);
9b7396624a7b503 zijun_hu        2016-10-05  3113  #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
9b7396624a7b503 zijun_hu        2016-10-05  3114  		/* and fail if we have fallback */
9b7396624a7b503 zijun_hu        2016-10-05  3115  		rc = -EINVAL;
9b7396624a7b503 zijun_hu        2016-10-05  3116  		goto out_free_areas;
9b7396624a7b503 zijun_hu        2016-10-05  3117  #endif
42b64281453249d Tejun Heo       2012-04-27  3118  	}
42b64281453249d Tejun Heo       2012-04-27  3119  
42b64281453249d Tejun Heo       2012-04-27  3120  	/*
42b64281453249d Tejun Heo       2012-04-27  3121  	 * Copy data and free unused parts.  This should happen after all
42b64281453249d Tejun Heo       2012-04-27  3122  	 * allocations are complete; otherwise, we may end up with
42b64281453249d Tejun Heo       2012-04-27  3123  	 * overlapping groups.
42b64281453249d Tejun Heo       2012-04-27  3124  	 */
42b64281453249d Tejun Heo       2012-04-27  3125  	for (group = 0; group < ai->nr_groups; group++) {
42b64281453249d Tejun Heo       2012-04-27  3126  		struct pcpu_group_info *gi = &ai->groups[group];
42b64281453249d Tejun Heo       2012-04-27  3127  		void *ptr = areas[group];
66c3a75772247c3 Tejun Heo       2009-03-10  3128  
c8826dd538602d7 Tejun Heo       2009-08-14  3129  		for (i = 0; i < gi->nr_units; i++, ptr += ai->unit_size) {
c8826dd538602d7 Tejun Heo       2009-08-14  3130  			if (gi->cpu_map[i] == NR_CPUS) {
c8826dd538602d7 Tejun Heo       2009-08-14  3131  				/* unused unit, free whole */
23f917169ef157a Kefeng Wang     2022-01-19  3132  				pcpu_fc_free(ptr, ai->unit_size);
c8826dd538602d7 Tejun Heo       2009-08-14  3133  				continue;
c8826dd538602d7 Tejun Heo       2009-08-14  3134  			}
c8826dd538602d7 Tejun Heo       2009-08-14  3135  			/* copy and return the unused part */
fd1e8a1fe2b54df Tejun Heo       2009-08-14  3136  			memcpy(ptr, __per_cpu_load, ai->static_size);
23f917169ef157a Kefeng Wang     2022-01-19  3137  			pcpu_fc_free(ptr + size_sum, ai->unit_size - size_sum);
c8826dd538602d7 Tejun Heo       2009-08-14  3138  		}
66c3a75772247c3 Tejun Heo       2009-03-10  3139  	}
66c3a75772247c3 Tejun Heo       2009-03-10  3140  
c8826dd538602d7 Tejun Heo       2009-08-14  3141  	/* base address is now known, determine group base offsets */
6ea529a2037ce66 Tejun Heo       2009-09-24  3142  	for (group = 0; group < ai->nr_groups; group++) {
c8826dd538602d7 Tejun Heo       2009-08-14  3143  		ai->groups[group].base_offset = areas[group] - base;
6ea529a2037ce66 Tejun Heo       2009-09-24  3144  	}
c8826dd538602d7 Tejun Heo       2009-08-14  3145  
00206a69ee32f03 Matteo Croce    2019-03-18  3146  	pr_info("Embedded %zu pages/cpu s%zu r%zu d%zu u%zu\n",
00206a69ee32f03 Matteo Croce    2019-03-18  3147  		PFN_DOWN(size_sum), ai->static_size, ai->reserved_size,
fd1e8a1fe2b54df Tejun Heo       2009-08-14  3148  		ai->dyn_size, ai->unit_size);
66c3a75772247c3 Tejun Heo       2009-03-10  3149  
163fa23435cc9c7 Kefeng Wang     2019-07-03  3150  	pcpu_setup_first_chunk(ai, base);
c8826dd538602d7 Tejun Heo       2009-08-14  3151  	goto out_free;
c8826dd538602d7 Tejun Heo       2009-08-14  3152  
c8826dd538602d7 Tejun Heo       2009-08-14  3153  out_free_areas:
c8826dd538602d7 Tejun Heo       2009-08-14  3154  	for (group = 0; group < ai->nr_groups; group++)
f851c8d8583891a Michael Holzheu 2013-09-17  3155  		if (areas[group])
23f917169ef157a Kefeng Wang     2022-01-19  3156  			pcpu_fc_free(areas[group],
c8826dd538602d7 Tejun Heo       2009-08-14  3157  				ai->groups[group].nr_units * ai->unit_size);
c8826dd538602d7 Tejun Heo       2009-08-14  3158  out_free:
fd1e8a1fe2b54df Tejun Heo       2009-08-14  3159  	pcpu_free_alloc_info(ai);
c8826dd538602d7 Tejun Heo       2009-08-14  3160  	if (areas)
4421cca0a3e4833 Mike Rapoport   2021-11-05  3161  		memblock_free(areas, areas_size);
fb435d5233f8b6f Tejun Heo       2009-08-14  3162  	return rc;
fa8a7094ba1679b Tejun Heo       2009-06-22  3163  }
3c9a024fde58b08 Tejun Heo       2010-09-09  3164  #endif /* BUILD_EMBED_FIRST_CHUNK */
d4b95f80399471e Tejun Heo       2009-07-04  3165  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
