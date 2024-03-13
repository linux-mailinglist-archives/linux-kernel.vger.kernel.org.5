Return-Path: <linux-kernel+bounces-101747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102EF87AB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423971C2107F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB24C61B;
	Wed, 13 Mar 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLuuTpmq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93EA56B7F;
	Wed, 13 Mar 2024 16:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347568; cv=none; b=dCILSCHHC4yqRn4HmIrlJifbz9l90xHQ97swsrQrwJzwkg06fKDw1SBivmeFtoJs3NIPBwI2iN7xGhLW/52I3QA5x7MTn8D7HCSd7hibS+1e8Q9bwxYtiEr6FM7ybQ+nktu2sGkQLXhnrrZF2T9Jf1KDosgEixYoEPJOqo1GwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347568; c=relaxed/simple;
	bh=7S7HCJW9mvbBTxHyz3ldQDTtoUXg6JT0YPDvWToakec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+FZ6GfvK6fq/UBqLdRGqFykFFRgoe8LU5Svonp8uJhYwuxaldunvwgNq5KSl4QYhdCajVDQdIJaSAlvND1uT2dNjTDGyzEF0yx1u3uti9vgU6wmW9VIpEb8ug7+7q5VOlwim2H7v3xNk5xTPgMxo4cImwdpiph1WvEMT0kiaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLuuTpmq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA1DC433F1;
	Wed, 13 Mar 2024 16:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347568;
	bh=7S7HCJW9mvbBTxHyz3ldQDTtoUXg6JT0YPDvWToakec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dLuuTpmqaNfwVBZ7xKyfYx9CtVriA/dzBwonN1Oh6j5+6tbmbMZmRgGGiLDL1mJ2m
	 8sKEw9B34a6b2EVL3kSb0YnqkObPYSVrp34DPjNdqrgtFBLtSEQYQAjk7R3iv2PtOK
	 fnfSf9cxITd0j08bCUpEkI+nMHEmGg2Eo6mECnf2ttYat7QJ/AcjB9tbxQNboSY1GK
	 ceWkLywkeCPdOByEbRBLmUqv6Zu7doKwWKBuP1kv7oKTlGK+uHWIqw+t5pSatw8ytv
	 DOzNZnA8hyEAiA7Wx3KrAWcTO3zs/YBRHrlL9c+qq2fqcJfYOnUs1Wk9V43qlBiDHm
	 UHr/RzamSM5/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guillaume Nault <gnault@redhat.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 08/61] xfrm: Clear low order bits of ->flowi4_tos in decode_session4().
Date: Wed, 13 Mar 2024 12:31:43 -0400
Message-ID: <20240313163236.613880-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Guillaume Nault <gnault@redhat.com>

[ Upstream commit 1982a2a02c9197436d4a8ea12f66bafab53f16a0 ]

Commit 23e7b1bfed61 ("xfrm: Don't accidentally set RTO_ONLINK in
decode_session4()") fixed a problem where decode_session4() could
erroneously set the RTO_ONLINK flag for IPv4 route lookups. This
problem was reintroduced when decode_session4() was modified to
use the flow dissector.

Fix this by clearing again the two low order bits of ->flowi4_tos.
Found by code inspection, compile tested only.

Fixes: 7a0207094f1b ("xfrm: policy: replace session decode with flow dissector")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c13dc3ef79107..e69d588caa0c6 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -3416,7 +3416,7 @@ decode_session4(const struct xfrm_flow_keys *flkeys, struct flowi *fl, bool reve
 	}
 
 	fl4->flowi4_proto = flkeys->basic.ip_proto;
-	fl4->flowi4_tos = flkeys->ip.tos;
+	fl4->flowi4_tos = flkeys->ip.tos & ~INET_ECN_MASK;
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.43.0


