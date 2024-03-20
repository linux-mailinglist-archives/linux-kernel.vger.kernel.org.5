Return-Path: <linux-kernel+bounces-109442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 01874881937
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A33F11F21C93
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6389C8595F;
	Wed, 20 Mar 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hES20M3n"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CB23DE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970724; cv=none; b=doGx0JEWKZO15aAJIh5kT6HXUFmPSQ58MO02uynOADN9vFoIbZEWC0YMjkivjfLyjmS28d7svBAggj4Em+EqRU4LT3LeKuZ/Eed++o9smOKUzeMrsw0aN1GtQtopq+6AK1Vb/vJ6V1jePHslVgKraGvI14e1fUluVKDPxGj1yHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970724; c=relaxed/simple;
	bh=hwyO1p0U/dSWBYG0avzKydXMK5sMGnIo/l9kw2vMSyM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ts4oAAGLnT35dcUlTYcy1AVsPbVIFWxPMJwQ5zclct8EeOf3r83kZxLHMM6Le2T3tY2uSGKFlNt2ApFG5Dl80kwi+sGPifr0jKnQOZKIp7cMzjWBc3olyDgVgfj1S9k2vc2BdFh7h/ZA+kry/6jl9LqgKaUB0jRgWK9gjZMEl1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hES20M3n; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710970723; x=1742506723;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hwyO1p0U/dSWBYG0avzKydXMK5sMGnIo/l9kw2vMSyM=;
  b=hES20M3n9/rMt2SD4r2mX9vPh5/jCrbf67umE9/tO44gxkHlK6iRsx5Y
   41zZ/q5kHcTEFCGgKdYc1wwQMsAg/H8+uMar+1d7K9gQItoDrOIFuS3ud
   PENFSb/omQXhCgIonQ6IjmOIcazqEUvzWAQ/JhprnYHBJBRl3PJUZFMo/
   a39LKUg3EFJMMODxz5mkMzJthrELqzRV716KxUqkMdWfrWHjcq7/ZrP5f
   TTZWXaUVylN5vw8DcfE9twtBGWq0SdnNg4IKF9TF4/7Vgj4TDooRBOe98
   ITazuPRIJctYrNp053n6rz+Zo+pMdrnH9IhDyPKaacduiMlMYHjbWK7a4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6137949"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="6137949"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="14357271"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 20 Mar 2024 14:33:24 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rn3Yo-000Ivd-0F;
	Wed, 20 Mar 2024 21:33:22 +0000
Date: Thu, 21 Mar 2024 05:32:53 +0800
From: kernel test robot <lkp@intel.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: ld.lld: error: section .bss virtual address range overlaps with
 .init.pi.text
Message-ID: <202403210517.QYQ8g3G8-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4145ce1e7bc247fd6f2846e8699473448717b37
commit: 3b90b09af5be42491a8a74a549318cfa265b3029 riscv: Fix orphan section warnings caused by kernel/pi
date:   11 months ago
config: riscv-randconfig-r054-20240320 (https://download.01.org/0day-ci/archive/20240321/202403210517.QYQ8g3G8-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 8f68022f8e6e54d1aeae4ed301f5a015963089b7)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240321/202403210517.QYQ8g3G8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403210517.QYQ8g3G8-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: section .bss virtual address range overlaps with .init.pi.text
   >>> .bss range is [0xFFFFFFFF82DB7000, 0xFFFFFFFF83F4943F]
   >>> .init.pi.text range is [0xFFFFFFFF82F9EC20, 0xFFFFFFFF82FA20EF]

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

