Return-Path: <linux-kernel+bounces-42531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E328402B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9400C282EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E6258205;
	Mon, 29 Jan 2024 10:23:25 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842E258105
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523804; cv=none; b=sKseqajFaUUnLIZDbxQ9wOes0yx2q96qQKAhranrNWb9wwAi3AHs8WWaJcFNyrf1oI9LPWBFWWZBWLdjMsKBcHMP506MUuVxvFTRWXtVwwyWK3NEPaVrNgUBzl/4zKSFNCrlWIlSOYs+TxJ7SeirbEz1SY77Ce0mMx8i6IsTvyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523804; c=relaxed/simple;
	bh=CaZxgYYb4ZfJrYl/9daHpHqKX/nQ0rHVtu0HGQLYOY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YbSt/Djucjr04nC2VvwdyzAaIYug8Sj3ys5Aoh7LfDqdWKIty1N+3wCVIiwiGzf+IOgU+dU1C2HjOKzQ89LjCAYO3W9dQnuxgEC3/nsJeM7fA+HWiP9cgsQAhy0M5DgJEszaeiwqiUdcdFqZgzO6N2NENcTnAn83G7J3KYE998Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40TAM7Tk022034;
	Mon, 29 Jan 2024 18:22:07 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TNkgG1rC5z2R5Td1;
	Mon, 29 Jan 2024 18:14:34 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 29 Jan 2024 18:22:05 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH 1/3] f2fs: correct counting methods of free_segments in __set_inuse
Date: Mon, 29 Jan 2024 18:21:49 +0800
Message-ID: <1706523709-24605-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 40TAM7Tk022034

There is a corner scenario on a small-capacity partition with 64MB size:
1. The main area has a total of 24 segments, and there are no free
segments left shown from the free_segmap bitmap and free_secmap in
free_segmap_info.
---------------------------------------------------------------------
bitmap value: ffffffffffffffff
---------------------------------------------------------------------
2. When doing gc, an out-of-bounds segment with segno=24 is allocated.
Because CONFIG_F2FS_CHECK_FS is not enabled, f2fs_bug_on in get_new_segment
just print warning log but the subsequent process continues to run.
---------------------------------------------------------------------
got_it:
    /* set it as dirty segment in free segmap */
    f2fs_bug_on(sbi, test_bit(segno, free_i->free_segmap));
    __set_inuse(sbi, segno);
----------------------------------------------------------------------
3. __set_inuse directly sets free_i->free_segments--,
As a result, free_i->free_segments=-1, as shown in the following
coredump information:
----------------------------------------------------------------------
  crash_arm64> struct free_segmap_info 0xffffff8084d9a000 -x
  struct free_segmap_info {
  start_segno = 0x7,
  free_segments = 0xffffffff,
  free_sections = 0x0,
----------------------------------------------------------------------
This is unreasonable and will cause free_segments and free_sections
counts mismatch if there are segments released as free.

So same counting methods like free_sections should be used to
free_segments.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/segment.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 8129be7..f2847f1 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -463,8 +463,8 @@ static inline void __set_inuse(struct f2fs_sb_info *sbi,
 	struct free_segmap_info *free_i = FREE_I(sbi);
 	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
 
-	set_bit(segno, free_i->free_segmap);
-	free_i->free_segments--;
+	if (!test_and_set_bit(segno, free_i->free_segmap))
+		free_i->free_segments--;
 	if (!test_and_set_bit(secno, free_i->free_secmap))
 		free_i->free_sections--;
 }
-- 
1.9.1


