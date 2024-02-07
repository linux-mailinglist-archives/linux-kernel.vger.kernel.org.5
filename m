Return-Path: <linux-kernel+bounces-55969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0184C449
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E727BB24869
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91E614F98;
	Wed,  7 Feb 2024 05:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i885OU8q"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0B3134A8;
	Wed,  7 Feb 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707282346; cv=none; b=nMRLTk3FEsmjhS0AGFjfuAINNEsP1qjCLOg8Px5CRLzI8QgtuGvvWIpfvp69rpSp2O3p0TbBnVwSQS+2NAEw4OiF5OxNjm7HbxjZfQROXLhArbeF88o0SVvUwDBSqJ2bh0jCBe6vcZwA6mbd7aFCxjEw2kzEB18BuG8UPuC4ZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707282346; c=relaxed/simple;
	bh=TNbOIHNIUAkklbSCkVxhZ2LYHAebQaHbRzHIdmiIxOE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SAGfcY0FVGojsOSHJ4sYIHLpyQjCewdOplZLuYWpkHpKcW1dZbh2d1DS5lfCrq8rNSf2SvqrPqZgTRjyTx9SuqS79+rYp0bayEO/EzLsDBfY1HWtphGUm91lMVhUSO48Oy6F3DgUtDOQbt8bvF84qQlBb3Stt0HkwF/BhkD179c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i885OU8q; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707282344; x=1738818344;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TNbOIHNIUAkklbSCkVxhZ2LYHAebQaHbRzHIdmiIxOE=;
  b=i885OU8qPNVRKcXAbdydWWBweKPmNqV8iGCOeMytqUeWr+x3d5wLNPQS
   W2cFWBAM0ewiVLiv8NlKB4uTPFjUnK4zgrtC+c2GZfaXZ9HLbfx39Lewp
   qp8+W0LRHM/fz13lKT1m4kyasSJ4vizHbFY2w+wpB3i2OFXIoXTQeQSWH
   b15ye7Hz1xsB62OZ2EIdsIafwqN9tbk0FH7RsJDz4LL6aGbjIrVQzMpqQ
   mToUbOPnhcxTao2aCb1Rjk3KJKCS04cEm7e3Mnyl8ldYlIH59Zuk7MusE
   GcWqOCkTc730dzYqwoKy8ZQ6zITYE8OxEWaY5fspwZY/8wmzNc+De2Cso
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="12268896"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="12268896"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 21:05:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="824400199"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="824400199"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Feb 2024 21:05:38 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rXa7s-0002E1-0v;
	Wed, 07 Feb 2024 05:05:36 +0000
Date: Wed, 7 Feb 2024 13:04:59 +0800
From: kernel test robot <lkp@intel.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-unionfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, paul@paul-moore.com,
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com,
	roberto.sassu@huawei.com, amir73il@gmail.com, brauner@kernel.org,
	miklos@szeredi.hu, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v2 4/9] ima: Reset EVM status upon detecting changes to
 the real file
Message-ID: <202402071226.lXIiGtbl-lkp@intel.com>
References: <20240205182506.3569743-5-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205182506.3569743-5-stefanb@linux.ibm.com>

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
patch link:    https://lore.kernel.org/r/20240205182506.3569743-5-stefanb%40linux.ibm.com
patch subject: [PATCH v2 4/9] ima: Reset EVM status upon detecting changes to the real file
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20240207/202402071226.lXIiGtbl-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240207/202402071226.lXIiGtbl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402071226.lXIiGtbl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> security/integrity/ima/ima_main.c:303:9: error: use of undeclared identifier 'D_REAL_METADATA'
     303 |                                                          D_REAL_METADATA)))
         |                                                          ^
   1 error generated.


vim +/D_REAL_METADATA +303 security/integrity/ima/ima_main.c

   207	
   208	static int process_measurement(struct file *file, const struct cred *cred,
   209				       u32 secid, char *buf, loff_t size, int mask,
   210				       enum ima_hooks func)
   211	{
   212		struct inode *real_inode, *inode = file_inode(file);
   213		struct integrity_iint_cache *iint = NULL;
   214		struct ima_template_desc *template_desc = NULL;
   215		char *pathbuf = NULL;
   216		char filename[NAME_MAX];
   217		const char *pathname = NULL;
   218		int rc = 0, action, must_appraise = 0;
   219		int pcr = CONFIG_IMA_MEASURE_PCR_IDX;
   220		struct evm_ima_xattr_data *xattr_value = NULL;
   221		struct modsig *modsig = NULL;
   222		int xattr_len = 0;
   223		bool violation_check;
   224		enum hash_algo hash_algo;
   225		unsigned int allowed_algos = 0;
   226	
   227		if (!ima_policy_flag || !S_ISREG(inode->i_mode))
   228			return 0;
   229	
   230		/* Return an IMA_MEASURE, IMA_APPRAISE, IMA_AUDIT action
   231		 * bitmask based on the appraise/audit/measurement policy.
   232		 * Included is the appraise submask.
   233		 */
   234		action = ima_get_action(file_mnt_idmap(file), inode, cred, secid,
   235					mask, func, &pcr, &template_desc, NULL,
   236					&allowed_algos);
   237		violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
   238				    func == MMAP_CHECK_REQPROT) &&
   239				   (ima_policy_flag & IMA_MEASURE));
   240		if (!action && !violation_check)
   241			return 0;
   242	
   243		must_appraise = action & IMA_APPRAISE;
   244	
   245		/*  Is the appraise rule hook specific?  */
   246		if (action & IMA_FILE_APPRAISE)
   247			func = FILE_CHECK;
   248	
   249		inode_lock(inode);
   250	
   251		if (action) {
   252			iint = integrity_inode_get(inode);
   253			if (!iint)
   254				rc = -ENOMEM;
   255		}
   256	
   257		if (!rc && violation_check)
   258			ima_rdwr_violation_check(file, iint, action & IMA_MEASURE,
   259						 &pathbuf, &pathname, filename);
   260	
   261		inode_unlock(inode);
   262	
   263		if (rc)
   264			goto out;
   265		if (!action)
   266			goto out;
   267	
   268		mutex_lock(&iint->mutex);
   269	
   270		if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
   271			/* reset appraisal flags if ima_inode_post_setattr was called */
   272			iint->flags &= ~(IMA_APPRAISE | IMA_APPRAISED |
   273					 IMA_APPRAISE_SUBMASK | IMA_APPRAISED_SUBMASK |
   274					 IMA_NONACTION_FLAGS);
   275	
   276		/*
   277		 * Re-evaulate the file if either the xattr has changed or the
   278		 * kernel has no way of detecting file change on the filesystem.
   279		 * (Limited to privileged mounted filesystems.)
   280		 */
   281		if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
   282		    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
   283		     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
   284		     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
   285			iint->flags &= ~IMA_DONE_MASK;
   286			iint->measured_pcrs = 0;
   287		}
   288	
   289		/*
   290		 * Detect and re-evaluate changes made to the inode holding file data.
   291		 */
   292		real_inode = d_real_inode(file_dentry(file));
   293		if (real_inode != inode &&
   294		    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
   295			if (!IS_I_VERSION(real_inode) ||
   296			    real_inode->i_sb->s_dev != iint->real_dev ||
   297			    real_inode->i_ino != iint->real_ino ||
   298			    !inode_eq_iversion(real_inode, iint->version)) {
   299				iint->flags &= ~IMA_DONE_MASK;
   300				iint->measured_pcrs = 0;
   301	
   302				if (real_inode == d_inode(d_real(file_dentry(file),
 > 303								 D_REAL_METADATA)))
   304					evm_reset_cache_status(file_dentry(file), iint);
   305			}
   306		}
   307	
   308		/* Determine if already appraised/measured based on bitmask
   309		 * (IMA_MEASURE, IMA_MEASURED, IMA_XXXX_APPRAISE, IMA_XXXX_APPRAISED,
   310		 *  IMA_AUDIT, IMA_AUDITED)
   311		 */
   312		iint->flags |= action;
   313		action &= IMA_DO_MASK;
   314		action &= ~((iint->flags & (IMA_DONE_MASK ^ IMA_MEASURED)) >> 1);
   315	
   316		/* If target pcr is already measured, unset IMA_MEASURE action */
   317		if ((action & IMA_MEASURE) && (iint->measured_pcrs & (0x1 << pcr)))
   318			action ^= IMA_MEASURE;
   319	
   320		/* HASH sets the digital signature and update flags, nothing else */
   321		if ((action & IMA_HASH) &&
   322		    !(test_bit(IMA_DIGSIG, &iint->atomic_flags))) {
   323			xattr_len = ima_read_xattr(file_dentry(file),
   324						   &xattr_value, xattr_len);
   325			if ((xattr_value && xattr_len > 2) &&
   326			    (xattr_value->type == EVM_IMA_XATTR_DIGSIG))
   327				set_bit(IMA_DIGSIG, &iint->atomic_flags);
   328			iint->flags |= IMA_HASHED;
   329			action ^= IMA_HASH;
   330			set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
   331		}
   332	
   333		/* Nothing to do, just return existing appraised status */
   334		if (!action) {
   335			if (must_appraise) {
   336				rc = mmap_violation_check(func, file, &pathbuf,
   337							  &pathname, filename);
   338				if (!rc)
   339					rc = ima_get_cache_status(iint, func);
   340			}
   341			goto out_locked;
   342		}
   343	
   344		if ((action & IMA_APPRAISE_SUBMASK) ||
   345		    strcmp(template_desc->name, IMA_TEMPLATE_IMA_NAME) != 0) {
   346			/* read 'security.ima' */
   347			xattr_len = ima_read_xattr(file_dentry(file),
   348						   &xattr_value, xattr_len);
   349	
   350			/*
   351			 * Read the appended modsig if allowed by the policy, and allow
   352			 * an additional measurement list entry, if needed, based on the
   353			 * template format and whether the file was already measured.
   354			 */
   355			if (iint->flags & IMA_MODSIG_ALLOWED) {
   356				rc = ima_read_modsig(func, buf, size, &modsig);
   357	
   358				if (!rc && ima_template_has_modsig(template_desc) &&
   359				    iint->flags & IMA_MEASURED)
   360					action |= IMA_MEASURE;
   361			}
   362		}
   363	
   364		hash_algo = ima_get_hash_algo(xattr_value, xattr_len);
   365	
   366		rc = ima_collect_measurement(iint, file, buf, size, hash_algo, modsig);
   367		if (rc != 0 && rc != -EBADF && rc != -EINVAL)
   368			goto out_locked;
   369	
   370		if (!pathbuf)	/* ima_rdwr_violation possibly pre-fetched */
   371			pathname = ima_d_path(&file->f_path, &pathbuf, filename);
   372	
   373		if (action & IMA_MEASURE)
   374			ima_store_measurement(iint, file, pathname,
   375					      xattr_value, xattr_len, modsig, pcr,
   376					      template_desc);
   377		if (rc == 0 && (action & IMA_APPRAISE_SUBMASK)) {
   378			rc = ima_check_blacklist(iint, modsig, pcr);
   379			if (rc != -EPERM) {
   380				inode_lock(inode);
   381				rc = ima_appraise_measurement(func, iint, file,
   382							      pathname, xattr_value,
   383							      xattr_len, modsig);
   384				inode_unlock(inode);
   385			}
   386			if (!rc)
   387				rc = mmap_violation_check(func, file, &pathbuf,
   388							  &pathname, filename);
   389		}
   390		if (action & IMA_AUDIT)
   391			ima_audit_measurement(iint, pathname);
   392	
   393		if ((file->f_flags & O_DIRECT) && (iint->flags & IMA_PERMIT_DIRECTIO))
   394			rc = 0;
   395	
   396		/* Ensure the digest was generated using an allowed algorithm */
   397		if (rc == 0 && must_appraise && allowed_algos != 0 &&
   398		    (allowed_algos & (1U << hash_algo)) == 0) {
   399			rc = -EACCES;
   400	
   401			integrity_audit_msg(AUDIT_INTEGRITY_DATA, file_inode(file),
   402					    pathname, "collect_data",
   403					    "denied-hash-algorithm", rc, 0);
   404		}
   405	out_locked:
   406		if ((mask & MAY_WRITE) && test_bit(IMA_DIGSIG, &iint->atomic_flags) &&
   407		     !(iint->flags & IMA_NEW_FILE))
   408			rc = -EACCES;
   409		mutex_unlock(&iint->mutex);
   410		kfree(xattr_value);
   411		ima_free_modsig(modsig);
   412	out:
   413		if (pathbuf)
   414			__putname(pathbuf);
   415		if (must_appraise) {
   416			if (rc && (ima_appraise & IMA_APPRAISE_ENFORCE))
   417				return -EACCES;
   418			if (file->f_mode & FMODE_WRITE)
   419				set_bit(IMA_UPDATE_XATTR, &iint->atomic_flags);
   420		}
   421		return 0;
   422	}
   423	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

