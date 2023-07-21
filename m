Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C326A75D66B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 23:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjGUVXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 17:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjGUVXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 17:23:04 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62F630D0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 14:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689974579; x=1721510579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+l8avb+Up5dj5lQ+lm2WQ7/323A6EvT04ucY7c/xtj4=;
  b=WFcKCsllOiPcB96o7YVHXQmkifZvumvpDtkv/hOy9TcvNieHMalMitbs
   LP9iIQ/iG29HyajZpEChtXhTsjXnk16ztp2+KHJfhIem6BSYZWN17j/qR
   JztS8NHpj4a6MpS46D/GxYmSIKWfFj5mRR7W184wDwcG1iVE1aEgmEoEP
   qIEkM7gOqiDpPdI2JJ9JX7kLlTYhMaVezGcQuviupm0J1Zvm0PLKtHdkL
   4epSAVOHemt+9kay5SklKWWtxQzen8333E8ELdm3/b09xMX/EGRIVO1G7
   vTV3tP5HeNj2I+jvA3f94ZGo2MHrOCKv46Q7XYAgbOLkCE9fwbdYbKWq0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="357116635"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="357116635"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 14:22:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="702166598"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="702166598"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2023 14:22:55 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qMxa9-0007fl-00;
        Fri, 21 Jul 2023 21:22:39 +0000
Date:   Sat, 22 Jul 2023 05:22:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     thunder.leizhen@huaweicloud.com, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     oe-kbuild-all@lists.linux.dev,
        Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the
 bottom-up direction
Message-ID: <202307220500.1I73fZ5Z-lkp@intel.com>
References: <20230721081726.882-2-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721081726.882-2-thunder.leizhen@huaweicloud.com>
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

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on linus/master v6.5-rc2 next-20230721]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/thunder-leizhen-huaweicloud-com/arm64-kdump-Allocate-crash-low-memory-in-the-bottom-up-direction/20230721-162312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
patch link:    https://lore.kernel.org/r/20230721081726.882-2-thunder.leizhen%40huaweicloud.com
patch subject: [PATCH 1/3] arm64: kdump: Allocate crash low memory in the bottom-up direction
config: arm64-allnoconfig (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230722/202307220500.1I73fZ5Z-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307220500.1I73fZ5Z-lkp@intel.com/

All errors (new ones prefixed by >>):

   aarch64-linux-ld: arch/arm64/mm/init.o: in function `late_reserve_crashkernel':
>> init.c:(.init.text+0x58): undefined reference to `crashk_res'
   aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
   init.c:(.init.text+0x58): dangerous relocation: unsupported relocation
>> aarch64-linux-ld: init.c:(.init.text+0x5c): undefined reference to `crashk_res'
>> aarch64-linux-ld: init.c:(.init.text+0x88): undefined reference to `crashk_low_res'
   aarch64-linux-ld: arch/arm64/mm/init.o: relocation R_AARCH64_ADR_PREL_PG_HI21 against symbol `crashk_low_res' which may bind externally can not be used when making a shared object; recompile with -fPIC
   init.c:(.init.text+0x88): dangerous relocation: unsupported relocation
   aarch64-linux-ld: init.c:(.init.text+0x90): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x9c): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0xd0): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x13c): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x150): undefined reference to `crashk_res'
   aarch64-linux-ld: init.c:(.init.text+0x18c): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x1b0): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x204): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x234): undefined reference to `crashk_low_res'
   aarch64-linux-ld: init.c:(.init.text+0x248): undefined reference to `crashk_low_res'
   aarch64-linux-ld: arch/arm64/mm/init.o:init.c:(.init.text+0x25c): more undefined references to `crashk_low_res' follow

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
