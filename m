Return-Path: <linux-kernel+bounces-42134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0E983FCE4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C53D1F2318C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A310A03;
	Mon, 29 Jan 2024 03:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iy0L7m2j"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7496710957;
	Mon, 29 Jan 2024 03:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499612; cv=none; b=XfwncRFRMWio0QZCLESgQz9dt4WAgXrVHGEM0QyqZEse2bECgp6IqJEdMIEtJk/WcH6zagyKrq+JdAZolperpXrknhLIPXFS6k0FgeE67OT/rDDfAYKcWw7MLcevR5wuN1cnDbX8hJHGIvmgfcBm8eMrKA9SNVM9BCYdaV0vvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499612; c=relaxed/simple;
	bh=+bQCXJR0sf7n1fc5UEvI/I5MK89K8Itu0r2VGI3HRFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqNUMe5DeGrWy+yiztLiy82WylP5omhgcqqK5+Q3Y+GYzbIHSPqg/xyhzyvm44mxzM50GPgfJJwOYypHCWhRRpn27vncV2rCJIQdPnPUOh6HfFAqYNWGFyI2RpwSYffrWnyBmyJ5/lR276LME97ooAZzp50jop57ubFpZj17Gzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iy0L7m2j; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706499610; x=1738035610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+bQCXJR0sf7n1fc5UEvI/I5MK89K8Itu0r2VGI3HRFo=;
  b=Iy0L7m2j7ZhYwqtcpqKy1g8hjLWgHpAfjYHL8rW1nsSvJy5X2NpUfmWe
   34NO9MLiGSUmRxxkS2iW8+0mn+0TPo4PJtCeyLjXz1I3BPgcCrU2iSbVV
   DLcJ1ABr4QFtGOGeN1M4gdMMLyeLbNNAQsXEq8OeBqRNNgwiwIW2/yCkr
   MNSQ8k90zb+K7J0pF6eHKu4nfaTdzRIBXvt0q7JJ5Ecnf+o7RST9ASejL
   G7YL9ZLYo2wQ7K7VTk/xZSqhmfA7Sxmxl0vNzwa4wMmasx8rekwQvZEda
   XJ9jg5KeMuJTQM/vXhgSDboE+OVez/fqmPhVdDYH+2YZiCbPt4rVxTFGq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="9952522"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="9952522"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 19:40:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="906947399"
X-IronPort-AV: E=Sophos;i="6.05,226,1701158400"; 
   d="scan'208";a="906947399"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 28 Jan 2024 19:40:02 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rUIV6-00040q-2C;
	Mon, 29 Jan 2024 03:40:00 +0000
Date: Mon, 29 Jan 2024 11:39:11 +0800
From: kernel test robot <lkp@intel.com>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, catalin.marinas@arm.com,
	will@kernel.org, robh+dt@kernel.org, frowand.list@gmail.com,
	vgupta@kernel.org, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
	guoren@kernel.org, monstr@monstr.eu, palmer@dabbelt.com,
	aou@eecs.berkeley.edu, dinguyen@kernel.org, chenhuacai@kernel.org,
	tsbogend@alpha.franken.de, jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
	mpe@ellerman.id.au, ysato@users.sourceforge.jp, dalias@libc.org,
	glaubitz@physik.fu-berlin.de, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	chris@zankel.net, jcmvbkbc@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 18/46] of: reserved_mem: Add code to dynamically allocate
 reserved_mem array
Message-ID: <202401291128.e7tdNh5x-lkp@intel.com>
References: <20240126235425.12233-19-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126235425.12233-19-quic_obabatun@quicinc.com>

Hi Oreoluwa,

kernel test robot noticed the following build warnings:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core vgupta-arc/for-curr powerpc/next powerpc/fixes jcmvbkbc-xtensa/xtensa-for-next linus/master v6.8-rc1 next-20240125]
[cannot apply to vgupta-arc/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oreoluwa-Babatunde/of-reserved_mem-Change-the-order-that-reserved_mem-regions-are-stored/20240127-081735
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240126235425.12233-19-quic_obabatun%40quicinc.com
patch subject: [PATCH 18/46] of: reserved_mem: Add code to dynamically allocate reserved_mem array
config: arm-aspeed_g4_defconfig (https://download.01.org/0day-ci/archive/20240129/202401291128.e7tdNh5x-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240129/202401291128.e7tdNh5x-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401291128.e7tdNh5x-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
>> WARNING: modpost: vmlinux: section mismatch in reference: alloc_reserved_mem_array+0x50 (section: .text.unlikely) -> memblock_alloc_try_nid (section: .init.text)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

