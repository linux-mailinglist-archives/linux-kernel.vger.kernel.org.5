Return-Path: <linux-kernel+bounces-115729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74D788974F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E83171C2D20A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 166E0363380;
	Mon, 25 Mar 2024 02:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZlHObspu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6551EFFD9;
	Sun, 24 Mar 2024 23:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321802; cv=none; b=s2ApB6uD8udWn14HoP5do0QpomXSNu3us+t+pzOC6mZvZ9cr0/YpWsh9k0hKjArGCkxmdTH3KTg8BhXIsl+L7E7b2bUlf9GHbJcTidLEQ69q2y2W518c3JkMYBeGYR/oO9IIy+4XBKp4SM0zkO/4utW1Y/arAgyH35FpEeAM5kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321802; c=relaxed/simple;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fR6Li+O+ORlcJmxsUUzNlE8AcTtUa+jB+lWFNLPtwOycBWx1PGrCmgX1/jh1IpeQpVr/3HAS5lyiZNh2u7n6BzVOqdufh0VqO9OUsK+li8yDZ179pNohmK9bzw5Hez/4CVH/21XMt9N2krF1LrYcUHzegRcDb/5An2IqLNLMBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZlHObspu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDB9C433F1;
	Sun, 24 Mar 2024 23:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321802;
	bh=dhKFxGipNUYb7+OZCcYXRa1jL6XDpWTD56tS1MNSVQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZlHObspuar9xzF7dqbYkLSdgAlsXPbItK9969+m3pFcfXzOn/RAW9TloCXkmxscC3
	 OT7EPNHw+Pkj56x7ocinsAiTckAoCagstWSosOISbByHCEcqWFzia1C33b/p+OOAPc
	 fhcQLtjlt/z6YB0ix7yAISbwRv83FnkVytU3YReQpwc15N/Y9aUTk0aufZwo3UeyUd
	 3uuVP/41s8CPga3V5ll2+xYub6RHHRyf1Yv8dx+rzJEzsW1cSvBbEsNp+GTAU3cd4t
	 KbSQboCC9caIRwGdkK8AULYU0qhRTOfHczuub06sonMlNNr1iJcGCGBwsSv3xDw2xG
	 WNoU6fX2uW7PA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 530/638] net: sunrpc: Fix an off by one in rpc_sockaddr2uaddr()
Date: Sun, 24 Mar 2024 18:59:27 -0400
Message-ID: <20240324230116.1348576-531-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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


