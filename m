Return-Path: <linux-kernel+bounces-41764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7CD183F775
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CA4D1F21240
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BB06D1DB;
	Sun, 28 Jan 2024 16:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7WGDK4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B7E6D1C7;
	Sun, 28 Jan 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458481; cv=none; b=jJutZwGsRNNgaYuivaCcwe6DjNZAfdfKPhILV/CkoMuMHPSaiR0JTJEzNVS1hN2K/s3VYi3OJlAPW06qq1GJrvh5+IxKAjC65XBN90V5b0F0k+0IlaBZ1P7PwoCmPbumov+5PeCWEFZUL4aD2KxAQ0wlMfDUEBRSUEhqJY3w+kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458481; c=relaxed/simple;
	bh=EAQK+pmAxemO5p2IYX5ZtBkQUnczClZcU2V0gohHe5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wj8vBn4YuwEgyU9xH5xF5sSDzHM0sRhMgbhULthPs7HTM6kkvQ0dBRDN+VONvTQAPSwSBI02KjYljtONEzzr1XhGgxWrYUD9ngZ5tkDU8lWv66E0vup/fVqtbDLun5m+0f4yuuNUhzl4uHenpff1DJRNncpaM2B8LY5yZogo5AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7WGDK4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E34B7C433C7;
	Sun, 28 Jan 2024 16:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458481;
	bh=EAQK+pmAxemO5p2IYX5ZtBkQUnczClZcU2V0gohHe5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g7WGDK4ZJfaYndt9TP2vskFjHdORXQfG0x4HxITtPNSIQV5R5+yErpT4oJoJ3r0Ql
	 jCkFnHDay5+FzLN1kc7VlaDsByg9RzWILPN/JHOqnmAr1uswVBcSs3Ww+fD3+rO/Bw
	 XW2e5Qvqmpd+iW4EKTHc9+gXq2i8Kn6eZ0qa0CHRSYIRyIbmsHh4uDyKP1flWs7cds
	 u9kSRJt1kn6XkBpq1mKS9+x+PK2PFR/iVkruwI3yW0eXTBfgBMip0tP3IX9uRjYVrk
	 m+g7UxI9j/Zcdmt2Fblvqg496x/cTjLN13RUwc5sEfyatloDzvObGuff6znjaVAmCn
	 QnmSxUz3hU0jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	Tejun Heo <tj@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 09/27] fs/kernfs/dir: obey S_ISGID
Date: Sun, 28 Jan 2024 11:13:54 -0500
Message-ID: <20240128161424.203600-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
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
index 44842e6cf0a9..a00e11ebfa77 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -669,6 +669,18 @@ struct kernfs_node *kernfs_new_node(struct kernfs_node *parent,
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


