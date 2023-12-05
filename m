Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AA2804A42
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344452AbjLEGhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:37:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344397AbjLEGhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:37:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EFA811F;
        Mon,  4 Dec 2023 22:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701758228; x=1733294228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZqvAkwNMScC8HI8XbCdEX2rgOR/mZYQHPqzhl7WBsng=;
  b=ZtrvTdzJLxWBcxg6ziAodYS8pVU3xI4Nb4Z0kHChk5EzfgzW8A+ci1Iu
   agIYcJSz3lGExf/O9b31TfKQKjjTkxm0EDTO6o0DcarAaS+Y0RNQ2OFav
   ORz5RbBgH5PZv1lj3rCHxvUONBy/o6/ofNG976/Hp1sUmrNiJZue/D3oH
   t4hFiaaCmwDO0pUcWHPUxWiglZmpJUPPc83GFyPJcjxx7b9Qc+OA1styZ
   EmPEyxnvC75jtEz/WvYrjmpjKXSB2ffHpqlxzoUwQwKA/BHkm1IKEYLQu
   7Qokbuj67YZ55MQk9Fm4YP2gSPJu76zKjMfLO9t0hrq0ul0BdSWie3t8y
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="374035375"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="374035375"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 22:37:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="764224102"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="764224102"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 04 Dec 2023 22:37:03 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1rAP3F-0008Rc-1f;
        Tue, 05 Dec 2023 06:37:01 +0000
Date:   Tue, 5 Dec 2023 14:36:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     NeilBrown <neilb@suse.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/2] nfsd: Don't leave work of closing files to a work
 queue.
Message-ID: <202312051443.02Ddb5pd-lkp@intel.com>
References: <20231204014042.6754-3-neilb@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204014042.6754-3-neilb@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi NeilBrown,

kernel test robot noticed the following build warnings:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v6.7-rc4]
[cannot apply to brauner-vfs/vfs.all next-20231205]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/NeilBrown/Allow-a-kthread-to-declare-that-it-calls-task_work_run/20231204-094248
base:   tip/sched/core
patch link:    https://lore.kernel.org/r/20231204014042.6754-3-neilb%40suse.de
patch subject: [PATCH 2/2] nfsd: Don't leave work of closing files to a work queue.
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20231205/202312051443.02Ddb5pd-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231205/202312051443.02Ddb5pd-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202312051443.02Ddb5pd-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/nfsd/filecache.c:431: warning: Function parameter or member 'nn' not described in 'nfsd_file_dispose_some'


vim +431 fs/nfsd/filecache.c

   425	
   426	/**
   427	 * nfsd_file_dispose_some
   428	 *
   429	 */
   430	void nfsd_file_dispose_some(struct nfsd_net *nn)
 > 431	{
   432		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
   433		LIST_HEAD(dispose);
   434		int i;
   435	
   436		if (list_empty(&l->freeme))
   437			return;
   438		spin_lock(&l->lock);
   439		for (i = 0; i < 8 && !list_empty(&l->freeme); i++)
   440			list_move(l->freeme.next, &dispose);
   441		spin_unlock(&l->lock);
   442		if (!list_empty(&l->freeme))
   443			svc_wake_up(nn->nfsd_serv);
   444		nfsd_file_dispose_list(&dispose);
   445	}
   446	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
