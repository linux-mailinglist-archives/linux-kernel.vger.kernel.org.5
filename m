Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B43875951A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjGSM3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGSM3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:29:05 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BA8E136;
        Wed, 19 Jul 2023 05:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689769743; x=1721305743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KYLhNrHtUFSx7/C0LdiN2Hgj1mrnIODr7nl7CL2g1ec=;
  b=GLo5fwpA9RYfEwW6/qKpSaiIEECoHFS+FuLBNVg6Y306byW9tmexk3vH
   61HkhMuZoBsg5tXMPfCP2Ad4x/94mVaEDLSCKAqMgwxrVnUDM7jbqTR/6
   09mfAY++DcyhEGtfKGWQQSjvPOQRzWLrUrr1i+So/QtnZOLSi7aHxIA5/
   j4oi8JD/sUGzIE5cO6OytYDtDTqKqE/B1r2RCjVUgnzmmPgRZnc7+GdBZ
   LRcGrupUQNaQCfszvio/ZqbiJqQaf5B4kwKH3G9IqZzOkcojKsjdgls+H
   C0OoPMwO9AqOtYUibJ+C2yV9s0mUByMVu5axM0xfdnIhg5igMtc1ZGI0B
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="397303362"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="397303362"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 05:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="793998622"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="793998622"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 19 Jul 2023 05:28:42 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM6IL-0004n7-0g;
        Wed, 19 Jul 2023 12:28:41 +0000
Date:   Wed, 19 Jul 2023 20:28:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunlong Xing <yunlong.xing@unisoc.com>, miklos@szeredi.hu,
        amir73il@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
        hongyu.jin@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH V2] ovl: fix mount fail because the upper doesn't have
 space
Message-ID: <202307192052.2CaL6sdr-lkp@intel.com>
References: <20230719085434.154834-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719085434.154834-1-yunlong.xing@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunlong,

kernel test robot noticed the following build errors:

[auto build test ERROR on mszeredi-vfs/overlayfs-next]
[also build test ERROR on linus/master v6.5-rc2 next-20230719]
[cannot apply to mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunlong-Xing/ovl-fix-mount-fail-because-the-upper-doesn-t-have-space/20230719-165654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
patch link:    https://lore.kernel.org/r/20230719085434.154834-1-yunlong.xing%40unisoc.com
patch subject: [PATCH V2] ovl: fix mount fail because the upper doesn't have space
config: arc-randconfig-r024-20230718 (https://download.01.org/0day-ci/archive/20230719/202307192052.2CaL6sdr-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307192052.2CaL6sdr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307192052.2CaL6sdr-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/overlayfs/super.c: In function 'ovl_make_workdir':
>> fs/overlayfs/super.c:1192:25: warning: missing terminating " character
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                         ^
   fs/overlayfs/super.c:1193:28: warning: missing terminating " character
    1193 |                         err");
         |                            ^
>> fs/overlayfs/super.c:2065:23: error: unterminated argument list invoking macro "pr_warn"
    2065 | module_exit(ovl_exit);
         |                       ^
>> fs/overlayfs/super.c:1192:17: error: 'pr_warn' undeclared (first use in this function)
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                 ^~~~~~~
   fs/overlayfs/super.c:1192:17: note: each undeclared identifier is reported only once for each function it appears in
>> fs/overlayfs/super.c:1192:24: error: expected ';' at end of input
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                        ^
         |                        ;
   ......
   fs/overlayfs/super.c:1191:9: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
    1191 |         if (!rename_whiteout)
         |         ^~
   fs/overlayfs/super.c:1191:9: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
>> fs/overlayfs/super.c:1192:17: error: expected declaration or statement at end of input
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                 ^~~~~~~
>> fs/overlayfs/super.c:1188:17: error: label 'out' used but not defined
    1188 |                 goto out;
         |                 ^~~~
   fs/overlayfs/super.c:1144:13: warning: unused variable 'fh_type' [-Wunused-variable]
    1144 |         int fh_type;
         |             ^~~~~~~
   fs/overlayfs/super.c: At top level:
   fs/overlayfs/super.c:1136:12: warning: 'ovl_make_workdir' defined but not used [-Wunused-function]
    1136 | static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
         |            ^~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:1118:12: warning: 'ovl_create_volatile_dirty' defined but not used [-Wunused-function]
    1118 | static int ovl_create_volatile_dirty(struct ovl_fs *ofs)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:969:12: warning: 'ovl_get_upper' defined but not used [-Wunused-function]
     969 | static int ovl_get_upper(struct super_block *sb, struct ovl_fs *ofs,
         |            ^~~~~~~~~~~~~
   fs/overlayfs/super.c:926:36: warning: 'ovl_user_xattr_handlers' defined but not used [-Wunused-variable]
     926 | static const struct xattr_handler *ovl_user_xattr_handlers[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:920:36: warning: 'ovl_trusted_xattr_handlers' defined but not used [-Wunused-variable]
     920 | static const struct xattr_handler *ovl_trusted_xattr_handlers[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:859:13: warning: 'ovl_workdir_ok' defined but not used [-Wunused-function]
     859 | static bool ovl_workdir_ok(struct dentry *workdir, struct dentry *upperdir)
         |             ^~~~~~~~~~~~~~
   fs/overlayfs/super.c:816:12: warning: 'ovl_lower_dir' defined but not used [-Wunused-function]
     816 | static int ovl_lower_dir(const char *name, struct path *path,
         |            ^~~~~~~~~~~~~
   fs/overlayfs/super.c:580:12: warning: 'ovl_fs_params_verify' defined but not used [-Wunused-function]
     580 | static int ovl_fs_params_verify(const struct ovl_fs_context *ctx,
         |            ^~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:493:12: warning: 'ovl_parse_param' defined but not used [-Wunused-function]
     493 | static int ovl_parse_param(struct fs_context *fc, struct fs_parameter *param)
         |            ^~~~~~~~~~~~~~~
   fs/overlayfs/super.c:442:38: warning: 'ovl_super_operations' defined but not used [-Wunused-const-variable=]
     442 | static const struct super_operations ovl_super_operations = {
         |                                      ^~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:420:12: warning: 'ovl_reconfigure' defined but not used [-Wunused-function]
     420 | static int ovl_reconfigure(struct fs_context *fc)
         |            ^~~~~~~~~~~~~~~
   fs/overlayfs/super.c:166:39: warning: 'ovl_dentry_operations' defined but not used [-Wunused-const-variable=]
     166 | static const struct dentry_operations ovl_dentry_operations = {
         |                                       ^~~~~~~~~~~~~~~~~~~~~


vim +/pr_warn +2065 fs/overlayfs/super.c

e9be9d5e76e348 Miklos Szeredi 2014-10-24  2063  
e9be9d5e76e348 Miklos Szeredi 2014-10-24  2064  module_init(ovl_init);
e9be9d5e76e348 Miklos Szeredi 2014-10-24 @2065  module_exit(ovl_exit);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
