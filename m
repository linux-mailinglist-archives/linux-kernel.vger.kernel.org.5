Return-Path: <linux-kernel+bounces-16185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D12D823A54
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902031C24B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1978187A;
	Thu,  4 Jan 2024 01:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oohtoBmc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2F91849;
	Thu,  4 Jan 2024 01:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E99EC433C7;
	Thu,  4 Jan 2024 01:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704332840;
	bh=kQ9z3YizwfzmqcFN76TVfrBEZr7D/AzQOLXak1t8Y0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oohtoBmc4FNRxf8gicjq0J2lgUihr9zu3Nd4nQilcFpjFIUCdaX4fo4A7HI57zdir
	 +cNAyJBuDW13TcW66roEWJ2xmCzWeXDYm7WaXMbmz1nlu7N4yHvDQQDlRBOW0Vejal
	 lM3OseYO9O3NT6rpLzDoE4JbUPHIXavm7g53NiV9GsNCNG0p2l5YKGDqPcGtOD0Icu
	 13LGimTP/eqzg81Uwjho3PrmkwhPr1bynIrBmt6W036w1QDvebHRwjG3KMQzrG7/LX
	 MmWD7h2gRn9gBxshwBwg/lie3DJwrsEL5ZZoPxGs62e/9y0pKGkkRyambFDcMy9YKs
	 wEofqy+SmRBIQ==
Date: Wed, 3 Jan 2024 17:47:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1] net: mctp: use deprecated parser in
 mctp_set_link_af
Message-ID: <20240103174719.2b2c1565@kernel.org>
In-Reply-To: <20231228070258.3052422-1-linma@zju.edu.cn>
References: <20231228070258.3052422-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 15:02:58 +0800 Lin Ma wrote:
> In mctp set_link_af implementation `mctp_set_link_af`, it uses strict
> parser nla_parse_nested to parse the nested attribute. This is fine in
> most cases but not here, as the rtnetlink uses *bad magic* in setlink
> code, see code snippet in function `do_setlink`.
> 
>   nla_for_each_nested(af, tb[IFLA_AF_SPEC], rem) {
>     const struct rtnl_af_ops *af_ops;
>     BUG_ON(!(af_ops = rtnl_af_lookup(nla_type(af)))); <= (1)
>     err = af_ops->set_link_af(dev, af, extack);       <= (2)
> 
> That is, in line (1), the attribute type of af will used to look up the
> af_ops, and for MCTP case will use AF_MCTP here to get mctp_af_ops.
> Therefore, the attribute with type AF_MCTP will never survive in the
> check within the nla_parse_nested.
> 
>   if (!(nla->nla_type & NLA_F_NESTED)) {  <= nla_type is AF_MCTP
>     NL_SET_ERR_MSG_ATTR(extack, nla, "NLA_F_NESTED is missing");
>     return -EINVAL;  <= always invalid
>   }
> 
> For other set_link_af users IPV4 and IPV6 both make a trick here by
> using nla_parse_nested_deprecated, which will check the NLA_F_NESTED
> then able to use this type field as family value. This patch simply port
> the MCTP code also to deprecated parser to make it work.

Did you test this? It's a suspiciously detailed and yet seemingly
incorrect explanation..
-- 
pv-bot: s
pw-bot: cr

