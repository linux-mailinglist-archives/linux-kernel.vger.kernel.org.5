Return-Path: <linux-kernel+bounces-51418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F073848AFF
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 05:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 416581C221B2
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4F8567D;
	Sun,  4 Feb 2024 04:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L7wvaLCe"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B351C3D;
	Sun,  4 Feb 2024 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707020867; cv=none; b=jZikSIYjVNDZKvtZGXGkRHBkdJOsMrOYgdi7tsD3/e02G7FDKPkg+mo1LxEgBqS5sPTXAX2U0ecE22fr7+r4+j4E+w9vEzT8orDyFHDBllH3RwttNc8x6raVjQgt8qfinuuCxP4VNjYUmUa2ZPLt4FyGAMj7KSW7uqbKpBDYuSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707020867; c=relaxed/simple;
	bh=5ueOFmnH0raghBRETpa0zjyXxByg30ezHCMopGwPipM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6K41Elq/bi2DUF0TUtNOzsoSgIfeXZQmF9TomDqeh3j9bqVkgUuz43oQ++OlC1eJ/BF6cD6F26wkppMURx17n19q+kZuLDEmyfnx+xUt8PeQLICw5xIvJ83Vdgs4sLP+ALvABnVhBSwpe7G7f/z5Z+RsEo87cBJZezmF1uTXko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L7wvaLCe; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707020865; x=1738556865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ueOFmnH0raghBRETpa0zjyXxByg30ezHCMopGwPipM=;
  b=L7wvaLCeribC1zBYVF65UDBiqH92vkGm0HWNHD5a5L/OdcMy+vKx3uBH
   oniUaLuWUkMKIT8pwmhC8Xxi1ygXxAxMYgyFgxhjrYNJ1ko9I5r9SeYqx
   KKAeuKfjcqfdeFrhHAQ1aV0M19I8zjGX3PSMfcST11OT+eVlmm/JGRgrd
   u99+lqBjuZkx9RRlwqEGedEC85gS7EogDk7jW9SgvZIxKFfCDUXR6/9zx
   +A+PPaqgL9IPnjp4OdAGm2UN5E4jnMSvEZ/8kgIwVjbgXAw6GOMIvQOxL
   3Lry15D1rCOOksko462pZlMJV9O9hGrbDx1OZXZErjRRJIP7DSOhGbaP4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="3328439"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="3328439"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 20:27:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="427609"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 03 Feb 2024 20:27:42 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rWU6V-00060k-1u;
	Sun, 04 Feb 2024 04:27:39 +0000
Date: Sun, 4 Feb 2024 12:27:30 +0800
From: kernel test robot <lkp@intel.com>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>,
	srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 08/16] misc: fastrpc: Add support to allocate shared
 context bank
Message-ID: <202402041227.P8EVWOg4-lkp@intel.com>
References: <20240202064039.15505-9-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202064039.15505-9-quic_ekangupt@quicinc.com>

Hi Ekansh,

kernel test robot noticed the following build errors:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on char-misc/char-misc-next char-misc/char-misc-linus linus/master v6.8-rc2 next-20240202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ekansh-Gupta/misc-fastrpc-Redesign-remote-heap-management/20240202-144921
base:   char-misc/char-misc-testing
patch link:    https://lore.kernel.org/r/20240202064039.15505-9-quic_ekangupt%40quicinc.com
patch subject: [PATCH v1 08/16] misc: fastrpc: Add support to allocate shared context bank
config: i386-buildonly-randconfig-001-20240203 (https://download.01.org/0day-ci/archive/20240204/202402041227.P8EVWOg4-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240204/202402041227.P8EVWOg4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402041227.P8EVWOg4-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/misc/fastrpc.h:182:2: error: unknown type name 'u32'
     182 |         u32 sharedcb;   /* Set to SMMU share context bank */
         |         ^
   ./usr/include/misc/fastrpc.h:186:2: error: unknown type name 'u32'
     186 |         u32 req;
         |         ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

