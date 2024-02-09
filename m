Return-Path: <linux-kernel+bounces-59890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A02084FCF4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B8901C274B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E2B4E1A2;
	Fri,  9 Feb 2024 19:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QmQeu32M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EA983CB7;
	Fri,  9 Feb 2024 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507407; cv=none; b=W5VHV075TtcojwDbLivxdHRDza0nBKb2/GF67Nd08+6T+tWctFWhj28HPx37Tu64plCu42OE2wxyLUXA7iQcrCyNShqSXnCbZ6mZCD8PiYpb7vh9BRa8/loBSQohoMt6JU04Yde5r2ouGQfi4KszrdWhp85u0+LqcNlljiKsGEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507407; c=relaxed/simple;
	bh=bTxXNbHfZZhEuLVtEBZ4sln50esH9OZdaF3Hs6jsuZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmkReLnYA3MJCZqKLN/WXID+E+E8eqizUrE4nEsYmKxO7akGXqilJxAhKmM5JekPja/iAhDVRhHMZS6MnrqKtAE93GWiEBow6Jo8Rq+DXrM8OtvFbL+YY8PcSEV0GUeo9sDQubgMAZADSg3TYSfBkhXiwgaSQcWp66k/brVtrhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QmQeu32M; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707507405; x=1739043405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bTxXNbHfZZhEuLVtEBZ4sln50esH9OZdaF3Hs6jsuZE=;
  b=QmQeu32MVyXN+N29N45pfMgRciZ4BicJ+DLBk9EQCwKiKfbr1dbUBLpp
   Trz+OIEuRemTR8TWYBASC0xi7QqIt12MCZP0MCNHiZ4npp+lG3pZicoN9
   vy3hULHqrvr9f2Ue7D2JSvOMaoSgojIxKXUDoc+vLR0XGisQRqSM8fBmz
   luTxtWyEJP2fujX3zZvtNFpf3MWTWpFMkis5VxkyC1xSVGROQOh8U/8YF
   ekV19tyHeUn5xeLqjOhIL2inIFAJymfH7eqWiVj9CnOAnnsPPyVHpuOQC
   +0S6Y/wkYrRjzrptsx7/OzUumOu2O+0rl/dtaSWY+xP+V8Bnx9Wc5S/mg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="18902724"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18902724"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:36:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="934510391"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="934510391"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 09 Feb 2024 11:36:39 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYWfs-00053a-2R;
	Fri, 09 Feb 2024 19:36:36 +0000
Date: Sat, 10 Feb 2024 03:36:23 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
	davem@davemloft.net
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	saulo.alessandre@tse.jus.br, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 01/14] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <202402100352.1TagPxg9-lkp@intel.com>
References: <20240208221840.3665874-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208221840.3665874-2-stefanb@linux.ibm.com>

Hi Stefan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on herbert-cryptodev-2.6/master]
[also build test WARNING on herbert-crypto-2.6/master linus/master v6.8-rc3 next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/crypto-ecdsa-Convert-byte-arrays-with-key-coordinates-to-digits/20240209-062415
base:   https://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git master
patch link:    https://lore.kernel.org/r/20240208221840.3665874-2-stefanb%40linux.ibm.com
patch subject: [PATCH 01/14] crypto: ecdsa - Convert byte arrays with key coordinates to digits
config: x86_64-randconfig-101-20240209 (https://download.01.org/0day-ci/archive/20240210/202402100352.1TagPxg9-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402100352.1TagPxg9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402100352.1TagPxg9-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> crypto/ecdsa.c:225:34: warning: variable 'nbytes' set but not used [-Wunused-but-set-variable]
     225 |         unsigned int digitlen, ndigits, nbytes;
         |                                         ^
   1 warning generated.


vim +/nbytes +225 crypto/ecdsa.c

   216	
   217	/*
   218	 * Set the public key given the raw uncompressed key data from an X509
   219	 * certificate. The key data contain the concatenated X and Y coordinates of
   220	 * the public key.
   221	 */
   222	static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsigned int keylen)
   223	{
   224		struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
 > 225		unsigned int digitlen, ndigits, nbytes;
   226		const unsigned char *d = key;
   227		int ret;
   228	
   229		ret = ecdsa_ecc_ctx_reset(ctx);
   230		if (ret < 0)
   231			return ret;
   232	
   233		if (keylen < 1 || (((keylen - 1) >> 1) % sizeof(u64)) != 0)
   234			return -EINVAL;
   235		/* we only accept uncompressed format indicated by '4' */
   236		if (d[0] != 4)
   237			return -EINVAL;
   238	
   239		keylen--;
   240		digitlen = keylen >> 1;
   241	
   242		ndigits = digitlen / sizeof(u64);
   243		if (ndigits != ctx->curve->g.ndigits)
   244			return -EINVAL;
   245	
   246		nbytes = ndigits * sizeof(u64);
   247		d++;
   248	
   249		ecc_digits_from_array(d, digitlen, ctx->pub_key.x, ndigits);
   250		ecc_digits_from_array(&d[digitlen], digitlen, ctx->pub_key.y, ndigits);
   251	
   252		ret = ecc_is_pubkey_valid_full(ctx->curve, &ctx->pub_key);
   253	
   254		ctx->pub_key_set = ret == 0;
   255	
   256		return ret;
   257	}
   258	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

