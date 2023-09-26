Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2467AF57A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 22:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbjIZUov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 16:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjIZUon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 16:44:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F9F9F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695761076; x=1727297076;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gK5hWn8nLs18VMiTM7kXxPjeLkMzRB4MUjym/ABZruA=;
  b=kD2mF7dSs7r8g5mDZd/ub7/kCj5L6udH9F/YAUCqysJzVMB/8CcG90bR
   uA7IDaB49dZMLdb8MdAnBxUye8QB2TQ0iwBpsfrTKI9ia22r/cHoTYGa9
   AZK6PpqqZys/7T+gvpigQ7q10iw/SSgIdr26atEB5wGcLCs3IPLoOqRio
   bi8PWvoZeHpY8GQr/49PxzeGtG5R49qruXfUOgu74EJrF55eqX3heH5Z9
   vGaJYUV9aDjixHjwIfssYOfiMO6WWsGT7ROBPzyQAQkGb5wdQ8HXOSBJk
   hAqkx2ABtmyj+tXYbQS13nb9/Hu90/G+GrJsEeQjuiKVP17PKtlcj9rsb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="371999466"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="371999466"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 13:44:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="872631689"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="872631689"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 26 Sep 2023 13:44:33 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qlEv1-0003Ld-0Y;
        Tue, 26 Sep 2023 20:44:31 +0000
Date:   Wed, 27 Sep 2023 04:44:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Dunaev <dunaev@tecon.ru>
Cc:     oe-kbuild-all@lists.linux.dev, dunaich@mail.ru,
        Dmitry Dunaev <dunaev@tecon.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] irqchip/riscv-intc: Mark INTC nodes for secondary CPUs
 as initialized.
Message-ID: <202309270417.HR9Q4rJN-lkp@intel.com>
References: <20230926102801.1591126-1-dunaev@tecon.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926102801.1591126-1-dunaev@tecon.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on linus/master v6.6-rc3 next-20230926]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Dunaev/irqchip-riscv-intc-Mark-INTC-nodes-for-secondary-CPUs-as-initialized/20230926-183500
base:   tip/irq/core
patch link:    https://lore.kernel.org/r/20230926102801.1591126-1-dunaev%40tecon.ru
patch subject: [PATCH] irqchip/riscv-intc: Mark INTC nodes for secondary CPUs as initialized.
config: riscv-randconfig-001-20230926 (https://download.01.org/0day-ci/archive/20230927/202309270417.HR9Q4rJN-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230927/202309270417.HR9Q4rJN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309270417.HR9Q4rJN-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/irqchip/irq-riscv-intc.c: In function 'riscv_intc_acpi_init':
>> drivers/irqchip/irq-riscv-intc.c:185:58: error: 'node' undeclared (first use in this function)
     185 |                 fwnode_dev_initialized(of_node_to_fwnode(node), true);
         |                                                          ^~~~
   drivers/irqchip/irq-riscv-intc.c:185:58: note: each undeclared identifier is reported only once for each function it appears in


vim +/node +185 drivers/irqchip/irq-riscv-intc.c

   169	
   170	static int __init riscv_intc_acpi_init(union acpi_subtable_headers *header,
   171					       const unsigned long end)
   172	{
   173		struct fwnode_handle *fn;
   174		struct acpi_madt_rintc *rintc;
   175	
   176		rintc = (struct acpi_madt_rintc *)header;
   177	
   178		/*
   179		 * The ACPI MADT will have one INTC for each CPU (or HART)
   180		 * so riscv_intc_acpi_init() function will be called once
   181		 * for each INTC. We only do INTC initialization
   182		 * for the INTC belonging to the boot CPU (or boot HART).
   183		 */
   184		if (riscv_hartid_to_cpuid(rintc->hart_id) != smp_processor_id()) {
 > 185			fwnode_dev_initialized(of_node_to_fwnode(node), true);
   186			return 0;
   187		}
   188	
   189		fn = irq_domain_alloc_named_fwnode("RISCV-INTC");
   190		if (!fn) {
   191			pr_err("unable to allocate INTC FW node\n");
   192			return -ENOMEM;
   193		}
   194	
   195		return riscv_intc_init_common(fn);
   196	}
   197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
