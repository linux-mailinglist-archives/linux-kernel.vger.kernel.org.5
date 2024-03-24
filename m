Return-Path: <linux-kernel+bounces-112900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EEBE887F9A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11761C2115C
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D86055E4B;
	Sun, 24 Mar 2024 22:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjrBFK2j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A1554916;
	Sun, 24 Mar 2024 22:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319710; cv=none; b=PCHd4/JWZPQmj1mhmiyaKY4JIsrMRWMrxn6R1aFJJ4RLnzR0HaHp91lEvp14YfB7tC8WdtvqRhuq2R5jinOtDYEYHUVXOEjSP5VqRU2QTlWVfhCrMW1urrgzsIbX2m8JLXd+CwQ8UvRnX9Rl5cHo9N+Upxmz7hztJpoz1T1pVbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319710; c=relaxed/simple;
	bh=76vkGyrV3hb3aWyw3PS3hSUigT9JbLaVi74F4EZkltQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5s2qc38bKclZY4z5PJiZWc0cmYrxoK1NhFwnU2li7D3TFG3qFpAcCAmrjBHKxQe0f/07a3z9cgTSrfI02JCQ2cav/TkQUNmSLJCk0yLjM0DcnlYbds5XtfjUW6TEqS6IVp3Osaxx5wmMt1Z8fw+raBLQUk9sWK5u9pPD2+53mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjrBFK2j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C28C433F1;
	Sun, 24 Mar 2024 22:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319710;
	bh=76vkGyrV3hb3aWyw3PS3hSUigT9JbLaVi74F4EZkltQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KjrBFK2jOlWhfJ0YF1t2+n+lPhqZGV6fseqd2hDAv1HlOEm2++2m94rhNqpI+mkYg
	 dXDcWyI7pdPVKmdm7c2A26jF2+YWjC4Kmf8kVdvuRjE+A6pe1VoBa4xoKpdvhn+B7Z
	 g2L74Nnfp4PNhII0FUvej4HfHNVx9tRyjZ/GlKwrBsgk6CI9qqbXOamjTF+mqJlggV
	 REYpjTrhSfQkHy2+98Xjp26OfeoNCIhvlYQ5wBPSXRo64VAE+BB0yKlyTUT7xtj3F7
	 mG+iISNIhrGlpLKwLodVeFLHbFCasZPyQ9Kvh1t9kve7JdFBfLhcDGgWZWEWinMVt7
	 QI31NR2mY4U8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Jens Axboe <axboe@kernel.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 013/715] fs: Fix rw_hint validation
Date: Sun, 24 Mar 2024 18:23:12 -0400
Message-ID: <20240324223455.1342824-14-sashal@kernel.org>
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

From: Bart Van Assche <bvanassche@acm.org>

[ Upstream commit ec16b147a55bfa14e858234eb7b1a7c8e7cd5021 ]

Reject values that are valid rw_hints after truncation but not before
truncation by passing an untruncated value to rw_hint_valid().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Fixes: 5657cb0797c4 ("fs/fcntl: use copy_to/from_user() for u64 types")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Link: https://lore.kernel.org/r/20240202203926.2478590-2-bvanassche@acm.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fcntl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index c80a6acad742f..3ff707bf2743a 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -268,7 +268,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(enum rw_hint hint)
+static bool rw_hint_valid(u64 hint)
 {
 	switch (hint) {
 	case RWH_WRITE_LIFE_NOT_SET:
@@ -288,19 +288,17 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
 {
 	struct inode *inode = file_inode(file);
 	u64 __user *argp = (u64 __user *)arg;
-	enum rw_hint hint;
-	u64 h;
+	u64 hint;
 
 	switch (cmd) {
 	case F_GET_RW_HINT:
-		h = inode->i_write_hint;
-		if (copy_to_user(argp, &h, sizeof(*argp)))
+		hint = inode->i_write_hint;
+		if (copy_to_user(argp, &hint, sizeof(*argp)))
 			return -EFAULT;
 		return 0;
 	case F_SET_RW_HINT:
-		if (copy_from_user(&h, argp, sizeof(h)))
+		if (copy_from_user(&hint, argp, sizeof(hint)))
 			return -EFAULT;
-		hint = (enum rw_hint) h;
 		if (!rw_hint_valid(hint))
 			return -EINVAL;
 
-- 
2.43.0


