Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B650275D54C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 22:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGUUA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGUUA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 16:00:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E5092D7F;
        Fri, 21 Jul 2023 13:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689969625; x=1721505625;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UTAejJQPSuliS6ZdTpleNGEHMmmHZFob/eKQc45LiNc=;
  b=RjhsabJzD76jvmxBDkMhLolZCk/mpPBhwAZvSBjPTq7zVeZcF2u6siMk
   lTaL2JM45dXe/UHwwzjj8MIF2FdNMqMRk7aEM1o0DDe4dz8FeDeTb3f6N
   KSusooy6yiUQTexTD9kMontdrvCl7KtDWsz6CgaSqeo/sAoAjKHyWGhXC
   w8BFIaV1vhf/0vWE/Phe0tMCHQ4PQo5/atEgjTBYCHTJyq+K++IfJAoB1
   +YWpgOLp0ZYXJYM8zrUHI5SOEgypsSbtkZ2h6DwjVYg3lLHSQVzFLQue3
   NIhaT99DhB6eoBdeL9BSjUDNk2nRRUkN98G0r74tbxzapwcN4T1fSgHKP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="347400020"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="347400020"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 13:00:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="795071770"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="795071770"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 13:00:15 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMwIQ-0007bh-3D;
        Fri, 21 Jul 2023 20:00:14 +0000
Date:   Sat, 22 Jul 2023 03:59:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 3/5] arm64: libstub: Move KASLR handling functions to
 kaslr.c
Message-ID: <202307220314.ZZIxEjW2-lkp@intel.com>
References: <20230721074850.310644-4-alexghiti@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721074850.310644-4-alexghiti@rivosinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexandre,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.5-rc2 next-20230721]
[cannot apply to efi/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Introduce-virtual-kernel-mapping-KASLR/20230721-155554
base:   linus/master
patch link:    https://lore.kernel.org/r/20230721074850.310644-4-alexghiti%40rivosinc.com
patch subject: [PATCH v5 3/5] arm64: libstub: Move KASLR handling functions to kaslr.c
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20230722/202307220314.ZZIxEjW2-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220314.ZZIxEjW2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307220314.ZZIxEjW2-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/firmware/efi/libstub/kaslr.c: In function 'efi_kaslr_relocate_kernel':
>> drivers/firmware/efi/libstub/kaslr.c:155:9: error: implicit declaration of function 'efi_icache_sync'; did you mean 'efi_cache_sync_image'? [-Werror=implicit-function-declaration]
     155 |         efi_icache_sync(*image_addr, *image_addr + kernel_codesize);
         |         ^~~~~~~~~~~~~~~
         |         efi_cache_sync_image
   cc1: some warnings being treated as errors


vim +155 drivers/firmware/efi/libstub/kaslr.c

    87	
    88	/**
    89	 * efi_kaslr_relocate_kernel() - Relocate the kernel (random if KASLR enabled)
    90	 * @image_addr: Pointer to the current kernel location
    91	 * @reserve_addr:	Pointer to the relocated kernel location
    92	 * @reserve_size:	Size of the relocated kernel
    93	 * @kernel_size:	Size of the text + data
    94	 * @kernel_codesize:	Size of the text
    95	 * @kernel_memsize:	Size of the text + data + bss
    96	 * @phys_seed:		Random seed used for the relocation
    97	 *
    98	 * If KASLR is not enabled, this function relocates the kernel to a fixed
    99	 * address (or leave it as its current location). If KASLR is enabled, the
   100	 * kernel physical location is randomized using the seed in parameter.
   101	 *
   102	 * Return:	status code, EFI_SUCCESS if relocation is successful
   103	 */
   104	efi_status_t efi_kaslr_relocate_kernel(unsigned long *image_addr,
   105					       unsigned long *reserve_addr,
   106					       unsigned long *reserve_size,
   107					       unsigned long kernel_size,
   108					       unsigned long kernel_codesize,
   109					       unsigned long kernel_memsize,
   110					       u32 phys_seed)
   111	{
   112		efi_status_t status;
   113		u64 min_kimg_align = efi_get_kimg_min_align();
   114	
   115		if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && phys_seed != 0) {
   116			/*
   117			 * If KASLR is enabled, and we have some randomness available,
   118			 * locate the kernel at a randomized offset in physical memory.
   119			 */
   120			status = efi_random_alloc(*reserve_size, min_kimg_align,
   121						  reserve_addr, phys_seed,
   122						  EFI_LOADER_CODE);
   123			if (status != EFI_SUCCESS)
   124				efi_warn("efi_random_alloc() failed: 0x%lx\n", status);
   125		} else {
   126			status = EFI_OUT_OF_RESOURCES;
   127		}
   128	
   129		if (status != EFI_SUCCESS) {
   130			if (!check_image_region(*image_addr, kernel_memsize)) {
   131				efi_err("FIRMWARE BUG: Image BSS overlaps adjacent EFI memory region\n");
   132			} else if (IS_ALIGNED(*image_addr, min_kimg_align) &&
   133				   (u64)_end < EFI_ALLOC_LIMIT) {
   134				/*
   135				 * Just execute from wherever we were loaded by the
   136				 * UEFI PE/COFF loader if the placement is suitable.
   137				 */
   138				*reserve_size = 0;
   139				return EFI_SUCCESS;
   140			}
   141	
   142			status = efi_allocate_pages_aligned(*reserve_size, reserve_addr,
   143							    ULONG_MAX, min_kimg_align,
   144							    EFI_LOADER_CODE);
   145	
   146			if (status != EFI_SUCCESS) {
   147				efi_err("Failed to relocate kernel\n");
   148				*reserve_size = 0;
   149				return status;
   150			}
   151		}
   152	
   153		memcpy((void *)*reserve_addr, (void *)*image_addr, kernel_size);
   154		*image_addr = *reserve_addr;
 > 155		efi_icache_sync(*image_addr, *image_addr + kernel_codesize);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
