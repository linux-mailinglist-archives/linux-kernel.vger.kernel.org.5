Return-Path: <linux-kernel+bounces-11815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E981EC01
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 05:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2328C283563
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 04:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5A63C2C;
	Wed, 27 Dec 2023 04:17:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4160D3C15
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 04:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VzJyGwp_1703650640;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzJyGwp_1703650640)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 12:17:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Yue Hu <huyue2@coolpad.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Chao Yu <chao@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	bugreport@ubisectech.com
Subject: [PATCH] erofs: fix inconsistent per-file compression format
Date: Wed, 27 Dec 2023 12:17:18 +0800
Message-Id: <20231227041718.1428868-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <1affdad9-20f1-4fca-95af-237fda3df2b1.bugreport@ubisectech.com>
References: <1affdad9-20f1-4fca-95af-237fda3df2b1.bugreport@ubisectech.com>
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
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/zmap.c         | 15 ++++++++-------
 2 files changed, 9 insertions(+), 8 deletions(-)

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
index 7b55111fd533..d513f2cd7521 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -578,7 +578,8 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
 	struct super_block *const sb = inode->i_sb;
-	int err, headnr;
+	struct erofs_sb_info *sbi = EROFS_SB(sb);
+	int err, nr;
 	erofs_off_t pos;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	void *kaddr;
@@ -622,12 +623,12 @@ static int z_erofs_fill_inode_lazy(struct inode *inode)
 	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
 	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
 
-	headnr = 0;
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
-	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
-			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
-		err = -EOPNOTSUPP;
+	nr = 0;
+	if (!(sbi->available_compr_algs & (1 << vi->z_algorithmtype[0])) ||
+	    !(sbi->available_compr_algs & (1 << vi->z_algorithmtype[++nr]))) {
+		erofs_err(sb, "inconsistent HEAD%u algorithm format %u for nid %llu",
+			  nr + 1, vi->z_algorithmtype[nr], vi->nid);
+		err = -EFSCORRUPTED;
 		goto out_put_metabuf;
 	}
 
-- 
2.39.3


