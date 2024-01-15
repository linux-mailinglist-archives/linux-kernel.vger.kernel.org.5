Return-Path: <linux-kernel+bounces-26583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D29A382E3D5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76DEE1F24816
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED051C6BA;
	Mon, 15 Jan 2024 23:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3uCDLch"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3281B94F;
	Mon, 15 Jan 2024 23:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420F8C433C7;
	Mon, 15 Jan 2024 23:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705361301;
	bh=y85cnKH5QAAhRgBFfPMsEGMGsxfCej+YC/AocRD+Lag=;
	h=From:To:Cc:Subject:Date:From;
	b=B3uCDLchDpdZ5Nl3KBdRgfu7hNunkdboVORoloXZujuIB33IDNVk/adGmgfSsRc1K
	 iT/h9TDTdMAesqHCxefcJbbJCdxv2SoE8M99d0N9VOwnET7XaFR7Q3+bAwZUeBNcfF
	 tWG2lz7UngF/hMgt06g1i6tQkRbvQLoyVQCqN9BIavYI6EgXlCcKhv+ucfB5GubKyx
	 AUgD7cfGJgBCqQZyky/OQ5GPcaAkfTdf5PvPv2q9vQXF53TaEU4IPTHC0IbemVMKcv
	 fKohPLwaeIhW84UYA4O/V4jBGfhjEax4vizBRpLfrnlsPRKecB6vOj7N7K4SM1UnZx
	 0V8ynB4kL8/BA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	zack.rusin@broadcom.com,
	mcgrof@kernel.org,
	pstanner@redhat.com,
	nick.alcock@oracle.com,
	code@siddh.me,
	ddiss@suse.de
Subject: [PATCH AUTOSEL 5.10 01/10] watch_queue: fix kcalloc() arguments order
Date: Mon, 15 Jan 2024 18:27:50 -0500
Message-ID: <20240115232818.210010-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 73717917d816..5f15a921a8d0 100644
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


