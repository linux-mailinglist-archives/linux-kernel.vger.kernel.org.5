Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD95E7EA027
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbjKMPiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:38:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKMPiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:38:03 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75601706;
        Mon, 13 Nov 2023 07:37:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699889879; x=1731425879;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w8TTSWY7bGFFxI17jKTubI0A2ir8yt0Laypod+M+uRk=;
  b=DfzJdJWH0ltoGeTA5F+oF+HY7nDXX/Z92q+PyzDB+xo9mNZoLfYgwMRz
   1/o+IZEAkqDBncfQoTn1Dzz9UaDcnbqS7b9tR0OdVsjCjAPqvGHqZfVuO
   zyyslGZYLOgG5YxGQui8HAhSVFYT5lDsejGDEjnC2TcNc49mmlj3URo//
   vFtjwNOGBt84nvOlsbRpgdJ2fFBfYK/FQ0AXFmpCJYqYKYt7+2MuFKr7O
   1Zv/2pMWEOM+ULXeStrfR39blAOfoagiRskZ6Uxc6u4zYLl1oFr/d8KHR
   LAyKCuXv3wn+QNzC0ObPx+PRREdbK57GcJcYnJiYYbMJQkpV2SP6LD0xi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="375481341"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="375481341"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2023 07:37:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="1011571200"
X-IronPort-AV: E=Sophos;i="6.03,299,1694761200"; 
   d="scan'208";a="1011571200"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Nov 2023 07:37:55 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r2Z0a-000CE6-2m;
        Mon, 13 Nov 2023 15:37:52 +0000
Date:   Mon, 13 Nov 2023 23:37:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     SEO HOYOUNG <hy50.seo@samsung.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, alim.akhtar@samsung.com,
        avri.altman@wdc.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, beanhuo@micron.com, bvanassche@acm.org,
        kwangwon.min@samsung.com, kwmad.kim@samsung.com,
        sh425.lee@samsung.com, sc.suh@samsung.com,
        quic_nguyenb@quicinc.com, cpgs@samsung.com, grant.jung@samsung.com,
        junwoo80.lee@samsung.com
Cc:     oe-kbuild-all@lists.linux.dev, SEO HOYOUNG <hy50.seo@samsung.com>
Subject: Re: [PATCH v1] scsi: ufs: core: fix racing issue during
 ufshcd_mcq_abort
Message-ID: <202311132304.bqVcJ27s-lkp@intel.com>
References: <20231113112935.16343-1-hy50.seo@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113112935.16343-1-hy50.seo@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi SEO,

kernel test robot noticed the following build errors:

[auto build test ERROR on jejb-scsi/for-next]
[also build test ERROR on mkp-scsi/for-next linus/master v6.7-rc1 next-20231113]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/SEO-HOYOUNG/scsi-ufs-core-fix-racing-issue-during-ufshcd_mcq_abort/20231113-194433
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git for-next
patch link:    https://lore.kernel.org/r/20231113112935.16343-1-hy50.seo%40samsung.com
patch subject: [PATCH v1] scsi: ufs: core: fix racing issue during ufshcd_mcq_abort
config: arc-randconfig-001-20231113 (https://download.01.org/0day-ci/archive/20231113/202311132304.bqVcJ27s-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231113/202311132304.bqVcJ27s-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311132304.bqVcJ27s-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/ufs/core/ufshcd.c: In function 'ufshcd_try_to_abort_task':
>> drivers/ufs/core/ufshcd.c:7571:34: error: 'cmd' undeclared (first use in this function)
    7571 |         if (!ufshcd_cmd_inflight(cmd) ||
         |                                  ^~~
   drivers/ufs/core/ufshcd.c:7571:34: note: each undeclared identifier is reported only once for each function it appears in


vim +/cmd +7571 drivers/ufs/core/ufshcd.c

  7484	
  7485	/**
  7486	 * ufshcd_try_to_abort_task - abort a specific task
  7487	 * @hba: Pointer to adapter instance
  7488	 * @tag: Task tag/index to be aborted
  7489	 *
  7490	 * Abort the pending command in device by sending UFS_ABORT_TASK task management
  7491	 * command, and in host controller by clearing the door-bell register. There can
  7492	 * be race between controller sending the command to the device while abort is
  7493	 * issued. To avoid that, first issue UFS_QUERY_TASK to check if the command is
  7494	 * really issued and then try to abort it.
  7495	 *
  7496	 * Return: zero on success, non-zero on failure.
  7497	 */
  7498	int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag)
  7499	{
  7500		struct ufshcd_lrb *lrbp = &hba->lrb[tag];
  7501		int err = 0;
  7502		int poll_cnt;
  7503		u8 resp = 0xF;
  7504		u32 reg;
  7505	
  7506		for (poll_cnt = 100; poll_cnt; poll_cnt--) {
  7507			err = ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp->task_tag,
  7508					UFS_QUERY_TASK, &resp);
  7509			if (!err && resp == UPIU_TASK_MANAGEMENT_FUNC_SUCCEEDED) {
  7510				/* cmd pending in the device */
  7511				dev_err(hba->dev, "%s: cmd pending in the device. tag = %d\n",
  7512					__func__, tag);
  7513				break;
  7514			} else if (!err && resp == UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
  7515				/*
  7516				 * cmd not pending in the device, check if it is
  7517				 * in transition.
  7518				 */
  7519				dev_err(hba->dev, "%s: cmd at tag %d not pending in the device.\n",
  7520					__func__, tag);
  7521				if (is_mcq_enabled(hba)) {
  7522					/* MCQ mode */
  7523					if (ufshcd_cmd_inflight(lrbp->cmd)) {
  7524						/* sleep for max. 200us same delay as in SDB mode */
  7525						usleep_range(100, 200);
  7526						continue;
  7527					}
  7528					/* command completed already */
  7529					dev_err(hba->dev, "%s: cmd at tag=%d is cleared.\n",
  7530						__func__, tag);
  7531					goto out;
  7532				}
  7533	
  7534				/* Single Doorbell Mode */
  7535				reg = ufshcd_readl(hba, REG_UTP_TRANSFER_REQ_DOOR_BELL);
  7536				if (reg & (1 << tag)) {
  7537					/* sleep for max. 200us to stabilize */
  7538					usleep_range(100, 200);
  7539					continue;
  7540				}
  7541				/* command completed already */
  7542				dev_err(hba->dev, "%s: cmd at tag %d successfully cleared from DB.\n",
  7543					__func__, tag);
  7544				goto out;
  7545			} else {
  7546				dev_err(hba->dev,
  7547					"%s: no response from device. tag = %d, err %d\n",
  7548					__func__, tag, err);
  7549				if (!err)
  7550					err = resp; /* service response error */
  7551				goto out;
  7552			}
  7553		}
  7554	
  7555		if (!poll_cnt) {
  7556			err = -EBUSY;
  7557			goto out;
  7558		}
  7559	
  7560		err = ufshcd_issue_tm_cmd(hba, lrbp->lun, lrbp->task_tag,
  7561				UFS_ABORT_TASK, &resp);
  7562		if (err || resp != UPIU_TASK_MANAGEMENT_FUNC_COMPL) {
  7563			if (!err) {
  7564				err = resp; /* service response error */
  7565				dev_err(hba->dev, "%s: issued. tag = %d, err %d\n",
  7566					__func__, tag, err);
  7567			}
  7568			goto out;
  7569		}
  7570	
> 7571		if (!ufshcd_cmd_inflight(cmd) ||
  7572		    test_bit(SCMD_STATE_COMPLETE, &cmd->state))
  7573			goto out;
  7574	
  7575		err = ufshcd_clear_cmd(hba, tag);
  7576		if (err)
  7577			dev_err(hba->dev, "%s: Failed clearing cmd at tag %d, err %d\n",
  7578				__func__, tag, err);
  7579	
  7580	out:
  7581		return err;
  7582	}
  7583	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
