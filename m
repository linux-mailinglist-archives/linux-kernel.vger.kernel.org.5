Return-Path: <linux-kernel+bounces-63394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30861852EBC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF7F7283A18
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60983335DB;
	Tue, 13 Feb 2024 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X8vvQDaR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888402C697
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822291; cv=none; b=I2TzMMPyH3QuY1DqDq28F+LXJqXkMfQYqgf6QUn9gIvFXQJ0T6/rBz9L3kZFwlCQJm60rnjfGyxAjH//ZaHmTWBqXZxPgX3XNkNy2Ikn1JCcnnBtXx56CtwpsDs+cxqA3br2Z5OkacKlKUMg2QmEsXz59WYoN8f2YQM2OTaITgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822291; c=relaxed/simple;
	bh=EYCv+DL+eV5ThLL4UKQHtVxj82o1lGzydAly5t5mYS4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kpANkNGvBP6JtfWEVfL5xbPwBtVUZDKCKoSwrM2+TUdSh0w4E8oyXlliFniIc+L5M3pO0q9DqQztTTpNIcf4ZdjTSIpX+9pMUpqlK+UM3N7nJi/vJXiP+HIm1i7X6VWZ3V3AJ6Ww6pLLElJ8XPcFYF4t0Yu5liZwcVus/DHnZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X8vvQDaR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707822289; x=1739358289;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EYCv+DL+eV5ThLL4UKQHtVxj82o1lGzydAly5t5mYS4=;
  b=X8vvQDaRgWW6OrUBougyMJij6wysEK4jw9mH6+/5bBANEsei+0J3moJ1
   XKrwxqzTBd8FOgtR+mR5/34A+cMjy7WuNGLWKB7LYY/YKaNTi/mWRfvu/
   9zW4Qx3EHoSVhHMHkp9ZDYNNp2QDiu3faB/bBTNw7tzw8JX7N10AX4h48
   8yFz3buiuooscf9p7aQUBPt9r7B8kVtNApibpxqIrutSQtjR2mmqTeuWI
   jL67/NlpaiTQPD7ISr/OR8xlW0LJFhhEVsbiypKhlN5EpSgijbvOj0fHj
   K7HamPvmUasb6QVJbqAi4Qh6Xl70V14LkMMq1sPaI6W1W66cnZdHf7QJ5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5641762"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="5641762"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 03:04:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935325723"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935325723"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 03:04:46 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rZqai-0007gc-0N;
	Tue, 13 Feb 2024 11:04:44 +0000
Date: Tue, 13 Feb 2024 19:04:43 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: powerpc-linux-ld: debug_vm_pgtable.c:undefined reference to
 `pud_set_huge'
Message-ID: <202402131836.OU1TDuoi-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c664e16bb1ba1c8cf1d7ecf3df5fd83bbb8ac15a
commit: b49e578b9314db051da0ad72bba24094193f9bd0 Revert "powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLAGS() with asm goto"
date:   7 months ago
config: powerpc-buildonly-randconfig-r001-20230115 (https://download.01.org/0day-ci/archive/20240213/202402131836.OU1TDuoi-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240213/202402131836.OU1TDuoi-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402131836.OU1TDuoi-lkp@intel.com/

All errors (new ones prefixed by >>):

   powerpc-linux-ld: mm/vmalloc.o: in function `vmap_range_noflush':
   vmalloc.c:(.text+0xf84): undefined reference to `pmd_free_pte_page'
   powerpc-linux-ld: vmalloc.c:(.text+0xfa0): undefined reference to `pmd_set_huge'
   powerpc-linux-ld: mm/debug_vm_pgtable.o: in function `debug_vm_pgtable':
   debug_vm_pgtable.c:(.init.text+0xb50): undefined reference to `pmd_set_huge'
>> powerpc-linux-ld: debug_vm_pgtable.c:(.init.text+0xc40): undefined reference to `pud_set_huge'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

