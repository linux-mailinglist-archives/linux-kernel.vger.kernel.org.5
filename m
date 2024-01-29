Return-Path: <linux-kernel+bounces-43429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D9B8413C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6801D1C235CE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6746C76048;
	Mon, 29 Jan 2024 19:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FXli1qFn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B061D6A008;
	Mon, 29 Jan 2024 19:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557941; cv=none; b=QRvDtcY6Qxj18kbfPFqfF/WB0YKVx86f7S7kWf/wwyjnh/4mtYQojT45WwwyQ1z2dGLLnzEF3aQwoF9FyCdtNUXvjjoKxnIGbK/Tz9pOBxelQIyfQsXlUxsTr/Z5Nz6WMtyU5Az8rDh/q7UKKsN3fD3SjKSEDpNjhPQpLJvga2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557941; c=relaxed/simple;
	bh=AkBpWCt8Yn5W3lR5XfqNrLHf+HDLn89jCMBMA0LnBBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHwPtFNIxhbxc+Mfvq0BYrBumOvbfGm0T6ktYc62ghNf6CAvu0oVOrDVRjjJVgYtvxPZbI+CzDIHMhijTNfKxsP4BdVxYrsGNAgrP3zNmSORDlARARZZT35Z1Qk1srO3MEP1QD9g44RIlR/XevhKA+CX0KpWi/3QVCNM8t8WtKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FXli1qFn; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706557940; x=1738093940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AkBpWCt8Yn5W3lR5XfqNrLHf+HDLn89jCMBMA0LnBBE=;
  b=FXli1qFn5rtHdMiLjYOTCvTrdNQppYdukJ5O2ALII639G2tMVhbKFIM2
   NMxd0CGnV9FJKkc59YpdYPblGrJ491KUlGou95OEDY8y9s+TYyGOhCA40
   SkYw34jg4dLUhbu98ghBcSJjLxFYTc2IMfQFdOWhpIXlCdnwsdobOZhC9
   m49px8Cb5VQq6Zg2P/brZcaFtvXPjuySu6FqUl9McwtjZhTJrYhJiGv0a
   xr8Wq5Xmm9TnsXMxiq0q+2L3ICkZWQ6Pwt6HOJtdOXSDvDOr6KAW9ipvG
   bITidKIwMweqOhiCLo+FcRR3G3JF2cKlBZ7VFAjIW1ujM1eOM2kpXxB2q
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="16450390"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="16450390"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 11:52:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="29905599"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Jan 2024 11:52:13 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUXfv-0004bQ-0f;
	Mon, 29 Jan 2024 19:52:11 +0000
Date: Tue, 30 Jan 2024 03:51:51 +0800
From: kernel test robot <lkp@intel.com>
To: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-can@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Emil Renner Berthing <kernel@esmil.dk>,
	Rob Herring <robh+dt@kernel.org>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	William Qiu <william.qiu@starfivetech.com>
Subject: Re: [PATCH v1 3/4] can: cast: add driver for CAST CAN controller
Message-ID: <202401300313.9DPa2nuW-lkp@intel.com>
References: <20240129031239.17037-4-william.qiu@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129031239.17037-4-william.qiu@starfivetech.com>

Hi William,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master mkl-can-next/testing v6.8-rc2 next-20240129]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/William-Qiu/dt-bindings-vendor-prefixes-Add-cast-vendor-prefix/20240129-114752
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240129031239.17037-4-william.qiu%40starfivetech.com
patch subject: [PATCH v1 3/4] can: cast: add driver for CAST CAN controller
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20240130/202401300313.9DPa2nuW-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4a39d08908942b2d415db405844cbe4af73e75d4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401300313.9DPa2nuW-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401300313.9DPa2nuW-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/cast_can.c:352:5: warning: no previous prototype for function 'ccan_get_freebuffer' [-Wmissing-prototypes]
     352 | int ccan_get_freebuffer(struct ccan_priv *priv)
         |     ^
   drivers/net/can/cast_can.c:352:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     352 | int ccan_get_freebuffer(struct ccan_priv *priv)
         | ^
         | static 
   1 warning generated.


vim +/ccan_get_freebuffer +352 drivers/net/can/cast_can.c

   351	
 > 352	int ccan_get_freebuffer(struct ccan_priv *priv)
   353	{
   354		/* Get next transmit buffer */
   355		ccan_reigister_set_bit(priv, CCAN_TCTRL_OFFSET, CCAN_SET_TENEXT_MASK);
   356	
   357		if (ccan_ioread8(priv->reg_base + CCAN_TCTRL_OFFSET) & CCAN_SET_TENEXT_MASK)
   358			return -EPERM;
   359	
   360		return 0;
   361	}
   362	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

