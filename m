Return-Path: <linux-kernel+bounces-109302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DC2881764
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BBC5285304
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4AF85299;
	Wed, 20 Mar 2024 18:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yre7rij2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281497E761
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960041; cv=none; b=Hu6NMp7+jOPbRwUKARqw5B8wHvQhA5kUk9TZCi8IM15PfyhmfJkbv6UJ5UesT4b4TF0NORtBoBBJAbu26PCdZBJapFVM3qNa9oj9N8oIoMjt35f2CaoExNBu2+ulOfz3dT2wWAcxR5llSFxyX3ImZM60bdDHLwSchurjYwzf0P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960041; c=relaxed/simple;
	bh=Xs4PBq6qNCG3M1b/48Y2i69dxtc4czrZRuoQL2YN7VY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hYXV7ibcvk3frNM0psAZk/cauH/p13VPUjyMaZafar4nozGxBriWTH+3BGxSYgzVGs9fxsT782cLTRxGW46eMCMXRF+y9bV+geRBZAq4YNInYhuorqWwtPbT8TBUxlvK7OUrxQsxv93qCvdvM/d8ZBGryMR2tCBGIvmvXbuVg7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yre7rij2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710960040; x=1742496040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Xs4PBq6qNCG3M1b/48Y2i69dxtc4czrZRuoQL2YN7VY=;
  b=Yre7rij2l+gap+jCCaHlQMej9TnE9XOacqdS8Kcety+9DofksuvZ9LZP
   QxNIcrXg9ZXX/oyBpvMRK0E8c1RL2d7e6it6QSFM6CHrgICKAiFLEtY56
   AseFg26w8aKEd3w98qrHe3mxKrYz5VUt7/UJprSoD9Vbf1tZNOAKii0mB
   YyC7VXkfTXcryD7n22TZswM+aN8jNio+jSpR667JSY9z9G4iZ3VPVnxG/
   NhJu2AMWvJ2/EM0l++noVmVaHQoxHCZu75v6e/61G0DOr2YDVx3Zw/ENK
   Ovfz8h2cqXHQ5mpldWylfSt+wDgPanbWoGn26YfSxUMlq2e6fNd31uL6+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5787714"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="5787714"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 11:38:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="18966972"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 20 Mar 2024 11:38:21 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rn0pO-000Iqj-0h;
	Wed, 20 Mar 2024 18:38:18 +0000
Date: Thu, 21 Mar 2024 02:38:15 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Chinner <dchinner@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: fs/xfs/libxfs/xfs_attr_leaf.c:1061:13-20: WARNING opportunity for
 kmemdup
Message-ID: <202403210204.LPPBJMhf-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   a4145ce1e7bc247fd6f2846e8699473448717b37
commit: f078d4ea827607867d42fb3b2ef907caf86ce49d xfs: convert kmem_alloc() to kmalloc()
date:   5 weeks ago
config: x86_64-randconfig-104-20240320 (https://download.01.org/0day-ci/archive/20240321/202403210204.LPPBJMhf-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403210204.LPPBJMhf-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/xfs/libxfs/xfs_attr_leaf.c:1061:13-20: WARNING opportunity for kmemdup

vim +1061 fs/xfs/libxfs/xfs_attr_leaf.c

  1039	
  1040	/*
  1041	 * Convert a leaf attribute list to shortform attribute list
  1042	 */
  1043	int
  1044	xfs_attr3_leaf_to_shortform(
  1045		struct xfs_buf		*bp,
  1046		struct xfs_da_args	*args,
  1047		int			forkoff)
  1048	{
  1049		struct xfs_attr_leafblock *leaf;
  1050		struct xfs_attr3_icleaf_hdr ichdr;
  1051		struct xfs_attr_leaf_entry *entry;
  1052		struct xfs_attr_leaf_name_local *name_loc;
  1053		struct xfs_da_args	nargs;
  1054		struct xfs_inode	*dp = args->dp;
  1055		char			*tmpbuffer;
  1056		int			error;
  1057		int			i;
  1058	
  1059		trace_xfs_attr_leaf_to_sf(args);
  1060	
> 1061		tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
  1062		if (!tmpbuffer)
  1063			return -ENOMEM;
  1064	
  1065		memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
  1066	
  1067		leaf = (xfs_attr_leafblock_t *)tmpbuffer;
  1068		xfs_attr3_leaf_hdr_from_disk(args->geo, &ichdr, leaf);
  1069		entry = xfs_attr3_leaf_entryp(leaf);
  1070	
  1071		/* XXX (dgc): buffer is about to be marked stale - why zero it? */
  1072		memset(bp->b_addr, 0, args->geo->blksize);
  1073	
  1074		/*
  1075		 * Clean out the prior contents of the attribute list.
  1076		 */
  1077		error = xfs_da_shrink_inode(args, 0, bp);
  1078		if (error)
  1079			goto out;
  1080	
  1081		if (forkoff == -1) {
  1082			/*
  1083			 * Don't remove the attr fork if this operation is the first
  1084			 * part of a attr replace operations. We're going to add a new
  1085			 * attr immediately, so we need to keep the attr fork around in
  1086			 * this case.
  1087			 */
  1088			if (!(args->op_flags & XFS_DA_OP_REPLACE)) {
  1089				ASSERT(xfs_has_attr2(dp->i_mount));
  1090				ASSERT(dp->i_df.if_format != XFS_DINODE_FMT_BTREE);
  1091				xfs_attr_fork_remove(dp, args->trans);
  1092			}
  1093			goto out;
  1094		}
  1095	
  1096		xfs_attr_shortform_create(args);
  1097	
  1098		/*
  1099		 * Copy the attributes
  1100		 */
  1101		memset((char *)&nargs, 0, sizeof(nargs));
  1102		nargs.geo = args->geo;
  1103		nargs.dp = dp;
  1104		nargs.total = args->total;
  1105		nargs.whichfork = XFS_ATTR_FORK;
  1106		nargs.trans = args->trans;
  1107		nargs.op_flags = XFS_DA_OP_OKNOENT;
  1108	
  1109		for (i = 0; i < ichdr.count; entry++, i++) {
  1110			if (entry->flags & XFS_ATTR_INCOMPLETE)
  1111				continue;	/* don't copy partial entries */
  1112			if (!entry->nameidx)
  1113				continue;
  1114			ASSERT(entry->flags & XFS_ATTR_LOCAL);
  1115			name_loc = xfs_attr3_leaf_name_local(leaf, i);
  1116			nargs.name = name_loc->nameval;
  1117			nargs.namelen = name_loc->namelen;
  1118			nargs.value = &name_loc->nameval[nargs.namelen];
  1119			nargs.valuelen = be16_to_cpu(name_loc->valuelen);
  1120			nargs.hashval = be32_to_cpu(entry->hashval);
  1121			nargs.attr_filter = entry->flags & XFS_ATTR_NSP_ONDISK_MASK;
  1122			xfs_attr_shortform_add(&nargs, forkoff);
  1123		}
  1124		error = 0;
  1125	
  1126	out:
  1127		kmem_free(tmpbuffer);
  1128		return error;
  1129	}
  1130	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

