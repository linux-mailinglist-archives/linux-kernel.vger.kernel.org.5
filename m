Return-Path: <linux-kernel+bounces-113920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 035F3888EDB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B3C1C29534
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8EAE214106;
	Sun, 24 Mar 2024 23:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o6JxXBvt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801A01EE687;
	Sun, 24 Mar 2024 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321013; cv=none; b=eKCcZsIfNsM8+Nre0ve/zrZe6QLefq9R4FixVclloprAy93EznmRFGE5oYHn1374wS+Mlp5f6BWhXFavk9Gzq464/ToRwcA/V1wozHYm9X9gLQLaKEZ6YlnwyygEDx0YfpEMfqGGf6t4aHBOoRiWn7HeEBM2L0e5ZqTBLRx0xQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321013; c=relaxed/simple;
	bh=sc48ERtTTU0b8gYTul/PEN+dkQ0Jo7sKqaYgyeRyucg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKpTnV52BflJLcdyzGmtQ5mWzBvZPCN8pe/ZwW24OThAK0UHKLIpHkWepmWPaAcxwjjxHO3J3Vk5xWGtX+uQUz3amOFrEb37Tojo8hwtZ3pw97i7oLc0DIyEJNxe3tTLLuR434OyxXbv9sxY+jUUhDmYp+4iw5FzupFnQut2zJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o6JxXBvt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64E6C433C7;
	Sun, 24 Mar 2024 22:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321013;
	bh=sc48ERtTTU0b8gYTul/PEN+dkQ0Jo7sKqaYgyeRyucg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o6JxXBvtxQX+Y/H7UzNDmejEhPuS/g48I8LIZGkKAKcbLEFtG1orPs86Yp8rjCHRk
	 7y84BpIJQySTyyP2+UpCu2rE6Sjy5aDx5aDdNfAG4/UKmttnlTA1Q6Q6R5ppAHoc7w
	 2TcNQwPdvav7JiSTwWOPKZHAUH9PMpEPT4H66QUwRW8/0ao5r8H3EU6AF33BHhB5BY
	 CvSY1F7pGQ7E2/6M5E3j8N3ZQDjqaQzz5jNVNYd+qGWR2l5h8yu7p/NVhyJC4VhECM
	 tQzlUXhA1JpkeuR2VKZ6gu9Q4zFyt+yuzbWKw8Ap29thDuecYM4SdYLYVYqk7zt4Gt
	 x3VHg1IfvieIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 576/713] f2fs: zone: fix to wait completion of last bio in zone correctly
Date: Sun, 24 Mar 2024 18:45:02 -0400
Message-ID: <20240324224720.1345309-577-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 536af8211586af09c5bea1c15ad28ddec5f66a97 ]

It needs to check last zone_pending_bio and wait IO completion before
traverse next fio in io->io_list, otherwise, bio in next zone may be
submitted before all IO completion in current zone.

Fixes: e067dc3c6b9c ("f2fs: maintain six open zones for zoned devices")
Cc: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 41091287f5439..cd9f1c6039c49 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1010,7 +1010,7 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	f2fs_bug_on(sbi, is_read_io(fio->op));
 
 	f2fs_down_write(&io->io_rwsem);
-
+next:
 #ifdef CONFIG_BLK_DEV_ZONED
 	if (f2fs_sb_has_blkzoned(sbi) && btype < META && io->zone_pending_bio) {
 		wait_for_completion_io(&io->zone_wait);
@@ -1020,7 +1020,6 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 	}
 #endif
 
-next:
 	if (fio->in_list) {
 		spin_lock(&io->io_lock);
 		if (list_empty(&io->io_list)) {
-- 
2.43.0


