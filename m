Return-Path: <linux-kernel+bounces-25344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B301E82CE05
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 18:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42468283705
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 17:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8835684;
	Sat, 13 Jan 2024 17:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Umff4QXD"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC35663
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 17:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705168278; x=1736704278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6tMMVf1LXjFd2vcj/Sqweewo/s0ZpYMPQ6RCumJW+jY=;
  b=Umff4QXDv6zkJMADi+VbG71a+ZQPnc0xFsfrBqiiUjvVGjUEsFu/O8Vx
   XTmHPtQ9xiPsj6zPm8/WfidHBgUbbeXQZToPgozipU6YL8PfYpfXat1Pu
   B11NXi0Db564TlxddJixs2bB5VwoyGk1bq7eYqfy/CvQQ+MzIhPDZqZCU
   nacEDBbaPS1tIgLagGQ1SScdoKMAL9b0HQ6/fDpZpz+838LeexgJELLzH
   M85H2RsAyfAFPAMDj3WA2XOAJ8vM453+pYmgq/mosfneXarf4XvyBhlyQ
   G+0ICzTTTqxMXSRs/mkBGXZnIHMAnjAqWSJdqNwJYBZB6CtRw0VZwr6IF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="6760130"
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="6760130"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2024 09:51:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,192,1695711600"; 
   d="scan'208";a="25342449"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 13 Jan 2024 09:51:13 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOiA2-000Am0-2l;
	Sat, 13 Jan 2024 17:51:10 +0000
Date: Sun, 14 Jan 2024 01:50:23 +0800
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
Message-ID: <202401140128.MBysmTaN-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on tip/x86/core]
[also build test ERROR on v6.7]
[cannot apply to linus/master next-20240112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Coiby-Xu/kexec_file-allow-to-place-kexec_buf-randomly/20240110-151859
base:   tip/x86/core
patch link:    https://lore.kernel.org/r/20240110071522.1308935-3-coxu%40redhat.com
patch subject: [PATCH v2 2/5] crash_dump: save the dm crypt key temporarily
config: i386-buildonly-randconfig-002-20240113 (https://download.01.org/0day-ci/archive/20240114/202401140128.MBysmTaN-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240114/202401140128.MBysmTaN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202401140128.MBysmTaN-lkp@intel.com/

All errors (new ones prefixed by >>):

   ld: kernel/ksysfs.o: in function `crash_dm_crypt_key_store':
>> ksysfs.c:(.text+0x2d0): undefined reference to `crash_sysfs_dm_crypt_key_write'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

