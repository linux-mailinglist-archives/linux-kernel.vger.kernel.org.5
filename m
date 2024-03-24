Return-Path: <linux-kernel+bounces-114390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05416888A30
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9676E1F27792
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C284273D96;
	Sun, 24 Mar 2024 23:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DlOsfwok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A27218547;
	Sun, 24 Mar 2024 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321791; cv=none; b=rg7Bl7bSpo6pj4RIofOYWDsLZVrIqYQ6YWaWTUQqlL6kNqRJdz9Bh1Y/WvlaXj4riI3hqD6rxggwgX1sPKe3Xk6PptDnWTbm8xxevyTKCLy4vmkG42vE5JaP1ey4rt4r3mSx/yBHarkgnA+MQgLgzAaz5UiAOaBDFRh8Czx/Kro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321791; c=relaxed/simple;
	bh=uWN6XqGL3TzC5YSOzD2F0iscnersYTYSCVK9mXXPX2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYX3PZ8JTvO/83gLCVlu452LVNEP5ha65mIRcHnlYUh78C++Wr9+nKi08k7ZV4bhcMai91p2f5AVx86XMeW9oQs7iCSYYdI57Wue2zBqzpeYkGQ7OoDQmeQCTjU5S7d8VdzNFTQDuumEazXOjyl7xesiDldfMCAp8KMs8WnSqQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DlOsfwok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5635C433A6;
	Sun, 24 Mar 2024 23:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321790;
	bh=uWN6XqGL3TzC5YSOzD2F0iscnersYTYSCVK9mXXPX2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DlOsfwoktP4wKgJuDGXcmkcljDPIJCEjhcW08MeQiN0Oa6SmFaek6dLrTqJlCHQdK
	 q6gDHNC/bzmyRsHpUjh54hUqnySMAmmsTEasPduQ8C0HaFKs29Kofqfnlk2r6OZY2Q
	 y+uSM2weCOMQ8RkY4mZvSNyEC6CDn+pIv6Hp/d/WF+r+Zs8b2SfIn987UkIkMuC0b4
	 fUcsot/JBjXr1tZtMYsjl4/un62N2Q1SDGADkyTQXKCv0USgXGeu6ZfDN208tg4u6f
	 zf9bORmyYSyYdUB0v7UjNprc45nSYOE4vSKxFFyL8YcZm57KWIdO6kYZfIEGKcQ48t
	 QxmE6cdrOvBgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Daeho Jeong <daehojeong@google.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 518/638] f2fs: zone: fix to wait completion of last bio in zone correctly
Date: Sun, 24 Mar 2024 18:59:15 -0400
Message-ID: <20240324230116.1348576-519-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 3dcff94221695..271f5eab15db5 100644
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


