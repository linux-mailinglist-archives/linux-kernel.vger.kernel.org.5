Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F07D0492
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346606AbjJSWAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjJSWAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:00:38 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C6DB6;
        Thu, 19 Oct 2023 15:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697752836; x=1729288836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XYOfl3k4kNXFxBzmpgdyr71706CFZuSZYJvSmjYNO0Y=;
  b=IKG2SySN+OfRtHmxIjW7Ujjgw10WJL4U4vzJXBEA2I3Lj6ih8IOtv/zT
   vPWmDY0CzaIOuceGAl7iyvj7r2SummOTGtP2aiopjc3CCqLiPXmX0l4YJ
   seRSi690DtKF14YCDb63bWWMqXbPQQylWJv86JuyPY2w/nye0aQbMxl37
   MYWlj/pidsubuVjCdFt6yE4IUYkkyy/9q/34cYX5tBA7RmMrBostmQUJz
   X9Xv6UDx76ZBRFhJR+0KGBkBAbZ82mFc0aTj7yBWaxLtfPhrgTMCMiJnQ
   iJrRMhdV3YVTGSPxRmp2dFkZU6t6LVWPQ8EDlVN1MqB4JjtVhwPxvuTOF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="371449989"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="371449989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 15:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="786568901"
X-IronPort-AV: E=Sophos;i="6.03,238,1694761200"; 
   d="scan'208";a="786568901"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 19 Oct 2023 15:00:32 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qtb4A-0002dl-0h;
        Thu, 19 Oct 2023 22:00:30 +0000
Date:   Fri, 20 Oct 2023 05:59:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     oe-kbuild-all@lists.linux.dev,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kent Overstreet <kmo@daterainc.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH 1/1] trace: Move readpos from seq_buf to trace_seq
Message-ID: <202310200523.ggyHvT6w-lkp@intel.com>
References: <20231019194514.2115506-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019194514.2115506-2-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,

kernel test robot noticed the following build warnings:

[auto build test WARNING on kees/for-next/pstore]
[also build test WARNING on kees/for-next/kspp linus/master v6.6-rc6 next-20231019]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matthew-Wilcox-Oracle/trace-Move-readpos-from-seq_buf-to-trace_seq/20231020-034718
base:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/pstore
patch link:    https://lore.kernel.org/r/20231019194514.2115506-2-willy%40infradead.org
patch subject: [PATCH 1/1] trace: Move readpos from seq_buf to trace_seq
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20231020/202310200523.ggyHvT6w-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231020/202310200523.ggyHvT6w-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310200523.ggyHvT6w-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> lib/seq_buf.c:344: warning: Function parameter or member 'start' not described in 'seq_buf_to_user'


vim +344 lib/seq_buf.c

3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  322) 
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  323) /**
9dbbc3b9d09d6d lib/seq_buf.c          Zhen Lei                 2021-07-07  324   * seq_buf_to_user - copy the sequence buffer to user space
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  325)  * @s: seq_buf descriptor
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  326)  * @ubuf: The userspace memory location to copy to
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  327)  * @cnt: The amount to copy
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  328)  *
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  329)  * Copies the sequence buffer into the userspace memory pointed to
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  330)  * by @ubuf. It starts from the last read position (@s->readpos)
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  331)  * and writes up to @cnt characters or till it reaches the end of
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  332)  * the content in the buffer (@s->len), which ever comes first.
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  333)  *
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  334)  * On success, it returns a positive number of the number of bytes
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  335)  * it copied.
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  336)  *
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  337)  * On failure it returns -EBUSY if all of the content in the
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  338)  * sequence has been already read, which includes nothing in the
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  339)  * sequence (@s->len == @s->readpos).
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  340)  *
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  341)  * Returns -EFAULT if the copy to userspace fails.
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  342)  */
9377093a882be0 lib/seq_buf.c          Matthew Wilcox (Oracle   2023-10-19  343) int seq_buf_to_user(struct seq_buf *s, char __user *ubuf, size_t start, int cnt)
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25 @344) {
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  345) 	int len;
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  346) 	int ret;
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  347) 
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  348) 	if (!cnt)
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  349) 		return 0;
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  350) 
ff078d8fc64472 lib/seq_buf.c          Jerry Snitselaar         2015-11-16  351  	len = seq_buf_used(s);
ff078d8fc64472 lib/seq_buf.c          Jerry Snitselaar         2015-11-16  352  
9377093a882be0 lib/seq_buf.c          Matthew Wilcox (Oracle   2023-10-19  353) 	if (len <= start)
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  354) 		return -EBUSY;
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  355) 
9377093a882be0 lib/seq_buf.c          Matthew Wilcox (Oracle   2023-10-19  356) 	len -= start;
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  357) 	if (cnt > len)
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  358) 		cnt = len;
9377093a882be0 lib/seq_buf.c          Matthew Wilcox (Oracle   2023-10-19  359) 	ret = copy_to_user(ubuf, s->buffer + start, cnt);
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  360) 	if (ret == cnt)
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  361) 		return -EFAULT;
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  362) 
9377093a882be0 lib/seq_buf.c          Matthew Wilcox (Oracle   2023-10-19  363) 	return cnt - ret;
3a161d99c43ce7 kernel/trace/seq_buf.c Steven Rostedt (Red Hat  2014-06-25  364) }
353cade3149c27 lib/seq_buf.c          Piotr Maziarz            2019-11-07  365  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
