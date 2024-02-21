Return-Path: <linux-kernel+bounces-73987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5385CE82
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 04:01:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4401F23558
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FA738F84;
	Wed, 21 Feb 2024 03:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="blDL4qZF"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B872B9D5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708484467; cv=none; b=bCChj3e8bCBE2TnmKxd+V6bN5T57ABW8Gnwz/3AmDypy34gCw/nfp4YtRy/EnnUH9wNZHmuXlRHdk6V2SACb+NV5RJ4ZTI8rG6TsooKJmi3ar5CXl7ss7JfU4VQvPwMM8aT3IJ3XZItYAHDdmAmOmippdQdrZLQuNhhAh3MNOkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708484467; c=relaxed/simple;
	bh=4aSQqd3v8b8sxmF1wbx1k+O6G0isQcBWH8qkJ4BH9RU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=vELu5mfUjJG9cZjA4ljlBezVVk9N0iXYxfIbhCVlVhrp/ZuDPxeNqHUIpc3/Si7nNKRXLY3Wvepvsmr0taRbfhF9n6zUfxSg+0Ohvb2Px6YCjZ4AzMtbAix3mYgmZv+lboJVo1NdXjXAlIY4rKlxb66vv+583ffd37gKK4AUdAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=blDL4qZF; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708484464; x=1740020464;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4aSQqd3v8b8sxmF1wbx1k+O6G0isQcBWH8qkJ4BH9RU=;
  b=blDL4qZFDeosQhxJpeKtm9KtODl24CcyKDFKVWcbcEMkxCCcByDcUF5S
   iUWAvDvy5Ei6hlSUxLq2nKIa6MZMOLt2fOPA/o1l6W0bgbwy9YZvXPZpx
   DKUUvmy7DHcuIr8IBRT2I+e+HoyIBohkw00IyO1IoZWZcWaCROOGrDrIr
   60CHiGFOh/NVwtEOQAkPMSEW5uPgx/mef1BRsOcrNMg2QbirKzrtDzYCk
   HPImpQCxSrPhKG5jtCzCaKpuuALAHjcgCiieNsAKTla/kBsrDJVMOdRQo
   yrXMKCUlSUY8uPndOrfUCGp2g2smBxiVox/nZbsuZT/SoI1l1amBoDecC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2495450"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2495450"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 19:01:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="9634218"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 20 Feb 2024 19:00:50 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rccps-0004xa-0I;
	Wed, 21 Feb 2024 03:00:15 +0000
Date: Wed, 21 Feb 2024 10:59:09 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240215 1/1]
 drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:59: error:
 duplicate member 'hdr'
Message-ID: <202402211012.UFFWsyhQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240215
head:   b50c399b249bcb0fdc709e812b4e87519937299d
commit: 3fedbc527c5726b876207557fb133a5e558c1898 [1/1] treewide: Address -Wflexible-array-member-not-at-end warnings
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240221/202402211012.UFFWsyhQ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240221/202402211012.UFFWsyhQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402211012.UFFWsyhQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kcsan-checks.h:14,
                    from include/asm-generic/barrier.h:17,
                    from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:251,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/netdevice.h:24,
                    from include/trace/events/xdp.h:8,
                    from include/linux/bpf_trace.h:5,
                    from drivers/net/ethernet/netronome/nfp/nfd3/dp.c:4:
>> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:59: error: duplicate member 'hdr'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |                                                           ^~~
   include/uapi/linux/stddef.h:29:46: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                              ^~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:36:48: error: duplicate member 'hdr'
      36 |                             struct nfp_ccm_hdr hdr;
         |                                                ^~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:37:36: error: duplicate member 'ep_id'
      37 |                             __be32 ep_id;
         |                                    ^~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:38:32: error: duplicate member 'resv'
      38 |                             u8 resv[3];
         |                                ^~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:39:32: error: duplicate member 'opcode'
      39 |                             u8 opcode;
         |                                ^~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:40:32: error: duplicate member 'key_len'
      40 |                             u8 key_len;
         |                                ^~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:41:36: error: duplicate member 'ipver_vlan'
      41 |                             __be16 ipver_vlan __packed;
         |                                    ^~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:42:32: error: duplicate member 'l4_proto'
      42 |                             u8 l4_proto;
         |                                ^~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kcsan-checks.h:14,
                    from include/asm-generic/barrier.h:17,
                    from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:251,
                    from include/linux/build_bug.h:5,
                    from include/linux/container_of.h:5,
                    from include/linux/list.h:5,
                    from include/linux/timer.h:5,
                    from include/linux/netdevice.h:24,
                    from include/trace/events/xdp.h:8,
                    from include/linux/bpf_trace.h:5,
                    from drivers/net/ethernet/netronome/nfp/nfdk/dp.c:4:
>> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:59: error: duplicate member 'hdr'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |                                                           ^~~
   include/uapi/linux/stddef.h:29:46: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                              ^~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:36:48: error: duplicate member 'hdr'
      36 |                             struct nfp_ccm_hdr hdr;
         |                                                ^~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:37:36: error: duplicate member 'ep_id'
      37 |                             __be32 ep_id;
         |                                    ^~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:38:32: error: duplicate member 'resv'
      38 |                             u8 resv[3];
         |                                ^~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:39:32: error: duplicate member 'opcode'
      39 |                             u8 opcode;
         |                                ^~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:40:32: error: duplicate member 'key_len'
      40 |                             u8 key_len;
         |                                ^~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:41:36: error: duplicate member 'ipver_vlan'
      41 |                             __be16 ipver_vlan __packed;
         |                                    ^~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:42:32: error: duplicate member 'l4_proto'
      42 |                             u8 l4_proto;
         |                                ^~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/nfdk/../crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kcsan-checks.h:14,
                    from include/asm-generic/barrier.h:17,
                    from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:251,
                    from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from drivers/net/ethernet/netronome/nfp/nfp_net_common.c:14:
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:59: error: duplicate member 'hdr'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |                                                           ^~~
   include/uapi/linux/stddef.h:29:46: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                              ^~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:36:48: error: duplicate member 'hdr'
      36 |                             struct nfp_ccm_hdr hdr;
         |                                                ^~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:37:36: error: duplicate member 'ep_id'
      37 |                             __be32 ep_id;
         |                                    ^~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:38:32: error: duplicate member 'resv'
      38 |                             u8 resv[3];
         |                                ^~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:39:32: error: duplicate member 'opcode'
      39 |                             u8 opcode;
         |                                ^~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:40:32: error: duplicate member 'key_len'
      40 |                             u8 key_len;
         |                                ^~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:41:36: error: duplicate member 'ipver_vlan'
      41 |                             __be16 ipver_vlan __packed;
         |                                    ^~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:42:32: error: duplicate member 'l4_proto'
      42 |                             u8 l4_proto;
         |                                ^~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/stddef.h:5,
                    from include/uapi/linux/posix_types.h:5,
                    from include/uapi/linux/types.h:14,
                    from include/linux/types.h:6,
                    from include/linux/kcsan-checks.h:14,
                    from include/asm-generic/barrier.h:17,
                    from arch/alpha/include/asm/barrier.h:21,
                    from arch/alpha/include/asm/rwonce.h:10,
                    from include/linux/compiler.h:251,
                    from include/linux/build_bug.h:5,
                    from include/linux/bitfield.h:10,
                    from drivers/net/ethernet/netronome/nfp/crypto/tls.c:4:
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:59: error: duplicate member 'hdr'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |                                                           ^~~
   include/uapi/linux/stddef.h:29:46: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                              ^~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:36:48: error: duplicate member 'hdr'
      36 |                             struct nfp_ccm_hdr hdr;
         |                                                ^~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:37:36: error: duplicate member 'ep_id'
      37 |                             __be32 ep_id;
         |                                    ^~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:38:32: error: duplicate member 'resv'
      38 |                             u8 resv[3];
         |                                ^~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:39:32: error: duplicate member 'opcode'
      39 |                             u8 opcode;
         |                                ^~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:40:32: error: duplicate member 'key_len'
      40 |                             u8 key_len;
         |                                ^~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:41:36: error: duplicate member 'ipver_vlan'
      41 |                             __be16 ipver_vlan __packed;
         |                                    ^~~~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
>> drivers/net/ethernet/netronome/nfp/crypto/fw.h:42:32: error: duplicate member 'l4_proto'
      42 |                             u8 l4_proto;
         |                                ^~~~~~~~
   include/uapi/linux/stddef.h:29:30: note: in definition of macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                              ^~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/fw.h:35:9: note: in expansion of macro 'struct_group_tagged'
      35 |         struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
         |         ^~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/netronome/nfp/crypto/tls.c: In function 'nfp_net_tls_set_ipv6':
>> drivers/net/ethernet/netronome/nfp/crypto/tls.c:199:19: error: 'struct nfp_crypto_req_add_front_hdr' has no member named 'key_len'
     199 |         req->front.key_len += sizeof(struct in6_addr) * 2;
         |                   ^
.


vim +/hdr +35 drivers/net/ethernet/netronome/nfp/nfd3/../crypto/fw.h

    33	
    34	struct nfp_crypto_req_add_front {
  > 35		struct_group_tagged(nfp_crypto_req_add_front_hdr, hdr,
  > 36				    struct nfp_ccm_hdr hdr;
  > 37				    __be32 ep_id;
  > 38				    u8 resv[3];
  > 39				    u8 opcode;
  > 40				    u8 key_len;
  > 41				    __be16 ipver_vlan __packed;
  > 42				    u8 l4_proto;
    43	#define NFP_NET_TLS_NON_ADDR_KEY_LEN	8
    44		);
    45		u8 l3_addrs[];
    46	};
    47	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

