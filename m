Return-Path: <linux-kernel+bounces-60138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A967D85009F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 00:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6087F1F26358
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF122374FA;
	Fri,  9 Feb 2024 23:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E2SynAlz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF15F37149
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707520491; cv=none; b=iWsqh4Mh6FNy/5bwkgd0WxVSSQgJxQ2cIK3D1FdJLpTs0CfJdF+y6E/Yi7W3ZWABL98W0mEuJU+e+YbugCVIVVpNofNkpjVtLVBk0kTZuSXef2110qyWal2lPv6kms7owGdMAXxCcfutah1auduSfLdKVvEajwxgrRlI+/5cPX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707520491; c=relaxed/simple;
	bh=jdcg4DWF8JQDI25uT7aDRCN2nQorXmzFpgA+OiAtN/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IO46pdQac86pq5PDo9EuPj1YhSaDSdgWysU7UASMaj0r1ZkEPwkIJEvmcAmAbwxYFBetqw4wF8vpYsy8ckG54+r9kGeng4+eehIYm04l1WF33d8dblR6d4aSjIb21Q36SXqPN9C66L5gFizZd4UnqNawwDiZwFBixOHUmDgo1tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E2SynAlz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707520489; x=1739056489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jdcg4DWF8JQDI25uT7aDRCN2nQorXmzFpgA+OiAtN/c=;
  b=E2SynAlzwSbKbl5zLo2wy0XsszUhgt0CFvlHJOPGvopWjmgQwBu0CaXM
   pJTx3Ns/sJY1h9zp3jJX3FUDUMGAobNTGMt6sKTPOUAaCVxfBGOV55DCi
   J8YABBCdnSvvQAYXqjLdV5BZ9R0E3fJxzPESomVAhpNfj6viPU5CxOAkZ
   FH4veFAUDUNHN5lfVzNSKxpzUPrsODHNHIXTeE6mDnCqMBJyLxAjEsFBS
   D17iHxLm7UkcKrTOxAfBOXxI0iBXNlFlAdPybfmNpjfsPsRl/PsKIrbYr
   fm34CS4D9CDaY35o5cZW1XSr0wat6jKhRL4YYDn96AkMPgD/lU6lWpQR9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="4495780"
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="4495780"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 15:14:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,258,1701158400"; 
   d="scan'208";a="2355567"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 09 Feb 2024 15:14:45 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYa4w-0005C2-35;
	Fri, 09 Feb 2024 23:14:42 +0000
Date: Sat, 10 Feb 2024 07:14:27 +0800
From: kernel test robot <lkp@intel.com>
To: Oscar Salvador <osalvador@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>, Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: Re: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
Message-ID: <202402100636.5lFPAlbB-lkp@intel.com>
References: <20240208234539.19113-4-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208234539.19113-4-osalvador@suse.de>

Hi Oscar,

kernel test robot noticed the following build warnings:

[auto build test WARNING on akpm-mm/mm-nonmm-unstable]
[also build test WARNING on linus/master v6.8-rc3]
[cannot apply to akpm-mm/mm-everything next-20240209]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Oscar-Salvador/lib-stackdepot-Move-stack_record-struct-definition-into-the-header/20240209-074611
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-nonmm-unstable
patch link:    https://lore.kernel.org/r/20240208234539.19113-4-osalvador%40suse.de
patch subject: [PATCH v7 3/4] mm,page_owner: Display all stacks and their count
config: x86_64-randconfig-121-20240209 (https://download.01.org/0day-ci/archive/20240210/202402100636.5lFPAlbB-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240210/202402100636.5lFPAlbB-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402100636.5lFPAlbB-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> mm/page_owner.c:828:30: sparse: sparse: symbol 'page_owner_stack_operations' was not declared. Should it be static?
   mm/page_owner.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/xarray.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/page_owner_stack_operations +828 mm/page_owner.c

   827	
 > 828	const struct file_operations page_owner_stack_operations = {
   829		.open		= page_owner_stack_open,
   830		.read		= seq_read,
   831		.llseek		= seq_lseek,
   832		.release	= seq_release,
   833	};
   834	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

