Return-Path: <linux-kernel+bounces-115147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FB8889326
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCED29A3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7601C7384;
	Mon, 25 Mar 2024 01:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tv20Lb52"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F9182755;
	Sun, 24 Mar 2024 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324163; cv=none; b=cs5ygR6NgPdUtVTF1arBW+giR1gc8hCQcNDO2pE1FpEbjRLNzY09tnEvq/Gb4y8Ik5l22bbcW5N61PJEb10tNIwtRgsvDLFBVhPzESqcrN68UVrJ9BdAokd7J8GzSAjNvbmIaKkiZEBs8fSYoQcHOgCykU3Myvw5mgMXb6MBBNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324163; c=relaxed/simple;
	bh=G1pmVYTlKYB2evp2UH26aRIMP5vTOXvwujH5BaIMyP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VhK7Ii0UnkBZqSgZewrceu8/QSMlDZLR9bS3z+FRTwJYTb+dbBJTwlOeHXZP3r7w670h0jqa9/cJMkC9i+1NZQksN/iWt686QxADYklJntI+6Z2OdjbE3WUdQ2AbwSYWf4Jvs36tjH9kcvQOUunonz26xhAWOMVjS7LvNzsAA30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tv20Lb52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D098C43399;
	Sun, 24 Mar 2024 23:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324163;
	bh=G1pmVYTlKYB2evp2UH26aRIMP5vTOXvwujH5BaIMyP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tv20Lb52KjcYxYKwFRd+1g8iEWrVxIPlvBU+iCPNe6S3c27rWpG33AGSzHnWss/4f
	 YbEqKqEcwAI6XZDb0R0q790MdrvKAt7lKRvN3THva9Jy7yDMGr0Q84M9UjJ5Nh9hfJ
	 rv5TpPB+yRrfMpNkKAXYpO4fFYdUIYOcCAPjJuiJAc3QYWvNpOCA4YzAOifz57cpLT
	 O3WX5bfVamRmM+7XnBzfQPReRe5LurTL2YaSKc5BIQcDn9Gfv9zNzp7NND7W5d29mE
	 db/VlTpSejAzLae8cXfW+57BsKDHkJyLi4A1iQE9JlbuYhn5NbxZ9WoyjFYl3/+d3K
	 N4V1AcMUCOLdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 158/183] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 19:46:11 -0400
Message-ID: <20240324234638.1355609-159-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 698ad1a538da0b6bf969cfee630b4e3a026afb87 ]

The intent is to check if 'dest' is truncated or not. So, >= should be
used instead of >, because strlcat() returns the length of 'dest' and 'src'
excluding the trailing NULL.

Fixes: 56463e50d1fc ("NFS: Use super.c for NFSROOT mount option parsing")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/nfsroot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfsroot.c b/fs/nfs/nfsroot.c
index effaa4247b912..c0f2e1751c33e 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -169,10 +169,10 @@ static int __init root_nfs_cat(char *dest, const char *src,
 	size_t len = strlen(dest);
 
 	if (len && dest[len - 1] != ',')
-		if (strlcat(dest, ",", destlen) > destlen)
+		if (strlcat(dest, ",", destlen) >= destlen)
 			return -1;
 
-	if (strlcat(dest, src, destlen) > destlen)
+	if (strlcat(dest, src, destlen) >= destlen)
 		return -1;
 	return 0;
 }
-- 
2.43.0


