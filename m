Return-Path: <linux-kernel+bounces-116345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA839889E65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 844B528D7E9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1F0299168;
	Mon, 25 Mar 2024 03:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckDdUes2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A81856AD;
	Sun, 24 Mar 2024 23:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324364; cv=none; b=V5t2y965+xZP7u3a59/MhN1QGYWQd1hHeLqSdml6YEDxeIsN3RP/OS32BKOwWrPbW+i2TyslYo+Ol+DphqLgWw+xs+U+bcuHduc3fiztEWVeXZa1E8TVNK05Qgm4KCQvC+u2FLzxY6ejBEW0wDgkE/QnuOSiy9EF1U5T37iVwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324364; c=relaxed/simple;
	bh=JheoSwJSnHfF0q6NRf7tt3Cg5P8qwcOVNT8AoQjQpRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SDbeNuQIHEA4oKQCyiluL6mP46s3AgxBYuF10LXLTQN3nt88IYs50LAoOKEfmSuD/H5TfSBUYn3l0uS1aXXahdNrGUZuAweSXwqkes/9zkKKlWz8Gg1bT+cSgI5VB4YkZTxczqMoU4kiqxK86SY6BbVd0oGQhO8/cwsjerPFOCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckDdUes2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7260C43394;
	Sun, 24 Mar 2024 23:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324364;
	bh=JheoSwJSnHfF0q6NRf7tt3Cg5P8qwcOVNT8AoQjQpRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ckDdUes2CNTnT5WBSHLf9gDEmhIrMDa8ROkY+h/VwY2zwqlckUYcjn0bM1c8KNs3C
	 gDZSKtQz0GoW67BiD5uskQUgJAyHaaJug7jl5/YRIeAChzEku2T5QxyI6//889Frpe
	 +Xfdul9e9wSEi1cmUcpaBygELH/kxjqL2za4sRyDdXwMYlgPk+3WxuPvTCMTpvXpOw
	 0x2vBKZh0eLhRzfoEEDD3fv3bBFY1Nf9xg/pCcOiyCAFKzyYzxgwhxjiVPgrJS9jZL
	 QMyFLj6LuoHkNKxMSbCvZQTSCUa85AhQjp7s6HGKcBzp9buUXnIeZdQW0vYpKTPPOw
	 1gXJy+/uZJIug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 131/148] net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
Date: Sun, 24 Mar 2024 19:49:55 -0400
Message-ID: <20240324235012.1356413-132-sashal@kernel.org>
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

[ Upstream commit d6f4de70f73a106986ee315d7d512539f2f3303a ]

The intent is to check if the strings' are truncated or not. So, >= should
be used instead of >, because strlcat() and snprintf() return the length of
the output, excluding the trailing NULL.

Fixes: a02d69261134 ("SUNRPC: Provide functions for managing universal addresses")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/addr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
index 7404f02702a1c..eba3b6f4d4ace 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -287,10 +287,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
 	}
 
 	if (snprintf(portbuf, sizeof(portbuf),
-		     ".%u.%u", port >> 8, port & 0xff) > (int)sizeof(portbuf))
+		     ".%u.%u", port >> 8, port & 0xff) >= (int)sizeof(portbuf))
 		return NULL;
 
-	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) > sizeof(addrbuf))
+	if (strlcat(addrbuf, portbuf, sizeof(addrbuf)) >= sizeof(addrbuf))
 		return NULL;
 
 	return kstrdup(addrbuf, gfp_flags);
-- 
2.43.0


