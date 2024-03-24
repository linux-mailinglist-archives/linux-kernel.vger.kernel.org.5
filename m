Return-Path: <linux-kernel+bounces-115340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843BA889AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD4F2A611F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CE01E6F55;
	Mon, 25 Mar 2024 02:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh/3C/G3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF29F1CE6B3;
	Sun, 24 Mar 2024 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320515; cv=none; b=iCCajK13Y9LI1/QjtFPsYqzCs48nQ0uCEaVeyw3LarUFXMnCxYkHwe6pt0z3mWmu0ujuZYOHKGLiZz2AB3qwcaGBA6BfeAMrOOTeJMdeZPsiG5V9WyPJ3dEWeSx2P+MMexgOvQhMmrOZX3w84wCsCkFvvHd3/4VPIBcMtkf8mn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320515; c=relaxed/simple;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jwJPVqLz3Ka6Kda95TFr/YijBM8ziWI72dYF/umU6KLdTaZvvBKsgB9jJmwD5MZrUo/6X2WWqF111kyw/IIcJ1PQ4CezPA8F3QPOYiMcTcFoECn7CNM7sL3XX1L+KyIa5dQwRViyBc5Soj4LPG8cKO5WVpcdxIT+VY+0kT/HxYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh/3C/G3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059C4C433C7;
	Sun, 24 Mar 2024 22:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320515;
	bh=KLNv6IZ5yEeP9+TzZ7XNfvS9hm4MRpt6kWqrQ9+/B+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xh/3C/G3z/ETJBFT9HR6ng6c6K4GVcO1yuOXTPpM+hg5EZd7VblgXu8ft0Q1wuYM1
	 z4NHCD22WwXx0cosrxd1DNDcsqOjdWW6eSWu+7dG9St53CXfLzojpCgqy+4EGKpVOA
	 iLFOWHykkTrJHRBbpidOJOTFPaCKuy2OIAsOlfaGccLgDaSEiPpYzQPIZ58VcFoqQF
	 mb9CYJyTQ30u1N9w4P5npBe3t8kLcpwwUXAOFb4Gfttm4GlnAzN1u47B9HuIT5Mcik
	 jk0wxUCJc+tIW8c26Bz0oQNc1DKd95MtUtmZAKSfEcvYdMbu9h94Zcut9TFNACZudH
	 xAl1oLiIfBYnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Yu <yumike@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 076/713] xfrm: set skb control buffer based on packet offload as well
Date: Sun, 24 Mar 2024 18:36:42 -0400
Message-ID: <20240324224720.1345309-77-sashal@kernel.org>
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


