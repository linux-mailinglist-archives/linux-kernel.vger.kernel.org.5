Return-Path: <linux-kernel+bounces-114636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 563F3889099
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1124F291EED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AF615E80E;
	Sun, 24 Mar 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eN6q72nb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0015E819;
	Sun, 24 Mar 2024 23:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322295; cv=none; b=gcDIEjZzjGHePZlr0Ijg6j/hpRVfKuqKdKJdDl3xhwPMTOGPw9o84pnkA4q4tJJueH90qYv0o8+J3MYFj2ZS3U7GkEWLFldxR1R3NNWHjZUuwxIKrttMLUua0kdNi6Kh+0fJ8rLBkPmcN1ej/0KxgMg0i/KKQhCSzpy2z4GQSlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322295; c=relaxed/simple;
	bh=gU9vpmsROynx/x3Ad7nOWcmQ06mJYgDKHOQz871Pshc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2TLt8UyQIseHHxKn7JsNC5kU56K2QlnZuViNZHZmT8SDHk3oIgTKV6UEZsrcy/+xgyZ7LyD54VQEvbbuGe44sO3hvL+KyYJrFQbv42Fh/7v6ZWKNkhEiFSjAY6VM36ZaNIWF7VCr7sfRowaZtGywrVPWR2REmV8RaVHOV6fmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eN6q72nb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697D7C433F1;
	Sun, 24 Mar 2024 23:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322294;
	bh=gU9vpmsROynx/x3Ad7nOWcmQ06mJYgDKHOQz871Pshc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eN6q72nbk1mCqaAWoMdlxOgvEc9ht4hmNJpD+iwYdvrgsaGQ+8y+3Itj062ddunDZ
	 Gk5A14PP/1JzXyPeZTab4eFtElu/ayBlhfaBomuDNcdyGgHKtlgANWOD/XeOZTfXU4
	 c9ihdTv+OTHlVjFUQ6hlxigjXnA1U3MNdCVziMA1cj6uzX8NjYAonAS9vTIrPN/qqq
	 RmQ19zwAPVQUuFa6tuRpxbwQfGClHJEAIGtjmY0vegETtyzUEmwCB+L+I39tgAgFlX
	 GqkNoDYRX1SKHUAsK22xsIDlrD8bt/RR5pxmaw34PwLWsly0Pnt2zUsVvrxEPnHH6V
	 ali1Uw5G6LwKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 377/451] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 19:10:53 -0400
Message-ID: <20240324231207.1351418-378-sashal@kernel.org>
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
index 620329b7e6aeb..0b1c1d2e076c1 100644
--- a/fs/nfs/nfsroot.c
+++ b/fs/nfs/nfsroot.c
@@ -175,10 +175,10 @@ static int __init root_nfs_cat(char *dest, const char *src,
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


