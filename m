Return-Path: <linux-kernel+bounces-55829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F3F84C232
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B427B2A1D8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D571FC1D;
	Wed,  7 Feb 2024 02:02:09 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C1EDDC1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271329; cv=none; b=iVgqa88zV/4DKH3WEbkaMPgM0yrGunTNVTVSJsy2Bb7jGj9miUhxRFzp5WUjrdpjmdrBfzbOU6w4QJSl5eYH5u42JIa8sKT6ZQX7NHk0FN1CTdabtvTQ9PCKalEs1bl8/5cWU3FyGPtRpacB/BGrW525ZaeBxZN+A8F97UgOX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271329; c=relaxed/simple;
	bh=CaZxgYYb4ZfJrYl/9daHpHqKX/nQ0rHVtu0HGQLYOY4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iclEMdZQ5w8k30iEvOOeUfqeh4S+EJm8m1xSTpLU4t0UKIvdzvIbz2JY8FVoWDRVFbIXmkdVQ2CHvd5NLRnZezb8vA4SC9SCQ1WeigYLXfmLCbp4wLAzPwr61Kd/5eNiYSuqCwNqZaEo6YxARHFcIlzzygPQyhU7ho9n0ap12so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41721TTX075531;
	Wed, 7 Feb 2024 10:01:29 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TV3J13RTXz2K4cHw;
	Wed,  7 Feb 2024 10:01:21 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 7 Feb 2024 10:01:26 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH v2 1/4] f2fs: correct counting methods of free_segments in __set_inuse
Date: Wed, 7 Feb 2024 10:01:01 +0800
Message-ID: <1707271264-5551-2-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
References: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 41721TTX075531

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


