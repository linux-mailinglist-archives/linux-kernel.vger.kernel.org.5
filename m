Return-Path: <linux-kernel+bounces-75808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B9E85EF4E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D7D3B236EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 02:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA58614A94;
	Thu, 22 Feb 2024 02:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oG9VDKTQ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE5012E4A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708570483; cv=none; b=AOfOADj9Wyf1MWXgVOXu4KjHhTCuDpcmZmB04mvnOV8jP+jDPM1wywLwr6+IvTG/qQYrifjocCZqTWDYuYi2NOkMObxRLNSw9l3DHrTPckNE6lBZKP31YliFgX0KGAHSVXC0Uztz3Vfkpx6SfF8BANEPnqZwU2Szs1/AynTcJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708570483; c=relaxed/simple;
	bh=b58XkQy6g0dg+CVt+U6m2c2JXFmj802/lw5QCdHqoYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=E5gOjgZzuTYY7zZczJfeJMR8JNd1bQZ7hmk/ylXTApYYFGdjnY1Cg7l2xONtq73PlJYdvYRy6GrQYsM46EmOJZNyrlJzrh+3YXNS0wIt5VHGAwlXw0xe/GyScCwVu+S8WoSNoNGYCaAXsgEuZa2IeK7cOuIqxFC6KlyzM5xGIAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oG9VDKTQ; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708570481; x=1740106481;
  h=date:from:to:cc:subject:message-id;
  bh=b58XkQy6g0dg+CVt+U6m2c2JXFmj802/lw5QCdHqoYM=;
  b=oG9VDKTQ7Uro36prlkqdPvfAZGZZz4V9UIj84Mah3on2p4KkgZsBZOfu
   XwrXNjTx+TYZDGMuvTrRvLefZfestp7GBIftWmWLDBSdpx9PuOG7weR+9
   5dMZRxPdFT4t/AHDl0oCjebQxOfy/5lF6HB9oWZbUkSzW7A2nwiFJnpl1
   3TaCzkYyj3/Cljs+f8Kf2RBeDfw+muULMetRpQxl4NVW46rPvpZGOlHon
   JVAs0pip37Sm6RPP5jS9wLd38ELMgbGPRyZ8bBrtGmn1PInDpY4Yb5yZY
   4yzSloNql82NmV4N5CKnjdEN2Io3HQpfAkuNahBULBfR+EFLendO79DYC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="6547842"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="6547842"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:54:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28484018"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa002.fm.intel.com with ESMTP; 21 Feb 2024 18:54:36 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rczE1-0005vO-2X;
	Thu, 22 Feb 2024 02:54:24 +0000
Date: Thu, 22 Feb 2024 10:52:51 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215] BUILD SUCCESS
 48d8a8892c4c2e993764b958955f93785d762ce9
Message-ID: <202402221048.VopBXvHc-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
branch HEAD: 48d8a8892c4c2e993764b958955f93785d762ce9  treewide: Address -Wflexible-array-member-not-at-end warnings

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- alpha-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-randconfig-003-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-randconfig-003-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-randconfig-004-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-buildonly-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-buildonly-randconfig-004-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-buildonly-randconfig-005-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-buildonly-randconfig-006-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-004-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-005-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-011-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-013-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-015-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- m68k-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- m68k-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- m68k-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- microblaze-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- microblaze-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- microblaze-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- openrisc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- openrisc-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-randconfig-003-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc64-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- riscv-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- s390-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- um-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- um-i386_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- um-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-buildonly-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-003-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-004-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-005-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-006-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-012-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-014-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-015-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-016-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-071-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-072-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-073-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-074-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-076-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- xtensa-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
`-- xtensa-randconfig-002-20240221
    `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
clang_recent_errors
|-- arm-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- arm-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- arm-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- arm-randconfig-004-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- arm64-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- hexagon-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- hexagon-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- hexagon-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- hexagon-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-randconfig-002-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-randconfig-003-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-randconfig-006-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-randconfig-012-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-randconfig-014-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- i386-randconfig-016-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- powerpc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- riscv-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- riscv-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- riscv-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- s390-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- s390-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- s390-randconfig-001-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- um-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- um-allnoconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- um-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- um-x86_64_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-buildonly-randconfig-004-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-buildonly-randconfig-005-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-buildonly-randconfig-006-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-randconfig-011-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-randconfig-013-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
|-- x86_64-randconfig-075-20240221
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)
`-- x86_64-rhel-8.3-rust
    `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_hdr-)

elapsed time: 1404m

configs tested: 163
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240221   gcc  
arc                   randconfig-002-20240221   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240221   clang
arm                   randconfig-002-20240221   clang
arm                   randconfig-003-20240221   gcc  
arm                   randconfig-004-20240221   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240221   gcc  
arm64                 randconfig-002-20240221   gcc  
arm64                 randconfig-003-20240221   gcc  
arm64                 randconfig-004-20240221   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240221   gcc  
csky                  randconfig-002-20240221   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240221   clang
hexagon               randconfig-002-20240221   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240221   gcc  
i386         buildonly-randconfig-002-20240221   clang
i386         buildonly-randconfig-003-20240221   gcc  
i386         buildonly-randconfig-004-20240221   gcc  
i386         buildonly-randconfig-005-20240221   gcc  
i386         buildonly-randconfig-006-20240221   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240221   gcc  
i386                  randconfig-002-20240221   clang
i386                  randconfig-003-20240221   clang
i386                  randconfig-004-20240221   gcc  
i386                  randconfig-005-20240221   gcc  
i386                  randconfig-006-20240221   clang
i386                  randconfig-011-20240221   gcc  
i386                  randconfig-012-20240221   clang
i386                  randconfig-013-20240221   gcc  
i386                  randconfig-014-20240221   clang
i386                  randconfig-015-20240221   gcc  
i386                  randconfig-016-20240221   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240221   gcc  
loongarch             randconfig-002-20240221   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240221   gcc  
nios2                 randconfig-002-20240221   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240221   gcc  
parisc                randconfig-002-20240221   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240221   gcc  
powerpc               randconfig-002-20240221   gcc  
powerpc               randconfig-003-20240221   gcc  
powerpc64             randconfig-001-20240221   gcc  
powerpc64             randconfig-002-20240221   gcc  
powerpc64             randconfig-003-20240221   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240221   clang
riscv                 randconfig-002-20240221   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240221   clang
s390                  randconfig-002-20240221   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240221   gcc  
sh                    randconfig-002-20240221   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240221   gcc  
sparc64               randconfig-002-20240221   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240221   gcc  
um                    randconfig-002-20240221   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240221   clang
x86_64       buildonly-randconfig-002-20240221   gcc  
x86_64       buildonly-randconfig-003-20240221   gcc  
x86_64       buildonly-randconfig-004-20240221   clang
x86_64       buildonly-randconfig-005-20240221   clang
x86_64       buildonly-randconfig-006-20240221   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240221   gcc  
x86_64                randconfig-002-20240221   gcc  
x86_64                randconfig-003-20240221   gcc  
x86_64                randconfig-004-20240221   gcc  
x86_64                randconfig-005-20240221   gcc  
x86_64                randconfig-006-20240221   gcc  
x86_64                randconfig-011-20240221   clang
x86_64                randconfig-012-20240221   gcc  
x86_64                randconfig-013-20240221   clang
x86_64                randconfig-014-20240221   gcc  
x86_64                randconfig-015-20240221   gcc  
x86_64                randconfig-016-20240221   gcc  
x86_64                randconfig-071-20240221   gcc  
x86_64                randconfig-072-20240221   gcc  
x86_64                randconfig-073-20240221   gcc  
x86_64                randconfig-074-20240221   gcc  
x86_64                randconfig-075-20240221   clang
x86_64                randconfig-076-20240221   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240221   gcc  
xtensa                randconfig-002-20240221   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

