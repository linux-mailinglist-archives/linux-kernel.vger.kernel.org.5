Return-Path: <linux-kernel+bounces-114058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13220888827
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 446A81C27306
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DA02319D7;
	Sun, 24 Mar 2024 23:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DbNv6opR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B65C1FDB45;
	Sun, 24 Mar 2024 23:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321339; cv=none; b=NWpv8/+GpaRPs70B1huFf+7NRfC77SoqcSMb50wxyyYcAsYkx2NEYdaiyQykD3v7Vf7TnQEw4xl42ZxSrImAX73ZZMaw2vT+ZtF/mBDS8SCehY7yLPzX88IWY1mtd5LcuWkl9RS8mlUL7Q7gKUD/I2xKco9ox06Gtg+mOWpKKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321339; c=relaxed/simple;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GavvZIjll9m4aPqSd5Yn94OWaQogLJS+BZ9OR5Nj8MsJVZV5k9J1kAD0ZUUkGiQrQ39ovVAfKaTEh2iFz1Nx6Krk5FFLkR0c0Kr94EBhjE0t9DTIaLS8TwPlQIUPfW9nXbNQvmScRGluRkdKBz+f98hBKnxUlIR2h6PRfkK2Y4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DbNv6opR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9DFAC433C7;
	Sun, 24 Mar 2024 23:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321338;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbNv6opRGY9SYDI2ou+V7R3NKyAzQK+61wLizAKxE5fPZzt3oP/GFTPBWG2EgMcpI
	 hKvQ+Vy33icCirlFt/5a9u4EkMW8EkpqaXg3V5x/RrkCOFK95+xlo8UYWT/d16yt43
	 c6tRRc6PsKuMOcQZkhODgs4PFenLOTaK6AQ+Qp0kz5Nd9jsrmokXSzu9qtciVNVDL7
	 0lDF4IHcH6wjQivYggtzHZKuNePQk+2UUXxalJaEU9VHgetXC610IkbGTI2DkbGWsj
	 2hKPcJko6yhgxzObKt1KVb9+kttMmzqEmfrPm1mM9f/gRl/fLRvw2RIGxqQ5oB9lgt
	 AjQp+OP45KpOQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 062/638] xfrm: set skb control buffer based on packet offload as well
Date: Sun, 24 Mar 2024 18:51:39 -0400
Message-ID: <20240324230116.1348576-63-sashal@kernel.org>
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


