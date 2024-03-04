Return-Path: <linux-kernel+bounces-90524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D43870099
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8F4B24241
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57EF33A287;
	Mon,  4 Mar 2024 11:44:18 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71803A1BD
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552657; cv=none; b=FtAaVDCbqSv5QtWcs6hYEWQkss013YB0CcWB0gzaS+CDoznndknZODZcQ8R3r73EOUXUSNh557NDzopdr6SQzAOFnJAKmNXIpGfu9LxqBzwKoIYvwP/42oZAP0duP8XZM1KfHpdqxcx9nwgdiXdRR7jhUMEAwMSxIxTey/gD9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552657; c=relaxed/simple;
	bh=5iF5ULb6UQAyIkEg3k/MDpf1xc/nJELC4HMPKOgxefI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WAuZtLGGP0Bdv7fi+0Rs0Y5UBAcHMuhXs29OPU4Ud82c3OkWEwGD1uDMn84FFfUXTmXeljg8tOA/BEHWYIe58XzLDHAv9OxjgzQr5DODOyM5V6zVVsfrV2IWpD2aqqQl6cqzkhdbUG0LVL5pwMOebSCTn8+RkE1PvGrxwyht2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 424BhWrk006663;
	Mon, 4 Mar 2024 19:43:32 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TpGyf2pWZz2Kr5R7;
	Mon,  4 Mar 2024 19:42:34 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 4 Mar 2024 19:43:30 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH] f2fs: fix to remove f2fs_bug_on in add_bio_entry
Date: Mon, 4 Mar 2024 19:43:22 +0800
Message-ID: <1709552602-14373-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 424BhWrk006663

add_bio_entry should not trigger system panic when bio_add_page fail,
fix to remove it.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/data.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index bd8674b..2fbbf8f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -761,8 +761,10 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	be->bio = bio;
 	bio_get(bio);
 
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE)
-		f2fs_bug_on(sbi, 1);
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) != PAGE_SIZE) {
+		bio_put(bio);
+		return;
+	}
 
 	f2fs_down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
-- 
1.9.1


