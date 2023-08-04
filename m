Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AB5770A2A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjHDU5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjHDU5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:57:18 -0400
X-Greylist: delayed 471 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Aug 2023 13:57:17 PDT
Received: from out-89.mta0.migadu.com (out-89.mta0.migadu.com [IPv6:2001:41d0:1004:224b::59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCC710CA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 13:57:17 -0700 (PDT)
Message-ID: <3e38a143-b683-6368-8e76-277394155bc6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1691182163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E1eN8tOuww36HZPXLIuSgwhpOWc+BiApnQsrkjpB8Ks=;
        b=g7gLkCsYN/MAuFNNC+BDN7awxDKUINupinpjfY3fTYaXuKEuxAQZ51HBbu0376liiHg6X0
        2RnwG2OGU0iRp80CxY7bu5SiyMKQmRa/3jx5heAtSWnN7nYPWQC69F6olNomt/z86uspBi
        AVvwcBeMYOESSVIERkVnQEDiJtrgFDQ=
Date:   Fri, 4 Aug 2023 21:49:19 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net/ipv4: return the real errno instead of -EINVAL
Content-Language: en-US
To:     yang.yang29@zte.com.cn, davem@davemloft.net
Cc:     dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <202308041648338823694@zte.com.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <202308041648338823694@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 09:48, yang.yang29@zte.com.cn wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> For now, no matter what error pointer ip_neigh_for_gw() returns,
> ip_finish_output2() always return -EINVAL, which may mislead the upper
> users.
> 
> For exemple, an application uses sendto to send an UDP packet, but when the
> neighbor table overflows, sendto() will get a value of -EINVAL, and it will
> cause users to waste a lot of time checking parameters for errors.
> 
> Return the real errno instead of -EINVAL.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> Cc: Si Hao <si.hao@zte.com.cn>
> Cc: Dai Shixin <dai.shixin@zte.com.cn>
> Cc: Jiang Xuexin <jiang.xuexin@zte.com.cn>
> ---
>   net/ipv4/ip_output.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 6ba1a0fafbaa..2d7cf083dff9 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -201,6 +201,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
>   	unsigned int hh_len = LL_RESERVED_SPACE(dev);
>   	struct neighbour *neigh;
>   	bool is_v6gw = false;
> +	int res;
> 
>   	if (rt->rt_type == RTN_MULTICAST) {
>   		IP_UPD_PO_STATS(net, IPSTATS_MIB_OUTMCAST, skb->len);
> @@ -214,8 +215,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
>   	}
> 
>   	if (lwtunnel_xmit_redirect(dst->lwtstate)) {
> -		int res = lwtunnel_xmit(skb);
> -
> +		res = lwtunnel_xmit(skb);
>   		if (res < 0 || res == LWTUNNEL_XMIT_DONE)
>   			return res;
>   	}
> @@ -223,8 +223,6 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
>   	rcu_read_lock();
>   	neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
>   	if (!IS_ERR(neigh)) {
> -		int res;
> -
>   		sock_confirm_neigh(skb, neigh);
>   		/* if crossing protocols, can not use the cached header */
>   		res = neigh_output(neigh, skb, is_v6gw);
> @@ -236,7 +234,8 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
>   	net_dbg_ratelimited("%s: No header cache and no neighbour!\n",
>   			    __func__);
>   	kfree_skb_reason(skb, SKB_DROP_REASON_NEIGH_CREATEFAIL);
> -	return -EINVAL;
> +	res = PTR_ERR(neigh);
> +	return res;

I believe this part could be written as

-	return -EINVAL;
+	return PTR_ERR(neigh);


and there is no need to change the code is other places. This will be
easier to track/backport.


>   }
> 
>   static int ip_finish_output_gso(struct net *net, struct sock *sk,

