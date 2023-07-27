Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3EE4765E49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjG0Vco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjG0Vcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:32:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF7E19BF;
        Thu, 27 Jul 2023 14:32:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14D9961F59;
        Thu, 27 Jul 2023 21:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22F6C433C7;
        Thu, 27 Jul 2023 21:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690493558;
        bh=LFiOuKaV4mYQNVWY6/YSUjVKfAWsifUjllsJxEWkg8U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C3h/UWMhwQ4HJv0OU0SmB484+Mafgk/jk4xS+WlpXnP+79zKugFJ0W00kXfqOMUb1
         V12jq8z7gzm+9/LDbIrDUUgD0o68nv+G//zyM5RiNm8OldUYjrw0vf+K/WRP8Xc9JA
         trmz3jisE21oeOqtLnSi2ABih/sVEOTC+P81D32c2u4+DX0q/9vJhnmC7ORaY/Inxn
         911c5GEXmYs12kMkBXi1f3ViZN9/45PPH0P+yrvqH+IB4Dr2P6xMuqfp3/JRoZKYAr
         lt9F+PKsw876bbfX5mygCil62jIQn8Vr9iX769LeyZVyChHBym8Bc58XQIi72H7UTS
         jsNI8ZItJ5trQ==
From:   SeongJae Park <sj@kernel.org>
To:     Rishabh Bhatnagar <risbhat@amazon.com>
Cc:     gregkh@linuxfoundation.org, lee@kernel.org, davem@davemloft.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        "Jamal Hadi Salim" <jhs@mojatatu.com>,
        SeongJae Park <sj@kernel.org>
Subject: Re: [PATCH 4.14] net/sched: cls_u32: Fix reference counter leak leading to overflow
Date:   Thu, 27 Jul 2023 21:32:36 +0000
Message-Id: <20230727213236.49413-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230727191554.21333-1-risbhat@amazon.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 19:15:54 +0000 Rishabh Bhatnagar <risbhat@amazon.com> wrote:

> From: Lee Jones <lee@kernel.org>
> 
> Upstream commit 04c55383fa5689357bcdd2c8036725a55ed632bc.
> 
> In the event of a failure in tcf_change_indev(), u32_set_parms() will
> immediately return without decrementing the recently incremented
> reference counter.  If this happens enough times, the counter will
> rollover and the reference freed, leading to a double free which can be
> used to do 'bad things'.
> 
> In order to prevent this, move the point of possible failure above the
> point where the reference counter is incremented.  Also save any
> meaningful return values to be applied to the return data at the
> appropriate point in time.
> 
> This issue was caught with KASAN.
> 
> Fixes: 705c7091262d ("net: sched: cls_u32: no need to call tcf_exts_change for newly allocated struct")
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Lee Jones <lee@kernel.org>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Rishabh Bhatnagar <risbhat@amazon.com>

Acked-by: SeongJae Park <sj@kernel.org>

> ---
>  net/sched/cls_u32.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
> index fdbdcba44917..a4e01220a53a 100644
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -774,11 +774,22 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
>  			 struct nlattr *est, bool ovr)
>  {
>  	int err;
> +#ifdef CONFIG_NET_CLS_IND
> +	int ifindex = -1;
> +#endif
>  
>  	err = tcf_exts_validate(net, tp, tb, est, &n->exts, ovr);
>  	if (err < 0)
>  		return err;
>  
> +#ifdef CONFIG_NET_CLS_IND
> +	if (tb[TCA_U32_INDEV]) {
> +		ifindex = tcf_change_indev(net, tb[TCA_U32_INDEV]);
> +		if (ifindex < 0)
> +			return -EINVAL;
> +	}
> +#endif
> +
>  	if (tb[TCA_U32_LINK]) {
>  		u32 handle = nla_get_u32(tb[TCA_U32_LINK]);
>  		struct tc_u_hnode *ht_down = NULL, *ht_old;
> @@ -806,14 +817,10 @@ static int u32_set_parms(struct net *net, struct tcf_proto *tp,
>  	}
>  
>  #ifdef CONFIG_NET_CLS_IND
> -	if (tb[TCA_U32_INDEV]) {
> -		int ret;
> -		ret = tcf_change_indev(net, tb[TCA_U32_INDEV]);
> -		if (ret < 0)
> -			return -EINVAL;
> -		n->ifindex = ret;
> -	}
> +	if (ifindex >= 0)
> +		n->ifindex = ifindex;
>  #endif
> +
>  	return 0;

Very trivial nit: Someone might think the above new line is better not to be
added?  I don't really care, though.

>  }
>  
> -- 
> 2.40.1
> 

Thanks,
SJ
