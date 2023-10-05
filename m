Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381EA7B99E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 04:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233476AbjJECTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 22:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233580AbjJECTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 22:19:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E66DD
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 19:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696472389; x=1728008389;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XlOnScdtAGDG7tWSy3Li0cvXQjsbEt3gzAVcHpkWsQM=;
  b=PLbrXeK5L0LLOuV1ZTCU5HQ9D5kA4Agl5agHq/0ZOTo+GbLsQk3ESj/T
   jn/M0TVDNunUTk4xGLFDF8gPjCzl3ks9P1cUsnV+HJaLs4Q0cRrWcGqpI
   BjHmU8liP/i2OOlbGOJGXewFSlPfAzxfZRPSR8+I9E5JfbVNsKgnSA5Ne
   XRS3SyIgqH6uaiN/g+3gKoqbx3rw4NQ6H1hIn/Mr94mXlT9ra3TRIeB+R
   7vxQjQe201lNRNgRwFoqAu9b+PQFO462ud8T0gB7kGXLArTYLeEPMeSrG
   /io8h/ALFG7y9+2GxmFyQ6i31JQTnC7lc5pYGY1ZhUB4YXiI2w+6DlLEV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="373725717"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="373725717"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 19:15:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="925409747"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="925409747"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Oct 2023 19:15:37 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoDtn-000KsK-16;
        Thu, 05 Oct 2023 02:15:35 +0000
Date:   Thu, 5 Oct 2023 10:14:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>, mcgrof@kernel.org,
        russell.h.weight@intel.com, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH v2] firmware_loader: Abort new fw load request once
 firmware core knows about reboot
Message-ID: <202310051011.PW217wHD-lkp@intel.com>
References: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1696431327-7369-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mukesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus linus/master v6.6-rc4 next-20231004]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Mukesh-Ojha/firmware_loader-Abort-new-fw-load-request-once-firmware-core-knows-about-reboot/20231004-225910
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/1696431327-7369-1-git-send-email-quic_mojha%40quicinc.com
patch subject: [PATCH v2] firmware_loader: Abort new fw load request once firmware core knows about reboot
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20231005/202310051011.PW217wHD-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231005/202310051011.PW217wHD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310051011.PW217wHD-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/base/firmware_loader/main.c:21:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
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
   In file included from drivers/base/firmware_loader/main.c:21:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     573 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from drivers/base/firmware_loader/main.c:21:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
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
   In file included from drivers/base/firmware_loader/main.c:45:
   In file included from drivers/base/firmware_loader/fallback.h:9:
>> drivers/base/firmware_loader/sysfs.h:87:20: error: redefinition of 'fw_load_abort' as different kind of symbol
      87 | static inline void fw_load_abort(struct fw_sysfs *fw_sysfs)
         |                    ^
   drivers/base/firmware_loader/firmware.h:89:13: note: previous definition is here
      89 | extern bool fw_load_abort;
         |             ^
   12 warnings and 1 error generated.


vim +/fw_load_abort +87 drivers/base/firmware_loader/sysfs.h

e0c11a8b985137 Russ Weight 2022-04-21  86  
e0c11a8b985137 Russ Weight 2022-04-21 @87  static inline void fw_load_abort(struct fw_sysfs *fw_sysfs)
e0c11a8b985137 Russ Weight 2022-04-21  88  {
e0c11a8b985137 Russ Weight 2022-04-21  89  	struct fw_priv *fw_priv = fw_sysfs->fw_priv;
e0c11a8b985137 Russ Weight 2022-04-21  90  
e0c11a8b985137 Russ Weight 2022-04-21  91  	__fw_load_abort(fw_priv);
e0c11a8b985137 Russ Weight 2022-04-21  92  }
e0c11a8b985137 Russ Weight 2022-04-21  93  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
