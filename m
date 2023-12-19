Return-Path: <linux-kernel+bounces-4729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D46DC818147
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E428A1C23399
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BECE847B;
	Tue, 19 Dec 2023 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PhHJcT1F"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6B16D3F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702965629; x=1734501629;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KuZnLO475ngFLg9EV3A/3KeAGUlrMD5qDq4De+BpMew=;
  b=PhHJcT1FNGTs8qve21nKNIKlgjZD12X8Jw2OdZrBB0zTgkYmL4mxjNlE
   CSfz3Tr+X/8l8461OYPZiG5s3vhjhbcNLYHZjUs/81aKPiGO99oD7+f3Z
   x+ksGaU4iFRP9BmgEUqxFAo+rTFzkZ6Jxu5NE7FZs6ufk8w5ScdphFPfe
   kQu9485eDA2mQ9kw2dDiOUsr/prdiRXche5Gk2oGrAFRPkVIevTIRnlgQ
   4SuN+H49CUPaMOzY97Fp5P1AEmNH08LWiAxNw+/E5k/dMFOD52e+bI6wP
   ZXGVtAdzn2o9ilRk9pVRwYh2/Xl2RhYrl8cAA4MyxGuQPUTwNuiqHvu5B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="392785559"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="392785559"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 22:00:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="769108675"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="769108675"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 18 Dec 2023 22:00:24 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFT9R-0004uu-0t;
	Tue, 19 Dec 2023 06:00:21 +0000
Date: Tue, 19 Dec 2023 14:00:12 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association
 path
Message-ID: <202312191347.7X0VJgnV-lkp@intel.com>
References: <20231218153105.12717-16-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218153105.12717-16-dwagner@suse.de>

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on linux-nvme/nvme-6.8]
[also build test ERROR on linus/master v6.7-rc6 next-20231218]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvmet-fc-remove-unnecessary-bracket/20231219-003117
base:   git://git.infradead.org/nvme.git nvme-6.8
patch link:    https://lore.kernel.org/r/20231218153105.12717-16-dwagner%40suse.de
patch subject: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association path
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231219/202312191347.7X0VJgnV-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191347.7X0VJgnV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191347.7X0VJgnV-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/target/fc.c:253:2: error: call to undeclared function 'nvmet_fc_tgtport_put'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           nvmet_fc_tgtport_put(tgtport);
           ^
>> drivers/nvme/target/fc.c:259:13: error: static declaration of 'nvmet_fc_tgtport_put' follows non-static declaration
   static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
               ^
   drivers/nvme/target/fc.c:253:2: note: previous implicit declaration is here
           nvmet_fc_tgtport_put(tgtport);
           ^
   2 errors generated.


vim +/nvmet_fc_tgtport_put +253 drivers/nvme/target/fc.c

   244	
   245	
   246	static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
   247	static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
   248	static void nvmet_fc_put_tgtport_work(struct work_struct *work)
   249	{
   250		struct nvmet_fc_tgtport *tgtport =
   251			container_of(work, struct nvmet_fc_tgtport, put_work);
   252	
 > 253		nvmet_fc_tgtport_put(tgtport);
   254	}
   255	static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
   256	static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
   257	static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
   258	static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 > 259	static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
   260	static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
   261	static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
   262						struct nvmet_fc_fcp_iod *fod);
   263	static void nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc);
   264	static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
   265					struct nvmet_fc_ls_iod *iod);
   266	
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

