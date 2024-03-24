Return-Path: <linux-kernel+bounces-115252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F33C1888DFC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADCD928E778
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46071CE048;
	Mon, 25 Mar 2024 01:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT7gB9VE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BF11856CB;
	Sun, 24 Mar 2024 23:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324366; cv=none; b=bFyohi9RYFBJEndk8I3zGJdXeZkrmA+vtSFtiwzeqwLEbwlCZTtr41FjLMzoNk/2TQsgjkmQyEHUnowUBhahXbFWKHtV6d1O4IonLMAnx6oKlqG24OwTYyu9c7xPuB10ENUzn+rono/BGzzRpUOSGnqq4Zpzg1PLBiAHgT6h4Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324366; c=relaxed/simple;
	bh=G1pmVYTlKYB2evp2UH26aRIMP5vTOXvwujH5BaIMyP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nbccl3RcwdNBPl5nkPHpbZZHldEuU2T6JA1SLDJQvWrXisqAWj9LQS047dts223akEWh9HsJgLiD9qMDO2rtLfHnZktsbpaG6yVx4ZwYse3DUwiUslHmZlvFWf7n6+BItRgkMrQGMacg0JzBEDJsXHEDQWagjhayGwxOf++iyC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT7gB9VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA484C433F1;
	Sun, 24 Mar 2024 23:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324365;
	bh=G1pmVYTlKYB2evp2UH26aRIMP5vTOXvwujH5BaIMyP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hT7gB9VEbQwVzmndwUwOG/ttJ6JtC96xlfCv2BoQn7sVJ8HHd1AXazpBPChZ0ZSMN
	 4HeL5YEu+WXgxisU7t988cAlatXBPgqZKAMHKGwijiCinnwouhhA0Y/GX5gLRQYIlY
	 QGRD/nC/mq/Y8QUajONaMU3+uWRAgXRoWXuuZHEWGW3cpFqOoN2ppKNtnhzI0rUBnV
	 mhNdVs8dVDBAkMvtzloBVNYtB7sgyjj0LKjlv2kpK3b0hnT4JWyyYTEUcGF9xvk4DO
	 GQT1F8BYnEIE0NTdCVBfAtNaGhUW8uyzfpmiwra5J89CGR/+v+2HrIPSGP07f7YRVf
	 wlM/GfBLDym8A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 132/148] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 19:49:56 -0400
Message-ID: <20240324235012.1356413-133-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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


