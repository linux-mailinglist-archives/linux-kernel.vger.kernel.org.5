Return-Path: <linux-kernel+bounces-123274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B08998905D0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E13671C2F401
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611162A8D3;
	Thu, 28 Mar 2024 16:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AXoptmnw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C20139D09;
	Thu, 28 Mar 2024 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643844; cv=none; b=KsC59SBW2QZ7yL/7zFTg0Ewq6uAg2BvJwS2WX4Eo6eUjem3r3ar/NHo12lMoGDFo7mby4hNRNW6StqaEG/1l8sihR75Jgod+myX63YeG/y1AqnCjhJkXSbwNWm+G+nGmP5ehSo+7JQ5P5SvISzR7E37sWCqG16l4bp+XUSWx96w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643844; c=relaxed/simple;
	bh=oKhOL3EyDx0U3wUHH2cNjQih0LgHQEhwmCUnPFJxBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rH5BezGhAHLS7bEPJ4c1ik2BWtHc/AqB898odhp9wAPBdUZpc1xNXAWe8SvFpZTC5Fe4GiNsfkORTaWgs+qyJUDM+Uqydrtpa6h9JNU+ShsyiTGqi6/iBdb93zPRLuifhwM7h/cNZ0siRoRROf4YBX+19gfemtBkBdzp7odJV44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AXoptmnw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711643842; x=1743179842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oKhOL3EyDx0U3wUHH2cNjQih0LgHQEhwmCUnPFJxBd4=;
  b=AXoptmnw4RKZTrk4Zb2mG966dcQrPuyNq62XitHXU4IjWg/oStJPm3nS
   N7SMcFOzICYDWTS5ghffsRzeVhqyx1iQYkxG484/rqDzDs6I3OohMiy2r
   pMOQcle0qRCwlhLLbbu8/URaNP1ngMppGgSxnIdMcw/QdPOuc8QV6pJJw
   UHb/a2TEQeWl6P4nsTZITxOjzrMIDs3hAfpqPlImRFJOnaIgKd+tTEGqK
   9EXS1h0DJUSvsOxYzBftrUp6kSClLXEuc9H0iquV3sWFZzUJZDi/xWXm5
   E5U3PTe9kQJuP5QDvTl23DMCVaF29/UNbr9WzdnQ6axh0bPD6KCW41FBk
   A==;
X-CSE-ConnectionGUID: OPfAFhA2QiiLDAXzmyxAEA==
X-CSE-MsgGUID: NgXiSShIQ6605nqlRqnfKw==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="6705558"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="6705558"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 09:37:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; 
   d="scan'208";a="16764511"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Mar 2024 09:37:16 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpskb-0002LW-13;
	Thu, 28 Mar 2024 16:37:13 +0000
Date: Fri, 29 Mar 2024 00:37:02 +0800
From: kernel test robot <lkp@intel.com>
To: Cristian Marussi <cristian.marussi@arm.com>,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sudeep.holla@arm.com,
	cristian.marussi@arm.com, jassisinghbrar@gmail.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org
Subject: Re: [PATCH 2/2] mailbox: arm_mhuv3: Add driver
Message-ID: <202403290015.tCLXudqC-lkp@intel.com>
References: <20240325092808.117510-3-cristian.marussi@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325092808.117510-3-cristian.marussi@arm.com>

Hi Cristian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on soc/for-next]
[also build test WARNING on robh/for-next linus/master v6.9-rc1 next-20240328]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Cristian-Marussi/dt-bindings-mailbox-arm-mhuv3-Add-bindings/20240326-020048
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
patch link:    https://lore.kernel.org/r/20240325092808.117510-3-cristian.marussi%40arm.com
patch subject: [PATCH 2/2] mailbox: arm_mhuv3: Add driver
config: powerpc-randconfig-r131-20240328 (https://download.01.org/0day-ci/archive/20240329/202403290015.tCLXudqC-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 23de3862dce582ce91c1aa914467d982cb1a73b4)
reproduce: (https://download.01.org/0day-ci/archive/20240329/202403290015.tCLXudqC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403290015.tCLXudqC-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/mailbox/arm_mhuv3.c:565:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct pdbcw_page *dbcw @@     got struct pdbcw_page [noderef] __iomem * @@
   drivers/mailbox/arm_mhuv3.c:565:46: sparse:     expected struct pdbcw_page *dbcw
   drivers/mailbox/arm_mhuv3.c:565:46: sparse:     got struct pdbcw_page [noderef] __iomem *
>> drivers/mailbox/arm_mhuv3.c:568:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct pdbcw_int * @@
   drivers/mailbox/arm_mhuv3.c:568:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:568:25: sparse:     got struct pdbcw_int *
>> drivers/mailbox/arm_mhuv3.c:568:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct pdbcw_int * @@
   drivers/mailbox/arm_mhuv3.c:568:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:568:25: sparse:     got struct pdbcw_int *
   drivers/mailbox/arm_mhuv3.c:569:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct pdbcw_int * @@
   drivers/mailbox/arm_mhuv3.c:569:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:569:25: sparse:     got struct pdbcw_int *
   drivers/mailbox/arm_mhuv3.c:569:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct pdbcw_int * @@
   drivers/mailbox/arm_mhuv3.c:569:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:569:25: sparse:     got struct pdbcw_int *
>> drivers/mailbox/arm_mhuv3.c:570:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct xbcw_ctrl * @@
   drivers/mailbox/arm_mhuv3.c:570:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:570:25: sparse:     got struct xbcw_ctrl *
>> drivers/mailbox/arm_mhuv3.c:570:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct xbcw_ctrl * @@
   drivers/mailbox/arm_mhuv3.c:570:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:570:25: sparse:     got struct xbcw_ctrl *
>> drivers/mailbox/arm_mhuv3.c:573:46: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct mdbcw_page *dbcw @@     got struct mdbcw_page [noderef] __iomem * @@
   drivers/mailbox/arm_mhuv3.c:573:46: sparse:     expected struct mdbcw_page *dbcw
   drivers/mailbox/arm_mhuv3.c:573:46: sparse:     got struct mdbcw_page [noderef] __iomem *
>> drivers/mailbox/arm_mhuv3.c:576:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/mailbox/arm_mhuv3.c:576:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:576:25: sparse:     got unsigned int *
   drivers/mailbox/arm_mhuv3.c:577:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/mailbox/arm_mhuv3.c:577:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:577:25: sparse:     got unsigned int *
   drivers/mailbox/arm_mhuv3.c:578:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct xbcw_ctrl * @@
   drivers/mailbox/arm_mhuv3.c:578:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:578:25: sparse:     got struct xbcw_ctrl *
   drivers/mailbox/arm_mhuv3.c:578:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got struct xbcw_ctrl * @@
   drivers/mailbox/arm_mhuv3.c:578:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/mailbox/arm_mhuv3.c:578:25: sparse:     got struct xbcw_ctrl *
>> drivers/mailbox/arm_mhuv3.c:360:9: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:370:9: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:373:9: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:639:30: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:659:33: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:688:14: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:700:17: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:719:14: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:732:14: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:789:22: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:795:22: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:796:22: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:802:31: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:806:17: sparse: sparse: dereference of noderef expression
   drivers/mailbox/arm_mhuv3.c:1038:17: sparse: sparse: dereference of noderef expression

vim +565 drivers/mailbox/arm_mhuv3.c

   558	
   559	static void mhuv3_dbe_combined_irq_setup(struct mhuv3 *mhu)
   560	{
   561		int i;
   562		struct mhuv3_extension *e = mhu->ext[DBE_EXT];
   563	
   564		if (mhu->frame == PBX_FRAME) {
 > 565			struct pdbcw_page *dbcw = mhu->pbx->dbcw;
   566	
   567			for (i = 0; i < e->max_chans; i++) {
 > 568				writel_relaxed_bitfield(0x1, &dbcw[i].int_clr, tfr_ack);
   569				writel_relaxed_bitfield(0x0, &dbcw[i].int_en, tfr_ack);
 > 570				writel_relaxed_bitfield(0x1, &dbcw[i].ctrl, comb_en);
   571			}
   572		} else {
 > 573			struct mdbcw_page *dbcw = mhu->mbx->dbcw;
   574	
   575			for (i = 0; i < e->max_chans; i++) {
 > 576				writel_relaxed(0xFFFFFFFF, &dbcw[i].clr);
   577				writel_relaxed(0xFFFFFFFF, &dbcw[i].msk_set);
   578				writel_relaxed_bitfield(0x1, &dbcw[i].ctrl, comb_en);
   579			}
   580		}
   581	}
   582	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

