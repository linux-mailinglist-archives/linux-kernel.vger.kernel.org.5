Return-Path: <linux-kernel+bounces-101149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A950C87A323
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8F61C2148E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9C14ABA;
	Wed, 13 Mar 2024 07:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9T5B7vH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143B0134AD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710313422; cv=none; b=FOGFnrvKpjfiNPdjZ1jwvab9vs4ij9jkcK9hrdy9G3ZemMQ5tWcSIUqg5/nGXu/UqUjIysQAuTNt9jJl01lfupAkuKa7OmKphSNwz1Ji5zz8o2zZXmQnagnsA9Ab3Fdc3x7uVcX1acMk3Zo8eo8aDNKxciJFPLndCNVqbXxqhR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710313422; c=relaxed/simple;
	bh=TM4llEmWvt3Eqj4ka9xxYANerkoKCQkq7CdMxuEFzkY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=poVJaio8sYkzF21PSnvrMOvGv6yLvwpFIXEXovwSRQcjFMN2kcJjOoKaEaWukucsU21w0DI1ocpQ0xJFyQ1zgO6IxEgAVkU+7pyXXXSG2DGZy0lqA0yFLOdJQhlknNP97PfJ5nPJ6B6H3cAIweKwV4IcgFrHDEWgRARDQdGkjG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e9T5B7vH; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710313420; x=1741849420;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TM4llEmWvt3Eqj4ka9xxYANerkoKCQkq7CdMxuEFzkY=;
  b=e9T5B7vHFp6L61n7cJrOGGqbUUhrHzgjoBzEM9SRkZCYoz/+DVGeqd5/
   U62o7YHQVDupvG9Q+WRD23KUH5+mTIMN3OrCd7aR7Y6AkfYN0Tgeh4+Sg
   x5/9N6fvyi0s+wZYvgJ8Ywq+/VDeX6xnUz0wlbM6BE+aH50aom5WPsWl3
   532lwTpxzrSVfdWS6fHUKrZdHDCP5lmZqMtVtS+Wy1ev9pzrxt7UxZn/4
   4IpCQ8fIEX1wbqzvnzS5309Ms1KPlIIehUcF4p/lZlwWnliguy8Hw/J3Y
   cgi6OdYawNGT5mvKb3XBsWrdZAiTf3pajtM/hoQ9sly6yMKVkhhkOpCu2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="30496297"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="30496297"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 00:03:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12265334"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Mar 2024 00:03:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkIeF-000C8B-1B;
	Wed, 13 Mar 2024 07:03:35 +0000
Date: Wed, 13 Mar 2024 15:03:20 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240312 1/1]
 lib/crc64-rocksoft.c:69:13: error: no member named 'tfm' in 'struct
 shash_desc'
Message-ID: <202403131436.V9IBdFAo-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git testing/WFAMNAE-next20240312
head:   33ee4d07d6d337670a64f9d41e14e7579cfa9015
commit: 33ee4d07d6d337670a64f9d41e14e7579cfa9015 [1/1] treewide: avoid -Wfamnae warnings
config: i386-buildonly-randconfig-003-20240313 (https://download.01.org/0day-ci/archive/20240313/202403131436.V9IBdFAo-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403131436.V9IBdFAo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403131436.V9IBdFAo-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/crc64-rocksoft.c:8:
   include/crypto/hash.h:155:2: error: expected member name or ';' after declaration specifiers
     155 |         struct_group_tagged(shash_desc_hdr, hdr,
         |         ^
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:28:20: note: expanded from macro '__struct_group'
      28 |                 struct { MEMBERS } ATTRS; \
         |                                  ^
   In file included from lib/crc64-rocksoft.c:8:
   include/crypto/hash.h:155:2: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     155 |         struct_group_tagged(shash_desc_hdr, hdr,
         |         ^
     156 |                             struct crypto_shash *tfm;
     157 |                             __aligned(ARCH_SLAB_MINALIGN));
         |                             int
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:28:20: note: expanded from macro '__struct_group'
      28 |                 struct { MEMBERS } ATTRS; \
         |                                  ^
   In file included from lib/crc64-rocksoft.c:8:
   include/crypto/hash.h:155:2: warning: expected ';' at end of declaration list
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:28:20: note: expanded from macro '__struct_group'
      28 |                 struct { MEMBERS } ATTRS; \
         |                                  ^
   In file included from lib/crc64-rocksoft.c:8:
   include/crypto/hash.h:155:2: error: expected member name or ';' after declaration specifiers
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:29:24: note: expanded from macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                      ^
   In file included from lib/crc64-rocksoft.c:8:
   include/crypto/hash.h:155:2: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
     155 |         struct_group_tagged(shash_desc_hdr, hdr,
         |         ^
     156 |                             struct crypto_shash *tfm;
     157 |                             __aligned(ARCH_SLAB_MINALIGN));
         |                             int
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:29:24: note: expanded from macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                      ^
   In file included from lib/crc64-rocksoft.c:8:
   include/crypto/hash.h:155:2: warning: expected ';' at end of declaration list
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:29:24: note: expanded from macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                      ^
   In file included from lib/crc64-rocksoft.c:8:
   include/crypto/hash.h:158:8: error: flexible array member '__ctx' not allowed in otherwise empty struct
     158 |         void *__ctx[];
         |               ^
   include/crypto/hash.h:891:35: error: no member named 'tfm' in 'struct shash_desc'
     891 |         struct crypto_shash *tfm = desc->tfm;
         |                                    ~~~~  ^
   include/crypto/hash.h:951:49: error: no member named 'tfm' in 'struct shash_desc'
     951 |                          sizeof(*desc) + crypto_shash_descsize(desc->tfm));
         |                                                                ~~~~  ^
>> lib/crc64-rocksoft.c:69:13: error: no member named 'tfm' in 'struct shash_desc'
      69 |         desc.shash.tfm = rcu_dereference(crc64_rocksoft_tfm);
         |         ~~~~~~~~~~ ^
   2 warnings and 8 errors generated.


vim +69 lib/crc64-rocksoft.c

f3813f4b287e48 Keith Busch 2022-03-03  56  
f3813f4b287e48 Keith Busch 2022-03-03  57  u64 crc64_rocksoft_update(u64 crc, const unsigned char *buffer, size_t len)
f3813f4b287e48 Keith Busch 2022-03-03  58  {
f3813f4b287e48 Keith Busch 2022-03-03  59  	struct {
f3813f4b287e48 Keith Busch 2022-03-03  60  		struct shash_desc shash;
f3813f4b287e48 Keith Busch 2022-03-03  61  		u64 crc;
f3813f4b287e48 Keith Busch 2022-03-03  62  	} desc;
f3813f4b287e48 Keith Busch 2022-03-03  63  	int err;
f3813f4b287e48 Keith Busch 2022-03-03  64  
f3813f4b287e48 Keith Busch 2022-03-03  65  	if (static_branch_unlikely(&crc64_rocksoft_fallback))
f3813f4b287e48 Keith Busch 2022-03-03  66  		return crc64_rocksoft_generic(crc, buffer, len);
f3813f4b287e48 Keith Busch 2022-03-03  67  
f3813f4b287e48 Keith Busch 2022-03-03  68  	rcu_read_lock();
f3813f4b287e48 Keith Busch 2022-03-03 @69  	desc.shash.tfm = rcu_dereference(crc64_rocksoft_tfm);
f3813f4b287e48 Keith Busch 2022-03-03  70  	desc.crc = crc;
f3813f4b287e48 Keith Busch 2022-03-03  71  	err = crypto_shash_update(&desc.shash, buffer, len);
f3813f4b287e48 Keith Busch 2022-03-03  72  	rcu_read_unlock();
f3813f4b287e48 Keith Busch 2022-03-03  73  
f3813f4b287e48 Keith Busch 2022-03-03  74  	BUG_ON(err);
f3813f4b287e48 Keith Busch 2022-03-03  75  
f3813f4b287e48 Keith Busch 2022-03-03  76  	return desc.crc;
f3813f4b287e48 Keith Busch 2022-03-03  77  }
f3813f4b287e48 Keith Busch 2022-03-03  78  EXPORT_SYMBOL_GPL(crc64_rocksoft_update);
f3813f4b287e48 Keith Busch 2022-03-03  79  

:::::: The code at line 69 was first introduced by commit
:::::: f3813f4b287e480b1fcd62ca798d8556644b8278 crypto: add rocksoft 64b crc guard tag framework

:::::: TO: Keith Busch <kbusch@kernel.org>
:::::: CC: Jens Axboe <axboe@kernel.dk>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

