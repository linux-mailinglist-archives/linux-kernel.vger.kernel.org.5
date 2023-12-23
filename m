Return-Path: <linux-kernel+bounces-10589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F0D81D693
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 22:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91A301F21F80
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 21:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2D171CC;
	Sat, 23 Dec 2023 21:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXsO3swr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F466171A7;
	Sat, 23 Dec 2023 21:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1896C433C7;
	Sat, 23 Dec 2023 21:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703365992;
	bh=eS/NNuZs+uOixwQlUIyReqblSnwjefK/9VvHHvHlqSg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MXsO3swrJ93l572Jy066m5YHVhMaZHJtrpERQsudltVi+PY0qP/mbxhFCHy31XP8A
	 RAPeblZ3kpeq2YECDLYZHXh8AvJe5aWl0cZGzpbftDubvJwJBhRLGBFJy3QIDJUIZb
	 /8nMPThkBRXuaMvR7cBYb5oc3+TMfHVLdsc2u/M8cJ6StX32JTx8Uq/QY+njQ0ULRk
	 vzYdLkA3nq33W1USIamUafyNeRhPlXmGD+tITdVkksvuPQnYmn4lP4zydgJqTjZsJG
	 E1JYTWZV2ynH0Oobz9tnVG8sS6YROLG6QzsG162xYFNCApoujlWNekRBH16Lmz3aMM
	 OImY4pFCB0KyQ==
Date: Sat, 23 Dec 2023 21:13:06 +0000
From: Simon Horman <horms@kernel.org>
To: Brad Cowie <brad@faucet.nz>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, fw@strlen.de,
	linux-kernel@vger.kernel.org, kadlec@netfilter.org,
	edumazet@google.com, netfilter-devel@vger.kernel.org,
	kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	pablo@netfilter.org, Xin Long <lucien.xin@gmail.com>,
	Aaron Conole <aconole@redhat.com>, coreteam@netfilter.org
Subject: Re: [PATCH net] netfilter: nf_nat: fix action not being set for all
 ct states
Message-ID: <20231223211306.GA215659@kernel.org>
References: <20231221224311.130319-1-brad@faucet.nz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221224311.130319-1-brad@faucet.nz>

+ Xin Long <lucien.xin@gmail.com>
  Aaron Conole <aconole@redhat.com>
  coreteam@netfilter.org

On Fri, Dec 22, 2023 at 11:43:11AM +1300, Brad Cowie wrote:
> This fixes openvswitch's handling of nat packets in the related state.
> 
> In nf_ct_nat_execute(), which is called from nf_ct_nat(), ICMP/ICMPv6
> packets in the IP_CT_RELATED or IP_CT_RELATED_REPLY state, which have
> not been dropped, will follow the goto, however the placement of the
> goto label means that updating the action bit field will be bypassed.
> 
> This causes ovs_nat_update_key() to not be called from ovs_ct_nat()
> which means the openvswitch match key for the ICMP/ICMPv6 packet is not
> updated and the pre-nat value will be retained for the key, which will
> result in the wrong openflow rule being matched for that packet.
> 
> Move the goto label above where the action bit field is being set so
> that it is updated in all cases where the packet is accepted.
> 
> Fixes: ebddb1404900 ("net: move the nat function to nf_nat_ovs for ovs and tc")
> Signed-off-by: Brad Cowie <brad@faucet.nz>

Thanks Brad,

I agree with your analysis and that the problem appears to
have been introduced by the cited commit.

I am curious to know what use case triggers this /
why it when unnoticed for a year.

But in any case, this fix looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/netfilter/nf_nat_ovs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_nat_ovs.c b/net/netfilter/nf_nat_ovs.c
> index 551abd2da614..0f9a559f6207 100644
> --- a/net/netfilter/nf_nat_ovs.c
> +++ b/net/netfilter/nf_nat_ovs.c
> @@ -75,9 +75,10 @@ static int nf_ct_nat_execute(struct sk_buff *skb, struct nf_conn *ct,
>  	}
>  
>  	err = nf_nat_packet(ct, ctinfo, hooknum, skb);
> +out:
>  	if (err == NF_ACCEPT)
>  		*action |= BIT(maniptype);
> -out:
> +
>  	return err;
>  }
>  
> -- 
> 2.34.1
> 
> _______________________________________________
> dev mailing list
> dev@openvswitch.org
> https://mail.openvswitch.org/mailman/listinfo/ovs-dev
> 

