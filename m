Return-Path: <linux-kernel+bounces-96117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E1A875755
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461551C20F49
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9272C137763;
	Thu,  7 Mar 2024 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOA5lQQA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81EF135A56;
	Thu,  7 Mar 2024 19:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709840215; cv=none; b=WuK7hxmoXh6ye7GAkAHbL9fm6TxW3WM3fdn3QBjvMxPrI+D4M9TAc2XmlNqZvxqYXWZnFzBuWabclwkUjjhYqEc/zOW2Gx/BrFTHzyw6k1od+/Iu2OOSf0cyfGnK+nPtWP59zVSJHA8erl/Abx6u2luLSREQTEdjbW59z/hEqR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709840215; c=relaxed/simple;
	bh=1KgGaAOEWbovalkj+qhFZ1YtOmYOmUKmUqLvlOtisHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1AoJp9tSiOKbvdeMDq9VY7qeGCiWJspkjjyZrLZDGx7GT1XULfFxXa+qAvAcAzJJZkvvnLlNFkhxsINRGbyaiGcFf/Ty5lI5D00JPab78dzT8weKNlwyLSdI6roElnlqLN+aIgxo1ftEwxitUngOqwg0RjNiSjLNWqWTf2kCRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOA5lQQA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3F2C433F1;
	Thu,  7 Mar 2024 19:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709840215;
	bh=1KgGaAOEWbovalkj+qhFZ1YtOmYOmUKmUqLvlOtisHQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tOA5lQQAX0B3LhpjtoXKJRjGQ85CeIUnjIZ0wkJcN5D+SORITfOESXruD0j0BFK/E
	 0UKY9dgzyyXDFzMgO8Px+GltHCeGcnat3LXBWdjEoetCR4/yG4rNPwQr4QhN1pvkfw
	 E3eHtLIlMHsJjwiwSjPVoO/UWqK1XN3oTD9xmJBjpxywjZocsZgd8uh+9yxFImk532
	 bCNIQevs5HSINTFzWTo76AegUv9XbnEgBo1qitZJsAjpDqEheNrzKURhWUX36P6x2t
	 9TZX3kCp85qoFhPhZtsGH+vT/1YFk/37Pd2qdLZ6aPLRejdf3M3usNwAEM/naXI2YQ
	 ke5B1CuE3sIww==
Message-ID: <5487d52a-31de-4422-b5ed-a59390d23ca0@kernel.org>
Date: Thu, 7 Mar 2024 12:36:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] ipv6: fib6_rules: flush route cache when rule is
 changed
Content-Language: en-US
To: Shiming Cheng <shiming.cheng@mediatek.com>, jiri@resnulli.us,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Lena Wang <lena.wang@mediatek.com>
References: <20240307100157.29699-1-shiming.cheng@mediatek.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240307100157.29699-1-shiming.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/7/24 3:01 AM, Shiming Cheng wrote:
> When rule policy is changed, ipv6 socket cache is not refreshed.
> The sock's skb still uses a outdated route cache and was sent to
> a wrong interface.
> 
> To avoid this error we should update fib node's version when
> rule is changed. Then skb's route will be reroute checked as
> route cache version is already different with fib node version.
> The route cache is refreshed to match the latest rule.
> 
> Fixes: 101367c2f8c4 ("[IPV6]: Policy Routing Rules")
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> Signed-off-by: Lena Wang <lena.wang@mediatek.com>
> ---
> v5:
>   - rebase on the top of latest net/main branch.
> v4:
>   - add "Fixes:" tag.
>   - update subject as requested.
> v3:
>   - update patch description and name format in commit message.
> v2:
>   - modify flush function same way as ipv4 flush cache.
>   - use tabs to aligh with existing code.
> ---
> ---
>  net/ipv6/fib6_rules.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



