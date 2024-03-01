Return-Path: <linux-kernel+bounces-89060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909C986EA19
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 21:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BDB1C2421C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DD83C070;
	Fri,  1 Mar 2024 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iqTaE3oQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557A97EC
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 20:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709323982; cv=none; b=N8GpYO5HaBbYKTFtO+SRMkGONFEmcT5U5WMj5ulktk3JVowlCPSjBtHQzvLqQ4mBcvZjuwMSJ5tRBLAB9naHHPvpr/IAlHuaWcTdEmU2y5z/umi7yIJ1sE8ChjdHbQqx8Eh00CYObPDXjiZ/qlmNLgD/UHYQzOTaq8nfTtqYynQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709323982; c=relaxed/simple;
	bh=D+EhPZ+fZWYYQBAJI9TX8JmHQ+KmcncAzm/iN9Wb/78=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NBLYONXtbXmPe7Cvqc175kAmJsuKAUuROoj/xof9zsjm78uDXvGw62jRQ9BFp9N93hm230PI4BVOfy//Ui87/Imwt/kqw/mDPMPq9wiBPw0UN1k+1CjHI/lsSmlKbxLHzRnOwv1fhCLW1NVudPJAUXl36xrGt5B8stIl8tSTJzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iqTaE3oQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709323981; x=1740859981;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D+EhPZ+fZWYYQBAJI9TX8JmHQ+KmcncAzm/iN9Wb/78=;
  b=iqTaE3oQz7KhY6HRt/kH97YX0t0FDFy55TsiDYK6TyT9JxbVoe1HmIV+
   R+AlHBeKgNPAh7n/s/kNB6nxWWAZ02KLjO5DryqdlTRWD9B7KlX1Aa+3t
   Y3jboRaxl2TvljFMrC2QBEO1YKf0ASgZzUMlivlrJGuZeXBuELj1OxNsc
   POdyze6dVjmD+rFOcW9fb5dpHos/+oatw+rDMP3vcbwrePDmcxUj7uv8l
   L7zCXNjj4cOOqgomTl1jL3/1Px0WUrFjVSO60YnQpeL2sb124Rz2n5Eer
   CMwaLN6NMRdg6RAC3Er3PxLdKneoHXzbcPT4sBWeCD7JGiOpQp7jR27Kl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3744655"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3744655"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 12:13:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8681079"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 01 Mar 2024 12:12:58 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rg9FK-000E4V-2y;
	Fri, 01 Mar 2024 20:12:47 +0000
Date: Sat, 2 Mar 2024 04:12:16 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjan@linux.intel.com>
Subject: arch/x86/include/asm/processor.h:698:16: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202403020457.RCJoQ3ts-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Thomas,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   87adedeba51a822533649b143232418b9e26d08b
commit: 6e29032340b60f7aa7475c8234b17273e4424007 x86/cpu: Move cpu_l[l2]c_id into topology info
date:   5 months ago
config: i386-randconfig-062-20240301 (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240302/202403020457.RCJoQ3ts-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403020457.RCJoQ3ts-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)


vim +698 arch/x86/include/asm/processor.h

   695	
   696	static inline u16 per_cpu_llc_id(unsigned int cpu)
   697	{
 > 698		return per_cpu(cpu_info.topo.llc_id, cpu);
   699	}
   700	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

