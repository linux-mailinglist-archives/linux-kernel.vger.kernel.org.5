Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805928075BF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442630AbjLFQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379377AbjLFQu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:50:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3260D7F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:50:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA1C433C8;
        Wed,  6 Dec 2023 16:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701881431;
        bh=uOaUV/x5ijC7KJbVV3edKrjS8niRkEle6TaN8naPFz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hcd8ItYOoFEC/bFxRgyDSQg4eDgEi7NjBZZ1K/bZpZTpJ4dMCQ2Bavo/o4asTygME
         Lxfuz8yvWNOS5re1U2V/UJzmZWRccnkWGE8IjSaq+2/VdNt1LHJX2E9SQEisfDhIfs
         OtQuwh9qJk35wCLoovp6UQOpKs3aDg+AgBlHFoJTRCsnzH044NSgig0OOjQGe8Y+vG
         spsC7mWYl1gPMw3pRUkKTwAE+C8J4/oe7iDKYDrYpXIBTM7wUFWbPzLYj1N9iBK6UR
         J3kSMjADE2RKl1gufKnQATapZUN22fUEKf6jWHVOoRQb07o9twouWzUrV5mtQhE/Fd
         hgpQyfspEzoRQ==
Date:   Wed, 6 Dec 2023 17:50:25 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
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
Message-ID: <20231206-gutmenschen-freie-5da710dfa4ab@brauner>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
 <20231206-refinanzieren-werkhalle-22db5334f256@brauner>
 <CAG48ez07dJ_=KUzRONVhMmr2koW9PwiZ5KxMHfx8ERPA=j4cUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez07dJ_=KUzRONVhMmr2koW9PwiZ5KxMHfx8ERPA=j4cUw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 06, 2023 at 03:38:50PM +0100, Jann Horn wrote:
> On Wed, Dec 6, 2023 at 2:58 PM Christian Brauner <brauner@kernel.org> wrote:
> >
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
> > In your other mail you wrote:
> >
> > > I also think we have no guarantee here that the socket's ->file won't
> > > go away due to a concurrent __sock_release(), which could cause us to
> > > continue reading file credentials out of a file whose refcount has
> > > already dropped to zero?
> >
> > Is this an independent worry or can the concurrent __sock_release()
> > issue only happen due to a sock_orphan() having happened first? I think
> > that it requires a sock_orphan() having happend, presumably because the
> > socket gets marked SOCK_DEAD and can thus be released via
> > __sock_release() asynchronously?
> >
> > If so then taking sk_callback_lock() in owner_mt() should fix this.
> > (Otherwise we might need an additional get_active_file() on
> > sk->sk_socker->file in owner_mt() in addition to the other fix.)
> 
> My understanding is that it could only happen due to a sock_orphan()
> having happened first, and so just sk_callback_lock() should probably
> be a sufficient fix. (I'm not an expert on net subsystem locking rules
> though.)

Ok, so as I suspected. That's good.
