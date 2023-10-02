Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FEA7B5946
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbjJBRL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 13:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjJBRL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 13:11:56 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE016AB;
        Mon,  2 Oct 2023 10:11:53 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qnMSQ-00039e-DV; Mon, 02 Oct 2023 19:11:46 +0200
Date:   Mon, 2 Oct 2023 19:11:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Yan Zhai <yan@cloudflare.com>
Cc:     Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Aya Levin <ayal@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH net] ipv6: avoid atomic fragment on GSO packets
Message-ID: <20231002171146.GB9274@breakpoint.cc>
References: <ZRcOXJ0pkuph6fko@debian.debian>
 <20230930110854.GA13787@breakpoint.cc>
 <CAO3-Pbp2onn+EUhKRrB5an_tyzLcaH+1FUqrThsxXqqpBAxshA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO3-Pbp2onn+EUhKRrB5an_tyzLcaH+1FUqrThsxXqqpBAxshA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yan Zhai <yan@cloudflare.com> wrote:
> On Sat, Sep 30, 2023 at 6:09 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > This helper is also called for skbs where IP6CB(skb)->frag_max_size
> > exceeds the MTU, so this check looks wrong to me.
> >
> > Same remark for dst_allfrag() check in __ip6_finish_output(),
> > after this patch, it would be ignored.
> >
> Thanks for covering my carelessness. I was just considering the GSO
> case so frag_max_size was overlooked. dst_allfrag is indeed a case
> based on the code logic. But just out of curiosity, do we still see
> any use of this feature? From commit messages it is set when PMTU
> values signals smaller than min IPv6 MTU. But such PMTU values are
> just dropped in __ip6_rt_update_pmtu now. Iproute2 code also does not
> provide this route feature anymore. So it might be actually a dead
> check?

I don't think iproute2 ever exposed it, I think we can axe
dst_allfrag().

> > I think you should consider to first refactor __ip6_finish_output to make
> > the existing checks more readable (e.g. handle gso vs. non-gso in separate
> > branches) and then add the check to last seg in
> > ip6_finish_output_gso_slowpath_drop().
> >
> Agree with refactoring to mirror what IPv4 code is doing. It might not
> hurt if we check every segments in this case, since it is already the
> slowpath and it will make code more compact.

No objections from my side.
