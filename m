Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B193F7933E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 04:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241624AbjIFCwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 22:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjIFCwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 22:52:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70CCC2;
        Tue,  5 Sep 2023 19:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693968757; x=1725504757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=b/IlaQTZB5j0he0vRsx9Okx0UXxCOU0YpQJ6T4yXngA=;
  b=DMIibnaRFzWF1T6bqd7Pv5CQyz4p1FWdFI4dURTwximIraEr4bj5nt48
   FOzJ1ZF9/wLWii9tO6HwsCKFQ+9TK2ZYSPvSqe7wNpUIjQmnVqjBqY7md
   QCt8Y1vsnBhVFstZzXUVjppXRGVjLTzBCtd9RSFb6O70qmnWrriMwaKVI
   KCNteS4HxhH9Gs/jtjNCzKGHzRXNFZ7UbQ8AlDTDC39+aFWy9FkCdRpre
   QnZ1cVmtJkypkqdAaHzRfER70xGP1UO9OFIljX3hx8voxyxWU3LQterBL
   HjS1W+ihEM2rDpO9IvD3dyH3jqQEkn0DT+f2Q38zsimFXTSOR053YRZwx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407954966"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="407954966"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2023 19:52:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="776411652"
X-IronPort-AV: E=Sophos;i="6.02,230,1688454000"; 
   d="scan'208";a="776411652"
Received: from lkp-server02.sh.intel.com (HELO e0b2ea88afd5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 05 Sep 2023 19:52:34 -0700
Received: from kbuild by e0b2ea88afd5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qdiea-0002Oj-11;
        Wed, 06 Sep 2023 02:52:29 +0000
Date:   Wed, 6 Sep 2023 10:52:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: Re: [PATCH] tracefs/eventfs: Use dput to free the toplevel events
 directory
Message-ID: <202309061055.V08YOtla-lkp@intel.com>
References: <20230905183332.628d7cc0@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905183332.628d7cc0@gandalf.local.home>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

kernel test robot noticed the following build warnings:

[auto build test WARNING on linus/master]
[also build test WARNING on next-20230905]
[cannot apply to v6.5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steven-Rostedt/tracefs-eventfs-Use-dput-to-free-the-toplevel-events-directory/20230906-063414
base:   linus/master
patch link:    https://lore.kernel.org/r/20230905183332.628d7cc0%40gandalf.local.home
patch subject: [PATCH] tracefs/eventfs: Use dput to free the toplevel events directory
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230906/202309061055.V08YOtla-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230906/202309061055.V08YOtla-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309061055.V08YOtla-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/tracefs/event_inode.c: In function 'eventfs_remove_events_dir':
>> fs/tracefs/event_inode.c:804:31: warning: variable 'ei' set but not used [-Wunused-but-set-variable]
     804 |         struct eventfs_inode *ei;
         |                               ^~


vim +/ei +804 fs/tracefs/event_inode.c

5bdcd5f5331a276 Ajay Kaher 2023-07-28  794  
5bdcd5f5331a276 Ajay Kaher 2023-07-28  795  /**
5bdcd5f5331a276 Ajay Kaher 2023-07-28  796   * eventfs_remove_events_dir - remove eventfs dir or file from list
5bdcd5f5331a276 Ajay Kaher 2023-07-28  797   * @dentry: events's dentry to be removed.
5bdcd5f5331a276 Ajay Kaher 2023-07-28  798   *
5bdcd5f5331a276 Ajay Kaher 2023-07-28  799   * This function remove events main directory
5bdcd5f5331a276 Ajay Kaher 2023-07-28  800   */
5bdcd5f5331a276 Ajay Kaher 2023-07-28  801  void eventfs_remove_events_dir(struct dentry *dentry)
5bdcd5f5331a276 Ajay Kaher 2023-07-28  802  {
5bdcd5f5331a276 Ajay Kaher 2023-07-28  803  	struct tracefs_inode *ti;
5bdcd5f5331a276 Ajay Kaher 2023-07-28 @804  	struct eventfs_inode *ei;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
