Return-Path: <linux-kernel+bounces-114893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A586E88920F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78001C2D2B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264E82CFA06;
	Mon, 25 Mar 2024 00:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNANmy3T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8FC5B209;
	Sun, 24 Mar 2024 23:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323563; cv=none; b=mudgdZqnPnHSrf8QpQ6iDyuYJzkSsIGsfzZU7XID325/fatdbPZo/MFVNK0T8LYd6pzba/FUaof0FJ4J5onIVQHUfaCC98FJeWCXcMiW3RLzOJ/6EEq+71Ko9wXzbaWEZBqmPEUNF7Pq4TdwkbG9FmVDWh2x6CI8mOm3KMa0ysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323563; c=relaxed/simple;
	bh=LYazFtegKbUQmWF4+002xX2Q9D4Jt0jQN6fweMdHyiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g60ce+g9CAqiIc9Z03QvdIg4Oc4IBazI9H/01Q5FxvcQiUcU1I5C3NOSRUI9Aog+ZLmmSFwt5NduGKS+uF8Z0NMv8VcNfedfR/ixCxIug5zaWixgocvgG6E+byT8sJpXcd0LOAzfoYMv7RJVLoLHKDkSqJCu9B/By1EBEjRafNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNANmy3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8219EC43390;
	Sun, 24 Mar 2024 23:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323562;
	bh=LYazFtegKbUQmWF4+002xX2Q9D4Jt0jQN6fweMdHyiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WNANmy3TUkpRh4XtGUDffHoiZC+7PHLK9AUvT4gUXkYmUUsyLlGzbVJj7P5Yk96M7
	 UymxQ0n2TtM6oKGR8eUaiW3mpuY3T0jmSFrVpeu+g/EopBbZo+LWvtIypC9CwASILb
	 czWF1jnJND8RW8QFz/tuNrHAU7nkF0vWtgd4kNWTv5nFT7frfJx8wQWhRfAGfZccCA
	 2Z5xMVWF/UCQVSq0gykn2cllnNxw5tDFD1oEH5pN2YITSTunocmd9Q4LCNY7uuuEuT
	 yfdTeEgDJyniDPjgEOZHKaU9BYQjbp2NepwY1rRpjqVBJC0lNOJYPbeeY7apG6cthi
	 xQb7pzHqHBXUA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jorge Mora <jmora1300@gmail.com>,
	Jorge Mora <mora@netapp.com>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 269/317] NFSv4.2: fix listxattr maximum XDR buffer size
Date: Sun, 24 Mar 2024 19:34:09 -0400
Message-ID: <20240324233458.1352854-270-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jorge Mora <jmora1300@gmail.com>

[ Upstream commit bcac8bff90a6ee1629f90669cdb9d28fb86049b0 ]

Switch order of operations to avoid creating a short XDR buffer:
e.g., buflen = 12, old xdrlen = 12, new xdrlen = 20.

Having a short XDR buffer leads to lxa_maxcount be a few bytes
less than what is needed to retrieve the whole list when using
a buflen as returned by a call with size = 0:
    buflen = listxattr(path, NULL, 0);
    buf = malloc(buflen);
    buflen = listxattr(path, buf, buflen);

For a file with one attribute (name = '123456'), the first call
with size = 0 will return buflen = 12 ('user.123456\x00').
The second call with size = 12, sends LISTXATTRS with
lxa_maxcount = 12 + 8 (cookie) + 4 (array count) = 24. The
XDR buffer needs 8 (cookie) + 4 (array count) + 4 (name count)
+ 6 (name len) + 2 (padding) + 4 (eof) = 28 which is 4 bytes
shorter than the lxa_maxcount provided in the call.

Fixes: 04a5da690e8f ("NFSv4.2: define limits and sizes for user xattr handling")
Signed-off-by: Jorge Mora <mora@netapp.com>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfs42.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs42.h b/fs/nfs/nfs42.h
index 0fe5aacbcfdf1..e7192d0eea3de 100644
--- a/fs/nfs/nfs42.h
+++ b/fs/nfs/nfs42.h
@@ -54,11 +54,14 @@ int nfs42_proc_removexattr(struct inode *inode, const char *name);
  * They would be 7 bytes long in the eventual buffer ("user.x\0"), and
  * 8 bytes long XDR-encoded.
  *
- * Include the trailing eof word as well.
+ * Include the trailing eof word as well and make the result a multiple
+ * of 4 bytes.
  */
 static inline u32 nfs42_listxattr_xdrsize(u32 buflen)
 {
-	return ((buflen / (XATTR_USER_PREFIX_LEN + 2)) * 8) + 4;
+	u32 size = 8 * buflen / (XATTR_USER_PREFIX_LEN + 2) + 4;
+
+	return (size + 3) & ~3;
 }
 #endif /* CONFIG_NFS_V4_2 */
 #endif /* __LINUX_FS_NFS_NFS4_2_H */
-- 
2.43.0


