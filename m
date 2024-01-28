Return-Path: <linux-kernel+bounces-41529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5149883F3C3
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390171C210A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFDA8F6C;
	Sun, 28 Jan 2024 04:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8zAsAus"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B062DDA2;
	Sun, 28 Jan 2024 04:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706416223; cv=none; b=XimyJGHIxNrlpu+CeeDt4vouUjNpYriEUAtKdLfu1nLhWk+lYCbyracwJcTzhkq18eojUM0pmmuXK3TnZs2nxwFK2CJ8fBPr6JaTZ8883QkBuZ7Id1GehuQGeaTnszSynIAq6cEtVx7ZDKu7AZraNYA77OKaAHVzIakJbLttYio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706416223; c=relaxed/simple;
	bh=5KJJfPnG1UoHE6jIm0aaEisxP7TFBqaCktqKdcwNC7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP9fKCtHe4FpWPBWcXgu/7ucC4XYK5Q4bdcpA5yPCEvXv6r0R0EMqK+cAlQOXOxJiNk8r7M3/s26Cuw7m7bHPrjhpTpAxgapyHqYSEceYgmN7vpro/E8rIPYiUKPP/RJhJ+8rcs1HWUHjb2CI0hJhNKe/aBlyPn9/hRT8I6909Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8zAsAus; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706416221; x=1737952221;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5KJJfPnG1UoHE6jIm0aaEisxP7TFBqaCktqKdcwNC7c=;
  b=c8zAsAuspSzn5JzuekdZPatzKhS3RtQWaB3hnq6IMisqgJoR4/7RendP
   IIWAB2ZHbQlP9Dnoq1ola0MBzOvgwMeGn4uGpnZBFtsE0bvaBaOiCk9Cq
   GrIPPzT/j5Y7QlnNNMGc4nN6pJrddgin4qN5szVPoqp1GenEHb2jsY+MG
   //D6fuyjoVE4rNhvVYDcz/lao6B9CQ47EC31CSCFqipm5E+tUvfSGmV3E
   JWhknTaYKHpeyN7V3tC/bcTK0S5txXvnqBCArHkTRzE0m7RGmtmqU0vkt
   5TOnz1VOyhOXGBAJkkZt16GWuqXDpI7BVfI7geAx9r0PzK02KWFY7WALe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="433900320"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="433900320"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 20:30:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="910718819"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="910718819"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 Jan 2024 20:30:13 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTwo7-00034k-1V;
	Sun, 28 Jan 2024 04:30:11 +0000
Date: Sun, 28 Jan 2024 12:29:50 +0800
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
Subject: Re: [PATCH 30/46] of: reserved_mem: Add code to use unflattened DT
 for reserved_mem nodes
Message-ID: <202401281219.iIhqs1Si-lkp@intel.com>
References: <20240126235425.12233-31-quic_obabatun@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126235425.12233-31-quic_obabatun@quicinc.com>

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
patch link:    https://lore.kernel.org/r/20240126235425.12233-31-quic_obabatun%40quicinc.com
patch subject: [PATCH 30/46] of: reserved_mem: Add code to use unflattened DT for reserved_mem nodes
config: i386-randconfig-061-20240127 (https://download.01.org/0day-ci/archive/20240128/202401281219.iIhqs1Si-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240128/202401281219.iIhqs1Si-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401281219.iIhqs1Si-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/of/of_reserved_mem.c:111:18: sparse: sparse: incompatible types for operation (<):
   drivers/of/of_reserved_mem.c:111:18: sparse:    struct device_node *[assigned] node
   drivers/of/of_reserved_mem.c:111:18: sparse:    int

vim +111 drivers/of/of_reserved_mem.c

    98	
    99	/*
   100	 * Save the reserved_mem reg nodes in the reserved_mem array
   101	 */
   102	static void __init dt_scan_reserved_mem_reg_nodes(void)
   103	{
   104		int t_len = (dt_root_addr_cells + dt_root_size_cells) * sizeof(__be32);
   105		struct device_node *node, *child;
   106		phys_addr_t base, size;
   107		const __be32 *prop;
   108		int len;
   109	
   110		node = of_find_node_by_path("/reserved-memory");
 > 111		if (node < 0) {
   112			pr_err("Reserved memory: Did not find reserved-memory node\n");
   113			return;
   114		}
   115	
   116		for_each_child_of_node(node, child) {
   117			const char *uname;
   118			struct reserved_mem *rmem;
   119	
   120			if (!of_device_is_available(child))
   121				continue;
   122	
   123			prop = of_get_property(child, "reg", &len);
   124			if (!prop) {
   125				rmem = of_reserved_mem_lookup(child);
   126				if (rmem)
   127					rmem->dev_node = child;
   128				continue;
   129			}
   130	
   131			uname = of_node_full_name(child);
   132			if (len && len % t_len != 0) {
   133				pr_err("Reserved memory: invalid reg property in '%s', skipping node.\n",
   134				       uname);
   135				continue;
   136			}
   137	
   138			base = dt_mem_next_cell(dt_root_addr_cells, &prop);
   139			size = dt_mem_next_cell(dt_root_size_cells, &prop);
   140	
   141			if (size)
   142				fdt_reserved_mem_save_node(child, uname, base, size);
   143		}
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

