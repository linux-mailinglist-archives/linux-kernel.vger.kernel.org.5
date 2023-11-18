Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E6E7F0038
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:04:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjKRPEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:04:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:04:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880AB12B;
        Sat, 18 Nov 2023 07:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700319874; x=1731855874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=g94IAzBaDrXXBM3wde18BakVdeksJK1Q+O3n3qhmQCg=;
  b=C/t4pQ9Nxpdf7H01BFsGTH6Inx52ALpjFX7K6zZNBjRYxTLP57unJTNu
   gjvVAAmYVhG8jCGvb0JwI3PDS7bqpVos8cgRRqYGU22Plg6VOD6gKvqJi
   eJVoinitoIQoKcnhTeyqhCPpq2J3WCgeazcRToPEwoNlecFtnO+UHybtK
   AhGB7Co7h2v7bOMtYUdXB9wCJIKCszhOrn++3pzvY3ZfPY+XAEhrlAnxh
   98037jtgpLXdHE/XK0i10fXOHWuRKY5z1Z8IMASLhzcK6eqmZIOWwKefY
   bbRzdZ11TGkhoiACW/Rcv4m8DvPD9REznaRzlyrikOySi1JCKDyuP+7E/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="455727717"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="455727717"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2023 07:04:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10898"; a="1013195108"
X-IronPort-AV: E=Sophos;i="6.04,209,1695711600"; 
   d="scan'208";a="1013195108"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 18 Nov 2023 07:04:24 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r4Mru-0003zv-18;
        Sat, 18 Nov 2023 15:04:22 +0000
Date:   Sat, 18 Nov 2023 23:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>, Anders Larsen <al@alarsen.net>
Cc:     oe-kbuild-all@lists.linux.dev, Kees Cook <keescook@chromium.org>,
        Ronald Monthero <debug.penguin32@gmail.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH 1/2] qnx4: Extract dir entry filename processing into
 helper
Message-ID: <202311182210.gREgIbSb-lkp@intel.com>
References: <20231118033225.2181299-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118033225.2181299-1-keescook@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kees,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.7-rc1 next-20231117]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kees-Cook/qnx4-Extract-dir-entry-filename-processing-into-helper/20231118-114223
base:   linus/master
patch link:    https://lore.kernel.org/r/20231118033225.2181299-1-keescook%40chromium.org
patch subject: [PATCH 1/2] qnx4: Extract dir entry filename processing into helper
config: i386-randconfig-011-20231118 (https://download.01.org/0day-ci/archive/20231118/202311182210.gREgIbSb-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231118/202311182210.gREgIbSb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311182210.gREgIbSb-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from fs/qnx4/dir.c:16:0:
>> fs/qnx4/qnx4.h:86:51: error: expected ',' before ')' token
            offsetof(struct qnx4_link_info, dl_status));
                                                      ^
   fs/qnx4/qnx4.h:88:56: error: expected ',' before ')' token
            offsetof(union qnx4_directory_entry, de_status));
                                                           ^


vim +86 fs/qnx4/qnx4.h

    47	
    48	/*
    49	 * A qnx4 directory entry is an inode entry or link info
    50	 * depending on the status field in the last byte. The
    51	 * first byte is where the name start either way, and a
    52	 * zero means it's empty.
    53	 *
    54	 * Also, due to a bug in gcc, we don't want to use the
    55	 * real (differently sized) name arrays in the inode and
    56	 * link entries, but always the 'de_name[]' one in the
    57	 * fake struct entry.
    58	 *
    59	 * See
    60	 *
    61	 *   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578#c6
    62	 *
    63	 * for details, but basically gcc will take the size of the
    64	 * 'name' array from one of the used union entries randomly.
    65	 *
    66	 * This use of 'de_name[]' (48 bytes) avoids the false positive
    67	 * warnings that would happen if gcc decides to use 'inode.di_name'
    68	 * (16 bytes) even when the pointer and size were to come from
    69	 * 'link.dl_name' (48 bytes).
    70	 *
    71	 * In all cases the actual name pointer itself is the same, it's
    72	 * only the gcc internal 'what is the size of this field' logic
    73	 * that can get confused.
    74	 */
    75	union qnx4_directory_entry {
    76		struct {
    77			const char de_name[48];
    78			u8 de_pad[15];
    79			u8 de_status;
    80		};
    81		struct qnx4_inode_entry inode;
    82		struct qnx4_link_info link;
    83	};
    84	/* Make sure the status byte is in the same place for all structs. */
    85	_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
  > 86		       offsetof(struct qnx4_link_info, dl_status));
    87	_Static_assert(offsetof(struct qnx4_inode_entry, di_status) ==
    88		       offsetof(union qnx4_directory_entry, de_status));
    89	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
