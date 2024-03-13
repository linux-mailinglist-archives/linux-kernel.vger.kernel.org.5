Return-Path: <linux-kernel+bounces-101142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF0887A303
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5FEB283172
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8714014;
	Wed, 13 Mar 2024 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V/Hw9PPf"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D076168DF
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710312222; cv=none; b=ApbtlZzORoqrZ4a+f7wrpk02VATK0QRuMtl7woOB+Nk2qzy4t48y+ed7ChlJ8l16Ts+jB2O4yoGI3nSQPUQw/ErXLjRVIB17S7x8Ow01VNIMH+kTYx55Ca8qh+RhlH7qHRlfo8HHoO0zpWUkS4uR3xEYC4W18SqfDd8SoF75AoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710312222; c=relaxed/simple;
	bh=/qAKkUIlw3A1A7qYgrmzb9dnCLvg+8XSpZKKT2K0WUY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BZZECcwSK9kz+ghfUZEgtKhh59a1WgHGx9ogQq3R/x1k7BupTZq2qgn1mbpJXbFSfxWe3+HpUBErud80vGiTMg3YOkYM6UHsRVcgCpX2e2a0N6dk25hzg4n/fh411CpipCdCovYgsQf5naFnOhLRtYDsgn7XNjxesFtsTR6hqc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V/Hw9PPf; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710312221; x=1741848221;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/qAKkUIlw3A1A7qYgrmzb9dnCLvg+8XSpZKKT2K0WUY=;
  b=V/Hw9PPfTZp2Zvg2jShngdLO5e0P+EZ/vQ13qhMms872i6CEWqsHla4r
   ORdEOZFqHMRaclpfA0ivXT5plDuz3ZBVcml5NP3fUvjrOcaQKUfG+gZEr
   qqaZ5pkOAkTPsawQ2ukI7scbCi923wBBzJ8bLnFgSxQENLnxK3u0biEVa
   hDIgfN3jc+tOztpJ/LaZbGkI/fiZVXwehJU68xk7N+bYTzCrbd4W1l6tO
   A27Qelq3eyH+9ZpILEbYnZuh1WSbuXTqTxdMPDVoaqy5x/q8AQiXhv2bF
   QrtGIwfl/sMb5+2anCTUUUY8s+fNv/NJck531eSAxYrZMqmfBA7UC2ew0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="4923165"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="4923165"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 23:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12387798"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 12 Mar 2024 23:43:38 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkIKt-000C7z-0t;
	Wed, 13 Mar 2024 06:43:35 +0000
Date: Wed, 13 Mar 2024 14:43:02 +0800
From: kernel test robot <lkp@intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: [gustavoars:testing/WFAMNAE-next20240312 1/1]
 lib/crc-t10dif.c:75:13: error: no member named 'tfm' in 'struct shash_desc'
Message-ID: <202403131429.n6mGhow1-lkp@intel.com>
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
config: hexagon-defconfig (https://download.01.org/0day-ci/archive/20240313/202403131429.n6mGhow1-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 503c55e17037436dcd45ac69dea8967e67e3f5e8)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240313/202403131429.n6mGhow1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403131429.n6mGhow1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from lib/crc-t10dif.c:14:
   include/crypto/hash.h:155:2: error: expected member name or ';' after declaration specifiers
     155 |         struct_group_tagged(shash_desc_hdr, hdr,
         |         ^
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:28:20: note: expanded from macro '__struct_group'
      28 |                 struct { MEMBERS } ATTRS; \
         |                                  ^
   In file included from lib/crc-t10dif.c:14:
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
   In file included from lib/crc-t10dif.c:14:
   include/crypto/hash.h:155:2: warning: expected ';' at end of declaration list
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:28:20: note: expanded from macro '__struct_group'
      28 |                 struct { MEMBERS } ATTRS; \
         |                                  ^
   In file included from lib/crc-t10dif.c:14:
   include/crypto/hash.h:155:2: error: expected member name or ';' after declaration specifiers
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:29:24: note: expanded from macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                      ^
   In file included from lib/crc-t10dif.c:14:
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
   In file included from lib/crc-t10dif.c:14:
   include/crypto/hash.h:155:2: warning: expected ';' at end of declaration list
   include/linux/stddef.h:81:2: note: expanded from macro 'struct_group_tagged'
      81 |         __struct_group(TAG, NAME, /* no attrs */, MEMBERS)
         |         ^
   include/uapi/linux/stddef.h:29:24: note: expanded from macro '__struct_group'
      29 |                 struct TAG { MEMBERS } ATTRS NAME; \
         |                                      ^
   In file included from lib/crc-t10dif.c:14:
   include/crypto/hash.h:158:8: error: flexible array member '__ctx' not allowed in otherwise empty struct
     158 |         void *__ctx[];
         |               ^
   include/crypto/hash.h:891:35: error: no member named 'tfm' in 'struct shash_desc'
     891 |         struct crypto_shash *tfm = desc->tfm;
         |                                    ~~~~  ^
   include/crypto/hash.h:951:49: error: no member named 'tfm' in 'struct shash_desc'
     951 |                          sizeof(*desc) + crypto_shash_descsize(desc->tfm));
         |                                                                ~~~~  ^
>> lib/crc-t10dif.c:75:13: error: no member named 'tfm' in 'struct shash_desc'
      75 |         desc.shash.tfm = rcu_dereference(crct10dif_tfm);
         |         ~~~~~~~~~~ ^
   2 warnings and 8 errors generated.


vim +75 lib/crc-t10dif.c

f11f594edba7f6 Martin K. Petersen 2008-06-25  62  
10081fb532a2a2 Akinobu Mita       2015-05-01  63  __u16 crc_t10dif_update(__u16 crc, const unsigned char *buffer, size_t len)
f11f594edba7f6 Martin K. Petersen 2008-06-25  64  {
68411521cc6055 Herbert Xu         2013-09-07  65  	struct {
68411521cc6055 Herbert Xu         2013-09-07  66  		struct shash_desc shash;
29195232fa2f72 Eric Biggers       2020-06-09  67  		__u16 crc;
68411521cc6055 Herbert Xu         2013-09-07  68  	} desc;
68411521cc6055 Herbert Xu         2013-09-07  69  	int err;
68411521cc6055 Herbert Xu         2013-09-07  70  
be924e0aaa315a Eric Biggers       2020-06-09  71  	if (static_branch_unlikely(&crct10dif_fallback))
10081fb532a2a2 Akinobu Mita       2015-05-01  72  		return crc_t10dif_generic(crc, buffer, len);
26052f9b9bb8de Herbert Xu         2013-09-12  73  
b76377543b738a Martin K. Petersen 2018-08-30  74  	rcu_read_lock();
b76377543b738a Martin K. Petersen 2018-08-30 @75  	desc.shash.tfm = rcu_dereference(crct10dif_tfm);
29195232fa2f72 Eric Biggers       2020-06-09  76  	desc.crc = crc;
68411521cc6055 Herbert Xu         2013-09-07  77  	err = crypto_shash_update(&desc.shash, buffer, len);
b76377543b738a Martin K. Petersen 2018-08-30  78  	rcu_read_unlock();
b76377543b738a Martin K. Petersen 2018-08-30  79  
68411521cc6055 Herbert Xu         2013-09-07  80  	BUG_ON(err);
f11f594edba7f6 Martin K. Petersen 2008-06-25  81  
29195232fa2f72 Eric Biggers       2020-06-09  82  	return desc.crc;
f11f594edba7f6 Martin K. Petersen 2008-06-25  83  }
10081fb532a2a2 Akinobu Mita       2015-05-01  84  EXPORT_SYMBOL(crc_t10dif_update);
10081fb532a2a2 Akinobu Mita       2015-05-01  85  

:::::: The code at line 75 was first introduced by commit
:::::: b76377543b738a6b58b0a7b0a42dd9e16436fee1 crc-t10dif: Pick better transform if one becomes available

:::::: TO: Martin K. Petersen <martin.petersen@oracle.com>
:::::: CC: Herbert Xu <herbert@gondor.apana.org.au>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

