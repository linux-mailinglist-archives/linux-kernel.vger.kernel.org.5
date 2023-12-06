Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0E8807581
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbjLFQmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:42:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjLFQms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:42:48 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F0AD51;
        Wed,  6 Dec 2023 08:42:48 -0800 (PST)
Received: from [78.30.43.141] (port=54118 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1rAuyx-003xzA-MK; Wed, 06 Dec 2023 17:42:46 +0100
Date:   Wed, 6 Dec 2023 17:42:42 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>, Jann Horn <jannh@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Christian Brauner <brauner@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Is xt_owner's owner_mt() racy with sock_orphan()? [worse with
 new TYPESAFE_BY_RCU file lifetime?]
Message-ID: <ZXCkgoVQCn6bMoKT@calendula>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
 <ZW+Yv6TR+EMBp03f@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZW+Yv6TR+EMBp03f@orbyte.nwl.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 10:40:15PM +0100, Phil Sutter wrote:
> Hi,
> 
> On Tue, Dec 05, 2023 at 06:08:29PM +0100, Jann Horn wrote:
> > On Tue, Dec 5, 2023 at 5:40 PM Jann Horn <jannh@google.com> wrote:
> > >
> > > Hi!
> > >
> > > I think this code is racy, but testing that seems like a pain...
> > >
> > > owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> > > NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> > > non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> > > accesses the ->f_cred of that file.
> > >
> > > I don't see anything that protects this against a concurrent
> > > sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
> > 
> > Ah, and all the other users of ->sk_socket in net/netfilter/ do it
> > under the sk_callback_lock... so I guess the fix would be to add the
> > same in owner_mt?
> 
> Sounds reasonable, although I wonder how likely a socket is to
> orphan while netfilter is processing a packet it just sent.
> 
> How about the attached patch? Not sure what hash to put into a Fixes:
> tag given this is a day 1 bug and ipt_owner/ip6t_owner predate git.
> 
> Thanks, Phil

> From 3e28490e43b04d49e6e7f145a70fff7dd42c8cc5 Mon Sep 17 00:00:00 2001
> From: Phil Sutter <phil@nwl.cc>
> Date: Tue, 5 Dec 2023 21:58:12 +0100
> Subject: [nf PATCH] netfilter: xt_owner: Fix for unsafe access of sk->sk_socket
> 
> A concurrently running sock_orphan() may NULL the sk_socket pointer in
> between check and deref. Follow other users (like nft_meta.c for
> instance) and acquire sk_callback_lock before dereferencing sk_socket.

For the record, I have placed this patch in nf.git

Thanks.
