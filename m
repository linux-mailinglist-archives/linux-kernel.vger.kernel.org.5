Return-Path: <linux-kernel+bounces-115146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29459889324
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2071F32DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED651C7877;
	Mon, 25 Mar 2024 01:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVEazqfl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7CE182747;
	Sun, 24 Mar 2024 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324162; cv=none; b=FZv+RngouE8gMYsL9g2tWEJekaOY9Qgqvmj9K/0uy5P7sTHRvQNO0WbmLNiIQg00VuEy3h35BsgLdYeUS/y7uHKncPx+ViCC0WzqAv7TKxVm5+62RfiR9OMcnoEImnIzgl1NJ/o2DlxeVWmwxlEMY1z0my9kuweO/20TbXTWtFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324162; c=relaxed/simple;
	bh=pP09BQR5vGUKD4rX+sTintaCEvicXfwuzCjxTMxtbw8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=patv23yqtj8R37DUdubo7eW5OxFZYPvSZrdgd21PBqWb3qppahvcAVsqQ/EGLekysxxesTkb5pmTAXOZv6kLz5VYNoGOKBOTsJ9jWD9dEvZ02VmJyM6iEJSgKOJqK/FvXtNOSMwDLrbr4oKHd/1HDi6HsjDuJwawZYeZiPj+W/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVEazqfl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB693C433C7;
	Sun, 24 Mar 2024 23:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324161;
	bh=pP09BQR5vGUKD4rX+sTintaCEvicXfwuzCjxTMxtbw8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CVEazqflDcVyh31Wk1pKFKwC4o7ja4ux4QCoOH85y2HfbV/fRQnZq7l7QOHv6GiMl
	 d7oR8fMkv25UTVJ+8RphTJlGST7aUL608+ghgk7cv/efPccX7iqv9nhyBWjdqij7Vm
	 OK6slo9ngj3bJV30QSHr4HtoG6eLxQdIfYUeI8ElnWOe8ZMVCbEAYJVC3uuKg2UGMR
	 t/DNESetryKemoctEMeMsCDQONLrC8jhXrcP7Tw4IZ37MNVHNFIQC3QUYM2KcLqFkl
	 JkCsfJgwhYYgGr6eV3OcueVJKMvNi/kodyu7ebpuw8jDLkhE5gSvUrTlqy8pBvjZHB
	 BPPY5xDMtchvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 156/183] net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
Date: Sun, 24 Mar 2024 19:46:09 -0400
Message-ID: <20240324234638.1355609-157-sashal@kernel.org>
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
index 0d4a2bb09589c..be2fc88f5bde1 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -288,10 +288,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
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


