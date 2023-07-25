Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704FE7620E9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 20:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjGYSEm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 14:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjGYSEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 14:04:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E5011FDE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 11:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690308276; x=1721844276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5yaYFvzrcC2c+MKP9/288rlj3HZSZkDLwU+zCpqOwLo=;
  b=UuWkUl5YRE0qubZsf2hhc0uaIxrkSqm2WC7CfizhqQ9fa7S5eGYTJ+qj
   R5zcJQOrwu1/MFLyFG622YEdSfnzSSAvYa6ZMsrK27e3BY2CJdQEVToS3
   TIrJSBJMMINGNDEjAU1LY/4YkClElK/DI32BJnXcSUWQwWp46zvo4V/r0
   6JSn0S+0MDNBfmowHYr2Z5ImhZE36hi15wKPZRtCLKS7qOp14B0uo0s+4
   Tmc2VTEMjepp8ys1yl+wNcf89NZiyDLWY184BSKvdgNvXLnCJnSJI8pie
   4N9TxqZ/a/lDWUWL3BHRDbtMNoNFmudg5ghXzV7ybemdrvch4YCWpU+jx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="370480901"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="370480901"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 11:04:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="839933309"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="839933309"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2023 11:04:00 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qOMNp-0000Cr-2u;
        Tue, 25 Jul 2023 18:03:47 +0000
Date:   Wed, 26 Jul 2023 02:02:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Laight <David.Laight@aculab.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        "'Matthew Wilcox (Oracle)'" <willy@infradead.org>,
        'Christoph Hellwig' <hch@infradead.org>,
        "'Jason A. Donenfeld'" <Jason@zx2c4.com>
Cc:     oe-kbuild-all@lists.linux.dev,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH next resend 2/5] minmax: Allow min()/max()/clamp() if the
 arguments have the same signedness.
Message-ID: <202307260144.boYg18Ty-lkp@intel.com>
References: <a09512c8526b46759669d0b879144563@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a09512c8526b46759669d0b879144563@AcuMS.aculab.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on akpm-mm/mm-everything]
[also build test ERROR on linus/master v6.5-rc3 next-20230725]
[cannot apply to next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Allow-min-max-clamp-if-the-arguments-have-the-same-signedness/20230725-204940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/a09512c8526b46759669d0b879144563%40AcuMS.aculab.com
patch subject: [PATCH next resend 2/5] minmax: Allow min()/max()/clamp() if the arguments have the same signedness.
config: riscv-randconfig-r024-20230725 (https://download.01.org/0day-ci/archive/20230726/202307260144.boYg18Ty-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230726/202307260144.boYg18Ty-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307260144.boYg18Ty-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-meson-gpio.c:15:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-meson-gpio.c:597:1: note: in expansion of macro 'IRQCHIP_MATCH'
     597 | IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
         | ^~~~~~~~~~~~~
>> include/linux/irqchip.h:24:9: error: initializer element is not constant
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-meson-gpio.c:597:1: note: in expansion of macro 'IRQCHIP_MATCH'
     597 | IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
         | ^~~~~~~~~~~~~
   include/linux/irqchip.h:24:9: note: (near initialization for 'meson_gpio_intc_irqchip_match_table[0].data')
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-meson-gpio.c:597:1: note: in expansion of macro 'IRQCHIP_MATCH'
     597 | IRQCHIP_MATCH("amlogic,meson-gpio-intc", meson_gpio_irq_of_init)
         | ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqchip.h:16,
                    from drivers/irqchip/irq-riscv-intc.c:14:
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
   drivers/irqchip/irq-riscv-intc.c:164:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     164 | IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
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
   drivers/irqchip/irq-riscv-intc.c:164:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     164 | IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_riscv.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-riscv-intc.c:164:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     164 | IRQCHIP_DECLARE(riscv, "riscv,cpu-intc", riscv_intc_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/irqchip/irq-renesas-rzg2l.c:14:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-renesas-rzg2l.c:389:1: note: in expansion of macro 'IRQCHIP_MATCH'
     389 | IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
         | ^~~~~~~~~~~~~
>> include/linux/irqchip.h:24:9: error: initializer element is not constant
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-renesas-rzg2l.c:389:1: note: in expansion of macro 'IRQCHIP_MATCH'
     389 | IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
         | ^~~~~~~~~~~~~
   include/linux/irqchip.h:24:9: note: (near initialization for 'rzg2l_irqc_irqchip_match_table[0].data')
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-renesas-rzg2l.c:389:1: note: in expansion of macro 'IRQCHIP_MATCH'
     389 | IRQCHIP_MATCH("renesas,rzg2l-irqc", rzg2l_irqc_init)
         | ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqchip.h:16,
                    from drivers/irqchip/irq-sifive-plic.c:11:
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
   drivers/irqchip/irq-sifive-plic.c:571:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     571 | IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
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
   drivers/irqchip/irq-sifive-plic.c:571:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     571 | IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_sifive_plic.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-sifive-plic.c:571:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     571 | IRQCHIP_DECLARE(sifive_plic, "sifive,plic-1.0.0", plic_init);
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
   drivers/irqchip/irq-sifive-plic.c:572:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     572 | IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_riscv_plic0.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-sifive-plic.c:572:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     572 | IRQCHIP_DECLARE(riscv_plic0, "riscv,plic0", plic_init); /* for legacy systems */
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
   drivers/irqchip/irq-sifive-plic.c:580:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     580 | IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_andestech_nceplic100.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-sifive-plic.c:580:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     580 | IRQCHIP_DECLARE(andestech_nceplic100, "andestech,nceplic100", plic_edge_init);
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
   drivers/irqchip/irq-sifive-plic.c:581:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     581 | IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_thead_c900_plic.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-sifive-plic.c:581:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     581 | IRQCHIP_DECLARE(thead_c900_plic, "thead,c900-plic", plic_edge_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from include/linux/irqchip.h:16,
                    from drivers/irqchip/irq-mst-intc.c:9:
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
   drivers/irqchip/irq-mst-intc.c:291:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     291 | IRQCHIP_DECLARE(mst_intc, "mstar,mst-intc", mst_intc_of_init);
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
   drivers/irqchip/irq-mst-intc.c:291:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     291 | IRQCHIP_DECLARE(mst_intc, "mstar,mst-intc", mst_intc_of_init);
         | ^~~~~~~~~~~~~~~
   include/linux/of.h:1478:30: note: (near initialization for '__of_table_mst_intc.data')
    1478 |                      .data = (fn == (fn_type)NULL) ? fn : fn  }
         |                              ^
   include/linux/of.h:1493:17: note: in expansion of macro '_OF_DECLARE'
    1493 |                 _OF_DECLARE(table, name, compat, fn, of_init_fn_2)
         |                 ^~~~~~~~~~~
   include/linux/irqchip.h:37:9: note: in expansion of macro 'OF_DECLARE_2'
      37 |         OF_DECLARE_2(irqchip, name, compat, typecheck_irq_init_cb(fn))
         |         ^~~~~~~~~~~~
   drivers/irqchip/irq-mst-intc.c:291:1: note: in expansion of macro 'IRQCHIP_DECLARE'
     291 | IRQCHIP_DECLARE(mst_intc, "mstar,mst-intc", mst_intc_of_init);
         | ^~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   In file included from drivers/irqchip/irq-imx-mu-msi.c:15:
>> include/linux/irqchip.h:24:10: error: implicit declaration of function '__typecheck'; did you mean 'typecheck'? [-Werror=implicit-function-declaration]
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |          ^~~~~~~~~~~
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:445:1: note: in expansion of macro 'IRQCHIP_MATCH'
     445 | IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
         | ^~~~~~~~~~~~~
>> include/linux/irqchip.h:24:9: error: initializer element is not constant
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:445:1: note: in expansion of macro 'IRQCHIP_MATCH'
     445 | IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
         | ^~~~~~~~~~~~~
   include/linux/irqchip.h:24:9: note: (near initialization for 'imx_mu_msi_irqchip_match_table[0].data')
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:445:1: note: in expansion of macro 'IRQCHIP_MATCH'
     445 | IRQCHIP_MATCH("fsl,imx7ulp-mu-msi", imx_mu_imx7ulp_of_init)
         | ^~~~~~~~~~~~~
>> include/linux/irqchip.h:24:9: error: initializer element is not constant
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:446:1: note: in expansion of macro 'IRQCHIP_MATCH'
     446 | IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
         | ^~~~~~~~~~~~~
   include/linux/irqchip.h:24:9: note: (near initialization for 'imx_mu_msi_irqchip_match_table[1].data')
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:446:1: note: in expansion of macro 'IRQCHIP_MATCH'
     446 | IRQCHIP_MATCH("fsl,imx6sx-mu-msi", imx_mu_imx6sx_of_init)
         | ^~~~~~~~~~~~~
>> include/linux/irqchip.h:24:9: error: initializer element is not constant
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:447:1: note: in expansion of macro 'IRQCHIP_MATCH'
     447 | IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
         | ^~~~~~~~~~~~~
   include/linux/irqchip.h:24:9: note: (near initialization for 'imx_mu_msi_irqchip_match_table[2].data')
      24 |         (__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
         |         ^
   include/linux/irqchip.h:45:45: note: in expansion of macro 'typecheck_irq_init_cb'
      45 |                                     .data = typecheck_irq_init_cb(fn), },
         |                                             ^~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-imx-mu-msi.c:447:1: note: in expansion of macro 'IRQCHIP_MATCH'
     447 | IRQCHIP_MATCH("fsl,imx8ulp-mu-msi", imx_mu_imx8ulp_of_init)
         | ^~~~~~~~~~~~~
   cc1: some warnings being treated as errors
..


vim +24 include/linux/irqchip.h

f1985002839af80 Marc Zyngier 2021-10-20  22  
f1985002839af80 Marc Zyngier 2021-10-20  23  #define typecheck_irq_init_cb(fn)					\
f1985002839af80 Marc Zyngier 2021-10-20 @24  	(__typecheck(typecheck_irq_init_cb, &fn) ? fn : fn)
f1985002839af80 Marc Zyngier 2021-10-20  25  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
