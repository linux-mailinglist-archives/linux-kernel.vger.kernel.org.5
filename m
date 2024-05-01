Return-Path: <linux-kernel+bounces-165372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59038B8BE0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 621791F22687
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF9212F398;
	Wed,  1 May 2024 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YinB/Tw0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546CC1758D;
	Wed,  1 May 2024 14:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714573717; cv=none; b=iCpmr4ZiTi+hGOL7llh6uH7qkPpLQuD8zz8FaHUVQzY7M31OOA9UbPno41gCDWBgY1Ul2qdZ9Gja6TxZyurGqld17DxYgpWO6fuv634NtzvNILW4XMOuy9XSA3tHSjbE5jh62VZkL7EL6fCHuc5i8e/ujB+w8i4HppCoPu1DnZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714573717; c=relaxed/simple;
	bh=FZNQ8iWfNQYPNeiTDqWByloJQKxPn8yJ9IlYcd1zXx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=at9e2u5Xy0BSIrR1u8ZB33nfZNyddfBr5U5kGTB14JAvuGQn9uCHMGx5nhHKLRYngA/1Nrg1k/0S9mMbzV4p1FCwMwDgqK1gYEuom5o2YEULachhVVNIE6jVgvjTpKNAWDrRHVk/7mWCjW4xktqiEfN2MilyutvQmWHQVe3oD6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YinB/Tw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65D81C072AA;
	Wed,  1 May 2024 14:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714573716;
	bh=FZNQ8iWfNQYPNeiTDqWByloJQKxPn8yJ9IlYcd1zXx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YinB/Tw04tiUJTptvJiGlXsCFmxozNuoBkBk6mlC8lIXjeZNi5YS3ap7Oppqi+7jo
	 QVevGt6M8z0/h1uiUuCwlKPq0CXEv0UQWWmjVAVU7PmCetSbz+wLjntcWukw4EORSt
	 TWpyfVDiTcukQezMm3zAJfu/ghZ62XUw5B4F1m0uPas78ZcZz8VIefH4hPUrFvNSE5
	 giUBZnnsVOwDgWbCrGsEBUwGd4OS75+b4ypPLd3N1Wz0AYXyLVfH/9aPp9/IuLXDIW
	 jUJge5JZ2F5oft97PhC/dRvEKOgitZIWNL6owQ1uemeRJhQIZOqiME/mvqgqqmnSwD
	 FyBwz44p3cJdA==
Date: Wed, 1 May 2024 07:28:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>, "davem@davemloft.net"
 <davem@davemloft.net>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "jacob.e.keller@intel.com"
 <jacob.e.keller@intel.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Jianbo
 Liu <jianbol@nvidia.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>
Subject: Re: [RFC PATCH] net: Fix one page_pool page leak from
 skb_frag_unref
Message-ID: <20240501072835.631dcda0@kernel.org>
In-Reply-To: <20240501072434.5720fd42@kernel.org>
References: <20240424165646.1625690-2-dtatulea@nvidia.com>
	<4ba023709249e11d97c78a98ac7db3b37f419960.camel@nvidia.com>
	<CAHS8izMbAJHatnM6SvsZVLPY+N7LgGJg03pSdNfSRFCufGh9Zg@mail.gmail.com>
	<4c20b500c2ed615aba424c0f3c7a79f5f5a04171.camel@nvidia.com>
	<20240426160557.51de91f9@kernel.org>
	<c307a3086d255d1dfed22284f500aa9fb70f11a3.camel@nvidia.com>
	<7a5a1d74040052afc8cc6cc5c2700fdf2e836b0c.camel@nvidia.com>
	<CAHS8izOsFqiSiS4Z-E-jfD70aogNp5Bcyt7Rk8xFoR2TcDjz=g@mail.gmail.com>
	<20240501072434.5720fd42@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 May 2024 07:24:34 -0700 Jakub Kicinski wrote:
> I vote #2, actually :( Or #3 make page pool ref safe to acquire
> concurrently, but that plus fixing all the places where we do crazy
> things may be tricky.
> 
> Even taking the ref is not as simple as using atomic_long_inc_not_zero()
> sadly, partly because we try to keep the refcount at one, in an apparent
> attempt to avoid dirtying the cache line twice.
> 
> So maybe partial revert to stop be bleeding and retry after more testing
> is the way to go?
> 
> I had a quick look at the code and there is also a bunch of functions
> which "shift" frags from one skb to another, without checking whether
> the pp_recycle state matches.

BTW these two refs seem to look at the wrong skb:

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0c8b82750000..afd3336928d0 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2148,7 +2148,7 @@ struct sk_buff *__pskb_copy_fclone(struct sk_buff *skb, int headroom,
 		}
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
 			skb_shinfo(n)->frags[i] = skb_shinfo(skb)->frags[i];
-			skb_frag_ref(skb, i);
+			skb_frag_ref(n, i);
 		}
 		skb_shinfo(n)->nr_frags = i;
 	}
@@ -5934,7 +5934,7 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 	 * since we set nr_frags to 0.
 	 */
 	for (i = 0; i < from_shinfo->nr_frags; i++)
-		__skb_frag_ref(&from_shinfo->frags[i], from->pp_recycle);
+		__skb_frag_ref(&from_shinfo->frags[i], to->pp_recycle);
 
 	to->truesize += delta;
 	to->len += len;

