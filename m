Return-Path: <linux-kernel+bounces-25377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D82482CED5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E2611C20F73
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC7A16439;
	Sat, 13 Jan 2024 21:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XLecsp/h"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F216AB6
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 21:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705182237; x=1736718237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bBcS14m9y6v0leXUixwYnMiFcxzv1qlwb01Nb1b8Cq0=;
  b=XLecsp/huJP4ICF5vO0EB10I6DaMARVmX2aa7g0Pm6fWL9B5AGZjj5fO
   AfTDcb5y1mAq8DZbkVj8eVXt/jN5b/YFt91RuI47LwRSKg6OvRcsFsUh0
   zwKgD5dXjY3D9XehVEab/rBg+m/0GkRwLFC1npPpVbtdza90qqjn+sYDx
   rHYkRtc/y/hOZYsoXh47OyTE2CHOs9wpYa1mxy8V7TPwdmU/lFTJ0Ac85
   5NRzuKgOfvr+N9QjERU7ZlkABSRAAT7/XgAIZQMHyq9Km5AVC3EqQ8Tyj
   +GzjvMiBwazQLeF6KLpyKV3Aw2Et59aAGqoPs9941EwzW8PayZYB07v3O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="485575132"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="485575132"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 13:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="783404768"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="783404768"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 13 Jan 2024 13:43:51 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOlnB-000Avo-0b;
	Sat, 13 Jan 2024 21:43:49 +0000
Date: Sun, 14 Jan 2024 05:43:09 +0800
From: kernel test robot <lkp@intel.com>
To: Coiby Xu <coxu@redhat.com>, kexec@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, Ondrej Kozina <okozina@redhat.com>,
	Milan Broz <gmazyland@gmail.com>,
	Thomas Staudt <tstaudt@de.ibm.com>,
	Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
	Kairui Song <ryncsn@gmail.com>, dm-devel@redhat.com,
	Jan Pazdziora <jpazdziora@redhat.com>,
	Pingfan Liu <kernelfans@gmail.com>, Baoquan He <bhe@redhat.com>,
	Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
	x86@kernel.org, Dave Hansen <dave.hansen@intel.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
Message-ID: <202401140506.JQu60mgM-lkp@intel.com>
References: <20240110071522.1308935-3-coxu@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110071522.1308935-3-coxu@redhat.com>

Hi Coiby,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/x86/core]
[also build test WARNING on v6.7]
[cannot apply to linus/master next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240110-151859
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240110071522.1308935-3-coxu%40redhat.com
patch subject: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
config: x86_64-randconfig-123-20240114 (https://download.01.org/0day-ci/archive/20240114/202401140506.JQu60mgM-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401140506.JQu60mgM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140506.JQu60mgM-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> kernel/crash_dump_dm_crypt.c:8:6: sparse: sparse: symbol 'wipe_dm_crypt_key' was not declared. Should it be static?
   kernel/crash_dump_dm_crypt.c: note: in included file (through include/linux/mmzone.h, include/linux/gfp.h, include/linux/mm.h, ...):
   include/linux/page-flags.h:242:46: sparse: sparse: self-comparison always evaluates to false

vim +/wipe_dm_crypt_key +8 kernel/crash_dump_dm_crypt.c

     7	
   > 8	void wipe_dm_crypt_key(void)
     9	{
    10		if (dm_crypt_key) {
    11			memset(dm_crypt_key, 0, dm_crypt_key_size * sizeof(u8));
    12			kfree(dm_crypt_key);
    13			dm_crypt_key = NULL;
    14		}
    15	}
    16	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

