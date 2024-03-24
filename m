Return-Path: <linux-kernel+bounces-115041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D243A888CB5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C17A292077
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9464E2ED949;
	Mon, 25 Mar 2024 00:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OsQKhbjg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A298517D238;
	Sun, 24 Mar 2024 23:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323819; cv=none; b=H5wOFTiFrTZXmAKM4V0Y+2KqCK4uRsWpBTJt9dysN7doP2VV92wfpWVXzQnfzgrhhb9hFsBxJXhusSYOIq5ObD8qHJ1wKN2jjL94xnkcFijuhgh8XTl7lr3XoUJqb/0eYXp/6UH3/GbHUydbp/rnxB4mMWl9O7os1j4CLfGvz4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323819; c=relaxed/simple;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Obhl4iKqKhjTWAT5Ba5jeIabJFTkgNGHCbfGYAoxHsQTaHKuFIw6460AplckcQx0MMNhQ8RaVf60ZidHQlq8A0rQonriTQE9vlnpinrqNv7Eeyijy++0+QLAuBBsx7RIJA/TcjUUJidadHsrim8zOV08LD5og7XUEpbZJOCQAkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OsQKhbjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD172C43399;
	Sun, 24 Mar 2024 23:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323819;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OsQKhbjgHrgXbqdlXoiLIjaNa6PbKaOxQ9CbuH0DIFeHggjQ3xd6eUdi+avEAaoKv
	 DHTVqbOz+r38I/4cQBp+xHWoMOYFltuD28NM4U/MVg8B73ZOJu+DpdRg3M6qVXOcl9
	 UfDwN8PVsKL7lxSS8N6bngDGd0koOH3J1cHAmAOpvnclLHijkYujlQWshiLT3IakJ1
	 15B//ApzU/oF61X2tweAnZ8iHwyu8BL0FnmRqmB8wLbWdl7iO17rt+dqKVHa3bkgGN
	 21Pt0ZKZBpcz2Sanv0wCYz12mma6M/9FTYtuuzgQnRXGF5Bys3aDoO8Q8ng5OrM5P+
	 G8HIRbENXxEgA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 198/238] net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
Date: Sun, 24 Mar 2024 19:39:46 -0400
Message-ID: <20240324234027.1354210-199-sashal@kernel.org>
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
index d435bffc61999..97ff11973c493 100644
--- a/net/sunrpc/addr.c
+++ b/net/sunrpc/addr.c
@@ -284,10 +284,10 @@ char *rpc_sockaddr2uaddr(const struct sockaddr *sap, gfp_t gfp_flags)
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


