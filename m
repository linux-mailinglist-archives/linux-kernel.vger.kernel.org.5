Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEE97CB9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 06:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbjJQExB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 00:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQEw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 00:52:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE4FA2;
        Mon, 16 Oct 2023 21:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697518376; x=1729054376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aDjfjftiY1bEitGKNGlzv06DZeVXN5zC6ddC0dUDzPw=;
  b=iVnB0FgLqwq+64fUCV6oOvw5697Io/XIZfzXpD6OuTiOfqp7wSWrFrLH
   gw9lqqvWgffJwV8ASWdR7+/ijSsMx3TGsJkuDr8fzaMaukIjV47qS7hnv
   UUutDXhKooOjEVRU2Du8YIVT51eLVo1wbw0vApNr32M0fRgXXZHSFtp5G
   qLYRWpnuORc6ofGyq9bwzSfg5PZPXWB0izHkcOe1fiTHs1VnUEIYxvwDf
   w6vSGZ0dUBvM7O33Gvt2KfrNtFZWuWm29oXBUbNqtpbPVz0tfvqKVDAOZ
   Csx8vyRP9QFyJQtHhF9xSQR+vGwp7l1qh0iRPa7kYhLWD9s6lEtRQMudE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376066162"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="376066162"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 21:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="3926579"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 16 Oct 2023 21:52:54 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qsc4U-00091n-1v;
        Tue, 17 Oct 2023 04:52:46 +0000
Date:   Tue, 17 Oct 2023 12:52:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nikhil V <quic_nprakash@quicinc.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>
Cc:     oe-kbuild-all@lists.linux.dev,
        Nikhil V <quic_nprakash@quicinc.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-doc@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_kprasan@quicinc.com, quic_mpilaniy@quicinc.com,
        quic_shrekk@quicinc.com, mpleshivenkov@google.com,
        ericyin@google.com
Subject: Re: [PATCH 2/4] PM: hibernate: Move to crypto APIs for LZO
 compression
Message-ID: <202310171226.pLUPeuC7-lkp@intel.com>
References: <486273fb828eb56d1895fee49481f5c035df8300.1696410298.git.quic_nprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <486273fb828eb56d1895fee49481f5c035df8300.1696410298.git.quic_nprakash@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikhil,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc6 next-20231016]
[cannot apply to pavel-leds/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikhil-V/PM-hibernate-Rename-lzo-to-make-it-generic/20231004-173227
base:   linus/master
patch link:    https://lore.kernel.org/r/486273fb828eb56d1895fee49481f5c035df8300.1696410298.git.quic_nprakash%40quicinc.com
patch subject: [PATCH 2/4] PM: hibernate: Move to crypto APIs for LZO compression
config: sh-sh7770_generic_defconfig (https://download.01.org/0day-ci/archive/20231017/202310171226.pLUPeuC7-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231017/202310171226.pLUPeuC7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310171226.pLUPeuC7-lkp@intel.com/

All errors (new ones prefixed by >>):

   sh4-linux-ld: kernel/power/hibernate.o: in function `software_resume':
>> hibernate.c:(.text+0xd0c): undefined reference to `crypto_has_alg'
   sh4-linux-ld: kernel/power/hibernate.o: in function `hibernate':
   hibernate.c:(.text+0x1218): undefined reference to `crypto_has_alg'
   sh4-linux-ld: kernel/power/swap.o: in function `compress_threadfn':
>> swap.c:(.text+0x5d8): undefined reference to `crypto_comp_compress'
   sh4-linux-ld: kernel/power/swap.o: in function `decompress_threadfn':
>> swap.c:(.text+0x728): undefined reference to `crypto_comp_decompress'
   sh4-linux-ld: kernel/power/swap.o: in function `load_compressed_image':
>> swap.c:(.text+0x9ec): undefined reference to `crypto_alloc_base'
>> sh4-linux-ld: swap.c:(.text+0xe7c): undefined reference to `crypto_destroy_tfm'
   sh4-linux-ld: kernel/power/swap.o: in function `save_compressed_image':
   swap.c:(.text+0x14f8): undefined reference to `crypto_alloc_base'
   sh4-linux-ld: swap.c:(.text+0x169c): undefined reference to `crypto_destroy_tfm'
   sh4-linux-ld: crypto/lzo.o: in function `lzo_decompress':
>> lzo.c:(.text+0x50): undefined reference to `lzo1x_decompress_safe'
   sh4-linux-ld: crypto/lzo.o: in function `lzo_compress':
>> lzo.c:(.text+0xb0): undefined reference to `lzo1x_1_compress'
   sh4-linux-ld: crypto/lzo.o: in function `lzo_sdecompress':
   lzo.c:(.text+0x144): undefined reference to `lzo1x_decompress_safe'
   sh4-linux-ld: crypto/lzo.o: in function `lzo_scompress':
   lzo.c:(.text+0x1a0): undefined reference to `lzo1x_1_compress'
   sh4-linux-ld: crypto/lzo.o: in function `lzo_mod_fini':
>> lzo.c:(.exit.text+0x14): undefined reference to `crypto_unregister_alg'
>> sh4-linux-ld: lzo.c:(.exit.text+0x20): undefined reference to `crypto_unregister_scomp'
   sh4-linux-ld: crypto/lzo.o: in function `lzo_mod_init':
>> lzo.c:(.init.text+0x30): undefined reference to `crypto_register_alg'
>> sh4-linux-ld: lzo.c:(.init.text+0x38): undefined reference to `crypto_register_scomp'
>> sh4-linux-ld: lzo.c:(.init.text+0x40): undefined reference to `crypto_unregister_alg'
   sh4-linux-ld: crypto/lzo-rle.o: in function `lzorle_decompress':
>> lzo-rle.c:(.text+0x50): undefined reference to `lzo1x_decompress_safe'
   sh4-linux-ld: crypto/lzo-rle.o: in function `lzorle_compress':
>> lzo-rle.c:(.text+0xb0): undefined reference to `lzorle1x_1_compress'
   sh4-linux-ld: crypto/lzo-rle.o: in function `lzorle_sdecompress':
   lzo-rle.c:(.text+0x144): undefined reference to `lzo1x_decompress_safe'
   sh4-linux-ld: crypto/lzo-rle.o: in function `lzorle_scompress':
   lzo-rle.c:(.text+0x1a0): undefined reference to `lzorle1x_1_compress'
   sh4-linux-ld: crypto/lzo-rle.o: in function `lzorle_mod_fini':
>> lzo-rle.c:(.exit.text+0x14): undefined reference to `crypto_unregister_alg'
>> sh4-linux-ld: lzo-rle.c:(.exit.text+0x20): undefined reference to `crypto_unregister_scomp'
   sh4-linux-ld: crypto/lzo-rle.o: in function `lzorle_mod_init':
>> lzo-rle.c:(.init.text+0x30): undefined reference to `crypto_register_alg'
>> sh4-linux-ld: lzo-rle.c:(.init.text+0x38): undefined reference to `crypto_register_scomp'
>> sh4-linux-ld: lzo-rle.c:(.init.text+0x40): undefined reference to `crypto_unregister_alg'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for CRYPTO_LZO
   Depends on [n]: CRYPTO [=n]
   Selected by [y]:
   - HIBERNATION [=y] && SWAP [=y] && ARCH_HIBERNATION_POSSIBLE [=y]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
