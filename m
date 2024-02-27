Return-Path: <linux-kernel+bounces-83471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816B18699DD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B801288240
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B514690E;
	Tue, 27 Feb 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQPZKf7o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9211468E3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 15:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709046397; cv=none; b=a6b1i3zN3t/lm+QFTMY48IDWz0543n5seq5rpj1u2I5GD69BSAP+05xDSorTHI4bhoY5F7HDdM/495bwfKwTNONOqgbGo2/k7f0OKW6Dv9bXcrVomVBFB3VLkXb6ZHDcDbGUSjNxPpOtVD4KdT9rOnFyRJxa3lJiiOlEBzyNIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709046397; c=relaxed/simple;
	bh=Dg60Guh5xxI2n2BEEUudJcXx9ZZbzM3OrI5eLHlaYD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HfcKyJ4geq4BdOnhv1f3kpEVCq5pGQXndC1c66FcLXWEtrv2rShX7Ru0uo7v/tvdt+c7R/MYPZss8ccY3Tow8cnI7bP9rZdtHjnP0Uv0X5z5unmO/BxX+ZCnba5enlk9g3qxLhtuCvF2YwosbZ4pYANh5G7uhpVmlOaVDkjCPQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQPZKf7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ADB6C433C7;
	Tue, 27 Feb 2024 15:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709046396;
	bh=Dg60Guh5xxI2n2BEEUudJcXx9ZZbzM3OrI5eLHlaYD4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mQPZKf7o95NPmtnoEHmArkHnuRYhdJFIV+T8FTIKZDbTeA3Mok+A4lfMFvYfm3+Sb
	 bBROEG1uMnZZe/PjJ9CspUT6iGMRSo+64mzKLJGxxASE8z8TKfajIlghsIieSK2gs7
	 SnlJmPTQk7Hs4PIJ3o006PP3bjp6xsv1rnbji76Gl179z7PSE+1BksUNXVO617MZxx
	 9u5HtS0x0s3lwnZyPOYQrzvvNjSAIWJCd1YrYrzex3RGhl97CIGxqHvNINw791E6Hm
	 YG6f9jQK1o29f2ov91vo+Yvo/27yqB5x3TYHS4Z379c8KwCGkaAaboypw8ZFJpaY+8
	 aOoJlelss7ctg==
Message-ID: <655ba4a1-4f73-4ef4-aff3-0b439e65a9c9@kernel.org>
Date: Tue, 27 Feb 2024 08:06:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Net:cache didn't flush when ipv6 rule changed
Content-Language: en-US
To: =?UTF-8?B?TGVuYSBXYW5nICjnjovlqJwp?= <Lena.Wang@mediatek.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?U2hpbWluZyBDaGVuZyAo5oiQ6K+X5piOKQ==?= <Shiming.Cheng@mediatek.com>
References: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <3efcbaf0872481d1a842eb9e18fa368b4b94d940.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/26/24 6:11 AM, Lena Wang (王娜) wrote:

> diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
> index 7523c4baef35..bec2cf4436e1 100644
> --- a/net/ipv6/fib6_rules.c
> +++ b/net/ipv6/fib6_rules.c
> @@ -449,6 +449,15 @@ static size_t fib6_rule_nlmsg_payload(struct
> fib_rule *rule)
>                + nla_total_size(16); /* src */
>  }
> 
> +static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
> +{
> +       struct net *net = ops->fro_net;
> +       if (!net)
> +               return;
> +       rt_genid_bump_ipv6(net);
> +       return;
> +}

This can be written as a 1-liner - the same way as the IPv4 flush cache:

static void fib6_rule_flush_cache(struct fib_rules_ops *ops)
{
	rt_genid_bump_ipv6(ops->fro_net);
}


> +
>  static const struct fib_rules_ops __net_initconst
> fib6_rules_ops_template = {
>         .family                 = AF_INET6,
>         .rule_size              = sizeof(struct fib6_rule),
> @@ -461,6 +470,7 @@ static const struct fib_rules_ops __net_initconst
> fib6_rules_ops_template = {
>         .compare                = fib6_rule_compare,
>         .fill                   = fib6_rule_fill,
>         .nlmsg_payload          = fib6_rule_nlmsg_payload,
> +       .flush_cache    = fib6_rule_flush_cache,

this should be tabs and the columns should align with existing code.



>         .nlgroup                = RTNLGRP_IPV6_RULE,
>         .owner                  = THIS_MODULE,
>         .fro_net                = &init_net,
> --
> 2.18.0


