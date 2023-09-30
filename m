Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4A87B4011
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjI3LJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 07:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjI3LJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 07:09:13 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B670CA;
        Sat, 30 Sep 2023 04:09:10 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qmXqA-0003rY-Oh; Sat, 30 Sep 2023 13:08:54 +0200
Date:   Sat, 30 Sep 2023 13:08:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
Message-ID: <20230930110854.GA13787@breakpoint.cc>
References: <ZRcOXJ0pkuph6fko@debian.debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRcOXJ0pkuph6fko@debian.debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Zhai <yan@cloudflare.com> wrote:
> GSO packets can contain a trailing segment that is smaller than
> gso_size. When examining the dst MTU for such packet, if its gso_size
> is too large, then all segments would be fragmented. However, there is a
> good chance the trailing segment has smaller actual size than both
> gso_size as well as the MTU, which leads to an "atomic fragment".
> RFC-8021 explicitly recommend to deprecate such use case. An Existing
> report from APNIC also shows that atomic fragments can be dropped
> unexpectedly along the path [1].
> 
> Add an extra check in ip6_fragment to catch all possible generation of
> atomic fragments. Skip atomic header if it is called on a packet no
> larger than MTU.
> 
> Link: https://www.potaroo.net/presentations/2022-03-01-ipv6-frag.pdf [1]
> Fixes: b210de4f8c97 ("net: ipv6: Validate GSO SKB before finish IPv6 processing")
> Reported-by: David Wragg <dwragg@cloudflare.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
> ---
>  net/ipv6/ip6_output.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
> index 951ba8089b5b..42f5f68a6e24 100644
> --- a/net/ipv6/ip6_output.c
> +++ b/net/ipv6/ip6_output.c
> @@ -854,6 +854,13 @@ int ip6_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
>  	__be32 frag_id;
>  	u8 *prevhdr, nexthdr = 0;
>  
> +	/* RFC-8021 recommended atomic fragments to be deprecated. Double check
> +	 * the actual packet size before fragment it.
> +	 */
> +	mtu = ip6_skb_dst_mtu(skb);
> +	if (unlikely(skb->len <= mtu))
> +		return output(net, sk, skb);
> +

This helper is also called for skbs where IP6CB(skb)->frag_max_size
exceeds the MTU, so this check looks wrong to me.

Same remark for dst_allfrag() check in __ip6_finish_output(),
after this patch, it would be ignored.

I think you should consider to first refactor __ip6_finish_output to make
the existing checks more readable (e.g. handle gso vs. non-gso in separate
branches) and then add the check to last seg in
ip6_finish_output_gso_slowpath_drop().

Alternatively you might be able to pass more info down to
ip6_fragment and move decisions there.

In any case we should make same frag-or-no-frag decisions,
regardless of this being the orig skb or a segmented one,
