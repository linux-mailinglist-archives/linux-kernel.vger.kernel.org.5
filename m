Return-Path: <linux-kernel+bounces-4889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7009181835D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254061F24D41
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7B11725;
	Tue, 19 Dec 2023 08:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bG4Lhs3L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C83125CC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702974609; x=1734510609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TFvk/efFGED3uKW4jz6Wb+17MhEzSYGtlBq2AKXhvJ8=;
  b=bG4Lhs3L6gI7ecFuLz7Srnk6LSvx27YiiRjGjNJg6zxLheDomiMEbmVh
   D4nKhmGCkvgTfofJvw0rb55uxx0+l3XRhY/ZKvvq7O0Y3IzvK32riwbKB
   7hHkltN7OzGxG2tfpcn7jSZ1dCuIvFUUo+fT4idyQutDvcdZwV8z8DvJY
   /GC1WpP+PC/WRsZNwP1vFcm6jIxWXYAW/DUMhk36Iw712UT4x4G3RuoD/
   fTzEu16IxOWMcBzCZL1UG4lMQCeU3xVa01ArJS1pa6Iu1/hKamdM9AZjh
   TczpyBKYzySLg7MI32Vy6XjxOIfTwyA7Xrv4Wtz0vcsmccSB2vpGnUFDA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="375115821"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="375115821"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:30:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="1023065694"
X-IronPort-AV: E=Sophos;i="6.04,287,1695711600"; 
   d="scan'208";a="1023065694"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 Dec 2023 00:30:06 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFVUK-000541-06;
	Tue, 19 Dec 2023 08:30:04 +0000
Date: Tue, 19 Dec 2023 16:29:41 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association
 path
Message-ID: <202312191634.ASof5mm8-lkp@intel.com>
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
[also build test ERROR on linus/master v6.7-rc6 next-20231219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvmet-fc-remove-unnecessary-bracket/20231219-003117
base:   git://git.infradead.org/nvme.git nvme-6.8
patch link:    https://lore.kernel.org/r/20231218153105.12717-16-dwagner%40suse.de
patch subject: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association path
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20231219/202312191634.ASof5mm8-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191634.ASof5mm8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191634.ASof5mm8-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/nvme/target/fc.c: In function 'nvmet_fc_put_tgtport_work':
>> drivers/nvme/target/fc.c:253:9: error: implicit declaration of function 'nvmet_fc_tgtport_put'; did you mean 'nvmet_ctrl_put'? [-Werror=implicit-function-declaration]
     253 |         nvmet_fc_tgtport_put(tgtport);
         |         ^~~~~~~~~~~~~~~~~~~~
         |         nvmet_ctrl_put
   drivers/nvme/target/fc.c: At top level:
>> drivers/nvme/target/fc.c:259:13: warning: conflicting types for 'nvmet_fc_tgtport_put'; have 'void(struct nvmet_fc_tgtport *)'
     259 | static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/fc.c:259:13: error: static declaration of 'nvmet_fc_tgtport_put' follows non-static declaration
   drivers/nvme/target/fc.c:253:9: note: previous implicit declaration of 'nvmet_fc_tgtport_put' with type 'void(struct nvmet_fc_tgtport *)'
     253 |         nvmet_fc_tgtport_put(tgtport);
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +253 drivers/nvme/target/fc.c

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

