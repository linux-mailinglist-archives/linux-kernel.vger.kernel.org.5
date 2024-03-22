Return-Path: <linux-kernel+bounces-112115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3B48875E3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 00:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B980F284CAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3F182C71;
	Fri, 22 Mar 2024 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+96oimK"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F437F7C0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 23:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711151205; cv=none; b=W1dkKKA89CyJb/klABBHmz0L82PdhB5zMBNmuIJpMpDpxhTC3AGEvGQBiGZ/ktlPD8eO+McFebiliBM4OXrk2hWyiNFDLI67OkmWN5msHvqaxL8DKhJ7rX2dHDgTfKRI6XJKvO/0gms0LboB+H22ue/S/x7f+2+D9D4Oai7p19w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711151205; c=relaxed/simple;
	bh=0dQRgUKG2KrM0H8KRCUZ8Adhw2NOh+un1/+cJjmT7gY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=kioIYMGMSxp+SPahwtXzw1IgsOO0cFlr78IB6EF7mAYs6DENabFes1BFMEd4sQLbb5nZvEBdT1E8ldDIsqC9zJwLqCYpLSTwNbGXCO4dSmTwjqLDCzsXzBV8C0cPBf0J9HQPHogGj/iEkPM/zBUY0mEJFDvkJUHphSwNLFeGuvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+96oimK; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711151204; x=1742687204;
  h=date:from:to:cc:subject:message-id;
  bh=0dQRgUKG2KrM0H8KRCUZ8Adhw2NOh+un1/+cJjmT7gY=;
  b=J+96oimKKHLohgW4S+tz+sC0mFWa0BT9MBZ2gPe2ysqWrb2q26TMuiIh
   gIqDi6AstYiXJYpq2vf+qskSWIGfVcTDMJtFe5gGP99e178kUtH4dCGkj
   KWSisSPO1p14qZB7UuSt69zNAiI1ktQr0iJVXOkMSF+R30JwMSYTdro8c
   Rp0Raw4OxscoekyygC07h/0AqncBBmt6clkkr4S4LrhZA+BP7F9zYlksk
   bciKfPdVhdtkPzobCxuVvrcjGmWYpHIpw8w4+WdKdAl6oSRVUEEd+jgUy
   oJw6r0GRCwsCELzYbpC8Qh/B5G97ilB5l/ml3ElWbVTSLftMVCb9Bpe4M
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="17611725"
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="17611725"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 16:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,147,1708416000"; 
   d="scan'208";a="46052876"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 22 Mar 2024 16:46:42 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rnoat-000Khq-1U;
	Fri, 22 Mar 2024 23:46:39 +0000
Date: Sat, 23 Mar 2024 07:46:35 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cleanups] BUILD SUCCESS
 3c41786cab885f9c542e89f624bcdb71187dbb75
Message-ID: <202403230732.OiFyVkSj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cleanups
branch HEAD: 3c41786cab885f9c542e89f624bcdb71187dbb75  x86/fred: Fix typo in Kconfig description

elapsed time: 736m

configs tested: 26
configs skipped: 134

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240322   gcc  
i386         buildonly-randconfig-002-20240322   gcc  
i386         buildonly-randconfig-003-20240322   clang
i386         buildonly-randconfig-004-20240322   clang
i386         buildonly-randconfig-005-20240322   gcc  
i386         buildonly-randconfig-006-20240322   clang
i386                                defconfig   clang
i386                  randconfig-001-20240322   clang
i386                  randconfig-002-20240322   clang
i386                  randconfig-003-20240322   gcc  
i386                  randconfig-004-20240322   gcc  
i386                  randconfig-005-20240322   clang
i386                  randconfig-006-20240322   clang
i386                  randconfig-011-20240322   gcc  
i386                  randconfig-012-20240322   clang
i386                  randconfig-013-20240322   clang
i386                  randconfig-014-20240322   clang
i386                  randconfig-015-20240322   gcc  
i386                  randconfig-016-20240322   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

