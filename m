Return-Path: <linux-kernel+bounces-44385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7D3842159
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11C9AB28173
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7E760ED2;
	Tue, 30 Jan 2024 10:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jlgfh+Kv"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAC260DCB
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 10:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610786; cv=none; b=i8s5aAUiV+Pkd+woqpG1atgJaYCGfCVh8yWvvJM7YyudTjPuzxDkRk2tzta8ejZOTEEcab7HXj2tvocQcuLwlFqa5mNMunCDMaC8sCHoSo6NS4ZSFkmEqk5nQInXPQLc/qtyBtVf3GOJAlDlufY1F2guHESOu4gCCcYJCfWO3W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610786; c=relaxed/simple;
	bh=EtbXZiJXL9ufw2lfi48v2k/iOBAnpK2mgszDD4rfv+U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KgiGQeajZwapLhMetEmh2bp0QyN86xHKHvJc4PcEggQgPvionvvLe8mYr7rQI84rrGfVm6DJvLoNEmpYSf2nFzAUzcK6Bq+8Za9Nre0LhorA5h1RlWcJT1vDQxYaSL1jrsarqNyfoPaxs4KnN3MBMmAIjnkeMiZs+UBNA8VCipM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jlgfh+Kv; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706610784; x=1738146784;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EtbXZiJXL9ufw2lfi48v2k/iOBAnpK2mgszDD4rfv+U=;
  b=jlgfh+KvbNCWbvtDtTOp9NlxfJ8ljxHXOfpG68FhbKDBpUP0HOQ4qup8
   lIaadLBlquA37fGx/GoUKsudn9uelARlQiNxK+gCs/6jrWXOjr1jYkTjI
   DfRCc5wFNZv8bJ+31y0i+fG3LVsy74KGn99CEhCAdpbFJo3hQuyIrrfRv
   F9jLD8vFTYCHWsoOkuYzMBv6MUvbC1E/uIvVtdK2wngLSfcDO5EMdOgOJ
   UIansKbGN6L70zNScWBMzLj+aF+mlcJmqfm2BC4NpCTeTSWmckGV9ICK3
   K47hRBigBeLZb0MV/PVJ2Z39V5OhowOUZOQrhcHxIdZa9TtwJvhX4vceM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10624367"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10624367"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 02:30:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3627207"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by fmviesa005.fm.intel.com with ESMTP; 30 Jan 2024 02:30:20 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUlIt-0000C4-2B;
	Tue, 30 Jan 2024 10:26:19 +0000
Date: Tue, 30 Jan 2024 18:24:22 +0800
From: kernel test robot <lkp@intel.com>
To: Ondrej Zary <linux@zary.sk>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: drivers/ata/pata_parport/friq.c:112:63: sparse: sparse: cast to
 restricted __le16
Message-ID: <202401301838.JDzCSLYe-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   861c0981648f5b64c86fd028ee622096eb7af05a
commit: 72f2b0b2185099dce354c805009f591dda3ab73d drivers/block: Move PARIDE protocol modules to drivers/ata/pata_parport
date:   12 months ago
config: m68k-randconfig-r123-20240129 (https://download.01.org/0day-ci/archive/20240130/202401301838.JDzCSLYe-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240130/202401301838.JDzCSLYe-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401301838.JDzCSLYe-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/ata/pata_parport/friq.c:112:63: sparse: sparse: cast to restricted __le16
>> drivers/ata/pata_parport/friq.c:112:63: sparse: sparse: cast to restricted __le16
>> drivers/ata/pata_parport/friq.c:112:63: sparse: sparse: cast to restricted __le16
>> drivers/ata/pata_parport/friq.c:112:63: sparse: sparse: cast to restricted __le16
   drivers/ata/pata_parport/friq.c: note: in included file (through arch/m68k/include/asm/io.h):
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer
   arch/m68k/include/asm/io_mm.h:166:21: sparse: sparse: Using plain integer as NULL pointer

vim +112 drivers/ata/pata_parport/friq.c

^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   80  
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   81          switch(pi->mode) {
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   82  
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   83          case 0: CMD(regr); 
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   84                  for (k=0;k<count;k++) {
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   85                          w2(6); l = r1();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   86                          w2(4); h = r1();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   87                          buf[k] = j44(l,h);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   88                  }
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   89                  w2(4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   90                  break;
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   91  
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   92          case 1: ph = 2;
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   93                  CMD(regr+0xc0); 
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   94                  w0(0xff);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   95                  for (k=0;k<count;k++) {
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   96                          w2(0xa4 + ph); 
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   97                          buf[k] = r0();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   98                          ph = 2 - ph;
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16   99                  } 
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  100                  w2(0xac); w2(0xa4); w2(4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  101                  break;
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  102  
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  103  	case 2: CMD(regr+0x80);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  104  		for (k=0;k<count-2;k++) buf[k] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  105  		w2(0xac); w2(0xa4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  106  		buf[count-2] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  107  		buf[count-1] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  108  		w2(4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  109  		break;
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  110  
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  111  	case 3: CMD(regr+0x80);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16 @112                  for (k=0;k<(count/2)-1;k++) ((u16 *)buf)[k] = r4w();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  113                  w2(0xac); w2(0xa4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  114                  buf[count-2] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  115                  buf[count-1] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  116                  w2(4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  117                  break;
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  118  
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  119  	case 4: CMD(regr+0x80);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  120                  for (k=0;k<(count/4)-1;k++) ((u32 *)buf)[k] = r4l();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  121                  buf[count-4] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  122                  buf[count-3] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  123                  w2(0xac); w2(0xa4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  124                  buf[count-2] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  125                  buf[count-1] = r4();
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  126                  w2(4);
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  127                  break;
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  128  
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  129          }
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  130  }
^1da177e4c3f41 drivers/block/paride/friq.c Linus Torvalds 2005-04-16  131  

:::::: The code at line 112 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

