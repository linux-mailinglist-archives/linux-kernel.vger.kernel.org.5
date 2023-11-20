Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E067F0FDB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:07:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjKTKHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:07:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjKTKHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:07:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29513114
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 02:07:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C23C433C8;
        Mon, 20 Nov 2023 10:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700474857;
        bh=TGfMgrwe2KSPbSi99VzqSOOv4ugU1e/nyk1zzOp92KM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEyPPQ394vbJXExhh6eX21kitVT0AmfJLg1XKcXda1q+nqME91xRGKsNFonThOvQR
         i4K2EQ2/aMLkdO6ny8mWPfC7nc1LyQ9acrGHvoEqew8OGRCOdPngtBZZv70NlK5jK5
         A7heIR2lmBpYneiuMaE/IhxRZks3gCjVkP5M78zUU+SEA+HuRF3Ey/XS3XGNeS6RU1
         a8HpfkoeO+Gb6SVUz7LArSjoVrCaHQctl6SMHmXpVDuVIGnMcFRali1cw0Z+h5uyEc
         aQnD4ZCaKE4tu33Kapp+xme/8zxxLMfC1WHZnQWXyUkW5nIx3sqDFj6UnOpPxnFAtb
         BpXvxcB2YG5eg==
Date:   Mon, 20 Nov 2023 10:07:32 +0000
From:   Simon Horman <horms@kernel.org>
To:     Pedro Tammela <pctammela@mojatatu.com>
Cc:     Kunwu Chan <chentao@kylinos.cn>, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        kunwu.chan@hotmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: Fix restricted __be16 degrades to integer
Message-ID: <20231120100732.GN186930@vergenet.net>
References: <20231117101815.1867175-1-chentao@kylinos.cn>
 <b9a9aaef-a306-4fcf-83df-28140d9311bf@mojatatu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9a9aaef-a306-4fcf-83df-28140d9311bf@mojatatu.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 09:06:11AM -0300, Pedro Tammela wrote:
> On 17/11/2023 07:18, Kunwu Chan wrote:
> > net/sched/cls_api.c:2010:25: warning: restricted __be16 degrades to integer
> > net/sched/cls_api.c:2695:50: warning: restricted __be16 degrades to integer
> > 
> > Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
> > ---
> >   net/sched/cls_api.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> > index f73f39f61f66..4c47490eb0c1 100644
> > --- a/net/sched/cls_api.c
> > +++ b/net/sched/cls_api.c
> > @@ -2007,7 +2007,7 @@ static int tcf_fill_node(struct net *net, struct sk_buff *skb,
> >   		tcm->tcm_ifindex = TCM_IFINDEX_MAGIC_BLOCK;
> >   		tcm->tcm_block_index = block->index;
> >   	}
> > -	tcm->tcm_info = TC_H_MAKE(tp->prio, tp->protocol);
> > +	tcm->tcm_info = TC_H_MAKE(tp->prio, be16_to_cpu(tp->protocol));
> >   	if (nla_put_string(skb, TCA_KIND, tp->ops->kind))
> >   		goto nla_put_failure;
> >   	if (nla_put_u32(skb, TCA_CHAIN, tp->chain->index))
> > @@ -2692,7 +2692,7 @@ static bool tcf_chain_dump(struct tcf_chain *chain, struct Qdisc *q, u32 parent,
> >   		    TC_H_MAJ(tcm->tcm_info) != tp->prio)
> >   			continue;
> >   		if (TC_H_MIN(tcm->tcm_info) &&
> > -		    TC_H_MIN(tcm->tcm_info) != tp->protocol)
> > +		    TC_H_MIN(tcm->tcm_info) != be16_to_cpu(tp->protocol))
> >   			continue;
> >   		if (*p_index > index_start)
> >   			memset(&cb->args[1], 0,
> 
> I don't believe there's something to fix here

Hi,

as there are two patches addressing similar problems let's discuss
an appropriate approach (or not) in one place. I'd like to suggest here:

Link: https://lore.kernel.org/netdev/20231120100417.GM186930@vergenet.net/
