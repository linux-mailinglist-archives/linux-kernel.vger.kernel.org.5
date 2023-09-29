Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B757B2A11
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 03:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbjI2BDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 21:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjI2BD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 21:03:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B935EC1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 18:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695949406; x=1727485406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N78cAAZkwSzZQ/y3pbMOcajxYV4P3x+HCUtYShyNIt4=;
  b=ATnNW6WgZEfbmnas4KgD23ms1eeaCwj03vTrP8Adj3PAyX1JY44KksFI
   1V54zjZftCjNr0Ljh0OTlzWl37EyaqOVrAvH7dgVmRqScVr1SKEq0qTMl
   vWT8LsVgdmbudJ60xyL32n+vijbpuDxlxK3yU4hEHR5Y+392WC7jWmItZ
   t/vAy+eCH8sXp3aP1NOA967KkGaRZO5o+Rd+I3K/ZUhsFejB+Sfn4zun/
   x6xyE6Pol4U5Eml5TjBnKCtBpRNkZzsW/+Xz37N57JZoVOyikqQtihg7p
   iA3PHSLs0W3mUxKbVII/O07VgiG4NPE9LbtzoQHuP92BmJ09mHcirif/C
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="413119751"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="413119751"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 18:03:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="865506909"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="865506909"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 28 Sep 2023 18:03:21 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qm1uZ-0002EF-16;
        Fri, 29 Sep 2023 01:03:19 +0000
Date:   Fri, 29 Sep 2023 09:02:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     oe-kbuild-all@lists.linux.dev,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <cleger@rivosinc.com>,
        Atish Patra <atishp@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Evan Green <evan@rivosinc.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Topel <bjorn@rivosinc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Ron Minnich <rminnich@gmail.com>,
        Daniel Maslowski <cyrevolt@googlemail.com>
Subject: Re: [PATCH 6/7] riscv: report misaligned accesses emulation to
 hwprobe
Message-ID: <202309290842.Dk0K2nsp-lkp@intel.com>
References: <20230926150316.1129648-7-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230926150316.1129648-7-cleger@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc3 next-20230928]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cl-ment-L-ger/riscv-remove-unused-functions-in-traps_misaligned-c/20230926-230654
base:   linus/master
patch link:    https://lore.kernel.org/r/20230926150316.1129648-7-cleger%40rivosinc.com
patch subject: [PATCH 6/7] riscv: report misaligned accesses emulation to hwprobe
config: riscv-randconfig-002-20230929 (https://download.01.org/0day-ci/archive/20230929/202309290842.Dk0K2nsp-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230929/202309290842.Dk0K2nsp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309290842.Dk0K2nsp-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   arch/riscv/kernel/traps_misaligned.c: In function 'handle_misaligned_load':
   arch/riscv/kernel/traps_misaligned.c:420:48: error: 'struct thread_struct' has no member named 'align_ctl'
     420 |         if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
         |                                                ^
   arch/riscv/kernel/traps_misaligned.c: In function 'handle_misaligned_store':
   arch/riscv/kernel/traps_misaligned.c:522:48: error: 'struct thread_struct' has no member named 'align_ctl'
     522 |         if (user_mode(regs) && (current->thread.align_ctl & PR_UNALIGN_SIGBUS))
         |                                                ^
   arch/riscv/kernel/traps_misaligned.c: In function 'check_unaligned_access_emulated':
>> arch/riscv/kernel/traps_misaligned.c:610:17: error: expected ':' or ')' before '_ASM_EXTABLE'
     610 |                 _ASM_EXTABLE(1b, 2b)
         |                 ^~~~~~~~~~~~
>> arch/riscv/kernel/traps_misaligned.c:610:30: error: invalid suffix "b" on integer constant
     610 |                 _ASM_EXTABLE(1b, 2b)
         |                              ^~
   arch/riscv/kernel/traps_misaligned.c:610:34: error: invalid suffix "b" on integer constant
     610 |                 _ASM_EXTABLE(1b, 2b)
         |                                  ^~
>> arch/riscv/kernel/traps_misaligned.c:602:37: warning: unused variable 'tmp_var' [-Wunused-variable]
     602 |         unsigned long emulated = 1, tmp_var;
         |                                     ^~~~~~~


vim +610 arch/riscv/kernel/traps_misaligned.c

   599	
   600	bool check_unaligned_access_emulated(int cpu)
   601	{
 > 602		unsigned long emulated = 1, tmp_var;
   603	
   604		/* Use a fixup to detect if misaligned access triggered an exception */
   605		__asm__ __volatile__ (
   606			"1:\n"
   607			"	"REG_L" %[tmp], 1(%[ptr])\n"
   608			"	li %[emulated], 0\n"
   609			"2:\n"
 > 610			_ASM_EXTABLE(1b, 2b)
   611		: [emulated] "+r" (emulated), [tmp] "=r" (tmp_var)
   612		: [ptr] "r" (&tmp_var)
   613		: "memory");
   614	
   615		if (!emulated)
   616			return false;
   617	
   618		per_cpu(misaligned_access_speed, cpu) =
   619			RISCV_HWPROBE_MISALIGNED_EMULATED;
   620	
   621		return true;
   622	}
   623	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
