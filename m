Return-Path: <linux-kernel+bounces-135602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A820189C845
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:30:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47A9B1F249B0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40621411D9;
	Mon,  8 Apr 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTY9sboM"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72730140E29
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 15:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712590208; cv=none; b=PaPt+iOTX5jScWlnPFGbl+9yw281N2Y0xwgmUs9MnpQ0vXrsYE8AGE1CNzG3v9rytE52jGMVQptLG8Qm8IJXuBxL7glYxHO3NfpZ3Z9jYDybuhTZb2nlGfN/ZGfnAS5SNRCUwY5cxGSBXJvbmGmx87Nk/L6ISvONXHXyO8bfgCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712590208; c=relaxed/simple;
	bh=Smf4aywmigwysrSIcOcqw9bvaWWtvxCh+z00bSuHAcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hrQut2OPBZM6RJlRFVADZarnYUPdAdLQtKwiIb5ms1eDsDqYXb1QjpJhL7otg5esbvtBY4rq6rvEj3feslCQTuksXwyT8oitLE1RXugRlWqVy3B67xvTKhQyLzpOoZNs+lKMfpdB3/dLdSVYgTNT1JAcY/aD0gf1RmXgkEoiuUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTY9sboM; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-617fffab703so20542447b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 08:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712590205; x=1713195005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ASL93255NaCWCo+CYsAiAClfDvlTbN+MqYwKv6ZLMw=;
        b=DTY9sboMOAOcwqlrn3sZHNftQ2BkhbFHzYAvsZNA/gLR7+w4BOI1usMRk2TOG3vLDT
         WMFLaxI6BX+4faSeTIDZ85Cdo+yQRjh2qKCGyjXbU/LQSMWaMAFdn+VjUB2/9J+8ml4P
         yAlAZSxHDbvFukxxhi/MmGf5JBYIVixyvVB+S1TvFJHQBtt7dkK2kId6bbwQGsl2TOsM
         TYC1qoTbIzjL1kLz2KFjP/kyLGRKi5byYkUMrvNt4LFWakFGD4yxYlCBYsYyUb0mqxSB
         FvDHv3Ktug+l3RMjq2y2GBwG0xrFbhEpGnEeQlqnBqJnBrkhX6LHLoOKNrQWxYxfe3Lz
         3jXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712590205; x=1713195005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ASL93255NaCWCo+CYsAiAClfDvlTbN+MqYwKv6ZLMw=;
        b=ITaX0hB/IeXbULZz32GV1QUfjaP7tk4r4mzz3+SBThs34uhWtxxt33TzKQ0kE2EWf0
         Vmbm827Krfa5fp17IYjF8qEVkC8gAuFZj0bae9NgHRKl3WkJR+k2n+2cSwr5PzmYGg+u
         W11KDTMU/52K54ltOlChtx+Eohjg4YH8p+bZGNVT6mKupbHxZtEMOt68pWxE2UPM0qsp
         OnB9l3BrHuoI52bqedtOMJQI6X9L+m/RXVmZe/b6QYD9ri3Dyfdn0cQ/79F116yHZM2j
         DsF5cwTTRS0GlJf7f6GIqQE7lf8pAx7yts46A9oLGWcvoVQWwJXpFTXuub4EHHMftir/
         wSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIp4JXmOd79jlA8R2SJuQ6El/z0ONl5d6sYdpwEmLPYAueNkoRBlP2nr+GhcDNkhMNVntgMvN8nISMUG7j2/ZfM3Xr7oZ+Z++UnUTq
X-Gm-Message-State: AOJu0Ywhqc/AySo4xUfhSOrYU/TUdgsP/ymaanIfN+AwdaQz78Jokoy5
	lPmgd5jq7carG9Zc27z43/K9prYMCpxo4oxAP+LpT5IF6B6gZwfQAjmQwLkLSPtkkkeZsgRDZ+Q
	K4SM+bS/RrSAy5MH7zWFDyw==
X-Google-Smtp-Source: AGHT+IHXvDrx0RfrpDfk+CeWB/a5GDfltDvqCr1L7MJCzD0FqFc/C0bRoo7LD/8GYLg36JJS/efD6eFuQ7KRgW6Ebw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2c4:200:ca23:d62d:de32:7c93])
 (user=almasrymina job=sendgmr) by 2002:a05:6902:1108:b0:dc7:865b:22c6 with
 SMTP id o8-20020a056902110800b00dc7865b22c6mr721592ybu.8.1712590205499; Mon,
 08 Apr 2024 08:30:05 -0700 (PDT)
Date: Mon,  8 Apr 2024 08:29:56 -0700
In-Reply-To: <20240408153000.2152844-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240408153000.2152844-1-almasrymina@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240408153000.2152844-2-almasrymina@google.com>
Subject: [PATCH net-next v5 1/3] net: make napi_frag_unref reuse skb_page_unref
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, 
	John Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

The implementations of these 2 functions are almost identical. Remove
the implementation of napi_frag_unref, and make it a call into
skb_page_unref so we don't duplicate the implementation.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>

---
 include/linux/skbuff.h | 12 +++---------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 7dfb906d92f7..c0ff85bb087a 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3522,10 +3522,10 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
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
@@ -3534,13 +3534,7 @@ skb_page_unref(const struct sk_buff *skb, struct page *page)
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


