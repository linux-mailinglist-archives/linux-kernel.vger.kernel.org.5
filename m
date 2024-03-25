Return-Path: <linux-kernel+bounces-116563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B3889ED4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:17:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85321C2DEC0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BAD814D43B;
	Mon, 25 Mar 2024 08:17:30 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB6D14D441
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711346253; cv=none; b=oT35Y8a9rVnLlVyjx1ERUCe1gain54FrlEbypDGzogi+UqLDjRN9G2E/m/9R09nhOQNPt8porvlsB5StzuWH+Ae9l9MHcAQLUOUwQm9r6AAlnQv3FesYmXZJRYGEiWvC7tF4ijlBY81FIMfWmCWxOolxJH0jaCaP0ogMdaUUbRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711346253; c=relaxed/simple;
	bh=hct+CG+K49mQ7e/gs5Egxa90nVS7OdjNK08fkPwVO7E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ciH92jGgEXBWdqifSj8CmRbEcAzU6q3uO631LQbxZbJLMv8ZQN7YucAImsn3WymEKchy+kHYKdCy5N9sgiYCGmbEQXKqZcGstxiJS5VhCsVrAzRyZ8OnvR1tyrVUoEOFKUrmLnAn7tm2o2Tz1/xj17SBFvjtDtFyHtkl6i2M7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42P5uic2078365;
	Mon, 25 Mar 2024 13:56:44 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V32G14BRMz2KXJwC;
	Mon, 25 Mar 2024 13:55:05 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 25 Mar 2024 13:56:42 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH V2] f2fs: fix to adjust appropirate defragment pg_end
Date: Mon, 25 Mar 2024 13:56:35 +0800
Message-ID: <1711346195-24555-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 42P5uic2078365

A length that exceeds the real size of the inode may be
specified from user, although these out-of-range areas
are not mapped, but they still need to be check in
while loop, which is unnecessary.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
v2: check i_size within inode lock according to Chao's suggestions
---
---
 fs/f2fs/file.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 128e53d..cf63db7 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2608,9 +2608,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	bool fragmented = false;
 	int err;
 
-	pg_start = range->start >> PAGE_SHIFT;
-	pg_end = (range->start + range->len) >> PAGE_SHIFT;
-
 	f2fs_balance_fs(sbi, true);
 
 	inode_lock(inode);
@@ -2629,10 +2626,16 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
-						range->start + range->len - 1);
+						min_t(loff_t, range->start + range->len - 1,
+						i_size_read(inode) - 1));
 	if (err)
 		goto out;
 
+	pg_start = range->start >> PAGE_SHIFT;
+	pg_end = min_t(pgoff_t,
+				(range->start + range->len) >> PAGE_SHIFT,
+				DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
+
 	/*
 	 * lookup mapping info in extent cache, skip defragmenting if physical
 	 * block addresses are continuous.
-- 
1.9.1


