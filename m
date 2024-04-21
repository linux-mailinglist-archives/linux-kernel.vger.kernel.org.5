Return-Path: <linux-kernel+bounces-152459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0578ABEC3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 10:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 630931C2085A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 08:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3459EDDBE;
	Sun, 21 Apr 2024 08:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rnwgejht"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348DD29B
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713687046; cv=none; b=uVgJVrP2HQuyLnAo58i5a+CJ61jW1R49LVf1XYWnDgKXnQd45kcTRns0YLOlfskUbyBYRejt6K1KRkUqHzB+7biLsSn1dokECfdhvw/Rsegs/wjxVQbngRwaQlxh74kaiRZ94BvyOeIFmDhoEinGwGy+LrGnk1vzpaNbvNtL9qY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713687046; c=relaxed/simple;
	bh=9YqIovk5vKDD41bcj6PG5vBXG+7i2PLto4+FhfMONDs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ECIOXDUYzvE8odG+pWcPAIJ7YJLbJO9vq80k/3a1xSN3PudbhqcQr7KRlMMR9E/Wv31ek5gZ3LVKtIHJV/eafPrrW2mda9Urg6lK5lp1mEXglOhJkHRBuB22wxfzol4z53KW6cOheSprjX0tF+1brOJEX1EvzmGfwPcRCzxrMsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rnwgejht; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713687044; x=1745223044;
  h=date:from:to:cc:subject:message-id;
  bh=9YqIovk5vKDD41bcj6PG5vBXG+7i2PLto4+FhfMONDs=;
  b=RnwgejhtQ6B9K+BbFd2HUqWKZBksXFq8j9rM2bSa7w4eC9PMr7BM+6wJ
   Wdkmx4ePCPsxRxp1ecAXaao5YTZYA3RqI6uFsD3mSudZN8dozkA7oZHBM
   L/8ak2pFsIJrdjliVM9dId6Bllbw+08LU2u4DFlbk6/4CvsAB8Pyagg3R
   /m7GMs0+oeSyPq5JdiJEgfotDZGg6ykUI9Hp7fIdxWlikhrP8G3oYty3A
   YTq6+XY3g96GpSuD6DHW/SnlkL682FFvE0mUH8rrqE+JRsr3YmIzLmvrs
   AICrNSqUsu6Ku5vcOyf8TvJ0lnnCBXMnZJb9Xd7hwTeiKxIPdfLT4+/Wc
   A==;
X-CSE-ConnectionGUID: SXWcK+fFRoGVgnTyz9LBZQ==
X-CSE-MsgGUID: OkK2TPHPQt+dE5KJ4D4KzA==
X-IronPort-AV: E=McAfee;i="6600,9927,11050"; a="19794532"
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="19794532"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2024 01:10:43 -0700
X-CSE-ConnectionGUID: 6eHXwtWqRiuiRblKbrjO6Q==
X-CSE-MsgGUID: rnU1uU5dQ/ymDXhfvMrxwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,217,1708416000"; 
   d="scan'208";a="28512488"
Received: from unknown (HELO 23c141fc0fd8) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 21 Apr 2024 01:10:42 -0700
Received: from kbuild by 23c141fc0fd8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rySHX-000Bo8-2i;
	Sun, 21 Apr 2024 08:10:39 +0000
Date: Sun, 21 Apr 2024 16:10:17 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/build] BUILD SUCCESS
 cba786af84a0f9716204e09f518ce3b7ada8555e
Message-ID: <202404211613.Mkl15AN6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/build
branch HEAD: cba786af84a0f9716204e09f518ce3b7ada8555e  x86/purgatory: Switch to the position-independent small code model

elapsed time: 722m

configs tested: 50
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240421   clang
i386         buildonly-randconfig-002-20240421   clang
i386         buildonly-randconfig-003-20240421   clang
i386         buildonly-randconfig-004-20240421   gcc  
i386         buildonly-randconfig-005-20240421   clang
i386         buildonly-randconfig-006-20240421   clang
i386                                defconfig   clang
i386                  randconfig-001-20240421   clang
i386                  randconfig-002-20240421   clang
i386                  randconfig-003-20240421   gcc  
i386                  randconfig-004-20240421   clang
i386                  randconfig-005-20240421   clang
i386                  randconfig-006-20240421   clang
i386                  randconfig-011-20240421   clang
i386                  randconfig-012-20240421   gcc  
i386                  randconfig-013-20240421   gcc  
i386                  randconfig-014-20240421   clang
i386                  randconfig-015-20240421   gcc  
i386                  randconfig-016-20240421   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240421   clang
x86_64       buildonly-randconfig-002-20240421   clang
x86_64       buildonly-randconfig-003-20240421   gcc  
x86_64       buildonly-randconfig-004-20240421   clang
x86_64       buildonly-randconfig-005-20240421   clang
x86_64       buildonly-randconfig-006-20240421   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240421   gcc  
x86_64                randconfig-002-20240421   clang
x86_64                randconfig-003-20240421   gcc  
x86_64                randconfig-004-20240421   clang
x86_64                randconfig-005-20240421   gcc  
x86_64                randconfig-006-20240421   gcc  
x86_64                randconfig-011-20240421   clang
x86_64                randconfig-012-20240421   clang
x86_64                randconfig-013-20240421   clang
x86_64                randconfig-014-20240421   gcc  
x86_64                randconfig-015-20240421   clang
x86_64                randconfig-016-20240421   clang
x86_64                randconfig-071-20240421   clang
x86_64                randconfig-072-20240421   clang
x86_64                randconfig-073-20240421   clang
x86_64                randconfig-074-20240421   clang
x86_64                randconfig-075-20240421   gcc  
x86_64                randconfig-076-20240421   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

