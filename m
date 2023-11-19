Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859027F0879
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 20:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjKSTaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 14:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjKSTaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 14:30:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8323411A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 11:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700422213; x=1731958213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Z52c+3QrrOwMzKRvT8pfIjueGEQNBpDqPu2dnBFnVFU=;
  b=eb7yMb2hCQMc9sq2d/abtH2uGM6w6kPfnPBUrdiUK/KmYRUrKsdMxS6w
   ri5cy7AhbJITe0nOiHo+Fg/ujghhJH5onvsgqQzCN+U2I52IQ+trC27u5
   qKivote3gtjL2ZnuLEyZLyLVgnDKGQu5LhwdV+89xGYTrhQkJKjSfQPmk
   vNS7p2jrH5/tEwFczX/HWL4Yi0qj1R4rNTY/+qdteWCskrcCf8QUtYImM
   nciHjscF6KUH6+q+y4T4SNSOBAE+/TnDS2XdfGi0vbeIdB4TVObH7UsI/
   RU05v1JrPCkOOfwuKfvKWQRhVDAjG2M/p4kAeQu0UOTOlgDWx2ZpgcSHQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13071995"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="13071995"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 11:30:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="939608784"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="939608784"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2023 11:30:10 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4nUd-0005Td-2P;
        Sun, 19 Nov 2023 19:30:07 +0000
Date:   Mon, 20 Nov 2023 03:29:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuanyuan Zhong <yzhong@purestorage.com>, kbusch@kernel.org,
        axboe@kernel.dk, hch@lst.de, sagi@grimberg.me
Cc:     oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, randyj@purestorage.com,
        hcoutinho@purestorage.com, Yuanyuan Zhong <yzhong@purestorage.com>
Subject: Re: [PATCH] nvme-core: remove head->effects to fix use-after-free
Message-ID: <202311200305.oyZkQTJh-lkp@intel.com>
References: <20231115185439.2616073-1-yzhong@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231115185439.2616073-1-yzhong@purestorage.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuanyuan,

kernel test robot noticed the following build errors:

[auto build test ERROR on hch-configfs/for-next]
[also build test ERROR on linus/master v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanyuan-Zhong/nvme-core-remove-head-effects-to-fix-use-after-free/20231116-025616
base:   git://git.infradead.org/users/hch/configfs.git for-next
patch link:    https://lore.kernel.org/r/20231115185439.2616073-1-yzhong%40purestorage.com
patch subject: [PATCH] nvme-core: remove head->effects to fix use-after-free
config: powerpc-randconfig-r133-20231119 (https://download.01.org/0day-ci/archive/20231120/202311200305.oyZkQTJh-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20231120/202311200305.oyZkQTJh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311200305.oyZkQTJh-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/zns.c:50:43: error: no member named 'effects' in 'struct nvme_ns_head'
      50 |         struct nvme_effects_log *log = ns->head->effects;
         |                                        ~~~~~~~~  ^
   1 error generated.


vim +50 drivers/nvme/host/zns.c

240e6ee272c07a Keith Busch       2020-06-29   47  
d525c3c0232216 Christoph Hellwig 2020-08-20   48  int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
240e6ee272c07a Keith Busch       2020-06-29   49  {
240e6ee272c07a Keith Busch       2020-06-29  @50  	struct nvme_effects_log *log = ns->head->effects;
d525c3c0232216 Christoph Hellwig 2020-08-20   51  	struct request_queue *q = ns->queue;
240e6ee272c07a Keith Busch       2020-06-29   52  	struct nvme_command c = { };
240e6ee272c07a Keith Busch       2020-06-29   53  	struct nvme_id_ns_zns *id;
240e6ee272c07a Keith Busch       2020-06-29   54  	int status;
240e6ee272c07a Keith Busch       2020-06-29   55  
240e6ee272c07a Keith Busch       2020-06-29   56  	/* Driver requires zone append support */
2f4c9ba23b887e Javier González   2020-12-01   57  	if ((le32_to_cpu(log->iocs[nvme_cmd_zone_append]) &
240e6ee272c07a Keith Busch       2020-06-29   58  			NVME_CMD_EFFECTS_CSUPP)) {
2f4c9ba23b887e Javier González   2020-12-01   59  		if (test_and_clear_bit(NVME_NS_FORCE_RO, &ns->flags))
240e6ee272c07a Keith Busch       2020-06-29   60  			dev_warn(ns->ctrl->device,
2f4c9ba23b887e Javier González   2020-12-01   61  				 "Zone Append supported for zoned namespace:%d. Remove read-only mode\n",
2f4c9ba23b887e Javier González   2020-12-01   62  				 ns->head->ns_id);
2f4c9ba23b887e Javier González   2020-12-01   63  	} else {
2f4c9ba23b887e Javier González   2020-12-01   64  		set_bit(NVME_NS_FORCE_RO, &ns->flags);
2f4c9ba23b887e Javier González   2020-12-01   65  		dev_warn(ns->ctrl->device,
2f4c9ba23b887e Javier González   2020-12-01   66  			 "Zone Append not supported for zoned namespace:%d. Forcing to read-only mode\n",
240e6ee272c07a Keith Busch       2020-06-29   67  			 ns->head->ns_id);
240e6ee272c07a Keith Busch       2020-06-29   68  	}
240e6ee272c07a Keith Busch       2020-06-29   69  
240e6ee272c07a Keith Busch       2020-06-29   70  	/* Lazily query controller append limit for the first zoned namespace */
240e6ee272c07a Keith Busch       2020-06-29   71  	if (!ns->ctrl->max_zone_append) {
240e6ee272c07a Keith Busch       2020-06-29   72  		status = nvme_set_max_append(ns->ctrl);
240e6ee272c07a Keith Busch       2020-06-29   73  		if (status)
240e6ee272c07a Keith Busch       2020-06-29   74  			return status;
240e6ee272c07a Keith Busch       2020-06-29   75  	}
240e6ee272c07a Keith Busch       2020-06-29   76  
240e6ee272c07a Keith Busch       2020-06-29   77  	id = kzalloc(sizeof(*id), GFP_KERNEL);
240e6ee272c07a Keith Busch       2020-06-29   78  	if (!id)
240e6ee272c07a Keith Busch       2020-06-29   79  		return -ENOMEM;
240e6ee272c07a Keith Busch       2020-06-29   80  
240e6ee272c07a Keith Busch       2020-06-29   81  	c.identify.opcode = nvme_admin_identify;
240e6ee272c07a Keith Busch       2020-06-29   82  	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
240e6ee272c07a Keith Busch       2020-06-29   83  	c.identify.cns = NVME_ID_CNS_CS_NS;
240e6ee272c07a Keith Busch       2020-06-29   84  	c.identify.csi = NVME_CSI_ZNS;
240e6ee272c07a Keith Busch       2020-06-29   85  
240e6ee272c07a Keith Busch       2020-06-29   86  	status = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, id, sizeof(*id));
240e6ee272c07a Keith Busch       2020-06-29   87  	if (status)
240e6ee272c07a Keith Busch       2020-06-29   88  		goto free_data;
240e6ee272c07a Keith Busch       2020-06-29   89  
240e6ee272c07a Keith Busch       2020-06-29   90  	/*
240e6ee272c07a Keith Busch       2020-06-29   91  	 * We currently do not handle devices requiring any of the zoned
240e6ee272c07a Keith Busch       2020-06-29   92  	 * operation characteristics.
240e6ee272c07a Keith Busch       2020-06-29   93  	 */
240e6ee272c07a Keith Busch       2020-06-29   94  	if (id->zoc) {
240e6ee272c07a Keith Busch       2020-06-29   95  		dev_warn(ns->ctrl->device,
240e6ee272c07a Keith Busch       2020-06-29   96  			"zone operations:%x not supported for namespace:%u\n",
240e6ee272c07a Keith Busch       2020-06-29   97  			le16_to_cpu(id->zoc), ns->head->ns_id);
a9e0e6bc728ebc Christoph Hellwig 2021-04-07   98  		status = -ENODEV;
240e6ee272c07a Keith Busch       2020-06-29   99  		goto free_data;
240e6ee272c07a Keith Busch       2020-06-29  100  	}
240e6ee272c07a Keith Busch       2020-06-29  101  
240e6ee272c07a Keith Busch       2020-06-29  102  	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
240e6ee272c07a Keith Busch       2020-06-29  103  	if (!is_power_of_2(ns->zsze)) {
240e6ee272c07a Keith Busch       2020-06-29  104  		dev_warn(ns->ctrl->device,
240e6ee272c07a Keith Busch       2020-06-29  105  			"invalid zone size:%llu for namespace:%u\n",
240e6ee272c07a Keith Busch       2020-06-29  106  			ns->zsze, ns->head->ns_id);
a9e0e6bc728ebc Christoph Hellwig 2021-04-07  107  		status = -ENODEV;
240e6ee272c07a Keith Busch       2020-06-29  108  		goto free_data;
240e6ee272c07a Keith Busch       2020-06-29  109  	}
240e6ee272c07a Keith Busch       2020-06-29  110  
6b2bd274744e64 Christoph Hellwig 2022-07-06  111  	disk_set_zoned(ns->disk, BLK_ZONED_HM);
240e6ee272c07a Keith Busch       2020-06-29  112  	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
982977df48179c Christoph Hellwig 2022-07-06  113  	disk_set_max_open_zones(ns->disk, le32_to_cpu(id->mor) + 1);
982977df48179c Christoph Hellwig 2022-07-06  114  	disk_set_max_active_zones(ns->disk, le32_to_cpu(id->mar) + 1);
240e6ee272c07a Keith Busch       2020-06-29  115  free_data:
240e6ee272c07a Keith Busch       2020-06-29  116  	kfree(id);
240e6ee272c07a Keith Busch       2020-06-29  117  	return status;
240e6ee272c07a Keith Busch       2020-06-29  118  }
240e6ee272c07a Keith Busch       2020-06-29  119  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
