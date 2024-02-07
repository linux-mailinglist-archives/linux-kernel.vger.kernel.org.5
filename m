Return-Path: <linux-kernel+bounces-55826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A7384C22A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC47EB24DFA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F482EAE5;
	Wed,  7 Feb 2024 01:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B3O55aQ4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244A0DF78;
	Wed,  7 Feb 2024 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270933; cv=none; b=LtyF4f+Q3XDAoCbjHI4FIHLajTgj/TUeGXqYV0VZlrE0PpZPACCWQKppSRtFlPOHhx/daGa7zT6/PcXSZntrXvF1xyHUPm1jcakE/qxpt0o7wkd7MxkToCRkGGZhX4U4Fa/b0oZlM8LwvCBQbz8DUaL6mHu0r3lg8Bg/Gi/3Cp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270933; c=relaxed/simple;
	bh=mG7uSB7BF0mlbRNJ9ZZyvOnHgKYsgTxFbHl5KXrLGug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ukku/ahHKgN3zLVsjSLScw64MMmo+NyMhn4vAq8sFcXVn+JIUpAeK9VRrJ7mVpI/RAFd9wcb71aGybFAJwDEMby4VJOwUcPnaaTbpv651ly6k+p49g0R6MQm6fhx/nBZry8NfsRolgHGfDe+w6a4dKXzOV3PX7A/JpiSFAw4YVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B3O55aQ4; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707270930; x=1738806930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mG7uSB7BF0mlbRNJ9ZZyvOnHgKYsgTxFbHl5KXrLGug=;
  b=B3O55aQ4kdKFmYjUNuUgkK9+q5KwpfRZz4qPKnMnL+fPPoRHAka2nU2e
   evi3HKpde10+QT5vxsm0ZJq3xhDYBzA3w9XxMJPCHQz4azb5a7339+cAo
   6PfReVhKg9AH2a8JUAR2IZNDGjQbxo+aMP3ahHhK7/on5asxoYKagaCW2
   AtwZ+U0N2S2LI+KFCR+uYAX11CrGO1Jj0lRo2MskAkCIRiu52NSVWh6Ox
   hXtqYJx0HP2wn61wFxP5v0pe0unKdcbS2J21zFiOQSksq56O1EwboY/is
   o7mTSM7pxmNVFvoIdxxwDu+sQcVid9iLxtsJoU2QjVJ077AkWlV0wMW4f
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="4671459"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="4671459"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:55:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5807087"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Feb 2024 17:55:26 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXX9o-0001yQ-1U;
	Wed, 07 Feb 2024 01:55:24 +0000
Date: Wed, 7 Feb 2024 09:54:34 +0800
From: kernel test robot <lkp@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Ingo Molnar <mingo@kernel.org>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/2 v3] cxl/region: Use cond_guard() in show_targetN()
Message-ID: <202402070919.0zuYCxMS-lkp@intel.com>
References: <20240206121301.7225-3-fabio.maria.de.francesco@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206121301.7225-3-fabio.maria.de.francesco@linux.intel.com>

Hi Fabio,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on v6.8-rc3 next-20240206]
[cannot apply to cxl/next cxl/pending]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cleanup-Add-cond_guard-to-conditional-guards/20240206-203110
base:   linus/master
patch link:    https://lore.kernel.org/r/20240206121301.7225-3-fabio.maria.de.francesco%40linux.intel.com
patch subject: [PATCH 2/2 v3] cxl/region: Use cond_guard() in show_targetN()
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20240207/202402070919.0zuYCxMS-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402070919.0zuYCxMS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402070919.0zuYCxMS-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/cxl/core/region.c: In function 'show_targetN':
>> drivers/cxl/core/region.c:670:70: warning: suggest braces around empty body in an 'else' statement [-Wempty-body]
     670 |         cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
         |                                                                      ^


vim +/else +670 drivers/cxl/core/region.c

   664	
   665	static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
   666	{
   667		struct cxl_region_params *p = &cxlr->params;
   668		struct cxl_endpoint_decoder *cxled;
   669	
 > 670		cond_guard(rwsem_read_intr, return -EINTR, &cxl_region_rwsem);
   671	
   672		if (pos >= p->interleave_ways) {
   673			dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
   674				p->interleave_ways);
   675			return -ENXIO;
   676		}
   677	
   678		cxled = p->targets[pos];
   679		if (!cxled)
   680			return sysfs_emit(buf, "\n");
   681	
   682		return sysfs_emit(buf, "%s\n", dev_name(&cxled->cxld.dev));
   683	}
   684	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

