Return-Path: <linux-kernel+bounces-7280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12E281A4CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD28328C575
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667564AF6C;
	Wed, 20 Dec 2023 16:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="clU9cgF3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B51482F2;
	Wed, 20 Dec 2023 16:17:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F732C433C9;
	Wed, 20 Dec 2023 16:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703089069;
	bh=yiNywPcfnyASYER4gw7HzvtQFMt8fPzWYtnEf1VIzBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=clU9cgF3ePrzVBDXkDLJ/Y2RvTmfJCYP5TiFw2k1l3+M/W+i5CRlaH67NhiSJK3Qn
	 +oJa+vcpEIFqdcJ8HTb0RuDkib0CTGy5OC/yhL1p1UrVcnmSHnuAjzckBw9SRBwzTM
	 TM7E2OS8hpzRZQRVKZhd57uRr8EuibcDSwmhBj/rwplZoqII7Haqi3KTwd6AEVB9hc
	 +hNpKBEHvkLlwsZeeN8x68YH4LWAnk7UDcgJU2e/xjLjOTrT4PVhlx3AB+9jmK34QO
	 /RR4VI/XsdxOoZysBYT156ljTHU0imSZef/Lqcgwf2yy6N0MOJXDHPm29wIzPBdhbk
	 3piLOpPFztFnQ==
Date: Wed, 20 Dec 2023 17:17:42 +0100
From: Simon Horman <horms@kernel.org>
To: Lin Ma <linma@zju.edu.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horatiu.vultur@microchip.com, henrik.bjoernlund@microchip.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] bridge: cfm: fix enum typo in br_cc_ccm_tx_parse
Message-ID: <20231220161742.GM882741@kernel.org>
References: <20231220075914.2426376-1-linma@zju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220075914.2426376-1-linma@zju.edu.cn>

On Wed, Dec 20, 2023 at 03:59:14PM +0800, Lin Ma wrote:
> It appears that there is a typo in the code where the nlattr array is
> being parsed with policy br_cfm_cc_ccm_tx_policy, but the instance is
> being accessed via IFLA_BRIDGE_CFM_CC_RDI_INSTANCE, which is associated
> with the policy br_cfm_cc_rdi_policy.
> 
> Though it seems like a harmless typo since these two enum owns the exact
> same value (1 here), it is quite misleading hence fix it by using the
> correct enum IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE here.
> 
> Fixes: 2be665c3940d ("bridge: cfm: Netlink SET configuration Interface.")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>

Thanks Lin Ma,

I agree with your analysis, that the problem was introduced in the
cited commit, and that it is resolved by your patch.

However, as there is no user-visible bug I don't believe this reaches
the bar for a 'fix' for Networking code. Accordingly, I think that
the Fixes tag should be dropped. And, instead cited commit can be mentioned
using something like "This problem was introduced by commit ...".

Also, as I don't think it is a fix I think it should be targeted at the
net-next tree:

	Subject: [PATCH net-next vX] ...

The above nits notwithstanding,

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/bridge/br_cfm_netlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bridge/br_cfm_netlink.c b/net/bridge/br_cfm_netlink.c
> index 5c4c369f8536..2faab44652e7 100644
> --- a/net/bridge/br_cfm_netlink.c
> +++ b/net/bridge/br_cfm_netlink.c
> @@ -362,7 +362,7 @@ static int br_cc_ccm_tx_parse(struct net_bridge *br, struct nlattr *attr,
>  
>  	memset(&tx_info, 0, sizeof(tx_info));
>  
> -	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_RDI_INSTANCE]);
> +	instance = nla_get_u32(tb[IFLA_BRIDGE_CFM_CC_CCM_TX_INSTANCE]);
>  	nla_memcpy(&tx_info.dmac.addr,
>  		   tb[IFLA_BRIDGE_CFM_CC_CCM_TX_DMAC],
>  		   sizeof(tx_info.dmac.addr));
> -- 
> 2.17.1
> 
> 

