Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77F047A2860
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 22:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237332AbjIOUpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 16:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjIOUpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 16:45:23 -0400
Received: from out-211.mta1.migadu.com (out-211.mta1.migadu.com [IPv6:2001:41d0:203:375::d3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3041118D
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 13:45:18 -0700 (PDT)
Message-ID: <aaa5aa34-6437-5013-ea3f-95330614908a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694810716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zZu5o0cgVYXAFH7d9696U+gHAz/I7CL0OXnkm5dCDf8=;
        b=ArCTnuBFrZVZMvsfRzsFhqroZehMZUBRALdUc4bMzmQq2Q7492lBhGukC9uInB4RKhrBz2
        7ehHSbx2VaI3j8kX6772ZWNTwZtohLKarNF9PJFco5jmi3IkQtEVRK2Yu9CPOrOuyV6aBI
        qFnY9fBRoFi2xRIgc83tvyG7JBzFIk4=
Date:   Fri, 15 Sep 2023 21:45:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] net: sched: qfq: dont intepret cls results when asked to
 drop
Content-Language: en-US
To:     Ma Ke <make_ruc2021@163.com>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230915142355.3411527-1-make_ruc2021@163.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20230915142355.3411527-1-make_ruc2021@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/09/2023 15:23, Ma Ke wrote:
> If asked to drop a packet via TC_ACT_SHOT it is unsafe to
> assume that res.class contains a valid pointer.
> 
> Signed-off-by: Ma Ke <make_ruc2021@163.com>
> ---
>   net/sched/sch_qfq.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
> index 546c10adcacd..91c323eff012 100644
> --- a/net/sched/sch_qfq.c
> +++ b/net/sched/sch_qfq.c
> @@ -696,6 +696,8 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
>   	fl = rcu_dereference_bh(q->filter_list);
>   	result = tcf_classify(skb, NULL, fl, &res, false);
>   	if (result >= 0) {
> +		if (result == TC_ACT_SHOT)
> +			return NULL;

The same comment again - the check is meaningless.

>   #ifdef CONFIG_NET_CLS_ACT
>   		switch (result) {
>   		case TC_ACT_QUEUED:
> @@ -703,8 +705,6 @@ static struct qfq_class *qfq_classify(struct sk_buff *skb, struct Qdisc *sch,
>   		case TC_ACT_TRAP:
>   			*qerr = NET_XMIT_SUCCESS | __NET_XMIT_STOLEN;
>   			fallthrough;
> -		case TC_ACT_SHOT:
> -			return NULL;
>   		}
>   #endif
>   		cl = (struct qfq_class *)res.class;

