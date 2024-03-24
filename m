Return-Path: <linux-kernel+bounces-114464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4247888A9D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 756D31F25CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E70317C19B;
	Sun, 24 Mar 2024 23:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UqjgttIo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D34220982;
	Sun, 24 Mar 2024 23:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321887; cv=none; b=QEJvscS0+6s0ZkEy2yiMLsXmqpBuMuqMY/B7lRLt3tNS4POMVl+ddE5SPjEdHsb3kUjW8eHTCTymgMeuIaSqm2BiEA790KHbZNKTCkVpTNMdYrFP19KWSyYFyTxlLrLSWIiH/KEojxD3sW/CkbmP6Ou3tQeZnHtaTm1tTxcZlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321887; c=relaxed/simple;
	bh=Ls2/MLqVo8XkIUPGIM99iciRPcSQ/fnqZvLaX8OkTtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uln0zWygtHCeh11lskDxktvTJUJvYlED8NtKYMaY8I7Xv+kEaxFMMzlv0bQsuLUNuAzT8KKoEq64kx0JZGANkdfqgzcD0Mx5ShVfM+1fENLf1wv7M19rXjNn5/CvzhRBiRUFJvYP0fTfex/GkfA9HBNLvk/xLURvwJ9n24806XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UqjgttIo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A28C433C7;
	Sun, 24 Mar 2024 23:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321885;
	bh=Ls2/MLqVo8XkIUPGIM99iciRPcSQ/fnqZvLaX8OkTtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UqjgttIoWnSqjct5GhYHreXSuSx/e0zEu8Y0370eLwd9It0lYrVDG50cdSaLlfRqK
	 EXNFAt4sUnlfFrq9UESJhc/Ck5vuLsn7gbsv+tI1EhKGtkFmVIwVZRYvy1RqLrijCc
	 +s6/WR3hXz9iES1VwDn45VYaflOlGV/oSSw6q4mt5Zkl4+f6/qfc0+66ZRThwXQ/59
	 2tB9taqmi0qVcTki4wwWCtQrvK5oJU4/dwabcxuYd0goy0WlhV9M2QnPCu4eAue4cY
	 bT5WYM3OvKmoUP5pw1Wubqib/CDhc4+RhDHCDw/T3wmqZvSE0osO0iSu36/SJoG8Qe
	 hEGxevUQYPr8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Frank Hsiao <frankhsiao@qnap.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 613/638] ceph: stop copying to iter at EOF on sync reads
Date: Sun, 24 Mar 2024 19:00:50 -0400
Message-ID: <20240324230116.1348576-614-sashal@kernel.org>
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

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 1065da21e5df9d843d2c5165d5d576be000142a6 ]

If EOF is encountered, ceph_sync_read() return value is adjusted down
according to i_size, but the "to" iter is advanced by the actual number
of bytes read.  Then, when retrying, the remainder of the range may be
skipped incorrectly.

Ensure that the "to" iter is advanced only until EOF.

[ idryomov: changelog ]

Fixes: c3d8e0b5de48 ("ceph: return the real size read when it hits EOF")
Reported-by: Frank Hsiao <frankhsiao@qnap.com>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Frank Hsiao <frankhsiao@qnap.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/file.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index b5f8038065d7c..bdd0a3b894b7b 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1108,7 +1108,12 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 		}
 
 		idx = 0;
-		left = ret > 0 ? ret : 0;
+		if (ret <= 0)
+			left = 0;
+		else if (off + ret > i_size)
+			left = i_size - off;
+		else
+			left = ret;
 		while (left > 0) {
 			size_t plen, copied;
 
@@ -1137,15 +1142,13 @@ ssize_t __ceph_sync_read(struct inode *inode, loff_t *ki_pos,
 	}
 
 	if (ret > 0) {
-		if (off > *ki_pos) {
-			if (off >= i_size) {
-				*retry_op = CHECK_EOF;
-				ret = i_size - *ki_pos;
-				*ki_pos = i_size;
-			} else {
-				ret = off - *ki_pos;
-				*ki_pos = off;
-			}
+		if (off >= i_size) {
+			*retry_op = CHECK_EOF;
+			ret = i_size - *ki_pos;
+			*ki_pos = i_size;
+		} else {
+			ret = off - *ki_pos;
+			*ki_pos = off;
 		}
 
 		if (last_objver)
-- 
2.43.0


