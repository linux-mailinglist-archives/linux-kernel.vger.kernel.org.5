Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB407ABCDC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 02:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjIWAuE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 20:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbjIWAuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 20:50:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADA3B9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 17:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695430196; x=1726966196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=arO5SOxrLYzeSSD/8djWtK8jhXdONIIS+QCZYXekP2Q=;
  b=ajVVRilxP7O43mN6ipUO+C3qTkPVw8adGIL7PLtJtfDBJe2uD7wORcnc
   73JoxcHBDzhUdRugQ2EPElT9zRw6QruYHZD6VOozPPd0sZz5AA5UpA0ox
   X3Xm7+qhxpbhm/5A89E1/BzwYxNKweXxCkQPrsyC4AbCQniDj+NoazQeH
   m+DHzBnhrMxX8Gv6qGQabQTWbdMXb6wX4cL2UzT1uPohqYT+RIUDTdDTQ
   +VjuTjmpjJcmZGqinf8aIlcbUfzGKcD1uXtu1tIUJyyYoLzgH9DdilRVG
   wpkk43zzFNYhcekoJRH23AOpLNUPG3EV7dmxQhdm5ez8qcgsT5OyhccHU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="380885132"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="380885132"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 17:49:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="817995342"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="817995342"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 22 Sep 2023 17:49:54 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjqqF-0001X4-2n;
        Sat, 23 Sep 2023 00:49:52 +0000
Date:   Sat, 23 Sep 2023 08:49:01 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wei Gong <gongwei833x@gmail.com>, tglx@linutronix.de
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>
Subject: Re: [PATCH] genirq: avoid long loops in handle_edge_irq
Message-ID: <202309230859.ygo4QTtO-lkp@intel.com>
References: <20230921080146.37186-1-gongwei833x@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921080146.37186-1-gongwei833x@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wei,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Wei-Gong/genirq-avoid-long-loops-in-handle_edge_irq/20230922-025437
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20230921080146.37186-1-gongwei833x%40gmail.com
patch subject: [PATCH] genirq: avoid long loops in handle_edge_irq
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230923/202309230859.ygo4QTtO-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230923/202309230859.ygo4QTtO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309230859.ygo4QTtO-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from kernel/irq/chip.c:11:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from kernel/irq/chip.c:11:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from kernel/irq/chip.c:11:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:692:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     692 |         readsb(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:700:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     700 |         readsw(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:708:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     708 |         readsl(PCI_IOBASE + addr, buffer, count);
         |                ~~~~~~~~~~ ^
   include/asm-generic/io.h:717:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     717 |         writesb(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:726:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     726 |         writesw(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
   include/asm-generic/io.h:735:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     735 |         writesl(PCI_IOBASE + addr, buffer, count);
         |                 ~~~~~~~~~~ ^
>> kernel/irq/chip.c:835:63: error: no member named 'affinity' in 'struct irq_common_data'
     835 |                  cpumask_test_cpu(smp_processor_id(), desc->irq_common_data.affinity));
         |                                                       ~~~~~~~~~~~~~~~~~~~~~ ^
   12 warnings and 1 error generated.


vim +835 kernel/irq/chip.c

   771	
   772	/**
   773	 *	handle_edge_irq - edge type IRQ handler
   774	 *	@desc:	the interrupt description structure for this irq
   775	 *
   776	 *	Interrupt occurs on the falling and/or rising edge of a hardware
   777	 *	signal. The occurrence is latched into the irq controller hardware
   778	 *	and must be acked in order to be reenabled. After the ack another
   779	 *	interrupt can happen on the same source even before the first one
   780	 *	is handled by the associated event handler. If this happens it
   781	 *	might be necessary to disable (mask) the interrupt depending on the
   782	 *	controller hardware. This requires to reenable the interrupt inside
   783	 *	of the loop which handles the interrupts which have arrived while
   784	 *	the handler was running. If all pending interrupts are handled, the
   785	 *	loop is left.
   786	 */
   787	void handle_edge_irq(struct irq_desc *desc)
   788	{
   789		raw_spin_lock(&desc->lock);
   790	
   791		desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
   792	
   793		if (!irq_may_run(desc)) {
   794			desc->istate |= IRQS_PENDING;
   795			mask_ack_irq(desc);
   796			goto out_unlock;
   797		}
   798	
   799		/*
   800		 * If its disabled or no action available then mask it and get
   801		 * out of here.
   802		 */
   803		if (irqd_irq_disabled(&desc->irq_data) || !desc->action) {
   804			desc->istate |= IRQS_PENDING;
   805			mask_ack_irq(desc);
   806			goto out_unlock;
   807		}
   808	
   809		kstat_incr_irqs_this_cpu(desc);
   810	
   811		/* Start handling the irq */
   812		desc->irq_data.chip->irq_ack(&desc->irq_data);
   813	
   814		do {
   815			if (unlikely(!desc->action)) {
   816				mask_irq(desc);
   817				goto out_unlock;
   818			}
   819	
   820			/*
   821			 * When another irq arrived while we were handling
   822			 * one, we could have masked the irq.
   823			 * Reenable it, if it was not disabled in meantime.
   824			 */
   825			if (unlikely(desc->istate & IRQS_PENDING)) {
   826				if (!irqd_irq_disabled(&desc->irq_data) &&
   827				    irqd_irq_masked(&desc->irq_data))
   828					unmask_irq(desc);
   829			}
   830	
   831			handle_irq_event(desc);
   832	
   833		} while ((desc->istate & IRQS_PENDING) &&
   834			 !irqd_irq_disabled(&desc->irq_data) &&
 > 835			 cpumask_test_cpu(smp_processor_id(), desc->irq_common_data.affinity));
   836	
   837	out_unlock:
   838		raw_spin_unlock(&desc->lock);
   839	}
   840	EXPORT_SYMBOL(handle_edge_irq);
   841	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
