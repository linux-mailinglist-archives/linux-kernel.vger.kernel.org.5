Return-Path: <linux-kernel+bounces-26846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A69982E6DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C1D4284E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BFB22319;
	Tue, 16 Jan 2024 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mkhrNxl1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53198208BC;
	Tue, 16 Jan 2024 01:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5E9C433F1;
	Tue, 16 Jan 2024 01:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367171;
	bh=RqhjB69RblzpblVNXf0+MpdYnaiOYIRtCEhaG505RBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mkhrNxl1xemrVzwWXhnXVZNHBoKpawCFBjtQxhG/XOqNzHlVAArTiLGFI4Ajl6a7S
	 EFsh6v6MgKwQ093EyIt9ciNJEfEAPUyczj2O8UyJ777LOlSSoub4y0ZaL8baqgbWCB
	 ZUkKvHmS5gFsEmWjQlbL4YfglvjZhe5qA/vG9d7nA8O0BLeVK0RmEzeocGxuewxaYw
	 eKheSFXIv+Z7mNC2bFYezx2KvioGNwBn/m0+9WUirwv5P893F2jue7mUupukU8w3f2
	 KphRR1h1tQ7VVM1nRwsjGTIvpAGeOWfNmD1nyr07gdKAATzK9OjeZqarMVrsJhchpD
	 22I2KMWY4h9sg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriel Krisman Bertazi <krisman@suse.de>,
	Eric Biggers <ebiggers@google.com>,
	Sasha Levin <sashal@kernel.org>,
	code@tyhicks.com,
	brauner@kernel.org,
	dchinner@redhat.com,
	jack@suse.cz,
	jlayton@kernel.org,
	xiubli@redhat.com,
	stefanb@linux.ibm.com,
	viro@zeniv.linux.org.uk,
	ecryptfs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 15/19] ecryptfs: Reject casefold directory inodes
Date: Mon, 15 Jan 2024 20:05:10 -0500
Message-ID: <20240116010532.218428-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@suse.de>

[ Upstream commit cd72c7ef5fed44272272a105b1da22810c91be69 ]

Even though it seems to be able to resolve some names of
case-insensitive directories, the lack of d_hash and d_compare means we
end up with a broken state in the d_cache.  Considering it was never a
goal to support these two together, and we are preparing to use
d_revalidate in case-insensitive filesystems, which would make the
combination even more broken, reject any attempt to get a casefolded
inode from ecryptfs.

Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ecryptfs/inode.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 5ab4b87888a7..795e9fe2f721 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -78,6 +78,14 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 
 	if (lower_inode->i_sb != ecryptfs_superblock_to_lower(sb))
 		return ERR_PTR(-EXDEV);
+
+	/* Reject dealing with casefold directories. */
+	if (IS_CASEFOLDED(lower_inode)) {
+		pr_err_ratelimited("%s: Can't handle casefolded directory.\n",
+				   __func__);
+		return ERR_PTR(-EREMOTE);
+	}
+
 	if (!igrab(lower_inode))
 		return ERR_PTR(-ESTALE);
 	inode = iget5_locked(sb, (unsigned long)lower_inode,
-- 
2.43.0


