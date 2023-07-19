Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B587594F5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 14:18:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjGSMSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 08:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGSMSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 08:18:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EEAE0;
        Wed, 19 Jul 2023 05:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689769125; x=1721305125;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yu1UzLTeugLyqYX6UqEkcCgWfK42hiuHpkQFfI2Ed04=;
  b=LugTkoDUUdpeDdermFQsnfrC7QAfrwwCQKM2t2oyO+abpmD7atS8+2Pe
   6Lsr9OnUTvzJLuk1SkjwmyD60Wm9IfyEha6QipBworO8SXmMuBstLd8WO
   p9y1gN5T6oLuvIvHvBJ5i+lNNta5aH7GdAx67RGyPxAJqrKYWS6XWhFwn
   thivoRzMSGxmL10PIRwqTN6Z+xi/q3C7liSQffw1STh6UBtGpYXDSycZI
   sMPYPKXIG00yHsNfUS5/lrl5VyX2+wCEpExmWX7LLMjFkwxm5qPXGSV86
   36AdCNBcL+wW+CWZT+vnZCUb2uv8oCZgAKs5KvY6XXgRw6rN8SrKD1TTZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346747429"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346747429"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 05:18:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="674267301"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="674267301"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 19 Jul 2023 05:18:41 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM68f-0004mt-0M;
        Wed, 19 Jul 2023 12:18:41 +0000
Date:   Wed, 19 Jul 2023 20:17:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunlong Xing <yunlong.xing@unisoc.com>, miklos@szeredi.hu,
        amir73il@gmail.com
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhiguo.niu@unisoc.com, hongyu.jin@unisoc.com,
        yunlongxing23@gmail.com
Subject: Re: [PATCH V2] ovl: fix mount fail because the upper doesn't have
 space
Message-ID: <202307192047.274jiOge-lkp@intel.com>
References: <20230719085434.154834-1-yunlong.xing@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719085434.154834-1-yunlong.xing@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
[also build test ERROR on linus/master]
[cannot apply to mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunlong-Xing/ovl-fix-mount-fail-because-the-upper-doesn-t-have-space/20230719-165654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
patch link:    https://lore.kernel.org/r/20230719085434.154834-1-yunlong.xing%40unisoc.com
patch subject: [PATCH V2] ovl: fix mount fail because the upper doesn't have space
config: arm64-randconfig-r026-20230718 (https://download.01.org/0day-ci/archive/20230719/202307192047.274jiOge-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307192047.274jiOge-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307192047.274jiOge-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   fs/overlayfs/super.c:1192:11: warning: missing terminating '"' character [-Winvalid-pp-token]
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                         ^
   fs/overlayfs/super.c:1193:7: warning: missing terminating '"' character [-Winvalid-pp-token]
    1193 |                         err");
         |                            ^
>> fs/overlayfs/super.c:1192:3: error: unterminated function-like macro invocation
    1192 |                 pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
         |                 ^
   include/linux/printk.h:507:9: note: macro 'pr_warn' defined here
     507 | #define pr_warn(fmt, ...) \
         |         ^
>> fs/overlayfs/super.c:2065:23: error: expected expression
    2065 | module_exit(ovl_exit);
         |                       ^
>> fs/overlayfs/super.c:2065:23: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
   fs/overlayfs/super.c:1191:2: note: previous statement is here
    1191 |         if (!rename_whiteout)
         |         ^
>> fs/overlayfs/super.c:2065:23: error: expected '}'
    2065 | module_exit(ovl_exit);
         |                       ^
   fs/overlayfs/super.c:1138:1: note: to match this '{'
    1138 | {
         | ^
>> fs/overlayfs/super.c:1154:8: error: use of undeclared label 'out'
    1154 |                 goto out;
         |                      ^
   3 warnings and 4 errors generated.


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
> 1154			goto out;
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
> 1191		if (!rename_whiteout)
> 1192			pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
> 1193				err");
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
