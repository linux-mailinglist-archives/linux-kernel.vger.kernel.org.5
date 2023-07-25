Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64541761B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbjGYOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjGYOU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:20:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A1270F
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690294562; x=1721830562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jf0hGveR8VnC7khCzTYgz4+84014slJ7CKnSAzdH/sA=;
  b=IeBcHuF21HTKFtaQHkFDy37XvOoU70wibGZI49V0RvCDS39nBApghcRa
   urSCIv81fMkzA+nm+V7NvMDoPS1gyPW/ViHmF0GG3qD9DtuRhv/He3Mq+
   vHmK2Pa7pF9rNo579HQ9hfkmNdrelbaCq6wE/yy5Yf1IhZW8szu5zqwnj
   uekb5EETJgNVRRja+WzmB8kwIu6QJeWN7KMhRorTBxm7mu30sQILg4AIi
   V5AtyRSxo35WmwxszcV0IAWJ6C25kR136zcLIuAUElRKvggC43reSelYa
   lDj6S85lDVokAqH0bvyQ6dpq7z8iMicEFkqrCXBkDOfeOM10SqCGrSS4/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="367762656"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="367762656"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 07:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="972704897"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="972704897"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 25 Jul 2023 07:15:32 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOIos-00001J-2q;
        Tue, 25 Jul 2023 14:15:25 +0000
Date:   Tue, 25 Jul 2023 22:14:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <202307252139.Kz3mgUAw-lkp@intel.com>
References: <454f967d452548a9acfa7c0a0872507e@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454f967d452548a9acfa7c0a0872507e@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test ERROR on linus/master v6.5-rc3 next-20230725]
[cannot apply to next-20230725 hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Add-min_unsigned-a-b-and-max_unsigned-a-b/20230725-180332
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/454f967d452548a9acfa7c0a0872507e%40AcuMS.aculab.com
patch subject: [PATCH next 2/5] minmax: Allow min()/max()/clamp() if the arguments have the same signedness.
config: loongarch-allnoconfig (https://download.01.org/0day-ci/archive/20230725/202307252139.Kz3mgUAw-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230725/202307252139.Kz3mgUAw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307252139.Kz3mgUAw-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/irqdomain.h:36,
                    from arch/loongarch/include/asm/irq.h:8,
                    from include/linux/irq.h:23,
                    from arch/loongarch/include/asm/hardirq.h:10,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/irqchip/irq-loongarch-cpu.c:8:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/of.h:1478:31: note: in definition of macro '_OF_DECLARE'
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                               ^~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   include/linux/irqchip.h:37:45: note: in expansion of macro 'typecheck_irq_init_cb'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-cpu.c:110:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     110 | IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", cpuintc_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-cpu.c:110:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     110 | IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", cpuintc_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_cpu_intc.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongarch-cpu.c:110:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     110 | IRQCHIP_DECLARE(cpu_intc, "loongson,cpu-interrupt-controller", cpuintc_of_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqdomain.h:36,
                    from arch/loongarch/include/asm/irq.h:8,
                    from include/linux/irq.h:23,
                    from arch/loongarch/include/asm/hardirq.h:10,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/irqchip/irq-loongson-liointc.c:10:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/of.h:1478:31: note: in definition of macro '_OF_DECLARE'
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                               ^~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   include/linux/irqchip.h:37:45: note: in expansion of macro 'typecheck_irq_init_cb'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-liointc.c:371:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     371 | IRQCHIP_DECLARE(loongson_liointc_1_0, "loongson,liointc-1.0", liointc_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-liointc.c:371:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     371 | IRQCHIP_DECLARE(loongson_liointc_1_0, "loongson,liointc-1.0", liointc_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_loongson_liointc_1_0.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-liointc.c:371:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     371 | IRQCHIP_DECLARE(loongson_liointc_1_0, "loongson,liointc-1.0", liointc_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-liointc.c:372:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     372 | IRQCHIP_DECLARE(loongson_liointc_1_0a, "loongson,liointc-1.0a", liointc_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_loongson_liointc_1_0a.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-liointc.c:372:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     372 | IRQCHIP_DECLARE(loongson_liointc_1_0a, "loongson,liointc-1.0a", liointc_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-liointc.c:373:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     373 | IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_loongson_liointc_2_0.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-liointc.c:373:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     373 | IRQCHIP_DECLARE(loongson_liointc_2_0, "loongson,liointc-2.0", liointc_of_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqdomain.h:36,
                    from arch/loongarch/include/asm/irq.h:8,
                    from include/linux/irq.h:23,
                    from arch/loongarch/include/asm/hardirq.h:10,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/irqchip/irq-loongson-eiointc.c:11:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/of.h:1478:31: note: in definition of macro '_OF_DECLARE'
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                               ^~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   include/linux/irqchip.h:37:45: note: in expansion of macro 'typecheck_irq_init_cb'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c:508:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     508 | IRQCHIP_DECLARE(loongson_ls2k0500_eiointc, "loongson,ls2k0500-eiointc", eiointc_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c:508:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     508 | IRQCHIP_DECLARE(loongson_ls2k0500_eiointc, "loongson,ls2k0500-eiointc", eiointc_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_loongson_ls2k0500_eiointc.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c:508:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     508 | IRQCHIP_DECLARE(loongson_ls2k0500_eiointc, "loongson,ls2k0500-eiointc", eiointc_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c:509:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     509 | IRQCHIP_DECLARE(loongson_ls2k2000_eiointc, "loongson,ls2k2000-eiointc", eiointc_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_loongson_ls2k2000_eiointc.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-eiointc.c:509:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     509 | IRQCHIP_DECLARE(loongson_ls2k2000_eiointc, "loongson,ls2k2000-eiointc", eiointc_of_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqdomain.h:36,
                    from arch/loongarch/include/asm/irq.h:8,
                    from include/linux/irq.h:23,
                    from arch/loongarch/include/asm/hardirq.h:10,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/irqchip/irq-loongson-htvec.c:9:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/of.h:1478:31: note: in definition of macro '_OF_DECLARE'
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                               ^~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   include/linux/irqchip.h:37:45: note: in expansion of macro 'typecheck_irq_init_cb'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-htvec.c:257:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     257 | IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-htvec.c:257:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     257 | IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_htvec.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-htvec.c:257:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     257 | IRQCHIP_DECLARE(htvec, "loongson,htvec-1.0", htvec_of_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqdomain.h:36,
                    from arch/loongarch/include/asm/irq.h:8,
                    from include/linux/irq.h:23,
                    from arch/loongarch/include/asm/hardirq.h:10,
                    from include/linux/hardirq.h:11,
                    from include/linux/interrupt.h:11,
                    from drivers/irqchip/irq-loongson-pch-pic.c:9:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/of.h:1478:31: note: in definition of macro '_OF_DECLARE'
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                               ^~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   include/linux/irqchip.h:37:45: note: in expansion of macro 'typecheck_irq_init_cb'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-pic.c:358:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     358 | IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
         | ^~~~~~~~~~~~~~~
>> include/linux/of.h:1478:30: error: initializer element is not constant
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-pic.c:358:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     358 | IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_pch_pic.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-pic.c:358:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     358 | IRQCHIP_DECLARE(pch_pic, "loongson,pch-pic-1.0", pch_pic_of_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +24 include/linux/irqchip.h

f1985002839af8 Marc Zyngier 2021-10-20  22  
f1985002839af8 Marc Zyngier 2021-10-20  23  #define typecheck_irq_init_cb(fn)					\
f1985002839af8 Marc Zyngier 2021-10-20 @24  	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
f1985002839af8 Marc Zyngier 2021-10-20  25  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
