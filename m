Return-Path: <linux-kernel+bounces-115799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E568897FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49751C3120F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E539A3736C1;
	Mon, 25 Mar 2024 03:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzNoI+Ly"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1478B1448E5;
	Sun, 24 Mar 2024 23:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321987; cv=none; b=I3rTV07d1ZNZNIFQwZiN/T+Rvj60R8v/m304UodNLIG/WAkFgfaCss2aEIsE8dQQKapLr1e3pVS5RsQfeHGvjqXO0aTWAD+2DX2Sd3Ytby1KsrRJe/jUBD9jAb/KHdyT+mn/x9I791uva05Uz2D8oiz3EPZHU7sOuoRKBDjoElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321987; c=relaxed/simple;
	bh=mucHz+Zr6Fkl4kHASezKHfkPzv7eULYOavvfoTfoUzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uj2Cgshvg0WUf8qkzL0Oa2IFDL7zcMrwvUnihbcQVXpu3NmerCGfZVwOqa1n+898rUy4WKrBLBU887fQSd39g6hf6KuLAtSLipu9rIPhPfTBJe/IqxijMHcDo7YjGqdJQGlPH8uTsECNYqFtjrGLV6R33HieXPOan0rKCTGY1lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzNoI+Ly; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD916C43394;
	Sun, 24 Mar 2024 23:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321986;
	bh=mucHz+Zr6Fkl4kHASezKHfkPzv7eULYOavvfoTfoUzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fzNoI+Lyo3qVE8rzxc9I1/yeNblOnD1veY4nKpgL6yr1SpLBv3i2eWF9e2OUCVbuk
	 TrPw+4ZwkrYANl9yMmRgI49bZ3sxj7gjciOOYJDgJ3sa62whu5fJb4ygteC1mfp/GL
	 pPkgz3DBWGZpDef5DxTtcK3szQw633TJ4x1yyUfQnrIt55PW1hBPEKcmRs9iewO/KA
	 KCO14j+S/d/NvcRfQ8ilwqcPG9RPThT3Ft6kUd/XiRQABh6tSLLILQryo6sjrxECoq
	 iC0A1a+KmT+r5LshB3rzcUydxGbz/8x1Z03F4TO2dxCGtbU2eIMYZ1OPPt3WntdIuB
	 T3Kold60e4EJw==
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
Subject: [PATCH 6.1 059/451] fs: Fix rw_hint validation
Date: Sun, 24 Mar 2024 19:05:35 -0400
Message-ID: <20240324231207.1351418-60-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 146c9ab0cd4b7..0964e5dbf0cac 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -267,7 +267,7 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 }
 #endif
 
-static bool rw_hint_valid(enum rw_hint hint)
+static bool rw_hint_valid(u64 hint)
 {
 	switch (hint) {
 	case RWH_WRITE_LIFE_NOT_SET:
@@ -287,19 +287,17 @@ static long fcntl_rw_hint(struct file *file, unsigned int cmd,
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


