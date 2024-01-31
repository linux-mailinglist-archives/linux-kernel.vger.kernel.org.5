Return-Path: <linux-kernel+bounces-46824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFAB68444D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913D1281E7C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3056F12C526;
	Wed, 31 Jan 2024 16:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dem+Ob8S"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD35712BE8D;
	Wed, 31 Jan 2024 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719708; cv=none; b=MEyEW5RzzUSNt3cS/pnUxbgdD/oL90k1YUKKYtjNkpxJrNv9eaQG7nLx4loGf/EV1dXRUDTbUhseNL+GjCUbrDh2LzU71WExl64mxq6rGxrtFfx29Drl4x5/uTgUMvxsaP41S9iUVjJc7VqRS1NopMZD2grZ4vpndgMlOiatF+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719708; c=relaxed/simple;
	bh=O+Ckqld21NseZzB5lCAj+EQ7OHd0wXrB13RwGOqBfic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycu0Tm1JuV6Qf8vAZ/C9Mpj2AKWGBlTN0jIj/rTD9WgFF1Qh3H0HK+mjc/wd/vGHLVvroCoqy/PUHfPiiXj01Ej4j8TtkGKKjRgeefw47aJUX2mIuLwasSW/8J7ZzdhnrZXE7O2jm69XbpXsh4WPoWTvTN8yksgnJhAh2b2vSBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dem+Ob8S; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706719706; x=1738255706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O+Ckqld21NseZzB5lCAj+EQ7OHd0wXrB13RwGOqBfic=;
  b=dem+Ob8SxoCZs9nxa764/1aU9lSlw21ry8yb7Xf+cAXYtAgqB8gwrk9L
   FPDktsiihAGsoirO2gmnk24DHLGte9g0yZGeW4rFjhFzyAqU5xz/yLlWU
   rwkeItK9dyMAopb5Z98R/PpGEb02Nz6n8LIk0+jawne8QdaWD8EbSS+SD
   YD7DxtRLhXqci2pJDWjKr/Sge7AeHKoKnAWWlbVnXRwP7+FNJrAbZHKr/
   Bjr2Ca6o0nNgyRE4yrzMU1GG2kiD9ih5mkJeDi2o1fxMlqOrJ7I5kXdDM
   0NOa4fC1W3pAqtkL77dktN8jxGmrcRoL24rEfWnOOoJm7cncyxZcQ/wIy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="403275510"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="403275510"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 08:48:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="788635713"
X-IronPort-AV: E=Sophos;i="6.05,231,1701158400"; 
   d="scan'208";a="788635713"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 31 Jan 2024 08:48:21 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVDl5-0001mG-0n;
	Wed, 31 Jan 2024 16:48:19 +0000
Date: Thu, 1 Feb 2024 00:47:34 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, amir73il@gmail.com, miklos@szeredi.hu,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH 1/5] security: allow finer granularity in permitting
 copy-up of security xattrs
Message-ID: <202402010014.MArAf4UB-lkp@intel.com>
References: <20240130214620.3155380-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130214620.3155380-2-stefanb@linux.ibm.com>

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on pcmoore-selinux/next linus/master v6.8-rc2 next-20240131]
[cannot apply to mszeredi-vfs/overlayfs-next mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/security-allow-finer-granularity-in-permitting-copy-up-of-security-xattrs/20240131-054854
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20240130214620.3155380-2-stefanb%40linux.ibm.com
patch subject: [PATCH 1/5] security: allow finer granularity in permitting copy-up of security xattrs
config: i386-buildonly-randconfig-002-20240131 (https://download.01.org/0day-ci/archive/20240201/202402010014.MArAf4UB-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240201/202402010014.MArAf4UB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402010014.MArAf4UB-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/security.c:2627:38: error: too many arguments to function call, expected single argument 'name', have 2 arguments
    2627 |         return evm_inode_copy_up_xattr(src, name);
         |                ~~~~~~~~~~~~~~~~~~~~~~~      ^~~~
   include/linux/evm.h:121:20: note: 'evm_inode_copy_up_xattr' declared here
     121 | static inline int  evm_inode_copy_up_xattr(const char *name)
         |                    ^                       ~~~~~~~~~~~~~~~~
   1 error generated.


vim +/name +2627 security/security.c

  2596	
  2597	/**
  2598	 * security_inode_copy_up_xattr() - Filter xattrs in an overlayfs copy-up op
  2599	 * @src: union dentry of copy-up file
  2600	 * @name: xattr name
  2601	 *
  2602	 * Filter the xattrs being copied up when a unioned file is copied up from a
  2603	 * lower layer to the union/overlay layer.   The caller is responsible for
  2604	 * reading and writing the xattrs, this hook is merely a filter.
  2605	 *
  2606	 * Return: Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP
  2607	 *         if the security module does not know about attribute, or a negative
  2608	 *         error code to abort the copy up.
  2609	 */
  2610	int security_inode_copy_up_xattr(struct dentry *src, const char *name)
  2611	{
  2612		struct security_hook_list *hp;
  2613		int rc;
  2614	
  2615		/*
  2616		 * The implementation can return 0 (accept the xattr), 1 (discard the
  2617		 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
  2618		 * any other error code in case of an error.
  2619		 */
  2620		hlist_for_each_entry(hp,
  2621				     &security_hook_heads.inode_copy_up_xattr, list) {
  2622			rc = hp->hook.inode_copy_up_xattr(src, name);
  2623			if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
  2624				return rc;
  2625		}
  2626	
> 2627		return evm_inode_copy_up_xattr(src, name);
  2628	}
  2629	EXPORT_SYMBOL(security_inode_copy_up_xattr);
  2630	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

