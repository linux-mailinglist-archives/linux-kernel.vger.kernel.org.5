Return-Path: <linux-kernel+bounces-102382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C87EA87B16F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0400E1C29E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A12C535B8;
	Wed, 13 Mar 2024 18:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P2mYGp7L"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585C10F1
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355565; cv=none; b=gThUF7NgjHjVz9m3/Bym0ggeDVIsTrp2QzfAWxupKFe/8GPLjfZsxck/JaYbf/TZVU5m3V3FUZ8kMSm7jloZ0CenvpDv0bMf8j4NWHHLB74ti6/Qe+dj6CKB9is7Q5FBX2yn7Po+bPWG7yt4mTc8FDLt/h4bwwx0/pGly1pAXr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355565; c=relaxed/simple;
	bh=PjSs+lTdGDKvwVF7H5qvZEpDpoXFchfAOD+tMuxixI4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jjGhVwpEtmJ/Um9daZFre6bxzwboam/IJPuhIh3aU54lcK8VBxcuT/nVy9tbTCzwlyX3uTk4OxwJfE+2wcqNEaDSkGzzetQbBFh/xe1qq8dOOAFfQ/1gN1Y1IXhEjoUH4/FOgoDdt8ZoyCfLsn3yuIRKLJfJ9gFgzhKiTKR7rAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P2mYGp7L; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710355564; x=1741891564;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PjSs+lTdGDKvwVF7H5qvZEpDpoXFchfAOD+tMuxixI4=;
  b=P2mYGp7LOjzSK+PyMykDOL1EEQjMcZcCd6TcS0M3B2pxQz8IjpQv2h08
   VfoMLWWjjyHLcrcdluqXH/04oxHLoeItX+tvB/oMw8WfY1io+wMSzGwGj
   8nmJjFSr7gpYRIaBMqFSuWUadIaqlPGl+92bPO1TafLgwrkw63bIzqZ1k
   vPGiOKk3JmPMMvhZIif1QJAcPgGcSRs301lK8v2p1hhHi/OPY3vAXeuY+
   D0+3JwC4M6Yr3Av3GSaHbNT/x9SZuRzTJM8qGYDOCclEsIrDdWU/4G/j7
   XZmUlShmyhkU4I09PBTQVUr3ioOSSkL14gQrzapo08Qidh1igsyrh4nJo
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="4998028"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="4998028"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 11:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="12478787"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 13 Mar 2024 11:46:01 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkTby-000CgT-23;
	Wed, 13 Mar 2024 18:45:58 +0000
Date: Thu, 14 Mar 2024 02:45:30 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Herve Codina <herve.codina@bootlin.com>
Subject: WARNING: modpost: vmlinux: section mismatch in reference:
 find_next_bit+0x14 (section: .text.unlikely) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <202403140236.HDGbPm2J-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b0546776ad3f332e215cebc0b063ba4351971cca
commit: de5f84338970815b9fdd3497a975fb572d11e0b5 lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
date:   2 days ago
config: xtensa-randconfig-s031-20211010 (https://download.01.org/0day-ci/archive/20240314/202403140236.HDGbPm2J-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240314/202403140236.HDGbPm2J-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202403140236.HDGbPm2J-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x3c (section: .text.unlikely) -> initcall_level_names (section: .init.data)
>> WARNING: modpost: vmlinux: section mismatch in reference: find_next_bit+0x14 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

