Return-Path: <linux-kernel+bounces-111669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D6E886F4F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4711F2442E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373984D595;
	Fri, 22 Mar 2024 15:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyou0njs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7539E4C601
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 15:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711119602; cv=none; b=Uq9/yJVk4jT/Lrlugv1RoIPcmVKowxwxq+G0TZgeiagt+tlKR/FlOTvgARdwJIeeTHgEVnOhWcF57m0KVXSlJqGZtc6dJaUNIoVGthm0Rk/lR8ZCM2bnL1RLnWYJgGQk+RIE4Tyzg64d0QKgy4J/Jl26yVHPr1II/yJPLJ8vGHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711119602; c=relaxed/simple;
	bh=n0MJ4YjaOKX2Bd1ABkqsW07WnDRYW7ulWQqb4AqpGVc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ETCPuxfZF5Vy64aRsII2ixrYUPf9KeElLrJEvKfT+r0aNiPtH5ohohBDquNkPdE3qMTIEfewgH6PB/Pytek8L0bXnUdzflxnaf/QAXpPHAJ3/S2pB5nbpWgZj3BhBSocP+Mw2m2z566r05qrLCNmErJ0qMux0+nqx3uzY1VDdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyou0njs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75ED1C433F1;
	Fri, 22 Mar 2024 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711119602;
	bh=n0MJ4YjaOKX2Bd1ABkqsW07WnDRYW7ulWQqb4AqpGVc=;
	h=From:To:Cc:Subject:Date:From;
	b=cyou0njs8x7Vs9rk8sEBi7YG32eFPaf4JbVqDon8/i8hPEwTr+tI7PX1NjNRI6FGV
	 qKcHs9Oa+MvockmwtqL7C4bNeiI/TTt5BS0p4zIAJYTou+MuQ7bj1mrOfJSCcXFCzZ
	 HSJMHxqDXd2vO8I953ErmC3IGPHvr30u0S3LnBCBtTYkTrPHNZGvBD9/iAQLj2gDfp
	 E+EmuzrmCG60FpTljylD3mFQra33ZOu4xqlrdCT7TeaPaFPh+n82CJaKa47azNE0H3
	 wpLNM0wA64oiRcRtbpssPCWZouRATPEngnQsm1jypdWmsgN5IgsFisq3F8IjXxGDp6
	 +LZ/MkMzy1a2w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	Roman Smirnov <r.smirnov@omp.ru>
Subject: [PATCH] f2fs: fix to detect inconsistent nat entry during truncation
Date: Fri, 22 Mar 2024 22:59:55 +0800
Message-Id: <20240322145955.2959257-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Roman Smirnov reported as below:

"
There is a possible bug in f2fs_truncate_inode_blocks():

    if (err < 0 && err != -ENOENT)
    			goto fail;
        ...
        offset[1] = 0;
        offset[0]++;
        nofs += err;

If err = -ENOENT then nofs will sum with an error code,
which is strange behaviour. Also if nofs < ENOENT this will
cause an overflow. err will be equal to -ENOENT with the
following call stack:

truncate_nodes()
  f2fs_get_node_page()
     __get_node_page()
        read_node_page()
"

If nat is corrupted, truncate_nodes() may return -ENOENT, and
f2fs_truncate_inode_blocks() doesn't handle such error correctly,
fix it.

Reported-by: Roman Smirnov <r.smirnov@omp.ru>
Closes: https://lore.kernel.org/linux-f2fs-devel/085b27fd2b364a3c8c3a9ca77363e246@omp.ru
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b3de6d6cdb02..bb57bbaff7b4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1187,7 +1187,17 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 		default:
 			BUG();
 		}
-		if (err < 0 && err != -ENOENT)
+		if (err == -ENOENT) {
+			set_sbi_flag(F2FS_P_SB(page), SBI_NEED_FSCK);
+			f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+			f2fs_err_ratelimited(sbi,
+				"truncate node fail, ino:%lu, nid:%u, "
+				"offset[0]:%d, offset[1]:%d, nofs:%d",
+				inode->i_ino, dn.nid, offset[0],
+				offset[1], nofs);
+			err = 0;
+		}
+		if (err < 0)
 			goto fail;
 		if (offset[1] == 0 &&
 				ri->i_nid[offset[0] - NODE_DIR1_BLOCK]) {
-- 
2.40.1


