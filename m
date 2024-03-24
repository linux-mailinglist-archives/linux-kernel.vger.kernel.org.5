Return-Path: <linux-kernel+bounces-113467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCAB888490
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7797E1C23E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5D81B2F73;
	Sun, 24 Mar 2024 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb+idTpj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2B371752;
	Sun, 24 Mar 2024 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320268; cv=none; b=j64Uz44WmZhhQ828wh5mvJucz3DInYk4Zl5FPzgFfMP3RjBKc4RIJ+k4v8fJLaPOPlvkcTpMfaDnAuZI0QpvdZ4Vv4lDL0SYPqEHZM1wef2iLmz3BRaRzD8UBzraCLjkLbRPHVM+ixvtaW9sPXBLIW7NzRC7m+ET5bLVGc+hPXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320268; c=relaxed/simple;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I0xR/ToZcfmHTT2xBm2IwILUu+TmDSvjUpWoEHFdWQ5OBXftmGiO4dqm7H3jmGKcy/iSY1VopiezgTbeXtzoC3WbeE86Nvq8y9gjJb0FDcDbxQnTnsDWQTpL3TDT7QhAVWkGdIkVMQAO0NSIxOnsyrQP5s0heM+pe1W3m4Zx43c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb+idTpj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F05C433F1;
	Sun, 24 Mar 2024 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320268;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rb+idTpj4RW9RlugWYCHBalPhvD9t5p9m58YbnJzrN1zkDbiLFtCGeIPpE6Jj3p1q
	 DDE9x80DKCdebQC03zwP1guZQjiR51y4qedyJ/xDGX26YqTI/xu5M1H0rPH3G0N80Z
	 BBGcCS7NQH6KXFXIGdSEAvX6hpsNUA9TEla4rJPRJs2jVHBT9mJNERUUS0Z4lGM15V
	 wfzRXM66+VR95WIMavd4BL5nrhCuI6tL/qODgmCkDbo0XbcwffAbBdVG8svCx7yzRM
	 diGreG474Vvjnmqs2l0VHGgNazVL9vvWJSnkGWe+OQJ1CwZ7ocaXOlWJlSLi/KF4QV
	 RBXqgVlhM73cA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 576/715] net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
Date: Sun, 24 Mar 2024 18:32:35 -0400
Message-ID: <20240324223455.1342824-577-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


