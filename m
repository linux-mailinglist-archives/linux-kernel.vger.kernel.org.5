Return-Path: <linux-kernel+bounces-105231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A155D87DAD1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A8282091
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 16:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393401BF27;
	Sat, 16 Mar 2024 16:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwrqswgV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC581BDD0;
	Sat, 16 Mar 2024 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710606570; cv=none; b=gPO1wamtqrbPgBiC9G4B2ik4QRRtnHr0LffKsxTt7qmBj06jwVn+CELqotBsHiApRKK03PK5uRqF7Aui3uiu7ARPeEa3uk6eELPqOQu63t6PYNmm4Jd2358Y+B226RQsWBJojC39r/Az7/5LTU1SCGfCt02ZRI+GNmyxlQY6FLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710606570; c=relaxed/simple;
	bh=5qE8kYJREZWCNMC1klayr2kNVh5Rg7+5qdAS3gKxcg4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IcLCE8I9nKL4YL86Cfj+fgniCB22IgwPBk6/ca0aYm+ctVklkLvBzRzpvtC6LCjs3O/Q4vVM8fZRKbOK7KGATgPlWJT5/pD5OCrJ8gwdiUjbMVXdRINJ2aX5BUPswq26BeHL15VawEyFptW5paMQNNGEtkyajdLYrOXBQT/D6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwrqswgV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF03CC433F1;
	Sat, 16 Mar 2024 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710606569;
	bh=5qE8kYJREZWCNMC1klayr2kNVh5Rg7+5qdAS3gKxcg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwrqswgVxGCPKB7gHtMKSFzUTipBn3n9+ODM2kZBJaCwPT9ZnEJMlSg6Z9RPPknIT
	 jYRQBPiG+vRDIBz6MNr9CSY/4XJgP2aY4t0ZktSOaH9mAuvKeWrlAFii3zuz77nlxa
	 FClu1D6NisoqLnoO00n1Ciz1zR10tujQO6hyNWRhVtXH7dAQ9GK6hlFBUmFwkO0SGz
	 YIzQMoCu+1kRPpGUpfNNvUiEZKwKa724Jj8S6TUHJSA36255oTyItSawoO0UunWeQO
	 PKUDgpLII9GMXU1RkdnP/N06Md1oOezUWhdhWTZQHgLMAosEWgvQ0iXl++LPz+/onn
	 oqfQo09C9exeg==
Message-ID: <893d73c3-e449-49ad-b297-1acef5dae38e@kernel.org>
Date: Sat, 16 Mar 2024 10:29:27 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Ido Schimmel <idosch@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Petr Machata <petrm@nvidia.com>,
 Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <b2578acd-9838-45b6-a50d-96a86171b20e@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/16/24 3:46 AM, Dan Carpenter wrote:
> The nh_grp_hw_stats_update() function doesn't always set "hw_stats_used"
> so it could be used without being initialized.  Set it to false.
> 
> Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/ipv4/nexthop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 74928a9d1aa4..c25bfdf4e25f 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -824,8 +824,8 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
>  				  u32 op_flags)
>  {
>  	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
> +	bool hw_stats_used = false;
>  	struct nlattr *nest;
> -	bool hw_stats_used;
>  	int err;
>  	int i;
>  

Reviewed-by: David Ahern <dsahern@kernel.org>

The flag could be moved under
	`if (op_flags & NHA_OP_FLAG_DUMP_HW_STATS ...`
as well.

