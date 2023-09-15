Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEE17A2842
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbjIOUiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236626AbjIOUhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:37:36 -0400
Received: from out-221.mta0.migadu.com (out-221.mta0.migadu.com [IPv6:2001:41d0:1004:224b::dd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2655F106
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:37:30 -0700 (PDT)
Message-ID: <fda205c8-9b68-3333-a790-6191a03e0b67@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694810246;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N9jUf0AezV9CUepWS4dSseHstKPiBlVXkzsuiSmuKZs=;
        b=cWsad2eNPDi2UIKGOD+rK2TaN1QvhdjuQcX8rGNgy8SnfvjEzileHeOHufHGj3aDmLH3MZ
        HTlyOocTWSj8YttEdbm9iyjRYNjHDlkY6KIxhOP3SPGMhhVN4H2QJ2jI4BBIXQ4my0x2I+
        l/4eRZcSrWx2fUkUpdRgaB8UEBOexiQ=
Date:   Fri, 15 Sep 2023 21:37:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: sched: drr: dont intepret cls results when asked to
 drop
To:     Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230915142056.3411330-1-make_ruc2021@163.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230915142056.3411330-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 15:20, Ma Ke wrote:
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   net/sched/sch_drr.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
> index 19901e77cd3b..a535dc3b0e05 100644
> --- a/net/sched/sch_drr.c
> +++ b/net/sched/sch_drr.c
> @@ -310,6 +310,8 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
>   	fl = rcu_dereference_bh(q->filter_list);
>   	result = tcf_classify(skb, NULL, fl, &res, false);
>   	if (result >= 0) {
> +		if (result == TC_ACT_SHOT)
> +			return NULL;

With CONFIG_NET_CLS_ACT undefined tcf_classify can only return
TC_ACT_UNSPEC and the if statement above is always false.

Do you have any real issue you are trying to fix?

>   #ifdef CONFIG_NET_CLS_ACT
>   		switch (result) {
>   		case TC_ACT_QUEUED:
> @@ -317,8 +319,6 @@ static struct drr_class *drr_classify(struct sk_buff *skb, struct Qdisc *sch,
>   		case TC_ACT_TRAP:
>   			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>   			fallthrough;
> -		case TC_ACT_SHOT:
> -			return NULL;
>   		}
>   #endif
>   		cl = (struct drr_class *)res.class;

