Return-Path: <linux-kernel+bounces-12081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9981EFB8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 16:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0781283025
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5449845961;
	Wed, 27 Dec 2023 15:19:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D6145956
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 15:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VzLTIgm_1703690346;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VzLTIgm_1703690346)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 23:19:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
Subject: [PATCH] erofs: avoid debugging output for (de)compressed data
Date: Wed, 27 Dec 2023 23:19:03 +0800
Message-Id: <20231227151903.2900413-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <000000000000321c24060d7cfa1c@google.com>
References: <000000000000321c24060d7cfa1c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzbot reported a KMSAN warning,
erofs: (device loop0): z_erofs_lz4_decompress_mem: failed to decompress -12 in[46, 4050] out[917]
=====================================================
BUG: KMSAN: uninit-value in hex_dump_to_buffer+0xae9/0x10f0 lib/hexdump.c:194
  ..
  print_hex_dump+0x13d/0x3e0 lib/hexdump.c:276
  z_erofs_lz4_decompress_mem fs/erofs/decompressor.c:252 [inline]
  z_erofs_lz4_decompress+0x257e/0x2a70 fs/erofs/decompressor.c:311
  z_erofs_decompress_pcluster fs/erofs/zdata.c:1290 [inline]
  z_erofs_decompress_queue+0x338c/0x6460 fs/erofs/zdata.c:1372
  z_erofs_runqueue+0x36cd/0x3830
  z_erofs_read_folio+0x435/0x810 fs/erofs/zdata.c:1843

The root cause is that the printed decompressed buffer may be filled
incompletely due to decompression failure.  Since they were once only
used for debugging, get rid of them now.

Reported-by: syzbot+6c746eea496f34b3161d@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/000000000000321c24060d7cfa1c@google.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index af98e88908ee..923afef7997a 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -246,15 +246,9 @@ static int z_erofs_lz4_decompress_mem(struct z_erofs_lz4_decompress_ctx *ctx,
 	if (ret != rq->outputsize) {
 		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
 			  ret, rq->inputsize, inputmargin, rq->outputsize);
-
-		print_hex_dump(KERN_DEBUG, "[ in]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, src + inputmargin, rq->inputsize, true);
-		print_hex_dump(KERN_DEBUG, "[out]: ", DUMP_PREFIX_OFFSET,
-			       16, 1, out, rq->outputsize, true);
-
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
-		ret = -EIO;
+		ret = -EFSCORRUPTED;
 	} else {
 		ret = 0;
 	}
-- 
2.39.3


