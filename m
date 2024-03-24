Return-Path: <linux-kernel+bounces-113470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860F7888494
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1801F22B93
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4936F1B3A52;
	Sun, 24 Mar 2024 22:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvNO/flA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D281B3A3A;
	Sun, 24 Mar 2024 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320271; cv=none; b=Hl13Z3jWXx2t4/gE1/UYpDHB/u+zkUm7WQN0T+RjvHnKNvynu37vGC+wLX9d9JaAzUyAFz2N0Slozqu6i5/MuzyKgIvoJ5NDVL1Z7aPfwlv5JoAoQ1G9zkXz7chc1Yejnhp1UK66hxJx8SgaVzs5A9YdN7/Ey6Q+3hON3Ifvnf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320271; c=relaxed/simple;
	bh=/2lRRt0p/PbalcosEuQoZVIl6eiZOdYACesm/oMd6JI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrAtm9Xu6fAkrv+YZUB6XREt74BYamWg2WxhHLzIVBZW8p78nGy96JMF6BgnK2xixiQQf+f+lD+8zhakUv12s192TTJZDc5YYmp4EiI4WtYxk3jL10YP4rOYEZJ85Vzwnlgkf3u3Lu0YbT3S+JLD1uAZ6t+z1kthNozNs5EeeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvNO/flA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86077C433C7;
	Sun, 24 Mar 2024 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320271;
	bh=/2lRRt0p/PbalcosEuQoZVIl6eiZOdYACesm/oMd6JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvNO/flAMfQ6ceQDE23axozg/oBl2RUOaxCR6/ZqLRJ52NaXxqq5XuWA9GZsc+q5a
	 Kgn0LTjypfUsK6uJaGkP+udCFiqC6zgVI9OLtGw7VkE5qD5yitcbC7kLkAjiwJ8xRE
	 k3pxkugbGzAnedX7mVIE2hoAk4R/9FIXpsZOfKDOGbEkaYCRNnyLAlnp5OHX4Ictyf
	 mM7gRvG377HCBAqZCUzwo95p1O48PHqlqCgu6WiLDXwVT9VG2yI1AbGQLS3yfLMWw3
	 Z84Tj6KNQ56rO1Pr1THKkG6ODSxPGyjKd+pSf+/v8+34DSDzWABdm9z2BNwf+evkaV
	 JKLYl/kd9cCyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 579/715] f2fs: compress: fix to check compress flag w/ .i_sem lock
Date: Sun, 24 Mar 2024 18:32:38 -0400
Message-ID: <20240324223455.1342824-580-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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

[ Upstream commit ea59b12ac69774c08aa95cd5b6100700ea0cce97 ]

It needs to check compress flag w/ .i_sem lock, otherwise, compressed
inode may be disabled after the check condition, it's not needed to
set compress option on non-compress inode.

Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/file.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1ff1c45e19271..caab20648b951 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3994,16 +3994,20 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 				sizeof(option)))
 		return -EFAULT;
 
-	if (!f2fs_compressed_file(inode) ||
-			option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
-			option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
-			option.algorithm >= COMPRESS_MAX)
+	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+		option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
+		option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
 
 	file_start_write(filp);
 	inode_lock(inode);
 
 	f2fs_down_write(&F2FS_I(inode)->i_sem);
+	if (!f2fs_compressed_file(inode)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (f2fs_is_mmap_file(inode) || get_dirty_pages(inode)) {
 		ret = -EBUSY;
 		goto out;
-- 
2.43.0


