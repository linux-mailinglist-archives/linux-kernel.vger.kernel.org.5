Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6B276666E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjG1IJM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233664AbjG1IJC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:09:02 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951E430E0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 01:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690531740; x=1722067740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Zf3u9MqOYiM0cW/8pxHoBN78bqdIoMm8eVEVTQKPBoo=;
  b=esac5/HOS1JeBz3FH1mpu14O3bTpoo2hF7t9BFQD0qXg47e5v1u89NBD
   Y7ecIalzIAetqkWBdbqAZ75+PYDW7tw0u0wwTN/l7ek/BzXPbTcYxnyLe
   EDsO3YOXgz0zXkSASn5Mv1FAwqfAzyCLraz+tTeGgJlp8HxewQnkFQeTW
   WsJ89skqxRb+HQaCmcz2+0STGOyCyroBhjc8hOnv//SFcXGlzQRnKc3i/
   DfkVATdG3pJ5i7dZRi2pLeLvg2IzWwBKx2E+Iq5EptlVlkS5hgnpkcTEf
   LwFirZ8vRu57UZ+f04dtcNhlt847PvS+JPVKtVGxsKOWwD7XZcKg03wgt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="358562649"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="358562649"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 01:09:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817411261"
X-IronPort-AV: E=Sophos;i="6.01,236,1684825200"; 
   d="scan'208";a="817411261"
Received: from lkp-server02.sh.intel.com (HELO 953e8cd98f7d) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jul 2023 01:08:57 -0700
Received: from kbuild by 953e8cd98f7d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qPIWu-000311-2M;
        Fri, 28 Jul 2023 08:08:56 +0000
Date:   Fri, 28 Jul 2023 16:08:10 +0800
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
Subject: Re: [PATCH next resend 5/5] minmax: Relax check to allow comparison
 between int and small unsigned constants.
Message-ID: <202307281556.iTVIR4tJ-lkp@intel.com>
References: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48c2cd0407f14859919d4fcbe526234a@AcuMS.aculab.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-everything]
[also build test WARNING on linus/master crng-random/master v6.5-rc3 next-20230728]
[cannot apply to next-20230725]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Laight/minmax-Allow-min-max-clamp-if-the-arguments-have-the-same-signedness/20230725-204940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
patch link:    https://lore.kernel.org/r/48c2cd0407f14859919d4fcbe526234a%40AcuMS.aculab.com
patch subject: [PATCH next resend 5/5] minmax: Relax check to allow comparison between int and small unsigned constants.
config: xtensa-randconfig-r093-20230725 (https://download.01.org/0day-ci/archive/20230728/202307281556.iTVIR4tJ-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230728/202307281556.iTVIR4tJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307281556.iTVIR4tJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   mm/kmemleak.c: note: in included file (through arch/xtensa/include/asm/bitops.h, include/linux/bitops.h, include/linux/kernel.h):
   arch/xtensa/include/asm/processor.h:103:2: sparse: sparse: Unsupported xtensa ABI
   arch/xtensa/include/asm/processor.h:133:2: sparse: sparse: Unsupported Xtensa ABI
>> mm/kmemleak.c:1429:32: sparse: sparse: incompatible types for operation (>=):
>> mm/kmemleak.c:1429:32: sparse:    void *
>> mm/kmemleak.c:1429:32: sparse:    int
>> mm/kmemleak.c:1429:32: sparse: sparse: bad constant expression type
>> mm/kmemleak.c:1429:32: sparse: sparse: incompatible types for operation (>=):
>> mm/kmemleak.c:1429:32: sparse:    void *
>> mm/kmemleak.c:1429:32: sparse:    int
>> mm/kmemleak.c:1429:32: sparse: sparse: incompatible types for operation (>=):
>> mm/kmemleak.c:1429:32: sparse:    void *end
>> mm/kmemleak.c:1429:32: sparse:    int
>> mm/kmemleak.c:1429:32: sparse: sparse: incompatible types for operation (>=):
>> mm/kmemleak.c:1429:32: sparse:    void *
>> mm/kmemleak.c:1429:32: sparse:    int
>> mm/kmemleak.c:1429:32: sparse: sparse: incompatible types for operation (>=):
>> mm/kmemleak.c:1429:32: sparse:    void *end
>> mm/kmemleak.c:1429:32: sparse:    int
   mm/kmemleak.c:1429:32: sparse: sparse: incompatible types for operation (<):
   mm/kmemleak.c:1429:32: sparse:    bad type __UNIQUE_ID___x229
   mm/kmemleak.c:1429:32: sparse:    bad type __UNIQUE_ID___y230

vim +1429 mm/kmemleak.c

3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1396  
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1397  /*
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1398   * Scan a memory block corresponding to a kmemleak_object. A condition is
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1399   * that object->use_count >= 1.
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1400   */
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1401  static void scan_object(struct kmemleak_object *object)
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1402  {
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1403  	struct kmemleak_scan_area *area;
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1404  	unsigned long flags;
0c24e061196c21 Patrick Wang     2022-06-11  1405  	void *obj_ptr;
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1406  
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1407  	/*
21ae2956ce289f Uwe Kleine-König 2009-10-07  1408  	 * Once the object->lock is acquired, the corresponding memory block
21ae2956ce289f Uwe Kleine-König 2009-10-07  1409  	 * cannot be freed (the same lock is acquired in delete_object).
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1410  	 */
8c96f1bc6fc49c He Zhe           2020-01-30  1411  	raw_spin_lock_irqsave(&object->lock, flags);
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1412  	if (object->flags & OBJECT_NO_SCAN)
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1413  		goto out;
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1414  	if (!(object->flags & OBJECT_ALLOCATED))
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1415  		/* already freed object */
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1416  		goto out;
0c24e061196c21 Patrick Wang     2022-06-11  1417  
0c24e061196c21 Patrick Wang     2022-06-11  1418  	obj_ptr = object->flags & OBJECT_PHYS ?
0c24e061196c21 Patrick Wang     2022-06-11  1419  		  __va((phys_addr_t)object->pointer) :
0c24e061196c21 Patrick Wang     2022-06-11  1420  		  (void *)object->pointer;
0c24e061196c21 Patrick Wang     2022-06-11  1421  
dba82d9431770e Catalin Marinas  2019-09-23  1422  	if (hlist_empty(&object->area_list) ||
dba82d9431770e Catalin Marinas  2019-09-23  1423  	    object->flags & OBJECT_FULL_SCAN) {
0c24e061196c21 Patrick Wang     2022-06-11  1424  		void *start = obj_ptr;
0c24e061196c21 Patrick Wang     2022-06-11  1425  		void *end = obj_ptr + object->size;
93ada579b0eea0 Catalin Marinas  2015-06-24  1426  		void *next;
af98603dad87e3 Catalin Marinas  2009-08-27  1427  
93ada579b0eea0 Catalin Marinas  2015-06-24  1428  		do {
93ada579b0eea0 Catalin Marinas  2015-06-24 @1429  			next = min(start + MAX_SCAN_SIZE, end);
93ada579b0eea0 Catalin Marinas  2015-06-24  1430  			scan_block(start, next, object);
93ada579b0eea0 Catalin Marinas  2015-06-24  1431  
93ada579b0eea0 Catalin Marinas  2015-06-24  1432  			start = next;
93ada579b0eea0 Catalin Marinas  2015-06-24  1433  			if (start >= end)
93ada579b0eea0 Catalin Marinas  2015-06-24  1434  				break;
af98603dad87e3 Catalin Marinas  2009-08-27  1435  
8c96f1bc6fc49c He Zhe           2020-01-30  1436  			raw_spin_unlock_irqrestore(&object->lock, flags);
af98603dad87e3 Catalin Marinas  2009-08-27  1437  			cond_resched();
8c96f1bc6fc49c He Zhe           2020-01-30  1438  			raw_spin_lock_irqsave(&object->lock, flags);
93ada579b0eea0 Catalin Marinas  2015-06-24  1439  		} while (object->flags & OBJECT_ALLOCATED);
af98603dad87e3 Catalin Marinas  2009-08-27  1440  	} else
b67bfe0d42cac5 Sasha Levin      2013-02-27  1441  		hlist_for_each_entry(area, &object->area_list, node)
c017b4be3e8417 Catalin Marinas  2009-10-28  1442  			scan_block((void *)area->start,
c017b4be3e8417 Catalin Marinas  2009-10-28  1443  				   (void *)(area->start + area->size),
93ada579b0eea0 Catalin Marinas  2015-06-24  1444  				   object);
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1445  out:
8c96f1bc6fc49c He Zhe           2020-01-30  1446  	raw_spin_unlock_irqrestore(&object->lock, flags);
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1447  }
3c7b4e6b8be4c1 Catalin Marinas  2009-06-11  1448  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
