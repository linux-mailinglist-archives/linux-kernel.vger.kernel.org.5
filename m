Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5677A080
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 16:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjHLOgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 10:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLOgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 10:36:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0D10C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691850983; x=1723386983;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R7NRsqEtZsZwqqRfMkes7tldaRARTKA/e6Mek0FrHvo=;
  b=YFFeA7ErsSJZiczXA7XUAwVfaX9FwGBP6cBape4MtZyPjoxFfctT+lmQ
   sRSUPG0yuX3n5+AFT4lhy2ZGrS43TyjfqxmjeoovD17N+iWPI/B4oO6HT
   CWMnuusd+eXFTrp1/AtxVaLmjiq77W2d0eQrYZOrwXziWudQNHHDGI4M2
   TbMc3g/xrV8fnPNaGsihn2K9HCw9+OxN6Zugb3H+r5Y3/kbxvg6GIJqOJ
   ic/n+ceeIoLJpYyyzyTgx7OQo0jFWnZTuniq/18t78k0Gwnwfeje//PIN
   JXrwTLCwB7s30u/RL9NieNH3Ai3JIm47kjgDJmwvqO01NXQ4iNZp4kWNe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="435724842"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="435724842"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2023 07:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10800"; a="762473293"
X-IronPort-AV: E=Sophos;i="6.01,168,1684825200"; 
   d="scan'208";a="762473293"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Aug 2023 07:36:16 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qUpix-0008ca-19;
        Sat, 12 Aug 2023 14:36:15 +0000
Date:   Sat, 12 Aug 2023 22:35:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sami Tolvanen <samitolvanen@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Kees Cook <keescook@chromium.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Guo Ren <guoren@kernel.org>, Deepak Gupta <debug@rivosinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jisheng Zhang <jszhang@kernel.org>
Subject: Re: [PATCH 1/5] riscv: VMAP_STACK overflow detection thread-safe
Message-ID: <202308122238.XLMMmeL0-lkp@intel.com>
References: <20230811233556.97161-8-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811233556.97161-8-samitolvanen@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sami,

kernel test robot noticed the following build errors:

[auto build test ERROR on 52a93d39b17dc7eb98b6aa3edb93943248e03b2f]

url:    https://github.com/intel-lab-lkp/linux/commits/Sami-Tolvanen/riscv-VMAP_STACK-overflow-detection-thread-safe/20230812-073751
base:   52a93d39b17dc7eb98b6aa3edb93943248e03b2f
patch link:    https://lore.kernel.org/r/20230811233556.97161-8-samitolvanen%40google.com
patch subject: [PATCH 1/5] riscv: VMAP_STACK overflow detection thread-safe
config: riscv-randconfig-r042-20230812 (https://download.01.org/0day-ci/archive/20230812/202308122238.XLMMmeL0-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308122238.XLMMmeL0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308122238.XLMMmeL0-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __per_cpu_offset
   >>> referenced by arch/riscv/kernel/entry.o:(handle_kernel_stack_overflow) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
