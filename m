Return-Path: <linux-kernel+bounces-26571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7B082E3B6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC0E1C22179
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108F11C281;
	Mon, 15 Jan 2024 23:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opdx5ahX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDC71B7E3;
	Mon, 15 Jan 2024 23:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB2EC433C7;
	Mon, 15 Jan 2024 23:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361241;
	bh=4k9GUBLYvchpOD/KUw5lkivxzcmbwmvaOSYuP68VHJU=;
	h=From:To:Cc:Subject:Date:From;
	b=opdx5ahXb2bx37XjH6fF3x9WzUT0tKbz9MG9b81Bu+WHWkZM5E3Gc6UT4lsVjW+A6
	 +AK6IgGtO/+xsMf1jb/yW28KUr67rFINhNxE0WdBO4b7jI2heLB2/+AI7zEQSxaeOI
	 N10qTw/CvBMDXFjyHrZ6YfEtjQnnEDFZmQ1lmRz8AS9jd5+0DVMM9S529p9pF+t//u
	 VMMqHcmS2Mas3FYnWi7Tyon28Pk3eO9W6JikVg6TAyKoN2VDU/8fcAp9URUFZfp1UH
	 kr2byTPk/MYa8+O6dH2nN76H3SDoujzntF/XSamRh2Qr3m4fXdHGSAidmFUJvneOot
	 D/TJT3A5zZtJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	airlied@redhat.com,
	code@siddh.me,
	mcgrof@kernel.org,
	pstanner@redhat.com,
	ddiss@suse.de,
	nick.alcock@oracle.com
Subject: [PATCH AUTOSEL 5.15 01/12] watch_queue: fix kcalloc() arguments order
Date: Mon, 15 Jan 2024 18:26:46 -0500
Message-ID: <20240115232718.209642-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit 1bfc466b13cf6652ba227c282c27a30ffede69a5 ]

When compiling with gcc version 14.0.0 20231220 (experimental)
and W=1, I've noticed the following warning:

kernel/watch_queue.c: In function 'watch_queue_set_size':
kernel/watch_queue.c:273:32: warning: 'kcalloc' sizes specified with 'sizeof'
in the earlier argument and not in the later argument [-Wcalloc-transposed-args]
  273 |         pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
      |                                ^~~~~~

Since 'n' and 'size' arguments of 'kcalloc()' are multiplied to
calculate the final size, their actual order doesn't affect the
result and so this is not a bug. But it's still worth to fix it.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Link: https://lore.kernel.org/r/20231221090139.12579-1-dmantipov@yandex.ru
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index ae31bf8d2feb..bf86e1d71cd3 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -275,7 +275,7 @@ long watch_queue_set_size(struct pipe_inode_info *pipe, unsigned int nr_notes)
 		goto error;
 
 	ret = -ENOMEM;
-	pages = kcalloc(sizeof(struct page *), nr_pages, GFP_KERNEL);
+	pages = kcalloc(nr_pages, sizeof(struct page *), GFP_KERNEL);
 	if (!pages)
 		goto error;
 
-- 
2.43.0


