Return-Path: <linux-kernel+bounces-131939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE4D898DBF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A19E8B280C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C46130E47;
	Thu,  4 Apr 2024 18:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cg6TSTq5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E9512FF9E;
	Thu,  4 Apr 2024 18:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254129; cv=none; b=n/ps0Ggka8KG2kOWd8fLg5L2hV+LaKb9du8wGgSUm8LmH/lHa/pT4X6Pn3lwKL+CAzO5QBa1uNJsHn3gaeSY28sZVYy7PzKQwzKxYo7p65IjkajxEuLsc+BCW9Jd2Qm+sdV0rLKnbvXUsziGqH6Nt9ug7ehrPZNB1v3dXztxTtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254129; c=relaxed/simple;
	bh=RpP+y2wWHWREDK0ERlTy3wMqea7M9kmE8ZvKoZA+kn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPhWsv725M+wlLkTs3WFFTMHm5auMZUMkHvs7N/pS54ChS8bzqAmQewBKRE+Gnu1c8qzHzKwyoqpjR7zFKuHidcQn6QH58khWeqNJMrhgfue7peuxbu2+m2dgu9vu/GFnnQ0w0wzZWTKyWROwpamZjqU0EI/lbIo4DixLnNVt94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cg6TSTq5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74D68C433F1;
	Thu,  4 Apr 2024 18:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712254129;
	bh=RpP+y2wWHWREDK0ERlTy3wMqea7M9kmE8ZvKoZA+kn0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cg6TSTq5MEwcNpABq5SbGDs2gh+SB90dyP0i6uHPL0gTcYYP3y7wWrLedTLjXVSQo
	 0eCcszGR4TMQ8YcXYgZSAI7HMsQFkm5uAvUHNiexwBmlXTNMNuS8pWK+v7idMOi0I+
	 e2mStKINe8EX5MHsD5aKu4Mpxs3/Ua3YLAcrcntW56jAyic7FdG11S66fhEOrUFM+9
	 QItDOoXRLrP10xm5KjRUp7b1In31JbJfBo0Z+Hs1WjnhuRA4d/vmWawUIrvKwg3fuc
	 1pLzHNZDqw3o+Kf195WcG0kEgID+wawScjKdpt5lUHbDF74V9QQBiH/Gj1xLtEfxZG
	 OiQB04fGtOslg==
Message-ID: <26c51418-0807-4e29-bc48-06a1e31f8016@kernel.org>
Date: Thu, 4 Apr 2024 12:08:47 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] ip6_vti: Do not use custom stat allocator
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240404125254.2978650-1-leitao@debian.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240404125254.2978650-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/4/24 6:52 AM, Breno Leitao wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> Remove the allocation in the ip6_vti and leverage the network
> core allocation instead.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/ipv6/ip6_vti.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)

Reviewed-by: David Ahern <dsahern@kernel.org>



