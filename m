Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06727F01C1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 19:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKRSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 13:01:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKRSBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 13:01:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E755FD5;
        Sat, 18 Nov 2023 10:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700330468; x=1731866468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=64HG6dl3P1Ll0SEzEuCELqJoNOAHRtrFe3DtZhTKbGw=;
  b=HUsZEnQW3tC9zZKA0Et2PZreWar8arWNdvQw8m+6oGXf1fTVi4sOZu/i
   sxV77YeTgQ+v0EC3uoXX60FeBAGhoLdTFn8Ck0na/ycBa5IPtYhvspiC8
   Kd096A69bAe8B+GF9rKSbGjSH1nMrPkUJZ1J+CGa3kDMHymdEKscvbNl7
   HK1ZgJzwO9DYCTF6BB05RjswDTwagfWRd3uDyIRGYUlyg/95AxcSsNaVN
   RpG/5DOyOVCZNe6gkiUPPRZ7EUZUyRc8R2IzMrHL6LuRu1i6JbdxX0Xy8
   29V0JT8SFdIZbMcCm7FdZrnL/+fdsoGkYi95vIahakjLO3BW5BV6gZgY6
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="4546133"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="4546133"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 10:01:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="759442522"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="759442522"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Nov 2023 10:01:05 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Pcs-0004A9-2m;
        Sat, 18 Nov 2023 18:01:02 +0000
Date:   Sun, 19 Nov 2023 02:00:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>, Anders Larsen <al@alarsen.net>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] qnx4: Extract dir entry filename processing into
 helper
Message-ID: <202311190108.LDeSe9Lj-lkp@intel.com>
References: <20231118033225.2181299-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118033225.2181299-1-keescook@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/qnx4-Extract-dir-entry-filename-processing-into-helper/20231118-114223
base:   linus/master
patch link:    https://lore.kernel.org/r/20231118033225.2181299-1-keescook%40chromium.org
patch subject: [PATCH 1/2] qnx4: Extract dir entry filename processing into helper
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20231119/202311190108.LDeSe9Lj-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231119/202311190108.LDeSe9Lj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311190108.LDeSe9Lj-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from fs/qnx4/inode.c:20:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     547 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     560 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from fs/qnx4/inode.c:20:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from fs/qnx4/inode.c:20:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:337:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     584 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     594 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     604 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   In file included from fs/qnx4/inode.c:24:
>> fs/qnx4/qnx4.h:86:51: warning: '_Static_assert' with no message is a C2x extension [-Wc2x-extensions]
      86 |                offsetof(struct qnx4_link_info, dl_status));
         |                                                          ^
         |                                                          , ""
   fs/qnx4/qnx4.h:88:56: warning: '_Static_assert' with no message is a C2x extension [-Wc2x-extensions]
      88 |                offsetof(union qnx4_directory_entry, de_status));
         |                                                               ^
         |                                                               , ""
   8 warnings generated.


vim +/_Static_assert +86 fs/qnx4/qnx4.h

    47	
    48	/*
    49	 * A qnx4 directory entry is an inode entry or link info
    50	 * depending on the status field in the last byte. The
    51	 * first byte is where the name start either way, and a
    52	 * zero means it's empty.
    53	 *
    54	 * Also, due to a bug in gcc, we don't want to use the
    55	 * real (differently sized) name arrays in the inode and
    56	 * link entries, but always the 'de_name[]' one in the
    57	 * fake struct entry.
    58	 *
    59	 * See
    60	 *
    61	 *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578#c6
    62	 *
    63	 * for details, but basically gcc will take the size of the
    64	 * 'name' array from one of the used union entries randomly.
    65	 *
    66	 * This use of 'de_name[]' (48 bytes) avoids the false positive
    67	 * warnings that would happen if gcc decides to use 'inode.di_name'
    68	 * (16 bytes) even when the pointer and size were to come from
    69	 * 'link.dl_name' (48 bytes).
    70	 *
    71	 * In all cases the actual name pointer itself is the same, it's
    72	 * only the gcc internal 'what is the size of this field' logic
    73	 * that can get confused.
    74	 */
    75	union qnx4_directory_entry {
    76		struct {
    77			const char de_name[48];
    78			u8 de_pad[15];
    79			u8 de_status;
    80		};
    81		struct qnx4_inode_entry inode;
    82		struct qnx4_link_info link;
    83	};
    84	/* Make sure the status byte is in the same place for all structs. */
    85	_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
  > 86		       offsetof(struct qnx4_link_info, dl_status));
    87	_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
    88		       offsetof(union qnx4_directory_entry, de_status));
    89	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
