Return-Path: <linux-kernel+bounces-110978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D143886693
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:04:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932ED282E9F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA50C133;
	Fri, 22 Mar 2024 06:04:23 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34DE65C
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087462; cv=none; b=fBmmwU8LD7hQTuvW0dPBfgMRT53scMhZeZ6+QeOUTML3x88dSzE8P81cHbjdJj/AnYmk3+LSWrp0Qp9Z6m62j2ZEImckyYwP8hDu/PzM3Pk0oAWsQ0PNmWgSKkonizKtLH1eUBVuWYLHgOj6+x+i+VhJDqys+/Tpt0gU/FEo06Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087462; c=relaxed/simple;
	bh=oymclslinvYkSdIJY8wyn9nZB7VJgipYqG8U7+so4+A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4rSMIa8u58H7o7mXE513YumwWJ6aPcIYTnnWOyV9l3ODNtVEqK+286Op+sYfWeQk2zyIioUDQls7PFs4ypMwmWIa84wJ0G/xxcGCvBZ7NPQPCTIefw2Ie/8896gy/e9xzKDxmMmek0wMzlohJUc1B5pSN0UMdgdiRvme9dZnvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 42M63LJl093516;
	Fri, 22 Mar 2024 14:03:21 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4V1BY828Zkz2Lj488;
	Fri, 22 Mar 2024 14:01:48 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 22 Mar 2024 14:03:19 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH] f2fs: fix to adjust appropirate defragment pg_end
Date: Fri, 22 Mar 2024 14:03:10 +0800
Message-ID: <1711087390-23645-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 42M63LJl093516

A length that exceeds the real size of the inode may be
specified from user, although these out-of-range areas
are not mapped, but they still need to be check in
while loop, which is unnecessary.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 128e53d..0e7eac6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2609,7 +2609,9 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 	int err;
 
 	pg_start = range->start >> PAGE_SHIFT;
-	pg_end = (range->start + range->len) >> PAGE_SHIFT;
+	pg_end = min_t(pgoff_t,
+			(range->start + range->len) >> PAGE_SHIFT,
+			DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE));
 
 	f2fs_balance_fs(sbi, true);
 
-- 
1.9.1


