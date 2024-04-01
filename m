Return-Path: <linux-kernel+bounces-127117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588F98946D9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:59:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD7E1C2195C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4957755C3C;
	Mon,  1 Apr 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L9kLj/g1"
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F756B6B
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008747; cv=none; b=OXw5omBxcPi+jQxSH2++qDmoT8zMEMVxJHyGoCU/BuSh60Cmf4FsXW9pFrTq6pMxXiok6zpDc7LVn1O0nOz20X47yt/A/7WezHUOzpwPA4IhUElx4TbwoFRnXarl9jnPTB0Py4TNTnFK5nCL7ytMneeZBFNQuBMg+uzvycXvGuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008747; c=relaxed/simple;
	bh=6iZBHoWjr0SW3V6W6W27wiyE26vfswz1Bipp3C2ZJ1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N0sgNr4YE9lXxB+kk8chfjS85TEkZHU6WvE2PMUMxjuI7IRNuXCd/ZGjehHHTONOXy/4fYQ+tKMN20bsaoRnPXz5DQ+8GiWQdOfls6cdQdoa+aJiH55rKilmiQOaRJx+z0AtJQ0d57axxhPjGNHanaskLVRPbmhUdov2PSxwssA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L9kLj/g1; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-789d981ae87so593669485a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712008745; x=1712613545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vXRjUgtATZ0E/Y+63Z5tthtMhFwiRvlicbw1JhZ19s0=;
        b=L9kLj/g1fdAP6hAoaF94/Z7xKSOgVPYG+zqkWsA3kE//TuYlC9nFW/SYWy3FwE8Vg3
         7go/lm2fHyEDGxDi2KwqzRA+er10Gr0Q5iYmqH1CrrwsaQ55K1rBd3s7fRTuoHu8zjmJ
         Ezb3q1PTo1zPVz0gydjRF/AvcOi8X6NZf4Rl8eUU5+sa1Ky81Y/cN0i/4SxMKEPl+6Ag
         CZG4ECo6XY5syruH0uqNDF260LE0yui8yxK+xnxTc/zg4AeJBdlrGD8Hap4LYFDSd9Gv
         nj/5+6M3rwDoPwSvUYlDfWCeCytb6WfbYmnwGU8RCvJcKUM8eLPYasM/dbK9Tg2DXNj8
         L7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712008745; x=1712613545;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXRjUgtATZ0E/Y+63Z5tthtMhFwiRvlicbw1JhZ19s0=;
        b=C+Q0N+SuMLLJ2Q8RUkdZQ+cD05SPRW4eSJWjqmPuXfohm02hefS0XSXRQCyBu9ELIQ
         7Z2kx9kdMcYc5OOoI4Cgi1NC3nnO/lDDPdouXqWbDoVC1onQIklDCug8WNkoLKaGE7Pg
         YeAR0/G88P7cj1O3rl8xEPKdI1EJos+9IBVFrMUgphEXA869nk/IX0wMoiPtxdJ9TxNH
         qA2WHMfQQoVwDIIaRMjAB3a8S7ThN6qU7fpoKUGK95m2vFLVJ9fxonHrV/82tcxvSlia
         bphH8P5qa7BJQWx0A5g0/Fu6U9hjMfHnSfOxHipxtCPmTxzZoqqQO1HjYjTJNW6j4A8A
         3U6g==
X-Forwarded-Encrypted: i=1; AJvYcCXfzpFM4VgJNHPfJoG01YMWQL9Q9Y2vSGLHcFzRJDkAyCXQyBI3oWS2sm5u+Hwie4IGD+/u/M6XjDXeJYX+Uh0AOsM3Dk7UPp0rlOAA
X-Gm-Message-State: AOJu0YzgMOPEaZ+8DX80M13TihzL0BnfNh2k5AxNQ3AiMZA6Z9mNNYz0
	GE+kIPf/0mWA32xzqWIwgZf1Q+Yz4f9d0LjNGzugc7MDVmJZBCaT2ppfqua9uRkQBUWva+Tllc0
	MFNJPj0Ny2LCKFZEOt/rKFg==
X-Google-Smtp-Source: AGHT+IFGadfogXIS8kOngK5G9vWIutCMBx8L4gKWUrm8XeH+h8lfoSVo1ljXz4C/IkewoV3oHHDRSuJKCxCHbdkprQ==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:b337:405b:46e7:9bd9])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:72d:b0:dc8:5e26:f4d7 with
 SMTP id l13-20020a056902072d00b00dc85e26f4d7mr3443884ybt.13.1712008248349;
 Mon, 01 Apr 2024 14:50:48 -0700 (PDT)
Date: Mon,  1 Apr 2024 14:50:37 -0700
In-Reply-To: <20240401215042.1877541-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240401215042.1877541-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240401215042.1877541-2-almasrymina@google.com>
Subject: [PATCH net-next v3 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Mirko Lindner <mlindner@marvell.com>, Stephen Hemminger <stephen@networkplumber.org>, 
	Tariq Toukan <tariqt@nvidia.com>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Maxim Mikityanskiy <maxtram95@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Simon Horman <horms@kernel.org>, 
	Yunsheng Lin <linyunsheng@huawei.com>, 
	"=?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?=" <nabijaczleweli@nabijaczleweli.xyz>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, David Howells <dhowells@redhat.com>, 
	Florian Westphal <fw@strlen.de>, Aleksander Lobakin <aleksander.lobakin@intel.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Johannes Berg <johannes.berg@intel.com>, 
	Liang Chen <liangchen.linux@gmail.com>
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
index b7f1ecdaec38..a6b5596dc0cb 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3513,10 +3513,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 bool napi_pp_put_page(struct page *page, bool napi_safe);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+skb_page_unref(struct page *page, bool recycle, bool napi_safe)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page, napi_safe))
 		return;
 #endif
 	put_page(page);
@@ -3525,13 +3525,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
 static inline void
 napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
 {
-	struct page *page = skb_frag_page(frag);
-
-#ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
-		return;
-#endif
-	put_page(page);
+	skb_page_unref(skb_frag_page(frag), recycle, napi_safe);
 }
 
 /**
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..3d2c252c5570 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..4fe4f97f5420 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(sg_page(sg), skb->pp_recycle, false);
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0.478.gd926399ef9-goog


