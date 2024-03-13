Return-Path: <linux-kernel+bounces-101635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFB87A9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2768D1F224BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788564A12;
	Wed, 13 Mar 2024 14:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW44QuMN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505F723C9
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341097; cv=none; b=VBsjq1K/4Wph9zDlzl5T3Zflfnp7CvL4VAidpeGec7XEvuMpwgHpM6tzOgdIpPfJ9WOnTAPFt5WUeePa3AdFJ6cMN7wh7A+gsddmfZOUUk7n/zf3S/whrXJAr6JkQ1Wgk995qtbkgWAP7gUTsxvzfrhR/j64ofe05FnZSr/VZi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341097; c=relaxed/simple;
	bh=Xsrb7gfqF0E19x/tTdxxttHy0VhJ5DUY6AoitKSvVSU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Asl/uuVgWu9mqx5ud+e6BCe+fiCzNKxfEOUX6ZnaR6zCwnmZXAt+miTpAmxFetCo1FkEvPIukedBaQbZ7ULBSUcEnFpxCOtPvhw+jrVI4W+LXM7gljtOxPmBNDov8bao1zwruDrEqdzwjrkB1Yc/Za52Q1nOE+wPkxOk6TOGNg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW44QuMN; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710341095; x=1741877095;
  h=date:from:to:cc:subject:message-id;
  bh=Xsrb7gfqF0E19x/tTdxxttHy0VhJ5DUY6AoitKSvVSU=;
  b=OW44QuMNxjNjp8csfnhRwWPmMByq0alLuD7osEvGc9lrKYd7xnFXOB3Q
   +SMP0Fofb6mYMJ1VuinnyocRCwJTCWedNYZ+anC0i+Fd5bU40A8uvjAdF
   N80Cimhjvb3rnJHaVzPcZm+6r4D6kS0F8MYiD0W6uyuX71Bx3HHrJkk6K
   HTkjBSNadh/tJtxFdyAYFKlxztnuz8xxL8lgqbYvC396jvujHmBs1nkcP
   yLGyLw3uWEaZkJPBXnxHZxSChPbAcQSDOEdWDvRVn4Y0dFi8KGLBCeX5Y
   KUY/W1fCdYgnP32T4IUAk0Fak4iLjjhScu+zYZOADu3l8pR55oBQ95dZ+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8881540"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="8881540"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:44:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="49373998"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 13 Mar 2024 07:44:52 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkPqb-000CRz-1G;
	Wed, 13 Mar 2024 14:44:49 +0000
Date: Wed, 13 Mar 2024 22:43:52 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240312] BUILD REGRESSION
 33ee4d07d6d337670a64f9d41e14e7579cfa9015
Message-ID: <202403132246.u5d2X6Rf-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240312
branch HEAD: 33ee4d07d6d337670a64f9d41e14e7579cfa9015  treewide: avoid -Wfamnae warnings

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202403131429.n6mGhow1-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403131436.V9IBdFAo-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/auxdisplay/seg-led-gpio.c:47:2: error: incomplete definition of type 'struct cm_work'
drivers/auxdisplay/seg-led-gpio.c:47:2: error: member reference type 'void' is not a pointer
drivers/auxdisplay/seg-led-gpio.c:47:2: error: offsetof of incomplete type 'struct cm_work'
drivers/auxdisplay/seg-led-gpio.c:47:2: error: passing 'void' to parameter of incompatible type 'struct work_struct *'
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:7899:2: error: incomplete definition of type 'struct cm_work'
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:7899:2: error: member reference type 'void' is not a pointer
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:7899:2: error: offsetof of incomplete type 'struct cm_work'
drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c:7899:2: error: passing 'void' to parameter of incompatible type 'struct work_struct *'
drivers/platform/chrome/cros_ec_proto_test.c:1576:11: error: static assertion failed due to requirement '__builtin_types_compatible_p(struct cros_ec_command, struct cros_ec_command_hdr) || __builtin_types_compatible_p(struct cros_ec_command, void)': pointer type mismatch in container_of()
lib/crc-t10dif.c:75:13: error: no member named 'tfm' in 'struct shash_desc'
lib/crc64-rocksoft.c:69:13: error: no member named 'tfm' in 'struct shash_desc'

Error/Warning ids grouped by kconfigs:

clang_recent_errors
|-- arm64-allmodconfig
|   |-- drivers-platform-chrome-cros_ec_proto_test.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-cros_ec_command-struct-cros_ec_command_hdr)-__builtin_types_compatible
|   |-- lib-crc-t10dif.c:error:no-member-named-tfm-in-struct-shash_desc
|   `-- lib-crc64-rocksoft.c:error:no-member-named-tfm-in-struct-shash_desc
|-- hexagon-defconfig
|   `-- lib-crc-t10dif.c:error:no-member-named-tfm-in-struct-shash_desc
|-- i386-buildonly-randconfig-003-20240313
|   `-- lib-crc64-rocksoft.c:error:no-member-named-tfm-in-struct-shash_desc
|-- i386-randconfig-003-20240313
|   `-- drivers-platform-chrome-cros_ec_proto_test.c:error:static-assertion-failed-due-to-requirement-__builtin_types_compatible_p(struct-cros_ec_command-struct-cros_ec_command_hdr)-__builtin_types_compatible
|-- powerpc-allyesconfig
|   |-- lib-crc-t10dif.c:error:no-member-named-tfm-in-struct-shash_desc
|   `-- lib-crc64-rocksoft.c:error:no-member-named-tfm-in-struct-shash_desc
|-- riscv-allmodconfig
|   |-- lib-crc-t10dif.c:error:no-member-named-tfm-in-struct-shash_desc
|   `-- lib-crc64-rocksoft.c:error:no-member-named-tfm-in-struct-shash_desc
|-- riscv-allyesconfig
|   |-- lib-crc-t10dif.c:error:no-member-named-tfm-in-struct-shash_desc
|   `-- lib-crc64-rocksoft.c:error:no-member-named-tfm-in-struct-shash_desc
`-- x86_64-allyesconfig
    |-- drivers-auxdisplay-seg-led-gpio.c:error:incomplete-definition-of-type-struct-cm_work
    |-- drivers-auxdisplay-seg-led-gpio.c:error:member-reference-type-void-is-not-a-pointer
    |-- drivers-auxdisplay-seg-led-gpio.c:error:offsetof-of-incomplete-type-struct-cm_work
    |-- drivers-auxdisplay-seg-led-gpio.c:error:passing-void-to-parameter-of-incompatible-type-struct-work_struct
    |-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:error:incomplete-definition-of-type-struct-cm_work
    |-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:error:member-reference-type-void-is-not-a-pointer
    |-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:error:offsetof-of-incomplete-type-struct-cm_work
    `-- drivers-net-wireless-realtek-rtl8xxxu-rtl8xxxu_core.c:error:passing-void-to-parameter-of-incompatible-type-struct-work_struct

elapsed time: 726m

configs tested: 114
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                 nsimosci_hs_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                           u8500_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240313   gcc  
i386         buildonly-randconfig-002-20240313   gcc  
i386         buildonly-randconfig-003-20240313   clang
i386         buildonly-randconfig-004-20240313   clang
i386         buildonly-randconfig-005-20240313   clang
i386         buildonly-randconfig-006-20240313   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240313   clang
i386                  randconfig-002-20240313   clang
i386                  randconfig-003-20240313   clang
i386                  randconfig-004-20240313   gcc  
i386                  randconfig-005-20240313   gcc  
i386                  randconfig-006-20240313   clang
i386                  randconfig-011-20240313   gcc  
i386                  randconfig-012-20240313   clang
i386                  randconfig-013-20240313   gcc  
i386                  randconfig-014-20240313   gcc  
i386                  randconfig-015-20240313   clang
i386                  randconfig-016-20240313   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
mips                          ath25_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     asp8347_defconfig   clang
powerpc                 canyonlands_defconfig   clang
powerpc                      cm5200_defconfig   clang
powerpc                   currituck_defconfig   clang
powerpc                       eiger_defconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                     sequoia_defconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

