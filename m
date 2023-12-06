Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8EE08075B6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442624AbjLFQtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378787AbjLFQtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:49:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ED9B2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:49:58 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF0DC433C8;
        Wed,  6 Dec 2023 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701881397;
        bh=rMAoUjOmr5QtbI6rn6eo4WOMrnTR1D6zBGzrt2Afy9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nxXEzb3uTcRmZMsipF5O+JnEPiOGWtYp0M/22/GFpAre2r31rmbRgosxfeQy7MBQX
         kq8PRy7iC0/1XmiUQDXu771Y4nV++RTEguPHotHNSz/zO8Sxmi8ZRt0oc0eGgydDKU
         6z4+YiNKQsrUHsKsGlGi5GrM0njU/F+OjNTDACkIJ4+7s+F+IMG1KvaQFi9ZSbRohG
         x/2v6f1Eypy+DwRBuqEQt18Z4FTSuZe4spozrr8nFoBOw+otVxNv0UhACO7mKs7tOe
         wyI2+KtO36rz1L/KZv6o1fr6TvEOCuHeLv9/jd26pDrwgG1ZDVWRLVRQGYE0pOaUnp
         vr1RQcbqs13XQ==
Date:   Wed, 6 Dec 2023 17:49:51 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with
 new TYPESAFE_BY_RCU file lifetime?]
Message-ID: <20231206-fixpunkt-annehmbar-d191785a09a3@brauner>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
 <ZW+Yv6TR+EMBp03f@orbyte.nwl.cc>
 <CAG48ez2G4q-50242WRE01iaKfAhd0D+XT9Ry0uS767ceHEzHXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2G4q-50242WRE01iaKfAhd0D+XT9Ry0uS767ceHEzHXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 05:28:44PM +0100, Jann Horn wrote:
> On Tue, Dec 5, 2023 at 10:40 PM Phil Sutter <phil@nwl.cc> wrote:
> > On Tue, Dec 05, 2023 at 06:08:29PM +0100, Jann Horn wrote:
> > > On Tue, Dec 5, 2023 at 5:40 PM Jann Horn <jannh@google.com> wrote:
> > > >
> > > > Hi!
> > > >
> > > > I think this code is racy, but testing that seems like a pain...
> > > >
> > > > owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> > > > NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> > > > non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> > > > accesses the ->f_cred of that file.
> > > >
> > > > I don't see anything that protects this against a concurrent
> > > > sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
> > >
> > > Ah, and all the other users of ->sk_socket in net/netfilter/ do it
> > > under the sk_callback_lock... so I guess the fix would be to add the
> > > same in owner_mt?
> >
> > Sounds reasonable, although I wonder how likely a socket is to
> > orphan while netfilter is processing a packet it just sent.
> >
> > How about the attached patch? Not sure what hash to put into a Fixes:
> > tag given this is a day 1 bug and ipt_owner/ip6t_owner predate git.
> 
> Looks mostly reasonable to me; though I guess it's a bit weird to have
> two separate bailout paths for checking whether sk->sk_socket is NULL,
> where the first check can race, and the second check uses different
> logic for determining the return value; I don't know whether that
> actually matters semantically. But I'm not sure how to make it look
> nicer either.
> I guess you could add a READ_ONCE() around the first read to signal
> that that's a potentially racy read, but I don't feel strongly about
> that.

It should be possible to split it into two static inlin helpers:

owner_mt_fast()
owner_mt_slow()

And then abstract the lockless and locked fetches into the two helpers.
