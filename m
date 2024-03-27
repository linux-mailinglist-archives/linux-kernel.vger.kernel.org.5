Return-Path: <linux-kernel+bounces-120250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B56A88D4DD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A75631F2BC39
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280BB21A04;
	Wed, 27 Mar 2024 03:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z8DLK5tT"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E73DAC10
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711508654; cv=none; b=BfSiLloCZNbNsKvB42BY1S3anI4WYPPlSR7I4CCmmb2xQb/3XHhHQJzyRltpZ+424pei0SFFmJY7KZtpObklgYoh4WF8AF0O3fJ89PRl80j8R6dvA9X5Mzd9pgGao9QWN6FbA4mLJsbZChT4fd5wzz8t3om7vk0ivGq9aFmJWHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711508654; c=relaxed/simple;
	bh=zTBLIeTpRFbv2V2bDHW5oWuXwfOSbPn3Epj6AbmGKOo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=YUtY5Cdq/AK7F1ojfof+wIZMx8C4qr7w29mNbkV/rijemx1+cu8vFGFAZtJ1Pc+ZKYSm/DURFgpWsATNDjvok4D8I0Q73VinVUZNr3ZontwFzZHTEomDh6Uo66h3MH2MrJMpBzpFy0b+jyQPDr2OUqHJBNFU6Kk1aBZUAeuPSAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z8DLK5tT; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711508653; x=1743044653;
  h=date:from:to:cc:subject:message-id;
  bh=zTBLIeTpRFbv2V2bDHW5oWuXwfOSbPn3Epj6AbmGKOo=;
  b=Z8DLK5tTayK7gWkIenEjoKb/K1fYYzmjq2imp97CbIMh4NvqCtSYOgFD
   hKgHJ9LAFEDZEgFKNngTZW3f+pyofInNxAQOTZGMcQpEnLle5ofDl9xKz
   xYOekcrgmz6jk7xP1OS3c4tgHBR45/v7D6TM4M29YrX4kDvZq0m0ik9ZF
   3VnyOB1dzYTyXe+PyirPLyBwB7fzXj9udT74t4toWY3pc7EXuvOjCz0oI
   vB4qs+/NXUaG4/lZx0tidjjzcnpWwgZzQm0XJo9erFWMzQ1Kdifm6DpOt
   nekUj7HGbYvVd0p/7oI2TcJgdwlSldOKhtI8TubYRANSl6Cr38HpwLQsV
   g==;
X-CSE-ConnectionGUID: lDy4Gsp2R62M97uf2Yv/Vg==
X-CSE-MsgGUID: G5c5oFhGS0WGKEB7soDf3Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="6529179"
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="6529179"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:04:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,157,1708416000"; 
   d="scan'208";a="20874305"
Received: from lkp-server01.sh.intel.com (HELO be39aa325d23) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 Mar 2024 20:04:11 -0700
Received: from kbuild by be39aa325d23 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rpJaD-0000gF-0P;
	Wed, 27 Mar 2024 03:04:09 +0000
Date: Wed, 27 Mar 2024 11:03:54 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 0f4a1e80989aca185d955fcd791d7750082044a2
Message-ID: <202403271150.n43xNT7B-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/urgent
branch HEAD: 0f4a1e80989aca185d955fcd791d7750082044a2  x86/sev: Skip ROM range scans and validation for SEV-SNP guests

elapsed time: 731m

configs tested: 29
configs skipped: 131

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240327   gcc  
i386         buildonly-randconfig-002-20240327   gcc  
i386         buildonly-randconfig-003-20240327   clang
i386         buildonly-randconfig-004-20240327   clang
i386         buildonly-randconfig-005-20240327   clang
i386         buildonly-randconfig-006-20240327   clang
i386                                defconfig   clang
i386                  randconfig-001-20240327   gcc  
i386                  randconfig-002-20240327   gcc  
i386                  randconfig-003-20240327   clang
i386                  randconfig-004-20240327   gcc  
i386                  randconfig-005-20240327   clang
i386                  randconfig-006-20240327   gcc  
i386                  randconfig-011-20240327   gcc  
i386                  randconfig-012-20240327   clang
i386                  randconfig-013-20240327   gcc  
i386                  randconfig-014-20240327   clang
i386                  randconfig-015-20240327   gcc  
i386                  randconfig-016-20240327   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240327   gcc  
x86_64       buildonly-randconfig-002-20240327   gcc  
x86_64       buildonly-randconfig-003-20240327   gcc  
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

