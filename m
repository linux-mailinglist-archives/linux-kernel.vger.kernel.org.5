Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A6D75BC4C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 04:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjGUCbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 22:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGUCbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 22:31:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBAD211B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 19:31:02 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R6YS44vNHz18LQp;
        Fri, 21 Jul 2023 10:30:12 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 10:30:57 +0800
Message-ID: <fc955d9b-c9f0-47b5-063a-b82c52550fe9@huawei.com>
Date:   Fri, 21 Jul 2023 10:30:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 09/10] mm/page_io: convert count_swpout_vm_event() to
 take in a folio
Content-Language: en-US
To:     kernel test robot <lkp@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <willy@infradead.org>
CC:     <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
        <hch@infradead.org>, <sidhartha.kumar@oracle.com>,
        <akpm@linux-foundation.org>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230720130147.4071649-10-zhangpeng362@huawei.com>
 <202307210951.NCdscoSS-lkp@intel.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <202307210951.NCdscoSS-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/21 9:31, kernel test robot wrote:

> Hi Peng,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on akpm-mm/mm-everything]
> [also build test ERROR on axboe-block/for-next linus/master v6.5-rc2 next-20230720]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/mm-page_io-remove-unneeded-ClearPageUptodate/20230720-210515
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> patch link:    https://lore.kernel.org/r/20230720130147.4071649-10-zhangpeng362%40huawei.com
> patch subject: [PATCH v3 09/10] mm/page_io: convert count_swpout_vm_event() to take in a folio
> config: um-randconfig-r003-20230720 (https://download.01.org/0day-ci/archive/20230721/202307210951.NCdscoSS-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
> reproduce: (https://download.01.org/0day-ci/archive/20230721/202307210951.NCdscoSS-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202307210951.NCdscoSS-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>     In file included from mm/page_io.c:15:
>     In file included from include/linux/kernel_stat.h:9:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from arch/um/include/asm/hardirq.h:5:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/um/include/asm/io.h:24:
>     include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       547 |         val = __raw_readb(PCI_IOBASE + addr);
>           |                           ~~~~~~~~~~ ^
>     include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
>        37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
>           |                                                   ^
>     In file included from mm/page_io.c:15:
>     In file included from include/linux/kernel_stat.h:9:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from arch/um/include/asm/hardirq.h:5:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/um/include/asm/io.h:24:
>     include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
>           |                                                         ~~~~~~~~~~ ^
>     include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
>        35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>           |                                                   ^
>     In file included from mm/page_io.c:15:
>     In file included from include/linux/kernel_stat.h:9:
>     In file included from include/linux/interrupt.h:11:
>     In file included from include/linux/hardirq.h:11:
>     In file included from arch/um/include/asm/hardirq.h:5:
>     In file included from include/asm-generic/hardirq.h:17:
>     In file included from include/linux/irq.h:20:
>     In file included from include/linux/io.h:13:
>     In file included from arch/um/include/asm/io.h:24:
>     include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       584 |         __raw_writeb(value, PCI_IOBASE + addr);
>           |                             ~~~~~~~~~~ ^
>     include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
>           |                                                       ~~~~~~~~~~ ^
>     include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       692 |         readsb(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       700 |         readsw(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       708 |         readsl(PCI_IOBASE + addr, buffer, count);
>           |                ~~~~~~~~~~ ^
>     include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       717 |         writesb(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       726 |         writesw(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>     include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>       735 |         writesl(PCI_IOBASE + addr, buffer, count);
>           |                 ~~~~~~~~~~ ^
>>> mm/page_io.c:211:18: error: use of undeclared identifier 'THP_SWPOUT'; did you mean 'PSWPOUT'?
>       211 |                 count_vm_event(THP_SWPOUT);
>           |                                ^~~~~~~~~~
>           |                                PSWPOUT
>     include/linux/vm_event_item.h:32:47: note: 'PSWPOUT' declared here
>        32 | enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>           |                                               ^
>     12 warnings and 1 error generated.

I will fix it in the next version. Thanks.

>
> vim +211 mm/page_io.c
>
> 2f772e6cadf8ad Seth Jennings 2013-04-29  207
> c40c44eb86eb74 ZhangPeng     2023-07-20  208  static inline void count_swpout_vm_event(struct folio *folio)
> 225311a46411c3 Huang Ying    2017-09-06  209  {
> c40c44eb86eb74 ZhangPeng     2023-07-20  210  	if (unlikely(folio_test_pmd_mappable(folio)))
> 225311a46411c3 Huang Ying    2017-09-06 @211  		count_vm_event(THP_SWPOUT);
> c40c44eb86eb74 ZhangPeng     2023-07-20  212  	count_vm_events(PSWPOUT, folio_nr_pages(folio));
> 225311a46411c3 Huang Ying    2017-09-06  213  }
> 225311a46411c3 Huang Ying    2017-09-06  214
>
-- 
Best Regards,
Peng

