Return-Path: <linux-kernel+bounces-40259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A45C83DD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADC221C21B98
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01281D559;
	Fri, 26 Jan 2024 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/lKFtS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4033B1D526
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706282394; cv=none; b=f1aAmN/u1LXpvqaCE0ZUNit24G3CdH5MuB8Np5FgqGBSZmnowOxvQMW7roXUrIsbov0Oid1Zfo8eP/CrJTy4tj+IqJc7Tvw6LX69loHGzQWDeFTckhHtwsSyD//CphzN7X0Jt1DeJO8RzVP/oDvqdIVqxjvu+gGUD+TVmUdQuHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706282394; c=relaxed/simple;
	bh=ZtyUk0RkyPEdvpNQ+7kxFdt/jzM49VUpcfVYCbc7d8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CDj1QtY3sqMxs+izZ8ILR5AaN4NetqiVleIt67xntig4e8NdvKNMTI3N1RILB7l1z14mlrMQQO/FlqwcVl6KZWs94JXv8+LhPMvx1UGI4GC6hWG3472mRMw6DGZ23r80QLGjFVl4kZjm2lr2tDjD4gRVy0pqab8DLr0lAj/viK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/lKFtS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B34C43399;
	Fri, 26 Jan 2024 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706282393;
	bh=ZtyUk0RkyPEdvpNQ+7kxFdt/jzM49VUpcfVYCbc7d8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/lKFtS3SEBsyc03ZV7lLYkFi7Cr7qlb5YWRz43hAwGBNPt3Kjc5KNU4hXm9cu24D
	 yMTnqZ2kDFrriyvoFvFzuuzbBs0TleEH5Be+MCoSXV5vwHBBa08hYHCH2zfsUAHyYj
	 MY1DiabtwZ+a5vBOTjaTr00oomXPvw299JQQ+sB0kdaK8DArWPhf8gPgPsqaVKU4rq
	 bbvuGIHaRWFXy5Q6WHapuuu4sQm4THUn37/NWxyC3qRijDH2nZ/zWQzadplq8C1EQp
	 27hwuh4uyKULz44GQHDp2S/f8emx5w0se1Ne2KyNZnrsFWTbm4Q6CbNmO8GEcpVlOA
	 Ff9xNb3BzlMRA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: use f2fs_err_ratelimited() to avoid redundant logs
Date: Fri, 26 Jan 2024 23:19:17 +0800
Message-Id: <20240126151917.837565-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240126151917.837565-1-chao@kernel.org>
References: <20240126151917.837565-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use f2fs_err_ratelimited() to instead f2fs_err() in
f2fs_record_stop_reason() and f2fs_record_errors() to
avoid redundant logs.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4ca390363131..f0fa76d227e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4096,7 +4096,9 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 
 	f2fs_up_write(&sbi->sb_lock);
 	if (err)
-		f2fs_err(sbi, "f2fs_commit_super fails to record err:%d", err);
+		f2fs_err_ratelimited(sbi,
+			"f2fs_commit_super fails to record stop_reason, err:%d",
+			err);
 }
 
 void f2fs_save_errors(struct f2fs_sb_info *sbi, unsigned char flag)
@@ -4139,8 +4141,9 @@ static void f2fs_record_errors(struct f2fs_sb_info *sbi, unsigned char error)
 
 	err = f2fs_commit_super(sbi, false);
 	if (err)
-		f2fs_err(sbi, "f2fs_commit_super fails to record errors:%u, err:%d",
-								error, err);
+		f2fs_err_ratelimited(sbi,
+			"f2fs_commit_super fails to record errors:%u, err:%d",
+			error, err);
 out_unlock:
 	f2fs_up_write(&sbi->sb_lock);
 }
-- 
2.40.1


