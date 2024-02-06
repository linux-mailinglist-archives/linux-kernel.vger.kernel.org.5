Return-Path: <linux-kernel+bounces-55451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CAA84BCD8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D78D1C23571
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB5912E63;
	Tue,  6 Feb 2024 18:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqbM+Q+r"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80B4171A7;
	Tue,  6 Feb 2024 18:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707243802; cv=none; b=LvbIb+fgLNXyyRulAfKTKh8a1qNusiLC3uGQ9FixkTpIDisTFn3IE43WCpkMCSlLGQaaN7ggs3jnFN1XEDQdcyES5DnQUcAC4Q9FNJUNv5hyg6zJikac2LDZtt1yqob3jaqj7vMVr2nfB9qtnBZQ8+7B/ea8m35JQD2q9UQQGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707243802; c=relaxed/simple;
	bh=KTit+aWgJvVP7m+gfVMXWeOWNPCtM6Grpruq+iW3l9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6dpKQBPjQhCQPMKs4i+nUGWi4htPxzLAUuvrzxOtbTCjTzvrvaQJLu/AyhFU+lZ1e2I3yX7bKQfZGPAzZnSTvZOzPN3JdaSvdVJIorhAnd9W7bi8FOtSOI3Vfbn64fSLJRJ6wFjDZ/CC+GA4L5n9b+DljOoz+dB1A7d39K5ONA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqbM+Q+r; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707243800; x=1738779800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KTit+aWgJvVP7m+gfVMXWeOWNPCtM6Grpruq+iW3l9Q=;
  b=hqbM+Q+rjqHVJZ+vKuX5gM9/BiqMjW9EZ8k4J5Iiom4ydmyC0glO/u7O
   nPIpRQEzQDeO4es5QNf6JyriZBBM2yaLDRAnp9qp6dLx2TC2DzValxK1C
   +4NhR/dRsqvBpk7nnr41aYYHSqtCUAmD4OPn0gSEsfD6sd5HLXa68+p9m
   qtVk+xEdm28wQP/sL6X/AXPf6cSlZFzZoSINmQoGhuEb6RV6yBTY51nwj
   GdEs+knYsr+ilMfkDmln+35ZVgG8EKeXM48ktBePePV4lGyX7U/eErqkj
   Hphq1QbVAgdEQAXtvGiNu/9FxN/p5cY6DtDLe5h1JObZgLw+p8i2hWhTb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="435948257"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="435948257"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 10:23:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="38507988"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Feb 2024 10:23:16 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXQ6D-0001gG-1H;
	Tue, 06 Feb 2024 18:23:13 +0000
Date: Wed, 7 Feb 2024 02:22:48 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
	zohar@linux.ibm.com, roberto.sassu@huawei.com, amir73il@gmail.com,
	brauner@kernel.org, miklos@szeredi.hu,
	Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 5/9] evm: Use the inode holding the metadata to
 calculate metadata hash
Message-ID: <202402070220.eYpQ6zcm-lkp@intel.com>
References: <20240205182506.3569743-6-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182506.3569743-6-stefanb@linux.ibm.com>

Hi Stefan,

kernel test robot noticed the following build errors:

[auto build test ERROR on zohar-integrity/next-integrity]
[also build test ERROR on pcmoore-selinux/next linus/master v6.8-rc3 next-20240206]
[cannot apply to mszeredi-vfs/overlayfs-next mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Stefan-Berger/ima-Rename-backing_inode-to-real_inode/20240206-022848
base:   https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git next-integrity
patch link:    https://lore.kernel.org/r/20240205182506.3569743-6-stefanb%40linux.ibm.com
patch subject: [PATCH v2 5/9] evm: Use the inode holding the metadata to calculate metadata hash
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20240207/202402070220.eYpQ6zcm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402070220.eYpQ6zcm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402070220.eYpQ6zcm-lkp@intel.com/

All errors (new ones prefixed by >>):

   security/integrity/evm/evm_crypto.c: In function 'evm_calc_hmac_or_hash':
>> security/integrity/evm/evm_crypto.c:226:54: error: 'D_REAL_METADATA' undeclared (first use in this function)
     226 |         struct inode *inode = d_inode(d_real(dentry, D_REAL_METADATA));
         |                                                      ^~~~~~~~~~~~~~~
   security/integrity/evm/evm_crypto.c:226:54: note: each undeclared identifier is reported only once for each function it appears in


vim +/D_REAL_METADATA +226 security/integrity/evm/evm_crypto.c

   212	
   213	/*
   214	 * Calculate the HMAC value across the set of protected security xattrs.
   215	 *
   216	 * Instead of retrieving the requested xattr, for performance, calculate
   217	 * the hmac using the requested xattr value. Don't alloc/free memory for
   218	 * each xattr, but attempt to re-use the previously allocated memory.
   219	 */
   220	static int evm_calc_hmac_or_hash(struct dentry *dentry,
   221					 const char *req_xattr_name,
   222					 const char *req_xattr_value,
   223					 size_t req_xattr_value_len,
   224					 uint8_t type, struct evm_digest *data)
   225	{
 > 226		struct inode *inode = d_inode(d_real(dentry, D_REAL_METADATA));
   227		struct xattr_list *xattr;
   228		struct shash_desc *desc;
   229		size_t xattr_size = 0;
   230		char *xattr_value = NULL;
   231		int error;
   232		int size, user_space_size;
   233		bool ima_present = false;
   234	
   235		if (!(inode->i_opflags & IOP_XATTR) ||
   236		    inode->i_sb->s_user_ns != &init_user_ns)
   237			return -EOPNOTSUPP;
   238	
   239		desc = init_desc(type, data->hdr.algo);
   240		if (IS_ERR(desc))
   241			return PTR_ERR(desc);
   242	
   243		data->hdr.length = crypto_shash_digestsize(desc->tfm);
   244	
   245		error = -ENODATA;
   246		list_for_each_entry_lockless(xattr, &evm_config_xattrnames, list) {
   247			bool is_ima = false;
   248	
   249			if (strcmp(xattr->name, XATTR_NAME_IMA) == 0)
   250				is_ima = true;
   251	
   252			/*
   253			 * Skip non-enabled xattrs for locally calculated
   254			 * signatures/HMACs.
   255			 */
   256			if (type != EVM_XATTR_PORTABLE_DIGSIG && !xattr->enabled)
   257				continue;
   258	
   259			if ((req_xattr_name && req_xattr_value)
   260			    && !strcmp(xattr->name, req_xattr_name)) {
   261				error = 0;
   262				crypto_shash_update(desc, (const u8 *)req_xattr_value,
   263						     req_xattr_value_len);
   264				if (is_ima)
   265					ima_present = true;
   266	
   267				dump_security_xattr(req_xattr_name,
   268						    req_xattr_value,
   269						    req_xattr_value_len);
   270				continue;
   271			}
   272			size = vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
   273						  &xattr_value, xattr_size, GFP_NOFS);
   274			if (size == -ENOMEM) {
   275				error = -ENOMEM;
   276				goto out;
   277			}
   278			if (size < 0)
   279				continue;
   280	
   281			user_space_size = vfs_getxattr(&nop_mnt_idmap, dentry,
   282						       xattr->name, NULL, 0);
   283			if (user_space_size != size)
   284				pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
   285					 dentry->d_name.name, xattr->name, size,
   286					 user_space_size);
   287			error = 0;
   288			xattr_size = size;
   289			crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
   290			if (is_ima)
   291				ima_present = true;
   292	
   293			dump_security_xattr(xattr->name, xattr_value, xattr_size);
   294		}
   295		hmac_add_misc(desc, inode, type, data->digest);
   296	
   297		/* Portable EVM signatures must include an IMA hash */
   298		if (type == EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
   299			error = -EPERM;
   300	out:
   301		kfree(xattr_value);
   302		kfree(desc);
   303		return error;
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

