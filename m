Return-Path: <linux-kernel+bounces-52697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC9849B8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E39283EA5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9324D1CA9B;
	Mon,  5 Feb 2024 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhFy3H6U"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747031CA9E;
	Mon,  5 Feb 2024 13:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138937; cv=none; b=tAK5EiGt1B6AbagL83AM+9iThbbeiwB0EkU6wEGaK77f00XoQ0SUNI+Jc38wOHE5pVqFreuEtVkZyqJjSkYW9XURtW0ZjoiS9EPBc5wk6eBo3h3coNP2Tv1/6rvmXjV3JNNsMHOnjScJhfLhR7+c/R3QaPgaCqP6NgXfnHwF95o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138937; c=relaxed/simple;
	bh=jxi9hBIW/u/xN1/3l39jSDwYER6jWurCP3CAR9bpTUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0lyUoboDdHgnmN7zQuQGGsk/Qf3bZWL5aqSlCshFvS4vP2QPehL/olO1TKlgrLnLph6M/BLKgPr8rBZNOfoMeQJXBgJtyQzuPKLjVlh+gp8Z9cHUYy7mIsTBE2S9NUxVUAHn6DmfHVHCHSL1TJDtHBXTGghbP0tjd/wAoLy9aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PhFy3H6U; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707138935; x=1738674935;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jxi9hBIW/u/xN1/3l39jSDwYER6jWurCP3CAR9bpTUM=;
  b=PhFy3H6U0Zt5UmfhWaAy21wVepJAJrAs0D/uK9pTvyz9cBW12VGn/hdL
   L2Q6R7w3coxHPmrtxL+g3713OOMPFY+PR/IhAyQEnIW9Ozl1MZ5d4x0Q3
   VOasJehQZOeLRArGn5L3XGyUGsADuEJSq1XxnKhC2YRYQRDuy874jHETv
   0YEnl4KqBhhstN1ST4FqSlWrJWeqyIZGFjImvhpiSrcu9U5RjDBTRPlmD
   /gAICEyIgsQ89cNc9vYZv81uwMJgrvJ5NCCJPk5BKJmBrN6mnQvri3VOY
   3dSfn1i+KP8fjFLcSLZjgpZ7YYjtY5+VJGn3I0pGU34e5olF5DQfbvRG5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="11105846"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11105846"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1014816"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 05 Feb 2024 05:15:29 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWyoo-0000Xk-32;
	Mon, 05 Feb 2024 13:15:26 +0000
Date: Mon, 5 Feb 2024 21:14:50 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>
Cc: oe-kbuild-all@lists.linux.dev, alexandre.belloni@bootlin.com,
	conor.culhane@silvaco.com, devicetree@vger.kernel.org,
	gregkh@linuxfoundation.org, ilpo.jarvinen@linux.intel.com,
	imx@lists.linux.dev, jirislaby@kernel.org, joe@perches.com,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, miquel.raynal@bootlin.com,
	robh@kernel.org, zbigniew.lukwinski@linux.intel.com
Subject: Re: [PATCH v6 8/8] tty: i3c: add TTY over I3C master support
Message-ID: <202402052026.UNrmrB2M-lkp@intel.com>
References: <20240202230925.1000659-9-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202230925.1000659-9-Frank.Li@nxp.com>

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tty/tty-testing]
[also build test WARNING on tty/tty-next tty/tty-linus robh/for-next linus/master v6.8-rc3 next-20240205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/i3c-add-target-mode-support/20240203-071519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
patch link:    https://lore.kernel.org/r/20240202230925.1000659-9-Frank.Li%40nxp.com
patch subject: [PATCH v6 8/8] tty: i3c: add TTY over I3C master support
config: powerpc-randconfig-r071-20240205 (https://download.01.org/0day-ci/archive/20240205/202402052026.UNrmrB2M-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402052026.UNrmrB2M-lkp@intel.com/

smatch warnings:
drivers/tty/i3c_tty.c:237 tty_i3c_rxwork() error: uninitialized symbol 'status'.

vim +/status +237 drivers/tty/i3c_tty.c

   191	
   192	static void tty_i3c_rxwork(struct work_struct *work)
   193	{
   194		struct ttyi3c_port *sport = container_of(work, struct ttyi3c_port, rxwork);
   195		struct i3c_priv_xfer xfers;
   196		u32 retry = I3C_TTY_RETRY;
   197		u16 status;
   198		int ret;
   199	
   200		memset(&xfers, 0, sizeof(xfers));
   201		xfers.data.in = sport->rx_buff;
   202		xfers.len = I3C_TTY_TRANS_SIZE;
   203		xfers.rnw = 1;
   204	
   205		do {
   206			if (test_bit(I3C_TTY_RX_STOP, &sport->status))
   207				break;
   208	
   209			i3c_device_do_priv_xfers(sport->i3cdev, &xfers, 1);
   210	
   211			if (xfers.actual_len) {
   212				ret = tty_insert_flip_string(&sport->port, sport->rx_buff,
   213							     xfers.actual_len);
   214				if (ret < xfers.actual_len)
   215					sport->buf_overrun++;
   216	
   217				retry = I3C_TTY_RETRY;
   218				continue;
   219			}
   220	
   221			status = I3C_TTY_TARGET_RX_READY;
   222			i3c_device_getstatus_format1(sport->i3cdev, &status);
   223			/*
   224			 * Target side needs some time to fill data into fifo. Target side may not
   225			 * have hardware update status in real time. Software update status always
   226			 * needs some delays.
   227			 *
   228			 * Generally, target side have circular buffer in memory, it will be moved
   229			 * into FIFO by CPU or DMA. 'status' just show if circular buffer empty. But
   230			 * there are gap, especially CPU have not response irq to fill FIFO in time.
   231			 * So xfers.actual will be zero, wait for little time to avoid flood
   232			 * transfer in i3c bus.
   233			 */
   234			usleep_range(I3C_TTY_YIELD_US, 10 * I3C_TTY_YIELD_US);
   235			retry--;
   236	
 > 237		} while (retry && (status & I3C_TTY_TARGET_RX_READY));
   238	
   239		tty_flip_buffer_push(&sport->port);
   240	}
   241	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

