Return-Path: <linux-kernel+bounces-31393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 675AA832DB2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208D3284E20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBA655C35;
	Fri, 19 Jan 2024 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I8kUq447"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDC71C15;
	Fri, 19 Jan 2024 17:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705684044; cv=none; b=FtZvH6iHR3YOpQza/QwPnTeO4UVqGixlFMuMdg8IolItQ5/ammqgb9/YMMUVvcmBAdr1aeMR2wZ6JBuBFsQSl0rsXpUjeju/IuHw3KIKWSqTib96twoA6lbIeAZiVFoflK/rGRW7Vz2fbRQdb7QqC+74kCDnMOndOtqsmPkDsEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705684044; c=relaxed/simple;
	bh=UQKvrlIh2v6bhtJDIP6agbk3s+La60WIG/t2aFDjulQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reMg+SkULaf4GAq2WN8B3qTOlca5mzG4RZ/9XqzX5E/5NSPA5Iu5wDUbA0wnEQeuOX4PaNBGs9mbtECwy9+7YCMl12pvxdX7YVUSKOC8ecFJuTBZ7apMz4/ToIRPBT3GaXzEZbq+EwWsXuzhVSYS6LSYIL9Bdu33Ck7cczD97OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I8kUq447; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705684043; x=1737220043;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UQKvrlIh2v6bhtJDIP6agbk3s+La60WIG/t2aFDjulQ=;
  b=I8kUq447/ZGNB+MbHlG/NzbqEpBXCLiWvIHtLgWOJXrYaV+wAq0rAKxM
   Vf5LKCyhuzKpw4bdVWwPFVnt2GLlv5Efq4USEsiL9q0QT+O7r1CuFBbdx
   vSocu+ypqQfAkFbqwj/ET/nuNaBLD+p1i9rWGpyYqz6Z6iw2aK8jSgvJT
   x4YXeD+IdE6RqZn4d0Xro41oImVgbS9/rrlxs/ZAaPVtWapFtoZloHFaA
   qJ2z4CeHplcIWGFoEu+sQFGpGObIv/ItgopDvDiWzU1dcO5iD5d7YMRGO
   WFurlR0USGX8tClHLz9+AemC9IudCXlOEFpM11CGqeQPPlMMkBao0nvwD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="14314026"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="14314026"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 09:05:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="19446853"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2024 09:05:10 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQsIm-0004Hs-0L;
	Fri, 19 Jan 2024 17:05:08 +0000
Date: Sat, 20 Jan 2024 01:04:43 +0800
From: kernel test robot <lkp@intel.com>
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, 675146817@qq.com,
	story_19872006@126.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, seanjc@google.com, kim.phillips@amd.com,
	kirill.shutemov@linux.intel.com, jmattson@google.com,
	babu.moger@amd.com, kai.huang@intel.com, acme@redhat.com,
	aik@amd.com, namhyung@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, CobeChen@zhaoxin.com, TimGuo@zhaoxin.com,
	LeoLiu-oc@zhaoxin.com, GeorgeXue@zhaoxin.com
Subject: Re: [PATCH 3/3] crypto: Zhaoxin: Hardware Engine Driver for
 SHA1/256/384/512
Message-ID: <202401200020.g4KDJOTm-lkp@intel.com>
References: <20240116063549.3016-4-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116063549.3016-4-TonyWWang-oc@zhaoxin.com>

Hi Tony,

kernel test robot noticed the following build errors:

[auto build test ERROR on herbert-cryptodev-2.6/master]
[also build test ERROR on tip/x86/core linus/master v6.7 next-20240119]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Tony-W-Wang-oc/crypto-padlock-sha-Matches-CPU-with-Family-with-6-explicitly/20240116-144827
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20240116063549.3016-4-TonyWWang-oc%40zhaoxin.com
patch subject: [PATCH 3/3] crypto: Zhaoxin: Hardware Engine Driver for SHA1/256/384/512
config: loongarch-allyesconfig (https://download.01.org/0day-ci/archive/20240120/202401200020.g4KDJOTm-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240120/202401200020.g4KDJOTm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401200020.g4KDJOTm-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/crypto/zhaoxin-sha.c:20:10: fatal error: asm/cpu_device_id.h: No such file or directory
      20 | #include <asm/cpu_device_id.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.


vim +20 drivers/crypto/zhaoxin-sha.c

  > 20	#include <asm/cpu_device_id.h>
    21	#include <asm/fpu/api.h>
    22	#include "zhaoxin-sha.h"
    23	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

