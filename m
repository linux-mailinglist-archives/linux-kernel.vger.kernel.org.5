Return-Path: <linux-kernel+bounces-69101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2C6858476
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED9481F21FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 17:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009FA13342C;
	Fri, 16 Feb 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm4ybSrm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12888132C1F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 17:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708105457; cv=none; b=e2u1NfkFtSgiPhzc6HMjjEtcNfoqmlVNNtg09+D2emP277U5FY8tz19mN5b4k6Emn3ud2O0vpZH3FBLqjuSlPJX0LeP/qH6Ei2I0iPH+MMYinFwDKGLyJ7q08dAO6gvSM6IO0IiX31yL6iw8rYDMPy056NqFu61HgbL1sjynlYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708105457; c=relaxed/simple;
	bh=pmBmI1KbV5a9rmAzbJ/yEMHw8wFlEQBYvtjALpUz2ms=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RUbeacMfgYQ4lsnlt729uT9Ym+9RpL7P6V+P00e1TBeT3CPiNDPvnSHLCmUYV9BETq4TJoQWW6xf8tNyCxgvNOO6K9KXR3zZIGMCUEsrD5fg8C1c3LSBRvBCgIKsQZn66QcYwdRiJysWX1LCJWh18SeBl7/kSikywIoWY8UyXes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xm4ybSrm; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708105455; x=1739641455;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=pmBmI1KbV5a9rmAzbJ/yEMHw8wFlEQBYvtjALpUz2ms=;
  b=Xm4ybSrmUg91S/JW3Qr9MmXvGbZcwbz4kcJIBAq2u/uyU5fMxNBE6owN
   s7/DgxG8xJxApgP+Qx9SvffLhQlL+408jOsy90iIZnhB+ZZn1qXH2bSqR
   npJG7DJg3KxRkoMUVtSvPgMWaVr+uS+YZOqCMAQ7ALEv1S170ZXXa71WG
   Fup7rYWdNWJir5NAinmzy9+HTXz5xxnwy5XYgQ9Gtopp6ya6flUyP09tZ
   DugEz8924qTrbyVeZOAw0QBAGTCbCDPgnXwPWoOwfFDfI6WqtLJOCOpnp
   Iw8u8CD0LAkfrEryaxewY/sIY5zDEIcdNWUL2N2rcqTqtInYdyN3uxD6f
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="6052159"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="6052159"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 09:44:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="4253891"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 16 Feb 2024 09:44:13 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rb2FY-0001VI-22;
	Fri, 16 Feb 2024 17:43:51 +0000
Date: Sat, 17 Feb 2024 01:42:53 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215 1/1]
 arch/um/drivers/virt-pci.c:285:38: error: passing argument 2 of
 'um_pci_send_cmd' from incompatible pointer type
Message-ID: <202402170111.jekyERfk-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
head:   7a19cfa6c1665cd2b4a34d4504e23d2ee68b87b2
commit: 7a19cfa6c1665cd2b4a34d4504e23d2ee68b87b2 [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240217/202402170111.jekyERfk-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240217/202402170111.jekyERfk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402170111.jekyERfk-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from ./arch/um/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/um/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:79,
                    from include/linux/spinlock.h:56,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:7,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:9,
                    from include/linux/module.h:17,
                    from arch/um/drivers/virt-pci.c:6:
   arch/um/drivers/virt-pci.c: In function 'um_pci_cfgspace_write':
>> arch/um/drivers/virt-pci.c:285:38: error: passing argument 2 of 'um_pci_send_cmd' from incompatible pointer type [-Werror=incompatible-pointer-types]
     285 |         WARN_ON(um_pci_send_cmd(dev, &msg.hdr, sizeof(msg), NULL, 0, NULL, 0));
         |                                      ^~~~~~~~
         |                                      |
         |                                      struct virtio_pcidev_msg_tag *
   include/asm-generic/bug.h:123:32: note: in definition of macro 'WARN_ON'
     123 |         int __ret_warn_on = !!(condition);                              \
         |                                ^~~~~~~~~
   arch/um/drivers/virt-pci.c:72:54: note: expected 'struct virtio_pcidev_msg *' but argument is of type 'struct virtio_pcidev_msg_tag *'
      72 |                            struct virtio_pcidev_msg *cmd,
         |                            ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/um_pci_send_cmd +285 arch/um/drivers/virt-pci.c

68f5d3f3b65432 Johannes Berg       2021-03-05  244  
68f5d3f3b65432 Johannes Berg       2021-03-05  245  static void um_pci_cfgspace_write(void *priv, unsigned int offset, int size,
68f5d3f3b65432 Johannes Berg       2021-03-05  246  				  unsigned long val)
68f5d3f3b65432 Johannes Berg       2021-03-05  247  {
68f5d3f3b65432 Johannes Berg       2021-03-05  248  	struct um_pci_device_reg *reg = priv;
68f5d3f3b65432 Johannes Berg       2021-03-05  249  	struct um_pci_device *dev = reg->dev;
68f5d3f3b65432 Johannes Berg       2021-03-05  250  	struct {
7a19cfa6c1665c Gustavo A. R. Silva 2024-02-15  251  		struct virtio_pcidev_msg_tag hdr;
68f5d3f3b65432 Johannes Berg       2021-03-05  252  		/* maximum size - we may only use parts of it */
68f5d3f3b65432 Johannes Berg       2021-03-05  253  		u8 data[8];
68f5d3f3b65432 Johannes Berg       2021-03-05  254  	} msg = {
68f5d3f3b65432 Johannes Berg       2021-03-05  255  		.hdr = {
68f5d3f3b65432 Johannes Berg       2021-03-05  256  			.op = VIRTIO_PCIDEV_OP_CFG_WRITE,
68f5d3f3b65432 Johannes Berg       2021-03-05  257  			.size = size,
68f5d3f3b65432 Johannes Berg       2021-03-05  258  			.addr = offset,
68f5d3f3b65432 Johannes Berg       2021-03-05  259  		},
68f5d3f3b65432 Johannes Berg       2021-03-05  260  	};
68f5d3f3b65432 Johannes Berg       2021-03-05  261  
68f5d3f3b65432 Johannes Berg       2021-03-05  262  	if (!dev)
68f5d3f3b65432 Johannes Berg       2021-03-05  263  		return;
68f5d3f3b65432 Johannes Berg       2021-03-05  264  
68f5d3f3b65432 Johannes Berg       2021-03-05  265  	switch (size) {
68f5d3f3b65432 Johannes Berg       2021-03-05  266  	case 1:
68f5d3f3b65432 Johannes Berg       2021-03-05  267  		msg.data[0] = (u8)val;
68f5d3f3b65432 Johannes Berg       2021-03-05  268  		break;
68f5d3f3b65432 Johannes Berg       2021-03-05  269  	case 2:
68f5d3f3b65432 Johannes Berg       2021-03-05  270  		put_unaligned_le16(val, (void *)msg.data);
68f5d3f3b65432 Johannes Berg       2021-03-05  271  		break;
68f5d3f3b65432 Johannes Berg       2021-03-05  272  	case 4:
68f5d3f3b65432 Johannes Berg       2021-03-05  273  		put_unaligned_le32(val, (void *)msg.data);
68f5d3f3b65432 Johannes Berg       2021-03-05  274  		break;
68f5d3f3b65432 Johannes Berg       2021-03-05  275  #ifdef CONFIG_64BIT
68f5d3f3b65432 Johannes Berg       2021-03-05  276  	case 8:
68f5d3f3b65432 Johannes Berg       2021-03-05  277  		put_unaligned_le64(val, (void *)msg.data);
68f5d3f3b65432 Johannes Berg       2021-03-05  278  		break;
68f5d3f3b65432 Johannes Berg       2021-03-05  279  #endif
68f5d3f3b65432 Johannes Berg       2021-03-05  280  	default:
68f5d3f3b65432 Johannes Berg       2021-03-05  281  		WARN(1, "invalid config space write size %d\n", size);
68f5d3f3b65432 Johannes Berg       2021-03-05  282  		return;
68f5d3f3b65432 Johannes Berg       2021-03-05  283  	}
68f5d3f3b65432 Johannes Berg       2021-03-05  284  
68f5d3f3b65432 Johannes Berg       2021-03-05 @285  	WARN_ON(um_pci_send_cmd(dev, &msg.hdr, sizeof(msg), NULL, 0, NULL, 0));
68f5d3f3b65432 Johannes Berg       2021-03-05  286  }
68f5d3f3b65432 Johannes Berg       2021-03-05  287  

:::::: The code at line 285 was first introduced by commit
:::::: 68f5d3f3b6543266b29e047cfaf9842333019b4c um: add PCI over virtio emulation driver

:::::: TO: Johannes Berg <johannes.berg@intel.com>
:::::: CC: Richard Weinberger <richard@nod.at>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

