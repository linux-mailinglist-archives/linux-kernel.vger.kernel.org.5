Return-Path: <linux-kernel+bounces-41818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E487083F80B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B9F628A5F0
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88131144636;
	Sun, 28 Jan 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+VxVNV7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8223144629;
	Sun, 28 Jan 2024 16:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458605; cv=none; b=OBVSmZAESvcqo17QbCLFRpdJxnYa/ZbcNis93Bz3Z6r5VKP9lNJfjyHJkQ21yQOK9x4bs++iydHUNLw83Hb00J4rhbtpcbHHUFAllj+ncFp1hHYI4tpqCCPUF24OK0z7CFYoc9HfGoh2CkMaCvd/Fl7/xOqYSQxzB36g4Yl96E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458605; c=relaxed/simple;
	bh=TVrjnz4N4BXeetl0qonNX9Rk4p9IAvClyH7GaIBkBKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtxNCzMz0W10t8N74at3nfILYUmpY6+apgyf0xM/yLFFBbRokioLPQkjFZx8TN38Ir4MStPltatiXZFOa3tN+TR8OIf3dF/0KYN1Vbwk/hzbHprRDzvARvzoP+q2NRzzeed7Wcw8Nzl8vj4zGsLXhicY6TCK0qDo3GKOIewFw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+VxVNV7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88338C433F1;
	Sun, 28 Jan 2024 16:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458605;
	bh=TVrjnz4N4BXeetl0qonNX9Rk4p9IAvClyH7GaIBkBKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b+VxVNV77WSuGMXas77mF8GxZfpAViFVdLsarG2B9MbN9XoUgSBIa++gXGelx7aN1
	 8QDxiZe7xfAiGfytHCBLKFRoWzzU1chgP/+97GefEXBOeNEJwLxP9FGqsxUkWE+ew9
	 +2gdSS0FIQ7WAFnvyT7V8nTxeUq0SRSt/bkIjF2Vg1VnXStMzuqQEsqU9mEk7gqYRH
	 ToXusGW3yZNbU8cGncStIq61ZqxPKSMwfK58rPBa/6SCCeUENBz1LmQRWrVra+VcwE
	 OSG08/+zIHsASF/2cSRRPdkTW2nS6d57Fqo2Q9PcGvEHhJBu5wRHr3Df9G95xSa7YA
	 DqFwVv4HgZkkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 04/11] fs/kernfs/dir: obey S_ISGID
Date: Sun, 28 Jan 2024 11:16:25 -0500
Message-ID: <20240128161637.205509-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161637.205509-1-sashal@kernel.org>
References: <20240128161637.205509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Max Kellermann <max.kellermann@ionos.com>

[ Upstream commit 5133bee62f0ea5d4c316d503cc0040cac5637601 ]

Handling of S_ISGID is usually done by inode_init_owner() in all other
filesystems, but kernfs doesn't use that function.  In kernfs, struct
kernfs_node is the primary data structure, and struct inode is only
created from it on demand.  Therefore, inode_init_owner() can't be
used and we need to imitate its behavior.

S_ISGID support is useful for the cgroup filesystem; it allows
subtrees managed by an unprivileged process to retain a certain owner
gid, which then enables sharing access to the subtree with another
unprivileged process.

--
v1 -> v2: minor coding style fix (comment)

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20231208093310.297233-2-max.kellermann@ionos.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/kernfs/dir.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index d2068566c0b8..d3a602ea795b 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -702,6 +702,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
 {
 	struct kernfs_node *kn;
 
+	if (parent->mode & S_ISGID) {
+		/* this code block imitates inode_init_owner() for
+		 * kernfs
+		 */
+
+		if (parent->iattr)
+			gid = parent->iattr->ia_gid;
+
+		if (flags & KERNFS_DIR)
+			mode |= S_ISGID;
+	}
+
 	kn = __kernfs_new_node(kernfs_root(parent), parent,
 			       name, mode, uid, gid, flags);
 	if (kn) {
-- 
2.43.0


