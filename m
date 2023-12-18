Return-Path: <linux-kernel+bounces-3180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC960816873
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 09:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 143AD1C2261E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770B5107BC;
	Mon, 18 Dec 2023 08:43:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAA9111C91;
	Mon, 18 Dec 2023 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-7 (Coremail) with SMTP id AQAAfwBnbmoeBoBlde5bAw--.9111S2;
	Mon, 18 Dec 2023 16:43:10 +0800 (CST)
Received: from phytium.com.cn (unknown [111.160.237.26])
	by mail (Coremail) with SMTP id AQAAfwDXjmgYBoBloWMAAA--.124S3;
	Mon, 18 Dec 2023 16:43:04 +0800 (CST)
From: Zhang Yiqun <zhangyiqun@phytium.com.cn>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhang Yiqun <zhangyiqun@phytium.com.cn>
Subject: [PATCH] xfrm: Use spin_lock_bh() in xfrm_input()
Date: Mon, 18 Dec 2023 16:42:52 +0800
Message-Id: <20231218084252.7644-1-zhangyiqun@phytium.com.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:AQAAfwDXjmgYBoBloWMAAA--.124S3
X-CM-SenderInfo: x2kd0wp1lt30o6sk53xlxphulrpou0/
Authentication-Results: hzbj-icmmx-7; spf=neutral smtp.mail=zhangyiqun
	@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvdXoW7Jr4kCr4rKF4DAry7tF1kKrg_yoWkXFg_ur
	yfWay8GwnIqrnaya1kJwsxJr1q9w4fXFWxWry2yrZrXryxX3s5X3yI9ry5Ar4xuF48uas5
	uFyqqrZ7Gw129jkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8wcxFpf9Il3svdxBIdaVrnU
	Uv73VFW2AGmfu7jjvjm3AaLaJ3UjIYCTnIWjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRUUUUU
	UUUU=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This patch is to change spin_lock() into spin_lock_bh(), which can
disable bottem half in calling. If we leave this as spin_lock(),
it may stuck in a deadlock, because the callback in bottem half in
crypto driver will also call xfrm_input() again.

Signed-off-by: Zhang Yiqun <zhangyiqun@phytium.com.cn>
---
 net/xfrm/xfrm_input.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index bd4ce21d76d7..f4cd46d73b1e 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -581,7 +581,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		}
 
 lock:
-		spin_lock(&x->lock);
+		spin_lock_bh(&x->lock);
 
 		if (unlikely(x->km.state != XFRM_STATE_VALID)) {
 			if (x->km.state == XFRM_STATE_ACQ)
@@ -607,7 +607,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			goto drop_unlock;
 		}
 
-		spin_unlock(&x->lock);
+		spin_unlock_bh(&x->lock);
 
 		if (xfrm_tunnel_check(skb, x, family)) {
 			XFRM_INC_STATS(net, LINUX_MIB_XFRMINSTATEMODEERROR);
-- 
2.17.1


