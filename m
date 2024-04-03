Return-Path: <linux-kernel+bounces-130092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06DE897403
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6E28DD1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF2B14AD12;
	Wed,  3 Apr 2024 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4bFNfmse"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B162E14A0A0
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712158133; cv=none; b=GZnjWaC7qERim67OjyFWCVDwgcScCEZqInhM9GgmqL1wNgNjhtCg7P/DGLwWnt0LrjOEBg3OSbCIVCSfyqdLbNmadDWM1JUtjNelZhmhpfIMxmHfJF4gSU9XJso2Lk/pnZrKxrBXxW39Hg4Fgk/NRwu6fJOadVG6QIQ4+L3cdFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712158133; c=relaxed/simple;
	bh=qI/WTLfanKJmZ34UlJ0XO8JlnMX3COqXLh2LGzSj/Tk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AKIx8LADXM1I5+bLa1IW2wsV/rB5NPi3LWJPBfwgxWcDAxrJlnp7z27l3zKtYrV5d/p0BTZlmnJYCIpJFs8RzGiFDRndCBUxb8ElFEkWeD8CezMHHFasAhDjXXS68b/sGktuhLPFMpwM2xxaN+mAYhfYwbrPW5lGvDchi2LG1M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4bFNfmse; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60cd62fa1f9so97191547b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 08:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712158129; x=1712762929; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f30V4mJ6zBXpnDX7YMJN+GSwZJV8AwOhj9hRQ6MYBsI=;
        b=4bFNfmsetopb+Y3QWCUFAzneGbVAAsKjY9q5WCpX1tbkCA2GlF/360bWElCPfey7EW
         87+vrRjmTZeIdtP6RTbKrneLRl9MsROMOfHi4hmWXWS6ThQNsNb/AV+Y2Nv2LomCLZ2D
         8xkc4kQqL/2Y0Mzp4obBaruZK2K13HmL7mA3jJcQIllpTkDX+F54HenDCqHGeDEaXkpg
         lipb253vKh6elxJRXsku3Z6YPRQxrdfVaBod3U+3OklRAILr/nzyDWShba+dOqOh0XLr
         M7BTgWClayRto0MX7WSi+/iTD6mG9hbmQgwp2sF5+89BZz17MUOuB0C+xVYM+vpybSNJ
         qfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712158129; x=1712762929;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f30V4mJ6zBXpnDX7YMJN+GSwZJV8AwOhj9hRQ6MYBsI=;
        b=uT94xaklu6vLKMwb7GhenFtmTKTA1FgzZg4B8OJy6lIQ+G1KPPLcMIdpbrSk4UIb+X
         R7bzno4GYf9qaxiyD5FVKeHU2Tr2E9OO4TLqMKOUWrNEv1pWv6hWFvSSF4j7Lyy7gScy
         Gi60L2Bryl43WLXVFkRlhIXVoNRF5h+SIrqS3rpxu7Djt/Cs2AbmISGZnN85cEX2R0aS
         xohVyoT15199roIDup/Z0G4sE0ZNdQgowjVjjjPhL4wBjULtesq4WOYEAj/vTPbEC9qR
         kmZgX8RSUOuTRlzG8jpDVqNJRzr7RBra8r+Lq9Zb+Ut/7nCCW7g3161jXOc7Hee3cuwO
         uw0A==
X-Forwarded-Encrypted: i=1; AJvYcCV+jA232pCO2uI7GRsY97layWv3UrxXBYkx9Aef+r0m0NuY+CwcRibS6b+F/TToKJ0yz2i+EjrQ7XQFdNjQgxcpE4JvLkKy+pvIOFg3
X-Gm-Message-State: AOJu0Yw8ngS93u7whw+S4q2ydILuRxon5twxBFQHfWYylqwEu9B7l2hq
	y/pOMczjb2eSzrzreQQnCt0EAG8u5tO7u9jqSuTI8vwxQFPdEUUkdm4QR+n6L8jI7MlKzZPaQqa
	mPNndlt1bW807xaJ+rFDb1A==
X-Google-Smtp-Source: AGHT+IGzZVWQFKGFPRlSV+1U40c2zc08NGC6CIm6+7ow+62WSgAyqJwDMpv69O41zQOGQ11r0GAMxvoCgYHdQi/kIQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:1726:7620:90a1:78b9])
 (user=almasrymina job=sendgmr) by 2002:a81:9a93:0:b0:610:3b7a:c179 with SMTP
 id r141-20020a819a93000000b006103b7ac179mr3808941ywg.8.1712158129686; Wed, 03
 Apr 2024 08:28:49 -0700 (PDT)
Date: Wed,  3 Apr 2024 08:28:40 -0700
In-Reply-To: <20240403152844.4061814-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240403152844.4061814-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240403152844.4061814-2-almasrymina@google.com>
Subject: [PATCH net-next v4 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Florian Westphal <fw@strlen.de>, David Howells <dhowells@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Content-Type: text/plain; charset="UTF-8"

The implementations of these 2 functions are almost identical. Remove
the implementation of napi_frag_unref, and make it a call into
skb_page_unref so we don't duplicate the implementation.

Signed-off-by: Mina Almasry <almasrymina@google.com>

---
 include/linux/skbuff.h | 12 +++---------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 03ea36a82cdd..7dcbd27e1497 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3513,10 +3513,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page)
+skb_page_unref(struct page *page, bool recycle)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page))
+	if (recycle && napi_pp_put_page(page))
 		return;
 #endif
 	put_page(page);
@@ -3525,13 +3525,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle)
 {
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page))
-		return;
-#endif
-	put_page(page);
+	skb_page_unref(skb_frag_page(frag), recycle);
 }
 
 /**
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index 3d647c9a7a21..40330253f076 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg));
+			skb_page_unref(sg_page(sg), skb->pp_recycle);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index fe8d53f5a5ee..fb431d0a3475 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg));
+			skb_page_unref(sg_page(sg), skb->pp_recycle);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.478.gd926399ef9-goog


