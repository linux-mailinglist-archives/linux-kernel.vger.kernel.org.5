Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFB97D698B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjJYKxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbjJYKxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:53:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5A78F;
        Wed, 25 Oct 2023 03:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698231188; x=1729767188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m/Y0aFVGcqZhvuRZA6upPo6yyOECscOmEoJCrsx/B18=;
  b=DfwYjkIZcHgd+CRtR5o4tE/++wcGOw1zWBLfAHA4X2aXrGMsH3ncqC1c
   jvT0Q//u14Ygl2KEjwmOnuxPyu/z4S1iT/pTibeYCs3jK3f2Suvac9Dh5
   8mQ1od2p9Tgdr4sRjtTWE8+ks76O7O0sq33QPR3EKFKd4en+IjYPLOa9g
   7AmXnJXanrJipB0xvIE+diOnU8NxTZ/NruqpKomxhb5AHhQImnmmTPPby
   bxU4zmH6Ikp76mdFfZ/bM/dN9tYQLNwWv3bbPcBBvtxErbX08x5Iq0biM
   B3A8xsMX+1kbQ2918+pSD4pMSs2r77U5t6tZYJAuMjYYMeEah386Ljhn2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="390136000"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="390136000"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 03:53:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="52501"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Oct 2023 03:52:29 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qvbVV-0008pp-1a;
        Wed, 25 Oct 2023 10:53:01 +0000
Date:   Wed, 25 Oct 2023 18:52:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Karan Tilak Kumar <kartilak@cisco.com>, sebaddel@cisco.com
Cc:     oe-kbuild-all@lists.linux.dev, arulponn@cisco.com,
        djhawar@cisco.com, gcboffa@cisco.com, mkai2@cisco.com,
        satishkh@cisco.com, jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Karan Tilak Kumar <kartilak@cisco.com>
Subject: Re: [PATCH 07/13] scsi: fnic: Modify ISRs to support multiqueue(MQ)
Message-ID: <202310251847.4T8BVZAZ-lkp@intel.com>
References: <20231020190629.338623-8-kartilak@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020190629.338623-8-kartilak@cisco.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Karan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mkp-scsi/for-next]
[also build test WARNING on jejb-scsi/for-next next-20231025]
[cannot apply to linus/master v6.6-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Karan-Tilak-Kumar/scsi-fnic-Modify-definitions-to-sync-with-VIC-firmware/20231021-031259
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
patch link:    https://lore.kernel.org/r/20231020190629.338623-8-kartilak%40cisco.com
patch subject: [PATCH 07/13] scsi: fnic: Modify ISRs to support multiqueue(MQ)
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20231025/202310251847.4T8BVZAZ-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231025/202310251847.4T8BVZAZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310251847.4T8BVZAZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/scsi/fnic/fnic_isr.c:242:5: warning: no previous prototype for 'fnic_set_intr_mode_msix' [-Wmissing-prototypes]
     242 | int fnic_set_intr_mode_msix(struct fnic *fnic)
         |     ^~~~~~~~~~~~~~~~~~~~~~~


vim +/fnic_set_intr_mode_msix +242 drivers/scsi/fnic/fnic_isr.c

   241	
 > 242	int fnic_set_intr_mode_msix(struct fnic *fnic)
   243	{
   244		unsigned int n = ARRAY_SIZE(fnic->rq);
   245		unsigned int m = ARRAY_SIZE(fnic->wq);
   246		unsigned int o = ARRAY_SIZE(fnic->hw_copy_wq);
   247		unsigned int min_irqs = n + m + 1 + 1; /*rq, raw wq, wq, err*/
   248	
   249		/*
   250		 * We need n RQs, m WQs, o Copy WQs, n+m+o CQs, and n+m+o+1 INTRs
   251		 * (last INTR is used for WQ/RQ errors and notification area)
   252		 */
   253		FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
   254			"fnic<%d>: %s: %d: rq-array size: %d wq-array size: %d copy-wq array size: %d\n",
   255			fnic->fnic_num, __func__, __LINE__, n, m, o);
   256		FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
   257			"fnic<%d>: %s: %d: rq_count: %d raw_wq_count: %d wq_copy_count: %d cq_count: %d\n",
   258			fnic->fnic_num, __func__, __LINE__, fnic->rq_count, fnic->raw_wq_count,
   259			fnic->wq_copy_count, fnic->cq_count);
   260	
   261		if (fnic->rq_count <= n && fnic->raw_wq_count <= m &&
   262			fnic->wq_copy_count <= o) {
   263			int vec_count = 0;
   264			int vecs = fnic->rq_count + fnic->raw_wq_count + fnic->wq_copy_count + 1;
   265	
   266			vec_count = pci_alloc_irq_vectors(fnic->pdev, min_irqs, vecs,
   267						PCI_IRQ_MSIX | PCI_IRQ_AFFINITY);
   268			FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
   269						"fnic<%d>: %s: %d: allocated %d MSI-X vectors\n",
   270						fnic->fnic_num, __func__, __LINE__, vec_count);
   271	
   272			if (vec_count > 0) {
   273				if (vec_count < vecs) {
   274					FNIC_ISR_DBG(KERN_ERR, fnic->lport->host,
   275					"fnic<%d>: %s: %d: interrupts number mismatch: vec_count: %d vecs: %d\n",
   276					fnic->fnic_num, __func__, __LINE__, vec_count, vecs);
   277					if (vec_count < min_irqs) {
   278						FNIC_ISR_DBG(KERN_ERR, fnic->lport->host,
   279									"fnic<%d>: %s: %d: no interrupts for copy wq\n",
   280									fnic->fnic_num, __func__, __LINE__);
   281						return 1;
   282					}
   283				}
   284	
   285				fnic->rq_count = n;
   286				fnic->raw_wq_count = m;
   287				fnic->cpy_wq_base = fnic->rq_count + fnic->raw_wq_count;
   288				fnic->wq_copy_count = vec_count - n - m - 1;
   289				fnic->wq_count = fnic->raw_wq_count + fnic->wq_copy_count;
   290				if (fnic->cq_count != vec_count - 1) {
   291					FNIC_ISR_DBG(KERN_ERR, fnic->lport->host,
   292					"fnic<%d>: %s: %d: CQ count: %d does not match MSI-X vector count: %d\n",
   293					fnic->fnic_num, __func__, __LINE__, fnic->cq_count, vec_count);
   294					fnic->cq_count = vec_count - 1;
   295				}
   296				fnic->intr_count = vec_count;
   297				fnic->err_intr_offset = fnic->rq_count + fnic->wq_count;
   298	
   299				FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
   300					"fnic<%d>: %s: %d: rq_count: %d raw_wq_count: %d cpy_wq_base: %d\n",
   301					fnic->fnic_num, __func__, __LINE__, fnic->rq_count,
   302					fnic->raw_wq_count, fnic->cpy_wq_base);
   303	
   304				FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
   305					"fnic<%d>: %s: %d: wq_copy_count: %d wq_count: %d cq_count: %d\n",
   306					fnic->fnic_num, __func__, __LINE__, fnic->wq_copy_count,
   307					fnic->wq_count, fnic->cq_count);
   308	
   309				FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
   310					"fnic<%d>: %s: %d: intr_count: %d err_intr_offset: %u",
   311					fnic->fnic_num, __func__, __LINE__, fnic->intr_count,
   312					fnic->err_intr_offset);
   313	
   314				vnic_dev_set_intr_mode(fnic->vdev, VNIC_DEV_INTR_MODE_MSIX);
   315				FNIC_ISR_DBG(KERN_INFO, fnic->lport->host,
   316						"fnic<%d>: %s: %d: fnic using MSI-X\n", fnic->fnic_num,
   317						__func__, __LINE__);
   318				return 0;
   319			}
   320		}
   321		return 1;
   322	} //fnic_set_intr_mode_msix
   323	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
