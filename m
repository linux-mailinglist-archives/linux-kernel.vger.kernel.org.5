Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230867A8B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjITSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjITSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:25:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AA0CC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695234307; x=1726770307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9PhOSiuYuVCKZUST18M9mJT1hnZQKOIdZaAVIzPPgvU=;
  b=JvxleZ7Hn5Arn28SzbMPdbFm9Dz5LFPyf095IUmwjZqzcRZrcMjaNMy8
   woLyRRkzNlhMgFXdiY4d/qv4z6jaIh+bN3jbXNIZDvCtjXAszgiZ1+Gea
   OxpfTpqO1OpJvbuMpVMWAQL8tYGV+xEGjTNZeFMP4VXGmn8ZppFdUCp+l
   nbS2EgSfjWGTosD91qDhr6LfOaGUFwe64wNfG0lSHycxYsFFC7ZTmNb2Q
   ms6r68GDoMUiFQsyJxJ8/hDuS+nTmYNa8KeOoTisNdOwHYLUwjluOr48/
   rJfujrsry8PERp+dJRmbiP6uH1/zmey+Xa2t8DVWvLCnvbigiiPYrAvr3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="359689179"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="359689179"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 11:25:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="993724832"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="993724832"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Sep 2023 11:25:04 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qj1sk-00091o-0u;
        Wed, 20 Sep 2023 18:25:02 +0000
Date:   Thu, 21 Sep 2023 02:24:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH] printk/nbcon: Add assert that CPU migration is disabled
 when calling nbcon_context_try_acquire()
Message-ID: <202309210239.GwxqY2v3-lkp@intel.com>
References: <20230920125136.15504-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920125136.15504-1-pmladek@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20230920]
[cannot apply to linus/master v6.6-rc2 v6.6-rc1 v6.5 v6.6-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Petr-Mladek/printk-nbcon-Add-assert-that-CPU-migration-is-disabled-when-calling-nbcon_context_try_acquire/20230920-205406
base:   next-20230920
patch link:    https://lore.kernel.org/r/20230920125136.15504-1-pmladek%40suse.com
patch subject: [PATCH] printk/nbcon: Add assert that CPU migration is disabled when calling nbcon_context_try_acquire()
config: um-allnoconfig (https://download.01.org/0day-ci/archive/20230921/202309210239.GwxqY2v3-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230921/202309210239.GwxqY2v3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309210239.GwxqY2v3-lkp@intel.com/

All errors (new ones prefixed by >>):

>> kernel/printk/nbcon.c:595:2: error: call to undeclared function 'nbcon_assert_cpu_migration_disabled'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     595 |         nbcon_assert_cpu_migration_disabled();
         |         ^
   1 error generated.


vim +/nbcon_assert_cpu_migration_disabled +595 kernel/printk/nbcon.c

   575	
   576	/**
   577	 * nbcon_context_try_acquire - Try to acquire nbcon console
   578	 * @ctxt:	The context of the caller
   579	 *
   580	 * Return:	True if the console was acquired. False otherwise.
   581	 *
   582	 * If the caller allowed an unsafe hostile takeover, on success the
   583	 * caller should check the current console state to see if it is
   584	 * in an unsafe state. Otherwise, on success the caller may assume
   585	 * the console is not in an unsafe state.
   586	 */
   587	__maybe_unused
   588	static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
   589	{
   590		unsigned int cpu = smp_processor_id();
   591		struct console *con = ctxt->console;
   592		struct nbcon_state cur;
   593		int err;
   594	
 > 595		nbcon_assert_cpu_migration_disabled();
   596	
   597		nbcon_state_read(con, &cur);
   598	try_again:
   599		err = nbcon_context_try_acquire_direct(ctxt, &cur);
   600		if (err != -EBUSY)
   601			goto out;
   602	
   603		err = nbcon_context_try_acquire_handover(ctxt, &cur);
   604		if (err == -EAGAIN)
   605			goto try_again;
   606		if (err != -EBUSY)
   607			goto out;
   608	
   609		err = nbcon_context_try_acquire_hostile(ctxt, &cur);
   610	out:
   611		if (err)
   612			return false;
   613	
   614		/* Acquire succeeded. */
   615	
   616		/* Assign the appropriate buffer for this context. */
   617		if (atomic_read(&panic_cpu) == cpu)
   618			ctxt->pbufs = &panic_nbcon_pbufs;
   619		else
   620			ctxt->pbufs = con->pbufs;
   621	
   622		/* Set the record sequence for this context to print. */
   623		ctxt->seq = nbcon_seq_read(ctxt->console);
   624	
   625		return true;
   626	}
   627	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
