Return-Path: <linux-kernel+bounces-100493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D73D1879890
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C556B2161A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BF57E0E3;
	Tue, 12 Mar 2024 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TKm3kokM"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09BD7D3E1
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710259806; cv=none; b=SeXcFe4mh4mmOmv+TQ5veXmaLxWsICoNsLoms5XLtOhPfxQRb0u1kXoExxnaMnnGEzEytJfE7Iaeec4KTBQ2c9RphgjU8z+46MOVC23XtjS4LKXPj8Fkobev1GMhXBqFpig+vwADv7t0ODkfXgDQ2UqjflqIR8MZ3FeEclmIBVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710259806; c=relaxed/simple;
	bh=G8C1oEjdrYjzoN8BtMudNJ3vM/Hhj9cwGQ+yfqEivJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ep8p6spDuw/FeOgcFQET1rC+HoKdfd3zidp1vO4LgWrPFg24NGxJZXCKmPfFAf6xpq3fShtzadT6hrYlPZX0L4QpSQhjwdcFBmsQxanyDxSw+leUvcursjeTup5RkrXKUi+wTJzUEN+2vYBrV2P/Kv7KfQeKyO24Z2YtqA3X6LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TKm3kokM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4132a348546so14944085e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710259803; x=1710864603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8y9cotcn2YcwHYQkWcYzADrL0CgjgqPVI4Ap8W1Z/w=;
        b=TKm3kokMRVibK+WzOzuaGfhJbhQ4n22ai8Auf/duBPG0PIWjk1rm+6uH9Ga7ndfbh5
         XlejJexZyRAICGAwSM8VUg0fPlhf+gq9JDjmchvi8MYY4rY1xhAuNZnfLloOgG/nGOom
         VPGzmRrxN8apNaq9l8hPzuL6z7DNZjGCAqilVETc822LkGVPDhm2ey7UgkIGomg36wpo
         l/hq5gxqkaEmh5RRTsGicqmMl+UbMAwaMr7DHav13jyXNqvH+kFpJHDKka2po3rVrEvM
         h0zCEhk4ZJMwpXDwNFctnykCxiX1yWJbf0lQvDAtYiu6++7iHrBxY0IVfAXxGZ+OUuGB
         wuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710259803; x=1710864603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8y9cotcn2YcwHYQkWcYzADrL0CgjgqPVI4Ap8W1Z/w=;
        b=kiYo2xxoFMoxBw31WOMVRG+Qhdof77ZuiHDvQW/p7UfyUXwmI2j0DTKDEFdxgj3j32
         dr46pv4tVrAbc0WXOBu0zwWwKAqIokns27yS3FoyiEeoFzDyQyr/R+aUohI9a9Phgucj
         dxLPASFYcw0rXXCC/Id0izBNSGn1EM8K9nCdyuKFeLkP4niICdzrIo/8n59a50OSlrxZ
         MBmuQGMV2I+fzfG+GFtklEH/1w6ny92ZGfA3B74StCebypRf7UlHIz7Arb6pVN3XWJSW
         4wtGHBEcGtQd2el96fzm4iFTGJFPaH3ueiozKKeJswGZbrowig1PYW3mgQNT/m831O+y
         Hvcg==
X-Forwarded-Encrypted: i=1; AJvYcCVLK3ZmkfjZAryRDjH3CojGQl07a8d9Iye8shgvBsHQszuWnFNP58PG1m5wKZHps0b3YqlyeQIwR9Uw3LMVIy/tXrfp7nPDa5R9RNKj
X-Gm-Message-State: AOJu0YwMEGfYbaEvM24mbaBc377Vp9tdo8mzcuNvXRQsJYKGYRFT2Qy5
	9mR8K0EZMLWHtdaegU8kCQSWlnzMEBCRtOUjPgGY26MDJ/LJ544a5ICR5QWwpLk=
X-Google-Smtp-Source: AGHT+IHqfxZojQFqGYalatcTwN7r4+eqL0JqCeWkKtamZQWH4DLqUok57Uowustec7URYbqzuvnK8w==
X-Received: by 2002:a05:600c:4508:b0:413:2a10:8a29 with SMTP id t8-20020a05600c450800b004132a108a29mr4223456wmo.13.1710259802871;
        Tue, 12 Mar 2024 09:10:02 -0700 (PDT)
Received: from localhost.localdomain ([104.28.232.7])
        by smtp.gmail.com with ESMTPSA id fl8-20020a05600c0b8800b00413e523b7f9sm474253wmb.43.2024.03.12.09.10.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 12 Mar 2024 09:10:02 -0700 (PDT)
From: Ignat Korchagin <ignat@cloudflare.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	Ignat Korchagin <ignat@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH net v2 1/2] net: veth: do not manipulate GRO when using XDP
Date: Tue, 12 Mar 2024 16:05:51 +0000
Message-Id: <20240312160551.73184-2-ignat@cloudflare.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20240312160551.73184-1-ignat@cloudflare.com>
References: <20240312160551.73184-1-ignat@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

Changes in v2:
  * add Fixes reference to commit description
  * fix commit message spelling

Link: https://lore.kernel.org/lkml/20240311124015.38106-1-ignat@cloudflare.com/
Fixes: d3256efd8e8b ("veth: allow enabling NAPI even without XDP")
Fixes: fe9f801355f0 ("net: veth: clear GRO when clearing XDP even when down")
Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>
Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
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


