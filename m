Return-Path: <linux-kernel+bounces-111681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A86F886F89
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A38B1C22741
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B5953E33;
	Fri, 22 Mar 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILqw2lM2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9F53395;
	Fri, 22 Mar 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120241; cv=none; b=LFdOlsSCVvaYahwisX/IGg2H3oK5Lsbho5wiKDX49h4Z9IlEc/htX1k+Xn0fevrMnLF586BkBbIOdwdpHBI0HuOsQZR+01E0gmpqWwwB7fZqJzc8H5v6WSH4+L9mgWYV0RLeoqgcAMyOt8P8PxRQChpD6US0X+0YXZwmxYQY0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120241; c=relaxed/simple;
	bh=zuAJ4KqMjN/DpBCJhAzyfFMIpKPo4o0Xr2xSP1cuuW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZyVvYESSCEq+FugNc27ldzAYqaB2zbyHI+iMeyNZsvlQeomZbBT90KdEWtF5qsfaE2t1BudBRxo2++7lXbGQJuzqd0E7CASOYTV13qtgSB76jiInskeT1oM5Bim/SCjYvsz/8ZrGFs3SH1zH45hWyCk2UrfdKxeVwFqWTClfY78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILqw2lM2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB1FC433F1;
	Fri, 22 Mar 2024 15:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711120241;
	bh=zuAJ4KqMjN/DpBCJhAzyfFMIpKPo4o0Xr2xSP1cuuW4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ILqw2lM2KoUGCN9xfK9q4QR88Tja0wqBbaWYl749k/Ao4mPktKoyQte9b+wjHNeUd
	 IdY1rcrUc50AegJV3nVEnazLG5nd+DhirwSYwMxM9xHmFCOekg45kDMUUlZvm3Ewgt
	 djdjusIxPtY/EZP1Apuuaq753dHDe3eG/hDseOOwjxoRsU3huM7TAL2LPdeM+xpbrf
	 vpKsDQr4KzwnXQo/vNPPsgy9Wa0Dijbo+qx4OC3MppYHHRjEBCJDH+Vui96CXkRRlX
	 dxi6UcLO/9oUgNXABZtJgv2Whwa6VuQ5TqwWXdY5kKunNT502ocyWoPkX0nmE7rBV0
	 WZPVvjfqUDtYQ==
Message-ID: <4f1aed2e-d382-4147-912a-c915026f8f0c@kernel.org>
Date: Fri, 22 Mar 2024 09:10:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ipv4/route: avoid unused-but-set-variable warning
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Kunwu Chan <chentao@kylinos.cn>,
 Joel Granados <joel.granados@gmail.com>,
 Zhengchao Shao <shaozhengchao@huawei.com>,
 Wangyang Guo <wangyang.guo@intel.com>, Kyle Zeng <zengyhkyle@gmail.com>,
 Beniamino Galvani <b.galvani@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240322131817.905700-1-arnd@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240322131817.905700-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/22/24 7:18 AM, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The log_martians variable is only used in an #ifdef, causing a 'make W=1'
> warning with gcc:
> 
> net/ipv4/route.c: In function 'ip_rt_send_redirect':
> net/ipv4/route.c:880:13: error: variable 'log_martians' set but not used [-Werror=unused-but-set-variable]
> 
> Change the #ifdef to an equivalent IS_ENABLED() to let the compiler
> see where the variable is used.
> 
> Fixes: 30038fc61adf ("net: ip_rt_send_redirect() optimization")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/ipv4/route.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



