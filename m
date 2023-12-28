Return-Path: <linux-kernel+bounces-12347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE481F3A3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7182815B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E01423A7;
	Thu, 28 Dec 2023 01:35:25 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB571FAA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4T0rZT4Fp9z1FGKj;
	Thu, 28 Dec 2023 09:31:29 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F2A81A0194;
	Thu, 28 Dec 2023 09:35:06 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:33:39 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH mtd-utils 11/11] tests: ubifs_repair: Add README
Date: Thu, 28 Dec 2023 09:36:39 +0800
Message-ID: <20231228013639.2827205-12-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20231228013639.2827205-1-chengzhihao1@huawei.com>
References: <20231228013639.2827205-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

Add document for ubifs_repair testcases, explain all testcases and how
to run them.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 tests/ubifs_repair-tests/README.txt | 233 ++++++++++++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100644 tests/ubifs_repair-tests/README.txt

diff --git a/tests/ubifs_repair-tests/README.txt b/tests/ubifs_repair-tests/README.txt
new file mode 100644
index 0000000..cb1ce98
--- /dev/null
+++ b/tests/ubifs_repair-tests/README.txt
@@ -0,0 +1,233 @@
+
+ ubifs_repair tests
+ ==================
+
+ There are seven testcases for ubifs_repair on encryption/non-encryption
+ situations:
+   1) authentication_refuse: Currently authenticated UBIFS image is not
+      supported for repairing, check whether ubifs_repair can refuse
+      authenticated UBIFS image.
+   2) random_corrupted_repair: Inject random corruption on UBIFS image
+      by writting random data on kinds of mtd devices (eg. nand, nor),
+      check the consistency of UBIFS after repairing.
+      This testcase simulate random bad UBIFS image caused by hardware
+      exceptions(eg. ecc uncorrectable, unwritten), and makes sure that
+      ubifs_repair could make UBIFS be consistent after repairing UBIFS
+      image.
+   3) cycle_corrupted_repair_fault_inject: Inject memory/io fault while
+      repairing corrupted UBIFS images.
+      This testcase mainly checks whether ubifs_repair has problems (eg.
+      memleak, UAF, null-ptr-def, etc.) in random error paths. Besides,
+      it provides a similar way to simulate powercut during repairing,
+      and checks whether ubifs_repair can fix an UBIFS image after many
+      repairing rounds interrupted by kinds of errors.
+   4) cycle_powercut_mount_repair: Inject powercut while doing fsstress
+      on mounted UBIFS, check the consistency of UBIFS after repairing.
+      This testscase mainly makes sure that ubifs_repair can make UBIFS
+      image be consistent in common stress cases and powercut cases.
+   5) powercut_repair_mount: Inject powercut while doing fsstress on
+      mounted UBIFS for kinds of flashes (eg. nand, nor).
+      This testcase mainly makes sure that ubifs_repair can make UBIFS
+      image be consistent on different flashes (eg. nand, nor). Because
+      the min_io_size of nor flash is 1, the UBIFS image on nor flash
+      will be different from nand flash after doing powercut, so we need
+      make sure ubifs_repair can handle these two types of flash.
+   6) cycle_mount_repair_check: Do fsstress and repair ubifs image, make
+      sure all files(and their data) are not lost after repairing.
+      This testcase mainly checks whether ubifs_repair could corrupt
+      filesystem content in common case.
+   7) repair_bad_image: For kinds of inconsistent UBIFS images(which
+      can simulate corruptions caused by some potentional UBIFS bug), check
+      repairing result.
+      This testcase mainly checks whether the behavior is in expected after
+      repairing specific inconsistent UBIFS image. There is no debugfs tools
+      (for example: debugfs[ext4], xfs_db) for UBIFS, so no way to inject
+      precise corruption into UBIFS image, we have to prepare inconsistent
+      UBIFS images in advance like e2fsprogs[1] does. (Goto [2] to see how to
+      generate inconsistent UBIFS images). Here's a descriptons of the various
+      test images:
+
+      =========================================================================
+            image         |     Description     |          expectancy
+      -------------------------------------------------------------------------
+      good                | good image contains | repair success, fs content is
+                          | kinds of files.     | not changed.
+      -------------------------------------------------------------------------
+      sb_fanout           | invalid fanout in   | repair failed.
+                          | superblock.         |
+      -------------------------------------------------------------------------
+      sb_fmt_version      | invalid fmt_version | repair failed.
+                          | in superblock.      |
+      -------------------------------------------------------------------------
+      sb_leb_size         | invalid leb_size in | repair failed.
+                          | superblock.         |
+      -------------------------------------------------------------------------
+      sb_log_lebs         | invalid log lebs in | repair failed.
+                          | superblock.         |
+      -------------------------------------------------------------------------
+      sb_min_io_size      | invalid min_io_size | repair failed.
+                          | in superblock.      |
+      -------------------------------------------------------------------------
+      master_highest_inum | invalid highest_inum| repair success, fs content is
+                          | in master nodes.    | not changed.
+      -------------------------------------------------------------------------
+      master_lpt          | bad lpt pos in      | repair success, fs content is
+                          | master nodes.       | not changed.
+      -------------------------------------------------------------------------
+      master_tnc          | bad tnc pos in      | repair success, fs content is
+                          | master nodes.       | not changed.
+      -------------------------------------------------------------------------
+      master_total_dead   | bad total_dead in   | repair success, fs content is
+                          | master nodes.       | not changed.
+      -------------------------------------------------------------------------
+      master_total_dirty  | bad total_dirty in  | repair success, fs content is
+                          | master nodes.       | not changed.
+      -------------------------------------------------------------------------
+      master_total_free   | bad total_free in   | repair success, fs content is
+                          | master nodes.       | not changed.
+      -------------------------------------------------------------------------
+      log                 | corrupted log area. | repair success, fs content is
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      lpt_dirty           | bad dirty in pnode. | repair success, fs content is
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      lpt_flags           | bad flags in pnode  | repair success, fs content is
+                          | (eg. index).        | not changed.
+      -------------------------------------------------------------------------
+      lpt_free            | bad free in pnode.  | repair success, fs content is
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      lpt_pos             | bad pos in nnode.   | repair success, fs content is
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      tnc_lv0_key         | bad key in lv0      | repair success, fs content is
+                          | znode.              | not changed.
+      -------------------------------------------------------------------------
+      tnc_lv0_len         | bad len in lv0      | repair success, fs content is
+                          | znode.              | not changed.
+      -------------------------------------------------------------------------
+      tnc_lv0_pos         | bad pos in lv0      | repair success, fs content is
+                          | znode.              | not changed.
+      -------------------------------------------------------------------------
+      tnc_noleaf_key      | bad key in non-leaf | repair success, fs content is
+                          | znode.              | not changed.
+      -------------------------------------------------------------------------
+      tnc_noleaf_len      | bad len in non-leaf | repair success, fs content is
+                          | znode.              | not changed.
+      -------------------------------------------------------------------------
+      tnc_noleaf_pos      | bad pos in non-leaf | repair success, fs content is
+                          | znode.              | not changed.
+      -------------------------------------------------------------------------
+      inode_data          | bad data node.      | repair success, file content
+                          |                     | is changed, other files are
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      inode_mode          | bad inode mode for  | repair success, soft link
+                          | solf link file.     | file is dropped, other files
+                          |                     | are not changed.
+      -------------------------------------------------------------------------
+      inode_nlink         | wrong nlink for     | repair success, nlink is
+                          | file.               | corrected, fs content is not
+                          |                     | changed.
+      -------------------------------------------------------------------------
+      inode_size          | wrong inode size    | repair success, inode size is
+                          | for file.           | corrected, fs content is not
+                          |                     | changed.
+      -------------------------------------------------------------------------
+      inode_xcnt          | wrong inode         | repair success, xattr_cnt is
+                          | xattr_cnt for file. | corrected, fs content is not
+                          |                     | changed.
+      -------------------------------------------------------------------------
+      soft_link_data_len  | bad inode data_len  | repair success, soft link
+                          | for solt link file. | file is dropped, other files
+                          |                     | are not changed.
+      -------------------------------------------------------------------------
+      dentry_key          | bad dentry key for  | repair success, dentry is
+                          | file.               | removed, other files are
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      dentry_nlen         | inconsistent nlen   | repair success, dentry is
+                          | and name in dentry  | removed, other files are
+                          | for file.           | not changed.
+      -------------------------------------------------------------------------
+      dentry_type         | inconsistent type   | repair success, dentry is
+                          | between dentry and  | removed, other files are
+                          | inode for file.     | not changed.
+      -------------------------------------------------------------------------
+      xinode_flags        | lost UBIFS_XATTR_FL | repair success, xattr is
+                          | in xattr inode      | removed, other files are
+                          | flags for file.     | not changed.
+      -------------------------------------------------------------------------
+      xinode_key          | bad xattr inode key | repair success, xattr is
+                          | for file.           | removed, other files are
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      xinode_mode         | bad xattr inode     | repair success, xattr is
+                          | mode for file.      | removed, other files are
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      xentry_key          | bad xattr entry key | repair success, xattr is
+                          | for file.           | removed, other files are
+                          |                     | not changed.
+      -------------------------------------------------------------------------
+      xentry_nlen         | inconsistent nlen   | repair success, xattr is
+                          | and name in xattr   | removed, other files are
+                          | entry for file.     | not changed.
+      -------------------------------------------------------------------------
+      xentry_type         | inconsistent type   | repair success, xattr is
+                          | between xattr entry | removed, other files are
+                          | and xattr inode for | not changed.
+                          | file.               |
+      -------------------------------------------------------------------------
+      dir_lost            | bad dentry for dir. | repair success, dir and files
+                          |                     | under dir are removed, other
+                          |                     | files are not changed.
+      -------------------------------------------------------------------------
+      root_dir            | bad '/'.            | repair success, create new
+                          |                     | root dir('/').
+      =========================================================================
+
+ Dependence
+ ----------
+ kernel configs:
+   CONFIG_MTD_NAND_NANDSIM=m
+   CONFIG_MTD_MTDRAM=m
+   CONFIG_MTD_UBI=m
+   CONFIG_MTD_UBI_FASTMAP=y
+   CONFIG_UBIFS_FS=m
+   CONFIG_UBIFS_FS_XATTR=y
+   CONFIG_UBIFS_FS_AUTHENTICATION=y
+   CONFIG_FS_ENCRYPTION=y
+   CONFIG_FAILSLAB=y
+   CONFIG_FAIL_PAGE_ALLOC=y
+
+   CONFIG_DEBUG_KMEMLEAK=y // optional
+
+ tools:
+   fsstress		[3][4]
+   keyctl		[5]
+   fscryptctl		[6]
+   setfattr/getfattr	[7]
+
+ Running
+ -------
+
+ Please build and install mtd-utils first.
+ Run single case:
+   cd $INSTALL_DIR/libexec/mtd-utils
+   ./powercut_repair_mount.sh
+   ./random_corrupted_repair.sh
+   ./cycle_mount_repair_check.sh
+ Run all cases: sh $INSTALL_DIR/libexec/mtd-utils/ubifs_repair_run_all.sh
+
+ References
+ ----------
+
+ [1] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/tests/README
+ [2] https://bugzilla.kernel.org/show_bug.cgi?id=218327
+ [3] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/tree/ltp/fsstress.c
+ [4] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/fs/fsstress/fsstress.c
+ [5] https://github.com/torvalds/linux/blob/master/security/keys/keyctl.c
+ [6] https://github.com/google/fscryptctl
+ [7] https://github.com/philips/attr/tree/master
-- 
2.13.6


