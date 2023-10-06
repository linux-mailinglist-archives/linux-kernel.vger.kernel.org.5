Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9667BB714
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbjJFL70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbjJFL7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:59:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EF7CE;
        Fri,  6 Oct 2023 04:59:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qojU8-0008RN-RX; Fri, 06 Oct 2023 13:59:12 +0200
Date:   Fri, 6 Oct 2023 13:59:12 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Ma Ke <make_ruc2021@163.com>, steffen.klassert@secunet.com,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: xfrm: fix return value check in ipcomp_compress
Message-ID: <20231006115912.GB29258@breakpoint.cc>
References: <20231006114106.3982925-1-make_ruc2021@163.com>
 <20231006114751.GA29258@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006114751.GA29258@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Ma Ke <make_ruc2021@163.com> wrote:
> > In ipcomp_compress, to avoid an unexpected result returned by
> > pskb_trim, we should check the return value of pskb_trim().
> > 
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  net/xfrm/xfrm_ipcomp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/xfrm/xfrm_ipcomp.c b/net/xfrm/xfrm_ipcomp.c
> > index 9c0fa0e1786a..5f2e6edadf48 100644
> > --- a/net/xfrm/xfrm_ipcomp.c
> > +++ b/net/xfrm/xfrm_ipcomp.c
> > @@ -144,7 +144,9 @@ static int ipcomp_compress(struct xfrm_state *x, struct sk_buff *skb)
> >  	memcpy(start + sizeof(struct ip_comp_hdr), scratch, dlen);
> >  	local_bh_enable();
> >  
> > -	pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
> > +	err = pskb_trim(skb, dlen + sizeof(struct ip_comp_hdr));
> > +	if (unlikely(err))
> > +		goto out;
> 
> This can't be right, this now calls local_bh_enable() twice.

Furthermore, looking at this:

1. skb went through skb_linearize_cow() before, so no paged data anymore

2. Right before there is a check to bail in case compression inflated
packet size.

IOW, this pskb_trim cannot fail, it boils down to __skb_trim().
