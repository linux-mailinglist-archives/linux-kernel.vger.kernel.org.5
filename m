Return-Path: <linux-kernel+bounces-37200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4EF83AC80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C481F23291
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292F4128383;
	Wed, 24 Jan 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqkQ1rzS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE2128376
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107512; cv=none; b=RRXKqcwwkyprnnGgPyNGD1wnghsQggAxtmaYLMP7zPjwylsGbQBr0K55ynIEKR14GULSTT6cP9m3ccRTn91JhX9W749NZlO5ZP3UI/+bI90UmZROkKb7jw5xwn7jVYUg/0IOdwzkSMaX22MC0iSWIm6cYOFYN4159O+Uc81DuFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107512; c=relaxed/simple;
	bh=GmaYoIhCc4vPw5Lo1/sPZc2Sy8eWLhDLcOKDvMVTJ2w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cUc6ogT8D9sNCvExoMaTohVM2bDWsotGk5YjzjTSz9qRsqeoifjoHqEpGsML8SxGGb8fEAn1X1cZmr0Hhl96NwkpWF506Jwo3bXGPXZhD8BAweSJq5fiBxxupqWH9LQjxSdJ7/GuMLDL7Pchz1i04A09mm6bM3iW3iFBcLc71ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqkQ1rzS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B78C43399;
	Wed, 24 Jan 2024 14:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706107512;
	bh=GmaYoIhCc4vPw5Lo1/sPZc2Sy8eWLhDLcOKDvMVTJ2w=;
	h=From:To:Cc:Subject:Date:From;
	b=JqkQ1rzSk81G/5oXUF5vcMSH2UZHazJHBuWisp7JuQJHVG2oIqbzkFhkn0rXELxgQ
	 G5R2uXqeV+zN1N3MbpQSqsOz423fo50SAHbHP+2ItzD+9au1VGqrk1k75NPAJTT5W6
	 a5dtFwkf8kHu8bKIMmoVrmyPeAFAVOL8jRwfiSy59udfUX15cAKoa66i9Yubaj/seC
	 pqwSXow7WXuXHh7C2c8AaJCjpEyyuX9C4aZ5OnW5G8IQzKK6ZGnd+8TOzeomNgKUhB
	 FXN8ufRsme/VIWKSsFeAjINnzFaji1xRpNpvBZkHhJFNtc3Jkqd1zfVP2Xer3tFtHc
	 ViUBKDhj5lm/w==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: use printk_ratelimited to avoid redundant logs
Date: Wed, 24 Jan 2024 22:45:06 +0800
Message-Id: <20240124144506.15052-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use printk_ratelimited() instead of f2fs_err() in f2fs_record_stop_reason(),
and f2fs_record_errors() to avoid redundant logs.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e2c066fbc0fa..7e437aea268e 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4091,7 +4091,9 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 
 	f2fs_up_write(&sbi->sb_lock);
 	if (err)
-		f2fs_err(sbi, "f2fs_commit_super fails to record err:%d", err);
+		printk_ratelimited(
+			"%sF2FS-fs (%s): f2fs_commit_super fails to record stop_reason, err:%d\n",
+			KERN_ERR, sbi->sb->s_id, err);
 }
 
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
@@ -4134,8 +4136,9 @@ static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
 
 	err = f2fs_commit_super(sbi, false);
 	if (err)
-		f2fs_err(sbi, "f2fs_commit_super fails to record errors:%u, err:%d",
-								error, err);
+		printk_ratelimited(
+			"%sF2FS-fs (%s): f2fs_commit_super fails to record errors:%u, err:%d\n",
+			KERN_ERR, sbi->sb->s_id, error, err);
 out_unlock:
 	f2fs_up_write(&sbi->sb_lock);
 }
-- 
2.40.1


