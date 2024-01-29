Return-Path: <linux-kernel+bounces-43599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D80F9841623
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E97B2391D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091751C31;
	Mon, 29 Jan 2024 22:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lMUNS08t"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CBF54736;
	Mon, 29 Jan 2024 22:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706569165; cv=none; b=oQcJyQkMiSfciuYBcRH3ISxguzGEH1iE79QrrPou83BjR/xyIXvuJIh3jBYwwptuHretcr2H5scZ5P1bWh53ZyTOZzADYJKxbLL9AS+4CzIHrJRQDItVQM8H3msHGlLHTFZ1dGFNoclTWJ6ALb+bAIGnEWsRb0MQ845S+xKRKUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706569165; c=relaxed/simple;
	bh=JNV9jQ6id/1L1Zg6Yr7l1mZgaZ5CjsKCXyjXTnXM8ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1rITltzeYIjF4AtF/GFvPlvJXC14Zy5Zrn9AtMME871cCAs9rnOzL6qko8nAJNkPsXojeFC4nm8F3fh0eoC1Oe8hC0qFWWc4m5TuJspJeTcZ6fwnZVDyCZY6CDZWr4qWBOcgK2n03BIZH2lkhCJPUE1C17sx9KXpC8uL/DncSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lMUNS08t; arc=none smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706569163; x=1738105163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JNV9jQ6id/1L1Zg6Yr7l1mZgaZ5CjsKCXyjXTnXM8ss=;
  b=lMUNS08ttsNeg6OLzH2S31eESNySaletX+GfiR9MH1SHTE0vXM8Ck16R
   N7ObrvcDXnF3M0KOAMvVP9O/1TJbWTshxlWjIP7rc8PFzeqbOLguA+E3g
   60HwC/Z5Fzx418tLIqg+uUZ3H3saJ+pkoEU3/DMsswS4CNckPg/3TG2DJ
   nMLRKu66DKEeo9UcCT8GRyEUOZGtuxjFUDShA0YAZ7K6/ExGvn8UTksbj
   zJMSs0Xp/a5Sx2Ti8ZVMhLk7jE3u4Kc+wJwxlWa8Ks5GP5bjA4carxNkg
   paTfyLBdd+HICc+SN6uW8lsNNuZQqnil/KWLfsr6xotKQRAM8f16TZpgg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="393543934"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="393543934"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 14:59:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="878235933"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="878235933"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2024 14:59:17 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUaax-0004hM-0B;
	Mon, 29 Jan 2024 22:59:15 +0000
Date: Tue, 30 Jan 2024 06:58:18 +0800
From: kernel test robot <lkp@intel.com>
To: William Qiu <william.qiu@starfivetech.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-can@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Emil Renner Berthing <kernel@esmil.dk>,
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
Message-ID: <202401300618.Sp2FQ2Z7-lkp@intel.com>
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
config: openrisc-allmodconfig (https://download.01.org/0day-ci/archive/20240130/202401300618.Sp2FQ2Z7-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240130/202401300618.Sp2FQ2Z7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401300618.Sp2FQ2Z7-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/can/cast_can.c:352:5: warning: no previous prototype for 'ccan_get_freebuffer' [-Wmissing-prototypes]
     352 | int ccan_get_freebuffer(struct ccan_priv *priv)
         |     ^~~~~~~~~~~~~~~~~~~


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

