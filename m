Return-Path: <linux-kernel+bounces-56707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FBF984CDE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3B08B26B8F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A807F7DF;
	Wed,  7 Feb 2024 15:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jF3oZI/C"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A9259B78;
	Wed,  7 Feb 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319342; cv=none; b=lrUCSqxna0Z4NqFNPcdKk0tgrU1NOCzEPdIawlabTnsv7SNePgVryT1nrogmRoSZQBTQwnqjVQcXLBjIvHBCPLlt9z2+6xaPwfT/SF9ulYszNC+Te2Vs8RqnkOaroidR3e+Whava+rtrhw5dXc0uKHHtNm0BBDNOvrJCLkEBILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319342; c=relaxed/simple;
	bh=0ZqVkE4MQT6le5S4lU2VaSaHvTULorc8uo0swoUmiUI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lKlO6E2l0hjG/0kWTceUX5e47Elxn1oGO8drrwsfDECzAvd6LBh6MaOIX6sJN0IOcXe+4h75d8CMJC4ltFiu3nnYvutNeug9+Iir6zxpaiz7i/TDDxH66pKoPHRWTVz9FkdX6hUkwhA5qY4k9uu4Q8wRx6D+lzblVKVXxbBUD5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jF3oZI/C; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707319340; x=1738855340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ZqVkE4MQT6le5S4lU2VaSaHvTULorc8uo0swoUmiUI=;
  b=jF3oZI/C6hb98mtYHLQaugOK0GTYEdMV4GOoBB9VDN5uccgjt13LzvEU
   0S7YVOHaxqmo+FW5kBHHVg9qcZCK9iqsKXFUNzJCEKATt0f9M8YhRBMY6
   DLqkyOH2iz0RBimCBo+QH0aexZ68u7o5b5jqovksBXX0j1R95xLQ4TACQ
   a27uTuCKc3qRaUgyM14ZH1eM2BvBUGj8T0SP6k7pBUcjfamlijkptwk1b
   6g5g94pDo/qyo6fRkUU9qarplLhIbsPcuJXolfXMRIzAGOxrvDmpgcrDC
   oRpB88eJ7tYerjjRLlP95sgZhjIaaqG1Wtvw7vViYFV27mM1FRXvAA4Cz
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="3998390"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="3998390"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 07:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1657320"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.22.1])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 07:22:16 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ingo Molnar <mingo@kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 2/2 v3] cxl/region: Use cond_guard() in show_targetN()
Date: Wed, 07 Feb 2024 16:22:13 +0100
Message-ID: <4546212.LvFx2qVVIh@fdefranc-mobl3>
Organization: intel
In-Reply-To: <202402070919.0zuYCxMS-lkp@intel.com>
References:
 <20240206121301.7225-3-fabio.maria.de.francesco@linux.intel.com>
 <202402070919.0zuYCxMS-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 7 February 2024 02:54:34 CET kernel test robot wrote:
> Hi Fabio,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.8-rc3 next-20240206]
> [cannot apply to cxl/next cxl/pending]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:   
> https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cleanup
> -Add-cond_guard-to-conditional-guards/20240206-203110 base:   linus/master
> patch link:   
> https://lore.kernel.org/r/20240206121301.7225-3-fabio.maria.de.francesco%40
> linux.intel.com patch subject: [PATCH 2/2 v3] cxl/region: Use cond_guard()
> in show_targetN() config: s390-allyesconfig
> (https://download.01.org/0day-ci/archive/20240207/202402070919.0zuYCxMS-lkp
> @intel.com/config) compiler: s390-linux-gcc (GCC) 13.2.0
> reproduce (this is a W=1 build):
> (https://download.01.org/0day-ci/archive/20240207/202402070919.0zuYCxMS-lkp
> @intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version
> of the same patch/commit), kindly add following tags
> 
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes:
> | https://lore.kernel.org/oe-kbuild-all/202402070919.0zuYCxMS-lkp@intel.com
> | /
> All warnings (new ones prefixed by >>):
> 
>    drivers/cxl/core/region.c: In function 'show_targetN':
> >> drivers/cxl/core/region.c:670:70: warning: suggest braces around empty
> >> body in an 'else' statement [-Wempty-body]
>      670 |         cond_guard(rwsem_read_intr, return -EINTR,
> &cxl_region_rwsem);
>          |                                                                      
^

I think that this warning deserves attention and braces should be added around 
the 'else' empty body. I'm going to send v4:

#define cond_guard(_name, _ret, args...) \
        CLASS(_name, scope)(args); \
        if (!__guard_ptr(_name)(&scope)) _ret; \
        else { }

Any comments?

Fabio

> 
> vim +/else +670 drivers/cxl/core/region.c
> 
>    664
>    665	static size_t show_targetN(struct cxl_region *cxlr, char *buf, int
> pos) 666	{
>    667		struct cxl_region_params *p = &cxlr->params;
>    668		struct cxl_endpoint_decoder *cxled;
>    669
> 
>  > 670		cond_guard(rwsem_read_intr, return -EINTR, 
&cxl_region_rwsem);
> 
>    671
>    672		if (pos >= p->interleave_ways) {
>    673			dev_dbg(&cxlr->dev, "position %d out of range 
%d\n", pos,
>    674				p->interleave_ways);
>    675			return -ENXIO;
>    676		}
>    677
>    678		cxled = p->targets[pos];
>    679		if (!cxled)
>    680			return sysfs_emit(buf, "\n");
>    681
>    682		return sysfs_emit(buf, "%s\n", dev_name(&cxled-
>cxld.dev));
>    683	}
>    684





