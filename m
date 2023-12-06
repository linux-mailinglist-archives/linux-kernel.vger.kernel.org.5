Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6258079A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379554AbjLFUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:42:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjLFUma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:42:30 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A17CA;
        Wed,  6 Dec 2023 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5X7bJGIMfmpn3bbdaGyZfOpNZRgMQhcfVmmJOst3z7M=; b=fJJ3Gea7zb7nFaK23Yzspw8VxF
        0kCgM38MKJ/yd3J1SX/jSt3A0Dh47YcF4C35ilwrwLCCX68r6ibmq5ixJtCS9cxFtXN9W2u8/IKnf
        C0lm7ANdk+o2exFsA/0liT88VpjpIQzlqD0Z5791AQq4jUIUIlN+tmzcRmexnpWvLvrdeP5h2pYUL
        L/VbJhciTG05DEkExeG+oDxoTxXCDnLtoQD1B1z7bHiXdD1zZjuX3s80Vd8Z+HD9qPFr7yZ4BRx9V
        frH+f0S8hB2iF7+A5HFOm3nnz2h/Mwmen/SFhJ1aQHB0/eH+9KtOVV43wsN6mBmsa7NRdIAhjg/ue
        c1rnIl7g==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1rAyiz-00042g-Sb; Wed, 06 Dec 2023 21:42:29 +0100
Date:   Wed, 6 Dec 2023 21:42:29 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Jann Horn <jannh@google.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
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
Message-ID: <ZXDctabBrEFMVxg2@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Jann Horn <jannh@google.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        coreteam@netfilter.org, Christian Brauner <brauner@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
        Network Development <netdev@vger.kernel.org>,
        kernel list <linux-kernel@vger.kernel.org>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
 <ZW+Yv6TR+EMBp03f@orbyte.nwl.cc>
 <CAG48ez2G4q-50242WRE01iaKfAhd0D+XT9Ry0uS767ceHEzHXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2G4q-50242WRE01iaKfAhd0D+XT9Ry0uS767ceHEzHXA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

I find the code pretty confusing since it combines three matches (socket
UID, socket GID and socket existence) via binary ops. The second bail
disregards socket existence bits, I assumed it was deliberate and thus
decided to leave the first part as-is.

> I guess you could add a READ_ONCE() around the first read to signal
> that that's a potentially racy read, but I don't feel strongly about
> that.

Is this just annotation or do you see a practical effect of using
READ_ONCE() there?

Either way, thanks for the review!

Phil
