Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B30759421
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjGSL0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGSL0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:26:52 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3579E4D;
        Wed, 19 Jul 2023 04:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689766008; x=1721302008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iCZNLBU8weIydVb6QYttZRo+MtivYuPsXDy7xlDmD3Y=;
  b=UQcGnwNFhlbYnDzqxrKSEide8K5kwiAYIXOHul0exQ1iI3N//4tWwU5r
   HpPSH3xZVI9SqCjCBMjp3Ebu0lo//cGxgooJOinYzdL8M3N7LauirjqVt
   7cspaIlaah8HVQS5JyUlCSJRWsCesN72fOGiyOu6O+RW1MJKlkncgVkKx
   5ieqa+tVFBDx/LJZAm5ybntp3u7dnJF+IQIDKaoiwqXf5+hh+pWlcklG4
   2I3Q0zbKsP6Z3a4szVTnrfp0yfhweyDwKMvBmU7YLzjnUeHJpO7XgXMM/
   pPXFGFEpAqmWXIF0jU4sdIzmfy9z1MyqSiR5bll/cEVYDDmP+kGKVVN4y
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="351303050"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="351303050"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 04:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="897887988"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="897887988"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 19 Jul 2023 04:26:45 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM5KP-0004it-0o;
        Wed, 19 Jul 2023 11:26:45 +0000
Date:   Wed, 19 Jul 2023 19:26:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunlong Xing <yunlong.xing@unisoc.com>, miklos@szeredi.hu,
        amir73il@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
        hongyu.jin@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH V2] ovl: fix mount fail because the upper doesn't have
 space
Message-ID: <202307191949.czbm8CT2-lkp@intel.com>
References: <20230719085434.154834-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719085434.154834-1-yunlong.xing@unisoc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunlong,

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-vfs/overlayfs-next]
[also build test WARNING on linus/master v6.5-rc2 next-20230719]
[cannot apply to mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunlong-Xing/ovl-fix-mount-fail-because-the-upper-doesn-t-have-space/20230719-165654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
patch link:    https://lore.kernel.org/r/20230719085434.154834-1-yunlong.xing%40unisoc.com
patch subject: [PATCH V2] ovl: fix mount fail because the upper doesn't have space
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20230719/202307191949.czbm8CT2-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307191949.czbm8CT2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307191949.czbm8CT2-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/overlayfs/super.c: In function 'ovl_make_workdir':
>> fs/overlayfs/super.c:1192:25: warning: missing terminating " character
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                         ^
   fs/overlayfs/super.c:1193:28: warning: missing terminating " character
    1193 |                         err");
         |                            ^
   fs/overlayfs/super.c:2065:23: error: unterminated argument list invoking macro "pr_warn"
    2065 | module_exit(ovl_exit);
         |                       ^
   fs/overlayfs/super.c:1192:17: error: 'pr_warn' undeclared (first use in this function)
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                 ^~~~~~~
   fs/overlayfs/super.c:1192:17: note: each undeclared identifier is reported only once for each function it appears in
   fs/overlayfs/super.c:1192:24: error: expected ';' at end of input
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                        ^
         |                        ;
   ......
   fs/overlayfs/super.c:1191:9: note: '-Wmisleading-indentation' is disabled from this point onwards, since column-tracking was disabled due to the size of the code/headers
    1191 |         if (!rename_whiteout)
         |         ^~
   fs/overlayfs/super.c:1191:9: note: adding '-flarge-source-files' will allow for more column-tracking support, at the expense of compilation time and memory
   fs/overlayfs/super.c:1192:17: error: expected declaration or statement at end of input
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                 ^~~~~~~
   fs/overlayfs/super.c:1188:17: error: label 'out' used but not defined
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


vim +1192 fs/overlayfs/super.c

  1135	
  1136	static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
  1137				    const struct path *workpath)
  1138	{
  1139		struct vfsmount *mnt = ovl_upper_mnt(ofs);
  1140		struct dentry *workdir;
  1141		struct file *tmpfile;
  1142		bool rename_whiteout;
  1143		bool d_type;
  1144		int fh_type;
  1145		int err;
  1146	
  1147		err = mnt_want_write(mnt);
  1148		if (err)
  1149			return err;
  1150	
  1151		workdir = ovl_workdir_create(ofs, OVL_WORKDIR_NAME, false);
  1152		err = PTR_ERR(workdir);
  1153		if (IS_ERR_OR_NULL(workdir))
  1154			goto out;
  1155	
  1156		ofs->workdir = workdir;
  1157	
  1158		err = ovl_setup_trap(sb, ofs->workdir, &ofs->workdir_trap, "workdir");
  1159		if (err)
  1160			goto out;
  1161	
  1162		/*
  1163		 * Upper should support d_type, else whiteouts are visible.  Given
  1164		 * workdir and upper are on same fs, we can do iterate_dir() on
  1165		 * workdir. This check requires successful creation of workdir in
  1166		 * previous step.
  1167		 */
  1168		err = ovl_check_d_type_supported(workpath);
  1169		if (err < 0)
  1170			goto out;
  1171	
  1172		d_type = err;
  1173		if (!d_type)
  1174			pr_warn("upper fs needs to support d_type.\n");
  1175	
  1176		/* Check if upper/work fs supports O_TMPFILE */
  1177		tmpfile = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
  1178		ofs->tmpfile = !IS_ERR(tmpfile);
  1179		if (ofs->tmpfile)
  1180			fput(tmpfile);
  1181		else
  1182			pr_warn("upper fs does not support tmpfile.\n");
  1183	
  1184	
  1185		/* Check if upper/work fs supports RENAME_WHITEOUT */
  1186		err = ovl_check_rename_whiteout(ofs);
  1187		if (err < 0 && err != -ENOSPC)
  1188			goto out;
  1189	
  1190		rename_whiteout = err > 0;
  1191		if (!rename_whiteout)
> 1192			pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
  1193				err");
  1194	
  1195		/*
  1196		 * Check if upper/work fs supports (trusted|user).overlay.* xattr
  1197		 */
  1198		err = ovl_setxattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE, "0", 1);
  1199		if (err) {
  1200			pr_warn("failed to set xattr on upper\n");
  1201			ofs->noxattr = true;
  1202			if (ovl_redirect_follow(ofs)) {
  1203				ofs->config.redirect_mode = OVL_REDIRECT_NOFOLLOW;
  1204				pr_warn("...falling back to redirect_dir=nofollow.\n");
  1205			}
  1206			if (ofs->config.metacopy) {
  1207				ofs->config.metacopy = false;
  1208				pr_warn("...falling back to metacopy=off.\n");
  1209			}
  1210			if (ofs->config.index) {
  1211				ofs->config.index = false;
  1212				pr_warn("...falling back to index=off.\n");
  1213			}
  1214			/*
  1215			 * xattr support is required for persistent st_ino.
  1216			 * Without persistent st_ino, xino=auto falls back to xino=off.
  1217			 */
  1218			if (ofs->config.xino == OVL_XINO_AUTO) {
  1219				ofs->config.xino = OVL_XINO_OFF;
  1220				pr_warn("...falling back to xino=off.\n");
  1221			}
  1222			if (err == -EPERM && !ofs->config.userxattr)
  1223				pr_info("try mounting with 'userxattr' option\n");
  1224			err = 0;
  1225		} else {
  1226			ovl_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);
  1227		}
  1228	
  1229		/*
  1230		 * We allowed sub-optimal upper fs configuration and don't want to break
  1231		 * users over kernel upgrade, but we never allowed remote upper fs, so
  1232		 * we can enforce strict requirements for remote upper fs.
  1233		 */
  1234		if (ovl_dentry_remote(ofs->workdir) &&
  1235		    (!d_type || !rename_whiteout || ofs->noxattr)) {
  1236			pr_err("upper fs missing required features.\n");
  1237			err = -EINVAL;
  1238			goto out;
  1239		}
  1240	
  1241		/*
  1242		 * For volatile mount, create a incompat/volatile/dirty file to keep
  1243		 * track of it.
  1244		 */
  1245		if (ofs->config.ovl_volatile) {
  1246			err = ovl_create_volatile_dirty(ofs);
  1247			if (err < 0) {
  1248				pr_err("Failed to create volatile/dirty file.\n");
  1249				goto out;
  1250			}
  1251		}
  1252	
  1253		/* Check if upper/work fs supports file handles */
  1254		fh_type = ovl_can_decode_fh(ofs->workdir->d_sb);
  1255		if (ofs->config.index && !fh_type) {
  1256			ofs->config.index = false;
  1257			pr_warn("upper fs does not support file handles, falling back to index=off.\n");
  1258		}
  1259	
  1260		/* Check if upper fs has 32bit inode numbers */
  1261		if (fh_type != FILEID_INO32_GEN)
  1262			ofs->xino_mode = -1;
  1263	
  1264		/* NFS export of r/w mount depends on index */
  1265		if (ofs->config.nfs_export && !ofs->config.index) {
  1266			pr_warn("NFS export requires \"index=on\", falling back to nfs_export=off.\n");
  1267			ofs->config.nfs_export = false;
  1268		}
  1269	out:
  1270		mnt_drop_write(mnt);
  1271		return err;
  1272	}
  1273	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
