Return-Path: <linux-kernel+bounces-114631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F59889095
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276A11F2B2C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD6113CAAE;
	Sun, 24 Mar 2024 23:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YDma95Qj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4782B234D7A;
	Sun, 24 Mar 2024 23:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322288; cv=none; b=EAUb12sg9LWrTxUgpncuJeMp1GxtkNn6nwwwhx9uCLML6hDqH7tuqYbYG/lwBV/dl8y9vLJYozNEinV3gsi/vQj+9w/E++QWAUPOKSehPAX7UHAMpUdDN0lLsB+vsf50zI0GyxtH5hXUPO3ItkBIXoAyQnntmU3T0VoNWlbHy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322288; c=relaxed/simple;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sv1mdtfNZLfxSK8XHSFfkwf/GDbpnE262G/pm5j601tC4bz6WAOvkfmiI0YMzmq7SQIm1rww8TgY+AZMAy+Cw/x87YT2b36146pGToLf2InLeVGWfkSasXeGDbU0wDWHmafGEq8W6zABlrmmXOV5fXbmikaWd0kMev18sv3a/ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YDma95Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3AEC433F1;
	Sun, 24 Mar 2024 23:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322287;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YDma95QjSGdDWTQOfovNnFc8zQ4YCSrzOq7lIlBGFZCLPpIwpuBN/EMmcRvCIi5uE
	 XHp+YCSFYTcSKxGjYaU4aFogg+JMN6wVG3gBMcoLMvTED0HEC329ibBnwupnds/mwR
	 cMphEDPMZh6ftEUd43GsZtYBNDgnnwxAj2KTaVJnXd+uG46LtmBY2DPz2sIxzbcV3d
	 M5xcxFnRIM//B698G7EJ5GIM9Cw7TLxV3tcZ5VJp2J6m+dgXw/ZVzmGA//+gOa1XYe
	 3lyGWMr++jQ7QBQswto0sM+gghaLFzZImwmXCrpOA/FOePzTNqY9ZvEc0iBgN7fgf3
	 8CZ9sRFhM1xBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 370/451] net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
Date: Sun, 24 Mar 2024 19:10:46 -0400
Message-ID: <20240324231207.1351418-371-sashal@kernel.org>
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


