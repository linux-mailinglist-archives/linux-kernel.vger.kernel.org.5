Return-Path: <linux-kernel+bounces-112386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B595B88792F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 16:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA991F2197A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 15:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37362405FB;
	Sat, 23 Mar 2024 15:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mx5NN6Pz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67BD25568
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 15:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711206546; cv=none; b=lL5hVQRaPmOdALsUSk0DP8rBY295wEe2FMzuTuFq/CY3DDe50ob4mURr1ZrZRh6XMoHDJJvEgke8WTvZNhFtSSt80JiKM7sjWqLca1C8VfMYqFHmQyd1AAAQvsMLMZzHs64G2kLAtdVqc0OodCw/5Mr0TdMNV0VuYh2JA7PiDOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711206546; c=relaxed/simple;
	bh=YztTkRP1Rs6RE6uoc2ayBCPwYuZ4QDIWawY64DRegsI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EBEqHEstIm40Y8+TIiNkcPRSS1Dx+GZLF8k9mYMzBnuGAnwR1Oex7o4KA3an7p6ou6gTwezkfid8yCGyw0TvhDoCcMr7KhXME7OphTY8gIg0aHlqDPRYJaSHY1uEmxQnh+jQXvMfINMxYf+i70X2g315QWIFDVjrnQMAQV4HOsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mx5NN6Pz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711206544; x=1742742544;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YztTkRP1Rs6RE6uoc2ayBCPwYuZ4QDIWawY64DRegsI=;
  b=mx5NN6PzEbKd9K1gShQ/CtxpsrvjeN2ROkjx9xuKXXDNM+k7A8io55sX
   /yCB3SUIzio6b0VlIqA6z+JytuUpth1YZ0L4DMXSvniRvUmhigQaltIA1
   QUk064ofEfSHIjLTqtR61MjizYdDvM9scrJ3lbzdsBq+mKWzUzAG3s04d
   a7VPmBtCZqeqNw9uUf5/8okGDvzlhfGJkb6k13dieUDNxzBVenSOvWJUK
   x3Py1YUZ1uwCMQsMW1MYdd45hbZcYD0oPW1B8L1hEiXTcsg3QIgfjZS6c
   4LDvgz2RTk3z4554Nj3vB8UkhTdeziW2ZhBXo+6C8gdwHKMLYjx9nxl9K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11021"; a="10024512"
X-IronPort-AV: E=Sophos;i="6.07,149,1708416000"; 
   d="scan'208";a="10024512"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2024 08:09:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,149,1708416000"; 
   d="scan'208";a="38313816"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 23 Mar 2024 08:09:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ro2zT-000LF9-1r;
	Sat, 23 Mar 2024 15:08:59 +0000
Date: Sat, 23 Mar 2024 23:08:59 +0800
From: kernel test robot <lkp@intel.com>
To: Dave Chinner <dchinner@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Chandan Babu R <chandanbabu@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: fs/xfs/libxfs/xfs_dir2.c:336:15-22: WARNING opportunity for kmemdup
Message-ID: <202403232305.aLpp8AlJ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bfa8f18691ed2e978e4dd51190569c434f93e268
commit: f078d4ea827607867d42fb3b2ef907caf86ce49d xfs: convert kmem_alloc() to kmalloc()
date:   6 weeks ago
config: x86_64-randconfig-103-20240323 (https://download.01.org/0day-ci/archive/20240323/202403232305.aLpp8AlJ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403232305.aLpp8AlJ-lkp@intel.com/

cocci warnings: (new ones prefixed by >>)
>> fs/xfs/libxfs/xfs_dir2.c:336:15-22: WARNING opportunity for kmemdup

vim +336 fs/xfs/libxfs/xfs_dir2.c

   319	
   320	/*
   321	 * If doing a CI lookup and case-insensitive match, dup actual name into
   322	 * args.value. Return EEXIST for success (ie. name found) or an error.
   323	 */
   324	int
   325	xfs_dir_cilookup_result(
   326		struct xfs_da_args *args,
   327		const unsigned char *name,
   328		int		len)
   329	{
   330		if (args->cmpresult == XFS_CMP_DIFFERENT)
   331			return -ENOENT;
   332		if (args->cmpresult != XFS_CMP_CASE ||
   333						!(args->op_flags & XFS_DA_OP_CILOOKUP))
   334			return -EEXIST;
   335	
 > 336		args->value = kmalloc(len, GFP_NOFS | __GFP_RETRY_MAYFAIL);
   337		if (!args->value)
   338			return -ENOMEM;
   339	
   340		memcpy(args->value, name, len);
   341		args->valuelen = len;
   342		return -EEXIST;
   343	}
   344	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

