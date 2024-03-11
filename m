Return-Path: <linux-kernel+bounces-99396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A18CD8787CE
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 19:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B9E1C213C1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2A604A5;
	Mon, 11 Mar 2024 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMdurENo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F355FDCC;
	Mon, 11 Mar 2024 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710182288; cv=none; b=GWVabHAhO5+NfyogQHgoURhV7XCNc1nDQeXYzOKvzLktl7RMs8R+8AugFbzvCEeUHtnN7vIvS3CzYGx9DRXd++LzPC8MNJ/S7OiWL7SGtogZaKgKKgN67+TnGKDM6YM5uloPwuuzxLQat+4AJa4B2I7fMV0WnZMYTrpWPIYckRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710182288; c=relaxed/simple;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upyY+Ju/Q9ugV2NKAnSZenNPiJPl4zwBEDdk0cH1pnu08/tscPu4iQHlZJpqgp1vJ/DpcbIauskKXpY89l68xmZ6jHJyDxV9eQLvrdtYnExQ2kXdooybGQuFkDzhivf6iriy0ZgC3H6VcYHrde5OCFyW9o4e5aDU+EnbnDcXzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMdurENo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5F5C433F1;
	Mon, 11 Mar 2024 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182288;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMdurENoT0XholYbGqjkq0Z/VmlPSSXcyLWQK7aa5CF3T9PzhsrHe9jy7TlIdSSxx
	 WGGyt6yMqKO1tHx5vDeljlgW89G2HZYPbPWhC7SeCcdMvPNZDQYdS6CR1pSrpdTFuv
	 GU4OODM3GhBUVuR6Aq4cglTdwutNEw03Vwb7ypmxozFinDcegDwBEwKBY9PwhoKnnI
	 Esjx6sRVGknZdqNTdos7V7Kwd5whyUSB63Pip7VXVki0dEHjau4t+SRM6+LT674wB0
	 wDPSt12bVDezPd4CwSiyFcQLjJgTENRr5RcCR/IIygFY82JLAm72phANn41WPumAF1
	 geU/QzYdnL4hA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 08/12] xfrm: set skb control buffer based on packet offload as well
Date: Mon, 11 Mar 2024 14:37:22 -0400
Message-ID: <20240311183727.328187-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183727.328187-1-sashal@kernel.org>
References: <20240311183727.328187-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.21
Content-Transfer-Encoding: 8bit

From: Mike Yu <yumike@google.com>

[ Upstream commit 8688ab2170a5be0bc922195f7091c38b506bab2e ]

In packet offload, packets are not encrypted in XFRM stack, so
the next network layer which the packets will be forwarded to
should depend on where the packet came from (either xfrm4_output
or xfrm6_output) rather than the matched SA's family type.

Test: verified IPv6-in-IPv4 packets on Android device with
      IPsec packet offload enabled
Signed-off-by: Mike Yu <yumike@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_output.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 662c83beb345e..e5722c95b8bb3 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -704,9 +704,13 @@ int xfrm_output(struct sock *sk, struct sk_buff *skb)
 {
 	struct net *net = dev_net(skb_dst(skb)->dev);
 	struct xfrm_state *x = skb_dst(skb)->xfrm;
+	int family;
 	int err;
 
-	switch (x->outer_mode.family) {
+	family = (x->xso.type != XFRM_DEV_OFFLOAD_PACKET) ? x->outer_mode.family
+		: skb_dst(skb)->ops->family;
+
+	switch (family) {
 	case AF_INET:
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		IPCB(skb)->flags |= IPSKB_XFRM_TRANSFORMED;
-- 
2.43.0


