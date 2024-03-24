Return-Path: <linux-kernel+bounces-115043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 26925888D2C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67BB9B25202
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1592EDFE1;
	Mon, 25 Mar 2024 00:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjFfnO4A"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86D52853D4;
	Sun, 24 Mar 2024 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323824; cv=none; b=Z1IvleEnZ+Jvcuje3VYebQBRKjC0o7zSOdQRyUk6631zBXhsINO6HhvNGAsXQYamdlHsVPoWbcjiqu66sW2L02SZj7q1PFV2cqHWYr/NvzhtrhJKomAL88K0cNlh/t+4A9mscUROev1E9p3/R69k05iDP5n4Gk8RMK69k52sbVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323824; c=relaxed/simple;
	bh=Roie6MsJdNvp73cKniu3QDUBbywUVPcSI2K9N8bQLTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGOH0tZyaBuNWNs3Ytn2RS8CUdVZesLnB2cjYd3TGtEJXRxqUHBN0BAOm199fUQ5xFSfJQV6k5XjR2g8MrL5tWxCogPU1Z3PYJ8h2OjPgseqPNV1uryTw3GbmuZwaGwRWItVcwXPHwaCmaSG1yofAmquLUNexhpzsXVHojSde+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjFfnO4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0569C433F1;
	Sun, 24 Mar 2024 23:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323823;
	bh=Roie6MsJdNvp73cKniu3QDUBbywUVPcSI2K9N8bQLTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjFfnO4APQ/H5haW66R+rdPtoKeKval7o2klD1BuY2+UMtPtlm+6jc/2y+UNW9MoB
	 9AvuSOsmpD2v+kLWMlXDT7Brle0aInmjnDvjFni9WVwJw/wMQ3Z9ndFtzG1tPbAQig
	 Gc2tc+xClmTJkWyzjtG+P0cBOSiEk65SurC1gdRk7QsTiU0Av7MDXoCxTConk9OvtK
	 7RvDINBHtaXlFBDkH6VoBq+BXJqnaSHdSnSgVjj0rKamqSX6+Lrk2Td56LiiGjk8/V
	 fYBekTgYn/Kp2jAY2C1oYnEcuUQ5eWPV9d5VF5Y0y68lqhTmLcFxRSocFZNpyaGvU0
	 xPbbo53SNrXAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 202/238] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 19:39:50 -0400
Message-ID: <20240324234027.1354210-203-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index fa148308822cc..c2cf4ff628811 100644
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


