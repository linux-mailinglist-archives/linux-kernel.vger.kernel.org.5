Return-Path: <linux-kernel+bounces-80047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3F8862A1E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 680E01F21592
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F866101E6;
	Sun, 25 Feb 2024 11:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J6exCQdL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2971C2ED
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 11:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708861523; cv=none; b=f7F/+AIEOSSP/53mO7+YuwGTr+Q68X+CziitsRFz1hBBGShRBiUOhOxB3wvM/P1SWgmnkKw/tz8tpZ25M0I8BqCUbufdnj8HXn6miGkzflbqLlQpDag1/iub6CNYIhSJFBrWKfgSYSYwdqcsKWMUg41Svw3P8RYz8rd9dRGUAYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708861523; c=relaxed/simple;
	bh=gOZhPgC0V+pYzVMrEwaPhfJykj0gYCQdTnks0fedWTg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=VvRl8Lkqamdl+oMKRd0T6VwB8ZPVaUgueFfXNhwlGmKcOHHolaSbQIRUCv0ePVuppEUa5tRlxZ/WPSkRbqx7a80bsEJ/gj2/bOvRmiZOcxDeSFyNr6LL/GmRsRJW3JyLVJrRKssj3IOUiCYNTB3iTz4/bF6ykB6ifqSxqVtDbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J6exCQdL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708861521; x=1740397521;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gOZhPgC0V+pYzVMrEwaPhfJykj0gYCQdTnks0fedWTg=;
  b=J6exCQdLYfDzzNDm6g7Fr1y1RkdN+GsEKCVRXJQWVHlX7nGISrSvO5Vc
   AJLerFAr8TWTF1quCfh9mz6LbeFRkJ6Lue5H9WZEHkssxMlnUuqkA+BjE
   L9hmjfv/3nM9YMjAy+a2U8GcfDHqgtC9b7bsTgFf8xhoTPF9HbtU7ufaU
   Llichqa/bJJHVPQ+XvEk0K5Ui9HZryv40QHkWOxMkOLVVYsZt+GHUIbyG
   PqAcrP8BjqqxhFsqZtir340/BF4Bb3th8oNS1vYyDAmoR0RQU6V7b6lLy
   D5uSeelqDyKAiiCrpnfhjpz6eOoqpqHKUOGEVOXBIivtd5iQuF80Gl2d0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="20597687"
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="20597687"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 03:45:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,183,1705392000"; 
   d="scan'208";a="6730759"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 25 Feb 2024 03:45:19 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1reCwW-0009V6-0O;
	Sun, 25 Feb 2024 11:45:16 +0000
Date: Sun, 25 Feb 2024 19:44:39 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240223 1/1]
 drivers/scsi/megaraid/megaraid_sas_fp.c:103:29: error: 'struct
 MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
Message-ID: <202402251943.zGBJ7sEO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240223
head:   b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4
commit: b23fc9e6ff31f4ef9e8de5580963cf53579ef0d4 [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: i386-buildonly-randconfig-001-20240225 (https://download.01.org/0day-ci/archive/20240225/202402251943.zGBJ7sEO-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240225/202402251943.zGBJ7sEO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402251943.zGBJ7sEO-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdRaidGet':
>> drivers/scsi/megaraid/megaraid_sas_fp.c:103:29: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     103 |         return &map->raidMap.ldSpanMap[ld].ldRaid;
         |                             ^
>> drivers/scsi/megaraid/megaraid_sas_fp.c:101:37: warning: parameter 'ld' set but not used [-Wunused-but-set-parameter]
     101 | struct MR_LD_RAID *MR_LdRaidGet(u32 ld, struct MR_DRV_RAID_MAP_ALL *map)
         |                                 ~~~~^~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdSpanInfoGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:110:29: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     110 |         return &map->raidMap.ldSpanMap[ld].spanBlock[0];
         |                             ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:106:56: warning: parameter 'ld' set but not used [-Wunused-but-set-parameter]
     106 | static struct MR_SPAN_BLOCK_INFO *MR_LdSpanInfoGet(u32 ld,
         |                                                    ~~~~^~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdDataArmGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:115:28: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     115 |         return map->raidMap.ldSpanMap[ld].dataArmMap[armIdx];
         |                            ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:113:31: warning: parameter 'ld' set but not used [-Wunused-but-set-parameter]
     113 | static u8 MR_LdDataArmGet(u32 ld, u32 armIdx, struct MR_DRV_RAID_MAP_ALL *map)
         |                           ~~~~^~
>> drivers/scsi/megaraid/megaraid_sas_fp.c:113:39: warning: parameter 'armIdx' set but not used [-Wunused-but-set-parameter]
     113 | static u8 MR_LdDataArmGet(u32 ld, u32 armIdx, struct MR_DRV_RAID_MAP_ALL *map)
         |                                   ~~~~^~~~~~
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/x86/include/uapi/asm/byteorder.h:5,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/x86/include/asm/bitops.h:436,
                    from include/linux/bitops.h:68,
                    from include/linux/kernel.h:23,
                    from drivers/scsi/megaraid/megaraid_sas_fp.c:21:
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdSpanArrayGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:125:40: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     125 |         return le16_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].span.arrayRef);
         |                                        ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:125:16: note: in expansion of macro 'le16_to_cpu'
     125 |         return le16_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].span.arrayRef);
         |                ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c:123:27: warning: parameter 'ld' set but not used [-Wunused-but-set-parameter]
     123 | u16 MR_LdSpanArrayGet(u32 ld, u32 span, struct MR_DRV_RAID_MAP_ALL *map)
         |                       ~~~~^~
>> drivers/scsi/megaraid/megaraid_sas_fp.c:123:35: warning: parameter 'span' set but not used [-Wunused-but-set-parameter]
     123 | u16 MR_LdSpanArrayGet(u32 ld, u32 span, struct MR_DRV_RAID_MAP_ALL *map)
         |                               ~~~~^~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_GetLDTgtId':
   drivers/scsi/megaraid/megaraid_sas_fp.c:140:40: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     140 |         return le16_to_cpu(map->raidMap.ldSpanMap[ld].ldRaid.targetId);
         |                                        ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: in definition of macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:140:16: note: in expansion of macro 'le16_to_cpu'
     140 |         return le16_to_cpu(map->raidMap.ldSpanMap[ld].ldRaid.targetId);
         |                ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c:138:23: warning: parameter 'ld' set but not used [-Wunused-but-set-parameter]
     138 | u16 MR_GetLDTgtId(u32 ld, struct MR_DRV_RAID_MAP_ALL *map)
         |                   ~~~~^~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdSpanPtrGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:151:29: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     151 |         return &map->raidMap.ldSpanMap[ld].spanBlock[span].span;
         |                             ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:148:47: warning: parameter 'ld' set but not used [-Wunused-but-set-parameter]
     148 | static struct MR_LD_SPAN *MR_LdSpanPtrGet(u32 ld, u32 span,
         |                                           ~~~~^~
   drivers/scsi/megaraid/megaraid_sas_fp.c:148:55: warning: parameter 'span' set but not used [-Wunused-but-set-parameter]
     148 | static struct MR_LD_SPAN *MR_LdSpanPtrGet(u32 ld, u32 span,
         |                                                   ~~~~^~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_PopulateDrvRaidMap':
>> drivers/scsi/megaraid/megaraid_sas_fp.c:171:47: error: initialization of 'struct MR_DRV_RAID_MAP *' from incompatible pointer type 'struct MR_DRV_RAID_MAP_hdr *' [-Werror=incompatible-pointer-types]
     171 |         struct MR_DRV_RAID_MAP *pDrvRaidMap = &drv_map->raidMap;
         |                                               ^
>> drivers/scsi/megaraid/megaraid_sas_fp.c:272:28: error: assignment to 'struct MR_FW_RAID_MAP *' from incompatible pointer type 'struct MR_FW_RAID_MAP_hdr *' [-Werror=incompatible-pointer-types]
     272 |                 pFwRaidMap = &fw_map_old->raidMap;
         |                            ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_ValidateMapInfo':
>> drivers/scsi/megaraid/megaraid_sas_fp.c:319:21: error: assignment to 'struct MR_DRV_RAID_MAP *' from incompatible pointer type 'struct MR_DRV_RAID_MAP_hdr *' [-Werror=incompatible-pointer-types]
     319 |         pDrvRaidMap = &drv_map->raidMap;
         |                     ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'mr_spanset_get_span_block':
   drivers/scsi/megaraid/megaraid_sas_fp.c:443:53: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     443 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                                                     ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:443:29: note: in expansion of macro 'le32_to_cpu'
     443 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                             ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c:445:53: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     445 |                                 quad = &map->raidMap.ldSpanMap[ld].
         |                                                     ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'get_row_from_strip':
   drivers/scsi/megaraid/megaraid_sas_fp.c:510:53: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     510 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                                                     ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:510:29: note: in expansion of macro 'le32_to_cpu'
     510 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                             ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'get_strip_from_row':
   drivers/scsi/megaraid/megaraid_sas_fp.c:563:53: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     563 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                                                     ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:563:29: note: in expansion of macro 'le32_to_cpu'
     563 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                             ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c:565:53: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     565 |                                 quad = &map->raidMap.ldSpanMap[ld].
         |                                                     ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'get_arm_from_strip':
   drivers/scsi/megaraid/megaraid_sas_fp.c:626:53: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
     626 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                                                     ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:626:29: note: in expansion of macro 'le32_to_cpu'
     626 |                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                             ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'mr_update_span_set':
   drivers/scsi/megaraid/megaraid_sas_fp.c:1240:61: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
    1240 |                                 if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                                                             ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:1240:37: note: in expansion of macro 'le32_to_cpu'
    1240 |                                 if (le32_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].
         |                                     ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c:1245:53: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
    1245 |                                 quad = &map->raidMap.ldSpanMap[ld].
         |                                                     ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:1253:69: error: 'struct MR_DRV_RAID_MAP_hdr' has no member named 'ldSpanMap'
    1253 |                                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].
         |                                                                     ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: in definition of macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   drivers/scsi/megaraid/megaraid_sas_fp.c:1253:45: note: in expansion of macro 'le32_to_cpu'
    1253 |                                         if (le32_to_cpu(map->raidMap.ldSpanMap[ld].
         |                                             ^~~~~~~~~~~
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdRaidGet':
>> drivers/scsi/megaraid/megaraid_sas_fp.c:104:1: warning: control reaches end of non-void function [-Wreturn-type]
     104 | }
         | ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdSpanArrayGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:126:1: warning: control reaches end of non-void function [-Wreturn-type]
     126 | }
         | ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_GetLDTgtId':
   drivers/scsi/megaraid/megaraid_sas_fp.c:141:1: warning: control reaches end of non-void function [-Wreturn-type]
     141 | }
         | ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdSpanPtrGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:152:1: warning: control reaches end of non-void function [-Wreturn-type]
     152 | }
         | ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdSpanInfoGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:111:1: warning: control reaches end of non-void function [-Wreturn-type]
     111 | }
         | ^
   drivers/scsi/megaraid/megaraid_sas_fp.c: In function 'MR_LdDataArmGet':
   drivers/scsi/megaraid/megaraid_sas_fp.c:116:1: warning: control reaches end of non-void function [-Wreturn-type]
     116 | }
         | ^
   cc1: some warnings being treated as errors


vim +103 drivers/scsi/megaraid/megaraid_sas_fp.c

9c915a8c99bce6 Adam Radford               2010-12-21  100  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12 @101  struct MR_LD_RAID *MR_LdRaidGet(u32 ld, struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  102  {
9c915a8c99bce6 Adam Radford               2010-12-21 @103  	return &map->raidMap.ldSpanMap[ld].ldRaid;
9c915a8c99bce6 Adam Radford               2010-12-21 @104  }
9c915a8c99bce6 Adam Radford               2010-12-21  105  
9c915a8c99bce6 Adam Radford               2010-12-21  106  static struct MR_SPAN_BLOCK_INFO *MR_LdSpanInfoGet(u32 ld,
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  107  						   struct MR_DRV_RAID_MAP_ALL
9c915a8c99bce6 Adam Radford               2010-12-21  108  						   *map)
9c915a8c99bce6 Adam Radford               2010-12-21  109  {
9c915a8c99bce6 Adam Radford               2010-12-21  110  	return &map->raidMap.ldSpanMap[ld].spanBlock[0];
9c915a8c99bce6 Adam Radford               2010-12-21  111  }
9c915a8c99bce6 Adam Radford               2010-12-21  112  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12 @113  static u8 MR_LdDataArmGet(u32 ld, u32 armIdx, struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  114  {
9c915a8c99bce6 Adam Radford               2010-12-21 @115  	return map->raidMap.ldSpanMap[ld].dataArmMap[armIdx];
9c915a8c99bce6 Adam Radford               2010-12-21  116  }
9c915a8c99bce6 Adam Radford               2010-12-21  117  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  118  u16 MR_ArPdGet(u32 ar, u32 arm, struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  119  {
94cd65ddf4d70b Sumit.Saxena@lsi.com       2013-09-06  120  	return le16_to_cpu(map->raidMap.arMapInfo[ar].pd[arm]);
9c915a8c99bce6 Adam Radford               2010-12-21  121  }
9c915a8c99bce6 Adam Radford               2010-12-21  122  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12 @123  u16 MR_LdSpanArrayGet(u32 ld, u32 span, struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  124  {
94cd65ddf4d70b Sumit.Saxena@lsi.com       2013-09-06 @125  	return le16_to_cpu(map->raidMap.ldSpanMap[ld].spanBlock[span].span.arrayRef);
9c915a8c99bce6 Adam Radford               2010-12-21  126  }
9c915a8c99bce6 Adam Radford               2010-12-21  127  
9ab9ed38f6186c Christoph Hellwig          2015-04-23  128  __le16 MR_PdDevHandleGet(u32 pd, struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  129  {
9c915a8c99bce6 Adam Radford               2010-12-21  130  	return map->raidMap.devHndlInfo[pd].curDevHdl;
9c915a8c99bce6 Adam Radford               2010-12-21  131  }
9c915a8c99bce6 Adam Radford               2010-12-21  132  
33203bc4d61b33 Shivasharan S              2017-02-10  133  static u8 MR_PdInterfaceTypeGet(u32 pd, struct MR_DRV_RAID_MAP_ALL *map)
33203bc4d61b33 Shivasharan S              2017-02-10  134  {
33203bc4d61b33 Shivasharan S              2017-02-10  135  	return map->raidMap.devHndlInfo[pd].interfaceType;
33203bc4d61b33 Shivasharan S              2017-02-10  136  }
33203bc4d61b33 Shivasharan S              2017-02-10  137  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  138  u16 MR_GetLDTgtId(u32 ld, struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  139  {
be26374beff8b4 Sumit.Saxena@lsi.com       2014-02-12  140  	return le16_to_cpu(map->raidMap.ldSpanMap[ld].ldRaid.targetId);
9c915a8c99bce6 Adam Radford               2010-12-21  141  }
9c915a8c99bce6 Adam Radford               2010-12-21  142  
d2d0358bcd0913 Shivasharan S              2017-02-10  143  u16 MR_TargetIdToLdGet(u32 ldTgtId, struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  144  {
be26374beff8b4 Sumit.Saxena@lsi.com       2014-02-12  145  	return map->raidMap.ldTgtIdToLd[ldTgtId];
9c915a8c99bce6 Adam Radford               2010-12-21  146  }
9c915a8c99bce6 Adam Radford               2010-12-21  147  
9c915a8c99bce6 Adam Radford               2010-12-21 @148  static struct MR_LD_SPAN *MR_LdSpanPtrGet(u32 ld, u32 span,
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  149  					  struct MR_DRV_RAID_MAP_ALL *map)
9c915a8c99bce6 Adam Radford               2010-12-21  150  {
9c915a8c99bce6 Adam Radford               2010-12-21  151  	return &map->raidMap.ldSpanMap[ld].spanBlock[span].span;
9c915a8c99bce6 Adam Radford               2010-12-21  152  }
9c915a8c99bce6 Adam Radford               2010-12-21  153  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  154  /*
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  155   * This function will Populate Driver Map using firmware raid map
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  156   */
5f19f7c879c4aa Shivasharan S              2018-01-05  157  static int MR_PopulateDrvRaidMap(struct megasas_instance *instance, u64 map_id)
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  158  {
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  159  	struct fusion_context *fusion = instance->ctrl_context;
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  160  	struct MR_FW_RAID_MAP_ALL     *fw_map_old    = NULL;
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  161  	struct MR_FW_RAID_MAP         *pFwRaidMap    = NULL;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  162  	int i, j;
200aed582d6170 Sumit.Saxena@avagotech.com 2015-01-05  163  	u16 ld_count;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  164  	struct MR_FW_RAID_MAP_DYNAMIC *fw_map_dyn;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  165  	struct MR_FW_RAID_MAP_EXT *fw_map_ext;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  166  	struct MR_RAID_MAP_DESC_TABLE *desc_table;
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  167  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  168  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  169  	struct MR_DRV_RAID_MAP_ALL *drv_map =
5f19f7c879c4aa Shivasharan S              2018-01-05  170  			fusion->ld_drv_map[(map_id & 1)];
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12 @171  	struct MR_DRV_RAID_MAP *pDrvRaidMap = &drv_map->raidMap;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  172  	void *raid_map_data = NULL;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  173  
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  174  	memset(drv_map, 0, fusion->drv_map_sz);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  175  	memset(pDrvRaidMap->ldTgtIdToLd,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  176  	       0xff, (sizeof(u16) * MAX_LOGICAL_DRIVES_DYN));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  177  
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  178  	if (instance->max_raid_mapsize) {
5f19f7c879c4aa Shivasharan S              2018-01-05  179  		fw_map_dyn = fusion->ld_map[(map_id & 1)];
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  180  		desc_table =
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  181  		(struct MR_RAID_MAP_DESC_TABLE *)((void *)fw_map_dyn + le32_to_cpu(fw_map_dyn->desc_table_offset));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  182  		if (desc_table != fw_map_dyn->raid_map_desc_table)
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  183  			dev_dbg(&instance->pdev->dev, "offsets of desc table are not matching desc %p original %p\n",
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  184  				desc_table, fw_map_dyn->raid_map_desc_table);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  185  
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  186  		ld_count = (u16)le16_to_cpu(fw_map_dyn->ld_count);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  187  		pDrvRaidMap->ldCount = (__le16)cpu_to_le16(ld_count);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  188  		pDrvRaidMap->fpPdIoTimeoutSec =
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  189  			fw_map_dyn->fp_pd_io_timeout_sec;
a174118b7a97c5 Shivasharan S              2017-02-10  190  		pDrvRaidMap->totalSize =
a174118b7a97c5 Shivasharan S              2017-02-10  191  			cpu_to_le32(sizeof(struct MR_DRV_RAID_MAP_ALL));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  192  		/* point to actual data starting point*/
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  193  		raid_map_data = (void *)fw_map_dyn +
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  194  			le32_to_cpu(fw_map_dyn->desc_table_offset) +
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  195  			le32_to_cpu(fw_map_dyn->desc_table_size);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  196  
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  197  		for (i = 0; i < le32_to_cpu(fw_map_dyn->desc_table_num_elements); ++i) {
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  198  			switch (le32_to_cpu(desc_table->raid_map_desc_type)) {
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  199  			case RAID_MAP_DESC_TYPE_DEVHDL_INFO:
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  200  				fw_map_dyn->dev_hndl_info =
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  201  				(struct MR_DEV_HANDLE_INFO *)(raid_map_data + le32_to_cpu(desc_table->raid_map_desc_offset));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  202  				memcpy(pDrvRaidMap->devHndlInfo,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  203  					fw_map_dyn->dev_hndl_info,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  204  					sizeof(struct MR_DEV_HANDLE_INFO) *
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  205  					le32_to_cpu(desc_table->raid_map_desc_elements));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  206  			break;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  207  			case RAID_MAP_DESC_TYPE_TGTID_INFO:
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  208  				fw_map_dyn->ld_tgt_id_to_ld =
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  209  					(u16 *)(raid_map_data +
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  210  					le32_to_cpu(desc_table->raid_map_desc_offset));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  211  				for (j = 0; j < le32_to_cpu(desc_table->raid_map_desc_elements); j++) {
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  212  					pDrvRaidMap->ldTgtIdToLd[j] =
a174118b7a97c5 Shivasharan S              2017-02-10  213  						le16_to_cpu(fw_map_dyn->ld_tgt_id_to_ld[j]);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  214  				}
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  215  			break;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  216  			case RAID_MAP_DESC_TYPE_ARRAY_INFO:
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  217  				fw_map_dyn->ar_map_info =
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  218  					(struct MR_ARRAY_INFO *)
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  219  					(raid_map_data + le32_to_cpu(desc_table->raid_map_desc_offset));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  220  				memcpy(pDrvRaidMap->arMapInfo,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  221  				       fw_map_dyn->ar_map_info,
41064f1bf8886b Shivasharan S              2017-02-10  222  				       sizeof(struct MR_ARRAY_INFO) *
41064f1bf8886b Shivasharan S              2017-02-10  223  				       le32_to_cpu(desc_table->raid_map_desc_elements));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  224  			break;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  225  			case RAID_MAP_DESC_TYPE_SPAN_INFO:
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  226  				fw_map_dyn->ld_span_map =
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  227  					(struct MR_LD_SPAN_MAP *)
41064f1bf8886b Shivasharan S              2017-02-10  228  					(raid_map_data +
41064f1bf8886b Shivasharan S              2017-02-10  229  					le32_to_cpu(desc_table->raid_map_desc_offset));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  230  				memcpy(pDrvRaidMap->ldSpanMap,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  231  				       fw_map_dyn->ld_span_map,
41064f1bf8886b Shivasharan S              2017-02-10  232  				       sizeof(struct MR_LD_SPAN_MAP) *
41064f1bf8886b Shivasharan S              2017-02-10  233  				       le32_to_cpu(desc_table->raid_map_desc_elements));
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  234  			break;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  235  			default:
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  236  				dev_dbg(&instance->pdev->dev, "wrong number of desctableElements %d\n",
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  237  					fw_map_dyn->desc_table_num_elements);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  238  			}
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  239  			++desc_table;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  240  		}
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  241  
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  242  	} else if (instance->supportmax256vd) {
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  243  		fw_map_ext =
5f19f7c879c4aa Shivasharan S              2018-01-05  244  			(struct MR_FW_RAID_MAP_EXT *)fusion->ld_map[(map_id & 1)];
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  245  		ld_count = (u16)le16_to_cpu(fw_map_ext->ldCount);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  246  		if (ld_count > MAX_LOGICAL_DRIVES_EXT) {
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  247  			dev_dbg(&instance->pdev->dev, "megaraid_sas: LD count exposed in RAID map in not valid\n");
7ada701d0d5e5c Shivasharan S              2018-01-05  248  			return 1;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  249  		}
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  250  
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  251  		pDrvRaidMap->ldCount = (__le16)cpu_to_le16(ld_count);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  252  		pDrvRaidMap->fpPdIoTimeoutSec = fw_map_ext->fpPdIoTimeoutSec;
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  253  		for (i = 0; i < (MAX_LOGICAL_DRIVES_EXT); i++)
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  254  			pDrvRaidMap->ldTgtIdToLd[i] =
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  255  				(u16)fw_map_ext->ldTgtIdToLd[i];
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  256  		memcpy(pDrvRaidMap->ldSpanMap, fw_map_ext->ldSpanMap,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  257  		       sizeof(struct MR_LD_SPAN_MAP) * ld_count);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  258  		memcpy(pDrvRaidMap->arMapInfo, fw_map_ext->arMapInfo,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  259  		       sizeof(struct MR_ARRAY_INFO) * MAX_API_ARRAYS_EXT);
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  260  		memcpy(pDrvRaidMap->devHndlInfo, fw_map_ext->devHndlInfo,
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  261  		       sizeof(struct MR_DEV_HANDLE_INFO) *
d889344e4e59eb Sasikumar Chandrasekaran   2017-01-10  262  		       MAX_RAIDMAP_PHYSICAL_DEVICES);
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  263  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  264  		/* New Raid map will not set totalSize, so keep expected value
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  265  		 * for legacy code in ValidateMapInfo
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  266  		 */
6e755ddc2935d9 Sumit.Saxena@avagotech.com 2014-11-17  267  		pDrvRaidMap->totalSize =
6e755ddc2935d9 Sumit.Saxena@avagotech.com 2014-11-17  268  			cpu_to_le32(sizeof(struct MR_FW_RAID_MAP_EXT));
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  269  	} else {
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  270  		fw_map_old = (struct MR_FW_RAID_MAP_ALL *)
5f19f7c879c4aa Shivasharan S              2018-01-05  271  				fusion->ld_map[(map_id & 1)];
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12 @272  		pFwRaidMap = &fw_map_old->raidMap;
200aed582d6170 Sumit.Saxena@avagotech.com 2015-01-05  273  		ld_count = (u16)le32_to_cpu(pFwRaidMap->ldCount);
7ada701d0d5e5c Shivasharan S              2018-01-05  274  		if (ld_count > MAX_LOGICAL_DRIVES) {
7ada701d0d5e5c Shivasharan S              2018-01-05  275  			dev_dbg(&instance->pdev->dev,
7ada701d0d5e5c Shivasharan S              2018-01-05  276  				"LD count exposed in RAID map in not valid\n");
7ada701d0d5e5c Shivasharan S              2018-01-05  277  			return 1;
7ada701d0d5e5c Shivasharan S              2018-01-05  278  		}
7ada701d0d5e5c Shivasharan S              2018-01-05  279  
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  280  		pDrvRaidMap->totalSize = pFwRaidMap->totalSize;
200aed582d6170 Sumit.Saxena@avagotech.com 2015-01-05  281  		pDrvRaidMap->ldCount = (__le16)cpu_to_le16(ld_count);
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  282  		pDrvRaidMap->fpPdIoTimeoutSec = pFwRaidMap->fpPdIoTimeoutSec;
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  283  		for (i = 0; i < MAX_RAIDMAP_LOGICAL_DRIVES + MAX_RAIDMAP_VIEWS; i++)
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  284  			pDrvRaidMap->ldTgtIdToLd[i] =
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  285  				(u8)pFwRaidMap->ldTgtIdToLd[i];
200aed582d6170 Sumit.Saxena@avagotech.com 2015-01-05  286  		for (i = 0; i < ld_count; i++) {
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  287  			pDrvRaidMap->ldSpanMap[i] = pFwRaidMap->ldSpanMap[i];
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  288  		}
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  289  		memcpy(pDrvRaidMap->arMapInfo, pFwRaidMap->arMapInfo,
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  290  			sizeof(struct MR_ARRAY_INFO) * MAX_RAIDMAP_ARRAYS);
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  291  		memcpy(pDrvRaidMap->devHndlInfo, pFwRaidMap->devHndlInfo,
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  292  			sizeof(struct MR_DEV_HANDLE_INFO) *
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  293  			MAX_RAIDMAP_PHYSICAL_DEVICES);
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  294  	}
7ada701d0d5e5c Shivasharan S              2018-01-05  295  
7ada701d0d5e5c Shivasharan S              2018-01-05  296  	return 0;
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  297  }
51087a8617fef1 Sumit.Saxena@avagotech.com 2014-09-12  298  

:::::: The code at line 103 was first introduced by commit
:::::: 9c915a8c99bce637226aa09cb05fc18486b229cb [SCSI] megaraid_sas: Add 9565/9285 specific code

:::::: TO: adam radford <aradford@gmail.com>
:::::: CC: James Bottomley <James.Bottomley@suse.de>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

