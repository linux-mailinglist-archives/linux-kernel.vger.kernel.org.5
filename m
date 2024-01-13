Return-Path: <linux-kernel+bounces-25314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B582CD61
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 16:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 794E628370B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 15:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA5EA4;
	Sat, 13 Jan 2024 15:06:22 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78CC360
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-Vyax8_1705158364;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W-Vyax8_1705158364)
          by smtp.aliyun-inc.com;
          Sat, 13 Jan 2024 23:06:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Yue Hu <huyue2@coolpad.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	bugreport@ubisectech.com
Subject: [PATCH v3] erofs: fix inconsistent per-file compression format
Date: Sat, 13 Jan 2024 23:06:02 +0800
Message-Id: <20240113150602.1471050-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
References: <20231227050633.1507448-1-hsiangkao@linux.alibaba.com>
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
an unsupported algorithmtype for specific inodes, e.g. use MicroLZMA
algorithmtype even it's not set in `sbi->available_compr_algs`.  This
can lead to an unexpected "BUG: kernel NULL pointer dereference" if
the corresponding decompressor isn't built-in.

Fix this by checking against `sbi->available_compr_algs` for each
m_algorithmformat request.  Incorrect !erofs_sb_has_compr_cfgs preset
bitmap is now fixed together since it was harmless previously.

Reported-by: <bugreport@ubisectech.com>
Fixes: 8f89926290c4 ("erofs: get compression algorithms directly on mapping")
Fixes: 622ceaddb764 ("erofs: lzma compression support")
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
changes since v2:
 - Should check in z_erofs_do_map_blocks() runtimely since another
   algorithmtype[0/1] could leave as unused (0) but it can be
   problematic if LZ4 is not set in `sbi->available_compr_algs`.

 fs/erofs/decompressor.c |  2 +-
 fs/erofs/zmap.c         | 23 +++++++++++++----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 1d65b9f60a39..072ef6a66823 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -408,7 +408,7 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	int size, ret = 0;
 
 	if (!erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs = Z_EROFS_COMPRESSION_LZ4;
+		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
 		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 	}
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9753875e41cb..7e1116804008 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -454,7 +454,7 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 		.map = map,
 	};
 	int err = 0;
-	unsigned int lclusterbits, endoff;
+	unsigned int lclusterbits, endoff, afmt;
 	unsigned long initial_lcn;
 	unsigned long long ofs, end;
 
@@ -543,17 +543,20 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			err = -EFSCORRUPTED;
 			goto unmap_out;
 		}
-		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_INTERLACED;
-		else
-			map->m_algorithmformat =
-				Z_EROFS_COMPRESSION_SHIFTED;
-	} else if (m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2) {
-		map->m_algorithmformat = vi->z_algorithmtype[1];
+		afmt = vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER ?
+			Z_EROFS_COMPRESSION_INTERLACED :
+			Z_EROFS_COMPRESSION_SHIFTED;
 	} else {
-		map->m_algorithmformat = vi->z_algorithmtype[0];
+		afmt = m.headtype == Z_EROFS_LCLUSTER_TYPE_HEAD2 ?
+			vi->z_algorithmtype[1] : vi->z_algorithmtype[0];
+		if (!(EROFS_I_SB(inode)->available_compr_algs & (1 << afmt))) {
+			erofs_err(inode->i_sb, "inconsistent algorithmtype %u for nid %llu",
+				  afmt, vi->nid);
+			err = -EFSCORRUPTED;
+			goto unmap_out;
+		}
 	}
+	map->m_algorithmformat = afmt;
 
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
-- 
2.39.3


