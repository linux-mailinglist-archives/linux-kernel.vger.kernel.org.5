Return-Path: <linux-kernel+bounces-72390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF21B85B2BB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C6012870DD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D84A58101;
	Tue, 20 Feb 2024 06:12:35 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319758205
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708409554; cv=none; b=DcO+Omd4z/6BOgDO8pgqaaZnHnPflNnn0hfH6FW7hQc6s/qbb9ZNy2r1xy0QtL6Buf8zKyfB511Q2Nv3eUleslSToZBifK7UNzxmC0Idek4hRIiCQJdns19WzaLxVxJRvtrNwlBO4KcbaXAYRZpAPWJUdn9l9S0eWemhNA+OFMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708409554; c=relaxed/simple;
	bh=fnveXVA8uwvpzeoXM7iu36eGk0swh3LJ1WxEDd6T8p8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=V+9rs8r77LatrYGTLwC0eiAXBL/XgIOrCAHGRZ6gnTDdXCndQYR9U+Hig956A02kR2V4SV1seR2N4/GYIVuytEGpuny34/ASzyriqurdumdgtK/G2Xx1D/sbOjPz2N5eB2GAOfWERputDwj7CTCNCuEihUsO3SQaoKkgAY6h5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41K6BVwF081774;
	Tue, 20 Feb 2024 14:11:31 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4Tf8D24k1Qz2K4gjL;
	Tue, 20 Feb 2024 14:10:58 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Tue, 20 Feb 2024 14:11:29 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH v4 4/4] f2fs: stop checkpoint when get a out-of-bounds segment
Date: Tue, 20 Feb 2024 14:11:24 +0800
Message-ID: <1708409484-27326-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 41K6BVwF081774

There is low probability that an out-of-bounds segment will be got
on a small-capacity device. In order to prevent subsequent write requests
allocating block address from this invalid segment, which may cause
unexpected issue, stop checkpoint should be performed.

Also introduce a new stop cp reason: STOP_CP_REASON_NO_SEGMENT.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
changes of v4: use more suitable MACRO name according to Chao's suggestions
changes of v3: correct MACRO spelling and update based on the lastes code
---
---
 fs/f2fs/segment.c       | 7 ++++++-
 include/linux/f2fs_fs.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c25aaec..e42e34c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2665,7 +2665,12 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 	if (secno >= MAIN_SECS(sbi)) {
 		secno = find_first_zero_bit(free_i->free_secmap,
 							MAIN_SECS(sbi));
-		f2fs_bug_on(sbi, secno >= MAIN_SECS(sbi));
+		if (secno >= MAIN_SECS(sbi)) {
+			f2fs_stop_checkpoint(sbi, false,
+				STOP_CP_REASON_NO_SEGMENT);
+			f2fs_bug_on(sbi, 1);
+		}
+
 	}
 	segno = GET_SEG_FROM_SEC(sbi, secno);
 	zoneno = GET_ZONE_FROM_SEC(sbi, secno);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 9b69c50..755e9a4 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -75,6 +75,7 @@ enum stop_cp_reason {
 	STOP_CP_REASON_CORRUPTED_SUMMARY,
 	STOP_CP_REASON_UPDATE_INODE,
 	STOP_CP_REASON_FLUSH_FAIL,
+	STOP_CP_REASON_NO_SEGMENT,
 	STOP_CP_REASON_MAX,
 };
 
-- 
1.9.1


