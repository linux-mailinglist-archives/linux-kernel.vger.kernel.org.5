Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED93180716E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378731AbjLFN6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378713AbjLFN6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:58:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634E9A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:58:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B72FC433C7;
        Wed,  6 Dec 2023 13:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701871122;
        bh=igbPsqBqoC6Yx2+ikp9QT1gV4CGkTMXJP7iKBjWdZ3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NuZBxUDRhHT/RUByFl8OswuDT+o0oA7/OX5J4+UiSHxe2O6k9gLNxFAZtfXxO0uiq
         R71x2H6o0RrTHC0eVqeJNL+K3VlpWwLf+zMNsf7i/JmNRHQNoFX9id6su73i+rqncg
         dOrrWdyjbFbeY2LB+cHc0SE6yWdnoE+X80I68lpt+R3HI7km/6fSMLn1B5Lk6legQa
         KVqqlpEk3X/wEyIG7ytGOPaaga7jCka2AWPIi3Ato9IfoM5t9OTFnrxbhg/x2xx/yc
         nYdgYtarnKjk4VxveyJNg5pFi7OgQXomKaf5r/dUe3R1i0KcQCpWYe8NPGLK4e//bU
         EA6jxYRGTg4+Q==
Date:   Wed, 6 Dec 2023 14:58:36 +0100
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
Message-ID: <20231206-refinanzieren-werkhalle-22db5334f256@brauner>
References: <CAG48ez0TfTAkaRWFCTb44x=TWP_sDZVx-5U2hvfQSFOhghNrCA@mail.gmail.com>
 <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez1hXk_cffp3dy-bYMcoyCCj-EySYR5SzYrNiRHGD=hOUg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 06:08:29PM +0100, Jann Horn wrote:
> On Tue, Dec 5, 2023 at 5:40 PM Jann Horn <jannh@google.com> wrote:
> >
> > Hi!
> >
> > I think this code is racy, but testing that seems like a pain...
> >
> > owner_mt() in xt_owner runs in context of a NF_INET_LOCAL_OUT or
> > NF_INET_POST_ROUTING hook. It first checks that sk->sk_socket is
> > non-NULL, then checks that sk->sk_socket->file is non-NULL, then
> > accesses the ->f_cred of that file.
> >
> > I don't see anything that protects this against a concurrent
> > sock_orphan(), which NULLs out the sk->sk_socket pointer, if we're in
> 
> Ah, and all the other users of ->sk_socket in net/netfilter/ do it
> under the sk_callback_lock... so I guess the fix would be to add the
> same in owner_mt?

In your other mail you wrote:

> I also think we have no guarantee here that the socket's ->file won't
> go away due to a concurrent __sock_release(), which could cause us to
> continue reading file credentials out of a file whose refcount has
> already dropped to zero?

Is this an independent worry or can the concurrent __sock_release()
issue only happen due to a sock_orphan() having happened first? I think
that it requires a sock_orphan() having happend, presumably because the
socket gets marked SOCK_DEAD and can thus be released via
__sock_release() asynchronously?

If so then taking sk_callback_lock() in owner_mt() should fix this.
(Otherwise we might need an additional get_active_file() on
sk->sk_socker->file in owner_mt() in addition to the other fix.)
