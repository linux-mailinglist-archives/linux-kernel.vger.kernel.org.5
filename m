Return-Path: <linux-kernel+bounces-12345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837FE81F3A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29D9E2815B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 01:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E33C4684;
	Thu, 28 Dec 2023 01:34:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA31410E5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Dec 2023 01:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4T0rdt0vwyz1vqLt;
	Thu, 28 Dec 2023 09:34:26 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id 482541A0198;
	Thu, 28 Dec 2023 09:34:21 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Dec
 2023 09:33:37 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <david.oberhollenzer@sigma-star.at>, <richard@nod.at>,
	<miquel.raynal@bootlin.com>, <s.hauer@pengutronix.de>,
	<Tudor.Ambarus@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: [PATCH mtd-utils 08/11] tests: ubifs_repair: Add corrupted images
Date: Thu, 28 Dec 2023 09:36:36 +0800
Message-ID: <20231228013639.2827205-9-chengzhihao1@huawei.com>
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

This is a preparation for adding repairing testcase. There is no debugfs
tools (for example: debugfs[ext4], xfs_db) for UBIFS, so no way to inject
precise corruption into UBIFS image, we have to prepare inconsistent
UBIFS images in advance like e2fsprogs[1] does. (Goto [2] to see how to
generate inconsistent UBIFS images). Here's a descriptons of the various
test images:

=========================================================================
      image         |     Description     |          expectancy
-------------------------------------------------------------------------
good                | good image contains | repair success, fs content is
                    | kinds of files.     | not changed.
-------------------------------------------------------------------------
sb_fanout           | invalid fanout in   | repair failed.
                    | superblock.         |
-------------------------------------------------------------------------
sb_fmt_version      | invalid fmt_version | repair failed.
                    | in superblock.      |
-------------------------------------------------------------------------
sb_leb_size         | invalid leb_size in | repair failed.
                    | superblock.         |
-------------------------------------------------------------------------
sb_log_lebs         | invalid log lebs in | repair failed.
                    | superblock.         |
-------------------------------------------------------------------------
sb_min_io_size      | invalid min_io_size | repair failed.
                    | in superblock.      |
-------------------------------------------------------------------------
master_highest_inum | invalid highest_inum| repair success, fs content is
                    | in master nodes.    | not changed.
-------------------------------------------------------------------------
master_lpt          | bad lpt pos in      | repair success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_tnc          | bad tnc pos in      | repair success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_total_dead   | bad total_dead in   | repair success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_total_dirty  | bad total_dirty in  | repair success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
master_total_free   | bad total_free in   | repair success, fs content is
                    | master nodes.       | not changed.
-------------------------------------------------------------------------
log                 | corrupted log area. | repair success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
lpt_dirty           | bad dirty in pnode. | repair success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
lpt_flags           | bad flags in pnode  | repair success, fs content is
                    | (eg. index).        | not changed.
-------------------------------------------------------------------------
lpt_free            | bad free in pnode.  | repair success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
lpt_pos             | bad pos in nnode.   | repair success, fs content is
                    |                     | not changed.
-------------------------------------------------------------------------
tnc_lv0_key         | bad key in lv0      | repair success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_lv0_len         | bad len in lv0      | repair success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_lv0_pos         | bad pos in lv0      | repair success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_noleaf_key      | bad key in non-leaf | repair success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_noleaf_len      | bad len in non-leaf | repair success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
tnc_noleaf_pos      | bad pos in non-leaf | repair success, fs content is
                    | znode.              | not changed.
-------------------------------------------------------------------------
inode_data          | bad data node.      | repair success, file content
                    |                     | is changed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
inode_mode          | bad inode mode for  | repair success, soft link
                    | solf link file.     | file is dropped, other files
                    |                     | are not changed.
-------------------------------------------------------------------------
inode_nlink         | wrong nlink for     | repair success, nlink is
                    | file.               | corrected, fs content is not
                    |                     | changed.
-------------------------------------------------------------------------
inode_size          | wrong inode size    | repair success, inode size is
                    | for file.           | corrected, fs content is not
                    |                     | changed.
-------------------------------------------------------------------------
inode_xcnt          | wrong inode         | repair success, xattr_cnt is
                    | xattr_cnt for file. | corrected, fs content is not
                    |                     | changed.
-------------------------------------------------------------------------
soft_link_data_len  | bad inode data_len  | repair success, soft link
                    | for solt link file. | file is dropped, other files
                    |                     | are not changed.
-------------------------------------------------------------------------
dentry_key          | bad dentry key for  | repair success, dentry is
                    | file.               | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
dentry_nlen         | inconsistent nlen   | repair success, dentry is
                    | and name in dentry  | removed, other files are
                    | for file.           | not changed.
-------------------------------------------------------------------------
dentry_type         | inconsistent type   | repair success, dentry is
                    | between dentry and  | removed, other files are
                    | inode for file.     | not changed.
-------------------------------------------------------------------------
xinode_flags        | lost UBIFS_XATTR_FL | repair success, xattr is
                    | in xattr inode      | removed, other files are
                    | flags for file.     | not changed.
-------------------------------------------------------------------------
xinode_key          | bad xattr inode key | repair success, xattr is
                    | for file.           | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
xinode_mode         | bad xattr inode     | repair success, xattr is
                    | mode for file.      | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
xentry_key          | bad xattr entry key | repair success, xattr is
                    | for file.           | removed, other files are
                    |                     | not changed.
-------------------------------------------------------------------------
xentry_nlen         | inconsistent nlen   | repair success, xattr is
                    | and name in xattr   | removed, other files are
                    | entry for file.     | not changed.
-------------------------------------------------------------------------
xentry_type         | inconsistent type   | repair success, xattr is
                    | between xattr entry | removed, other files are
                    | and xattr inode for | not changed.
                    | file.               |
-------------------------------------------------------------------------
dir_lost            | bad dentry for dir. | repair success, dir and files
                    |                     | under dir are removed, other
                    |                     | files are not changed.
-------------------------------------------------------------------------
root_dir            | bad '/'.            | repair success, create new
                    |                     | root dir('/').
=========================================================================

[1] https://git.kernel.org/pub/scm/fs/ext2/e2fsprogs.git/tree/tests/README
[2] https://bugzilla.kernel.org/show_bug.cgi?id=218327

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 Makefile.am                                        |   1 +
 tests/ubifs_repair-tests/Makemodule.am             |  42 +++++++++++++++++++++
 tests/ubifs_repair-tests/images/dentry_key.gz      | Bin 0 -> 5377 bytes
 tests/ubifs_repair-tests/images/dentry_nlen.gz     | Bin 0 -> 5386 bytes
 tests/ubifs_repair-tests/images/dentry_type.gz     | Bin 0 -> 5384 bytes
 tests/ubifs_repair-tests/images/dir_lost.gz        | Bin 0 -> 5381 bytes
 tests/ubifs_repair-tests/images/good.gz            | Bin 0 -> 5251 bytes
 tests/ubifs_repair-tests/images/inode_data.gz      | Bin 0 -> 5297 bytes
 tests/ubifs_repair-tests/images/inode_mode.gz      | Bin 0 -> 5383 bytes
 tests/ubifs_repair-tests/images/inode_nlink.gz     | Bin 0 -> 5383 bytes
 tests/ubifs_repair-tests/images/inode_size.gz      | Bin 0 -> 5384 bytes
 tests/ubifs_repair-tests/images/inode_xcnt.gz      | Bin 0 -> 5388 bytes
 tests/ubifs_repair-tests/images/log.gz             | Bin 0 -> 5232 bytes
 tests/ubifs_repair-tests/images/lpt_dirty.gz       | Bin 0 -> 5360 bytes
 tests/ubifs_repair-tests/images/lpt_flags.gz       | Bin 0 -> 5361 bytes
 tests/ubifs_repair-tests/images/lpt_free.gz        | Bin 0 -> 5350 bytes
 tests/ubifs_repair-tests/images/lpt_pos.gz         | Bin 0 -> 5374 bytes
 .../images/master_highest_inum.gz                  | Bin 0 -> 5034 bytes
 tests/ubifs_repair-tests/images/master_lpt.gz      | Bin 0 -> 5035 bytes
 tests/ubifs_repair-tests/images/master_tnc.gz      | Bin 0 -> 5024 bytes
 .../ubifs_repair-tests/images/master_total_dead.gz | Bin 0 -> 5033 bytes
 .../images/master_total_dirty.gz                   | Bin 0 -> 5032 bytes
 .../ubifs_repair-tests/images/master_total_free.gz | Bin 0 -> 5030 bytes
 tests/ubifs_repair-tests/images/root_dir.gz        | Bin 0 -> 1298 bytes
 tests/ubifs_repair-tests/images/sb_fanout.gz       | Bin 0 -> 5322 bytes
 tests/ubifs_repair-tests/images/sb_fmt_version.gz  | Bin 0 -> 5326 bytes
 tests/ubifs_repair-tests/images/sb_leb_size.gz     | Bin 0 -> 5324 bytes
 tests/ubifs_repair-tests/images/sb_log_lebs.gz     | Bin 0 -> 5323 bytes
 tests/ubifs_repair-tests/images/sb_min_io_size.gz  | Bin 0 -> 5328 bytes
 .../images/soft_link_data_len.gz                   | Bin 0 -> 5389 bytes
 tests/ubifs_repair-tests/images/tnc_lv0_key.gz     | Bin 0 -> 5414 bytes
 tests/ubifs_repair-tests/images/tnc_lv0_len.gz     | Bin 0 -> 5420 bytes
 tests/ubifs_repair-tests/images/tnc_lv0_pos.gz     | Bin 0 -> 5404 bytes
 tests/ubifs_repair-tests/images/tnc_noleaf_key.gz  | Bin 0 -> 5430 bytes
 tests/ubifs_repair-tests/images/tnc_noleaf_len.gz  | Bin 0 -> 5437 bytes
 tests/ubifs_repair-tests/images/tnc_noleaf_pos.gz  | Bin 0 -> 5418 bytes
 tests/ubifs_repair-tests/images/xentry_key.gz      | Bin 0 -> 5378 bytes
 tests/ubifs_repair-tests/images/xentry_nlen.gz     | Bin 0 -> 5386 bytes
 tests/ubifs_repair-tests/images/xentry_type.gz     | Bin 0 -> 5386 bytes
 tests/ubifs_repair-tests/images/xinode_flags.gz    | Bin 0 -> 5384 bytes
 tests/ubifs_repair-tests/images/xinode_key.gz      | Bin 0 -> 5383 bytes
 tests/ubifs_repair-tests/images/xinode_mode.gz     | Bin 0 -> 5386 bytes
 42 files changed, 43 insertions(+)
 create mode 100644 tests/ubifs_repair-tests/images/dentry_key.gz
 create mode 100644 tests/ubifs_repair-tests/images/dentry_nlen.gz
 create mode 100644 tests/ubifs_repair-tests/images/dentry_type.gz
 create mode 100644 tests/ubifs_repair-tests/images/dir_lost.gz
 create mode 100644 tests/ubifs_repair-tests/images/good.gz
 create mode 100644 tests/ubifs_repair-tests/images/inode_data.gz
 create mode 100644 tests/ubifs_repair-tests/images/inode_mode.gz
 create mode 100644 tests/ubifs_repair-tests/images/inode_nlink.gz
 create mode 100644 tests/ubifs_repair-tests/images/inode_size.gz
 create mode 100644 tests/ubifs_repair-tests/images/inode_xcnt.gz
 create mode 100644 tests/ubifs_repair-tests/images/log.gz
 create mode 100644 tests/ubifs_repair-tests/images/lpt_dirty.gz
 create mode 100644 tests/ubifs_repair-tests/images/lpt_flags.gz
 create mode 100644 tests/ubifs_repair-tests/images/lpt_free.gz
 create mode 100644 tests/ubifs_repair-tests/images/lpt_pos.gz
 create mode 100644 tests/ubifs_repair-tests/images/master_highest_inum.gz
 create mode 100644 tests/ubifs_repair-tests/images/master_lpt.gz
 create mode 100644 tests/ubifs_repair-tests/images/master_tnc.gz
 create mode 100644 tests/ubifs_repair-tests/images/master_total_dead.gz
 create mode 100644 tests/ubifs_repair-tests/images/master_total_dirty.gz
 create mode 100644 tests/ubifs_repair-tests/images/master_total_free.gz
 create mode 100644 tests/ubifs_repair-tests/images/root_dir.gz
 create mode 100644 tests/ubifs_repair-tests/images/sb_fanout.gz
 create mode 100644 tests/ubifs_repair-tests/images/sb_fmt_version.gz
 create mode 100644 tests/ubifs_repair-tests/images/sb_leb_size.gz
 create mode 100644 tests/ubifs_repair-tests/images/sb_log_lebs.gz
 create mode 100644 tests/ubifs_repair-tests/images/sb_min_io_size.gz
 create mode 100644 tests/ubifs_repair-tests/images/soft_link_data_len.gz
 create mode 100644 tests/ubifs_repair-tests/images/tnc_lv0_key.gz
 create mode 100644 tests/ubifs_repair-tests/images/tnc_lv0_len.gz
 create mode 100644 tests/ubifs_repair-tests/images/tnc_lv0_pos.gz
 create mode 100644 tests/ubifs_repair-tests/images/tnc_noleaf_key.gz
 create mode 100644 tests/ubifs_repair-tests/images/tnc_noleaf_len.gz
 create mode 100644 tests/ubifs_repair-tests/images/tnc_noleaf_pos.gz
 create mode 100644 tests/ubifs_repair-tests/images/xentry_key.gz
 create mode 100644 tests/ubifs_repair-tests/images/xentry_nlen.gz
 create mode 100644 tests/ubifs_repair-tests/images/xentry_type.gz
 create mode 100644 tests/ubifs_repair-tests/images/xinode_flags.gz
 create mode 100644 tests/ubifs_repair-tests/images/xinode_key.gz
 create mode 100644 tests/ubifs_repair-tests/images/xinode_mode.gz

diff --git a/Makefile.am b/Makefile.am
index 1454233..b190424 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -39,6 +39,7 @@ dist_man8_MANS =
 testdir = @TESTBINDIR@
 test_PROGRAMS =
 test_SCRIPTS =
+test_DATA =
 
 TESTS =
 EXTRA_DIST = COPYING CHANGELOG.md README.txt
diff --git a/tests/ubifs_repair-tests/Makemodule.am b/tests/ubifs_repair-tests/Makemodule.am
index 323102b..6070b0c 100644
--- a/tests/ubifs_repair-tests/Makemodule.am
+++ b/tests/ubifs_repair-tests/Makemodule.am
@@ -6,3 +6,45 @@ test_SCRIPTS += \
 	tests/ubifs_repair-tests/tests/cycle_corrupted_repair_fault_inject.sh \
 	tests/ubifs_repair-tests/tests/cycle_powercut_mount_repair.sh \
 	tests/ubifs_repair-tests/tests/random_corrupted_repair.sh
+
+test_DATA += \
+	tests/ubifs_repair-tests/images/good.gz \
+	tests/ubifs_repair-tests/images/sb_fanout.gz \
+	tests/ubifs_repair-tests/images/sb_fmt_version.gz \
+	tests/ubifs_repair-tests/images/sb_leb_size.gz \
+	tests/ubifs_repair-tests/images/sb_log_lebs.gz \
+	tests/ubifs_repair-tests/images/sb_min_io_size.gz \
+	tests/ubifs_repair-tests/images/master_highest_inum.gz \
+	tests/ubifs_repair-tests/images/master_lpt.gz \
+	tests/ubifs_repair-tests/images/master_tnc.gz \
+	tests/ubifs_repair-tests/images/master_total_dead.gz \
+	tests/ubifs_repair-tests/images/master_total_dirty.gz \
+	tests/ubifs_repair-tests/images/master_total_free.gz \
+	tests/ubifs_repair-tests/images/log.gz \
+	tests/ubifs_repair-tests/images/lpt_dirty.gz \
+	tests/ubifs_repair-tests/images/lpt_flags.gz \
+	tests/ubifs_repair-tests/images/lpt_free.gz \
+	tests/ubifs_repair-tests/images/lpt_pos.gz \
+	tests/ubifs_repair-tests/images/tnc_lv0_key.gz \
+	tests/ubifs_repair-tests/images/tnc_lv0_len.gz \
+	tests/ubifs_repair-tests/images/tnc_lv0_pos.gz \
+	tests/ubifs_repair-tests/images/tnc_noleaf_key.gz \
+	tests/ubifs_repair-tests/images/tnc_noleaf_len.gz \
+	tests/ubifs_repair-tests/images/tnc_noleaf_pos.gz \
+	tests/ubifs_repair-tests/images/inode_data.gz \
+	tests/ubifs_repair-tests/images/inode_mode.gz \
+	tests/ubifs_repair-tests/images/inode_nlink.gz \
+	tests/ubifs_repair-tests/images/inode_size.gz \
+	tests/ubifs_repair-tests/images/inode_xcnt.gz \
+	tests/ubifs_repair-tests/images/soft_link_data_len.gz \
+	tests/ubifs_repair-tests/images/dentry_key.gz \
+	tests/ubifs_repair-tests/images/dentry_nlen.gz \
+	tests/ubifs_repair-tests/images/dentry_type.gz \
+	tests/ubifs_repair-tests/images/xinode_flags.gz \
+	tests/ubifs_repair-tests/images/xinode_key.gz \
+	tests/ubifs_repair-tests/images/xinode_mode.gz \
+	tests/ubifs_repair-tests/images/xentry_key.gz \
+	tests/ubifs_repair-tests/images/xentry_nlen.gz \
+	tests/ubifs_repair-tests/images/xentry_type.gz \
+	tests/ubifs_repair-tests/images/dir_lost.gz \
+	tests/ubifs_repair-tests/images/root_dir.gz
diff --git a/tests/ubifs_repair-tests/images/dentry_key.gz b/tests/ubifs_repair-tests/images/dentry_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..aceaae006b352c35e4892b3a5f8263bbfcb29e49
GIT binary patch
literal 5377
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/dentry_nlen.gz b/tests/ubifs_repair-tests/images/dentry_nlen.gz
new file mode 100644
index 0000000000000000000000000000000000000000..9acd3ecc4e1c1416a91ab0896331f33e6fbab2c6
GIT binary patch
literal 5386
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
F<e%zptI7ZX

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/dentry_type.gz b/tests/ubifs_repair-tests/images/dentry_type.gz
new file mode 100644
index 0000000000000000000000000000000000000000..883d11ac10e27dc24f39038fb1739c6af0b214b1
GIT binary patch
literal 5384
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
N^r3)t=+Kcv{|92Yws`;m

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/dir_lost.gz b/tests/ubifs_repair-tests/images/dir_lost.gz
new file mode 100644
index 0000000000000000000000000000000000000000..70c4e8d22b364be1a9b9bc8c7105dc4196bed4d5
GIT binary patch
literal 5381
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/good.gz b/tests/ubifs_repair-tests/images/good.gz
new file mode 100644
index 0000000000000000000000000000000000000000..0611528fce68959068509fda7ccf420e757652ae
GIT binary patch
literal 5251
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/inode_data.gz b/tests/ubifs_repair-tests/images/inode_data.gz
new file mode 100644
index 0000000000000000000000000000000000000000..5d3e5ad3b617a5d3f9434f09c9c6165014753441
GIT binary patch
literal 5297
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
M*J|3neFyga4<MR?b^rhX

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/inode_mode.gz b/tests/ubifs_repair-tests/images/inode_mode.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e82fed94e6a84f8f8149d872e6fad8704b1cdf5c
GIT binary patch
literal 5383
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
S?~fI>kmYM1KOUZ=JpTurzoe1?

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/inode_nlink.gz b/tests/ubifs_repair-tests/images/inode_nlink.gz
new file mode 100644
index 0000000000000000000000000000000000000000..64d20e8c1af03976b021cffcad1e58542875d5b5
GIT binary patch
literal 5383
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
Gf&T+qKc8g)

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/inode_size.gz b/tests/ubifs_repair-tests/images/inode_size.gz
new file mode 100644
index 0000000000000000000000000000000000000000..ecd7f78e0c9e5ffe18905a903acd50bd5d8d42f0
GIT binary patch
literal 5384
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
K*tKi#u73f_9;hz>

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/inode_xcnt.gz b/tests/ubifs_repair-tests/images/inode_xcnt.gz
new file mode 100644
index 0000000000000000000000000000000000000000..3b31f03866104dab73ba1c97b1e7065734fb35ea
GIT binary patch
literal 5388
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/log.gz b/tests/ubifs_repair-tests/images/log.gz
new file mode 100644
index 0000000000000000000000000000000000000000..6e6c8a8338af294b7c4575eff355e1f871f41406
GIT binary patch
literal 5232
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
ZCEy>_F9!eASK}iG<#Z3H^6(tu`5)K1gBt(<

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/lpt_dirty.gz b/tests/ubifs_repair-tests/images/lpt_dirty.gz
new file mode 100644
index 0000000000000000000000000000000000000000..1d020b718953ef13ca800b503b17d154c2e1a237
GIT binary patch
literal 5360
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
D4=A_J

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/lpt_flags.gz b/tests/ubifs_repair-tests/images/lpt_flags.gz
new file mode 100644
index 0000000000000000000000000000000000000000..546e9326b5039a65429f5fa45e8b1f0e3efdbfdc
GIT binary patch
literal 5361
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
IY}mTtU)`Oms{jB1

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/lpt_free.gz b/tests/ubifs_repair-tests/images/lpt_free.gz
new file mode 100644
index 0000000000000000000000000000000000000000..31c46a0f6277f96a0b04c362c1fb84442333f5e7
GIT binary patch
literal 5350
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
E53u@|q5uE@

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/lpt_pos.gz b/tests/ubifs_repair-tests/images/lpt_pos.gz
new file mode 100644
index 0000000000000000000000000000000000000000..39c2fb10902958e2d6581c2dedd3dd70b89d3fe2
GIT binary patch
literal 5374
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
R*KDllRmIA)yLRo_^*<xUq|E>T

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/master_highest_inum.gz b/tests/ubifs_repair-tests/images/master_highest_inum.gz
new file mode 100644
index 0000000000000000000000000000000000000000..8912bbe3adc56135a16ee4a26718f8c53c7cb870
GIT binary patch
literal 5034
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/master_lpt.gz b/tests/ubifs_repair-tests/images/master_lpt.gz
new file mode 100644
index 0000000000000000000000000000000000000000..156a2741d2b352933e7eb5d6f4b49d03aaf45ba8
GIT binary patch
literal 5035
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/master_tnc.gz b/tests/ubifs_repair-tests/images/master_tnc.gz
new file mode 100644
index 0000000000000000000000000000000000000000..f62ef22feaf880ee83d795d29a9b7d3fca61506a
GIT binary patch
literal 5024
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
bVEs65dSS``A%f6c<em>sFUy654ha1hL1fAU

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/master_total_dead.gz b/tests/ubifs_repair-tests/images/master_total_dead.gz
new file mode 100644
index 0000000000000000000000000000000000000000..90a2ba266562d58b7e29f52d907095d3c2b2cb43
GIT binary patch
literal 5033
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/master_total_dirty.gz b/tests/ubifs_repair-tests/images/master_total_dirty.gz
new file mode 100644
index 0000000000000000000000000000000000000000..2286669f87a908dbd409fdb988ae2ddceb6ad03a
GIT binary patch
literal 5032
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/master_total_free.gz b/tests/ubifs_repair-tests/images/master_total_free.gz
new file mode 100644
index 0000000000000000000000000000000000000000..0394a76baa38bf36eb64df3ff4b725977208d7fe
GIT binary patch
literal 5030
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/root_dir.gz b/tests/ubifs_repair-tests/images/root_dir.gz
new file mode 100644
index 0000000000000000000000000000000000000000..ed846363fb4229ce01951c8bc60c067da0a52310
GIT binary patch
literal 1298
zcmb2|=HPhwv@4Z?xhOxsBt9jxh~e!W`;0lIGRHqY*E>6ZS@Xi?EgdGVtfd=XUTD(D
z6_6>>;LvpvT;d^{<$A=Pm36iPN7<_85G^OMr59Xpuk*U-7*Zfu_#((9R%FSFW@pRy
zhUZPECseOIdpuq^UjN6_ca`tz%HQ7+He%U#^ZNzm@-3^hZ{0P$8*8lo-sWSF>4ATz
z=i16Lpn?Z&Z;k)+qlz&c)t&i2Klc2e{|D!87Wewjj4FK~D&e0zsu05|OhcaDeetKh
z{QtGE*Qd03%(q|OD=feF|DkRBbPv~lUp-%Ke*W1xGppDBN(?Wp^Dg~3?N#T^R~e?8
zf6MpZ+p#+IEKlg-$)Tk`UVeMO_^Wd0%YJkxh8;O|=0AVcGg0Ng?DyZ)e!TI`S6Erv
zZvWq_W$&LHIW+m$tWf@6`D>nCKcoJ+f9ve4S=S<h<Nr4|F5LIsV*k>epP!y&x08t~
z|8vt{{_npd8`sy>{Ox{!PItG}ip!d@AkS4U{r`^<$(O4SPWt)3YDwL$sAqrvgF<rY
zZ)9np$^_jAqyP7J&HMSk**aan<a>Uu?w$iT8g#qm?r;1)@B6m=SrU@_-!`8tJ-c(|
zyQupuYx2*XH9fxd(tL3wYd}nuHD~_RXaC4}e*N4b<=yY!-K{S8_OJi<HlDBV|Npup
z|8-vP-jDy@O@BCjzV)9cjgI*-2j=s~+r;il+^Ki>*G=Q4($l=N+ph7fm5egpl9qAy
z!mNd+&eRoHv+Y_a(64*0gg*a&{p<Vr6>kompZfE^==NK6+q}(nrqk5&jI%p_KL0QN
zcK@`mf7$!zSAO39cD9<ES^n*!lpW=pVnY}E9tm>3YkKX@{8#HfKC4(2SwFvi>E4X<
zcP3q*QC<CSTiyQZ*|%RlD|5g98JJ4you%1pg8x*1{c6AI=ar`u?{%(@`Txsm$G>d<
zSKp;jV`hz;w$1<h`;J}Cehf@?^J>3`*#6&}opnCA`Pu&LXZx?u`}Iry*VDP)i}wmY
z`~N@O>;FI0tkW?2B-i=>{Jb|dE&TuB%S~tYS3lnu=ie>gWB%VZQum)a<5GL{jP*nR
z4lo<NtV4AOLj?Dk|EOj&I8;9SkCq}A*nIwvrZHgN&w4Z=jq`u((S)X?6P3ef{%1$k
U*zgI9v+5cB8vpw<Ft9NI0As%&^8f$<

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/sb_fanout.gz b/tests/ubifs_repair-tests/images/sb_fanout.gz
new file mode 100644
index 0000000000000000000000000000000000000000..0b267f64b3555c689e2ba06baf23970d089f96ff
GIT binary patch
literal 5322
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/sb_fmt_version.gz b/tests/ubifs_repair-tests/images/sb_fmt_version.gz
new file mode 100644
index 0000000000000000000000000000000000000000..31070a12e2f63f9c0f90ec8bd0790783e18f0ba3
GIT binary patch
literal 5326
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/sb_leb_size.gz b/tests/ubifs_repair-tests/images/sb_leb_size.gz
new file mode 100644
index 0000000000000000000000000000000000000000..9688ccde7201ed5eebddce87d1d21490c9a9ce1e
GIT binary patch
literal 5324
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/sb_log_lebs.gz b/tests/ubifs_repair-tests/images/sb_log_lebs.gz
new file mode 100644
index 0000000000000000000000000000000000000000..4f74796ef32f96d688bb3b8dbb988682a1122fe7
GIT binary patch
literal 5323
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/sb_min_io_size.gz b/tests/ubifs_repair-tests/images/sb_min_io_size.gz
new file mode 100644
index 0000000000000000000000000000000000000000..8871841ebec45687923045e93fbec1e1fe79fef7
GIT binary patch
literal 5328
zcmcgwXI#_C)^?W_6j1~PM4Dw43uUR1u8V>o2uKM{Sm`YUh@pq5pr|OI2tf!Sy@N;z
zp(7%lNPq+gB+?8JdI%v2$^YGZKi#{#_v<^K&hI(T{GK!A%$ymyghPjhs$Y5@;Dfoj
zLVN>VeW9)}-$>5`t22k~#cbtzwy+W>k6Yd}obFT%;&UE3{!{QBE0u$N2X9=r5q<Xy
z=wuLRKv5KPrrvqr=+SNsn`zWdm0N|*sv2*`f~cM?YC(lTIpMV%)CeUQ4(sg|0~;2)
ziKC;|mDbA3<8)W1QP%5M@xywgo8gIEDP?);fq!m~h=eRQ@}GSNUOGQ!BgY5E0LqK!
zj7ux~|AW?Yv;+|NXWxe<D?s?4UDrpVX4t?qSJAet<^0K%hPxp>Q`Lr$y3or-441|L
zm78K%rI=SiBUTeuw!N1w?7S5HD)>ebXwaxBGJQTKvZL_J*-O_EP8Rz&duw<Xwf&b<
zFgJ!9^5L?Ym2Y*l$L*IWzxLal<}PSMnPBe*+ZXd?pojgMB)9owoxr4;pa_`Fg|*;+
z4(-6nr#~}*6;vreY2OM7v7-Ku(S3(le&D$>R2e|nIXAr!CdOt_uH(B_^O7%!P<5x(
z$2;)e{-a_@V&a%Ywb;$fvJR>?#hd{&S8CQ1IFu|Pa!}&z502j12*}~m8AshJQ&@$g
zj+=J>Jet1yo2VDBtcs`{zVz+ES-B_yp+noKB-jdh5%Fw_n2RS{7`9*M+^VwXG^O1X
zi^<Y{x--DqwOixWyb0BZ&(eYxFKoA#!cV#2%e_rX6{}(s)sacUnT*sP?84fEU*9#t
zIqZ*?KrW-OJ2{C?uIpJYEU-!_Oz5XrblJD*M{wTKl2e+GiGQZxSZc)F8(l558GBW~
zhW+DT6I{po$;xxPMLXoB2rU?WCiwoRy1KFTGYbY1Gx{Xj<)i_e|CI@4-nXmYyh~h@
z!#ax%VJ)$(xK*|BHZo`@+J}OyhP4|1j$C&#(xIqj3rCHYFGgii-5K)oF)_w|{?$FZ
zb&rG>f-AT0`dv{tHMYV1_We=P5vQb?$FlFe@SC>y?!`6b%U2<b8&b+#babJwl$i96
zG?K}!zc115xLAOj&vAC2rKw>L5qehC^bqu)S%R(Y3|B=8ZJN@Plx{>wo;vnBkE_=C
z;aQ6Aux(5}USuVP67!t$C^v$`F-qDiEZSw1)_uKG=8xnF5}Dfc_6GyKruB6=;1$Px
z<Ic3)6rHWj3Iv-b*1w(F-cO(x>j9PYCo6~iTiV!`Q9O$uX0qOj2x;Z}X5{d`=Bb<`
z!0Ns?PrD!tvPLgI(r%#Ya*mRj0n{rtkj7J|=3tj`fX*ZjvJe~reaLv)bHqSyT$w45
zfyqIp?*@Mggv;1i_$iCDm(=a1jJ**)@7guMn{F7ZgC98-d5m?+ZMd7}G&PQz+L}Xo
zSH#<j=n9+T6apSxt?vf(Q;6=4t#|YmgCX?0erJSMPZ7U>E;UllR2~#bIw2-*H+|P{
zfc6HH^TlYYZ98(WWh%17mZjC@7FM91%%0DQw%?14JJ}ieP-Dk_^tK=7_%_jf2vkdt
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/soft_link_data_len.gz b/tests/ubifs_repair-tests/images/soft_link_data_len.gz
new file mode 100644
index 0000000000000000000000000000000000000000..4fa20cf01fcaa5f0145bf4b2639d89ca0b9184ce
GIT binary patch
literal 5389
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
N5c~befdj$^{sX?+t&RWy

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/tnc_lv0_key.gz b/tests/ubifs_repair-tests/images/tnc_lv0_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..9a45f26074ea396e032169b9d64bce3e0199f650
GIT binary patch
literal 5414
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/tnc_lv0_len.gz b/tests/ubifs_repair-tests/images/tnc_lv0_len.gz
new file mode 100644
index 0000000000000000000000000000000000000000..1cf0d794741448ae77eab6e047db3d3e315408d5
GIT binary patch
literal 5420
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
Py4Dea#D|9t9X<4as?)~M

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/tnc_lv0_pos.gz b/tests/ubifs_repair-tests/images/tnc_lv0_pos.gz
new file mode 100644
index 0000000000000000000000000000000000000000..9ba36f97775edd4660122fd6d2b25a3849738df5
GIT binary patch
literal 5404
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/tnc_noleaf_key.gz b/tests/ubifs_repair-tests/images/tnc_noleaf_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..b9dcd3799a6b0f982c30a9c9d8da8011929c2154
GIT binary patch
literal 5430
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%0AE{Yf-xP4nh0-ThP?jRwI5%XIzMsFm`j*YG
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
E0S~zARsaA1

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/tnc_noleaf_len.gz b/tests/ubifs_repair-tests/images/tnc_noleaf_len.gz
new file mode 100644
index 0000000000000000000000000000000000000000..e2c5a9a213891734c89d4042cdfe1a824b8b6071
GIT binary patch
literal 5437
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
T%n#5L_Q_lU`M5)eem(SGOET8b

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/tnc_noleaf_pos.gz b/tests/ubifs_repair-tests/images/tnc_noleaf_pos.gz
new file mode 100644
index 0000000000000000000000000000000000000000..60cbe7a71b18b647e1efeee448172853887de9ff
GIT binary patch
literal 5418
zcmc&&XH?VKx3xTVlo3WnK|o>|x`1@SBq#_Lnt&7$5&>yaqVyJ`ASxhDdS{RTLIA0O
z2t=g^0VyW55Fr#p2t5fTB){i+-~Nv8>wEXpS!<uQ_P+P7bMCnt6!*s;UG1?hd-nVL
zIKzDqUM`NV@W%+hJ<H@ncZC<ly4J@J91s>(IUo4`0OkSd>^`Sz(Ub89u3f!zUiR4X
zKGqxCn2zJGvR_Hn{By15;DKc^6;T8IDvd|itHg}%Dp3bM-i$<kj_0EmF?AFy<qK48
z_2To~O+BH-Kr3}UL2p*O3isHf#Zc1S;Dr76m82f--SgY^lthf;qkaqR*>l7`pO5PA
z+X5)3MaJt2H~0TOZ%wlh0R0|%8hHcI{XMkjz-j;&sAFS?-F*}8+?>!MoDgplEUy?t
zC(SlL?)A--_IKV2o{5Zl|KUv%%>IYCwDDhh_jeiYw>9GbDwh$pJrapeWHmn9j!kme
zGznfH$e8i+yt<blUiK<s0kJWc%FHvf>N&k3(~`yg?r)Egtlq5#lfuIsxXS@C(x1`Z
zj`L}B3!4{k{O&{YYs}XxR(`|~kWfXH{h{9r{+P4n$^i<nsy7_xzh7sYxsKh-JY_m1
zK6*pJEPFvoHC56{t1YWA?D@)QYe|}<7|l@@ErR;=G=CNnX!9mt!glLfGt98auR9@T
z9hxJubpl6;m>HEP5afUS*Z(k<RTl!lzsZ4vh$evYL;HiM>>+W@68pcnfDmrnwHLx2
ziamQf8(d9CYPEA$8*kfnZc_62p<hJKEpQ>4j{3(urf!3)41+LBA1>$+=()bEOQ#lK
zM53hVrSR=nAI+waySuIP)Lb0O17$uR;-1Q-i7uSR_k_p~dK%dB7vE(Jw&W@|TO^vj
zPTQ&9A<Yns=E5ukMDJmO3Y>;*F;V&cJV}rW=xnv$z<9f@tS_C#Ja%omoqn@3DRJ`?
zrrV<vZPkZPA&||wuS0c1xNib_2vt$&H8yECE1=9qcQG6*ERds&`r~aUs(xu&d6reO
zHMJe0UAIYoa<8WLx%$f4xd<g3Dt%eHy070;TKyj1905<9f$>*DbkE?ZXO@Co@mU+;
zl&_2WAwcWEj^t5Jz|~tWZEoSvY<HL<g&qzi_Jemk<vcK$?y9>5Lh}KNe$%7IwyF;w
za0~Yom~B*aLn-;E7lt<)hI{9il|#%X2yiVJ$8RIe$168z$ZwZSA~ia+mS?2H5+i&Q
zc1Uh^dq=xDYWwx$z&jhQ_@nTjEK?MjgzRYRv@Vw33Qujkto&`ufI&pj(1}M#ice++
zWi6KnX}`fM&ED8mk7d4*Cy?MXyRbzLVj7AI518lbQu#L{Vz~Mt4saO?W8-i#aoDzv
zKg+a)0oK~rn9rH5c+Slb9*U5yIb;~BZKso!%Y4I5s}=y3nS)JW4E*Rk*K-rEI}ATh
z$-(i(vsY^?q~bdV(cwHJGSf$~x-X;%Aq$4#9(?(@jBsCpO@AU#A5Jf67B{NH&hg)x
zFU!1>0~tbJX7Jj)(c<()hb@T>m5$s#t%mm%7vg{3PQJMiecv`%9a>l4T&aEv;2KwT
zV<tqnJ@kpWmUqdQnw;-mFaw@G(-%H)Eb+uC3Hvcqu|8(cxS55`M4K-J46Bs1Gw~Vt
z-b22{EZ+Gcqr3o5{J5{|2DS)7(n{*;kDdy}0Im@O*qTP|upa`nm{r7`2vouk;!x#3
zKM#$-)M0MA0*6ricdeI4tCLkJYE=MdUlaerE-_4NAVnEZXA{`#3NU;m9}xXl`L^^=
zKL$|Ktf`j#&{oHw9JCW$KiQXJOW+-G!Y3vRU+25*8~QwgG-CCw7~D<m;t%T}JtiC1
zM(FXyy!(fnAzU-!$zf&>fmbtYp9@>booc_>MrqLdu&i*aTOcjr-pvVE^0b-H(_}8!
z`>5Z-#m)etox{OqxI?bM=n`jee%kMeQf*Qd$$F*kB!w~x*~~_(2PP9e>MX@>lltIK
z+FlIrypUIo+3BQiON_$?p#__38oTs>9M?j+erniN_@W(@X4WQ7K{xyFwgiNwkj&eB
z{DR^ct4V|0`PKom0c@sHRGibm*PB5{=b*+<l)A2yfWO($)3;W!51JxsP7SxI4D%0e
z)WrQz?c+V4&5f>6s+$^N&Dn{~!<@C-YtG}^8i=vYd%JMWnz7pSSsZdczp!YS>6vuJ
zO>RMg)HwaH8*eW{=FL?Mk;MsITC5><;Fb!>s3OPnU8WInY2g02+RhwX)JqXn>;Mh8
z^LC{InzumWBL>WNBUw%3@IhsV)o+8<h4_fyJ|o{58$Y|NMzr)pmxuFh!+LzR#z>^?
z$eCD&e9no;8&0dQxS73-rg1>{h~QcfJ9t`L<SDmum?Z4~LL|*2|59<GT8nILc@$>p
zY=urwx#0hGNTsAR;lqIP8F>mHg`DS?RJm0h-U9GXfX1*7|KHjGJOI4o6?ERzemr@Z
zm!22xF{2uw5H0*hrXljd+2|f4Wv-(v1lu1WoZQtoOzquuXIOHtFKQe5Klf2+gCF&v
z%X*8;6Hnh3T7Ui}-_IgAz=@|%=m5)KG@G+T)d-FPj0;3vX0e}|LWo{D%E&_&b?um^
zGJoT*8tL@$6eT?$9<r|6q&S)uf#Xm{N8(pcB00QN=Bku8GJ1-8Ra%mCwUGbl1YK7F
zI`<+4eC`|Gdu8n~<Q#hwl*#LW_f(=nS;58iYpy7Aio&o+EHk7nPL2+e_g?&?nf>fF
z2T<$axW%{76j0Nf75FAJ9|5Z2i-?$Th79t*Zvv*r=pfCCFYg35uIF>;a*Z2opo(Kg
zLSZ9(cqV9$jFGMfxPq@TtZCZQD)ev^DENms*zm75vIh~TH3d{7yL`=$&3~UO=~Qt7
z5~I8qpAFK1Q$qlcb&RgN9s0238Tc9iTrt1^{rjcpchhBl0I1SeOn6-pXTMuWB%cx#
zYYQ~wfUiKSfgC=7O|b>S_SP)g^_~dlQ{<d@C@-~5#~VKrfuP&hfL(!q=~x4l%mDlt
zm@3=y005pTW*k4F^S=#Qh$t`*$j+bvcr~S3Hx}PIduqS%&mAPMTjF&KLpPN>@xZ->
z(rtMcwDx^{hd*S<Usc^|w%GQ}h&<$DSPRy?Q-h+!UV+pzXO3G@xHGP6U(W~#UFly5
zd$h5HwqYS_mwqgI=xXKoF|Ky@SH!<)tRhz%6Am@3A}I<cc&3?~;0xOTpSoc=j~!W_
zAocihg(=!rVR>KesY$WZd=GW^+Cj#%btyOdfb!%u$EH59YG*Cti|WhG4HF$*CHDn2
zXeYqM^kR=i8#f#;KcHjxTEURWzSnK)SwkJXxH?T2q5<Xhw%XS1aRq0wG$XZ(X~F>C
zrpnwv1hFkoc>8ws5~-XSB=)k>*2*yykrPuTC#33y3V%3GaW1EVc{iw64w;IgT7S%p
z%~+my9T3NH?lkmAD;Nku8ta}g5Q+6-G}qkqH6)-`cLnW5aj|GF4Ks;bVdx6bz1<!=
zzL|gfO~kT-k>wsfDJ##3==U_0Lw!N4F}9z-KIIr?0b$&3_;3d|@;VjiY;(`uGdJ&R
z$!ue?fF;+~m^?Y=KQ;P+Y9{KRxz5|>#UHQ84dfIB8ru>pLlzM{Se;&?{;AT+P(kq)
zq(9^P*b}Vx?2_&1loJhFl1}aEH-E<(h~gQY0pU3xnuML>mRfTLD?(lSTadaK@*>K4
zJ4}i=o_l$&Hi(J|saw>2EWY$;ezf^v#|DRGB_Sl_>9fF?(b1}0{ygj>!1PQT(*kSG
z<_;;pa2}a>;nGwED0WSti}>TW7INw&_UpATh^EFXoUW;H<lU1Kh{L&x@_g5EylZfw
zIEY+h*N7?W^_4uY9fyv_e-c?oAA@p<J(T`HVqQ+^qk?JV?&m4o6Hb&`A2-J)tIfNj
zw7vJKDN^SP_*l+Y+SX`lB~6p4HNllOz096miaAU!?W(_BFjZ#Z)PsPN#kX%AtN0F$
zSnqen_HWhNIc<=cr~DFGUd|5d1O8D}ai*cEx-($MoK0cUEQ@=vAWrhqU?*Z2(Ftr8
zZo;T#)NB2OgZGwKxy|dHhx1|${;Sgfy1a|FZ0Tzct@4wU0IO6lBqw;5FtY10rq<Z|
zXOuuDI?m^t8bJ2jJ-b#53ZAJ=J3B@FKAvjw&%M40#$SeeF}AKjtbu9910&^0%?7pQ
z$vlS$jepEjB)bWD-1o0`-nQjQ+aj)jTDDuwLAjgi5=3<l)wDmdgmp%3dm<at@%L&?
zfP91Gw{{;=_oDZaEKL=ySKep7J{o)(t$>17GQaU+`U00hmaV&G{UX>V3<>T=Dnex7
zc#<c9#sv@LWJ!kL)TD3A>gT_xqVer~*aEaQ1?iKQ!>B8CF=Rq|-`WQ*+lK{xY)B)b
zOs6d__%xau$J2T%rs4|N*cftX(A@`DQ^YwJhAkz+Chi)^@g^(NZSWtUSl^gNgPc`c
z;H4oj9ptbt9pf;Uw4hyLQ;b0CmShIhXd>7-jvf9{-5~I*TP8I5-SCcXRrk9OTp^X?
z{c_HjK}~LiSMn*BVZ8(f8O&WUU_cU&d=`@S!Ol)9t5&+?xz=7O<L+3WyAmp8%ji9#
zy`Vl2;+%C~WT1Q7i|6litDR`tC$41dpe@@1n7*V{HqaD;TwPtQFW>8Hp8kfLXDx$O
zJw2iW8~%*-*122(PzAJP`~z+p2Ul~@TksP^HdtrNdSo2L^Ot#tLR*>?wXr5fmamib
zx@dezyO83=)zW6f8?khChGBPGXf)(Cqv6^)%cZVAo3AXEo<Wvq*){q5Uu9FRZ%Kv5
z>x^j3T4qR{7%>Yo%x`EQ*WXd2Fa|mc$lXM>0^XV>P<PTZH1RTs=xESer?GmnK!TT5
zao^)5HL56GdsO@M&>(d`eoe4W9d*zEK4z=%D2i6(*V?E4O4N(?mpII=WfPN>V?tDy
zpS^Rzs@j75Wk0~&xIERN)^I<QPL`f77@&>1-Rv|`N@jH$o=(8woVs$Ac;G`Ai1nAT
z+1eela?#85M9Tbo<d?Cz`bv^?NohE_p56232X{wqZD&4+QvConYv_eF#nuH%!a05A
zm5TdIy>^~B(Ge`lO6ytA&Ij<9@zjGqJh94$LxDtC3VTa;`oXuNHm!Z(wbIK~(@2Za
zA1CoE?}l2+h>v}HhHfR8_j68T*L8H9utO!473v>ccblY{UGKLY68okh%=hsbR?W2z
zbi>OxQeQ1oMaCYqzj^Y~`$b4_!abRAd)0`089S&F$;?0%+DBfiWt%LnGH)}L(8eZA
zYMFZeXbR@ec}vgKIDBz<E*W7J(VTwgd_cbWu+5=rmy&==*1YR|?Bg8sI%efQ{2vnR
zHDklEgmq6tx<;^n*puj|e)&o>(tDF*d}0)hXCZI1yAHUFf@%tHyW5SV9!YD*OJs!a
z+_9LVUdAVj+ljwEDy!A~WVY7G^yGv|^-LNq46!vZ?_*P%HEyuNV9npGuH6(F1QiI2
z?-sHnhXY$Nhw@u37BXID-BL)w{#g(a<ipeaWX1M6V!AUlmvQ1?4m%+9QU@!Mwm6m2
zXH^yAKKIG5OT?|Qn%Cc0+qjaGUe8-aC*`4!P(TpXOD*n?CpFSo*X<Kj?bvN~L8U3!
z6x{WJ!>xBWr%sKeTf3rg-*y_aI*UFID2hqI#*2&+Jxc2ZNG4);0GJk}^c7HlMogqO
zVz&F}jm!g8O)Pxiiei2D<=6YS7v6iljZc?wZ7i0>=sGFB>9Mxx6Vw!&A0?dgy>L-m
z{gDMmqBhMh-oe<{PU)evJtkGZuk$@7`niOvBA=?vp}02(dqN9BL%FSp!AZ;2e!op*
zh2=Dw(b5*Nn_ZHd(D7w?bfUuV6cpoL(d#fVF}@KV7Ez|L^Z3RxsW}V^f`40I7;UPN
zI&jn|K{D48D1TR_AdKgYM5o7N``B*Q$TA}&WOn77L5PNPU`C0qti1eqJ<bCd5{VWN
z!=jgSShCcu*k`?YCu>&g48Mdm(z;SS<;116y3auGLf4$=RfiSCae7)}HoEW+=Y4jv
zmg4Cz3Mw(8{t+zReSKxA^o2hMB$-VY>CWHK$_9rhC8Lcd1bAR=?IY`gs>sg!ZY3tR
zs%7CrHK%W-z<f?m+3N6UJ)hHuHbuM?r&C%(Zu636>-9Uw$y~jem>sRU^PZnZdxqbL
zHz;q#+3Tm2{;mG<K&#t-xNBF<uFnJ9j;*r*YSlN)`RlK~*;T|@K<JmL?o%8A=w|&5
z05!We&6{*Du-F0|9$Jbv*q-+M<srTHH`MIexa$76DI*~py(W&~0C{i{q+F1BLOV!E
z>#Y6y3@&BM?>i_$<2r3+6->&_5dT&nT2;GO7Zv>8c@>LLL2#>gpTr;EV*iKKJ$t?b
zYt=hI;o>j8)6?mz{9ir2NSS}jPWjcadiuQ=_~nClb!`s#h4pMOW$##$@Wh@y2lxCp
D5d-{u

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/xentry_key.gz b/tests/ubifs_repair-tests/images/xentry_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..d2ff24989fda6ee8b181dfa403403fac332cd19a
GIT binary patch
literal 5378
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
F{1@wnu+abj

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/xentry_nlen.gz b/tests/ubifs_repair-tests/images/xentry_nlen.gz
new file mode 100644
index 0000000000000000000000000000000000000000..96215b7663446b9b1934f56a08fa5a765dfde49d
GIT binary patch
literal 5386
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
az~47MY5YG3zz2cAZx=l!Lig-Bu;<@2Ldw7Z

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/xentry_type.gz b/tests/ubifs_repair-tests/images/xentry_type.gz
new file mode 100644
index 0000000000000000000000000000000000000000..71ef8d9d66b102504bd02c76a271d1f8034ea24a
GIT binary patch
literal 5386
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

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/xinode_flags.gz b/tests/ubifs_repair-tests/images/xinode_flags.gz
new file mode 100644
index 0000000000000000000000000000000000000000..83e2a10e270f67698d7cb5c3d5c8971a0789d30c
GIT binary patch
literal 5384
zcmc&&XHb({x5i^Z&r!gmfQk?+AXPdFBnk%+q$?$066p{iG(+eS5m2fPfdD~8K#Fvb
z9+jq{w}hG~ks2UULP$dLUcc|oo%!Y*@85g(uQhwE+3T5S?OA(23zWEj|0p%VO<;G3
z7s}7o4dL$N<PjvWJbmD{85`(Y3zt`vt1^9dKFybC3w>5&tolG94MBP=VyIS?zZdEu
zav?nCw5m&qv|ElW7w08{t30SWB>W7`q2>jlnOupTE;dU7-rq&jW<{*B!dJQ348`;=
z+Reyp9rCkoxb;n+lmx}8iM-EOw)PoWqg;>f7Wn15M|da91Agfe5P06C$^+Ihivaf6
ziFqi6z3bO;+ad#i@ULB0*m(fx*RFf(EDRSA-RS+kp6>DX)T(4!tS@z+W3g$`%XRzU
zw!5Xe5#c+x#x=sn!AGEQHz;90G(%zP8&)p?c`7}&q`St{tx5n=E9me^t;#u(`6N~X
zu6xkG3ip~{Y9`sS;1fCigLK%YV^Fzl<D-A=ee*!4+bv=#hH*^_D@SRnOgF8eGsu#Z
z|Am&9y3M(KKr1=I_$KqK4?}s*UgEf?yVU+ItD9nnOa#3Wvj%DrHnvr<j0>UWW>ep1
z3KR>(qdwegBziBa9R{6*lKL!LP7ODBlY8zGzIX84T0qTc<N;Cfbj)x6rsItr1pxlR
z=Lg8uOg{EiKE-P51rPXF-JWBjeodbMc#j(gm}LwBz(w`Gn<`XOc-U_%TBf11Y}*z^
zTZf-`ZA)t@w+u?57c?bR9;VnQil^@V6w;)T>b&%@YuAkSp#Vk!dnrURAj+tc<c}~V
zi__#jyTaNhC?^SUeMOs=8WNXo04I{W%PYuzf9WFXL;8N7;TLR&na^xA66pg`P&Luc
z%#t)$5hNCW@#MLY`$ubQ6I!ZGNZK8bwB)xWZ<Uen+;M6x3Rymra`Wb!5iy3{Jt7mC
zNR}vjYW!I_yNl6YHWyspAcS23n*FM4Tvc@{H4O?|Y1D@FPjtTvCJYK(7dws)&t+MK
zQpHwtR6p=F%I&tmgnEj}`Qx{5Atx@MXMHf7l{&Z3?Yh!2L1HFm-)$#5>YC?0jnUS+
znq8i+i|KgU^C{aRA+F(fjk7IJd-Q$b!*sCnYQFiRo~^rfenyjdCB~-c(2#r)+PWyy
zPAQXK5GWkWC0EtB%Y8qH_6E1DK~`^k;eJ8D*D02fkm={?NkP^{p(SY}m*0*E6{X#N
zzkVV%EEJ3V^=0B4Q!D^Nv%Y=6)qq7cp*f;a@L^v}iK&%c4))CAtBZxjRnzusMzL$r
zyLJl_7Gt|V(o#Yn&E|ab6+PjeB*!@DmsmP<szm*>+@UIynEz{YyU>jnzX>E3hWP@7
zxTT2Qsflb=4nS?fPJ}l#t2HbBKVbSFGH3(>0Hm?8hDOW}-rQv_>DoS=hJu;CoNOXe
zHS@)>*9z#40!470wU20ri+n)1RqmTDV)nM`{KM1><A0QsuTSYDaBbyiH63R4FN^)^
zWp}6t=pgH}-x><4e&Cqmq-ZAaV?RANsBfHP3Kby}VnW{T#GNT^`O#+ZKtsjmD9kmV
z&M4QeJ1jVtEDHs~m(F*k-bF;}jWStcEPmAxEBdKFT=6(vS;L7ppC3Pkwiat=V&wHA
zuEK0NOwgMUkyG+8K(}LUPr%ofUFU^S2~^p-7i>pUG_S3L_ZxJPd*u-m08W=;*B*rP
ziRCQvJ3@sA52E{tgFtBVk`k*vkO3pZVl4R=O#*bEH3gJ!iMQ<)wGr-HvB#g<#Ev_n
zCDsf0e!F;7kdzb8i1J8&#9C|t0N(DWV;R?L-O*`#IRHfN6Gx`Zd%GP9eF?Dg&XfXk
zlC3c62w(;P@y7OmQM7Toj@%y+JnStZmkRl3?hn}NpD&00#`C;oMJ|x~X6mynW9Oe?
z|K5q%Puv8$srdll<e6RQ+?v_Exu+4Ua{DEV*e~ok7M1pci}2og4lggTuO3o5@a<Nh
zCnvCCn|pf{n~7Dw9GPLB)6O6X(RDhRA!(dZY_nEW&*~V>e1pr=br~jR2@=La0*zNg
zC-<_Amd^PN9j8syV3U`F%|N`bIVImX!yS32-KQ`6`V$>=tnzMnUMpBLV979HB<(k~
zq^M%Gh&XD@>BZ5xsbJ*uLHVKc0SiS<S!c;PljC<BBx0VsXo6`*%nUGnsX)J+nrLwh
zyq0-a(b6N0e=;ljhB9<y>`yF&=C$36(~@~#mR7<uw&i$GLrO`o)|IT$m?lmt^DWgm
z72e*M+*!?aFx~hZWqk)d*RXi+qnc!%2Hs*t?5HL)Wp(XMfR##6UYE~h(kbZhIaE)P
zo-Zy6^P09tx#hk`?%vzk419}sc@(TaIypHE%SZo(@P6k#Y?kZSh#$TKsJ94SE}?<6
z`Y=Ski&ZzH!2PK9UkCfwYWZ(AYAvScT|wDZgV)~;=2w`bhosx*wvYAd4s@Qn>pnPA
z?EstGxybaV_k@XOztA*$DBB8(Wbzrw$=s7_jd$iQ1%EFyHtUj!1y@}6bsy30xcl|H
zbjp#ZcJpJGQV(u_-yAWc7P`}qYb;NK8~GjW3o#HB_?SQDHdD?~p-(F4Qbi<ubH~u4
zxici=61qgJx-J%`*F|%gw3E~vb8$lTj#;!gYv68O(pI`KSJfxFa-jirc(0VB-}#KD
zk->WP>5C0xDi?K~qiuUfkSddowHfJ>C3LHoL9-mmraXR3@|K6=V(;bo%&>2d7g;J^
zE_l#Mb$?eBT|l`cRG7h=+WgcyOcrw}Kqe`aO5U;e3!X4XaD$>(!LT{J8PT6`Q7zm9
zAIqNZ=c%<RQ76<D^H@C(QbN@nvRvb)ICF!KmE~~Btm988;0wO1meryhDmB19WT^UC
zXij`}ZJ2_NR{a)qzCwLoHkBAGXar9I9bHj%=DZ^kz>C3G{FsY(CUGCH#d8%0o22I8
z7o@c{R-x~0%ommVap4Lfftx;eX-8m3JXUgA3!nl0Tv(J&CfW)y$7EmcJ(8$-0_AyY
zmh#l?3q0$OB!l4M<VOt-UK`8bA~kuG4bS*jwmCSlF?4IqR`50NEN~$bwrVr@BNW2A
zxKUF=OSj7%TdgYJ8mn8&oA!<I*visXg;Z**d5=AJmo7WPwP#31j=sJho&3u7srQ{O
zUW+<iDRVZA>pzE^j+fCY)l*@IC3M>+E0TnGjgDJbIJ>D+T)lLHqP;FVdzUaK(z2(4
z=j3NVXpP@lMc^6l>kY29@#3W$mnqc^o|gQ58-;4tC-VEq#-8fjfzIf(@_qK_Rupi@
zj(P^!(Yl*`j4TrOjptGtso%C(7%|ejnS#kE776nGL~1KTs@{1+m3y1|g%ZG*#{Olq
zf<le4Uj+B~yn{^Y8Grt=dRhnjsb4+B+0rSfwwU!=Itx+7b22fEKhbcyQ0QDg0RvkZ
zyyG&S%7L?nAqe+@c3nFx!k<whX%HOlk+GsIbZPeJQgcfu&)e?EPH<Fh1+K1Sc*3^w
zl0=-5(3lHk(nis*4gcwrJ}t;BJBwOZT8r&}6e^#rqcvDuLtALxg@reXliI*)d0}l5
zp#)bSrtYP=s7W@!S#%-^Jj?a9#p>K8tU$Ye4-4Ief70dbo%$F;>VNbZhkox3LHB+P
z3r2oCZS~?nUV_+8&7?;#eJt(SZ{fL`-NiF{YtE?|<+p83yPLjBV7?HMMx_x?$Zhm_
zL31yZHZX3tD}6~_YHN1%p%T3qhTM6(p0r)A*9@+O=tVG3aNXyfIl?HdGgaNX?BTE5
z-ji9S6!(hdK<Wuamut8Q8AHviC0*t3cr#~u!d7zNh?&A4sXO5dUul}Hm-No+Ciuif
z)_$1wxRoQR6cC&yjkIWPLG|5V<wXkmf^CfZ7qr@5=dZaS3mLUkjZosNsT}t3dKJNU
z5~ClDZuTMLW?S<>5)!rzStG-|t84gS`EsAB@zb($vpwo$W;|#UcDot%hQQkzxOxKF
zWV;8u70*iI?KXcuRbNV-zCxI(h&&W-fzb1sR_037l5K|ZhXVr}X~;=_SWX;%Cos1!
zB}Za5d_LQ_r$I+El98*C7!^hGdJBDr(^GKCb}4RWC+$Zz_!=$*Bv!^m%J@A=E_=~h
zz<phK$;chne|dfT%82!JO<$iCng<%K^L{o-3}BZX_u@P;o<0O~jl4F}^fcG%yo`ek
zJu8nL+n{%%)TC}bp(aBc(Wc<(Ww}tDxc6{Vp|rWRAA9FxAnikUtI`urbU-FNQ;4(J
zS~6L%PrPP3FrekfRNZ(d`m9~76lcZWb}6^$th7(iDDF>t?`T?$hE{fxPCrV$W&jv`
zqvzd%>Mur0VqVS{A29G%a%lBL+74~YM2cgPE56|GL%k>L@S^U%+Rs%{!GoW~ayrRW
zf=k5Kah|+K?Ni}K$Z<Dj*K+r6;nCvB?Xd@W>CCczUh^WS24}k)Q|ixUB|p~7^#tS9
zPs>_knjK$%;b%~7=|1e9&<t*aAat50_JHacajD~F40N;*-rHKO;UG5B`)YRWkkB-@
zhXYj%?%uqrD8;;mNnnrqnj$}wyz(3)p&Fhre!@~L`V1zy@)){e*bH`Kazf&!&Ze$7
z8l69RPu`*rI6>;>BwSrKW8X~AG+b*#QDEMbmwpWO-26ewx;fC)&Xj}9a;ooqmwQ~4
zZ^OdJxd{wX%AC1WSw-387mVZakuf}>sFuwz5G(1z=zJ~zi_f%(UW|;@I(Bm8F7JE@
zwIgRV2A4aK1pBl2J&jl+Z7_^?WOV=FYTS8Pz<4j;nNn66g?b+KdU$bn+?Ph4j!mUT
z-`e}odRca*$7aitM7bti!@qaRPzc!{4tNK0FPlYd8nnEav_S=jTc;)Qeb<r9OMXKg
zkyR|y$peaYw#>5X_DS3A=7ISvCCJ1>&>s#7AcrYp1bje*Me23DrTfZ~l3V?&FHwm2
zPhB_a$`}B!=Vq^63!NAIRg{3hR|Cre0Kr${0m23}-GAxmd>Kn@+jEm*!3*+zsYjx6
z8807Mk$gLFMb0I%{8PV0|A-i~OY0j;=+f8r?I_3_6S7e{uw(atJqRXj*T}0O>?+yb
z>CNWtr86_+US$UJAM*6Sfkd4Asb_$0wT0))CqJdduBJ`9{}k<|mm&W6!RxOez}s}2
z%5_1(_L4p9+~8H^nk6|Qfo%pVuR!Tl8YxEPNl{vLK|c7Lo0kJy#Flt8vk_8%v>+>m
z-&}v@@$aWiMNDwA%s(|3sW)DoO4I*tuqhZZ_;UGl<-o)J>R8G~lMXESeXs}oasT``
zev}6xsE>!=(3|JiePnb78j?#`gdxo_6<g7qTs&k4v-hBMGGjA7UO4H{Y^)cdAp&tz
zXyx|P(JX|gReEz&aq+AC>Jsnn&feY?Nr{Q7sHkoFd>(Bk;QLH)XszKapxPI5n;Ui`
zHR!Ff$90-cVE1qqeP+AZWd2+F;dV^J`j6%9g0yk*>u*Be3T<Hc^hYJtVZx#gBj;WE
z@m%x`j3YVeaZ+h+Kc7O7b$l4!_Hy6EEG#`)StsS9uy`0S4c2s(a_=*#(uPP;o6b%?
zh+Moe3N*ooXnx<CQT5u&ovg0=kqkJ9m@2cIJ5#h`^umL=Z|0rF+$wCa24!YPkDHsB
ze!^gs*mR|mx@aw?+_P|O-f>3d>a!BRhcpRiY)@~RIMs8ji(4KQ9;h$d#n#@A<UWJ8
z#Q)*vklS3_I$OEgx7C}!zQ%5J^N@~PV#IzFoe<QDbJ=Q8nTf2DL6pgtsV98|Bg7$t
zmuCz7TNp#fZp?c)?p;^&<<{0}iFeoqMv`Cr%t2ylbuGO&7n<chi)L=DXM7QMXNtMX
zG%UGtWKvPcl?AyP1a~F~LXk>U79SNxC6=eFv<~(FM!8^!m&p#_pfvUDS$oi0bBc6p
z&@&+hPK-FdQ@A1C4}8*pIckg@#*41)U@=aUH!u&nBb_eBaz2i1hXuOL13g7%C96qP
zLh&X?Tjl<?5_t!dfvE@xlP%<`W&sDVb$U-n<+Dddq~|e&HT~`m35OtWM~kU`hDUmt
z-~QR3q$?rCr_#{RlAYeLRvb5GaWf`upE=iQQ{0cclhyPalp~Ly0S(JlfaXq8^%!_d
zb1bBLea)fGLcTgI@pr$=(xL8OCacM)1s^Er{JE9F_l5JgPRqV^D^Kw$$rQJF7qd|I
zTjHVi@oM@&x>{R5R|%$&lbS60xoaq(o5MIX8~Wu6m_r@6s!vu_s(EW{9-+d#5`m>O
z-2Jl7omrcm;e=KvxDf7R0rlpFT9@FHRFMrTBAQJd8l-9#%C=f>*lk@_3gXN0um}I6
zTh!x{x7dJ5*WZV8cDwt5zs)MH%!cy+KB$xH-vIvOw11hFp?KhL{pcQXW9RP@@D>GP
Nt?2w(KwzK1e*t!Xu6F<c

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/xinode_key.gz b/tests/ubifs_repair-tests/images/xinode_key.gz
new file mode 100644
index 0000000000000000000000000000000000000000..ff0a04f0df22bc0817e3cca97b53824e3796ec19
GIT binary patch
literal 5383
zcmcgwXH?VK_I1YhP)8BV2uht9RHTV09YX|cC{5`#qJ&5b0)`ffigYngP>>EHJrGJl
zhbUF4(h>=Th=BwM5Fms!lHY&c|I@5_zOV0oI_vIx*4^uzyY{;KD5UJ)??y?6?%5mW
z4G-{yLVTg&dsfK@TrGG&|0YsZU8UZ<KGT1|-YFexcGBeG=AiVkyJIi>yp0K`t`5xI
zOC0(-{vLfC3b`bn=B4&PW@<DI!KV}lBiI6&-F_ZN#(lJ(s>g|3=OEVwxlHxUeyR=p
zr5j@qiYZstLH0^|EjvH_4VhAGraPXz=f~><g?1eP{}|f?t+560yHR{VA-<<I6A}Gi
zjv0w<1ABjrS???X`+f`+t_sPbnBK_aExS{v29l6SsK-pGF-^s0pyF}{`GUNv#EiVI
zUC6L~Bfdth=^Z+zS<P0`i-VWHrt^BRYZB_*cQLB~McS)Af6D3AG(Yi~xP}5>-_iU|
z%v|Hk`;SXI{jTP0418b8B=YV(cXo%hT&Rh@EimaO({z#pm-+QF%JVqe{-1tK&RWvQ
z8~|pncfPBLcvQp83|31$q%|QS7G9y8B6cPg+iS5z!l<dvb?r!k%g(}s0w*LV4ubDp
zaa+{hA)Zi>btBAKgEYu>NY1uxL0-zfPkf^=`s6Vc6&1!m{{P0C7&P#oMSBwS?5+?n
zx!uvRDklI?XUR8J8M{AbxF_<^EjBPnDFXnHo9MRtok{Hr{~!fqZIM{jg6wLn*2OPs
zkl>EGc*h27KZE;6<mx1q<PSdI)bW+SK|G2Q_5@0Q?@XaFsE8h3UXOFJaEuIjsj8HY
zIPNQ`kL2&id9u@-DFKI(=O9eWmM9%WFDovIuBNmekc^@KW`wC~KfLCk{lFu)!Z}c^
zXoqgr{n13-`i@K0SHnurRJ+`;hWnH|ixJ{tCuTJzQF%RqKFP01--TN?E$;rC5#6>I
z5Afnx+}v4m7fqZvUnMNy_-AC8dnppUmb7XCL(bhWp?X{e$S{$v(E(T3GE!mAbVb>S
zkviwuw<z>XqDzrpZ2Bz=mol!rUd3!|SX34|)^Vma`c>>pZbVAIw{7ildS40)_nLkl
zlI!%A<uv~YR^;{GA=jyV*f)gCSnQZoZs{L5RCXemsJt_xg8LZJiyKkVo=ENuZY!TP
zofqL$Do!2LH*Lkf^#Bw&C0yZxsz!7`d1nE9Af;cweDd;Cvag(-Pr_6(#w9$}qyvq|
z|M)clrxi*8i2Hf$IZXM&DMOn@#hi^0q-|+=)d)C?YyH;7X&R2^7SD3`;Ehe^cDkV7
z%*tk;*N<$}{BmgGdL|-1^qRf*zwD$v--tPt82_)s-HCdUDIe&y>8JxBrijj`j1t3(
zd;r`WLqfKpFSV=I--<<#|5l~-Nk#mB9a8al0KoBLuH9gNcpz96WLy`^o*HI|W!gwi
zd0tf4yz0G@Y~d2=SM>GImPvl!sW&oP!|4Z>j2xA6YnO7z)HOFrajNb5yi;->8NZ<f
z-QnVo6Tr<8y9X_x^WqE*^j-$Ad6WQVv=`%&>VK<=xv^=@6Tjw&oKHyD?|UD8&fxPc
z0>vTF@66#LIj43JZ>6^%g@D9>rr4ZcIi2-soTq7z+|^GpG_*a0^b#>ju(f0ln|U{g
zo7Re6V1TVRKUmq<i&~PY2flyUecCGlPo|t}%;3A2BZS>O!k?W!3$7%w0pNFZ%-Hit
z$RbgYLx6m35Gg2l2r(Kt(F8N6Zww&)k14$Gf2zb2)W?16fP)}q{@GULK6<DcN{Wy7
zQ;#?l<pMN45iwDyT2b+OpX5X3gWEvN-RJC4uyaW`2>Mh6SS8nr4ltxa2wTY|K=^(?
z10S9c%4uT9OaMUOF#-^H<-Vm7^eG0gy5$52ejxDN0Q*V+@-V+Xv*Q5(jJ=ofhUO{!
zC&hp7JV6;(h+=qxZ2){I3E?oL`zkZ{3P&UU;I_Mf_fx6?`dBpJ%Pz2C5Rdpul6rra
zO_oT7h)c#4RPiw^)U}es#ESF{A!%N?n`dR~W6dtx-4r43Tj~ulfx#CRssZx+AZo>#
zX(_bStiCghepW7q?zOiP))=tEy)o)1PA|}qJE*ff79MNbM@o_=n~ab9f**&IK6t0P
z-I7^@87O*jFQ3eIhK~3r^m#}9k$WsYud_-2KAGnxUWU`YX#ii;j(&_;Zm5B)Y;cR0
z-p|`$%!offwqG8tlg4h>JF(RRITQJDWOQI~P)_zVsQ~&uT2#&OAurB!x`E!eF&&9w
z>YSB0%#0&41l-_VlV!zH8|l0tujg4B^|~*m0`#+K+1wQ9mEQS_5%AYQDOEhwhmgt!
zcQpAoFs(wezZGS2c7yS^S#B3YnG+bgQF+oGibm%FCaePC-@2J%L2Qtge_P7A0z=HE
zpAD70sG#n{7EWR>w{0ACn#(9abl49=Eonu{GO3f&ki%=PN>CH?jLfm2SbuR7FG)*K
z*_8hX$_9ls!^DhvcsFo2-U;qFF#qgo<4j<2%Gvb?H`eke{UYyw+S{-|yKa&8VxI-v
z2kb##QIqMv6J3y()w-OpU=Aw2E;P8R-Te9pVySF6VRt>X%Go<*x`k@FuW2+T8^2VM
zfUin2MX8MWx{xNDz?zMwi}R+gQeMQw3fj@)G3<CzVA7brfdjV8GxWe{FgZeXZnENK
z-{Nw-Van>>t}dyEQ#Wglb#x#G!?QG7Yr+j2YA85;nqkk<mD0F5G;95{l!Od$B=0-$
z{mVDw;`$kGxZ@D=EpWRbMKJ2>@-QE*Sy`A-;31q=Zfo}+-Pat3$U&ah9A5lBH00Le
zRm$nyu#gyT!FfA7Q?fSmf?(K+9QjDbOus2!E#TsuucuE!&+C?MbNeOW5fMJG%o!;~
z$d3?KaI3rja;D3g+Q=%psgh)+-yGM~8}MG(b~zD)BvA|JRxTM6w4c3rxea+23Ysi2
zd2AiD%95{=y_=Wc^vG>v`)f=2S*13mA(C#C1?$}$r%f2GLQU%&qNd!*R+949n*Gvz
zSCj@d1nJPH4$qa)6ryllv}wgz9pRY3vEM^7FK2Q3aYy@3h_j4p(}Z>~|Fv%980E~Q
z*5V3x(N3vxbdw-Ia~}R81@UD_lzxM3cJ9{bNu!c*H+m90L(u1{tqQvbEq}8l`(^ox
z!f?cGFMWzpTBq0OtIw%E7PH}?&)!vilDFGLpy7S(<=m+B6luvdxNKDJ<I))OTKD$Z
zoy4*tD}1*RCzvKsTYpPj`Y@kliQIvomyLwQE;pPqOHHRUdUW%n!l;GG4#J^hp(iX4
z9ja|D+q8q1cC<Nl5BW5$hqep5$#HBI#MoLbjG@@lM^%UrLw{`_(wRZl!_Wcb8?W9V
zv!z2iO5{K;jL{t{YQsh3=kvMSnuoJbI({*!4vJpzoERj4EtLZtK!)7yk9jN>rV1o~
z*JUTYvtKx=k#R~(dze5`nB@4BeFNotpWT=I%*yb&9vl-5kfy>4+#nk0cWbM)jR<o>
z{L!O(Ii!&g`$2MTQ(<A@4zKj3Iy{GXxt6og{sz~kGgVnj{o4LC#(hv?4Vsg0j~h#!
zg-kTI7Hr`ua1lN_`mJW|x`urfUMA!NKQ~;z!xhX)q-x@>4-_oH;$TCq#14Eb?FdK)
zSNQEFi#rx~FnW%v-DWW~VD?kg=vz<Qt=zB*hi#&zYU!f;_R9`Gk2=Ncou8=l?1QnT
z*bBM9t}lKNk$nhQ@d;}}*qzr6cMZHgt6L*K<v04mv7@h%$6NZzl!SV*q+=ygJGV~S
zDXnTcr8c<i&|$ZI?!in?BF#pQ{!hBg8LV=^jNa{zn(&WfF%mLCT?2+yq0PQUQyUnm
z=CIV7hHhm-Y1h@Yq$c99)0f~UoNvQrs!OMYaK~n?5xo71(F{4gOm<`r0dt1aLf7~f
zpBi4IuemqOB8SpR@o(18?1Y3{V>v?usxqO7Lodt?42Q#oul5NgrK)8XecM2uweh6&
z6UGJLt=zzS-?HpwGTC^kZ#KWS;_pzFtCXq*>?_p6tv;kn&#Ww(ApW2$7*?$fWQ{mo
z=UW^}$!$2`#OW(t7c^X-*BCXFxK!a(oEeUN@VLYg^Xh4JWA%Q051o)i&VqWqrrllQ
zw(GVUV+qYTb)!J`g==Nb_>^XSK9lOK<KN&iqd@^FUIYJ8S5}lh<nJj|4INj3UR(Bz
zM6OyIhhXBXLY%{{zO~53cpPiiy0E}2Y2N_Z96wvp6tQ_PeC>&BK-qrbldq3aj}3*k
z%&E1s*e&O1TywNzNZSyJ{fB*=tVkGkeXHQJqLN=QA^Vth@KYgHTUXX6G>;tS_>@UC
zLlPrq^X;ZD?%ZSA9gm-K#72%yzUbMs5~$aBEqfbmZw;?F<V$(_>E&v{L*~0O^7?i4
zY9B<>oP?@$Y>0eNxB=<=*lMnEf-k{0D6*?gwu2Fjf7obL65m@Wr`ozJxV|wrs#Rc~
zedJ`3VdrfV^4>8#hA_R=LVc9UlDHVrcYc4{*lDHDg~euzF!^D8la90G*Y29BB=Has
z*-Q9NvH{BfmVrW68D0ely<q(?23E5gUn$$XK9XGdPsAS~f}B*NNnUA93!*ypvmCMj
z)!te^_(9c5V^@;Yzm;q}WWl>smK7J+9WdwOOR9xXe#MmBk!zaM$MWJzESHM?rTR(}
zA|G@veWW>u`pTN^EaB=!+duVXt*;B8MIMf7*lx|aO?q9)BJKLs!^`tOPTb_-t9|qU
zX)G{aQ~6Zg(x*@Dz}QS6)Oo@~SwoFe#@nUo+D-`CPCV$hg@ASMf<Mj=8F%Nk?lo|z
zugP2VWj`7lQCh#lv(t6=pM!nLZb@04bl(;d7Y-w`BbF1w)S4>3?(V$5<-M0gBRp=i
zZps<-9L*vecZOH5I>D04a2w$t*Jj{grzC}g&PfW+t*`m*g}<+>yI|E~?iQiJupjw_
z4WmDOUDfBgVgPtJo{Fs>k@)ey=|g|vU);GWE$7p1%R*6x@(EjsG<(;RO1nmskH;0&
zXOgrZ^xC`c8vo<xdEOU{YA#L^759jgY;mJbuEtT8i`maAZjWaBKzurD?z5)ON9S!g
zUAq>L4Iwc8i>K#mMZOgQ4zMrEbJKCk2h%Inxn|H?*QR*zONwi8qTL7blGg?lWRH{`
zTZkdGv>mCa)Z6ndG^E6y{Js$@|2)yW+V!?N`*-Erg98b*cWphVgdZ%7-N+><siyt!
zP4*vuo@W0#BFTA~amM;zw|?LHoxca7bq;w`jgaWBg$Z6Kch@$|jKB|nVsb8Af-&`B
zB7g;k-H=-E`Q;4J7aUoQD5N`DZ1Y#UitwuUe)Eomf%PLEx<1sfq^ti*&yMgM9Y<5T
zBCkem(Xz7pXv1=Hc`l8*I9!0wFpald070QptaClo<ds__;LNBVCYHR&l3g7<HO_rW
z=CAJX^*Xb+5M2M0o2mA4`31E>h@F2P^Op1J=DTr2#z|;OH!qRz=}O^I44ZHvLx*}l
z(WYafV35Y663^dvHAm(%>UZN`!E%Yc>)%724q<7r1dpBE%aqZxkC`KfJ*@cFEMPrz
zn}^zHjV{;I=;aXK#WE>JNLFWs^zT`2{q~+hKGpvwO~DZt)ZO|r!@{DZtXPkt>uV_=
zkjRoNVI5`SUo9Z-&n)9~`!>acjA&9SDFLVH)M6qY4AR6>BV<K&Ys+YgA}>ehG}F&7
z`u+^9acyyBb1{CAel~7h;rYVW=0}TpeL;ujYH&UNYmLU5*7K*)`19eF(3Ro&h|xva
zK_U!xV&zg45r=4c-Qy4vL$s5m+}z=WDoKZ!A6VO$CK9q%zA8&Vg_2N>UvQsaj4Dt_
z<8!Z25Mb*dm~xcvkjUTH)K66X6mXgWEK6xv=1b#&-vrdJ7j|y6*C-}2cNdD0WeFjT
zqGf(B1Ft86)me6HiLq-Jfn8^L19|g7RyWTw70gpGN)92y(Y)zaS`Am|JHSNQbSDO2
z3BZ?U-3?yPLn6*MunV}MjAAGJZtvUHg|5yfcc0Gfr-aFI(uq+Pj8dPPS`>95>fBZ8
zv$h8Bdf9kEOO#6;s1!SKq+WkqPa<;n8#=3qoNjdJE^66MPl9E+?(!($VHsdFxUzYj
zs!`Ptjam#a&<Texw*?aeNVDylDmM+RLLG?O4JL+FH;m3VD_wSQMIqiy6_<WdfDz{u
zA)|-E%$CTyNKm6~k^Eqv2D3v0D|K4PUWy6`6=^n}R?s}F&z{1XZqix#(Ay5P3V)VM
zAT_L<D*QzRlx?obtp!uLVot!E3OWXc3}CdUaR;g)y@KX0cGV6=^DlDo%|~Zk0948S
zeZc1`J`4O^R;K8pn7^d{J1jTi{C!4sh1~-D-N;pr3W2|6T1NptLtoo%@7W`^=l=l9
CEWC;U

literal 0
HcmV?d00001

diff --git a/tests/ubifs_repair-tests/images/xinode_mode.gz b/tests/ubifs_repair-tests/images/xinode_mode.gz
new file mode 100644
index 0000000000000000000000000000000000000000..c86f69c7e3a716864035d1763ae533079727b8b2
GIT binary patch
literal 5386
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
QVZvU0uJPWrOJvtS0f#f8%m4rY

literal 0
HcmV?d00001

-- 
2.13.6


