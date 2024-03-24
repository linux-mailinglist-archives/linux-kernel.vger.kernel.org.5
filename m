Return-Path: <linux-kernel+bounces-114455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3402889001
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACFFB290D48
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3A5C5F3;
	Sun, 24 Mar 2024 23:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrB2iiHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E0215666B;
	Sun, 24 Mar 2024 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321874; cv=none; b=FvmnZ+UsNibZ5S0+Zndif1AZKyJRXdSvxT5Grp/7T7KP3RCznbBCmlqoLQjN0C+1lAwTtGykfxf6o/36/5AKSuECHW9r/uF4O1hUP665fm8rYfdGu3MQm4KqAPVsyU0SOed99Hgxd+SGoDaxv+97zJGcJGWKCiHq4eQMxplueNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321874; c=relaxed/simple;
	bh=GBtMvyQ4Pow6PVi2bB8hpS6fY8x1l/vc4erlX1gilSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YO5re6pCcTHvXzyqqLxDulsrbFeqSjQGU8e3WXewRoFyAr4vsyLe1Uzxps1EutyQhZDtGOdbarZYcta39NU25BNqKL+ahVADxHoqB6nGt9MVZGqXH87FLQ6vEw2vBQsu9XbruVpOAYbJvA8cE92oVk82selv8xZ+wv96X3XqfFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrB2iiHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43C85C43390;
	Sun, 24 Mar 2024 23:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321874;
	bh=GBtMvyQ4Pow6PVi2bB8hpS6fY8x1l/vc4erlX1gilSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TrB2iiHjKxVUpq/xZKqp++JtgmonyVc/MXLpl87DicUFSQzpREKHYtoD4OaVuKCfy
	 IMZU3L0jjwv6yW+lh6DK+yHURSD/ZC6Fq3oqHDIiRjVLKEB9cBLAvQjXNJCs7d9mxO
	 OdA1w454Z9MIonbVlcsRT4wwp/8wDFGmY8cU+p6qWmyl6p1sh9BxGI+EqP76sYE4E/
	 hnawLwQGVoCoxaxakYnQrUNG8Lpinw7CX2HtMQe/owYVbqSdPfmT/ErkeyWl+f4Ztq
	 yvPkzqsRheqHPeZSQjC+3Fq1zllC5cdyPlzOO9rJzYsNDORy5pk6DlMr09AL9oOg14
	 Ldhm2FcPhoQpw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 602/638] net: veth: do not manipulate GRO when using XDP
Date: Sun, 24 Mar 2024 19:00:39 -0400
Message-ID: <20240324230116.1348576-603-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Ignat Korchagin <ignat@cloudflare.com>

[ Upstream commit d7db7775ea2e31502d46427f5efd385afc4ff1eb ]

Commit d3256efd8e8b ("veth: allow enabling NAPI even without XDP") tried to fix
the fact that GRO was not possible without XDP, because veth did not use NAPI
without XDP. However, it also introduced the behaviour that GRO is always
enabled, when XDP is enabled.

While it might be desired for most cases, it is confusing for the user at best
as the GRO flag suddenly changes, when an XDP program is attached. It also
introduces some complexities in state management as was partially addressed in
commit fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down").

But the biggest problem is that it is not possible to disable GRO at all, when
an XDP program is attached, which might be needed for some use cases.

Fix this by not touching the GRO flag on XDP enable/disable as the code already
supports switching to NAPI if either GRO or XDP is requested.

Link: https://lore.kernel.org/lkml/20240311124015.38106-1-ignat@cloudflare.com/
Fixes: d3256efd8e8b ("veth: allow enabling NAPI even without XDP")
Fixes: fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 0ae90702e7f84..5cdb77e861c0e 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1525,8 +1525,6 @@ static netdev_features_t veth_fix_features(struct net_device *dev,
 		if (peer_priv->_xdp_prog)
 			features &= ~NETIF_F_GSO_SOFTWARE;
 	}
-	if (priv->_xdp_prog)
-		features |= NETIF_F_GRO;
 
 	return features;
 }
@@ -1630,14 +1628,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 
 		if (!old_prog) {
-			if (!veth_gro_requested(dev)) {
-				/* user-space did not require GRO, but adding
-				 * XDP is supposed to get GRO working
-				 */
-				dev->features |= NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
-
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 			peer->max_mtu = max_mtu;
 		}
@@ -1653,14 +1643,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			if (dev->flags & IFF_UP)
 				veth_disable_xdp(dev);
 
-			/* if user-space did not require GRO, since adding XDP
-			 * enabled it, clear it now
-			 */
-			if (!veth_gro_requested(dev)) {
-				dev->features &= ~NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
-
 			if (peer) {
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
 				peer->max_mtu = ETH_MAX_MTU;
-- 
2.43.0


