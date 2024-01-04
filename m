Return-Path: <linux-kernel+bounces-17327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0EB824BD2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5916B23635
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA762D602;
	Thu,  4 Jan 2024 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="izwqJq+K";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="RstD/2Z/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx-lax3-3.ucr.edu (mx.ucr.edu [169.235.156.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181C2D049
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1704410879; x=1735946879;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3U6IBgqMPfYIU4Ebli3H3Dr97CK+nUXKQyDxoPdswBE=;
  b=izwqJq+KNpGks3isHl+ulSZ1kHBtJShirkIanb4zrSdTGNa+vSI3dSdF
   NcA96OvNbTCqKg/xzb+H0CbYFe1uqa7CcXuF1zBhiCxQ8ktUFujLjSyZ4
   tvN2SRThXolLo1tpFzrJp7bV6cJO5JdOZrTwhBYauIU3J/rAYEMPD8yhx
   Bu/hXYEQZ9q2Vhh62KfgI2uk6RNEPUTRFsYz3CRWTEVQjKbi2v6WJPpLQ
   i2gQ/4XGPVF3DlVrf6M4BP1o/u7nbtd54/IT3YO64zlUNNX+bbBEF9lxb
   og5Rrd1if3yN4oLH0qQMleIwdtJTmAsXUoA+CCwdKgbpbh7tBz3oeYNSn
   w==;
X-CSE-ConnectionGUID: 6uLUXgGNQHy80PPeEzqVpg==
X-CSE-MsgGUID: QvyU+TgHSH6ojDaiqU8M9A==
Received: from mail-oo1-f69.google.com ([209.85.161.69])
  by smtp-lax3-3.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jan 2024 15:26:50 -0800
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-594ed6d469cso1056716eaf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 15:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1704410809; x=1705015609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u4Dw0mTClgaFsB3U7t+HPsmZwI4wTqyqXn3PwWakYqU=;
        b=RstD/2Z/w2hON0CUvAYeMaOEOBH9Drov3L2VSLyouZQekBwOMuBXbog9urxjSkZPx2
         XIpCqMbsJ/FuqbMVMx/zfUZ+O6ZQiqmucLlHr49mck53To+Jl4qfQTRFJUgUd1HyikDE
         pjfl/DCUawsGEwOUJViSzYl7TaSj58AYkHJOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704410809; x=1705015609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u4Dw0mTClgaFsB3U7t+HPsmZwI4wTqyqXn3PwWakYqU=;
        b=Tr31yU10lnT2EGLTYFlW4wCd/Zd9rPLRyZS7swd1M+YGefUeLAj6Te27Vnm06OUH8P
         nnMW0YvTJ+LbGjk6N2aGPbplLBw0vSVq2IKGarSBSooqvcZfish3fBfl1vHImjiNXOfG
         4oFXoqbdPS2mxxBPMuYlebvYqn4Ru5QfaW9dLgofuTraMpR7NgNAXkoBvv6gbcM8KUnW
         xTb8QZBVIZukJBZIWT3Ezu7HUXm0lo3YF2dCxxXHX2JwxvvNLu9hWLdhqt+ndA70w5bb
         57MZjDoF/9ckuXv8BZGtUTt/MuZyHuCtQjhjBcdCSvWe8H/SkcZkavqBWMVlKck6XlPU
         fSVw==
X-Gm-Message-State: AOJu0YwvJWR2G5C7CVKM4Acb+QZ0+9FSbdVuKTKtZ+OqLz3EbYyF/mD/
	VIqfoB6F6iGAFlEC2f9TvL898I61uiKX12GGl6aPrepUGu3knNaYbMfzThDy771xk9873eaFlg+
	QyCz+5l0SHS3xzBA6TB70h0t/qBG5MauU6g==
X-Received: by 2002:a05:6358:60c4:b0:170:daa8:576e with SMTP id i4-20020a05635860c400b00170daa8576emr1148695rwi.47.1704410808986;
        Thu, 04 Jan 2024 15:26:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGDMbmb56woVxFKjGUQ/hq719tA9RHlVqnPTXOSn9/x5agag9e0eThcPLTidjJSnU0iJw7oEw==
X-Received: by 2002:a05:6358:60c4:b0:170:daa8:576e with SMTP id i4-20020a05635860c400b00170daa8576emr1148692rwi.47.1704410808599;
        Thu, 04 Jan 2024 15:26:48 -0800 (PST)
Received: from localhost (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.gmail.com with UTF8SMTPSA id a5-20020a636605000000b0059d34fb9ccasm224141pgc.2.2024.01.04.15.26.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 15:26:48 -0800 (PST)
From: Xiaochen Zou <xzou017@ucr.edu>
To: davem@davemloft.net
Cc: dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiaochen Zou <xzou017@ucr.edu>
Subject: [PATCH] net: gre: complete lockless access to dev->needed_headroom
Date: Thu,  4 Jan 2024 15:27:14 -0800
Message-Id: <20240104232714.619657-1-xzou017@ucr.edu>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to 4b397c06cb9 (net: tunnels: annotate lockless
accesses to dev->needed_headroom), we need to use lockless
access to protect dev->needed_headroom from data racing.
This patch complete the changes in ip(6)_gre.

More changes in other modules might be needed for completeness.

Signed-off-by: Xiaochen Zou <xzou017@ucr.edu>
---
 net/ipv4/ip_gre.c  | 12 ++++++------
 net/ipv6/ip6_gre.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
index 5169c3c72cff..8c979c421d79 100644
--- a/net/ipv4/ip_gre.c
+++ b/net/ipv4/ip_gre.c
@@ -491,7 +491,7 @@ static void gre_fb_xmit(struct sk_buff *skb, struct net_device *dev,
 	key = &tun_info->key;
 	tunnel_hlen = gre_calc_hlen(key->tun_flags);
 
-	if (skb_cow_head(skb, dev->needed_headroom))
+	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
 		goto err_free_skb;
 
 	/* Push Tunnel header. */
@@ -541,7 +541,7 @@ static void erspan_fb_xmit(struct sk_buff *skb, struct net_device *dev)
 	version = md->version;
 	tunnel_hlen = 8 + erspan_hdr_len(version);
 
-	if (skb_cow_head(skb, dev->needed_headroom))
+	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
 		goto err_free_skb;
 
 	if (gre_handle_offloads(skb, false))
@@ -653,7 +653,7 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
 		    skb_checksum_start(skb) < skb->data)
 			goto free_skb;
 	} else {
-		if (skb_cow_head(skb, dev->needed_headroom))
+		if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
 			goto free_skb;
 
 		tnl_params = &tunnel->parms.iph;
@@ -689,7 +689,7 @@ static netdev_tx_t erspan_xmit(struct sk_buff *skb,
 	if (gre_handle_offloads(skb, false))
 		goto free_skb;
 
-	if (skb_cow_head(skb, dev->needed_headroom))
+	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
 		goto free_skb;
 
 	if (skb->len > dev->mtu + dev->hard_header_len) {
@@ -742,7 +742,7 @@ static netdev_tx_t gre_tap_xmit(struct sk_buff *skb,
 	if (gre_handle_offloads(skb, !!(tunnel->parms.o_flags & TUNNEL_CSUM)))
 		goto free_skb;
 
-	if (skb_cow_head(skb, dev->needed_headroom))
+	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom)))
 		goto free_skb;
 
 	__gre_xmit(skb, dev, &tunnel->parms.iph, htons(ETH_P_TEB));
@@ -768,7 +768,7 @@ static void ipgre_link_update(struct net_device *dev, bool set_mtu)
 	if (dev->header_ops)
 		dev->hard_header_len += len;
 	else
-		dev->needed_headroom += len;
+		WRITE_ONCE(dev->needed_headroom, dev->needed_headroom + len);
 
 	if (set_mtu)
 		dev->mtu = max_t(int, dev->mtu - len, 68);
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 070d87abf7c0..8c060591641d 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -782,7 +782,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 			(TUNNEL_CSUM | TUNNEL_KEY | TUNNEL_SEQ);
 		tun_hlen = gre_calc_hlen(flags);
 
-		if (skb_cow_head(skb, dev->needed_headroom ?: tun_hlen + tunnel->encap_hlen))
+		if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom) ?: tun_hlen + tunnel->encap_hlen))
 			return -ENOMEM;
 
 		gre_build_header(skb, tun_hlen,
@@ -792,7 +792,7 @@ static netdev_tx_t __gre6_xmit(struct sk_buff *skb,
 						      : 0);
 
 	} else {
-		if (skb_cow_head(skb, dev->needed_headroom ?: tunnel->hlen))
+		if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom) ?: tunnel->hlen))
 			return -ENOMEM;
 
 		flags = tunnel->parms.o_flags;
@@ -976,7 +976,7 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			truncate = true;
 	}
 
-	if (skb_cow_head(skb, dev->needed_headroom ?: t->hlen))
+	if (skb_cow_head(skb, READ_ONCE(dev->needed_headroom) ?: t->hlen))
 		goto tx_err;
 
 	t->parms.o_flags &= ~TUNNEL_KEY;
@@ -1153,7 +1153,7 @@ static void ip6gre_tnl_link_config_route(struct ip6_tnl *t, int set_mtu,
 			if (t->dev->header_ops)
 				dev->hard_header_len = dst_len;
 			else
-				dev->needed_headroom = dst_len;
+				WRITE_ONCE(dev->needed_headroom, dst_len);
 
 			if (set_mtu) {
 				int mtu = rt->dst.dev->mtu - t_hlen;
@@ -1184,7 +1184,7 @@ static int ip6gre_calc_hlen(struct ip6_tnl *tunnel)
 	if (tunnel->dev->header_ops)
 		tunnel->dev->hard_header_len = LL_MAX_HEADER + t_hlen;
 	else
-		tunnel->dev->needed_headroom = LL_MAX_HEADER + t_hlen;
+		WRITE_ONCE(tunnel->dev->needed_headroom, LL_MAX_HEADER + t_hlen);
 
 	return t_hlen;
 }
@@ -1864,7 +1864,7 @@ static int ip6erspan_calc_hlen(struct ip6_tnl *tunnel)
 		       erspan_hdr_len(tunnel->parms.erspan_ver);
 
 	t_hlen = tunnel->hlen + sizeof(struct ipv6hdr);
-	tunnel->dev->needed_headroom = LL_MAX_HEADER + t_hlen;
+	WRITE_ONCE(tunnel->dev->needed_headroom, LL_MAX_HEADER + t_hlen);
 	return t_hlen;
 }
 
-- 
2.25.1


