Return-Path: <linux-kernel+bounces-60394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB985045E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C58D282E6E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CFF3DBBE;
	Sat, 10 Feb 2024 12:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XanJ0GbF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E513D0DF
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 12:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707568042; cv=none; b=s0u5OS0XPx019qsFPoNZSg1a4xCxEXpdEjwxGfxxGFh3ObCYJmXiFzVLM7QxIkUuH5Z5zo4bqjzXVmDF2hm9jYqkNBjmMTHmpMsUQsIDVOF/qpXXUHrtMvzZvcYCPKmHrwMBk0tbrudPb0VXyxZPWBcZ5Y/WskWgQDAKAndpzTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707568042; c=relaxed/simple;
	bh=CDT//qYcBnZUHn1FTBe+ZpVUsM5rhvtyWe5Slde0+OE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B1srprxuUlCb713CynsjI2aclYSvVJe2soOogCZq6DgQSrtGDXvFCddvKmbd5ES3ocr1MohI4l16GS9fAK+LEnZHS3nCtuGEGqP0HXuS88TmZtnoCXHZgqnyjneSnJtn5kDUq/jBDKWUpTeQcp4dUpIxdR4q5NOTEV+iTQTNz7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XanJ0GbF; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707568041; x=1739104041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CDT//qYcBnZUHn1FTBe+ZpVUsM5rhvtyWe5Slde0+OE=;
  b=XanJ0GbFV0lfpOKlf3G4V4tRdmQSL7SzYcXxgVrea6qQw41cbHAFtHyq
   aAUDj97QcZXEtmmur9N1IW7mciNPgimdgXKr8vhtV0qGnxm2kr6+vqz8s
   u74fG3bSAl3HfGL5V7hlG6TuFdgy8PajE4AZlHTJa4NfuBnBU4pRQXCQU
   UsmuFfB/zQM6U0jHGgIfsrlNl3uQWTsNrOdA7I0/j1inFVEKw6mhZKeGr
   lMN7uY1RDgKlyNrMiUHvFArSfFNcj4d6tVV/X0+13v2MoXb4FkYDzuG5p
   rY3EVACCH4jGyYoFNAP6RTmE1RBHZ4HUkpIc5l7MZb4fpH4Hg5F3xIjLD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5348289"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="5348289"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2024 04:27:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="2474320"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 10 Feb 2024 04:27:19 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYmRw-0005dk-2D;
	Sat, 10 Feb 2024 12:27:16 +0000
Date: Sat, 10 Feb 2024 20:26:26 +0800
From: kernel test robot <lkp@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Max Kellermann <max.kellermann@ionos.com>
Subject: Re: [PATCH v2 35/35] include: remove lots of unnecessary
 <linux/kernel.h> includes
Message-ID: <202402102041.qUqvmKVs-lkp@intel.com>
References: <20240209164027.2582906-36-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209164027.2582906-36-max.kellermann@ionos.com>

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20240209]
[cannot apply to drm-misc/drm-misc-next media-tree/master mkp-scsi/for-next linus/master v6.8-rc3 v6.8-rc2 v6.8-rc1 v6.8-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Kellermann/include-add-missing-includes/20240210-005417
base:   next-20240209
patch link:    https://lore.kernel.org/r/20240209164027.2582906-36-max.kellermann%40ionos.com
patch subject: [PATCH v2 35/35] include: remove lots of unnecessary <linux/kernel.h> includes
config: alpha-allnoconfig (https://download.01.org/0day-ci/archive/20240210/202402102041.qUqvmKVs-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402102041.qUqvmKVs-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402102041.qUqvmKVs-lkp@intel.com/

All errors (new ones prefixed by >>):

   lib/flex_proportions.c: In function 'fprop_reflect_period_percpu':
>> lib/flex_proportions.c:92:26: error: implicit declaration of function 'ilog2' [-Werror=implicit-function-declaration]
      92 | #define PROP_BATCH (8*(1+ilog2(nr_cpu_ids)))
         |                          ^~~~~
   lib/flex_proportions.c:130:41: note: in expansion of macro 'PROP_BATCH'
     130 |                 if (val < (nr_cpu_ids * PROP_BATCH))
         |                                         ^~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/ilog2 +92 lib/flex_proportions.c

f3109a51f8dc88 Jan Kara 2012-05-24  88  
f3109a51f8dc88 Jan Kara 2012-05-24  89  /*
f3109a51f8dc88 Jan Kara 2012-05-24  90   * ---- PERCPU ----
f3109a51f8dc88 Jan Kara 2012-05-24  91   */
f3109a51f8dc88 Jan Kara 2012-05-24 @92  #define PROP_BATCH (8*(1+ilog2(nr_cpu_ids)))
f3109a51f8dc88 Jan Kara 2012-05-24  93  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

