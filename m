Return-Path: <linux-kernel+bounces-34811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8CD8387C9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF701C23A56
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41851C2A;
	Tue, 23 Jan 2024 07:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CPz4gsQD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8C3611E
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705993587; cv=none; b=SIkCBb6cixR3P3IdD6Gqgje1PBxlvgLt7gRusKbpT9xpWRxykseuzsdMUbuFcQ99MrMrUtYZ1yaHiVfMdHGQltdqlbSES1xXiSsFnXjHnAljFRMMdpNTcVJjp4B0j3AH4BGdSCRIH1PN/XXu7nHor9yIaI7P3Qut4zDHJxDsW/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705993587; c=relaxed/simple;
	bh=hHkuAf4gZ7+6sCZ70cOeNF3q8dJ/UkJ1NOVeBhrhq54=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WKSnHyMkfVty+m3MK22nu6c4UK98LsQhxD1vLVKsfRHZT8QzT0uDUHPLbzWR/1rrxq0kR7vRMll24ejSCNj911/d+80xjvlO+R9Ao1yszhDjcXgmkaG74PWYVma5sgbROZ00dkvdWKETdHGUAdTDla3He0BstL2fdAwQkpEsBeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CPz4gsQD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705993586; x=1737529586;
  h=date:from:to:cc:subject:message-id;
  bh=hHkuAf4gZ7+6sCZ70cOeNF3q8dJ/UkJ1NOVeBhrhq54=;
  b=CPz4gsQDZFUk9FqSsTvlnws9FjWPwpzSXqrUmGOk3Vs4Xg0uDS+80ST4
   cctwmyTrxSiqrfxgWaFASHIoMm+FjUaBRhUmt354HG6+zGDiDXgYQM2Du
   B+rzs5ABLqrLp3dH5hG1UHUh/v41Sy+lEr+INbI7j5Zs3ZyLJOpfRljas
   vJUddbLIPhJFYdQrTEkAB0gpNjgApekN3M0G7FstS01eZ4aVzZBNZyJCk
   sgCauqkUWtkICS6/GOBHV0Fx95BRjtsDna4HLNfOEaC27ZQX2WkoZJbem
   px/vQw0B+LBA0lihDTSY6e49eK6LYgXV8SGaghg8PXWiU8PYNKhilqIOI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="1317777"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="1317777"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 23:06:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="819987473"
X-IronPort-AV: E=Sophos;i="6.05,213,1701158400"; 
   d="scan'208";a="819987473"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Jan 2024 23:06:24 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rSArV-0007F5-2c;
	Tue, 23 Jan 2024 07:06:21 +0000
Date: Tue, 23 Jan 2024 15:05:52 +0800
From: kernel test robot <lkp@intel.com>
To: "x86-ml" <x86@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [tip:x86/cpu] BUILD SUCCESS
 bbfc72531ee7ae1617b39869022ea28b9b6a1b36
Message-ID: <202401231550.3nm93tT3-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cpu
branch HEAD: bbfc72531ee7ae1617b39869022ea28b9b6a1b36  x86/CPU/AMD: Add X86_FEATURE_ZEN5

elapsed time: 1233m

configs tested: 26
configs skipped: 135

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240122   clang
i386         buildonly-randconfig-002-20240122   clang
i386         buildonly-randconfig-003-20240122   clang
i386         buildonly-randconfig-004-20240122   clang
i386         buildonly-randconfig-005-20240122   clang
i386         buildonly-randconfig-006-20240122   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240122   clang
i386                  randconfig-002-20240122   clang
i386                  randconfig-003-20240122   clang
i386                  randconfig-004-20240122   clang
i386                  randconfig-005-20240122   clang
i386                  randconfig-006-20240122   clang
i386                  randconfig-011-20240122   gcc  
i386                  randconfig-012-20240122   gcc  
i386                  randconfig-013-20240122   gcc  
i386                  randconfig-014-20240122   gcc  
i386                  randconfig-015-20240122   gcc  
i386                  randconfig-016-20240122   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

