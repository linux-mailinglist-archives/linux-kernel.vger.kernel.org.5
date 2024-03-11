Return-Path: <linux-kernel+bounces-98835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DC7878014
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53FDB1C211C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 12:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600E83B7AC;
	Mon, 11 Mar 2024 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KWjn9wkd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7D425755
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710160842; cv=none; b=kFqaeBfo4q2zhHUHOhWc7/h8IHItVm8i+GyWKDER2BkwOXZwN8KbaxOvisV07n7pS8aTaqOnJQD1GD/o/nm7leAZdXEhYHj9eB1tXo7VTlvYqWi9ZDueZSTLhC4GMSbv8b7lrUjuXRQ+RMZicBERaXGdRr+M24ZgckUiAeMjGDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710160842; c=relaxed/simple;
	bh=7iyN0obiYCS+6q+ebCFwc+JmlfO9przc4D5Z134DvjU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=n/3r6Re6tNFJu5dHpFk2GOTrxsDnUvOdHF1SpkJ71bOYnh9JfN7ONdAoRbOy866dK+5qDeXU7rVpXOQX4yY3bh7/JA1ECD0w/+14MPJq7zC4844uPXeE5V2ynBkjXyangvCrrBg5ufr0QX15Mmns8YHn/LotJP2lp5Rq4HtDW9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KWjn9wkd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4132a348546so4550225e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710160838; x=1710765638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CUeKqYGVxUsunuJQG4tec02NEsEnm7zmFbvtCQVCYHg=;
        b=KWjn9wkdgjPZq1ztzOIEVSE13iOZsXsTh5/YI8IZDivNa4MjLRiLEEMeABVrAKzl0A
         jKf9+nudKWBe1fiBGwzYtsTIYFKP03YfzI6aXpYHU7Hi9xHC/a6iLkmEkfzCevG2jwt2
         FyvpDz8SsstPvhPnDksUZ3hJMgl1NtC3VBDLgdeWolwojqfj0p1C3AVWhW+cdw4KpYoJ
         9pXJA2uRqrlk7ADdwCKezhNYeEFLic/FNZ29tdTYS9fSEscLjY14Ap7sJ7bmkoHVL9Ze
         cMB752GZXnwq5Uvqdd3x7SRiJwVmPkN/Xs19y++G4cVnFdIE4FEeL8YFftEFVXN98/HD
         GB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710160838; x=1710765638;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CUeKqYGVxUsunuJQG4tec02NEsEnm7zmFbvtCQVCYHg=;
        b=gbiqnx+ilFrktIMp0cvJSe8f6bigyeXLQ0Q7gKXhQJt9F8P1S9JxT/m5pCBolsp7KV
         HMmPjN5AdE2+/jHP4bUO/+Yo08OtmS3iOE6bL8iipc8ESdYX6Mm455HHn+wqByZXJvu4
         BaByMQ3CGeFDsUJemk1BKDmzdCtnQptF8+GKEBLtoGQdDQsTxxNdVe64jKcAfbZn+3Mu
         5ueTqL1PJVBynEy8HhdzUKt6pK6R2AyDVZO9CSVQQwilEIKo1ZkI3C/qeUnY9/u8xCMe
         pYdq2a1wtRElstSXYQ5EwakRku60o7Tm6Kphu5wfYDYPpTSySzzbuVCTvrPVeNL3V089
         XIHw==
X-Forwarded-Encrypted: i=1; AJvYcCXvFbyU++Ipk2tQcHOeWC2XxItPT10wzz1vw129ia5+R95R/tKghBk5GbQjUhokWSZhWTvWs4LSgxL8qU1T2ovqC4fnuP4874IXkfim
X-Gm-Message-State: AOJu0YxdyQrdYJ3o6RyBuOEiifKtt/sc+2YOKuzAgv+ej+VOzHaLHI5q
	ollQxt196+f87RMtb4FLoXfinoLsAm5QrN/Vcb74xpmC5bFw8OY+cTo1Orvvtr4=
X-Google-Smtp-Source: AGHT+IGrWrKeOoeIXZ88Juws7JMAQU223c+6sOcyECtWdOTk8c7M3KTrvXuOfFZ0ZFTmwCOXsQgdNg==
X-Received: by 2002:a05:600c:358f:b0:413:216c:9d67 with SMTP id p15-20020a05600c358f00b00413216c9d67mr4729237wmq.14.1710160838502;
        Mon, 11 Mar 2024 05:40:38 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.6])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c358e00b00412d4c8b743sm8983383wmq.30.2024.03.11.05.40.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 11 Mar 2024 05:40:37 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>
Subject: [PATCH] net: veth: do not manipulate GRO when using XDP
Date: Mon, 11 Mar 2024 12:40:15 +0000
Message-Id: <20240311124015.38106-1-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit d3256efd8e8b ("veth: allow enabling NAPI even without XDP") tried to fix
the fact that GRO was not possible without XDP, because veth did not use NAPI
without XDP. However, it also introduced the behaviour that GRO is always
enabled, when XDP is enabled.

While it might be desired for most cases, it is confusing for the user at best
as the GRO flag sudddenly changes, when an XDP program is attached. It also
introduces some complexities in state management as was partially addressed in
commit fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down").

But the biggest problem is that it is not possible to disable GRO at all, when
an XDP program is attached, which might be needed for some use cases.

Fix this by not touching the GRO flag on XDP enable/disable as the code already
supports switching to NAPI if either GRO or XDP is requested.

Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
---
 drivers/net/veth.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index cd4a6fe458f9..f0b2c4d5fe43 100644
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
2.39.2


