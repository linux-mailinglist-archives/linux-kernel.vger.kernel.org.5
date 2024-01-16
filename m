Return-Path: <linux-kernel+bounces-26890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE9B82E76D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B5221C22BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482103F8CC;
	Tue, 16 Jan 2024 01:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/oaI49M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9611F3EA7A;
	Tue, 16 Jan 2024 01:08:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84379C43390;
	Tue, 16 Jan 2024 01:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367312;
	bh=TJqRddFjDl5iBcUmWcW6ywZ7vqFu0BSvQf50wqCCMU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/oaI49MDLlA4sVTwBWilL5yY6bOTNRGqMet12DE1jx8Pd5qZQsZsN5/KkoLH6Ihh
	 dQE1oc0+kriJXVjp+HcbLSTu3VDnZxQHRsCN/TafR/z4Fh+P0EksQPqkd6RD3k2Zmf
	 W8V4UX2E+fyJ23l9LC7AZ+bll4Aoks1EeUUSlNLfGW/MzszhcmI92gmqCFSZG9QlQD
	 g8jJ0sBTwKxLukT1BnbkIqx356YJtE1OjR71PPTKCz9EwT+7jGSZ9pDD7paRMFapL9
	 4Zbmc4C+3HQvdYEzAaYzILszUrl6n362HCGEed5nQ/RCUX4BE1qWnQAr2fkQpGSQaW
	 VY1xFUoxb4OcA==
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
	amir73il@gmail.com,
	stefanb@linux.ibm.com,
	walmeida@microsoft.com,
	ecryptfs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 5/9] ecryptfs: Reject casefold directory inodes
Date: Mon, 15 Jan 2024 20:08:11 -0500
Message-ID: <20240116010819.219701-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010819.219701-1-sashal@kernel.org>
References: <20240116010819.219701-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index e23752d9a79f..c867a0d62f36 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -76,6 +76,14 @@ static struct inode *__ecryptfs_get_inode(struct inode *lower_inode,
 
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


