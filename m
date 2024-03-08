Return-Path: <linux-kernel+bounces-96805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6F78761A9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1941F232A7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671A53E17;
	Fri,  8 Mar 2024 10:13:13 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683B55381E
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892793; cv=none; b=JXACDrivwGgQZBtQiDrtaBD4PLBxfMXTVc5gcEepv/fwI/MsMEO0zHtKlYfhSafjRzUz6U84ryX7yYddhnQRU6mFumu/o63iwYsPYsTkKSpqI26AyEchQe61IPegmfIpIXrpQ/IgfHRhZgNwYLW/G/uQLgD94YpF4vC7yQe/Ds0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892793; c=relaxed/simple;
	bh=WeE17r77aXKxwoNW7bW5pS29OZsiQmX2gOInE1lutwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nqS5Vg0Y9UbIpkL24nXScMgFCBl5ztDZIY7qzEcA5gYuraJldgH+/L84b7Jj7xbiIIsVJkENRlo03YzFnpLDPgDQcxEDIliGCDnPhcYCK5JAoiSMnUcrV2tWH/aZBs+tFC2ra6Ak4XzA/1nE6TT2lsXB1Sfa1eongsVnOd1QfqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 428ACbu3067848;
	Fri, 8 Mar 2024 18:12:37 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Trhll6Yxwz2L3SH2;
	Fri,  8 Mar 2024 18:11:31 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 8 Mar 2024 18:12:36 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH 1/2] f2fs: fix to remove f2fs_bug_on in add_bio_entry
Date: Fri, 8 Mar 2024 18:12:32 +0800
Message-ID: <1709892753-27461-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 428ACbu3067848

add_bio_entry should not trigger system panic when bio_add_page fail,
fix to remove it.

Fixes: 0b20fcec8651 ("f2fs: cache global IPU bio")
Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/data.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d9494b5..f8ae684 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -759,8 +759,10 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
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


