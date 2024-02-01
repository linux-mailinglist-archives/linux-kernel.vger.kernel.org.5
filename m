Return-Path: <linux-kernel+bounces-48973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D669D84643C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAA52891A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44D9D47A7B;
	Thu,  1 Feb 2024 23:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L2yEviLG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09AB47A64;
	Thu,  1 Feb 2024 23:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706828510; cv=none; b=ISNS3W5ySAsKXQLLS/VFX85QbYYRlL6XRbnH1nptaHnZCIX/G6vijxr/zJfMy/u+HF3d3PYH00+ikGOgwRTg2fuZBc3q+ryR8ebzfeWA8gMxaZQ/TAJYCwrcx+yRSpdjULnb887Hw/VZSEX139Hg/VGdffoNmqjDsNYsBzrhRQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706828510; c=relaxed/simple;
	bh=4XkErM8CaF4yBbMqEOKoKHCOfQFc1bRAL1QvdlEZivU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/cwYcf/P9HPsdBnLoIAK4B+5VVHzMXd4YvBB4eGiPXvMaHIUITsCA4eRO0F0r4XQ3umlpNW/pgeDlKhD1RyqSTTZCadElzds8c3kKyX7KyY6C1ry3DCjkNoFqC6UhJChw0rxoPZRKNG7Pl6bZ9v0plS7ggahyAMLKEgYYpWinU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L2yEviLG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706828509; x=1738364509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4XkErM8CaF4yBbMqEOKoKHCOfQFc1bRAL1QvdlEZivU=;
  b=L2yEviLGr4kUkj+DB0G1Xb6yJRm9/zhVR2zvJaAtI3ryQ8v4AJ8YVQ5L
   HAKp+bJhsaNN176IMnad0yHB6bb+9TknlYZQbOA5y7OxF6oxv1noEi68C
   YoFREmqjjS4HDLdUFcUyABkT8RaQLWSDFbEzNE9duyBFas072qYDjjbWS
   aREZy/rX7NR4WjNM8pyJg06h0tg7bVS0Ba/7q+hV2SskjXukbW3DgAnSg
   6Q58QAlbLm1kJ5qLeRRBHysdjDAGqS4ME/it4oOyJyMhgbi4/LKGgRjmd
   Lr7OBpHcHno0i3BCegqpJ+qzsoAGvt9s4+rmT9rOCUr7ldM9c26/brygI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="22530111"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="22530111"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 15:01:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="4502458"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 01 Feb 2024 15:01:43 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVg3w-0003IY-2A;
	Thu, 01 Feb 2024 23:01:40 +0000
Date: Fri, 2 Feb 2024 07:00:41 +0800
From: kernel test robot <lkp@intel.com>
To: Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Marco Felsch <m.felsch@pengutronix.de>,
	Jeff LaBundy <jeff@labundy.com>
Cc: oe-kbuild-all@lists.linux.dev, catalin.popescu@leica-geosystems.com,
	mark.satterthwaite@touchnetix.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	bsp-development.geo@leica-geosystems.com,
	Kamel Bouhara <kamel.bouhara@bootlin.com>
Subject: Re: [PATCH v7 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
Message-ID: <202402020623.8T1Ah513-lkp@intel.com>
References: <20240131141158.3350344-4-kamel.bouhara@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131141158.3350344-4-kamel.bouhara@bootlin.com>

Hi Kamel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on dtor-input/next]
[also build test WARNING on dtor-input/for-linus robh/for-next krzk-dt/for-next linus/master v6.8-rc2 next-20240201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kamel-Bouhara/dt-bindings-vendor-prefixes-Add-TouchNetix-AS/20240131-221925
base:   https://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next
patch link:    https://lore.kernel.org/r/20240131141158.3350344-4-kamel.bouhara%40bootlin.com
patch subject: [PATCH v7 3/3] Input: Add TouchNetix axiom i2c touchscreen driver
config: s390-randconfig-r131-20240201 (https://download.01.org/0day-ci/archive/20240202/202402020623.8T1Ah513-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project fdac7d0b6f74f919d319b31a0680c77f66732586)
reproduce: (https://download.01.org/0day-ci/archive/20240202/202402020623.8T1Ah513-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402020623.8T1Ah513-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/input/touchscreen/touchnetix_axiom.c:181:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le32 [usertype] preamble @@     got unsigned int @@
   drivers/input/touchscreen/touchnetix_axiom.c:181:18: sparse:     expected restricted __le32 [usertype] preamble
   drivers/input/touchscreen/touchnetix_axiom.c:181:18: sparse:     got unsigned int
>> drivers/input/touchscreen/touchnetix_axiom.c:183:40: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected unsigned int reg @@     got restricted __le32 [usertype] preamble @@
   drivers/input/touchscreen/touchnetix_axiom.c:183:40: sparse:     expected unsigned int reg
   drivers/input/touchscreen/touchnetix_axiom.c:183:40: sparse:     got restricted __le32 [usertype] preamble

vim +181 drivers/input/touchscreen/touchnetix_axiom.c

   171	
   172	static int axiom_read(struct axiom_data *ts, u8 usage, u8 page, void *buf, u16 len)
   173	{
   174		struct axiom_cmd_header cmd_header;
   175		__le32 preamble;
   176		int ret;
   177	
   178		cmd_header.target_address = cpu_to_le16(axiom_usage_to_target_address(ts, usage, page, 0));
   179		cmd_header.length = cpu_to_le16(len | AXIOM_CMD_HEADER_READ_MASK);
   180	
 > 181		preamble = get_unaligned_le32((u8 *)&cmd_header);
   182	
 > 183		ret = regmap_write(ts->regmap, preamble, 0);
   184		if (ret) {
   185			dev_err(ts->dev, "failed to write preamble, error %d\n", ret);
   186			return ret;
   187		}
   188	
   189		ret = regmap_raw_read(ts->regmap, 0, buf, len);
   190		if (ret) {
   191			dev_err(ts->dev, "failed to read target address %04x, error %d\n",
   192				cmd_header.target_address, ret);
   193			return ret;
   194		}
   195	
   196		/* Wait device's DMA operations */
   197		usleep_range(AXIOM_DMA_OPS_DELAY_USEC, AXIOM_DMA_OPS_DELAY_USEC + 50);
   198	
   199		return 0;
   200	}
   201	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

