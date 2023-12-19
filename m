Return-Path: <linux-kernel+bounces-5063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E13781862B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:18:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E761C239F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26A15494;
	Tue, 19 Dec 2023 11:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U/hAg5c9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D254618629
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702984685; x=1734520685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=o21DTEAWwM0e0dbAkfsavP1ZgY7Ic+y7ddHRBOQkmhU=;
  b=U/hAg5c9SQFvq0ZFhpMpT8FXo5slZ9mQ+ezkQQZcQmLUJqvwcB9CMEWk
   4P3ThQNZMqDxgy6jFZ9qOkgdlLWyj+SiRQyf6Y/KWIIsxZLJKojg8Bxof
   U5wGQu/LXiTEkBmTx8yQ92A2oc0bbe8wQDulZonwwhriAyad/IR8/3ihB
   lJh7FKSMVLPz4lcB7jqVWgEkAQBl9iflloyQPk+Tg5ut4L6E/Ej/hrlhF
   R+jS3ivoaRY6udv8c+0hbpt3fZ4jUfR9n8/+MH0cijWn3cxJbG1h8J66O
   zFXWmVjragP29/40zzpWUfsisoDY2CYaL59urYeya5EPaYK+iO7qiHwJI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="481832819"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="481832819"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 03:18:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10928"; a="804863597"
X-IronPort-AV: E=Sophos;i="6.04,288,1695711600"; 
   d="scan'208";a="804863597"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 19 Dec 2023 03:18:02 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rFY6o-0005EB-2Q;
	Tue, 19 Dec 2023 11:17:59 +0000
Date: Tue, 19 Dec 2023 19:17:22 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association
 path
Message-ID: <202312191845.lwrs1kbh-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on linux-nvme/nvme-6.8]
[also build test WARNING on linus/master v6.7-rc6 next-20231219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvmet-fc-remove-unnecessary-bracket/20231219-003117
base:   git://git.infradead.org/nvme.git nvme-6.8
patch link:    https://lore.kernel.org/r/20231218153105.12717-16-dwagner%40suse.de
patch subject: [PATCH v3 15/16] nvmet-fc: avoid deadlock on delete association path
config: i386-randconfig-013-20231219 (https://download.01.org/0day-ci/archive/20231219/202312191845.lwrs1kbh-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231219/202312191845.lwrs1kbh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312191845.lwrs1kbh-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/fc.c: In function 'nvmet_fc_put_tgtport_work':
   drivers/nvme/target/fc.c:253:2: error: implicit declaration of function 'nvmet_fc_tgtport_put'; did you mean 'nvmet_ctrl_put'? [-Werror=implicit-function-declaration]
     nvmet_fc_tgtport_put(tgtport);
     ^~~~~~~~~~~~~~~~~~~~
     nvmet_ctrl_put
   drivers/nvme/target/fc.c: At top level:
>> drivers/nvme/target/fc.c:259:13: warning: conflicting types for 'nvmet_fc_tgtport_put'
    static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
                ^~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/fc.c:259:13: error: static declaration of 'nvmet_fc_tgtport_put' follows non-static declaration
   drivers/nvme/target/fc.c:253:2: note: previous implicit declaration of 'nvmet_fc_tgtport_put' was here
     nvmet_fc_tgtport_put(tgtport);
     ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/nvmet_fc_tgtport_put +259 drivers/nvme/target/fc.c

c53432030d8642 James Smart   2016-12-02  244  
c53432030d8642 James Smart   2016-12-02  245  
c53432030d8642 James Smart   2016-12-02  246  static void nvmet_fc_handle_ls_rqst_work(struct work_struct *work);
9d625f7792875e James Smart   2018-02-28  247  static void nvmet_fc_fcp_rqst_op_defer_work(struct work_struct *work);
20d5f3b830ab45 Daniel Wagner 2023-12-18  248  static void nvmet_fc_put_tgtport_work(struct work_struct *work)
20d5f3b830ab45 Daniel Wagner 2023-12-18  249  {
20d5f3b830ab45 Daniel Wagner 2023-12-18  250  	struct nvmet_fc_tgtport *tgtport =
20d5f3b830ab45 Daniel Wagner 2023-12-18  251  		container_of(work, struct nvmet_fc_tgtport, put_work);
20d5f3b830ab45 Daniel Wagner 2023-12-18  252  
20d5f3b830ab45 Daniel Wagner 2023-12-18  253  	nvmet_fc_tgtport_put(tgtport);
20d5f3b830ab45 Daniel Wagner 2023-12-18  254  }
c53432030d8642 James Smart   2016-12-02  255  static void nvmet_fc_tgt_a_put(struct nvmet_fc_tgt_assoc *assoc);
c53432030d8642 James Smart   2016-12-02  256  static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
c53432030d8642 James Smart   2016-12-02  257  static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
c53432030d8642 James Smart   2016-12-02  258  static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
c53432030d8642 James Smart   2016-12-02 @259  static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
c53432030d8642 James Smart   2016-12-02  260  static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
0fb228d30b8d72 James Smart   2017-08-01  261  static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
0fb228d30b8d72 James Smart   2017-08-01  262  					struct nvmet_fc_fcp_iod *fod);
a96d4bd867129e James Smart   2017-10-27  263  static void nvmet_fc_delete_target_assoc(struct nvmet_fc_tgt_assoc *assoc);
47bf3241064498 James Smart   2020-03-31  264  static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
47bf3241064498 James Smart   2020-03-31  265  				struct nvmet_fc_ls_iod *iod);
c53432030d8642 James Smart   2016-12-02  266  
c53432030d8642 James Smart   2016-12-02  267  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

