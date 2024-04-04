Return-Path: <linux-kernel+bounces-132059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7470898F3A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 21:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26931C26F8C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3DE134435;
	Thu,  4 Apr 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sBVqG7gi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA0874C14
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 19:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712260380; cv=none; b=F4m1oEqXRJRwjIAPD9swIgti8N8Myh9iBVrXH9R9LU1YLnfm4axDCcynd5AP0dfNTJ0LWt99caJKnloIwxoG+DYWuKx6rVcyeAqFSByoCaBJwQVN2SxbCJWt6eXHHG6lM3WZoAFEl0TlnuSZ/w3KBZmfZCvgGKHwFytCf5wSCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712260380; c=relaxed/simple;
	bh=ieg3chWZv+yjKObSx+3pR+vukItMhYCKSo8GVacn5UQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pTiSQME3jNapKm70F3tyEHJW5y00BTnkKFrvMrsceuhF1RKZIcps+3sR+tvdCDi6/XneIl4rpxtDHmzPQo+xqoKZzc8YxgasiI1xKyfqtihzLt+jY0BmW0tSudmaWgLrYZTtbLDrQKg9DXPnaRU+YqDjQcJZb+rb/5oaQ/AisIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sBVqG7gi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78796C43390;
	Thu,  4 Apr 2024 19:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712260379;
	bh=ieg3chWZv+yjKObSx+3pR+vukItMhYCKSo8GVacn5UQ=;
	h=From:To:Cc:Subject:Date:From;
	b=sBVqG7gizLXMXmHsu/0hQ7s1fzGrQCPlyq+YBxYYu8hqF/k9B2fd1V8gu39r52jj9
	 zULIHj0khYLtaVIZc2wjgOuDKJMFbaMpaYTxplMkh215mWwHdnkNA7SXjvqphMdJpP
	 3/P93Z2MZc8lY+8zNrINgnXr70YuVkPC1jdlYuyyElqdLXCttoUHxJzTdLAKthXU+V
	 +lZsDY/lEgUBGvA+xDzQwWFBfhSwLDoIxRKh37x82QKqRjilOEEPo6Wkwvl16Z+Y2/
	 cTMuuk6wM2v1r7vb95eiIzypYs+vCyqplg3vkFxBIg612uWn+AOK62qM00lw97j+vE
	 uKJFzRlYpzCVA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	=?UTF-8?q?Light=20Hsieh=20=28=E8=AC=9D=E6=98=8E=E7=87=88=29?= <Light.Hsieh@mediatek.com>
Subject: [PATCH] f2fs: don't set RO when shutting down f2fs
Date: Thu,  4 Apr 2024 19:52:54 +0000
Message-ID: <20240404195254.556896-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Shutdown does not check the error of thaw_super due to readonly, which
causes a deadlock like below.

f2fs_ioc_shutdown(F2FS_GOING_DOWN_FULLSYNC)        issue_discard_thread
 - bdev_freeze
  - freeze_super
 - f2fs_stop_checkpoint()
  - f2fs_handle_critical_error                     - sb_start_write
    - set RO                                         - waiting
 - bdev_thaw
  - thaw_super_locked
    - return -EINVAL, if sb_rdonly()
 - f2fs_stop_discard_thread
  -> wait for kthread_stop(discard_thread);

Reported-by: "Light Hsieh (謝明燈)" <Light.Hsieh@mediatek.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/super.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index df9765b41dac..ba6288e870c5 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4135,9 +4135,16 @@ void f2fs_handle_critical_error(struct f2fs_sb_info *sbi, unsigned char reason,
 	if (shutdown)
 		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
 
-	/* continue filesystem operators if errors=continue */
-	if (continue_fs || f2fs_readonly(sb))
+	/*
+	 * Continue filesystem operators if errors=continue. Should not set
+	 * RO by shutdown, since RO bypasses thaw_super which can hang the
+	 * system.
+	 */
+	if (continue_fs || f2fs_readonly(sb) ||
+				reason == STOP_CP_REASON_SHUTDOWN) {
+		f2fs_warn(sbi, "Stopped filesystem due to readon: %d", reason);
 		return;
+	}
 
 	f2fs_warn(sbi, "Remounting filesystem read-only");
 	/*
-- 
2.44.0.478.gd926399ef9-goog


