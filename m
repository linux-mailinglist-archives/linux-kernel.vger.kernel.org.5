Return-Path: <linux-kernel+bounces-93012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E810887297D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5308BB2EDA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6DC12BEAA;
	Tue,  5 Mar 2024 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VLnv0YLb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6AA126F0F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709674266; cv=none; b=KdHuU7qhAikVLAUz4W2Xn2AFDN4KqJD+XYnswjzLVgH+s5lrPqWQo2/H8VyI+KU4ZxX5RA9HQOeimgOOetDm1NWCLYviavcJt72brre7dJyzCe6ISmD19TWRV+dcbzdhJwY96AhnwzdZu9/gDtj5TXXuT0O97CWVHgXcAYPEjlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709674266; c=relaxed/simple;
	bh=g94ijPnIMzKka6Rf2qsruVkI6faam2W+JcpRHvfHBjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MoEDUwBzfOAJgjn/AO2U0CGNnIqkbEV3LmYS+OY+2wDIQaN7kfxpsu7X2tlSBDDr/4z2Kv5XgOYLjRNeiyYXTGh7hYrtiEO5D9vIa4+bsMS8e/OT0jTwwJ1rSXFyzK8cA/7Nxt5o2rAkm1T/MIYD9rIOFI5Gi0T01VlK+5FjGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VLnv0YLb; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709674264; x=1741210264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g94ijPnIMzKka6Rf2qsruVkI6faam2W+JcpRHvfHBjQ=;
  b=VLnv0YLb6rLO2mCRBTbShFfzvzuEfE2coiAZjE1dJEOnZm660K5SvSW3
   j4QhWb6wzKRZ7jkdIe/U5wqa3YmBHy0wnJONxSW8fQVrwXgJ9dVdYlyqC
   jb6PPCcy5YeBu1Ir7JsLnSx83KWvRHmSl0zubU4ofK6yRYTmPEd9HL4wv
   EeJ2ylrQPJLd0b001U0nIfsmXfpzQCCTFv34hR0FW5O+jjbbm3Q9a2gBr
   TmR4fcGAMMNgj/x3bG0yu4Y1ZkpTnwM8V2IXUxLU1GDzjHaT+gCH07RKg
   gmQOp+34WRu+w97AAkVKG5jM/2Nv5M2tHnsH8GXfYXWMY5cDktOcJv6yG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="14835834"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="14835834"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 13:31:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9936934"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 Mar 2024 13:31:01 -0800
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rhcNG-0003fB-0x;
	Tue, 05 Mar 2024 21:30:58 +0000
Date: Wed, 6 Mar 2024 05:30:09 +0800
From: kernel test robot <lkp@intel.com>
To: Noah Goldstein <goldstein.w.n@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: WARNING: modpost: "csum_partial" [lib/checksum_kunit.ko] has no CRC!
Message-ID: <202403060518.8rOj5Cli-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   90d35da658da8cff0d4ecbb5113f5fac9d00eb72
commit: 688eb8191b475db5acfd48634600b04fd3dda9ad x86/csum: Improve performance of `csum_partial`
date:   10 months ago
config: um-randconfig-001-20240304 (https://download.01.org/0day-ci/archive/20240306/202403060518.8rOj5Cli-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240306/202403060518.8rOj5Cli-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403060518.8rOj5Cli-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: EXPORT symbol "cmpxchg8b_emu" [vmlinux] version generation failed, symbol will not be versioned.
Is "cmpxchg8b_emu" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: EXPORT symbol "csum_partial" [vmlinux] version generation failed, symbol will not be versioned.
Is "csum_partial" prototyped in <asm/asm-prototypes.h>?
WARNING: modpost: "csum_partial" [block/t10-pi.ko] has no CRC!
>> WARNING: modpost: "csum_partial" [lib/checksum_kunit.ko] has no CRC!
WARNING: modpost: "csum_partial" [drivers/scsi/scsi_debug.ko] has no CRC!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

