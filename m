Return-Path: <linux-kernel+bounces-69670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29AF858D18
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E01BE284266
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 03:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96FF41BDF8;
	Sat, 17 Feb 2024 03:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjE0K6F/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9247D18E02
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708141934; cv=none; b=BIi7eQx+au2ZcCCu6fmyKsHDf8Vm/AvzUesWW32eHBEueNCFluMzKnmcA0F9Mmb2E/PcSzAv6XlmteftZKZZO3rvTIaAaBl48DEu3QC4gb7nPX6UW4XnVTwyZ8Ylz6sUU6cRuUkLKzlwbiOnoUwDxxJ1Ryxnw0vekvOIQGyyh7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708141934; c=relaxed/simple;
	bh=m021ERTraAWTtmZ+DU9AgfNBLsbQXU7DGNlg/blXUt0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=lqWNWqqMb5anjqt9NM0Iwpn/1NXXnfyK3403b4WOjBeFbJdk3F7QB+SZrMJuDkgEN7IChMRzBE9zyRrdrFrpw6NUy6nDBBeo1GJ5NpU3hTYgH9to7VjTS2CjVwQhkQtweSbdEVE9RV+Ysgzs6wsGSXTrjKWrXTNRYvPdU6cKF8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjE0K6F/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708141932; x=1739677932;
  h=date:from:to:cc:subject:message-id;
  bh=m021ERTraAWTtmZ+DU9AgfNBLsbQXU7DGNlg/blXUt0=;
  b=OjE0K6F/ZUdy9zhfv5lsroLnvE0ihAqStAD9ETjuV1no1qtI5oiCtxtN
   11BqrnA+0o1Y8fh9g7hHTupWi4/8utdwwA0PvF6foPxyiwUc0KxU5WtZz
   xenKlUaAGkhWH3fWZV7Ujyt+hUab0/5PRKAWQc9xgKovJo8lLohdWW7Qu
   n973n+W49ehSsw5DeGqEKjOSaGugniaXDStNmCM5+CmdM4Dl5+I+FbIxL
   UquO54l7oDW+eBydI6HqA5TfCl8VIGOEyvWeb239csYCnjEBELnvDBFg3
   IwNb/xmjCIgzpb6ldr/hBcPSynYNeRD8ST/Z1I4lpiewbQcG7lt795FQj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="12910093"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="12910093"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 19:52:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="8676861"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 16 Feb 2024 19:52:09 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rbBkE-0001oS-0C;
	Sat, 17 Feb 2024 03:52:06 +0000
Date: Sat, 17 Feb 2024 11:51:32 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215] BUILD REGRESSION
 7a19cfa6c1665cd2b4a34d4504e23d2ee68b87b2
Message-ID: <202402171128.IZ7WQkKg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
branch HEAD: 7a19cfa6c1665cd2b4a34d4504e23d2ee68b87b2  treewide: Address -Wflexible-array-member-not-at-end warnings

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402170111.jekyERfk-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/um/drivers/virt-pci.c:285:38: error: passing argument 2 of 'um_pci_send_cmd' from incompatible pointer type [-Werror=incompatible-pointer-types]
include/asm-generic/tlb.h:246:44: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/bpf.h:1963:42: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/cgroup-defs.h:398:34: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/fs.h:1042:39: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties
include/linux/perf_event.h:124:45: error: '__section__' attribute only applies to functions, global variables, Objective-C methods, and Objective-C properties

Error/Warning ids grouped by kconfigs:

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
|-- arc-nsimosci_hs_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arc-randconfig-r061-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-allmodconfig
|   |-- include-asm-generic-tlb.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-asm-generic-tlb.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-perf_event.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-perf_event.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-types.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-types.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-uapi-linux-stddef.h:warning:declaration-does-not-declare-anything
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-allyesconfig
|   |-- include-asm-generic-tlb.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-asm-generic-tlb.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-perf_event.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-perf_event.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-types.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-types.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-uapi-linux-stddef.h:warning:declaration-does-not-declare-anything
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm-randconfig-003-20240216
|   |-- include-asm-generic-tlb.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-asm-generic-tlb.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-perf_event.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-perf_event.h:warning:used-attribute-does-not-apply-to-types
|   `-- include-uapi-linux-stddef.h:warning:declaration-does-not-declare-anything
|-- arm-s5pv210_defconfig
|   |-- include-asm-generic-tlb.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-asm-generic-tlb.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:section-attribute-does-not-apply-to-types
|   |-- include-linux-cgroup-defs.h:warning:used-attribute-does-not-apply-to-types
|   |-- include-uapi-linux-stddef.h:warning:declaration-does-not-declare-anything
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- arm64-randconfig-004-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-randconfig-r053-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- csky-randconfig-r064-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-buildonly-randconfig-004-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-buildonly-randconfig-005-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-003-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-005-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-011-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-012-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-013-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-015-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-016-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-051-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- i386-randconfig-141-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- loongarch-randconfig-002-20240216
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
|-- mips-bmips_be_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-decstation_64_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-ip27_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- mips-maltaup_xpa_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- nios2-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- openrisc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- openrisc-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- openrisc-randconfig-r052-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- parisc64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-ppa8548_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc-tqm5200_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- powerpc64-randconfig-003-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- riscv-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- s390-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- s390-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- s390-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-randconfig-r063-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-sdk7780_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sh-shmin_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- sparc64-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- um-allyesconfig
|   |-- arch-um-drivers-virt-pci.c:error:passing-argument-of-um_pci_send_cmd-from-incompatible-pointer-type
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- um-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- um-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-003-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-004-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-005-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-011-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-012-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-014-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-073-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-074-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-076-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-101-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
|-- x86_64-randconfig-104-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
`-- x86_64-randconfig-161-20240217
    `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-lacks-a-cast
clang_recent_errors
|-- arm-defconfig
|   |-- include-asm-generic-tlb.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-asm-generic-tlb.h:warning:__used__-attribute-only-applies-to-variables-with-non-local-storage-functions-and-Objective-C-methods
|   |-- include-asm-generic-tlb.h:warning:declaration-does-not-declare-anything
|   |-- include-linux-bpf.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-bpf.h:warning:__used__-attribute-only-applies-to-variables-with-non-local-storage-functions-and-Objective-C-methods
|   |-- include-linux-bpf.h:warning:declaration-does-not-declare-anything
|   |-- include-linux-cgroup-defs.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-cgroup-defs.h:warning:__used__-attribute-only-applies-to-variables-with-non-local-storage-functions-and-Objective-C-methods
|   |-- include-linux-cgroup-defs.h:warning:declaration-does-not-declare-anything
|   |-- include-linux-fs.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-perf_event.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-linux-perf_event.h:warning:__used__-attribute-only-applies-to-variables-with-non-local-storage-functions-and-Objective-C-methods
|   |-- include-linux-perf_event.h:warning:declaration-does-not-declare-anything
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- arm-pxa168_defconfig
|   |-- include-asm-generic-tlb.h:error:__section__-attribute-only-applies-to-functions-global-variables-Objective-C-methods-and-Objective-C-properties
|   |-- include-asm-generic-tlb.h:warning:__used__-attribute-only-applies-to-variables-with-non-local-storage-functions-and-Objective-C-methods
|   |-- include-asm-generic-tlb.h:warning:declaration-does-not-declare-anything
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- arm-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- arm64-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- arm64-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- arm64-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- arm64-randconfig-003-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- hexagon-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- hexagon-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- hexagon-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- hexagon-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- hexagon-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-buildonly-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-buildonly-randconfig-003-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-buildonly-randconfig-006-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-004-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-006-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-014-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-052-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-053-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- i386-randconfig-054-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- powerpc-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- powerpc-chrp32_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- powerpc-cm5200_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- powerpc-pasemi_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- powerpc-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- powerpc-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- powerpc-randconfig-003-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- riscv-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- riscv-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- riscv-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- riscv-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- s390-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- s390-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- s390-randconfig-r051-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- um-allmodconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- um-allnoconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- um-defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- um-x86_64_defconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-allyesconfig
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-buildonly-randconfig-001-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-buildonly-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-buildonly-randconfig-003-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-buildonly-randconfig-004-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-buildonly-randconfig-006-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-002-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-006-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-013-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-015-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-016-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-071-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-072-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-075-20240216
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-102-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
|-- x86_64-randconfig-103-20240217
|   `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)
`-- x86_64-rhel-8.3-rust
    `-- kernel-bpf-core.c:warning:comparison-of-distinct-pointer-types-(-struct-bpf_prog_array-and-struct-bpf_prog_array_tag-)

elapsed time: 1456m

configs tested: 179
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20240216   gcc  
arc                   randconfig-002-20240216   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240216   clang
arm                   randconfig-002-20240216   clang
arm                   randconfig-003-20240216   gcc  
arm                   randconfig-004-20240216   gcc  
arm                         s5pv210_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240216   clang
arm64                 randconfig-002-20240216   gcc  
arm64                 randconfig-003-20240216   clang
arm64                 randconfig-004-20240216   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240216   gcc  
csky                  randconfig-002-20240216   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240216   clang
hexagon               randconfig-002-20240216   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240216   gcc  
i386         buildonly-randconfig-002-20240216   clang
i386         buildonly-randconfig-003-20240216   clang
i386         buildonly-randconfig-004-20240216   gcc  
i386         buildonly-randconfig-005-20240216   gcc  
i386         buildonly-randconfig-006-20240216   clang
i386                                defconfig   clang
i386                  randconfig-001-20240216   clang
i386                  randconfig-002-20240216   clang
i386                  randconfig-003-20240216   gcc  
i386                  randconfig-004-20240216   clang
i386                  randconfig-005-20240216   gcc  
i386                  randconfig-006-20240216   clang
i386                  randconfig-011-20240216   gcc  
i386                  randconfig-012-20240216   gcc  
i386                  randconfig-013-20240216   gcc  
i386                  randconfig-014-20240216   clang
i386                  randconfig-015-20240216   gcc  
i386                  randconfig-016-20240216   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240216   gcc  
loongarch             randconfig-002-20240216   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                    maltaup_xpa_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240216   gcc  
nios2                 randconfig-002-20240216   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240216   gcc  
parisc                randconfig-002-20240216   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      chrp32_defconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                      pasemi_defconfig   clang
powerpc                     ppa8548_defconfig   gcc  
powerpc               randconfig-001-20240216   clang
powerpc               randconfig-002-20240216   clang
powerpc               randconfig-003-20240216   clang
powerpc                     stx_gp3_defconfig   clang
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-001-20240216   clang
powerpc64             randconfig-002-20240216   clang
powerpc64             randconfig-003-20240216   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240216   gcc  
riscv                 randconfig-002-20240216   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240216   gcc  
s390                  randconfig-002-20240216   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                    randconfig-001-20240216   gcc  
sh                    randconfig-002-20240216   gcc  
sh                          sdk7780_defconfig   gcc  
sh                            shmin_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240216   gcc  
sparc64               randconfig-002-20240216   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240216   gcc  
um                    randconfig-002-20240216   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240216   clang
x86_64       buildonly-randconfig-002-20240216   clang
x86_64       buildonly-randconfig-003-20240216   clang
x86_64       buildonly-randconfig-004-20240216   clang
x86_64       buildonly-randconfig-005-20240216   gcc  
x86_64       buildonly-randconfig-006-20240216   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240216   gcc  
x86_64                randconfig-002-20240216   clang
x86_64                randconfig-003-20240216   gcc  
x86_64                randconfig-004-20240216   gcc  
x86_64                randconfig-005-20240216   gcc  
x86_64                randconfig-006-20240216   clang
x86_64                randconfig-011-20240216   gcc  
x86_64                randconfig-012-20240216   gcc  
x86_64                randconfig-013-20240216   clang
x86_64                randconfig-014-20240216   gcc  
x86_64                randconfig-015-20240216   clang
x86_64                randconfig-016-20240216   clang
x86_64                randconfig-071-20240216   clang
x86_64                randconfig-072-20240216   clang
x86_64                randconfig-073-20240216   gcc  
x86_64                randconfig-074-20240216   gcc  
x86_64                randconfig-075-20240216   clang
x86_64                randconfig-076-20240216   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240216   gcc  
xtensa                randconfig-002-20240216   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

