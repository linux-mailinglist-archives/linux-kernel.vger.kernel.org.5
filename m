Return-Path: <linux-kernel+bounces-115542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 264EA889C4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB3F81F36344
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C711EF7F6;
	Mon, 25 Mar 2024 02:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WVnkPiDU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5788C1EF7DF;
	Sun, 24 Mar 2024 22:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321037; cv=none; b=aUNF32fbzinBt0VfMxAA8lsAvPduKlKbPTklNeHBZw6jHPLQKp+fLE5gmhUhyxfHpTWtaB2KTs978jceT3Ts1LVx28KFmFm1xkJguYiTgajdxxVF5ZCEHS2DITsA5YnPQ4zDMwitvtDJQG8SlR9Zsl3xxLOGvx55fn5Fk5EoNeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321037; c=relaxed/simple;
	bh=Zkv4uBQK8eMbRPj/TMoLQKTy5qtiJb0tBI+C77mgZrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdLGHGFEqcF6+3Tg7Yv5t+NHAkc8x3thKgwwgbg7WvypbTIIh7QgamEUeaQUe/HMtMsNPXh0/ksieUYInGQuhM/IRdu1MwAESuGQ2+BGA/PC7ZTxM4CiWMht7tocoCq1Ig1/b+uZvXD4HUTcoAvHcdmpv8CY8aKjGxKOsDBGOKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WVnkPiDU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DD77C43390;
	Sun, 24 Mar 2024 22:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321037;
	bh=Zkv4uBQK8eMbRPj/TMoLQKTy5qtiJb0tBI+C77mgZrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVnkPiDUvL+OLpIEypT4j6QoBEYSD6fGJZBZViqLyzvZkNg3+rUMLxBEoUlZgrbXw
	 DFFk71DFfePz4VvOVkeJr/Etg73VZqQ+Xm13HzQ8oyu3WFxnHnLoklf31JeywWP9K7
	 m3jdhdO32A+kfwYJ6dfZAsHYpkuE2c2E5x/CmuOMe7qooerATtwEdDRtDZw8QYPTaX
	 Jou7yRn2aRqWvvDtelcaFfHtjojxzwRcDccP+tGkCISMVVvKNi/pWhZEFwB7LvaZ9E
	 glsSsmwxK4qySXjCn96jz34wAfoeRYiVed6Y71r/bD9F7CacKZ2qqxBJ04lSllKkSH
	 hQPb1PUZLouDA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 600/713] NFS: Fix an off by one in root_nfs_cat()
Date: Sun, 24 Mar 2024 18:45:26 -0400
Message-ID: <20240324224720.1345309-601-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 7600100ba26f0..432612d224374 100644
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


