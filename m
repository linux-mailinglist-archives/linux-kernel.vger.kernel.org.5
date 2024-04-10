Return-Path: <linux-kernel+bounces-137794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA4389E7BB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 03:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2676B2224C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B910D1388;
	Wed, 10 Apr 2024 01:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzKneyhx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D13623;
	Wed, 10 Apr 2024 01:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712712184; cv=none; b=U9xRYlQGYSHJAr1TdL031wKGNn15S9xYxuA4Yy1jQVVgCOwmEzF1iBDvsxvF9bfL12hZDBBFFYjfgIlmkn2POcraEB+dP2P2KN+XCvik9W4FhV5jAolsHQshRC46TPdL4keZ50PZ6cYZ0bXkGBOOMKbf/sGvtK3Cv8eN0WcQcdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712712184; c=relaxed/simple;
	bh=gGDtkr3EW72+N26cNWxqd4eoTm7khCsAlYGmZPzNCeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BYZdH58fWti/3x6b0L4XHzDaVjpVCRhSe6OEiSBhVQSZ0L6NHrJaES1ADvRmEX8HBcyIoShg/thW64jvmavgMVt/rQrbGfoRU+Nm0eTaIVT8daiP/f1aDD7vZxsWg26YEj5zg4fBfcdlT33eKUK5ao2HpTExeU5VBA5eEdtXxyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzKneyhx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AC6C433F1;
	Wed, 10 Apr 2024 01:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712712183;
	bh=gGDtkr3EW72+N26cNWxqd4eoTm7khCsAlYGmZPzNCeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FzKneyhxcyzOmFRbLdpgjbFHy0DfjwXGlpN/ZgB+FwK6RmhTEl6QFZ/QX0I8tSHpB
	 LX/oX8n0bPWeR7+1aJAhuF61fGuDRmemIdOJ9maF8fWJ5ZIKiFHY8Ed7eAXxVrVHyT
	 5Htac4d/0cySawF05grv2j19SsrmJPcFII0QZk8Eg2nwA1DelJnULbiOxAH2R9fVQx
	 h5wrqbaCi9qgW/MxgeWPgcr79/dqYef8zKwtca/i2JXaXUdBXDRHyUlWLldsO0kYDE
	 AODhm+DjGUtxaBi+lze0h3iokjAMWbElebTt7f2pQ0rma2Ad8m2vn6hFTDUfNhpoAx
	 EpmskHieSvB4w==
Date: Tue, 9 Apr 2024 18:23:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Ayush Sawal
 <ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 David Ahern <dsahern@kernel.org>, Boris Pismenny <borisp@nvidia.com>, John
 Fastabend <john.fastabend@gmail.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH net-next v5 2/3] net: mirror skb frag ref/unref helpers
Message-ID: <20240409182301.227c9ff7@kernel.org>
In-Reply-To: <20240408153000.2152844-3-almasrymina@google.com>
References: <20240408153000.2152844-1-almasrymina@google.com>
	<20240408153000.2152844-3-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 08:29:57 -0700 Mina Almasry wrote:
> +#ifdef CONFIG_PAGE_POOL
> +static inline bool is_pp_page(struct page *page)
> +{
> +	return (page->pp_magic & ~0x3UL) == PP_SIGNATURE;
> +}
> +
> +/* page_pool_unref_page() lives in net/page_pool/helpers.h */
> +static inline void page_pool_ref_page(struct page *page)
> +{
> +	atomic_long_inc(&page->pp_ref_count);
> +}
> +
> +static inline bool napi_pp_get_page(struct page *page)
> +{
> +	page = compound_head(page);
> +
> +	if (!is_pp_page(page))
> +		return false;
> +
> +	page_pool_ref_page(page);
> +	return true;
> +}
> +#endif
> +
> +static inline void skb_page_ref(struct page *page, bool recycle)
> +{
> +#ifdef CONFIG_PAGE_POOL
> +	if (recycle && napi_pp_get_page(page))
> +		return;
> +#endif
> +	get_page(page);
> +}

Shifting of all this code from pp to skbuff catches the eye.
There aren't that many callers to these, can we start a new header?
We can then include page pool headers in the without worry.

I'll apply the other patches, they look independent.

