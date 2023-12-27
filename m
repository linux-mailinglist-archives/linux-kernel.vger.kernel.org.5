Return-Path: <linux-kernel+bounces-11830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA91581EC37
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CB06283647
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D9373FE1;
	Wed, 27 Dec 2023 05:06:51 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4A3C24
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 05:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VzJx.pC_1703653594;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzJx.pC_1703653594)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 13:06:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Yue Hu <huyue2@coolpad.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	bugreport@ubisectech.com
Subject: [PATCH v2] erofs: fix inconsistent per-file compression format
Date: Wed, 27 Dec 2023 13:06:33 +0800
Message-Id: <20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231227041718.1428868-1-hsiangkao@linux.alibaba.com>
References: <20231227041718.1428868-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EROFS can select compression algorithms on a per-file basis, and each
per-file compression algorithm needs to be marked in the on-disk
superblock for initialization.

However, syzkaller can generate inconsistent crafted images that use
an unsupported algorithm for specific inodes; thus, an unexpected
"BUG: kernel NULL pointer dereference" can be raised.

Fix this by checking against `sbi->available_compr_algs` for each
compressed inode.  Incorrect !erofs_sb_has_compr_cfgs preset bitmap
is now fixed together since it was harmless previously.

Reported-by: <bugreport@ubisectech.com>
Fixes: 14373711dd54 ("erofs: add on-disk compression configurations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v1:
 - fix left-shift overflow (undefined behavior).

 fs/erofs/decompressor.c | 2 +-
 fs/erofs/zmap.c         | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 021be5feb1bc..af98e88908ee 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -398,7 +398,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	int size, ret = 0;
 
 	if (!erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
+		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
 		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 	}
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7b55111fd533..6f10bc8bbb1c 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -578,6 +578,7 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	int err, headnr;
 	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
@@ -624,10 +625,12 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 
 	headnr = 0;
 	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
-	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
+	    !(sbi->available_compr_algs & (1 << vi->z_algorithmtype[0])) ||
+	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX ||
+	    !(sbi->available_compr_algs & (1 << vi->z_algorithmtype[headnr]))) {
+		erofs_err(sb, "inconsistent HEAD%u algorithm format %u for nid %llu",
 			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
-		err = -EOPNOTSUPP;
+		err = -EFSCORRUPTED;
 		goto out_put_metabuf;
 	}
 
-- 
2.39.3


