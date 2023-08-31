Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839DE78EFC7
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346408AbjHaOvA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjHaOvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:51:00 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B0D1B1;
        Thu, 31 Aug 2023 07:50:57 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qbj0S-0000qg-Ea; Thu, 31 Aug 2023 16:50:48 +0200
Date:   Thu, 31 Aug 2023 16:50:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Fernando Fernandez Mancera <ffmancera@riseup.net>,
        "open list:NETFILTER" <netfilter-devel@vger.kernel.org>,
        "open list:NETFILTER" <coreteam@netfilter.org>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, stable@kernel.org
Subject: Re: [PATCH nf v2] netfilter/osf: avoid OOB read
Message-ID: <20230831145048.GC15759@breakpoint.cc>
References: <20230831123931.60606-1-wander@redhat.com>
 <20230831133750.GB15759@breakpoint.cc>
 <CAAq0SU=nesniZCLBa7xoqJ853sk2_+LaBhenVSZeYoe=82Syow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAq0SU=nesniZCLBa7xoqJ853sk2_+LaBhenVSZeYoe=82Syow@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wander Lairson Costa <wander@redhat.com> wrote:
> On Thu, Aug 31, 2023 at 10:37 AM Florian Westphal <fw@strlen.de> wrote:
> >
> > Wander Lairson Costa <wander@redhat.com> wrote:
> > >
> > > diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
> > > index 8f1bfa6ccc2d..13fedf2aaa0f 100644
> > > --- a/net/netfilter/nfnetlink_osf.c
> > > +++ b/net/netfilter/nfnetlink_osf.c
> > > @@ -315,6 +315,9 @@ static int nfnl_osf_add_callback(struct sk_buff *skb,
> > >
> > >       f = nla_data(osf_attrs[OSF_ATTR_FINGER]);
> > >
> > > +     if (f->opt_num > ARRAY_SIZE(f->opt))
> > > +             return -EINVAL;
> > > +
> >
> > Hmm, this isn't enough; as far as I can see there is no validation
> > whatsoever.
> >
> 
> I didn't get it. It guarantees there is no OOB read of the opt array.

Sorry.  This is enough to validate opt_num.

But other members need validation too.

> > This should also check that all of:
> >
> >  char    genre[MAXGENRELEN];
> >  char    version[MAXGENRELEN];
> >  char    subtype[MAXGENRELEN];
> >
> > ... have a NUL byte. You could use strnlen() == ARRAY_SIZE() -> EINVAL
> > for those.
> >
> 
> I think the correct way would be memchr(genre/version/subtype, 0, MAXGENRELEN).

I don't really care how it looks like, just that its clear that
it is supposed to catch and reject non-null terminated c strings

:-)

> > Maybe there is more to be validated. I did not followup with all the
> >
> 
> I focused on the reported issue mainly because I am unfamiliar with
> the Netfilter layer. Let me take a deeper look.

I don't think there is anyone really familiar with OSF infra, it
was added quite a while back.
