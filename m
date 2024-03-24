Return-Path: <linux-kernel+bounces-113564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A93888555
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50141F2376C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615D71C6AE8;
	Sun, 24 Mar 2024 22:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZkGsZSsS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B61C6AD0;
	Sun, 24 Mar 2024 22:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320366; cv=none; b=rZC1fxUeHBNOnF9e8pCu9ZrCzskyVSRRJ++W/W4m+8eyBbUngmHrUMGGj/t7d6oiv0Ncu9sFUZeZMBJIoETXvidAEaREeWoQu0qhhMkkHaGc079+kbGTncPP1oWsqYyXqObn3HglxPHwBqVWv15zfbw8Cw9reuUeACzHZsksK88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320366; c=relaxed/simple;
	bh=qJvpa+hgPSNRiSCI0QuCwjzmMhDyKe7W3jSniZg3RgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oVPdZ36Ppq26iDtTtxN5QHc53dyI3/GqcmD1dKsMLq4M4YxNxT+H5e3eVKcWjDTTnTu7SIz1OeYYa3fqT0rQXvH/RH5ke6YVw2tR+vSDPPPAej6o37iOjAIYc5rAmOlOvYHGoQAThNg/FQUUFzdSkfvezc8RcqMl5idDVDzBrVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZkGsZSsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38E9C43399;
	Sun, 24 Mar 2024 22:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320366;
	bh=qJvpa+hgPSNRiSCI0QuCwjzmMhDyKe7W3jSniZg3RgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZkGsZSsSR7rDyEn3VwxxyZGJ4oBAgV4M+Y7DGC27/lJm7h5r1zqWm+/KwaTSebb/D
	 +RzxdUTpJmOzXJpnDA4aimyRW93HUl9MfXUPV0RBOCYj+p/doYYRAgeAZ3ZsUixmL7
	 I4NK8shl2qVsmsOL+HAw+TAkpJlUI744fDkN4byTQlWHFj8UtiXLPQq4q1/Rvd0TDu
	 AwTj/NYZKHYgembtgQ70pPyuvDkbFLt0dVRhMEz3evwD05OWktF4z8SRMvj7n5bhPF
	 Ibs4dbzD/r6vISifcrYEwce2IwXFSq8OthSuxLGYKhm/i5pB+qvuwa3F9gsqFKsW9X
	 kQjE8yG2TNgZw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ignat Korchagin <ignat@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 673/715] net: veth: do not manipulate GRO when using XDP
Date: Sun, 24 Mar 2024 18:34:12 -0400
Message-ID: <20240324223455.1342824-674-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index cd4a6fe458f95..f0b2c4d5fe43a 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1533,8 +1533,6 @@ static netdev_features_t veth_fix_features(struct net_device *dev,
 		if (peer_priv->_xdp_prog)
 			features &= ~NETIF_F_GSO_SOFTWARE;
 	}
-	if (priv->_xdp_prog)
-		features |= NETIF_F_GRO;
 
 	return features;
 }
@@ -1638,14 +1636,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
@@ -1661,14 +1651,6 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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


