Return-Path: <linux-kernel+bounces-158268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50F08B1DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021471C23C16
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B451272C0;
	Thu, 25 Apr 2024 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HQBOLnHA"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E5128361
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714036666; cv=none; b=lxoKhuyA3BP6Mte4fj4RAoXzkVkwgrkxcnts5jiHalc1q0J+5CTtMn4w8x3c5XSJbQhmPrd2RBh6UyO/UJysI58mojYESV7zvyMSNxKS66Vmc0dd68FzK9p6TPMqCD6WtjYUCceL8iYrqK/wjvZX7Am8vEL7PXyT2eEKiIIPEt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714036666; c=relaxed/simple;
	bh=65YKvGP5ldFEl9ghgHolAKwSIFb4oPQzeVo0l5Pgbv4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=S3lOiyplDuKnpewiV6TcJnEIU/2AAMzLErSYpTX0UscAnCKZJI1BytzYE0uUZgd631Ng1SmmaMk1a7igiFfhRbaY9qDb1I5fCwczmI1Om8FXxbNFzW5c0N/6gS92PJSyLBu3amNOqrN1Ug8YVV71XN2Xd6dwfpehVJdXdNAZ2No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HQBOLnHA; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714036661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=w9QN+P4vB8I0CAC9KqWe0wqLc0QQQLpQU5nSVu5xq8Q=;
	b=HQBOLnHAvyMVhYpOUP0Uy4vb/0VlhxF6hu9ZovWP9+FnnMWH6ZO3dz+BEbGKZdPoUdksWg
	MvsPvYKnkSYuX60kwCTS2RFbFOPiJYG9INYQrfQsbzEZFcgcJZ8ZhFkV9J/16qhEda74+B
	rdodoLIv02D7/9owtFkLy+FjIkYsKW0=
From: Youling Tang <youling.tang@linux.dev>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Youling Tang <tangyouling@kylinos.cn>
Subject: [PATCH] bcachefs: Use filemap_read() to simplify the execution flow
Date: Thu, 25 Apr 2024 17:16:59 +0800
Message-Id: <20240425091659.6148-1-youling.tang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Youling Tang <tangyouling@kylinos.cn>

Using filemap_read() can reduce unnecessary code execution
for non IOCB_DIRECT paths.

Signed-off-by: Youling Tang <tangyouling@kylinos.cn>
---
 fs/bcachefs/fs-io-direct.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/fs-io-direct.c b/fs/bcachefs/fs-io-direct.c
index 09d21aef879a..4072a6ba0d51 100644
--- a/fs/bcachefs/fs-io-direct.c
+++ b/fs/bcachefs/fs-io-direct.c
@@ -179,7 +179,7 @@ ssize_t bch2_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 	struct bch_inode_info *inode = file_bch_inode(file);
 	struct address_space *mapping = file->f_mapping;
 	size_t count = iov_iter_count(iter);
-	ssize_t ret;
+	ssize_t ret = 0;
 
 	if (!count)
 		return 0; /* skip atime */
@@ -205,7 +205,7 @@ ssize_t bch2_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			iocb->ki_pos += ret;
 	} else {
 		bch2_pagecache_add_get(inode);
-		ret = generic_file_read_iter(iocb, iter);
+		ret = filemap_read(iocb, iter, ret);
 		bch2_pagecache_add_put(inode);
 	}
 out:
-- 
2.34.1


