Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E407759745
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 15:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGSNsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 09:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjGSNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 09:48:43 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429C019A;
        Wed, 19 Jul 2023 06:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689774521; x=1721310521;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WtZGo5MYz/QLJnMhXvyu+YJ2hDQjW8Fo7x4zjLlESKg=;
  b=Eogipyz7swNoe9lT+o1WwY9+lnjYO8QQrpbFp+WUL5IlI+1Ex03IdBxa
   Ny2Z07cDYeLip2pmZPHqsosXp7qUbHxmbojklsdwixfsWtcefcibt7Xis
   5BKL52lL3LYhZRXFpn5/Pou3RXTYkfVTzdHPfAdgInGG3OR+gH7DxwRDM
   v+LB/BaAoweGLZu9Oh9zvE2pyzgXzxYr+boBLfcKa1vpkX9Q6oZC0xTcp
   DirjmhjHQLS/4K3Qldc7oBTiOATgU4QYD621CgwulZt3aVUtgF74ApiCF
   2ZD22fkm3LtHLKnse1ELfCzKMQltGpRb4KA1IbBy6gBtXDP6tc1trYzOu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="346772072"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="346772072"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2023 06:48:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="1054716022"
X-IronPort-AV: E=Sophos;i="6.01,216,1684825200"; 
   d="scan'208";a="1054716022"
Received: from lkp-server02.sh.intel.com (HELO 36946fcf73d7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2023 06:48:38 -0700
Received: from kbuild by 36946fcf73d7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qM7Xh-0004xS-1u;
        Wed, 19 Jul 2023 13:48:37 +0000
Date:   Wed, 19 Jul 2023 21:40:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yunlong Xing <yunlong.xing@unisoc.com>, miklos@szeredi.hu,
        amir73il@gmail.com
Cc:     oe-kbuild-all@lists.linux.dev, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
        hongyu.jin@unisoc.com, yunlongxing23@gmail.com
Subject: Re: [PATCH V2] ovl: fix mount fail because the upper doesn't have
 space
Message-ID: <202307192158.lNbgYfit-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on mszeredi-vfs/overlayfs-next]
[also build test WARNING on linus/master]
[cannot apply to mszeredi-vfs/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yunlong-Xing/ovl-fix-mount-fail-because-the-upper-doesn-t-have-space/20230719-165654
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mszeredi/vfs.git overlayfs-next
patch link:    https://lore.kernel.org/r/20230719085434.154834-1-yunlong.xing%40unisoc.com
patch subject: [PATCH V2] ovl: fix mount fail because the upper doesn't have space
config: i386-randconfig-i002-20230718 (https://download.01.org/0day-ci/archive/20230719/202307192158.lNbgYfit-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230719/202307192158.lNbgYfit-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307192158.lNbgYfit-lkp@intel.com/

All warnings (new ones prefixed by >>):

   fs/overlayfs/super.c: In function 'ovl_make_workdir':
   fs/overlayfs/super.c:1192:25: warning: missing terminating " character
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
>> fs/overlayfs/super.c:1144:13: warning: unused variable 'fh_type' [-Wunused-variable]
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
>> fs/overlayfs/super.c:926:36: warning: 'ovl_user_xattr_handlers' defined but not used [-Wunused-variable]
     926 | static const struct xattr_handler *ovl_user_xattr_handlers[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~
>> fs/overlayfs/super.c:920:36: warning: 'ovl_trusted_xattr_handlers' defined but not used [-Wunused-variable]
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
>> fs/overlayfs/super.c:442:38: warning: 'ovl_super_operations' defined but not used [-Wunused-const-variable=]
     442 | static const struct super_operations ovl_super_operations = {
         |                                      ^~~~~~~~~~~~~~~~~~~~
   fs/overlayfs/super.c:420:12: warning: 'ovl_reconfigure' defined but not used [-Wunused-function]
     420 | static int ovl_reconfigure(struct fs_context *fc)
         |            ^~~~~~~~~~~~~~~
>> fs/overlayfs/super.c:166:39: warning: 'ovl_dentry_operations' defined but not used [-Wunused-const-variable=]
     166 | static const struct dentry_operations ovl_dentry_operations = {
         |                                       ^~~~~~~~~~~~~~~~~~~~~


vim +/fh_type +1144 fs/overlayfs/super.c

c86243b090bc25 Vivek Goyal       2020-08-31  1135  
146d62e5a5867f Amir Goldstein    2019-04-18  1136  static int ovl_make_workdir(struct super_block *sb, struct ovl_fs *ofs,
2d3430875a3a97 Al Viro           2022-08-04  1137  			    const struct path *workpath)
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1138  {
08f4c7c86d4cf1 Miklos Szeredi    2020-06-04  1139  	struct vfsmount *mnt = ovl_upper_mnt(ofs);
2b1a77461f1602 Miklos Szeredi    2022-09-24  1140  	struct dentry *workdir;
2b1a77461f1602 Miklos Szeredi    2022-09-24  1141  	struct file *tmpfile;
d80172c2d85947 Amir Goldstein    2020-02-20  1142  	bool rename_whiteout;
d80172c2d85947 Amir Goldstein    2020-02-20  1143  	bool d_type;
e487d889b7e3e8 Amir Goldstein    2017-11-07 @1144  	int fh_type;
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1145  	int err;
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1146  
2ba9d57e650448 Amir Goldstein    2018-01-03  1147  	err = mnt_want_write(mnt);
2ba9d57e650448 Amir Goldstein    2018-01-03  1148  	if (err)
2ba9d57e650448 Amir Goldstein    2018-01-03  1149  		return err;
2ba9d57e650448 Amir Goldstein    2018-01-03  1150  
235ce9ed96bc62 Amir Goldstein    2020-08-30  1151  	workdir = ovl_workdir_create(ofs, OVL_WORKDIR_NAME, false);
235ce9ed96bc62 Amir Goldstein    2020-08-30  1152  	err = PTR_ERR(workdir);
235ce9ed96bc62 Amir Goldstein    2020-08-30  1153  	if (IS_ERR_OR_NULL(workdir))
2ba9d57e650448 Amir Goldstein    2018-01-03  1154  		goto out;
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1155  
235ce9ed96bc62 Amir Goldstein    2020-08-30  1156  	ofs->workdir = workdir;
235ce9ed96bc62 Amir Goldstein    2020-08-30  1157  
146d62e5a5867f Amir Goldstein    2019-04-18  1158  	err = ovl_setup_trap(sb, ofs->workdir, &ofs->workdir_trap, "workdir");
146d62e5a5867f Amir Goldstein    2019-04-18  1159  	if (err)
146d62e5a5867f Amir Goldstein    2019-04-18  1160  		goto out;
146d62e5a5867f Amir Goldstein    2019-04-18  1161  
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1162  	/*
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1163  	 * Upper should support d_type, else whiteouts are visible.  Given
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1164  	 * workdir and upper are on same fs, we can do iterate_dir() on
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1165  	 * workdir. This check requires successful creation of workdir in
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1166  	 * previous step.
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1167  	 */
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1168  	err = ovl_check_d_type_supported(workpath);
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1169  	if (err < 0)
2ba9d57e650448 Amir Goldstein    2018-01-03  1170  		goto out;
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1171  
d80172c2d85947 Amir Goldstein    2020-02-20  1172  	d_type = err;
d80172c2d85947 Amir Goldstein    2020-02-20  1173  	if (!d_type)
1bd0a3aea4357e lijiazi           2019-12-16  1174  		pr_warn("upper fs needs to support d_type.\n");
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1175  
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1176  	/* Check if upper/work fs supports O_TMPFILE */
2b1a77461f1602 Miklos Szeredi    2022-09-24  1177  	tmpfile = ovl_do_tmpfile(ofs, ofs->workdir, S_IFREG | 0);
2b1a77461f1602 Miklos Szeredi    2022-09-24  1178  	ofs->tmpfile = !IS_ERR(tmpfile);
ad204488d3046b Miklos Szeredi    2017-11-10  1179  	if (ofs->tmpfile)
2b1a77461f1602 Miklos Szeredi    2022-09-24  1180  		fput(tmpfile);
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1181  	else
1bd0a3aea4357e lijiazi           2019-12-16  1182  		pr_warn("upper fs does not support tmpfile.\n");
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1183  
cad218ab332078 Amir Goldstein    2020-02-20  1184  
cad218ab332078 Amir Goldstein    2020-02-20  1185  	/* Check if upper/work fs supports RENAME_WHITEOUT */
576bb263450bbb Christian Brauner 2022-04-04  1186  	err = ovl_check_rename_whiteout(ofs);
a64df2da371f93 Yunlong Xing      2023-07-19  1187  	if (err < 0 && err != -ENOSPC)
cad218ab332078 Amir Goldstein    2020-02-20  1188  		goto out;
cad218ab332078 Amir Goldstein    2020-02-20  1189  
a64df2da371f93 Yunlong Xing      2023-07-19  1190  	rename_whiteout = err > 0;
d80172c2d85947 Amir Goldstein    2020-02-20  1191  	if (!rename_whiteout)
a64df2da371f93 Yunlong Xing      2023-07-19  1192  		pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n,
a64df2da371f93 Yunlong Xing      2023-07-19  1193  			err");
cad218ab332078 Amir Goldstein    2020-02-20  1194  
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1195  	/*
2d2f2d7322ff43 Miklos Szeredi    2020-12-14  1196  	 * Check if upper/work fs supports (trusted|user).overlay.* xattr
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1197  	 */
c914c0e27eb084 Amir Goldstein    2022-04-04  1198  	err = ovl_setxattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE, "0", 1);
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1199  	if (err) {
b10b85fe5149ee Miklos Szeredi    2022-07-27  1200  		pr_warn("failed to set xattr on upper\n");
ad204488d3046b Miklos Szeredi    2017-11-10  1201  		ofs->noxattr = true;
af5f2396b671c9 Amir Goldstein    2023-06-17  1202  		if (ovl_redirect_follow(ofs)) {
af5f2396b671c9 Amir Goldstein    2023-06-17  1203  			ofs->config.redirect_mode = OVL_REDIRECT_NOFOLLOW;
af5f2396b671c9 Amir Goldstein    2023-06-17  1204  			pr_warn("...falling back to redirect_dir=nofollow.\n");
af5f2396b671c9 Amir Goldstein    2023-06-17  1205  		}
af5f2396b671c9 Amir Goldstein    2023-06-17  1206  		if (ofs->config.metacopy) {
d5791044d2e574 Vivek Goyal       2018-05-11  1207  			ofs->config.metacopy = false;
af5f2396b671c9 Amir Goldstein    2023-06-17  1208  			pr_warn("...falling back to metacopy=off.\n");
af5f2396b671c9 Amir Goldstein    2023-06-17  1209  		}
af5f2396b671c9 Amir Goldstein    2023-06-17  1210  		if (ofs->config.index) {
af5f2396b671c9 Amir Goldstein    2023-06-17  1211  			ofs->config.index = false;
af5f2396b671c9 Amir Goldstein    2023-06-17  1212  			pr_warn("...falling back to index=off.\n");
b0e0f69731cde2 Amir Goldstein    2021-03-09  1213  		}
b0e0f69731cde2 Amir Goldstein    2021-03-09  1214  		/*
b0e0f69731cde2 Amir Goldstein    2021-03-09  1215  		 * xattr support is required for persistent st_ino.
b0e0f69731cde2 Amir Goldstein    2021-03-09  1216  		 * Without persistent st_ino, xino=auto falls back to xino=off.
b0e0f69731cde2 Amir Goldstein    2021-03-09  1217  		 */
b0e0f69731cde2 Amir Goldstein    2021-03-09  1218  		if (ofs->config.xino == OVL_XINO_AUTO) {
b0e0f69731cde2 Amir Goldstein    2021-03-09  1219  			ofs->config.xino = OVL_XINO_OFF;
b10b85fe5149ee Miklos Szeredi    2022-07-27  1220  			pr_warn("...falling back to xino=off.\n");
b0e0f69731cde2 Amir Goldstein    2021-03-09  1221  		}
b10b85fe5149ee Miklos Szeredi    2022-07-27  1222  		if (err == -EPERM && !ofs->config.userxattr)
b10b85fe5149ee Miklos Szeredi    2022-07-27  1223  			pr_info("try mounting with 'userxattr' option\n");
2ba9d57e650448 Amir Goldstein    2018-01-03  1224  		err = 0;
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1225  	} else {
c914c0e27eb084 Amir Goldstein    2022-04-04  1226  		ovl_removexattr(ofs, ofs->workdir, OVL_XATTR_OPAQUE);
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1227  	}
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1228  
d80172c2d85947 Amir Goldstein    2020-02-20  1229  	/*
d80172c2d85947 Amir Goldstein    2020-02-20  1230  	 * We allowed sub-optimal upper fs configuration and don't want to break
d80172c2d85947 Amir Goldstein    2020-02-20  1231  	 * users over kernel upgrade, but we never allowed remote upper fs, so
d80172c2d85947 Amir Goldstein    2020-02-20  1232  	 * we can enforce strict requirements for remote upper fs.
d80172c2d85947 Amir Goldstein    2020-02-20  1233  	 */
d80172c2d85947 Amir Goldstein    2020-02-20  1234  	if (ovl_dentry_remote(ofs->workdir) &&
d80172c2d85947 Amir Goldstein    2020-02-20  1235  	    (!d_type || !rename_whiteout || ofs->noxattr)) {
d80172c2d85947 Amir Goldstein    2020-02-20  1236  		pr_err("upper fs missing required features.\n");
d80172c2d85947 Amir Goldstein    2020-02-20  1237  		err = -EINVAL;
d80172c2d85947 Amir Goldstein    2020-02-20  1238  		goto out;
d80172c2d85947 Amir Goldstein    2020-02-20  1239  	}
d80172c2d85947 Amir Goldstein    2020-02-20  1240  
c86243b090bc25 Vivek Goyal       2020-08-31  1241  	/*
c86243b090bc25 Vivek Goyal       2020-08-31  1242  	 * For volatile mount, create a incompat/volatile/dirty file to keep
c86243b090bc25 Vivek Goyal       2020-08-31  1243  	 * track of it.
c86243b090bc25 Vivek Goyal       2020-08-31  1244  	 */
c86243b090bc25 Vivek Goyal       2020-08-31  1245  	if (ofs->config.ovl_volatile) {
c86243b090bc25 Vivek Goyal       2020-08-31  1246  		err = ovl_create_volatile_dirty(ofs);
c86243b090bc25 Vivek Goyal       2020-08-31  1247  		if (err < 0) {
c86243b090bc25 Vivek Goyal       2020-08-31  1248  			pr_err("Failed to create volatile/dirty file.\n");
c86243b090bc25 Vivek Goyal       2020-08-31  1249  			goto out;
c86243b090bc25 Vivek Goyal       2020-08-31  1250  		}
c86243b090bc25 Vivek Goyal       2020-08-31  1251  	}
c86243b090bc25 Vivek Goyal       2020-08-31  1252  
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1253  	/* Check if upper/work fs supports file handles */
e487d889b7e3e8 Amir Goldstein    2017-11-07  1254  	fh_type = ovl_can_decode_fh(ofs->workdir->d_sb);
e487d889b7e3e8 Amir Goldstein    2017-11-07  1255  	if (ofs->config.index && !fh_type) {
ad204488d3046b Miklos Szeredi    2017-11-10  1256  		ofs->config.index = false;
1bd0a3aea4357e lijiazi           2019-12-16  1257  		pr_warn("upper fs does not support file handles, falling back to index=off.\n");
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1258  	}
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1259  
e487d889b7e3e8 Amir Goldstein    2017-11-07  1260  	/* Check if upper fs has 32bit inode numbers */
e487d889b7e3e8 Amir Goldstein    2017-11-07  1261  	if (fh_type != FILEID_INO32_GEN)
0f831ec85eda1a Amir Goldstein    2019-11-16  1262  		ofs->xino_mode = -1;
e487d889b7e3e8 Amir Goldstein    2017-11-07  1263  
f168f1098dd903 Amir Goldstein    2018-01-19  1264  	/* NFS export of r/w mount depends on index */
f168f1098dd903 Amir Goldstein    2018-01-19  1265  	if (ofs->config.nfs_export && !ofs->config.index) {
1bd0a3aea4357e lijiazi           2019-12-16  1266  		pr_warn("NFS export requires \"index=on\", falling back to nfs_export=off.\n");
f168f1098dd903 Amir Goldstein    2018-01-19  1267  		ofs->config.nfs_export = false;
f168f1098dd903 Amir Goldstein    2018-01-19  1268  	}
2ba9d57e650448 Amir Goldstein    2018-01-03  1269  out:
2ba9d57e650448 Amir Goldstein    2018-01-03  1270  	mnt_drop_write(mnt);
2ba9d57e650448 Amir Goldstein    2018-01-03  1271  	return err;
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1272  }
8ed61dc37ee0a3 Miklos Szeredi    2017-11-09  1273  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
