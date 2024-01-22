Return-Path: <linux-kernel+bounces-33212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0DD836653
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58638B268AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5722540C12;
	Mon, 22 Jan 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMAvz396"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9058940BF0;
	Mon, 22 Jan 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935372; cv=none; b=HkmKG4OF4Q3EueomDLJyIEB5KgQP9xGvNSkvjJbNUWVJ9dubZDpFiNT1ZEmzep2TWI2N/jPOXz94JKEkaXx4ty0d/KEQty0F1wiwyfID8n/Eh0V/FRvEWcc928R0j/ZpIhvkObQrC7x+2r3e6mmptiOMKVff9+HHka1YDrok4JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935372; c=relaxed/simple;
	bh=5aC+nKOs0GKiXSpHw8goFRw1kFLdMGqnZlrxfkFtfGg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HVG4dKLeCTnvZMlgrlfROJQ3X1P/gZxa9uEIIfaJK9dJodTixBU0EtrlmDxnzwtWxnuUAtlEHKKWahSwzL6zK72AZDKeDoZmtQsmrVqlrmtzZt1jtLTWHGtAbwtXylQBic0do/jni60JsGNEfDxChW6aOy9noCb2O3j3wPd4E/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMAvz396; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3334FC43394;
	Mon, 22 Jan 2024 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935372;
	bh=5aC+nKOs0GKiXSpHw8goFRw1kFLdMGqnZlrxfkFtfGg=;
	h=From:To:Cc:Subject:Date:From;
	b=GMAvz396rabWS2yx7WzoDh5TzDMUrStOmRZiprdW9HUWZLyaWf9s85Nch7TMno/cj
	 YumfIP0/lotl/uyU5hxokT53ck5m7nYjaEyMPMFB8ZTkbUp554eQJsQbW3iTO0tUoM
	 PMc1IgVzfYGFI4FgKM8wsMbsWVc9n/aj3OLawphLatbWjA5eyad1iHzjgGNbEISatm
	 0hJfT9ZncUriB7FMdaLGutGca47mYbyTJ3QM+TBgeL3G1z2gA7LYvdWM5KU75dF8IC
	 Boqqbu8GBq8ul/RntzvC6HqlXAji4qIbkEUw1MrObXAjfMyOUIrjx8rAS6MueD6egH
	 lRgQ9oTMNxqKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH AUTOSEL 6.7 01/88] f2fs: fix to check return value of f2fs_reserve_new_block()
Date: Mon, 22 Jan 2024 09:50:34 -0500
Message-ID: <20240122145608.990137-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 956fa1ddc132e028f3b7d4cf17e6bfc8cb36c7fd ]

Let's check return value of f2fs_reserve_new_block() in do_recover_data()
rather than letting it fails silently.

Also refactoring check condition on return value of f2fs_reserve_new_block()
as below:
- trigger f2fs_bug_on() only for ENOSPC case;
- use do-while statement to avoid redundant codes;

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index b56d0f1078a7..16415c770b45 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -712,7 +712,16 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		 */
 		if (dest == NEW_ADDR) {
 			f2fs_truncate_data_blocks_range(&dn, 1);
-			f2fs_reserve_new_block(&dn);
+			do {
+				err = f2fs_reserve_new_block(&dn);
+				if (err == -ENOSPC) {
+					f2fs_bug_on(sbi, 1);
+					break;
+				}
+			} while (err &&
+				IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
+			if (err)
+				goto err;
 			continue;
 		}
 
@@ -720,12 +729,14 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
 		if (f2fs_is_valid_blkaddr(sbi, dest, META_POR)) {
 
 			if (src == NULL_ADDR) {
-				err = f2fs_reserve_new_block(&dn);
-				while (err &&
-				       IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION))
+				do {
 					err = f2fs_reserve_new_block(&dn);
-				/* We should not get -ENOSPC */
-				f2fs_bug_on(sbi, err);
+					if (err == -ENOSPC) {
+						f2fs_bug_on(sbi, 1);
+						break;
+					}
+				} while (err &&
+					IS_ENABLED(CONFIG_F2FS_FAULT_INJECTION));
 				if (err)
 					goto err;
 			}
-- 
2.43.0


